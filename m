Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABE4C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 04:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3AE832A4;
	Thu, 17 Jul 2025 06:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIJmYnK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57F2832DA; Thu, 17 Jul 2025 06:49:11 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC60783287
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 06:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8KyXdKop18012v5japtZwCvEmt8hKEkgOkFdDVLy/FPMs93vm2dd7MtI5m6a9pqESsx1EPZOIddAMFo8nD1798twow01flvC/yzov/rU0ssoq9rSynagZKebxBFPbJa4+rls6u7vvAxNn8MOiNEjz4D3LvBpQcrj+1JZa6XoVdnIgwpn/PQkBomsl7Wby0AANCuEmrbkqGgODSceygCkZgy4iYksJtyzVOmDWTwctX+CFzl7CZFgR+ncWSak4BMgDbXA2V1ctGwCVOKfmFHNgrQAXb7PYijTPX2U9781ZjEt2qzaaypeq0BI2QyIB66ToirWFxKgBbFB4VHD1ck7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueV5iFYKJToXfzmXJoomKM/BAS5UGDc4YO7/F4wPqU0=;
 b=L1mkCl9Uku6G8mjD3wUkuKkDh9UUkTqY0bcxikdghvNo4tj6HyJCxaj9WcXiuUiHwh3apCTXJ8LDaG8QRm3v2AExjbEMMFodXIgbnWSfd54vrcvJQIvsTYGOXyNiBecy9iTqAahB+L1uCQbn55zoJKAA7v81P+l0czQR+Z6a2TTz72GjaxY3OhbOJfC4KjYhoJKtfONQ48sfKA7DiemvdM8XwyG1hBUHPEL8RVkU9sNuIu4Qm/HsnjWLSFPcyYYW8Wh1oCu/27E6wQ4HT+uxVulvOmRwjH1o+f/iwY4vsrMzsAjbc6O1YXJIMenVE7IO99QLWDv/iLBxlKoB07WbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueV5iFYKJToXfzmXJoomKM/BAS5UGDc4YO7/F4wPqU0=;
 b=OIJmYnK8kL/D64SPHUVnkiI6DwFMjopxfWKVPi079+dBfPjf/Gn78YgX/R0OCj6s9JXp7hbR9vXi02VwC/eu9G07xzqPgaZd9yCiDx7Qi74yGg/dj+vNHmVM9+WW6TF9QtZUqjQIbmlL7Pp7mPHFpu6fuxM6aW5nqrMq9hCmexk=
Received: from CH0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:b0::18)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 04:49:05 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::d9) by CH0PR03CA0013.outlook.office365.com
 (2603:10b6:610:b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 04:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 04:49:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 23:49:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 23:49:03 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Jul 2025 23:49:02 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, 
 <git@amd.com>
Subject: [PATCH] net: xilinx: Fix kernel-doc for axi_mrmac function parameters
Date: Thu, 17 Jul 2025 10:18:55 +0530
Message-ID: <20250717044855.1359443-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 980a31f1-f57c-45cf-eb07-08ddc4ed4251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J52mTIso0f9WsdyOBhZQNTffNaKJ8cMFk6IIj0cn4UB/nxluiTfRu/7qadMs?=
 =?us-ascii?Q?dT8OpYmsS0qNQSg++buHq/bNVCprKc8sW29l8iD7JDennQUqNWLNtm8sMitT?=
 =?us-ascii?Q?6UDlczgIso5UJer0hX1mggcdrUlDGH05VgN9ixct8GFu65OhNe/I2/HSWeaz?=
 =?us-ascii?Q?/YLPre+Mcf2dPyXYD9P2EQG5qMuHWQexLo14o4kkJeqKCLGnYUOeOY/dWwwZ?=
 =?us-ascii?Q?hb4VuJnb55I4rOXnKAdYK3ifhZeNSgzmyitO62K4z4JWQ7k40b0eZEs/yaX5?=
 =?us-ascii?Q?tfE2a8t/W2tn3W8Wq7OyZlkC54Th9JFdDxcdpdKclhBqyW9lvvU/ZtL7RVAI?=
 =?us-ascii?Q?23akKFe7eIgbs6MBMwLr4GYkVGtKI5ITz14IyfAS/9qcjZ/ln9wbMcWfxUuq?=
 =?us-ascii?Q?gG0VlbKzh1wZiZViKo+78GZb/LQJbB7Rq4C8SluVC2c7eNyJ+XkRwuois+ud?=
 =?us-ascii?Q?GvSFltA0qpsuKhjgC+0sJksnDYyZrr/yRsnF0HO7oB9BEfoJ0cAGDgn0rONo?=
 =?us-ascii?Q?r7V73ylOTfiCWGV4yblc0a1Fskka+p68b5SM8o/oWpj7oJjYChPoL1/oaoP+?=
 =?us-ascii?Q?HvS7h+LQRh0qxUqYhK8tqZeHeqCy4svjF/tELj+0tBgpJsXPZqGhFXeQvUkf?=
 =?us-ascii?Q?tuBIy1ZEjJGMTodpOnA3QJKakakPYO/tTHgAj73XEdFWOnOXdLlSbAcQKioq?=
 =?us-ascii?Q?bIjru+VXIWnklxlPu4jcdPnaz2R5Yj4fikUygMFj5hTs0afGvPuTkCUhZlrI?=
 =?us-ascii?Q?krfhN7df/bQTCkg35anNJYfvvXb0yX1U6qPeXHAFf5F+GzCTCOi3miyZZ1Dc?=
 =?us-ascii?Q?cqLbfOuW0W/JUTt2hhoml7CSWOxKhWa/6Exy237Ym30QGWCegrtCToq9c/MV?=
 =?us-ascii?Q?W/8ArvwEq5dt4kddrviAUaaQuGblcae82yLEzVsNVqn1Mh+cRh5I17XBaoSD?=
 =?us-ascii?Q?6Uxh2ZZriLGCiSaI1WGNPbrukqwkIDa/2PeqAseHDLYObqOW84//9KgbrQPG?=
 =?us-ascii?Q?291zGqxaYl/9L2OTp7Y1J63Tyo9C2KIQ1uvHTlSqJwb6GBU1Amg1ccyeDGBW?=
 =?us-ascii?Q?qWPbofRt47W64yW1YG0dt37Lgds02neIow05SgMsdRjbBgHUplWKW/k1DsZE?=
 =?us-ascii?Q?0/VLMOBkGfCSKfd+6WdB0qa/uQ+VL7lqD/oK22GKfRy3N4Kedh5rQAB3a8SP?=
 =?us-ascii?Q?9QUOFQNPsDjPL03a084GmbVyVB5o6t3LyZ095mu3ycksjEeDmZTCw8n6Rtgy?=
 =?us-ascii?Q?AM1TtCqays9KokccPRPWaOcHxQeOGrJXIhITfJF8vzVNjmRgq1N9mC/7javD?=
 =?us-ascii?Q?6QQcnhDwj/lcGqRK5hWoLxqXoBVJl5Eu+ZHuyCaqgEyKA26aZL9y3TV3Caja?=
 =?us-ascii?Q?sgikgK43IgJRnEKE8+wqA1eJrYXC2sTigDpiGdX/W5kgHSyy/q6i4NGpvL+r?=
 =?us-ascii?Q?HIAFJ74Zobm96oGCjtnZkCnx/2pABtMX+uDiBPUKlKRN3MLRhMEgwS+X/uyU?=
 =?us-ascii?Q?MZNn6wlkSUq4Qx/6Um4yu9yEoEDIJSe06Yw7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 04:49:05.4891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980a31f1-f57c-45cf-eb07-08ddc4ed4251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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

The kernel-doc comment for the axi_mrmac_recv function was missing
the colon (':') after the '@packetp' parameter tag.

The kernel-doc comment for the axi_mrmac_free_pkt function was missing
the colon (':') after the 'length' parameter tag.

This caused a Sparse warnings regarding the 'packetp' and 'length'
parameters not being described. Fix the formatting to align
with kernel-doc standards and resolve the warning.

drivers/net/xilinx_axi_mrmac.c:357:
warning: Function parameter or member 'packetp' not described
in 'axi_mrmac_recv'
drivers/net/xilinx_axi_mrmac.c:411:
warning: Function parameter or member 'length' not described
in 'axi_mrmac_free_pkt'

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 555651937f8..56f877c20a6 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -346,7 +346,7 @@ static bool isrxready(struct axi_mrmac_priv *priv)
  * axi_mrmac_recv - MRMAC Rx function
  * @dev:	udevice structure
  * @flags:	flags from network stack
- * @packetp	pointer to received data
+ * @packetp:	pointer to received data
  *
  * Return:	received data length on success, negative value on errors
  *
@@ -399,7 +399,7 @@ static int axi_mrmac_recv(struct udevice *dev, int flags, uchar **packetp)
  * axi_mrmac_free_pkt - MRMAC free packet function
  * @dev:	udevice structure
  * @packet:	receive buffer pointer
- * @length	received data length
+ * @length:	received data length
  *
  * Return:	0 on success, negative value on errors
  *
-- 
2.25.1

