Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EB9FD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F24683F4D;
	Wed, 25 Feb 2026 15:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="POvzbJoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C5F83F2A; Wed, 25 Feb 2026 14:41:00 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E55EE83EF5
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpJvYRyaubvLDpnu5461yBfHWTqmKoSrdNw9sYmyaXEPcvw3xZ+ILe9Pg6/1bPLhauQ+YTBNGj+BU5Nr5EtpSUr1/Crnfv5mDu67/ypcZYPJKZu9FudcpHqG1GMwnBzhgHkXxj+xoe9MQZwLUlp+OR/FFtvKFsGWQ9jzFvzTLHM459/Hu8b3T8tv1lbhjLIMIfXaZeJms9bT/G53tWATKMm2dP7PaHDNB77FPV/wpRfOEVCOUJNwhM6EGS65JR9wcEL5BurxDRA/ATnHKZ9kiSOaf2qN7sai+V7/qTNx5AIdB7//WEIfp2MxNFvgcpa9V+dhU56Urj4tRIj2YGhkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw01RhMHuDz0Q+S1z+LB2IoJg2jzuHoxTTQ+SAM5SRQ=;
 b=nByoUhMqd/w0q6vrZ5azyjy/gKQw9SmffHU1q5wYV5ZvxSxd2l//9KuhEkAJFJMDc3wQHxVl5wisTO+dHGgUIjFJxyYD1sUw2nkAVZKA5kHhqoU4XnTebIFBPk3/w4Mj6z0M8xl3avKn/JCpISGNpHLhATWv4eFXfiR3NWvpzONLyqcV3+JxClFGGqUufBWqOW1HNNK7u1ufORwRNFjfmCb0nmW5YOliCmtbKIYuW8oBJBXapUpq70tqZ5d3nZQ6/cCzjUgMPo4B0TewMiDXaomfxugAgi6Pn+12jUyhRcDQIrOb4amjaz91wjCc7+8Gcf89grCx9n7dD74Ir3wt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw01RhMHuDz0Q+S1z+LB2IoJg2jzuHoxTTQ+SAM5SRQ=;
 b=POvzbJoDDtYOh9RBAmuA8u2KB70UU7aCUX/UVkbhW1RC8OaGBvw2zpINP9c/NMg1ZFArJpxQqxqKtZyTI05uh1oM/taDNxWcRY4+fh4u52LNPOdu7e+CFg5CikhMBS0ejYV4LC93XbmZcR1HfIceLoMx2yP2NhGZZxjTEbp33A0=
Received: from PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::35)
 by LV3PR10MB8129.namprd10.prod.outlook.com (2603:10b6:408:285::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:25:04 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::10) by PH7P220CA0001.outlook.office365.com
 (2603:10b6:510:326::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:25:03 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:25:00 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:25:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:25:00 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGw011150;
 Wed, 25 Feb 2026 07:24:57 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 8/9] board: phytec: phycore_am62ax: rm-cfg: Update rm-cfg
 to reflect new resource reservation
Date: Wed, 25 Feb 2026 18:54:24 +0530
Message-ID: <20260225132425.3096103-9-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|LV3PR10MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 510db2ad-d6ef-4704-889a-08de7471490d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34070700014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: Ojn9qkWziugfoyueCWZMyZWTfuvhApfluVv4FNgTmyLyI0x8L8x/GgMrKcf4p4/ohkB/4+hOrAPAsPZUCug5+iHydQOw4xnR1ezlxhNgSP2D+zKC89DpectXysIWFF8UdcufkFunCr5JbkA6TGW9qsN3WE6mOGH89Mkdt1e1tNGz/HhgXOEQHvcElc8hsRa6p2KP9Y9lIkD8X9lMONd7sUxFYEYaKmoYEIh79ccQSd7PEEjDFoMEpxtozfdjUt8e1Q6cZsJm/mi3p7ADyUIErkUDDr9SizFhL0zJ9/AYKkxEJi394cHltJtCh58FA6U16JAq12l4Eb1nmNNOzuo5/LyWyNBrwXxBG0M5/+Puo/dCvvpuT0nJ6RGBX4qoIftL8RseQy1gad3VjoV9solNtTR/DGXWrIhFlgX4OD8Mq9AFx9d3H86EfqoJeeqYgMUKUcaR6xEz67w39BQK1pIz0E6njod3ZJz6cvCzZN3CD+nSEumDea5HKNHE42XKVivon6TE6VJwXMrUHousnaMsqB8q+mQnXCptlqtaYPkazkQDMo2OyfOpLIcgi45u1giXuA1KQFL69EjOiLBUUEiQNiY85pvH9+hPkRBaxAPSQGij9b8upt4chF0MM7hD/gKEidYHaIkqWvGxwsRnKZfs+hoAt22t59xlrVdWxKy+IK27ikauF0CT4wBAg+FqpM18Z7NxLoNQS2srl6uLfE9NnrmPuMdkM6QvOmCFNeVNU9fGR253qAcao0Q5s8GvhoPznXnVzea1RmIwAXhcYe1slp4LSDAzAQ0XyCVZnSb8CE/IBPDAnkf7l9a5XFmrdVw2HgJjzqU36j96jqUqtiBvkA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34070700014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vbYhV3QmTevDMRdrQTZr8P7VUyJkn+Jj0MLmRXkeJ7Zk3wqNF7hT7nCbNrKK27ytxbYdmdNgTq1AxCFTcTDETCIB/m2jy242xDRjM0OMjS8tLrVKOsuCvnbUJamuEn9yv4jAOP/JWP8SA3W8nryE7LlbRvTFvDkluxOwW4rB4K6yituHPUj6pm7+z6HaQC3gAqTgAzJgW86OOCsTUJHVINc3MAcoBwNFjCnqyhLKBy5trDN8cbG7OMqU+jc7xewAq0LW7hozcHfQpQbtaTiVihuhZlrDdvT/ufUhXwI7rlie0knQyN0z6OAKd6+dmxnqUOxGXNhjC8qwv7HvIdsBIGvvIg/vBRvcgMy5e5cWCeImcFc8wcvDQGPuvNJX0FtfhUnW/xiirQ3hvhoCN/zVS3JXlEluPA8BG5/DVump9fyd4p8gvroiSJo4OlOAkmaf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:25:03.8127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 510db2ad-d6ef-4704-889a-08de7471490d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8129
X-Mailman-Approved-At: Wed, 25 Feb 2026 15:01:23 +0100
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62ax devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/phytec/phycore_am62ax/rm-cfg.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62ax/rm-cfg.yaml b/board/phytec/phycore_am62ax/rm-cfg.yaml
index 0f34b8c1bc0..38bcd46e7e7 100644
--- a/board/phytec/phycore_am62ax/rm-cfg.yaml
+++ b/board/phytec/phycore_am62ax/rm-cfg.yaml
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 1038
-            num_resource: 497
+            num_resource: 496
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

