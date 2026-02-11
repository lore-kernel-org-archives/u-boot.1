Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F264FECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E616983B30;
	Wed, 11 Feb 2026 19:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1ab4hieF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA88B83DE0; Wed, 11 Feb 2026 19:23:02 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F2983D7D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM6Ho9Y1bfNz5KfzU8sgBjgt8SYwo0MzTtvxoblR9JTaYQnCotgrZEF2jGM0IMx8r7RI0U4Vv3hmrrM7w7oIP8iP9xAa7mkDlReNoQGvfJ3FNIQRDcPpILSwYikWGnhcTAOGUEIZBR0O65oeDke165EWegVdpjl0BRwvRaKaNI+q9Bgryn8hRYlB26wULXusYsAN9WAJSBjEb0Hi0xSBsMBLXiA9AJO/sHYWHm7+jtDZ0ox7OpqFE4ERbTrvhC5Xobi57ITct5PDexAGbkjCrqaXi6QZcBKzNpC9JXOgREPTrwfSvp6KR8dO+253auWoX8TKI2M8SOE21NfXJoQE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU6TaSZqJJug70Z9iz4Wnr+7g8i9TPMDTKPjyhaSci4=;
 b=La3Kyu6BWFqdqXdbLSA3dprIDz5ryREl41MSw1/aXCdGuC78RvYIIl5mkzLWnD6ZCsDZs5QQKz6fXU8pXU/mtw5SHyEn6uB8hA+XOW27L3IuWvYjgNxHazLShFYIat7OnFg0/98k+St2xEUb/GharGrf+0YLcmCozLHnfnHVfZxTIAXVtOXoX0jwQ/LO/0cc+NVsL8bsn7fI51dRh1hMsTIdoSrri8jqg6bsp2iM/07OAr1HlA+QG6SpQOdaFpaJ0cmIh8Hn+1Rlrxn+HrArI7US09amC7cYEINzthDAlUcETOVMA+327ohftgz2LrTjtEMoM00atWsVKVllI1ubxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU6TaSZqJJug70Z9iz4Wnr+7g8i9TPMDTKPjyhaSci4=;
 b=1ab4hieFnUfYF8YDBC2ZlbSHh4/g1zLvgONLdGOM6PKpndhy6Znf10FcTdT5DiFQ6bmWRnW1AtZx/sdlIr1avT03CnuKxovMTRQ0jRNf/6svj8cNbjTANaVYbxKj39jJNmunEqKCFKsWZjqA1kcncXRPaLACu6927tib9qeVtQCo2+gD0SUwcQH3mR47aHahyfPcsib8yL9oT0xWEKRFXzcQZjYewE/g+K3/oDgLu3L8aZBGPCm39GlkhkjLmG7fs8c3Yj5oCNX1RpguffAXy+YXho4g402i0GNXt718cLErafkTFnsUrTbXNk7hZMkB9UmIMPxjIIo44Z0b7x++Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:22:58 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:22:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 04/16] net: airoha: declare airoha_eth_port as
 U_BOOT_DRIVER()
Date: Wed, 11 Feb 2026 21:22:18 +0300
Message-ID: <20260211182230.968921-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: bdce2afb-3815-4552-e178-08de699a9553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJBuCou2iwSWamSoSedLNVtTZnUMzi00qBJBCJki7sP3eoie2A69+j0vWW3M?=
 =?us-ascii?Q?m7rdYzDMoeRlF5Cmg3WQ2rI9JOjNa43519vPcYgqwyClJV8ZGsdlMjPkjLku?=
 =?us-ascii?Q?JUPRKBuSmyVlIJXnWuX7RLaXQZZqszGI1A7V9213vAFSgWlcb6STL+Ot9OBS?=
 =?us-ascii?Q?Z0DBDLjX7EIMzLBbBEwRoihwjJaM5ITWofxPncNtLeQh6Zto1PjYPb0PeV88?=
 =?us-ascii?Q?gKGtPmyeUtGVuzkTd2+JlbThlYgOzD8cH4LSru/XQ6Xx3TqpnJ1HTK7dwE2A?=
 =?us-ascii?Q?G33+p9Q/tfo2278CWC4tsGkdoU2Av1WpKLykgfk8hiV74ExIzmQfDWTIGtW2?=
 =?us-ascii?Q?AVPcTjRGhJeHyXD1XLQ+Dt3ZXgCidR/r7/F8q5ynpmjftJrm6tBUEiqUfSkS?=
 =?us-ascii?Q?nNEwjqI6n4Lr2OzyEszKuLhN9W9GGra0KKJ9+pW1pUKlBoHtvUmWkoU09zli?=
 =?us-ascii?Q?UQQBHPmUsBhyM33Ul4U/WBDzWMwJULtqidFDoZG9YzHWw+KgDxZavkr6aHUA?=
 =?us-ascii?Q?065C53gtrE3mwi5AL0xzdUKBvhwD2e9F4QEiqh3uUV1CdEuQC8lVH94527ly?=
 =?us-ascii?Q?XlifqIMn+mfcgPnMKd9iVn4iCPSU8LNdSpahNyFmUDlF+Zp2lR3VAZlOX8Lm?=
 =?us-ascii?Q?Yq+aHTjOV1gU9hZ8K13QyaK3mbttNCDaFt5EsGgnuqSGlcGkTzB3YfqRRqJI?=
 =?us-ascii?Q?YMEG0EtAdGxgGT1TvTnABQYJl+otzuQ3/StzuXg1kUD6ZeU2TmVX+bNWYTZl?=
 =?us-ascii?Q?XhRFB0Uv7gtfdT89B7/A0KiC8nipmRwCpL0B2Er07eQ4byVuNDyvoTdy4qVD?=
 =?us-ascii?Q?qaotq1hL8wR56YVSJDoMcj96zYtc96YQ438NbBYQrVgrSSTqlRg4mTpC6jKm?=
 =?us-ascii?Q?/gqG0u0njJ/6Sg+RbsetruPTSX48Cmjx9L9BurlZ6yFSXxLcSapY1+B8wHKC?=
 =?us-ascii?Q?oUfvsj/8us+7R7YuSgmrflNxl4xP434rtmWZxsmGagEc8QJFGdckGJ2KMm57?=
 =?us-ascii?Q?VUbtUbVGZlUsAXfJE3yVmphO66btdWRJViY3ZlRh9BFRmPWKSXM4cPN3/eHK?=
 =?us-ascii?Q?i9Msw7R8LXHIHnSnG1TV4olqVqogNhDHcgoKtNcv6clmSoxMD6zMi7s+KlcS?=
 =?us-ascii?Q?xR92+5BC62vLQSN/FUUcpcvq2XHoFIpffj38pJGRHQwtzW43PJRDWI3YgJv7?=
 =?us-ascii?Q?3rJKzKv5npwXYXnY8R8bOo7g8jAmF8B/XZjjnfOJ4SQMm/jgx8xz2FZNumKZ?=
 =?us-ascii?Q?s0Deb/3uLWEedaByi+p70gpyEZE28eeE4jiTEYbLa/XFQCUImP6ljHU5UzAR?=
 =?us-ascii?Q?chU46JOhMXQTVDfWOl5tZmJRRvHdzJD44djUj4JDT2oYws/OLGWEHWldR+DN?=
 =?us-ascii?Q?Y1remCNXsMhupv7uK8qEDtz00P262WWMOqLNFTXqSFsoib2vwUE/ReAUuHrp?=
 =?us-ascii?Q?U8an/uiBEfexjghgiizAFSKJJs+7DaMvt93F5kTD3o6joyl/puIStonsoqrO?=
 =?us-ascii?Q?1ExEdOqU/6U8URHzj+K3NnasA36maHf5Gcq3//qAeB0Ef5m0CJ8Lx+4Rrod2?=
 =?us-ascii?Q?sTQiY/8/mS1KJ7WYSa6CtwFYYzj3vhybl8kC4vwuvMrI0+GLvYJO8o1We816?=
 =?us-ascii?Q?rhMhWnuDooLQ/NnjXGldQCiBHTp+f0qMQlkHozGXn/jL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?em9b8311W6kFUeSfrc275iG5nUMQLNOrcJjUoUu0lylygaktBbgZtPReBzYi?=
 =?us-ascii?Q?PS9X/PTaRLMcARKDb+pVca8FrvfC9Wp+u2hB7wTVu1H5bXldlLeACKecfcH6?=
 =?us-ascii?Q?MogkQ196uVuPlIEsOgA8U6l+gy7MQU+9GX0q89bgpK028bGZ+flQSbcDehx+?=
 =?us-ascii?Q?UtRiH/2YHm/zP55S7mxkRo0o9ky7F4ZukXEUMm2sGdTiIc45QWis+W/wiR3Z?=
 =?us-ascii?Q?73ygNk0+rxTgFzDGsq8JQzRnHm5zY5Uc0zYuW/IXzUGqJwLzUGz8BWW+inYO?=
 =?us-ascii?Q?JIelzaQEVJQfd6VeUTmDTl8p+9vZEx/pLdZAytE89qOBONyQbdI5yzSyQJ1j?=
 =?us-ascii?Q?JYdiJak5HvulpD/vVn3HigPCQcoYe9M67kil02yhKMuqFUsI0USBNfz3NL2O?=
 =?us-ascii?Q?cWpCR9va7EgNBtC0e5ReK5gVISuvsriUbXwm2CLSWPvaRmnTQzCnbzQP095V?=
 =?us-ascii?Q?ao8B8SZw67LwehrnudbsLf6CWTtBaepP54F0aoSy3o1S4hBXl/HNi8RaO/ld?=
 =?us-ascii?Q?odT1Le+wLgWiyMJG782rdZ9frBcMoUBQqQOdK8FUV88HHOha+VL+jus6IOr2?=
 =?us-ascii?Q?z6FtELaaDQ7sWg/4yJd+WFP4Zs7R6/EOz72koRrIZSdmlZSQwff0+YCCbBhR?=
 =?us-ascii?Q?03M807Dh0MdM1YgjyW6PQJ08TwTPsZxXDaKq4K5snTlZm9NuFzmXiS2AS6st?=
 =?us-ascii?Q?e26GTYKxEhnpnHE7Ce7vJT30gXNqsAohImsxSQvJJQeul3/HGkWAldUz45M/?=
 =?us-ascii?Q?CP9Pn5DVaBObPOPGvC8I908XNwF3E6F0ZHofCaT2JOdZuJNPPPrnSXpt1kvW?=
 =?us-ascii?Q?Pok0dn+VupGOwt2p5hMPVk1v/w2rZaA03ojVGNtsxUNhhXsGoa5AcCDJGz+Z?=
 =?us-ascii?Q?iVNeFbOFgY+ey02+uXJeOpNcQT6lMqgpAf8iUQVT0krDS4VUT3DYXezBwxEa?=
 =?us-ascii?Q?QWCe3lPYPqzVbBHv7kSDcKI0JHX/D6S4xEKLIvjwaPVX5/zbpWmO/S0j3BfX?=
 =?us-ascii?Q?M1cishLa3CkI8/EAx31ZI1INHTCoWfv7CJfHO8pUvTf75EQGgDqIUxL/i3k9?=
 =?us-ascii?Q?93Vjo6xXKecdy3PgyFZhU6PwV1p7bp1gYpUxR/2sGgowXbbwSoPDHYMnuchu?=
 =?us-ascii?Q?oLqizTp9OjgmiqjwmPZ84TbowBW1ehXu1AlZDvUQjemouPrQ4cAvl6x0x5J7?=
 =?us-ascii?Q?1iPiA+5JvrUX5RkPyeke+3r5BO/AboeE+BdHHijCjHq+l3o3pZCi+YaG0t7Q?=
 =?us-ascii?Q?dvbsXqJ8lvyB7ajRlzOySankOipsdPrzYZygFCJy4hYltQ/sb9VXGQtr0GPH?=
 =?us-ascii?Q?4cCfW42HU9wmEfjxvIMUFnkk+zsre3OOMBh2sF1xMs82v5EWeXLsQkazJ0PR?=
 =?us-ascii?Q?aekscrC845aaDG1AzaN6hEXTUxbXKVqMrFCmraBzLlwTuYV+c9eY/23r8rmG?=
 =?us-ascii?Q?ZIQlfLdb/XWn6WnQuJPA8GVyGnwjW0MKHidft8vcAKdrPm1V+ZmNBaL06T21?=
 =?us-ascii?Q?JSeN5ZSI1Zqv3uMT6TxeHpBH5+bG+SbybUNI1Q2Vhvn0yUah9gS7xP09xWj/?=
 =?us-ascii?Q?BNdG07MHG3W4PUWYZFQSBZeGB82P1EAzUN+0jecg9xvgJwbIfkv5uOykVOM4?=
 =?us-ascii?Q?2AMM044K54VTa1zj8zXyWUCCE2ssN8HnYb/YQZRZXihlbcctxYdQw1QMnLZe?=
 =?us-ascii?Q?/CXjtnNlbYJNkhzAgsNW8LyEUIa3w4jqdjmmbtkYIx9zoKHhs9fpLKaC2Azj?=
 =?us-ascii?Q?40XpaFrCiE1tcBtpt37ASHp3Jl8iCws=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bdce2afb-3815-4552-e178-08de699a9553
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:22:58.6617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkzZT6zC+9m4wfCk5CvWVP9qSMkLz7g3nVLGRY9QB1ov32cQqyHgEpv8xOFiMtkHG6Emakv4MmtS7EO7MW5Oi9R0rc8HZ61zdF7AraAoBsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

Declare airoha_eth_port as U_BOOT_DRIVER(), fix airoha_alloc_gdm_port()
to lookup a driver instead of direct airoha_eth_port usage.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 171fb0825fa..4ae97326c36 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -397,8 +397,6 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
-static struct driver airoha_eth_port;
-
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
 {
@@ -781,10 +779,15 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 {
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct udevice *gdm_dev;
+	struct driver *gdm_drv;
 	char *str;
 	int ret;
 	u32 id;
 
+	gdm_drv = lists_driver_lookup_name("airoha-eth-port");
+	if (!gdm_drv)
+		return -ENOENT;
+
 	ret = ofnode_read_u32(node, "reg", &id);
 	if (ret)
 		return ret;
@@ -796,7 +799,7 @@ static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
 	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
 		 "airoha-gdm%d", id);
 
-	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
+	return device_bind_with_driver_data(dev, gdm_drv, str,
 					    (ulong)eth, node, &gdm_dev);
 }
 
@@ -1147,7 +1150,7 @@ static const struct eth_ops airoha_eth_ops = {
 	.write_hwaddr = arht_eth_write_hwaddr,
 };
 
-static struct driver airoha_eth_port = {
+U_BOOT_DRIVER(airoha_eth_port) = {
 	.name = "airoha-eth-port",
 	.id = UCLASS_ETH,
 	.of_to_plat = airoha_eth_port_of_to_plat,
-- 
2.51.0

