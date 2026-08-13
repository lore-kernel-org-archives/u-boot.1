Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A11AC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07A8F608BD;
	Thu, 13 Aug 2026 07:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VDg0Zmx7zvNw; Thu, 13 Aug 2026 07:23:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DED63608F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605834;
	bh=srh4eU0g3yZ1qH1UHntK51uh50crFZc08ID/p0pVDvU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=01NgqHpxLLK2SATnMKjBfe48ATa809brCQKt+72yD2LSWA8aYdDWPHCT61nV7dotr
	 VSV755Yh5P2V/0AdRX0fA6Au6wgOG6LuQAXQSAXIlbwHlkLmZNdDo2lKWX/U7fj5YT
	 fj+6ZmYM+emjrwaoMy2KyBJDCtKbEht32ZNV3uiD2kx4+tcjBdXfu3LyJn8hcsGOBC
	 fnyD4hmxVgweu83spPeZIRKyanNbvDXbEYk2M54/3Zr+2vEhWhZKgCyfZgZ900Jy20
	 jpNaSqcwMNcsDy18YEaG9ZtWEbttFg32faR8pKJzVnvMbxYHHQTRmhPnruV7Q1XNSM
	 fQJJPA+SxKNxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DED63608F1;
	Thu, 13 Aug 2026 07:23:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8858109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEDBA40337
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5E9UFiq2ZrH for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:23:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E39634025D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E39634025D
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E39634025D
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvH6tqmlseZuGcJNSXao8QRf/KYgFVgTfsOue4pMAeCs7ie4RxQD1LXeiY4T8FhcBrzP6qA4fl84JhCuvVnLFwLhIYKTsPVG52G18rc/S0ed5XLI1q6aP3qH0NShUg8lR83w+5qOkOUyPpf70addtxnDSjnq7z9F9U5aW5kJB8qPm0gi6SeQx+Fhm7PsNfgVUHnrxJLpjPod8ebU/e4goNASBrP8AhZ0/vRbp1MnV86BfOL3wGee9SG5UM1LSJL0jFEl0sfO5BUuwvzQXRKwtNkMh9sRsBP7HSbaMt+pFht8/wMZRkPyn33ZGPJ+Od4s3Cjek9EHNiEWhFIZAqJSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srh4eU0g3yZ1qH1UHntK51uh50crFZc08ID/p0pVDvU=;
 b=tMS2YXqkoTFksezGRyK/XIlX20zC4ttFCHW25QPMsztnFPvfAZR1fxymz8KVV9q5MEXSCjrAnsXYZAVJbeqzsOBr+hI4LlgRMyvfbqeXd/lAA+qiwFA1msSKbUY77hT+VKkW1uRxsqB5sLYP7SW8+wFV568BaXAE0j4FyHvlwXM80HacpTYUWCUXFGkwwk5iTcE7RMQydr7M/0R9ySlsHgKuStH7yMUCHHqr6EcDWu/MEl6f/Eoct0H2wJbQXr1lqiMduDqw1T+CMrlb+oFni2XH3v+TKmTWsumm/hfWWt4zRUpC6ET/+b679tdGozJ1LfrSiVv1IoEUT2v1JASYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS2PEPF0000455E.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50b) by LV8PR12MB9261.namprd12.prod.outlook.com
 (2603:10b6:408:1ed::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:23:47 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:92f::1004:0:4) by DS2PEPF0000455E.outlook.office365.com
 (2603:10b6:f:fc00::50b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 07:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 13 Aug 2026 07:23:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:23:43 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:23:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, Marek Vasut
 <marex@denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] MAINTAINERS: Move u-boot-microblaze to u-boot-amd
Date: Thu, 13 Aug 2026 09:23:22 +0200
Message-ID: <f9b2bc4725a1c50bfd856665c8bb23b87d1077d3.1786605799.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786605799.git.michal.simek@amd.com>
References: <cover.1786605799.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=J+S8YYNnuy+lbe1FIf16wyVDqO6f15aiK4H2dzUF0TU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTVFnyefPJQhSq/wUqZrVfF+4S0svx6/n5yaXZgWNpbK
 +LouqOjo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACaiuprhf8w5Ycv7H6dkvOaI
 upi/83y46NM4jkkB6ktLGdZdOmiVO4mR4YzMxMbygqqnx24rLdvO94Cn6d2qX+b6S/5P75sunHn
 rMSsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ecd031-bdce-43f0-8271-08def90bd013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|13003099007|56012099006|10067099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: MrrZLOygfHU6A+wDMzEaKS0f/gRDKl5kjlsdl7XcVmcIwbiqNKObD8uoTHJ6U9KB6VckwPvxwwMlc7r35ag4XDBXEksx4TVALMSrKv8PgtkZ8RlOIpSkWXMt2d2bqQcJN6dk+idLjltIsVRvA5YV049OFuCVU1iaCoVe3a+8Gg+dG1aC7Hq6g8VLfAu191/tRvoyE2i0RMgvQiXpKABm3zXUtnpsCXUbadGZlDCzqXpn2H0Ogg28fgMyfAjhVLjha+EqYxBnWSnqd5JKr24yfrYK39Uc5tTClYlFWpmiXSMTOh8AYqi4x75hFiSMgjKh8UmgCh+PBT25M+sCjhphAr1tg0PBtKbk6K4apfpHAcbyZiCIsCRKutEo2Stxrd+4gtCkkROIwr/b48piSYeVUmI/1o+6jP///A9sT+UB3oVjsCqQVY8ar2bgoDRZHh5Kde+fIg1+8vKG2Khoj6dKQMv9Zr5eqkkWvjJiV0Xzt23OwqTAoD2ODMSoHvdaVsXgyKX+mLZEZ0VKzvIyEjYhbRPQ2YmjoVwF1N+gTdXaWdCzy9f6D5Z+iheemcUVOgZR3KGtDO7cV+g0AtDgL3pDET3drsqLXgwAWNiS5dtRtAdKb648oGfUvcPXXSlvWR62Wzhug7O1TGoxjhozXrH8zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dP7baVEpQaI0fZypYwzBXLY4rwSvDRymVcO8vekjq8j0IeVkprUnAiDDiibL5nc6k97A7KZX5DUpv+XjG+WIqEn6RekkIraJD+VuTvPRNmsskp4QV0us1n2KJn6etMzkZGLQqcsuKllYj6KH+it+9mOOjiDkQehmxfSL5yyZXr4UqegTVjLGL7sHzum+ciWrLO5PpHIjgVFaCguQ2f7aTArahDmBvb4giXIO14KvWUhgIskZnQLx+beMJNCh6JA8FKIMcvsQNVAY/80xYILNYwX5JWiHunWuKmy2in380cMQkY/55mriT/bMfijH5UTMC2C2AaDD5IItjC3bLFH8PuOhMPSf0O2Bwh1TBdup0VVz52kSe1066jFzsVkjpILxvOG0qAmrHrazvGUEV8tS2NXEk6w84ewdSJSKX7z/xtElEfICjaTfS0fpWTQ+H23O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:23:46.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ecd031-bdce-43f0-8271-08def90bd013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srh4eU0g3yZ1qH1UHntK51uh50crFZc08ID/p0pVDvU=;
 b=3HU+qwXs80pgbi8Hf1Ud+An7EW8EGdzcqwms/eICA4yN1bnQMzpjz7Im56QE0UAxB3iqR65Mw/tgEPOJhgQe9jeFDOKhpXeDqFcCvwGKUHSBe5dCKvkdI/m+ph3plJb2YMN8WWP8RcbJl49io38fPlnfxPbYBFEjtTfOT1AIW9k=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3HU+qwXs
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

By moving to u-boot-project.org custodian tree has been also renamed to
reflect current situation around AMD/XILINX SOCs but links to repo haven't
been updated.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb48eea55c5a..5b07ab6656a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -805,7 +805,7 @@ N:	uniphier
 ARM VERSAL NET
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/mach-versal-net/
 F:	drivers/soc/soc_xilinx_versal_net.c
 N:	(?<!uni)versal-net
@@ -813,7 +813,7 @@ N:	(?<!uni)versal-net
 ARM VERSAL
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/mach-versal/
 F:	drivers/net/xilinx_axi_mrmac.*
 F:	drivers/soc/soc_xilinx_versal.c
@@ -824,7 +824,7 @@ N:	(?<!uni)versal
 ARM VERSAL GEN 2
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/mach-versal2/
 
 ARM VERSATILE EXPRESS DRIVERS
@@ -838,7 +838,7 @@ ARM ZYNQ and ZYNQMP
 M:	Michal Simek <monstr@monstr.eu>
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	doc/board/xilinx/
 F:	doc/device-tree-bindings/video/syncoam,seps525.txt
 F:	drivers/gpio/gpio_slg7xl45106.c
@@ -856,7 +856,7 @@ N:	zynq
 ARM ZYNQMP R5
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/arm/mach-zynqmp-r5/
 
 ARM PHYTIUM
@@ -1125,7 +1125,7 @@ F:	test/dm/fastboot.c
 FPGA
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	drivers/fpga/
 F:	cmd/fpga.c
 F:	include/fpga.h
@@ -1274,7 +1274,7 @@ F:	lib/membuf.c
 MICROBLAZE
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
-T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-microblaze.git
+T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-amd.git
 F:	arch/microblaze/
 F:	cmd/mfsl.c
 F:	drivers/gpio/xilinx_gpio.c
-- 
2.43.0

