Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED88C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 12:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A2E98384C;
	Tue, 22 Jul 2025 14:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="m9sTR2Qz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCFB8386D; Tue, 22 Jul 2025 14:44:51 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDE28339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOO6clCHcFWD2vTxucOS3TP57biA2po4Nr2l9Bl9MqLYO/USazQVFV1YI0Re1YWE1tSycx+hpgaTMvv4GVXtUZVEioAyZGsOuM/h8jF28YsUDd8SqE8iv0mJGDn0OkzHGqavjLdz3GlQQ3D1Ur/OOq4SiaY7ViJUd6T9G5sq2KnOEVvdHjlBDwBMN4y4msycGG3Zs25BARJ0RrpxpmpgtNSrR+oAhDBjH0oZZ8eC1OoqpIjH+NKQit1Z5h+QTMSQx6aKgu8vyxdoafEgBPeON/owIgs0saEW7snLadxDRxWEV6TWrp8FxaNhoU/6dzQHpHZiQGFb/2wrwLxvUlPMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJjpyTpBye87Zky+72KkO9KpQUMUmNPrAWITQPYDK4E=;
 b=jKb8gZWSvjWOb0T9gW3BZ8J9Z1HVJfBTCr6OKHRXCSRj4fBZayVHxneNWONVA/4Ce8rnwLxi473J/XZKBbBhcwGeqCa7h9VQigpInxC5SbEO8jWxjkaDAkgQcdsi1F1jFjlAieQHhi66RhiYvKid//0JHA1c976SCoYe/6Byz90499YM9JmVKvgEIv+56q5DA5JRXjo5jGYL50QaerPZO95nVAxqLvyY+VaFf28GOoLGtnqRQLJiTsCENC/SbfPoPr9o+Vm4nqyIF3/UnmgU77wropUZ5Il/UJ7AYP71ekvzdyk5i4DlGay/O7t9ZjLftjDwXnzS5B7kuao/mUz6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJjpyTpBye87Zky+72KkO9KpQUMUmNPrAWITQPYDK4E=;
 b=m9sTR2Qzt1pF6CQVz76AmZLS8w7WQkRy8qiSBUWXHlDyN437FChAN15AXmLHoDVkrpFWGCBMA35c8IsjiZ5HERK0BrDEx7KsvZpauqNjVJfWyuAc9jnhkv+aee0E1PUzg3uxK6gcM1UGYsXtHKt+TF3bsYAGLXUtFDAv/WPrMGdoKYD+BDCa3M8j8mVAKpRBjOCWeH7ZRs/rulkZBRUbbRQ0IhuU0TeFgxndhY6tyXdvwcLrHcuKDZdLvl7X6gsBaUqMS057adk8FZX2fsyMkzq8Wf0bT3gu0HICOPJpKMP+Pr3XB2IgUUOD2CLRFQ0LO1T3yUb/wecxuADAU5mYmA==
Received: from AM6PR02CA0017.eurprd02.prod.outlook.com (2603:10a6:20b:6e::30)
 by AM0P195MB0641.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:16e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 12:44:45 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::89) by AM6PR02CA0017.outlook.office365.com
 (2603:10a6:20b:6e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Tue,
 22 Jul 2025 12:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 12:44:45 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 22 Jul
 2025 14:44:44 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 22 Jul
 2025 14:44:44 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 22 Jul 2025 14:44:22 +0200
Subject: [PATCH] board: phytec: migrate imx8mm boards to standard boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250722-phytec-mx8mm-standardboot-v1-1-a389a801eb6f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAKWHf2gC/x3MTQqAIBBA4avErBsoK/q5SrQwnWoWaqiEEd09a
 fkt3nsgkGcKMBUPeLo4sLMZdVmAOqTdCVlng6hEV/X1gOdxR1Jo0mAMhiitll6vzkVUzdg1JEf
 V9gJyf3raOP3veXnfD7rO1qFrAAAA
X-Change-ID: 20250718-phytec-mx8mm-standardboot-c3953ea9c472
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753188284; l=7260;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=yV2kKCfIRyWvgzKtx+85LiBJj1ijmVefCAUwmnoNQGw=;
 b=kbTOAX7rayg6s5CKHQTMp+uPHfQS0oYw3xBebfjBITfkWjk367Y4qO4Ycy0SCGOEVuuhxyhbs
 ZjtArd9MvK9Br2VWTZ7u9qOt+gPygGPH7RSdfdddWha7SIt24vQGFN8
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|AM0P195MB0641:EE_
X-MS-Office365-Filtering-Correlation-Id: 272d40b6-b7cc-4884-cdfc-08ddc91d897e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnppZVRjOE5DeC9COFh5OXNrSTFpSEh6VEdjbE9uZGNHVng4NURnS3N0Q3JK?=
 =?utf-8?B?R3RUSG8zSnNFNTBzdXJjdTgxM1kwMUdhaFJpWVp2czdIalFFWk5GRE5LY0tt?=
 =?utf-8?B?RmVqUUZiYTR1ckkybk8wa2pWT1FpSnFKR3dtc0d2ZVZhc1l5R2s5Q0YwNHc5?=
 =?utf-8?B?WHhCaDV6aWZOT1ZTUGpVTTBmV05JTUIyN0pzZDJNaHBuM1BTRnk5WHY2UVNI?=
 =?utf-8?B?RTEzQjRSdTZYaWhjSDAvT1lwZDFIeElQaU5BbHNQRDlXUUk4Z3hZZmprYW9W?=
 =?utf-8?B?N2hBcXkxK21PSG9IU2hNR3dLZk1NQmppNXh3cnE3QUdDdUh4eHUyOHBLeHlt?=
 =?utf-8?B?VW14TnBTYU9jVU8ySDZsckVYZ3AvTEdmczVIdTVGR1gxajY2VFFaUlRZQ3Jo?=
 =?utf-8?B?bDIxdHdvclZlcngwcTMvVCtlYytnTG9uSVNrbXhqb2ZJWVBSS05OekFMM0ox?=
 =?utf-8?B?enNmM3VvV2dremJaRWp3SFF4c1NsVDZIaklzd0U3V0xJR2NQQ1RDMkgrRWhN?=
 =?utf-8?B?M01FZ0RXaFhVNjNWN1phMHUrajdOWkltOEVZektGNmdhWWlvL1ZicUg3SUlG?=
 =?utf-8?B?eG9RKzJLVUhFb2MzWjNZTlBEbVdTMld0d0pENmxRRDRoRlJDWEVnemVYQTNh?=
 =?utf-8?B?WDQ2eWZrTUNsVE9mQkVxZS9hQUNsdHJIRzFHYmZ2U3N0NVFQbytBZDZuQ3ly?=
 =?utf-8?B?SXBuNWJqMUU0TVZyTXpjeThwaW1KZVFOdzVqRHp5V3AzV1YxdXNKTjdLSmYx?=
 =?utf-8?B?ZjNwNUlqRjUxOUhFM2UrejF0VGpBa24vb1FwYkpmdmlldmJkVHB4a3o5L2wx?=
 =?utf-8?B?TnVMQWRaSGxVTzcxU21WVm55VU1sRnZRcUNYSmxnb1drNldEbXgyQ2JNaE50?=
 =?utf-8?B?K0YvSisweEFCbWNSeHYxYXZOaXNtUWZvQjJodmgxVlVlUHNCT1lucWJJZTZP?=
 =?utf-8?B?alZXa2JoQnJyS2tvenFsSGFuL1lpdytkMHUyVUh0MURUcGVXcVlXRm1zYTlP?=
 =?utf-8?B?ZVo4dXBxV2RGR0xWMHFlYVNWdkxFUUYvbGZ4ZjRGT3NuUFl3NGVSaExuRkh6?=
 =?utf-8?B?Q3F2QUE4Z1pPd0lEaFdUMUZONmY2M0tCdlB2OFBtc3F0dWxKRW5hcm5LY0hx?=
 =?utf-8?B?RFBJRU9qaEF2MzdXWlJLNENqT0VlM0Z2c3lqUnhUSXI3UWJZbkNSMXM2Q1Yz?=
 =?utf-8?B?d1VvKzhjK3M4eWJ6NUhhZlBYYXRIZGR5Y2xWd3lMZlNEbnVQVm14SysrT2NW?=
 =?utf-8?B?U3V3aTMzbWpvRnhSNTdLSGVOWXpsdlU2czc0TnJYMGVBeU1Way91Z1RnNnFS?=
 =?utf-8?B?bXZub05Razl4K2VyOUJlNXJCaHFBa1ptM1Q5S3hDVnAzNW1BRWtNaHZ6aWEz?=
 =?utf-8?B?U0liRUk4d0crb2lVMGMrbHMya2JqUkJ0V0hITnpobVJkQzRWOUU1ejJ6cDNL?=
 =?utf-8?B?eHQ5dnJhOFAybFVDNUlpdTIzallkMkVVeWNWUENmN0FzUmF4UDMwRm5yTDFK?=
 =?utf-8?B?RXhQcFQ0ajA0K2VLTHMyWTNUZmpwSXNsdzdqRnRPeDltT1F1WDJRdjVFRkxE?=
 =?utf-8?B?ZTZaSnZJbDdGdjZDWGJRVDYvdWNRdkVXelR1RWtSVzVRcVN3OU1SZXJMRUlE?=
 =?utf-8?B?QmVtbFM2ZjAvR21KTmVEbE15dXA5TkhGRGdETDlxbXc3THpPS3pIMU5ZMVZq?=
 =?utf-8?B?MkdFaW4xd3B4ZUR6cVpqbWxFZklXbndJTUVhWjVEaUQrSzQxeW5YT3hqclUz?=
 =?utf-8?B?aWJUYnhPVElBckFlSkxiUDlLK1kxdmYrYnlxdjZaSmVDRWxESHJHSEVGUjBB?=
 =?utf-8?B?N1NNY0ZCYmlQNWptUk14VTVEWERBcWNudEpmVmZyQ1hLc1RybGVwY0M2bnBo?=
 =?utf-8?B?TmxSR3I0akdtb0g1U0l1MmZxMk5Sam9vaW9qclNIZHBjRVpNKzUwL1VZVDA2?=
 =?utf-8?B?RmI0Ymk1VmhEbjNtRStDZkIreGM1OW90VStYa2dKU2RMM2RVZjBXTjNia0V3?=
 =?utf-8?B?QUlTK0lmaUM1M29kbU0yZW4vYW9abklpWFEvZ0NBRVdsTWdvdHBQeTF6aDJn?=
 =?utf-8?Q?b1v1oe?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 12:44:45.4087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 272d40b6-b7cc-4884-cdfc-08ddc91d897e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0641
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

remove boot logic from shared env file for phyboard-polis and
phygate-tauri.
Adjust configs for both boards as well.
Space at the beginning of addressable RAM is reserved for space used via
standard boot env variables. CONFIG_SYS_LOAD_ADDR is set to the lowest
address behind the standard boot variables reserved space.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
phyGATE-Tauri and phyBOARD-Polis both have boot logic in the U-Boot
environment. Remove that logic and let the respective distro handle the
boot logic with standard boot.

both boards can boot from mmc devices, ethernet and USB.

With the migration to standard boot, addresses for kernel, dtb etc. changes.
Reserve space for blobs before loadaddr and put OP-TEE at the end of RAM
(for lowest RAM size variant; 1GiB for imx8mm-polis and 2GiB for
imx8mm-tauri).
---
 board/phytec/phycore_imx8mm/phycore_imx8mm.env | 72 ++++----------------------
 configs/imx8mm-phygate-tauri-l_defconfig       | 15 ++----
 configs/phycore-imx8mm_defconfig               | 14 ++---
 3 files changed, 18 insertions(+), 83 deletions(-)

diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index 402d967ab7d58ad206c1b6c03d6f039a77ddef8b..b3f0915432829219e0d6e0d89b1003d789988db4 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,65 +1,15 @@
-#include <env/phytec/rauc.env>
-
-bootcmd=
-	mmc dev ${mmcdev};
-	if mmc rescan; then
-		if test ${doraucboot} = 1; then
-			run raucinit;
-		fi;
-		if run loadimage; then
-			run mmcboot;
-		else
-			run netboot;
-		fi;
-	fi;
-console=ttymxc2,115200
+console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2
-fdt_addr_r=0x48000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
-image=Image
+fdt_addr_r=0x40480000
+fdt_overlay_addr_r=0x404a0000
+kernel_addr_r=0x40a00000
+kernel_comp_addr_r=0x43a00000
+kernel_comp_size=0x1e00000
+pxefile_addr_r=0x45800000
+ramdisk_addr_r=0x45802000
+scriptaddr=0x47600000
+script_offset_f=0x0
+script_size_f=0x2000
 ip_dyn=yes
-loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
-mmcargs=
-	setenv bootargs console=${console}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
-mmcautodetect=yes
-mmcboot=
-	echo Booting from mmc ...;
-	run mmcargs;
-	if run loadfdt; then
-		if test ${dofitboot} = 1; then
-			booti ${loadaddr} - ${fdt_addr_r}
-		else
-			echo WARN: Cannot load the DT;
-		fi;
-	fi;
-mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
-mmcpart=1
-mmcroot=2
-netargs=
-	setenv bootargs console=${console} root=/dev/nfs ip=dhcp
-	nfsroot=${serverip}:${nfsroot},v3,tcp
-netboot=
-	echo Booting from net ...;
-	if test ${ip_dyn} = yes; then
-		setenv get_cmd dhcp;
-	else
-		setenv get_cmd tftp;
-	fi;
-	${get_cmd} ${loadaddr} ${image};
-	run netargs;
-	if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
-		booti ${loadaddr} - ${fdt_addr_r};
-	else
-		echo WARN: Cannot load the DT;
-	fi;
 nfsroot=/srv/nfs
-update_bootimg=
-	mmc dev ${mmcdev};
-	if dhcp ${loadaddr} ${update_filepath}/${update_filename}; then
-		setexpr fw_sz ${filesize} / 0x200;
-		mmc write ${loadaddr} ${update_offset} ${fw_sz};
-	fi;
-update_filename=flash.bin
-update_offset=0x42
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index 7c8a2060b1a8a658eb94e57223775e709d0d848e..7369c0a05ac98315682127f0e96af7d36c4763d2 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -9,7 +9,6 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phygate-tauri-l"
-CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
@@ -20,16 +19,15 @@ CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x47602000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3E0000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadimage; then run mmcboot; else run netboot; fi; fi;"
-CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_DEFAULT_FDT_FILE="imx8mm-phygate-tauri-l"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
@@ -44,7 +42,6 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
@@ -60,15 +57,9 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 96eacec1d2309a20184236f9c84beb1e4cd01f27..4d6bce26f07f7b90e7c3674f4b9ddcac8d775e1d 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phyboard-polis-rdk"
-CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -23,7 +23,7 @@ CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x47602000
 CONFIG_SF_DEFAULT_BUS=3
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3E0000
@@ -31,8 +31,9 @@ CONFIG_PCI=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_DEFAULT_FDT_FILE="imx8mm-phyboard-polis-rdk"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
@@ -48,7 +49,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_WATCHDOG=y
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
@@ -66,15 +66,9 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y

---
base-commit: 2f18139ff221d9a9edd0687517a47aa2280f6c94
change-id: 20250718-phytec-mx8mm-standardboot-c3953ea9c472

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

