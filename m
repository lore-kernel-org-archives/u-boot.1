Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D1DC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 16:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE846883AC;
	Tue,  2 Jul 2024 18:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HaXzIEQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A95886A0; Tue,  2 Jul 2024 18:30:16 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956D688113
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 18:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b5052defa6so25527526d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719937813; x=1720542613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0PEgycXGp50BHsyMoKpP6M9SosCh9tgSiDS7GVVglKw=;
 b=HaXzIEQYpZZxZTpLRBoL2a41l+HxBBLv/XA280CIejGmzz0sTaW4SOUQixD+GBo4tA
 JzFg/Cfv/gqjiCv4Yeog0LAvgzjHiBF4DRQvoLlP3z3CuVQ2gPVISQseKg5wRyqDjOFI
 pRjXPs7yP1by7OXxdRl3qjkodsronyAMbpVdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719937813; x=1720542613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0PEgycXGp50BHsyMoKpP6M9SosCh9tgSiDS7GVVglKw=;
 b=UBT2yYx0/2rnOVe0+NfifektTXIBPxeW2Cz7AdwrRjAIvuKYtAasvO4F6Bqf43N8s0
 l+K37tsiJMyd47br6JHp01Het4SR3H3TWFglNOFixe2DqhBe1syoLB7MfgV1IQeB9eaj
 WLBDYO4Id877RUiX+5JuPfSDqJNSUonz1CBV5Kr5ztVLOU2OQlT5Rx2o1YH8kkvOKYgZ
 5XmNlq8I9ohdCfUMam2bMafz4jA+viLDmOuE3rDDc+Z7bwdLcuA+ENggSYThGwkhtyp8
 /FV41/ehIZcbbcT25F+Sp6Rc3x7bvOwfjWto1gRVuGwtSc89oqxGSF50uy1A4sNdpYRM
 DXhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGBIir99cqqUuYAi2SA81PhUu92+wd/Klb4SEN542GQtPdahTDcohMyw+U1NVyBXj+ThJfDBLU/ACC8c5/kSTTat4gsA==
X-Gm-Message-State: AOJu0YyOzyA7jsPGKRmXe+MbUk50rpIRAqv6XsJGOmkvr06Vp7Lb9lUI
 LuuWI4cUAhGFu+4rXvwh8sr3CdCB1Rj2/mhu4oYOXpnsWvP0u+hscWbxPEYjm2nRT+OzbCJBWaq
 nErcyd6Z6mMvwQRqbxj/mr0meT47N602rdSiR
X-Google-Smtp-Source: AGHT+IEZqWV+AbD6XSy9lCDCiQh6wxPwTlxnL6P/b+cFbDzO1sSbmuBEBGjKOQV7IPDjqt37qjJtGxnvXKfA4P4JFa4=
X-Received: by 2002:a05:6214:20e2:b0:6b5:2b33:5445 with SMTP id
 6a1803df08f44-6b5b70cd6d2mr105896516d6.25.1719937813524; Tue, 02 Jul 2024
 09:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240702011440.2888308-1-sam.povilus@amd.com>
 <20240702011440.2888308-3-sam.povilus@amd.com>
In-Reply-To: <20240702011440.2888308-3-sam.povilus@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 17:30:02 +0100
Message-ID: <CAFLszTgUgYjRNMMFVeEtpfG93_RKvMsJbQtPjm+UUWKYimLQVw@mail.gmail.com>
Subject: Re: [RFC v2 2/2] doc: add missing table of content links
To: Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, xypron.glpk@gmx.de, u-boot@lists.denx.de, git@amd.com
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

Hi Sam,

On Tue, 2 Jul 2024 at 02:14, Sam Povilus <sam.povilus@amd.com> wrote:
>

Please can you add a commit message?

> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
> ---
>  doc/usage/fit/index.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
> index af2e481212..904f1593cb 100644
> --- a/doc/usage/fit/index.rst
> +++ b/doc/usage/fit/index.rst
> @@ -16,3 +16,23 @@ images that it it reads and boots. Documentation about FIT is available in
>      verified-boot
>      beaglebone_vboot
>      overlay-fdt-boot
> +    beaglebone_vboot

This seems to duplicate an entry above. Can you try 'make htmldocs'
and check that it passes?

> +    howto
> +    kernel_fdt
> +    kernel_fdts_compressed
> +    kernel
> +    multi
> +    multi_spl
> +    multi-with-fpga
> +    multi-with-loadables
> +    overlay-fdt-boot
> +    sec_firmware_ppa
> +    signature
> +    sign-configs
> +    sign-images
> +    uefi
> +    update3
> +    update_uboot
> +    verified-boot
> +    x86-fit-boot
> +
> --
> 2.34.1
>

Regards,
Simon
