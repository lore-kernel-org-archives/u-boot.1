Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C20BD6B6AD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FAB189234;
	Wed, 30 Oct 2024 17:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="ULXPrRry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A39489234; Wed, 30 Oct 2024 17:48:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250A389206
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQpNEpDebSOISC108OHxo/IcP7DDPLl5SxL6zMHrVZNLWOEizPbk5k35tNDtXnuQgR+ErAJQGOL9zMyF4xyLijA9KoI7XGMeuMFsBrGwFVDuEdpwKdWHUUmh31GjC6zTI4UhNrzsFkHA5eZ8ffbAgXF3TIzIg7LtyXlWitqSMUmm68jrfseg/+hnypdpdJmizYi9EcTPp/09/Vsjs+k54uDgoyE7BwmxmV9cpzGxg6IoE2TJxwsvqwn1vdyjLjcyEviC78fpDawmJYE0Cd8GGQ9yy0P6e3v13I94QwCmLXc4Y6lCNmmQpCE1kS0VwJiFLVkEMXAXfkxDKuvKcwSZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggcPn6sbY8xvw6hSGU48NLVLmTPnmL0qyXC6sz+PaPQ=;
 b=QbzYZ7xYVfsrsWO31vUxX4GXpPvF9/qUJ2W8jMb363RiGLeBO7P0P83jof6eWtzHB7EYcGLwtviHpTCwTXbxyPSbi38wHy3K0+JY1Z4UmbVNlEk1ajCjTNrVYU17pltmC1FTZLcj0TLUmwt5sFA9Cg9U4viyjtQHYZZ1n9CT1Vuy0PibTt6PdwuJi3FkyWS3KEB16UDEKKok5PkWkF03vWHXEF0R0disQDTvwvPFn9UzpGc7R5W+GfVBRe7BydJsxBfF30tyHXItVldtHO7dwit2wwzjsqezsOyNDQa03KbpcDkgAaG5M+9PQ4RVKBeNmNcmIN6jtd/+6r9O6FRtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggcPn6sbY8xvw6hSGU48NLVLmTPnmL0qyXC6sz+PaPQ=;
 b=ULXPrRryP8d1PU7rYZBG+P5VBbqTThmh5rZJMDdbaIvaXm4ogwtgUpo29DoBm77HTqrlABdxaiHVT1axQweYgop7/4g34wmpsyQIPaPxahc2iQvgPi8Pi8+UManQrnzCzrk/upgCKRsABwoVViQdIAVsVEb/dLDnZsUCNVg7A/Y=
Received: from AM0PR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::14) by AS1P195MB1517.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:48:33 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::c2) by AM0PR01CA0109.outlook.office365.com
 (2603:10a6:208:168::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 16:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 16:48:32 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:28 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 30 Oct
 2024 17:48:28 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <n-francis@ti.com>, <afd@ti.com>, <d-gole@ti.co>,
 <sjg@chromium.org>
CC: <d.schultz@phytec.de>, <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 6/6] board: phytec: common: k3: Apply SoM-specific overlays to
 OS device tree
Date: Wed, 30 Oct 2024 17:48:15 +0100
Message-ID: <20241030164815.1763506-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030164815.1763506-1-w.egorov@phytec.de>
References: <20241030164815.1763506-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|AS1P195MB1517:EE_
X-MS-Office365-Filtering-Correlation-Id: e47c69db-d57a-41b5-8a7d-08dcf902b0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cjqhKfxfWP5mOwD4smiof3rPmFD/oFY2J8trTR0ID6/i/JEveTzPXC9BW58+?=
 =?us-ascii?Q?RAdZRq5cHE6MiwwBzkdPuyZrTl9P5PhxnwAwPXJ1dNu+QkmXcOkBTveEN5t1?=
 =?us-ascii?Q?0zxAh8xK06+9T+uCe1vo3dRxk+O8v/xQvJIskPEtiGmlMJPC+LyswBxMjK94?=
 =?us-ascii?Q?yv5ESp5m8djTJHN3rg8Is8jRk5OFT11Ap3xHmrHENYygYKJrGqIS1LTwiyjS?=
 =?us-ascii?Q?mv8jgaUkT0j0W+bhccKP8Spmw5n+hUbQR92NgWm7oU6soY8izsUhubRM0NE6?=
 =?us-ascii?Q?EYky/2Oo/m//BTm3TiNhhbW0NcvYJ+ORbLodgf8TabMz72uSKEeOjE6z+E8U?=
 =?us-ascii?Q?XPevJjmADQ/EzB9KrrGCLJARwWzZ8uypKEEXE2pw9kUuzcQNWbvIwpTkM3Av?=
 =?us-ascii?Q?3B8cCR+TSGBVkDGjMaWcdQVTShG/TmtJLTrYjoEDXverIUXE55+xf4qQIEPT?=
 =?us-ascii?Q?PelBszpAEp17iGOrrzngi9rKIJ5UcEnvABA1smwe5/VHqBhvUdgHVTHgfbEF?=
 =?us-ascii?Q?urrViXr1MPxE0RJJCv0fTm1dejVLSGQ9BdTH9FaTwlZslREfz4Sz3fgD2RTe?=
 =?us-ascii?Q?3q8FpgEiQVc2Cq7GMPX6nwBUwfOvy3Ykx8l1AFW9cOB9KosGKnvFC2BP5l4w?=
 =?us-ascii?Q?Aa8NglEeDgbS49jy3qbNT16HQCNDZhCn1bEAvaUYI3a8xV+iQood5X8wkNfC?=
 =?us-ascii?Q?XCw7gw5BNc2fM7skrosgMGxdU6vMzy139d9qcGQS3qGjjyrCd7LRC7jb8JBz?=
 =?us-ascii?Q?D8wB8pIE7MJrdAL7/WJ2W6pT/lES489q1wFbtEAL4ysGlPyrzpOldWwV3fhJ?=
 =?us-ascii?Q?uvaolvLNJ67K13bSjFIsBVVAbdJP3AQpHp5/eq463hqH+FXTAzalUgsv85a6?=
 =?us-ascii?Q?dK+r/DwfbBtY5+NHupG8rry8kn02ua1P8AErZ5584HJMY881tXV604qpwuPQ?=
 =?us-ascii?Q?INsarSW2HtKXTnXMRP+ttOJbv+7CIV6JDEKgxkkWCJDr7lDOPZXXxutS9KjX?=
 =?us-ascii?Q?e9NZHDnJ2+/b+bCcnr9uDwZrqcYHvgjAmN5X7vjz01fX6525HgZ2oZ60FiUK?=
 =?us-ascii?Q?uIbNJNGWJkVKond/Zda+8qc/rKMBF4XtWfe7GeYN2mn6YjcFtr0eKpUr+JHL?=
 =?us-ascii?Q?6QYMRJWE7qdQ2yBqP4Jo81kMymr2ByrdvtgW3QddMJCwpi8Ao7kx++xtyIm4?=
 =?us-ascii?Q?ecnzbioRyPDnsBgp1IpDYQn6sJcRAcZ15ou0uaBxlPGrdQlCA+nmtKI/r+SV?=
 =?us-ascii?Q?3DHCIYziMvgaB1TckytDu/s8ZhErMx9zJlege3QThsOqihu1El8Q4vxRO6e0?=
 =?us-ascii?Q?f5kuTIla9Tbbq/64tv3IMpkXWrf9xt1XAqSAhQg0FFZWjbibLHH3uO/rYB35?=
 =?us-ascii?Q?Y16CplSn6jKGNR8EDU+/INNe+CdRYQceoKQ+eM3sPORJfyUGaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:48:32.9852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c69db-d57a-41b5-8a7d-08dcf902b0bc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1517
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

Our SoMs are available in multiple configurations, managed via device
tree overlays. To determine the specific variant in use, we read the
EEPROM and apply the appropriate overlays during boot to the device tree
used by the OS.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/k3/board.c | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 3d7e090ccaa..346b2b6491a 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -6,7 +6,9 @@
 
 #include <env_internal.h>
 #include <fdt_support.h>
+#include <dm/ofnode.h>
 #include <spl.h>
+#include <malloc.h>
 #include <asm/arch/hardware.h>
 
 #include "../am6_som_detection.h"
@@ -97,8 +99,79 @@ int board_late_init(void)
 #endif
 
 #if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+static int fdt_apply_overlay_from_fit(const char *overlay_path, void *fdt)
+{
+	u64 loadaddr;
+	ofnode node;
+	int ret;
+
+	node = ofnode_path(overlay_path);
+	if (!ofnode_valid(node))
+		return -FDT_ERR_NOTFOUND;
+
+	ret = ofnode_read_u64(node, "load", &loadaddr);
+	if (ret)
+		return ret;
+
+	return fdt_overlay_apply_verbose(fdt, (void *)loadaddr);
+}
+
+static void fdt_apply_som_overlays(void *blob)
+{
+	void *fdt_copy;
+	u32 fdt_size;
+	struct phytec_eeprom_data data;
+	int err;
+
+	fdt_size = fdt_totalsize(blob);
+	fdt_copy = malloc(fdt_size);
+	if (!fdt_copy)
+		goto fixup_error;
+
+	memcpy(fdt_copy, blob, fdt_size);
+
+	err = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (err)
+		goto fixup_error;
+
+	if (phytec_get_am6_rtc(&data) == 0) {
+		err = fdt_apply_overlay_from_fit("/fit-images/som-no-rtc", fdt_copy);
+		if (err)
+			goto fixup_error;
+	}
+
+	if (phytec_get_am6_spi(&data) == PHYTEC_EEPROM_VALUE_X) {
+		err = fdt_apply_overlay_from_fit("/fit-images/som-no-spi", fdt_copy);
+		if (err)
+			goto fixup_error;
+	}
+
+	if (phytec_get_am6_eth(&data) == 0) {
+		err = fdt_apply_overlay_from_fit("/fit-images/som-no-eth", fdt_copy);
+		if (err)
+			goto fixup_error;
+	}
+
+	if (phytec_am6_is_qspi(&data)) {
+		err = fdt_apply_overlay_from_fit("/fit-images/som-qspi-nor", fdt_copy);
+		if (err)
+			goto fixup_error;
+	}
+
+	memcpy(blob, fdt_copy, fdt_size);
+
+cleanup:
+	free(fdt_copy);
+	return;
+
+fixup_error:
+	pr_err("Failed to apply SoM overlays\n");
+	goto cleanup;
+}
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
+	fdt_apply_som_overlays(blob);
 	fdt_copy_fixed_partitions(blob);
 
 	return 0;
-- 
2.34.1

