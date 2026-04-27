Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C589FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED0E83C14;
	Mon, 27 Apr 2026 09:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="O6HLaUL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A4583FDB; Mon, 27 Apr 2026 09:09:32 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F5F80077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 04745554420811f19a16598d5ca7f8ec-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=Z1MwIeNYoGCW3hcyT0ag7OXfzy1UQRv0x+xy6HPFhGk=; 
 b=O6HLaUL4rWw93b4mxh3dy51385XTSVTiKgHXvWpmQKdKfrC0I0Q7jRtTfNzx1aOOQ/wIwpCLw4nB9k4Yhl+lre4fNMxXIPU2PWs1EHzPvd6McTiFBQxPbh1/R7IQQKlxmdwG9/0LHOJruUISJMOLuPwSAeLv0kLtbr4rurnRw2A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:95ca3f41-32d5-4608-935c-247aeb3e5b31, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:62cca764-469e-4eb6-aeb8-4b21454b0f32,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 04745554420811f19a16598d5ca7f8ec-20260427
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1896026179; Mon, 27 Apr 2026 15:09:22 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 15:09:21 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 15:09:20 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 00/10] Add support for ubi environment to create volumes
 (v3)
Date: Mon, 27 Apr 2026 15:09:11 +0800
Message-ID: <cover.1777272283.git.weijie.gao@mediatek.com>
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
create ubi env volumes if not exist.

Changes:
v2: Add const qualifier for char */void * in function parameters
    Adjust normal command message

v3: Fix command messages
    Fix some incorrect code flow and error handling
    Correct dynamic parameter type
    Add comments for exported functions

Weijie Gao (10):
  ubi: remove unnecessary extern directive from function prototypes
  cmd: ubi: mark read-only function parameters with const
  cmd: ubi: use void * for buf parameter in ubi_volume_read
  cmd: ubifs: mark string parameters with const
  cmd: ubi: change the type of parameter dynamic to bool
  cmd: ubi: reorganize command messages
  cmd: ubi: export more APIs to public
  cmd: ubi: allow creating volume with all free spaces in ubi_create_vol
  ubi: add comments for exported ubi API functions
  env: ubi: add support to create environment volume if it does not
    exist

 cmd/ubi.c             | 162 ++++++++++++++++++++++++++++--------------
 cmd/ubifs.c           |   2 +-
 env/Kconfig           |  11 +++
 env/ubi.c             |  39 +++++++++-
 fs/ubifs/super.c      |   2 +-
 fs/ubifs/ubifs.c      |   2 +-
 include/ubi_uboot.h   | 106 +++++++++++++++++++++++++--
 include/ubifs_uboot.h |   4 +-
 8 files changed, 260 insertions(+), 68 deletions(-)

-- 
2.45.2

