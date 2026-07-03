Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D92C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7615E84AA6;
	Fri,  3 Jul 2026 13:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="oIqzI/Ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE4E684A4D; Fri,  3 Jul 2026 13:57:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F155084AAC
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIOrTruyqtyxDlzw28yD2ZWYD1RAYfuUK6scdIeXHyMzy7dFupa9oQpU2uzqs+osdxh0csEhDElJYx4uuoyZBCWmE1o2sBnw2NLgHM7WDuPystMvmEGSUeF676mj5Mif4j6tGNMyrZMalm5r57dffkEjoVDiUwVa4ZlNX/L24rM1NAduWD8u9opfI3lp7b/VFa2u9KLfTKr9cgyTt3/tAutKpnJr3s/cIEsedoEW/r0LDd2SJ2FwPmetf0XEsBCTNwI2C8I8bnRnZNm7XH0ba2FZmrVecy9V2H8fsbUinpoFJpp12OI5PxgNtSiMGbyL2I/NvCShB4jvXHRzkyawFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/lajWjnsRmKmC1diByWoiQVunn1uVZUff6407Vz2U0=;
 b=vQk9CdyeTAQQmsGIPtYBpjRspZDRCTL+V6PX15XZTPQ4NCftgP19JCp/QaXclUJuXfGaBgUmvGxJNAjO9uoX2Dvl+0RYezK65bZs1qptC86wJljJU3dQ4aYdLbU5MfjIFUPzu0TazIulyI3x125o04sjE9EGSW+BS7nILLL24ytvZlYWhT8PBkMZn0XQEG2/vvpOTV1mhsYpr4Vpd7zsDPdgTlWz6BHSrnlK8YPDfeHEdVLwqKa/V66Pr6N84PBpSGsK/S94mW3IxZQb45Oxojdv4RNJjHxT0P9maQAcrnHE1n1DKOSj7oH+SNfuhX6yZnOhlVpK8HOxTWz57PzC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/lajWjnsRmKmC1diByWoiQVunn1uVZUff6407Vz2U0=;
 b=oIqzI/Ho0pcIpz9DGrMXYjRii7Qm9F/f/PguXAhh9V2hFjsDnGCR26XtykFL8aU/o+IHOnIkbAG/ErnEU0blwuyGlGCvCZQhl4u5FF8JK+21Dkdw2CC5sDzW9qWmvbEY0+LMdEzAL3wvLSxiRj3qiRTE2T6BCTMRz1jVNxKAyIyjffDIsDiVXXoiGT+T52VWH0xC7qTvXNnKwfHFp5J/VVFt3AXWyvjw/Hpxp6ORU4BFH2+G6+e9lKInB9Dx+jZOipwzh4aofcjo+XM+1jay2EdNmgA6ahQ7TQhngLoqwxs4locZ+Dr5GkSO2zO1OvinDkG0QfqZN8pRAp+u99ah5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:07 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:07 +0000
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
Subject: [PATCH v15 10/24] watchdog: renesas_wwdt: Convert to common
 field_{get, prep}() helpers
Date: Fri,  3 Jul 2026 14:56:13 +0300
Message-ID: <20260703115627.2317120-11-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa202ea-020d-4d80-4864-08ded8fa3499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uXoCQ+D7qoGx7o1mAX5QIO/9EC2jdGlkUVuxsCJ14MaTYvfSfYQEHoXGFHI7LTHfzkXkDnIVomeHSaBjrlj8Sn4dpfc8ZIGHtkHqAVFE+pNHpxYHpxyraai6PG4E/rtofeTCIeOpnByOrvMS24FJXzdbEAL0KaWr4US6+o3xqQVIxZgm98gok1IYz9loJ0NC9OJX4Vs6wMhLgX+MPtpUH0R6meZQZbXKge6kABfHguFoGmy36KXhJMFZj27KLmxHkauPRamyoNfLYK/8JqX3aG/YEsWtcpzpiVZ886WxLE9m/nehoLoCDTXd52Ptyg8uJptnVN0JcmxDCyaffMkLJmcD3TyfCpP3bXpbno1vVZ+Y6z1EJYaWLdlTWgm9E8Gy9ocRAXVsKZKID0YD0uuwClZiJdt0sh7JedjdJKiw0F7mAoUl86fyPo+rubIYzPbOfjqf9PJaA3WxSzK8U92oC/AFf/8Fsdyli4p1F0WNl6idAJcieTIOKniW1iQHLddVE9FLS+o2EUvV7OiS/NXNb3pseGa5ch7n3+323ldSn7AaQHSGeVbYD6dK8r9ZRjE3xUFwQd66o3HHBJc8f3gB0KZmi34icV5ONeeV1qHeXJvDVQsQL+4v40HSUd77xS7mwvifs/1IJ5uGYfsz0TlYb3F4wZZj6XwC5fOa+Csxhlm/SoZUdxRcsE8se0AWBrO30tTBz6NYMqyXuEgMnwLLetclv0Z6eIjDBUspdp/g2OeUqNKPW7jnqciC1/xFhAu7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7h3mQJSLTLoQEO2sr+j8maX9x+3at9KOv9w4L91fyV1Bi9dOxqEHkqbpQun?=
 =?us-ascii?Q?WTX5a34Zbg9y5M6R22xhBDcs2KAUdLVOHC2XNe2FVauphqHp6V0j+zpbdqNB?=
 =?us-ascii?Q?nyAZJCPhV1zR760Q98qUg8oxxdcc6FWJp9pRGfKhrAdUcqE/n8XB7fV41CFq?=
 =?us-ascii?Q?NKaYV9/3d3R3hy+gX0VMd/WbZfX2XiLWrJs9kzQFL0CRW49n4X27BB5D8HMM?=
 =?us-ascii?Q?sqgo7tihDdqMaND0o2Mr4W51YW15l4AYvT5F4yKgjWSGKgnGcA/KVXGJYIxY?=
 =?us-ascii?Q?sIuK6EJbMaJaV1mr3xOEuPoX9U7pb3Gonz/R0SJfgsDD4fvQ+kolegYYIn5u?=
 =?us-ascii?Q?+zgvX62XRypDsBNBY0cF0mZs++zlNWMpvBukeX5sL1cAL4S+Hg8njirsItgE?=
 =?us-ascii?Q?fzgeYEKfEdUOcbLwfE+foiR8Y72FC5IGJ+yPqKiB6tEFSVX1J5fjsB5Vp+cW?=
 =?us-ascii?Q?ILjMAXOQzEZITGD+tNp6DgCNEvor1zh+npeMYNH2gdA4e6BPwDICXmzobGU3?=
 =?us-ascii?Q?HDQKfr5INblcelQxWjOF0Ct0GCppwAvlWveBERX+s7TV/VsI84v/BGU5iD9G?=
 =?us-ascii?Q?AhhPaS7vt4cUzmhRFDUYg64KI7YcXF6EFvViOFOUF+lFhX1XFRMD2ACjRUP6?=
 =?us-ascii?Q?K1t22JHW/icVhyq2gL2Gg47DADyC3oiZnVF8E/GLa9yCz27y2qLOy8kZ8UwH?=
 =?us-ascii?Q?r4ReCfCBmY8KCNEL5ImRss4jybZJ/nFza9QScq5uo3NRTunAW9cD+GHfyWcA?=
 =?us-ascii?Q?fT+NPHUqxNIbG8jRfb+X0MVlT/fFc8oFS42I6mNbuxQ4K+mQ5jaKMbfyh8Ha?=
 =?us-ascii?Q?3bAGXtVKYaX9tHTR1anffDsFD3vnO0x/GiVC9HbbeayOjxoB4uGAfKSvXS3h?=
 =?us-ascii?Q?Cn+pYWbrb/wNvnQYAs124VnU+WpiS6OeL7t7PAPjV7sVxxiAm/T+p2T/oUoo?=
 =?us-ascii?Q?qMJAXeN2pjfhFC44XCLsUk+0GXjHWN7nebI++pEqjbqQbl0KY2TzZc5/Ij6S?=
 =?us-ascii?Q?sNvNJWPXKyoOsimhpnkqeOvAxKql2L+5yf3o0soY6gET0eWkswUBWR3n+fR9?=
 =?us-ascii?Q?krSkJ/YPthCoG8BkX60zD65AGWMmgBtTKnwNnKB6cMDKWvNIYTL4kh0Rrwp1?=
 =?us-ascii?Q?19zR3UY//TOWlZZcaH6lpRLFgP+bXNDVYTAxt6XxynjAkUvFUbbnhPqfmIfq?=
 =?us-ascii?Q?ygg05wzB9dRP0WAwC1qPHtfFn3K2jTA+uJVTU8Amg2q5yKccKko8wjVIlyoG?=
 =?us-ascii?Q?uON4WiXny0HgcKJ7V8U+3WqSqhd1QoZ9tGoIRZfhKQTpPSfC3ky94PiUZtg1?=
 =?us-ascii?Q?Pmqw2OdLo1H1kh99S//wmGdfUZQ6OKGYLwCgV1k/7Xhxd9+/nbrydmM9X7nG?=
 =?us-ascii?Q?L63wS4huXSC0iLvg5+eOpmfsxamEG1rq0bkUEOU5r+u7RHRG3sc4QcO0Q7/v?=
 =?us-ascii?Q?PXNnHtOyLO/9N8nfbyQRh3fHXmHoz74vGijA2wf1MUcIn9/Ym5EQYLiPjftp?=
 =?us-ascii?Q?5jMmEfWywXYCuLSiYrqVUREaq6e2kiQMJowc+i74K1ur1stTAZ20A27kf8MW?=
 =?us-ascii?Q?FJlaGIw3idh/jp7kO51oMk68KAsCaEVB60w46iUttYrQ+wYaFSs3mkgKWRIO?=
 =?us-ascii?Q?VBus7rvnRB4ouRvYkal1wenMzgvj4BAZ5/O8Ms/VLvNrYNbgxvvUX2PA51mu?=
 =?us-ascii?Q?Qe/E4XMjpPP3qIrk15brwp8yKhl7kM+SD84XGnXGT6Xo0+kDz/TyPsHslQhP?=
 =?us-ascii?Q?yCG7hTR79Wfu0cpnjBFku4OfTxGZvCE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa202ea-020d-4d80-4864-08ded8fa3499
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:07.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwrJ52f2+L+dXll0vxKemzUnD/9Wwm4WXHaMl7Ybrv3wE50b3Y6k1KsICXFl9+Ghy0CJmYxj6LPSe5XkWLje4fDocry1HUd0r3gVxs6HcYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/watchdog/renesas_wwdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wwdt.c b/drivers/watchdog/renesas_wwdt.c
index 92e639a91bb..60f2ac466bf 100644
--- a/drivers/watchdog/renesas_wwdt.c
+++ b/drivers/watchdog/renesas_wwdt.c
@@ -13,9 +13,6 @@
 #include <syscon.h>
 #include <wdt.h>
 
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define RSIP_CTL_CFG4		0xc0
 #define RSIP_CTL_CFG4_OPWDEN	BIT(3)
 #define RSIP_CTL_CFG4_OPWDVAC	BIT(5)
-- 
2.53.0

