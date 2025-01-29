Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E787DC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7803B8091B;
	Wed, 29 Jan 2025 16:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yia7+0Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7875E80762; Wed, 29 Jan 2025 16:24:53 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AE7809D4
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUNoIslVGSfqK71hpbTOJVDBXbuWtkw0iD++Lxxy1dqJifrZxVr/IHOUCCW+ezxir5TE/B8jLlCc4Yhl65y2C++Iv1zkrqFA5tugq4wSdf5vvHS1H4RDaGlJxgp1Zo9yEL5XAOo+e0ratoa04STAYbNMIMc0H+wu1/TSHYdF+QzBjK7QA/t2yFWP+i7nm/WUSrOBpm/nEwsutsN2cYIdyeQ3gAKlMhg9jXWdDutSjhqENO9jTwgHQJtqWrTIZaxXyvqPrYiOKQk+AgpxAjlSVMRQS7dG5e6I2PuVo13o9WI1V4DetVZMWMZ0okVWbvI45goai/gRuopBL6RNSFlhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQSJ/tKrEkSt6A7itN/b8EEpVUZZqqF2F/auj6leJoA=;
 b=N19369tD9RAbn4zwd+dN4kw7eF/DlXQT85cS+UhPlpLmpqXg3Nq/OPCWkkbfN64f5OXA8c3rwGoZGNubmiAmpwGdDvZ0vxjmAVGWbQJfbS4sxWY/50eiPG1+DTxVO6zEFSxRUCc/o7qrAeI99ojfQEtoXIB7xUzmBbU4A7UOx6ssK7K27bSaLE8xxfvUDo62TDECRN+s3cHb5apUKDxz0fv49b/3thjfrjXCxPlva2goekZ2xFh+swsgbUsZF3uW8YFMCMVIQ0Xcxdzr0TI4ie7+jkIVNHtlBiLh/9C0xWpLaFc5bHzS0tbWOKOHdEm4NETvoX7SR6UA5lyGNK6auA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQSJ/tKrEkSt6A7itN/b8EEpVUZZqqF2F/auj6leJoA=;
 b=Yia7+0SrpqTp5Oj2riMOBHJCHAe5ilrrvrx3N/tt6R8/QCXaWV0RcmhcJ1hqfmyvy5IzlvV67hYBRY1AF/7rMwE32EnJzm1gysOGrQut9px1LTFjCXM0vxEKmPEfruEzwt86pvpoT8YHl66RHS3izNfITKnYGhXJLm4R1g3KZKM=
Received: from CH2PR05CA0071.namprd05.prod.outlook.com (2603:10b6:610:38::48)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 15:24:46 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::24) by CH2PR05CA0071.outlook.office365.com
 (2603:10b6:610:38::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.13 via Frontend Transport; Wed,
 29 Jan 2025 15:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 15:24:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 09:24:42 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Dmitry Rokosov <ddrokosov@salutedevices.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Maxim Moskalets <maximmosk4@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: Fix Kconfig coding style
Date: Wed, 29 Jan 2025 16:24:32 +0100
Message-ID: <7f37ddd44ceb2c3309a814329b92e48b557568dd.1738164269.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2911; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PlEyvXwL9rrvxinOByHAuXY0gl78Z3o27QjftUMdqbM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvRZHobuLafTM/sE02YVMSe+0UkN2Hb6uFsN632Vj80Gr
 95Zaid0xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgImcF2WYwyvy2SrjnaBj2OkZ
 4dmaSRlTPq2xYpjNzn+tO479iGsKd+FekQlRR8ROrsoEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d84082-1ec7-49f8-dd80-08dd40791019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pMaV0FYdHbnVpMQP3Zz9ztJ7J7an+7hpsv38YXJb7/Iz9nzmhk0ssLAaJJic?=
 =?us-ascii?Q?Tv9bNZJM+cIXWAeAMeYeYHVkGZyD21pLA40WtOCVj6buY0CsBxZq2hK3YtCx?=
 =?us-ascii?Q?rZEC503GNu9k1XbLc9p1Mj28P19dnp/Gh/G9BOXtyOf6vxrddAeCbkyRjqF6?=
 =?us-ascii?Q?smQGnfBvOH7LTfdrJ90a4KQtaUeUaA+1dIsOvLVx5Nb/HkQDLuKrFx1pf6za?=
 =?us-ascii?Q?EI+8RPR9kJVn6hHybPuCp0mq8ShaxP6A9MGMdRihJPXjhTRMW0cahgOX1Lj4?=
 =?us-ascii?Q?vZkwu+o3iLxXDQK5v5M2/Hl0EB+JyM1/fIulND03u41UcarGKWOL2a7X21qK?=
 =?us-ascii?Q?nsxhxRMCmo0/PcBVZycUvbGrxVGOzqqG9/HracFQSWKiYtomAUPW+pIK4LLx?=
 =?us-ascii?Q?eWDlLKc1lk18N6MAiLcwKl+6M1fKLSf+T9vQwqUwFu/0Ezz0Sc12PXglaS5W?=
 =?us-ascii?Q?Q5+hAgwaGtkYF54wb98By6e3qRh6syUYKw4AfM1Bz1Y2+VQ4zmUzhTietnwf?=
 =?us-ascii?Q?aDwDZVeGK3Z4ygaxdCoC8+JQ1+F068huAD08VrO9ej+4fDtqcU+1naKgAmzR?=
 =?us-ascii?Q?Dvlx/vs0TREX8v7r1hUNhcIa8aWCTbuxXZgw34HY+Zm9OLe6zd+o8gFhceUO?=
 =?us-ascii?Q?8FGnUj2ImnFSiixNcW0OJeQEpyV989i3pWf74xV8NF/ErK53boFhB4Sc3U7D?=
 =?us-ascii?Q?5nhwUrNjGTHk4gfMw5jpPXeG3sNsmAF5cLqsXrPrJv35p1eqBry1UlI3r3uh?=
 =?us-ascii?Q?GuoJOEYs4H3uvRhPXcCdvTy9cwm4kwOeGL8DBf+cgjA/bgDGw63q9uDxiScb?=
 =?us-ascii?Q?iaFvQJoan47PtDumsfbvZarIFDcxvy0/gYjweChbOJ8RrhS5/EiR9TpChnj7?=
 =?us-ascii?Q?RIP0uyMSE2SIA0zdcx/I9kbSmGvPttVvn/cgcqQjFrFbrq1V+r5NHCqnHhju?=
 =?us-ascii?Q?cmwjTDxWUlHSJUmrtZAQmZuMcpUXkO6noYVze+JBh3AgKLsamgTdxlG241uy?=
 =?us-ascii?Q?uGUyEGDkPylM1ldugbGXtWoQhvyv5IKDI37507ARRq8Kyu/6GeZK30pH55j1?=
 =?us-ascii?Q?pXad1IoUNvWnYS17C/2chx6AYpaIHSR6kl46BedbR3+qWvS7PHN1Q4qvCKnh?=
 =?us-ascii?Q?M4tOHnNWyu3V9YAj+cyXEHkp2CV0nNf0d2ns+Pa39ZZntYlkNjDM0z4/4DIp?=
 =?us-ascii?Q?cMtgea+/p5zHsVUWKj6/NbKHnszIuoYtGYU65mrqOGwpIkFbg2HPWTID6AyR?=
 =?us-ascii?Q?yLrxHWzyJSux8tN75OZIb+hjnZvzmRDd4T5NLDKyUK0sk3JHCaJNlHk0Kiqt?=
 =?us-ascii?Q?qTUrCxo+zx5MZ3wnRKksCRf9Wz1QZl6AtBurKftjxgs/BWl1de1bM6LeHFKV?=
 =?us-ascii?Q?bLEC3UIX+MOKapeFIrP9YieIUdbzK3fi7gbvllk0NZFZYmDjd9GUB7C2J7Az?=
 =?us-ascii?Q?EnPKb047gceY4S+93oUu7wZFdLMqSKwTFAzRx25ppGCH67Rq7YKTNUfJ+pRE?=
 =?us-ascii?Q?Vf3YaR0Hu4J+vrU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:24:46.0735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d84082-1ec7-49f8-dd80-08dd40791019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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

Some entries are not using tabs for indentation and also help should use
two spaces indentation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/Kconfig | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d00e743db360..e62817bd9775 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -280,13 +280,13 @@ config CMD_BOOTM
 	  Boot an application image from the memory.
 
 config CMD_BOOTM_PRE_LOAD
-       bool "enable pre-load on bootm"
-       depends on CMD_BOOTM
-       depends on IMAGE_PRE_LOAD
-       help
-	 Enable support of stage pre-load for the bootm command.
-	 This stage allow to check or modify the image provided
-	 to the bootm command.
+	bool "enable pre-load on bootm"
+	depends on CMD_BOOTM
+	depends on IMAGE_PRE_LOAD
+	help
+	  Enable support of stage pre-load for the bootm command.
+	  This stage allow to check or modify the image provided
+	  to the bootm command.
 
 config CMD_BOOTDEV
 	bool "bootdev"
@@ -1811,7 +1811,7 @@ config CMD_SETEXPR_FMT
 	depends on CMD_SETEXPR
 	help
 	  Evaluate format string expression and store result in an environment
-	    variable.
+	  variable.
 
 config CMD_XXD
 	bool "xxd"
@@ -2154,12 +2154,12 @@ config WGET_HTTPS
 	depends on CMD_WGET
 	depends on PROT_TCP_LWIP
 	depends on MBEDTLS_LIB
-        select SHA256
-        select RSA
-        select ASYMMETRIC_KEY_TYPE
-        select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
-        select X509_CERTIFICATE_PARSER
-        select PKCS7_MESSAGE_PARSER
+	select SHA256
+	select RSA
+	select ASYMMETRIC_KEY_TYPE
+	select ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+	select X509_CERTIFICATE_PARSER
+	select PKCS7_MESSAGE_PARSER
 	select MBEDTLS_LIB_CRYPTO
 	select MBEDTLS_LIB_TLS
 	select RSA_VERIFY_WITH_PKEY
@@ -2238,10 +2238,10 @@ config CMD_BLKMAP
 	depends on BLKMAP
 	default y if BLKMAP
 	help
- 	  Create virtual block devices that are backed by various sources,
- 	  e.g. RAM, or parts of an existing block device. Though much more
- 	  rudimentary, it borrows a lot of ideas from Linux's device mapper
- 	  subsystem.
+	  Create virtual block devices that are backed by various sources,
+	  e.g. RAM, or parts of an existing block device. Though much more
+	  rudimentary, it borrows a lot of ideas from Linux's device mapper
+	  subsystem.
 
 	  Example use-cases:
 	  - Treat a region of RAM as a block device, i.e. a RAM disk. This let's
@@ -3027,10 +3027,10 @@ config CMD_UBI
 	  partition support.
 
 config CMD_UBI_RENAME
-       bool "Enable rename"
-       depends on CMD_UBI
-       help
-	 Enable a "ubi" command to rename ubi volume:
+	bool "Enable rename"
+	depends on CMD_UBI
+	help
+	  Enable a "ubi" command to rename ubi volume:
 	   ubi rename <oldname> <newname>
 
 config CMD_UBIFS
-- 
2.43.0

