Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A998AFA0C42
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 07:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1762183936;
	Wed, 15 Apr 2026 09:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bTa8lB06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7428883B99; Wed, 15 Apr 2026 09:41:23 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AFE8838BB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sam.shih@mediatek.com
X-UUID: 7ae771ee389e11f1ae70033691e9ac7d-20260415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=mvtieHGnN+R5zk0SAjts2jabKuObS/oY5qWkyhj0xRE=; 
 b=bTa8lB06qjEdxKtEmO3X94BJtRwpAPYVl4qF4id0TRGPhKUkcWBxlQKxk4xka+gp4BgnAkgRwXyRjwY3eFx94vlhT2GsBbXnn5sRwTy0Xj086+eWrcbrQOY/hnQC3S6CJcJ+Cu7elzUdPoGT+hnQxCOPdwmVOnXDUBLaO2CJlNs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8c167a5b-7ea1-4b55-ac55-71f350417070, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:3e4f728f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7ae771ee389e11f1ae70033691e9ac7d-20260415
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <sam.shih@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 559947997; Wed, 15 Apr 2026 15:41:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Apr 2026 15:41:13 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Wed, 15 Apr 2026 15:41:13 +0800
Received: by mediatek.com (Postfix, from userid 10015778)
 id 05BF9200C6; Wed, 15 Apr 2026 15:41:13 +0800 (CST)
Message-ID: <b41c8e2b29ca8286d487260f984ca21f3f2ae588.camel@mediatek.com>
Subject: Re: [PATCH 1/2] clk: mediatek: remove redundant forward declarations
From: sam.shih <sam.shih@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, Weijie Gao
 <weijie.gao@mediatek.com>, <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>
Date: Wed, 15 Apr 2026 15:41:12 +0800
In-Reply-To: <5176855c-6d04-4361-8d94-ac82ffc2c4e7@baylibre.com>
References: <fc7c50ebff2932b5f0a237c3fc492aefba3a0292.1775786729.git.weijie.gao@mediatek.com>
 <5176855c-6d04-4361-8d94-ac82ffc2c4e7@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: git-send-email 2.45.1
MIME-Version: 1.0
X-Mailer: git-send-email 2.45.1
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

Hi David,
=20
Thanks for the review and the suggestions.
=20
We will rework this series as three patches with a cover letter.
=20
1/3: Remove the redundant forward declarations and drop the Fixes: tag
from this change.
=20
2/3: Adjust the code formatting and declarations so that the functional
fix in patch 3/3 applies cleanly and passes checkpatch.pl.
=20
3/3: Add the actual functional fix for the parent rate lookup.


On Fri, 2026-04-10 at 11:07 -0500, David Lechner wrote:
> On 4/9/26 9:12 PM, Weijie Gao wrote:
> > From: Sam Shih <sam.shih@mediatek.com>
> >=20
> > The clk_ops structures (mtk_clk_apmixedsys_ops,
> > mtk_clk_topckgen_ops,
> > mtk_clk_infrasys_ops) are already declared with extern in clk-
> > mtk.h,
> > which is included by this file. The forward declarations in clk-
> > mtk.c
> > are therefore redundant and can be removed.
> >=20
>=20
> > Fixes: 00d0ff7f81bf ("clk: mediatek: refactor parent rate lookup
> > functions")
>=20
> Since this is just redundant and didn't actually break anything, the
> Fixes: tag is not appropriate. We can remove it.
>=20
>=20
> It is also helpful to include a cover letter when sending multiple
> patches.


Best regards,
Sam
