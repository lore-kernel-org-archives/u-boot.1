Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C21D10F24
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 18:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F2F83A57;
	Wed, 26 Nov 2025 19:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="absjAyUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0088983A5C; Wed, 26 Nov 2025 19:22:10 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE37B839DD
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 19:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlwRmFecOJ9qVc6QxxtusAtAw8aQOeOYVMrBwyAc1TpdvD2o3ZKZei0QwAODwxCYPy7MnRPGZHp8MsCtp0rWdlNbVfd0wB4Pv1OLFPics/KEnxd3mr4jP958JVTfTQMJm/CcBCq7LHm9oDBfOEy7QFO0u8MslSjn5MAN+cwUx6dIeN7fus/8U7n1kgjvxm+w0A3rcaM7+qdcdQNl5b1vVb/udZprnkIPMZVOglXPrG/ivOwrq0NBLbi7c1JpI2+6ILz7x2+aiUa6r9CPIyv0E4UQBYjrkIdg7PvSFgfJdjvR5Hgpi7XTH3kK42PdD/HbPswdDpxJCdeNWTg0GJyDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfe8F2XQENVGJordeZTJq3LlraIIEzzZ6QJS5pVllpo=;
 b=mMtW3dE4NXr1kG2d5o/nowGFziXXAB9//h4ZHFvZfFvj99tfFZiIzuSbafKnlqcoT8nGA0L9GGh56bl6nJSO27+f/T5E/WlzWtHKAOOGGw0d98OyPo4e/7eK+i+5O4a8OgXrzLaxj58+5k8X3r/DZcDl6Mt0T8Dlqb8jOt/QZFehPCGKuFPG6xMDewBk+DmhcTMyvA5Fh1V/efPyV07MfOwE0X9Ffsm0X3o6gVe/6Uaai6IsnkjbOXiLU/4Z1ivSDLu/VNJfFc9fVHHrdi240igc7kd5QF0eDheywCYybQJHd9O2DlPHRf95gdPEhY0PZYqPLXQwwr1X7/LhU6Ax+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfe8F2XQENVGJordeZTJq3LlraIIEzzZ6QJS5pVllpo=;
 b=absjAyUFBZ006ISJKQR4GRPNj8a8TuW3fe7zyPwUgw6Guq1oswlXFQ8RLKiw/c3Hp844DBjhpLznmODj+B3kkn5zzYiO3MCU7yiveB8Gom2xOY1hp5mnoGAYgd+INzPXR3EwtqGqB+O9BpWwLVrZsNjP7snIV+IzlHFX1orp2YM=
Received: from DS7PR03CA0175.namprd03.prod.outlook.com (2603:10b6:5:3b2::30)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 18:22:00 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::80) by DS7PR03CA0175.outlook.office365.com
 (2603:10b6:5:3b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 18:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 18:21:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 12:21:58 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 10:21:58 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cadence_qspi: Update the delays for flash reset
Date: Wed, 26 Nov 2025 19:21:49 +0100
Message-ID: <3fd0641a164a4d628fdf28a94771829f3bf9cb0c.1764181308.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6crsdFdmO3ZtqXIbBnPXtG7DCm7Rvz0D7osytPtd/Ek=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSqu9ppGd/bdvTK6yP7ZGSuXxJ6x+u8tNvv5p498y8E9
 ipfzxJ93FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATkaxm+Cs7+cfcW9VbA6wX
 x/b9aZZLfZc1bb1hUsWhjb/iQ7NLYkMZGT59XedVceAwy4OdMUZ/UuQS9MpdlLvYDHky7psy90R
 mcQIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: d26c1a25-52f4-489e-2471-08de2d18b0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?801UxBA4e4M+HIvPFwd7CoJ7qEyh6Nb7PKjHml/Gg8iAC5tXAo+SV7O4iK0R?=
 =?us-ascii?Q?ISt9k/tC3LCBmulhFUGJTj6kzUtKz0/AuTJWxhz7jxSXcv711uYLCHI16MoK?=
 =?us-ascii?Q?/1xQFAOHAb54dcSby9FrBCB8pdWTHZ6Zujb/I6TmisX8nf09jDwEIUOkS94j?=
 =?us-ascii?Q?2tt9wUFbITAhVUobUFKZYfS9pdb9zYKxVM4yOH2Z4iQe4r3IgaR0jzNnwx5/?=
 =?us-ascii?Q?jyazoj0Zz2QW+XzGkORtMaLAcn2mUvvPS5Q9nnP6dJaUtpE/Seh1WBiY5+e7?=
 =?us-ascii?Q?dcn0EYih9ogeBHRYL+mVVJ5/dUuEVshlhA2Z1/MB7B6/mEB+MtHN8aGAnLfe?=
 =?us-ascii?Q?+IvKnMuA3smNxkrX6pvEZmS0uUfs6Nt/14UNh/0lHhTwaA0LGUBj1ur7NkSE?=
 =?us-ascii?Q?DqP35dGNKV/bEHNExNyelm+ws74tZvjTm7Jf/8J0kVXOAHG9l4CD/fGkNqIW?=
 =?us-ascii?Q?pphZnvbfJHxx6t2kKZCL7yaAu4D1TRwmpLEaZ/uxv3U7XLQJxeQUJdoOWjnR?=
 =?us-ascii?Q?GpeB9OOQl1C/6UtGg7KorOv6k+axRfw4A8teEXTPcgatWHYcVEItnw/7TCSH?=
 =?us-ascii?Q?/ZRpCBUNWhIcYcTVCNeS8TjvNAM6eswtVohZEYyBQTHajW8WLnGn/Pk+a29P?=
 =?us-ascii?Q?GHv4iRj4ohpEKAbwgv6vpFOOOO4ETAQhiQxsEdEB/bK6YrEc0D1Ss57pKfo/?=
 =?us-ascii?Q?gtpJhqIn78jCJu0z1XsVhxW+bJJdFkl7lLf+9SRm68yh+CqgIK1WigTyqlY5?=
 =?us-ascii?Q?KLWI1gnD7ws0Ktc4FL8WXnMOW5E+tfx5AQXxh8Ive2mYni5qRD2HCRAPRgUH?=
 =?us-ascii?Q?dmewFLYNUwdcL1R2zicqrkT98qS6twW+z1dkq+y6LLph3yiB+F0Hxg52AkF/?=
 =?us-ascii?Q?NIJxdB0Zju5g7T6XLGZ7fNro8YsW9dRD/f2QYyA6F+YBpSBosV9zuXilChMY?=
 =?us-ascii?Q?lS25Gjv+GACLNpLPvF9LUrQJvYqA311EYEHHfS6SidKHFPPzecEavVdT/0jj?=
 =?us-ascii?Q?itP7te+18qYeFrQ92jcQDY8BvBcnKzvZnZygBPtlN1fPN7QF/IkillMEKMaf?=
 =?us-ascii?Q?iWaKwUl6m0OKinSWomdzjYCvJXnPG+0MxWl7WdpD1hxy6DmqQ3POeh2Ms9pW?=
 =?us-ascii?Q?QU3N2akL/1vxrNQpY/7rskoaWOY31XyUDc34rQSxHDBKIap2UmM/KjHn3JTU?=
 =?us-ascii?Q?aKlzPtRHc74q2kGU6l2kow89xNmuEUpVYE6+tspdJ1NZZHaCoSQF0CvrqXxt?=
 =?us-ascii?Q?uR+itpeCWjiRltAO9cNyTPjC/yKsscLz1/Md/NeAjWn6eBfJK8V9U1NjPSS9?=
 =?us-ascii?Q?mDy6qgbtepZbm5GO7LvF/45Byv7j0T1XHs+DqHGrHDcNewbBkwAzME5psJmv?=
 =?us-ascii?Q?kyJ7kcYXIN9ayxDWKQglE8ZR+gTSyFlnxHjKjso+bkHojvnXhN3W/NcoIQjr?=
 =?us-ascii?Q?11KD0bGkk8/TK9KP5vOEmEAhiHQWzcSgGoQbeKonIeHRNpA+/LTBerSp0OBD?=
 =?us-ascii?Q?qMDGwIcf+KjpNjSk1EAVrQasOu61EzPCQR+djlDjLp7h+XmQe9IcUIhFXW5c?=
 =?us-ascii?Q?YRWKsWyhCAXyZahy41s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 18:21:59.9345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c1a25-52f4-489e-2471-08de2d18b0b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819
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

Updating the delays for flash reset in the mini u-boot case.
These experimental delay values by looking at different flash device
vendors datasheets.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/spi/cadence_ospi_versal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 0efbbf56a5e3..e3ddf127e5a8 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -178,15 +178,15 @@ int cadence_qspi_flash_reset(struct udevice *dev)
 
 	/* Disable Tri-state */
 	writel((readl(BANK0_TRI) & ~BIT(FLASH_RESET_GPIO)), BANK0_TRI);
-	udelay(1);
+	udelay(5);
 
 	/* Set value 0 to pin */
 	writel((readl(BANK0_OUTPUT) & ~BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(10);
+	udelay(150);
 
 	/* Set value 1 to pin */
 	writel((readl(BANK0_OUTPUT) | BIT(FLASH_RESET_GPIO)), BANK0_OUTPUT);
-	udelay(10);
+	udelay(1200);
 
 	return 0;
 }
-- 
2.43.0

base-commit: 5f6d6db9c301daf10ddb707a9031f1a467d6ebf1
branch: debian-sent3
