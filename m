Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974A0C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673448858C;
	Tue,  6 Aug 2024 14:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQ/NZRyi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDE488599; Tue,  6 Aug 2024 14:08:01 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B86D883FE
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVzcf/CHZNA4ePFu1W/Bv+Xq7mdV56ezuNu+GWQNXiZB7+KSMR1J4/Zsz9ZyGWI3ejr2/q30UkrkBf+EpRBzMjq0A6tq9BWU3ma9foRBvMJXYIlA1loNYAb7P9+6zMgAlS2cXkpXqYp52GJJbtIjWb/8lyBWUcsswZs8ah7idzL12dOhEBBidp3RVnIBrRKeLY1jXasJWWwvDy2/5BOcfbroPvO8BsmcJlqcrI2ePYh1gNpmtj7/SlLozD/WoLhXc+HpkenUmjDJMGvcMkZklBU1FDdip7GBJQ28YbBQRrclaAnw1/+6wz55cRK1nucbSJdA8qpGhgiQN9p5xOdcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmXP2y3Zrlp+P9gF72dlubyQcyJbrtLaYHBxGB/sTnI=;
 b=ZhfIztH6Kl1NfsBOWb+twN/cB/dHg45+TKrBnGB1niw0CN9x/E8aYEmOd+s10SyZfrhLravxX3ZTnzGAn2v8Zfw/6UTY31BofbR9KvVaq8buHmgIuXZXwWhvm4TmmiRXIGyl6r0JRQ9y9FM4E4u6Y5xS1ZZcZrNv0KQBttJ5vFeCPmswG8AX5UtNNI34WY8PBTMO5HOYUP1a8ry7ygFOA9Apkdq7kfzI+8KRQ9VTH5B7iYkvsBmYswL7ASbu+rafuhxfoICgGduVoQuFVIaAewt8B0r4Xd8t4/8GhpQg/fRuc0eUS1Myos0yunZcJWQZUhs7f/MUgN6hrnqXpmu5PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmXP2y3Zrlp+P9gF72dlubyQcyJbrtLaYHBxGB/sTnI=;
 b=bQ/NZRyifWmASNtc6yPrO2jbwSINdy5/A1sDLCJwi3XP9+k/2vJJF975hcTeZj65cwTCS6AinN/VTDQ1JfNCpgF5q/SXDgrsdSOMmKAC/ZWNYGTLzF07zBxY70+KuF9h+akRo4DA5zwUPAm/V7m72XfurdxKHIfWJXUpc0SLaf8=
Received: from CH2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:59::30)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 12:07:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::fe) by CH2PR03CA0020.outlook.office365.com
 (2603:10b6:610:59::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 12:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 12:07:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 07:07:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 07:07:51 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 6 Aug 2024 07:07:49 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH] cmd: sf: prevent overwriting the reserved memory
Date: Tue, 6 Aug 2024 17:37:00 +0530
Message-ID: <20240806120659.686073-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2004442f-7cdb-41fe-38bd-08dcb6106643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+Zk06m0bS6SjBxOoF81sqze8x3cTq4gGpt/96+TMhEW4G7fAqX6qXsoRCpf?=
 =?us-ascii?Q?i3FQSnoWST3bjCzHN+eBGBI7bRdFnQOYFhJp5FQHO/kLVcNfIcFvtZQtcnRv?=
 =?us-ascii?Q?HCzbswM1wTWEXA7aSD5v7kU8AmvHjgsNUPqytBTr2Sna4g/R6PxpXK3ptB4B?=
 =?us-ascii?Q?UF4SU0yQBwx/0U2zCZu37DiqHTF7Ga2MCOLPSn4Cxy/xlU2DyamILfhHQyE8?=
 =?us-ascii?Q?DasCZSlKbXCT7Lt3G4WUuupK4H0mJZLitMYd8TID/FpCEt/h1JCI9GFUD7Px?=
 =?us-ascii?Q?whQxxAEBxGyMiensivhOlpJwWK5Q8RRojaQ8JuRErE6qqrGk7HXaOBvJmHDd?=
 =?us-ascii?Q?KaSuwvy+EigKjhA4EqF3xyv278T2EE+H7Q+qkSM/4PoAhrfZ/lj9TMX1/WXL?=
 =?us-ascii?Q?UNveImDoeseE8ZMqi4CPdKQytH70eV0m7IuDEJHlKAGp2YgE287yeCQ5bv54?=
 =?us-ascii?Q?aUrtahsfTvW7kOvGFOkZICZ8WLHZwwY/WF/nuyI2WXTry7EpoQb3xa5g7OJW?=
 =?us-ascii?Q?hhD/HtSUzGtGGAntZ0f8S7HRkKj/FnDsIXobTbzzzH1RsmPdebT9WmUfm8I4?=
 =?us-ascii?Q?ogs2wWWFGt/dyLe1H8fdmnoDSQk0eJ1AZFUW7FPNiL1XJcqTz0TePr2jfYgr?=
 =?us-ascii?Q?8khqW7SHOJ9ktYJe/mIhrPF5sVa8xiFliloUksv2SIE5eyYm447Por5+xxvW?=
 =?us-ascii?Q?DrVzOxItGuWq/Y646PUgZngAzqqSrFepRCveX2CEp0IrDI1Mf7OwERMB1h3n?=
 =?us-ascii?Q?ARWqwWEEoPWDIe7ZXB6cmKt/CSKRJ5B0claLV2XHhu2rFB53jG50NyMHcoU1?=
 =?us-ascii?Q?GVouO40ofd0KoaWitDMlTEmVmc6GP/sOp3tzdC8M5AQSM5zJCPuzsW4Ug6hU?=
 =?us-ascii?Q?LUGrBUYaV291OoypWOkWUkfInR5JQ41nBZUrET7IFK7Q1kdamCRqnoo7rDCE?=
 =?us-ascii?Q?ddvbcKU/gETa2czT3E7RdR3dvdqi2NpMBuDYGyRGafsFw5SJXSMpXmhkVW1S?=
 =?us-ascii?Q?rXXuvUKgIGEIk4A+xhgLIeY2/L+MeVvTcBwrmuPNj+bVnA4VUYyD3vhR3dNh?=
 =?us-ascii?Q?fIj/nCQFeDeOo0DBKamZGNHnqebMh10HaNg3NSs0sTFKsrz7b5LAoxO0c4cp?=
 =?us-ascii?Q?v2ZoYzmhkwU2NuC/Urm5mlZx9WikUeOtcgvfyGeVocNpG2zhKVw0etFwAP1M?=
 =?us-ascii?Q?UTsHpZkcUb+iznJOdsIvSUDSaUpkdsE//JtCmSyzolScAKf8Vx9PmRu6qG41?=
 =?us-ascii?Q?GiVW00nsV82qhV5Oz+HOn99PhdQ4Ko4IlcvGaUDo7Q3UIYOfF51e0WOZPLvV?=
 =?us-ascii?Q?QFx6c+8Iau0vDNjj32o8+fW8hJAtvgl85ouhQPZTkIq8zdcZPD5T/MdFt9Eo?=
 =?us-ascii?Q?4t4mLf2+nqX+2YEMhAfe5gZQS+jpPLTuHv9UamEHq0wXxK03wsX47WIn/Y/g?=
 =?us-ascii?Q?DeVxkmrHv7/Q/GzXjzknz64ze3GPkjPR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 12:07:53.0087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2004442f-7cdb-41fe-38bd-08dcb6106643
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
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

Added LMB API to prevent SF command from overwriting reserved
memory areas. The current SPI code does not use LMB APIs for
loading data into memory addresses. To resolve this, LMB APIs
were added to check the load address of an SF command and ensure it
does not overwrite reserved memory addresses. Similar checks are
used in TFTP, serial load, and boot code to prevent overwriting
reserved memory.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
UT:
Tested on Versal NET board

Versal NET> sf read 0xf000000 0x0 0x100                                         
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...
                                   
Versal NET> sf read 0x79ea9000 0x 0x100                                         
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...       
                            
Versal NET> sf write 0x79ea9000 0x 0x100                                        
device 0 offset 0x0, size 0x100                                                 
ERROR: trying to overwrite reserved memory...

Versal NET> sf write 0x79eaf000 0x20000 0x100 
device 0 offset 0x20000, size 0x100
ERROR: trying to overwrite reserved memory...

 cmd/sf.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/cmd/sf.c b/cmd/sf.c
index f43a2e08b3..d2ce1af8a0 100644
--- a/cmd/sf.c
+++ b/cmd/sf.c
@@ -10,6 +10,7 @@
 #include <div64.h>
 #include <dm.h>
 #include <log.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <spi.h>
@@ -272,6 +273,35 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
 	return 0;
 }
 
+#ifdef CONFIG_LMB
+static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
+{
+	struct lmb lmb;
+	phys_size_t max_size;
+	ulong end_addr;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+	lmb_dump_all(&lmb);
+
+	max_size = lmb_get_free_size(&lmb, start_addr);
+	if (!max_size) {
+		printf("ERROR: trying to overwrite reserved memory...\n");
+		return CMD_RET_FAILURE;
+	}
+
+	end_addr = start_addr + max_size;
+	if (!end_addr)
+		end_addr = ULONG_MAX;
+
+	if ((start_addr + len) > end_addr) {
+		printf("ERROR: trying to overwrite reserved memory...\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+#endif
+
 static int do_spi_flash_read_write(int argc, char *const argv[])
 {
 	unsigned long addr;
@@ -315,7 +345,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
 		ret = spi_flash_update(flash, offset, len, buf);
 	} else if (strncmp(argv[0], "read", 4) == 0 ||
 			strncmp(argv[0], "write", 5) == 0) {
-		int read;
+		int read, ret;
+
+#ifdef CONFIG_LMB
+		ret = do_spi_read_lmb_check(addr, len);
+		if (ret)
+			return ret;
+#endif
 
 		read = strncmp(argv[0], "read", 4) == 0;
 		if (read)
-- 
2.25.1

