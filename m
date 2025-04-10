Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB752C369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C05883A7B;
	Thu, 10 Apr 2025 10:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MHG3SVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5AB83A57; Thu, 10 Apr 2025 10:31:18 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F166383A3D
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGwOrjDyOX8bk3LhV+ZkKuutw2S2iJqO5ZSv6u8ua39bJaQYBuoN4S+rLPVSH1hOJFvJoFxPeCE9Qy3nFr4HDu8F/wfqgO85AoEEsTIaZHX11Sk4vEJzog4jF9YogQvXRaETCn/29vsP4sIIsfr89MByc/ZTFYHu1jwbcS7RsnrDmCJsqkg9lmR6kCY8w3FExAKsX7iAR4IMzTDYlT8yuACVZNnMU9bgsSurbbfip0Qs/6CprSKNmgDF5JQPleWraTkt0oGMVD0rQpyn0n8NrdT2Vb3tQ3xi1GyNnmV+f5D6ZCXh+UIxuscl3J/KZzafbo3ex8VedGqyZOWSIaXwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzJPuFKsB4SolRi70s6l++UGvfUQGE3/PB0wD3JpemA=;
 b=IVDOTtXcaO7OViSUNvv4wBpZQmb2/0qICsAQICzq9dkfXPkvmWLSp271RewmeClDvIa3ea1GWIj8gH9wJlwJv33YTwMFfZVlh00k8peFVyuY0vAdINwJuVKEOwoDMDyq4pR/3R/BckKbWLBQgPiAmBkWoN32Ak8XOacnPKdUF8usz4vAnY0Q+T8XNWly/nJeuOPQsD38G7Cf3c6tqfcxsqRx3o8Q22EFYRbg563fNymiC7y/ssU/ohvsl9B2dvrjDbPHfF5Hn00jBtG0uyO6syv+KFpHmNIrh0Mziu6Abcbgs1uN0HCLeqC4C5Z/rCbtI3rMULJBgArLb98BZq9HJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzJPuFKsB4SolRi70s6l++UGvfUQGE3/PB0wD3JpemA=;
 b=5MHG3SVnBUfmH3oXfbETqcHIVFRN9VDJcoUjABlwvHkpE+LErmZO9rJ3+oPc8JD0I7Ct+BLYVGiMvZZaIbcC6zF2NJqnLkXeCVgStxYL+BAk1ezUP74Y0OoJKileEK+ow6N3NQzHz5mEvvUaS7wnHGMHeWmyWIV4wjSoZwJnoAQ=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Thu, 10 Apr
 2025 08:31:11 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::ef) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 08:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:31:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:31:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 03:31:07 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 03:31:06 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: versal2: Add usb distro boot command
Date: Thu, 10 Apr 2025 10:30:55 +0200
Message-ID: <121b6879efde0b83d3933852442895631c4cb24f.1744273853.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744273853.git.michal.simek@amd.com>
References: <cover.1744273853.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c96bed7-c658-4f8f-f747-08dd780a0bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMYoyz6jXzy9m7ZSxIa0S+BmcJlN8C1wtWjBW9hHoQhUFBfh3Aj/F2GYTMuF?=
 =?us-ascii?Q?NcOTGqwYxInJWBqKmbTW58ANB8HKSGVKm5O8MqRKCVWb8IVMyoBk4zz/9nhr?=
 =?us-ascii?Q?xqXFLxhiYKCkBMvZCci33nkqxFKf3v1tyYL7PrNgli6nqfNMu17UaoeDWcCU?=
 =?us-ascii?Q?+3jx2KlpwpPEtk1oZE3988hrwdPLWMxn7WamI2BKnr2/AhKT9u5R1Rlfh7Kk?=
 =?us-ascii?Q?lkkh2dzwCuydlMn4DsUlgVZLVZC0suUBQKWgCZ/719bUj+lqABiJzCbuNY3W?=
 =?us-ascii?Q?tZNPBe1wkUrafnzk0DTnxEeAZSwvj1oLRHS4f/fS6dMmjNK/MrIlJ7UT47Xb?=
 =?us-ascii?Q?L7LfX5ToV8QypH6fcLPZ1P363Z5ZOf+KaSgJ6cNl5iYaEBZkggJsOJ8X3ZaC?=
 =?us-ascii?Q?yetj5TA6Z6tQeFlt3BNWQwJdSCYm7hrNr+7UOcGQJkvc1qPqgUCXAiEhLu42?=
 =?us-ascii?Q?6c32ZsS1/23wzHx6NPGZRBdChzjbPLfPXYcxyCWJH9d2bIXvl0mYIVrGA7Rp?=
 =?us-ascii?Q?E8mwaab2/QgUl+7zj7D7g7oqMQXYNWYn/+g4CHW/pCPBMvJ6+QddtU5pFW8u?=
 =?us-ascii?Q?g6YLyFkPXj1GqbwXW7NEaxtE90l/nTi7BoyJLHslLNWrdQsyXzRRPlclUYwF?=
 =?us-ascii?Q?Q8bBjoP3CqF8Wlt80A6VFMbBA611GVjJ+6k/gH+lQm6RK0YXsQiF8QKhG3vK?=
 =?us-ascii?Q?+WCy7lPKVTFVlOZXpZhycOuKfvzl0tfMLGKCxK66k1YzjoCAWmUcA5O1LMG4?=
 =?us-ascii?Q?Q+i0i2Z3fLxvUT94yRiAapqlOlbq+ZaXJOc9Sgk2Mzmmc2Ndih5A5s5fW37H?=
 =?us-ascii?Q?Cg8vvNZl+jcBh6rsPD6mP9JL5NwO1ZyB+q74+Lx5m4EEoxhn4/BrlPytTrZY?=
 =?us-ascii?Q?Tx0ak1ioG9olZggBWmtmxyICU+GIN6i0DqUT9iT+A1Qneb8FKbwhaWi8ipuP?=
 =?us-ascii?Q?zcfEJaj0pIJyK/oe59lcjZ8vB7fbyVfAvV4ek0LV+G6WOBVqzHpkCOkX72Tk?=
 =?us-ascii?Q?3AtMUN3LegHNd1BpXKoywDzOEydN2/CoTD4FYuDkF8Pdnt7mmFoN+KbxYCJ0?=
 =?us-ascii?Q?hoWZbyOvtpGAq5GtZa2V3SDR6EYkX/2jCdebYXEqTPC6Kb2EF9WyQmYytPS0?=
 =?us-ascii?Q?h1ifah+uEmvLHJFaCqLXAC+e81YwcIVYSVo+I6Emm0FHPG8lCwEekqzZ0tXC?=
 =?us-ascii?Q?PELfB/CeC9w8ihCM9lv8ws3hkNXwmntnHkvpnwxgeO8Vk6lya+sP3mHRJgiM?=
 =?us-ascii?Q?AvgPgwYZBs49fIo+q/UVn6EtvCOcJbFruAh5LOUadlzNwOYsMpLD/KNBfOxt?=
 =?us-ascii?Q?rJ36l52Qaqkp+U2C2b0s3gy7+Wo0AUZyR1oIp2hUCjqZhqLrLL3Ot/EoY4SK?=
 =?us-ascii?Q?YQJsm9LW4TOId716onm5M9lj4hXqLxEqHtKCTybMg8j5rRaOsaMbaz9CmRK3?=
 =?us-ascii?Q?OaMWNzhJzxx3fTpbhi+GstuiBc5Y9T1y1L8mnh7xvsYYoItpFhThADSl4DoZ?=
 =?us-ascii?Q?eTams7VO44cZIRg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:31:09.8559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c96bed7-c658-4f8f-f747-08dd780a0bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
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

Adding support for the usb distro boot command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index e937375ca6e7..1ade6adfa0bc 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -125,12 +125,19 @@
 #define BOOTENV_DEV_NAME_DFU_USB(devtypeu, devtypel, instance) \
 	""
 
+#if defined(CONFIG_USB_STORAGE)
+#define BOOT_TARGET_DEVICES_USB(func)  func(USB, usb, 0) func(USB, usb, 1)
+#else
+#define BOOT_TARGET_DEVICES_USB(func)
+#endif
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_JTAG(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
 	BOOT_TARGET_DEVICES_UFS(func) \
 	BOOT_TARGET_DEVICES_XSPI(func) \
 	BOOT_TARGET_DEVICES_DFU_USB(func) \
+	BOOT_TARGET_DEVICES_USB(func) \
 	BOOT_TARGET_DEVICES_PXE(func) \
 	BOOT_TARGET_DEVICES_DHCP(func)
 
-- 
2.43.0

