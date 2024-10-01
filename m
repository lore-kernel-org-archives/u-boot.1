Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFDCF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 20:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6091E892A1;
	Tue,  1 Oct 2024 22:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="gAVpkzfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65703892C6; Tue,  1 Oct 2024 22:44:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D51892A6
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 22:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxlTQTrFaNNguCbP9aHek9d2uY8F1YWINA3oMQyw0e5O8bSu9tIqSGCVBx8uj70T7a26laNS/nz/27CKdq74njovn/rlNCtqdD++JQ9YAarBn8gOUB8V9MhZp2KLV2DwjutzkMWm5R4hTOD96n259/qtpKMLcsVvqR3X3Sdb7fK4K0wfCuVw+lZ17rEZmLMtL6StbceJ2Y6d6hgOlE6Ii4IXMrmo/obD80HEGqh84G9jsWTDH2yG2lvSdTvnvUri8rl2AyPqlBebAhq9+krPU2MaDs7L1/HvX59WAoiFJKZK6AWgm12IOd/AH0atvKq5dRErE0aC/z3hmIwVe2DfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzsgTtBBhFwFichKnMzvvJMvJjAegPEkOJ1Xx+b0T80=;
 b=TfaYGbIDf6IG/5cqlzzyzU5vYML6CWsdYv/kgoeKHJCl0tI9nr/PVdzQkbbjAA99NnL3K4bx3dSg3Gc0FKMvlwJwiq26eoy4g8uEk/yIGwBlc3b1LwBsfcGwuc1FRGTjs0qBtTY8aKQqyKh+9pR6BZS14pjg4Y00TNSMh+HPg0aRxwFyASbuHpJDXHNj9PDpFreJpTu1FheuJWu4GdJeGfMnyaqMer96hyVfZfKP+SUfPIRxXR2GcmtSkqEuVfPjXzCN5/EtIoEPJ7rrc50i+q0fSjHXtGK/FRjkevs01x/+0rdi74g/ij2BXx2n1fGmtor/AEefoUJJ6IuJvS7Egw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzsgTtBBhFwFichKnMzvvJMvJjAegPEkOJ1Xx+b0T80=;
 b=gAVpkzfqm6DtaZ7r6bokUT3DVTXCpOyqNl7znhcOB/aIgcsZ8/qtQkI0IR4C1aYPgOUYqpGekvPJWNqPM38rjBgiVB61gMWMchWC4hU/JeRjFIzHzhbz/G0lNtVC7hMcuq2rT1Xf01PTCOu/MmcgtZtllZM2WUkDkS2BXQNwETw0fpm9lTjtMXWNl4+r93iVCcZTlKMWGmRclWoNG0c+AMt1EvLYGiyff+lk8kV9Ickli+ZxQOgI8hcIE7lyNFvX3bMEoXPu7GS4VxLae6mkXBlDixSpNH5GXdusft2D3J1vAaC/eWJ98cOOjsz6YKbvA8Km3C75fX3drHSpI9Fp2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6539.eurprd08.prod.outlook.com (2603:10a6:10:23f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 20:44:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 20:44:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 William Zhang <william.zhang@broadcom.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 03/10] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Tue,  1 Oct 2024 23:44:35 +0300
Message-ID: <20241001204444.917238-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001204444.917238-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B5E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:16) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3905a2-d229-49f9-3a31-08dce259e86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3SkW8r+MfcPVuO5OIRPgh9M/fVjVwiT+HgofCeRlftdI98SwdRl5b7hk0ddz?=
 =?us-ascii?Q?VjXDPnz15fKAcFKV7VyIbl/30M7b/2na+pfADuCQBIwyiLJRchzTv05uASZt?=
 =?us-ascii?Q?+9C+gp40TBFvURPYiTP2whbFDhz3W7KvXtWMv01t2hUsyNkdi1ycO/cp80Ob?=
 =?us-ascii?Q?DuFEcNoisZ7XPnNVWFerDezcOy4ToNxsB12guSBMV7zFaFmlPrGF1zHm32qc?=
 =?us-ascii?Q?QbNlSRLKIKJ8TqlFG/RKTKvBUB+fIIruDugzLxkqGQr88UJgyXbuLXkZS7do?=
 =?us-ascii?Q?ff7JcOULpp21wad+LtM5w6NNGBZkBHyWMTHFyDsc69wb40M8OVLxz2lcyOmF?=
 =?us-ascii?Q?553Oz2h5pRopc5PrPlVrUrW6E0W3es5xc2KVkS80Y6UsnsFBxGJZktGgx8zJ?=
 =?us-ascii?Q?ZlfyJz0pcOKGyi8RX+CjBPGFOI/u56QWlCLn4/i80KdzVA8p4MV0uDGs6wdf?=
 =?us-ascii?Q?ZalISY4MppEj/0lA/i37pZzNnUhsZdTEr2NDJ4lTlrpK6eJMYZ5mFsbCGcxO?=
 =?us-ascii?Q?A/ZBvHrEwtSYkVtQESWwgLWLU4YU3691Zx+9NHnuhHn80TrhO4BFz4OQzAib?=
 =?us-ascii?Q?VLBETUHMsZefR7pmPsVJK4kYxF1pejQZGd2w/s2JdhEi7vQN4a+U7XyVPb2p?=
 =?us-ascii?Q?2Wa00/2sMdwhmBfcyWPE4aU/hKWnp1Fy+QaQpvMdmrmUejquvZKfTw2plWc5?=
 =?us-ascii?Q?jb89QDpLiI4svAgIR8ZLpD1YabdP+lkL6giO8qPD0xtaIaXcfQTnoNnIVUSu?=
 =?us-ascii?Q?cqoMwovTe+ZNtu1xC9jXQRqRJc5uyxzQl5Tea9BYiJ3ZRW0LRsFrCsrOaX53?=
 =?us-ascii?Q?MsQLrcbp4T1a4UpnA8u0X6lxcsP1dw4u6tC+NVV50DRU+GNm+uCoFYgmAHbG?=
 =?us-ascii?Q?iK2JJH3Hkhixsa6tJw8n4DGX9H2bc4sGyKDX2+46HZyX0R785yOK34Q2AIio?=
 =?us-ascii?Q?BBXhh4FtiP+r7UZPoDrC0TttoPaVDKYXLSJr1ev62UWgQWrGaKKv9y93nOYs?=
 =?us-ascii?Q?nK/8uW0hPtfi5D86wc/2RQYTcc3E/WCwC+kBKPoVoxeT4E3u8w9bV/2uxxYz?=
 =?us-ascii?Q?ZNubbdJ7LShIbkaQ+HE7Giv2baIOEWMduxAjDHhEJ/JDLHU2ewQOqk/XNrTu?=
 =?us-ascii?Q?BAJke3YYrG6X/ebWBEUYeiYiBWOelIV/nTyAQmQqgAIPB6/gVumnrxbxitJf?=
 =?us-ascii?Q?Jo4JoI/xemzE97DSKCv8A90lTwUN8D388THSyXNtcBciKuXsvZkfyK5CCN6i?=
 =?us-ascii?Q?kT12DDParJ8NLRXRRUOuwqOXu9LOHSWTpNWJjI+KNca0OutJPkojUGleMJo8?=
 =?us-ascii?Q?bvF4Zv7rWepLTit/PzMrnZPSy51r6rS2EpQ+CaSSUm4ljtui/BWWfleUm3Xv?=
 =?us-ascii?Q?wWuOIeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCqjY3b6gb1DkbzPhYRL44g0lc4mKnmnXRoqRv0NDc07DafXknxImGKzrZ4O?=
 =?us-ascii?Q?2ZeSYDm/UaCD/Ks5GCCBnJWpMcHuzBDceR9K5jPaXuNe32OQ2qyW6e43DFB0?=
 =?us-ascii?Q?bK52HzcQaAa2Gkx5UvZ0RpvEtyxq/T21O0K13Wu/1zxBrPTfcFkzvqsks5HZ?=
 =?us-ascii?Q?u0ziqYr3veewtZI/wU7NmdvsvVylPWFCICYoxAUvradO2Lo2UMSsl7pInOh1?=
 =?us-ascii?Q?tuHUq+krUMobZn5H2JG+tFHwdwj0baWPqPMQOTN7IbVKvnP7HiR/6IT5WMoD?=
 =?us-ascii?Q?k+rKpv57z6e4dR0q7PX+x0uCUnTUHwFShDZoMx7p387K6NxEAv6Gn9YBFCsJ?=
 =?us-ascii?Q?/aVIGZ4W45K27fp6wpxoO3hAu9jDAbFjnkqFIdjHBs+89/l0wiz+IurfpYM5?=
 =?us-ascii?Q?DjGU87iXDyaekF2IikwI5UppEPHeV0cdqGnO4sg+byfyQ4RaOPGUgiQAVi83?=
 =?us-ascii?Q?2vhMbjQX5jDPUrVPYW5LEzOp2Nz+Y2cZURuNZIGHYO2dHX2xALpxr+TRD9f4?=
 =?us-ascii?Q?fYd5yey8sCE9hRYhXZtjNQMZc9+56M1GbCNVZlm2dl379vZu/wd6OJZRFAjp?=
 =?us-ascii?Q?cSgHP68McMWhogCnZpplCs2gDxZp8TPBmxMx6UxxZCMDKW+do3WyPBO49QZ4?=
 =?us-ascii?Q?oZ+GEbefzWmHjkWGQoYeY10eemfwK+NOuIPI4cgYJgQ/1w9/en3HlqgutBCk?=
 =?us-ascii?Q?KG0C4ZowcB9LURnVcMNRe3Oxt6uCxowWUk8PoP02WM2fnFxCIrHLOtj2sqDn?=
 =?us-ascii?Q?MSsayfbAWlxqNiJc/0EAwGpysucgfGzsGIu4o16TVTaZ3eDBn/7JC2blc4Sz?=
 =?us-ascii?Q?KqiSDjBjKQjzItuhH/uRYWmB3rPyh5TfLskVfgWGdC6gvcVMOVfZB7PkxPXp?=
 =?us-ascii?Q?F5enBJXg0VtSofwSit4l3atlf8jga1DxugeVoZA80DVB3thX6fGoOpX5Lh6w?=
 =?us-ascii?Q?Dw7scqfOA8NvBrUQBMOT7KpCtvj3CLp3daKMLGAVIo+9iOno+EjYdYXEgfjx?=
 =?us-ascii?Q?5Eh/MrEpwJ/XlpgwVpSEPyzLMwIYWAJOS+HIR510/HDw64oaa22a1eA8Ehua?=
 =?us-ascii?Q?x8xHhdHsQGNneLMOX5NTqlSLoaHmf2jHDP5ShzVkCB2JNdIdW7VdI8MN5uW3?=
 =?us-ascii?Q?0kXgrvXgxu1zhfbojHby7vl8lwEfr9/EdVFJk+VhHYDp4puUc2Gjamp+fend?=
 =?us-ascii?Q?g0AUnUMwLoAyciPwLjwc8vjQp0JpSvEQ/sSRLuTkBrjwhGNRcxsCpe5v9DsL?=
 =?us-ascii?Q?gMn2jlTMo4LWo3lZ34IC2OPjOzDxAzt7ne8UVFXTl92dMsBibQqEEI/NoH42?=
 =?us-ascii?Q?64btlCJ8KVr79LebeK68+F8Efl2+M84vG/NMXwNvgvVaRnfyHb92NlHL07hV?=
 =?us-ascii?Q?+UGvHvhLFhBgdmv73PBPDOKK2uM9hEB+4ehigFVHgmJrY3YFgN030EYtoLnI?=
 =?us-ascii?Q?JVSbmhmkZj0j7LMFubwG+3udYH35a9ICz9WBtbiBbb/+422PX+8H3v2Sy8nU?=
 =?us-ascii?Q?+UJ8cGq2FUTkW6vSPgF6o6XtM872/xDuO7amRmEM4U/nzpyOG8Tf3FV5sS29?=
 =?us-ascii?Q?bPibJNsbkIPmML78FyKdvtFVlGTEPZ96cwW/CChoPYmX1tkgdcMoGuSHf2kc?=
 =?us-ascii?Q?JITfAhWLGfh2avaqxd3sNnQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3905a2-d229-49f9-3a31-08dce259e86d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:44:56.1106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3Z5N2MJrv0ul4zbbReOPRh9OKghICIL9Ln5htw9B91IKwNuAIlnJXAklz27S7yXGE9E5XLiwKrMtFMgGSvn3NfrqV1PbdbZAW2DJoXBDig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6539
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8f227ce81fa..62779dd3e51 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1267,12 +1267,14 @@ static const struct spi_device_id spinand_ids[] = {
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
2.45.2

