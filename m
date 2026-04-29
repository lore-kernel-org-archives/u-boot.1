Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41884FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34536846C1;
	Wed, 29 Apr 2026 08:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bL7CmVC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831CC846D1; Wed, 29 Apr 2026 08:30:07 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683DF8460C
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFNBiO4RB3jjeSndxxZ+wkL3Azy662ybOfmcBuiCPrfmK8rOFhM7YlS7TfPriP05qG5gdwiViolIbc9wVLcisESqih70oMkwuyx4uDad41btpSygpFIXnXbpqYJX42L4soH3ZeJC6PnIY59LRH4MLY/tDVoI90cpwMUPs8xrkX+QOifHBhljDMPIkBzFy91aWt6VhkgqqManb6dNXAGdmB5FUuyvJ/jkLOUK9dG0dl/VGuMc346NgKj1fZzCF8xKO61RnWiuc9bRSf8jPVKzhJn8k6xNp85+gKB0oAWlUx3yD+U/U60zU9qFzcqW+vhM7M1CAgoQug16XWaXpI8k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UILSnfvZ20WlQNXAIsrh1psVDasCPKhwsbqVZeL+fqA=;
 b=boy7erD6JjZchzdwkzxAXkfgMGhcx2BZ10l/HV04+UDOISb/89njI8MC84IsxO49BfKfb/TvgiGbSj/M27+zdOFnaL4si8ljq8nAjg9i+HmZBHA8NpqVybiocdMbAm+f/d8uQnJOqxSyn6avpF8gQ8bN78G6U6Up/WEZlWqEWrCByEEFI9/GV18gsot6N1M5stAMzl2f798ojDf+nNQMzWqBQ4Ong5BkuNSewNziqGJOuPXX2bwXmbRgmBTUaQtdi/2/B3SCzs0MPW1oRIisQev6ojB7R01RN5iOcYb7PC7Nhu8kXzdp8ACTBaHGXpsCVDVLXp/02HKhLfak8DB1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UILSnfvZ20WlQNXAIsrh1psVDasCPKhwsbqVZeL+fqA=;
 b=bL7CmVC3gGZivmqgZe7GqeqF77mxNlEMRS6ZzQDEZDe+J8J8V4vfo2AmidUAX18aKGe6tARGO4gNe1w5u38VN+UJDxrMWbguZqIqJK23ahfHijsKrCL3Ae9Eg6S1nSnS+smfGz2DCtfWkfXy+VCLhoqY133wXy4JejMzHO+H9Cs=
Received: from CH2PR18CA0028.namprd18.prod.outlook.com (2603:10b6:610:4f::38)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 06:30:00 +0000
Received: from DM2PEPF00003FC2.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::a5) by CH2PR18CA0028.outlook.office365.com
 (2603:10b6:610:4f::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 06:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC2.mail.protection.outlook.com (10.167.23.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 06:30:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 01:29:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 01:29:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Raymond Mao <raymondmaoca@gmail.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] bloblist: fix pointer comparison in bloblist_apply_blobs()
Date: Wed, 29 Apr 2026 08:29:53 +0200
Message-ID: <cffa552d648f84769f4d5d540f419173f10cb86e.1777444191.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=DDpvM/yjvaIjl6983va63fsUY9aGtQcWLrpA2AK9xbA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+XJrU1lOZy2K73itY++ypqNmxDZnr2575SYnvqBGNP
 Zv/QP9vRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzk2kxGhvvnf2hJipX4Ns/W
 25V7iOfXky9rlbhmrHO6msMvzJS+tobhn+pKj4U3VGfs+hv47PrOdTu6yhlsJCqnmrJINeSvDBB
 Q4AYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC2:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4e2dc9-72e0-4553-442c-08dea5b8bd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Yn/LQMqGIjrrMnG12m7fRZFaUOZ9vLuKWPvlAQsSTgA2ZqaXfG2GcDnMvM2QjaJwLdDs0cKpAtroqDz4+gB2TZ6M3cWz6zIPKm7+otx1tHQbPY7rtNTDA4F+CdP86G4N3FyGl5KHJVkewP4LfNuMgQQbNxaXMRVpTU7B1fUlbfUAOMcDxPCKU6cds8g3BxiG1vPKwQB6Ylf8Py7B1OrV3SL0+zhnx/NiU0N5bIiEwQ+iI8Io6lPvkijzFOAUtcYOIQsvdZ00qVBwI0b4rhUqAZ17XQE/J0OsMIXlhdTJ0lKLoNxivdAuIP8IUaZoPpqMQx/9UUryBxmjFc/NnycINgNd6qZqyUz5i8G8SY1P0PrDxquxY7mGDk5p2ULCKQvZGGeWKbCZYMwtSIMmZ6lpLQDsJdyl8pPLgugB0k+Q0Q6BnxnsnrszzO4nk8prrb9sQ2o8BT4j2McgG9U3YT/lpIjp6KXVPnvVp9lpfao2FS7ypjWjtE523ep2SFP22REQ8IFhZ8xWQzzoJHg6Q0izcwDxJBMj3zZHfuseEAxQHcaniTq4EC9N4/wLDwIAM6GDK+3Ew6EPlZQga7lZpWVeRih7SVOLvb0jRtEm0Fn3V9pNu+o4ZKgu/qZgPdjs1SlD1SEuoudhSV+lLdKVYhBlctmdPvW4qyhAnppg2Zouy2AAuRWhPf++mwBrUDnW6qQ272YrJhLFG3oGCDAEGcEkFXRPo5oitaZdsCSXdhjPLz4alA0p8bL8YRnojgfsZHWuHZ4lfGBrEBJHDDDoWpTQLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mq7+Jf1FOO96sNFL9v764EAi2idLgVmBMQRsaXdgteyPxylyhAPENrB9LPdE8v4EhZwzotLF40o2fMoRthJeSghfrxkAThGABirINPatR5TqT4gYGJC378qofDxQ6eQEZ2E/KY+gltURtt8aJgqrGsL2fN+drWrdRYDCyJQiyBlei5Sgf2Zc89L28BQFX4j/uq/UmjduhazdB0+7tteXtNbEMbysM2K8rYn1d3iQy39Cn5tQbxJ+9gLPcH4qCxFvFAXynbAfzFGvTgm8H2LDqeiEtW/A/ZxAnz8eNnwwyVwaUeTk2cfZHanLUeWPSu4RcifeXziZ+aRrNRQ9iHR8dc75TV1ONU33PQhwE5QlwZboA4R5B4QvLfoQ0ICEpzjknUTzJLNpcJG07gs5yyhjs4Xo193TeRGBV73C7wzSuV8MQvY41TND0OohB3kJzBaW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:30:00.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4e2dc9-72e0-4553-442c-08dea5b8bd3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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

The rec_from_blob() function returns a pointer, but the code was
comparing it using "rec <= 0" which is incorrect for pointer types.
Pointers should be compared using "== NULL" or "!= NULL".

Addresses-Coverity-ID: CID 645841: Incorrect expression (BAD_COMPARE)
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index afed968ce01d..d084be899588 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -300,7 +300,7 @@ int bloblist_apply_blobs(uint tag, int (*func)(void **data, int size))
 			}
 
 			rec = rec_from_blob(blob - dat_off);
-			if (rec <= 0) {
+			if (!rec) {
 				log_err("Blob corrupted\n");
 				return -ENOENT;
 			}
-- 
2.43.0

base-commit: e995dcb19c89c5c697b57380831167ff238b0d07
