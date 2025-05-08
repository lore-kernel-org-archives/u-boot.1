Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A7C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0FC82B16;
	Thu,  8 May 2025 17:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GBNAde8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CBB828A2; Thu,  8 May 2025 17:16:06 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C06829CD
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK/Tyz5HK+wYAUFkd5upO1zB9JrUT4hf7ztUtR1MBOzU6k2Sk/m6okV0psuMZ4PHbKIDgauJrU0/0a2opqCiiKwFuHxsy4foJjqCqCaWFok8LSj9bj49BDGzVstFfh7HOakeACxukk2A9HAQ69oeYfxZKKgs0RIVuv70rfsdfKjXUrfk/TazuIdqLmYNchhwetBzpUn7jcjuMkaYmXbShvRXckuHj2+a3rwFKZDi1L5qK7zlYh5zOCadwvLVvtXhItXBKyB6eYktHrCXGBKLWS48xaY4Kpiw6vRY3GoTnxNntk0dmKgV/d3375ShY6JVKYIDa0b14vXdOoSvK69vyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oBBymdRbctHJO19A38MakGn7QCcm840rxDE4DUhoEQ=;
 b=Q9RlZbGEPQ/jOUHanDflPqPAqMUCvh+Z4DxVevfZmtoaOuwnO88tZqg0aeMo1MTPYpCaIYwA39CX3SlDUZHzPrEeqQ5EDCoxbNnIi7qGOsCXQDx8ZsBBoBIlICYWF57gilXzF+lGvHYlvH1q1BFafvATivifq79ADrXVH5o+z4O8Xg53oiq67UDzC2gxdddzYQ89ssWpBUv3VQJYpfXTWNj9s6Em+uyOPtLoIo/yILMnjW6wwNXGVhkuaNXNIS8Dq14vtNRbP77A5/taPYxsUP4d1yHqNJ8cpsyr8IGaZ1MdazzBRV8bP8c1HIIb1sRseJEk4e3PgAzA8HmWlbZb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oBBymdRbctHJO19A38MakGn7QCcm840rxDE4DUhoEQ=;
 b=GBNAde8opQiRLfu+soEbnYDpu/mrBYuXvumWlLDLqF0EuccU3KH4sh53ZjebKp611rkIsJLqpqnq5s9/KlB2kVaMO22Mqo+CvNEuGUhse+fZswJRNGKGVTLt3zPLlahP1mzCagfiTvsLYSpuC9CW/nKPU6tXUniw4T5IdmDkkvScHmXOT9hr6/TQ9jts1I3Pp54Z+PYqXyr7R1MWhWjXLmY91yu/hcdQpfZZGooXL2JstM4MpuymleryQ92EHGYPu4tiB1cpBYWHKY/9vDYmXq8GiibAsM2GBjyioGza7MzSL7GQ0LVzCSIQkSMOfilGu4z+vni2fK/cGvJxx4wPEQ==
Received: from DB9PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:10:1db::8)
 by PAXP195MB1229.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 15:15:59 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::cf) by DB9PR06CA0003.outlook.office365.com
 (2603:10a6:10:1db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 15:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:58 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 5/7] board: phytec: common: k3: Update boot_targets at
 runtime
Date: Thu, 8 May 2025 17:15:46 +0200
Message-ID: <20250508151548.162122-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|PAXP195MB1229:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb5cd01-a236-452a-bf1a-08dd8e433cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckIxSVQ4cE94UFJja3ZWWjRsamI5Nmt1aWNoaHdhelVBS0MwL0RDK2RoM3hv?=
 =?utf-8?B?TFpCQmZ1djlrdThsVVRzSXZMRk9lMEtBdHhXWER0ZnlXQmFSWXM1T0ZqZ3dt?=
 =?utf-8?B?NnIweWVFbE9hUEErbGk2YmpKU2NWUFVEcHk5dDltM2FwMmNCTWtvVkFZbGNN?=
 =?utf-8?B?S1VLbXY0TDMxTkxnS2YvOXo0NHNrYjBUWmRrckhNQ296ZmRxV3RPQldRM0tx?=
 =?utf-8?B?NWx2MlVaanpZMUlJQ1Vjb3Z6NEl4S3JTWTFOcmtXckhMSGpiNkxZc2RnSjdE?=
 =?utf-8?B?anFHdUV0ZkJMYTkwMG8raG1Lemc0Z0RBOEJITkkwbWdsRkNOQXlXQlVwTHNZ?=
 =?utf-8?B?MHluV0ZvQWJuekJERGplb25zNHNKNjJpRTJjdlc4V0dsSVk5K3kxRlJLQTZK?=
 =?utf-8?B?ZjVqYW8xeDd5ZGdnaDN0aHc0c0hmVEtqcE1CTUEvUEJrVlZjcnI5N1JnOXNs?=
 =?utf-8?B?a0lTeW5iUTVZT3ZkZjhkUjIvU08ySHQyampGclBpRkFjeUd2QjB0dnQ0R3dF?=
 =?utf-8?B?bWh1blhTRXpMeEttNE9KY0tDRi9pSDJjZ3A3a3lzT3AvZklRRUlPNDJCdUhF?=
 =?utf-8?B?WVNqTFFXRmJycjJ0MUUyeVY2MFdqOGVGeUdKbXVQVDJCYkUxMEZoSWdpZ0xV?=
 =?utf-8?B?WFRSOUt5YjJZck5LNFpVQWlVTXJweTJqRjZ2UHRmWG5iWW5EKzZlRU5YUlNE?=
 =?utf-8?B?TkpER0lsSFJLWkxBV2xsc096b2xmRmRWZlNqRDRIM2NJQTE4QnAwMXdjc2RE?=
 =?utf-8?B?MTNUUjJscTB0TEhkM3FJVUpYa08wWmdCM2JERVBhanR6eXhjREZRL3ZxUWd2?=
 =?utf-8?B?Qm5qQUxqM0dqbUhQeW1QZWRRbEZMd3BkUFBNejR1bVN2ditDOE1xSzNFcno1?=
 =?utf-8?B?L2VKZlg4VmtwYXFJMXJIakU1UncyNjhqd01ML296c1RBWU1oaGtzK21jZXc4?=
 =?utf-8?B?N2NuSE1uWnFyVFI5OUEvd0F5ZnlyS2RqZW45V0RBTGo1KzRrdGxjWlNLbmlT?=
 =?utf-8?B?OW5tL2JVM20xNERBL3p0amsvUTJzVzRoZE1lZHVoRVNQc2hxaTYwOVM3blRY?=
 =?utf-8?B?RUlnL0VOVk1pVU5Cdy9MVGVFSTZLdGtWU1NZbCtjeXI3allxaGxLdWdLK25s?=
 =?utf-8?B?U2NvWXZtZ0R5dFhFbmIzTkhVZ052eGxINmRVakE2c3dLc1owRkdYOFkrbG9H?=
 =?utf-8?B?MHRKNjZsblFHWHpEaWwvaDRTVjBLRSs4UmxRYXJPeDVxUmxqSDZLNmRFaWVF?=
 =?utf-8?B?L3NaSHQzUlY0cHV0cml5N1hrUXZyUUlEY1JxTVkyeE1YUDBJWEcxV21YWkhE?=
 =?utf-8?B?NTZLN2JKMm9ER05ZZUtlakdWVGp6b01semVVNGJmUnBuWmxTN0xVTThSWktS?=
 =?utf-8?B?ZDdZOUNsbk9ybmJSUHdnbVlScFh6Y29RM01lRGRVRWhTazgxOEFWS0txNkFZ?=
 =?utf-8?B?MnloR3BkZU84d0kxTWF6cWVWdS96Z2Y3akQ3cWVYQjhMYkxyNUdhWFFoOG1O?=
 =?utf-8?B?b1ByNmZQR1llci9mZTJTVVpadTVuSlY0TjNzekxoSzFKSS9zd0ZxRFVTMkQz?=
 =?utf-8?B?UGlxb3VpWXltS2xMMGhIdmpCK2g3ZHlMZmdBVlVVV0ZGRDBPMUhFTmVsd1Bx?=
 =?utf-8?B?UzFqZW1OWWwya0NTUHJadUsvU2Zlc0IxZWhpeTEzUkI2dlJ3SG1iSlpIOFU2?=
 =?utf-8?B?SXRIQWc4ZVBqMDRXRXRlNFRSRmNFU1NmcnlnbG16YlZkR2NZUjVxVE94SnZv?=
 =?utf-8?B?THcyNUZVZFhUdjRyUHhNKzZQWWgwSmUyZnE2MHZxQ2I2dzYrSGxZOWgwZEp2?=
 =?utf-8?B?UzJnT0F5NUh3MU5tL1c5a1MzQkQvTURZNmZnQU5zeGdKNmo5RnBxbndsa1p4?=
 =?utf-8?B?NGwzcmpXNWxZT2NZdXZNQmxZMDNMTUJJaEFtYXF5NDhCYjhBSW0vdk1VcFNu?=
 =?utf-8?B?OW1CYlYxSW4wcm50Y2lOYzBWYm1qRE41NWo0VDh2MnFWdkY5bkFodDJRQ3NN?=
 =?utf-8?B?bVB6MXlHVDh3PT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:58.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb5cd01-a236-452a-bf1a-08dd8e433cc8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1229
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

Factor out boot device detection from board_late_init() into a new
boot_targets_setup() helper.

Adjust the boot_targets environment variable to favor the device we
just booted from. If boot_targets is still at its default value,
prepend the current boot device to the list; otherwise leave any
user-customized order untouched.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2:
  - Move boot_targets_setup() inside IS_ENABLED(CONFIG_BOARD_LATE_INIT)
    block to fix compile warning on R5 case:
      warning: ‘boot_targets_setup’ defined but not used
---
 board/phytec/common/k3/board.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 828973a8e28..755b9ecd407 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -121,24 +121,37 @@ enum env_location env_get_location(enum env_operation op, int prio)
 }
 
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
-int board_late_init(void)
+/**
+ * Ensure the boot order favors the device we just booted from.
+ * If boot_targets is still at its default value, move the current
+ * boot device to the front of the list. Otherwise, leave any customized
+ * order untouched.
+ */
+static void boot_targets_setup(void)
 {
 	u32 boot_device = get_boot_device();
+	const char *boot_targets = NULL;
+	char boot_targets_default[100];
+	int ret;
 
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
 		env_set_ulong("mmcdev", 0);
 		env_set("boot", "mmc");
+		boot_targets = "mmc0 mmc1 spi_flash dhcp";
 		break;
 	case BOOT_DEVICE_MMC2:
 		env_set_ulong("mmcdev", 1);
 		env_set("boot", "mmc");
+		boot_targets = "mmc1 mmc0 spi_flash dhcp";
 		break;
 	case BOOT_DEVICE_SPI:
 		env_set("boot", "spi");
+		boot_targets = "spi_flash mmc0 mmc1 dhcp";
 		break;
 	case BOOT_DEVICE_ETHERNET:
 		env_set("boot", "net");
+		boot_targets = "dhcp mmc0 mmc1 spi_flash";
 		break;
 	case BOOT_DEVICE_UART:
 		env_set("boot", "uart");
@@ -148,6 +161,25 @@ int board_late_init(void)
 		break;
 	};
 
+	if (!boot_targets)
+		return;
+
+	ret = env_get_default_into("boot_targets", boot_targets_default, sizeof(boot_targets_default));
+	if (ret < 0)
+		boot_targets_default[0] = '\0';
+
+	if (strcmp(boot_targets_default, env_get("boot_targets"))) {
+		debug("boot_targets not default, don't change it\n");
+		return;
+	}
+
+	env_set("boot_targets", boot_targets);
+}
+
+int board_late_init(void)
+{
+	boot_targets_setup();
+
 	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
 		struct phytec_api3_element *block_element;
 		struct phytec_eeprom_data data;
-- 
2.34.1

