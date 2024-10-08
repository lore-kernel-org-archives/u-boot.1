Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2ADBCF0427
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 21:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2609688F23;
	Tue,  8 Oct 2024 23:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDX5/9T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1EB88F47; Tue,  8 Oct 2024 23:19:27 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E7688EBA
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 23:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so8400150a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728422365; x=1729027165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndfd7aFQ13gSQLD5Hw1ovJg0ihAm2IzlxA7CHEwvpDo=;
 b=hDX5/9T4/pIxM9WzGsmX8C5ePu6Cv5aNpiJ6OyhZkiLgEymbV2kY6YH+i1ZI+QsL7o
 h0zsuMWXcpqqXl07ITJtqR683LwStUmKyEvoNq9T3kxovJAODjcGiQ930IwohJaISS/S
 MnVEbIGFilG912qVaeaWF0Abysl1EpoLbzQJY05qrUI16iQW2WwivMqaAEs37VX5ijy2
 BkzLLlX/ftmbp16pKgrn7xPpMxmLcWZ5LupSbfFDSLnrbLfIRQ5k7asJkY/cfCNw0Zs5
 66LTa+t2iLmqeVwHUFaO8WY97pOBA/mGca01yEZEX9ehrG4ksnW+dXuamfiRTLGCs0i7
 kMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728422365; x=1729027165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ndfd7aFQ13gSQLD5Hw1ovJg0ihAm2IzlxA7CHEwvpDo=;
 b=HiL/38FzqTHWwmO6rjUjeTi3aeUKsd/giDyCLbDIglb/b/sDOws7otuTPcfR2qDzaB
 j44iVtYH2sUeqHHF74yX9GtS9p9/rDcMcOdjYSvxx10r//xw4PDe2NUtzduIYTqF81Iv
 Bw3GT4QCq4GwpXlz6k2jVmuDDraruATutstL6SDxwudVMvS9FIKYySTJvoTtBwVILco9
 V5afGDCfFomyhSfyYW4DedsHDQGRPRpj73ZKVSk8nf7hEzMZAvSYxwIB4vxDT2pqdabu
 px+KchLgU2mBS8yYcGnBRkodhe8yyWWo9xkuTNDX99COUGpKR7L8NuWxfP51NWdeGuSn
 sSmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNYCOJXTPyma5bcyCTFPoz3XpF2o0dqwPaM6kouJNJ6CRSypPqtQTebr2irfWJlp61YhPGps4=@lists.denx.de
X-Gm-Message-State: AOJu0YzQqM/3hZsz37kbkLISXDwODaYLBqOy4kz8U2HXM9qBQGZfy8Uj
 4wpt2xa2xhU6HOWbwUoN+RnIFFCiDy3jG+cKJoEM26+OH5Y0NZsxl/ZXPM6wNlDNyPgQ7oMGGSK
 qQPdqXjk1dJGTN5trioKnMIvQcO7plEIT
X-Google-Smtp-Source: AGHT+IFk9vijPWruprCJDAq6NqqVBmi2REwe7qZ98madxsjT8uYx/tpaeRZINml+MGClw5e9yQ4Ndjquf1+5QA5xdmc=
X-Received: by 2002:a05:6402:42ca:b0:5c8:8fe7:739c with SMTP id
 4fb4d7f45d1cf-5c91d53e908mr203646a12.7.1728422364497; Tue, 08 Oct 2024
 14:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241008192719.2192430-1-jonas@kwiboo.se>
In-Reply-To: <20241008192719.2192430-1-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 8 Oct 2024 22:19:12 +0100
Message-ID: <CALeDE9N7o_WsXLd-txWyYzHTid3JQPFY-1WLgMFb7TnZZ=CskQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: Migrate to use USB_DWC3_GENERIC on RK3328
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
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

On Tue, 8 Oct 2024 at 20:52, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> After the full convertion of usb gadget interrupt handling to
> usb_gadget_generic_ops, it is now possible to use DM_USB_GADGET,
> DWC2_OTG and DWC3_GENERIC together without causing a build error.
>
> Change to use USB_DWC3_GENERIC instead of USB_XHCI_DWC3 to complte the
> migration initiated in commit 1bc4e8eb1d7f ("rockchip: Migrate to use
> DM_USB_GADGET on RK3328"). No functional change is intended.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
LGTM
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
> This has been tested on a Orange Pi R1 Plus LTS and a NanoPi R2S Plus.
> ---
>  configs/evb-rk3328_defconfig                  | 3 +--
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 3 +--
>  configs/nanopi-r2c-rk3328_defconfig           | 3 +--
>  configs/nanopi-r2s-rk3328_defconfig           | 3 +--
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 +--
>  configs/orangepi-r1-plus-rk3328_defconfig     | 3 +--
>  6 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
> index bfb85223437d..b3790c4d4ae2 100644
> --- a/configs/evb-rk3328_defconfig
> +++ b/configs/evb-rk3328_defconfig
> @@ -88,13 +88,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
> index f311a0a80ba7..19fab59eff01 100644
> --- a/configs/nanopi-r2c-plus-rk3328_defconfig
> +++ b/configs/nanopi-r2c-plus-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
> index 533dc1029f73..65ffdd34d4d1 100644
> --- a/configs/nanopi-r2c-rk3328_defconfig
> +++ b/configs/nanopi-r2c-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
> index 2591a9cc8ab2..751da1c446d8 100644
> --- a/configs/nanopi-r2s-rk3328_defconfig
> +++ b/configs/nanopi-r2s-rk3328_defconfig
> @@ -94,13 +94,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> index 14cdbd813c81..7786a3514b4d 100644
> --- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
> @@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
> index 7fe58e7a1467..e2b9ce705ecb 100644
> --- a/configs/orangepi-r1-plus-rk3328_defconfig
> +++ b/configs/orangepi-r1-plus-rk3328_defconfig
> @@ -104,13 +104,12 @@ CONFIG_SYSRESET=y
>  CONFIG_USB=y
>  CONFIG_DM_USB_GADGET=y
>  CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_GENERIC=y
>  CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_GENERIC=y
>  CONFIG_USB_DWC3=y
> -# CONFIG_USB_DWC3_GADGET is not set
> +CONFIG_USB_DWC3_GENERIC=y
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DWC2_OTG=y
>  CONFIG_USB_FUNCTION_ROCKUSB=y
> --
> 2.46.2
>
