Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47329ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450DD88E5E;
	Tue, 10 Sep 2024 00:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KgOENHSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9525F88E66; Tue, 10 Sep 2024 00:24:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEB788E5D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzUpRK/0RDgUSaP/x/Xn42jE9jo9vLJuYga7N9/ZLemkxNrWxfiGTA5i790ujI1s0Q8KgrVocawpZvAMXxJKfHPFdiZ8mFQPcU7UfLzttHdS4jCZkkZHJYuDc+LPWoQzq30rp0lW51HPhNGM0O9ZEq2J79DLsbN6qury7K3019JZ5J4cnqE/3Pdn1kjfdgCJaBm2tWn9xXwT4ocnDPE2Pa0rSKOlloFN2dafBRhPWmboW5PDmGVzSKqoevoix0/sBlKqfjJY2I9kq6MSOW+cWEWVkk11DwxaqzufXnUwBihXx3iORUxu/uTGnpOLtDDpp0rCuBBOXD4Mab+sBJf+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIpKMrgieRd0uiFaGsLMiQL9c4w2nS6s4iimFPcCk4U=;
 b=NXN2kWb+3T5ukl5zu5/5jzlDIuWQh5wItifJZK/PUIT6spYVTXReQdJuWHI3z7eEO55G1PC2XTpfunQxTlkosoo1BfpMeEjL8vWsmKY1w/Z3b5LkWhMqCzGfQqRky46Gc3EKd9lHX4P1Nz1/VHHf8P8qr1/TnDX2XsPXurodc9M2iYeBQx53YVlZYVPY/GcXeswtuB+RcBi42mZUJwqSM5xiJfJwd927ZAm/eG/uz96pGsDCh4eRfBDU/JqiNWCC6XGBjdP64jkC8VX43lt7wOpHLcXkmcW/PNhs+/hYOOqmTHrxMepuMQYjV9r+NpAbnrCaZYpuDFA+qCr/ShevMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIpKMrgieRd0uiFaGsLMiQL9c4w2nS6s4iimFPcCk4U=;
 b=KgOENHSEOmP4ZV0TKC32gIysp2zNQ0+51XRyC61rSfG0461FMUXlhu1fq8552wKZTRR++zyBoFTG+hc7fvNerWuPvXCfyTarkCyLuHIpirnBi/6y/iQjUPDvzkNYoJGr4xAvEY7LM431qXAezld7bPJVX6BgWQJgq9IHuzZXyh0W9uwnEmh3pD6cW7FG4nqBoF9IGqCwLrsxlBUS0aTPO2+Exg1wz53wqsNoPPNeyyphjni2wP2qZTqqLFbQ7I6AoT6J1DJsBRT9VfZtRjE2jOcsstlvYaeUV4zKYxgm/y71pSwlcA4OVrnmgmKji9Ki+RlR3v70+NThsrsBihh9AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 04/10] mtd: spinand: simulate behavior of linux's
 function spinand_wait()
Date: Tue, 10 Sep 2024 01:23:52 +0300
Message-ID: <20240909222401.2562898-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: c20ac356-241c-47cd-c182-08dcd11e2332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MWCOBhcT4yMMtQhj4cYHflkWJVTmg7oSGHghYmiHIOKNjRuDA83jDnKULIdA?=
 =?us-ascii?Q?ssuTRfBREB+tsWE2KGhhYmFHf6Ge71JmVELRp8+6r8PuobjoJZAwEtn+pwrN?=
 =?us-ascii?Q?sHDZoafnDauCRWjZErZY5WTW2LU6i1v6WQFc4M5H9g5vkbGU89ZLk9vDMq2g?=
 =?us-ascii?Q?cASeg8HEaZW469pzlio2vs0KliJ7KS5UTHGQNeslcJvgl0yq2KJC8p3VJRdx?=
 =?us-ascii?Q?2VsYpwGiMtuH7bgVGisSoIiMSgFLeMqh2pGmjz1h/+29XMx5crA1sYb238ha?=
 =?us-ascii?Q?nilH+5zKaAeGT62TV6TbOIl4cBn/c0AoPo3UR7vDCvkRK7cD+BcTlxMfh/dh?=
 =?us-ascii?Q?Mz9xw7A4SdqHzq+EyNwZSyV6p3k8IHSVGuPqyPV3LeD3QI4jWD0IH1staiGI?=
 =?us-ascii?Q?0Zs1xEjEw0EYE5qjiPy4yP6s59Giobmh2vGR52uLEROXmCFsnnbJ0GhYNA0N?=
 =?us-ascii?Q?qTiYce/T4jW+EONk57dsSDpobJ8bU8cY/tPl/7aaDsInPE6zJZaWD7zMFluL?=
 =?us-ascii?Q?PEEs5jzwtrKw73Jy0rNiS9JfeofDyvMdQcf9NL/AouqhqEVqo8TTQrF0PlDt?=
 =?us-ascii?Q?3qGqkpCnD4jVFBcOtRcsU2J2MkykD7LKGVagrJewlAxt1+zJKuWQPVEsDcQX?=
 =?us-ascii?Q?IyIdXEk813hK4wNEUf/dcjlhAEtTn00jUzUQCcsEcZOAslxKuvHqfGwz6ZkE?=
 =?us-ascii?Q?mCZx+ZC/Z6L1oW/NrVMQDJMTzRi8JL7W2JWoYRtufxhWjVbwYtii0Opch+kS?=
 =?us-ascii?Q?OuA7QbOGSSd3WCEk0Mr6OzIbq9NzyRIAkJpuFVW30bvlGVg2diDOn6VXdgSS?=
 =?us-ascii?Q?64bDuLaPHPTwHGFAPkrymzfn3fgjC+CP++SMdkgoaAt6lxoJP4SwgXahgVCC?=
 =?us-ascii?Q?zMYd8jV1t+94McIi4IC5sg/W2V55Q8NUEHE6WsxueAaUW93O+nBjQvg+VI/r?=
 =?us-ascii?Q?n4BagqJMj/DZOfKOQW0SAS3jGHj+XMNpx/Z+3mhkSdJf4NVyZQhVdEM68pg0?=
 =?us-ascii?Q?a8jkEP7WyRteyOZuq52hXilxM/f7XUjbKWyAgzBhiTotmuszNKZy3n4AIoKm?=
 =?us-ascii?Q?1s/aYz3pPgnoCOln0OZr9xqJDhHGCMVb9JdC0yx2TYDTuO5SniHaWfK+Q2fb?=
 =?us-ascii?Q?yRGlEuq9UUUKfbs1eIBXQnLzX1BWD/vfNuY6Jz550wJPmhbJ/MOG9vS3gd0T?=
 =?us-ascii?Q?DX9tPeREZmgQRiSISB6Aw6BGIXSTMroNqopjmL9QQ4BAGsbcl6+UfazKxdlQ?=
 =?us-ascii?Q?oI9TqXd9B3ZXLimvGNKak/PzVyH0qAxZ+wghIrdDzmyeSarL1VlnuSYu0QCr?=
 =?us-ascii?Q?RT9OHpeSY3/Z69cJqjkdq+mGPPF71CrKVIIOm/a/298b4CN7spsui5MQe1me?=
 =?us-ascii?Q?CRoUasDZgbPGg4uEE5t9goOLm6D9/OaXb/Ov0W47wuPNDwOlBtK2Fmo9pwQE?=
 =?us-ascii?Q?gRG4M8aqqjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/WzZA6H7D6obxpdQ/lI4stnkqHN2iErNFS6QO0dGkFw4/nA9XFjCGC2uvI4D?=
 =?us-ascii?Q?XjW9ooIx/RSBni7xJ3OKkRnyUoLaxVGjfIoZGtKS6svrzBzuCxlrVApBB4RX?=
 =?us-ascii?Q?WLBmX1n35KK3XvQzlnkDTZgeMJFk36LLzFJ0a2GX216SxtU+ldUCAHMpgNJL?=
 =?us-ascii?Q?c6SqGEB4qKNeOR6xzhrBox0F/EsL85eeTWfcDXVdbh4wSBv1dp2q+xjCZ3Eg?=
 =?us-ascii?Q?wyygRblB4jpEacRUGbdknFrPazAVLaAtfLKJRU8CLPIZEzsQAKYR3RvKGcp1?=
 =?us-ascii?Q?qiyfTcftsTkzgSzKsZ0YIxlYh8PcJW10THE7CuWphKN5U4y5gBAktAiho+2J?=
 =?us-ascii?Q?G9/TgzXUhloAFCeKq+Gq97Z75iUiuV1G6H3xlPjvoPu/WYaqacqtR2eDn00Q?=
 =?us-ascii?Q?BHTwYw8/UKTv1h3pX98oyk7uHLdMIW0HYA9OrBszMIuDhObWSsZOGRi2mG5C?=
 =?us-ascii?Q?eg2kRD6bqtsTtG9X/yXyQvhi8Gum22S+gVXVw+jga19qlFsGLElXoFcjAntk?=
 =?us-ascii?Q?AKlW2nG6drA79hd/8LZUkHF3rRxyBTfpn/QtSArZhdPc5tfKCTHZ5Q+9lsWg?=
 =?us-ascii?Q?NmBYnfWMnD2V+CDEdFWAMJyw/2Gy8CF/SeN2jE3Xux1RSoF50m37vpBD0uWg?=
 =?us-ascii?Q?BAbMwjoLZZfmMhmG1dzS0j5wRCIu8yHc5pRebHxk3Lw8aWprwZxNtyBC3rbF?=
 =?us-ascii?Q?07U6KYuLNCo3i7gYT7PvIV1tkqWdpsFfYOecboW0KpVWDFgAHfhDhvgp0C7+?=
 =?us-ascii?Q?tUmaPPy7gf+n+wCNcWHVCZ2zi0RfvDc/Fs1NQT0qYnszx8N7NvzKvDhpsiwu?=
 =?us-ascii?Q?7M6ERWKY01bEKEY8ZHzHAEHAwIR0b5JPSKU0UhbaVqPgt+dYLdNjtgbdtySq?=
 =?us-ascii?Q?YuCthlQIukjPtdtKqOESkSdH3hSb9hgBbR1k5YK/yJJdGIeDn0YWDHp3UgQT?=
 =?us-ascii?Q?jiHZd7JwnoBJj5DAzwn+uw6feZRni7X1A+uPKgQGx0hWkf9yensXCMnsMQbF?=
 =?us-ascii?Q?BWBx0v79Aq6yQ1cH++wUlh/Lx9iEaapgBr2KiS+e6+SGy6QeF0Maqv5ONXU+?=
 =?us-ascii?Q?ekmRMKBjgOMWBjsrMm1N8zG9c9TAcvaJvppOCDsFmEnlYMSEPvDgN+l6mbZo?=
 =?us-ascii?Q?dDtsST6vFwpmbGjYCcklkcfI/LFY3jCe+jwelAS0JUb8/WIfzQCKtJFtpejP?=
 =?us-ascii?Q?9s37rmdS6p/S0Guqs4ixs4hyLLXqe3p0fcsKrvr0BBqkO/2LTGPOrwGqg+UH?=
 =?us-ascii?Q?07QtncM6vz8SHikG4ASTaWq2UrW+u4Bo3vGzIElLqm+KJpil808d/MNcqjJ8?=
 =?us-ascii?Q?8Qj2EgNQakI0HJBXpH7Gt2i5BVDyUzgS6prnApinGjfA51vEnpdU0/ifHsv2?=
 =?us-ascii?Q?ArmBjYPkv079jHmq/7tGOrigB3pgHj42UFAE+O5aTsqyu67WqiMfaCaw444M?=
 =?us-ascii?Q?dZDDs/rSSCU2z3qUMU0eJyXkYRsBRH4mgnfzQfwWlqdLKC3BFRN8LZR3Yo2z?=
 =?us-ascii?Q?p3FuZaSaPFcMspRKYsWTCEgCJqRLPf6lLaLSSAmttBXjE+RXCCmyseg4Me25?=
 =?us-ascii?Q?UyU5meG4Jg26ybbEU+5QLHtuIJGo8iK9M4A5XWsK9aZK0sM+qDb5GBCKBbIw?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ac356-241c-47cd-c182-08dcd11e2332
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:15.0866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYTe2HxutIf9zrQdXcHZDMEv8coBB78iR6FDd33SSOaswG2WZaCGpjcwp/IbXY7NvBBOer382Jjutx3wVJXrqwj7sxzBdPwMyWI1h1rKBu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

also call schedule() to allow periodic actions

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 ++++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 62779dd3e51..a10605487f3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -32,6 +32,7 @@
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 #include <linux/printk.h>
+#include <linux/delay.h>
 #endif
 
 struct spinand_plat {
@@ -362,21 +363,29 @@ static int spinand_erase_op(struct spinand_device *spinand,
 	return spi_mem_exec_op(spinand->slave, &op);
 }
 
-static int spinand_wait(struct spinand_device *spinand, u8 *s)
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
@@ -418,7 +427,10 @@ static int spinand_reset_op(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
-	return spinand_wait(spinand, NULL);
+	return spinand_wait(spinand,
+			    SPINAND_RESET_INITIAL_DELAY_US,
+			    SPINAND_RESET_POLL_DELAY_US,
+			    NULL);
 }
 
 static int spinand_lock_block(struct spinand_device *spinand, u8 lock)
@@ -466,7 +478,10 @@ static int spinand_read_page(struct spinand_device *spinand,
 	if (ret)
 		return ret;
 
-	ret = spinand_wait(spinand, &status);
+	ret = spinand_wait(spinand,
+			   SPINAND_READ_INITIAL_DELAY_US,
+			   SPINAND_READ_POLL_DELAY_US,
+			   &status);
 	if (ret < 0)
 		return ret;
 
@@ -498,9 +513,12 @@ static int spinand_write_page(struct spinand_device *spinand,
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
@@ -702,7 +720,10 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
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
index 5934b7604cc..b701d25f73d 100644
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
2.45.2

