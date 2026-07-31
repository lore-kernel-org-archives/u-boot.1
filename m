Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69EAC55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 837996072E;
	Fri, 31 Jul 2026 02:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6PDoPJ9F97uu; Fri, 31 Jul 2026 02:58:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADCF2606EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785466721;
	bh=bRZFNWvD55FbW+BkRboC+EKutPBYahLYH6qgGbFFhCo=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wAlecolAV5f71BYs/YSSx6kANuG4r6OCpp0/5gQHjFmWAnZTC2FZr+SLkfQGzjltl
	 dv/izAkkOtvzvSJpI7xXm8JV0IqoVwSeP+M127K4mWrKnsduvyDQPzJYAiB+ZkwbO/
	 +Ldt7fQIAL0+CGqYre0ZhRonm8G6MGz+ncX7SWSfx+N0sZJ1UD5Z/vCDB6URaxa+UH
	 0mmWuDC9ZP7FDpQcFzk8jQrhc6cophB4RKTMFp51qg/wiOzTtpshLr+l0y9NLDMb3M
	 VTIxKfyzVal3kMidYGlaaTeXecyG6bU9du84YPEf7TWkoD3zhAHkYEGSZy9iJ4nL8N
	 qnvFub8ERjjyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADCF2606EF;
	Fri, 31 Jul 2026 02:58:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73D3869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5939C40EAE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FOlPi4u2Cf7s for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 02:58:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=weijie.gao@mediatek.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B5AF940EAD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5AF940EAD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5AF940EAD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 02:58:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4453484A0B; Fri, 31 Jul 2026 04:58:35 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DB3849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 04:58:29 +0200 (CEST)
X-UUID: b0d211b08c8b11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:8d8fea6a-9f8e-4f70-927a-7b559fb974de, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:85795ef1-0685-46a3-9cac-19d8f3a05ae7,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|836|865|888|898,TC:-5,Content:
 0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b0d211b08c8b11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1539374157; Fri, 31 Jul 2026 10:58:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 10:58:20 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 10:58:20 +0800
Message-ID: <8baa55343131dff464a02e024df532f7d9de8e96.camel@mediatek.com>
Subject: Re: [PATCH v2] common: spl: nand: improve u-boot offsets overriding
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>
Date: Fri, 31 Jul 2026 10:58:19 +0800
In-Reply-To: <20260415073425.72208-1-weijie.gao@mediatek.com>
References: <20260415073425.72208-1-weijie.gao@mediatek.com>
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
 bh=bRZFNWvD55FbW+BkRboC+EKutPBYahLYH6qgGbFFhCo=; 
 b=SSLbHh8d6NJ6VHvFojCm/WKubFNp/zHSkQIP99xuyOaaBW0MuNMrpwBApV5FTDfLSDlOJXcu/FY6nGPv1M3Eg85nFGROi45tLf9nE1tttH5Et+/5xBgJ9WAIgA9AhycpBck26cOQULDl2jJXazLwjpZ1FFK5izrf5IOJjyh4tbk=;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=mediatek.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=SSLbHh8d
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=weijie.gao@mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="SSLbHh8d";
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

On Wed, 2026-04-15 at 15:34 +0800, Weijie Gao wrote:
> This patch introduces spl_nand_get_uboot_raw_page_redund() to wrap
> the
> CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND macro, similar as what
> spl_nand_get_uboot_raw_page() has already done.
> 
> The spl_nand_get_uboot_raw_page_redund() is defined to return int to
> allow
> disabling loading redundant u-boot by returning a negative value.
> By default if CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND equals
> CONFIG_SYS_NAND_U_BOOT_OFFS, spl_nand_get_uboot_raw_page_redund()
> will
> return -1.
> 
> This patch also replaces all references to
> CONFIG_SYS_NAND_U_BOOT_OFFS and
> CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND with the return value of the two
> functions mentioned above.
> 
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
>  common/spl/spl_nand.c | 40 +++++++++++++++++++++++++++-------------
>  1 file changed, 27 insertions(+), 13 deletions(-)
> 

Best Regards,
Weijie

