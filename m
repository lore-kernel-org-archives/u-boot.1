Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E127E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC48F8036B;
	Tue,  7 Jan 2025 10:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DBcC+EIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 997A8803DC; Tue,  7 Jan 2025 10:47:43 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F701801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso8141129f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736243259; x=1736848059;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fAFLKSSFsh1TbgCIl/E+IUrhIU9DeryxX7nMGS+SwsQ=;
 b=DBcC+EINb6BmkhptGTfhHjnAIl251i6JLA/WCKbnOwuqewzPzLQ0iLcK//lBY9Fjd1
 RegTV8lmvYlj6JSjtMBqdTsEMQfqGRsKM2L60wG1ckyhiED9TnZzDRESV+8cGz+NsGp+
 +MA9IrBxyM9UQWsYL3ZOdJEpa2bOf0hZFnJ3WdPl15/uids4YVkg22LeBMX9hAl2m2Pw
 Xr1VKef19Fxm9r6jYYrXVxtGmPMbU5fQ7ya2OMVeFr9HmAEUv8hgTpay/bN1rIJIuOJI
 BJj+aI9Tyi2MWpefZxb0QvRpCN+jaCBYozrmgbW2RDyUMPzhWw9KogoOucY+ptRsJP8p
 JI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736243259; x=1736848059;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fAFLKSSFsh1TbgCIl/E+IUrhIU9DeryxX7nMGS+SwsQ=;
 b=Fm/nu7jTIb3oaCwiis/RKZbtun4frLBQ/R/694iKQthQKESJMsLl78zNDcb71mKjU9
 C3+rSRLvhw71YKqiIMOiAGRRL72Dud3/W+ND6wv0A/+mu2DHPkd0auqCI4CD5jyczbC3
 QkYWrekTaOIHQDnyQGYOpUf7Ip1T+jrw42x8OGORtzq0vQnBBD1DeKk7B/nog5+MW4Tm
 W/4220wKuLsvy84xoo2m53mKqvfeUiJ0Um6gzQCfgWpk3sLEWeKOgZ0RkId10q2nRa4W
 T3BKGdQuK/cPKzeO2lhgnFrfGdtylGr1/yjwd0VSetifkbgyONAJimKckX6cF3ud1igK
 UBBQ==
X-Gm-Message-State: AOJu0YzcuVK2+E/7HJl0TCl7M1yYYB45WigRdWXtUlqaVHUwSNMc1u57
 AnXph2iFsqCKev5axWt1h3hipEPKMUwqzoHDSvC5nCi145M3uAIkaLDsP9sYbrA=
X-Gm-Gg: ASbGncvWbwU9xjjLcLu+/w7KlpASyrGfKyR5HgVQV87g2btxuJmzbAq9rY8yRZ2VRBu
 i7gz96EiJdbU7vZUw2x38ex4KIodVeEdLxIWJWEIG95OIqC6yYZzrAT3Q5CqcYu1uKCxzIn+Uk7
 de6kVObp1g34LuHwdjtxRPEZv6IuP4d1eMeAUModZQf2ydVqq8qlvnnREa+FhCY6EW91Cj/kI/n
 8/EYskG4I3VOdJZltmfUIm7wEGA7jwmGtufkxdtWlA3nPS4S/g2Hjcr91auLEjgxQ==
X-Google-Smtp-Source: AGHT+IHP7suyig9vlEYhoEsij2rY6cV8COt1SvTVHIgisIluFTuppAI8xk8jyXNqwrX1xfgKrxE9ug==
X-Received: by 2002:adf:890a:0:b0:38a:615b:9ec0 with SMTP id
 ffacd0b85a97d-38a615b9ff8mr15194805f8f.54.1736243258788; 
 Tue, 07 Jan 2025 01:47:38 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b271sm624130035e9.34.2025.01.07.01.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:47:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com,
 junhui.liu@pigmoral.tech
Subject: Re: [PATCH v3 0/8] usb: dwc2: Refactor and update USB DWC2 driver
In-Reply-To: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
Date: Tue, 07 Jan 2025 10:47:37 +0100
Message-ID: <87jzb7c5vq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Junhui,

On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> This series improves the USB DWC2 driver by extracting register
> definitions into a common file for better readability and updating the
> reset method to reflect changes in version 4.20a, including the new
> GRSTCTL_CSFTRST_DONE bit for reset completion indication.
>
> This series has been tested on two platforms:
> - MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
>   connected the board to the PC through the rockusb command. Test log [1].
> - K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
>   rtl8152 USB to net chip and an external rtl8152 adapter connected to
>   the onboard USB-C interface via USB hub. Test log [3].
>
> [1] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-mk808-md
> [2] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
> [3] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-k230-canmv-md

When applying this series on top of master (commit 6d41f0a39d64 ("Prepare v2025.01"))
And building with khadas-vim3_android_ab_defconfig, I see:

drivers/usb/gadget/dwc2_udc_otg.c:1209:33: error: invalid use of undefined type 'struct dwc2_core_reg'
 1209 |         return readl(&usbotg_reg->global_regs.gotgctl) & GOTGCTL_BSESVLD;
      |                                 ^~

Full build logs:
https://paste.debian.net/1343304/

It seems that at some places, we use:
    struct dwc2_core_reg

instead of:
    struct dwc2_core_regs

Could that be fixed for v4, please?

I think this typo is in "usb: dwc2: Align macros with Linux kernel
definitions" but missed it during review, sorry.

>
> ---
> Changes in v3:
> - Handled warnings from checkpatch.pl (add spaces around '<<' and
>   replace 'x' with '(x)' for macro argument).
> - Add return ret; when timeout happens.
> - Link to v2: https://lore.kernel.org/r/20241230-dwc2-dev-v2-3-12cd9b8a2358@outlook.com
>
> Changes in v2:
> - Reorganized structures, renamed macros, and moved code for better
>   clarity and maintainability.
> - Added a fix for the incorrect ULPI_UTMI_SEL bit setting.
> - Added a fix for incorrectly calculating HBstLen for external DMA mode.
> - Extend the changes that replace uint32 with u32 to also include u8 and
>   u16.
> - Link to v1: https://lore.kernel.org/r/20240522142311.17351-1-seashell11234455@gmail.com
>
> ---
> Junhui Liu (1):
>       usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
>
> Kongyang Liu (7):
>       usb: dwc2: Extract register definitions to common header file
>       USB: dwc2: Fix HBstLen setting for external DMA mode
>       usb: dwc2: Clean up with bitfield macros
>       usb: dwc2: Align macros with Linux kernel definitions
>       usb: dwc2: Extract macro definitions to common header
>       usb: dwc2: Unify flush and reset logic with v4.20a support
>       usb: dwc2: Replace uint<x>_t types with u<x>
>
>  drivers/usb/common/Makefile                |   2 +
>  drivers/usb/common/dwc2_core.c             | 115 +++++
>  drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
>  drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
>  drivers/usb/gadget/dwc2_udc_otg_regs.h     | 293 ++---------
>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
>  drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
>  drivers/usb/host/dwc2.h                    | 750 +----------------------------
>  8 files changed, 1137 insertions(+), 1508 deletions(-)
> ---
> base-commit: e7713a78829250b925d6377ee26c7b0745727feb
> change-id: 20241218-dwc2-dev-955c21a81118
>
> Best regards,
> -- 
> Junhui Liu <junhui.liu@pigmoral.tech>
