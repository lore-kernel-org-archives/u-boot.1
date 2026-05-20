Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16328CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954F5846F2;
	Wed, 20 May 2026 10:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="i5S9NrKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1E1803C6; Wed, 20 May 2026 10:27:43 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A748460E
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: bb940426542511f1b5a00d44d12bea5a-20260520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oSHBc+rJheSDZuXA17o/tfFcAD0Y9fbN0UCROXRgMZk=; 
 b=i5S9NrKWVNh6RhHmQngJF/dRkp/QBBgAPhtrVvL6xg7Lj5w3PjO0x8tiWqfAvdlKH1rCsDgcT8fGqgnX2+1T3CqtZPYEISfkIAW4VIOCwvaC+TmWROLkvG1vtFL9OTcQ3AHnxTXTV+3zPlFitx3byw4Qu4b8hgIOShDvf9h0318=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:d81fc50e-e89b-41ad-a37f-ccfb3ea8bafa, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:9091e75, CLOUDID:8c2a2946-e650-4d81-a877-d298d8f44b5d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bb940426542511f1b5a00d44d12bea5a-20260520
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 260535891; Wed, 20 May 2026 16:27:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 20 May 2026 16:27:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 20 May 2026 16:27:24 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 00/10] Add support for ubi environment to create volumes
 (v5)
Date: Wed, 20 May 2026 16:27:17 +0800
Message-ID: <cover.1779263662.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
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

This patch series expose more ubi helpers to allow the ubi environment to
create ubi env volumes before loading if they're not exist.

Changes:
v5: Return CMD_RET_USAGE on all usage error path
    Return -ENODEV instead of PTR_ERR(mtd) in ubi_part()
    Fix commit message mistake
    Fix API function description comments
    Fix Kconfig help text

v4: Adjust command message. Error messages will be printed in both command
     and api call.
    Add parameter check for "ubi rename" subcommand
    Fix duplicated call to ubi_require_volume() in command.
    Squash api function comments.
    Change all return value to negative.
    Add another kconfig option to control whether to create static volume.
    Read environment volume only when it exists or has been created.

v3: Fix command messages
    Fix some incorrect code flow and error handling
    Correct dynamic parameter type
    Add comments for exported functions

v2: Add const qualifier for char */void * in function parameters
    Adjust normal command message

Weijie Gao (10):
  ubi: remove unnecessary extern directive from function prototypes
  cmd: ubi: mark read-only function parameters with const
  cmd: ubi: use void * for buf parameter in ubi_volume_read
  cmd: ubifs: mark string parameters with const
  cmd: ubi: change the type of parameter dynamic to bool
  cmd: ubi: change all positive error return value to negative
  cmd: ubi: reorganize command messages
  cmd: ubi: export more APIs to public
  cmd: ubi: allow creating volume with all free spaces in ubi_create_vol
  env: ubi: add support to create environment volume if it does not
    exist

 cmd/ubi.c             | 272 +++++++++++++++++++++++++++---------------
 cmd/ubifs.c           |   2 +-
 env/Kconfig           |  20 ++++
 env/ubi.c             |  65 ++++++++--
 fs/ubifs/super.c      |   2 +-
 fs/ubifs/ubifs.c      |   2 +-
 include/ubi_uboot.h   | 106 ++++++++++++++--
 include/ubifs_uboot.h |   4 +-
 8 files changed, 351 insertions(+), 122 deletions(-)

-- 
2.45.2

