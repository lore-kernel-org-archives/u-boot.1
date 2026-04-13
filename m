Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068AFE9380E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 03:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70923836AC;
	Mon, 13 Apr 2026 05:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="qyr2RUK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AD8839D5; Mon, 13 Apr 2026 05:53:25 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F968352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 05:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4c2f335436ec11f19a16598d5ca7f8ec-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=/PUMBRL1GO80qg/vLE0iThP6WNAMo4LrhlUk2j5Za/c=; 
 b=qyr2RUK/1B6m5hVfBOd9NvHBc+iDw7jpyWgOkQN6SD04QUzYUD9cnADRKFx4NK3CJnw1bH0XSQwBqQunyS2TThybxKE8C4QIO0dgdAKVH2FgoWpQnMQYrcsUH/TFdsRtjfTw21P9CTf4Fz46Ai/78YksBEhtR/xhEYurR2e+J78=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:28bfe558-4bd4-49fe-a2bb-5340418bdb65, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:46dd588f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4c2f335436ec11f19a16598d5ca7f8ec-20260413
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1942705960; Mon, 13 Apr 2026 11:53:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 11:53:13 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 11:53:12 +0800
Message-ID: <f2e47f5ce68168f71492e7bfa207f00ca13cf026.camel@mediatek.com>
Subject: Re: [PATCH] common: spl: spl_nand: make CONFIG_SYS_NAND_U_BOOT_OFFS
 optional in spl_nand_get_uboot_raw_page()
From: Weijie Gao <weijie.gao@mediatek.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>
Date: Mon, 13 Apr 2026 11:53:12 +0800
In-Reply-To: <20260410144457.GU41863@bill-the-cat>
References: <20260410084933.103186-1-weijie.gao@mediatek.com>
 <20260410144457.GU41863@bill-the-cat>
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

Hi Tom,

On Fri, 2026-04-10 at 08:44 -0600, Tom Rini wrote:
> On Fri, Apr 10, 2026 at 04:49:33PM +0800, Weijie Gao wrote:
> 
> > As spl_nand_get_uboot_raw_page() is a weak function, when a board
> > wants to
> > override it, the CONFIG_SYS_NAND_U_BOOT_OFFS becomes meaningless
> > within
> > this function.
> > 
> > This patch allows spl_nand_get_uboot_raw_page() being compiled
> > without
> > CONFIG_SYS_NAND_U_BOOT_OFFS being defined.
> > 
> > Note: this is available only when both CONFIG_SPL_NAND_RAW_ONLY and
> > CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND are not defined.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> >  common/spl/spl_nand.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> I think the bug here is that when SYS_NAND_U_BOOT_LOCATIONS isn't
> defined, we should still be able to override
> spl_nand_get_uboot_raw_page
> (with an implementation that does not use
> CONFIG_SYS_NAND_U_BOOT_OFFS).
> Can you please re-examine the code with that in mind? Thanks!
> 

So I come up with the following idea:
1. With my current path, replace all reference to
   CONFIG_SYS_NAND_U_BOOT_OFFS with spl_nand_get_uboot_raw_page()
2. Add a new weak function, spl_nand_get_uboot_raw_page_redund(), to
   wrap the CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND macro, and do the same
   modification as spl_nand_get_uboot_raw_page() do.

I'll send new patch later

Weijie


