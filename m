Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A508CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCE2460B65;
	Thu,  1 Oct 2026 01:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfUrvdfvTai4; Thu,  1 Oct 2026 01:21:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F2D8E60B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817708;
	b=GhrFaG3PBcoc4VzPlf9GF+GP4kAd/IpjK3RyErTLyBkjznanid8vYgHXZ2SUUwyaT0kO
	 T3ugalJzdomztJtsnyK1pI3QNfrvkpy1ZL2vre748XPY4fVpJxTZN3UGi8JMX+GIX9mXg
	 gi3lrfz3A/tGmWzhbh266HSdxzdAHLllT9t7EE+7hNlXQxfsDPhAm5XoVs2Yb88BcycaP
	 coAFvuMm2cWPYXbntn2Fn8RMlnxAmfGV+VJl9iA47mA0fLzBzCvjjdv6t/URpUxCFjCGe
	 rlTLtKrXxx1x9b53hekY2jsikOM3KXwkPbN9irK8o5tt2+wcCb9tshz+oIXzj+XzUaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
	b=boPNfVHNNQ9s53fWZLvfSMds5OeFkv/E5c3Uaecabt8wkOcFF3r+T82deqaLrNC72WaN
	 CHvYOCCBrf/kcEAstau8pjva170m1TjSZr8MOdV2PFaQFEnO61BXxkSn972SjJ/W9PLt6
	 nTs9eYj1fYIUiqYDhEXwuSkstwQlgFSaGZpHPTC9qEyJw3ET8YfbKW7KRDSW82+wMddzF
	 Yi3OI+C4s/jBxJOKIcrqM2u3Ber6N0RuNWaH/HtTkbvkLOxX3ETBpvcD/GcX04MAn4ymE
	 maOoMT7WAh1QPzpfus1JS5xtUEDXbTB6OKF9qaYiregRpfQZUWDRyDeR+I4IM4kHkeg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817708;
	bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9WgHzvx8FkQrQTQ2CqDt+JBC5nDZDFrayviKKZvtq8Lzz5YY1y3sC+pMC+zJzKEd
	 AmdgsQPqrcnQE0lV0GFxVR3sg/QoHUSaJQ33xOYnxZtqbw6zB6t0h+5wLSWaGAaWw4
	 S/R9CaLEs364b5OS0hBEZdyT//FqoW46hBpXOF665gBpU90qYSt8xVr64pQ2aWG0Gx
	 9YghMcqHcSoVkKhlQW9aqJVf7UQkiQ+MiFdpy1fMAJnKN8xjYGVFh5YbDPV2ESUTVc
	 SKp3hnHsB2aYchex0rRyTMJVg6ctVmTCrCqLyN4EpLYo/yE0Jv+1xfjZWdpvCXGW9N
	 vcrz9Akp8VXAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2D8E60B74;
	Thu,  1 Oct 2026 01:21:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 469A91A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CBB34025F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D1gi39SE9aC1 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:21:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7E854400D0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::12"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817705;
 b=Ea6JW8Y8Vcxw4Cm0Gq/mmGUu8gwkF73UYtS5cx2TsYJakMH2BvQQhmjXvJkydg67FkAb
 CtWp4Ql3nJwtVJJ8/9/+Ea+HofWTV3oe6lbS0c+U2wC8mt+trzi+P923XRssj+O4ylgwc
 w8qdHwXTNMD4KMqvp7J6xaRK/i0v0Me32DV6PO3jFfqZehi71e+Mko/eHaOmuwLjx5TxZ
 JJqZRE7K56xpDYJ9AhArH70Y5sjNMvgX5grLGa/ZLAa7TdIbQ/xbaZsSJSxHYE7p9ROjn
 IAZ5pD1NsUdRT+X2p8kWQL39fmJ2qoPFONzyWq74hWchS2siODtAXi4yxdqwsfSOpkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
 b=p6m43dr3xz673s6RIPjQarYfXB1BmFxeIMczANZQdzDGzkhfJl4JQ6vFmJ00zKiobBO1
 y9as0SsTmAciD0XwCb3FbecqpX6SH4MziUIPRUqNntOiLFcM8jDAcHX1CahwXV8JJFBll
 aB1cj54doke0VGIyQC3p9JuODTA+vKGcNZCk+6fTURmH2MpG0xysI5aRUoj1oL2g2evzD
 0fgi4nDq+FidmFKwv+gzEYKYIpMXpSLS2JJYuIpwiZb4IJ7QrvW3DPaYIgtWNXfPV+94H
 XCWuIWJav7V8fY7x1YZiQDE/j9hLGSQamrwkc7TWYy2nArTQw9ugMGdkNd4BlS49I4g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lf+fEIf2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::12"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::12; helo=mail-pj2-x12.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lf+fEIf2
Received: from mail-pj2-x12.google.com (mail-pj2-x12.google.com
 [IPv6:2607:f8b0:4864:39::12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E854400D0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:45 +0000 (UTC)
Received: by mail-pj2-x12.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so29015545ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817704; cv=none;
 d=google.com; s=arc-20260327;
 b=NSHDupN9Aa3rkPehPo7aBnz8Ia4TtIWzGG5fjRstyNPd9pdLqXzsYt01QiYfTJm0PL
 4HkQWzYJaJi4FSOLDuwmIZv0JT8O41z1n6NE0vn2LoEhbamC9GMRO8M1Mh3V/xgPrqsF
 IOkjY4AGh9dZ00kZ6gj0ZgNBWiH2MZyeFwm7bs2nn0cClZeUSi5K33VIBV2LdOpJ5w8u
 6Mi/Grb4Q5zKqIfEpVDAX89JmOUX9Og43Idj9rUPQb0CgOO5/JR6P6aH+ewmYPMBNp/F
 9myUYBlqzhvN00/Fov+pbPzFgwXvmADDJNvcjwxn5dq+0vWF5qkR0QD9oHXmtSAbFv/P
 lwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
 fh=dZ0tJMEGsIVFUzoIG+XzQP0n93LR20+4J2Xk227cWpM=;
 b=k/GOYv7/372Debm3Ro4R8L32jYghmG1inmCVfy6cTHFMzV1k8c5yQl45UgqnA1D9Cd
 8Glf6eblirT6A01E5kY32rhWvS73MZHAMrV8R79zMX4FxJe6eLfCQ7UxxZscCy1l018o
 Wl+mS8eoD7YPJnxZRC44qaw4/7OGozxJWZDZIJwmX5yuVdVX/TkoHumVkY5oRDG8qnGP
 ZxUrc1XwsYrVWj3ULhcosgAn9KX1Ys4BpSigIY5bCqXsUyUBWvVGIpVFXd4pfzzIDihI
 1/woqtzFLSUcOe0AGs9lkrcMpuROaOSv/CI5uCcRXA7XTiSyTBIqJAXHrF3w0z5UhnYz
 hVAQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790817704; x=1791422504;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
 b=lf+fEIf2iyhYfsPdFzzsic5P+Ko7VpsUktf9PIRcLhAho6FrwPEg3lTOfRQbzPwdgE
 DR87faJ+fxSTZz/3l6MyrHKoFH4qFcZMMFpeJoxWtQgsqqTrKA53oCZCha1rYETgjoL9
 AVw8WF70oWiFyz0Vep1gTXFbVAgTvpGQvPIng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817704; x=1791422504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6UP3uv9O3lAmZe+YYjtjnNyxqhlRnEIGC5ZIFCoWcq4=;
 b=txSWUYz2XZcG7mSJNQvsqxf52kQvCJviZ8Ml+TwTX/mMtDzfFZsHLVUfh032fMLktB
 ihaszkRWLlD0HgMAWjq1+1Xo6vfxA3+asCp/wD0FakzMZDn3kYAYCPP4VL9TnvkVByfo
 /TdNaW2ikyGDOfc6keedKnqAkkOmws/9odNVHv46Y/iD1aC47ucu5oW1b+mA1y1vpq6b
 N7laoo0lf3YpBCCs2ONw/3O3wpH8n/isCqSA2EXFbL4O/GQLljRS78981N/wpqO6Hy3H
 yLzkdE+/zCabhxtDUYdLkzojIJwJXXlF3L5z5jmdGGchWnCK+QTcKkDWwjqcYoY+YklZ
 YVJA==
X-Gm-Message-State: AFq9FYLBtOCyobLxEktX6IpNjOP6w8l/PVwxNKWuHdjgXeZELP+ubZHM
 D4K3mCGKxavAgFf+6zQZUbLTepX84cFRpzNtOOOrHHigpx+rNP6wYjANkKYN+ce4aq5WuV+F7Ai
 85GNhU6DpQP1vAj9b94pcUnLTR5J+fXMh0afrvO6tZmqrxZ0igdoIaw==
X-Gm-Gg: AYBFou26B1dozPuXpBZhpLPAh9YyBvVPxYbkkryGQcmZg8ZtlAsl5BoGosMJiKI6Euq
 lCQyzbShoRiTjCN2/v27E5A8snK/+URWoxwuUtQPUzEkgon82S4xAqLmT9volD0IjQfs9KJu5uT
 CybJ2N6AVK69Z8NPB4Kir0QFJMcwRwd4ZAeaTwLA22UDzEZ8oo57LM7cXgQYtdBjIOPxx/hMC5d
 cG8SVZXwN7bn3WD44VV+f5hBtiRQtHGNj1Ze5vEDlNow3yApY69dIMBlqTgcPYtF/ER3pwQGsl5
 amEpRf6VWNqp2ZM2d/o2uGVTsHvSiBbCGLgzCqfLoTyzFQyNn1DInB09MtegC29wdGA=
X-Received: by 2002:a17:903:4405:b0:2e2:d09f:d770 with SMTP id
 d9443c01a7336-2e2e4a28957mr22836945ad.26.1790817704092; Wed, 30 Sep 2026
 18:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
 <20260929110315.2879640-3-suraj.hanumantkakade@amd.com>
In-Reply-To: <20260929110315.2879640-3-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:21:28 +0100
X-Gm-Features: AclHuK-tHbeOC5gkEqFWT-7xtmdff4mP70BQY4Vvtsi9Sur_fone2QLSmUuzXLQ
Message-ID: <CAFLszTi4tsOD4FuM9=gHAT0J5QAHuHk7Vo64S1W7GtvHTTZ2hA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: drop GNU Make < 4.0 compatibility code
To: suraj.hanumantkakade@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
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

Hi Suraj,

On 2026-09-29T11:02:52, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
> Makefile: drop GNU Make < 4.0 compatibility code
>
> RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
> reached EOM/EOL on June 30, 2024. While you may get extended support,
> it is a good time to raise the minimum GNU Make version.

This text and the version check appear to come from Linux commit
5f99665ee8f4 ("kbuild: raise the minimum GNU Make requirement to
4.0"). Please can you credit it, e.g. "This follows Linux commit ...",
to help anyone syncing Kbuild with Linux later?

> diff --git a/Makefile b/Makefile
> @@ -12,6 +12,10 @@ NAME =
> +ifeq ($(filter output-sync,$(.FEATURES)),)
> +$(error GNU Make >= 4.0 is required. Your Make version is $(MAKE_VERSION))
> +endif

The check looks fine. The Linux commit also updated the documented
minimum in changes.rst. We have no equivalent table, but please
consider adding a short note to doc/build/gcc.rst, since the README
only says that GNU make is assumed.

> diff --git a/Makefile b/Makefile
> @@ -93,15 +97,9 @@ endif
> -ifneq ($(filter 4.%,$(MAKE_VERSION)),)       # make-4
> -ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
> -  quiet=silent_
> -endif
> -else                                 # make-3.8x
> -ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
> +ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
>    quiet=silent_
>  endif
> -endif

Please mention in the commit message that this also changes behaviour
on Make 4.x, rather than just removing dead code. The old 'filter %s'
check only matched when 's' was the last of the single-letter flags.
The new form matches Linux and handles Make 4.4, so I am happy with
the change itself. It also fixes the existing 'filter 4.%' test, which
never matched Make 4.x versions beyond 4.

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
>
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> Makefile | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
