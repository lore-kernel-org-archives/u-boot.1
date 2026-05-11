Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B168CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D886283A91;
	Mon, 11 May 2026 15:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lgLMZFrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFF383BC8; Mon, 11 May 2026 15:31:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6707838D7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso7547358a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506286; cv=none;
 d=google.com; s=arc-20240605;
 b=XFujHvpKTeWb/itS+tHqzH4KMIi7gwpBB3aCu65lRTtdOZ/bg+svZxrhjnG2tMgJIc
 X3OyaAM51xU1oNyyEejKv6VWszMQi5lWln7WwWDL8KXJTFzGErl+MWjfShld5K6061Sb
 8P/HOTI1hJriSX16c4yeuj0V3fMG7DXNltS6zE6/XTpb3CuKqXxAZneN7uVf4mCZ9ejV
 mJZh2FRMRPgXiytWOTp1TA7P0ZjV4hjIL9NtRdxUqBkxX/g4M33zeqpKb6wi18REbSQn
 QftCXk2NCTSZjGpImCk0yYzT7ZaoKO+4V2FOQ24HrZ/FXpXNth3FUbDl/GSEUdRPwO0/
 8EQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G/9c9jtiIWLUrC8zEx9FM22pYb3iZEKhrgRj72TYf/Y=;
 fh=gE6Yt7gElLCbh8ryhtP+HD2nmjSP4RFADqefourqOuY=;
 b=MwXb2537qn4cKkfJbF1TIlKRfnIKZlmmGUE39YDIjuJBuTnrhwgWZiAOiTJGkVq8n0
 nDu46WzjevRs2kH7hJywF2zzPD8GKbhtxGtlpjfbOVsAxCJUTOkSS0bDmajCRfmeoY9Z
 EzjIR/CeVvxac+LleX1zVcmJAVPXttEwT7sRUnY0xcJEMdoQjA4dIkylBsP5V4Rn0LCO
 kUJUoTPY7g7jrvz9aAsDvxr5DyTg00SWVbShLD59G2UngKgLxFMIp/T+yfkZUln+lP3X
 q3l9SMQMiAVCvOVMNO2hOV3deObSVV/IW9QFMfCxHqIESZVcnnkQaI/t8Hgsezvu8vU0
 ZG9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506286; x=1779111086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/9c9jtiIWLUrC8zEx9FM22pYb3iZEKhrgRj72TYf/Y=;
 b=lgLMZFrcwz0/LKKEwMPElsfq0BNA4Gw4FzaZ49Hc2Dimi3GsLTKyDIj/fNE316ZZMT
 JKZgbig5nU1A/7sRHxxxherj2L7XgSCcW/Wu+C+6SX/qd1u7oH2os2OoVLctDjLbsMqV
 tbyxeFlFkitniWnfz+QnbZSHvgaC9ZF+YRZl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506286; x=1779111086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/9c9jtiIWLUrC8zEx9FM22pYb3iZEKhrgRj72TYf/Y=;
 b=riszfzqodbe9fGH0TwzlBpqoDgasMu48EE2XCn264sM8RKUs6PbFv1SbhzXCg9o7kX
 Cw1GY4lg2uNsaL2JdrNhcUKJKsDdMaMi+vMvuCiLExzrS2RRktjCSPqeTqtvyHun6TFy
 El1oU+JIkaIvb5YC68ns4/aOd5luPzLW4a4M4hLzRnqFhcPIM5iBBDagWq8mDF0zCTGt
 DaAFIBWFgTU0l2HEiB9vSsujzo6rshXOohRVrRxxjujsNd13fPUYbYhFD6mAyzw9fPk/
 INFdo9VZYNS3MdRaH3xPbWid0S+BaVPNJ71NgmlWJSomf7n6+29/xfKpJtdedEO8eEPr
 Yk0Q==
X-Gm-Message-State: AOJu0YzxirASzLrDZZyST0BRZdtqNT0q67eYC/VOd1mfiy7vcETTQJUQ
 GUxVhc2A98kg5tkW5wO7Q/PjMIKmD8n171RdYY+nTvntc5kdBl55p9Fsx+cB0z/euvY3sMTnn/i
 fV/hBsuiyb2zvVJvvM/GI5BE+bqrfE7moc2V+VfjxrSOL0pOaQTc=
X-Gm-Gg: Acq92OFoi2GDSkgSs7kOshSlNgPJYtF6v6ZsBWcGL32aONJJLRYd6JKhToQJRoQE8ew
 8NLjrmsrdstj+pdFcCmObg07g5TttNvafvo3h5P3R/K2OfE+03JiuDP3FacA97G2HKMtia/4c04
 KOaUrhetpPG6StJkXc9eOwfnpadU4uKCJE4/kARv6j8HqBx6Dz8XiQNFh8rc2bmIpC6fUHAaH8x
 5d5DoBzBSMjjRuduEajsy4HU+2AqxBU5EOSV4TDOT+Ym0XuxkIDQo2GwusiT6t3Y1pZ9MVKZynC
 q54eSA==
X-Received: by 2002:a17:907:e102:b0:bcb:34af:654a with SMTP id
 a640c23a62f3a-bcb34af67efmr510886866b.40.1778506284856; Mon, 11 May 2026
 06:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
 <20260508213217.3807786-3-aristo.chen@canonical.com>
In-Reply-To: <20260508213217.3807786-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:31:07 -0600
X-Gm-Features: AVHnY4JwEmb-lpZCeR2EKZzaJll6t8u_0OuqfbiHQEDv8m8C8l0H9Bhsmk539kM
Message-ID: <CAFLszTjLL75tLp59ke8E8MTiYfrKJiSdmAmDwibLOiZBa54R7w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] test: fit: regression test for default-config
 print with reversed node order
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-05-08T21:31:58, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fit: regression test for default-config print with reversed node order
>
> Add a test that builds a FIT whose /configurations node is defined
> before /images in the source, runs iminfo, and asserts that the
> "Default Configuration: '<name>'" line appears in the output.
>
> Before the fix in the preceding commit ("boot/fit: read default-config
> property from the configurations node"), fit_print_contents() read the
> default-config property using the loop variable left over from iterating
> /images children. With /images defined first that variable accidentally
> pointed at /configurations and the line printed correctly; with
> /configurations defined first the read returned NULL and the line was
> silently omitted. The new test exercises the latter layout, which had
> no coverage.
>
> iminfo and the fit_print_contents() path had no test coverage at all
> before this commit.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
