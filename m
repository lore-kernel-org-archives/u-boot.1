Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D61FD19512
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 01:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A359683F2E;
	Tue, 27 Jan 2026 02:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Yw4eZhUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707183F36; Tue, 27 Jan 2026 02:15:48 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D800483BFE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ab92d1bcfb1d11f085319dbc3099e8fb-20260127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=iZAv0ELmyatSyIcgHY/Hm/vAPGNHpU8OC4wFc++CwKo=; 
 b=Yw4eZhUzHUuKK2fmBLx5/8jjwSzHdmXd5v/P4bYGB6r9rO/9HddBizpAVQtke8KX7l0pALdXPBv3JvCA/45ztmbcoLJK3zizTYos7lP4rMQn9nrC3ydxFbPBKJaUN5lqAn2GTgfEIJ0Vt2qWjIjQJd0o73JaKZtBqO7g0zv9khI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:82847c57-68f8-41d0-ac5e-3b4004eb358d, IP:0,
 U
 RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:2
X-CID-META: VersionHash:89c9d04, CLOUDID:d4e6965a-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
 ntent:4|15|50,EDM:-3,IP:nil,URL:80|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab92d1bcfb1d11f085319dbc3099e8fb-20260127
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1771420849; Tue, 27 Jan 2026 09:15:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 27 Jan 2026 09:15:28 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 27 Jan 2026 09:15:27 +0800
Message-ID: <9c465e76bb7cd33e5fa8c16b22d2159e04d49332.camel@mediatek.com>
Subject: Re: Question about Marvell CUX3410 support
From: Weijie Gao <weijie.gao@mediatek.com>
To: Beiyan Yun <root@infi.wang>, <u-boot@lists.denx.de>
CC: <ilias.apalodimas@linaro.org>, <jerome.forissier@linaro.org>,
 <joe.hershberger@ni.com>, <lucienzx159@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <paul.barker.ct@bp.renesas.com>,
 <rfried.dev@gmail.com>, <romain.gantois@bootlin.com>, <s-vadapalli@ti.com>,
 <trini@konsulko.com>
Date: Tue, 27 Jan 2026 09:15:27 +0800
In-Reply-To: <A2A08E1D-EF71-4C83-B2E1-9375B32257F2@infi.wang>
References: <A2A08E1D-EF71-4C83-B2E1-9375B32257F2@infi.wang>
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

On Fri, 2026-01-23 at 18:29 +0800, Beiyan Yun wrote:
> 
> Hi Weijie, and Aquantia maintainers:
> 
> I'm still working on porting U-Boot to Buffalo WXR18000BE10P. Despite
> my previous cleanup of the firmware loading code, the PHY still needs
> proper bringup.
> 
> I noticed a useful commit in MediaTek's U-Boot that adds support for
> this PHY (
> https://urldefense.com/v3/__https://github.com/mtk-openwrt/u-boot/commit/7a5cf8f2f6d043ed6c9105fac9851e16b82a9623__;!!CTRNKA9wMg0ARbw!g14NSZU8xzHk1TvLICsg9C31bFxhDWkMcpP4DhWpIikOYCp_ZaTLJykD-8KWhvk0ZeaRGATboQQ7391G$
>  ). Do you have plans to upstream this, or would you mind if I
> prepare a patch based on your work?

OK. I'll send this path today.


> 
> Thanks,
> Yun

