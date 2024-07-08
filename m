Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC388C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 15:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3244B887C3;
	Mon,  8 Jul 2024 17:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+D6O/cN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC8F8879C; Mon,  8 Jul 2024 17:39:56 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B286E8879C
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLcFAeBv+pd9fy4mcGf8fwJSx6NjD5kj33sY9s87iXqUWbWATtw6VEh5kERgAwFzeOQCqXjWEKUfPoXl+lFG4kqdnqrCLo4/zQvh2ijri5O4fHMxYx4MvJRQ9Co5gc1AoeO5A+mQyKOemOwOQDdsoCwkB8jeEX5TzpAr7+dpXOjjw+dc/SUA/607XW/VUS3wT/SfikhZdQ1mOLXMA1ddVWtaQnWJ7eyXI1NlKCo/5b+Rbwzjcpvp9Oah+6/D3fdekpxIhgV1naIJk4/NuW84d8xb96+Cbt4J9g9Ht47mcGVI12n28yfIxlzGUFMbxgBF+fx/6SXGuuLFU8dOOZrOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLtzhsH9LCzOTQvYZp3NlYJO6q2cSBq7N5P8udbWhJw=;
 b=U0MRYqmtirmoin5eE+LYXiLF12AlKYwEeoNv4Ao7LW66iI0dmhmUoIHCVCskWd7HgZYB2N53qXtioCiSL8BhHTig7Yu3WEcWfIeXMs2RebvxtrkUqyYbxHOBeXvrfEm9H2WIX8d48al2nac+5Flh6sGlsTLcnyfSwZ2E3eHsmfyNTEWDgAFxj/z7chWMpUm/UBqWE98VDdQTfV9YZnMXOh13GBW+RIAHhCS8szmNzTuoMlqScaUOzGJ36zK3KAe/6Py2+BAv3FwnxjqWA1PWz9IRG+K/AREZJ4udM6iONo+/9HmD4Q/oGectQHjBKblmB7N4xgb4EKnjx+oaDQNQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLtzhsH9LCzOTQvYZp3NlYJO6q2cSBq7N5P8udbWhJw=;
 b=k+D6O/cNzOrkMx0C1lBm1xQuAzAp0f0NXIVf8+qIlFunALfLPD6OgGxjpJoNCOOaSWazyJQ7yoaJPKFiHSAZ2c+6deonEmaEPuWU5ntoVkDWUW4QeOaasepZgMGmbBgdQgJAZ9ma9l0G3z6ayYrup+FpdPls4ncWsWgqOawutdw=
Received: from DM6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:5:80::33) by
 SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 15:39:49 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:80:cafe::d8) by DM6PR08CA0020.outlook.office365.com
 (2603:10b6:5:80::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 15:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 15:39:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 10:39:47 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 8 Jul 2024 10:39:47 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v3 2/2] doc: add missing table of content links
Date: Mon, 8 Jul 2024 09:39:41 -0600
Message-ID: <20240708153941.1045588-3-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708153941.1045588-1-sam.povilus@amd.com>
References: <20240708153941.1045588-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: f87dfa17-72a3-41ed-761c-08dc9f643379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrQ4UnViZkEEXaYFnK7r/q89klO+uksgH5c4cuULIrU8/iiextPtX9qziqeg?=
 =?us-ascii?Q?y2TBr0ABx6dDrWiNJnTWia5hftr0KKrJ951xxQJl1XcNWoJnPwhfNX4nZxII?=
 =?us-ascii?Q?wgtFu+QaKsnraGru4ksfzM7Ja/zUDAitfWOYToRRHgXPecq4sqdHjC7TNRhL?=
 =?us-ascii?Q?PAsyrPpZx5vR+vEsCmeGiHMo5e9xxp/rZTYWdPAYcmX1h8OdbXwAMPJUl3PJ?=
 =?us-ascii?Q?dnDZCfGFTT+49Ix08QpBIsiDm6k9m5DettgkIVVJnLFOOGoz+pVXN5ekKfUE?=
 =?us-ascii?Q?/2UpCH5alhGja0rJVfBdACj7d2LrCsWUAM41DsepNhiwnAQhNLDWRhVvta2V?=
 =?us-ascii?Q?P+3mIsrCEwQl2lpwWDVgjhxxAAuAnbjzQFHeUpD6BMEQ7kOS/acSmkEikJMj?=
 =?us-ascii?Q?t1MBA6j0Qz20j2y7afr7BySlXB7qDNzqv2IAl3VWf2OENzOj2LoII1s68QFM?=
 =?us-ascii?Q?dqH8/qw/BStYcRyADO4dNhX+X253/Q8NWyA+avfJQOA56dDG/tHV5pfkUlBd?=
 =?us-ascii?Q?FLZotIWZmS7K7YJSqeY23akMtiepdkufD/EOxiACgfzPvU2tT+T8WyV/QMDc?=
 =?us-ascii?Q?E2sqy6WQlNWdT+A//6d174R7dsqMd8S/JKra6N9vYn41GGzPXYfzj6BCJ3Er?=
 =?us-ascii?Q?3UVUanz7bD/PbdYYVst6eTfd7vNfSVcu2no/o1agtWUUSkmkcpVQa0Wi8HKy?=
 =?us-ascii?Q?fhh9vpVCmEvlv75aqUygN4KvvbZpzcG9lEu49/U9ifSiGIZGFXoGjdoZR+gS?=
 =?us-ascii?Q?gdBIaOnzn96eDM1IptisLg7QgC5Wqsf1OqLLKTxt+j6Xbm4ApjD9Pg76Yp/7?=
 =?us-ascii?Q?d5MaYUmtw7CQxTP2xnh9hhl6cHDn6lsPADZCUoyMx0YCLKQGTyL464P9hPzO?=
 =?us-ascii?Q?NYbROYbAq+0ZR54L6mUpr593iWtLGdtjlvY/yuI/79UAqBNJl9pw25zwKTim?=
 =?us-ascii?Q?AlVokIYM2pxa5HDhei/d/ItflJYVvwEslkK9rtGepOnyYMemY4boo66VwV/o?=
 =?us-ascii?Q?MR3/kI3GL2m0/WlTShbdiZrUN0/K1G7C+xttezSw9wFy1WJD2SWP2SSKTq/z?=
 =?us-ascii?Q?bx17GS/2fECOZQ3hAHvlZeieSRNdUmfNtqQkmvrAc4Jv9VnCvpNTH72iQso/?=
 =?us-ascii?Q?/mncoNSS7bxVF5+XQtCC2ZbbUv8noTa7MBV3OifnC/pVk1vbz2jc+viSK9oF?=
 =?us-ascii?Q?/56NVZsBOJpg7OUZOuNJWFptobNIr76Y2GiAXbnsZwJhVwWXfh0k0sg3zkFx?=
 =?us-ascii?Q?drcejWm2o+EI+6BxNjFhxvvAb5+5opBHMFM/YFVClGITwwUZMK3Wl5AXpbYj?=
 =?us-ascii?Q?mIM5NtH18qOv0dwEFjOSM3O/sk4D2qoz2V5xtr28cFdaLOrCFcCpdSTFuXSc?=
 =?us-ascii?Q?xIQe2xUbt/ivdCyRs/8WncyZx2IPe0/GFbjFqHloTW2kVjOkqcCN1ilQ7VwR?=
 =?us-ascii?Q?uzpZt7ADdCY4tltQzB9jkFLztG9ZxPiO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 15:39:48.6255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87dfa17-72a3-41ed-761c-08dc9f643379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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

add missing table of content links, make alphabetical 

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/index.rst | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index af2e481212..ed28dc89ae 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -10,9 +10,24 @@ images that it it reads and boots. Documentation about FIT is available in
 .. toctree::
     :maxdepth: 1
 
+    beaglebone_vboot
     howto
-    x86-fit-boot
+    kernel_fdt
+    kernel_fdts_compressed
+    kernel
+    multi
+    multi_spl
+    multi-with-fpga
+    multi-with-loadables
+    overlay-fdt-boot
+    sec_firmware_ppa
     signature
+    sign-configs
+    sign-images
+    source_file_format
+    uefi
+    update3
+    update_uboot
     verified-boot
-    beaglebone_vboot
-    overlay-fdt-boot
+    x86-fit-boot
+
-- 
2.34.1

