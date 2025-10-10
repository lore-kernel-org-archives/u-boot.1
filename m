Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C516FCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F0A8405C;
	Fri, 10 Oct 2025 21:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iBYZwqM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031B283FA7; Fri, 10 Oct 2025 21:08:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CF483F8E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:08:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2GaF7vMNQb8S7JWGsy9oyLxv8FQIgBzkbGWmSObD860ja9CmMcf43jBJtMewsgoqzsLxwRRlak+jbAZD5TJ+s84Il9AXxf6dZT9FgQZTlG+wVI3zSM9piJWgeK5jP1fbBfAQ2A+mU9AJ8LDoxKG7KDc8+ZdaGXdm6kzVp1zoGucZc04c1OEdXzNxYHJlMSYzbCVZOM265dXKRyYYx4QwpTEYtYUZASJZxMDLJqBl0UC3mUSAam6fNnMHgpL6mn7S6P0bwF7Uwo+lXJYe8V8aNxYmo89RAaH4aY4pgGgAYx4ZSxfttrj4wzpDz4BzgYO2HABCc4Zoqw6vrvtEF4NfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=ESB76crTGyIgn3iIAeJazAdvxDG69Sp+KBcZqZ1uBGqiQada6ZlW+ZDSvOtzUxWeTOen5XC5XV/NBBf4tpsdzFO1lt95YAZfus+zKeOZpCx6AYzAv7qeed9c4s/Sa884u75/T1Dt4oRM5YLBT39KuKJ22EOlG/P+nzEzb8HzA04dUv37kg8JHpJUy0olNBq6M9uQARjLHn4t8OV3ymSfrZHyELYWwUupHQwFciwXiDVjm1HySvNPm4WxlAK4V070dbWvnoq8cC6ufbzFNgBjbWefyfo13RLr5phOc4A+WNq1itBPqN2qa+J+ewa3I3bX/e3N4gy/3mHPMFEP6aGMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4oiK82w7A4Bgvz10VWunzINQUGG3JMwg/sEwkeocYA=;
 b=iBYZwqM6mBkV1vIFFVpNPevvaWbys8fcWUjfZxoUpwNrqBvDFdkxFqk9N6cNg61nEbaFug1PSVVfVYIzQVpgulw3MjEo0/i4EaFKJjHdpV7a5U/OFMcIQIcLhaRfxvfoVHm/nFvEncQn3XbCGewrxK8/bKfqihBpDUl62lVEP5tbb3YYQYOTAjmDqn+Ob4cDqLsbyVODDO+/lVa9xrI/CuTMn8pOXf+qAsObcWAc6zaz0F9L6WvEP5vsEEPaSg9TiBM2EbEb0QOLBG9bwHLqdZtguyH/9BYkysSv/ioJMedFN/hru165f9WudGRZLQRLMLOzl4JfijIqQlbKND/2Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8371.eurprd08.prod.outlook.com (2603:10a6:20b:56a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:08:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:08:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 02/11] spi: airoha: add support of dual/quad wires spi modes
 to exec_op() handler
Date: Fri, 10 Oct 2025 22:08:32 +0300
Message-ID: <20251010190841.1590130-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010190841.1590130-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::314) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d722587-0b15-4be1-6e9d-08de08307231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0bwnJExmU9suLTuB9OvJwESBRWvyW5Et/FgTovha3JM2ZPwqoEEXmFxR9xa?=
 =?us-ascii?Q?RJNY7AwLWlbjeHLrx0+lcmsmz87ySV23+sO2J5WRqtuEYyRDFe0GW5l0Qavx?=
 =?us-ascii?Q?Loxwrj5BAh5qd9fb6XF1YfLXV3aMBoY3BZ0ut6AUFCaqldFspWk/4/0CV3rp?=
 =?us-ascii?Q?9HV9rYY9Hy6gCWNj1dkyowPLWBngX4G+fbsix2Vev6zUjdzv6whlRM8UejkF?=
 =?us-ascii?Q?SzA/nPMp+mm6pa/CB+ksZdRebIbpEIMzd+vsrBRtkmbjsglTwELnNv9IBB4r?=
 =?us-ascii?Q?sLPcejbe0ElHSKbyRlr4rYlZpQXjubeHhemi7szDE5syBu6tYmF1ELAn6vCw?=
 =?us-ascii?Q?WahZ+fo9MnDL1yoDETUIzo439cGpYBFCFosSMZg5GT44j9jtbk9rtBmkxBFy?=
 =?us-ascii?Q?8zFQzI9VIl3SaPxbAur6qcdUDK6NbKS2zoFuY4K0xr/r6qr6craJa/eBDYhH?=
 =?us-ascii?Q?NbLq66hiKACEY4NHdCAaFUhFy55N85Da8tQWela1JMf2ohGZDKLj5cZeZm0P?=
 =?us-ascii?Q?by5VaNywU2oqQrDnIa3UKJ9PCpU/Sm6AwxDPAZS6veDN/ZcyoAC8dCzSHHHE?=
 =?us-ascii?Q?F2XKl+Va936TakqFdqzTc0SHP5XbOiuHVQJvEjtnwoO3A5QqL4sckpAmzheM?=
 =?us-ascii?Q?9s9RhuklvuqpejaTRpCnv4VbdYKeEXtNrP86JlojZTA14wJy3MPKYJtRnp4f?=
 =?us-ascii?Q?GIN2UFvjAJJovDegudQXb7ZLTht7nnvaRUs96u5qN/nrebZexeyvDNANMcSB?=
 =?us-ascii?Q?F+dIyu2X9FRQopsFY/hkAbZc14NyDFIsjGH3GFN31TWV1MIi06xvs4nopBNI?=
 =?us-ascii?Q?JT2SLB+RYBZqgeMiJc37O6BMoNYcjRTAdRsctE8y7udoywV0JzeHVwxR9hOy?=
 =?us-ascii?Q?IpVf2i7IwWge8P6U4LkURjkQleMNDbhhSvgrWjDNeNorSXf054jKDRlt8hSs?=
 =?us-ascii?Q?a1TXt4RBR2ql5XPD8vglBstKDq76WB/pYACogoArL+Vqh8KI0sUQQv/t9OnL?=
 =?us-ascii?Q?EUnjZVCJ/6kzf1u/QarUvZc/+qFxsIL+Nivdfn7kxCCO4e7D1u7CsDBQfZSE?=
 =?us-ascii?Q?FTJOmHY+s8VQ/P55Q6gvRUR6CfCnImjcdtPGge+s3kPYKq2PcWRb6KM5Rmmr?=
 =?us-ascii?Q?tkiOaS/3B549U1yHe1UlMSF88pLXg/+USyvIYrhudN6evYqD9DjDAnqvLPEG?=
 =?us-ascii?Q?HV6RcPgXk6MGS9+DsG0BOozPxIvOhX683D/9Sz0BeIoSSR0wFdEtjXGMfqIc?=
 =?us-ascii?Q?zfHxAhjsv1nC8JumPYccCWQvDfu3tZLLTwD1BDyMibcfH8N7IPlD5xF9fPKD?=
 =?us-ascii?Q?rDKsNxyMY+hdtIVmTeWqBFajtYrrfQBxt+QYD0GxwtMXZxChg4p1/8jA6+VE?=
 =?us-ascii?Q?346Dio+JvXiY9uqZfJQorQ9nhSZ4/hiChDsc6YYdxJ/xja8DYb/FyiKKnbaf?=
 =?us-ascii?Q?hvZLYdDEUHdDXgli3++aJRG+DLkwJJfCsVlm76c0QGyUu2jJ1aJxFLjAoNNJ?=
 =?us-ascii?Q?alRiWXdrt/nrudhzhXFB4F2PB/B8mJfZtNut?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SioztZwmC5uyPDxxTmwgfmz/1OyXhLhqJ/yDda7072HI9nJFT8ArfnU5k/+k?=
 =?us-ascii?Q?saSZLm/PnCgaQPMhuhB4bYYY3DFA/zJ0v4SvZa8Y6oY8fXR/ULagltB6Abh0?=
 =?us-ascii?Q?ctscq8PlEsF1IoAKh+gRUoB1A8S6K0fgkBqQcLK+dIusDRak4BTaneo2prM6?=
 =?us-ascii?Q?PoOhtG/9YCmNiYvfAXoIX7ta44ScuknhYCk+RdyzoELgkgiKHwoXCoM1MSzM?=
 =?us-ascii?Q?uQ3UgfeOOWCKA65fuBBolvMd73xaShBnBSHg3fQ8IrTBsQvSYT3PKAdMTzk+?=
 =?us-ascii?Q?QuG+6gAqPH0Q8Pcu7P5xyG0MI3EPoaC8BAxXIZoj7dttu3z+rTKgdIhaDWZM?=
 =?us-ascii?Q?Nn4mfgR+YC6M6/SBXN3nIXVsrrathBiuEDo1/2rIgXxmzrrh4Y+aJQw6qoRa?=
 =?us-ascii?Q?HKXntsEOZgQ1Vxo+EvVZsPlJsAa2AAtoLKdLiQQij1xDCvL/pyTOA3Mop4Sl?=
 =?us-ascii?Q?PwPC2fpXmzE9qXgd5Rwpv5HhLvjufTYzgiEenz7Wfdg0sfll/D+1fxLbQttU?=
 =?us-ascii?Q?Ek0FyWyaW1lcefquqadGlV0WWHsV1NzjE2sTAg3gPBzW3dp/52Wp3LUF4jSl?=
 =?us-ascii?Q?7wkeowOPTX1j9/FljKygDi34ezJfY26xvSISI/8jtn0BogxRMn8p4QJAHjbG?=
 =?us-ascii?Q?Sa3XedjhKaKBhlgZg/q3Le7c8MoYf1obYhFVMDwrJM4xfJDFmR47sBtMmRgv?=
 =?us-ascii?Q?jlNoBoALFcur3YEWYm0OEscALHP0qviICu/UK9+Yb2/3fY9Bt+Qx9NJVudGy?=
 =?us-ascii?Q?6umKICl0QFMN/M0ztfIzwBRV1nt+qzrNHCpSfFXO2axgP2dap30/jBW/9WNJ?=
 =?us-ascii?Q?EMN9VVgUXXxbXQUzvHvbcyqnESLpgKArj+yMMaBQAtlYVnuJJ/bGSNtsGPkP?=
 =?us-ascii?Q?pc4uxNu73jfrihT23QXzYFKxzSD54LBAAuw1vJ0XwvPmr7VUW8noINZf7swO?=
 =?us-ascii?Q?nFvFJgXpnIQ136XvBhecAd81LMc/wx9C8dPV1ftjigxKyN5oOLuhuFCTm0MO?=
 =?us-ascii?Q?4umtG6lB0En+bTr1svNP9LBsYnRvF2m6W6A0Phln+MNWmLtNqKQ6C2eb8lx8?=
 =?us-ascii?Q?qpCW46/PCCe9L/VGc+XE59Y0up/0LxlxFhA5eHIEFRBNrOOoXFHLNv93zycL?=
 =?us-ascii?Q?nqiqagiTbTOllmJTQpa/wdO9IDlrcYMIqryd1tDYf6hD5WmqfBjk8XZRJy5o?=
 =?us-ascii?Q?eTWY3lTNi5Abq9oL9iE3LFIMv0k6du7Gc9lh8JYNsgUiE1+8OfYnmDpUPR2g?=
 =?us-ascii?Q?WT9lELropbWJ0hMUUmWpxb9QiUCxpPP6BF7PFCw/p/jLFA2HbTjD4Q7Evl0S?=
 =?us-ascii?Q?7TwyvGm4vuOC/NHRmdZl7oGq+MFKVGPT7Orbi9kh34jQFEqdF79sAcTKwig8?=
 =?us-ascii?Q?0M8J9MBkrRHc0cfhAnWTIP+NfJIe52zzYW7azJ94tCznD19KcYhhsSScGHbq?=
 =?us-ascii?Q?OAJjXMHzPyBFxtMfTpDLrT4ysI2mL2zQqdKVYAdD/VjvsiMWsRDtf97Uehlb?=
 =?us-ascii?Q?6WToUazeGN5BDwR3zbj5XfTCrJb5LXNdSBJW9cCtcbNpdHX7axhJyVfhwdsb?=
 =?us-ascii?Q?7pMH7Z/cK2s1mfOmdUk+USX+5GDUhx7R/TGH0yMXxuOGVOvLXGAFywaFeCLI?=
 =?us-ascii?Q?JW1qOxUpQiuH7CwWVBSGa4M=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d722587-0b15-4be1-6e9d-08de08307231
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:08:50.2894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIIStrSOPWjlHT2jbNFu3Ul1UXPkYanmKjmLP+23dZlHPO4LSgyJ1TNn4hz4TFQuJaxo5A7rp/aYTGVOrnz/jpYjqwdsppH4cwYYSzLOqBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8371
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

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 143 +++++++++++++++++++++++++++-------
 1 file changed, 117 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 4eb01038404..7cd409ba44a 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -186,6 +186,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -380,10 +388,26 @@ static int airoha_snand_set_mode(struct airoha_snand_priv *priv,
 	return regmap_write(priv->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_priv *priv,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -402,16 +426,32 @@ static int airoha_snand_write_data(struct airoha_snand_priv *priv, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_priv *priv, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_priv *priv,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(priv, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(priv, cmd, data_len);
 		if (err)
 			return err;
 
@@ -525,6 +565,38 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
+static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
+{
+	if (op->addr.nbytes != 2)
+		return false;
+
+	if (op->addr.buswidth != 1 && op->addr.buswidth != 2 &&
+	    op->addr.buswidth != 4)
+		return false;
+
+	switch (op->data.dir) {
+	case SPI_MEM_DATA_IN:
+		if (op->dummy.nbytes * BITS_PER_BYTE / op->dummy.buswidth > 0xf)
+			return false;
+
+		/* quad in / quad out */
+		if (op->addr.buswidth == 4)
+			return op->data.buswidth == 4;
+
+		if (op->addr.buswidth == 2)
+			return op->data.buswidth == 2;
+
+		/* standard spi */
+		return op->data.buswidth == 4 || op->data.buswidth == 2 ||
+		       op->data.buswidth == 1;
+	case SPI_MEM_DATA_OUT:
+		return !op->dummy.nbytes && op->addr.buswidth == 1 &&
+		       (op->data.buswidth == 4 || op->data.buswidth == 1);
+	default:
+		return false;
+	}
+}
+
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -534,6 +606,9 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 	if (op->cmd.buswidth != 1)
 		return false;
 
+	if (airoha_snand_is_page_ops(op))
+		return true;
+
 	return (!op->addr.nbytes || op->addr.buswidth == 1) &&
 	       (!op->dummy.nbytes || op->dummy.buswidth == 1) &&
 	       (!op->data.nbytes || op->data.buswidth == 1);
@@ -542,13 +617,29 @@ static bool airoha_snand_supports_op(struct spi_slave *slave,
 static int airoha_snand_exec_op(struct spi_slave *slave,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct udevice *bus = slave->dev->parent;
 	struct airoha_snand_priv *priv;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	priv = dev_get_priv(bus);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(priv, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -559,40 +650,40 @@ static int airoha_snand_exec_op(struct spi_slave *slave,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(priv, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(priv, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(priv, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(priv, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(priv, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(priv, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(priv, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(priv, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(priv, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(priv, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0

