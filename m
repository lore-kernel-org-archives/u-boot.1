Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EDDCA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EB280FA8;
	Mon, 18 Aug 2025 12:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="q6WjtW3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC81A82977; Mon, 18 Aug 2025 12:06:34 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8803380107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGQB4e75MXCRfSthbrbcKyp29cECWfP+gCYUunZcU0N+Zfl06fQ0XnQ+sbkCvQKWmaHICDevQsFFfM5sEUwZUndWwlX8egHWx6sL6+a0YKQh7M3MnEb89mO0D3R9c0PDMr+9793ff0T0sOcn4TmVGpjc8xBC5X7/kFPjQE8Z21vF+YN9jbNybxxfNtBIrV/n8F2HbcsrlroIebSkcAHsuaEk5AD2lhPjLcBMzvcsHnYj9HURVeZOn6oZ+oZFc0sI1UPqeY3+rOCTdVR+6miWrqEXdLKtG92syxJ72nD/6I9UEwZ3xxq8uc3Qom2h/Qtkek15hl1vqOopJqGVMEeHrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVGGszSoQy5DyOo6V5YuZwMBlZ5Hn3BUkfWRNvFYfaQ=;
 b=vUQYkJBE8Vq3WoRLalgHJEA4JCue25TEsZfB74EQ2nQTisn/JUFnL9/XzDN9PhsLauxJxRzr4NxfMRGAAGUu6jfMELgkoCpRu1X8jb2FyrpzB44CjHJfUXSrxlR+bP8w8VFjlV31ecc8nZjhqIP/lHug8idRdp8lRhc7bdC9/nEOpZPKUQeUarhj5nEj/AuSdg9GZCpzYlFA1RDhpjqznSHu6/DoO7YQBp3f4Vjx0qCo67flA6BdJVjKl7fX5M99u4ql4Kv8Q33O/6LFMcNnI8Gs3k6wRq5ggTX66YnOS4MThYBEs902YmYvppsYoGH291QoVGUtlgijrbs0ipyqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVGGszSoQy5DyOo6V5YuZwMBlZ5Hn3BUkfWRNvFYfaQ=;
 b=q6WjtW3YwGtLHrdAil2B2Xpto0FJPyhlCpudKqHaQUa2ND9avWDSefx2FHlqj8x1J393kpJDu37A9sXIopl+LoCah5755cm/gGnIo3+dSVs8L3HyJgND9wFRGRmb2TfOGDj6V/Bs99LgX2aSeQzxz35uToEWp4TEx2qzOGGaFswZEgJsPzPo9+hft4OxOcDmNsCk8SJWDMapcZKBVr50Ezy59HtOOtlzvyX9bUIPfAE2HDJMgnNnu2zV/xWSkaNR4fmg/uB70+d009hR5VskeDhbS2YOGlcEuAEQ1GJl2Tw9AViJj/e8rQKDwipxEG7pPCpjEx91hmUl0h98F4APSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexander Lobakin <alobakin@pm.me>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 04/21] mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
Date: Mon, 18 Aug 2025 13:05:56 +0300
Message-ID: <20250818100614.432931-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 46120be5-abea-420a-6866-08ddde3ee6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RCKTScqKYudsSRZ+6dm/btvpM0Zgou/Ac/JmMyWvBczxWrST17Qp74HONoVY?=
 =?us-ascii?Q?sYYVH+ZjxWTD3WE+m+g+fSG64/f3OcvK6mcBElKUy3rNKUKmL4/TOAGnIUn/?=
 =?us-ascii?Q?YPUwf3f/xyp0SQBgK5Kp6/yjFnuxoj/DbJmmPOy2JMSlmlijcDKgmSq9ncXc?=
 =?us-ascii?Q?8iI5XIOdJm8gIuYondo2L0k68iQ/vVGOtag2xYieCj5jZMjprTAOsow12pNd?=
 =?us-ascii?Q?Rd20BPst1gmeqeq5HbFIVcKNHZeEKLL88fXgUk6aVPJK9WZa7IOpFPLffKD/?=
 =?us-ascii?Q?cVVAfWWjBYsZrvK6jzDsMTDs5EKJU1r1sGdj9jYyVLK8zSPh6aUwEG3TfXE/?=
 =?us-ascii?Q?6ixphOlhPIaO7hl4LbTr/fYlPHMpTAnKqEwVvRJv5FvaAqarYBfc0Z7hQ83K?=
 =?us-ascii?Q?SQfdlBfFH+0VO5zFjyENzMfGxqwYmct7tLjqNDy+sLSasFjJDr6AMQkzRTh6?=
 =?us-ascii?Q?796VdfXhIsjHBxQjCij/TZ8A8qr4eU+PA4zXDzo1i0ot41TabObdx9t1g4il?=
 =?us-ascii?Q?nWfTBoLXo7EfERGhE1D8IqcByXhEFKoro21Ts3XVL2sgawIfEGki6S/iCUWH?=
 =?us-ascii?Q?V/gvZXbBaKvWy64IQyNuhXYe/61QrGI5xbHvC5OwtKJwbuKOlXXMwMsWXBGj?=
 =?us-ascii?Q?tlHAc1A7OzsjLoXGx0u2Ii247kspRH6r6mUx4/z5Qp9wyJ+10dxkK2h/Rh9p?=
 =?us-ascii?Q?0+6KBHbaQUMOptnEJLRZagcRclfr6fIlXsgGe7ahMnbf5g1ZEIV1O/Y6G4YO?=
 =?us-ascii?Q?3FEoYKQtis3ACm9hMgKP3uXgRXkMO9eVjlQ5nbIJMCaGSLKV+8mZrnrYVz5E?=
 =?us-ascii?Q?05YJ391GoyHplWxsunGAg/mrTuyem8pCuVcE9uKKIkFVlPeEbm4qrEbJd5Tt?=
 =?us-ascii?Q?a45WcO+YaspSNN3EwbgOKtjUN8PHmgiCyCrO2hGbUT90Pm2uTo+88nswg7GC?=
 =?us-ascii?Q?Hbq+EqqB2yB3GSwcdYibaz9dYWL22YFO0ek35ZXA/SmWS56T6rEy+ecAHfD9?=
 =?us-ascii?Q?B2S032Mq2Qd+3Xggk+VZkvJFas8SCNqClUDLNPddLEirVg0DR5JMClrdknHo?=
 =?us-ascii?Q?TemYAM07yN79/03dAkJTsV8tVg7jed0zn7233vJjrDlYM9GdDbjUcaJp0ABn?=
 =?us-ascii?Q?9ApAAB9S4rJCTcJxMtZ2YYKRXGDjFAU+2FCL6x3TtimLMmAMTbL/7ZkxhRk1?=
 =?us-ascii?Q?dpBlAMU0a8QEofYRMzqAbuqv/JJPTScnfPDBy9lo1vwp8/0kmziII7GpyFGB?=
 =?us-ascii?Q?mDtt85aebZmOpXYoOGYiWmot3/xiQhCjTpFiL3i6H31EQCUpgwVMt4pUHK3x?=
 =?us-ascii?Q?OT9NsiRHpYKjCSGpn3XWbQuTuBDmDN2mJX98rgwEbLE9EY+206PPSk184Y9f?=
 =?us-ascii?Q?z7izRNSzV0CL1/2gUGTNLSvgVHk/Mv76Y0mRX+0gLeildXEOTq7/DUgbj2nU?=
 =?us-ascii?Q?THYjwnbaLj7fy7guUZ9U0LaZvirY07uiZOjfbsFp5ZCoTI6vE7U44O+Nw3cS?=
 =?us-ascii?Q?BUdA733sIKe/+GI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7LvalZH1J/LAHyBE5edQdANCBk5y52tOsUXOBtPb+WP2lhKzmnqAQXavnbxN?=
 =?us-ascii?Q?V6DaGfQSxrPxreFoaiK+DIUQ93ro+JqIdqXmFkaEJQmcwdla4yNCLsGFlis+?=
 =?us-ascii?Q?Xu3YdV/tgsCf7w/PKsWvFNSjqxlvhDA1r5BKEid45KAlEYpaIJ6BMlrzqEpD?=
 =?us-ascii?Q?5Ly7B6baDJDKX5VipMGgeQdyB3lavd3PUBsL271YqYk0OPFUAP8wRSsNM3Oz?=
 =?us-ascii?Q?iblFmC1eV3J4sg+IxSPhqV29NNO9z6hmPEYB651BTOXIWnZark5342R+Gm4n?=
 =?us-ascii?Q?Hyj/ygziBEUeKE+47TFbniun7OL8TIjvKDALx166lOo2xy7wB7NWY9cdDszV?=
 =?us-ascii?Q?3G9jsLh/tSWzbfZtqcwUkyyfHOG2X9KglNBhZn6/vW/8bPnbJvZfuQGB7D3T?=
 =?us-ascii?Q?8xDYFfUkkrIB4oOHpXbNknDybmL2kXEv8DCmYgSPRbZ54yapLGi/pzK8J4hV?=
 =?us-ascii?Q?AlYbdEYPRQovlq4RDj/HvCbQaGI8cKoTAH1q9oy7KvxPbw+FyO7FYE6YCDU5?=
 =?us-ascii?Q?LS8wF+ehGJZnyYah9DSt/GFFOSk1rzqtYu3aWILxpmxY8sa6L3nI4NnxaFG8?=
 =?us-ascii?Q?r0yHKlcMDVjWCQiMA4NoMPeRPoHgoDgyZtMzImuoke5xRORbBGU9IvQXcR5Q?=
 =?us-ascii?Q?tkyhT/8ptJdYwaQwUPGKiddHfOG5zWF6TFu+ZmwqEqELffzXrgJJLgTcABod?=
 =?us-ascii?Q?kwkxkOuYHc8/GjHyXjV6K5bqsepZ7mFQPnZOf6nTm4OzmWavUW/yN+vpQK1j?=
 =?us-ascii?Q?tcqBPUX/dr9jsGqXwT6JNfS97JflKEFPqBWw+jlWwVHEGbXemX6JlvlucEvV?=
 =?us-ascii?Q?vHl4zeblpBxyOzU4Y2DjPt8qlAZN9RgGzV6m/6nXJ9ZdCJU8OujoGk6zgwgi?=
 =?us-ascii?Q?xhzQndJFzEHxS6IF+Vb2L4issYJP8XiyO0seoq/AmpA1bwtwvAEZ3pvz8bQ9?=
 =?us-ascii?Q?oW81Fiz8xhSrhrEdND4UpeF6yZ1+IzKsHzcjzvqsvfrle5CBJHOgFWG7cKnB?=
 =?us-ascii?Q?bw6SVhN4me1Pn9e7xWjMQZZWcPuQgk7V3HrZTJhJnS4YMtw7ydF0liiD44Mg?=
 =?us-ascii?Q?SNu1SGfkgoDxhAwoR+L9q+Bu4RlvSE2fIUjyEGiQ8WNbX56U9tHSaQiz1tXB?=
 =?us-ascii?Q?eWUrqwZNjZlgZJ+C8lMsnoDhdZSlyUQo760RO70wgc5wNTYV8efORwMTvpFa?=
 =?us-ascii?Q?1f3BzvTOpovbtqcnvq+owkB1Q7+j2mZCFdv/4LBr/2p7ymxALBvr3196N//n?=
 =?us-ascii?Q?NcTtBfEWqmPZ1qYRj3ynaipZnHT6tgaL5JJUp9J8pAa5QIDqRSnAiDNja5m0?=
 =?us-ascii?Q?XTw2oTnCdf/AN6qJbT0a5uV1XfuT2uUd6zuMVvjSF+cV1x0wEQoi/lHjpIng?=
 =?us-ascii?Q?6HhAYTO+VT5OkDYVMfN+EVHhaAUN6E47tcMh1Z6LF6Y0mgk2skcv2fK9cMhT?=
 =?us-ascii?Q?5XD/j8zW/cC0kL8US15CvCVNo9Npp5G4CQo49MkpfzkNB2olcKHp1FioK8h1?=
 =?us-ascii?Q?bJh2QljSFOzs+H9uVKrbQcn5ht2yzANtHO0Ewxoo4JUKmyhnIHdsgt8vHR8Q?=
 =?us-ascii?Q?G+lKEPtg7PaSQutaoWeWv+ffR13q/QS2l0uZ7EUrvJJUnzKaF7j8eKs37r7E?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46120be5-abea-420a-6866-08ddde3ee6fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:30.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uAxBZvVEuKQp+F1cWHYbiJIhxg+46Pg/r7AGyY25AdmPTsnsntOQIQlCTWhR/wkDXVo08vldYkDMjC+96cIoQ+nTATNmyJF2CUjqC20ST8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

This is a port of linux commit
25fefc88c71f ("mtd: spinand: core: add missing MODULE_DEVICE_TABLE()")

Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20210323173714.317884-1-alobakin@pm.me
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
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

