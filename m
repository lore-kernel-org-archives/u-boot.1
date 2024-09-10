Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1CDECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7C389060;
	Tue, 10 Sep 2024 15:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MGZa8HzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2270688FFB; Tue, 10 Sep 2024 15:55:54 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8494789088
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so3720415a12.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725976548; x=1726581348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/kxL8XbYzvK2Oq0YDGlbgBPQRUdBHqqXFHbPGGYu2ac=;
 b=MGZa8HzE80Zq8dNmC4SzRAgUTudyY6Ui9dTws3CK9LqYpNllqJrX7fEaFdbpXKKDEE
 TS56lHr+FyhpDu5oWZgVSyV84FhLXOe7FvRUCv2gzwlqWz0Ho6c8H2GeNCNq9qnVt5jG
 J0F+255rJcEt6GMyAi897Mwo5FH1ziN9Xxsj/SAhUDc56Bahjzg3dpYG+kOrqxLikpoq
 kmH6eakhYf1kyb9ioXssTOllJTzCQG8rNQxZvDmyGURFSr9j25fgAEisxcvPef8HYDGu
 K2B+nR24trEuxUrCsvIFIm5GX+9QD83SGxCcxcZJznPVDS4xhKIwrwlJpBXWMzMdRNsO
 vLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725976548; x=1726581348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/kxL8XbYzvK2Oq0YDGlbgBPQRUdBHqqXFHbPGGYu2ac=;
 b=bulWfR7L5cjNHbWgEcpCOdA8XyB9OWiVN+3y2JlstAxqM+BL8KV1X/3bXMCi916JJ7
 KLbZJ1IcnY4Cnjb1MDMUAF04iX5CfymJPAc3KjxaPIQRTqDwutiqK71WnokvBEIeAcNX
 iulguU6qDPgkWf3ezS73pkzQbSN8U3NAPfIyFvo7kcoXNFDIertYP7dPUs5IdSp04xFB
 /fJY7M52sDw19APs0KKwCa7ASYfQGhORIdRuk0L4+k0DsM8DLiAzsB37CD7jdejHIkyz
 jWDPRn3TwKvX1h/ZKHVbH7xpN71AIPFYuThrhlwa27cGMECd4ljY4qeqVmzlBca1sfg7
 yBBg==
X-Gm-Message-State: AOJu0Yyeoe4PlyW8vHCs8TL6wd2dn0Pjh2k64KS9VZC8eF5HJKMAngpJ
 Q46srUjG8YG0JDklijNhbDqmSBBSnxx9D4ZsAl/qyMh6wr3qJcUBYfDZZ85mYXNr9I2rs3na7vm
 ee0VVPNPpE5vXgn8uRojkbEADBZK57E3zdKWn5g==
X-Google-Smtp-Source: AGHT+IHHq0fCqeGIB/yNI6WamKU/OxbBf+qZZdV9NoReLRTasyrl3XQk4F+rqD4Zc25ssYZYW9vwnj2JhqCxMkHFYuM=
X-Received: by 2002:a05:6a21:31c7:b0:1cc:d73a:93f1 with SMTP id
 adf61e73a8af0-1cf5e1768e0mr988455637.42.1725976547608; Tue, 10 Sep 2024
 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240910102751.3182982-1-jerome.forissier@linaro.org>
In-Reply-To: <20240910102751.3182982-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Sep 2024 16:55:11 +0300
Message-ID: <CAC_iWjJ=zh6n-w9tG+vpMAuN2Pj8WcVtM7SzobOMVQB+LcUfFw@mail.gmail.com>
Subject: Re: [PATCH] dfu: fix Kconfig dependencies
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
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

On Tue, 10 Sept 2024 at 13:28, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
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
>         bool
>         select HASH
> -       depends on USB_GADGET
> +       depends on USB_GADGET_DOWNLOAD
>
>  config DFU_OVER_TFTP
>         bool
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 03fe3bca197..9921d3e0a77 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -323,6 +323,7 @@ config SPL_DFU
>         bool "Support DFU (Device Firmware Upgrade) in SPL"
>         select SPL_HASH
>         select SPL_DFU_NO_RESET
> +       depends on DFU_OVER_USB
>         depends on SPL_RAM_SUPPORT
>         help
>           This feature enables the DFU (Device Firmware Upgrade) in SPL with
> --
> 2.40.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
