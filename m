Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71760CA1013
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 12:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8358323A;
	Fri,  5 Sep 2025 14:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="AjqS67g3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628B2838FD; Fri,  5 Sep 2025 11:34:26 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B14838D2
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 11:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gaurav.jain@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVhTUBacpe4LQ+fbvrYLzkUqP6RFhjL5056L3Oo9NRHff9ZSbkAuj9aiO2ZbJ2VpK3Af1oHMdqznBnpz+ht3K4EP6Gc4ktWaHcgZ6MRR1n0vZh7pMUQz+nXEqEoueA/A3HiBwY6EXZbMeNdylcjrEGUMekq/ED3he1sm3qdh3Urxl4qpYk6IqWpWj77MqRucdK2KSJMk6x34BPZHCoie+l7t5XCNPHH8BKzlcXsF3P0EZkAQlgfNtDIyD8VMV4J23o3clcWVHVz8sFtPZPaF4iO4Nszc8L5UGrYV3xTgeVH0E30hwglb3vscPWZkqGFUUtaBwv5bJHEWs9fYnN7h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCfrusVV3xL8/3+3BgatV7FIkM78Q1qhFCdAKM0bvSI=;
 b=KxgjrNNye7i4A3Mf35U9PsfaopL6iyomcM7Z2RLRJqSL9WVxO/C2xt6D0zJO4MLVsB77MWDUEg+W5DDCAlBR8t/3WfPQHax/C60TG1zaq+0yU3Es+KCVb2fJNxWCcsWNP/xrlgIuiwmcS4x2CZjSOXfi91+1jMbygiiAzOX3QoF3Qld6fLqKUqy330Y8CoWD6xKq6T0mXoYQmc/hGLuNGz07DjFWgV0DqdMrZatynwWzAbGE2srCh5qwxKo8oxv+skL+9XtDaDIJgh1eJrztqtmDZpL14YqahCGIrJA9kWmeTPw8nU1AndmMUjUNKKxxJmDLFMKy9V3KzZTddKV/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCfrusVV3xL8/3+3BgatV7FIkM78Q1qhFCdAKM0bvSI=;
 b=AjqS67g3S0ubDvWOFm7MO3vwRaFPsT1T4ZEgBqV+RdypXpnrdnbCnkUT3muyDzWFS5MBRTt+B7ACHALydGsosEnM9JbMkj9Hp4Qkg64j8aDSBvZaPhY8yceLQEpVRXfQAB4IHARiJhlYOzk1SMJNJ2A0ZXTflkgQJXaznjIjePa4/Q3BMZnyJE1BqnulwrgFqWdV7w5LstbrLLsEwW1PzvJfirU1dXwg80JHSYmSLqgwoD02EI+fIInwZcTVmZXoliqNZ1Ex3au9qbScrzlB7TgmxbeE7hOyJsQeiA/P+vTKaOMncKrY4EWU2XqE74uSk9LnQcsFWZexxTL1UwpWfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by PAWPR04MB11675.eurprd04.prod.outlook.com (2603:10a6:102:50e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Fri, 5 Sep
 2025 09:34:22 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 09:34:22 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Pankaj Gupta <pankaj.gupta@nxp.com>,
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Olaf Baehring <olaf.baehring@draeger.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto/rng: double the entropy delay interval for retry
Date: Fri,  5 Sep 2025 15:03:48 +0530
Message-Id: <20250905093348.204409-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DB9PR04MB8409.eurprd04.prod.outlook.com
 (2603:10a6:10:244::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8409:EE_|PAWPR04MB11675:EE_
X-MS-Office365-Filtering-Correlation-Id: 1046d8d5-adbc-468a-54f9-08ddec5f6564
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VGhKt+Ouf8x5osppK9aYYMHru61UEFpHKWb6Fu3ILfSONyp8pATdxArMw42q?=
 =?us-ascii?Q?WKhIN2hRA15XlhcpasI4TzLddD14YJJkmppFuPsuyEiuAl1RavR46IQmGtxC?=
 =?us-ascii?Q?1TE8cWEc/p5a7rBmDhoAxOAYd8qawIiV7I+zKXHf7M1+zV+MGx2/Vyie0kiB?=
 =?us-ascii?Q?wPEXg6cE56G6wozQtQznB8jKf5kWiDWcbH6x+TZOEM/WQ0hM7pKCzEojdpso?=
 =?us-ascii?Q?KtuWe76+rXK5F1Ke0DyN8HqVJimqjTrsGGDhV3ttQVrKYnxkCALt18jOojXb?=
 =?us-ascii?Q?+WfY0OShdOivYMJKRldRilTda8u5s5PvBTr0GkIKvpzXLcMbDM+b6T/cLhNj?=
 =?us-ascii?Q?/XBV2yWvuh2NmJSPg5Xw/OdRyeb4a1xWo5u5FQqI1ZF5/+Gu62AxkYqC1plJ?=
 =?us-ascii?Q?u+kfgRDQQl3pQ0/AtFYW29e+KEE1F7Isrw2BlCzAsLFIIvXQ5ylkq3KvsQX0?=
 =?us-ascii?Q?wlCJ1wU042xK6hsfuakjua+OijztRN889XJU0A0o8l4p0Jtci6J6GkI6A+x+?=
 =?us-ascii?Q?AfT9YN2WCCuSfiAMBubKbZHO3LJVaNWyup/LzGfM2TQ84nLx6ln2nqTPbJRK?=
 =?us-ascii?Q?DdwBHTw2ZDg2y1VFwA9LYt51QHQh6t98DjRdLLP4Zcg+1N/HeHn/QmgWQ0hN?=
 =?us-ascii?Q?r+ThoSISTTsHVrT2wg30Ja9qpHKpOXrBs2mlapRFN92MzNunxQTnilGSwmG7?=
 =?us-ascii?Q?QV1i2TDOXKlUIo3KMHGNT84OPw4pBg2x2tJyleteTzbKy0bz23T2Gp2NDMEv?=
 =?us-ascii?Q?AYObUmVnuB0YSccr4Is9cWxwsVjjXqIQDf0pLuws82UnTHJyRum6vUJ6MyVp?=
 =?us-ascii?Q?5f6nAHxGLUQ+2l8QiFdyKCTrjfwq93V5bjHBnUph6insCsuA3vDt8pqS65bf?=
 =?us-ascii?Q?yTDBJ3cjrPdBmODnFBTzavFVOSH1MJ2AyEUfbGVjzcIe1Wufb+W2crAs9aYS?=
 =?us-ascii?Q?8bypzMheIYiw68oZ75sUWHx2Kq2bvnbLyHOgoaJQeZ1RH/dWaZFR3kIGLp0P?=
 =?us-ascii?Q?WcO5rD+sUzPVxebtWzGUpggo5HvARxd2CoLWrcWnhXo/JvPNNVO+t0cPF2MH?=
 =?us-ascii?Q?dmirhTF5xEJiTFaDQoXf0DM01PcCJfZ8Kg4dgMcnmwGPgNEXBVk3J8y/w3p0?=
 =?us-ascii?Q?m8F5u9z8ItpeglFo+3z/vfChGqAAKGTxG5krvQRak7dKJQ2A70QaoXyVysR0?=
 =?us-ascii?Q?0wG2HeO2VEB0KLBqBJL0nuD1NbuWshTUjNsD4+szQ+N2OvljR926XLz64iE3?=
 =?us-ascii?Q?kFsyaqbgQ3rPgqwvGKiarMir2LpCIojX8w4lMpYLSvWaHnsJLcib0pY11r2n?=
 =?us-ascii?Q?LfpL8lNHErZwmMTcvdkkCM3kgGJBoK6D3Z3phQIWaAfSx6nQocKQeWnGYSwB?=
 =?us-ascii?Q?SfJc+C1F0I1PhwpjaoVEsUWGqvlvdnfZKhYGmUBszBFb3SMSAY/xJY5hCDuL?=
 =?us-ascii?Q?OH4iljitgQ69jcCSF9QMc7hpG8UUquda/QI5hWCvt9+J4TUVHHgVHSYvLLiH?=
 =?us-ascii?Q?l4zjMfPa7WuYRc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8409.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7acGMhLPP8TgssDHtR8+Lh7ncNBfT6Ng8eO0cV1nlajkZmJ+ZQTORf8hxsh?=
 =?us-ascii?Q?QQt5z9j6FaYM8cuS7GmPJ4dZ3yQbPAxz8OtcQBaY8S1rOq0OIDZoVIghKVn5?=
 =?us-ascii?Q?j1CAUdtERhMOFVwk1elTvDtx+hpcqBrw2en69k7ZPBFgni0/TLvaJN4/LFaC?=
 =?us-ascii?Q?HppGfizkilv/pe2O/6hpwLrSAhMmk9vPk6lN2/sAVZxqVWQv5ZeyvR1ErUVV?=
 =?us-ascii?Q?1q7FkGBd90da3EG/DSXk70XRXEx5sWuZtORKL+Zd1g6Gaj+wo4NiFPsyQZ+R?=
 =?us-ascii?Q?Kc+nyfkE7JCcXUIlyO/nq4CjasahI1l2RCTkeUtdEZQ88Jf06MR7+8aRPmd3?=
 =?us-ascii?Q?QIuYvxYEuUbJ4g4HAqWNkONYqTXzrVhiHv5/3lFJ/GbBZs2x2OhH93DHK8bu?=
 =?us-ascii?Q?TCx/4GbVq7wCGY8JNAt+Rw5OiYie711LKE36SZg+HtlCMn4NS3vvnL+XuwHb?=
 =?us-ascii?Q?BmszzkCSsNlVmE3qcsRVlqV16NWqRWGgoT66VlAPUjvoyxAt1KgT+Lrfll0D?=
 =?us-ascii?Q?nCf2pgTUEq2k0yLNVIPp27EhX/NDzjxj9bbNWpwtmu+LtkXVWhavhBEb3AMx?=
 =?us-ascii?Q?D4EPR5IG9r7f/3CRUrZqo9zOqBtFDTvM2ZxYsn9wdIup+aqquNgu3+44VfIp?=
 =?us-ascii?Q?z4XvgfpkWVQNpmkg6m02F5FTzuXlcIRbj6yJdHCIFo8sCueUdhrXilofTGMw?=
 =?us-ascii?Q?BCCsgMggsnpoMcwARhMlmB0O8CIzSbjDmY/LybR2nf+DNWbFQ/mqiOs+0cvU?=
 =?us-ascii?Q?jG+TjqQcseCBZtbIVnkLlnKiilEhhs3shFzgLwuVhEQeBqRIkIZQxQqm9N6K?=
 =?us-ascii?Q?+/sRVDG9DEVKPPkXjNurZPTA4Rr7B1u/OClMKa5mdhReehC319tE5aR6P0JC?=
 =?us-ascii?Q?u1jP4/XELEWv8nhU6PAKqOH4B+ar28RAg38g2uyX3fSXka/8c6joBuR/R/9I?=
 =?us-ascii?Q?kESrB2gS+G+euAPtTbxnO/swbxIRfG2MhTZk1akx+2wyaOfw50dNPA4Uiqzz?=
 =?us-ascii?Q?AqiDhmLCA+zz9m8y8vHoyfKzFDmjQV3EKnJd6LbyOfNpjZgSj7M/mvu6i9fd?=
 =?us-ascii?Q?5OCcCJoT5miFSvq4Squ+J9mW20vLOIzgniOvUWRD7Do1ay2B1MWyxgaqt2cf?=
 =?us-ascii?Q?ySlya13v+S4hL12R/Lz+5050rsZxBfDZ879C7VXdbX2JzDFSFCv3leDehNRi?=
 =?us-ascii?Q?3SiSMybJDkFTziwsVF04WEoBrulLzuQiGEESPnKCB1UHQDzdR06wH37FWFhW?=
 =?us-ascii?Q?IErPqkBeqNbG/TI8Cs/fa9tMShp95+0BV1m2eUB4JioOMSPV/RVrri7f3tgI?=
 =?us-ascii?Q?pONi0i1MEVjN1Pv51zsd6IJCnK9Dgsdz3fE/jxyBenfdoEo2B6r0N1GegMSQ?=
 =?us-ascii?Q?9NIJZQIaTjOlq1KWBeEF7QcXtGpOxMNA04kvdFEAUXAAow/aiscz6+mY1Q1h?=
 =?us-ascii?Q?0HokU7eESLE/Lr21JQxZ/LSeq5ygboRFAgtGZV5GzsmK8V89gqflJn+b0Fv3?=
 =?us-ascii?Q?CLKft6o98KCS7MNQuhPW8cOD/i/30hd5G3+NLaGIr8Ms72z320Sjg01ghdRS?=
 =?us-ascii?Q?nn5vXMUPDwrBN9h7IygsMKPCLmbrjN/aCTKLQnNq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1046d8d5-adbc-468a-54f9-08ddec5f6564
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:34:22.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WBE+fp17wQYso4ZDSChb0uAo9oodOqXcMzXAG8ZmmpezXfQOYwUEcDxewfbnmh2ZKiB58dj7kxGyJvjl1p1Mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11675
X-Mailman-Approved-At: Fri, 05 Sep 2025 14:44:10 +0200
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

during entropy evaluation, if the generated samples fail
any statistical test, then, all of the bits will be discarded,
and a second set of samples will be generated and tested.

the entropy delay interval should be doubled before performing retry.

Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/fsl/jr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 8f7a821ebf3..07d336c074a 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -642,7 +642,7 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec)
 		 */
 		if (!inst_handles) {
 			kick_trng(ent_delay, sec);
-			ent_delay += 400;
+			ent_delay = ent_delay * 2;
 		}
 		/*
 		 * if instantiate_rng(...) fails, the loop will rerun
-- 
2.25.1

