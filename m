Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A106C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA27B8382F;
	Thu, 14 Aug 2025 01:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xXUNkcK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2628384E; Thu, 14 Aug 2025 01:43:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D798383F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfucW3JsIWN0G+dQ4IOQBA/XNWVmOYOc5wNK40VgXRVziTbT7dSzLNHNttRQBtR90rwaWB39b2mn2nFTe+7rl9yMyU2mP9t+fTy5SF03uIOPQAtFenpPqLLKWCTcYLa0tMFtgC3CtJL3wTQqojJORfJ6QQk30R7VsriilWL4zptwX6u2Zx4CHR4wiLeZBEJ6u8xkd7Tm0HUJFziOgqdDMDGyfeTvcoi9xtSYsD+kZ0YOQMP5NlaGzMiI0xUE6TNHZnUYdVqWsj1RNn3ae45GpDEEgZjZ5EQqpJ10Vl1lONlbvuk1kdD6bFG/3u2mHbdwT3rCmYNdpXLIfbzU/JQkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYwy9S3rRVcHpeqr8Em6AGlcemTPPBGF9SE0GlvX1Q0=;
 b=lDd9JiBNWC6+xwDdqlYjRXpBQs0D5yp9tSvI9In+KUGJ/lssSt4+3xPSPy3WmINkDRHi4l6wxYfQ4X7C7CLhZ/XNDioKMx5Fz3IxKqA4pfVPMoUdMvTlsoHSha8HoofcKc1xe1o74zUkYNZfIcNvsaSJwIm6D/8JWSXrjNPClqARnFH7N4P8Uk58UaFyL+a7Saiac6XAza80EzpKMFWVo4nW2i4ZQXR9tHWw+EGQgayiSQJdrwQB9hZtdROGfUfw1a4bYnEwzS2ugC70Eoxk7QDAbgkUjZ+Y6FWwpyXJXy+kYQkw2Tr48hKueGuUyMBtx6kH46d6mAJ1EGTkvsMFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYwy9S3rRVcHpeqr8Em6AGlcemTPPBGF9SE0GlvX1Q0=;
 b=xXUNkcK8Ja4pd6kC7ITAH1qkf0R0beFKpUMsToeWqIOSlhKhHlXpZb0kNgS5h/u9VhKCSCMPL/8oqcayNBRyoA9isqLqsrjA1UT1XibXvxNUwAO5zQCbnaZqlejvdmDUMlOwBKqrwrTUzUHrOe5/KEdlXt9tz6qlM6o6RGHFnp8BSpybkiA8x4HIO26WYuRZ7W5v2bzwlgDo+guMJoX/BCnTIrEu3lMSuokDZYY5vdHX1Xp+bSJNSuxB3nqlwrI1387CMNHiZbYmxejx8lJkdCCHu9fVDqT4YnSby7dpfow1aN+CED4b0Nj85BdkgF6DIH2r2OI/D0cXyXevtwy0xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:28 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:28 +0000
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
 Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v5 04/21] mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
Date: Thu, 14 Aug 2025 02:42:57 +0300
Message-ID: <20250813234314.3945708-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 765aa722-7440-46a2-99bb-08dddac3340b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCb9KJ3i9DM1O3L+NWsUKhHvxG95sQj24unQAuBf6nXapUPZrHRA8GaE7T1P?=
 =?us-ascii?Q?byxhNiyPlfbzCAmD5m32dB+723sZf7mXG2CNoKW0hRwLFwbEBl+lFgLBXtdF?=
 =?us-ascii?Q?EtMulGMMpf/dAaUS2S6PWoDdz0XwqYE2Ep9qOwJVjXQDLEVDcXSl3Lf8Jc+a?=
 =?us-ascii?Q?m+6mkeEQc7TFODuIqcWvp/MX3hakPF3lliNQpBnYiqLNuFy6eCyttbZj4NsZ?=
 =?us-ascii?Q?FBDDWiPceSMyG1p5Li/jfIvDvBiPFRuXr+VbcKbx5QREyUewpR55krKrjJh/?=
 =?us-ascii?Q?186vLVobzwHJFhQh5DC9Pm3m9AULh5P0gnPkQTaUDHYGObcZu9k1fEBpYbLN?=
 =?us-ascii?Q?8XuV6xDLaAXNvl7lBhKqgCzCosNk2GISjO5RPg8iZOZXU4CEQ4cCocoC7Men?=
 =?us-ascii?Q?j5/I8nF19iCTHcNqW1yTJzjyZfFUA9ON+QbjaATW1z7pKkYs4ng6kY3bdLpE?=
 =?us-ascii?Q?2SBMmvSrLULQgghOCYrpNiSD0tEJlPYya2QASzTeEEdMvY+SEaC8ogoZwHho?=
 =?us-ascii?Q?q3Nq2db6NUSbNclDNlYWurfPHYqSoiQIrNa5Arq+da2Fs8g2aK1mDb8PW6B6?=
 =?us-ascii?Q?sE4tZf9hnm7v171Jz87j8lkCgDhCR0ozxod+4yltNuUu/Duop9gbEv+Gqm82?=
 =?us-ascii?Q?WjVPvtyf01MAZWQtrV5h2reVAVpFWV/vMFn7wrVvp24RNT4grm8Symq5Pxul?=
 =?us-ascii?Q?36hSts84eEzJOp+ZSVLRl1h/IjwZJ6QwgzIU1K9TNJkzKlxXUjfP5lrCRMyD?=
 =?us-ascii?Q?jZuay43gQENAlSax1Wq0FGgc0ySNb5klJzFwrGHe7Gu4SnpEYIwr1tGa/VKY?=
 =?us-ascii?Q?DVhcqXCUvivqUdqTEhpLi72ckPTn5x+QEBfF+jPy/p/w64jxkqoxXndUkkM6?=
 =?us-ascii?Q?BTd/YiHK/GvH0DlhYP6DraDhcFGZhcGoP2C8TBy7HDFOtQSnmHjqe5GDwUoC?=
 =?us-ascii?Q?hvAqjB0CwRRISJLPBA9JBCJSflEkUnrhDMcI+66xcKOfQ1rTNV+eulHFO7UY?=
 =?us-ascii?Q?zpRHVGqrKtyi3OiDi2Cx12ZPK5e+/Jc5TNKma4sX17dEz+KXjB/8S/TltOdd?=
 =?us-ascii?Q?WK5P1zTxWONXtPSwQSic6YOMozus3DTyaGxbang1DwSZScHfkBpLyLNPBXst?=
 =?us-ascii?Q?Uyy+RuddRqRl9LIagBMayEqi2vHrSczSZNsAONBofGhC91+4RNfWkgamscA/?=
 =?us-ascii?Q?QxYhoIoYtmw0yJzTCX+zcS4Wt1GIPxQrgXS0ok+Y5KgM9w9as+pQaTXp26db?=
 =?us-ascii?Q?yM6A7FycC/feKiz1NsAzGPARJbvNIFRk/IAJWEUmOvnhch4Yv9sH0O8vkBUi?=
 =?us-ascii?Q?yCTemkqz68Cm3mGJGz1m6aRPw1Er1rKf9aqqBj6HgpQm9HAocuZqIPr9SkP4?=
 =?us-ascii?Q?LfWtslV2vRtiGIzDg5Ad4pVry6jqn08KjKtVJCuH9CFd1cmWVVHsgobWlf+/?=
 =?us-ascii?Q?ghgenEsmXmuAD8clxdQXYRnUQPcMZXYADvKflo/nvFnNWaBf30nT/PzdoBE4?=
 =?us-ascii?Q?fXfxUTuCrv/gHxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?87zZk7EwiOMoTUek6QrV1LYWi3G+/29u/pn1kZ5+tNREJv3wtW50C6jYJz+Z?=
 =?us-ascii?Q?qud7l6a7gFx/vkcKwAV2LHKRzCTvy091pD/h9Er6UGrODi7dAqTi5fWtseJm?=
 =?us-ascii?Q?+bTdMTTxTmpaPSi9zSqbaInknylT4FdA5m7ITLsECd+MJ5uAhmyemcW6phwY?=
 =?us-ascii?Q?tK30PE6wPhcLdiuZhiznu8gb73dlBitILbDXqYiOzw5041ukL6BoE6B5o3fi?=
 =?us-ascii?Q?LSrJTDTsysWrG/rbb6Pv8X+K+FZw7JnjOkJmP1Y/lGhXQ7pG2RCaw/lHSkkK?=
 =?us-ascii?Q?nVi9Wua7RymJXUFQL6m/CMnYJkT82bfIpK4itKstWllOnKBROY6sGZChyWya?=
 =?us-ascii?Q?7cObSK7nQ5hPyZvQ2ftTYUsmfApM+jOjUxiOq9Omq9FsTqMBd6q36V/HnBNX?=
 =?us-ascii?Q?iVTTAlZaePXoJKpALuYNfmXr5K+VOKwvJrQoz5XwoyBfiIyd5BXYqkPxDHwQ?=
 =?us-ascii?Q?3uWE95GVsq+CL5i7UxlyFNjA2KrKn/MBn3hRwCuQryscD7EY0DoiWBAt8TK0?=
 =?us-ascii?Q?TvrU6KJErl+cIewabI+0BpxkHMufYU/lvUQd940LMg7IvUWF36vQFZt2ix+Y?=
 =?us-ascii?Q?IbDNOnqo6QynI3RJ9mE90P5rqs0isRn9LUdgtIKsPRmJrU+Ayxw2tzGeKjDq?=
 =?us-ascii?Q?inwXZpLWFSzcm/gArZ5X6d/hkBcrWqwrxZPwmdNPAXWjRUjl2dIo785v9qnt?=
 =?us-ascii?Q?IUluDGwKWlK8uzQQXBu5BFmzKSO32rJ2AaNkCqDYR71PrHUWmgu6n2E4zMQI?=
 =?us-ascii?Q?FlT7LusLUtiWhXNauDqERO1JP7pSaMfp/HskjknY5+1tzUGVfXZsAP19pSXm?=
 =?us-ascii?Q?SOSeoqgyu9cQtzOEgjF5OSSTjvHmvwTcqZIF+gUahH6z/6VIrW99VisSPBzr?=
 =?us-ascii?Q?Y5rNbCSsQuHJc1p/v2A1Alfel0NRDT7JLxP7Clse92/M+QhNQz9k0ttuerlQ?=
 =?us-ascii?Q?8p60WoBUmBva2HUbw8P4OVA4xW6gcEc4QHNghMiyrllRge6X+k6KjP7oi4a4?=
 =?us-ascii?Q?ddfBOUr7W21UT0sYmtfQZma7xFBogTKNFu11gOMCAXBQ5gam+im5uk9vaQZy?=
 =?us-ascii?Q?QgrGLQQ3U1phH4hH3MjwcaOWSIek6w8TreJqu1AZ4l3VfRLJ1qb6GCdwJuT5?=
 =?us-ascii?Q?jl1LnEnUjwSUzbGyXHGFVGdSenWvtMDfSxLqMAEBPVCQ3UeCLuCu5rw+HGh4?=
 =?us-ascii?Q?+H6KT0m095KpXAZa1rAT1S089Inm41OVk6QcrswDqPEiQhhRb323mfTu2vjT?=
 =?us-ascii?Q?bQ9u0e4bR1PliydjcOVlfUsl1RUBIqO8rBfqQYpZ0CmiLmuYS8Cql/37LYoc?=
 =?us-ascii?Q?kL6JOqAKRUg5s5K/g5Hr3ZPMH5VH01DEF7naB93QT6NLu3c5n0eB8sp4DMEI?=
 =?us-ascii?Q?lKIzqsptd3yZlvAXDfCSV2xlXO79kEgr7DOFTFGyQZEp5+NvIz5Tm8tPcN61?=
 =?us-ascii?Q?Q8xVxRPNSOTYGSuSaLr/3+KBHnxNBj5sSDx+qXIJ244sEvSr97SGehBmrFuh?=
 =?us-ascii?Q?mi7L4xz/V8sGu4FjIOQmRFTvTUtw4RAvGhep6BEQHWEeWdlhdy/U6js6i1GG?=
 =?us-ascii?Q?eLGYb82eSS80Z9XCQoRn+jVGIoITmra0knKf3VCuKl5BiRO5g7FbgXCx0RoG?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 765aa722-7440-46a2-99bb-08dddac3340b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:28.5204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrgZn3Wl8VlROMkIilDTRroJn1o+zAhI2qDzijjo+nAVoIoSiF1bQ3k/cpvTfPHmbOMwSmYx5jUG9RQobixpt90l8dkxD/6jCeejq4lNEbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Alexander Lobakin <alobakin@pm.me>

The module misses MODULE_DEVICE_TABLE() for both SPI and OF ID tables
and thus never autoloads on ID matches.
Add the missing declarations.
Present since day-0 of spinand framework introduction.

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20210323173714.317884-1-alobakin@pm.me

This is a port of linux patch 25fefc88c71f ("mtd: spinand: core: add missing MODULE_DEVICE_TABLE()")

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.50.1

