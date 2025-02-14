Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D40C021A0
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 00:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF09E80F91;
	Fri, 14 Feb 2025 01:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Cl9iBGRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05ED980F92; Fri, 14 Feb 2025 01:57:37 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F5480F7A
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 01:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a73d2c2cea6e11efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=us5QlsUNc5WUhI+00iA+K9wCfBDquB7PgKhq4oqaQvk=; 
 b=Cl9iBGRcTuy48EpvAQg6nxfkMKOqe3+2T1XoZn4S1m3JRJ9azP/W+QQJOejGedHC3lJGtR8h8808ATbKkKvvaj3eJNWq7ggzAobIKGhw0J4FLV0IP/B30ifWR0iNsYdfKwdMf9OhHfNyrdlPYvJQjAwZAT5OfWOM+MFDvhnP04o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:d5517ece-47c2-4f70-9ff3-43713780bfb8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:05b470a1-97df-4c26-9c83-d31de0c9db26,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a73d2c2cea6e11efb8f9918b5fc74e19-20250214
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 609210021; Fri, 14 Feb 2025 08:57:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 08:57:24 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 08:57:23 +0800
Message-ID: <2203e93975f99357616caa6a20f2e62c21ad575c.camel@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: compile dts files only for matched target
From: Weijie Gao <weijie.gao@mediatek.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>
Date: Fri, 14 Feb 2025 08:57:23 +0800
In-Reply-To: <20250213155919.GV1233568@bill-the-cat>
References: <20250213090054.83932-1-weijie.gao@mediatek.com>
 <20250213155919.GV1233568@bill-the-cat>
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

On Thu, 2025-02-13 at 09:59 -0600, Tom Rini wrote:
> On Thu, Feb 13, 2025 at 05:00:54PM +0800, Weijie Gao wrote:
> 
> > Currently nearly all dts files for MediaTek targets will be
> > compiled at once. Split them for each target.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> >  arch/arm/dts/Makefile | 34 +++++++++++++++++++++++++---------
> >  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> I'd like to defer this and just migrate to OF_UPSTREAM instead.
> 

OK.. then this patch is not needed.

