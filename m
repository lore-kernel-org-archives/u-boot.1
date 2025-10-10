Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9B1CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D721584284;
	Fri, 10 Oct 2025 13:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Ev4ZPx4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BC8684248; Fri, 10 Oct 2025 13:58:56 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A331E8421E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4Jp5LdxBntzQhzod//uOeqxdMqaqyhW3l168jc24BVmVOAUTW24mfDEK+NGD/4nJlkLNoKPQfXhDt36FWu5d7T8HWoOkKnZ0FwDKHLgtfIJ5kUQ/kBwp/cVbeHngxQW7pWoczJmNF+Gl31xnXcz2nf+PQ3Ogg6PdcOJdL468IHuvb7/UWG3SFjo8rvlpcEQq+dWNVPU7hcuA02e3PvajGuQy66V40BTtutjPCnrtGLBhi4YSbnOLn0WZE3kw2vyFe1V63hTpSeXYx+uj3GldyClxhKW6PwuHIo1OkfpQW3USJRsvtat/lA7O6cN5GmE7B3/X6teBWk9LVy0Vxy6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhWTkeGyWtKq8cGSK5xl0CQFx79z6h1ivIGEdlieiy4=;
 b=x5I0pNNHRsLL3O3V19XM3gYMB9fP8EOZ0H+4+o79B2f7jR0V01J56tWl0SJN3V/+eJ+gCHD+4Fq55nKxYrzDF5EieLjlevGpGlekkOcDAdX8g4qjJLBmylO/qyWBykbt1+YJp5VvQI91J09eVqrAjuWV299yjdNHXve7heVQozWrHJ10Y5g8hsVwnz2+CpN/BsKOZGFW1EgD24s0tRFOf6ivQjR9WxqxZbRGi89t5z24/ijEpOoTmTncshqHYjnebHJIFJmIErOhnWQ+AXu/I8+gwjvTmaCrxHQ87yr/qFvAgnD+PUqzcmQTGqHmll1YGxZGCDlMfBdQPh9WPZF92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhWTkeGyWtKq8cGSK5xl0CQFx79z6h1ivIGEdlieiy4=;
 b=Ev4ZPx4FZ/kyzodwJagOGb+izzGBpVUEMvOP85EAn/QcHzGG/0fr8UfFKjfHHiUtWj8jwgRS9IE/Z3EnH2wnh/s61JU7iMXWP6QzDHsf6pLQTHUOsmSHAtPXM0xmhY2YURfg8qjrcalhOF9+WPxqE3bK1E3Cjhc8okQ9AYKOMVxBBNFnHp0xYMC9qdgvSgeN4494thRd72oAltcW8Sd5R1vhAi/ZeYYUUo+gy8QqmYoVq5B08YSjqW67tw9O7Oy/hOjnNEWbt3EyFIFClRTWB2+XoPFjmAkuAJyT09q9wwnQQeJ49sfv6ovHmg5KT/b+XSdzeIeLemAKfv/pGvaaAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:53 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:53 +0000
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
Subject: [PATCH RESEND v7 14/24] mtd: spinand: Introduce a way to avoid raw
 access
Date: Fri, 10 Oct 2025 14:58:15 +0300
Message-ID: <20251010115825.1531775-15-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 84372eda-3d73-4ba4-466b-08de07f461dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CC623UcgCsyNnROVyDqLk4YbiDZQtHxMLiiKi7jMnvK9leD6TRuEWFsytchW?=
 =?us-ascii?Q?5xGOZZLSVhWwSnhOK8DPJR8gSlCVhNd/GTocqfm7T6q5hOHbAVnhr4BGYzT0?=
 =?us-ascii?Q?RGzkkewHWJ/5B10TJkusUznB33tYCxVDuei/VhzMwFFixXHKbRLK+IRijb+3?=
 =?us-ascii?Q?vfYRLgrgkU4jPwXZDMajbCpYVsFZNfV+UNLb7au0vBzlBxJFIF2IEaqipf5J?=
 =?us-ascii?Q?ItGMJK5f43M2eYDKu43AKRCjLmoV8IPtrQV9hmQBq1ZE/9l5uhJ7OWxnE4h1?=
 =?us-ascii?Q?kRL7XTkAlSxuCUIcVQeymMoYWRsMlDpGuRBYec0Xge+023q7HMlyd+NFm/7C?=
 =?us-ascii?Q?pbWV16QZ4GAdG4ADjf1Rq3u9rowlk4vufGFVCNTBQpIPCsIwnYlWqPqeUkFJ?=
 =?us-ascii?Q?XgeJxKWqcaydXSIVuhkZYnFDqPLPiuivQvu/VTA4ltJDQXBalabrym4HGUgS?=
 =?us-ascii?Q?xfMMRRcQI02R5HjEHODUDnyJ8K8CUJ92yfN023diS5VILU6F02sGCzldAeAc?=
 =?us-ascii?Q?d0y0brNgDDseOB1ePxC2lwPSsEe59Zk0eCr3Aqa3hUBg/PUxv6y5wykPNZV+?=
 =?us-ascii?Q?X9xQsJeJWNcu9MGxfN/ism9sQFjSmANWUSAjGeXkgu8CTy0m/Cc65INahQvQ?=
 =?us-ascii?Q?Zu7pQANurnQ497ysKog5LdjofS3eZvycQ5urAfhBQhTEzlXS8QCXK8e9azfF?=
 =?us-ascii?Q?NSOjvrnOSSehjImHnhyHlju69JgBBAvZQnypEmAk7OucVgBt8kBuJAFYf99S?=
 =?us-ascii?Q?N0O5v/7KSiK1Unu7G3jcsTb7UjLS7qODZVaoWdp0sPJM3FolkjDWQtQnrN2w?=
 =?us-ascii?Q?sxhlQE9GaSm7xps0AdNlnyLMVLI025TGAS1SDBsUnK3rG86yonGlrKHzNyfP?=
 =?us-ascii?Q?0euJQRyS9N9R35TgBeR/axdvOBtAZB5/o7Kj9zbfWQpYpz/KfE/p7RSfjdmS?=
 =?us-ascii?Q?RBRw0s3lvja1dpq6HVRpkQPEvOXIrP51lySwYmncnRuG8xXUaVJRULZgn6Mh?=
 =?us-ascii?Q?kj0q3ns9RMkeW5aBWlsg2YlVJ8xXeUch7U5bb8BGs9qN+79rVr7CHYgPsCmt?=
 =?us-ascii?Q?LlAr7MbFqRnv3+CnAUMW1bEvjrxudGGqLX5aMELs0807OZsTjdYjxHM8RBzo?=
 =?us-ascii?Q?7O5LV2VuH8D316aCZlFEMg4DQpzZNocxLP7mwhTEnKkNdohmnkC3lP8/vpO7?=
 =?us-ascii?Q?eWc8Gqrzc9EBEiyXNTsBvsvFxsI8hRnI8ft9d7KePt1KY+ZiivGzzqHMgtQq?=
 =?us-ascii?Q?UlO9w5X1y7AamfsN1/pXurTqpGgA7oMt3EKC2ZmS33/WDXPYqzxUVMgmWvXE?=
 =?us-ascii?Q?dZYeG9Fekug+dX8mY92TjFU/HyQYFGgOd5DjocgBMAdwhwMRq6Tavzu1aJZD?=
 =?us-ascii?Q?+G0pu7DWra9zmvgz2/7pELLQWs/tooloPrxnW2tyNnf8gF6fTYMTgkOLeIZr?=
 =?us-ascii?Q?zol0FCT69TebV+02nGBaY3DDJQI4lWEUCliMLgEMl4Hs3mWiTundYeIrykrv?=
 =?us-ascii?Q?CuGsdD5H2TILIeDQQ5xryi/bxzxkSCfM+Zap+WLqcpog0HM8QCHGawSVmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Axq+ZFRxSfjuhiY9qiPbYDDEDRuHkcfbzuB8trRkna65MSYgrJJFUkYR29fR?=
 =?us-ascii?Q?RDZMLkulT8RsAcDN/cFCVzdNvYXKtdfW+xB14rcSJ6/Myzj/4EHuQoeSQecM?=
 =?us-ascii?Q?feMaFbIuNS0VwVJEoUfcZiFx8KQpQTFnZCccIDihh4QZgYrJnrMtgTTwsQL9?=
 =?us-ascii?Q?5YGBnc7f+g71uzH7/izC3ztRKZzvzh33oay/fY53PKOduk13lPc2MOzI1sd2?=
 =?us-ascii?Q?egpBShxM0q5rKL5bkfJAk5HF4c2XLqxs5mtRZaUWsW5HhAOdWiSAdo1xqU8I?=
 =?us-ascii?Q?Hz4w1C+Zh29y4bCcM5CuxaiC6WRdB6bXoM+bfLdtITGR6pQF+Yl6Dem/P8ga?=
 =?us-ascii?Q?Iar6SCASknWwFfnKerDaLT4oRqvoUh4b4qZkOFeH0oWVOTcIsqh/c71ix62s?=
 =?us-ascii?Q?bwGX74NWxC91ieV5Y6XjEjXH+QNkAtrn+OgqRJftWbN9s152P4WksKX4G/WK?=
 =?us-ascii?Q?9GMHRrObw6Brlbn/ACExZWys5Sa17BrTqgMI80UtSeV0H8t8ZNxyVPKYo4wz?=
 =?us-ascii?Q?RTmro9fbypOs8EoTh6TReUR6KGLEngUKzmEKIoCogJL0wqW9e77W4wZD8xQf?=
 =?us-ascii?Q?Psq/aRyaI7HsFZOyAMBqebEBDlH14E/Gnf6U4NKmQ+r48mksIl/qF68BMN54?=
 =?us-ascii?Q?feK5CnjXcLrOv+xTGxvgL4QoVlFUmxkazqP3muf4cU6hMeUTzXoxPitsxDp7?=
 =?us-ascii?Q?kbBwlXxlxumKKlKI2pnugJjHub+TlEYRwStM0vcOQLSikg+JoZu+CipJ2QE2?=
 =?us-ascii?Q?zNKfQh00p2kx/ZbqwI0S2dNUdu+tI5uMh7/D+nnHUG2TAZS7sl39x3Tqtc4c?=
 =?us-ascii?Q?YU8cDBdjNmrqWjnRPeCzX96IT9NMk3UpeYQQEslzpTnBWQOwwHqrvWTeUhqV?=
 =?us-ascii?Q?ZraAKVdvQMUZqlkbXUD+ZMwYKRuB94FVHVJHUqxfjPGW+kjI3CiLJ9Yz2chm?=
 =?us-ascii?Q?deJvftkdli6AbQtRrGQ+m/dI/oTLAODNu32FoTKsTlgsMIqM+Np4UTeq0bYe?=
 =?us-ascii?Q?+yL541N1hzH/hwFDQjRQ67WW6mXu0U6qAPBWkpEjwFpdRT4j+23J4tFhzMPA?=
 =?us-ascii?Q?V/clJAhlQYbd6LJJjdZiZMoWe9RJrlYfo4IV+UZPMn2i2s/GMe0MpbaRndnB?=
 =?us-ascii?Q?L8ftfJYm8d8p/8A2ZK7be1N+foTH9/E/TDNj2BXr4EL9azMAII6O8tEAo0dC?=
 =?us-ascii?Q?JAZgJb7I+dv3JFKyLHY1MRiEe8bO898IPUy5vrsp1A+nHwCZhL/5u3aNXy15?=
 =?us-ascii?Q?kZI5u5cGZ7S1ifoaomwqchlUMPfq4/wLWY2AlBdF5fN16UjOmxSf4W4y0Xdt?=
 =?us-ascii?Q?gA0lbW5H6sxU2iVBk950fFjn0kTGPKADznbQqeDYrtbjnvibEeRh7un+yrYZ?=
 =?us-ascii?Q?V6tE/RAO8bEIVIM+g6okhXPGHOmzIibdgPOkP67ZwIJETWal48PJPef3PCJ9?=
 =?us-ascii?Q?5kLZHcyRl+fGPluwvdsDiHePFP5EK5itEdym9dF/Cap9GMmHkcGO5Kpep7Ww?=
 =?us-ascii?Q?4o5/mEZaUsSkHUSPx7BBXD6oGSXcgs6VkjQzErRrtGmLYD1FqxTvj+MyjxaM?=
 =?us-ascii?Q?7ITHAG/1BnA9ueyEwF+RwxNehGNjkpoVwWMa5qtOQ/cKb/CJGsQAEfXvrHbe?=
 =?us-ascii?Q?I6JYnCc8Ts1WL44DBxULR0Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 84372eda-3d73-4ba4-466b-08de07f461dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:53.0633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI8kixf32FNUTxPZF2nIw3akhDbDvvC5J9lavIkacuYYFWX+/DHXkHUwbVHVC65G9weAScoQ406/RbbDZlXSmGz7H60MTaP18iKxSaOxveU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

This is a port of linux commit
6d9d6ab3a82a (mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d0c9083a5b3..c04e82651fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -749,9 +752,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -795,7 +806,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.51.0

