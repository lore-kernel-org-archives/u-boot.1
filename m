Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA8CCD5BB1
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 20:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA0584869;
	Sun, 24 May 2026 22:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NSFlLd5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 109EE848AA; Sun, 24 May 2026 22:00:53 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A00784878
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 22:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz/6Nx02DWrFLHVZ3MdnVpvxY06CcyN8Al624Vg1bEfgDmH2cvv1hGcKSImJPFc+hrO+/t5+BsvQw2qECc1Ht6yoxaPl52Twlmy6vAdPeuYTp04cOcQVchAmeqQ381So+/rDXvP+HuMxA+P5FznUS4hAy40gUl1w1Gi+HKX7YqqcYb4CqZB4Q7MFVj0yGzZflDWLjf9ogmqhlLBxC9rTHf0y5ewvsiXSpppt0U78v5yL0mWeCkljeSu7CZjozm3LjsJjoYNhpCCHtsUZUtZ9rvQ97FytmIyD/eF8JGb9z0rxQxsmOx4kASV+rg4qfQVxBsCjFiP8d2MIppyM69E+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=aUsEYipQY2c4wN18BB2s2Hg0GANydmB/P50ukQAhkcnxdA/Ni492HeDIH8r6fhvRHluyzXLfQbe1XpYwbYSrmmqj+F1F0qsgjHclLMfrlPh2WwtrRqW9rBNlGhOpmj5RmY6cFjK8OoqgmcU+891YFH1+Nxw1z6UBrW55VeJ8s6w+c56gjbDo+nL4bsGnZn+VmBEllL6oWIcp5nrFKuPCp/RpVPENI8QkmLlTSNvHsJ9Dn9wb4B9pDxe2Bl3gXnqoMT/xWzyVFlh+eeu3BGqUKKECzH4Co1eAzZMEBRdrKaHcx6MyuBLhpgMfHs/FtB31Z8c5QHGKPilKq5uAfBp1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=NSFlLd5vbFmtAKN/qxe3PDoJUD5ThsMph5gI08WSkdFziV+vxvuLu4K4dW4aZ4M52KyxuSQAbiqh0WehddzkX28o5FPOqD1GqjGD797RmjfML0duCDRGnPfd9aYHb3HFHf/CfpP6fYPQMOdSD5m0+5/duczL71SKoMXuatMlQm9XPva79wPyH8zG4vnwA0c+v2bMOtxKV+1lUrG7D5y1E34H5y6O2Ye4rPxcU/uGxWhZEw7U1cNQMKOPQ+hExG6QFlP2B77M5HhbwgUr3KA0bNtWPu7AL9ITdAEujKEspzzNU4aPxPTQYQJ5O1uwwmeuSak37L4Dfr9aMiHOUbmgOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS2PR08MB10266.eurprd08.prod.outlook.com (2603:10a6:20b:62f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:00:49 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:00:49 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v9 1/9] bitops: import BITS_PER_TYPE() macro from linux
Date: Sun, 24 May 2026 23:00:30 +0300
Message-ID: <20260524200038.47826-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260524200038.47826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS2PR08MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6ea415-77a4-46dc-1cc3-08deb9cf268b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38350700014|921020|11063799006;
X-Microsoft-Antispam-Message-Info: QDOZVsYmr2yeGrRAdvxTV2ov4O2bBA2HCSUfAw4m6fixvDeiPZ7zBBsGrRAQNq6X1FrkDW03WaSqm7VIHsE2PGzcRWfFkgreXiBN6DTcqy6B7io4l6+e/wB7GUm5eGBu9PiYE5aeIEMk5yMGZ6kJ71DHU7HQaErxjNVQ9BoqGMeedeJZJ9BzJeYuuhE3hH1XploPpd9ftBAZKWTwrfreRRgD5TuXtt2fcKLSQBp1Qbi2hsorg8B8rMTtCwIQgBhUBQwSG0HXKA2XKiSrujFgV27yHku/94TnuzeZs4ovXsvXQxHO2U+1yCNfF29RzOhUlhhDEUKwuCk00gL3Vx9Vt0h+ORTRzkdkMbKzMTDwaaXdAYSpU/kRkq2F40k69Qex8FnTvTNPPIGt1f3EALXfOS3MH9cKJ1vLrJOOApXPIV+c+cyjHlXXBxw1aRgA0Ehx5FJOpQTyO7c9l7vLYMj0SbjLOlD9srwvLpC8K+knQ1GdLtuSqZAR2lKOG/ASyBVtdLWW4iesdD/L/GbnDAMspHV2iHeLxUsmqidUCP6tM+jmB2UyHaOQr9+Mev2Ed5u65iew+IcrvJ+DUj+N/f8Sz+M2yZj9N1PWnoMPOw4VqRs4OTtxRO2xVWUoZ+sUYI2rr1cWkeWMEjZUBre4ugouGeuGuDh0VxLwt/ddzHRYA5hJdm43fnI7nhLFR+adE7WKdtc3M2i1qubWRdyNtrTGOKxkwe0ipM5aLshCHPTuiiv/vOfXt7HoAc4pOjkMkFuYAwm+v52FvPARzWUrFiJuPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhxjBxuoXrLjzGlbil4azKpSmJqYU2ZYKqxKLKdfJ5F9m9Qbt3KRCTAp9Jp1?=
 =?us-ascii?Q?1U9d5DRhkMB76dnQtShULhMsKmXxMefqYi8hC+Q7T9S1yYWxpS6POK+RX2JG?=
 =?us-ascii?Q?KSZwE4Go8nG4T35dZs6bbcXm7d+YjIEW39izPH6EATqy8to+sMNpjAqkMMn8?=
 =?us-ascii?Q?ly7kniFB48OIdJF1vR8C5M8SXzir8efQiKKxX3YHLwhFvkDfp0SQLxvgtRAC?=
 =?us-ascii?Q?hvAD23sxE3HJ97x6/8eaKZrxIWX2jfNYLwSKLAOszkhLsieSlHC4JKnAsC7f?=
 =?us-ascii?Q?2FW/MUaT1JWheCWeyqWX56z2mD9oWtTQskCGIns26v9wMVH3dt87H5rUKkCI?=
 =?us-ascii?Q?78je3FxrTBayCoPHKDm9Pu4GJbQNuknV23vBTYEARvF+rkt5Azc2xvLnyo6q?=
 =?us-ascii?Q?G8rLXhh1zfjsBr6Swu6oC1gLVz9X33rPjbdWlPDZeaHr46G72og22XmnhNuV?=
 =?us-ascii?Q?/7xTMIOGh3tw9+VnPCr9U2KXz2ODTAsndjuL/nHIFgGvwr6bqMG59rviRmro?=
 =?us-ascii?Q?SAHCl7b1OZyAoxa5Gboyui7c+y38IEKMgpgQKl/V5YUyfl3dRhxMTJ7ez3n8?=
 =?us-ascii?Q?SNypp/7SGxHI6K+gsmBvRMxEW+MEGFaMp1p+kincfZDGQRAY8V23fh5ZCdBw?=
 =?us-ascii?Q?GZp9yG+WVvDlIE+FJX6ToIVxj4RTmsQhe+nXWkW7onzs/a06leeS6gf7dC5F?=
 =?us-ascii?Q?MCwSkmMnanvFu9RB/tDrd4zd+r8hE9G3Tgviy3eIdC+efywpvWrmShb94JDt?=
 =?us-ascii?Q?JvOsbgRSrDX6eLIcfsov6tVeooCm5ivkRV9A3pmi26vKuTrH3OWDys5eZrn5?=
 =?us-ascii?Q?UHzEoH5mY87DK7CngMtlDnrwfHsgtRAvwnpZ/4T6e4D/e6KDWxjbhnkHR+hJ?=
 =?us-ascii?Q?CGZ3h2FuC1hTfMP9bxO2epcknJyNldWGYYZrlFPOG4L7xiuMWrkSutu9tJNs?=
 =?us-ascii?Q?SJegoTmJXvrWhisH7XZHD5PHzSUSJ6zdLXBRTfYFvXoG0ZHxF65pQq84+nN4?=
 =?us-ascii?Q?jwXjs2Ug09SL1tq6yn31vlTeAidWwXOa6YEqGcVeFZeppBfthAWGCMg+fisQ?=
 =?us-ascii?Q?2XkWBeIZena+G+DzbyRaaZ1l7LDVVJBD5KxziSOKS7AeTjUiRnqvyIP6r1IV?=
 =?us-ascii?Q?EVOjm40HeYrdFxNJk5mh0uq7Ww4rX2qNeyQ/fPTqoECrRLJIR4uE6CQwFPx8?=
 =?us-ascii?Q?f6NI8+m0DYKb4kFWJjRbxhPODLk/q82vdWFGSgd3JALWrq/rUmATRnmWYd9c?=
 =?us-ascii?Q?XqBppdekpWpg/rYTFLavWP9m5XgdPHP+HNRSp42yyICY+Fipj1tlIFKnakBf?=
 =?us-ascii?Q?GcvdcbncckuxE7giMGg5C/m/TUp3nF/DZZXE+NovtUvM6fF61kuCeEVef8TS?=
 =?us-ascii?Q?09ZRC3sw07a3u0ZyE/vO7IoHApTZ5uEReumuPVIHb1q8at6Qc61ys2gnVdUW?=
 =?us-ascii?Q?0s/yBzgFIBNFujXJrV3Ka3CnU+S09r/89JZJRXPTepR0+JWsssz/mpp8KPF1?=
 =?us-ascii?Q?CTmw3aBXAQHg6L3pfXilnBt16U/0ZuutTEddjoTcHkVOckNerBfZ7Kgfi84x?=
 =?us-ascii?Q?eWIc4+45zklWN1jD7JkCOPByOnX+8nRAlRi6HpGXZLPwGUd57UMQ0m2C2hvS?=
 =?us-ascii?Q?TSQjkoh+0MPZwpC3Wk7K5cIsc16TbtEQVsMUOkrxljHkzgX2yjPBc1B1Cv2c?=
 =?us-ascii?Q?sCEHqE83xK693v4nXN2VsxvrzUrhSBxukjLsxC/weDZpE8IiMTfEPW45mxA8?=
 =?us-ascii?Q?1N8ue8SoC+R5z93I4j0n9eIj4EfkGc0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ea415-77a4-46dc-1cc3-08deb9cf268b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:00:49.0512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1z0KJ2LRH55/Tv/UZJTnDIvIMqtegvjhGnraDVyZO4YFl/UIL06iiZctkUFuID2SOO272a7E545cSdT+GkZhxy4fe7wf4f0+mxt9S1fh/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10266
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

