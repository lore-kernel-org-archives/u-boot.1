Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB779E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 14:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7C88021D;
	Tue, 31 Dec 2024 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K2cVScSI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50BB880379; Tue, 31 Dec 2024 15:46:18 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8876D801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 15:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so17215325a12.3
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735656375; x=1736261175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S/TcbGsxmPKv/Cglf8kCNlrIEKT75vo5DfaVhro3HmA=;
 b=K2cVScSIFXV3mAt0wGS2YJ26opJ7+kazfgPoe9K1Nt7JzA9jy52vQQI4hhjvbyg948
 mkVmvCKNvSCp9RAXOv6jPuinrcvf6zQ2S6at7V/hhKQhLWhs9LNobCg0nfgIwZ/VsyYu
 QxtiOThSynbCY14ukcmZoDaoKPF6/WshC+CU/RJGHFcHH8+cvV7kAo7uKah+q1BENEt3
 iAceeYhEUqtwEjMgb8Ji4iBB4KRSTbKlZmmrM5ltKnwLQlWDSjsSjuof3dI5nASSK9Zu
 rz2VuKwIDGsTJgJF7EjzzhepI8u0ZeOSQTyU2pExd5e7WlbZHCYOm9Wyhmi2SDb8CNxB
 UunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735656375; x=1736261175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/TcbGsxmPKv/Cglf8kCNlrIEKT75vo5DfaVhro3HmA=;
 b=Y3UkLW8CCCk6b39/9LNMjeiPhmjEVLpiIKqzyNuip8C37QuQgVCW7axZcaZ1oxk5aA
 uQrv7ZrpFeiubFuCb5nBnlcnHw3iLQXrhblkuqc+BAjYOUOqeC2o4zFyQfmW7mNGQXZ2
 UECVTZur8FqIT7Cwf8r/P8L9NvjvfLe6StGKYYtjhKsCnkl55XBSQeJFJZVJTlgkk/AY
 d+TzNVQ4vuOcdEylt7lBWqQ3UAT0kDdc/+jFqP6rFKx0uoAQUb38cg6/JC/aGhAisbe4
 zqQhYSM/N4zf6VokMcG3ZI3UCWZbIzDWTuNlL7jbmHr5XPfyDXr0zFyuRPe2DipjMpH8
 KTJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7fZ1Vqec16WRx3oTsmlpTqqtbrDNoXIOxc2etXw4TtOVu7wBlCIWHnMHi2q69vMPLYXpWBWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzPiOq0YycMhcqvneLE7qdBU5YNNY5KWabkQaJx/D0ogHmUB/NX
 8kzrR4MfplWHh4klqb2GBEY/nGrPbz7P5uq0Dks+Sh2RYDQRLmrEkw2wSryR1AerBSMJjY8W6Kz
 1wQmnTlS+BmHrnG2lthpnLncF8ug=
X-Gm-Gg: ASbGncvg8LxifNEEGnX+Qj2AIhnrx1i3MsXz4imQ7RRqIBWOUyA1dylPE6uzGRUiAhW
 WOEi4ybk4FGALqPk23FS8p8br7oVMHYuCkZ8rMeQDtrYsF8LyDMKhfRXaS4PnSbkbN5HGR3E=
X-Google-Smtp-Source: AGHT+IFn2/axdHoveTnSWpp15wJEQAyU6cTc9gfMc5khX8q5qFxlZB2h6lzxERLx1gb1hkQ8FZ1ybSvmqOjuI7d4vGk=
X-Received: by 2002:a05:6402:210e:b0:5d1:1024:978c with SMTP id
 4fb4d7f45d1cf-5d81dd83c3amr35287293a12.2.1735656374625; Tue, 31 Dec 2024
 06:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
In-Reply-To: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 31 Dec 2024 14:46:03 +0000
Message-ID: <CALeDE9NbSEw1ZR2h_2Taq985aaoV6Oe5YTiKbY8RCfVg66uG1g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] usb: dwc2: Refactor and update USB DWC2 driver
To: liujh2818@outlook.com
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de, 
 Kongyang Liu <seashell11234455@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 30 Dec 2024 at 14:35, Junhui Liu via B4 Relay <
devnull+liujh2818.outlook.com@kernel.org> wrote:

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
> [1]
> https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-mk808-md
> [2]
> https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
> [3]
> https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-k230-canmv-md
>

With basic network testing on the Raspberry Pi 3+ (uses a USB attached
ethernet NIC)
Tested-by: Peter Robinson <pbrobinson@gmail.com>


> ---
> Changes in v2:
> - Reorganized structures, renamed macros, and moved code for better
>   clarity and maintainability.
> - Added a fix for the incorrect ULPI_UTMI_SEL bit setting.
> - Added a fix for incorrectly calculating HBstLen for external DMA mode.
> - Extend the changes that replace uint32 with u32 to also include u8 and
>   u16.
> - Link to v1:
> https://lore.kernel.org/r/20240522142311.17351-1-seashell11234455@gmail.com
>
> ---
> Junhui Liu (8):
>       usb: dwc2: Extract register definitions to common header file
>       usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
>       USB: dwc2: Fix HBstLen setting for external DMA mode
>       usb: dwc2: Clean up with bitfield macros
>       usb: dwc2: Align macros with Linux kernel definitions
>       usb: dwc2: Extract macro definitions to common header
>       usb: dwc2: Unify flush and reset logic with v4.20a support
>       usb: dwc2: Replace uint<x>_t types with u<x>
>
>  drivers/usb/common/Makefile                |   2 +
>  drivers/usb/common/dwc2_core.c             | 103 ++++
>  drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
>  drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
>  drivers/usb/gadget/dwc2_udc_otg_regs.h     | 289 ++---------
>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
>  drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
>  drivers/usb/host/dwc2.h                    | 750
> +----------------------------
>  8 files changed, 1123 insertions(+), 1506 deletions(-)
> ---
> base-commit: cb7410257ac930a6fb05f1c63b291b7d399f19f2
> change-id: 20241218-dwc2-dev-955c21a81118
>
> Best regards,
> --
> Junhui Liu <liujh2818@outlook.com>
>
>
>
