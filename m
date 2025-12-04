Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D26D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6369083B8B;
	Thu,  4 Dec 2025 05:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="3nb9vrqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9752F83F39; Thu,  4 Dec 2025 05:14:53 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C8583B1E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzzcJZCYI2QLmgCGVcAhpjmuAiwe+lx+lTUGrdLY7H96CIKquDoY1+Fmu5EMURJoWSxX6SaAcP+sRIfIZiw1c3Gva0lJS5M6gtBmCJe169Chh9jTX6NPEVodXqXfyxlY8KB/SIl9E0apNfFtS+iVN/ZZUqoMT8c76fAKzXj6+7PQLtbN2fdHcSFSwn8K5/Tf5P3acUs5rklW2vu8YsGk9hp0kFcBOssuMyuB5TQYUMHtDBnglU5T9yBxW6JScjZCfkc1oFQrM7s6Yoe21sV+YaM2N5bWedYPxbnGCNghzlUlKHpmhMV4iDMwCxALgdfzAgkwEPoqFdB4zNxn23kXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02y2+JJvi5drU0RwKWTr4pHDwHEX6kIA3GUOIFc4OCk=;
 b=booeGPaaR16yGS4pQfMHdUFjy7m55bDx0TUfcYiX5a4tbttPSAK7w4TJ+eo6WQjS3Fu3NFeuX0rQwXiU7NTlkCDdzVfO5sVk7nhu0mYaA9y8SI+dBQCe24Hi+iIpSlDq+6hnCL/mVUmCv0w6dapRiN2nnyFjR2fA4Y0T8OrzNqRPE8l3UhfIdv7Ibtt53km7bIQDYIuQSCwHsubghsRchXTRp9LaxeuIT13167seh5WpLzl+Ebo8eiuqI/awjb158wRrG5OMAy5QxJPViPVgIMzF2cCWeNF2gwTEmi7uHbvb78FUmez9Hnqvd4E/nfyzzTuiYxFd2mnKKkNNNuztKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02y2+JJvi5drU0RwKWTr4pHDwHEX6kIA3GUOIFc4OCk=;
 b=3nb9vrqLoir1DMOICt6CA5k/EPlaCnekKh4L9rfvygkUS0Qhc3dpRq8JnQvPmeA77L6nuudYce8kGvwnsg65OKrhxukUyo4kte7YzAKdyFpWSMFdHE7iIlSiSXc8itF03xR891p6xbUJIDNeYlIeFM8+JgxNkRxhManobBxaVsUgqBwJXGG7Zo4ZLwip3JX0lBXwXMvvXR1hXQp4xEcK1kKeAsWFrjgigk3ot6kZc2d7pIyl3rWznrDH5d3RzRwoH30ZkcQewznymu4/BnwqCVaE6izBkqjtnP5daNvTfz0dWPekBRHqPozRElFamLK7reglXTtpba6zxGy1rnu23Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 05/19] net: airoha: do not call airoha_fe_init() from GDM port
 independent code
Date: Thu,  4 Dec 2025 07:14:19 +0300
Message-ID: <20251204041433.3459826-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 69168091-04cd-4ee6-1892-08de32ebab0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+EyAUywbox27gOujBxKaYU1uP9eMn2ku/VRSC4+SxXmv8Qtx9n7vMqti+0Jk?=
 =?us-ascii?Q?opiGmimnLoywTmBtINxvrdN2L1ySJL4dhueoZpuFC+uzF/y2yCGkceC+bJzo?=
 =?us-ascii?Q?dAPdEluyistQktDqGzMAQf2VQkwNNmvqnf2byL96tZJRUzDP8WoeKo91fE+I?=
 =?us-ascii?Q?kciFuU0HljESj6lh1N3wmUTFq2dBnGO3dUBzNao3Pnc4FpXlv//iL/nLHxOe?=
 =?us-ascii?Q?PFmde3L2wy4kVl8VFTMFwK6ZIRO2yxyjLgrCBOjEMDJqtlH/qUec/nedQPfg?=
 =?us-ascii?Q?YhvVW78aximANrOlqm3Fm1IHcfRSDbFZRIuTm2XgYhIYo5OJSO5SUK73kmpo?=
 =?us-ascii?Q?qySaBa3QjRC0+IBQr46boDKFVf4EhB/0GtovjQqP/EScYJZM6cf7u19kjTZn?=
 =?us-ascii?Q?B1ltuht022V6undqo4eJxF1J/TYY3x4US6MhiVI8uPEOKr3bHK69kuFqla5K?=
 =?us-ascii?Q?/MgpgaGvS9M8RaG2UIH/8fB4UWTKBsw6vWk7GBj24eK3aFA9mJMpm40YvcNi?=
 =?us-ascii?Q?aWaK4AP/oOpRY635pjU3VtvnitBMTf36X1kx6aHi5SR256yay+3BIei1pZE5?=
 =?us-ascii?Q?pjwhZkyqvX+yS6JDjiEIm9LO9Bbae8jPBBUhYrbpBSen/r1gRpQRa/nl/i6c?=
 =?us-ascii?Q?oDiUwSb5HuwmtxbmyvEHqatz6Wtjq4mtz7ZH73YHmmi7dCkeciMRM01/0jpz?=
 =?us-ascii?Q?QRDt5MOH83sON5t8CliHGfxxFebcQVokohTT1FYMjCC3vE6BJWo8FhOycM0x?=
 =?us-ascii?Q?XR6Qw5G3UMwbr9PTYKhexVwWASBGne9ZZvY3e4nbFdvIFCMA6cijZIVD7OE/?=
 =?us-ascii?Q?gIXJvanZS8hSWfqK39RreoHN9Ti9jQ3hEBM2M8Xql2VKyLvLA3BbhKsN7g0a?=
 =?us-ascii?Q?o8aJIPcmBCYhFaEyBTwGH7WvvzEXpB7jjJlNxhuYFQycOlpL+C1D1Kla90OG?=
 =?us-ascii?Q?+STLBfo3732ywENP43jHh3MUHKRc1qF+J9hccETkFLDKUn/PUimCeRtuYdRo?=
 =?us-ascii?Q?ud+NUF4NY/vaE3Mr3XkBlg4fQ+0DQ81kn95IeBuh04keYNtn3Gf4vG8ys6Jp?=
 =?us-ascii?Q?SdD8OEWOQsiiPZWRrh5EIqV61HiyZYnDC1DCR9ACK7Y+vRUyiqhgaFpziFqu?=
 =?us-ascii?Q?9Jn3XFckCo4Lif+Mowtq2dDtpF/6aQSK4e91jpZuEvlabKTQ2Ve9omzbqgwH?=
 =?us-ascii?Q?Js+FCfy+WZ8jqjUPTI+FkLjcuQBIYMLxMVHpW/t4mAREfArACAwCVA0wJTXa?=
 =?us-ascii?Q?xynZbjYiPThRHQeq366jd5MUxNNn4EEAxtMMwsUJ+6KsPTKWiO+wQ/7j4k63?=
 =?us-ascii?Q?RKvpJ6hsmYynSOjYvSKohwsmhgZZaMN2+GHpnR/mDxQ4df9QDsDj0oggILxp?=
 =?us-ascii?Q?jkeN4U4z/ijpl27FHi5uENpznqO0q7IuNFJ1MxWg5bUmbP6HbsvAU4fQo+Yo?=
 =?us-ascii?Q?zntobXibv46mkdiQ75WFOaEmGBMXk8U9RpqBx7KgOHQc5KB1dSgGrCIZLEBE?=
 =?us-ascii?Q?qYCIt23okhP5N9lpiaoV58l56jEuVeBubjZqz0E4ZbToE0crn7tIhINojA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sb7kmp49iPZhishgpNzS4E7nvOKmbT2oRMgMO2mDefg2/yMSQXysr7pVG3yr?=
 =?us-ascii?Q?z4skN2dzsVkMppFXDr4XSoeFOyMZeHmpLNPJ7a0AbzetOgMY/3971Fxt9zj9?=
 =?us-ascii?Q?B97jygrMIaoJxoI4Z594inJ81kJxUy502JpL1oX27iEUVDBxpEZ0T+YKCSbc?=
 =?us-ascii?Q?CJyHYpneW+UTgOqv959MjQRaWSeY15FFEs1GkTNN2iyHmV3PVr2K8oeVmVop?=
 =?us-ascii?Q?vFHKixwG143Obr2hkT3nn0uGLUBtDaCm7+2xbJcQ9iB8o8Gsg6UxJb2JUhr3?=
 =?us-ascii?Q?EmopogoNWjUYo9e4SX8+9hJjYqOI3mBMiwY9jXmuET+STFnOcvET1p7QboEe?=
 =?us-ascii?Q?YQSVNRWHQ9/Hm/dCLuqIgWDDRz/sQvthYBXuiKKZGEBV6F5DNWR20Dl8bOvI?=
 =?us-ascii?Q?oWY+7QHTnASt7vqK1/Ebh8Qpim2h5rEeQflr5R1w4gil5SmXhv2BCHK59Caf?=
 =?us-ascii?Q?+AvTgVl8PK1q1f0E4Q0fu7oV45IC3CLhKdnIekDGO3bQqD/V1pMpoTkxb1Ah?=
 =?us-ascii?Q?6jDAgnPiS2RPx6CvhARZUZQWKp6ah1Xjp35J4Z+IOHm76yZCvvuFDw+HZHqp?=
 =?us-ascii?Q?QR+cUN5vdFfGD30Q9odfPy2t78h6NGG60YKtpIGQog2yCBZ42gazCTyIRtWw?=
 =?us-ascii?Q?hfXFHFHdGezBxpkd/ofsQkhTdJYc5LD1ImAH2rBJLgRb8qBe7/3sEp/samD9?=
 =?us-ascii?Q?Hsrh9gQ8yjkPnM7U94ShqItmPd11UgqzfcNVgRJ/Gq6RAUi94xe2f8kR5+Bp?=
 =?us-ascii?Q?eCToQ47Tk34QEHvwfyfkTaVnbySmZQgIfdqYAuRqCfyedtSW2Y6tDBEWl585?=
 =?us-ascii?Q?U/mjsS3JBR/n7jGcaaSxrM+umlLXEsGYzWcusTlFizSs49ddESHDQuCSXw0C?=
 =?us-ascii?Q?Rj/V8CDoXPHVQBrApaiO+ok+wzqRYi3FpPNyUmxHffxmFLbrM0nhU9E0d9IZ?=
 =?us-ascii?Q?3sv5oiwqDWZ+oi9JWWKJ9p/Z3crmzkc4RNHoQ/XPYUE7D+6B6R/VR3DGbJO5?=
 =?us-ascii?Q?B5ziVPOy15T6XuliRBQG9R7VkL1nEXMvti7lDXlFS+5oBFA0HwSb8/vzbSwL?=
 =?us-ascii?Q?szEJDSh0uzRTbb4gUlhFscd0sukVthlBQP3CMIxI8q8crUZBVCrfz3K918AE?=
 =?us-ascii?Q?d+vmPENfW9DP59K99uWfWxglbLO7fL5GKLPVCFx9wozdvsgPL2W803X5218l?=
 =?us-ascii?Q?pIiBIMEeiGaJikQpojCDsRvL6sbQfHFkvXafHQwB7ntBVSxmVmsAh1Em6xe8?=
 =?us-ascii?Q?fabiRM42Lt25yRGblFA9NO2zTf+sZjd7IM7N7Rp8fr2OgyMbYhtIXIMs/HTr?=
 =?us-ascii?Q?rytz+SzoMdGmNFa3kYB4BaV/qpgTN1dv74F/kGT7JzNXYWkvr6Du3POzurFC?=
 =?us-ascii?Q?vQ4OrjfcipuFen45+QY4SWkkPWuOX9yWpeezND9dNwssbAcGZ7JEhOn7AAQ7?=
 =?us-ascii?Q?LG07uvUERlpAYET8HIkN8Mcem/VOf1t7HsDupa9fGNenCa/jOdF41a2CGrWq?=
 =?us-ascii?Q?XtEqZtT0kCmvLVjlYGAVj/fy/n22uliohfHlt2xp/rSQDm3VPrGkr5cZE16l?=
 =?us-ascii?Q?bGtm+NxEDlOBI/mM2S6W3fvWUp0t5HTvBhXEkl7+MjpHZcPPb8zpeP2zRByE?=
 =?us-ascii?Q?U4lt1XQSSF5fGEFudu+L7uU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69168091-04cd-4ee6-1892-08de32ebab0e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:50.3400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQhq2MLdu1JaiDeLNL16t+Zp/E9QuDf20xD82+yy7u3/+HVPGRX66Txc6C4ANZF5rwn41GQvxwtcdxp/ugrC9OmAhQ9xOYnYjno7SZNLLu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

We should not call airoha_fe_init() from GDM port independent code,
because it do a GDM specific things.

Makes airoha_fe_maccr_init() and airoha_fe_init() port dependent
and call them from airoha_eth_port_probe()

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index ed8ee9da4c9..b1256866046 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -431,22 +431,18 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	}
 }
 
-static void airoha_fe_maccr_init(struct airoha_eth *eth)
+static void airoha_fe_maccr_init(struct airoha_gdm_port *port)
 {
-	int p;
-
-	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
-		/*
-		 * Disable any kind of CRC drop or offload.
-		 * Enable padding of short TX packets to 60 bytes.
-		 */
-		airoha_fe_wr(eth, REG_GDM_FWD_CFG(p), GDM_PAD_EN);
-	}
+	/*
+	 * Disable any kind of CRC drop or offload.
+	 * Enable padding of short TX packets to 60 bytes.
+	 */
+	airoha_fe_wr(port->qdma->eth, REG_GDM_FWD_CFG(port->id), GDM_PAD_EN);
 }
 
-static int airoha_fe_init(struct airoha_eth *eth)
+static int airoha_fe_init(struct airoha_gdm_port *port)
 {
-	airoha_fe_maccr_init(eth);
+	airoha_fe_maccr_init(port);
 
 	return 0;
 }
@@ -718,10 +714,6 @@ static int airoha_hw_init(struct udevice *dev,
 
 	mdelay(20);
 
-	ret = airoha_fe_init(eth);
-	if (ret)
-		return ret;
-
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
 		ret = airoha_qdma_init(dev, eth, &eth->qdma[i]);
 		if (ret)
@@ -898,6 +890,10 @@ static int airoha_eth_port_probe(struct udevice *dev)
 
 	port->qdma = &eth->qdma[0];
 
+	ret = airoha_fe_init(port);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.51.0

