Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8194C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FE2874D5;
	Wed, 20 Dec 2023 13:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I6gX35st";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027ED8772A; Wed, 20 Dec 2023 13:48:49 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DFDF874B1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e3cde8ab8so733047e87.0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703076526; x=1703681326; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=smbOsUBEsGc4caUVMoi7EFhMuHSsN1bzdtNsmKmN8ZY=;
 b=I6gX35stlOlHDcKvY756tO0BIpN/NB0KN2AtPVH6BkcbxYmXC443FJOD2crzXKqnHa
 rQiW5KJ1aqKpu7P/93C7ZP6k+SRpLCRgg+dl1pL2sG+icVOAmIpkygWBszvSTJSq7Ady
 s6tS26zKy/aXiMKwkkyRk+yngkwm6fn35vxRKDdw/bPzX2v5erSycifzZIeiHhGu5o36
 5BANtgHkYgRjXHlPW6jtbAFz6juleso7d7mLXNaPaNaWeldndVmiX2bxFxYWL5bEkKFm
 46+7gvKPq/9/R3CivifLweXH9EYmzZejwRhmN6/NgxQdKaEOHao4T1QwKO5P0u6cCbxy
 B6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703076526; x=1703681326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smbOsUBEsGc4caUVMoi7EFhMuHSsN1bzdtNsmKmN8ZY=;
 b=MxMf370/cs7VFGHr/QlzT85i4NJvVfdHbUw5s72WahOmOukorTvoCbhYpAvDcAWJ4l
 335x5zciH/7M++vXLUaNcAG3G2fEQyjgXKGFrXEoR1Ar+79lOz+jbCBBqq3yCSUdaL7n
 84SvcPJanwUdIhEu5wy455LCrY9RoCV/bLHFujb0K+LvMtJID+aajX0G8rVeRRT/J+EC
 maf2z2v+GZNYu7IRW1K1L0ul5mgxbXpGIj3i32Qkf95/DzmlY/pZub+16Z5boeWId3hT
 JcCii1jOHVT/GM0r7CGMysXCeA595X+q6GZSieIeklhKrm9g5M0RnybMIRwhR71XaBek
 iS5Q==
X-Gm-Message-State: AOJu0Yz5fE3ILMwia8WRivZQ71F8tSJk05TOuUACYxJop319cmS3AGyy
 7VhidD3qNE/fmejUW9qMA6aFVL/LKIZO8erg6bPbAJIL2nWmPw==
X-Google-Smtp-Source: AGHT+IGqQFE0JkMsF8DsbFdPGfdvsaf0btATaZKPWkdFJwpGUqSQtnIC6CUps0/fu0cJMgvmbSiogm7t+tlCUfp+d4I=
X-Received: by 2002:a05:6512:4898:b0:50e:26d2:8391 with SMTP id
 eq24-20020a056512489800b0050e26d28391mr1579732lfb.31.1703076526251; Wed, 20
 Dec 2023 04:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231219150408.10949-10-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 14:48:10 +0200
Message-ID: <CAC_iWjJi5hvTZCO0LgSaT6qmOskRrwbxHGCSiHwxyybdfu5gxg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] arm: enable support for QEMU firmware tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 19 Dec 2023 at 17:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enable the QEMU firmware interface if ACPI tables are to be supported on
> the QEMU platform.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
>         no change
> v3:
>         no change
> v2:
>         new patch
> ---
>  board/emulation/qemu-arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
> index ac2d078f42..e21c135e86 100644
> --- a/board/emulation/qemu-arm/Kconfig
> +++ b/board/emulation/qemu-arm/Kconfig
> @@ -5,6 +5,7 @@ config TEXT_BASE
>
>  config BOARD_SPECIFIC_OPTIONS # dummy
>         def_bool y
> +       select QFW if ACPI
>         select QFW_MMIO if CMD_QFW
>         imply VIRTIO_MMIO
>         imply VIRTIO_PCI
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
