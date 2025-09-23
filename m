Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F9CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC69833E9;
	Tue, 23 Sep 2025 20:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SVBvjsxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513A080107; Tue, 23 Sep 2025 20:33:05 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E268349B
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b2e173b8364so384024066b.1
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758652382; x=1759257182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1LNtWK2k+HSI2kA1PyQhd9hyPX3zd1vJk7t8bjGBWZQ=;
 b=SVBvjsxCosrh9mwz012Pq0eQzph/I3kqRAXQ+WzZowNqP0KqdIb8AObh/uJeo4c0qc
 uumIQcviEAOmoQYXMgOmQkAKuTRnF6mAKUgxSdrjTY2p/vHk4r5uHv+i2Kkfnwa1yrGb
 8jlO8J8pYnjfyuZPbs9be4DeXG23p+U9GQxJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758652382; x=1759257182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LNtWK2k+HSI2kA1PyQhd9hyPX3zd1vJk7t8bjGBWZQ=;
 b=WyDqcoLRGLt6iuVwGLPabZ9+8guve2E4bcmv29XFrxTeUGulNxshlQYssW7aLP7SUT
 BX/3PTODjFPjIR4NyDCEWJEXD6ieDF/MAxx0/60Gzvn7p3ah7ENVi1Hik0cuOKkCzF7X
 2exbKGSCDKtrQTFCw41z8vuoiqNv3ltZT5oGTl3gLHkwIpov4UHFSdBQ+cdpWqpwXNtc
 TDNJ/9VKzYuH52E8zbpb5LCI7CFczC3DuDC66TokXiDinfWM83ywJMrU/65U+CoG4/hm
 qsz/HFdv+77m0NBk5Acb2EXLbSX4w7SxtMrHJik762whOMspt7f2BhxW762Hn6msktYx
 /F1Q==
X-Gm-Message-State: AOJu0Yxoth1ReA1TLZvrLJUnVg7od3JzBt1UD1NWkJdAwHW1PgynbUS5
 j0Ac++BwlVZ3ICNeKOwoSCtClfbdx5Be+LaNZJ5b2csfBz/Ss3EFtqbYcdA9/rLUhTbOwUekDlZ
 lsb2ZYOs2H5MYGZLZjxHwI9MGfWA0fbGX0vFAGI33KXSqRkGap/t06A==
X-Gm-Gg: ASbGncuBHUU6hrmmvTXP9pmKrg47+3Xi/JtApesS/P74IcMDswMxwz6ViyCuMqlv/T8
 MUFpks4X89K0x9IpZP21QoVSWYfZ9Chnmv87lADtC/QXON9XTGGKRZnY3lfIxeS+UKbIB1Pxm7/
 wWKiO5EN2XbdhfqzqT+8H4QJ3wys/CjZ9lVl7a8W8tz4s5XB9F706cBGkRAmqrjX6SeKLeyUblu
 /CUxw==
X-Google-Smtp-Source: AGHT+IExCWnrF5wLWxBhdLyUghhh8cnBB/eQ3XXsYb6dIHk1fX7Z0BZiypGAbbtu8eKZSc+KMqw5ABFTVk94Jpfyi7Q=
X-Received: by 2002:a17:906:57cc:b0:b32:2b60:f13 with SMTP id
 a640c23a62f3a-b322b7ea383mr49329866b.54.1758652381747; Tue, 23 Sep 2025
 11:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250923183053.786043-1-sjg@u-boot.org>
 <20250923183053.786043-4-sjg@u-boot.org>
In-Reply-To: <20250923183053.786043-4-sjg@u-boot.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 12:32:37 -0600
X-Gm-Features: AS18NWCJUSB0vCDScCoEkO3a6nv2XoM_k7AcXiXPtRBRZDU6qJAsnsMgE5cOJ70
Message-ID: <CAFLszTi6gf=PSYsNYT19ry_2TwoZUBF4yXsOnMOmXGSGrQD1EA@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: Deal with the silent menu in grub
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi,

Sorry for the noise, please ignore this patch.

Regards,
SImon


On Tue, 23 Sept 2025 at 12:31, Simon Glass <sjg@u-boot.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The distro test for EFI in the EFI ARM app is currently flaky.
>
> If the test does not send an 'escape' character, then the board may boot
> straight into Ubuntu. If it does, but didn't need to, then grub sits at
> the command prompt.
>
> Handle this by pressing escape twice (which should always go to the grub
> command line), then using the 'normal' command to start the menu.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  test/py/tests/test_distro.py | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/test/py/tests/test_distro.py b/test/py/tests/test_distro.py
> index cc4aa265d90..d9bc9b18648 100644
> --- a/test/py/tests/test_distro.py
> +++ b/test/py/tests/test_distro.py
> @@ -106,13 +106,21 @@ def test_distro_arm_app_efi(ubman):
>              ["Booting bootflow 'efi_media_1.bootdev.part_1' with efi"])
>
>          # Press Escape to force GRUB to appear, even if the silent menu was
> -        # enabled by a previous boot
> +        # enabled by a previous boot. If the menu is already set to appear, this
> +        # will exit to the grub> prompt
> +        ubman.send('\x1b')
> +
> +        # Press Escape again, to force it to the grub> prompt
>          ubman.send('\x1b')
>
>      # Wait until we see the editor appear
>      with ubman.log.section('grub'):
> -        ubman.expect(['ESC to return previous'])
> -        # ubman.expect(['The highlighted entry will be executed automatically in 29s'])
> +        ubman.expect(['grub>'])
> +
> +        ubman.run_command('normal', wait_for_prompt=False)
> +
> +        # exp = ubman.expect(['ESC to return previous', 'grub>'])
> +        ubman.expect(['The highlighted entry will be executed automatically in'])
>
>          # Press 'e' to edit the command line
>          ubman.log.info("Pressing 'e'")
> --
> 2.43.0
>
> base-commit: 136c959dd2d089710fb131956081d09b9da3bea4
> branch: labh
