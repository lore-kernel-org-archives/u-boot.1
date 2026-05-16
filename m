Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE68CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04838848A2;
	Sat, 16 May 2026 03:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6eiXPo18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372DE848C0; Sat, 16 May 2026 03:01:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5165E848B8
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTW5SUfx2ngXlabGaVI146hPu/gIMeu53dOmSvKv+HSNrGOiul0emoxYsVprJrmTSVDk8KX+dJPX7w5tkKPzOYZs97gcf+38HSTJ+VgxCBrFEqqISyPBINQUhiVCjfGlL3ll8Xos/hJa6ej2K6+L0CN+Nqu3LGafHXwNk//DbiQOe9U+6jPajIqSNo44NRCtXYe4SFq7vGPumvjwGAXF8Z3Kt5h5WejuNEOMmqgmt0LyNJSvyzvA+ybgULD33mBqM16xrpvsGmiYYUdrlSsr9EIz7VG7T4gMHa5M4G+77+79kdsJL1WZzuwjc1Wgu3sqqh+Wjra3xrqq+hRWOJe37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=wyGJBbvM7097VGFx6E0n+eXXnYaqdgmAKxblwwsEjcDcBcKl9u6JV2/VbxtWvWVUeIIHn2uXeGKCuE9P8UwAaQv1wQunD0bwnh95628g19QMcc3LDAh69MNt/L+rkGsi2H/51e8KS8xkZRAyOIRGlMCH6r6SbazFZUp2qLVLKhrSYQc+ArKLsmzH+zBwIikqQJDzug2bTjHUURK7NJVNfOVP1Js0Uc8gmSgrnuYJCsT4/O++585ZUk7e9MpNqTUokI64vsySEkA8FG8TiHqXKWUGC8yc1N3qFIGCDl6xF6w2gu7uLEeliHYi2uS85kBuQoEsHoMzkCPvrrLGs0y5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=6eiXPo18nF6eHfnQ/bKteOnLoBVBuDdpw34HLKzZ9M9k7QtcOKu18cco4FxwQtq86XiP/k1itCY0eCm5T+wmg1sLfwJRR66adtUpjGKWpD9yBDlPKxLInkUou28O0V8nJQVB1yVFrQUW3Q0yaDKbubjGhi63TL6tsK/YhWNqtBPhkQ/EnND00DItXa/UYaDOH65+MIyjnjVxzjl3773vfuMQTsgt8V9KYUMbyMG1AmGN1ylfzzGKU432H3AwakM9MQ4H2NbXSOYoNuS7RSNYWjiayrKDyuQxk6UltdPYs20/5UN7QcqvzwLrDK1yFe7uTspCx5CE/aSrLgC/GdNzhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:01:13 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:01:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 11/12] configs: airoha: en7523: enable pinctrl/gpio support
Date: Sat, 16 May 2026 04:00:34 +0300
Message-ID: <20260516010036.1034352-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c6851a-be4b-48b7-2ad6-08deb2e69fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: /CXMnBO2VDs8P10hCDbK6p0qvqT1IqNxzR2ZCS1hHvIxKoFjIU2CVRvbq2R46l7KTBo/t5G/UALvPLu7GSMXMulCeQp+TR39MZHrPfI+AvxSIoZil5IJAybB/yJrWvOfl2Ej2coyLR9avNPi8Gc50qi7UZYnyYA1dVvxSC+4KJWm+BZxQ/l/rGAGv+D5cNKt/icjtQuLKmTvqGJ1kkaJKfVIlxb1psK95R2AEd0XiE+VHQ4QZDxngNdb3OL0Gp4q7ZiYxP5DFyWbZ0wBpaP69GQ/dEGjdBRZ6rGbj4IoCeMrNd2ngu/Ydr8U+Iqglc7MVgnw8TpHLPzUTQ4W4BM4lgMpkxaqyYBIetQIZbD1q1oa04h+QxIfbDaVEbVyAbaBzo9IlST+tw52WmUm/u+nKIJA9hgC9XPXjOdlm73WcE79yh7f8oSJIIIUDKUIjg5KThy5KFAqNKLenXIppI3QJMjONS34RTNc0hgbUem6uYCPLqwL/9vS5Kk50ssI1ez7aqrMemGBwN3X+mnKYft2nZ7MhLN3DK35dw9mU0QCu6EFlWw4r+DG4G8R/z5EUnNaQ3WM1yc9bpa6DxsRAoLQJtXNAhLW70DlKrCoqar1PG74DCdZCiv5EjEewGphIXgSCn098jQPhtxO4tmdfOXEaNJ3pMgufDRazWRlTpXlzrk2Jp7+2V6IK5ym5cTnaMtwL7IKKWwaUkR2IpKE589OLZhlI0g3hQDk+7eQ6nHsLCmZzK4R9fQAs4NRN0D05b/yE63UhM3AiS5xbYiy6Fv/0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TAf5G+Ak37FOhb0I4TlsCMYcLxVBu9mcH1L2uC7cz0JP6TRkiVdd+mkaCqmC?=
 =?us-ascii?Q?vSxhx4JAH0Js+KyRnE5/dkJlZ+SbRDfw9xOCZBiIYTqWhWSIyFUSb7i1XLUv?=
 =?us-ascii?Q?H8KV5iV97tTl1CZZUeSE4ok+N607cEGz8hrPQubPScwhKeOBso5i7k2lEh+C?=
 =?us-ascii?Q?sUtZQn1J6cpEtvxV8n8xeUY/gHZEjmrW6z2VzHVyUVO5B76um8EzL8QTM15m?=
 =?us-ascii?Q?8EExQ6hb76iBjmycxucgKwsKEsO35Yhr+fmSwwJdchVMgy2Osn1dT/UWsd8U?=
 =?us-ascii?Q?jWvuqVvRjdYlArEG+h5zl3KE4aOVqaaEr70yU8NhTJjaOYC+daYYx2DdZduu?=
 =?us-ascii?Q?ozCutDeuorJeV98CuR0KbvPgp3VhqmdRtBzyDeMi9AExyiGNaH9+I+K6cc+u?=
 =?us-ascii?Q?8IpkiNGh3DJDTf0PdQNrqRnbn1B+4YsgD1FVO4kH2mYjg7uGPB0wtRNA9kKC?=
 =?us-ascii?Q?OBrUIsLg40el5K48T3tfHnbX74NOqYKfyRctTfGiew/QVZjq8x8yEMXFqrlH?=
 =?us-ascii?Q?fUR/UJRMtSXOooGAtSa4ENfo00z2Jl0tUx0xCBrQAxWYXJMVRnAC+QO4PWkv?=
 =?us-ascii?Q?wwt7jF9W/lg5JMNwA8YQfuagFntUAorN77NFQxWcrwBwYTKVffE5iSJpFH46?=
 =?us-ascii?Q?cYf1DqUy6b9XdivuJmBbSD0KsFdevtsNq9Jft9j3pEPqyUe2V9hvAWTXz3gm?=
 =?us-ascii?Q?y7siI/HD7NmpKxcSsDS0WVvKETCAeFMkzuanKq4gbasjirSICv1dfZ1B8JFK?=
 =?us-ascii?Q?hXYHtmvEzzDHHhu6ZdX8NlJTwLYFxF6qyDEohn53YHrvX0BHKaFI44B0UPMO?=
 =?us-ascii?Q?Il1XiKes0eL5niLWELkCsIlsPZz3G9O9tGGyYTLhGEcUc7T73e9pSZnyTdW8?=
 =?us-ascii?Q?LNY5Yo4WTmHty44kD8DE8rXCP4ckyj6bcuBZXZOr/B53Wn5ZpVKp/SLmXKGA?=
 =?us-ascii?Q?n+kzOb/fEePS6HgnjgBEbVPs3SBlT2IobmmuP728UW0nMM28qfBwaozUomXv?=
 =?us-ascii?Q?w+kcz7i1+TzXoXpnrD0o2F5iopEy4wryk6hHjwUbPajrIj7iqS7+83kIAaP+?=
 =?us-ascii?Q?KGIkVKAH+DMy3KZtfsz0hNpgNBAAo6SSoIzLcu7dM9WrRAfWoXvTuDhSPcoS?=
 =?us-ascii?Q?UfQucD9Y9v3GecNTkxrbBrDQzUD4TR0nj5p07OQWCgrc132YyAo6r6ltR/LK?=
 =?us-ascii?Q?EoiMSShbaaX8tl91N61BMJKlRKiLFftjdNk1iQCq83oViTwtcnhfmxWrCsIO?=
 =?us-ascii?Q?kAaETL28tmAyQ4xo17kRQyazim1XGe1HrZd0hEzKPEnzvPWJ547dZxtA4MnO?=
 =?us-ascii?Q?+96RrVVj7QdxjdLp9j1q5nPQRLT/RioZ66CjGWeZA9j3BammrszeEYW2w9Gj?=
 =?us-ascii?Q?2VA6sL6l4h9PoICNop2JyrCwBVNrQiNZpmuK8WTjowhZpe4DUhgGZpoinyFy?=
 =?us-ascii?Q?LlNfTmvslxCsHxFV5ouAMXK05EAx293i9nuH3tfwEVkGVFUH89vomdnF7hEM?=
 =?us-ascii?Q?kaJZAl2zOGWauG7CdfhFPvRX4wtJK0ZL4EHsAwYqg9V4/b7SBcL8ZBTrkPkQ?=
 =?us-ascii?Q?6/lpu5Js8oP40LVluLu+wgoVdQ4LYh3Osi9JDO6CashCSgFODagHWzHxfdz2?=
 =?us-ascii?Q?cuygopzocRi9/wJd0M3+FpmYfmEyMAZCpEmsmpo9vzQvlqT8P13ro2dJy/LN?=
 =?us-ascii?Q?OGEUH6ZazGDEexki0+61wF9pVR0Ep/ipGeVdL0WRNbRdK6HurfhGRIZK/vlD?=
 =?us-ascii?Q?HutTZsjxuA+YMYWQzkGXpvgW78/PVTk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c6851a-be4b-48b7-2ad6-08deb2e69fb1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:01:12.6424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrNykme3pNvBfZowFFtcr5iQbSPOfC6c7vN+wPWQ+ighgLcp+LEKR4ua9O0sKRUPs5IUREU/lBMtORCLgXzXOUaUPqEJnyrXwYRxNt1WBvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/en7523_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index d3137a0ae44..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -54,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

