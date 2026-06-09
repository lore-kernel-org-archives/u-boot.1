Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF7DCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 18:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E98384942;
	Tue,  9 Jun 2026 20:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mjB+0wsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A7C8495B; Tue,  9 Jun 2026 20:11:02 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655648493E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 20:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsoD5eHpN4O5zLNnXvpeYBASjqDrQgTQ0znSkXzvtCkLAQOsbvWjeDBlMFa7HCEtuDmBqpMfpGPvUnNBgpkiI2J38rZyoELUzBnWEO6epysxFZTMEcuqz138FBaQZFULDIpgVhfFf4kAOZ1r7NZGLGOYnqgTMsEZlOO7YBNJiaPY3l14Wr9K+Lb78oUtlwKW+nMfVqwSkeerxjajGos4tBqZ3fcY1eMzH5lUlmbh8RXTkIanlKX6S4R/A5CjzTjAW1IjXAmNsOs02PKfQFIGASZTtPjQO4nAKmkQLGbXezE/2Ll9mxzRaK7t2xw+i5nnUu1Z8G4dO47PqHa2a7A33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PfdO7IAUUye83bTt3u4hbSkuhNdSlqsPOMSHBnnuO8=;
 b=QABsaRMMjq8YWtAM639f5XZt5KSUMliQcwH8ARGMsU5ajFn1avK4Bd4I38QbznInNBw7AyHzsMf66vjOC75el8VJRNZBdhWp118rSd+sG33WFIW0l19qBuinu7D1re643D9O6pj/b1TAlR4pHOZDfSP8sqGKJK2sEXbUJ0qYM+QYB0skoMMup07ELS6Gkehc7dEkETFcPzKNW+G95WACoE70u1hl0cXqqnJy7wfx3GP3cqLFW/oQ/edq7YT06p5xGGmysKB9SyF3pnMiBcQGAZ5hzHJIrQTGInkmry1byGRSxGh27XPf2ui9QEbxTgsidsBG3hxYt1FcPHycCcWuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PfdO7IAUUye83bTt3u4hbSkuhNdSlqsPOMSHBnnuO8=;
 b=mjB+0wsWCM8vMmK4dnX0+FKE3qIVOFR91MeWyCdE7eONEtXaHi4fcwRAd/+dqTmUm+qv42zgHKxV1NlwJBYkpK/pHanDiShCaM0DT94aKftBsR39V0ghidpgDgSlV3QxhpEPONibVLJg1NczxmYKPVVKvKrBEZGklB6rwJGBJL4=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 18:10:57 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::2) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Tue, 9
 Jun 2026 18:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 18:10:55 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:15 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 9 Jun
 2026 13:10:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 9 Jun 2026 13:10:15 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 659IADAd1612377;
 Tue, 9 Jun 2026 13:10:14 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [PATCH 1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
Date: Tue, 9 Jun 2026 23:40:03 +0530
Message-ID: <20260609181006.460401-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5caf5164-f594-431c-8136-08dec652736d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: JxZsRRae8zEPTp89o0ohZOiNod9k2o97kutt+0csTUZeNslJaJE5Eb+gSvwCkQhvYtazGOrGSJHHM8GPSBV9Htwt0XGSKcY7l2Q8ituEjx/8xmtFFkAbHrG6XTQ41Uy+lemLnIfYqOg6X2/62KsJWhIE+zRojkES1Afu/3CAGvqSZwzHb5Vnuqsokxe32skcd9kMEiCq4vo2DVUsunL7le0AsCz5B2zA5dPGerffRvStZiDk0baHiWi4xF1mZLOKVjSM94e4y5iCtPYvEzlR5cUnNA+GGxHmGxQyY5Cs3vIH2hoKuxPEf5i4oueuRjWoC+TpQbPaj0Pn75szQro4WlGMiD76j66WLbNX9pp4/IO95ojRy1uIzWO6Ja37hDss7n1m7GdBUwQ9RJPidebroN/36b+2DcnqDEwaBLmbrsWepczXRc+CfjUOgQeeT7wPoBFua1IcAAK43QpxKvJJRbvtmtt0897CQz8BvS5I8zRth+m2MSX09mLkT9uvp3bfJX8p+/PEI6wGwoVlXzEPkDjyJTHcNCsNxviCTUqUkZMsJkefBp2dHmY2xwmk/CnaG6dM533KzM7gtIBVuYDWLeHFBaMO+Qlm5N6nr5Hp8vZnaHYs+VisUtgQ6tP9mSyCpjnn+Ljy9BMAIqih8acad3DpNY0Gl6VlSPzcLaMfej42iUDddYyTyIgdavl4bKcRzNIAoTWM0tWwotxH0udaBsmnZgaxXZfai9k2hPULCow=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k+S+pXm7N69k2tLs5fkcEHBVmWNvaKYrLmGT+Cj5ijL7fs32vT+cWJu5Q7qWiRLsY6MwTjth8YA9aX7oCAPay2/KrInB+4TubAYDIInasSKJSTYqk3qZuxpUVlF3FqidkA1QUruvUWjs/GLVmjsq+RX1wX1KaUxUNdcL9+pjZlMPprScJqJ2mNe5d/NiIESBZK5KOS4pH9xtgu2D7loRywhOifacVJ6bFlynpbxWRRPzXlHjjSEhll1UFqn8UNwAgyYsMQw3y3OKSKddTmXGC5swDm76W/ZkiTk62it8JUIfTfPwiHzc1pc3kOiCwGArs/2r3h/3Po1jck/ONoWk9ONpmAOvBWclq+abPYp5b69E5Jyr5z5NkTp5afYY/ik0qBCS8wWduwl0u1IvPUP2yI9ccQ5FBkASpJR8W3o1yvFYOEgG3fJekD3izGvrB4cr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 18:10:55.8723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5caf5164-f594-431c-8136-08dec652736d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
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

Fix phandle corruption in fdt_fixup_reserved_memory()

The original implementation used a delete/recreate approach:
- Find existing reserved memory node (e.g. tfa@80000000)
- Delete the entire node with fdt_del_node()
- Create new node with fdtdec_add_reserved_memory()

This worked fine for ATF and OPTEE nodes because no other device tree
nodes reference them via phandles but other nodes example DM are
referenced by R5 nodes.

If these nodes are deleted and recreated, it will not have any phandle
property but the nodes referencing it will still contain the old
phandle, causing initialization to fail.

Update nodes in-place instead of delete/recreate to update only the
"reg" property using fdt_setprop().

Fixes: 8b0fc29de0e3 ("arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT")

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 39cb00c3f43..25e40f6a666 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -129,11 +129,12 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
 	if (nodeoffset < 0)
 		goto add_carveout;
 
-	/* Find existing matching subnode and remove it */
+	/* Find existing matching subnode and update it in place */
 	fdt_for_each_subnode(subnode, blob, nodeoffset) {
 		const char *node_name;
 		fdt_addr_t addr;
 		fdt_size_t size;
+		u64 reg[2];
 
 		/* Name matching */
 		node_name = fdt_get_name(blob, subnode, NULL);
@@ -146,15 +147,14 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
 				false);
 			if (addr == FDT_ADDR_T_NONE)
 				return -EINVAL;
-			new_size = size;
-
-			/* Delete node */
-			ret = fdt_del_node(blob, subnode);
+			/* Update the reg property in place */
+			reg[0] = cpu_to_fdt64(new_address);
+			reg[1] = cpu_to_fdt64(new_size);
+			ret = fdt_setprop(blob, subnode, "reg", reg, sizeof(reg));
 			if (ret < 0)
 				return ret;
 
-			/* Only one matching node */
-			break;
+			return 0;
 		}
 	}
 
-- 
2.34.1

