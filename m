Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E63E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA89841FF;
	Wed, 24 Dec 2025 09:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YbskNu4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED2C841FF; Wed, 24 Dec 2025 09:24:32 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D477D841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6HNakn92GsWJuUg3ROgjvHtH+QL87EObM0qC/WZPLJdBH1/3jBmxtWFersD5hPGTGKldaXvZ0IJq9ahN5QGAA8WVNhEPL4xhJE7XvrKh7mzsjTyXzYLkYWrBZTJMEZzhbfy64rFWQNE6V1gP8TKKcNC0RUzADzNwUaXNF0iKMbGEp6W0ImEtdeRydiUH7q+Y39e6dbFhfmxnG7gdlHwXNdqE6qsqIHYnx0F1pg3VanwsGbcRnbBh17zTN98di8OPG2FUPe27ylb5AEAbSd41AJ/dwgLWQ1wLZXxc5NWrDtyn46oo08Un4RF4hp0BOE9FtdZzjHuIsMkjHn6vRp5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w34da1vU3OmfZdzmE7JdH8kQgy7IBvXg2QoSBtRjqic=;
 b=sXwJzwteZ838OfMXTgr1vk9vd0iFunQ4GjzHKzCTVxbbX6eOK8ZZHvOoIZSPL6KcSLmnaz1EN3TyqacvT43sUm3FEQKTlSGyrWWslX5Q0CKHF2IeLab7kTZt0Y83gT5ULavyrDbjh1MyxRxAITQ0tY9Qfr/Yhu9he8RPX0NuYhTC9jHyaNg82lT5IHtZ6D5vd7fcelY4VvvvdasBjMhVvR1z7U6mMBhPkHnzso0Cmry7KaRjfwfSWPOhlB1TRtuWUHXeT8iDUZklUSY9eSPq0j40gWqEZ1tWJ3DKHzvk3XLvKd7PGvjoYaYqGtffIHyoIWZIgHClmaOzAqxWA1/hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w34da1vU3OmfZdzmE7JdH8kQgy7IBvXg2QoSBtRjqic=;
 b=YbskNu4AEaAed+ijg26yNwDFVpx5boatSjVlPSPuiXaan7oGSG+KvkR3RbpmkbiyrE+h6COTEliAQf6seXU5iYtwhCxE3xqJSn/3xk8w3Gx1KlFkNCvgO/2XGn6yVL+1fgIGaF00cH/7R3Lt5HHj8IJ5y70OvwQCahYEnWIihtBM2OMAjGBgZVPHjD/zxXuV6gcN3/btItV8rJdrdY1hJtPyg26RVvW6jMfKg7w0xMyXT1Bd9HfJ4abrjdxBvztAgYDDQVAaAnDbBNRFjlYABHI86YPoTjPseoYEHBH0AtyuBEHyZzVFrMp3fc6ia62mNQBD9uHiITH+GUvlaw24Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 03/19] net: airoha: allocate string for GDM port name
Date: Wed, 24 Dec 2025 11:23:53 +0300
Message-ID: <20251224082409.1347373-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deb4120-79e4-4650-05c9-08de42c5db96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tAt4j9k3ki2bHMdTiZIJeiN3SJzGBDjal/XL+J+Q9hJlci8k6+QIYj4W0d3w?=
 =?us-ascii?Q?SSt6Keex4xCEOnXhGARp2fEqJVDNqsqbMSUPyJN0yLcCu0imTCq9GcOdenhf?=
 =?us-ascii?Q?ROrdRuC9bHAOspZB6TW9vNU0249R3kegKSLlY0jwMwb49O002Y41fX/RYy+P?=
 =?us-ascii?Q?q46NAD7+26WAFfV8bwIoh+GfPPbQw3dQ5Ffv7uXFLttS6apfa7uuIzjNgt+A?=
 =?us-ascii?Q?RjyH5DPvhKYick5VOqP6nJ3hud+BRWgRGrv2+GA0k3XSF8fjCvlN+yODlBlO?=
 =?us-ascii?Q?2pxeVRsuhUL77rAIObYL7r3LznmDfJdlnFQhPWgLQYT6zjV97QgidEBunTub?=
 =?us-ascii?Q?t1yen60vp/mWHBqTSoC3DDOydQSpyN30qwaZqA0NZ8WZSiaxFSkDai0fbpRp?=
 =?us-ascii?Q?krXhZEYxfj7Y3QdRYzwbTouE1m5BTtWZk7Y5M+1oR0kpPB+B/FasJUu+68gE?=
 =?us-ascii?Q?drPG7Sbr8IsB281EkEQnQ+mqShHKAQ/1HWnuBEu1uYcyOZ1AFzfVYbrL+7gT?=
 =?us-ascii?Q?rE8liACHjTUjNdOJ46X6rHOBg40LLXQ5MgLxgnDcZv+y10YC+xB/MfF+xoeu?=
 =?us-ascii?Q?OfzlQe0WN5/FggKp7Vz1OQrsHLQ9syuIhpKTPbWfVlyE1x7trCoVqiXeRD7h?=
 =?us-ascii?Q?sY2KlH5fWm7J3d/T4Mtwe4okO/+nEiDXUW5J37VEdadJkSW8cnwoF+pj+ioA?=
 =?us-ascii?Q?eJg4M3eDsexyMAjGKNC3DCifFp53OqrKWZeAv8i4dm3n8ReYIO6XLy14nCRC?=
 =?us-ascii?Q?qzCPPwl8Zkyp3RB0iGz0NAAx1Xobzb5pGgkcJPsm7Plgjw6d/Y9g4eaQ1Mjg?=
 =?us-ascii?Q?0FDqYuN9g/tTVLKomkcfEbYlXGcXT61vDFmCdNRjsBgNcvuAg372vPxhi/o+?=
 =?us-ascii?Q?rsp1UwYq1Q5thJSZxFmuDwscoZQ5RKuBPraoF3QUpV00+RP5FKcJXvR7ETsS?=
 =?us-ascii?Q?WsUFL79i3gzGBMmxTLRBSDOaFpWx/EDTonUvTMGCXANhpO40cpbWPG6l/EZ1?=
 =?us-ascii?Q?7zsdl4WyLl2BQPPttI92VFGL8SBMMpd239MHcbAS2Xqlqr1pO9NhwY++ELdL?=
 =?us-ascii?Q?M4tdqLrHxAvfOzi3sPttn/9jmEzqPbaZ7lrVg2garp6a3PLpsyaPvfZ2pICx?=
 =?us-ascii?Q?HlG7jOBrZZx57djL3MQNcbxnJpVzglOIjqChQjxyjvYtvtpaNmUZy0JsNWqD?=
 =?us-ascii?Q?w0mp88n53vjF8z0KLto4ZRNV4T//Dyocd+r6vht7pUmSYbuBMqFaoNIqo2cq?=
 =?us-ascii?Q?7vwAsOXs+Ozl+iP0ZZKAxWnRSnW1x1ptnmCQ8B8pkbfTOBUHWL1IoupfAHm/?=
 =?us-ascii?Q?wAXOYgL/ThDLDni9BKViuyp3m8moqxcyHSkcUnEeLGYSQuOeWf8P7bzxDP4u?=
 =?us-ascii?Q?D/onmjtlkyYkbcwdOkZC1DJ6SKxHSmaT0QixO4cgGSeTW6G/t/RAIyCw/xSf?=
 =?us-ascii?Q?4rBZKomVWNrIsqnaANqKJgbX9ODCZT0qUIcHUfIJd2nbKU9TH9/9OYRaaJfY?=
 =?us-ascii?Q?yCvR5lXsgMsciKBUgvk8vym8HBvt/XZ+K6JC45LfFiQ1V+fhElaXEumchA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nKgvcOkd/GrWF8txemK82/5Y3gIbew6CN0aUyU2KYqSSogYmIyAGoBtnyy8C?=
 =?us-ascii?Q?TrxgNiWTW7QcpYTUgZkpTmg+ByUKiqsM33X5XAhosNLflu84xaU5M9RbaDhN?=
 =?us-ascii?Q?OOaASINqKmTPWAoJHf0xLM5KhMo/hSNHaOvoJ0U7S+bcekOzNyTAYs8pL9lp?=
 =?us-ascii?Q?uQbhvH0MU5LwsR02LkiFKKcBFwJJuGqNNrZftuZco/DSRLxRPNKvcJhHQLz0?=
 =?us-ascii?Q?ohkQmevx95WbfXEMiZw6JxAr+Hbh0X5c/wAiQh6xwnX0QLWeDqr2a1nLN5/9?=
 =?us-ascii?Q?eEQ9+gEckIPpRiF6YlD7wOr+Bg09kN9BWJj0SvGfAelv7376KyqbX9EkiiPj?=
 =?us-ascii?Q?sbvvRgJmwbyI0TnHXPMrQ2ymmNI7mXkWovNFgIBRocBZ0f9/xXDNjrr1vZOD?=
 =?us-ascii?Q?CRMHjLKTAuPJXVn3zOSk3ejSETpUGzN0jNL3ZsV55UdZjDIeC8SJpgVVWNSc?=
 =?us-ascii?Q?Zr6Qz7SyqIQgrnny/5gOb1ovk5N4HnJtAugA/3ZFryB4x17oSzMBn4UqHa3W?=
 =?us-ascii?Q?CuX0lnjOxz8f34KKu1VsUmDy25zJqVFrHp3Zl0DZZ3hVmb2p8n3h7hDy3Tjg?=
 =?us-ascii?Q?ektSRov5/FEcDOOLTosoOBOVZplaME8OaumldgtStipvWbYydiWuRjqjD5Dk?=
 =?us-ascii?Q?tCEr6hOuXYLjuu6B3qtN/V4NMoxqwiToKhpf6oFsWOHzXnifg3g5IdFlVGIb?=
 =?us-ascii?Q?wuKn6yA4HH6ntg+QeKf7dWOdqjxvrjVuc4PTZbI/Ur1J9b+0MiIWa3TO017J?=
 =?us-ascii?Q?ha3sMafclZZe2e+qhpcztD6yJCYVo4BntaTtPkJYTZGndd2DCtL8z9LAs0sf?=
 =?us-ascii?Q?RhuaTklZ9y7N/G8nW5T6tFj5qdxyTuEQkzZEyBQkb0tgrY4J6lt9ANAt+eDm?=
 =?us-ascii?Q?EVDIl++jDaXD5L5uETF18mUD2WK4YZI87Cr8w48oy/6FV4GqV3HFssXVi9ZP?=
 =?us-ascii?Q?5k6hf0HT+Z9gDIzUD8YxKBiRi1XN0yQBTSamBrjf32LextWq5036ShQklBaW?=
 =?us-ascii?Q?esP7/ZlB+R2CPHEXNzSZCJxvG/d5bTJWJ/Ieic2Jl/gDU+wBgvKK81VbG15C?=
 =?us-ascii?Q?XPxtxSVretU3r3smD3XrNtXnv8kyoiYVj/zmOhUQkv6IoPpYaPgVJsY5XgGa?=
 =?us-ascii?Q?8TIUYM2IlUAT8oS7CnUQZjbgkTRTatidnN7u55yUqjtjpX1AVRvIgBtRxVh4?=
 =?us-ascii?Q?RtMW8Ug/OKVgUzXKSWgVzEL6bCWBO2HmjVw3V9wYajbyLbEwoWuujVsFqP5Y?=
 =?us-ascii?Q?qTGPoIOO5oyCsgT+6EPuQ7AADzCwe82CCpCa2hESK6MiPkBzYTCgS88PDtsu?=
 =?us-ascii?Q?4alQQ5jafQlzmVK1Kx2UpCpRXKC/oGH0vVT0IwRxYBJ+v7jSoO2dbg6IO9QR?=
 =?us-ascii?Q?wlzAQ6u0+eXvmbFBh2UPMiXzJfx4GkhA0BtJGIKFs+33uCYJS0EZpP5IN5ly?=
 =?us-ascii?Q?XEgD4aUfG6e6nIkQhLKbR2wTZznjH+xEI+t6CSlK5dy7Q4xe+8MqZZiCpjwg?=
 =?us-ascii?Q?xVw2A5htzAJD7X8v8zMgWl5RfaSPkv48qfcPoT2/Hd7CSBVKnd0vi9qbgenC?=
 =?us-ascii?Q?rcMLrVHsgLuximVtMhVIrHgk0iwBNMAsaVcbWtSNvvRxVAplihGz3EqCF8hn?=
 =?us-ascii?Q?h7co4PqUdS/C+G4bzVtZg56rEk1kMM5JWg3EzmjnwM4HltTtHRj8WajrOn1g?=
 =?us-ascii?Q?Zdq4Qs52NaifSflKWp6t5voSEte0prInJdh878egAaZWdmMkQYvKkkO9aUMq?=
 =?us-ascii?Q?fdf2tCisT01v/Xg8sjUL/2m0Z8S63LM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb4120-79e4-4650-05c9-08de42c5db96
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:29.5957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFi8cX6OEE6lFKD2P532wTeU/PEdYyEw+eG8PG7f0DVVce++IRPC/obzHNTphk3/MiuG9Co+ElUeDxbpSu+ILr1L2KLrjujlfoW7PORMHQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

Allocate string for GDM port. This have following benefits:
 - avoid out of boundaries access to gdm_port_str[] array in
   airoha_alloc_gdm_port()
 - no entries for non-used GDM ports

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 31937137d59..900cea46264 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -330,7 +330,6 @@ struct airoha_eth {
 	struct airoha_eth_soc_data *soc;
 
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
@@ -791,12 +790,21 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	if (id > AIROHA_MAX_NUM_GDM_PORTS)
 		return -EINVAL;
 
-	str = eth->gdm_port_str[id];
+	str = malloc(AIROHA_GDM_PORT_STRING_LEN);
+	if (!str)
+		return -ENOMEM;
+
 	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
 		 "airoha-gdm%d", id);
 
-	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
-					    (ulong)eth, node, &gdm_dev);
+	ret = device_bind_with_driver_data(dev, &airoha_eth_port, str,
+					   (ulong)eth, node, &gdm_dev);
+	if (ret) {
+		free(str);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int airoha_eth_probe(struct udevice *dev)
-- 
2.51.0

