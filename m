Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821E5CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAB748460C;
	Wed, 13 May 2026 10:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nNyFGh4C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD84384659; Wed, 13 May 2026 10:02:59 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F298056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 21f00c804ea211f1a3561939bc42ff46-20260513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=Rt4tSFNIx8/0W4Pum+31UcV0hH1IXevmlECLKejb8Hg=; 
 b=nNyFGh4Cs+q0UQHkN8bYz+USwFcvFJtO0qYO1SNDBOTtevr+iH2VeBVkleREA/fwZTa7uQa1qyy4yhiCa8r//YIG6nVcjzLz/joCDkHxCfyhjuxiJQZRu2RU+4LlkyHFZEpuCq/mqmSGqD+zplABZFxzCgvOafXSb7AUnGsmTwM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:6e2dbf48-117a-45bd-8ce7-ef8e531fca88, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:9091e75, CLOUDID:b6a84dbf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
 15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21f00c804ea211f1a3561939bc42ff46-20260513
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1493565200; Wed, 13 May 2026 16:02:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 13 May 2026 16:02:47 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 13 May 2026 16:02:47 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 00/10] Add support for ubi environment to create volumes
 (v4)
Date: Wed, 13 May 2026 16:02:45 +0800
Message-ID: <cover.1778657347.git.weijie.gao@mediatek.com>
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

 cmd/ubi.c             | 276 +++++++++++++++++++++++++++---------------
 cmd/ubifs.c           |   2 +-
 env/Kconfig           |  20 +++
 env/ubi.c             |  65 ++++++++--
 fs/ubifs/super.c      |   2 +-
 fs/ubifs/ubifs.c      |   2 +-
 include/ubi_uboot.h   | 106 ++++++++++++++--
 include/ubifs_uboot.h |   4 +-
 8 files changed, 355 insertions(+), 122 deletions(-)

-- 
2.45.2

