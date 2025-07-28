Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A1BC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 07:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CD683108;
	Mon, 28 Jul 2025 09:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mkzgF3a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0981B82F00; Mon, 28 Jul 2025 09:08:19 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9081B830E4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFP3PuPyi2iODTCp3mLfNI6pVHKLfFNwiOuWk1NI4lKUFNHrWt4cfTznw2xV+5zbsA70qe7jkYSn3ioRHV91KVItSRrIIGeEDjpg6hsPqji1QUI6QHpenziL7zyI2MSVeQPX934LfqyNUdbAJEuKeOd8EruVs5COrSkZTYxyRT41tfBlKWpq5uNTsWu3e2phASgA/05fPNzkfiORbD9eVPRXi2/WHY3+anA8LxmzL/V6Trw0feE+/Xw6weXmyNqNZLhjy4TvJiaWdulplFCgBy3lJnOC4w2XKKy/ZVFPPq/Vb28SjX6QnCklizVoxcbcBpIAdKz/Yfg3EBRqaT/Kqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4VGhFZgp5amsWJjPGKpzfnIHlP0YyUQPTyaJYS2NQA=;
 b=Bc/Q9i2kpynBh8HWveBw8o4NZIahS4HGh0okp0+W4Su4YNYnNDOW/7F6ranMWrvZ3cWpf69+SZonpMeFylcX6KxfRMhJepzMJnMKm42ALRpCcFBS3eh452Jyu9Czqo6dWheKlniyAHrCAOpBi1njmm1T4wc4bE5+yyHCGZKmvNj1OTOTUpOX80G7U2HQJ8LAnqNv3Aa0ur2JyhJl+TImAJKLENciqUqZ+NQP2eV9dnEwNMQbW8vW4WhrrRMnakvSU/aciSBmzXBRKtG4PzrX58HkQw0buV1aaEwSNgP+inHDV2EP4n1HfSFUv76ciaMJGKs/KRximyv+sjw0bfGLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4VGhFZgp5amsWJjPGKpzfnIHlP0YyUQPTyaJYS2NQA=;
 b=mkzgF3a0Nt66KYuwkAqBam8QvlmIrXhj5qTopLXpBI0rnnL04x0pDY/U79dWD6UZv+c/hJxEzlQym4gt56ELUXRLiSPyb19OHpGEOuFPNpnQ9+scs1Y/9pe6+JpcZ0LxOg8IveggECs9r99pwv9DsMgZdR59PWYCkO8KuZsGI48=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:08:11 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::5d) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Mon,
 28 Jul 2025 07:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 07:08:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:06 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Jul 2025 02:08:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Pieter Van Trappen <pieter.van.trappen@cern.ch>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 1/3] fpga: xilinx: Check valid desc structure
Date: Mon, 28 Jul 2025 09:07:52 +0200
Message-ID: <876b6f8dbc99ca305460183dbd18635a35ccc989.1753686468.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1753686468.git.michal.simek@amd.com>
References: <cover.1753686468.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UWhLyqyJnY5ch9i9H+LqKtl7VyggdexQZ2vd8iqgVgc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWS0K55XFO7j3jHlsnCgWGVIJWvlaU31jTXr3lx/VrHUi
 qWp69GOjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZgIxy1GhtW5anOYMk3Yr0YV
 WrKeXL9j2c+k9AdlB06wFy825L+5WJHhf6hiJ2OledVfk8WXJ/4r6qnyEXjBvZ3rVsfJnd1mCxa
 9YwUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 42357d6d-b949-4928-1a94-08ddcda5833c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b+rfFCzwZtR93Mszph4g2Lucv2siLauRAOuuQMlZiehMeELo/ffRl6kE9BcU?=
 =?us-ascii?Q?WZ8iYrUs40mKCxPuYCxHFkjm9S7dGrFpAH5cYtqwnY/GG0Qe1glhGFPrbqyb?=
 =?us-ascii?Q?DdXKR5VkuYWzLnyNPRpaL8MmH2LCK7sCK2FPLk2ZnspjdprMpd42WKN4hAgK?=
 =?us-ascii?Q?B33gqryKjQyk+V8td8zpTIocG4O/GrUOMME6UeMb4VDsu/kyc/alL1aKpoDQ?=
 =?us-ascii?Q?/BPdVwPrU8IBVuctDzm3yGCnTUYMKBN2SdXn5bmxfLdgrq7iXN/uzKO0mBgK?=
 =?us-ascii?Q?oR26fYiP2Avf20MBJA7sKFyvPuiSvhHhlhZD7bUBZKalCndE2YbAcwD+jlZl?=
 =?us-ascii?Q?W7X7rGzdPXL4EUiUi+DiOwPeJ/4zRkHQ/QcFLy79z0HzIxcYz54zquIKJ50k?=
 =?us-ascii?Q?p9J27B/5OMzCsFnZkBFvkL24rv9Fg4uVmFCWC+dJWW4Nu1OUbUxQA6pUf0Zh?=
 =?us-ascii?Q?6Wcf7GTEj4P147sH7QKGNZ5OkJYpJBSk2QAAOsRaudUVbSnjYAcJnjkv6h3w?=
 =?us-ascii?Q?7AhGXzhIE2WWKB3Qzp2EPkrumKs7XIOIFa95nMN2o+1xujUO49bdVC4o/8yR?=
 =?us-ascii?Q?bVntG9At/RKMU5+LzGisGWyLLmY9KUYMNT1WTk2R4oVGVjkWc5vE0sLbc92f?=
 =?us-ascii?Q?JnoejpSQSm5g/KM+Wx/po6nbDqkmVQKf5L9CAnKFr0jHguhPehVvMccqN41K?=
 =?us-ascii?Q?JmZKJHkvouZEDZAhRGoGbl4aLwm6Q7vdEqYJDiH0JXVQfprWB/ZSwld/SE+M?=
 =?us-ascii?Q?PKNJ3ltEVZZnmLHGxQcoWiG0bSFq4enSsN6XwMILmPkp+Cw8840CSLJfzEMm?=
 =?us-ascii?Q?mg9Gz0ZeWhZto446ZdIG8Pjmhq//9DyBNXGoe2B06VQsH8eS9//132+KUQKz?=
 =?us-ascii?Q?sytmzomgcXVwVFhFqXxR7ZD1MOFllGgwzaBcsYTE0nQy52ivDs5O41EQqvOu?=
 =?us-ascii?Q?oxtR65jk3UmL8ZyyP3Us8hQxFHKRn/XnzoIlzz363ci3TY/lsmazJHVbQbgR?=
 =?us-ascii?Q?iUoyxS8l2Bltoz/Jicz5hW2IaFugdeweuHAVeTX11XYWuWfvAw7XaPV0P9Pg?=
 =?us-ascii?Q?VJWm0uPWsP7L+USB22YJVVE004+xElO7IvNH81HcVO3IjAJXU9MvCnTiWfeR?=
 =?us-ascii?Q?lRQzqwDyLjJo4ykD5Yx8Vow32Ud+C/vVwBOFG1WT0yN9AG+plrfhLo8GnRj9?=
 =?us-ascii?Q?7Xsj+IWlJ+C3asQhOUIuogS3ChxtGIbN8jjD1lz/hjUbl9PIRWk3ZVgqjL8Z?=
 =?us-ascii?Q?5C6cEGZT3WpHdQXOrv6I/hWhgpLFIUEzpnJIGl5lnKyAud0xN0X9G3ra1fZ3?=
 =?us-ascii?Q?WaIOWRQV+E2NkhHHrvtw1c/ybJYC1AZOFy0GTkvFJllBnbutiD2mz/DoxL8W?=
 =?us-ascii?Q?YQD6DYuYgi8a5GRNGDOhy7pkN/jMgp1oOdBUu7PEcrGHGiUi9CBgI3L0VXov?=
 =?us-ascii?Q?wXZpHfx121tUqlH/PLOte2fA7hUwbsA2BbQEDb/q4YMezbzNhuwFAKlwCqyq?=
 =?us-ascii?Q?uJWEd91tTbIktFlKYXDpYviFtveY45aRBDvJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:08:11.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42357d6d-b949-4928-1a94-08ddcda5833c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

FPGA validation can fail and return value needs to be checked.

Addresses-Coverity-ID: CID 583150: Null pointer dereferences  (NULL_RETURNS)
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 drivers/fpga/xilinx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 28c68faba55f..25b348648eff 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -50,6 +50,9 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 	dataptr = (unsigned char *)fpgadata;
 	/* Find out fpga_description */
 	desc = fpga_validate(devnum, dataptr, 0);
+	if (!desc)
+		return FPGA_FAIL;
+
 	/* Assign xilinx device description */
 	xdesc = desc->devdesc;
 
-- 
2.43.0

