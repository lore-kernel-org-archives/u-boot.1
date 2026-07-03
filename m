Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F84C43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23A684AFD;
	Fri,  3 Jul 2026 13:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p6LLG7Hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3079484AF1; Fri,  3 Jul 2026 13:57:30 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A589084ACE
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khFCP6hlY6E7ORTEaEl1+UDyH55A5mzpk/aK8S30mgBUkd5PBIu3LF6cUWa2a9LIXu68+72qX6KagySzIGa6t3lqYf5bR7kAcvhUFuh8X3fAJRsjYYOm7VXCke5fXlU15d7cU0BJc9AxyOXre5tSeUUH8GLoDxtSohTqWDvR3YiE9CdoI3JiQyvczzrd9rL2VRPFMdfRJquAB9W1gUw66YWX6NTiwJJ1pAUbzhc+pGiCf7Mu17ZYycXLY+E2szDC7rMCP+Vl72FTTEFuMK7k2IF7nO4qaRwxSjNgeIwSojhTZ0UqjDkUEl2vhMfJoOCl7AhiWHMhyJwd522svNXdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3P4Icyk90tDZz+fMoWbPs49pub99UPFzxFK96l81b8=;
 b=LIsNfPoAwnCsWsGTFXERbXSVfczfq04jFtuJbJGCUFCV1IuAuCro2ClhLwvesDPE4xpjHgoYcp1JH1kYr5MwUQoQM9GX5B3KFoHDQw2kboZvz3tXN3h2B4hAJp38rGSS9eO4cO2mYuw4LWcC0ibfx7/zIKf4udQg3s4EwU/KGBfPNTMqT2Gnz0YMi1RYgXnBTidCEQufVYlMm0yLHwjqc5NRnYvRERF9HDaAduyWLMTdh5xtwcX49Xye40GfQTHLioEFDSEQQuQt+MBoQPQLb2aUPs4OP6DBmoz3/Oqvq9uV1edv05bzVl0joh/TnDAlffuyapVlmOGBwfWrYdp/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3P4Icyk90tDZz+fMoWbPs49pub99UPFzxFK96l81b8=;
 b=p6LLG7Hp/LJwmiNsKSE5FukDVnVOndedIfaJ4LV7v/kNA53Z1XQ++fE9bD3YX0siwUYOrPIbcc/p9DTvTPCVUTL2tJSPD34mSW3x/Jiq8uEwNhSTIptBSHkISO7MX/Oqb9M1qdV2Dk4bwse6r66utkul8bk78Mk7/re7BmsOoyty12a12ZbETXPG26ZoWuvB08A0IXRUzQ6KitCqHohchPoal+uHpA3HgdU10LGMFyaHAiszEBgQlefEx7+ZuXnPihhZPSOt2vuStHZRYda27JKWX32Dz7+JE44f6FK8cBUsGB47ixQWdf9d486PWFgPEMrz9q+KrmLlVt1gq7wJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:17 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 13/24] mtd: nand: raw: sunxi: Convert to common field_{get,
 prep}() helpers
Date: Fri,  3 Jul 2026 14:56:16 +0300
Message-ID: <20260703115627.2317120-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c8c0e3-0346-4e9f-0bcc-08ded8fa3a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: FI07GtkwrHQ2NxXKHFadLH/lgA4+L67dUS5/zHISFLfaEUXZzuVPrdj0X3wzS3d2pn4VPn9bG8T3T2RobIheX9rbY2h2Abpxdi37g23MOnXgK7LVIUUU9b04W+oHxNxPHdEqXWUBVD2Dl0wr+fZirfdHtIut8iVylAtS79IZ4YvOYhlK39xALgkvIf1mDknP0uKls/qKv0WWif0t59yhX9Buu3cWW5FwMCH6OsaokxOYHM1YAmga50n95lum8TrftzQzNaLwFYgV/Zc9yXN3W8lk0DVtqijaHHlHEreoKySCEja6dzo4ZEOxuL11rxAjI826e7KOBmcWW+m6KiRWA8YoTzAa88HNKg496BhoprRRaKvBiQaXa3vwyizf3gBtqTIUUCXHVnmSaS5OY6n6RgSDa7vJ6BgRHqtQ5s8eJaibwojFI7FvVvkNc2fB3dzZ/6/XiAFcQ4PzA3dIF5zGlROwwZEATEJn6Awcd0h5FuwG8TSSOrDIU493cFtM6TXML7pXLRdqGefVSShl+aFrpHsS8EuUqZ2MIHYE+CjziCLv0s4ghUBTVkqPIvEv5GDoYBIKqG7RSBtiawBTQSTMxyqWxbGcYdaCEJsdpzF8xZuenck9BqpVB/MR6hfuJD7hEXm4T1mB0y7GHmbJwemslNFKv/WXEZNcM/xXRtrd5Q622h5XwX8zvitKM1xV/LkoolyXqMrlQijLay0u0pQ1sRifYIAh7xPLJkduB9WbCdFK5nyvGGTdKPd8Go44XqsY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFqn0QvMW/ATWTtVtVhmiay4RtaUA8bRBRTT3I9ReyUBFuP6ZtQKkhBF7bzt?=
 =?us-ascii?Q?RvRPzGdhk89rGA93iZzHGKRsh8TD0YpzM0z70EsVY5V9BcItuzghXpSFYjYT?=
 =?us-ascii?Q?zQIyrn7ts6uFTXC/a9yNGo37kEv7EXTpZb6cHvVX5xpKX68a5dU4BAJzmFfa?=
 =?us-ascii?Q?+uI8OYOvD4gPGqvroXwPXOZ12PFQQir4QWcty18+MZ8OgDNtw8MTJLUBiJ/p?=
 =?us-ascii?Q?f/weZ2Uu8gxS9JmsVNfLbuOZ3Cg0xic7mfgGN2IqziUa8lgFzG6I8CVD3xCS?=
 =?us-ascii?Q?BWEu2P+/4E4J2axXF+fomOP4lkvAfTxA7YPL3mvTThGdGuecpq3BFzDxbl0Z?=
 =?us-ascii?Q?MDiWXPjpBGVUlI9ORnk547zG+1yyVUceyZy2JNc8pcRic9u7xzsXdLszA3Cl?=
 =?us-ascii?Q?N2gej4zmXV67eeTXHi3prdyiG20AN7uIpTfx3b8w5PUuHlKZiwXjxlpRYUrs?=
 =?us-ascii?Q?0wLwP3vD3QMS0YTCPwfVqofIF8hjxvpcalFNWFNifw6BLi5bH056RLlAQlyh?=
 =?us-ascii?Q?dZB6/JDs/4R4SEuHXfhPCUs/04Co6FfDl/Ve5qbuhIdrTtCbH2k50+EGRZon?=
 =?us-ascii?Q?sqCicBvQh1c274cEdHbIuDB79BxdneVeIUCNS6FnIVlYgTOcMxno4naFOicj?=
 =?us-ascii?Q?yMe1Oh1u/Z5dAT1DYzNGLdKvdqaF1pVJOWInNvEGzllyl1BuzhdH9Quq5taT?=
 =?us-ascii?Q?/M9azMgLYcBL7dIFJo6JGDS3Wfq7xIKGGVVB5VZjkkQi9+8XLL76UCBNci7W?=
 =?us-ascii?Q?Csyc5iYk3a5+B1Z60sXxEO11e+lQKYQgf7IBiX3iywuybMw7CerRkp8y79G5?=
 =?us-ascii?Q?ob3RBQTpBy46c3lDMKohRp7gzFB6CpPovaRLqJLnCwEqVn9pJFNXngC9EGX3?=
 =?us-ascii?Q?jamUZEL6662hJVQMkaUY5CDK5jbgr+mjhqaEOe5BO/Pk1+aOwIx4vqyopseX?=
 =?us-ascii?Q?/wxqtK3aM72g3E3q6k3JWyLNlHFVgnxa8Om1ZkqyLTb8KjjZ9faBaSeL615n?=
 =?us-ascii?Q?HIfn2l4QRuBdFNW2YVThzDf19TIcqOKQwcvbtop16JpY7nQ6YrutGEDKMNRq?=
 =?us-ascii?Q?WwZWrPlo48CS1qExKEgWp+swTiYO4mZKcmof8FneFj9TJvLSctVmz5Qb0B54?=
 =?us-ascii?Q?7UCK7o52QAqkZklSOs00q15Sh2lQI9fpdzwoJ8UiI4RlR4Gl8m/HHRr/t+7z?=
 =?us-ascii?Q?KIAyIvAwC3HokKEjJi8I73sI0a8PDZOr+gn9bEPF+seXwvVuVz8JEPyR+s/V?=
 =?us-ascii?Q?SLWayXIT4VbD+uRTS7KyeOBJxFQbZnS6G0k+0BUI6dUzWKBI8aKUP+q10OM5?=
 =?us-ascii?Q?5zza8fM0GtAaPRscvTr/VgLvfPLkhVJ3RcexCSOtz6XYqTnKfcCesu7fDDrI?=
 =?us-ascii?Q?Pxfw66/EsfgAv4DRoAJZ7wyhMK6m7ClLOFVyNsLxBUgAsnQQFNCVPlDpNFym?=
 =?us-ascii?Q?1EjW99c/PTdQ5uaP2krqfH6On9uCWp98UPJoxszjQayyX6rZqPJ4E24olq/U?=
 =?us-ascii?Q?T/X6ZQqYY76B2ngHAtaKbYzkk/br8GCTKjS8dmrm79i1+toPIXlKdBmM5H70?=
 =?us-ascii?Q?g5juWQaURDL9sqP5uqyCxaV7JxcbojUA8rXuL/0GEjM/iH3kMN/VPjBWS8x9?=
 =?us-ascii?Q?21l/zdZ0EyBtRtKZ+XgnezLW10sMSl35VBeF7FQ48TsXHwXwtHjVymQmMd0Y?=
 =?us-ascii?Q?YZjVIq6mbjsawPOWUeQGC9pAQ3Owk7DnkuaoQDmqk+CUAN6gfY5qIB3Li+G/?=
 =?us-ascii?Q?jd7B2/cHidYb7BWKkjWmVhexwQpqZ/8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c8c0e3-0346-4e9f-0bcc-08ded8fa3a71
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:16.9231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spITQ/d01MEmIdTsDDwSTcPbFnkBnQ5wQw/HO1CHmvmIHJ+TND3wh9tE9Xx60/QaVuIp2e8TvFLJIu0p3sHjfI7TOqC5I7VWJcV1SxRA3EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/raw/sunxi_nand.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index b470e1d3368..1b2c514852d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -24,12 +24,7 @@
 #define SUNXI_NAND_H
 
 #include <linux/bitops.h>
-
-/* non compile-time field get/prep */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
+#include <linux/bitfield.h>
 
 #define NFC_REG_CTL		0x0000
 #define NFC_REG_ST		0x0004
-- 
2.53.0

