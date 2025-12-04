Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E10D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D6C8402F;
	Thu,  4 Dec 2025 05:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="w4UHdbgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA5A83FAF; Thu,  4 Dec 2025 05:15:09 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B60D83FDB
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJpF1kqB81psxDlSPOrzO6nwgY3M3k9MNLR1gu7nV7nVCbk5ajMCJKWJP+3wv3/ieCK1/YFwVYYUY2o+QISPIqDx908vz/ZKV1BS6cyVJoH9pnxY526paE7Ct9B9EGFQ4bHg/iDFCc5YOkqMXnrG6c6jLECsWvBfwUc7qdMHn5Z1YruyAxRYTX04PnZoiavjOzSSNCzPjR5ElwrJL90CGHvDQ/4ihR+2S90fxEuYjwAk6fVRqZptTDgcv5LM7rXEGXXvIxZsur3JqaXgI4h1Q7or4r0cTUN8cl9qxKP3cWOQIg3T22qRQJReftWPipd26pMRZSmyvOwmrMolWGbkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COKEekGdK7SmBXm9AMhbnA3X6abQnyH3CIk3Gv1CtWE=;
 b=hzd5f0o2b00w5netCo0OQDjrWQZOmFH202T+jOpTv2OK6gCQexkmIEA2h/D/PKMIvFGewQtE6eRZEAOIzM2X6Uq6GhJgH0gT0ahMnvAEVbF11h43fa2gNzpODVpZ0uJDQYzGwtZnQtXQer+V5ALyx43jzKtPfC21CNaotbfqq76m6iMjufw+lK5Az/XsoLtGzFDikOuGJ6q9fVmV18tz96qA8aKaZ2qpvSbM9Fae41fHaO8Xi/JRMXpXExxxufHcySTXyYu5uGDn618bALFDc8Db+Zi/ZS4OHGSiXjHYsuawXiz1zdpHoF/KrWEonYYcKPyYgoSDHiWcDnAmYyRBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COKEekGdK7SmBXm9AMhbnA3X6abQnyH3CIk3Gv1CtWE=;
 b=w4UHdbgdO+0LTYiieHcA1dMWcqr9guWeE3DzV6eEaF6rb5TJyCh55y5Au9Cd8MHx37OZxpQ8MwEagFpbY774dcKKkM119+HyS0f9go6MwOxhv+/eR4+zAsaLlQCKt8N2KzrvBfB6iDOzoPVg+aUPBi2/TNJvkkKUGh2jcGAVQP4BY3Z94mUlTD4BMWtK9B6ilqy0IFHdTJ6ByBDtBVSdor6faCcX7BA1rYLdk3936+otRBG2IJqW4ccm79Q3N0Tv5LAxhbVkHUh4TRlvwd7Fk9Fqi935GAbHrzRuWQ1BdchE1Mn017JkpeVO74mH7yRCqoG1lmufaQxuzE9u3WEpgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:05 +0000
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
Subject: [PATCH 15/19] net: airoha: makes PCS support optional
Date: Thu,  4 Dec 2025 07:14:29 +0300
Message-ID: <20251204041433.3459826-16-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: 27bbd3e2-d055-44b6-28eb-08de32ebb3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c+4heKxwVNfj+ZDpIGOJMwGPXhy2JLhflF3bsmDOP7bLjkeIf/ABUdirxvoe?=
 =?us-ascii?Q?injhR+CohbSPAcA5QOKp0ZdP0dwMqiodVPkuQe/zf725L4f9wABzrl9Ze1kd?=
 =?us-ascii?Q?o/9+iyIiKaLU7kr2rKOzjnxsmw96CgbBPZUeavJ52wM0ApXXX0qZES6FT7F7?=
 =?us-ascii?Q?d1KOQfLDSQrtuwYjYFgo9EdF7T3ZP6tL8X/hxFPtMzoMxrS8EyCboKwJP3fw?=
 =?us-ascii?Q?iniIk1otZ8zKNe78aw5yE/AymjmTy7UpHtIhKY/ksTgStC6xsMTDmB0ae9Ts?=
 =?us-ascii?Q?C/rHq1rBVpU36KUqgstm4kBM0jcJ7FHCYZv8QGTNlghGeUJzY+kSnRr6hjvr?=
 =?us-ascii?Q?XYHQSmlluq5pNkVR3kLVzpT3IAqrX9NEoZRETw+XAXJKC6LwGVce/qryz1bP?=
 =?us-ascii?Q?2+C6UkMz+9E6oNXe6LkSnoQA6H62IZl6VpwFtzuiwHpUT1z5pOr3lA/ScESK?=
 =?us-ascii?Q?/1UB5ZJq0dw/xVcHrD18UTStrUzQf6nyOOnrF2XJBEeT0u29hgQe+SaA18HV?=
 =?us-ascii?Q?OgUiMG9B/UXuyfOUElzqjpdi1jO8ECylghY1yzLUrKxb2OjsSrsErCOrFX1q?=
 =?us-ascii?Q?L/hvLMACcapYz67zMbzbiFoxpmKRW4yW1Wbb9EHX4mkonw5P6MgXHujrCj4j?=
 =?us-ascii?Q?XWoFhgRgxxMvcAs6TFzum/SIuofDJlq+5N5TFq7LaqXdQYZ0bhIxuYnd6zP+?=
 =?us-ascii?Q?EjLnZOF21U5qgGVQl3AvXMH1jTvrJLOKl47yPs0ecJVniLhPgbq1adFJ6d8j?=
 =?us-ascii?Q?J1tfWYZDKc/QsLaPCcZquPJf52HWvbEd+8jneSLdAURp0nIIFmWw1YERHQLr?=
 =?us-ascii?Q?4pMzms/Xll22qwRmid6nwCogv5mMgrxz9ZKStJzVNTKK6a3XvEe4EHz5p7sH?=
 =?us-ascii?Q?ce/mDgj6v877mloPXYXhUm6kd5IPF2fn/hMtQO0irn+PY5/y+o0oUTnDmQdK?=
 =?us-ascii?Q?uJI69YQRj66UKAGOM7KR+cYvo2e2JKZs+hLJGfEM4yxv3h7EQslbRv68uJ7c?=
 =?us-ascii?Q?ICc0s9d8aYIqoRXxcO1EV58ZZ48IUvoN2BWBCPNH7ZJ0L0IPMhQoeE2uStl9?=
 =?us-ascii?Q?NDQl9obspJR2bayi/vrF9XAihfMLDv9jAvMn9GzBCbgOxGw4VLh4MfwrlIhY?=
 =?us-ascii?Q?ebs8pPKAtAnTrDUstQwNw7+4sojl6BXq7gF994qHsvqAqc0YjVYBeSTssckR?=
 =?us-ascii?Q?Cz1jGXDh0YMBcVfitKsIxg2fSHZLZGeS9xbsdc1T0/5xFoDXLz/gqiBGmF3a?=
 =?us-ascii?Q?etzh096f2mTmUSl1In5E23WUWAwhQWfkQw96ulY12FucjqHQ57CVDAjUrAQF?=
 =?us-ascii?Q?837Gpzy3GN0aCrNrc27TR1Qzt1XGEYkbR/XZ+2uLM2bbG7hoqJG8IGW0KETE?=
 =?us-ascii?Q?lV+Krky5bpyBlJGOd6NEtI5GJ8wZ+fiGwBNGRH385MFBjv3laAEUeX1bomii?=
 =?us-ascii?Q?FflsepbKd+4UKMvgwX5aSR2GKHhyEzWzOtGIrQp2mwn1JhRvD72ChXIMeNiI?=
 =?us-ascii?Q?fCfKdXDHVRtWJMOvqi+PxLa3XUNsTUfKKVqCTyncXdyt9FhyZUCWUjstxw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHOUKymU8wJZetf9rxvAlWz//ZDXt9PQ3fWF5/DkYAGpGCQi7Ntmfc5mIKAe?=
 =?us-ascii?Q?vrV+5YY6v5lLXk5DgusnIOMzc4iRTJFILE6NshmHrFlJ5ONS2dNSM1IU9dsB?=
 =?us-ascii?Q?qFRM8zK/LdzK5gsMolPfDnBlk61luBRwNBq5VCeY0wpQ2NYauOq5U84kfcAL?=
 =?us-ascii?Q?My2c9eeUJDK75FBUuMpi8jiuw3uaJloJcTPZegpOubaIV/gI61zwoDbNNBmX?=
 =?us-ascii?Q?J4UN8U1bMcV1WbW7iK4ivkxrq6AilSv2XvUZZ4GkjK2DGRtQGlyYtbyjmvhI?=
 =?us-ascii?Q?YMxFFlgLESf18WBv2yBjTsUqdtXfjRB94lzT1LIzRvgjiFBwm6Czok4m3QOY?=
 =?us-ascii?Q?onGpu9E+aXk4DM2yxICmU4updjl6loWS9dFt9oUKEWswQVzJ6vjkfFXQ+elU?=
 =?us-ascii?Q?oyEvRq8i6LRKNyJnZHa8W2yJEzz99Gma9B0AoZHG9Vd2k5pvQsEAVhWdQXnm?=
 =?us-ascii?Q?Pa0zBxunscahL1cOqHS7ygUpdxTZaqmUo8mzMNTiF/JAUMFLUAGsdIGznqjI?=
 =?us-ascii?Q?C1okU6AaOlnF6/pvKCmcieo9VoWUxAkgA/p1ql9hgNFv8IJ957C3hBPKtVtu?=
 =?us-ascii?Q?3awZbwTw114YDzcDtKyaeOmcT3mg2rbWhTDzvgRq8QPUyuWhs74RsJMwY6vy?=
 =?us-ascii?Q?DlRmkREYEhiBAipQku0MP+3KEhsMwvMPinhUqyXPFd8mSyquTnFf2pe+b8rO?=
 =?us-ascii?Q?kHDyz26lI6cXanbLT0C4lOTP83RT+xljD5z0/8Aa3Bo47yjrlX8qppIwD2lF?=
 =?us-ascii?Q?iDsZfxwa72qJOtMdqV5WP7dIXBu2q8aNS6hshqHhKYJ+Q05/+5PjOjWtauXs?=
 =?us-ascii?Q?pq2qzhA07SlN/kJNQo7t1/lb2LEhjkJ3KPWatqmmmRdL5EEN8LMI/DilItJd?=
 =?us-ascii?Q?PerbZirqxQ2LqGt3N7qqLhV7EcrywRNBoL4mO0ZHl07prqXerwgkTxGeQaj0?=
 =?us-ascii?Q?qBz1ZJhyoS9w8Xa5hRgmkYi998LYXy8RRPqCBKOXeqP06ftKBMkD+qe7WbJ/?=
 =?us-ascii?Q?6kzwD6UnzEc3C5eDDyJpdQuiTJUv0m0YAoijTTDgnmXmd7P7QrqDZjh8Dct/?=
 =?us-ascii?Q?RVfVVWLxzIDwodn9dFhRc517r6ncWmJkK82ig/pQoFHxmPjtLHpdT+0r8ALn?=
 =?us-ascii?Q?2Ak+w3fY2R21/VI/LEkFselkNGB4P0/8cqKgd63sGrGn8kUB1WvcIhuyqYL3?=
 =?us-ascii?Q?wNWv/MnKyK+NQPei9iZk86DEdVRd5aOYYQGVbWjBu9COd0mNuCmzuv7v261J?=
 =?us-ascii?Q?Cs+DPDZ424B282zmT3XRszIupZWIhu1RwfwcMosDJ9igDoqFLT2t1cXjDYP2?=
 =?us-ascii?Q?Vfw49S3JHCA8tskciI5rrNOTJGISKinRiyu9m9DRutBOHzI6M332P2dXoGeu?=
 =?us-ascii?Q?2zS0GJCtAu6rh3naNHEj0+OYv1Uu0bKHEaz6Vv6Zv1TSfM6V/hwPEU1lyyeQ?=
 =?us-ascii?Q?Vf4X8Rg0QJ75FUkjwibE/7+xoc0dFgnrgnttQc9Gx+O9tZvcL0oggWvl/vbg?=
 =?us-ascii?Q?zR9uJuUaJ7o3ovUCrjv2RrDMLjZqe/nfF9rG6mUCoqNxiWI4hnbp87MMf215?=
 =?us-ascii?Q?z/MNErN2nqTWeP4FJa1xSZls7VNbZZapsBpmnrMsiYPECi/fAvs+cZsqbN6A?=
 =?us-ascii?Q?TLPBxXt2ALSKF5LQHZqKIY4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bbd3e2-d055-44b6-28eb-08de32ebb3be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:04.9169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T9m+fUTXQSqaq1Wkp9uLXkUyg08Jg+1jV2MchSwYsIv7m+6TSv0hgN51oTYwMSqYvO9dRfSP9XBunH9Hi/lxs0AnQ28pFrto8gNwKzkzaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

It's not possible to disable PCS support just now, an7581 u-boot will not
compile. This patch fixes an issue.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index e300ff3bd52..1356ca36722 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -126,6 +126,7 @@ source "drivers/net/airoha/Kconfig"
 config AIROHA_ETH
 	bool "Airoha Ethernet QDMA Driver"
 	depends on ARCH_AIROHA
+	select MISC
 	select PHYLIB
 	select DM_ETH_PHY
 	select DM_RESET
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index f773318fe14..a0644f63366 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -702,6 +702,7 @@ static int airoha_qdma_init(struct udevice *dev,
 	return airoha_qdma_hw_init(qdma);
 }
 
+#if defined(CONFIG_PCS_AIROHA)
 static int airoha_pcs_init(struct udevice *dev)
 {
 	struct airoha_gdm_port *port = dev_get_priv(dev);
@@ -729,6 +730,7 @@ static int airoha_pcs_init(struct udevice *dev)
 	return airoha_pcs_config(pcs_dev, port->neg_mode,
 				 port->mode, NULL, true);
 }
+#endif
 
 static int airoha_hw_init(struct udevice *dev,
 			  struct airoha_eth *eth)
@@ -827,6 +829,11 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
 
+#if !defined(CONFIG_PCS_AIROHA)
+	if (id != 1)
+		return -ENOTSUPP;
+#endif
+
 	str = malloc(AIROHA_GDM_PORT_STRING_LEN);
 	if (!str)
 		return -ENOMEM;
@@ -915,7 +922,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			continue;
 
 		ret = airoha_alloc_gdm_port(dev, node);
-		if (ret)
+		if (ret && ret != -ENOTSUPP)
 			return ret;
 	}
 
@@ -942,11 +949,15 @@ static int airoha_eth_port_probe(struct udevice *dev)
 		return ret;
 
 	if (port->id > 1) {
+#if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
 		if (ret)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+#else
+		return -EINVAL;
+#endif
 	}
 
 	return 0;
@@ -968,6 +979,7 @@ static int airoha_eth_init(struct udevice *dev)
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		struct phy_device *phydev = port->phydev;
 		int speed, duplex;
@@ -1008,6 +1020,7 @@ static int airoha_eth_init(struct udevice *dev)
 		airoha_pcs_link_up(port->pcs_dev, port->neg_mode, port->mode,
 				   speed, duplex);
 	}
+#endif
 
 	return 0;
 }
@@ -1017,12 +1030,14 @@ static void airoha_eth_stop(struct udevice *dev)
 	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
 
+#if defined(CONFIG_PCS_AIROHA)
 	if (port->id > 1) {
 		if (port->phydev)
 			phy_shutdown(port->phydev);
 
 		airoha_pcs_link_down(port->pcs_dev);
 	}
+#endif
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
-- 
2.51.0

