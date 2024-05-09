Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D30C25B4F
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 00:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6FAB882A9;
	Thu,  9 May 2024 02:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XuBWdia9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91808882AE; Thu,  9 May 2024 02:47:27 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB7088245
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 02:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrFJ9cfa+ovcZw/n+jBlJmMv5aThufcUlfIWEBSMAsXpQml6US+i4DOy978LnWrstfzH4MjFjVyqgoaquuZz83nOcxAj7MkbDyCVoIS1Z4mbo/BMXJOU0D+rAeTq7SLMj3RikCqU66mudBYWG0GZKY83nuATMfGVS5FjYDezuGoiYY5+FXnoBnJKN5PCKE5vWu0PZpUqkGC0dKsADE57/AR16CucR3paRbbor22ZfOn6zIMt6k4Gd/WAntMm00m1pWLMoJQsx8ZTuAgCTHE/q4Eh7xXGRzSjer8WjTq37HAPeESJB/Yp4zBlbrjsgFAcymS/34qEPaAgpUExm9Od3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP2nsYBt1BCf09q8xMcg6Vwc+2sAjBQoBR9w6bPQW6g=;
 b=g2d022t/Q8EnR1QgX9ynalbCuRSBqA/FLMCBnMa7Yu7d0cuwgZy8aJKFFsvu/ghT/HtksiexSNQBRcCr8UGg2cfvGFUf4ZbHn+6Z94g4+xUoWiBNJV8HkoH/o0GWSsLho7fz3k4ortONlu2nvZGuZgqi7vEKgCA9a6+orBbO6hhJ6azdpX7tR1rMjtxtsc9O+TwS6goC6Jfw0OXk02xExFIyrE79ra0FrIc5gyTu5WxgqGRz2Wz8Ax/xVGlk8D37OQLNNvtaictYyU4OOySFXBrObB9zNkiExtpKzEkmt/R2XFB/eJd4Mq/yQeW1vQ7ko6QKPm6oX6sNDvVyKZXsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP2nsYBt1BCf09q8xMcg6Vwc+2sAjBQoBR9w6bPQW6g=;
 b=XuBWdia999gLqcBQpNJxhNgfX7oeQKos/pASiQIpmK4z16C6S+5a87VvCw+SkEDg3GmVQ/bAXNJ0MI3X9yz/Oo3mSRxnby1nyPLbL9tjaxppmjNK8oL5fn4+G5mN1vDGGbDvlIgyV1278WrdE8uOlYiJToJoLBtQMgfxjvUaDT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 00:47:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 00:47:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/3] wdt-uclass: prevent multiple cyclic_register calls
Date: Thu,  9 May 2024 02:47:13 +0200
Message-Id: <20240509004714.1394547-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
References: <20240509004714.1394547-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 7167b8c4-0cee-4db9-7680-08dc6fc1974f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXIDlQavR5bjXlrJIFrhTbj+N23vBeeT7oc/3uECkBnNIWd9bKu9el/Ibpcl?=
 =?us-ascii?Q?4aNB/TDmdotHYVfo1FJxZLlE+q2YXayUFbqdXr8ywhzqmLlNi9AjGvgCV4I6?=
 =?us-ascii?Q?X9or17FTEZwf6p+WSAY6NCEwCjCQdbSMxLNJuSrFwVL+1jVpCFvD7oqBdtg8?=
 =?us-ascii?Q?A1GRlJRqW/Bb+4pNS6kPTZEHVo7Y7h8qSiusMNoh7Mt0j7phwv5HRQ6pMxV9?=
 =?us-ascii?Q?wS1sLio7zNJpvznB8rEvtADQNsRLkHhcfLrG3MHrczP/jjZD7JwXS7e5Mgjt?=
 =?us-ascii?Q?2Ekb4GS88q6GqRof2bAsapaJ15V57RtGPbszfzuWEJpuTg2CqlTWBBqnPMpx?=
 =?us-ascii?Q?TP+kYcG1biE1WfnPJ/3fMuqOpx/tQhbDVCabl/nEv75DI4V/E83RH4AiuAy1?=
 =?us-ascii?Q?MRMYTTyJZLLsviwwebgSrgJ2JDNcCppaDVBubfNKmwnH6k3d8IEYsfXVzFaZ?=
 =?us-ascii?Q?1U78wCo3xaautmDZhUbLxICADorwGhn+7bCnioqHbkg13AMBvR7hR3ZQue5k?=
 =?us-ascii?Q?PjyHcbhDn2nIiIfgSvQRI6runD91nBGSnUk+WNXfpMDPfgex8aSjLM65INKD?=
 =?us-ascii?Q?/t1td2KGK69K3O2J9DC5N5t9eeChjOqFs/UjVUCJAgJswafFJfN9L43Bs6dB?=
 =?us-ascii?Q?UOcRExkvClFp01FCoDH9lr6aCk05kaZWYlsyfiHHsePzbrFylGbYu9GV6Rsv?=
 =?us-ascii?Q?YzG8rnL4tMmleFNn6Fe7QoHrjR6dy0mlsL4u2jUMSBWJcJpkG6UzMCLXdO38?=
 =?us-ascii?Q?VcwTPkCvcl7KtQyZ+FppZYDI0sl+HPCpMwtrtXS9STqulvAPPQSL2WeNvWH2?=
 =?us-ascii?Q?u2kMBv/B/jRSFqImWGidu2eiGCf0t8Mmd57iPDyGeFoRLf63M0wZ5H53q7Nl?=
 =?us-ascii?Q?r/G1uPQ95ho7a93PJt2klnjAa8UfW5+mL4Sq0DURcUlqy+lZ4ttO5+X6XJPr?=
 =?us-ascii?Q?Gggln8I1Q2yi+Y5g/KkUgziBEE33NYxgfJ1gcNLbD65cVuc+l3r7dyoERVDS?=
 =?us-ascii?Q?YLBUJ4u2d0LxAb5OR8w3qfDEnHEfr6kyedHe6zxqZ0V/gpWB26qyszNPdDyS?=
 =?us-ascii?Q?fE5xX22bflb/CDeVVhw6Hea+CEtYdstTnR4HOWtKGaeoF7PO1k1ifrphnQln?=
 =?us-ascii?Q?UR/RB2u3GOclWPXt7hhvV+gpG/TP0PUcZWT8Jeyt/QWfelNMh9H27vYsv7Sd?=
 =?us-ascii?Q?I/9nvK6yZ8TWnyiVFtjeiLEj+KZs2JZNgS81w91ieQbQLwVCyqH0Cj8f+eMK?=
 =?us-ascii?Q?4VvBfuATFta91xHW+QWUxTUZe8YUiiI6FKhOqp1rxi7cTtWo9xq+d2eRXnKo?=
 =?us-ascii?Q?QKhRg3WGsLEB4JxzglBhWyLtAw94qfj9aWh6E3Or9hgq4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M/TIvki1oFsK3K9UxuQ8HQMTETPV0zLleh/qcNIYS/nhsDmmrD0/ncJoEqxZ?=
 =?us-ascii?Q?qSj3ofoOijyCdsEIGzVOSruV8HFUrUx6qr6AUCl25YxFrmMo4GUyhS56rsAu?=
 =?us-ascii?Q?nOL/Y9aEjkeXqBgSpEtMnR9KedWeez+9s2QjQHwdhktIscP3Yji53DzLrwUu?=
 =?us-ascii?Q?rMDX0EHgnebG0q1iFRhW3IiGqcDO2dXqm9RDRjPrmm/xa56FOyHeAoLdvbK4?=
 =?us-ascii?Q?NgkyXTP5W/jMiaCToEzHYGpkfvpmshJGgPf9j2Pk7e/w7trTN2D/IbvdqUSf?=
 =?us-ascii?Q?kgM0SlPITpDl6LfFrBxK8m6i+iCaCjjGTzk/v3I6X9ykNLimXajtn5fzaw65?=
 =?us-ascii?Q?p9fyIguOdgqrIufBnNUhRaeHQyT8i8r9h9OLuKZkgkMdlxXZwpjPL95XdHwz?=
 =?us-ascii?Q?ndG+IVq4aDI5zGldSS9TSNpq1aiOwqMWAP1nxpEzJkJCnWAM4pmTNUhq2Th3?=
 =?us-ascii?Q?xIhcyWc33iPL7DsWhb9v8je/08WRYqLKHfrD+5DpSIwhola+sBZHCMBlFqk4?=
 =?us-ascii?Q?KKzSZMhu5/ACIRK4EsULbpO/22aRx7a6ARAfR74827wezoM+9EjQxUMsOQiD?=
 =?us-ascii?Q?bnO7p5B7WBWzaRP1mBHLP+sy9ZWjbFAfmnPAmLewlVBlRj4HLGT2af/kj0t8?=
 =?us-ascii?Q?qO19/EULbu8FI5+POPg29KzQujDpjpkghFbnPmtteE4vnkl/B/RFiKnGZbhy?=
 =?us-ascii?Q?B1MT8aU9DjhM1fwXkK+NKI2DR2ViGJm4skkWo6qR2WkyESPQaOEOCB9/pzpB?=
 =?us-ascii?Q?8+l8kklyN8GbyLJrUnN2yoz8ozt8gBRvKH9jNd29jIiQY1ikc5EtRp0GavX5?=
 =?us-ascii?Q?JLa7Bg9u7VRssmdAJDGsr06VvizVM+6i+voYjaiWGpWB74ZGOlDe0WITI6PI?=
 =?us-ascii?Q?OiKwdZsZNCIfUkBlPuDTkik1fPHfUbAXMm4z8VsUR9M/b+6hSiGwcRvrKwK9?=
 =?us-ascii?Q?+FGO/hOo7v7F2qHDFykCM/H7BmqmVGnPU+geB/6wUg/ggYL3wNYq5LcdqIWO?=
 =?us-ascii?Q?Sqn/Dm+kX8CVIt8nn8Xyfry188A3JAiGXVA55bDaIomqs8V0xUya+iYpIugo?=
 =?us-ascii?Q?kOq+XclGcCDlr/ktix6FzwVBd5PKQgUW71+3pW763dyB7pgPOU1zFDo0IJFh?=
 =?us-ascii?Q?nmpl9wFhHm4itE6Qv6J/vxGQ6p5iDt9HHIkAfMTsTEHKjpFMB8MzCRsVuiHu?=
 =?us-ascii?Q?MFE3GRO/X+ugbHU6FTMxg9sJKPD5SFaPwlBFJ0SyNEKijGFqkjsldqdbg/oF?=
 =?us-ascii?Q?K7SFeFPE8gIdfJu0neWv51xrRby717Sk3injRwFjNQvDj+r9gkJr5lmxMg8/?=
 =?us-ascii?Q?bLhYPfNGaGQ8GlDSwKxaYu5Bs5ob/uw7b4F0fLYAJ6amq47M+aCIesAjdk6u?=
 =?us-ascii?Q?wocpdrbeBIRCU7ZxLKuRXEO7SkuTCq6f+k+pkJooXQ0rqodK1gsjzaWsayAN?=
 =?us-ascii?Q?dRKb5hjZDK+K0gxSXAAKglEFh+9zh9UYjSzqKrYBvs5A1TzXKWYDEp0cuXpc?=
 =?us-ascii?Q?22ihngdXpITjksW6kcPNhzS3doIgntHTK+k9gf0WhogebAHLFR5cgldPKwGi?=
 =?us-ascii?Q?hxpwM1nA/IVLkpH6S5FQafcgi2zIVgeHxv7nbiIY9MYOF0yX4JSpxqTFx2xU?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7167b8c4-0cee-4db9-7680-08dc6fc1974f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 00:47:23.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7inSL5W6S9rzN2i+66Vpmvq0neKBxZzUEUc5/fkD6rSQpGTSngt6eJmfFoaJM71Mfbd5bqG2m/NioLD14E+y0deApFFQQt6fbbtVvTE/gv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

Currently, the cyclic_register() done in wdt_start() is not undone in
wdt_stop(). Moreover, calling wdt_start multiple times (which is
perfectly allowed on an already started device, e.g. to change the
timeout value) will result in another struct cyclic_info being
registered, referring to the same watchdog device.

This can easily be seen on e.g. a wandboard:

=> cyclic list
function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
=> wdt list
watchdog@20bc000 (imx_wdt)
=> wdt dev watchdog@20bc000
=> wdt start 50000
WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
=> wdt start 12345
WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s

So properly unregister the watchdog device from the cyclic framework
in wdt_stop(). In wdt_start(), we cannot just skip the registration,
as the (new) timeout value may mean that we have to ask the cyclic
framework to call us more often. So if we're already running,
first unregister the old cyclic instance.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 417e8d7eef9..caa1567e0c3 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -122,10 +122,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 		char str[16];
 
-		priv->running = true;
-
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
+			if (priv->running)
+				cyclic_unregister(priv->cyclic);
+
 			/* Register the watchdog driver as a cyclic function */
 			priv->cyclic = cyclic_register(wdt_cyclic,
 						       priv->reset_period * 1000,
@@ -140,6 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 			}
 		}
 
+		priv->running = true;
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       str, (u32)lldiv(timeout_ms, 1000));
@@ -160,6 +162,9 @@ int wdt_stop(struct udevice *dev)
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
+		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
+			cyclic_unregister(priv->cyclic);
+
 		priv->running = false;
 	}
 
-- 
2.40.1.1.g1c60b9335d

