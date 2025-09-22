Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641A3CA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 16:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1724833ED;
	Mon, 22 Sep 2025 18:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w6doB7i0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B9E83423; Mon, 22 Sep 2025 18:05:15 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5458E832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 18:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxd3SwY4jRHSmbfpHWAaNqvklE93fpDBIh2jxaAeaNVetVfTmCXfo/HRNRp58SXa6+5NTMlx81j1JU5rZLjhG/oOMfW3eXhpmARW2qyoHznPsGKNU6fkKNtX5n2YJYTIygI4lQSG7c9zVQFidIpla8j8zPBNLV1QdF3wi/2GXp9UksJEdSGGgvBxwurKS7klFWvrWuKVQ5AmRDPG6+H6L1qlIbD2lsqhnvg0EPDXvwObVx8tepnAQCHFlc+gPMSlrk/+6Jy3RZUSkRrcx4GOiQ4M0fFAcdP3W5S+NdWdPg7UliV1rGIj9MTePQrCTepRjBKQ24ccD2XKKmPuCjgxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl1yEh7h2ZERZequDAEnR9AfpXS0zDNdUZ5vBNWsuWM=;
 b=si91gu1fJxoc97YQRgMlw6SswofrAhxUOET8ZItgVONlWb6/QKbegasGd+77mv1M2YHyawRFT0aBGouwzLOWsT1jNIS4uamnz63CogNQdBUjIv6wI6GG0XFQPnzERDNOEiZLyeaacB+5C8tH+lqUhlTLea+bX9oppPHgb8XHzdd627CCTS3/wTArKj1QVtF/ip9Q4p61VADmrr1wDVi8Zz8QR7IUkZvieyKrTEt9FDJ/f3XtRDUuySJMzUmKCa4hvntZxfIuBtiIXMN6dz90nkcMS/oeRnHwXaChLcycwDkNwxN11XZYrOz0bC33f55CnzAN2ZnjWkCv0ih24duZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl1yEh7h2ZERZequDAEnR9AfpXS0zDNdUZ5vBNWsuWM=;
 b=w6doB7i0vGEEcWfsR9/fNw/2+RbFjNKV64zXRrnJuYJHDqzUE1FMF0Ngw+S8/Yvp2GGQiWkq24DYGnDiuwdXBAJOHpYHW4LK5QZTR7EtS1Ur2/GpxR+BDm5qh6ntOlpRvAR/z3bf3q9zlnYNL6aEGfb14RXhVppwtvns7OMxhb0=
Received: from CH0PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:32::23)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 16:05:06 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::f0) by CH0PR07CA0018.outlook.office365.com
 (2603:10b6:610:32::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 16:05:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 16:05:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 22 Sep
 2025 09:03:48 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Sep
 2025 11:03:47 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 22 Sep 2025 09:03:46 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Marek Vasut <marex@denx.de>, "Tom
 Rini" <trini@konsulko.com>
CC: Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3] env: spi: Fix gd->env_valid for the first write
Date: Mon, 22 Sep 2025 18:03:39 +0200
Message-ID: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Eq6bTySF2FBpH1KaAGzDpTxzgF1Bn3rhGs921aXJMhM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRcLI7p+FN2hKd8QeEE8ZfZPSrLMsSnGF9b5Xexv/jAV
 K69TRUmHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCR3x8Z/tecl5c4fOfP2wOr
 VB46ckWuffFvW/sVha55B14XCvyurhRgZJgdtu2kbOPfN9s+iJ6zkNz1zdh5sZLR+ssKC7bn9u4
 MeMgGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: facc8dbd-732c-4f35-db5e-08ddf9f1cc4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2PwSol4JS8+VPsoAoT13NeGk4M0MCeztyL73fKqCVcnAdFSQI+R0NIk1TGJ0?=
 =?us-ascii?Q?f8QG9y9Xo9L2AeGqYk3qT979wOszggsAxhyhAI1+UoSdKmPIlXmFnr1nwrtI?=
 =?us-ascii?Q?N3vZjWcoGhCwLWvibnqIYZkX6yH9S+EwH19H/OSpkikzA7pdzv+c5qwQuDdy?=
 =?us-ascii?Q?lT94bYew2oSzgcwkljpUUqrpb6UT7+B0S5zQeksnwx/gTMKgE/cf1ds7Fj+a?=
 =?us-ascii?Q?IlB0fynRTa4QLRX6pIv362fODjgACHS63vdxS8YWP9AYogg6RusBUY7cVkTt?=
 =?us-ascii?Q?cFTSufKzcsOK2JYb0adVpl79xs9/ggt40a5BYvCD6YoSHc9W1+5CiNwBGjrp?=
 =?us-ascii?Q?rVEgq+gd1mLfY1Pu1nUAnNW3M2FjqZw4cS0rzgEdOi/HHUIpFKl6tkp2QxlL?=
 =?us-ascii?Q?onsIKYg1rb/hd26QhFi/WlW/cs7xNo5ZiB5RPjqyc9MsC+Ew8zCfc26MpqI6?=
 =?us-ascii?Q?Fyhsp9E03cH5SrMNypd6X18jfwFYWSpLVEV1FsaDF4I80ibwffs6bvEXsY26?=
 =?us-ascii?Q?VAyz40Jy9dtEweqBGaOk2ysHorOzzG/8Huynz9vdixJBu5T8pSzvYahuQf9D?=
 =?us-ascii?Q?OS4WuPoO+QXTLRz19wCp/SOeAE1tSqWolehhNjEwS30Dfui2JjJiG+gg9waZ?=
 =?us-ascii?Q?zbWPuA9Y07SwWv5dNqZdNx+3Cth/RuY56MTxVnAbE1OR9W2JRxz78xsGJ9+0?=
 =?us-ascii?Q?aowNTZ7siIQhyz/6KBIebewnGj2L1uihhgAl9/gme/0JuN/gbxcLQSTujR7r?=
 =?us-ascii?Q?t7AYqq+6NAcQLrDipbsfUv0K92hxnzdEMHscjdcyBI7Cp2MQlB1n+42deC82?=
 =?us-ascii?Q?GNoP6T/HcTSjztaqF4n3VeVq/dwNjopQ5kWjy2o84uCiEJ1dnaYWWxhHwK9L?=
 =?us-ascii?Q?vp71J+tUatVh4JvBvmogtm4iOviqG9QlRjMqtBZ6ER/JpPcmkcnczKETgQMJ?=
 =?us-ascii?Q?Ec8uYoVKQdVfMOn+UgF/FehlPB6eoU9PD74GJyh2tatRq5cYGmIuB8Eb7M/t?=
 =?us-ascii?Q?nn1zPRjEr9sl3+jLMMqwFnNFObf8sIlpTyyOnRHr8YP52gSL6EpF1U6ELTk4?=
 =?us-ascii?Q?CUkXbV0kbDY9WodjgjSNUb3A5mu3bAtBE1ryOAAENElozy3TiXGQhFpD2YCH?=
 =?us-ascii?Q?gZaq9+q3ld1Dc9DSsJB4U6R18k/adhBR73kfNyznRQZhs8OptnTjzNtsskF2?=
 =?us-ascii?Q?iqyk1k6RpGtjR1/65Hkv4mIFarsMoBfsFniRb1mrmDXDKApFdaQLpvZYXd54?=
 =?us-ascii?Q?G16GlNMrrxshcsHtF3srdLq3xlHd6cp7H+rtDwFSbTgBQrInCPDQe/m5iqex?=
 =?us-ascii?Q?e6Hf3dgTGitbktsBb+of6tVt7sIHgkvSMIW3B/yN11fLEsaTNcsE5XBhIly6?=
 =?us-ascii?Q?EF7rpbQTN+k6Ls+NOVnqrfYxZ9M50UZDnQnKWyVjaOjXHzgumweNGMjP4GtY?=
 =?us-ascii?Q?/swiA9A1c+Lk1fPWivwHbQ45AeL7rbujks6X5kbcMKQo7CBAQEgif7X+MXSC?=
 =?us-ascii?Q?3GLtGJhUZhaar5s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 16:05:06.5840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facc8dbd-732c-4f35-db5e-08ddf9f1cc4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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

When both SPI environment locations are invalid (gd->env_valid ==
ENV_INVALID), the first call to saveenv writes to the primary location and
sets the active flag. However, the logic for updating gd->env_valid
incorrectly sets it to ENV_REDUND, which does not match the actual location
written. This causes the first two writes to target the same location, and
alternation only begins after the second write.

Update the logic to alternate gd->env_valid based on whether the last write
was to the primary or redundant location, ensuring the first write sets
ENV_VALID and subsequent writes alternate as expected. This aligns
env_valid with the actual storage location and fixes the alternation
sequence from the first write.

With this change, the "Valid environment" printout correctly reflects the
active location after each save, and the alternation between primary and
redundant locations works as intended from the start.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- Polish commit message

Changes in v2:
- Simplify commit message

Origin commit message with more technical details.

When both location for variables are not valid (or empty) gd->env_valid is
0 (ENV_INVALID) which is setup by
env_sf_load()/env_import_redund()/env_check_redund() calls.

When saveenv is called in case of SPI env_sf_save() is called which
contains logic which describes new/old variable locations.

if (gd->env_valid == ENV_VALID) {
        env_new_offset = CONFIG_ENV_OFFSET_REDUND;
        env_offset = CONFIG_ENV_OFFSET;
} else {
        env_new_offset = CONFIG_ENV_OFFSET;
        env_offset = CONFIG_ENV_OFFSET_REDUND;
}

In case of ENV_INVALID option the first location is used (else part)
and variables are saved with ENV_REDUND_ACTIVE flag.
The second location flag is rewritten to ENV_REDUND_OBSOLETE.

And
gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
but that's not correct because the first location has been written and not
the second one.
That is confirmed by
printf("Valid environment: %d\n", (int)gd->env_valid);
which is showing number 2 (ENV_REDUND).

That's why change the logic how env_valid is setup to be aligned with
offset calculation which also cover the case where initial state is
ENV_INVALID.
Then print about Valid environment is showing proper location where
variables are saved for the first time.
But also it is fixing behavior where the first two writes are going to the
first location instead of the first to the first location and second to
second location. Alternation is happening after it.

v1: https://lore.kernel.org/r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
v2: https://lore.kernel.org/r/7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com
---
 env/sf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/sf.c b/env/sf.c
index 0b70e18b9afa..0e27a020643e 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -148,7 +148,7 @@ static int env_sf_save(void)
 
 	puts("done\n");
 
-	gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
+	gd->env_valid = gd->env_valid == ENV_VALID ? ENV_REDUND : ENV_VALID;
 
 	printf("Valid environment: %d\n", (int)gd->env_valid);
 
-- 
2.43.0

base-commit: 281f39d07226d7c7239c22a0a42088780a78bccb
