Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA72C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7581788356;
	Mon, 27 May 2024 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="kkqF4mjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C5E88221; Mon, 27 May 2024 09:51:43 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D2DF881E7
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 09:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anand@edgeble.ai
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57869599ed5so1751321a12.2
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1716796301; x=1717401101;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GHGUy2JevXhuqB4SmnSjeLXdWdWubLr9fAsYgTYTH0Y=;
 b=kkqF4mjGiYbaHsrPkNqB7EBnnteqgMJUUG+JvD1LLigsTBqks3pTCYVRT42oYRgHPJ
 PwWOwHbvHCrdJsfc1Vt57yFC5Mpfymc2diyx/FKyuwVPXhmBd2A6RFLADmF1OfyBf5kJ
 4hSBFkvzwu7Qu31CGd6s5bD+3VvibbuMvglSi8kG510CwCio44brQeTcfdrWsfLECMh2
 zvAR99XSgrqWcRGSW+vg7fo2VI9cTr39SbzAPSjg0iEB+WRydgYFL/ga3U6JVM80bq6L
 aqWrNKifmR41kpKY/73R8PbSl5RQVq4o0v0SQmSOj+INRhhW+x2aR+awuF81BnZ9znAL
 n4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716796301; x=1717401101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHGUy2JevXhuqB4SmnSjeLXdWdWubLr9fAsYgTYTH0Y=;
 b=lOrt0R8p613D9hgdmWWXcJcyN6YEM62GP7zWMLQet9CG05VO6lDrUoJIOXhA15iziC
 RSHHLHZ+YXCq5HjMD1xxI+sOjojcA//g7FKsG9PheadP2/88MGyDWXw5AzrVozCKma8J
 h1INPqytV9M5A4MJ/Kr0/yKXrOhYvT8cqKLf/w71AV9y+NBmXxJ++r+Nh6vsHOb3Defn
 NITIf3kJuA23qYjRZHCZv8BjTf9dHOc8waalEN14dJNtN+edScosZW6PKqdzVFj6SKRm
 a54tdbQbP4rGYWA0QfLz0umsCut23UNLNgChj3mta52l+9qcSIUR8O87HgN7fe1RSpge
 Yf6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDUZiJGGTKVEPgWxE635kkuJEN+tHFzdX0EPC6sBI3pLfnhLmvUpRJMR7S6ZUYnDg7PRyh5Nyq2mpGWXWw+532quqDFQ==
X-Gm-Message-State: AOJu0Yx1jF5UWrTI0NfNJijA12bqynW0vN4e5k2dQBPh/4oKH7BVwnvp
 GKmo4KW43V7+2IGsJI+m4Ymk11QTOKqH1X2JS/jkCrWQI+Gt3cvP866cR7XiPC38TC9MKwvfkq2
 EPpTa9K2atch9S0w+J+quHqJWUVATY6wkdyikOA==
X-Google-Smtp-Source: AGHT+IHICi4l6G2aBr/kMVkhHbXwAh3Rld06EFfF4Vi1rdWg0hnFwoTkjGaG3zkYpJeWwOjQ58/Ct21RZTD4gHM/qGY=
X-Received: by 2002:a50:9f2b:0:b0:578:57bd:3be0 with SMTP id
 4fb4d7f45d1cf-57857bd3c1bmr4921466a12.16.1716796300760; Mon, 27 May 2024
 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240527063915.6205-1-jagan@edgeble.ai>
 <20240527063915.6205-2-jagan@edgeble.ai>
In-Reply-To: <20240527063915.6205-2-jagan@edgeble.ai>
From: Anand Moon <anand@edgeble.ai>
Date: Mon, 27 May 2024 13:21:32 +0530
Message-ID: <CACF1qncXJnunQQ6QcgXj5Gi6yZ_u0z9FwJOsz4QmsK8YueBcDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rockchip: rk3588-edgeble: Add USB OTG support
To: Jagan Teki <jagan@edgeble.ai>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 27 May 2024 14:47:49 +0200
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

hi Jagan,

On Mon, 27 May 2024 at 12:09, Jagan Teki <jagan@edgeble.ai> wrote:
>
> Add support for USB OTG with UMS to program eMMC.
>
> Add it for Edgeble NCM6A, NCM6B.
>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Reviewed-by: Anand Moon <anand@edgeble.ai>


> ---
>  .../dts/rk3588-edgeble-neu6a-io-u-boot.dtsi    | 18 ++++++++++++++++++
>  .../dts/rk3588-edgeble-neu6b-io-u-boot.dtsi    | 18 ++++++++++++++++++
>  configs/neu6a-io-rk3588_defconfig              |  9 +++++++++
>  configs/neu6b-io-rk3588_defconfig              |  9 +++++++++
>  4 files changed, 54 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> index 88f3f7eee2..534d9f8a2c 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> @@ -15,3 +15,21 @@
>         bus-width = <4>;
>         status = "okay";
>  };
> +
> +&u2phy0 {
> +       status = "okay";
> +};
> +
> +&u2phy0_otg {
> +       status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +       status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +       dr_mode = "peripheral";
> +       maximum-speed = "high-speed";
> +       status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> index 289578803e..b3d17a60ce 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> @@ -15,3 +15,21 @@
>         bus-width = <4>;
>         status = "okay";
>  };
> +
> +&u2phy0 {
> +       status = "okay";
> +};
> +
> +&u2phy0_otg {
> +       status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +       status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +       dr_mode = "peripheral";
> +       maximum-speed = "high-speed";
> +       status = "okay";
> +};
> diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
> index ac281e6539..6e50d06458 100644
> --- a/configs/neu6a-io-rk3588_defconfig
> +++ b/configs/neu6a-io-rk3588_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
>  CONFIG_SPL_ATF=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  # CONFIG_SPL_DOS_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=y
> @@ -33,6 +34,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_MISC=y
> @@ -42,6 +44,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
> @@ -49,4 +53,9 @@ CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_ERRNO_STR=y
> diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
> index c01e5fb0d0..f2eb650f19 100644
> --- a/configs/neu6b-io-rk3588_defconfig
> +++ b/configs/neu6b-io-rk3588_defconfig
> @@ -24,6 +24,7 @@ CONFIG_SPL_PAD_TO=0x7f8000
>  CONFIG_SPL_ATF=y
>  CONFIG_CMD_GPT=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>  # CONFIG_CMD_SETEXPR is not set
>  # CONFIG_SPL_DOS_PARTITION is not set
>  CONFIG_SPL_OF_CONTROL=y
> @@ -33,6 +34,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
>  CONFIG_ROCKCHIP_GPIO=y
>  CONFIG_SYS_I2C_ROCKCHIP=y
>  CONFIG_MISC=y
> @@ -42,6 +44,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
>  CONFIG_SPL_PINCTRL=y
>  CONFIG_PWM_ROCKCHIP=y
>  CONFIG_SPL_RAM=y
> @@ -49,4 +53,9 @@ CONFIG_BAUDRATE=1500000
>  CONFIG_DEBUG_UART_SHIFT=2
>  CONFIG_SYS_NS16550_MEM32=y
>  CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_ERRNO_STR=y
> --
> 2.34.1
>
