Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CB9FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6379E84255;
	Tue, 28 Apr 2026 10:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="P52fY1e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60331842A2; Tue, 28 Apr 2026 10:30:48 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0484384150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEGQjdRzQ32CCyOkbjq6EDeZNtf4yFhrB27/ydLM731zMjoRqhZ3N1623VKIIP76DIbYSpBhq0JVRR2zgGzwARnvUrN18oJCzYSrG41IIR2ctDVRZN7F6ccbO6xz1jmu8HancYouvxy+YNJIarWo7ausjUIFATcvK711rhcWUZttWTKbWSAfovg5fIJIbjw4vzVSx/0s5bbKjTxCCRyI91m95hTeDeinRPmZ/54q/J6xbiAvYG8RPB62X8rnwubYI6/stUH1rUy3eTMuleD7MkfcW8LXTBvYPK7AnOXNMnacYkTVavNUshyimH35ErMK9C9HF64QhedVcvW+wbBuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lTEZjZrlG2EfyOpOi4E8ix/5dCkrpl6acKPyo6Dqeg=;
 b=KTHU0+kjzLopliDEs2/Cx6lEqUgD6CdyzAsGpIFwuCdmP+ENLx8T3HbDhmH6AYHdWGwfvnCjMnIRmQ456xQKqBqZ6h0+4IMdCSXIIn5fI1kQmCP1UQmD8bGGYb855NtN1XHe3MkvKe2qwmDKUClY+zxXu/S8d4Dbn2ssew4iHmPodE5Th0c3kmHvJDCEk/EPsdmLBNf/CGwqe4T20T6PX41qrK9iFujkeJgAgaUdEkKGtF5qzKfK+P33BW1mgCR2tNqaisexQaVXkF4RlJTpRZQmIG7RyRhsd0pId+uE38rcgyyhxuftExWOYX/Erhq9f2yeykH72oZWdjFksAWcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lTEZjZrlG2EfyOpOi4E8ix/5dCkrpl6acKPyo6Dqeg=;
 b=P52fY1e/+viLKrfSM9FxDugl42e3B6JJl3i76+ySGIDdC2BCyUPCc34h3BAQWOWZGAHKYmxTEEawhmFE1jP6LC47zQsAvNSwCmuVcvsQ4Vi/U0JRoc4LAkkfglfcU8Z9HYbhjjTjX5nQqS1/r2AZEFgrEXoUhajX/L01NhSzuX+eEbCW/W/jbY+p0wj1lbJfXl1zIP6QUwFWiYzc7tM9gBj5wCU5HJLRRwUx3osQOA0OOkTGoFmXjwHcjNdoUfDCHLnoP7DegdxHLJwY9j52KXya+W8S/mjvXwD/VqbzrbiONegDLdXA83rRqZvYjum68hFuPgy1ATJFakfg1B+Suw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by AS5PR04MB9826.eurprd04.prod.outlook.com
 (2603:10a6:20b:673::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:30:42 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:30:42 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 marex@nabladev.com, fedor.ross@ifm.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] imx9: scmi: Support iMX95/94/952 secondary boot
Date: Tue, 28 Apr 2026 16:32:50 +0800
Message-Id: <20260428083250.1802229-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::8) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|AS5PR04MB9826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c79c85b-f098-44b7-9380-08dea5006f85
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ttYJtr2rShfRzBvoQYiNXr0aM1NqRYTqfXeKoODGRAtYM1gf4s+H2dZgVqfnWOFHtfKVegcD+N6aCtgl/yN68sIUkXYsVlAYWY3xESNxn9ShdeIxuS03ivTeIMYx57KZAHOnQFVjFr/Az0mCQwy/VIrPYQ1X4bo8YrNFPkjQSihinHdwA152p6TY+3y3hXN+FxYDXyUyWcHb6xdqH4j34C8CBSB4cBlIYe7+xrBUdYq1Aj3YHoF5HkqesQF+r/nWGtqVX1OYvrbJvo2iUubNhEP4LKq6V0xiiWyCPb6d9rTUiZjYM0oChnXfB3UUI/rnPNdTbOK9R0sODoPBDUR76PB1bXWRfCsa04DOyvFIXFUuxn3DcVUcopFciAottiTqExnBR5tO5kxdjs/LO1Onqw5dkDCsk4opdq3CT6mYXWW/VZhkxoMjeoPw9ZhMndmXhnXOa9g2bRZeAKcueWq71/d5a7QiZTLAlM41P+HDYOu/+y8/BDIt6oYq0P7PLG0w2QlIxy3eoXpgTiEZcMGUjWYwjFYwN01yIwXHgjgvHr21jM/nGMnV/CdMS7MX3+HdtW9q23jJeSoEQVt9NyTk5HIwVm5eitYEc2KOP7TLnzoM4omgU8Np32nILCIWgW9GxnjZQhWukKo4dbGI3zsasq9L1q2waiSPmGPXlIhLT41/XKUdD03EiSDFY0aST93mDwxCjGIdDUiv0/OKLZOY55cE7xfnR2pqeojIp/I7U8PWRmhamiCwIA90SWX002KdPZABRjt39iE3O7PqRvNhZ+QoAavmrV0Mpc6X92bHtUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vt8zi/N+Hm1Iqy9vMu68oL53f92TJDnnNgTJXjGkdwsrD8XtRfuN+LRTsFiU?=
 =?us-ascii?Q?8RmiC52kmE30ia/G+DIKdbYScYMqU0ZPWniaraMukL4u83HAgvfQ1hoRrgYi?=
 =?us-ascii?Q?2AXWMPjO47LU48NgJB2wA7NQcZbbGnee+aqniO81GTz4fE3o/7TRVU3RkVZ6?=
 =?us-ascii?Q?kuWBWSUkQ3aX+kz8x20mkhqtbVY+SM8XnngJaH+gjP83CdoEQ2UCU+Kx2ruX?=
 =?us-ascii?Q?uCjh3/SewSRZy5M1f66BYXtp8cYcQQiiphdcw/EbecnNquB0OLTAzJpp+Rab?=
 =?us-ascii?Q?m0Xupy9UQ1JWmt2p0Dc4xLj7+mVd5iVCBDTTxrXPrYzrZ9XVItPj1Neb+bui?=
 =?us-ascii?Q?kqEYQPnwn+n/5NSGd3ecKl1bBGv2+Tf4DI38Bx95KRpwMHfydgaAYoYCbvh5?=
 =?us-ascii?Q?F2FJloX6VwZuncV0L5prbMrJhtvZb5srcP2RWu8Wk9yLmS7pfyOnqGotppXg?=
 =?us-ascii?Q?4B4VRMt1TmQ05k5Lu0jC6xsI4mZBWxqpvDvSNkxCaofvsS88kbPdWC5YmCzM?=
 =?us-ascii?Q?einDAF/PW3wu+0MvqDlX2lqIp8KhORzWbaBEuuDbO1ZR8WUOoq1xbUCoGcRZ?=
 =?us-ascii?Q?wNkKjDJzGDDzF0HbjRwOkAqwhdkZ6WdLthnyljeOADwHHyWluv6Ec4D5VJZg?=
 =?us-ascii?Q?ros3aJigAosbqRJAQZJzS5zv8P/NxknzMjbXP+DvoMh8fgL8OrN4VR+FTzAN?=
 =?us-ascii?Q?7FDz+rsF5IqMD4ZvvQe7YremuD0VDvyo69VwLF/Q1LHdywFr0a9Uv2jmXnqP?=
 =?us-ascii?Q?ed3U71wUTWSdusg2341XWOmwdOiNBffhF349bz3nqDtKCxyICUVkefBrdPcQ?=
 =?us-ascii?Q?4NPm6adRDI+JyVAqvg0wu5csyI6Q/vvbivaKRt1deJh6chZEBgGPcc/r/6gb?=
 =?us-ascii?Q?rYAdDW1xAovGI8eI31x6qrveTsHuYqlpUOEYxGw3T5IKDTBcHFpMXCB65qqv?=
 =?us-ascii?Q?ml2kHn7PPVdG5O30CLLvJqYIDEIpW3udrrysV3YxNG4ok6xQyeyeJqERlDZ0?=
 =?us-ascii?Q?l6g32tCYglWAya+udC5B8iIbEAWJEr5bIgW6XYrxp8FaCk96qrk5h3IEeXSA?=
 =?us-ascii?Q?6QnZxn8qxGkKkX9EBv6ImtmIO0WcCiTRLLV7cUJEsu+eR/dhx1aqkpJEd6XV?=
 =?us-ascii?Q?rhcIH5/QHzPIUKMn7aSC4V4xTRVnIi08+GiY2s+By9BzHY5IqrsG4MiwG0a7?=
 =?us-ascii?Q?Z0+3TXhZMqKo56Hy9Vt/lGCNdHhmI0rSDJGMo/BgA2aZ5kMARGa/GZLvRkiR?=
 =?us-ascii?Q?tTJ5c5px0BtbjHZ+ch6mZQk1CwuqYAZvn0Lf1tt69r5GRHMBQ4DKjZ10rz9q?=
 =?us-ascii?Q?Zr2gYeyQFohNtjCRQ9xcUmVtT2Fu1vmj6F1Ju/QBPpx6pvikqASdeN+3P24m?=
 =?us-ascii?Q?nk02Fq1DFGM3lurWer2sVWyRYW9seOyVO6O55PmSlftwSqWuegLG7kc/RUkn?=
 =?us-ascii?Q?VwpZfYlp2gPCcxKV2L4hnVzpVl1M+Q9I7o9Hb+3Ss/UeYPBEYwr5AYLG4zr4?=
 =?us-ascii?Q?Gus7YMmxiUafYeA2F4kTnZWYUy4J82gi+Sqvw3sDEDxwriWorpf+3YCdy3r0?=
 =?us-ascii?Q?fR9fGzOYOhEp+AJ2a7Q2SoAbgBrebawanYEGa8SyvjbDJ621cXYFMJT1gOqE?=
 =?us-ascii?Q?oSfsBTdAKTPo6kmbkNVqVBK+FG92gT+9763/TDN9aO7Pa9Hj4luGHFWLtHol?=
 =?us-ascii?Q?UQn7hEvLcdV5qB5+IdBgM6Zvol30OlOcRhchdlRNBOU+M6VR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c79c85b-f098-44b7-9380-08dea5006f85
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:30:42.4572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYybBo7ClGA0yJp/Xxh3kDAALykeW7Dm+2dFlHhzOsnVZi+IqIO251/sfCykDs5l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9826
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

When ROM boots from secondary container set, SPL should select
correct offset to load u-boot-atf container.
The implementation uses ROM passover information:
1) For non-eMMC boot partition device, use image offset in ROM
   passover data to get u-boot-atf container offset.
2) For eMMC boot partition device, use boot stage (secondary)
   in ROM passover data to select correct eMMC boot partition
   for u-boot-atf container.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  4 ++-
 arch/arm/mach-imx/image-container.c        | 27 ++++++++++++-------
 arch/arm/mach-imx/imx9/scmi/soc.c          | 30 +++++++++++++++++++---
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 73df8715f22..b5e7d7d6855 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -23,7 +23,9 @@ int low_drive_freq_update(void *blob);
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
 int get_reset_reason(bool sys, bool lm);
 
-u8 imx95_detect_secondary_image_boot(void);
+int scmi_get_boot_device_offset(unsigned long *img_off);
+int scmi_get_boot_stage(u8 *stage);
+u8 scmi_get_imgset_sel(void);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 63cf8596316..bdb43d138f2 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -225,15 +225,9 @@ static bool check_secondary_cnt_set(unsigned long *set_off)
 			}
 		}
 	}
-#elif IS_ENABLED(CONFIG_IMX95)
-	u8 img_set_sel = imx95_detect_secondary_image_boot();
-
-	*set_off = img_set_sel ? 0x400000 : 0;
+#endif
 
-	return !!img_set_sel;
-#else
 	return false;
-#endif
 }
 
 static unsigned long get_boot_device_offset(void *dev, int dev_type)
@@ -246,6 +240,14 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 		return offset;
 	}
 
+#if IS_ENABLED(CONFIG_ARCH_IMX9) && IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+	int ret;
+	ret = scmi_get_boot_device_offset(&offset);
+	if (!ret)
+		return offset;
+	/* fall back to boot from primary set if get rom passover failed */
+#endif
+
 	sec_boot = check_secondary_cnt_set(&sec_set_off);
 	if (sec_boot)
 		printf("Secondary set selected\n");
@@ -372,10 +374,17 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 
 	part = EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
 	if (part == EMMC_BOOT_PART_BOOT1 || part == EMMC_BOOT_PART_BOOT2) {
-		unsigned long sec_set_off = 0;
 		bool sec_boot = false;
-
+#if IS_ENABLED(CONFIG_ARCH_IMX9) && IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+		u8 stage;
+		int ret;
+		ret = scmi_get_boot_stage(&stage);
+		if (!ret)
+			sec_boot = (stage == 0x9);
+#else
+		unsigned long sec_set_off = 0;
 		sec_boot = check_secondary_cnt_set(&sec_set_off);
+#endif
 		if (sec_boot)
 			part = (part == EMMC_BOOT_PART_BOOT1) ? EMMC_HWPART_BOOT2 : EMMC_HWPART_BOOT1;
 	} else if (part == EMMC_BOOT_PART_USER) {
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 47e8fc247df..60fdd577f55 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -745,8 +745,31 @@ void build_info(void)
 	puts("\n");
 }
 
-#if IS_ENABLED(CONFIG_IMX95)
-u8 imx95_detect_secondary_image_boot(void)
+int scmi_get_boot_device_offset(unsigned long *img_off)
+{
+	int ret;
+	rom_passover_t rom_data = {0};
+
+	ret = scmi_get_rom_data(&rom_data);
+	if (!ret)
+		*img_off = rom_data.img_ofs;
+
+	return 0;
+}
+
+int scmi_get_boot_stage(u8 *stage)
+{
+	int ret;
+	rom_passover_t rom_data = {0};
+
+	ret = scmi_get_rom_data(&rom_data);
+	if (!ret)
+		*stage = rom_data.boot_stage;
+
+	return ret;
+}
+
+u8 scmi_get_imgset_sel(void)
 {
 	rom_passover_t rdata = { 0 };
 	int ret = scmi_get_rom_data(&rdata);
@@ -759,9 +782,8 @@ u8 imx95_detect_secondary_image_boot(void)
 
 int boot_mode_getprisec(void)
 {
-	return !!imx95_detect_secondary_image_boot();
+	return !!scmi_get_imgset_sel();
 }
-#endif
 
 int arch_misc_init(void)
 {
-- 
2.37.1

