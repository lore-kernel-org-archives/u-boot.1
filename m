Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE70C55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 03:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAAC66075F;
	Fri, 31 Jul 2026 03:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFIvLF9O4o64; Fri, 31 Jul 2026 03:17:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D25A606E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785467866;
	bh=Z8XGWgE6uHe5ENILOaZI5hrzBMctRMrHg+5iGbVyghI=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f3Jwo6oSY+LZvQIyov8Rxp9cAISB+Te2RHzzALsvNZJoOAZXchzbtxlTMBGmPT6Y5
	 f9j+CBOLwyjA2BnnyCND1W7s2qpMKjXncJ3MEtl5PpD7YwEiXjgV0ooJEmjDtM42aj
	 SKsrXijdl6UHyIfzLmK+cjRuOy8TcgQkQ3z/jtJSQ3BBsXBi2zUjdApeYZaQx/Seky
	 CQVXil/E2fojSuRdWqzVXIIWlCQm+H7dYAkf+vyoXjwjewl3if74ii2qJI8cjA3+Zk
	 O/oQwSWktyqfYmSfBCltT8E3skD3UQsP2e9v/9nZ2KdG0PoprczYE+OLV414iBeNnj
	 1ejbN0l2WsyXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D25A606E5;
	Fri, 31 Jul 2026 03:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C3D7218
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BE2480EB0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpV3xauVlInd for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:17:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=weijie.gao@mediatek.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F3C680E70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F3C680E70
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F3C680E70
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:17:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C485884A0B; Fri, 31 Jul 2026 05:17:36 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9D6849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 05:17:33 +0200 (CEST)
X-UUID: 59be0f2a8c8e11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:0078002c-3eb9-4a7d-8ab5-560df9ebcf43, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:37fdc28a-2e92-4dcd-8f3b-8af1b16bdb04,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|136|836|865|888|898,TC:-5,Cont
 ent:0|15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,B
 EC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 59be0f2a8c8e11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1569914970; Fri, 31 Jul 2026 11:17:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 11:17:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 11:17:22 +0800
Message-ID: <84525d04d661a5dbccc5476929b25d9552e2f989.camel@mediatek.com>
Subject: Re: [PATCH] mtd: spinand: add support for FudanMicro FM25S01BI3
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tianling Shen <cnsztl@gmail.com>
Date: Fri, 31 Jul 2026 11:17:22 +0800
In-Reply-To: <20260429081319.151702-1-weijie.gao@mediatek.com>
References: <20260429081319.151702-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Z8XGWgE6uHe5ENILOaZI5hrzBMctRMrHg+5iGbVyghI=; 
 b=I9n6InQLOsT7gvo6RQln4S214s8oPY5YPE9JSHXmDLctVWmI9E6+Eg8bCLdFzZOODUmkXslMiDwWUutU4EN8BvwxY+jyWbvejAfUzvvIVLU/6U9jjkkX36OiAVfdF25oqIPQfISjfYON7S03/1Bj5kPy6/ci86+4j2r3GV7ghto=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=I9n6InQL
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=weijie.gao@mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="I9n6InQL";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi All,

This is just a gentle ping.
Any comments/review are appreciated.
Is this patch able to be merged?

On Wed, 2026-04-29 at 16:13 +0800, Weijie Gao wrote:
> Add support for FudanMicro FM25S01BI3 SPI-NAND.
> 
> This driver is ported from linux kernel with fix:
> This SPI-NAND does not support 1S-4S-4S and 1S-2S-2S modes.
> 
https://lore.kernel.org/linux-mtd/20251127195900.2562-1-csharper2005@gmail.com/
> 
> Datasheet link:
> https://www.fmsh.com/nvm/FM25S01BI3_ds_eng.pdf
> 
> Tested on MediaTek's filogic platform reference board.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  drivers/mtd/nand/spi/fmsh.c | 77
> +++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 

Best Regards,
Weijie

