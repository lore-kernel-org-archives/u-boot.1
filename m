Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DBECCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 10:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5570683A3D;
	Wed,  5 Nov 2025 11:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TqMGxDww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2B783A47; Wed,  5 Nov 2025 11:23:31 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BFF83A28
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 11:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhoWG7FSsdcmRyJpMY90h8oVZpUBsyo3zvEYakGvUsmfxP2VMpMB/FXBXwt4dQb+kGYe9sqgiMIYlaQ+okU8qos3ExxgB4riMs/T4xy36qLw8WIAA6ltWnOl7LhfkeAXLrSveerdS1Ti08eRbwBFexQkV6ZxJRkVsKbSyADVpOWKGXD0jmXv2HOqPnyZc7LfWEMP5U2qYjHzUuhlKrL280qUz7Gj/QXUU5OhwPsyxPNdvC+f0Vkjdj4yyQEJ1lYZbXsadCNSqob9Ojfugy1FJ42BSrfx0JLgwgkZ2K+28zgopCZ3Y5qbHLodhzKcHZykyPZpx/cWSrXZ0oZhnKHlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0f010tmGTIngbXKXhiaHLs8XU68rN7h4k7XWr4Z2FOY=;
 b=FoY3sOJ6gAnecxd0vQwDdz4cS1YDlqCmW7/gznTmFoUyBE4ly8kbNu+OYV7V0XvYW92LnfEA+OmqfRYq3KvZUE88wEFweck93kTW0a6e1ZSmT83GLMUwD92ZjmDt7hF2vKyeJAcL4S1l6N8Qa0vwRv11V1fPERtzr1MXbvlwHZxk+zAv+XgCLAjMMwIrMuS1mjU4q4AdBS67yoHVn8wNRPCTwAab6kq2P87Ha+IYH41o+Wks4X1xEJMT2AwGTnHIBIG//XNPH1WXuUBNFL7J0MCWa3VtRhE7WHNxtOt4OF5HYSqk0wQ6pbRSQblJGW2cvls8jWY2tlwTbVNK3QYyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=disroot.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f010tmGTIngbXKXhiaHLs8XU68rN7h4k7XWr4Z2FOY=;
 b=TqMGxDwwQDmgYafQCqaXleM9z9ulwmpihD7QfKa01YkSBQwGqRSKW+dky0mxLRzSOJGzLR7yGO53AgDZFNoqmiathHFcM6ODETGAs5FQAxw2SPkOXa7vlFACkjkRxewaBFzVrAOkE71QT1MyzkcqCmblx1fxnu2tbNz7vNmntW0=
Received: from CH2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:610:38::38)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 10:23:25 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::5e) by CH2PR05CA0061.outlook.office365.com
 (2603:10b6:610:38::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 10:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 10:23:23 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:23:20 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:23:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 04:23:20 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5ANH5O3558154;
 Wed, 5 Nov 2025 04:23:17 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>
CC: <bb@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>, <ziyao@disroot.org>, <n-francis@ti.com>
Subject: [PATCH] kconfig: Add support for out-of-tree config fragment and
 defconfig
Date: Wed, 5 Nov 2025 15:53:16 +0530
Message-ID: <20251105102316.1713954-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: d0829962-c915-45e8-2824-08de1c5559d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bWUTZtdkFdT7y0+dbW5Ylv24XbF8+M0NTErNSnotHZvOEY6r2GzSX6sFARiF?=
 =?us-ascii?Q?YjPiELFU1v6KeRmRnUeh40POwkg7ABUqKOYh2dL+ySdUUq/oOljPMSqlQAGb?=
 =?us-ascii?Q?FMLsm1edQ8/5Z6dGo4Gpx8wVY8Y4AjK+BME90TWKjU0Wl1ygCne3lbCxiSnx?=
 =?us-ascii?Q?Fhg+sOF8/ui2w2oMeT0ZrhexMvYIcfGRxMSIl35pcBqPrw9vQjMWyytzqaSW?=
 =?us-ascii?Q?Qmt54rLZ/ZfcWoZm+If6tYU5EwEzGciUJ7Y6HGkuaTP/iZjnKEYFO6ShXMA1?=
 =?us-ascii?Q?YUZ6+Esx2B2yw1avHIUkgCaW94odNhsCN6/C+kLkcLBc8dC15Q/8GofcVGKD?=
 =?us-ascii?Q?2HNqFdXLs0vCqMQnGT5DhkMJ9CNrW6A2uUh0kOkn9s4gaSfeEXvMOi9mO9hX?=
 =?us-ascii?Q?2Uko5AXlmoS1Yw2oOSOuE5AvLuUAj1XuUwppFXykMPNxmQT+vg1gXOiXxuu/?=
 =?us-ascii?Q?04OBLJ4+Es7MxhdhbtSf9bF/ln1tes1nc7T9uUWeJX/jpOwxlguzM1n17+52?=
 =?us-ascii?Q?Ejk7CE0KeU/RomooHUVxzPuo9maRnE/bvbYQEpQJ5tOmzuHl7q0tBmYQPD98?=
 =?us-ascii?Q?SMA+s7yzBJPTzfol7tI0z28RPu210zQe53JW1bIIXLueQLfjqp1vVgJSWAmV?=
 =?us-ascii?Q?z/dc+8x9HyjTtrmU/T6HjxI9jf0BdLy7aD9SGnM3vmuIfQ0gIX7gSpa4erMr?=
 =?us-ascii?Q?0V32PVHS5A4XrbblG/o5qr+/qdZ5BnoP9OpG3oCEM5A9AjRnZiw2wHhAFyW8?=
 =?us-ascii?Q?AT6avxVe2XSmewjN14vQ0zNdkiraXj3utv+FFavbdCI2wwEQ7yuf98tMnntG?=
 =?us-ascii?Q?XbE7LYodJcd6ql2Ws7Ovwy5Ey2JIsUw4KHR98jhFAmmUMT62479Fk2o3Mufy?=
 =?us-ascii?Q?Rh7X1tcuRemmZvv6uPMm2SiETxN85m7Iv7BXCQZwabedMhyVHPy8QVsArVYI?=
 =?us-ascii?Q?2ODbRSTs25he4DgFDrIcrmL9LQYKUPEYAKSMRkQrDnCIaXMyVHoS5VteODJ+?=
 =?us-ascii?Q?8Gx7O9pRh0JBGfr2/TfiS6AGUyAANJEcrg+Y1gC4s80gdtxAj5/Ja7/WOYDk?=
 =?us-ascii?Q?hgj7sLkbYlnSOJRku8x8CQZJUE8XDuVRpUjdUbspozqumXtidsUf8TGI3/tt?=
 =?us-ascii?Q?xEOKN9bIriz88qujUG2V2qaJhAjZkySIyt8uH4rtOqY/suov+u8kTzDEBcP1?=
 =?us-ascii?Q?QutiA/r3lnWq2rbbz5mFpmDUKvdt9tNZql3nbsF1f5Aa7ChT0L80IS7KEDfa?=
 =?us-ascii?Q?OJnBdLrLvxWBLw8XyovOjA71E2pwqah+ksVfqjvuyYxsYIxPfSiR7ZH1HvZH?=
 =?us-ascii?Q?wpkBEOk4H6N16Yd5XEFhFKsWo8nUXWxGBc1AK0mBjT+qzmp04m/KY2YFX+xs?=
 =?us-ascii?Q?J/tsGMVzgI05pv664klQRVdtDgKDjVEn8SB90qoG+uvChQCcGtBBo3hB+8MV?=
 =?us-ascii?Q?BghMkVY2EDoHHnDtcneDMD53Gc0cmKrCCdzHpTu5J2RyaLCtHPPmoDe4Yyoa?=
 =?us-ascii?Q?rFT0O5dPTyh8eLR/un+VoYyrfW4he1Ns4NbFnSFmFThTyrACklzeIzIrpgRW?=
 =?us-ascii?Q?ciFZq86V4VNcWuGzU5s=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:23:23.7093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0829962-c915-45e8-2824-08de1c5559d0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
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

Add support for fetching config fragments and defconfigs out-of-tree using
CONFIG_FRAGMENT_PATH and CONFIG_DEFCONFIG_PATH respectively.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 scripts/kconfig/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index f0f93c56bdb..051c801eadb 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -12,6 +12,13 @@ PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig \
 #  Set SRCARCH to .. fake this Makefile.
 SRCARCH := ..
 
+# If a config fragment file is kept in an out-of-tree path, add it to the list
+# of paths to be searched within
+CONFIG_FRAGMENT_PATH ?= $(srctree)/arch/$(SRCARCH)/configs
+
+# If a defconfig file is kept in an out-of-tree path, pick it from there
+CONFIG_DEFCONFIG_PATH ?= $(srctree)/arch/$(SRCARCH)/configs
+
 ifdef KBUILD_KCONFIG
 Kconfig := $(KBUILD_KCONFIG)
 else
@@ -93,7 +100,7 @@ endif
 endif
 
 %_defconfig: $(obj)/conf
-	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(CONFIG_DEFCONFIG_PATH)/$@ -o generated_defconfig
 	$(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
 	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
 
@@ -103,6 +110,7 @@ endif
 
 configfiles=$(wildcard $(srctree)/kernel/configs/$@ \
 		$(srctree)/arch/$(SRCARCH)/configs/$@ \
+		$(CONFIG_FRAGMENT_PATH)/$@ \
 		$(shell find $(srctree)/board -name "$@"))
 
 %.config: $(obj)/conf
-- 
2.34.1

