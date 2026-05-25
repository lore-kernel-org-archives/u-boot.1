Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA665CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:35:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8332E8488A;
	Mon, 25 May 2026 04:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lmL1RhK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9BF58488A; Mon, 25 May 2026 04:35:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E52684881
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP/yzzUY5R/BaMmuqqlGcvPJ12iBlXPK/DbdEsUusvus0KuaceNb79koWE43yj5EfeEsNdrMXpeneVZgZ1DR0zT+1NAtOLHWpQmL7a2MCESmFChuLMAWeVKyXUCFDvnowBQPFTTtLgQld0xH0X+2g+iUdf7eCcQoJjfLvoOVKqTW7gk+3YStIse/HpKs/wtc+Zjk4BMWPaIukWAYLIhh471gb1MEih7m3G5BL/WP1e8VMv2Fumj1r4AXT3nAZH0v4CcTYvr+K3OaOi+nCo+zLYZlQQRdXpNDK2e+K8mpKpGG6zUx0RDYELPOr8VgMSEuya27bccmNwuQLge4m/dh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdPYb89zzQX2mqlyWdIN4FGwmK5lUU6CC7gqnubPMpk=;
 b=a67X4QhNgeY8k2S8HPcWwOMKQ+G4KzMBV6X/M1oNh9EOBImBzAownB/i7m5KN9p5vnAgYrXXivfw9XHXj/rkqYc+YovTo2/OmYUX6jIB74XY54RKLQceZwx/Qvet7iK6F/WZ9+Zo0iz5cudQ4Za1n2uCdyCYpM5tzi2CKJVgYpvYBLzDmjbQCy94TGHwEPyCwaSgIEU+LFwYiEfx7sGgcIldd/vnQB9ZZF8AU6a9OFoaV2wq/2DrwQUJsWRWN+N1CRmF0WUtCPuLXwS5U0+8xmd43gL53C/2TOooqmJJaM0hZIp+iWBcoTLqHPCCHXhn6sdhW3H7jsyGns65G6rLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdPYb89zzQX2mqlyWdIN4FGwmK5lUU6CC7gqnubPMpk=;
 b=lmL1RhK2IQ+TYh7I2S1xwN2U/opz1bXkCUefzhc96oPfZmbxTWLUHIVIsuwkbm1g8bTRJQdiVLSjRbh8Czy6b7W9BZYH6lE/+9fresS1PV20sKX9ud8wjgwgCNWw1aSq7nuTSQa4korUNpcNFhnLYd2r799V7PZBO575YST+zNLtvT91kTCSR0TK4Rpsdzd9IaPSoRraI6828Bbt/PJwphs90ckMitG23ZghFUFvMbTmdMNduRNmsJSEcpcGb2MBN1HgYuDXil1S7CYarDdJhwcCfad60qjxMjyk7lIK7DjUbfxRr7bxGS6xT9chn5xdOoxwhzkTjxl4Yb0MQXXgDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10118.eurprd04.prod.outlook.com (2603:10a6:102:45b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:35:09 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:35:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:51:49 +0800
Subject: [PATCH 3/3] watchdog: mpc8xxx_wdt: Use dev_remap_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-wdog-v1-3-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
In-Reply-To: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
To: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4412af8d-6e41-4b3b-f606-08deba063ced
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|22082099003|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: 1SKfd4BfRMSfPIHdxnNvATttEvhwVLDqT1clOZjyxkJBuzqwi5+L8fSZ7FcsE6T05oJGRtpLN7qU5DvkWGCshr2wmdGmF40jiqL894VSPkoUeQ4qVeHfYPzGeQp74xxqccpLLf6wG+RhP1rzA9Gi4D57srC1BRW9Pqut/tIzUR9o7J8TO7TO45kdWKBLWPZojXIHvfhOe5Ar6y+XfNANwFKx1F4uk49bwInthHerxUFmmcIdG5nq5n/HbJD9tg4o30bmZrOYKGA3RfIeW4RSYPcIctlF1pVFuv4kkQq8hcoQ+otz2yIcbu3s2RJ4SqH+P0VQZuJ1ECLRY/eZi7i0m0VIpQe13XLqMKVSWwdHtS4tN44HIdl0XCBn2FWmgLiuCe4xYe6rxeScCI74VLpzve6qmUejiXze+emRSJ6T03+jeFW91PU6ujKkFQhe1wVr8TCZrrzfTeQuDzGPuPH9Wm//37EWE7xuUFwZaundlAQ/y/8ls/kFTy5trbmv9nzvOwO6LW7OwVeEtxNsj/VnRTXCRqTraObofw/aB4NY08vM2j172uOe2kKbrFp2+wgkhvgB5KybmvTKuEcUXx1+afc4wjyz4Dudr3KVIybGGsaft1ODXqixsOVuYjUrSGhGJEfJIXnGYY0cEaj+864Rsb4KtasWyQSharuf0ipiKiT0PSO+tOYqQf0yXvDTaJsrIxOPi6vTdld4LuSR8xQnwBaGeungCDFeOQrzCrcLtwiWpNpcAO2dVVn9hJ7uGgTl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(22082099003)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFSUHZZeSs0WHY4R3d0WDlzWWtiMCtNM0l0THNVbHRrVXNSWlI3ZnR1SG8x?=
 =?utf-8?B?WE8yY0lPTlJUbGtYR1dWWU9hQm5qNjVXSWx2SDgwWUZ5Rnd4SmxRck9xWFlC?=
 =?utf-8?B?R2tCZGVGWmhTc2QxdGYxY3dlTXRVSzVsdFhzMGZqblVBRVZBVEpvUE5WVWdB?=
 =?utf-8?B?ckRROUsrTWtRclZLWVJzZWlIUVB2cTI5cXFtUVJCV0ovWUVhVFFzK0J3MEho?=
 =?utf-8?B?UkhrSStUcGE5R3lGVmNEM3c1d3NKVzJtSVBzcTEzQ0Evc1o0aDFNWFZKYWpR?=
 =?utf-8?B?KzhpMkdDTUpOTUNYbGtKbFdaK1A5cE1kOVgyajk4VFVxaDdvTDRuZnQ1VXFM?=
 =?utf-8?B?MDh5MGZRVTl4bVV1cnNqNmtFc2wzUEw0U0R2QkY4aDdFZ2hqMmJxb0RzeS8v?=
 =?utf-8?B?UTRtUEZKUHk3azhBTXIwakQ0Nm54VU0xY1g4QmJjT3VOY1NNc2F6UW5aS2JK?=
 =?utf-8?B?a1BMUVJRSzZtNFdENlNwSGFCQ3RJSXNIZzVJUGVBb0UvcHZUUkgvbHhWY29p?=
 =?utf-8?B?VHY2bm5QNUJvS041TXM2ZUkvZUlCYk4vck9iOFZpTXRUYWJRdnZlcElkN2Js?=
 =?utf-8?B?clNod2VoWHdQbUVVVlEyUVV1UzNPRXozam1hSDM0Y3J2d3NYK2NYNkFWS2c0?=
 =?utf-8?B?VXUzVDN2cE1DeVZpRWxWV2Znd2w1TFZ6NGFYNE9ORlc1TkFCWU43YTJQRlNj?=
 =?utf-8?B?ek1zamZYRXA5QVh2WVFydlp4WXJoVUY2YTZ6RFBad3U0TGcxdGRsalpsUzEw?=
 =?utf-8?B?eCtoNHR4MThBQ2tGZEwxRHE5ck9Xc3M3WnRjUFBWZDJPdW51S3NOUUp4WXNv?=
 =?utf-8?B?Y09ndzAyenNscEx0ZFUyT3M2SmhRcVB0SkJMQ1R3OGhKV2ZpRTllMjZNaUhF?=
 =?utf-8?B?cTFZa2paVUF3WTVoZ2diOVM4UHNxN3hGeVRzOTJiRTlLMFZkT0VmSnZFdFNR?=
 =?utf-8?B?dWVuRGl2ZXNoeTU4MmpWREdKa3R6TDBDalMyRnRSeFBSODNDQ1lDaDl4YmpC?=
 =?utf-8?B?TitCemh4TWI0NzNzZXpDNWFPQ3RLRURxcUJYdUQvZG0xdDd3S3VuUzJaUkdn?=
 =?utf-8?B?Mmk3UkJSRjZ0OTBSREt3QWxQR3NHVUo2bWRsUEE2dlo0NXVEWVY2L0E3RG5E?=
 =?utf-8?B?NHNrWGU5UEY1YWNTdEZ1Z3BFMFRjMm9zOC92cCtaQkt4ZzlBQWpseXozN0NH?=
 =?utf-8?B?NjZHUlpIdHRCZi9seWkvc0tvN01zQ2JPNm1hd09IZm5QYlNmS2NpWEFISGNo?=
 =?utf-8?B?NkRwZ3NwN3RYVWZpSzdTMm4rS1pkbWhRa0hZWFp4SmhFUG1aM0c3YTZzaU9j?=
 =?utf-8?B?aHp1UkdwMXYzcDN5RkxIaStVU1ZTSlpPWUtoaDNrNWcxNGxBVlZIN01FUmdv?=
 =?utf-8?B?ODMrVVJqOWZET2tpelJNWHA0R1F6dWZmSWJNV1d3M3pzYlVNQUYzeXVvTHNl?=
 =?utf-8?B?anRFN051RjhsMUs3ZUhQczM5ZkozeXlacERpbmNQVmR1ZU44ei84eXQ2aVZO?=
 =?utf-8?B?V3NpVHNjTnh5ak8zSjdzb0Q1TU1qdnpiczVONE5jRFRZNE9NQkNIbnVjQU82?=
 =?utf-8?B?MDlickZSbnRKUTdNeFJZb1RsenhqR1FKQllCWHNsQXRqWmtXMEpBdFhIdW80?=
 =?utf-8?B?ZGFkZHoxeWU0TUdwVW1lczBDWjFrWnI4MzV0WU5VVVI3QkdhRytQWGREUzBG?=
 =?utf-8?B?SjBHbzFGcjVkdDhPVkU1VjM1dEM2WEZodnkwbTNCVjdkQU5xaVdWWXNyYW1O?=
 =?utf-8?B?OXdLTGx2Q09pSklhTk42TlB6bjd2a01veEkyZWRjTDB3OW5PenZuVEg2cVpC?=
 =?utf-8?B?WU5ZUXoxUHhPZjZNNjRObWRwQkZHbTFRZWk3S2NNZGNIcDJqL0RsUkh5c0N0?=
 =?utf-8?B?RkFEWEhCNmQrVU0rdGtmc0t6d2ZNMkVOUEtUYWp3dnV3OEJMMSszTUlNSG5K?=
 =?utf-8?B?VU9wVTFrL0x6ZytJa1BVSGZEOHhtT0o1RUduRGhFR0Q0QTZwOVV2ZXM3WmpY?=
 =?utf-8?B?bUdvQmsrR2grMXdyWlZSVHJxMlZ5UW5VLzVGUGl4anY2RkxyVkY4cDB2VU13?=
 =?utf-8?B?aVpEMG5QZDhweSttSWFBcW1vNFVNbVkvK0Q2UmhVVnRwUW0vRkVXcW5jb2Ey?=
 =?utf-8?B?a0ZrcnRaSll6aVd5QldjdVdaOG1TVkFrdTNubCtsYkJTUjBCN1plUVhLNlB1?=
 =?utf-8?B?WCs1U3lnUW9KQjVzWWR5UyttOG1RSERuc0V5amR2VXZ6TDlCa1B3OUgxblZB?=
 =?utf-8?B?eWQ4UlA3ajB2dENzek55bllkdDJLQ0tDVkRkOHYrYk1jUjhDOFdXRnZpVmpn?=
 =?utf-8?B?RjdlOWoxcERKc3FuTXBDWUpiK09ybW1LRWVxNzlFY21OMXBnb3JDZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4412af8d-6e41-4b3b-f606-08deba063ced
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:35:08.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZCXQDtTiDwJiI+D53kZrhggYvA+x3BZrswizdSq64rJhSuqk9pGlP9TUZsybGogypcmb4FxwZPgK/bRy9K7pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10118
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_remap_addr() to replace devfdt_remap_addr which supports both live
device tree and flat DT backends, avoiding direct dependency on
devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/watchdog/mpc8xxx_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 7fcb866f574..068f99c5fc6 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -81,7 +81,7 @@ static int mpc8xxx_wdt_of_to_plat(struct udevice *dev)
 {
 	struct mpc8xxx_wdt_priv *priv = dev_get_priv(dev);
 
-	priv->base = (void __iomem *)devfdt_remap_addr(dev);
+	priv->base = (void __iomem *)dev_remap_addr(dev);
 
 	if (!priv->base)
 		return -EINVAL;

-- 
2.51.0

