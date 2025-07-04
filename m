Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087FFC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 12:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB5382F6D;
	Fri,  4 Jul 2025 14:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rMwp6qZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415A082F14; Fri,  4 Jul 2025 11:12:51 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F20E803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 11:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5649Cd03258779;
 Fri, 4 Jul 2025 04:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751620359;
 bh=SIrhYGHrXc4h2YL12+ohF5gU7A2CYTcQq4Taz1tnJ0U=;
 h=From:To:CC:Subject:Date;
 b=rMwp6qZTPxTAb9EjGhCfF3J8Yv8/k2bNliyoZB0g8ZDVoOxx+KHxMjDahpzZ60x+L
 Fs/aVM/4KclkhLo42nsrUkhGAtZW4V3FaSMx6uxjjkMxWC9pqgVXreigazg4WUMpik
 ZQT5aWZihxL8354efakBdwWDjnnbVD9C9V3ahX5s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5649CdSo3248065
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 4 Jul 2025 04:12:39 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 4
 Jul 2025 04:12:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 4 Jul 2025 04:12:38 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5649CZob2724494;
 Fri, 4 Jul 2025 04:12:35 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] board: ti: Clean up formatting in rm-cfg.yaml
Date: Fri, 4 Jul 2025 14:42:34 +0530
Message-ID: <20250704091234.3218906-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 04 Jul 2025 14:33:47 +0200
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

Move to using the latest generated RM YAML configuration files generated
by the K3 Resource Partitioning Tool which updates them to have standard
formatting with respect to indentation.

These files were generated from the untagged commit 41718bd5f915 ("docs: Update
docs and move them to docs folder") of the K3 Resource Partitioning tool. This
tool is packaged as a part of the public SDK and is not otherwise
publicly available.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Changes since v1:
https://lore.kernel.org/all/20250702105533.1533178-1-n-francis@ti.com/
- commit message changed to include the generated tool commit (Udit)

Boot logs:
https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21

 board/ti/am64x/rm-cfg.yaml      | 2416 +++++++-------
 board/ti/j7200/rm-cfg.yaml      | 3554 ++++++++++----------
 board/ti/j721e/rm-cfg.yaml      | 5498 +++++++++++++++----------------
 board/ti/j722s/rm-cfg.yaml      |   66 +-
 board/ti/j722s/tifs-rm-cfg.yaml | 1552 ++++-----
 5 files changed, 6543 insertions(+), 6543 deletions(-)

diff --git a/board/ti/am64x/rm-cfg.yaml b/board/ti/am64x/rm-cfg.yaml
index 88b37b5972c..1cc4cd34430 100644
--- a/board/ti/am64x/rm-cfg.yaml
+++ b/board/ti/am64x/rm-cfg.yaml
@@ -1,1215 +1,1215 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
-# Resource management configuration for AM64x
+# Resource management configuration for AM64X
 #
 
 ---
 
 rm-cfg:
-        rm_boardcfg:
-                rev:
-                        boardcfg_abi_maj: 0x0
-                        boardcfg_abi_min: 0x1
-                host_cfg:
-                        subhdr:
-                                magic: 0x4C41
-                                size: 356
-                        host_cfg_entries:
-                                -  # 1
-                                        host_id: 12
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 2
-                                        host_id: 30
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 3
-                                        host_id: 36
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 4
-                                        host_id: 38
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 5
-                                        host_id: 41
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 6
-                                        host_id: 43
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 7
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 8
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 9
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 10
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 11
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 12
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 13
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 14
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 15
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 16
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 17
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 18
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 19
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 20
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 21
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 22
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 23
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 24
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 25
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 26
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 27
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 28
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 29
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 30
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 31
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 32
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                resasg:
-                        subhdr:
-                                magic: 0x7B25
-                                size: 8
-                        resasg_entries_size: 1288
-                        reserved: 0
-        resasg_entries:
-                -
-                        start_resource: 0
-                        num_resource: 16
-                        type: 64
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 4
-                        type: 64
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 4
-                        type: 64
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 4
-                        type: 64
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 64
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 64
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 8
-                        type: 64
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 12
-                        type: 192
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 192
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 192
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 320
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 320
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 41
-                        type: 384
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 50176
-                        num_resource: 136
-                        type: 1666
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 1667
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 12
-                        type: 1677
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 6
-                        type: 1677
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 6
-                        type: 1677
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 2
-                        type: 1677
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 4
-                        type: 1677
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 1677
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 1
-                        type: 1677
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 27
-                        num_resource: 1
-                        type: 1677
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 6
-                        type: 1678
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 54
-                        num_resource: 6
-                        type: 1678
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 54
-                        num_resource: 6
-                        type: 1678
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 2
-                        type: 1678
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 62
-                        num_resource: 4
-                        type: 1678
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 66
-                        num_resource: 2
-                        type: 1678
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 6
-                        type: 1679
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 6
-                        type: 1679
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 6
-                        type: 1679
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 2
-                        type: 1679
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 4
-                        type: 1679
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 46
-                        num_resource: 2
-                        type: 1679
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 12
-                        type: 1696
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 6
-                        type: 1696
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 6
-                        type: 1696
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 2
-                        type: 1696
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 4
-                        type: 1696
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 1696
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 1
-                        type: 1696
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 27
-                        num_resource: 1
-                        type: 1696
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 6
-                        type: 1697
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 6
-                        type: 1697
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 6
-                        type: 1697
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 1697
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 4
-                        type: 1697
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 2
-                        type: 1697
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 6
-                        type: 1698
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 6
-                        type: 1698
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 6
-                        type: 1698
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 1698
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 4
-                        type: 1698
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 2
-                        type: 1698
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 35
-                        type: 1802
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 14
-                        type: 1802
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 14
-                        type: 1802
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 58
-                        num_resource: 14
-                        type: 1802
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 92
-                        num_resource: 14
-                        type: 1802
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 106
-                        num_resource: 14
-                        type: 1802
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 16
-                        type: 1802
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 512
-                        type: 1805
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 528
-                        num_resource: 256
-                        type: 1805
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 528
-                        num_resource: 256
-                        type: 1805
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 784
-                        num_resource: 192
-                        type: 1805
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 976
-                        num_resource: 256
-                        type: 1805
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 1232
-                        num_resource: 192
-                        type: 1805
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 1424
-                        num_resource: 96
-                        type: 1805
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 1520
-                        num_resource: 16
-                        type: 1805
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1024
-                        type: 1807
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 4096
-                        num_resource: 42
-                        type: 1808
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 4608
-                        num_resource: 112
-                        type: 1809
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 5120
-                        num_resource: 29
-                        type: 1810
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 5632
-                        num_resource: 176
-                        type: 1811
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 6144
-                        num_resource: 176
-                        type: 1812
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 6656
-                        num_resource: 176
-                        type: 1813
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 8192
-                        num_resource: 28
-                        type: 1814
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 8704
-                        num_resource: 28
-                        type: 1815
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 9216
-                        num_resource: 28
-                        type: 1816
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 9728
-                        num_resource: 20
-                        type: 1817
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 10240
-                        num_resource: 20
-                        type: 1818
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 10752
-                        num_resource: 20
-                        type: 1819
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 11264
-                        num_resource: 20
-                        type: 1820
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 11776
-                        num_resource: 20
-                        type: 1821
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 12288
-                        num_resource: 20
-                        type: 1822
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 1923
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 1936
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1936
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1936
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 1936
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 1936
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 1936
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 1
-                        type: 1936
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 64
-                        type: 1937
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 64
-                        type: 1937
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 88
-                        num_resource: 8
-                        type: 1939
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 8
-                        type: 1940
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 104
-                        num_resource: 8
-                        type: 1941
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 112
-                        num_resource: 4
-                        type: 1942
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 116
-                        num_resource: 3
-                        type: 1942
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 116
-                        num_resource: 3
-                        type: 1942
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 119
-                        num_resource: 2
-                        type: 1942
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 121
-                        num_resource: 4
-                        type: 1942
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 125
-                        num_resource: 2
-                        type: 1942
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 127
-                        num_resource: 1
-                        type: 1942
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 16
-                        type: 1943
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 16
-                        type: 1943
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 144
-                        num_resource: 8
-                        type: 1945
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 152
-                        num_resource: 8
-                        type: 1946
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 152
-                        num_resource: 8
-                        type: 1947
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 160
-                        num_resource: 64
-                        type: 1948
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 224
-                        num_resource: 64
-                        type: 1949
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 1955
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1955
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1955
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 1955
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 1955
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 1955
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 1
-                        type: 1955
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 1956
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 1956
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 25
-                        num_resource: 1
-                        type: 1958
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 8
-                        type: 1959
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 8
-                        type: 1960
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 1961
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1961
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1961
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 1961
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 1961
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 1961
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 1
-                        type: 1961
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 1962
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1962
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 3
-                        type: 1962
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 1962
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 1962
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 1962
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 1
-                        type: 1962
-                        host_id: 30
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 1
-                        type: 1963
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 1
-                        type: 1963
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 16
-                        type: 1964
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 16
-                        type: 1964
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 8
-                        type: 1966
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 8
-                        type: 1968
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 19
-                        num_resource: 1
-                        type: 1969
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 8
-                        type: 1970
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 1
-                        type: 1971
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 8
-                        type: 1972
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 21
-                        num_resource: 4
-                        type: 1973
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 64
-                        type: 1974
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 25
-                        num_resource: 4
-                        type: 1975
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 112
-                        num_resource: 64
-                        type: 1976
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 2112
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 2
-                        type: 2122
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 2
-                        type: 2124
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 2
-                        type: 2124
-                        host_id: 36
-                        reserved: 0
-                -
-                        start_resource: 22
-                        num_resource: 2
-                        type: 2124
-                        host_id: 38
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 2124
-                        host_id: 41
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 2
-                        type: 2124
-                        host_id: 43
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 2124
-                        host_id: 128
-                        reserved: 0
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 38
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
+                    host_id: 41
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 6
+                    host_id: 43
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 1288
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 64
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 4
+            type: 64
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 64
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 64
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 64
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 192
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 192
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 41
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 136
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1677
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 4
+            type: 1677
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 1
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 6
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 2
+            type: 1678
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 62
+            num_resource: 4
+            type: 1678
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 66
+            num_resource: 2
+            type: 1678
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 6
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 2
+            type: 1679
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 4
+            type: 1679
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 46
+            num_resource: 2
+            type: 1679
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1696
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 4
+            type: 1696
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 1
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 1697
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 4
+            type: 1697
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1697
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 1698
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 4
+            type: 1698
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 14
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 14
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 58
+            num_resource: 14
+            type: 1802
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 92
+            num_resource: 14
+            type: 1802
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 106
+            num_resource: 14
+            type: 1802
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 16
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 528
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 528
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 784
+            num_resource: 192
+            type: 1805
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 976
+            num_resource: 256
+            type: 1805
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 1232
+            num_resource: 192
+            type: 1805
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 1424
+            num_resource: 96
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 1520
+            num_resource: 16
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 42
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 112
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 29
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 176
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 176
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 176
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 28
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 28
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 28
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 20
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 20
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 20
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 20
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 20
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 20
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 1936
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 1936
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 1936
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 1
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 64
+            type: 1937
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 88
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 8
+            type: 1940
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 104
+            num_resource: 8
+            type: 1941
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 4
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 116
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 116
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 119
+            num_resource: 2
+            type: 1942
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 121
+            num_resource: 4
+            type: 1942
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 125
+            num_resource: 2
+            type: 1942
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 127
+            num_resource: 1
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 16
+            type: 1943
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 144
+            num_resource: 8
+            type: 1945
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 152
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 152
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 160
+            num_resource: 64
+            type: 1948
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 224
+            num_resource: 64
+            type: 1949
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 1955
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 1955
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 1955
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 1
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 1956
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 8
+            type: 1959
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 8
+            type: 1960
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 1961
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 1961
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 1961
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 1
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 1962
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 1962
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 1962
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 1
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 1
+            type: 1963
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 16
+            type: 1964
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 1966
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 1968
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 4
+            type: 1973
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 64
+            type: 1974
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 4
+            type: 1975
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 64
+            type: 1976
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 2124
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 2124
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 2
+            type: 2124
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 2124
+            host_id: 41
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 2124
+            host_id: 43
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 2124
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/j7200/rm-cfg.yaml b/board/ti/j7200/rm-cfg.yaml
index f83184bbfc0..9da0ea91ada 100644
--- a/board/ti/j7200/rm-cfg.yaml
+++ b/board/ti/j7200/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J7200
 #
@@ -7,1779 +7,1779 @@
 ---
 
 rm-cfg:
-        rm_boardcfg:
-                rev:
-                        boardcfg_abi_maj: 0x0
-                        boardcfg_abi_min: 0x1
-                host_cfg:
-                        subhdr:
-                                magic: 0x4C41
-                                size: 356
-                        host_cfg_entries:
-                                -  # 1
-                                        host_id: 3
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 2
-                                        host_id: 5
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 3
-                                        host_id: 12
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 4
-                                        host_id: 13
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 5
-                                        host_id: 35
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 6
-                                        host_id: 37
-                                        allowed_atype: 0b101010
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 7
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 8
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 9
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 10
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 11
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 12
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 13
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 14
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 15
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 16
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 17
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 18
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 19
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 20
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 21
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 22
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 23
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 24
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 25
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 26
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 27
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 28
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 29
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 30
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 31
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 32
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                resasg:
-                        subhdr:
-                                magic: 0x7B25
-                                size: 8
-                        resasg_entries_size: 2048
-                        reserved: 0
-        resasg_entries:
-                -
-                        start_resource: 0
-                        num_resource: 32
-                        type: 8192
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 32
-                        type: 8192
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 24
-                        type: 8320
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 24
-                        type: 8320
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 8
-                        type: 8384
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 8
-                        type: 8384
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 8384
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 8
-                        type: 8384
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 16
-                        type: 8384
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 16
-                        type: 8384
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 48
-                        type: 8704
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 8
-                        type: 8768
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 8
-                        type: 8768
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 8768
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 8
-                        type: 8768
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 64
-                        type: 13258
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 20480
-                        num_resource: 1024
-                        type: 13261
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 64
-                        type: 13322
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 22528
-                        num_resource: 1024
-                        type: 13325
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 86
-                        type: 13386
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 104
-                        num_resource: 32
-                        type: 13386
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 136
-                        num_resource: 16
-                        type: 13386
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 152
-                        num_resource: 16
-                        type: 13386
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 32
-                        type: 13386
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 200
-                        num_resource: 24
-                        type: 13386
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 224
-                        num_resource: 32
-                        type: 13386
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 1024
-                        type: 13389
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 1042
-                        num_resource: 512
-                        type: 13389
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 1554
-                        num_resource: 128
-                        type: 13389
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 1682
-                        num_resource: 128
-                        type: 13389
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 1810
-                        num_resource: 256
-                        type: 13389
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 2066
-                        num_resource: 512
-                        type: 13389
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 2578
-                        num_resource: 2030
-                        type: 13389
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 13440
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13440
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 4
-                        type: 13440
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 4
-                        type: 13440
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 16
-                        type: 13440
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 16
-                        type: 13440
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 16
-                        type: 13440
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13504
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 120
-                        num_resource: 200
-                        type: 13505
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 320
-                        num_resource: 40
-                        type: 13505
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 360
-                        num_resource: 32
-                        type: 13505
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 392
-                        num_resource: 32
-                        type: 13505
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 424
-                        num_resource: 256
-                        type: 13505
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 680
-                        num_resource: 256
-                        type: 13505
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 936
-                        num_resource: 38
-                        type: 13505
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 64
-                        num_resource: 4
-                        type: 13506
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 68
-                        num_resource: 2
-                        type: 13506
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 70
-                        num_resource: 2
-                        type: 13506
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 72
-                        num_resource: 2
-                        type: 13506
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 74
-                        num_resource: 2
-                        type: 13506
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 76
-                        num_resource: 2
-                        type: 13506
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 78
-                        num_resource: 20
-                        type: 13506
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 98
-                        num_resource: 4
-                        type: 13506
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 102
-                        num_resource: 8
-                        type: 13506
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 110
-                        num_resource: 8
-                        type: 13506
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 118
-                        num_resource: 2
-                        type: 13506
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13507
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 2
-                        type: 13507
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 2
-                        type: 13507
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 13507
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13507
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 2
-                        type: 13507
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 20
-                        type: 13507
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 4
-                        type: 13507
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 8
-                        type: 13507
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 50
-                        num_resource: 8
-                        type: 13507
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 58
-                        num_resource: 2
-                        type: 13507
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 62
-                        num_resource: 0
-                        type: 13509
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 62
-                        num_resource: 1
-                        type: 13509
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 62
-                        num_resource: 0
-                        type: 13509
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 63
-                        num_resource: 1
-                        type: 13509
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 0
-                        type: 13510
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 2
-                        type: 13510
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13511
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 1
-                        type: 13511
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13511
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 1
-                        type: 13511
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13512
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13512
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 1
-                        type: 13514
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 1
-                        type: 13514
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 3
-                        type: 13515
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 2
-                        type: 13515
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 1
-                        type: 13515
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 1
-                        type: 13515
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 16
-                        type: 13515
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 23
-                        num_resource: 8
-                        type: 13515
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 31
-                        num_resource: 1
-                        type: 13515
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 8
-                        type: 13568
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 68
-                        num_resource: 8
-                        type: 13568
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 76
-                        num_resource: 8
-                        type: 13568
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 84
-                        num_resource: 66
-                        type: 13568
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13569
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 49152
-                        num_resource: 1024
-                        type: 13570
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13571
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13578
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 2
-                        type: 13578
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 2
-                        type: 13578
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 13578
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13578
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 2
-                        type: 13578
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 20
-                        type: 13578
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 4
-                        type: 13578
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 8
-                        type: 13578
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 50
-                        num_resource: 8
-                        type: 13578
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 58
-                        num_resource: 2
-                        type: 13578
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13579
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 1
-                        type: 13579
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13579
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 1
-                        type: 13579
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13580
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13580
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13581
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 2
-                        type: 13581
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 2
-                        type: 13581
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 2
-                        type: 13581
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13581
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 2
-                        type: 13581
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 18
-                        num_resource: 20
-                        type: 13581
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 4
-                        type: 13581
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 8
-                        type: 13581
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 50
-                        num_resource: 8
-                        type: 13581
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 58
-                        num_resource: 2
-                        type: 13581
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13583
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 1
-                        type: 13583
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 0
-                        type: 13583
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 1
-                        type: 13583
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13584
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13584
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 128
-                        type: 13632
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 138
-                        num_resource: 54
-                        type: 13632
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 196
-                        num_resource: 28
-                        type: 13632
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 228
-                        num_resource: 28
-                        type: 13632
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 400
-                        num_resource: 4
-                        type: 13632
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 404
-                        num_resource: 4
-                        type: 13632
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 32
-                        type: 14922
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 47
-                        num_resource: 16
-                        type: 14922
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 63
-                        num_resource: 64
-                        type: 14922
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 127
-                        num_resource: 32
-                        type: 14922
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 159
-                        num_resource: 16
-                        type: 14922
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 175
-                        num_resource: 16
-                        type: 14922
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 191
-                        num_resource: 65
-                        type: 14922
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 16399
-                        num_resource: 128
-                        type: 14925
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16527
-                        num_resource: 128
-                        type: 14925
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 16655
-                        num_resource: 256
-                        type: 14925
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 16911
-                        num_resource: 128
-                        type: 14925
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 17039
-                        num_resource: 128
-                        type: 14925
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 17167
-                        num_resource: 128
-                        type: 14925
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 17295
-                        num_resource: 625
-                        type: 14925
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 1
-                        num_resource: 8
-                        type: 14976
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 14976
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 16
-                        type: 14976
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 29
-                        num_resource: 16
-                        type: 14976
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 45
-                        num_resource: 8
-                        type: 14976
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 53
-                        num_resource: 8
-                        type: 14976
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 61
-                        num_resource: 3
-                        type: 14976
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15040
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 32
-                        type: 15041
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 16
-                        type: 15041
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 144
-                        num_resource: 32
-                        type: 15041
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 176
-                        num_resource: 32
-                        type: 15041
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 208
-                        num_resource: 16
-                        type: 15041
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 224
-                        num_resource: 16
-                        type: 15041
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 240
-                        num_resource: 12
-                        type: 15041
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 50
-                        num_resource: 3
-                        type: 15042
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 53
-                        num_resource: 2
-                        type: 15042
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 55
-                        num_resource: 2
-                        type: 15042
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 57
-                        num_resource: 2
-                        type: 15042
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 59
-                        num_resource: 2
-                        type: 15042
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 61
-                        num_resource: 2
-                        type: 15042
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 63
-                        num_resource: 9
-                        type: 15042
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 72
-                        num_resource: 4
-                        type: 15042
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 76
-                        num_resource: 4
-                        type: 15042
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 80
-                        num_resource: 4
-                        type: 15042
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 84
-                        num_resource: 4
-                        type: 15042
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 88
-                        num_resource: 4
-                        type: 15042
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 92
-                        num_resource: 1
-                        type: 15042
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 3
-                        type: 15043
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 2
-                        type: 15043
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 15043
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 2
-                        type: 15043
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 2
-                        type: 15043
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 15043
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15043
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 15043
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 15043
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 4
-                        type: 15043
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 4
-                        type: 15043
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 4
-                        type: 15043
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 2
-                        type: 15043
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 0
-                        type: 15045
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 0
-                        type: 15045
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 1
-                        type: 15045
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 49
-                        num_resource: 1
-                        type: 15045
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15047
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15047
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15047
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 1
-                        num_resource: 1
-                        type: 15047
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 1
-                        type: 15050
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 1
-                        type: 15050
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 3
-                        type: 15051
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 2
-                        type: 15051
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 6
-                        type: 15051
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 6
-                        type: 15051
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 17
-                        num_resource: 5
-                        type: 15051
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 22
-                        num_resource: 5
-                        type: 15051
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 27
-                        num_resource: 5
-                        type: 15051
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 8
-                        type: 15104
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 56
-                        num_resource: 4
-                        type: 15104
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 8
-                        type: 15104
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 68
-                        num_resource: 4
-                        type: 15104
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 72
-                        num_resource: 8
-                        type: 15104
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 80
-                        num_resource: 4
-                        type: 15104
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 84
-                        num_resource: 12
-                        type: 15104
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15105
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 56320
-                        num_resource: 256
-                        type: 15106
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15107
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 3
-                        type: 15114
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 2
-                        type: 15114
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 15114
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 2
-                        type: 15114
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 2
-                        type: 15114
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 15114
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15114
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 15114
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 15114
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 4
-                        type: 15114
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 4
-                        type: 15114
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 4
-                        type: 15114
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 1
-                        type: 15114
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15115
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15115
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15115
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 1
-                        num_resource: 1
-                        type: 15115
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 3
-                        type: 15117
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 2
-                        type: 15117
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 2
-                        type: 15117
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 2
-                        type: 15117
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 2
-                        type: 15117
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 2
-                        type: 15117
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15117
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 15117
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 15117
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 4
-                        type: 15117
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 4
-                        type: 15117
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 4
-                        type: 15117
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 2
-                        type: 15117
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15119
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15119
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15119
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 1
-                        num_resource: 1
-                        type: 15119
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 20
-                        type: 15168
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 28
-                        type: 15168
-                        host_id: 5
-                        reserved: 0
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 6
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 2048
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 32
+            type: 8192
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 32
+            type: 8192
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 24
+            type: 8320
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 24
+            type: 8320
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 8384
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 8
+            type: 8384
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 8384
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 8
+            type: 8384
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 16
+            type: 8384
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 16
+            type: 8384
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 48
+            type: 8704
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 8768
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 8
+            type: 8768
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 8768
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 8
+            type: 8768
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 64
+            type: 13258
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 20480
+            num_resource: 1024
+            type: 13261
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 64
+            type: 13322
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 22528
+            num_resource: 1024
+            type: 13325
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 86
+            type: 13386
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 104
+            num_resource: 32
+            type: 13386
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 136
+            num_resource: 16
+            type: 13386
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 152
+            num_resource: 16
+            type: 13386
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 32
+            type: 13386
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 200
+            num_resource: 24
+            type: 13386
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 224
+            num_resource: 32
+            type: 13386
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 1024
+            type: 13389
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 1042
+            num_resource: 512
+            type: 13389
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 1554
+            num_resource: 128
+            type: 13389
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 1682
+            num_resource: 128
+            type: 13389
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 1810
+            num_resource: 256
+            type: 13389
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2066
+            num_resource: 512
+            type: 13389
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 2578
+            num_resource: 2030
+            type: 13389
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 13440
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13440
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 4
+            type: 13440
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 4
+            type: 13440
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 16
+            type: 13440
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 16
+            type: 13440
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 16
+            type: 13440
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13504
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 120
+            num_resource: 200
+            type: 13505
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 320
+            num_resource: 40
+            type: 13505
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 360
+            num_resource: 32
+            type: 13505
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 392
+            num_resource: 32
+            type: 13505
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 424
+            num_resource: 256
+            type: 13505
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 680
+            num_resource: 256
+            type: 13505
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 936
+            num_resource: 38
+            type: 13505
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 64
+            num_resource: 4
+            type: 13506
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 68
+            num_resource: 2
+            type: 13506
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 70
+            num_resource: 2
+            type: 13506
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 2
+            type: 13506
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 74
+            num_resource: 2
+            type: 13506
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 76
+            num_resource: 2
+            type: 13506
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 20
+            type: 13506
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 98
+            num_resource: 4
+            type: 13506
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 102
+            num_resource: 8
+            type: 13506
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 110
+            num_resource: 8
+            type: 13506
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 2
+            type: 13506
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13507
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 2
+            type: 13507
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 2
+            type: 13507
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 13507
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13507
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 2
+            type: 13507
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 20
+            type: 13507
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 4
+            type: 13507
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 8
+            type: 13507
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 8
+            type: 13507
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 58
+            num_resource: 2
+            type: 13507
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 62
+            num_resource: 0
+            type: 13509
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 62
+            num_resource: 1
+            type: 13509
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 62
+            num_resource: 0
+            type: 13509
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 63
+            num_resource: 1
+            type: 13509
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 0
+            type: 13510
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 2
+            type: 13510
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13511
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 13511
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13511
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 13511
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13512
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13512
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 13514
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 13514
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 3
+            type: 13515
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 2
+            type: 13515
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 1
+            type: 13515
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 1
+            type: 13515
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 16
+            type: 13515
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 8
+            type: 13515
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 31
+            num_resource: 1
+            type: 13515
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 8
+            type: 13568
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 68
+            num_resource: 8
+            type: 13568
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 76
+            num_resource: 8
+            type: 13568
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 66
+            type: 13568
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13569
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 49152
+            num_resource: 1024
+            type: 13570
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13571
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13578
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 2
+            type: 13578
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 2
+            type: 13578
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 13578
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13578
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 2
+            type: 13578
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 20
+            type: 13578
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 4
+            type: 13578
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 8
+            type: 13578
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 8
+            type: 13578
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 58
+            num_resource: 2
+            type: 13578
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13579
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 13579
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13579
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 13579
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13580
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13580
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13581
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 2
+            type: 13581
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 2
+            type: 13581
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 2
+            type: 13581
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13581
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 2
+            type: 13581
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 20
+            type: 13581
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 4
+            type: 13581
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 8
+            type: 13581
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 8
+            type: 13581
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 58
+            num_resource: 2
+            type: 13581
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13583
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 13583
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 0
+            type: 13583
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 13583
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13584
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13584
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 128
+            type: 13632
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 138
+            num_resource: 54
+            type: 13632
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 196
+            num_resource: 28
+            type: 13632
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 228
+            num_resource: 28
+            type: 13632
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 400
+            num_resource: 4
+            type: 13632
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 404
+            num_resource: 4
+            type: 13632
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 32
+            type: 14922
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 47
+            num_resource: 16
+            type: 14922
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 63
+            num_resource: 64
+            type: 14922
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 127
+            num_resource: 32
+            type: 14922
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 159
+            num_resource: 16
+            type: 14922
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 175
+            num_resource: 16
+            type: 14922
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 191
+            num_resource: 65
+            type: 14922
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 16399
+            num_resource: 128
+            type: 14925
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16527
+            num_resource: 128
+            type: 14925
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 16655
+            num_resource: 256
+            type: 14925
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 16911
+            num_resource: 128
+            type: 14925
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 17039
+            num_resource: 128
+            type: 14925
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 17167
+            num_resource: 128
+            type: 14925
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 17295
+            num_resource: 625
+            type: 14925
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 1
+            num_resource: 8
+            type: 14976
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 14976
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 16
+            type: 14976
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 29
+            num_resource: 16
+            type: 14976
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 45
+            num_resource: 8
+            type: 14976
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 53
+            num_resource: 8
+            type: 14976
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 61
+            num_resource: 3
+            type: 14976
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15040
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 32
+            type: 15041
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 16
+            type: 15041
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 144
+            num_resource: 32
+            type: 15041
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 176
+            num_resource: 32
+            type: 15041
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 208
+            num_resource: 16
+            type: 15041
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 224
+            num_resource: 16
+            type: 15041
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 240
+            num_resource: 12
+            type: 15041
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 3
+            type: 15042
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 53
+            num_resource: 2
+            type: 15042
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 55
+            num_resource: 2
+            type: 15042
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 2
+            type: 15042
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 59
+            num_resource: 2
+            type: 15042
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 61
+            num_resource: 2
+            type: 15042
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 63
+            num_resource: 9
+            type: 15042
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 4
+            type: 15042
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 76
+            num_resource: 4
+            type: 15042
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 4
+            type: 15042
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 4
+            type: 15042
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 88
+            num_resource: 4
+            type: 15042
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 92
+            num_resource: 1
+            type: 15042
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 3
+            type: 15043
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 2
+            type: 15043
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 15043
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 2
+            type: 15043
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 2
+            type: 15043
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 15043
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15043
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 15043
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 15043
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 4
+            type: 15043
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 4
+            type: 15043
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 4
+            type: 15043
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 2
+            type: 15043
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 0
+            type: 15045
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 0
+            type: 15045
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 1
+            type: 15045
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 49
+            num_resource: 1
+            type: 15045
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15047
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15047
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15047
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 1
+            num_resource: 1
+            type: 15047
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 15050
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 15050
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 3
+            type: 15051
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 2
+            type: 15051
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 6
+            type: 15051
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 6
+            type: 15051
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 17
+            num_resource: 5
+            type: 15051
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 5
+            type: 15051
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 5
+            type: 15051
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 8
+            type: 15104
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 56
+            num_resource: 4
+            type: 15104
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 8
+            type: 15104
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 68
+            num_resource: 4
+            type: 15104
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 8
+            type: 15104
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 4
+            type: 15104
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 12
+            type: 15104
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15105
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 56320
+            num_resource: 256
+            type: 15106
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15107
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 3
+            type: 15114
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 2
+            type: 15114
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 15114
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 2
+            type: 15114
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 2
+            type: 15114
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 15114
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15114
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 15114
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 15114
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 4
+            type: 15114
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 4
+            type: 15114
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 4
+            type: 15114
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 1
+            type: 15114
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15115
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15115
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15115
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 1
+            num_resource: 1
+            type: 15115
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 3
+            type: 15117
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 2
+            type: 15117
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 2
+            type: 15117
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 2
+            type: 15117
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 2
+            type: 15117
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 2
+            type: 15117
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15117
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 15117
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 15117
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 4
+            type: 15117
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 4
+            type: 15117
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 4
+            type: 15117
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 2
+            type: 15117
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15119
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15119
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15119
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 1
+            num_resource: 1
+            type: 15119
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 20
+            type: 15168
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 28
+            type: 15168
+            host_id: 5
+            reserved: 0
diff --git a/board/ti/j721e/rm-cfg.yaml b/board/ti/j721e/rm-cfg.yaml
index 0163e3e1717..88ec2026db0 100644
--- a/board/ti/j721e/rm-cfg.yaml
+++ b/board/ti/j721e/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J721E
 #
@@ -7,2751 +7,2751 @@
 ---
 
 rm-cfg:
-        rm_boardcfg:
-                rev:
-                        boardcfg_abi_maj: 0x0
-                        boardcfg_abi_min: 0x1
-                host_cfg:
-                        subhdr:
-                                magic: 0x4C41
-                                size: 356
-                        host_cfg_entries:
-                                -  # 1
-                                        host_id: 3
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 2
-                                        host_id: 5
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 3
-                                        host_id: 12
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 4
-                                        host_id: 13
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 5
-                                        host_id: 21
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 6
-                                        host_id: 26
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 7
-                                        host_id: 28
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 8
-                                        host_id: 35
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 9
-                                        host_id: 37
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 10
-                                        host_id: 40
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 11
-                                        host_id: 42
-                                        allowed_atype: 0x2A
-                                        allowed_qos: 0xAAAA
-                                        allowed_orderid: 0xAAAAAAAA
-                                        allowed_priority: 0xAAAA
-                                        allowed_sched_priority: 0xAA
-                                -  # 12
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 13
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 14
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 15
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 16
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 17
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 18
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 19
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 20
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 21
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 22
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 23
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 24
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 25
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 26
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 27
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 28
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 29
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 30
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 31
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                                -  # 32
-                                        host_id: 0
-                                        allowed_atype: 0
-                                        allowed_qos: 0
-                                        allowed_orderid: 0
-                                        allowed_priority: 0
-                                        allowed_sched_priority: 0
-                resasg:
-                        subhdr:
-                                magic: 0x7B25
-                                size: 8
-                        resasg_entries_size: 3344
-                        reserved: 0
-        resasg_entries:
-                -
-                        start_resource: 4
-                        num_resource: 93
-                        type: 7744
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 93
-                        type: 7808
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 32
-                        type: 7872
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 32
-                        type: 8192
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 32
-                        type: 8192
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 24
-                        type: 8320
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 24
-                        type: 8320
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 8
-                        type: 8384
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 8
-                        type: 8384
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 4
-                        type: 8384
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 4
-                        type: 8384
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 8384
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 8384
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 4
-                        type: 8384
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 4
-                        type: 8384
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 12
-                        type: 8384
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 52
-                        num_resource: 12
-                        type: 8384
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 128
-                        type: 8576
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 128
-                        type: 8576
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 128
-                        type: 8640
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 128
-                        type: 8640
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 48
-                        type: 8704
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 8
-                        type: 8768
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 8
-                        type: 8768
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 6
-                        type: 8768
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 22
-                        num_resource: 6
-                        type: 8768
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 2
-                        type: 8768
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 2
-                        type: 8768
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 64
-                        type: 13258
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 20480
-                        num_resource: 1024
-                        type: 13261
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 64
-                        type: 13322
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 22528
-                        num_resource: 1024
-                        type: 13325
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 86
-                        type: 13386
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 124
-                        num_resource: 32
-                        type: 13386
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 156
-                        num_resource: 12
-                        type: 13386
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 12
-                        type: 13386
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 180
-                        num_resource: 12
-                        type: 13386
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 192
-                        num_resource: 12
-                        type: 13386
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 204
-                        num_resource: 12
-                        type: 13386
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 216
-                        num_resource: 28
-                        type: 13386
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 244
-                        num_resource: 8
-                        type: 13386
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 252
-                        num_resource: 4
-                        type: 13386
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 1024
-                        type: 13389
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 1062
-                        num_resource: 512
-                        type: 13389
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 1574
-                        num_resource: 32
-                        type: 13389
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 1606
-                        num_resource: 32
-                        type: 13389
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 1638
-                        num_resource: 256
-                        type: 13389
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 1894
-                        num_resource: 256
-                        type: 13389
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 2150
-                        num_resource: 256
-                        type: 13389
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 2406
-                        num_resource: 256
-                        type: 13389
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 2662
-                        num_resource: 256
-                        type: 13389
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 2918
-                        num_resource: 512
-                        type: 13389
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 3430
-                        num_resource: 256
-                        type: 13389
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 3686
-                        num_resource: 922
-                        type: 13389
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 4
-                        type: 13440
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13440
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 4
-                        type: 13440
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 4
-                        type: 13440
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 4
-                        type: 13440
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 4
-                        type: 13440
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 4
-                        type: 13440
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 4
-                        type: 13440
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 4
-                        type: 13440
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 12
-                        type: 13440
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 4
-                        type: 13440
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 52
-                        num_resource: 12
-                        type: 13440
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13504
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 440
-                        num_resource: 150
-                        type: 13505
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 590
-                        num_resource: 40
-                        type: 13505
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 630
-                        num_resource: 6
-                        type: 13505
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 636
-                        num_resource: 6
-                        type: 13505
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 642
-                        num_resource: 10
-                        type: 13505
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 652
-                        num_resource: 10
-                        type: 13505
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 662
-                        num_resource: 32
-                        type: 13505
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 694
-                        num_resource: 38
-                        type: 13505
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 732
-                        num_resource: 12
-                        type: 13505
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 744
-                        num_resource: 182
-                        type: 13505
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 926
-                        num_resource: 40
-                        type: 13505
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 966
-                        num_resource: 8
-                        type: 13505
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 316
-                        num_resource: 8
-                        type: 13506
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 324
-                        num_resource: 2
-                        type: 13506
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 324
-                        num_resource: 0
-                        type: 13506
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 326
-                        num_resource: 2
-                        type: 13506
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 328
-                        num_resource: 2
-                        type: 13506
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 330
-                        num_resource: 2
-                        type: 13506
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 332
-                        num_resource: 2
-                        type: 13506
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 334
-                        num_resource: 8
-                        type: 13506
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 342
-                        num_resource: 2
-                        type: 13506
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 344
-                        num_resource: 4
-                        type: 13506
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 348
-                        num_resource: 1
-                        type: 13506
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 349
-                        num_resource: 47
-                        type: 13506
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 396
-                        num_resource: 1
-                        type: 13506
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 397
-                        num_resource: 4
-                        type: 13506
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 401
-                        num_resource: 4
-                        type: 13506
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 405
-                        num_resource: 4
-                        type: 13506
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 409
-                        num_resource: 8
-                        type: 13506
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 417
-                        num_resource: 6
-                        type: 13506
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 423
-                        num_resource: 16
-                        type: 13506
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 439
-                        num_resource: 1
-                        type: 13506
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 13507
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 13507
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 0
-                        type: 13507
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 2
-                        type: 13507
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 2
-                        type: 13507
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 2
-                        type: 13507
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 2
-                        type: 13507
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 8
-                        type: 13507
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 2
-                        type: 13507
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 4
-                        type: 13507
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 1
-                        type: 13507
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 49
-                        num_resource: 47
-                        type: 13507
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 1
-                        type: 13507
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 97
-                        num_resource: 4
-                        type: 13507
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 101
-                        num_resource: 4
-                        type: 13507
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 105
-                        num_resource: 4
-                        type: 13507
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 109
-                        num_resource: 8
-                        type: 13507
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 117
-                        num_resource: 6
-                        type: 13507
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 123
-                        num_resource: 10
-                        type: 13507
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 133
-                        num_resource: 6
-                        type: 13507
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 139
-                        num_resource: 1
-                        type: 13507
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 140
-                        num_resource: 16
-                        type: 13508
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 156
-                        num_resource: 6
-                        type: 13508
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 162
-                        num_resource: 6
-                        type: 13508
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 2
-                        type: 13508
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 170
-                        num_resource: 2
-                        type: 13508
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 172
-                        num_resource: 96
-                        type: 13508
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 268
-                        num_resource: 32
-                        type: 13508
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 304
-                        num_resource: 0
-                        type: 13509
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 304
-                        num_resource: 4
-                        type: 13509
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 304
-                        num_resource: 0
-                        type: 13509
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 308
-                        num_resource: 6
-                        type: 13509
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 314
-                        num_resource: 2
-                        type: 13509
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 300
-                        num_resource: 0
-                        type: 13510
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 300
-                        num_resource: 2
-                        type: 13510
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 300
-                        num_resource: 0
-                        type: 13510
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 302
-                        num_resource: 2
-                        type: 13510
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13511
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13511
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13511
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 6
-                        type: 13511
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13511
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13512
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13512
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13512
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 2
-                        type: 13512
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 5
-                        type: 13514
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 1
-                        type: 13514
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 3
-                        type: 13515
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 2
-                        type: 13515
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 1
-                        type: 13515
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 1
-                        type: 13515
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 3
-                        type: 13515
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 3
-                        type: 13515
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 3
-                        type: 13515
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 3
-                        type: 13515
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 19
-                        num_resource: 3
-                        type: 13515
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 22
-                        num_resource: 6
-                        type: 13515
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 3
-                        type: 13515
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 31
-                        num_resource: 1
-                        type: 13515
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 140
-                        num_resource: 16
-                        type: 13568
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 156
-                        num_resource: 16
-                        type: 13568
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 172
-                        num_resource: 128
-                        type: 13568
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13569
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 49152
-                        num_resource: 1024
-                        type: 13570
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 13571
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 13578
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 13578
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 0
-                        type: 13578
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 2
-                        type: 13578
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 2
-                        type: 13578
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 2
-                        type: 13578
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 2
-                        type: 13578
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 8
-                        type: 13578
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 2
-                        type: 13578
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 4
-                        type: 13578
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 1
-                        type: 13578
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 49
-                        num_resource: 47
-                        type: 13578
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 1
-                        type: 13578
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 97
-                        num_resource: 4
-                        type: 13578
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 101
-                        num_resource: 4
-                        type: 13578
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 105
-                        num_resource: 4
-                        type: 13578
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 109
-                        num_resource: 8
-                        type: 13578
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 117
-                        num_resource: 6
-                        type: 13578
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 123
-                        num_resource: 16
-                        type: 13578
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 139
-                        num_resource: 1
-                        type: 13578
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13579
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13579
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13579
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 6
-                        type: 13579
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13579
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13580
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13580
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13580
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 2
-                        type: 13580
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 8
-                        type: 13581
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 2
-                        type: 13581
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 0
-                        type: 13581
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 2
-                        type: 13581
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 28
-                        num_resource: 2
-                        type: 13581
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 2
-                        type: 13581
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 32
-                        num_resource: 2
-                        type: 13581
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 34
-                        num_resource: 8
-                        type: 13581
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 2
-                        type: 13581
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 44
-                        num_resource: 4
-                        type: 13581
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 1
-                        type: 13581
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 49
-                        num_resource: 47
-                        type: 13581
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 1
-                        type: 13581
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 97
-                        num_resource: 4
-                        type: 13581
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 101
-                        num_resource: 4
-                        type: 13581
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 105
-                        num_resource: 4
-                        type: 13581
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 109
-                        num_resource: 8
-                        type: 13581
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 117
-                        num_resource: 6
-                        type: 13581
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 123
-                        num_resource: 10
-                        type: 13581
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 133
-                        num_resource: 6
-                        type: 13581
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 139
-                        num_resource: 1
-                        type: 13581
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 140
-                        num_resource: 16
-                        type: 13582
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 156
-                        num_resource: 6
-                        type: 13582
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 162
-                        num_resource: 6
-                        type: 13582
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 2
-                        type: 13582
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 170
-                        num_resource: 2
-                        type: 13582
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 172
-                        num_resource: 96
-                        type: 13582
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 268
-                        num_resource: 32
-                        type: 13582
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13583
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 4
-                        type: 13583
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 4
-                        num_resource: 0
-                        type: 13583
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 6
-                        type: 13583
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 2
-                        type: 13583
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13584
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 13584
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 13584
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 2
-                        type: 13584
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 100
-                        type: 13632
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 110
-                        num_resource: 32
-                        type: 13632
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 142
-                        num_resource: 46
-                        type: 13632
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 196
-                        num_resource: 28
-                        type: 13632
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 228
-                        num_resource: 28
-                        type: 13632
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 260
-                        num_resource: 28
-                        type: 13632
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 292
-                        num_resource: 28
-                        type: 13632
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 320
-                        num_resource: 24
-                        type: 13632
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 352
-                        num_resource: 24
-                        type: 13632
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 400
-                        num_resource: 4
-                        type: 13632
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 404
-                        num_resource: 4
-                        type: 13632
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16
-                        num_resource: 32
-                        type: 14922
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 16
-                        type: 14922
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 64
-                        num_resource: 64
-                        type: 14922
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 128
-                        num_resource: 4
-                        type: 14922
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 132
-                        num_resource: 16
-                        type: 14922
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 148
-                        num_resource: 16
-                        type: 14922
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 164
-                        num_resource: 8
-                        type: 14922
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 172
-                        num_resource: 8
-                        type: 14922
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 180
-                        num_resource: 8
-                        type: 14922
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 188
-                        num_resource: 24
-                        type: 14922
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 212
-                        num_resource: 8
-                        type: 14922
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 220
-                        num_resource: 36
-                        type: 14922
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 16400
-                        num_resource: 128
-                        type: 14925
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 16528
-                        num_resource: 128
-                        type: 14925
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 16656
-                        num_resource: 256
-                        type: 14925
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 16912
-                        num_resource: 64
-                        type: 14925
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 16976
-                        num_resource: 128
-                        type: 14925
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 17104
-                        num_resource: 128
-                        type: 14925
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 17232
-                        num_resource: 64
-                        type: 14925
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 17296
-                        num_resource: 64
-                        type: 14925
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 17360
-                        num_resource: 64
-                        type: 14925
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 17424
-                        num_resource: 128
-                        type: 14925
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 17552
-                        num_resource: 128
-                        type: 14925
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 17680
-                        num_resource: 240
-                        type: 14925
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 1
-                        num_resource: 4
-                        type: 14976
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 4
-                        type: 14976
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 4
-                        type: 14976
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 4
-                        type: 14976
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 17
-                        num_resource: 4
-                        type: 14976
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 21
-                        num_resource: 4
-                        type: 14976
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 25
-                        num_resource: 4
-                        type: 14976
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 29
-                        num_resource: 4
-                        type: 14976
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 33
-                        num_resource: 4
-                        type: 14976
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 37
-                        num_resource: 16
-                        type: 14976
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 53
-                        num_resource: 4
-                        type: 14976
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 57
-                        num_resource: 7
-                        type: 14976
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15040
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 96
-                        num_resource: 20
-                        type: 15041
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 116
-                        num_resource: 8
-                        type: 15041
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 124
-                        num_resource: 32
-                        type: 15041
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 156
-                        num_resource: 12
-                        type: 15041
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 168
-                        num_resource: 8
-                        type: 15041
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 176
-                        num_resource: 8
-                        type: 15041
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 184
-                        num_resource: 8
-                        type: 15041
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 192
-                        num_resource: 8
-                        type: 15041
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 200
-                        num_resource: 8
-                        type: 15041
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 208
-                        num_resource: 16
-                        type: 15041
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 224
-                        num_resource: 8
-                        type: 15041
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 232
-                        num_resource: 20
-                        type: 15041
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 50
-                        num_resource: 4
-                        type: 15042
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 54
-                        num_resource: 2
-                        type: 15042
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 54
-                        num_resource: 0
-                        type: 15042
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 56
-                        num_resource: 0
-                        type: 15042
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 56
-                        num_resource: 1
-                        type: 15042
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 57
-                        num_resource: 1
-                        type: 15042
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 58
-                        num_resource: 1
-                        type: 15042
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 59
-                        num_resource: 1
-                        type: 15042
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 1
-                        type: 15042
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 61
-                        num_resource: 1
-                        type: 15042
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 62
-                        num_resource: 1
-                        type: 15042
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 63
-                        num_resource: 9
-                        type: 15042
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 72
-                        num_resource: 6
-                        type: 15042
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 78
-                        num_resource: 3
-                        type: 15042
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 81
-                        num_resource: 2
-                        type: 15042
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 83
-                        num_resource: 1
-                        type: 15042
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 84
-                        num_resource: 1
-                        type: 15042
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 85
-                        num_resource: 1
-                        type: 15042
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 86
-                        num_resource: 1
-                        type: 15042
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 87
-                        num_resource: 1
-                        type: 15042
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 88
-                        num_resource: 2
-                        type: 15042
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 90
-                        num_resource: 1
-                        type: 15042
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 91
-                        num_resource: 2
-                        type: 15042
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 4
-                        type: 15043
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 2
-                        type: 15043
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 0
-                        type: 15043
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 0
-                        type: 15043
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 1
-                        type: 15043
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 1
-                        type: 15043
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 1
-                        type: 15043
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 1
-                        type: 15043
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 1
-                        type: 15043
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 1
-                        type: 15043
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 1
-                        type: 15043
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15043
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 6
-                        type: 15043
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 3
-                        type: 15043
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 33
-                        num_resource: 2
-                        type: 15043
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 35
-                        num_resource: 1
-                        type: 15043
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 1
-                        type: 15043
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 37
-                        num_resource: 1
-                        type: 15043
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 1
-                        type: 15043
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 39
-                        num_resource: 1
-                        type: 15043
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 2
-                        type: 15043
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 1
-                        type: 15043
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 43
-                        num_resource: 3
-                        type: 15043
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 0
-                        type: 15045
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 2
-                        type: 15045
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15047
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 15047
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 5
-                        type: 15050
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 7
-                        num_resource: 1
-                        type: 15050
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 3
-                        type: 15051
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 3
-                        num_resource: 2
-                        type: 15051
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 5
-                        num_resource: 3
-                        type: 15051
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 3
-                        type: 15051
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 3
-                        type: 15051
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 3
-                        type: 15051
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 17
-                        num_resource: 3
-                        type: 15051
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 20
-                        num_resource: 3
-                        type: 15051
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 23
-                        num_resource: 3
-                        type: 15051
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 26
-                        num_resource: 3
-                        type: 15051
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 29
-                        num_resource: 3
-                        type: 15051
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 48
-                        num_resource: 8
-                        type: 15104
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 56
-                        num_resource: 4
-                        type: 15104
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 60
-                        num_resource: 8
-                        type: 15104
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 68
-                        num_resource: 4
-                        type: 15104
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 72
-                        num_resource: 4
-                        type: 15104
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 76
-                        num_resource: 4
-                        type: 15104
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 80
-                        num_resource: 8
-                        type: 15104
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 88
-                        num_resource: 4
-                        type: 15104
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 92
-                        num_resource: 4
-                        type: 15104
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15105
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 56320
-                        num_resource: 256
-                        type: 15106
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 1
-                        type: 15107
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 4
-                        type: 15114
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 2
-                        type: 15114
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 0
-                        type: 15114
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 0
-                        type: 15114
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 1
-                        type: 15114
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 1
-                        type: 15114
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 1
-                        type: 15114
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 1
-                        type: 15114
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 1
-                        type: 15114
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 1
-                        type: 15114
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 1
-                        type: 15114
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15114
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 6
-                        type: 15114
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 3
-                        type: 15114
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 33
-                        num_resource: 2
-                        type: 15114
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 35
-                        num_resource: 1
-                        type: 15114
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 1
-                        type: 15114
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 37
-                        num_resource: 1
-                        type: 15114
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 1
-                        type: 15114
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 39
-                        num_resource: 1
-                        type: 15114
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 2
-                        type: 15114
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 1
-                        type: 15114
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 43
-                        num_resource: 2
-                        type: 15114
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15115
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 15115
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 2
-                        num_resource: 4
-                        type: 15117
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 2
-                        type: 15117
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 6
-                        num_resource: 0
-                        type: 15117
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 0
-                        type: 15117
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 8
-                        num_resource: 1
-                        type: 15117
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 9
-                        num_resource: 1
-                        type: 15117
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 10
-                        num_resource: 1
-                        type: 15117
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 11
-                        num_resource: 1
-                        type: 15117
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 1
-                        type: 15117
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 13
-                        num_resource: 1
-                        type: 15117
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 14
-                        num_resource: 1
-                        type: 15117
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 15
-                        num_resource: 9
-                        type: 15117
-                        host_id: 12
-                        reserved: 0
-                -
-                        start_resource: 24
-                        num_resource: 6
-                        type: 15117
-                        host_id: 13
-                        reserved: 0
-                -
-                        start_resource: 30
-                        num_resource: 3
-                        type: 15117
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 33
-                        num_resource: 2
-                        type: 15117
-                        host_id: 5
-                        reserved: 0
-                -
-                        start_resource: 35
-                        num_resource: 1
-                        type: 15117
-                        host_id: 40
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 1
-                        type: 15117
-                        host_id: 42
-                        reserved: 0
-                -
-                        start_resource: 37
-                        num_resource: 1
-                        type: 15117
-                        host_id: 21
-                        reserved: 0
-                -
-                        start_resource: 38
-                        num_resource: 1
-                        type: 15117
-                        host_id: 26
-                        reserved: 0
-                -
-                        start_resource: 39
-                        num_resource: 1
-                        type: 15117
-                        host_id: 28
-                        reserved: 0
-                -
-                        start_resource: 40
-                        num_resource: 2
-                        type: 15117
-                        host_id: 35
-                        reserved: 0
-                -
-                        start_resource: 42
-                        num_resource: 1
-                        type: 15117
-                        host_id: 37
-                        reserved: 0
-                -
-                        start_resource: 43
-                        num_resource: 3
-                        type: 15117
-                        host_id: 128
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 0
-                        type: 15119
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 0
-                        num_resource: 2
-                        type: 15119
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 12
-                        num_resource: 20
-                        type: 15168
-                        host_id: 3
-                        reserved: 0
-                -
-                        start_resource: 36
-                        num_resource: 28
-                        type: 15168
-                        host_id: 5
-                        reserved: 0
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
+                    host_id: 21
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 6
+                    host_id: 26
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 7
+                    host_id: 28
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 8
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 9
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 10
+                    host_id: 40
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 11
+                    host_id: 42
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 3344
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 4
+            num_resource: 93
+            type: 7744
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 93
+            type: 7808
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 32
+            type: 7872
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 32
+            type: 8192
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 32
+            type: 8192
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 24
+            type: 8320
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 24
+            type: 8320
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 8384
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 8
+            type: 8384
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 8384
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 4
+            type: 8384
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 8384
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 8384
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 4
+            type: 8384
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 4
+            type: 8384
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 12
+            type: 8384
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 12
+            type: 8384
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 128
+            type: 8576
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 128
+            type: 8576
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 128
+            type: 8640
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 128
+            type: 8640
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 48
+            type: 8704
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 8768
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 8
+            type: 8768
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 8768
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 8768
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 8768
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 8768
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 64
+            type: 13258
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 20480
+            num_resource: 1024
+            type: 13261
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 64
+            type: 13322
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 22528
+            num_resource: 1024
+            type: 13325
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 86
+            type: 13386
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 32
+            type: 13386
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 156
+            num_resource: 12
+            type: 13386
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 12
+            type: 13386
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 180
+            num_resource: 12
+            type: 13386
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 192
+            num_resource: 12
+            type: 13386
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 204
+            num_resource: 12
+            type: 13386
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 216
+            num_resource: 28
+            type: 13386
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 244
+            num_resource: 8
+            type: 13386
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 252
+            num_resource: 4
+            type: 13386
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 1024
+            type: 13389
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 1062
+            num_resource: 512
+            type: 13389
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 1574
+            num_resource: 32
+            type: 13389
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 1606
+            num_resource: 32
+            type: 13389
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 1638
+            num_resource: 256
+            type: 13389
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 1894
+            num_resource: 256
+            type: 13389
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 2150
+            num_resource: 256
+            type: 13389
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 2406
+            num_resource: 256
+            type: 13389
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 2662
+            num_resource: 256
+            type: 13389
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 2918
+            num_resource: 512
+            type: 13389
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 3430
+            num_resource: 256
+            type: 13389
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 3686
+            num_resource: 922
+            type: 13389
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 13440
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13440
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 4
+            type: 13440
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 4
+            type: 13440
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 13440
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 4
+            type: 13440
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 13440
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 13440
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 4
+            type: 13440
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 12
+            type: 13440
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 4
+            type: 13440
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 12
+            type: 13440
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13504
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 440
+            num_resource: 150
+            type: 13505
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 590
+            num_resource: 40
+            type: 13505
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 630
+            num_resource: 6
+            type: 13505
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 636
+            num_resource: 6
+            type: 13505
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 642
+            num_resource: 10
+            type: 13505
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 652
+            num_resource: 10
+            type: 13505
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 662
+            num_resource: 32
+            type: 13505
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 694
+            num_resource: 38
+            type: 13505
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 732
+            num_resource: 12
+            type: 13505
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 744
+            num_resource: 182
+            type: 13505
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 926
+            num_resource: 40
+            type: 13505
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 966
+            num_resource: 8
+            type: 13505
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 316
+            num_resource: 8
+            type: 13506
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 324
+            num_resource: 2
+            type: 13506
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 324
+            num_resource: 0
+            type: 13506
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 326
+            num_resource: 2
+            type: 13506
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 328
+            num_resource: 2
+            type: 13506
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 330
+            num_resource: 2
+            type: 13506
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 332
+            num_resource: 2
+            type: 13506
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 334
+            num_resource: 8
+            type: 13506
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 342
+            num_resource: 2
+            type: 13506
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 344
+            num_resource: 4
+            type: 13506
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 348
+            num_resource: 1
+            type: 13506
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 349
+            num_resource: 47
+            type: 13506
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 396
+            num_resource: 1
+            type: 13506
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 397
+            num_resource: 4
+            type: 13506
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 401
+            num_resource: 4
+            type: 13506
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 405
+            num_resource: 4
+            type: 13506
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 409
+            num_resource: 8
+            type: 13506
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 417
+            num_resource: 6
+            type: 13506
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 423
+            num_resource: 16
+            type: 13506
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 439
+            num_resource: 1
+            type: 13506
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 13507
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 13507
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 0
+            type: 13507
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 13507
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 13507
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 13507
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 2
+            type: 13507
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 8
+            type: 13507
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 2
+            type: 13507
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 4
+            type: 13507
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 1
+            type: 13507
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 49
+            num_resource: 47
+            type: 13507
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 1
+            type: 13507
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 97
+            num_resource: 4
+            type: 13507
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 101
+            num_resource: 4
+            type: 13507
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 105
+            num_resource: 4
+            type: 13507
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 8
+            type: 13507
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 117
+            num_resource: 6
+            type: 13507
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 123
+            num_resource: 10
+            type: 13507
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 133
+            num_resource: 6
+            type: 13507
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 139
+            num_resource: 1
+            type: 13507
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 140
+            num_resource: 16
+            type: 13508
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 156
+            num_resource: 6
+            type: 13508
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 162
+            num_resource: 6
+            type: 13508
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 2
+            type: 13508
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 170
+            num_resource: 2
+            type: 13508
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 172
+            num_resource: 96
+            type: 13508
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 268
+            num_resource: 32
+            type: 13508
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 304
+            num_resource: 0
+            type: 13509
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 304
+            num_resource: 4
+            type: 13509
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 304
+            num_resource: 0
+            type: 13509
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 308
+            num_resource: 6
+            type: 13509
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 314
+            num_resource: 2
+            type: 13509
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 300
+            num_resource: 0
+            type: 13510
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 300
+            num_resource: 2
+            type: 13510
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 300
+            num_resource: 0
+            type: 13510
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 302
+            num_resource: 2
+            type: 13510
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13511
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13511
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13511
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 6
+            type: 13511
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13511
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13512
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13512
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13512
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 13512
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 5
+            type: 13514
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 1
+            type: 13514
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 3
+            type: 13515
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 2
+            type: 13515
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 1
+            type: 13515
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 1
+            type: 13515
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 3
+            type: 13515
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 13515
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 13515
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 13515
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 3
+            type: 13515
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 13515
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 3
+            type: 13515
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 31
+            num_resource: 1
+            type: 13515
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 140
+            num_resource: 16
+            type: 13568
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 156
+            num_resource: 16
+            type: 13568
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 172
+            num_resource: 128
+            type: 13568
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13569
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 49152
+            num_resource: 1024
+            type: 13570
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 13571
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 13578
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 13578
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 0
+            type: 13578
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 13578
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 13578
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 13578
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 2
+            type: 13578
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 8
+            type: 13578
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 2
+            type: 13578
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 4
+            type: 13578
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 1
+            type: 13578
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 49
+            num_resource: 47
+            type: 13578
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 1
+            type: 13578
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 97
+            num_resource: 4
+            type: 13578
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 101
+            num_resource: 4
+            type: 13578
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 105
+            num_resource: 4
+            type: 13578
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 8
+            type: 13578
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 117
+            num_resource: 6
+            type: 13578
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 123
+            num_resource: 16
+            type: 13578
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 139
+            num_resource: 1
+            type: 13578
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13579
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13579
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13579
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 6
+            type: 13579
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13579
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13580
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13580
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13580
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 13580
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 8
+            type: 13581
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 13581
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 0
+            type: 13581
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 13581
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 13581
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 13581
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 2
+            type: 13581
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 8
+            type: 13581
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 2
+            type: 13581
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 4
+            type: 13581
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 1
+            type: 13581
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 49
+            num_resource: 47
+            type: 13581
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 1
+            type: 13581
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 97
+            num_resource: 4
+            type: 13581
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 101
+            num_resource: 4
+            type: 13581
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 105
+            num_resource: 4
+            type: 13581
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 8
+            type: 13581
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 117
+            num_resource: 6
+            type: 13581
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 123
+            num_resource: 10
+            type: 13581
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 133
+            num_resource: 6
+            type: 13581
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 139
+            num_resource: 1
+            type: 13581
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 140
+            num_resource: 16
+            type: 13582
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 156
+            num_resource: 6
+            type: 13582
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 162
+            num_resource: 6
+            type: 13582
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 2
+            type: 13582
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 170
+            num_resource: 2
+            type: 13582
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 172
+            num_resource: 96
+            type: 13582
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 268
+            num_resource: 32
+            type: 13582
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13583
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 13583
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 0
+            type: 13583
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 6
+            type: 13583
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 2
+            type: 13583
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13584
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 13584
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 13584
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 13584
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 100
+            type: 13632
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 110
+            num_resource: 32
+            type: 13632
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 46
+            type: 13632
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 196
+            num_resource: 28
+            type: 13632
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 228
+            num_resource: 28
+            type: 13632
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 260
+            num_resource: 28
+            type: 13632
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 292
+            num_resource: 28
+            type: 13632
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 320
+            num_resource: 24
+            type: 13632
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 352
+            num_resource: 24
+            type: 13632
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 400
+            num_resource: 4
+            type: 13632
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 404
+            num_resource: 4
+            type: 13632
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 32
+            type: 14922
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 16
+            type: 14922
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 64
+            num_resource: 64
+            type: 14922
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 128
+            num_resource: 4
+            type: 14922
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 132
+            num_resource: 16
+            type: 14922
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 148
+            num_resource: 16
+            type: 14922
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 164
+            num_resource: 8
+            type: 14922
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 172
+            num_resource: 8
+            type: 14922
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 180
+            num_resource: 8
+            type: 14922
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 188
+            num_resource: 24
+            type: 14922
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 212
+            num_resource: 8
+            type: 14922
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 220
+            num_resource: 36
+            type: 14922
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 16400
+            num_resource: 128
+            type: 14925
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16528
+            num_resource: 128
+            type: 14925
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 16656
+            num_resource: 256
+            type: 14925
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 16912
+            num_resource: 64
+            type: 14925
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 16976
+            num_resource: 128
+            type: 14925
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 17104
+            num_resource: 128
+            type: 14925
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 17232
+            num_resource: 64
+            type: 14925
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 17296
+            num_resource: 64
+            type: 14925
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 17360
+            num_resource: 64
+            type: 14925
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 17424
+            num_resource: 128
+            type: 14925
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 17552
+            num_resource: 128
+            type: 14925
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 17680
+            num_resource: 240
+            type: 14925
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 1
+            num_resource: 4
+            type: 14976
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 4
+            type: 14976
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 4
+            type: 14976
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 4
+            type: 14976
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 17
+            num_resource: 4
+            type: 14976
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 4
+            type: 14976
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 4
+            type: 14976
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 29
+            num_resource: 4
+            type: 14976
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 33
+            num_resource: 4
+            type: 14976
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 37
+            num_resource: 16
+            type: 14976
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 53
+            num_resource: 4
+            type: 14976
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 7
+            type: 14976
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15040
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 96
+            num_resource: 20
+            type: 15041
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 116
+            num_resource: 8
+            type: 15041
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 32
+            type: 15041
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 156
+            num_resource: 12
+            type: 15041
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 15041
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 176
+            num_resource: 8
+            type: 15041
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 184
+            num_resource: 8
+            type: 15041
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 192
+            num_resource: 8
+            type: 15041
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 200
+            num_resource: 8
+            type: 15041
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 208
+            num_resource: 16
+            type: 15041
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 224
+            num_resource: 8
+            type: 15041
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 232
+            num_resource: 20
+            type: 15041
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 4
+            type: 15042
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 2
+            type: 15042
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 0
+            type: 15042
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 56
+            num_resource: 0
+            type: 15042
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 56
+            num_resource: 1
+            type: 15042
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 1
+            type: 15042
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 58
+            num_resource: 1
+            type: 15042
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 59
+            num_resource: 1
+            type: 15042
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 1
+            type: 15042
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 61
+            num_resource: 1
+            type: 15042
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 62
+            num_resource: 1
+            type: 15042
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 63
+            num_resource: 9
+            type: 15042
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 15042
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 3
+            type: 15042
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 81
+            num_resource: 2
+            type: 15042
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 1
+            type: 15042
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 1
+            type: 15042
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 85
+            num_resource: 1
+            type: 15042
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 86
+            num_resource: 1
+            type: 15042
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 87
+            num_resource: 1
+            type: 15042
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 88
+            num_resource: 2
+            type: 15042
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 90
+            num_resource: 1
+            type: 15042
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 2
+            type: 15042
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 4
+            type: 15043
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 2
+            type: 15043
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 0
+            type: 15043
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 0
+            type: 15043
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 1
+            type: 15043
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 1
+            type: 15043
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 1
+            type: 15043
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 1
+            type: 15043
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 1
+            type: 15043
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 1
+            type: 15043
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 1
+            type: 15043
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15043
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 6
+            type: 15043
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 3
+            type: 15043
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 33
+            num_resource: 2
+            type: 15043
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 1
+            type: 15043
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 1
+            type: 15043
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 37
+            num_resource: 1
+            type: 15043
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 1
+            type: 15043
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 39
+            num_resource: 1
+            type: 15043
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 2
+            type: 15043
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 1
+            type: 15043
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 3
+            type: 15043
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 0
+            type: 15045
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 2
+            type: 15045
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15047
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 15047
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 5
+            type: 15050
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 1
+            type: 15050
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 3
+            type: 15051
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 2
+            type: 15051
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 3
+            type: 15051
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 3
+            type: 15051
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 3
+            type: 15051
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 3
+            type: 15051
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 17
+            num_resource: 3
+            type: 15051
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 3
+            type: 15051
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 3
+            type: 15051
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 3
+            type: 15051
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 29
+            num_resource: 3
+            type: 15051
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 48
+            num_resource: 8
+            type: 15104
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 56
+            num_resource: 4
+            type: 15104
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 60
+            num_resource: 8
+            type: 15104
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 68
+            num_resource: 4
+            type: 15104
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 4
+            type: 15104
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 76
+            num_resource: 4
+            type: 15104
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 8
+            type: 15104
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 88
+            num_resource: 4
+            type: 15104
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 92
+            num_resource: 4
+            type: 15104
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15105
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 56320
+            num_resource: 256
+            type: 15106
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 15107
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 4
+            type: 15114
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 2
+            type: 15114
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 0
+            type: 15114
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 0
+            type: 15114
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 1
+            type: 15114
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 1
+            type: 15114
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 1
+            type: 15114
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 1
+            type: 15114
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 1
+            type: 15114
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 1
+            type: 15114
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 1
+            type: 15114
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15114
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 6
+            type: 15114
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 3
+            type: 15114
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 33
+            num_resource: 2
+            type: 15114
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 1
+            type: 15114
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 1
+            type: 15114
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 37
+            num_resource: 1
+            type: 15114
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 1
+            type: 15114
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 39
+            num_resource: 1
+            type: 15114
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 2
+            type: 15114
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 1
+            type: 15114
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 2
+            type: 15114
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15115
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 15115
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 4
+            type: 15117
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 2
+            type: 15117
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 0
+            type: 15117
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 0
+            type: 15117
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 1
+            type: 15117
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 9
+            num_resource: 1
+            type: 15117
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 1
+            type: 15117
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 11
+            num_resource: 1
+            type: 15117
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 1
+            type: 15117
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 1
+            type: 15117
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 1
+            type: 15117
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 15
+            num_resource: 9
+            type: 15117
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 6
+            type: 15117
+            host_id: 13
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 3
+            type: 15117
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 33
+            num_resource: 2
+            type: 15117
+            host_id: 5
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 1
+            type: 15117
+            host_id: 40
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 1
+            type: 15117
+            host_id: 42
+            reserved: 0
+        -
+            start_resource: 37
+            num_resource: 1
+            type: 15117
+            host_id: 21
+            reserved: 0
+        -
+            start_resource: 38
+            num_resource: 1
+            type: 15117
+            host_id: 26
+            reserved: 0
+        -
+            start_resource: 39
+            num_resource: 1
+            type: 15117
+            host_id: 28
+            reserved: 0
+        -
+            start_resource: 40
+            num_resource: 2
+            type: 15117
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 42
+            num_resource: 1
+            type: 15117
+            host_id: 37
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 3
+            type: 15117
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 0
+            type: 15119
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 15119
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 20
+            type: 15168
+            host_id: 3
+            reserved: 0
+        -
+            start_resource: 36
+            num_resource: 28
+            type: 15168
+            host_id: 5
+            reserved: 0
diff --git a/board/ti/j722s/rm-cfg.yaml b/board/ti/j722s/rm-cfg.yaml
index e32beb84795..62730adf216 100644
--- a/board/ti/j722s/rm-cfg.yaml
+++ b/board/ti/j722s/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J722S
 #
@@ -16,224 +16,224 @@ rm-cfg:
                 magic: 0x4C41
                 size: 356
             host_cfg_entries:
-                -
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 2
                     host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 3
                     host_id: 22
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 4
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 5
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 6
                     host_id: 38
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                -
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                -
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
diff --git a/board/ti/j722s/tifs-rm-cfg.yaml b/board/ti/j722s/tifs-rm-cfg.yaml
index 4a2af0ebcaf..7b2e58a89b3 100644
--- a/board/ti/j722s/tifs-rm-cfg.yaml
+++ b/board/ti/j722s/tifs-rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J722S
 #
@@ -16,224 +16,224 @@ tifs-rm-cfg:
                 magic: 0x4C41
                 size: 356
             host_cfg_entries:
-                - #1
+                -  # 1
                     host_id: 12
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #2
+                -  # 2
                     host_id: 20
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #3
+                -  # 3
                     host_id: 22
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #4
+                -  # 4
                     host_id: 30
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #5
+                -  # 5
                     host_id: 36
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #6
+                -  # 6
                     host_id: 38
                     allowed_atype: 0x2A
                     allowed_qos: 0xAAAA
                     allowed_orderid: 0xAAAAAAAA
                     allowed_priority: 0xAAAA
                     allowed_sched_priority: 0xAA
-                - #7
+                -  # 7
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #8
+                -  # 8
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #9
+                -  # 9
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #10
+                -  # 10
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #11
+                -  # 11
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #12
+                -  # 12
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #13
+                -  # 13
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #14
+                -  # 14
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #15
+                -  # 15
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #16
+                -  # 16
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #17
+                -  # 17
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #18
+                -  # 18
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #19
+                -  # 19
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #20
+                -  # 20
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #21
+                -  # 21
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #22
+                -  # 22
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #23
+                -  # 23
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #24
+                -  # 24
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #25
+                -  # 25
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #26
+                -  # 26
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #27
+                -  # 27
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #28
+                -  # 28
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #29
+                -  # 29
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #30
+                -  # 30
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #31
+                -  # 31
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
                     allowed_orderid: 0
                     allowed_priority: 0
                     allowed_sched_priority: 0
-                - #32
+                -  # 32
                     host_id: 0
                     allowed_atype: 0
                     allowed_qos: 0
@@ -248,746 +248,746 @@ tifs-rm-cfg:
             reserved: 0
     resasg_entries:
         -
-                start_resource: 0
-                num_resource: 16
-                type: 1677
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 6
-                type: 1677
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 6
-                type: 1677
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 2
-                type: 1677
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 4
-                type: 1677
-                host_id: 22
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 4
-                type: 1677
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 57
-                num_resource: 16
-                type: 1678
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 73
-                num_resource: 5
-                type: 1678
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 73
-                num_resource: 5
-                type: 1678
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 78
-                num_resource: 2
-                type: 1678
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 80
-                num_resource: 2
-                type: 1678
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 32
-                num_resource: 12
-                type: 1679
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 6
-                type: 1679
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 50
-                num_resource: 2
-                type: 1679
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 52
-                num_resource: 2
-                type: 1679
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 54
-                num_resource: 3
-                type: 1679
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 16
-                type: 1696
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 6
-                type: 1696
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 6
-                type: 1696
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 2
-                type: 1696
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 24
-                num_resource: 4
-                type: 1696
-                host_id: 22
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 4
-                type: 1696
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 16
-                type: 1697
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 5
-                type: 1697
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 5
-                type: 1697
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 2
-                type: 1697
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 2
-                type: 1697
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 12
-                type: 1698
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 12
-                num_resource: 6
-                type: 1698
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 18
-                num_resource: 2
-                type: 1698
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 2
-                type: 1698
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 3
-                type: 1698
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 7
-                num_resource: 21
-                type: 1802
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 44
-                num_resource: 36
-                type: 1802
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 84
-                num_resource: 16
-                type: 1802
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 100
-                num_resource: 16
-                type: 1802
-                host_id: 22
-                reserved: 0
-        -
-                start_resource: 154
-                num_resource: 14
-                type: 1802
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 168
-                num_resource: 16
-                type: 1802
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 29
-                type: 1807
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4608
-                num_resource: 99
-                type: 1808
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5120
-                num_resource: 24
-                type: 1809
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 5632
-                num_resource: 51
-                type: 1810
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 6144
-                num_resource: 51
-                type: 1811
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8192
-                num_resource: 32
-                type: 1812
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 8704
-                num_resource: 32
-                type: 1813
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9216
-                num_resource: 32
-                type: 1814
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 9728
-                num_resource: 25
-                type: 1815
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10240
-                num_resource: 25
-                type: 1816
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 10752
-                num_resource: 25
-                type: 1817
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11264
-                num_resource: 25
-                type: 1818
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 11776
-                num_resource: 25
-                type: 1819
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 12288
-                num_resource: 25
-                type: 1820
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1936
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1936
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1936
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1936
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 64
-                type: 1937
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 83
-                num_resource: 8
-                type: 1938
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 91
-                num_resource: 8
-                type: 1939
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 99
-                num_resource: 10
-                type: 1942
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 109
-                num_resource: 3
-                type: 1942
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 112
-                num_resource: 3
-                type: 1942
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 115
-                num_resource: 3
-                type: 1942
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 118
-                num_resource: 16
-                type: 1943
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1944
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 134
-                num_resource: 8
-                type: 1945
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1946
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 142
-                num_resource: 8
-                type: 1947
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1955
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1955
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1955
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1955
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 8
-                type: 1956
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 27
-                num_resource: 1
-                type: 1957
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 28
-                num_resource: 1
-                type: 1958
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1961
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1961
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1961
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1961
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 10
-                type: 1962
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 35
-                reserved: 0
-        -
-                start_resource: 10
-                num_resource: 3
-                type: 1962
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 13
-                num_resource: 3
-                type: 1962
-                host_id: 30
-                reserved: 0
-        -
-                start_resource: 16
-                num_resource: 3
-                type: 1962
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 1
-                type: 1963
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 19
-                num_resource: 16
-                type: 1964
-                host_id: 36
-                reserved: 0
-        -
-                start_resource: 20
-                num_resource: 1
-                type: 1965
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1966
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 21
-                num_resource: 1
-                type: 1967
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 35
-                num_resource: 8
-                type: 1968
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 1
-                type: 1969
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1970
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 23
-                num_resource: 1
-                type: 1971
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 43
-                num_resource: 8
-                type: 1972
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 1
-                type: 2112
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 2122
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 8
-                num_resource: 32
-                type: 12750
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 8
-                num_resource: 32
-                type: 12750
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 8
-                type: 12751
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 32
-                type: 12769
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 32
-                type: 12769
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 8
-                type: 12770
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 0
-                num_resource: 2
-                type: 12810
-                host_id: 12
-                reserved: 0
-        -
-                start_resource: 2
-                num_resource: 2
-                type: 12810
-                host_id: 20
-                reserved: 0
-        -
-                start_resource: 4
-                num_resource: 2
-                type: 12810
-                host_id: 22
-                reserved: 0
-        -
-                start_resource: 22
-                num_resource: 18
-                type: 12810
-                host_id: 38
-                reserved: 0
-        -
-                start_resource: 1536
-                num_resource: 8
-                type: 12823
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2048
-                num_resource: 8
-                type: 12824
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 2560
-                num_resource: 8
-                type: 12825
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 3072
-                num_resource: 32
-                type: 12826
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 3584
-                num_resource: 32
-                type: 12827
-                host_id: 128
-                reserved: 0
-        -
-                start_resource: 4096
-                num_resource: 32
-                type: 12828
-                host_id: 128
-                reserved: 0
+            start_resource: 0
+            num_resource: 16
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1677
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 1677
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 1677
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 16
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 73
+            num_resource: 5
+            type: 1678
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 73
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 3
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1696
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 1696
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 1696
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 5
+            type: 1697
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 3
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 21
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 16
+            type: 1802
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 100
+            num_resource: 16
+            type: 1802
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 154
+            num_resource: 14
+            type: 1802
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 16
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 25
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 25
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 25
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 25
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 25
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 25
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 32
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 32
+            type: 12750
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12751
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 32
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 32
+            type: 12769
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12770
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 12810
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 2
+            type: 12810
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 18
+            type: 12810
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 1536
+            num_resource: 8
+            type: 12823
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2048
+            num_resource: 8
+            type: 12824
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2560
+            num_resource: 8
+            type: 12825
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 32
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 32
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 32
+            type: 12828
+            host_id: 128
+            reserved: 0
-- 
2.34.1

