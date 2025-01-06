Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCF6E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0700801DE;
	Mon,  6 Jan 2025 10:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOhsyyeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C0480137; Mon,  6 Jan 2025 10:51:42 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C0C80137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUl/Gp9Q6hZAbVr1F6J8cvqDH2E/OarU1XzUqjNZGzgBVqFIJzVxnHBY3or1+CsUpXB0vsFiRBPsTmcO8JUNgzfhnqsYj3Hu1nF/pBjg+EwaSuvANADA0uqFKnGDJX+ur5taTy40NL1JURVgBHdAmehv71g3qK+PFDlnWtoRDH355BKUJ+1WG0YLDak5FY+QhCRZDrN3oBTazqPvCl1VGcoKTJbi4xNRqByMaV05lju7zQUZfg/uUlgoA2cSB45xjdTCgnSZZwlCCtjz7PJcGTkbahaUb2Y468ifqTjqGOkfxhSLmvD33XNmXVqrgk/JqUs58DG7AJFQgO/SWMgMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRtLo7B/BgBxMJ2N0m5PPKgxoS2kciRqTBXzjrTCT34=;
 b=Dk6LqFyRYVRae/L75f7PBBTF4fQI/NBoa45RUoqAVu/elt2AvUQHhkdAhkRdXSDGqlDXy5oQvIIGH43Jzqk+g1x/7hFtqILRoUwar18dyuYowA5N3QUNMkGytzYgSe4cjI/gETX+GSsrxM3AFnRU/28twRuw9XUENDGYlYKFCzWtcdDjg0POXwVkcDxoumsB7L03IEiOF5ZPRTZozGhiyriwGL5kQAD/nQ+3Ei7+xuelzW/nuScw3WcfX5jAvpVFNoRsYKTY7qb1e5AYBB5BPlELIUwonSt7b+fdNSPbk2kS5iIINIm4pADVbpr1tLKUXpZjw3Wujt+isbyysY2j2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRtLo7B/BgBxMJ2N0m5PPKgxoS2kciRqTBXzjrTCT34=;
 b=pOhsyyeS2NjiIt6gy0HoR2Gzkkc7burL7qDPjG6qBDc3yR6WjZmdf4JZb6rBZ1CUUcbx2Xi3xlYfklg9pFEONGHCcHAVxA/iBA+lqS8vrGpx1xrRHjtEqwEhT8BtbmXN2BQu0JhKNiACBk1DNRUR7d77aQ9vWVe9IMXMV9s1kMA=
Received: from CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::23)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 09:51:31 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::64) by CH0P223CA0025.outlook.office365.com
 (2603:10b6:610:116::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 09:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 09:51:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 03:51:29 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 6 Jan 2025 03:51:27 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>, <jagan@amarulasolutions.com>
Subject: [PATCH] spi: cadence_qspi: Fix OSPI DDR mode alignment issue
Date: Mon, 6 Jan 2025 15:21:20 +0530
Message-ID: <20250106095120.800753-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SN7PR12MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d26a6a-b276-4be3-ca23-08dd2e37b274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MjUPLykSUecswCIsdVItQHViKH2hmMvc2jXaTDX5oj0QhO9ftWpSQL0FwwlX?=
 =?us-ascii?Q?4JgKZ9ruWjeTl+WqTjI+T/Fjcz9ZNhrz3NkJqpJcJvIwKABT7NLQhPjdGgdC?=
 =?us-ascii?Q?KTbUZVxTTwbaTas9Itlu9iOWq+ljObx1F3tsYgmuxIlOIWqEiAlNKyowAI3U?=
 =?us-ascii?Q?QKCApjEkz6w8GL5CPd0XnXuV6Gti9kYyX6AEA5vxkGYI5tj0SODZbA6DjFb8?=
 =?us-ascii?Q?zzT6ahoZkAheJBnHHI0ecc8LFgPkToF4r0wNEtb8HKpVyAkAqize40oxJK8p?=
 =?us-ascii?Q?19w+Yz9nhdgROGxDOJK9ee1ybCbOfbWAJ+9sJ/2VtFP2DM3yqP+6KrFcdmgD?=
 =?us-ascii?Q?UaXmlNGybKNTEUhvN+mEauAro5NTDJXCe2lGnU2kGoiC2HVmRjA970AONsp+?=
 =?us-ascii?Q?/IS6/+3ZaP+/u68jMgeTgN94xDVwCoIw38cKec6m+hQF7H6r0gYqDiX0zKGP?=
 =?us-ascii?Q?2beVfVX1jZC4jt1kRNSq6NpLI21vBayfXYxrqWb7n62P4GNzQaOgUoHTrhOX?=
 =?us-ascii?Q?Gr2JVYcC13Wg2iYFTdIAz4bRQKRywXBoA6CsbhrXp4cI6CZV4/RzwcHteLfU?=
 =?us-ascii?Q?THZWGnjawbnRxdaWBneNwKq1p1rY/DnldH9w6fd0QzZlwpp5ZRKZXSQ5Bl2x?=
 =?us-ascii?Q?XojxHJY2jdF5R48Vw1SKfdb/+o2OfhdT2x/zvxj2x6GdytlYbNaBlaDqnGmc?=
 =?us-ascii?Q?6qQTvkZFmd6ce0iFM0mtmUSwdiJuUfuGVfMH0nHoGeQROSwNnRGPJTPfNeXR?=
 =?us-ascii?Q?8pUszDU+Em6bVX6mAVWKOw+yfGNh7BxFJ1h63Fv//ss9Gm6ti2WCAWI3358s?=
 =?us-ascii?Q?o5gxfBmdgsjj7Liozdg/IpLXu0wnvK0IHWsdkntATzHxqBJ4e+jfYZthdEGf?=
 =?us-ascii?Q?w6haJOv1hMwJBARioqnszdylVhjvtNSW0NaMVAyKiJy9Dl3lfLZvNw0xhRtf?=
 =?us-ascii?Q?BJTF+ZcxJlri0gfkbDGhskx9dbbX+cx4ygu1UeOAsa23zBEbDrIC4KPKIXMb?=
 =?us-ascii?Q?oO0UepbDit7zLHnX2hRF9nvCxJk1Ei4lloVgQrloZUkGO3eXDL6XJTrR1dBL?=
 =?us-ascii?Q?HEbK2cKFufZmnj7o6ncxN8vAa9t+xh4k8QN/zkYcAH5WeDL9mdyBJIP6E3Rm?=
 =?us-ascii?Q?3uEx3HwnVeK2zVhBBeDhUvC49uYBQ/HjhTUSJ+vB4p+Zk3jpQNE4ipPU3mc1?=
 =?us-ascii?Q?D2UiXn2Gi6/1s5dpx1tn+v4GZBOh+cJ5GjpN5QbqaetB6SLPeLp+uMaIh7tt?=
 =?us-ascii?Q?H9pFMWh1j1k/nMpccI8NRxmOp5s9YJ7J3/m4mfZq4JE9Myl5VaBjoCjhUusK?=
 =?us-ascii?Q?mT1OBwx9RNJplER3zmqzIaCSToYYbG46IeMP9checfX8P2JT+WsGDBTfHR2/?=
 =?us-ascii?Q?ZIh2c/GMW4S9V0KpAiBGuUlq9ujRjRVFUuzac/wNAVF6TzEFesTBhlE2rt6C?=
 =?us-ascii?Q?fM0o1OqnWgjvLjRmk1vXT4A/+EVsu7/QK90fgQ1gXCm3T2W8w/HfYWL5lj3S?=
 =?us-ascii?Q?H/qo3MjfA+TfCl8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 09:51:30.7618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d26a6a-b276-4be3-ca23-08dd2e37b274
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

If the least significant bit of the address is set to one when
using the DDR protocol for data transfer then the results are
indeterminate for few flash devices. To fix this the least
significant bit of the address is set to zero.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 222f828f54..8827a24ee6 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -24,6 +24,13 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 	u8 opcode, addr_bytes, *rxbuf, dummy_cycles;
 
 	n_rx = op->data.nbytes;
+
+	if (op->addr.dtr && (op->addr.val % 2)) {
+		n_rx += 1;
+		writel(op->addr.val & ~0x1,
+		       priv->regbase + CQSPI_REG_INDIRECTRDSTARTADDR);
+	}
+
 	rxbuf = op->data.buf.in;
 	rx_rem = n_rx % 4;
 	bytes_to_dma = n_rx - rx_rem;
@@ -104,6 +111,11 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		memcpy(rxbuf, &data, rx_rem);
 	}
 
+	if (op->addr.dtr && (op->addr.val % 2)) {
+		rxbuf -= bytes_to_dma;
+		memcpy(rxbuf, rxbuf + 1, n_rx - 1);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

