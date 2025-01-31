Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF72C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCD6807E4;
	Fri, 31 Jan 2025 07:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="AoK26PMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A014B807EE; Fri, 31 Jan 2025 07:51:21 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48431801FD
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c2bf94f0df9f11efbd192953cf12861f-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=PAMPQdcQ/CjqFylI5qfzyUoaSmDjIyRUsatsQOC5qfo=; 
 b=AoK26PMjlAWe3wlGrCX/dKEgmMCh519hbkebHNuFil/QZCJ2o3cSyslNEcGLQub2yEVoblaBNvkGaJ7hk7Nsyg/kSZLQ4PduoBk1lOMBVJdUrBYr44rSL18H5dAV4YLH0hU2dhPaUzo32Qv9MolNVDnwt1HsLOE8dDeFiSfuHTU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:978d098d-2b8f-4074-85fd-eca52ec2c233, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:eb5cf5fe-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c2bf94f0df9f11efbd192953cf12861f-20250131
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1061529069; Fri, 31 Jan 2025 14:51:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:51:11 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:51:11 +0800
Message-ID: <6b09c421f0618c2f3bf517671c70580c690ab240.camel@mediatek.com>
Subject: Re: [PATCH 7/8] arm: dts: mediatek: add USB nodes for MT7981
From: Weijie Gao <weijie.gao@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, SkyLake.Huang <skylake.huang@mediatek.com>, John
 Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 <u-boot@lists.denx.de>
Date: Fri, 31 Jan 2025 14:51:10 +0800
In-Reply-To: <20250127134046.26345-8-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-8-ansuelsmth@gmail.com>
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
> From: John Crispin <john@phrozen.org>
> 
> Add USB PHY nodes for MT7981. These are needed for USB support and
> also
> for PCIe support as the u3 PHY can also be used for PHY.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/dts/mt7981.dtsi | 48
> ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
> index b2c4cd7b54a..2360c6bbdca 100644
> --- a/arch/arm/dts/mt7981.dtsi
> +++ b/arch/arm/dts/mt7981.dtsi
> @@ -6,6 +6,7 @@
> 
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/clock/mt7981-clk.h>
>  #include <dt-bindings/reset/mt7629-reset.h>
>  #include <dt-bindings/pinctrl/mt65xx.h>
> @@ -315,4 +316,51 @@
>                 status = "disabled";
>         };
> 
> +       xhci: xhci@11200000 {
> +               compatible = "mediatek,mt7981-xhci",
> +                            "mediatek,mtk-xhci";
> +               reg = <0x11200000 0x2e00>,
> +                     <0x11203e00 0x0100>;
> +               reg-names = "mac", "ippc";
> +               interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> +               phys = <&u2port0 PHY_TYPE_USB2>,
> +                      <&u3port0 PHY_TYPE_USB3>;
> +               clocks = <&infracfg CLK_INFRA_IUSB_SYS_CK>,
> +                        <&infracfg CLK_INFRA_IUSB_CK>,
> +                        <&infracfg CLK_INFRA_IUSB_133_CK>,
> +                        <&infracfg CLK_INFRA_IUSB_66M_CK>,
> +                        <&topckgen CLK_TOP_U2U3_XHCI_SEL>;
> +               clock-names = "sys_ck",
> +                             "ref_ck",
> +                             "mcu_ck",
> +                             "dma_ck",
> +                             "xhci_ck";
> +               mediatek,u3p-dis-msk = <0x1>;
> +               status = "okay";
> +       };
> +
> +       usbtphy: usb-phy@11e10000 {
> +               compatible = "mediatek,mt7981",
> +                            "mediatek,generic-tphy-v2";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               status = "okay";
> +
> +               u2port0: usb-phy@11e10000 {
> +                       reg = <0x11e10000 0x700>;
> +                       clocks = <&topckgen CLK_TOP_USB_FRMCNT_SEL>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       status = "okay";
> +               };
> +
> +               u3port0: usb-phy@11e10700 {
> +                       reg = <0x11e10700 0x900>;
> +                       clocks = <&topckgen CLK_TOP_USB3_PHY_SEL>;
> +                       clock-names = "ref";
> +                       #phy-cells = <1>;
> +                       mediatek,syscon-type = <&topmisc 0x218 0>;
> +                       status = "okay";
> +               };
> +       };
>  };
> --
> 2.47.1
> 

Thanks!

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
Tested-by: Weijie Gao <weijie.gao@mediatek.com>

