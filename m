Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284ACC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C2E80F64;
	Fri, 31 Jan 2025 07:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lMIzxsNS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35BE80F77; Fri, 31 Jan 2025 07:51:36 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AC3801FD
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: cbd212b6df9f11efbd192953cf12861f-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=vLF3XOaHiJP531t1vK93N0ESigkHCcW+AOSmq2RlFTk=; 
 b=lMIzxsNSS3yZma4HgoMrJMLHTcV3y36v1DOWe4YKhH+k/s+BJvn1CMaZGpKryQH9sC1+XSa+p5fhtcjaaC8/2La8G2RdIDGGk6YE1pLmDwvy3Khsuc6A9aPqxm/CJisaX5bw22e3ksZtfUCordS7tM9Lc/VtAoRzXkWJAiGgs3U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:60f4f1e5-322b-470e-8970-adc6b1dd043e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:e71ce17e-427a-4311-9df4-bfaeeacd8532,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cbd212b6df9f11efbd192953cf12861f-20250131
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1442143147; Fri, 31 Jan 2025 14:51:28 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:51:27 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:51:26 +0800
Message-ID: <1fd55de162f88d9ed991692c9bd725fed2287b7c.camel@mediatek.com>
Subject: Re: [PATCH 8/8] arm: dts: mediatek: add PCIe node for MT7981
From: Weijie Gao <weijie.gao@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, SkyLake.Huang <skylake.huang@mediatek.com>, John
 Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 <u-boot@lists.denx.de>
Date: Fri, 31 Jan 2025 14:51:26 +0800
In-Reply-To: <20250127134046.26345-9-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-9-ansuelsmth@gmail.com>
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
> Add PCIe node for MT7981 with all the required properties to make
> PCIe
> work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/dts/mt7981.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
> index 2360c6bbdca..5b4cadc22f7 100644
> --- a/arch/arm/dts/mt7981.dtsi
> +++ b/arch/arm/dts/mt7981.dtsi
> @@ -339,6 +339,41 @@
>                 status = "okay";
>         };
> 
> +       pcie: pcie@11280000 {
> +               compatible = "mediatek,mt8192-pcie";
> +               device_type = "pci";
> +               reg = <0x11280000 0x4000>;
> +               reg-names = "pcie-mac";
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&infracfg CLK_INFRA_IPCIE_CK>,
> +                               <&infracfg CLK_INFRA_IPCIE_PIPE_CK>,
> +                               <&infracfg CLK_INFRA_IPCIER_CK>,
> +                               <&infracfg CLK_INFRA_IPCIEB_CK>;
> +               clock-names = "pl_250m", "tl_26m", "peri_26m",
> "top_133m";
> +               phys = <&u3port0 PHY_TYPE_PCIE>;
> +               phy-names = "pcie-phy";
> +               bus-range = <0x00 0xff>;
> +               ranges = <0x82000000 0 0x20000000 0x20000000 0
> 0x10000000>;
> +
> +               #interrupt-cells = <1>;
> +
> +               interrupt-map-mask = <0 0 0 7>;
> +               interrupt-map = <0 0 0 1 &pcie_intc 0>,
> +                       <0 0 0 2 &pcie_intc 1>,
> +                       <0 0 0 3 &pcie_intc 2>,
> +                       <0 0 0 4 &pcie_intc 3>;
> +
> +               status = "disabled";
> +
> +               pcie_intc: interrupt-controller {
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +                       #address-cells = <0>;
> +               };
> +       };
> +
>         usbtphy: usb-phy@11e10000 {
>                 compatible = "mediatek,mt7981",
>                              "mediatek,generic-tphy-v2";
> --
> 2.47.1
> 

Thanks!

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
Tested-by: Weijie Gao <weijie.gao@mediatek.com>

