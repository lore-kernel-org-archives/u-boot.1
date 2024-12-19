Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1F7E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240BC8022B;
	Thu, 19 Dec 2024 14:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hGU91f/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11CD8036B; Thu, 19 Dec 2024 14:06:03 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF1F080316
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA2ADoE1JAjnbvKv4tBxcxGHb5lSsv/tHU0rtyFhzLjmyFNBIMYllQHTGRaNypGdVgyZ5jwxP+AHZK3Lnxa+E0KUS8xBeBaQ6B+NdWgQg64HV3/7cEymW1ClCAT32ftuokCLP9BUIqTGLCaJViUt0n7pMYMETX6s2mRESbse2ROLLHMRoL617xzREYTpUh4cWJSb4bgCL9ZbZz+XkRGHKDs+t2aaX36AXArEdHUQge3borQAxjuDJmqJ1qIMqQJ5WSF3FmeHFVDkkySoxSsHyRvuCFsCj2xUk80gk7HwcNcy/S/S/rt5dziz+7UNldT83pNWDN+fAijhMzXE/L+a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk6LUbPJehauhu3VFe9690ueI25+F6SVYrEGZURmzfE=;
 b=o5QJ9Xp4CkeIb9fKy+6T+35lE2VMGNslffmrCYIbGDvIFC1NeCfTc6rrv7GtHuAPRdTECJeNdJDgdxIwCOd7vHCehkyF4o7GWHFpmVSRN79vXpCR3H9hYo9hKZl9HOMEDn73kG7rJV4D/YMYVrwwTmSCjuq7YjgOc1toUa9Lxq2QvHckod5qhfjw/rQjcCdYuwrpaWyFWh1ZbA8GZuBUIBdUs3CbNXkjEPjTI+x80lDkWS2NvCZ7pH3INttIkr6WjbAlO8z7sBIHbl1HUS+45xv1dzlQHnEx6K8+BeFgur7NsY+UL4FLoG5zA2D1RKliihCUA5VaTH23aeNVLYsn3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk6LUbPJehauhu3VFe9690ueI25+F6SVYrEGZURmzfE=;
 b=hGU91f/z6RLCxprUDSQYHzk4PS6UiVqUIwDfZQCwx8maUfUjpnJlHF8668bVp54RkD6nwijLoXC3gpN1Ju+iEh5CpjtaH1k9OLWmC6aZgaKnpL271q5jjpc9hvVrXRKHC2yURd1d3iTP7Va7tXrgg127Uw6Lh1wJ4n8weQ/bekiCHfVBhuZ82aU5y8+uhaRuDLHai8bxKtq2S7pFHA7Brq+2SkCZI2VlyrSTzLJpzisyuAnvKgFUzrpOuWpkI0tjZhhYTdGt5hlLqAQqYiXMJvtPpjI7lfQEnRXE1nMypRXua1C58rJkCfEbPVQo1iQ861TgNaP+Py8wGf0esfWTXw==
Received: from MR2P264CA0040.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::28) by
 PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.15; Thu, 19 Dec 2024 13:05:56 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:0:cafe::b) by MR2P264CA0040.outlook.office365.com
 (2603:10a6:500::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 13:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:56 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3F5B31FF7B;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 0/9] add the support of sha256_hmac and sha256_hkdf
Date: Thu, 19 Dec 2024 14:05:45 +0100
Message-Id: <20241219130554.49825-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PAZP264MB2990:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56ead86e-460c-4800-5795-08dd202de050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rj/6zkJ46pHq+6xbvdcS4k6iDtiuWsvEr9Cj/8un3n64MH8L2nlGg1LzsB0r?=
 =?us-ascii?Q?PCTLqc/CGoxNOLhAetxCLlP1TjyMrgMeVr40oKdqExwOyQDjMBFYks7EFbXo?=
 =?us-ascii?Q?X5lgMlAJyfSCvTcyyiVEi+eJ3KKIB+QHyKqXKvbtc05mHsIVa8cY4/3PuzlX?=
 =?us-ascii?Q?4zXzeawQ81bI+Uh/4dYuJiqbFGnfyZd6co4cm8XYPtqYh2SgiCLFGBzvMSeg?=
 =?us-ascii?Q?1o3MN6s2JDd32AY4FYvE9ghpxUjd0LokGZdKUlLuD75j3wSUKpSby6k1r5R6?=
 =?us-ascii?Q?9WHkVrHobfoboOvIfUzmk/3JL5IhcCT4sCLQJs6KjzgYqn/re+HZKGUd3TCN?=
 =?us-ascii?Q?9pyvOEi19qjgZ5+4gge100dCCOtJSZ1l1PYQw/yAxn3KRDhk16yGxze1LNt2?=
 =?us-ascii?Q?/IbrpDd3tLv9Li7+gZZ6TW//FtUPRCQyfeo/OxwEZRtzX7MJ7/ad1AaGOgHM?=
 =?us-ascii?Q?oTQW+7fNlzWBPIQynyTJ9b8tH99irVAhCPizVyOhopgBSUMxe6FR8iUyL+sF?=
 =?us-ascii?Q?ltvnwd3SxApxQb4Y79aO6UPlgDZhUd/a0Q6t/0fa+1zhJIUB0VCpZuOz8Qry?=
 =?us-ascii?Q?Kqp2aFJ9BmptLoTAsWwqrXfiYhimt0gaOor/CehBaku8udyfUKOSFlQbPkUo?=
 =?us-ascii?Q?s5koG6oJneqguwlbxBP8PB3lv+TPYkbteK6vdGZS53yaIhRHSNd6q5AEGlyQ?=
 =?us-ascii?Q?k+mAyQiKiLoT59Hq19g8qDQm7+aJUjIpW5WgmNWXzKboDCtmQcN6IVMkqej8?=
 =?us-ascii?Q?MRR9C6sszoKa12kPyHx7WquCPh8ZJPBlNvSRm9jnXg9VzYjy08T40gugZIn6?=
 =?us-ascii?Q?xTxLeVybWRSnfVjJlS2PmUyuL2AvBRkqtj9Vm1KEM5uKWVgDA8IjAHLFDIfQ?=
 =?us-ascii?Q?AfE7ppd6zd7RT6exvuYG+ON4hUkd+Wm25U67G3c+aObhXNW0aQsDzM+S/Lnf?=
 =?us-ascii?Q?emxZnradzEku9LdXYffLJUGROGXQCOMB58Kz3sohon3B3BJP+ewaTBcTiWbP?=
 =?us-ascii?Q?JJXvgxkgXoAcIX++Ops42igS7BP+0QVJp80MmFx1PbyJFDP0Botl9HYC2rEG?=
 =?us-ascii?Q?Spjc9LksZmy0f3U6wAhfCxFA8Uov29nBB8Sm+TEwUfF9xZe5IPCK5t57e9Xy?=
 =?us-ascii?Q?50Z9077rOCLtVOrRodu8aiioKrsSVRuXC1PtZARDmCGFWuJIZBnOxnU/ayqj?=
 =?us-ascii?Q?KyoWX78Mypt6EvRneE+A00mcLke5baM93jsdpqYVa+ACiP5NdDIepBVKy7E0?=
 =?us-ascii?Q?D3QtpOMAMsfHR5fospttAYbY3BmoyGTZopnU16PZfIQw3Kc+Sy6GI9kwEFEA?=
 =?us-ascii?Q?SOhC43mcmHD2gPo8z+UGyxwAEfqZqf7ognxog59b4JyInD7BSJwO3ExQKwoJ?=
 =?us-ascii?Q?Jw5Tqx6DTJ2u3mcrshRUwJD4+xyDdz3IX2G4uEUkcmH3om+djqJFD5lbDirW?=
 =?us-ascii?Q?fLU51ekMFrfYRDE/EFGzIpLko99R3qm5aqzEjlCQu02FoOMtlmkqIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:56.4676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ead86e-460c-4800-5795-08dd202de050
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2990
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

This serie adds the support of sha256_hmac and sha256_hkdf.
A first version was sent several months ago just before the 
integration of mbedtls. This new version is based on mbedtls.

The first patch of this serie add the support of hkdf
using mbedtls.

v7:
- add missing reviewed-by

v6:
- use const for test
- set buffer to 0 before using to to compute hmac

v5:
- use mbedtls to compute hmac
- add tests for hkdf
- enabled mbedtls in sandbox_defconfig
- some cleanup

v4:
- fix computation of the hmac
- add more test for hmac
- move sha256 common functions to sha256_common.c
- some cleanup

v3:
- also define sha256_hmac for legacy sha256
- add some #if to define function only when needed

Philippe Reynes (9):
  tools: kwbimage.h: use linux/compiler_attributes.h
  tools: renesas_spkgimage.h: use linux/compiler_attributes.h
  mbedtls: enable support of hkdf
  lib: sha256: move common function to sha256_common.c
  lib: sha256: add feature sha256_hmac
  test: lib: add test for sha256_hmac
  lib: mbedtls: sha256: add support of key derivation
  test: lib: add test for key derivation
  configs: sandbox: enable mbedtls

 configs/sandbox_defconfig        |   2 +
 include/u-boot/sha256.h          |  24 +++
 lib/Makefile                     |   1 +
 lib/mbedtls/Kconfig              |  14 ++
 lib/mbedtls/Makefile             |   2 +
 lib/mbedtls/mbedtls_def_config.h |   4 +
 lib/mbedtls/sha256.c             |  59 ++++---
 lib/sha256.c                     |  67 ++++---
 lib/sha256_common.c              |  50 ++++++
 test/lib/Makefile                |   2 +
 test/lib/test_sha256_hkdf.c      | 198 +++++++++++++++++++++
 test/lib/test_sha256_hmac.c      | 294 +++++++++++++++++++++++++++++++
 tools/Makefile                   |   1 +
 tools/kwbimage.h                 |   6 +-
 tools/renesas_spkgimage.h        |   6 +-
 15 files changed, 670 insertions(+), 60 deletions(-)
 create mode 100644 lib/sha256_common.c
 create mode 100644 test/lib/test_sha256_hkdf.c
 create mode 100644 test/lib/test_sha256_hmac.c

-- 
2.25.1

