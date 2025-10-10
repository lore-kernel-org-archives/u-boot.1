Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2ECCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA031841E6;
	Fri, 10 Oct 2025 13:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mqkB1OmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C160083837; Fri, 10 Oct 2025 13:58:43 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C8683F4B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnJ8WHTcZD9TUkWPz9Mo9UCq1tcKtjp463wa0kZ1UIfbKMTWIblJt5j/3eH38IfJGC015x8HuHcNjh5sfs+oaN5AZvLNB0pnhJXJ5z3tAn+3DYJpDgSY76v9HnuKhTo4J92ANDikZPUj5GVAp9Rz/dZB3ACHAbDafBrKmp9ciLJkwlIcPTugJQWf2BHhkSeIPX2G6Ni1cDlvrgVTa3Ktn5m2GzQxaLh14tgHpq/SQGWaDIIAWtxffZ5ugbaJiwqDlTAvsW9WVoVBMsxnEihochBl7vfjV+6wDjMAw8EhfnRQc7TaLk9SmJ3/raQ6XQlM2bnEmxTh/WChDB2YZVky3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+7OLkHWHAr72HKO4DHCICKgVPTdLoBXoCXGS++luOs=;
 b=uymNwNTYrrnxY5cMWfQ5hhS1Z6Ktk0RxfwL1u30vANxuVTOsWDcH4hdjWaoIyf3NSLa59ePurbd+8Su9RkbiGBQHnai7Wro4dh4KohuYKS48iaSXKAwutrqivd4aIEwSy6goOFtTuHPbhbe9UznESCYCh3tSNlZmIY5MHV13Fv/5h3UHODd2MrDCSpWIQkX24gC9Pqz5ZaXg+rI6eGibtR5HQGNEc/+7Ndi9edsKnXfA6f+x3SF8gWkVXmQ6elgYjQsV54u1gHwCEMjB2aTUT98rbQlpts0onuMDaBC7TE4HGu42wj3zujj5o2qWKfNLdZ5DuRSTqJ9r5YAcRSvCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+7OLkHWHAr72HKO4DHCICKgVPTdLoBXoCXGS++luOs=;
 b=mqkB1OmEujJdS2bzN1ghWfrzCRmn3pGepPpEWU2ujJxQDegZvmwLZOphz9RTO7PTv95UhBXdF0XGWhQNvvQVpZ6kLwigfXPzavM7COetyW+D3w5LSMl2QPS5+yFEa6/RPDEZgcY86gEWTZij3Q+SHxgJoUOgm8bJhCktSPjTbq3YMeHK2fmv7XcID0L3YBCHRkbJHJXH8r4bb576lFdaBp9L5G+6o7P5FJ9N9xW1lb0lY6cDfD1dxICXgBhpRmUfgMW0N2NsOAsSznDUPgy/1YMWQhFHXfwxbXxn2bwEx1BgsL9tldbL5DbFE/C9OiaVGwmsAK3bDdABLDDvyu3uWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 05/24] mtd: spinand: Extend spinand_wait() to match
 Linux kernel implementation
Date: Fri, 10 Oct 2025 14:58:06 +0300
Message-ID: <20251010115825.1531775-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8a62c1-e84f-48b9-eceb-08de07f45a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bYhppiECVOApdHlQR6Y9FzrlVZn7C28BeASF7DK4cnafdtwHNed/Y10oxDc9?=
 =?us-ascii?Q?ZT0+Aptvll2j6yzZrkQfY+8hhZsNtE2r/uJGI1X7KZS+YqGJMoICkyhIkyJP?=
 =?us-ascii?Q?CMFECiPG+6Nd2hzSBQsIbtIdQSR9BUiFA+z4Yrl8ELQF61tCIYY9TMT8yJS0?=
 =?us-ascii?Q?Ba9q4kfLcYQiMteD4sNtPSvvl9hrY9sy93idMWN3zE8i3Wh8DQ/Tb6kJkK2H?=
 =?us-ascii?Q?77LafD+ncsbUdwd3TFoAHW83xWidDQjyMRYpI2JKu7jDpMkHpbnOs3VLNGnR?=
 =?us-ascii?Q?K/AphNSKtLGrGKtqX7ykVI4EiG1GPqm4KbVluA1eSAlKXgBs+Dj2Ee466I6S?=
 =?us-ascii?Q?3+xIX8/D6BRWkhOD5nC2hADECxx0EY3X6y231lYvNHwr0bNecqRLMpCG567z?=
 =?us-ascii?Q?ENyvOyxesOwZXhuTT+yW8gj/DwAdKLbP7EYjNcaoSBejKNH39omXY5zTIFuz?=
 =?us-ascii?Q?w9bmVqZRv6N8p2cvqzRrMokheYgqfy/xZB2dTFm7p9TIECuIkf+m9aubBlBC?=
 =?us-ascii?Q?5XqaSA9uavEOJL7p6q4dpLUtSyJqAx3jOt5HHqaDdPdUhTMD3IPGLoNO3ksx?=
 =?us-ascii?Q?/81uXgHBvOeKxI9d8oSjZsXlM459x7lMbi6eoU2FmXxngaV4280C39QcoKko?=
 =?us-ascii?Q?cN8+q+Y/SoFz3KOsDoTJuqcRRYxtZYq1QDsN3fqgbicLTkC44pRKoFWeG6Y6?=
 =?us-ascii?Q?ewWX05Dms4cf3BRursHF6SlqENMYa3Zf45dnT1jYe8tfmPNZgNE+GqytqZky?=
 =?us-ascii?Q?Ow/pUtRDu3hiP56+tbECf1K9a/SFzq9/uLTSoRQ0gusJCB/MKImmzWJ9M5UE?=
 =?us-ascii?Q?tNOaAwM+FHXGhcDW8qNG8gZozdTFnfjiJ16nouov0fuyqP2mzCPAfN5wOz28?=
 =?us-ascii?Q?hn5uqKvSkaqHddJ8tTSvS2X6krYCFFGgZ0ER3HTyFcL+bWrvuZQSrriIOwcu?=
 =?us-ascii?Q?NQUUd4FlvBZmlUq3O+tBKg2HQjVILRFxsci29br1FZEFAIJo18kh+YbtQxnO?=
 =?us-ascii?Q?O4fl1MqL4DsE5MnihBq+qjmef6eZKh+dBoLlDCZJfKmopjtYr3OBTLgLWUjm?=
 =?us-ascii?Q?KbnpdlWShxcz1mJqjuxzg6KyjopjE+N85ZI8aTTQDF1L7oUqp3WqgKSzQ53G?=
 =?us-ascii?Q?q2LiCUC7F30x7d5UkSkkw4xGMLaBHHxwgMf2/OOP9p+Jjr8wQsrPwDHvnnqu?=
 =?us-ascii?Q?YcnXATEFf38Ff4lpl28H5D2Fn5p2b8zyMpM+kVuwtmWsAPuucOG5fGFeuoC9?=
 =?us-ascii?Q?n//+FDaQeNaF17QXzXC/2sCkn5vXyaeIQb8UgVnC43cc4RjKzCljK0zqQj97?=
 =?us-ascii?Q?I1FIIdCx0LJb8oqz0otR4oVngOJvdTCFoMNhYK9JMN7vUmFRHHvkZK0TMdY4?=
 =?us-ascii?Q?MJ4yjAT1N48ZI/HELCCzsF2YfAWeDCQmHdzlxYtMhfuvZSHLfq4XGQae+tPr?=
 =?us-ascii?Q?JVh6vprxyKP3OZSi3V9vWP8CCCfEylOKv1aEWN5w8oR6F605LZcfczEWTrFo?=
 =?us-ascii?Q?0JMlf11r8o88XtfKffuRrI9VaTc/U86TN7m3LVO35WDGoWG5XuRDiZhzng?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ICei109iuZpRG2Kd0WWLN3gviVNwyv8r8X+dVPl71xHH2nbHzcgUVVIZoaA?=
 =?us-ascii?Q?7OanCzQgpZ4civNgrSNCQIKAtKSCoFRD0FupimPVN2h9LJ/vmd+kgzXDk3CQ?=
 =?us-ascii?Q?nL/YDriyvcdzyJ2Dh19AfTBRA6swFGzd+YKYRWUSydFofrIXsMkUNu+HT5zA?=
 =?us-ascii?Q?MF5CdzLIxN6mAKfhH8owpRqT1/b9oQIguq3CfMSeDGzEzzmSadeEsx/xm1Dx?=
 =?us-ascii?Q?Qvy3ujldgvVjwgpPwcsMRv8u+V0IV7jZtireq8eR9huSMKw7DRUMVEnFQjCl?=
 =?us-ascii?Q?15iRN0/cntMLkDRUbWgcgS0vOriertork+MICnymjXgZTcHJx+oFK/nsCXW5?=
 =?us-ascii?Q?iwd2Rf96YoIhXKJ8pj11zyvgQT9OM7LIj6SCAI8qMhUrqcJcqHC4lUNTI67Q?=
 =?us-ascii?Q?PnPxw4qLNwwyVtMZPu3TzNvGn8/285uyga8nNnw2Ybw+qb9AhRRKUWV5M7zZ?=
 =?us-ascii?Q?S0BFOzJkiPHsN+cEpD02pyb0OmfG4LgLhMdbzmTaVir8vm2cP7UzECXzFpeL?=
 =?us-ascii?Q?6a+3tC0I6Y9hl5XpkZubinpFUBXQuTY+9oeVOj815kX8D19Dlx/WCaIMG1Tj?=
 =?us-ascii?Q?IrlMZ+Mzr/b3/zdbzTMDPAF4Cg3N2aIErLaJxwy37ZZDBsNXZoOhbRV5TV2P?=
 =?us-ascii?Q?Pm80eVufj/W8nq3Udt3egz4uK4Zj1zhVGZzAvFlsNGgyIvLbJz674xVotIaT?=
 =?us-ascii?Q?JhEChaT5yO3ngZQHB0LWgcF7FQzzy2sWJsowSDhkz0ynqWk/p964UjS8MuqN?=
 =?us-ascii?Q?60L5ajhXVmamxsMqmt/2nFZVqDuZfYn3Gn1mUViIdZqMs6Q5XND0yvDh7yqk?=
 =?us-ascii?Q?9WabIqmddq22b34AoqU6cVz9pXv0PleCJcTLrSN4abowS4f3lg9J1uCgACsI?=
 =?us-ascii?Q?wgfNld6WFU4P261TDcGqeocxR8geDpkhvIXmTMAUpReYEG5EN7IpxgMsyVGo?=
 =?us-ascii?Q?l88/x39/tNgj1gvfMEcd+QITcZ3pWFQ1j86wyHKYw3yoKlXek70bYNF28+c+?=
 =?us-ascii?Q?6uoYrL4XSCtCvEqtYlHYG+XOcpHIdW/08wCHyTU5FpvIp9hQc+jSjZdVTdJi?=
 =?us-ascii?Q?1gl9L5ew4P6zjPbSbVrG1Y873snfMQuVSOKpV2Qu+YYDyE909LKgBoaAIviI?=
 =?us-ascii?Q?szrPEIEqMHK363YgmcSwkdcr9wmjDr/EzaG8iA/EZcvY8ZcjD3H3o1cEzCwv?=
 =?us-ascii?Q?aJSEKwmbi3IztNZTLqliJfJEhHvBgr3vnivFX0x0up1QqfZzlwAh8oitrhLQ?=
 =?us-ascii?Q?KINQxkjzbIRUM8IQ41PC0WMopzHVj4+Qgn1xQ5snbzHEBNDoPgqqYcdAhpaI?=
 =?us-ascii?Q?OGelC+pvfdpmrMVjrJvpRvlsRabWt6xKC6/Gm6ckCmN+CQ/BO55lHCqslWBh?=
 =?us-ascii?Q?4o4feZ+5o3My4ewMgj9aAhnQI/PWAiwideRf9IxHm1vKPDscC2Ag06BaiFIy?=
 =?us-ascii?Q?FjJytrBiNUJJslkGa6WtS2d2VKel6llPQTLh//MhobFtb3TIKIUxwoDeaYsW?=
 =?us-ascii?Q?QrcwbrsvnBXAOdhrZsRF/BpF9xCE4TNwNYREkO7U7W99MTJ/+Rs5yQCzRuHe?=
 =?us-ascii?Q?86/DpbrjoYOH14Rlynu9yvQH1W1j3HSEKiFoToCq3NW+pz8Yn+NXfjIkgzQw?=
 =?us-ascii?Q?OQEtJzgYVOXSEVkKlLn1MvQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8a62c1-e84f-48b9-eceb-08de07f45a49
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:40.3747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ny4AKiX7ZbHbbdKlJj32Jz84QF07NVi1whYXbMeE0gVk67aLib38A/lL+tEHimHjx7JwHVKxJwu6ho0tcm6W4E5JVv33yUPFImYdVq7ySu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8464
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

This aligns spinand_wait() with the linux kernel. Instead of calling into
spi_mem_poll_status() which is not implemented in U-Boot, we code the
polling logic and make sure that schedule() is called periodically.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 47 +++++++++++++++++++++++++++++++------
 include/linux/mtd/spinand.h | 22 +++++++++++++++++
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 34e5ac33c63..3b612bec274 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,41 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
+/**
+ * spinand_wait() - Poll memory device status
+ * @spinand: the spinand device
+ * @initial_delay_us: delay in us before starting to poll
+ * @poll_delay_us: time to sleep between reads in us
+ * @s: the pointer to variable to store the value of REG_STATUS
+ *
+ * This function polls a status register (REG_STATUS) and returns when
+ * the STATUS_READY bit is 0 or when the timeout has expired.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int spinand_wait(struct spinand_device *spinand,
+			unsigned long initial_delay_us,
+			unsigned long poll_delay_us,
+			u8 *s)
 {
 	unsigned long start, stop;
 	u8 status;
 	int ret;
 
+	udelay(initial_delay_us);
 	start = get_timer(0);
-	stop = 400;
+	stop = SPINAND_WAITRDY_TIMEOUT_MS;
 	do {
+		schedule();
+
 		ret = spinand_read_status(spinand, &status);
 		if (ret)
 			return ret;
 
 		if (!(status & STATUS_BUSY))
 			goto out;
+
+		udelay(poll_delay_us);
 	} while (get_timer(start) < stop);
 
 	/*
@@ -418,7 +439,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +490,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +525,12 @@ static int spinand_write_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_WRITE_INITIAL_DELAY_US,
+			   SPINAND_WRITE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_PROG_FAILED))
-		ret = -EIO;
+		return -EIO;
 
 	return ret;
 }
@@ -702,7 +732,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_ERASE_INITIAL_DELAY_US,
+			   SPINAND_ERASE_POLL_DELAY_US,
+			   &status);
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 163269313f6..ba6c2ba149d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -176,6 +176,28 @@ struct spinand_op;
 struct spinand_device;
 
 #define SPINAND_MAX_ID_LEN	4
+/*
+ * For erase, write and read operation, we got the following timings :
+ * tBERS (erase) 1ms to 4ms
+ * tPROG 300us to 400us
+ * tREAD 25us to 100us
+ * In order to minimize latency, the min value is divided by 4 for the
+ * initial delay, and dividing by 20 for the poll delay.
+ * For reset, 5us/10us/500us if the device is respectively
+ * reading/programming/erasing when the RESET occurs. Since we always
+ * issue a RESET when the device is IDLE, 5us is selected for both initial
+ * and poll delay.
+ */
+#define SPINAND_READ_INITIAL_DELAY_US	6
+#define SPINAND_READ_POLL_DELAY_US	5
+#define SPINAND_RESET_INITIAL_DELAY_US	5
+#define SPINAND_RESET_POLL_DELAY_US	5
+#define SPINAND_WRITE_INITIAL_DELAY_US	75
+#define SPINAND_WRITE_POLL_DELAY_US	15
+#define SPINAND_ERASE_INITIAL_DELAY_US	250
+#define SPINAND_ERASE_POLL_DELAY_US	50
+
+#define SPINAND_WAITRDY_TIMEOUT_MS	400
 
 /**
  * struct spinand_id - SPI NAND id structure
-- 
2.51.0

