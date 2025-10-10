Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F32BCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2478427F;
	Fri, 10 Oct 2025 13:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="UJGwx6B4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16925842D2; Fri, 10 Oct 2025 13:59:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41EE68425A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0v/18G04s314BN70DjSiLfRSx/MAQm6guA02aneFJvkGErDkB1e7CaLFd53GT+rLi/kyJIT+YlQnbJfTVpGc6T19hbvpEjM5mnJHIQIuhqbB+vSJa6dUMQ7zHnTlv7J6qcymzkIM4k/FdLp1qqI2ljou410DM9uqPbq0kC3UIs51YiOImun+q/f477B8njVHmZ31KxGuHvyToOp0DOrj9NZPqXAalIOQDxUaSCfUAtFkBAODg1ySoZOtukGkPm7OS7pojU/cXWZ6NCOM5Z4xL10taDDzKUhay4d7MJG+mutbWphejhlcRNjGie4M+RbPww2GFbbhJNY6DAZfUxU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxu7egz2ArcnIFKU+wwuinm/C/N9+iOmQOTLBTYkztE=;
 b=FFF4GU0pnYvQ77YQKVd9Fb8ZZ6/rHapfcUDRaoHdKLpcVtpYYUO6+y9T1Zz1zfdXO6YYXkSO2RnQzB6xjJyQGw9FIfNXpox9UQL+xgnt5G8FvDjbMbKqn0KVXvWIk8AiFWg2JuKLjFMWEX4QkTBTH3N34WhJ7KD5PPQeC1ip6VpFaGWOIJnv8uEoxg1DDu39wH7iQmq5EmBritLiaKmUkw6EvlKhTohibZVLhSEAtvbqD7Q/sHnA6uJ8p0LpzkeBpJ+u85p7+Q0WT1L32xsCl/W7B3/Sou9Ba8vSnkXTwYLQKysG88vfMbiQ7Mrs4WHniEPUooVWo+pLj1yAwa05DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxu7egz2ArcnIFKU+wwuinm/C/N9+iOmQOTLBTYkztE=;
 b=UJGwx6B4FJ/7UwGlHzSg9o2oA4hF/BcI43dETHQKjTKP6ne/nosqdncpAOWW6yl4A1rCE1j3RwwqWQ1jRwLGgWjqK53CDzbcx3WJ7qpOm9oXUD14Csx+64C4g9X46K2vhTl81q5i0dVq4fftKP1Upba06DPiPWFLRB4ugV9G16p/7YTF67Bt7556+jhytkTx+A7FQcBQIBzAoLOhuT7G1+qKoLZF+eT69KhbOHTOjQx/knPYNA4hd6ohTazkZHVW3Ip84oik7sj0RNoy2WSRMqS2V3B5vAFesM4pLjvJKAANAUI5KkVpk/dLBVeoz0m2M88H1thq29nXctuFhlkr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:58:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:58:59 +0000
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
 Andreas Gnau <andreas.gnau@iopsys.eu>, Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH RESEND v7 19/24] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
Date: Fri, 10 Oct 2025 14:58:20 +0300
Message-ID: <20251010115825.1531775-20-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7f66e8fb-77c7-4ffa-cddb-08de07f465e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lB5eDxMVB6VoX0QgmjctDCu05z+3AoJoOQ2auqkhfmfMxIdxDLqUloMoxKH8?=
 =?us-ascii?Q?pUZ2Ia5NquW2zr0RU1UP495jnFNO4zbCA5jwW9WQUES9qlEy/R4Vz3ANdz6E?=
 =?us-ascii?Q?zc66ytd8yPwq6ZNOdYj1MbkQX1hTkXlRqCRusRIHwtv9Slwbi+O0nZW0/QfQ?=
 =?us-ascii?Q?rmuzQI5Sc9YWubgbdlLtZBvwWF+ouAcoBcX+1arPLUy2RQSJYakPLuM6Im/q?=
 =?us-ascii?Q?44At+TuFqs9fWmXB1foHjL5yKzyL0loLqKa/nLIAclsBWYsx19PUUFPd0uZk?=
 =?us-ascii?Q?1cAiwcw4MAZoYGgkIuOXpm33okHB4sGE2bQy/Ww+7mk8Q5ByT0T5k/nrWqji?=
 =?us-ascii?Q?1X9Yd6zHC7iZc8YIRfMVOP8bG4ZY8JV3pbsaqXldpven2f5dgyqYVFVK2kZQ?=
 =?us-ascii?Q?pAYaQ+UYsawFUIAk+tB0SM4hpkoZMabjFextN/9/gF2SpFbs5fjN0KWuHB//?=
 =?us-ascii?Q?TXLCOvcX12fiF49GYLDY2SFjOCAU5p2oDc2rcfCZDm+2pbFDZLVMTzvKq2oh?=
 =?us-ascii?Q?yFnp/PeD5hSgeY+nHUDoByep9H38wsYdatoH/5FkKLQ6HkZI/R1zgyRJpr5M?=
 =?us-ascii?Q?RgOfBYVVcGxGEqV395H+tayyJbu5edaqf/hXY8VXDackXYqY7mY9VrIVh5+H?=
 =?us-ascii?Q?L0l1HWFDHmGLn7ekVwbYQ0ng73HiYbL4zxNyqjvQYw9l0nwcSo5XEg55ANKX?=
 =?us-ascii?Q?zSFTRplOK46Pg6UiZjol9htxD/nElwJJOUkFQ2KfdhBmcrhW+17CmnJjz5gn?=
 =?us-ascii?Q?tJiR2/cFvpRLo54dBKQtx9hU4FS7Ts0mkZuIPTPq/MZbFKGWji7CSHJ4IcZX?=
 =?us-ascii?Q?QW6+Q0a0mGR7zDxkblNfBxDCYhvrdBwqxTIJqs6X4hLJn08ncMY6NNwq1Y6K?=
 =?us-ascii?Q?7aVSq3DoJ0H27huWeL7KR/7PD2fGyEy/CFci9e4qyK+H+DIGx3EZGu1swDa3?=
 =?us-ascii?Q?E3vNaA6tMcwxCPZzhIMU3/dQV5Qkr1aGQyX8wL7DEXFpkHNeqoy7LVm9PNvL?=
 =?us-ascii?Q?gLjuBJtUSK5HXJTPXzXZIGQ2ruuGAdqLZjRbSraWWebm3aauIeKtgGuLWaBc?=
 =?us-ascii?Q?kQ09ofgO/H0Fn4ZKqs4t0ejBgsnmQUZlKYSLNXVC0i/CgEe9H1RLEwG+QqTt?=
 =?us-ascii?Q?tbQ7nrasisy4QLOq3FfE8I8zbphBpo2sjvfOj3sFbBelcrK23ByjPntA7t1t?=
 =?us-ascii?Q?2EiuAfvGIoS8wic9gIIxJ9MVxZiTs45mpxjSBR5b8dTObqEa8ukDJ1mJ8THY?=
 =?us-ascii?Q?KNW27DJtEXZwLfT3uEEo0P9UX2ByVhfJ5ARE5Tf0NQMC0Nu0EbVwC63bClOE?=
 =?us-ascii?Q?UMHO5AqqCpTBxMLx5M7J00bGRplmgh/ez06VIeVVfqNqozqxJkX8BOvNb5Pa?=
 =?us-ascii?Q?K6AzdDAF5PUG/G5tmoDgncUa//oX815WejMiZlsnD/VqyAUKdWNVpQvUusM5?=
 =?us-ascii?Q?x6qqNFM2dXe94anfChy5Vmy+itBaD/LlcQVwBjCG4Of/sn57fAI029TkNcnL?=
 =?us-ascii?Q?6TqUDZ85Ozplc55Fy9c2nCrk2VzIx/G7wAVSox+K/KWyVm7FwDd7UU/ucQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8BDvFIBFzTYuIK59HjYKY0cD5Jfc7ULpEfo8lE+YS6gkK8Ehh3xgtV01b3Do?=
 =?us-ascii?Q?A/k8JZlXDniPI5KYig4LIx93kmxtR7HsOgaKILMd8F1q9L5agv3EBoeJ7/rq?=
 =?us-ascii?Q?M4e7kQZrfMIKS8XeIRPPzz7a7T5+Y8iMPtuZl3UOaIQjG8uSOuiaTW9QU2Oq?=
 =?us-ascii?Q?lfUL2JeOXUhyeQB+lhw0peySa33Hs5Lp30OsYzRF6eEpG/tUVpRFnWruaotF?=
 =?us-ascii?Q?vUJk5L2KtNmefCqy4Nje9zhmvTZb82PiUpD20IesZ922MG9TVcghz+J72dV8?=
 =?us-ascii?Q?zg1Rom/8pKXv7nM0e8zPmSEUv/RepLMV3t6dbWgEyx0fEH121+BbBLAJjAxv?=
 =?us-ascii?Q?HF90n0NrpdooR6Y6YU9KImeN7U3d77cCpA3vofhAImPgflSuubdncDAYOqu/?=
 =?us-ascii?Q?12CNp1f45IR1dAjGZ58zLzxNOn0ol2aIPDk1MriB5hEhUb/for/mBr19j2R4?=
 =?us-ascii?Q?smcksSWux0INNdAMScc0OFDbHojBnWThmZR7/b2uwFhY0qoyITm40hHyB+Zf?=
 =?us-ascii?Q?pjsHE9HWV9Wvzb1VjyzuqRxJYMZ0FHJ8LoKpvmSkzzs8kmoAeTT1MIjQwzZt?=
 =?us-ascii?Q?KWFAQ6naSTGhqD+x4Ib9QwH293CiFm1Up8XJpuyQQhpLGZaYkAql/1pQcpvG?=
 =?us-ascii?Q?Pdxxriqe0muMhnfvZrtVqsba/C+Euc56Dsmp8AHClaD0V4JX3sQtzVVvN5y2?=
 =?us-ascii?Q?Tz1P9EP+IFUZUN/snzLFjpo2ZzB8lcz9ezJSFKOpGYdhlUL4svSsrQOWhIku?=
 =?us-ascii?Q?tAmht2tW5/0S0qdm865pzdIEts6H9lfVTCnAXoxc/vWzCC9KqnRUGcXwTn5b?=
 =?us-ascii?Q?fxxjtQexPs91KgBExbFEDNFlweN/wazr8eweyOQgEeC8KmkzwVAADJ8TTxm0?=
 =?us-ascii?Q?mKTz/oCIKwOP2vP+A0Ga6UWInryHS6OGyaaKm3txP7kIM/gl+QqXT041Fh5c?=
 =?us-ascii?Q?v81f2lvX+UWVrIEEcek2k8jSXYLjFsKrdV45XpCbFvPuu47wS26wbz9BYAQS?=
 =?us-ascii?Q?3U3RJNYGDs7FfV0oA8xRad3pCo1xszSLDpObYdymWwAmzZw/aAMyCyHZqa0t?=
 =?us-ascii?Q?LEl08EALmjqJQLzz2LV4Jyc/06yrCQTlFMj0mrInmF42aAl+YskEmJ0LuZCx?=
 =?us-ascii?Q?/qUJaP88GnpT1zT/R4fFmG05LEMgs7+NxIY8C/G0R9qep4yM+l8o7miifAFk?=
 =?us-ascii?Q?ggFQ2uykMRUWU9AsunFUZO7ygWT+UJ4aMjl7CPrCvmpFf5mYSFalUnCVN/pl?=
 =?us-ascii?Q?3ac34GS3oiBR2MauMqV9S/Hg++EMDSAfT+gF1hB+5aghx45Qy3UTD6UGzfXW?=
 =?us-ascii?Q?sBwhLUQJthzZSvgVAKn46A4BpjPIRZxiCFl2esyagiWlebEz1F37CIk5meaN?=
 =?us-ascii?Q?7kLu9TanqNiUcJlz4l7BtFCfA2Slm81Nh3oIKTs5YcvyWiJWiUWA0eTcO2hG?=
 =?us-ascii?Q?GabYHqONsKu9fRxHkcJ5Q32h66FrJ2b5GtGPo6wuUYWWU7OJ7sCdcJROL7FS?=
 =?us-ascii?Q?z68zOwe60Dftds0CGh4g6CH+xZrjgvCNxjIm7w4u3O8Ed4CeNm6XpjVs+qKk?=
 =?us-ascii?Q?AN6Z92d3iCerpty8I53yFcSCifCbgoGI2dEUwxQhfjes8sVKFenfPj+zCSAQ?=
 =?us-ascii?Q?csrjjzD8tTAMwp5EvlGh1go=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f66e8fb-77c7-4ffa-cddb-08de07f465e9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:58:59.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCO1xJMX30Uhf+moX8FyP4SkHy6s/DKaJrG4yCFjrDvdCSh2AAk+tAZARxsXwT4fiV3RZFaATeZ0LClFtvD0Z141clDo0esXapDi/XTGA1s=
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

From: Gabor Juhos <j4g8y7@gmail.com>

Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
logic") the spinand_write_page() function ignores the errors returned
by spinand_wait(). Change the code to propagate those up to the stack
as it was done before the offending change.

This is a port of linux commit
091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
---
 drivers/mtd/nand/spi/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index daf6efb87d8..3e21a06dd0f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
-- 
2.51.0

