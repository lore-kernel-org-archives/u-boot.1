Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2DBC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 13:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE7C881B8;
	Fri, 26 Apr 2024 15:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mUiJplFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C6F881BF; Fri, 26 Apr 2024 15:39:40 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E15DA8819D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 15:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGyT/R61XrfjYKAOg4QuAoKBvZh/74bJ8vajcdILsEhI3US33OjPZnoPfEdPGThJgnT5PiaWgNAhA4Kvfp1kQV0UAR6IDqu7EYJuXlkNn6hGHbTceYLfNXcHT0sSqlSOdB2yylBzGVaWGlGScuqzj2IFJR8T30BDdL1AfapVgJPQBkO9+LfvLBdbJVDCzJtYrrOeeSGKBXw77DD1GQmj/tddMofqE8aPClHIygXegb4bH3//jXyG2GmX3zoIm1C38jhm+wZXoP31sZGcgJWpUBsa5FHNxHvDayId6XEwrQw78M3nsFd3Hp3RjW97/S+/V+2qvc9zSmIjb8wSs4NMfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06hgP/Zm5hfTSGh4cNxv+kxlX9GyOcaSSGVDcR2zS5c=;
 b=Eo43QYURaFnle03410uQkQxGKFcp3I7zwMDl0WxhcCPDrpVO8Il0QTF7p0elrqlxhkwuR7vmuPx/dyjSYMI5bALWe6pgEB1hcfA3pRb9yyRy72u9/CvJwqVif65HghmgdLyKZ+cOoqZ8S7l4mYPP1L8ZyI2aH6du9fmTVfQ9KUMTKlQxqFPkj8KOsZpKbAbMivNlSAX4ENLu+ublvCSMyk0JrGTE4ZA//DNdXYFN0eTgeKqPjloWQ5/u2DP2d9DZRtMIN34Jj7Mb1QDsk8vsPIF6XrMRftU5aPptDr+gDWt/ZnTbROA5YIUqk/++U5IRTYRSOBeuY7Nyj7y973AdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06hgP/Zm5hfTSGh4cNxv+kxlX9GyOcaSSGVDcR2zS5c=;
 b=mUiJplFijcDT5GliXeYieqsLc+EFfShWiKO9ue7nvZyjqMwDsyVoaJ+HXvI/Hso94+LOYTnx6TR9JwXgQOWmHmYkNl9Bmdl3wp7IdN8ZAWaNsxs3hWTfQLy0xgVcrOJIxls1CrhVw6FPHpllvrrBondXz/hMk8s/snHliy2YPKQ=
Received: from SA9PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:21::32)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 13:38:33 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::53) by SA9PR13CA0027.outlook.office365.com
 (2603:10b6:806:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.16 via Frontend
 Transport; Fri, 26 Apr 2024 13:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 13:38:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:38:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Max
 Krummenacher <max.krummenacher@toradex.com>, Peter Robinson
 <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 3/3] lib: smbios: Detect system properties via SYSINFO IDs
Date: Fri, 26 Apr 2024 15:38:13 +0200
Message-ID: <7a3722af00af013e4a76f3b086c08db50d155fa1.1714138688.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4171; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7x+cjCRe5BkbGnKTvk48ReFA81q3YyUN48BctbePqXU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTtdZ7mV3Xcm4qOvq67VR/2YP7G1qgzr4VyfQw0pW2mR
 39d8HVPRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIRT3DfIft2qs1Fh5wOndw
 /hE/n5is+Rmb5zHMD9CTElMUbXbP1+9jKWGdm//Z0qUGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: a90e86a4-7603-4261-5177-08dc65f62b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWOYxAe7AB7SUyd/cNudIOV5Dw/tvmguleoz4RfiY6j1WRmvHEqIHzca0fQ6?=
 =?us-ascii?Q?DfZhLDmcZSPhQGpQzDHDpQbwjNJ8Hu2vsF5GzWJhQbXRQyD5ettsyUEqQol5?=
 =?us-ascii?Q?cwj7LclJJeb3KyZpkqVoDjnijHK4t5Ly0UJH9pk43PDXZiBU6HrR7DvD40sV?=
 =?us-ascii?Q?b6LSWjVvcnI0kN75F+MogTQ54cwiGrgTDscOkDu/YG65629f5wxvTOjLvzWk?=
 =?us-ascii?Q?lHM2Zcgqngxqci1XTxafRsZRdnplliiLkTPEcFcTHw7Df6Z9CI8Zd3TH4j7s?=
 =?us-ascii?Q?dLDKG2sq+qxf2dY7V0F5HpZkkndH4JowYwkT1lJ1bnZrhsRJUcx9lVnt7zWk?=
 =?us-ascii?Q?lgxS3mmKfWHnpEA7/oFm1YNdbFbCZsys6aMqxPNGh5L1HGYFmNEmtGIeX6NQ?=
 =?us-ascii?Q?sYR95clUnug7My/XHjjkLK2McHSqpn6s/2Tvx6YoRmLf2I0tGUmUjllss+Nx?=
 =?us-ascii?Q?eYb6Ym1YM3QKwAamujULFxMLYQ1wv3kepjhzM7JnmdxO3/2PDyNGYNhsACrF?=
 =?us-ascii?Q?7GRs62/LiAFPIJQ0WK5F+ayoJqn0xJoiRnr2Bin+idDf9U/cQA8SGvma0cRy?=
 =?us-ascii?Q?oX7yDYb5Wu3bTxPuquRKXD7LkRZA1kD2YwODaj0Ir2qCQLyEf1GxQnRYABQY?=
 =?us-ascii?Q?AVXf55ChHdJo5MYTWfg7jl/kluCEAfrG1yZNDzZvKXSWxxX8FqhAgHu+BYtP?=
 =?us-ascii?Q?oQOamyslppcFdkmuaK7ceddsLxJI+G07xOGu1upfbVYc3AGkicAn8wr5rj4R?=
 =?us-ascii?Q?6k+UJmuIuNUBKoyksHSHa8+KA+o1icTtxrI4Kdxz62jEa/5l/T4RKULUsQr7?=
 =?us-ascii?Q?H1cGl4N2PM9+TZOU1bB0IZxCaAPJ2ULEjthCGrOsqpPTZqbiAYCw/WvzNDFO?=
 =?us-ascii?Q?QdSdztxrfpuG8XtgspG3am+amJcLeAt5uTBJ6LIgjA45+vq5vNTSam0CFtwO?=
 =?us-ascii?Q?++MeBsgLeVHi7Z6nL8xp0ZGWHqAuWRCk22FboUHN+Pqd1mFH1e/UJUk3Pm/Y?=
 =?us-ascii?Q?Z7/6iq/qoRedF713azKoyUIb/GGUw12uC3hjjhWeL4jyMXxqUby2YBvtDVWC?=
 =?us-ascii?Q?/FsX4JxUzTcWLuYmWWJ9gvOpwQnC1Eu39Fd1Wyz5ycS1sUWjA//AjeVXppEb?=
 =?us-ascii?Q?ooWR7QyAbWCDBiOmS9UUEATE0GfoV+SpzCje0Xtzzt1jAl1dJr+wMmWgamMo?=
 =?us-ascii?Q?URa9JswFBbNoBF2ccpyTY/hpSxe38pcnsLvp2jiQdzv+DseeiW4+dVvTjGGg?=
 =?us-ascii?Q?y+OqUa4DJcIV/lb/X5alRZ3I5LqTKPo6mywbXM1CSk6LiFztjmg3QlM27xg/?=
 =?us-ascii?Q?1++P6BFmAifQUnQgkARn5G1ZQdU3usy30FNmkqNoI+QG5nigQnuZ69HPvaC6?=
 =?us-ascii?Q?Yle4aoV7uyN0Fdp6deHsr5I+2Rfz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:38:33.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90e86a4-7603-4261-5177-08dc65f62b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

Code is pretty much supports only DT properties and completely ignore
information coming from sysinfo driver.
Code is calling smbios_add_prop() which calls with
smbios_add_prop_si(SYSINFO_ID_NONE). But SYSINFO_ID_NONE can't
differentiate different entries from sysinfo driver.
That's why introduce separate SYSINFO macros which can be used in sysinfo
driver and passed to smbios structure.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/sysinfo.h |  9 +++++++++
 lib/smbios.c      | 34 ++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/sysinfo.h b/include/sysinfo.h
index 524c7d6b223f..8a77ef448565 100644
--- a/include/sysinfo.h
+++ b/include/sysinfo.h
@@ -43,8 +43,17 @@ enum sysinfo_id {
 	SYSINFO_ID_NONE,
 
 	/* For SMBIOS tables */
+	SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
+	SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
 	SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
+	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
+	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
+	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
+	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
 	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
+	SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
+	SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
 
 	/* For show_board_info() */
 	SYSINFO_ID_BOARD_MODEL,
diff --git a/lib/smbios.c b/lib/smbios.c
index 3c1b3cf47e72..cd4a4aef6309 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -383,8 +383,12 @@ static int smbios_write_type1(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type1));
 	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
-	t->product_name = smbios_add_prop(ctx, "product", NULL);
+	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
+					     SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
+					     NULL);
+	t->product_name = smbios_add_prop_si(ctx, "product",
+					     SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
+					     NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
 					NULL);
@@ -392,11 +396,15 @@ static int smbios_write_type1(ulong *current, int handle,
 		t->serial_number = smbios_add_prop(ctx, NULL, serial_str);
 		strncpy((char *)t->uuid, serial_str, sizeof(t->uuid));
 	} else {
-		t->serial_number = smbios_add_prop(ctx, "serial", NULL);
+		t->serial_number = smbios_add_prop_si(ctx, "serial",
+						      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
+						      NULL);
 	}
 	t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
-	t->sku_number = smbios_add_prop(ctx, "sku", NULL);
-	t->family = smbios_add_prop(ctx, "family", NULL);
+	t->sku_number = smbios_add_prop_si(ctx, "sku",
+					   SYSINFO_ID_SMBIOS_SYSTEM_SKU, NULL);
+	t->family = smbios_add_prop_si(ctx, "family",
+				       SYSINFO_ID_SMBIOS_SYSTEM_FAMILY, NULL);
 
 	len = t->length + smbios_string_table_len(ctx);
 	*current += len;
@@ -415,12 +423,22 @@ static int smbios_write_type2(ulong *current, int handle,
 	memset(t, 0, sizeof(struct smbios_type2));
 	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
 	smbios_set_eos(ctx, t->eos);
-	t->manufacturer = smbios_add_prop(ctx, "manufacturer", NULL);
-	t->product_name = smbios_add_prop(ctx, "product", NULL);
+	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
+					     SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
+					     NULL);
+	t->product_name = smbios_add_prop_si(ctx, "product",
+					     SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
+					     NULL);
 	t->version = smbios_add_prop_si(ctx, "version",
 					SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
 					NULL);
-	t->asset_tag_number = smbios_add_prop(ctx, "asset-tag", NULL);
+
+	t->serial_number = smbios_add_prop_si(ctx, "serial",
+					      SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
+					      NULL);
+	t->asset_tag_number = smbios_add_prop_si(ctx, "asset-tag",
+						 SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
+						 NULL);
 	t->feature_flags = SMBIOS_BOARD_FEATURE_HOSTING;
 	t->board_type = SMBIOS_BOARD_MOTHERBOARD;
 	t->chassis_handle = handle + 1;
-- 
2.44.0

