Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DC606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oWdPAz06;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=QT0FJ26y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D483040850;
	Tue, 17 Nov 2026 13:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id blA8XGntFEI0; Tue, 17 Nov 2026 13:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1983640848
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794923525;
	b=IiJSS6pCHZFYI/MLaJCvvt4NpPJJlnespPM9A3XVLZwNMFZFIGar8yzPIzRjjsIsY7AT
	 t4sTQyfMNx+FgbHXB5y5MwBoGvC2a3YN96tobRIl5jcy536en53yC4IFdBZjoutJDPu6U
	 5vwiI30gnVvIle+xG2CnAaabvEFK6/3Ab6bzto9csZCUHA3doaoJgLa7Kkwd/OPTZlHR0
	 oZi3d3n39asdNRc116JzjqL/WAEKbpSMHyfY6OuQ9VVG6y1jO3s7Dv7RHKpTTIHIppuwU
	 qwGeENrmaVpxOx5hD6ZCRfTuosM9MDdcqQ5eGmPxjQibhiVfdA0cnt/R2XGtEJlUGuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794923525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uL24sJsTOjLdWipUPr3JWi8d7kIevmnAINWEXbiI+Rg=;
	b=T5zYy/BpcNavtsQxzOJg3QDJz9YKQaW53hJJKF4NspC+gpgyjpupgrgxQazID7ClfUYn
	 sL1sAXCshEvJwjfOSsrJDqQKdiYuurqMn3GCexqZPHGvInQrtCIYbtSjjUpe7jzXga2XO
	 1vLcMSv0+cklGmu+Hbja3YlvVVfPm5ODP+cI9vI614W6+6pRqZOsdXRfgcs/Vx/oRBUJW
	 PIQTFWtWaLz2ZieuNjeeqOJaZWNNgezU86EiPF8Ys3zXQ2/fMltLMm+iDpTNzcuri8YE/
	 ZUDviHUfodxI1Y8QGIKVA/aHIxqNRDAfls+6e7d5/SWiF9M9q/WaTnf8qhiSFxY8Lbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794923525;
	bh=uL24sJsTOjLdWipUPr3JWi8d7kIevmnAINWEXbiI+Rg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWdPAz06zUh+7NFx72QdYLC/eHiXtP0I9x9m3yM2wzR0dGxIOm9/2j0w0bbxZiPRx
	 CaEBaQiDkhJIdtXPigG2nYrMpqSOojHF7oXacXPnqQk0qeA7wXxWfBibqtoNL9zfcX
	 ElN7Vv3zYjvEaeHJusi7I3s8Gq3L3vD1z0ln79vFpzI+2aLRqf73tFeS5VqM48xdu4
	 o9Cs8X+PwrgEWJc1R51F9CnXvqZnVdQVoC5BWFP78yWjb5BvbnNI58v074Clij1pN0
	 jSjQtMU5t3yT2wPYYDuRMyFIKYNHfiOOPObgX10wnGVauwH+MHew9/wv5ktzgO9em6
	 /IfyXa/rK3hIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1983640848;
	Tue, 17 Nov 2026 13:52:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 288D5105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A87281160
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HCnuQnghbzw9 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 549078113C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=QT0FJ26y
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 549078113C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL24sJsTOjLdWipUPr3JWi8d7kIevmnAINWEXbiI+Rg=;
 b=QT0FJ26yjZJrlNgyLpExsTHuHskCgqoLicO3U7BD0s2CggFRspWQsa1mIrW/aO1cXJ46TCQEds5NEKy+6SyzbPjnDZ1DufWQpRcXD8nMXHlY+GZNBvHcSrA6JMDWPubneuusIJdFTDb42Ll3W5BLJslNKaaEDOeCBhscMU/5zDcrBZUokMeTqjyj7cIYObQHK1LzeuLscmMWfE343ykqYVFVBhbSHm2iyaCV6UvLZ4nq8xHHh/TTAByKMBW4NUOBQJ+NxwymSdds8J8NdNPAkU17fsbNUxz/gHu/MpJ/3loNgyuhwMX1U/HizwdbpSJu7ApQBl7Bpk/IcZFIpBn5QA==
Received: from GV2PEPF0004682C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::334) by AM9P195MB1172.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 13:51:54 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com (2603:10a6:1d8::16a)
 by GV2PEPF0004682C.outlook.office365.com (2603:10a6:158:400::334)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.14 via Frontend Transport; Tue, 17 Nov 2026 13:51:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 13:51:53 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 17 Nov
 2026 14:51:47 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 2/3] arm: mach-k3: Set /chosen/bootsource for the next boot
 stage
Date: Tue, 17 Nov 2026 15:51:23 +0200
Message-ID: <20261117135124.207113-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261117135124.207113-1-w.egorov@phytec.de>
References: <20261117135124.207113-1-w.egorov@phytec.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D2:EE_|AM9P195MB1172:EE_
X-MS-Office365-Filtering-Correlation-Id: 020f3dce-268b-43a6-71d6-08df44b1f045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|18002099003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: LpOkqun4CdCKgbZFu7YOYAl97zDosPVmdVGy9mQsk6xRbdTVmpY6NF3p12Bhtd2yLNIT1XEufjsQ6/QHCt2YU8KP2qvd7aS8MAPpoiO5+C7jXqy43dPxHWSAuJpPQ74dDufMKnRF/Yk4leUdYnioUMeVUSDLEMrdmYDoi53+TpxU9xGhNU5jybFpY1wSB4IX3w/u3gHivMzWOXhE1Cpd1/+3lMcgtBNDc1IUhKPUSzDaMs/iNrNE1HGGYLKJsGlJDzUoK8DETcARcJTfj7DQqhT0PetvbrBaH8EyWYtAD2W7w8gUNwKNXtepvRFf82YVVj1cirHgZ6N3aAFd2ya7XsZYmee7PCHlMBuqAI7GkM/ol+Co1aDugLggFeWA9pVg23uPYt/s1RAyq/lweuxmRcK20OURisIT0bMMEToM6WMgPU9sB3mVHU+/7QitMHjBnfVB+rQk2/Z5RYlm7sQJ+6QQjVgXb8YnvpXf8VSc2IrtZ5dnYoM1s82m/xu2G+eCvqZ+xLK3YKM/YuFJimpRiFC3rrm8ump2DFZYvq2IZvrPdli/CZIzg9H3PqEnXM5nGO7y1IQ755nsFS/SS/7LcFct7v2c/a+bh9N2FnzWEJPSYSR7EvURAKx1wZ++j175jkURKVmpHZaGBpFgXKQZMwTvH1Da68U5tcjLgpOoYGAsXMRE0W00ZHaBZYM4nEQ99QheMkVeCu3V6Cv19TOTtg==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261022075727099003)(261022115727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cdpHFWP0s2nSR/bc5LeoZRsXLM0JzCkoOBcOgC4PcdUxvcd3oE2YnGhYKUbZx6kT72e9tTwUzej5ZSa3qrdTJZYBqbR0oHQ+XP7K0ZGNzpk1a5nEBsi7SdAdJyPCbr2B/weiQRM+OCo2P8R1hhl2HJ9PEjhtxozZGjyt7BqCvu7YT5WXqejsJ2xfgY2cMFZflk4om7n4pyjKZ9hQd3XtsHU6fzwdAIg5yrsXsAfvy4ZwWT6Q4j0ijXmotWzBG9oTsJBLF3l30YkjNkb4hx/BdGhCPMTHkP1egTY7Q2wXxm6ejnSyq5kEUXzsF4VFFqOT6WiQbX8RCaTxgaPenth+bF8g7TV0sPKItR4cV6G4MsPWiKPD4Nvje9zaY3VQcp9C57lBblbKXo8ndM/TnDBp7GSgJiQc3k2PddbJoGJlHfSoALdL7vwJn0QlT6abaAGD
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:51:53.9819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f3dce-268b-43a6-71d6-08df44b1f045
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1172
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Call fdt_fixup_bootsource() from spl_perform_arch_fixups() so the next
boot stage knows the device the ROM booted from.

Implement bootsource_get_ofpath() for AM62x by mapping the boot device
from get_boot_device() to its device tree node. For OSPI boot the path
points to the flash chip and not the controller, since the flash node
is what the OS maps to an MTD device. All AM62 boards name it flash@0.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62x/boot.c | 26 ++++++++++++++++++++++++++
 arch/arm/mach-k3/common.c     |  1 +
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index a3a6cda6bdb..db07a550caf 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -2,6 +2,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/am62_spl.h>
+#include <fdt_support.h>
 
 static u32 __get_backup_bootmedia(u32 devstat)
 {
@@ -102,6 +103,31 @@ u32 get_boot_device(void)
 	return bootmedia;
 }
 
+const char *bootsource_get_ofpath(void)
+{
+	switch (get_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+		return "/bus@f0000/mmc@fa10000";
+	case BOOT_DEVICE_MMC2:
+		return "/bus@f0000/mmc@fa00000";
+	case BOOT_DEVICE_SPI:
+		/*
+		 * The flash chip is described by the board device tree. All
+		 * AM62 boards name it flash@0.
+		 */
+		return "/bus@f0000/bus@fc00000/spi@fc40000/flash@0";
+	case BOOT_DEVICE_ETHERNET:
+		return "/bus@f0000/ethernet@8000000/ethernet-ports/port@1";
+	case BOOT_DEVICE_UART:
+		return "/bus@f0000/serial@2800000";
+	case BOOT_DEVICE_USB:
+	case BOOT_DEVICE_DFU:
+		return "/bus@f0000/dwc3-usb@f900000/usb@31000000";
+	}
+
+	return NULL;
+}
+
 const char *get_reset_reason(void)
 {
 	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3b..c7fd7b4f44c 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -570,6 +570,7 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 		return;
 
 	fdt_fixup_reserved(fdt);
+	fdt_fixup_bootsource(fdt);
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
 		k3_falcon_fdt_fixup(fdt);
-- 
2.48.1

