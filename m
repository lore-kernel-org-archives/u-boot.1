Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076EDC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ED5480CBA;
	Thu, 20 Aug 2026 09:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lf00s6I60ipP; Thu, 20 Aug 2026 09:27:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218064;
	bh=RBWgWWZ93WnQWaPyuNUZr0+6IInep0uzkN2LlxyGhOM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oeFPd+trTIdGvwxeaqSEnES4TinAUA0YmJEe+uJ5JR932YnwAubY8R9h5ytfAh0hr
	 yc0DTnvC7HB+2m7LzaTukh62uOAVTYvfF9uX0qASI976rW+dfwd0qAvc8v/PW7xZa/
	 M7AyUGBcSD5I3B/BSbo+Ga9ffBs3sZ4BQaAbITyFV8afiVD4prt4iHqPgX4Rbls2cC
	 Jq+EuPdvgIWMhNWjuYaYXNxFNztH+m824y/cAsdaLK6EmODa4rbhI6FCIbsWODU8Td
	 aAgxOa2CdVQRRqrstUPjSo1hvSGwsuHxnnAtjmXNEwdtVz/dt5vVx4ErUbjK1Tfj0p
	 +WqSrS95tyagA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B29780C8D;
	Thu, 20 Aug 2026 09:27:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E4D239E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77E78405B6
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TOo_VXiLtGau for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qONJmWvo
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D65F4405B3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPltgBaKa806gT7WQdPgxMFdiiKigMrS6HyXAVWHJapZbY8IHI6B4vr4YebLO1/Vx++Jtme4R3t8Q714OjWoYnLc5WNMGCvDYJ0cZI4nHKXDp8TxNO0tSMozewydqyruEOvmI2lO4IP3DLnZl1bXEEOGJqvkedoIftY8oCzO4b27WfdNDwSgrBNSSHc8Wotb3IDFiRftZpVJ8Kkf8AQH6TlAl8rF55oQQcUDKwLukybt+Vj+PdRZ1+lnSTX/c0c08yiTQ5SGGOpqmkT2LXmPvXeAw71/ZWfJFOhGtqGdQKOz1f5FE8CbpqT1KTMj9KSvfFO8zDb+JcS/uYKYg9HnSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBWgWWZ93WnQWaPyuNUZr0+6IInep0uzkN2LlxyGhOM=;
 b=NSBLdIL5usueCGtET3ybT51TZfqi1RQa1HerPJcYLTZYI7x+anKEy/WMB+X6+ICk2bDeLMQuQ0X/Trard2+Z6/dZt6RBcCyG3YYjfm4//9g0JPnc9CpEGKdVpFuBwwgLZZKHwFDPhr3xHlhwc6qddBHzLZJXSk6cQlltboMI54dgc7Qi4nccdmh6Vq9ZbRnJtK/g1RAr26NKyzh8Wmyisi6cKSe9BBYGkThvaIMrQWnHcIfSvDTizbtA8Yis7QbmDvmYD6SOoLBl+z2l1F6Bf6msFInogir3CQkMgX0XvcIuvmCgrTfHBW6tYjBWD+SREmiIfPud3GLpWN8dnYnZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBWgWWZ93WnQWaPyuNUZr0+6IInep0uzkN2LlxyGhOM=;
 b=qONJmWvo9VMk9gsMajf8UYKiir2DtSmccl8lzBTlc30UkU0ACcYPCwwpB4ZjBXqFoEZlMp3NIn8e9j/wZFSxq2/cC4K28j4bgsgSMoDVqQqYt1lWz7G/n5npambn6wBwZcIeJmUJk09NM3JKPapKr2mmKgiJefvD8LLiWVO5iE4=
Received: from BN0PR04CA0145.namprd04.prod.outlook.com (2603:10b6:408:ed::30)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:27:38 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::6d) by BN0PR04CA0145.outlook.office365.com
 (2603:10b6:408:ed::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:27:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:27:35 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:27:33 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] net: mrmac: increase the Rx BD ring
Date: Thu, 20 Aug 2026 14:55:54 +0530
Message-ID: <20260820092623.1647844-9-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc1df3-53ea-475e-627c-08defe9d466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3bmxXtZwfWOkTO0vc2Jd0fC5DDon9RLiNggnS2yjGBkOCOSMVYkjqXaSW/XwL2il8y2+IM9BIZm0sSVwq7sy6ovq3yjJN5KyD00jsemd+kHo3dtGoBBnTFttKQyu1JPuseTDXM/gC1COisn0mFtLeUS34Z1vS+HFiW15+9YdKK3A+JUAd7YWQnH7njAGh9at6r+TLvzRxub3lZvuy+xWYyQnnKopx4W660O8suc4gY+YZqLGBTa/1skAC+yqm1ovHxIWxd8GnugWXHY0U5PvN7sLxbcKGoRZwNrSSvmFjs8iGmIG9SetKEUX/nI5W4hgNkeDtj6a/DB+W0bKTQoV/xeaUSiiLMaa3SOHv/cIo26zCh1IigZen4jQ27kn+ycnH8G6VTRROiigt+ZMB8dCJZ6yWW7seUhqhfn5au9slYq+wJlGmTWdD1z/ZbJQD77Q5L6sRL4mePkdL+7NdWxhEh774LCt34AZj272DlWxlMefhuM5iIOPtd7A1XT2OFF8nMFZWH2+sTgCyVWS3QdYOeH3R8J1tIImmYt8TFmKorbboKxa0HVzFZVNgNqY0/vH6J5WG5r9Lsy2hGnvEctV9omLnB1JzFSmsL/+9XyjnYpGZaYv8U47XGfMamgaUT2BoOtn4bkW8xGtdHPD5GPhm+MrAeCOS1pld+g3h5qk85gz8H+wJ9sjbLYP7Br4FCyYLbaMwQlWF79wmQ7mSpONPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6PhziJNS3um/D8U/zAuYT5jj5w1WG6mxxJ5C/gMDm1ijSeo49L1vULL+4lnqgCREi9Md7L/yl+vRkNgsUKBrs6dPVtO3lfUyT+vCoZ75vJSjLnDi9GZ1SowayCQxqHqlWAAsypr04NsEkdDL1qoMfmlw1i9DixWb1hfuf2q87lYfoeHljZ0sbWVG1qAmKLGqxZX4GcS1NSCBYvCMnXN7F19sb7gJpFISb1f1ZQ+qSN9pNbd8q664sGQDj3Lrt30SoHekPNG0EEzxh57IbvRF1k/VYEjpVvgQ30E4Fzlq3taN1D4AFcoCzUgSB3bS9sziA1JzrD1bm1pmm76u7aNeNM1zVrsHD4MQ7AMdPaG6dVOqygj7vWH8FgtzkoPStUHkBYT6b759cwsAS2iCCqPwLPBaLsBn40e9sODSVPmbCSy0/8MaVD4jVKbym5IUobJr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:27:37.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc1df3-53ea-475e-627c-08defe9d466d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
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

With only two Rx descriptors the ring is full as soon as two frames
arrive before the network stack drains them, and any further frame is
dropped by hardware until a descriptor is freed.

eth_rx() processes up to ETH_PACKETS_BATCH_RECV packets in one call, so
size the Rx ring from that constant. A full call can then be served
from the ring without hardware running out of descriptors, and the ring
depth follows if that constant ever changes.

Add static_assert() for the hardware minimum of two descriptors per
direction, so a smaller value fails the build instead of silently
making MRMAC drop packets.

This is headroom rather than a speed up. A TFTP transfer sends one
block at a time and waits for the ACK, so it keeps at most one packet
in flight and does not benefit from the deeper ring.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xilinx_axi_mrmac.h b/drivers/net/xilinx_axi_mrmac.h
index 2c5c83421e5..29f7c440238 100644
--- a/drivers/net/xilinx_axi_mrmac.h
+++ b/drivers/net/xilinx_axi_mrmac.h
@@ -11,14 +11,26 @@
 #ifndef __XILINX_AXI_MRMAC_H
 #define __XILINX_AXI_MRMAC_H
 
+#include <net.h>
+#include <linux/build_bug.h>
+
 #define MIN_PKT_SIZE	60
 
 /* MRMAC needs atleast two buffer descriptors for Tx/Rx to work.
  * Otherwise MRMAC will drop the packets. So, have atleast two Tx and
  * two Rx bd's.
+ *
+ * Tx keeps the minimum because send() waits for the transfer to
+ * complete, so a deeper Tx ring would never hold more than one frame.
+ * Rx matches the number of packets eth_rx() retires in one call, so a
+ * full batch can be taken from the ring without hardware dropping a
+ * frame for want of a free descriptor.
  */
 #define TX_DESC		2
-#define RX_DESC		2
+#define RX_DESC		ETH_PACKETS_BATCH_RECV
+
+static_assert(TX_DESC >= 2, "MRMAC needs at least two Tx descriptors");
+static_assert(RX_DESC >= 2, "MRMAC needs at least two Rx descriptors");
 
 /* MRMAC platform data structure */
 struct axi_mrmac_plat {
-- 
2.34.1

