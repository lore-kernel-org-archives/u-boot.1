Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4D8C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37EF380E2F;
	Thu, 27 Aug 2026 13:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 50g5XPAdmeVj; Thu, 27 Aug 2026 13:30:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787837412;
	bh=VUHQQLk4ghFkpw3dpaBPQqYtXrOfIwQGYRzFXEawE54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fW2DfHkgZxHnh+dE877hzBQ26CPVPe0UP0idhW2WkBICIV3Y9mIvG6HlejzlpgTK+
	 +0QRfDu9U6Veyx0fTvMR6qoJxzEGJFG9O133YdE58kLXMwO8kB8+TeJeJaz2QwrlS3
	 Ctz+sQ/8Mm12d+hWYURlcHWGv1NTgIa7MB69gg2ktc9AUcAdVrMWos/QJhcPEul/oY
	 1bO5KZ/UgfmvxVw8vDi9j7VRqc1Oz9UM+mhFqRIwX34lSzoQoBnsYrLlZfjC85wTIQ
	 GcL4G9ylQlZEcpdMpBb88LJswysbbRNvCqu3rUYHlwdCO71VJv9eqkqYbGm+OPh8QO
	 YclhyJ2o3CpzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7049D80AFA;
	Thu, 27 Aug 2026 13:30:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B0CE3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 28C7A80AFA
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAYDiR2PBxgC for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:30:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fFPoW0cz
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F7A780A58
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:30:08 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-836ce5d6e85so35913267b3.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787837408; cv=none;
 d=google.com; s=arc-20260327;
 b=aTyQzx1OO0b3lubx0xjV/CBpOknIafamhZGTDX5GmrMiLak+cStUMxfYr8r0OyD7zm
 ekNfsp4YQR7jAV5vv03l2H70rpNFwDvOKgf+1dSccxqTf2p7vUSf6yGWIyTgIL7rVyrJ
 cbegYY8vCAl8Jyogfrn6TW8EhwoztWzSq5oK/suF/H56UeKwjY4xOimowjMEhgCdk+mH
 6MV5c4iuIyvs/Pg0SfHuwsBfXtSffltJAmqlEi1Vuo4K5iWQhBqre6xaWvNORf21lR8S
 Fo7FbisJqA2+pEb0rswbpEz+8aT4Fzrz+SoLT0vcnPhJoWPEVj6cEZ2Vnhg42i4q5ofR
 bc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VUHQQLk4ghFkpw3dpaBPQqYtXrOfIwQGYRzFXEawE54=;
 fh=25FSSupmzb/PhQIDKwo7rcmDEY9JAPLHykP2xcS3heE=;
 b=QcbEFUcAbi/b5ZMfPMIIBMXJDuH8X2YJirrMUwNR0pMhb/4i8TkpSpAyIIAlPMKaID
 xFjIyskFId4sQA8B/Ks0V34dpjNDseQVrAocxlSYeB3IIdqFo0zXyxjtHoLSpxWU5naI
 0+DDrrgjcGGGEN2/vG2CN7Pp4ILPkOA7W5kEkCwRXNbA2USVfws/j8dN2SpjYwPtuY9j
 fnGy9OV3AbJF9x2fp3bAWXslA5ufyI0gNIedkJvvEjqEnyTxRUoXz7B97POi8bUBNY8/
 DHiN3C4EzJNkeJqFr5sLoeQDw6gtDwt19vM+L/ggygjAwSIQty977W85Ce5g+Dud+e2X
 v3Qw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787837408; x=1788442208;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VUHQQLk4ghFkpw3dpaBPQqYtXrOfIwQGYRzFXEawE54=;
 b=fFPoW0czbSnNiLcAoz+Jk8kxxdVShp7SAL/Ir0r4YlnTIY8Obann6q+//JZQzADIJj
 dmga5Mi0eKzKj7oGrJCGBIePv/Wst4eC2qsVulNtwjxIQbM21MwBLt40TeGNciD0JvRn
 LS86nOIHr3dW+cRDqHImklFaTORDsoPLaTLWNHlZhDTAxsj4/gJ/YbJrW9dh33noyN/V
 WtA13sOJykS66xczZVwgojZXxtjV7UGdnVEhbWOTK3A7NmuC1E4ZjwvjQWxsE4g9MqWx
 Z+7q5+uala1KUZR2rD1q9B3igC0GG8JDi+RfgZA1jA4uRgi91DPtKe9awp7+KYyVtBPl
 5k/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837408; x=1788442208;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VUHQQLk4ghFkpw3dpaBPQqYtXrOfIwQGYRzFXEawE54=;
 b=N0Pc1QQIrNKRbV/vF+gpVWRK9b6zJPH1lxMK+9I2dO8SE5lnP2J3F52T72lyH0HWMN
 v0jnIGKB/TvzluvWrFRnfAZJqCGomNYCF49TSw5ycWFiO+YzAt28bifoQ/rA7/dXFqR5
 TvZcCoEt4J23L5wxzjAr5X1ksP2TmOq++ykulpNjqpe7ypbJ8uEWKPQbXFG6lXD1mXaq
 R84CMzT5tgluMViMrSB4UbmmnjCKOE86uMulLIz9BNJejeEJCNh9SaDki/B/OzQKLEne
 7v9SbIyIKP/zWDGGg8Plu6YmWUUn/3fB53X1J8vtfKhBDHNqt/P0RefLJjnUEw22U9aG
 jP4A==
X-Gm-Message-State: AFuF++kYX1UD9qA5nRLC8KqakUmGgT1NYoe6wLIhdf7APsEmRKzXw5rm
 f9ioIlNUmkI/C3TgTidR9KI6HUrW/wd0ETVUxZpp2nD2yIKHnGy1oyTUswXuiP0eoUOZ6+raMu+
 Yt0GrXA5BS9Ecz40b6z1et28Kok61i+C5peUVvhhjWQ==
X-Gm-Gg: AR+sD10rKcUnFOtjS7ubvMDP8ad4LgK7bNN7TYhX9xJ29G6prDe36CozB4t5YCbE+a4
 ZREYAWqxVZ8PVzkHfpEjntHpVsEUCviM0lEpXV0ctbnBWttDwHtDsCSZydS7rCYp7LqK1qQufpC
 lUVZF/ZRR38vurQxYwOiXgK20xycuEl91o/PI9T9SX8I8v7p2XLUYkH3wibsM/SNqCCc+2W1PZJ
 RpAdwoZmohH9lObmQupGL9NhPjlwNncxyyz5JiCP8b3k37fOC7oCV/enGlQsHA7TXZotafP0nqB
 Q3FlqsKAFNZLlHkWS0KAeUXtiYu1AM4l97r1c1+Yec4xm7ArmPTDvMG13Y+ro4Mfcw3fYoSBtg+
 xRsIRg0Q2FWrOQoXURjZQI6WOzbIT7/ir9wY7lskfsLh/NMlSERc8UBZOMN0Y8TvAmU6PfZG5SD
 UCXVfsnXa4geAe0UGaQajAN9A8OkoOGdW9ExrO/CklqysBK7Qt/5xlNB88i01beWv4UQjCXBVLr
 AIxsnG20/qUJ2/LQJD5grmnfCdTmTaEQRIcFNmG1DLnIKZfH2EKleDT+v8wtm6vQvvXIMgeWfNr
 X+G/1i7nBRmrdFQJsGboBRceu2xZBTku9Xff18XG+SIbX15Lwh7W7+RbbWd2/Kxl9u+02oiZA7Z
 U/g3eLJF2hAg90IK0BwEdfHTXYawKhpwBUgJrwjtaNJ8=
X-Received: by 2002:a05:690c:6082:b0:84a:ffa1:8118 with SMTP id
 00721157ae682-85741054cfbmr74622017b3.31.1787837406319; Thu, 27 Aug 2026
 06:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
 <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
In-Reply-To: <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 27 Aug 2026 16:29:29 +0300
X-Gm-Features: AcwNN1U8a4fJ04-kvsUQAJkMWRt7oz5mEzID6ijPOD04UBTllCeb83rqeLz1qFQ
Message-ID: <CAC_iWj+WXkNAZPyRup4w09jSyr6TbkjLgZRyDxKzCQdFaK8-4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
To: Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com, 
 padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Borislav Petkov <bp@suse.de>, Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Suraj

On Thu, 27 Aug 2026 at 15:11, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
>
> RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
> reached EOM/EOL on June 30, 2024. While you may get extended support,
> it is a good time to raise the minimum GNU Make version.
>
> The new requirement, GNU Make 4.0, was released in October, 2013.
>
> Raise the enforced minimum GNU Make version to 4.0 and drop the
> now-unreachable compatibility code for older versions:
>
> - Add an explicit "GNU Make >= 4.0 is required" version-check gate.
> - Simplify the "make -s" (silent mode) detection to a single
>   unconditional check instead of branching on make-4 vs make-3.8x.
> - Drop the GNU Make 3.x sub-make workaround, which is now dead code.

Overall I agree on bumnping the minimum requirements to 4.0. In fact,
I think I did that when I did the Makefile bump to 5.x. However, the
macOS tools stopped compiling. We need to check the CI for that before
merging this.

>
> Fixes: ffe29ebc0701 ("kbuild: sync top Makefile with Linux 3.18-rc1")
> Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>

Why do we need fixes tags?

Cheers
/Ilias

> ---
>  Makefile | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 436f384f22a..889ac7bade5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -12,6 +12,10 @@ NAME =
>  # Comments in this file are targeted only to the developer, do not
>  # expect to learn how to build the kernel reading this file.
>
> +ifeq ($(filter output-sync,$(.FEATURES)),)
> +$(error GNU Make >= 4.0 is required. Your Make version is $(MAKE_VERSION))
> +endif
> +
>  $(if $(filter __%, $(MAKECMDGOALS)), \
>         $(error targets prefixed with '__' are only for internal use))
>
> @@ -93,15 +97,9 @@ endif
>
>  # If the user is running make -s (silent mode), suppress echoing of
>  # commands
> -ifneq ($(filter 4.%,$(MAKE_VERSION)),) # make-4
> -ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
> -  quiet=silent_
> -endif
> -else                                   # make-3.8x
> -ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
> +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
>    quiet=silent_
>  endif
> -endif
>
>  export quiet Q KBUILD_VERBOSE
>
> @@ -166,14 +164,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
>  MAKEFLAGS += --include-dir=$(abs_srctree)
>  endif
>
> -ifneq ($(filter 3.%,$(MAKE_VERSION)),)
> -# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
> -# We need to invoke sub-make to avoid implicit rules in the top Makefile.
> -need-sub-make := 1
> -# Cancel implicit rules for this Makefile.
> -$(this-makefile): ;
> -endif
> -
>  export abs_srctree abs_objtree
>  export sub_make_done := 1
>
> --
> 2.43.7
>
