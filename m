Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD5E93812
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 03:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8820C836AC;
	Mon, 13 Apr 2026 05:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="OfxwV1N0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91124839D5; Mon, 13 Apr 2026 05:45:48 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 332E08352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 3bbdac5436eb11f1ae70033691e9ac7d-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=3FvaJM6gf6lC4og0fsLemWIKc8F9kQYulNXRGBCuAYc=; 
 b=OfxwV1N0RXEl2ugQztIKedQRHAbG6FUaAtEbHYIi0tOipXI8SPDlBH1R66zc/lsJAXM9G7+hA3FOLAouFoIpqHRxpPbwX65FsAVD0KFjnJH2sAvZG/dKQ3plybIvMST6bnWxHCLO7ITDwtDtEXSQdGMxrTR3NUHDT3MhXTWfm0s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c1f161e3-481d-4472-a604-6c284dc4d7e3, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:9fa0c924-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3bbdac5436eb11f1ae70033691e9ac7d-20260413
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 757273510; Mon, 13 Apr 2026 11:45:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 11:45:36 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 11:45:35 +0800
Message-ID: <03aff8820f4ae0da6ae00955531beab818b7a942.camel@mediatek.com>
Subject: Re: [PATCH] mips: mtmips: align MT7621 image blobs to 8-byte boundary
From: Weijie Gao <weijie.gao@mediatek.com>
To: Shiji Yang <yangshiji66@outlook.com>, <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, "Daniel
 Schwierzeck" <daniel.schwierzeck@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Mon, 13 Apr 2026 11:45:35 +0800
In-Reply-To: <OS3PR01MB7802C722BA308D62F64EBD06BC272@OS3PR01MB7802.jpnprd01.prod.outlook.com>
References: <OS3PR01MB7802C722BA308D62F64EBD06BC272@OS3PR01MB7802.jpnprd01.prod.outlook.com>
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

Hi Shiji,

On Sun, 2026-04-12 at 20:12 +0800, Shiji Yang wrote:
> 
> MT7621 doesn't boot on u-boot v2026.04. Fix it by correcting the
> u-boot aligned offset.
> 
> Fixes: d9e183a04c92 ("MIPS: Assure end of U-Boot is at 8-byte aligned
> offset")
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/dts/mt7621-u-boot.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>

> 
> diff --git a/arch/mips/dts/mt7621-u-boot.dtsi b/arch/mips/dts/mt7621-
> u-boot.dtsi
> index fbac2ade25a..a6e585a0853 100644
> --- a/arch/mips/dts/mt7621-u-boot.dtsi
> +++ b/arch/mips/dts/mt7621-u-boot.dtsi
> @@ -47,13 +47,13 @@
> 
>  &binman {
>         u-boot-spl-ddr {
> -               align = <4>;
> -               align-size = <4>;
> +               align = <8>;
> +               align-size = <8>;
>                 filename = "u-boot-spl-ddr.bin";
>                 pad-byte = <0xff>;
> 
>                 u-boot-spl {
> -                       align-end = <4>;
> +                       align-end = <8>;
>                         filename = "u-boot-spl.bin";
>                 };
> 
> @@ -90,7 +90,7 @@
> 
>  #ifndef CONFIG_MT7621_BOOT_FROM_NAND
>                 u-boot-tpl {
> -                       align-end = <4>;
> +                       align-end = <8>;
>                         filename = "u-boot-tpl.bin";
>                 };
>  #endif
> --
> 2.53.0
> 

