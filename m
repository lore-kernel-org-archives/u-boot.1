Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D15BC55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 03:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E69060718;
	Fri, 31 Jul 2026 03:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svCo1xGE00ED; Fri, 31 Jul 2026 03:12:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D77F5606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785467558;
	bh=2qVTqdmrk60QeiiPSIemKe5JQna68Hr2dQRuoNNJLo0=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rMYWyWKI9WHzr5qHsXN0me8EVZkx7VKXa3wA02OA3crfeSs2gLIlmm7jsjMxJkqqn
	 vPUTpEsfoZScOs1juFOeD5CCEG6z1xTB21eIFrgyKxVaQ/aw94UW33w6JiewNrf81W
	 bLXc0E+Zid0eGV2VuPYbH2gsdj2wsOR0tVHoP21QhXTZwocu9NWdlMKdF+JcHIs4bq
	 W1Twi9qrrgQPJN0+9RP9HKTuDmKimzQGHmI7fzHO9r6hLOwrR4gwTrkRtDAogf0UyQ
	 YAUEMmh6AvqMNYzAWUpoooo34zzYF0og0zDPFmJ95lCr/0lkGE7rj7hoDQxMHd6h4q
	 KqiSRyRtk7ROw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D77F5606C6;
	Fri, 31 Jul 2026 03:12:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E7BA69
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 900F780E18
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pGhSCC0f7-EH for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:12:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=weijie.gao@mediatek.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 328F680E0B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 328F680E0B
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 328F680E0B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:12:34 +0000 (UTC)
X-UUID: aaf133e68c8d11f18dc8c9802ae25ab1-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:f25d9a14-dcfc-4b03-a693-c9af84d17eed, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:48f4c28a-2e92-4dcd-8f3b-8af1b16bdb04,
 B
 ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
 DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
 AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aaf133e68c8d11f18dc8c9802ae25ab1-20260731
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 368747647; Fri, 31 Jul 2026 11:12:31 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 11:12:29 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 11:12:29 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.u-boot-project.org>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Shiji Yang <yangshiji66@outlook.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH,RESEND] env: mtd: fix unbalanced put_mtd_device()
Date: Fri, 31 Jul 2026 11:12:27 +0800
Message-ID: <20260731031227.82743-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=2qVTqdmrk60QeiiPSIemKe5JQna68Hr2dQRuoNNJLo0=; 
 b=JrD03rL3Of76dvG4abas016X/UC1mT/LG3tbrhx0f5Ul13aEyze968HRnEJWNzMwYYPXUlGd8LoZESsW+vmE8N5TnZnR0alhEobODsO2952i/jGZtVIuKGB1wYtxgOneYZigl3T8VAQvaT5a4ptXVc8Mu3PSGAl41BZjSmZpPOE=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256
 header.s=dk header.b=JrD03rL3
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

In env_mtd_load(), put_mtd_device(mtd_env) should only be called after
setup_mtd_device(&mtd_env) returned success. Failing to do so will trigger
BUG_ON(mtd->usecount < 0) crash in __put_mtd_device().

Adding an early error out path for setup_mtd_device() to skip
put_mtd_device() will solve this issue.

Fixes: 39ae954b04ef ("env: mtd: add the missing put_mtd_device()")
Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 env/mtd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/env/mtd.c b/env/mtd.c
index b26ee80985a..67d207272d8 100644
--- a/env/mtd.c
+++ b/env/mtd.c
@@ -157,7 +157,7 @@ static int env_mtd_load(void)
 
 	ret = setup_mtd_device(&mtd_env);
 	if (ret)
-		goto out;
+		goto early_out;
 
 	sect_size = mtd_env->erasesize;
 
@@ -192,6 +192,7 @@ static int env_mtd_load(void)
 out:
 	put_mtd_device(mtd_env);
 
+early_out:
 	free(buf);
 
 	return ret;
-- 
2.45.2

