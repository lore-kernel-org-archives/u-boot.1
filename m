Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE9C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 720E580079;
	Mon,  3 Feb 2025 16:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wR4vKt/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D904580137; Mon,  3 Feb 2025 16:03:22 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C1B80077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP5wk/cp0QG1oYI4ttIfYqegs9gPFcwlUYzvrgDrtIkagqJ6J5uBczB0h7DLBa1mkQQYsNfbMEmUh5Pr5i4v/DeoMHnUy8JO/M9XYl99wzBQxPgNpnxHgnoM3aP19tWNbrLPlWW+d4K5BB0TRQyd1tWureoCsB8bSkft2/Voe7vlYklwhONpObsm/uk7urGd48GItmr8NaCtUySbnkmJzWPFsTklfYzn6nxXwe8c05jkZQeCi+pq01rcQeshLF6EAzuGbdPjwC6Rgbv7AlVFLc+hC3WbnwFsurZa/UWZqTs0LLCdWxYf3AGvWMvzyjxJ7HDG+NU01u4kEZn1767yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+VaawdpPnceCFhKoi+j+kZXZeC2Nhj0lhtrLrIXokE=;
 b=MYQNUbuW3eNHwB97quvlWQKzS/zGVI4Tan/2Qexcz9N7b1lOEO8TTtLzXhp3Y0jyzclmamNysNePBmJwDYidGxP4z2WMZ63BD44tVokOdHsWTWBJrpsNMAxuj6fT6zvh+zPr7Ap3CX5ShVWrT+wxwO5UpNw1nZ2Hni5AfcrzCekOzf5XddaCVMeT1xr7ct67/rh5455SbQPVwzAI+bnivFqOS2j5fakJgL5JdTcONjCU/ycSckNygKT/lCCj14mGNDuEpuGss+wp+3tMu9pqdYLRYHzLYm1/ki0QRlfiKlhBwV8laLj9sAobIan39gz8roZDTfUU7QZJKN1FvZ1xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+VaawdpPnceCFhKoi+j+kZXZeC2Nhj0lhtrLrIXokE=;
 b=wR4vKt/gCSw/irLDT3/XQnpR9l/mPUVt3auyw5UrB4KEtnlZteZACgFGJU4hsi7S/btfRBJkLPEpfT/xqOsyxNqKBGbEeQqFzoJoZNo6Vz6LdTLe5AIa90eWmVa/3MwoxILS68qTRZ4L+7qTMJ00JYnf4ARVjVrc3XQUWr7dI+k=
Received: from PH8PR20CA0009.namprd20.prod.outlook.com (2603:10b6:510:23c::23)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 15:03:14 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::75) by PH8PR20CA0009.outlook.office365.com
 (2603:10b6:510:23c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Mon,
 3 Feb 2025 15:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 15:03:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 09:03:09 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: Kconfig: Select DM_RNG for LWIP
Date: Mon, 3 Feb 2025 16:03:00 +0100
Message-ID: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IIgmRFFLcaabBhqWqiTeCmKzEwLn5AhsVuHkWKs7sYk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQFt5ZqbSo7oVCftPf6jOhberrMFj0plzjnL75Sa29bs
 XmZz6eYjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRhBkMs5hyFiQuzza5EzOR
 vWsja2TLc+V1VgwLGmwD7QNvfltzqmGOM5OWvehUp9MZAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: c5947c08-e7f1-4b4c-e55b-08dd4463e1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Q3mVfUGH6ep7ePMU3VpigJtsAjK5CNNuihkBxkqbzAnDkUqzV1mXu0BwYta?=
 =?us-ascii?Q?VPMZMTFysOEvkk59NmDTegB6jwZtMaIVugLXMH4Kfzv0MFkAq/reW8lgQvnb?=
 =?us-ascii?Q?tbXR+YScllEz/rbouRh9iRBL8FzZ4+q3FfrqKXr+YXSjgMpsWRqfhPaOR5Qb?=
 =?us-ascii?Q?pDTz3McutFxlIu+q4LSyAE3TemhCD8TP5uNt6DaGeND16I5oE+2IorkPShuA?=
 =?us-ascii?Q?82pL7N34/IPsoChqAFW7UVn28j8/9VCiO2rut7k3sor/h9qPOiIkGBcyNnuf?=
 =?us-ascii?Q?US7zKxbmFYxFBELQQstvijXORErOugmz39hYOZrkcfHAi9BK2tFdGhlhYm2r?=
 =?us-ascii?Q?1UdaxEzi5Jv/t92HN8XIktSBEvrUUZ5iAYUsNUFf0GDj+3G3N8zJTQR8lwFq?=
 =?us-ascii?Q?uQjV2h2j1lwBl5ck8pMSdC+y93NnQgcUnLbkE+3P2yc7iUx5wFCtojNdpMtB?=
 =?us-ascii?Q?ub/sjSEySHxidc0+H/XLRzw3Rm6zZ4bstUPjRwfIqF7myBDY8hAt6ugmyv6D?=
 =?us-ascii?Q?yMjbEOP9uAPiH2HBIK2m6X0FaTOjGt7lxtVpXtRNEZ26Og0mWj04zogSzYYC?=
 =?us-ascii?Q?t/UUBhHqumH5Rj9MohMJyYsEvVrYraVOVjRwAHvztwnNVDHYNPONUakxxi5v?=
 =?us-ascii?Q?m7HB9FXs9Le2LARYmNY+5q58PQoEQRawIC77gGW1P73LS3pmpqucUtvPGSBh?=
 =?us-ascii?Q?Isr1e96W0SxbMEaCnQ8INiDkpTRD0bV4udSubBhmdvYegchHIQJGwYU/gDl4?=
 =?us-ascii?Q?fc4nzNdxdfomgA5AwiLGiKB98ahnt8eYXJom1JZmDdc6p9mHcGaK4sKowSBF?=
 =?us-ascii?Q?2p1AGmVXfxkVND8WgOxDesjpAAlQKLon3/GQ6r5/6F23s6ZSfSA/N2tNhd/4?=
 =?us-ascii?Q?NtpCTAm2UVY1oHwSGc2QDBdV69Kv5VwNPWpS1buXDQ/v/JasatrphTLdCbr7?=
 =?us-ascii?Q?E+77ryPZbpKMBm8SwBf9TQJSgs5UzbmGvoipsX/FG9jpzeYvAYgMBzJHBoFa?=
 =?us-ascii?Q?aKyZ55mS6penefiS3lG0fFHE16t/mv2gyra1n1VTJYYp7xmO4+VwJfzicw4y?=
 =?us-ascii?Q?1QoNjAPS61mQUR0iRTVTWFk5wD1ywJju2/83lrB3ZmMyatEqWcJ031lWVv85?=
 =?us-ascii?Q?PcNLB/UIN0el6bZTogLWNPxufRH7eM45Wev7JZEsRqu5paZ4OHcDw3P+g2XN?=
 =?us-ascii?Q?gtGzxA+Ze201N8dtWqbr0BxCjoMEt4QCqMBnusx/mHwqILlu7gUIUL9UbSOE?=
 =?us-ascii?Q?gaOOhJYnhYfCmrN2jNwPLZ31X0190ed7/TPOaj60mRHJSliYK3kBQKjTDcRa?=
 =?us-ascii?Q?tUCtztCfjiKm/daS2936AIm1y3ek6ji2m5QsmGKmzRBxt5XaZr+B/JTINIVF?=
 =?us-ascii?Q?LiDGMP1VYuiz9Givast1VBKGogqUkwGK5zxJWkIA9uPYAtBg6RhTFjIzKRrf?=
 =?us-ascii?Q?Rud7IF3K/3MmKJWfQTgFMfBtdgVszSRl7N4GunSbW+zh2UXJ07gg7mmQHg+/?=
 =?us-ascii?Q?Ednw94xfX80eSuo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:03:13.7503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5947c08-e7f1-4b4c-e55b-08dd4463e1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855
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

LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
is not recorded anywhere that's why select DM_RNG when LWIP stack i used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/Kconfig b/net/Kconfig
index 24508026200d..6c684624fd6f 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -249,6 +249,7 @@ config WGET
 	select PROT_TCP if NET
 	select PROT_TCP_LWIP if NET_LWIP
 	select PROT_DNS_LWIP if NET_LWIP
+	select DM_RNG if NET_LWIP
 	help
 	  Selecting this will enable wget, an interface to send HTTP requests
 	  via the network stack.
-- 
2.43.0

