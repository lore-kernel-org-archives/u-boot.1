Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72221CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 06:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9EA8404D;
	Wed, 27 May 2026 08:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="pG/KMyu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4030083FF5; Wed, 27 May 2026 08:10:17 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B905D8341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: b7065414599211f18dc8c9802ae25ab1-20260527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=KjBi3/N7By1JvzdNHDBvksVbyFuRpCRCAZawYfwLNhY=; 
 b=pG/KMyu4Q1tVKVg1+o+Qxo+d/q3OM3J+6jhvZnhqTewiNtDlU535PIwO9mz/D1Vx0PbyP245TSwIEQu/7WdLaNy2B5oPRPD7Xptdtfqx3d+RHca3vlTEHlJ8ajxfpL5ky/7iw/ilH9btLZ7yjxo4xyJh2XnRVyYeOAMTH4yPfaY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:264ba70f-f3ff-4a56-ade9-13712040d0f8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:fec18f8a-9d5c-4b53-90fd-3e53e898f373,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7065414599211f18dc8c9802ae25ab1-20260527
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1465364083; Wed, 27 May 2026 14:10:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 14:10:08 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 27 May 2026 14:10:06 +0800
Message-ID: <620e95ee4a8c8f960a0d43c2194e0d17803756dd.camel@mediatek.com>
Subject: Re: [PATCH 3/5] spi: mtk_snor: Use dev_read_addr_ptr()
From: Weijie Gao <weijie.gao@mediatek.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Aspeed BMC SW team
 <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>
CC: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, "=?ISO-8859-1?Q?C=E9dric?=
 Le Goater" <clg@kaod.org>, Ryan Chen <ryan_chen@aspeedtech.com>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, "Michal
 Simek" <michal.simek@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, Noah.Shen
 <noah.shen@mediatek.com>, Meiker Gao <ot_meiker.gao@mediatek.com>, Macpaul
 Lin <macpaul.lin@mediatek.com>, Stefano Babic <sbabic@nabladev.com>, Fabio
 Estevam <festevam@gmail.com>, "Ye Li" <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 May 2026 14:10:06 +0800
In-Reply-To: <20260527-devfdt-spi-v1-3-37db1f6c168a@nxp.com>
References: <20260527-devfdt-spi-v1-0-37db1f6c168a@nxp.com>
 <20260527-devfdt-spi-v1-3-37db1f6c168a@nxp.com>
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

On Wed, 2026-05-27 at 10:35 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr_ptr() which supports both live device tree and flat
> DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/spi/mtk_snor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/mtk_snor.c b/drivers/spi/mtk_snor.c
> index 40fc1826db6..a54eca8acda 100644
> --- a/drivers/spi/mtk_snor.c
> +++ b/drivers/spi/mtk_snor.c
> @@ -528,7 +528,7 @@ static int mtk_snor_probe(struct udevice *bus)
>  	u8 *buffer;
>  	int ret;
>  
> -	priv->base = devfdt_get_addr_ptr(bus);
> +	priv->base = dev_read_addr_ptr(bus);
>  	if (!priv->base)
>  		return -EINVAL;
>  
> 

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>


