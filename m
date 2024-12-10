Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F351E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 04:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEF8897A6;
	Tue, 10 Dec 2024 05:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o49pJ+B5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82450897A7; Tue, 10 Dec 2024 05:28:31 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B7C896DC
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 05:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/z24EKZ801Oq3udWhN8BwhNnAYFa5R2kEKM68yNWLVcEnHaeajtJt6B+WvSROWBzAmME3QrMY/kFzZDAbmoApr3hodB2NrB9sB1DgbVnAent5o5+BK3UcwJNr5VkU3hDdIH54uVijpMt0vIZOYIQVxiGReo6KeTCfN7g1mIMHnWRuzb4ovBOv3jqFCzCFEGWQ0uKkR4wAO5fspl0VfSjmLFtCL15GSArEmtfIw3uaKT0KXl0xM5OEvbB53fhDJmpqZTMM9yBCe/Vq3EsJkIXTmmQ8w162NASpSMtq+vOgPqDsgtG21eaA2V6KIDO8TgHMg+n9WJ45xt3Bc5WUlN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB2sVXumplycsBOXSr8YSeMoUe25CpGoDZzmZhntjxA=;
 b=ICQMR/otLQM4+VB/jd2Fb60D21kuAp02PhY/1m/LkA3aJbuhXvDWqg1hvoB9OABF0cxkP5XtVTFBIoEKuRhihu+r4Kv+ftHtVP9JI1Devu0B/p1KLEjad+vh/Ffqo6u6X2uXKwhtqiHRg5EtmM74wm2g1gDtqO+U77L38q24vzacmzYU4PPKtp06EXCOnKWrDKV7txEra2aelbd9prOGtxlTJYXIGwxCWiev80TWKw5v4d8pPnG8jV655A82rTsAV1yp4Ok5Hk7Wt8iCCXB9CS4wnbyRrjtFQITMrs9tAlAETw1ZLqDjxPgKZrXZ9paFxyYZTk1fgxqmZMtjPAKpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB2sVXumplycsBOXSr8YSeMoUe25CpGoDZzmZhntjxA=;
 b=o49pJ+B5p7YlGoVGCqnJR0IDb2WjfzPi3cyy/6j1feGK+Wkto1JOYhmUUVGHeixarpO7c1+0yW0bIXHwDt/OSEk0BVpX1SLGU/St1kJznh2OJDR7Dzq9MgsBt2rrkEkenzHzn0MQdmHVXnWLQaRCzJHAummaImwmd1ahWj5eC2g=
Received: from PH3PEPF000040A9.namprd05.prod.outlook.com (2603:10b6:518:1::4b)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 04:28:22 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH3PEPF000040A9.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue,
 10 Dec 2024 04:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 04:28:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 22:28:13 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 9 Dec 2024 22:28:09 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>
CC: <j-humphreys@ti.com>, <michal.simek@amd.com>,
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <trini@konsulko.com>, <seanga2@gmail.com>, <caleb.connolly@linaro.org>,
 <sjg@chromium.org>, <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v3 0/2] Enable mt35xu512aba_fixups for all mt35xx flashes
Date: Tue, 10 Dec 2024 09:58:00 +0530
Message-ID: <20241210042802.632688-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: d80364ed-7b57-4c0c-ec0c-08dd18d3149d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TMXNeBCSJV4eYZxgZTPyv/pgiJzaF539x9vZext3RkI2pvtYCUToL3cbWEyc?=
 =?us-ascii?Q?C8BFPaNxbm1My54BMfMz8mygVIUvD3eldFxZ7zAlA1UsmOre7ypLIIKBWmHP?=
 =?us-ascii?Q?sDRxAWMyprk8DH9GqjSGoCMv6yh4bKWOBQT2YJGMnTC/GkTIYErH3J+GmbMm?=
 =?us-ascii?Q?3bKTAaNP5WYzyoFyLdM5trQRT7PB1+abyyv0xM58DVgZvXH4DulUnZLUmb++?=
 =?us-ascii?Q?0UiBGdGaDu/vLXOMy5fm4S1tvrBceMDbP7tS50rZFA2TW/xjD3GBaw3rHArM?=
 =?us-ascii?Q?P0hz7u2iOnp0iMvUI9/3yJtFT6UTrKjzLMeuOUiIok+CJKdl01ZP9z1dJlhf?=
 =?us-ascii?Q?feK+IoUo1SKkSHNQ5trXBaiiz8s3XzInYjHG8TFAiXf06djgNM8u/T+bZv+x?=
 =?us-ascii?Q?kNP6LFq2qZYtD0Oecwf0Achz464rW2+C1IhPKjjpuIkhXPShdBoVaBC8EnQI?=
 =?us-ascii?Q?f/3lJAtw4uecERBj8eGHl9EZALueljzk9rW6X+ZTgzDP9n/nIJiZgUFRe7X7?=
 =?us-ascii?Q?mnmLrfhBueekfbYh7K4G80VER7jbqd6xHc6mZisc+OhIlZnY215tVFJb60WI?=
 =?us-ascii?Q?fbcQwY3WjplDSsn7375utl+Odjz4zstU+DPIHbVmk9RnTj1elGPhBRYdbn69?=
 =?us-ascii?Q?b65KZUR3r4kJ1hsz6UIJ+9Rjw57qjQKkh+yUMMgnq2jDTjwuntFGsOF0s/EI?=
 =?us-ascii?Q?gVMFVNE3CsWvTALxb7DLSRMxCQ4SnwSrEk6sz4blmNvM3/2gLxuco+VrjV+4?=
 =?us-ascii?Q?hyckWEB0U+Dis98vDhNJOQKDQdw/EG6QH9HVJaX4Z+l4RvBs5U6JzdDrQ0Km?=
 =?us-ascii?Q?cpD6CFxFqzf3FWNSRlQpUKo15ZQEkVl3sq3axxZpSj9XImro0ynyf78HJfSl?=
 =?us-ascii?Q?19Wx8w24Lfeyg6SGSdiRIM6+bAR/tniUQAPWx+ed1rnZZgOnhl09QCAqLKxx?=
 =?us-ascii?Q?nqtV3ke66pru+FBVrgOk+uzXCRVIodQji1j7qumfKvbwV2lTUj4eYoiSekpu?=
 =?us-ascii?Q?ZrJ+smHRRvEGw0u1ThkAa5pJkjokuU1iTeKBxiYVd/yOvjAHMAkVKV/nU0Cd?=
 =?us-ascii?Q?FP6ejuehmQOZtY/whLj0LWn93iscbc4dY0zLXb7lIh7a8dmaOYrXoZurKGzN?=
 =?us-ascii?Q?JvlRfxR8cngkQGr18YzB7p5IOnLw0bHNfmmOhi5vy+fAnUCA82xzVAOXosG3?=
 =?us-ascii?Q?x2VU3nwm1KVRaHKmUBb+yem/e6SiT1LOm+M2qesF9E8j2s9jOTgQDh7uSL5n?=
 =?us-ascii?Q?Hj6pvRbrHL+1TGMC++/8++t5YF5OyE4+4/SE+x4iOuFB02Z8ULEBncsAVzY5?=
 =?us-ascii?Q?E2/TQKV7EgjYjHHZYBeQAdANzD9e/uamLm6Umd/DN+GpPAFsVvwOn33XwAWd?=
 =?us-ascii?Q?zBtQIMgcJJ7J6candpSp772AGP9wr/cgPH7JXKuR0jYXs5J945nqlXzzV0we?=
 =?us-ascii?Q?c1pziGxGvE2903IKE05wDg6AByDEJwRW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 04:28:21.8600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80364ed-7b57-4c0c-ec0c-08dd18d3149d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
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

Add SPI_NOR_OCTAL_DTR_READ flags to micron flashes
mt35xu01g and mt35xu02g.

Changes in v3:
- Seperated into two patches, one for nor-ids
  and other for mt35 fixups.

Venkatesh Yadav Abbarapu (2):
  mtd: spi-nor-ids: Enable DTR for micron flashes
  mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx flashes

 drivers/mtd/spi/spi-nor-core.c | 6 +++++-
 drivers/mtd/spi/spi-nor-ids.c  | 6 ++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.34.1

