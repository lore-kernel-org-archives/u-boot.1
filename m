Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE18EE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68EE88ED8;
	Thu, 12 Sep 2024 09:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A2C0CGrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499D288EFE; Thu, 12 Sep 2024 09:56:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BC888D70
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFtO5goAUN7V8rjC1FSZpKvmghZGVeNumOJVvbVcntqrB6FJaUOeqYEV2O16NM9Tcuf0ziKf3SgokseforpIsY/dwKERRdA09WWvxFYzqgrLwlltKk/2lTI+tFcN+qY8C8MvwjSTpRTRZWz4HNFns39K4YcmT2uQ1BIu/Jwz2jGYCYgWd0XNgBxgfsKh79ClukLkMdSnFwpqdi9/tHG3609OnxpgsmGfS0gcVAVD5cXf7P/zXNb2TeveynCl2Rfc7MvXCqPvUG5v2YPPSi+/XnjMXo02awohZY+AV12JW/Zp0gYlby6xvJX6H1jM79cfQQdpCGMqays5CeXoRnJFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CPBpGFfKVwNT7IN8nOlsH1BPcHXRDEnJP/X20TR/Uc=;
 b=b2Al1VLEn2EVcamIyVG7ADlpVSvBKSxSboZi2JvWddiCLX7SeaRLA3tzM+sIegtDN2nTPVmH5pPE09Sm5GMM4r0MH5SO9+2F6jRqgskOUshubYCStdlrkwuKvcQvVhPvHnaYBG4gSeVXiqWrDM/IxOxCZGmwn2pMxPqT7X3kDcmKCATKmnIOkGL9y043XLPrkrO9wSOhWcD3enkIcWUJbIGmZ2H/0fL3zeutYYnPGX4Ut2S81TpS6d9T4hm0JihRTFS5l3Dqoygl6unczDQXZ+n123KjGW2ZEAtHZNrOEXTmFFhN+o0xoHMMxJjLSlrIKiUGKGHr798h5okPDy7iZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CPBpGFfKVwNT7IN8nOlsH1BPcHXRDEnJP/X20TR/Uc=;
 b=A2C0CGrYNYaJqnYOliaQe/3GK9/W4LhV36LzS/i5LcTD/bwXzl2cjJGKnpO4KaKStV8SGTgqVp+veO5l4+9+03MUgWyy2pHFLjC7oPAaYSMItW1nxOzM5hPJoXD0boTSmwQD1FVqB6G/MmGugaLv1XtN0FqGzSz8wfr7tYrBI2Y=
Received: from DS7PR03CA0111.namprd03.prod.outlook.com (2603:10b6:5:3b7::26)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 07:56:35 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3f) by DS7PR03CA0111.outlook.office365.com
 (2603:10b6:5:3b7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 07:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 07:56:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 02:56:33 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix status property for m-a2197 boards
Date: Thu, 12 Sep 2024 09:56:24 +0200
Message-ID: <b5361e26f8bc529b897678d82d948373fa933e3f.1726127782.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7Ct9KTnMLpZfVmWw9ljhm9VYDrcwGjxKXekBsYLnqgo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRH89ZsyLVKfKl4KWb7k112yQcEHrQn3VBg2eC7yEym+
 2LfD7X6jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARywcM89P+uNa+3LeTgzk5
 IO/yZPVPoY8DLjHMTwjrWzbh9qF60ynfP8p/MjNvPLrvLQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 49745172-650c-4ae6-9d51-08dcd3006c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Gj6WjC+PNpXyjGvK3c9e4iHZYe5guEPwpHeTw5K+iAkv5YJAJRxD/58VWpU?=
 =?us-ascii?Q?1oYImUtEilPlaGotHJLvftXyclafEN4oKrUmvZTvSBMDeEYAmpBJ17VuhdP2?=
 =?us-ascii?Q?JJOBwoIaP8Z/jBwuJLu/EJgkbGb1x5UD2uk+xHlv8hX2fZoCu2NtHgBMJWIV?=
 =?us-ascii?Q?wyocm1uFC4TJaSZz9iICxvXQCI3GWQ3LEs5OQxnwuij+8PsMR7HrK5MwrSLg?=
 =?us-ascii?Q?7lOABBGIV1PrHESpbc4Bg0KrtT5KUrj1tJhZNyBZdzEHMgEFZcgbzpIITz31?=
 =?us-ascii?Q?BgXlYxfA7CW+su0Ofd/b1xRV6PKhnI3SZN+GK+NcE6f+Pr50oGUbeqbaQDuX?=
 =?us-ascii?Q?uHpn5cxo9BkNSh/617fXjajV8nr1K0lgt+dNq76tnR+6nuRoaUmnpKA0Sv9+?=
 =?us-ascii?Q?HM7NooOHigXojgEu7vKPjLCvSqs9pAiJaqNHJ5XbQTorqSAsrShrHf5ttkiZ?=
 =?us-ascii?Q?LUzdmmmF7gNOYTERlmVNOA6N9Q3+PTDeJPYm5eJOZHoqXUsPRq23hrglpwVH?=
 =?us-ascii?Q?xGJ5wmmcYvwWtGtbM0iMflcpZxaQG+sn0FzBeShk1qe7BTLSyd3sP8vnySjS?=
 =?us-ascii?Q?5zu1FoPKesGhVq3rFXGUlHByD4p2m+dEAj4arOQuAu2qCcn8R2nD9QE2SBJI?=
 =?us-ascii?Q?QTM389m6OUO5XA/VWjKfy7IJwEAs4RGxKnRfD3SHWFe6QbMUQIGaHlqocdU9?=
 =?us-ascii?Q?0bQgdk/jY7Ffab2kZmTir37VGl291gygEN//afX15Hkgkf+1usi38F1o15+R?=
 =?us-ascii?Q?oC0jCevoLxeGLQ1SRzWlcviDeklQnEAczX6wAuVoKT4oAUPBgMi9LWPbs9kz?=
 =?us-ascii?Q?gtFOlNMs5xesAYRyfDNx6nIyR7K95a7uuQQGxlG8ttu6WgrU7Zgs21H1PMB2?=
 =?us-ascii?Q?/p742zvw0o9n6v5IkB7Sl4OvKV2BQHh6NLCp1/xE/QlnwlOc8vhvE8338dT/?=
 =?us-ascii?Q?Ecpm2KJQP+/wfRmmWRrjurl6JwodOMP1yTYZUp75HRQ6d6A0VqurQPnYTG0N?=
 =?us-ascii?Q?fyVphFkLUA13vYH2ZaV9o1J09p+TAS++b4eW/WvEON697Va4hO7nLuF3QX7s?=
 =?us-ascii?Q?zR1NNBMc3tU3GQ7tjsJdLDzXplP+cLSwa0JKqQ3BioverJd9FBC+dyZCT+FG?=
 =?us-ascii?Q?Sr1oU/2m05/Ss8kIZNgPCkzgnVj/tvhx0rVQln+iRAZq4oqHJyfT+ADEiw/L?=
 =?us-ascii?Q?NRIMq1n0AF9aVVYQOi9g7Cvy7k/oS4r1cfaWYvgKUX6r0KTkVAMc9rHs5y3O?=
 =?us-ascii?Q?+aQwyf4N5sxSIyBWIwyuOdGZOhXqdyCHJNqVfgzEcAcUWRnddC51wqRbE2jH?=
 =?us-ascii?Q?4K+gaohAYTzUfC3EMZcTj3TfNnwc2hwJZgQxreJKEN5/X6Oyp8Aq81aSm7z6?=
 =?us-ascii?Q?Stp5s+0RYfj9eDPnBayNG0okqQfUFLvGGOl7+QDb0byNirpuD+lg2RXzMNpK?=
 =?us-ascii?Q?WqRsR1xFpNjgsKBEkjU9tevQ/4sthtfr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 07:56:35.1439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49745172-650c-4ae6-9d51-08dcd3006c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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

Status property should be missing or okay or disabled but not just disable.
dt-validate is reporting it too.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
 arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
index 83b8a98d80ca..38be5a0f96f1 100644
--- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
@@ -101,7 +101,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
index dd37b726d3dc..3c04da1c5fbe 100644
--- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
@@ -97,7 +97,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
index 811cebafe9e6..7439a2f872e5 100644
--- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
+++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
@@ -97,7 +97,7 @@
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
-	status = "disable";
+	status = "disabled";
 	no-1-8-v;
 	disable-wp;
 	xlnx,mio-bank = <1>;
-- 
2.43.0

