Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAEFD10F5D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 15:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C743D8398D;
	Wed, 26 Nov 2025 16:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gU2SSkWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5A68399B; Wed, 26 Nov 2025 16:10:04 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A8E83980
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 16:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGZ7FfpQo0n5C8ZBhtXliq9a36fUdiCOiXmoZrYhfKIqatoO/loI7KL8xiVgHIwT8waMCQcGN87qMYAqUUOB1nuL4JzOTllvPZ6MCLfXcCUEhNGoiAM1K9yReAqd97BkzpSdu4oIkEE/S+40akLzuxld6HW3HSx+UM5hnW9OEiqV7Ka8IYi9yEVTtF1az9VBOk3u1ZnaOMSm5ePvNvtiSoUeXhidyZUtHI5durJxWm5hrYcOLUl8TLtjJzsFuj27WqjX3qgr1tB3wncVTqwfKDnE8POwMn1qOlLOHJLAGFEbom+lNUA6IBN8drsWWtKhYJ6Hw2qOY6tADS+PFHoH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEV3Anj3SD3gAgrgGaxipLsDhlz0Fv1KOE8CiPiETSQ=;
 b=x6sfLIWs5BUH6PUZnKtamFNGWffJv8o2nWC22bcqcxcW3gBmAr3sTMGvzLAmzMGxf7G/Y2VhE6cdejAMRLk4zJX5NzJwmAGjiVGfGV9GXt8PasHr/nI5D/MZvY6nC2iE/ITZlb/59uGWq9b+M+moi/EzHdFXDxblmgNi+0ns7AcGh0zkVjHAiGEXApbO4Yuq1UdiAlk5pSryFYTCcagTalL8CQ9VgWilywhEfzBkY89kjilAG8YOQPR0GiDYADmz/2xE9EdtSak+ofnUoGbRJGhsqr6+dWxHzowmrzEqO9vzTauAdaNxvic1bDLE7eJOiKLpm/DP6+RK+SGc4ZWvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEV3Anj3SD3gAgrgGaxipLsDhlz0Fv1KOE8CiPiETSQ=;
 b=gU2SSkWQFAftmyCS9C0we1QOQLqqVks0d5bIzjX3vANDhsrkB8Ii0MV4Z+OyTdIgkBKYFW49JnBE2pqr5OcDJl4xHBZ2YAiABcOliByVmpY/MUCcF+BcbOkv4qpCMf1Iz4MJk+ucDkXys/cOf1K5/65Fkdwui+C2FoWMAOMzvqI=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Wed, 26 Nov 2025 15:09:56 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::50) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 15:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 15:09:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 09:09:51 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:09:50 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 07:09:50 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] common: memtop: Update the MEM_RGN_COUNT macro to 64
Date: Wed, 26 Nov 2025 16:09:41 +0100
Message-ID: <d9f73d26af832e19dfd79a4b7bfcf09c498a4873.1764169780.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+PF9lZwGdUCvSZR7l9zfWd0nYcGLd/4BxkmC8T4V1yw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqS5jPM4vIytJdVCzaF5q9Wbv9xMXVSj9KpUzfhP2c2
 imsPDOvo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACayWYeRYbOH7Ev/Hj8f4eBn
 /2ek9zhdFaztuF8U7iRbJS4ssFSph5FhTojw5CcWLjVmDU/1AldqXE653HRlLrtzxKmFN+Ry171
 kAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a50b554-1d86-4430-5bf3-08de2cfddbc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1yv4VHKfNWo023sT29CYyd8AHn6fz6shxeOfTzgHO8FXC6iIR8NZ5xRXw8t?=
 =?us-ascii?Q?tZUqZAQTaMtQRoSTgO6o1QR/YeFBhCgIY3iib0uhAsf1nwiOK52kKq8bD0G6?=
 =?us-ascii?Q?rdoJS46wFqmEZq8gOJ80+0D32Sux/idUM9ChsjrhpNG/sl8X0lkx0hJZK+cd?=
 =?us-ascii?Q?6k6yLjhmdJD/R5V/yo6dOa/DJ4lsK0Ztbj+C5YjDG5HPmWk8LZ9mMowB5lu0?=
 =?us-ascii?Q?IgYdvL8OnEZNuOSSYB+bzssSNEcpRZj5ozVIL3b9mcNPZnNuY2dQfSXnw5PS?=
 =?us-ascii?Q?P/y3aV4r0ZeAsGtBFn91Gwyj/703+W/jVvZKbfjVgcFPzJ2OM2JQmM4Id7k0?=
 =?us-ascii?Q?nnqpyxfeFOoMAQnIGvMZbGHSwG4YwCC69i58A+iSGab2AoMj6TUCkgDB2gM0?=
 =?us-ascii?Q?J6MuLBQkB9oJDGqJoy5ry7/SI3llezPZJLBIOdXzgOnzkUFJBgXwEfW8HLTn?=
 =?us-ascii?Q?pJlKGHzrA86rWpLizkJsMliAKVMem+M/bd8S64AUfI5ez+Xf5iSHNecMQvhy?=
 =?us-ascii?Q?i3NCNRtQIQnJgsNj+aEK5dHbfjPd/ZRxmIasF0mEzqBCYSIi/duUIkd9P+oN?=
 =?us-ascii?Q?2xe9/iZCsWdE1LCErR4Ff+NkPY7hcbwKmw8aT5xasMgdk8tz01TxRe7BGal1?=
 =?us-ascii?Q?oh0XnXuogw3Hi+CRDyP2uAOStmD/bt1tgp1LgFuSnwzNVupont7jFzqx6kar?=
 =?us-ascii?Q?FmIAonVKzd76dZNsxdLSDbQhg8qXfz5qt4CAypb5624Tw4vkMWqlxwuFP65O?=
 =?us-ascii?Q?uxX+z40TcvYon61rHXl5Qz8R5567m8sJsFc804uhdPpLCEgkp4Sb3nVRUbwH?=
 =?us-ascii?Q?iSO+sc9CwGnu3nZZNauU5t4zYUAHBSbmdWOuNXrk2CuFjhj05hufbCAzP7bq?=
 =?us-ascii?Q?8giTNUz2Y+MQZP+W6Z5A4rz+ojkzUXg+/C/efbJ7WKx05/vcV77kKe1crjw9?=
 =?us-ascii?Q?DF00dcKDV6ODU8ySNwFOKYmTb6cK1PBCGiVgBLxSZJ44j6sB/nVv+vijHbiK?=
 =?us-ascii?Q?HGVN7OfcvuiDdpw4y80iYFYSgjpjw2xsxwHXSlnUBl+vrUYMhioVj5CS2lBd?=
 =?us-ascii?Q?XW1JrSWwkTEGxiFAeZ1Cl1NTEgnQ6CWgDJUEElal0SzvdQRI8wpRSxWsW3Fk?=
 =?us-ascii?Q?wgN7Zd7TNL40fW2lJJrGh0O1KwKnSn6f/38NghfTc567+Q0ej94SWtljEN5Q?=
 =?us-ascii?Q?TxVFv1Ad2eEuoF9OIWAxXjitA+pDnhymreVCZ+Xwg/eRNu0gTxINA7pJSI4D?=
 =?us-ascii?Q?+FUlCqH+ms1egknYox8vyZrWtFH8n9jpfD8KubY+IFWIgSV1uOCXoMefcRVo?=
 =?us-ascii?Q?vFah6c+T2PBeqTb7iapFJrpRiTzGBUW0mzJRnoJj4ngouRsmEu4Dlo99W/zx?=
 =?us-ascii?Q?UNadTr2NF2dR7jPapXus9ysZMPBhZfjJj6hfW7J0imhujhhCiCRHUtI3RIDv?=
 =?us-ascii?Q?l15xo9nyWxd1wymUs0QTHRppOmSnhr/O60YjFR2Xwi5c48Ymtmef+gdVa1Pg?=
 =?us-ascii?Q?CoE2lgGa3fH74+q0tw0AIBiAGhdnTvNjsQdOXCQgIVj8eaLbtcpKB6bE1sL7?=
 =?us-ascii?Q?tHkeRNRNGYt2NYAsK6o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 15:09:55.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a50b554-1d86-4430-5bf3-08de2cfddbc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Crashes are occurring due to the number of reserved memory regions
exceeding the current maximum limit of 16. It is recommended to
increase the supported number of memory regions to 64, as newer
platforms may utilize more reserved regions.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 common/memtop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/memtop.c b/common/memtop.c
index bff27d8211ed..8ad394193f35 100644
--- a/common/memtop.c
+++ b/common/memtop.c
@@ -9,7 +9,7 @@
 
 #include <asm/types.h>
 
-#define MEM_RGN_COUNT	16
+#define MEM_RGN_COUNT	64
 
 struct region {
 	phys_addr_t base;
-- 
2.43.0

base-commit: e6deb9086afab9d2bdd53db8ecbc7db93af5204d
branch: debian-sent3
