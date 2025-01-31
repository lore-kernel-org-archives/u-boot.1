Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD2AC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E26D80F47;
	Fri, 31 Jan 2025 07:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Z7TqdYEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA4EC80F5F; Fri, 31 Jan 2025 07:50:06 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85BD380F42
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 95fb556cdf9f11ef99858b75a2457dd9-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=crNeCLNYmpg+xfeLSBgWOrYwySw65ByjAdoI4AUOF/k=; 
 b=Z7TqdYEpcXowuLalMzdtVOmmMGhu0yZEOFw/oqFBBZMuybTXbB8+pNF8qWPbcoZFU9QahMzFko/3DkP2uLFHoIe5/tzNwrunOdUasPymoxLu1uyOendtpyEyQjCj35fO5OkyHS4n3cwvZh0jNKbcP0J4Qtx/si4NHBmsDu22GSU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:252f91a9-98fc-443b-a52b-95d37726c716, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:f95af5fe-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 95fb556cdf9f11ef99858b75a2457dd9-20250131
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 461234268; Fri, 31 Jan 2025 14:49:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:49:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:49:55 +0800
Message-ID: <58e88319a4c482933db01b7663f1c849ae9279cc.camel@mediatek.com>
Subject: Re: [PATCH 3/8] mediatek: mt7986: move gpio-controller up and
 rename pinctrl to pio
From: Weijie Gao <weijie.gao@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, SkyLake.Huang <skylake.huang@mediatek.com>, John
 Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 <u-boot@lists.denx.de>
Date: Fri, 31 Jan 2025 14:49:55 +0800
In-Reply-To: <20250127134046.26345-4-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
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

On Mon, 2025-01-27 at 14:40 +0100, Christian Marangi wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Move gpio-controller up to pinctrl node and rename label to "pio" to
> match the label used in upstream kernel linux.
> 
> Update any DTS that reference the pinctrl to follow the new naming
> and
> structure.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/dts/mt7986.dtsi           |  8 +++-----
>  arch/arm/dts/mt7986a-bpi-r3-sd.dts | 12 ++++++------
>  arch/arm/dts/mt7986a-rfb.dts       |  4 ++--
>  arch/arm/dts/mt7986a-sd-rfb.dts    |  4 ++--
>  arch/arm/dts/mt7986b-rfb.dts       |  4 ++--
>  arch/arm/dts/mt7986b-sd-rfb.dts    |  4 ++--
>  6 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
> index 64ce45a6530..b2c57098a5e 100644
> --- a/arch/arm/dts/mt7986.dtsi
> +++ b/arch/arm/dts/mt7986.dtsi
> @@ -122,7 +122,7 @@
>                 #clock-cells = <1>;
>         };
> 
> -       pinctrl: pinctrl@1001f000 {
> +       pio: pinctrl@1001f000 {
>                 compatible = "mediatek,mt7986-pinctrl";
>                 reg = <0x1001f000 0x1000>,
>                       <0x11c30000 0x1000>,
> @@ -135,10 +135,8 @@
>                 reg-names = "gpio", "iocfg_rt", "iocfg_rb",
>                             "iocfg_lt", "iocfg_lb", "iocfg_tr",
>                             "iocfg_tl", "eint";
> -               gpio: gpio-controller {
> -                       gpio-controller;
> -                       #gpio-cells = <2>;
> -               };
> +               gpio-controller;
> +               #gpio-cells = <2>;
>         };
> 
>         pwm: pwm@10048000 {
> diff --git a/arch/arm/dts/mt7986a-bpi-r3-sd.dts
> b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
> index c156a813634..e01ae4c3dc7 100644
> --- a/arch/arm/dts/mt7986a-bpi-r3-sd.dts
> +++ b/arch/arm/dts/mt7986a-bpi-r3-sd.dts
> @@ -38,12 +38,12 @@
> 
>                 factory {
>                         label = "reset";
> -                       gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
> +                       gpios = <&pio 9 GPIO_ACTIVE_LOW>;
>                 };
> 
>                 wps {
>                         label = "wps";
> -                       gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +                       gpios = <&pio 10 GPIO_ACTIVE_LOW>;
>                 };
>         };
> 
> @@ -52,12 +52,12 @@
> 
>                 led_status_green: green {
>                         label = "green:status";
> -                       gpios = <&gpio 69 GPIO_ACTIVE_HIGH>;
> +                       gpios = <&pio 69 GPIO_ACTIVE_HIGH>;
>                 };
> 
>                 led_status_blue: blue {
>                         label = "blue:status";
> -                       gpios = <&gpio 86 GPIO_ACTIVE_HIGH>;
> +                       gpios = <&pio 86 GPIO_ACTIVE_HIGH>;
>                 };
>         };
> 
> @@ -78,7 +78,7 @@
>         mediatek,gmac-id = <0>;
>         phy-mode = "2500base-x";
>         mediatek,switch = "mt7531";
> -       reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +       reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> 
>         fixed-link {
>                 speed = <2500>;
> @@ -86,7 +86,7 @@
>         };
>  };
> 
> -&pinctrl {
> +&pio {
>         spic_pins: spi1-pins-func-1 {
>                 mux {
>                         function = "spi";
> diff --git a/arch/arm/dts/mt7986a-rfb.dts b/arch/arm/dts/mt7986a-
> rfb.dts
> index 67d14a99dae..d4bbb23204a 100644
> --- a/arch/arm/dts/mt7986a-rfb.dts
> +++ b/arch/arm/dts/mt7986a-rfb.dts
> @@ -57,7 +57,7 @@
>         mediatek,gmac-id = <0>;
>         phy-mode = "2500base-x";
>         mediatek,switch = "mt7531";
> -       reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +       reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> 
>         fixed-link {
>                 speed = <2500>;
> @@ -65,7 +65,7 @@
>         };
>  };
> 
> -&pinctrl {
> +&pio {
>         spi_flash_pins: spi0-pins-func-1 {
>                 mux {
>                         function = "flash";
> diff --git a/arch/arm/dts/mt7986a-sd-rfb.dts b/arch/arm/dts/mt7986a-
> sd-rfb.dts
> index 4f8fa70ec99..11823e05bda 100644
> --- a/arch/arm/dts/mt7986a-sd-rfb.dts
> +++ b/arch/arm/dts/mt7986a-sd-rfb.dts
> @@ -49,7 +49,7 @@
>         mediatek,gmac-id = <0>;
>         phy-mode = "2500base-x";
>         mediatek,switch = "mt7531";
> -       reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +       reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> 
>         fixed-link {
>                 speed = <2500>;
> @@ -57,7 +57,7 @@
>         };
>  };
> 
> -&pinctrl {
> +&pio {
>         spi_flash_pins: spi0-pins-func-1 {
>                 mux {
>                         function = "flash";
> diff --git a/arch/arm/dts/mt7986b-rfb.dts b/arch/arm/dts/mt7986b-
> rfb.dts
> index f98b04ab140..0a731fe87fd 100644
> --- a/arch/arm/dts/mt7986b-rfb.dts
> +++ b/arch/arm/dts/mt7986b-rfb.dts
> @@ -48,7 +48,7 @@
>         mediatek,gmac-id = <0>;
>         phy-mode = "2500base-x";
>         mediatek,switch = "mt7531";
> -       reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +       reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> 
>         fixed-link {
>                 speed = <2500>;
> @@ -56,7 +56,7 @@
>         };
>  };
> 
> -&pinctrl {
> +&pio {
>         spi_flash_pins: spi0-pins-func-1 {
>                 mux {
>                         function = "flash";
> diff --git a/arch/arm/dts/mt7986b-sd-rfb.dts b/arch/arm/dts/mt7986b-
> sd-rfb.dts
> index ec80a2fb710..e5fb4d73e70 100644
> --- a/arch/arm/dts/mt7986b-sd-rfb.dts
> +++ b/arch/arm/dts/mt7986b-sd-rfb.dts
> @@ -49,7 +49,7 @@
>         mediatek,gmac-id = <0>;
>         phy-mode = "2500base-x";
>         mediatek,switch = "mt7531";
> -       reset-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
> +       reset-gpios = <&pio 5 GPIO_ACTIVE_HIGH>;
> 
>         fixed-link {
>                 speed = <2500>;
> @@ -57,7 +57,7 @@
>         };
>  };
> 
> -&pinctrl {
> +&pio {
>         spi_flash_pins: spi0-pins-func-1 {
>                 mux {
>                         function = "flash";
> --
> 2.47.1
> 

Thanks!

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
Tested-by: Weijie Gao <weijie.gao@mediatek.com>

