Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3992ED1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117EA83C94;
	Thu,  4 Dec 2025 05:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5bhKRe0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E1383C08; Thu,  4 Dec 2025 05:14:49 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8F583B2C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brVTg9uYLx6VwGbANAy4LfahDyhqn90ypVdY6k/7w2li/02Yz32ML+NrlWLPjXEL5IgNVSFW/lkT4SjjCdX6pb2IW/XhW4eVoBOmIB7YsuA1BQHYcL6D/U4RERoELtiXBm/Tof9zC+zMqp/FIYmir/zAaur05udxyG4vpJngVtV/WWVIVZwo3dUHDxIBN0T0a8t5JTX3kWXfUGFH0mHrBIof1c0smWXqX71ZY12jOMC10oMbT39SKgqkMXhb47RoFBHg2kWCR0FIs0KwtDk1dKyMLJfCbEZ/GJDPDVol32nVutbBr+cC6jrmLSWuzmYbT5zcMZl47gV1S4JPMGcm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t0sHtVv7HEqRAQzns+M1bg8W/CKn55O70Abf9esYJo=;
 b=xtgKCH8Vb+yukjuUEw8fLt24biPCdGsuXdOZOgNXXk1N6E86kw7IBr/O4k3vHP6Ikm4vA7Pw3ERV1wrExaR+TOZ9H3PW6vYJn108zPw8o0hQTPjD7A77PFamyOuWwu6msNXT2WWlrJkAah1Vp8ev3XKpXQql1o2wop2I3yqzaA9t+JtpjuFDC4rkCgagxML1SQgrNVUC9w3tfAF0tn35HC0BbGaskr/gh3H2FUUerMYSbYACycmNi3WrzRwC4omsqnvFtqIwa0sd2irQKT3BMlLA2HszqjPEMRMpIkxvVutseOS6CTY8veK8Ww3wbuEJLMQ9wnIvvO3kelf7cXQ8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t0sHtVv7HEqRAQzns+M1bg8W/CKn55O70Abf9esYJo=;
 b=5bhKRe0apdIjXC5UXYQV436JGtoFawsus47JX1G6XwqLkNYtu4GZqqaLkHjiOORs2dvoCevx/F4bV6R/5ELo9j3yX4VteKmL5fLN9X0rrOW0lNYtSAb3zB4bn3xvvJHbx8wPwFscFLcnX5rB6ECmOAyk9xqRv3jZnSNlRGHf9fMiwgWzYeWSe2+ureaxQHzEZeYhRSwLoZl200z+eaLMr2xw5n/woXceOlfQM+Pv9OotjPRz20vbl2R2LBRhZra4kroF3ZJcySD6RyjXn3o6qzOKVTG27Wr6koCl3GubRo9RDLISxpEGci391XLrxFATTQlplt6qxvKpC1vbh7CD2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:45 +0000
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
Subject: [PATCH 02/19] net: airoha: add initial support for multiple GDM port
Date: Thu,  4 Dec 2025 07:14:16 +0300
Message-ID: <20251204041433.3459826-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: adafeb59-67d7-4af8-d8f2-08de32eba840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HRkA5vr5ko8uOCS/LVWx3ut0NXW5aO+2QMRXbFDl+FULA75Rw3U+Ddn9/p5R?=
 =?us-ascii?Q?L0/TElKuVfaAbno5/27wECZ2P+AAVLpAOdr8IEO/hPVbx6SkNIYuG4dU3kci?=
 =?us-ascii?Q?acDHBKCRlRwABTsgctjL8wjC417H5P9BfcWhGw+8VExOjrK3fyBl49xS9Bev?=
 =?us-ascii?Q?QEnMWSMlwcYfciMtNzogrALGYt6ePruvLPGw6vPBioygqvkzmLq4cePO25/o?=
 =?us-ascii?Q?7PDi1Efrh239vA8H7Syfh/yRYCBvoCr9jeyMqC8ayDV/xXQXDlQU6T3WqO6a?=
 =?us-ascii?Q?KqKLiKJNfYe8XAnMzxgU/Mx5GNiL8Q3YcSXREDXgQNj86eloXnP8tZylhPeP?=
 =?us-ascii?Q?12dK6rTA+te+73GIMPiFIuxVl23tJELIODD08U6T+ce1y5GzSYB+DaN5C1UQ?=
 =?us-ascii?Q?IjdaoU92gRFTrJdv6XjZ/umpl78P6gNZR+D4szTcSFg7DnPLwDXEHVpxa0rd?=
 =?us-ascii?Q?ZT4wFX2LGpiSj6A3L86WBBrncvrN3ibfRqXp04VRIt2wOecSJl4NfKXYWGHW?=
 =?us-ascii?Q?fXuaXcTuna1cze9c+Caday4Mqs0CqIScdJ2wznjKQ3T9OztKy7y4DvzWVPiq?=
 =?us-ascii?Q?fAYnriUb903BOztaCe1zHzvZDVycb5cfaDU4MUv1ICk9PkC6+Pi1pX3mdwxn?=
 =?us-ascii?Q?UZ1oUGpmJ/FKCb5aL3JoWAsrSFSWNCTWSiSFQ7p+IAHcWckpCQfGg6rfn4bg?=
 =?us-ascii?Q?T4nroF00fOOsOgHD16trrnfPSpSDrun36iiFZyfg8BKXglDetw619FCuD+M7?=
 =?us-ascii?Q?ZQB5ek7kIp3NspU3HbjmLFYwazCmFOJm8FtOE0PemSFqAVL7anrxWlHg1rpe?=
 =?us-ascii?Q?uN8Uh7tOxdF+oM+tkkG24U4E87Hfvlezc2NDw4WpkLGd3thcbMHLQc519tA0?=
 =?us-ascii?Q?+ZeybrbWWHR9L+90YnOkvmtNGWllRkGk9yISVm4hwOw0wp2S5tccO05lPSmE?=
 =?us-ascii?Q?pIjSOUhKOZc1F5e59yA179mKADsinh5d5DVjDeL5olDh7S8Uc4APLys9chw7?=
 =?us-ascii?Q?z1KGRG1Egs5SvyqVuFvNFOYP7olCWgpG9D4cAKwTmDstb9vKXYwjgpESwNKM?=
 =?us-ascii?Q?sq7TNx4PbYQBJIhdK4PlMqgCJ0tA1M54CS4CjuBRsTJW1GtAf8uAbtX/a8Ke?=
 =?us-ascii?Q?Ni7cMvDktMLqipCUjXFkSrV7AVZJnRx/Rs/ovjL+ubyAphDemhbS+yLH41ua?=
 =?us-ascii?Q?tC/bWxOXKW5ci+qGzBCXZ9ZHfMg3mbvJq4Fv8kN3KX4fQ/RwNLRPWcOOHztj?=
 =?us-ascii?Q?0s7eN19+IcO/4ELUBP0Fi3dptGXHz1E3oEsEg4LjP7wffsGWkQj9jaZ2pDYT?=
 =?us-ascii?Q?GcPezw3nTsmj8oUyo0O7j4bl0ao/6DcRR6JQ5v7wzBn2UNA061l+lnTEGz/J?=
 =?us-ascii?Q?6c/Au4XJiRO7P9oE+fu4WODyvTpuzGgwXJKcscUQkxUNpyNJMjSYacY2qGoM?=
 =?us-ascii?Q?kywajIBVSQtsCYNy6+ScMU0suBZKsBZjn5vTmU7RpZKcadhFCJZ/Ox/7t3pC?=
 =?us-ascii?Q?kfXLdQ1zkeZfNvn5RB2sd7amlDVwrhnAI1L7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pke02LJzxgZpvlEkDX4Q/nWHcbcFFQXltaca5AMdDemo4y7QGrfH/LzuWr62?=
 =?us-ascii?Q?m+aH0xKWZs4MzBfk+MNcDxUMpLMp5pFMvcLX8YyfKPkSiQYzQsyThBTY2tmj?=
 =?us-ascii?Q?NWYenTTe/E0CSlzan6/IGH2IILoccrRNoGQr9O5AqAl/DXK3LHumriG+/I7C?=
 =?us-ascii?Q?RGBl2KmpwTbWZPdb7V/gB+82vbRKuv/zWtA8NaTLP/7RJEbVzvv2UMRdmgqZ?=
 =?us-ascii?Q?cUVsGKDnM3hQ3PnyVbCG5T4TM+0Pivjl7cNsgP16OqB5xxBvEWEDOjVur4rO?=
 =?us-ascii?Q?1toMcT8FrKJrMdVo1bcUhw+2iG9sdihjq8of539oE2K99sEpyC/eIveh+PQX?=
 =?us-ascii?Q?ZswSw0ATWEkH4Bf/KcwwvnHJO6u5WifKm9bJhuMQZ27/B7NIm92aPSzevskN?=
 =?us-ascii?Q?XuY6nDQR2pw6/AK6fc79KdyojSEksVQjDfaFB4hCNLFxMozAbxOR2+70i8Bu?=
 =?us-ascii?Q?m++5r7nSXyIRRHk4xpv1TMtBrp1dTORJO5U/os9KvAHQetPo02nR7vkwBft1?=
 =?us-ascii?Q?/n+J6pDu3yIvyITooDjDzs13WmyFypLRgNKN7CvUkw+z/QjLeVdavhk5cX11?=
 =?us-ascii?Q?3hcILAgYlFqn1CSfN4tI0U58ArrHKqMVGpNzClmBTOD4TrbzsvPc2e04nSXq?=
 =?us-ascii?Q?u0dL/ILWz6Qc30FIZFK7IEVqJC6NGYr1CWLxgHSGXcsFcI8wlNfFYlK7LeSJ?=
 =?us-ascii?Q?Zpd70akOta/vKsIbxp9KaUbyRnt9wBSN1R1/YjRJZ5jROHWY2yJHutnKR6aI?=
 =?us-ascii?Q?Zan1werqCvjn4mQz7bs9LJovMId8Kzf8pfSE4PLTK2gLuinTKFunid+tSe2r?=
 =?us-ascii?Q?FMeN9Uw2hDLu+dfNm0oeB01Q82iMwdmeniPnHBYbIggDWYbJ05fhh9nwVRL8?=
 =?us-ascii?Q?HoDzQ+7iRs08+qmvwU4lsPJWXkBhCPizZb3oTazm4inUh8dw9Hne22cFgEOp?=
 =?us-ascii?Q?TrEFkrmik4/XGo9Qasjo5LxcH3hWCmFF8kmXZcOV4h9DhRVB0WfE97Pwvaq0?=
 =?us-ascii?Q?4yYdsdh449i2a4eFoK+/IDvH191gbmyr5gsJnZpNLCp/HpUKosRO8dUuaILx?=
 =?us-ascii?Q?+6Y4Rjmc6qQ2SS1rr55hn9OEdqCeC5Ekd3mMkKojqK494ZMxJY8jANpHgvmb?=
 =?us-ascii?Q?WApUltDQBGodB8PUjdiv9hAgzYGzaMynHTA4BAdmyRekT/qXdPDCi0hjQET3?=
 =?us-ascii?Q?+kKgayoN6O3fSIhB8Fd9lQfs22W7e3D6Oeo2CiGO/Bhf9Mku6iMnJ80Gk9dx?=
 =?us-ascii?Q?nj6VaUWSK+ODfmrntD041RTiKGk+8zx4ezniaFJlU31I+3uYn+qnm+82amQR?=
 =?us-ascii?Q?DhJz+FjUeCobeXucE9dYdJ6gia5WN6tBpcGoGMivwSovYTcl1zqNTYKlICsW?=
 =?us-ascii?Q?L4i1l38mNrdpahRgAbQZrRe4CWPKdjTUkFnr7hfNwCcqA+8psIMviVOfoH+4?=
 =?us-ascii?Q?Zv8QqwCEVk8elfIYXSIFIckPSXqCHh+C+Bjhr18b1N+rYLlGN6RPY2SQEHHS?=
 =?us-ascii?Q?SQebkl/z+lUFqgl2mEGhxMKdAWxBRBH2qhD2pLo6nSPCKo9Aag/SDJ0q9Mow?=
 =?us-ascii?Q?btnZFELajhcj0ww1gbAhTIKboHdwhnCUyyMSx/+eGIoztT4XJjbo8uo6ruNk?=
 =?us-ascii?Q?SwRwdUWagNGvF+EX7XlMHGo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: adafeb59-67d7-4af8-d8f2-08de32eba840
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:45.6317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95ULSWEYMJI6SwKtt+Vi9jIPN7R9Z2o7LytTwtuH0iJc3YJA/o292N03wSggrt3AVvZnZLSSlDrSdJcSJHSn/cWQ044urtFJzFZu61RSNUA=
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

From: Christian Marangi <ansuelsmth@gmail.com>

Rework the driver to support multiple GDM port. The driver is split to
main driver as a MISC driver with forced probe (by using the
DM_FLAG_PROBE_AFTER_BIND) and each GDM port register a ETH driver.

This permit a 1:1 implementation with the linux kernel driver and permit
to use the same exact DT nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 156 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 20 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 3234d875887..31937137d59 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -9,6 +9,7 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <mapmem.h>
 #include <net.h>
@@ -23,7 +24,7 @@
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
-#define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
@@ -37,6 +38,8 @@
 #define TX_DSCP_NUM			16
 #define RX_DSCP_NUM			PKTBUFSRX
 
+#define AIROHA_GDM_PORT_STRING_LEN	sizeof("airoha-gdmX")
+
 /* SCU */
 #define SCU_SHARE_FEMEM_SEL		0x958
 
@@ -245,6 +248,21 @@
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
 
+enum {
+	FE_PSE_PORT_CDM1,
+	FE_PSE_PORT_GDM1,
+	FE_PSE_PORT_GDM2,
+	FE_PSE_PORT_GDM3,
+	FE_PSE_PORT_PPE1,
+	FE_PSE_PORT_CDM2,
+	FE_PSE_PORT_CDM3,
+	FE_PSE_PORT_CDM4,
+	FE_PSE_PORT_PPE2,
+	FE_PSE_PORT_GDM4,
+	FE_PSE_PORT_CDM5,
+	FE_PSE_PORT_DROP = 0xf,
+};
+
 struct airoha_qdma_desc {
 	__le32 rsv;
 	__le32 ctrl;
@@ -309,11 +327,14 @@ struct airoha_eth {
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
 
+	struct airoha_eth_soc_data *soc;
+
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
+	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
+	u32 version;
 	int num_xsi_rsts;
 	const char * const *xsi_rsts_names;
 	const char *switch_compatible;
@@ -375,6 +396,8 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
+static struct driver airoha_eth_port;
+
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
 {
@@ -396,11 +419,26 @@ static inline void dma_unmap_unaligned(dma_addr_t addr, size_t len,
 	dma_unmap_single(start, end - start, dir);
 }
 
+static int airoha_get_fe_port(struct airoha_gdm_port *port)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+
+	switch (eth->soc->version) {
+	case 0x7523:
+		/* FIXME: GDM1 is the only supported port */
+		return FE_PSE_PORT_GDM1;
+	case 0x7581:
+	default:
+		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	}
+}
+
 static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
 
-	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
+	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
 		/*
 		 * Disable any kind of CRC drop or offload.
 		 * Enable padding of short TX packets to 60 bytes.
@@ -738,11 +776,35 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 	return 0;
 }
 
+static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
+{
+	struct airoha_eth *eth = dev_get_priv(dev);
+	struct udevice *gdm_dev;
+	char *str;
+	int ret;
+	u32 id;
+
+	ret = ofnode_read_u32(node, "reg", &id);
+	if (ret)
+		return ret;
+
+	if (id > AIROHA_MAX_NUM_GDM_PORTS)
+		return -EINVAL;
+
+	str = eth->gdm_port_str[id];
+	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
+		 "airoha-gdm%d", id);
+
+	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
+					    (ulong)eth, node, &gdm_dev);
+}
+
 static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
+	ofnode node;
 	int i, ret;
 
 	scu_regmap = airoha_get_scu_regmap();
@@ -755,6 +817,8 @@ static int airoha_eth_probe(struct udevice *dev)
 	 */
 	regmap_write(scu_regmap, SCU_SHARE_FEMEM_SEL, 0x0);
 
+	eth->soc = data;
+
 	eth->fe_regs = dev_remap_addr_name(dev, "fe");
 	if (!eth->fe_regs)
 		return -ENOMEM;
@@ -794,13 +858,42 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
+			continue;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = airoha_alloc_gdm_port(dev, node);
+		if (ret)
+			return ret;
+	}
+
 	return airoha_switch_init(dev, eth);
 }
 
+static int airoha_eth_port_of_to_plat(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	return dev_read_u32(dev, "reg", &port->id);
+}
+
+static int airoha_eth_port_probe(struct udevice *dev)
+{
+	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	port->qdma = &eth->qdma[0];
+
+	return 0;
+}
+
 static int airoha_eth_init(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -818,8 +911,8 @@ static int airoha_eth_init(struct udevice *dev)
 
 static void airoha_eth_stop(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -828,8 +921,8 @@ static void airoha_eth_stop(struct udevice *dev)
 
 static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	dma_addr_t dma_addr;
@@ -851,7 +944,7 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	desc = &q->desc[q->head];
 	index = (q->head + 1) % q->ndesc;
 
-	fport = 1;
+	fport = airoha_get_fe_port(port);
 
 	msg0 = 0;
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
@@ -893,8 +986,8 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 
 static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	u16 length;
@@ -921,8 +1014,8 @@ static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 
 static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -963,8 +1056,9 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 static int arht_eth_write_hwaddr(struct udevice *dev)
 {
+	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct airoha_eth *eth = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	unsigned char *mac = pdata->enetaddr;
 	u32 macaddr_lsb, macaddr_msb;
 
@@ -976,19 +1070,32 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 		      FIELD_PREP(SMACCR1_MAC0, mac[0]);
 
 	/* Set MAC for Switch */
-	airoha_switch_wr(eth, SWITCH_SMACCR0, macaddr_lsb);
-	airoha_switch_wr(eth, SWITCH_SMACCR1, macaddr_msb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR0, macaddr_lsb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR1, macaddr_msb);
+
+	return 0;
+}
+
+static int airoha_eth_bind(struct udevice *dev)
+{
+	/*
+	 * Force Probe as we set the Main ETH driver as misc
+	 * to register multiple eth port for each GDM
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
 	return 0;
 }
 
 static const struct airoha_eth_soc_data en7523_data = {
+	.version = 0x7523,
 	.xsi_rsts_names = en7523_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7523_xsi_rsts_names),
 	.switch_compatible = "airoha,en7523-switch",
 };
 
 static const struct airoha_eth_soc_data en7581_data = {
+	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.switch_compatible = "airoha,en7581-switch",
@@ -1013,12 +1120,21 @@ static const struct eth_ops airoha_eth_ops = {
 	.write_hwaddr = arht_eth_write_hwaddr,
 };
 
+static struct driver airoha_eth_port = {
+	.name = "airoha-eth-port",
+	.id = UCLASS_ETH,
+	.of_to_plat = airoha_eth_port_of_to_plat,
+	.probe = airoha_eth_port_probe,
+	.ops = &airoha_eth_ops,
+	.priv_auto = sizeof(struct airoha_gdm_port),
+	.plat_auto = sizeof(struct eth_pdata),
+};
+
 U_BOOT_DRIVER(airoha_eth) = {
 	.name = "airoha-eth",
-	.id = UCLASS_ETH,
+	.id = UCLASS_MISC,
 	.of_match = airoha_eth_ids,
 	.probe = airoha_eth_probe,
-	.ops = &airoha_eth_ops,
+	.bind = airoha_eth_bind,
 	.priv_auto = sizeof(struct airoha_eth),
-	.plat_auto = sizeof(struct eth_pdata),
 };
-- 
2.51.0

