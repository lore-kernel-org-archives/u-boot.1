Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B95BE68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6964183E4C;
	Tue, 17 Feb 2026 12:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w8dUG2eB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E3683DEB; Tue, 17 Feb 2026 12:22:31 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB842802C1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XskKcJIVJ17egIjsEyopo0aMzN1XyLGDQqQ3A9AaCR8s/sGeu+tJNlQWFkXL+aHKrmpE9N6nL0+XhVW5l1fsnY8TDD5KtSwk04UxTF1LwXWskqthr/HT+Yz8twu45jJuyD1DRElAzPojYRp5PQ5Z84Dc76VuetZvJb90R/vlTojhrrgjc9wyyeRNtCJVFN3iVatkqCJa++8uOAvw3TtDs1qLWPMMSPfLZaYlotACEKte3GzFObFCRJPhftzdJj4IpLsxzV+kt2jssLQkSRjZx2X9YDaWuGUwe/JgtyzKClc3Fq0fro+W0HilozH4d6HStZFD0YgsO99xDnPTwv3aGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzVeDk536XSS17TWhmTuaTynzqkdOn5tfI0/RIMhyk8=;
 b=S7TYsgKRXzehxjvL8imOWUSnecgPto/agss0IFWtuDLfiEbIHnLKEF/5gzq+aJeFrc59D6oRCg0mblpV0miUwiAw9ibnwCpzGApbWdxFnMKE1BjIuqq2Ju47Hk/dXnDKtin6wZx7WjpLctfneogvIcCQsc3bNVHN0jBLZVi8RDQ/eD2nOLW6ptooCGlzettjvbXjlpts7nLIRGEuhK9IvNMkZE+FpWWAvG5JMUL0w1dLSdcV0ZCHZqX5tqCiPL//Z3l0cBjBNV0Ej9P0vwifNg+1sly04AAgy1o11vhG+ieowXLQdLwXEhaiuX2lTDprZOEVA5tMF8fo6ABCTPU7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzVeDk536XSS17TWhmTuaTynzqkdOn5tfI0/RIMhyk8=;
 b=w8dUG2eBUA4uG6PkiR4yq1+wcPFB5pqLMiQ/cdUK4J0Qh8rc9f4gnUJGgsyMyYQbBuMqgHNyTL/tgtoW9ujCV02AI0ZJe0+MkcS1iaxcsm/ctQpmiAc3GGNG56RrAyrzB9JAo8dhLnGFthC4yJaGnYtMSiB1z170R8/hWO7qw/g=
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:22:25 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::1) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:24 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:24 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:24 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutT3263329;
 Tue, 17 Feb 2026 05:22:21 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 7/7] include: environment: ti: Add ospi_nand environment
 variables
Date: Tue, 17 Feb 2026 16:51:56 +0530
Message-ID: <20260217112156.272154-8-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217112156.272154-1-a-dutta@ti.com>
References: <20260217112156.272154-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e8a5d5-5e45-432a-21cf-08de6e16d387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T1nmktelke4lV1XTl2IzE5UTVWnPznBlObmfFXxXDlZaHNZPG6g/CEA0GmkZ?=
 =?us-ascii?Q?dd7T/69l0Yd3ITNEGlQ1JAqbHzaFUBr6QlIlKYiJmiMS0I7vRKL5TsGLhUfo?=
 =?us-ascii?Q?1dvy4vD3sZnwsKlP7CflQTUYaEMkrTKcQycpyYNKPssTclPAEaZY2nJ6lrvl?=
 =?us-ascii?Q?TXI//TAJPjOqLvUb4Z+Al2gmYEKtVY1l3uLJvKqO4seReC7VwV4ouIyRwhQh?=
 =?us-ascii?Q?FKDV5smysC9BVIGt1JYCZUH/5U/20SEfrH8AmjTH0NWab9hllGZfujeYREfD?=
 =?us-ascii?Q?osV2+4mwH7Yq0mIgzSOnrurADQPjrMtBxzDcVJsP7ZQsh7xXTbqx+qhrHand?=
 =?us-ascii?Q?n5JTbldHbouIsipFntaFecAKnAa2oSRSLdAm+Z7APkvQ83Dl3gQKAC6eZnDR?=
 =?us-ascii?Q?v259TX1d1zBPK5Mgm29cX7twYwvi+wPvKZU+etjTd0lDpa+TC0AfbP5xkFTE?=
 =?us-ascii?Q?eo+gXiN2Jn0DPmfo1hWfPFFvQuuSLg6nVfPoehrgslwHuDqM2687DkgjAb3k?=
 =?us-ascii?Q?uP9IvUPAnPWFDgwht2B4LeBE3bMXPtUIohdLgC+BoBU4lTGpkI6QFTwqPO3l?=
 =?us-ascii?Q?cRmq9XfFHhZuqKkaFVwLd+/3IQlwoKdKEmrGOrLw+28KCgSNBZ24vWAA6oI1?=
 =?us-ascii?Q?vjbJ3kaopoXwCmzWrMd31hMqRnBwGLY5pavs/ObtgQOL7qKRqvivqe2z87Tn?=
 =?us-ascii?Q?gEZ8nzjLwabVAJd8A0B+PDBgDpLfaFcXgpbo2Kg1r02ZstgGT/FqbZLxqu3d?=
 =?us-ascii?Q?UsA7DsTP0JUdR1ElOWNLdkUSb11KFf2aMStenieLTxlr/H1f4+m2Um45Vhei?=
 =?us-ascii?Q?YEboEFwROJCKa45gmik4Io67o+fHuHjugRdurYoQKab0OQjSR5TnZq+k5Yvx?=
 =?us-ascii?Q?aFpMs0+OhA9HerUUNsiVCy7jYyIAYFpJ33dA1w/aShIgklh2evAinXmpjq9u?=
 =?us-ascii?Q?9kapEiT6NacpIDvR7lKnbVaQwr4089NmuH33u5StXguRPdJq17aVuopZI+E2?=
 =?us-ascii?Q?8W7EUftCjcrP5xBsIDhdf0a6APpivcpXpqQBtnkyl1GRpjYf+fT9dvcAzxZX?=
 =?us-ascii?Q?gv7ReFi1Td9i+ZZAsMzlu13zQNsfQDDPMQFCb/OkgGPO3ayJOmr5+4gltIpN?=
 =?us-ascii?Q?8AUCFhWkZL5ywCJRdFBQCXyX9Ex6f1+7KJVRh8ybu+V9v01tNw6uhF5/9yU+?=
 =?us-ascii?Q?vJ9pjaEHmSDnQJxDFU5Zq9emxECz+wx43kQJxD8v/jwQRGPsp91yo5JZfSSQ?=
 =?us-ascii?Q?V7imd8YdO7kAEEw0/SQ0plDwGkPdJ1rG9QXVQWNfFiWyNE+nC2Ik6jXv1ael?=
 =?us-ascii?Q?nGIGR+fAFW6JXyI89BUlD1dRn1ffyE8x8mV9S1hJdqJSlOki6M4gHJ1xaraV?=
 =?us-ascii?Q?qCfrdRgrtcqCMuDO6aOowdUNgLrAhQf/Ny9oQn601fZZ7OzNOvgYIkqCqkha?=
 =?us-ascii?Q?2jK3SLzW97aB8Qh05ZXysh2b7njaA8zA/IKIzHgbVunp6MYv8Ub0iyIfqRjA?=
 =?us-ascii?Q?PqODy1GwExiBCUG+9fU8ZXoKPZheh069OdKUg+4lpSkC33pX2Tq8rJ3Y1JlU?=
 =?us-ascii?Q?q1Gh0yCG4z4FTir3h4dfZmIJa+Vt4DCMUz7T2j5IlWk6GefmfSsRXE8L8vzl?=
 =?us-ascii?Q?2p3Z3g+640/f+NJB0M8qU7G9TetjoWlE+lTMz/0IpNTBhUg2HGpeI6HVxNfR?=
 =?us-ascii?Q?aNMZfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ttSSDOF0kv6R2MiD5hGfu5GGK/r9K0+H+tnymEBShSz8ur9MmvqL+5+F6ayYJtOd4V+PGXkSRUZzGGIJiXYsTG+GdNZIoTMNpJALfl+sKTN/Fh5FjGYNl12VzZcJ/rjGat3/Fco0eL/d6D6RV57X0GLAv6/cCPebVHEcu7SDgr1nYn0MptafCNru4vnGJzXzRIycC0m0FxmA6viMkuIpJGPUw4V+/XOlylF7kjcbp6NqrYeZtjfLJU+ZI3N+WW0iko0ZSmk1Y9uIqAcW6O+EI9avKW48JtSb1v7jQ0/Sa6DE9t094oPd4xNYNo4EB9x9FCeMc0oikhuyYyeVzU91SOaDo67yESMHYRymSaVYyg9Kuf3DQoUHa1hSgwLTEO01f2RIip3x0aAMwsf3LcIYxmpKJeZduGQ/LE2Ejyyjd2H32WACyjyqRoLZ2/zn4yHL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:24.9011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e8a5d5-5e45-432a-21cf-08de6e16d387
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
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

From: Apurva Nandan <a-nandan@ti.com>

Add common OSPI NAND flash environment configuration that can be
shared across multiple K3 platforms. This consolidates OSPI NAND
boot and flash operation variables into a reusable environment file.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/env/ti/ospi_nand.env | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/env/ti/ospi_nand.env

diff --git a/include/env/ti/ospi_nand.env b/include/env/ti/ospi_nand.env
new file mode 100644
index 00000000000..04a4fb1dbb3
--- /dev/null
+++ b/include/env/ti/ospi_nand.env
@@ -0,0 +1,22 @@
+mtdids=spi-nand0=spi-nand0
+mtdparts=mtdparts=spi-nand0:512k(ospi_nand.tiboot3),2m(ospi_nand.tispl),\
+	4m(ospi_nand.u-boot),256k(ospi_nand.env),256k(ospi_nand.env.backup),\
+	98048k@32m(ospi_nand.rootfs),256k@130816k(ospi_nand.phypattern)
+ospi_nand_bootpart=ospi_nand.rootfs
+ospi_nand_bootvolume=ubi0:rootfs
+ospi_nand_ubi_init=ubi part ${ospi_nand_bootpart}; ubifsmount ${ospi_nand_bootvolume};
+args_ospi_nand=setenv bootargs console=${console}
+	${optargs} ubi.mtd=${ospi_nand_bootpart}
+	root=${ospi_nand_bootvolume} rootfstype=ubifs
+init_ospi_nand=run args_all args_ospi_nand ospi_nand_ubi_init
+get_fdt_ospi_nand=ubifsload ${fdtaddr} ${bootdir}/dtb/${fdtfile};
+get_overlay_ospi_nand=
+        fdt address ${fdtaddr}
+        fdt resize 0x100000;
+        for overlay in $name_overlays;
+        do;
+        ubifsload ${dtboaddr} ${bootdir}/dtb/${overlay} &&
+        fdt apply ${dtboaddr};
+        done;
+get_kern_ospi_nand=ubifsload ${loadaddr} ${bootdir}/${name_kern}
+get_fit_ospi_nand=ubifsload ${addr_fit} ${bootdir}/${name_fit}
-- 
2.34.1

