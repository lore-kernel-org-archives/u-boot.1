Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EB1CAC5BB
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 01:25:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38AD83984;
	Thu,  9 Oct 2025 03:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="rzw2ritS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B10683987; Thu,  9 Oct 2025 03:25:12 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D81AD8394A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 03:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: c40b9104a4ae11f0b33aeb1e7f16c2b6-20251009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=ggpd8Z39ybk9LPDIEgEPE3p67WsuZsD1/kbRZUnwmfo=; 
 b=rzw2ritS8KFBgTMUkY23habZxw3AQx5UnSdRHZ/XNxR/gj/4zuk3+1vfh1PSC2NYzzL0wzFgPKYfWWqN/2ivTthzBaS1/t4JUMk4vEUEcNNdjNvN82bfj6JkiV+2JLtJdAe1cP98HMqCa0vXlCjblECJuKRBkcUGX9Si5KDKwT0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:14858e6e-8142-471c-ba3a-aa02b2c88a40, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:1ec73102-eaf8-4c8c-94de-0bc39887e077,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
 ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c40b9104a4ae11f0b33aeb1e7f16c2b6-20251009
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 337309546; Thu, 09 Oct 2025 09:24:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 9 Oct 2025 09:24:55 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 9 Oct 2025 09:24:53 +0800
Message-ID: <c004df0c9f556aaf530a14898c933c5c657d3510.camel@mediatek.com>
Subject: Re: [PATCH] ARM: dts: build DTs for MT7987 RFB
From: Weijie Gao <weijie.gao@mediatek.com>
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Greg Malysa <malysagreg@gmail.com>, "Oliver
 Gaskell" <Oliver.Gaskell@analog.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, "Michal
 Simek" <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, <u-boot@lists.denx.de>
Date: Thu, 9 Oct 2025 09:24:53 +0800
In-Reply-To: <a4d4096d6b80a2b6f5bc800426380cdc60d9b037.1759413509.git.daniel@makrotopia.org>
References: <a4d4096d6b80a2b6f5bc800426380cdc60d9b037.1759413509.git.daniel@makrotopia.org>
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

Hi Daniel,

On Thu, 2025-10-02 at 14:59 +0100, Daniel Golle wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Compile the added device tree sources into blobs, which was forgotten
> when adding the source files.
> 
> Fixes: 2d6962e0618 (arm: mediatek: add support for MediaTek MT7987
> SoC)
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  arch/arm/dts/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 7c8cf3a5a1d..a36967b916e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1131,6 +1131,9 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>         mt7986b-sd-rfb.dtb \
>         mt7986a-emmc-rfb.dtb \
>         mt7986b-emmc-rfb.dtb \
> +       mt7987a-emmc-rfb.dtb \
> +       mt7987a-rfb.dtb \
> +       mt7987a-sd-rfb.dtb \

I'd suggest to use

obj-$(CONFIG_TARGET_MT7987) = mt7987a-emmc-rfb.dtb \
	mt7987a-rfb.dtb \
	mt7987a-sd-rfb.dtb \

>         mt7988-rfb.dtb \
>         mt7988-sd-rfb.dtb \
>         mt8183-pumpkin.dtb \
> --
> 2.51.0
> 

