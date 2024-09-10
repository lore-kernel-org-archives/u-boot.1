Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27F1ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF61889098;
	Tue, 10 Sep 2024 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LxlabYNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027918906B; Tue, 10 Sep 2024 15:21:34 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A7A89098
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-374c1963cb6so3464370f8f.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725974486; x=1726579286;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=D0Q60/qA2SDlj56RcJWIeuLMd9nDno5bdnuxCFM7uTM=;
 b=LxlabYNGuQaa+jaOaHJFHOoSBWXxSiLEqvtSjy2w8UR0SCZMbn2bGEVe3/gZedCFPs
 NK2dcn3RrUJpY3brsDRcBg+fZxkXKWYHHkBDBjQNVKP3IAL4rIyRMsdvmKZhYSGZ+S3G
 rK4XXOp0bjgaQDM1uMZjn0TX/DiEB4Bu1k1z/CNdHZgtC+Ig7+byNTaKZnXz57YEHOtm
 s4qie6nNRd4vgifObdYGdy2b5gOCWjbejqPYaYPBZsIaPBcslEeXSuu9LQtMuLqU/HwT
 qM5m2fLl5nvXTUDYBohiz6dURG4Woh9YrCdOVLOv1ZlIf8I7odSd843bFy7yAHe66Slj
 YXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725974486; x=1726579286;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0Q60/qA2SDlj56RcJWIeuLMd9nDno5bdnuxCFM7uTM=;
 b=MRrrQ1Trsm5ILBP3OFy+mBKP+uDNav7uDz08ZEbL85zRAmqhrH2ZI21SJc+8NKYHG5
 G7iggfUxVnUUJ5jookStvY6UXw+tPzuFNsV19Rlizw/3/z/sgHO5RzaCNAB66LxQk056
 lRwJIrIRtADGz75vVnOpKAVN5y++EzbS/TQrV/xztE8r5SbLj0EO3yNXVSuTRLc+jnM+
 04t+CURCGJMH1SZ3uvkkZ2KSx4clPpWSObmOtxafXu/gsdZLmmOyFF7YXrOVHs2Xo/Vc
 X/AoJgohdcdbhJgC8VYNnajv9SxSiueDSMYn+FNiyJAbcoGCjGO2oKaRdkqBndJ1eA9v
 O0kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDF2uE5+kODM+rcgw1Cb0RkrdZdXS/LRGEPNhIvHJPvA313ANJXt+q72JgpXJyv9/vRpapFY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdq9X38eU966Bxb85fFvF3AbTiHTFrYU7osH/+KuM4GMsmGCC0
 PDaiw8IolgYg2yGmtMrThvF2j6G+JVYYlHTQKX9y4qH/rhDwJ2BqGPLAaVZ4xeo=
X-Google-Smtp-Source: AGHT+IHQee9aYzFR/TtL0xmLmUf/QYzFXXjgj9EBfEzR7IKLtIDBLGwZZuJ62SfY+LSKQMBSVWs9sg==
X-Received: by 2002:adf:f30a:0:b0:377:27f1:d54f with SMTP id
 ffacd0b85a97d-3788967e268mr10737973f8f.45.1725974485381; 
 Tue, 10 Sep 2024 06:21:25 -0700 (PDT)
Received: from localhost (amarseille-656-1-38-54.w83-113.abo.wanadoo.fr.
 [83.113.113.54]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649b93sm8922199f8f.3.2024.09.10.06.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 06:21:24 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Jonas
 Karlman <jonas@kwiboo.se>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] dfu: fix Kconfig dependencies
In-Reply-To: <20240910102751.3182982-1-jerome.forissier@linaro.org>
References: <20240910102751.3182982-1-jerome.forissier@linaro.org>
Date: Tue, 10 Sep 2024 15:19:07 +0200
Message-ID: <875xr363zo.fsf@baylibre.com>
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

Hi Jerome,

Thank you for the patch.

On mar., sept. 10, 2024 at 12:27, Jerome Forissier <jerome.forissier@linaro.org> wrote:

> Fix link errors caused by missing Kconfig dependencies:
>
> 1. DFU_OVER_USB compiles common/dfu.c which calls g_dnl_clear_detach()
> which is implemented in drivers/usb/gadget/g_dnl.c which needs
> USB_GADGET_DOWNLOAD. Test case:
>
>  $ printf "CONFIG_USB_GADGET_DOWNLOAD=n\nCONFIG_USB_FUNCTION_FASTBOOT=n" \
>        >>configs/am62px_evm_a53_defconfig
>  $ make am62px_evm_a53_defconfig
>  $ make CROSS_COMPILE=aarch64-linux-gnu-
>  [...]
>  common/dfu.c:34:(.text.run_usb_dnl_gadget+0x68): undefined reference to `g_dnl_clear_detach
>  [...]
>
> 2. With the above fixed, the same build causes:
>
>  common/spl/spl_dfu.c:29:(.text.spl_dfu_cmd+0xb0): undefined reference to `run_usb_dnl_gadget'
>
> This is because SPL_DFU compiles common/spl/spl_dfu.c which calls
> run_usb_dnl_gadget() which is implemented in common/dfu.c which needs
> DFU_OVER_USB.
>
> Therefore add these dependencies to Kconfig.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/dfu/Kconfig        | 2 +-
>  drivers/usb/gadget/Kconfig | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index d034b501360..604386bb734 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -7,7 +7,7 @@ config DFU
>  config DFU_OVER_USB
>  	bool
>  	select HASH
> -	depends on USB_GADGET
> +	depends on USB_GADGET_DOWNLOAD
>  
>  config DFU_OVER_TFTP
>  	bool
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 03fe3bca197..9921d3e0a77 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -323,6 +323,7 @@ config SPL_DFU
>  	bool "Support DFU (Device Firmware Upgrade) in SPL"
>  	select SPL_HASH
>  	select SPL_DFU_NO_RESET
> +	depends on DFU_OVER_USB
>  	depends on SPL_RAM_SUPPORT
>  	help
>  	  This feature enables the DFU (Device Firmware Upgrade) in SPL with
> -- 
> 2.40.1
