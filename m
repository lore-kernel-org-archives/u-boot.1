Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 11:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0A38851D;
	Thu, 18 Apr 2024 13:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZiPAwNpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFEB885BD; Thu, 18 Apr 2024 13:48:16 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17EA885F5
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 13:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34801b1bc4aso140897f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713440893; x=1714045693; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElF1XMui5QmKTnb7hArcBvbOESOqRBGt2SJ9WGI7Z34=;
 b=ZiPAwNpwCSowhVCdNOX5lVcei1h8oC7AiBRy5IWJyyLLxOi2XGb+OxnmSrTpJ36TMV
 /jY4A8BO7C6LjHLA2ngDuCoChwyv47X3GRemSruh/SeCufJHB0mvyNNlNXIIu2la0GDJ
 oa7blP9V1dgHrpIAEKILIO5gjI9vZTsHCOaDddKa7Fggy3M4D8RNM+T032pSAJYMA94y
 i0fM862VG78YVi3OK6Xfmxp7BhP24CLtw/pnulDDur7wRPr0gXGISAmsr9Y9cQCLmHWv
 rJZV6WXcv1ZQu7OlyfuYzNp+Y/r3E3+NzgLL3ZFfv/YtLPc5scnViA8SueU/HUywwlPE
 /fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713440893; x=1714045693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElF1XMui5QmKTnb7hArcBvbOESOqRBGt2SJ9WGI7Z34=;
 b=L7v9rYDC8Lvu5iBb/YYYbIIoeTZAh+W0Oi9SFoUh/IZJXcVXuR+3XhOHIDGg2KLxE2
 q/D0e6Ekdd/9VJ6bupI/3Tcp5PWCvk5ZzQ0BGYmRFha4DXGl9nVTQg/FcqDbD6cljVgx
 9ky9leaD8kvlEN+KhaufLl2PonLtOFzJRnau5IP/xoL+8eY9VyVhUXTXztRpJt4kSBaA
 61NsKUdOFm4yRpMto3hFoR1qL+0016TZffcX1lSsSjba1xPkj/xK61Fpr9xmLPCS0DqN
 VRUQUR3QnQsd0/BiU3MRvF0RjO8NHZ64zgPPJA+W9k203VhkBTnuyPYbuU5/UW6d0ZIv
 EcjA==
X-Gm-Message-State: AOJu0YzV/U1oxNXZr2tA00fIOALrmm5l+NQcyON4WA8ic6UnpWvgEQyu
 Alss+hIyj+XjusSWbDSvSMdxQwzuWaLeOxv+ZH1x8uq+Fq1jHZfl2NOI3hta9vr+LJbpuD4rTcI
 M0bM/VnpLGNlqRNVPf0FHp8IvVWwPmInO6D0=
X-Google-Smtp-Source: AGHT+IFWhKsheksLnm06zQsZ6wqD49a+t7P1GXwqm6MSnXxSeY/HZ0w0mF9fsob/n64yWSx0RGNQamLQYd/xC73U2SQ=
X-Received: by 2002:a05:600c:4f51:b0:418:73d1:94e9 with SMTP id
 m17-20020a05600c4f5100b0041873d194e9mr1695520wmq.4.1713440893052; Thu, 18 Apr
 2024 04:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-2-patrice.chotard@foss.st.com>
In-Reply-To: <20240409150215.2497778-2-patrice.chotard@foss.st.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Thu, 18 Apr 2024 13:48:01 +0200
Message-ID: <CAByghJa_3MwcY74oNR0cKA2+XOA6R6J8LGhnecvZoJr_ONxTXw@mail.gmail.com>
Subject: Re: [PATCH v1 01/25] configs: stm32mp13: Enable FASTBOOT
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 9, 2024 at 5:19=E2=80=AFPM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> Enable FASTBOOT relative flags for stm32mp13_defconfig.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> ---
>
>  configs/stm32mp13_defconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
> index c893e272db9..db09e63100e 100644
> --- a/configs/stm32mp13_defconfig
> +++ b/configs/stm32mp13_defconfig
> @@ -15,6 +15,7 @@ CONFIG_CMD_STM32PROG=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0xc2000000
>  CONFIG_SYS_MEMTEST_START=3D0xc0000000
>  CONFIG_SYS_MEMTEST_END=3D0xc4000000
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
>  CONFIG_FIT=3Dy
>  CONFIG_SYS_BOOTM_LEN=3D0x2000000
>  CONFIG_DISTRO_DEFAULTS=3Dy
> @@ -53,6 +54,13 @@ CONFIG_SYS_MMC_ENV_DEV=3D-1
>  CONFIG_ENV_MMC_USE_DT=3Dy
>  CONFIG_CLK_SCMI=3Dy
>  CONFIG_SET_DFU_ALT_INFO=3Dy
> +CONFIG_USB_FUNCTION_FASTBOOT=3Dy
> +CONFIG_FASTBOOT_BUF_ADDR=3D0xc0000000
> +CONFIG_FASTBOOT_BUF_SIZE=3D0x02000000
> +CONFIG_FASTBOOT_FLASH=3Dy
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=3Dy
> +CONFIG_FASTBOOT_CMD_OEM_PARTCONF=3Dy
>  CONFIG_GPIO_HOG=3Dy
>  CONFIG_DM_I2C=3Dy
>  CONFIG_SYS_I2C_STM32F7=3Dy
> @@ -92,7 +100,6 @@ CONFIG_USB_GADGET_MANUFACTURER=3D"STMicroelectronics"
>  CONFIG_USB_GADGET_VENDOR_NUM=3D0x0483
>  CONFIG_USB_GADGET_PRODUCT_NUM=3D0x5720
>  CONFIG_USB_GADGET_DWC2_OTG=3Dy
> -CONFIG_USB_GADGET_DOWNLOAD=3Dy
>  CONFIG_ERRNO_STR=3Dy
>  # CONFIG_LMB_USE_MAX_REGIONS is not set
>  CONFIG_LMB_MEMORY_REGIONS=3D2
> --
> 2.25.1
>
Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
