Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE003CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 11:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D18846FA;
	Wed, 20 May 2026 13:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gR/tBtPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153AF846FC; Wed, 20 May 2026 13:00:42 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A48846E6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0QdecEveDZ5phYjm6NCzCjWE42KXTq+CYgXPdMDakY/eTBxcCcOoakg9cfZZkw2CxEVRmaSt1b0eUl+LkYNY4G2AWp02a9qFMYa8R28ZRNMa0K2h8GA/JqOUq/enlB1rQNPcG+D1MHiwfmGpdk9cwpSUpzEqU5nAslLG/BkXAxkJYwwdbrbC3Xme4oVU89F13wcU4H3ahuejvGOOCnKccOTF1wfNrT/nK9Vc4ewsj9dMOnJqZUdyDr250nBeq2VWVWYUIRszmJDhm9lBLb3IjFpx7o1GETRZeGuKkmV6NZtr32TVcfFkbJ5GCcj3iBDkTh+v3E5mmkxUYO1ZkxmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLO/h/LuCJnI1UaKHm6VkoyoMrMoXeGFXZrRpcMLWvQ=;
 b=FUerXvq4rUGC+zmX24z21QfEwewbOAleiHkXl8eBgyY12Iav2PkEMBUm1NJ9LAoZMpZED6RG2U3sCixDfsmzM+bRrrPESNZUI4Y5feu6DSnRNopGa4eq+cR2auT96dQPHUDXvSXNbP4VE7X5pQIViy1gQPBJDiO3N6JwpW30rXT/ywB9Mk/njqSRVQa6pRH13eOFtoM/8GE3Y6+EdJjZyhmLn5dNntfr7W21HfvWT6CHVVx9496EWW/ABKwHQC40mPMmrDdLeb3LIUrLZjy4cAtbXLyBN4jVBE7Nfz6RESEkue/D8IvRb7Fla7sUG7EyW3Q0i8mdjDFGvGo7hMdnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLO/h/LuCJnI1UaKHm6VkoyoMrMoXeGFXZrRpcMLWvQ=;
 b=gR/tBtPuPrY3K5LmEEMxhsjNlHo2QKisPmbzRymdCIUu9z3EeRafvp+8l9/xXl6AhQllrF3Yld9qjyO9+pkkSvOlrhTz+xfPgEFiulGeVxuCWUVReYNq8IO7ZbxgC9IICn0zAYCXFGtxjnDRLqUxbEoouDoi9jtq/LktuPEMb4U=
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by BN0PR10MB5110.namprd10.prod.outlook.com (2603:10b6:408:114::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:00:37 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::8c) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 11:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 11:00:37 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 06:00:36 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 06:00:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 06:00:36 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64KB0XaV1830936;
 Wed, 20 May 2026 06:00:33 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>
Subject: [PATCH v3] am57xx: restore bootm_size for ARMv7 HighMem constraint
Date: Wed, 20 May 2026 16:30:32 +0530
Message-ID: <20260520110032.2659321-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|BN0PR10MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 8671fee0-c979-4fb1-60ff-08deb65f061e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: fvwVxBCeXDAMBB+Ects3kJv/Mc61P8oZcBM6EO4zrSYCOtuj2GV3owu3/ycIoZhlgQv1kZ/8BhUKR0iHrSWwYbX6ftEFcKPEUfmqE9vwN5C/LlqKcrsjF4KdM8YnNRwnl173+4laU9HYaK3yzoCs8qWuDCi91trL8U5i925xiSz3RGjijUkJvIWaq2XvWB5/4gJnGP1G4/poyPpq5nTIfIWXuwzOSXIQe/5tkt5WkgYnQLPP5X6GN4qSSBOmT9eZStcV2lFko8+ugqZAffJ0cUoKskLcVGF7xCfJaCxoD1uFwCsEoPcXh3MqgEqzFNcSAPedCdPEGJdc2QLC6vLWCoV6+s/iCDrLv1S1EPNJo5F87sByquLeCCU9NJfL19lJUYoiw1pC0nIRODTOXA41mm7viBSq18wjXPFVZoh3RgMvm5qaXePXWTENl7nNU7D7fhYBFKERdkRSJuuDkdhp856fz+vie5sb9XFRqZd0c+B3JOCK/ViBAWTFhIzljnvxdHOjnwFTQt9ZuOGab4OTxlA6L6OCrC9WAx62KGoY/E0kYL1t5CCK1zZ0qKgz9ziG3EujTT0n34KMt6MSBu9Y7HqAwCal8riqnNzA3mO/1uyfNep/F+WBJYDeDaAjtt+u/z52l2NIkGpjYRcVMbOxYlvnig2gxq/0iagdsFbce8GpmirdIKBRnPe5pCNVEJ64
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a5jQv/OIwu9zf/HtJwpBj0FRVlMcwmdffIF2NBixqo4EAeQ9I4jovAl4jPKGJmCEeGdDG8/uWKcysWB5cqlFiutc3eqK0MqLL9MuQjd1lTOIkW4BDCqr2XBi4lHjMtUdFKGVPN6JG35qmlfuMrv5rGYJ4Y6E8uKh8RTx9dNqAGYfEzy/BWJg9CfrPY9gq4AOYbcgC13GLb2w31ZQAbDaCLDQlsfd3XX0jalgefwC0Pgu4xwDPe7C6oSmTEZ+y+b00RGKgF0Ie/wCbxwiJDqkj3ZryAlwZOVInQ6vl30Esp2BbwDbrsCWWdMN8fVGq+dAxqB75loaUhsczvw5NT9of+pQamMVnU2jXOFNETDEdYom4k5OwA85836IHzqXfbwYiKp+FlXN5MdtjgdU8qx/PMfKew9X+emAQF2DcXswqL855vpz9zamzhQzo+07a79n
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 11:00:37.2964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8671fee0-c979-4fb1-60ff-08deb65f061e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5110
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

babae80169d removed bootm_size from ti_common.env to allow K3 boards
to process images larger than 256MB, but preserved it in
ti_armv7_keystone2.env for ARMv7 Keystone2 boards. AM57xx (also ARMv7)
was not covered by that preservation.

Without bootm_size, env_get_bootm_size() falls back to gd->ram_size,
causing initrd_high to be computed as the top of all RAM. On ARM32
boards with more RAM than the DMA zone (e.g. AM572x IDK with 2GiB),
this places the ramdisk above 0xafe00000 (HighMem), which is not
directly accessible by the kernel after MMU setup, causing a silent
crash.

With bootm_size=0x10000000, initrd_high is constrained to
0x80000000 + 0x10000000 = 0x90000000, keeping the ramdisk in the
DMA zone and allowing the kernel to access it correctly.

Fixes: babae80169dd ("include: env: ti_common: remove bootm_size")

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Moteen Shah <m-shah@ti.com>
---
Changelog from v2: 
- Fixed spacing between the lines
- Add test logs
- Pick R/B by Neha

Testlogs: https://gist.github.com/Jamm02/4dc37a837eded0490d7f16b457807dc3
 board/ti/am57xx/am57xx.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
index a7cbbced099..4f712c5575a 100644
--- a/board/ti/am57xx/am57xx.env
+++ b/board/ti/am57xx/am57xx.env
@@ -2,6 +2,7 @@
 #include <env/ti/mmc.env>
 #include <env/ti/dfu.env>
 
+bootm_size=0x10000000
 bootpart=0:2
 bootdir=/boot
 get_name_kern=
-- 
2.34.1

