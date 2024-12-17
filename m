Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42613E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25648802C2;
	Tue, 17 Dec 2024 22:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="gUIwEJuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7142F801FB; Tue, 17 Dec 2024 22:36:20 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6DA801FB
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3no/IEishBfNERrL07/8EM2ZFDIFOekzm0mqyxklHnlZTCoXSNxFSSaOBWiTL/rwDZbbkkwJRF/xLTiSMsGWGInTGggJh1L1Hp8WJcznE75lZctt1miymYC7iPJjW8ExWdT2TYMPlVPqR4oPqTsa0PRgfFA0uuKfuqk9KqGgUifF/InWF8+rq2MV3qmTMQzXA3A5bPp4HKOGO4kDHikBsTuUylJZTxLkE+97Ta8K8MlbvEHp70P1755bdE2DVhU3nuooAkzEn2lv7pDhnf7u+Ic1KHS46zxPzPerYPHh50fo7fai2hz1qnBqGZbGOK300JVemets0fOTCJoRrA/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlJVD81iE9ErJjpAK7mSmQwYvRvkmIHwCR47cKHZZWs=;
 b=IraBl06SvGeJPjYcJFTC7IG3vWNCFCJpyrrXxoeot7Z9cJwVM8P/fmC7+Y3HzBaUXNPYeMsQfuA2P+z/cuDDIqbb1a82YT8EFTDzH4Ai4YgXig9s1mme3lStihK2ooaHPCQ11z/hjNQg5rQU2yH5RvaC7/iBFbCnIAw1rj5Mt03m4uqbrYNyIphRoO/UbJFaQRaegOOUDjw09xa9K+uyolnqSgCToAIOgeSDxoCKATET5jgvssLvghiLIKcRCp5xtalO7Kf6zubtQNJFbsrtQBjbjNYiSUvbBbop+2CVaYMcC45jUQ/vsYAAVEkSI1moG4UuihC8QGyptxRWVhn7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlJVD81iE9ErJjpAK7mSmQwYvRvkmIHwCR47cKHZZWs=;
 b=gUIwEJuyhAGY19s30z/aV8EayIu3RAUOAl9cVsceHD4fnMcU5mnmaRZkj1Dx/yaNTbvEm1QwnICljMkiCLa3zNQCMmXjOjU7Lj6jgRu/6gUpprftDstRie9U91lQsdOUz/Oz749JDCsw0piaU1yKVYsw6ETm57YZmT8tWSdNmZ4V0sMjpaalMvh6We/CRDhFfNQlE6rAK/NQ7D/29c+m/qOvvSv4Ww9JZYv2gqvRRc06a0HIzo69aRou86qrNfHm0swFV5Kxcs4HjTkHd47k8b7N4kdxkp33GIkwfoJOuBe1Te1FtvwbFciLS1FsfNMptq/gkgwxaYCcbf7Fe2JVqw==
Received: from GV0P278CA0037.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::6) by
 PR1P264MB2223.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 21:36:16 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:29:cafe::81) by GV0P278CA0037.outlook.office365.com
 (2603:10a6:710:29::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id E33401FFA8;
 Tue, 17 Dec 2024 22:36:15 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 0/9] add the support of sha256_hmac and sha256_hkdf
Date: Tue, 17 Dec 2024 22:36:04 +0100
Message-Id: <20241217213613.286813-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PR1P264MB2223:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe8856d7-2e01-41db-5bf6-08dd1ee2d630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DYidHlmJ7ZafJJCjSxpJd+GeexGZxDiRAyxruAAND9NN8ofbxH6OBVgp2ep0?=
 =?us-ascii?Q?Xh8aZFubKR4KXVKUHe1jD2kd3GrU2G6t0fBaNbQoZGMa5blNwtlZ4eYKMBim?=
 =?us-ascii?Q?4zEOXE4gUD2CF5yOrxyguuq+QA5H3UqM283uQMrQmavtv3CGTguVqGBXmP0W?=
 =?us-ascii?Q?i1AaPDMvDVLzgz7C0Pr2qH0MqoLIMDYvqhujlhbI7+9JWGlIgPoFg6OsNVp9?=
 =?us-ascii?Q?dqlRzjgeV4Xj3n1JPbDudbYuwTisQ5zKBVfe1+ohugzQl/ESh5ZUANR7lI47?=
 =?us-ascii?Q?TjGooRYCDWbihQ6IifRgIapL3pwB1Ay5MRXRa/X94rM5kiMA3eSFr1dBYxrV?=
 =?us-ascii?Q?DHUihbGlWp4JaaRWk+2bmRIJEaYEGvCMeioIruFen5/DAX53XGvDuRjrbCEH?=
 =?us-ascii?Q?I0Fvd+2w3/Zz626acMaPxcs7SZscihbDVGNujdm6FrBS+oR3AyfwJh411Ojd?=
 =?us-ascii?Q?5oQ6mc2wj0x/mgKTqkIo83xd71WmFKmkc7hTdhb/IjVxmv3CBEf0+ltS1Sbp?=
 =?us-ascii?Q?6GdkOdFJBvWjgIJ7bghwbq784ySUF+Twu1zd7/dVYWzEqZqtB4wwqxI8+Ne7?=
 =?us-ascii?Q?Rlc7UVurd23zIFc1dsJapZZ/JxoihCMSAYJ3Epsr4aJL/DnvgttaV2jx/Iqz?=
 =?us-ascii?Q?spuQFipCTBifN8ByVReHEcc8ZM+OM8Q84zs3f++sQVT3vXcsndtBcKKoqO3v?=
 =?us-ascii?Q?YeXrgkGjDJ35mru0aEwW49pnsBr6YX8yzURCWSobxTtMIKWipcDoKcQyxOmM?=
 =?us-ascii?Q?iOCnBzwMrdB6RO1zhQUHJtPevT4hJ/zGdrkII9JO/sZQk7XxOj6iMeXLJee8?=
 =?us-ascii?Q?ueQbXbk9woWNfRjZGHm4k8ytUKIRK+SG0EOAPWMXnNG0ERcEeJGj/xuvWTPu?=
 =?us-ascii?Q?x58UZtMWw+WlK6dFHXYREO7ixe6B1SXafP9Uj7tUWpyPGxcWkxfpRRxFk0bP?=
 =?us-ascii?Q?Czquvq80iXoV2LsSIPUdbQHyhCo2cnw6gPLTgFhhNDWIZCbiSynUDSfiMrBM?=
 =?us-ascii?Q?O3MCZAEhCQUyCPJzX/KKDAwjjswLvs9fafdMdxH8vU28Uw0NwICOegxfyi+0?=
 =?us-ascii?Q?S/N2IvQzf5yz2ME4VXxJEBgLJDpZLKMhoIL+BEsP4BcY7GyAe9J+OizOheIv?=
 =?us-ascii?Q?lU0fMNyQHw+EBO8bfqyvuyHgl7LGWZy5gJx2Q8Ivks0zivvQuvuM/Ncxh2IX?=
 =?us-ascii?Q?0XArIcr5IGRyuAJ8Qa2GOMAaNR5PuC/dtYYctkOla34VRS7uTHR1PSwwC7O2?=
 =?us-ascii?Q?R82KZJKu+8Dxoi1cbO07TTOM1Y0+LV5aBRjDpYVAf0w+tfnExki4prVtsA0c?=
 =?us-ascii?Q?7Or2GOxLC6M1tdm7l79XtGQlbS4D/sEwRaWHQfbJXH8tJR5mW9qbRuInsDFB?=
 =?us-ascii?Q?yMc+g/PXEQv6r6TCY7oY8wD0vMOJFwnOCat1OENavjSZapMatYUehDqhBCSp?=
 =?us-ascii?Q?ZpP7jxYJ4J9QB6wwumtkc4Dtjd75ZhDFktznXETu203cIDXx7gpYJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.0945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8856d7-2e01-41db-5bf6-08dd1ee2d630
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2223
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

