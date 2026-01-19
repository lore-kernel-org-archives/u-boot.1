Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E226DC9830C
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358C383015;
	Mon, 19 Jan 2026 01:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wWzKWpyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925B08307F; Mon, 19 Jan 2026 01:37:04 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F28F83015
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xf7CWeGEtB8yeDbdkkgpbX74QpluHebW1alyA81Hopxvo4lnPudJcWRjk2mE2cC5eHldX4Ku+k155LIiM4lMBXRJYH+yMzKCx/JFHFeRxoTph/YcE9gZT8zAs+soWkzEqkkX/qYSVdlyDECITR5CnuAXPE2//SnI45bLO7TXkTNrucQ26YXvGQoX+lYHM+b2JQ6z9mROi7OKIPROX0gYGPuzZYymMIeLzrbJkcn1eKw+nCDv+B55fvKaOl/rabzwBsDOB3yj/nAcEU7mOG/hQUwmt5luIbE7DRiAVemkT4AkewI6/bPLV0KTUy7mfORIUZtD0tXbp1eutty6/Z2h6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/t6KRTx34ZFxOUmE1hTFbb8Ut9HKir9A/os7seLxGU=;
 b=P/0hgDe3TLFvLJBS5qVB24w3DdoQxrLG2qktzLgod1pdfUNlscFiPlPE9/ALYeFTcsclBBS3eSLS98K2FBiik4n6A7V5mpM1sMCxkvn2tyJun4LGANyFNgyy66W84vO9/y3t9O++SbTq58Wv6uDAj6C93nBMeOf71tFySjoDU48/fE80BqyiBw9Oyv9znVNQN1Z0MGosfhdIiSURh8jCZ3S0hBgODq17bsBMcoYad6vw4K2vOXHJ5NHjMax7htwfLA8iZB4WeP7HDIxwJrns8eOaMo3yP2qSe0UtjMFPAZSi8w1X5nKwHcSOOtxeMrIAocy1umz08GsFAPsm9XgRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/t6KRTx34ZFxOUmE1hTFbb8Ut9HKir9A/os7seLxGU=;
 b=wWzKWpyh2M8PA2vNcveeH+N4hI5fkxHEWpcQeVkUJhVTaOIBxsF+DKo2YntAU98bK/SWFrwQg8lOgGH/Ou184annUmYyKXDIDfaJ4+87MmqFTght7nvAsfZRmNtF5buFr6ZVb0qB5OCgBl1yTLKYhSJJcRtg4dSvJ79tOpjdnfsIPPJFQTwrdYBgkMmKxn99ZeYFODYagDWaYZ2W0/pZSs4+eLCG9xqYvYYtGCYN6Tumho35opNTyWfPlCa8sU6RHrw/KT7huYzrOHS1Y2sI+6daOUWB9bQ1lVZeHAld9egB5iURzwLKnyOhGGgCWTDCNocne2JuxUYujbVZ9NUnaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GVXPR08MB10761.eurprd08.prod.outlook.com (2603:10a6:150:151::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 00:36:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.005; Mon, 19 Jan 2026
 00:36:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] mtd: mtdpart: fix partitions searching
Date: Mon, 19 Jan 2026 03:36:06 +0300
Message-ID: <20260119003606.748561-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0031.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GVXPR08MB10761:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f8b538-3f39-4e01-0908-08de56f2c6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5uG+cuPAzs0JdrOy+vNelT9q2lVsE0okAq/V/WZOYJeUxmEG4Zbri/9pvZJ?=
 =?us-ascii?Q?GbYzBsCm+BnczmzRHxd6APX3PUl15gn+f8z+wkEeFTfu3S5b83haFKGxNIV7?=
 =?us-ascii?Q?Qx5skzSPWwBOdakLZDC+rcqBiHMVBDw7LhDdPgddiBUUgXFlgUANYpEfsQhG?=
 =?us-ascii?Q?QUAm1T5ZHEN4CEYPRSsF8WhifdEoNe9m+iWBTxPzkJGCbcCNxBuwnK/RJMa9?=
 =?us-ascii?Q?g1XHARPU+dcb5Tb+IZVPFXQH78XyUQyWXPrcXLQnqWQY8+3kKcV5zKxhsNiI?=
 =?us-ascii?Q?8sA5oR0sJ7Pb0uKfandFDeZ/zgBREdYWBsmCC/KFqZkVRxPMmBJucJJNlXZ8?=
 =?us-ascii?Q?JfPnT+NSnWa9EksfxeQzIS/bBfOjEPZr5gGcSVQ8fdTJeAzAFunsECRUVUmF?=
 =?us-ascii?Q?D0lUkSe0YAtznHjgIbGeS5EVaKzeu3z0fz/BEZXAGY3XinOKznk7+GjEOeYC?=
 =?us-ascii?Q?AZAEvV9UMPwtaqhRgmtgB80l58yO/OxXS3gD8HJioNdPe/L2HzsgGxYRVYyr?=
 =?us-ascii?Q?Hmss/ZLt66EYoirDmyb2Q3HVrpRvk8jHtoe70ObDj5R/l+TvFChoLci4e4Ce?=
 =?us-ascii?Q?6+dHHlG5jVWm5IJoCMn1CH2Y60r/mC6WAOQZ0fUSw6zkhjbFp8cNOIU0atAk?=
 =?us-ascii?Q?svbcFDMarMT/XYAoXVhvZZVsokIzgtHj0+hiZDc9xsjUf0DkoHcgB845znr9?=
 =?us-ascii?Q?73PnJQQG2KB457jycosAFnG4fMFsr1zYOg88Ql4gkk+fRZ/uFX9D5DPEbkT4?=
 =?us-ascii?Q?DaWtVC0P0kie+Bln6OVosIGfjEoOhGZhXdGa90Ft1WUG0QkwIt/Z/VPlUaCK?=
 =?us-ascii?Q?YIqjNGmyf959G4U/tBVncN5VQIr1ARDr//1+lYbBnbzxG1qd5kzWBulkbWPa?=
 =?us-ascii?Q?MaTPLWzLAbGv6U+orxoaVQ+1bjf2YfwSCj6z7dxGHQQT/nfW3lnt/50CfwlN?=
 =?us-ascii?Q?pCO8/J+ytaVugT5R4Ah3bwIFjnMlUUnst9BVaCOHFea27HsZlwDbPxyj3QtB?=
 =?us-ascii?Q?XJXvkPGCIklWGJ4fLnPS13XoSG1t/QU7L8jFRa2tKJ67WLGeVXWklqPDBgcB?=
 =?us-ascii?Q?JeVqPvPCMKSldSbB4i3SRiQvNeqte8VcFtqTZVCHkps46Ep0rXvh9OsBoQMO?=
 =?us-ascii?Q?rzch7AFcXJgJNZO6rSg8oFcSfuKG/WWsABzC4E5/5xaIXHRQ+6pi7XkXrEDz?=
 =?us-ascii?Q?9DyRxIHKofg/9KBZq2rSdT7wdFAQENNJknQBVRVB1i4Wlly5IS80FHuaC6wI?=
 =?us-ascii?Q?FEjRXDASlVbxbrU8j6Arx4jTJ5Dno8CJHrrYiMHHL3PxLqyJJtguGzC8sNsh?=
 =?us-ascii?Q?Cs+Rs0s0zh7WYmN3bPewgXP53AA3sF/akMu43f70X7mD7KaJLKW7aZVwVkb7?=
 =?us-ascii?Q?7ld6zxeJJy7kSpVpawUf1PFx1j7M2qc3sZA4kKJ7CySSTAO6X8UJe5bchk3w?=
 =?us-ascii?Q?LMuAchaSoipA5eOkRvHK6TKeWiYRFuTmSjGkTrKT74AQ6oFlyvS4pO9Dmbma?=
 =?us-ascii?Q?LENNaWnin/qm06myj9jrnN1yJfsD9Yvo3Cnw58SwGPY0EbX0Jym7YYOtPio+?=
 =?us-ascii?Q?epSgxKzVVTdwxN4rd5TbQ/9yF3I2oXNwC9ZNZlWBeHB9YMIcCu64RTbn2R8G?=
 =?us-ascii?Q?GFONzwVZSRJi1uqe/qACLw2oDK4QSm7aoHAKzGrMrL0J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDY5m3STevI1BQTsEJyrlgoWVTfudTSs8rGdyrQbskDkyA3UvxY26qbs3ifU?=
 =?us-ascii?Q?MxzbRxntd9XaG4MRJoXUrZQSuWMVj3J9e+erOF3m2k+gyUkf0p5Xk+XvVr4g?=
 =?us-ascii?Q?44k39u3FqDiPlsiSlkI3tnYaGzaKx/IHTbEeJIsW2w0l+9o/nP8gIceYBhRa?=
 =?us-ascii?Q?1J0sFLn0ozwmV2Ce+hkfdsV1Hul+jeDrFErAeq9ONQwEnie7/7+GAmOO6V9w?=
 =?us-ascii?Q?R9g6z2ZTNVAKBPSs7AWh1sIyj3jtxFXGz2ZpOcLAONoCJ8RYiV4YXe3mnfP+?=
 =?us-ascii?Q?aCzueyv/NKotj3yBLaFPIU24i45I856FX41KL+tpgv2HiC6XccqKcROeJyRK?=
 =?us-ascii?Q?ZHsj3Xl6azRCX1jB3t09y72/13lK8d6035b2utSpqVrU4H5z6puba51ItmG5?=
 =?us-ascii?Q?FRy+Wf2a69+h1JxaTgwH6oZnt8hehpvaVWD+uTte9N50N97XpGB3nZ82Bxpv?=
 =?us-ascii?Q?eCry3QpLzHB7BHHYFRnWHb0MhxEl/Ilwgnz6d4B5ocZwgabW7XdoAXa82CCt?=
 =?us-ascii?Q?DyykZLR91z3077yWWIOrZa4dMBhl3mojMjWLAa650sJf7cOoaSQpNeKZLKM6?=
 =?us-ascii?Q?u3je7DIEnnOfHxxBn6nimpblv1UFNOpmcrZwMEbWbuFfC10OgbxR+4R55w7n?=
 =?us-ascii?Q?rTZ7cRWh198pHLBpshMUZI0yGxONWJ4Mc3JGyKA6bixGSTKM3I1MtD4fPT6V?=
 =?us-ascii?Q?f6Fm7FcvLlX+Bv38tOkIV/7L8X+LNO2AzCjvXb5fhqChVuBPASjmo205S1sr?=
 =?us-ascii?Q?hoC+xaFl9xJMcIzxHP/eOU9uUUG0hY7CNTb58oTJYBjYs42CK6otAzuYq2/Z?=
 =?us-ascii?Q?3/uV/pLm9fNpdmVeJdaXvYwGr+j6wy5n7d284/yeDxg58J9MscZ0uk46CE1G?=
 =?us-ascii?Q?iEqaHUyxkVLoY7FQGzZWbSUGB0RUqdHwkkD+WWu3CkUMiIDpnIL9okysDwe+?=
 =?us-ascii?Q?6DZ/ccvafk7F6/w1ejb4M614uGQQ5dYQUnUnGHFBNf6hL9ZQr/ePJAE1KxFQ?=
 =?us-ascii?Q?vfkg5lfwjhwObRbmEpo7XjxbT/IHcRu2ZX9G/so8FEG/xOrg9OlEZoOsmqPX?=
 =?us-ascii?Q?4GaG7vg8IuVSd+l2WgLRCH80BXOpzgTLaas7A45GqOaW/3GTeLHABZgN0f5z?=
 =?us-ascii?Q?NH+aVBNHky3mXG//iTOgANXos6tcFWWqg6aY23Dz/okOEEBv2KQ3rVIRFkl3?=
 =?us-ascii?Q?AHjMkdKo05ziUq3ouXOY5VLN6WenmF0ZJ9fx0KlwtwVmbfFWDC9FCMCQ7xKl?=
 =?us-ascii?Q?cLm+UY6eBGRfKkjTTJaxdAe9/wpP9fMjZvXPg98rSFOwr27ug/8dncGSWRkN?=
 =?us-ascii?Q?ii+VG9SLaewFacn7P8ePs9mdwau45bXf6qjEwUpU3G3jqcIuagDybWk+YGNI?=
 =?us-ascii?Q?r841kUBncWcIJKW+Yz6X+rFalJP2R8qy2dKyUKQpX+iDTXSw8gIGlSHxXBzp?=
 =?us-ascii?Q?9Diif2+En7PiCe9N1rDJgbBJthMg7pJSVT2SWviS4O6nrHMvYLudv9B4Lnh8?=
 =?us-ascii?Q?cTzOTJRTfKIbrr6JlV6+YQnaxSOor0C9toS7h0SqYQm+lV2I9NvE+5KznGt2?=
 =?us-ascii?Q?CGEarhauZFZ2JQADWl1WuP/6Omc8Vf1H+hw88vVJwbvrmIpaU73d3LgCKPV7?=
 =?us-ascii?Q?74E7ujXBgoEmzcdX2pxR+y4zJxLgXQZJxR7GXBeKABFoXMr11PClgo22FN1k?=
 =?us-ascii?Q?9uu8N/TFe1SDtC5I0ohzoqKJSAljo0bDyvCigOxeo+TCY7o6N8bF3PcPw1vk?=
 =?us-ascii?Q?cNIUfSbdGEzI/W+WX9JG+2Xgpgr8y30=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f8b538-3f39-4e01-0908-08de56f2c6f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 00:36:25.5014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvgvAQaewkmznoeHFyZz7TlpAWbPtFuYvWWo8yObwQcBF/pOQBziMKOwTjeS3i46K/4StZvNaKcm1MQ1PkqjiGkJBYGGKxssjbM39TDZsLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10761
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

mtdpart internally enumerate partitions starting from zero, but partition
driver API enumerate partitions starting from 1. Just now mtdpart does
not take this difference into account. This is wrong.

Unnecessary debug message also was removed.

Fixes: c29a6daec184 ("disk: support MTD partitions")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/mtdpart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 842d3e7274e..0bd4b3db022 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -1067,7 +1067,6 @@ static struct mtd_info *mtd_get_partition_by_index(struct mtd_info *mtd, int ind
 		if (i++ == index)
 			return part;
 
-	debug("Partition with idx=%d not found on MTD device %s\n", index, mtd->name);
 	return NULL;
 }
 
@@ -1082,9 +1081,11 @@ static int __maybe_unused part_get_info_mtd(struct blk_desc *dev_desc, int part_
 		return -EINVAL;
 	}
 
-	part = mtd_get_partition_by_index(master, part_idx);
+	/* internal indexing starts from zero, but part_idx starts from 1 */
+	part = mtd_get_partition_by_index(master, part_idx - 1);
 	if (!part) {
-		debug("Failed to find partition with idx=%d\n", part_idx);
+		debug("Failed to find partition with idx=%d on MTD device %s\n",
+		      part_idx - 1, master->name);
 		return -EINVAL;
 	}
 
-- 
2.51.0

