Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7669DCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F952841B8;
	Fri, 10 Oct 2025 13:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="sXXNX7Vr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7DA83FB0; Fri, 10 Oct 2025 13:58:47 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4EA2841B8
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGH7IPUs/oQD4/uvbdcAZEtP4KlRMex4I0pbXo4IDqNrt7Vosealgbd3md3VizbaMdU7x12F/Pm94xZyG88GAg1tAaJ/Uuy1mQe6qPC7u1CZ7HAkb6jCfnu84KqYYE0i5rGa/ClTu0Y8e0Vfy0u+0PveG3oD1J/y5EJICTkrTJ+BBjlbJTzjy/eGqdVgop4x4VsIl7SspPzZIHvm8+OfX5fHaaLr2hng1qLPiPSdTDAcm2PVGmuNaXH/usziKYvCm5ChXfymm3X8re4EWYO6dTm2cuTwlKMEpS+qE0bgN8AZYfQNmiTxXGFaqjBd9SX0jV8/LSz12fKYuhANL6r+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyqkra5Fo54Gnr98mnNB/TfZabZIYjZ9C4fUEkuynpY=;
 b=ZkUxVnmt4r58a6FvxDXN+wf/Eh3xBimd+xKc8W/d7zJCJb7z0K9GWTANkQRvqemnSqRDz9qDA3buYSEpLgkpzW/6QZ0DQI0iNct3JXf/b1eMIjDnRM04+0zSzPkovE0wEKlUdR9s0JXypDHQGM7fJHA4jt1vQeBJlUlo52BOm0h3oOQPgi47ItuXyuPs10OOaOeAOGpj5zDYzAUDZgl7CS908B6DZKB7NZkry4+vcx/qPq1ngJAVHNms+4pKlZH9eTV1mZmUiy2x7c2VIspRU8wezM7PSWrPfAgDBfHXWr45odv4kWEdLJxlCyx/Ah69GUVes7c+v8ZNTJA7cdULRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyqkra5Fo54Gnr98mnNB/TfZabZIYjZ9C4fUEkuynpY=;
 b=sXXNX7Vr64Pe7o5gEMn1xu27HZWv9YzEtlBcAXWmw+PbxfhmWe+LcZITcdAnDETwn03nLvoLVJ6bG44VMdp7itrdMNJ+x8jqPlQ+fUF2lGaQfldZSmaHKSslSi3SmM1g2OUACSFG9xVSwpCouKQf/000nhdTV2wEc8+0Q45yCNjisTYx3aib8tQV4rUPOiHaS9Pmsltzg+f3XUPYeM+vIFbQr7xzNqPWkCwU3V9YixZ11KF9bp1NxsOH4Jl9acYDqDIA1d4BfgwKGdBJaKM36OYPLJpoMsaA8YBT3Y0K1s8z9wRI/FCn+tk2hLGEgBz07+W/0pzDDhHBBC5ufUK6VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8464.eurprd08.prod.outlook.com (2603:10a6:150:b2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:44 +0000
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
Subject: [PATCH RESEND v7 08/24] mtd: spinand: Refactor spinand_init* functions
Date: Fri, 10 Oct 2025 14:58:09 +0300
Message-ID: <20251010115825.1531775-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 2d1ea3d9-e0ca-4d51-88e3-08de07f45cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ews5sa9jpw4dC0G1V+bPBrb8olPLHCiuQjkVhwzPLaiVfhImAxhHWOSFez5/?=
 =?us-ascii?Q?haSXNDeCUXyoT9gM1iUZphmMNj3CwubygVXDXntgcj+dj2gXWwqfxotx7TF9?=
 =?us-ascii?Q?2pZULRciOAzlyUhla94oxYM1BUZWzPJK0tvPeQGhlVajXqELfi7YJzk5mQ9h?=
 =?us-ascii?Q?vZW7NUZv+cKRI4o2Ah76yyVeH4RWu0PCjoVdqMbaF+zbFwRFsJj+PG119NaL?=
 =?us-ascii?Q?0hSAd/LXTazANwDoG/ha+XjriX2uv/V7nIH8RZseMHDnoePBUp+uXKVJpMwR?=
 =?us-ascii?Q?PQ7U7gLNG2rRmp0tPGc0N8jooY/I6Qk7eHIzCUulmVrSbg6cWOREJP2l06Ft?=
 =?us-ascii?Q?wW7i/RQBl9Wvpv1Q/nS11S0PRyJsQS67vLL3LdO3Ik2+AYgZasR3O5wxcRTH?=
 =?us-ascii?Q?CoBPs9S1d9I2Z/VbjYw4IDDy3ASKXdn8gylEJMcaWZzV6Ul+pw22W91UEiMO?=
 =?us-ascii?Q?nrIInOMwkdzdUnavZqVrXq6rsnnopHf491+1/9ln3vb00HoIub8KOHPzk4Yc?=
 =?us-ascii?Q?ochGH7MD8yoNqbh8YEyHBwf/tFG+1j9wpYDwQHxujL90rHaJtqf30/IygN9E?=
 =?us-ascii?Q?LJnHSQ3KJmETLMTBaRZXkiD1+29JC1sCIp8YuZNUjMhQ085cyjUt6wEfMIyU?=
 =?us-ascii?Q?zm/H7rP9sDsQLrvkymalE0sxSkv+AeNjhqgkHl7PdntfiKFyjjFm3q+vpg21?=
 =?us-ascii?Q?S0YwAMwrNKqgUCYTnMKpFQmWxp4/IWh23j7gzw7vCi4fDocjrVL3bVHjgMFY?=
 =?us-ascii?Q?94hwQ75yS4p/usnbsYJ0yzllQej1oL3PbFO8pXoDlgk6oyBtqq5CdE7AYmrS?=
 =?us-ascii?Q?mlwdMDxyLfnp91Zgo+58hyDnpjLHk2lhDrjiWOtbfLfZwnY7zlHkD0HGKp+I?=
 =?us-ascii?Q?l83uYC6FmFTIFhNR5pB2nzxd/5zLFk//SBNQzKSaHuI26vutHAaAndyV4zrL?=
 =?us-ascii?Q?O4hxrHfOmBuSGDC7f2bVdp4HH3X7di05g+NpE77YyVGsq3a6uJB1U1FqBfkt?=
 =?us-ascii?Q?jIqRGer2hfO3yn/CihNCm4z1tH2F2dSY/64SXU6h6NPF3Jq2i0feQxM0b853?=
 =?us-ascii?Q?9oCs3uZ1cq9s8hj4qda7wx28oJXlLNAI02I2i2oPe144VTozH50AQ3ol2SgF?=
 =?us-ascii?Q?6w3PXx2Xe5JkoIj3wPOhD4q4/R/gNRiWxeEzpWrPT31JFzYsAcxeamC22uei?=
 =?us-ascii?Q?tvRqHlKQdLgegLBZTUEdfU+JqY9EPV3/k69lO+c9SZHUulPrgcaJVRzBVtXf?=
 =?us-ascii?Q?hjgG10HMnhRkLP4X8BpGhYtkBAGeRa/BtBWF3ZbMw4Su18uNbs5lbLdI7uPx?=
 =?us-ascii?Q?/4s1N5TwYIkE5rraDumRdJ83NIvmIobOk2NTCZwwUsnjeYscrnwuBGMt121o?=
 =?us-ascii?Q?ayJBcfUljEAH5l4b0pJj3MvoS4zdFZJ/51QAVm93VWz5uzpnQ8UoG7eBpT3C?=
 =?us-ascii?Q?y08wKRqA/o8YzguFM3KPutyR7ShXyej/Atq8ZxpYm0Itzdf5/f8Uo0hHGlwe?=
 =?us-ascii?Q?XNMC9IJcVkXeJhbTOUNVNxE+38FnpozgT5/5nnREMK7GQ/1iFzFc5bV4CA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5pWVFspde+wiNVPnwT+qPJGCRR+8PLDpNF/TeHFpIFJLjTHVJpgzC8J1BOAU?=
 =?us-ascii?Q?tBJbLrYLqWnp3FPyc+a4SZJdhVqHicBu8bN/hWiPHtmEzYgQCOc69tNNSKZ+?=
 =?us-ascii?Q?GYFI0Jiv+pOpM3lUP1towZb72AnGfZbF3r3df+/rCvYsTcTROSA73CA39f4u?=
 =?us-ascii?Q?K+7yDotXPn4I5EjXbVrksrCdtdBuzvgIAp51QhzbG8DD3Xz4p2ZH4BOajMoU?=
 =?us-ascii?Q?16KgvyfkYbuQMuwif92FaKl/lp1YJeE8eH17Vy0pVwO8R0Hs11ecS69vDXJx?=
 =?us-ascii?Q?9/lwy6g41zIcMB7ZCcppB8Zg/kdnl3BickarS9CBq581zrX7yj5j18/aWUT3?=
 =?us-ascii?Q?7fbAYf13DH1oDkGS6iGEGZxEu4Ca6EI6zj1PcOmIWNphQXcByJBZXN4zbjfH?=
 =?us-ascii?Q?kQNpFabxpcXI3IbnQuEu7VgSEpO1N1kuK3KhGwZqlIDOjFABxBcbayc0WNFN?=
 =?us-ascii?Q?p5BPxkHgKAnMa7Jbw6H/lsjqIDRtJNLfJ7mSbvQVR9R+P5EtzcLGkrWG59R0?=
 =?us-ascii?Q?IVRpKABPi1PwGHUs1NXqGw/M3PsZByv1ZxgFWChmqakdWyJb9GnnrRNChyro?=
 =?us-ascii?Q?G4yK45OMutRjUyFfsffWYoYwhXbxiIbr4a/mmiJEr9NtfSWNTbSLhvvylg7x?=
 =?us-ascii?Q?Ue/4PdFXiUo9BZ/37qd/2c/RgeGK8N6xGYPUaaF47oyZ5K0J76xCd2Q21GzB?=
 =?us-ascii?Q?0lKiRGdc83FmzWVKa9k5m7x7lEuOn//q8lLYAU1PL3MPzB4lXdxdoCEaZXgK?=
 =?us-ascii?Q?Xr6bnILLSt+4JdO8b+eaJDcTR7mM0SpZXdRn0TNgKsqy1pSAYILgHB8LEwbt?=
 =?us-ascii?Q?flrXB7/FOpe9oQkhoLfurCkLgNNxLePK2bXpgrIZr2dKMJRSwpjRnXhmwsM2?=
 =?us-ascii?Q?Qm+GBtORdMusMavxBTXX9ZxRH9bp4Exsp18ZJBe5aIy1cfidipGwW6ZS80yv?=
 =?us-ascii?Q?t3Do+Mgus0U/fk30VE8YMV3iUOgw9bQLzlI9/jnNlF6VtxK/Z1y+eojViWmJ?=
 =?us-ascii?Q?0wBe4Urltejq4enU344fKRCnCeQ8bDK0uXcmVBno4cZcbyMYiOjm0tUNqKUB?=
 =?us-ascii?Q?t7NTHS5A648NkBU8sAtbAttc+YoLgA7trLQum+U7VuRAHwz4nvO6nODXNhxK?=
 =?us-ascii?Q?BUouHQSReOaiY2xDtkg3fOKn7NeRmpi83FaqmkIJIE+2wM2Ew7lfbHqzL+8r?=
 =?us-ascii?Q?ibtFvW0HpOnlkdkjASH42H/2x/BU7fLY3evLbR8ju9Ma2a2WC3+TJM0Ki9+Y?=
 =?us-ascii?Q?WqA/MFHgz1DuSHGA48f3KGgrXdFeQ/cMI4UnTlt5cmPeRjTY7kfnwNVzi31e?=
 =?us-ascii?Q?PtZzu49sFDVYfNEKnZLOvp+XsQmV64hgE5KAW6e0rqn3Nm8CBibLuLk3YwCQ?=
 =?us-ascii?Q?zRH9G2/aMOQGjGdJeUpNv4fvEJo5xpTBjIw8GGk7yhoTXttaaaZB+3M4sQpg?=
 =?us-ascii?Q?d+N5gV1bTGG95aI1cB2KtOpv/3oKvSOLa+ItJUS/tZ0saLDE+gRl0o08uhYz?=
 =?us-ascii?Q?urxgMt+6HxG+kDrKg7HTonoDhcsJtmPWgtmrYgmHV3y3cSVzWjwiw/MTSWTK?=
 =?us-ascii?Q?B4t3VKY2KhlaRQnLcv3EBa5Q9aD1c1Kfm0Mf7mIn/9Ga8TvzUdGcI+KJkgqc?=
 =?us-ascii?Q?paFXD4JgdWOuJ6zx44htLQY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1ea3d9-e0ca-4d51-88e3-08de07f45cb5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:44.3574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJX/9DxQ9kUKiqY7LVcfCPQ0ZSsOwDux96b+24V3jZu1ceg9T4hRlzdUK/cK75VgmtI3q7spkaR4NfezJR+xZdHfw0blE1lX0njhjn4H6tg=
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

No functional changes, just some refactoring to better match linux
kernel driver.

changes:
 * move spinand configuration reading out from spinand_init_cfg_cache()
   to separate function spinand_read_cfg()
 * move spinand flash initialization to separate function
   spinand_init_flash()
 * move direct mapping initialization to the end of spinand_init()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 112 ++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6d80b7c6d30..9b48bcba496 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -160,20 +160,12 @@ int spinand_select_target(struct spinand_device *spinand, unsigned int target)
 	return 0;
 }
 
-static int spinand_init_cfg_cache(struct spinand_device *spinand)
+static int spinand_read_cfg(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct udevice *dev = spinand->slave->dev;
 	unsigned int target;
 	int ret;
 
-	spinand->cfg_cache = devm_kzalloc(dev,
-					  sizeof(*spinand->cfg_cache) *
-					  nand->memorg.ntargets,
-					  GFP_KERNEL);
-	if (!spinand->cfg_cache)
-		return -ENOMEM;
-
 	for (target = 0; target < nand->memorg.ntargets; target++) {
 		ret = spinand_select_target(spinand, target);
 		if (ret)
@@ -192,6 +184,21 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 	return 0;
 }
 
+static int spinand_init_cfg_cache(struct spinand_device *spinand)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct udevice *dev = spinand->slave->dev;
+
+	spinand->cfg_cache = devm_kcalloc(dev,
+					  nand->memorg.ntargets,
+					  sizeof(*spinand->cfg_cache),
+					  GFP_KERNEL);
+	if (!spinand->cfg_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int spinand_init_quad_enable(struct spinand_device *spinand)
 {
 	bool enable = false;
@@ -1103,11 +1110,55 @@ static const struct mtd_ooblayout_ops spinand_noecc_ooblayout = {
 	.rfree = spinand_noecc_ooblayout_free,
 };
 
+static int spinand_init_flash(struct spinand_device *spinand)
+{
+	struct udevice *dev = spinand->slave->dev;
+	struct nand_device *nand = spinand_to_nand(spinand);
+	int ret, i;
+
+	ret = spinand_read_cfg(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_init_quad_enable(spinand);
+	if (ret)
+		return ret;
+
+	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	ret = spinand_manufacturer_init(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to initialize the SPI NAND chip (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	/* After power up, all blocks are locked, so unlock them here. */
+	for (i = 0; i < nand->memorg.ntargets; i++) {
+		ret = spinand_select_target(spinand, i);
+		if (ret)
+			break;
+
+		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		spinand_manufacturer_cleanup(spinand);
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
+	struct udevice *dev = spinand->slave->dev;
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	int ret, i;
+	int ret;
 
 	/*
 	 * We need a scratch buffer because the spi_mem interface requires that
@@ -1140,41 +1191,10 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_init_quad_enable(spinand);
+	ret = spinand_init_flash(spinand);
 	if (ret)
 		goto err_free_bufs;
 
-	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
-	if (ret)
-		goto err_free_bufs;
-
-	ret = spinand_manufacturer_init(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to initialize the SPI NAND chip (err = %d)\n",
-			ret);
-		goto err_free_bufs;
-	}
-
-	ret = spinand_create_dirmaps(spinand);
-	if (ret) {
-		dev_err(spinand->slave->dev,
-			"Failed to create direct mappings for read/write operations (err = %d)\n",
-			ret);
-		goto err_manuf_cleanup;
-	}
-
-	/* After power up, all blocks are locked, so unlock them here. */
-	for (i = 0; i < nand->memorg.ntargets; i++) {
-		ret = spinand_select_target(spinand, i);
-		if (ret)
-			goto err_manuf_cleanup;
-
-		ret = spinand_lock_block(spinand, BL_ALL_UNLOCKED);
-		if (ret)
-			goto err_manuf_cleanup;
-	}
-
 	ret = nanddev_init(nand, &spinand_ops, THIS_MODULE);
 	if (ret)
 		goto err_manuf_cleanup;
@@ -1201,6 +1221,14 @@ static int spinand_init(struct spinand_device *spinand)
 
 	mtd->oobavail = ret;
 
+	ret = spinand_create_dirmaps(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to create direct mappings for read/write operations (err = %d)\n",
+			ret);
+		goto err_cleanup_nanddev;
+	}
+
 	return 0;
 
 err_cleanup_nanddev:
-- 
2.51.0

