Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE6EE6BF10
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76C384584;
	Fri, 30 Jan 2026 23:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="e2GEgFOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECCD38459E; Fri, 30 Jan 2026 23:07:03 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A619184564
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEXxmst3J3sq3yY1Oz2UmiwXWiABTJEkNXTqprHlLbY85aH/e0OjfwOoeNPRZGnu76grxCXxUf8DdT4po3naCC5LkrvVqK7bz3+u+D0FBVVO2qmcv2i7sp1d3kGYGSdrnbYPi/jgTzurgLchfnA5I95rW4fiatPEQQ8qraOlKBWMfa9dPzGhBrjraytdzM7X1xS0YGxNKxZ915O0WTXTdl+rhFyNfmPC7QEL3jbj1AQ5J5E1Q3vXx1CuCIzlpH35hE+n+AQsGhom5tNhBUyzrULri5cDFyWjhPzJB1uQhVzUdEELAYC3nYIiykiNEVwDJGsD9JTZW6mkzOqdwFlvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQsfoy0to3PFGahJ8bZHy/J6p79g08mcpys/ih1EPP4=;
 b=Kz3gBOUUE46zMWaj/7f5s6ziGKDcFTRUSESibcTZv7orGT0jYsxDVEAiMSRdhZF9N6B+r+6P3sfPG9RAfZ2k8AKNBgDaWm/DeFwSHtGh103C/asXjUyDcPCPQPSOyI84RLpHiMV6xTGiQMgzKfAP2ddMvmzLyh+PQPFPMrq7ekCKS/k+/F8lsIaUWrL/xN1Ov2d/q6TEs7pDh18cw13jNSIsiXCHuMx3kGeyo6UFvSVz8duRYdSvX9VlDd27y4zufTqgdKbFWvKs+M6efpIElT1vI8Wd57gPU1CPF2f6ZNLKQak4rwTo08ZbdFaTDR2/l3u6s0vNHgm4Lc1kVaJmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQsfoy0to3PFGahJ8bZHy/J6p79g08mcpys/ih1EPP4=;
 b=e2GEgFOfR3JL+BDAXJ8NW0Ohe63dbZm0m/oZiO4Z3Rm4+0LEcDmDczYNQb+QDSsfeNJmpeJl8JmQoM/qXmH5tegctFjK7MY4b/ctzEUUazBw0GmDF1n24DGlH/JMoLf9B7VM05Z8HDrd7incKLE8q/TcGWh0tpAaBY/wFxhqgOObPnhmwCU/9eNMN3bb66uBaXMteDSB5hRtnfmqyBHoV4aeLz8cVLP1mgtNvbfI2rYGVrHHNQZHwsnHELed3gHdbAw2iM9CntxaleBz4pk24Lva0fLN9KBq20lNq4YVZCdlkYFO+tNXlUDtAYkNqJcB/T1sOTUbJE74g8J9HqyMzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:55 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 5/7] arm: dts: an7581: add mdio child node to switch node
Date: Sat, 31 Jan 2026 01:06:27 +0300
Message-ID: <20260130220629.4040550-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5248e1-00d4-4ea5-7cc2-08de604be127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eumdTradrRM5086kqXsdqVKxwDwXOR0HjHBwpUFTWDSfdWGks58KkedWxmsi?=
 =?us-ascii?Q?uJU2/ZhLE8AAoUV2vtcaUe9Qnk8Q5W7aKDpxA/V1vtvR58qU70RUt8CFEKSC?=
 =?us-ascii?Q?aJHlKMtkZr1U6H44AXNa4K11H0r+71DJWmZ0DO74hqlICcKRT7+Dy7WgMXDG?=
 =?us-ascii?Q?h0Tm9DVQtAC9BrP+4Tr0qRJbLn1r7aOUk/rqyCwT2+9I72SPKu+yHquSdAoo?=
 =?us-ascii?Q?mlhgxV3KrUgMDaTdAqS/xb0LkanUFK0SeeRGGyBZdNbSaOzS5l7PQ5lWBwJ4?=
 =?us-ascii?Q?S6H5Cdef+L1K8WXQFlitpKMFZgtOpSr9v3CC36zrQ1fyQRJcgbQQcKD49R+I?=
 =?us-ascii?Q?0i4KlAzyDPCVPWQdGUp+lcWNsXJhLOGcQtUgsX4x6mpy7ITHMNSukzCJGxuO?=
 =?us-ascii?Q?D36taYI2W1/UpcUyK6NCaRxLhFLOUrMHrfvzEtmkBI8i5NpIKhvG7jOQtB7J?=
 =?us-ascii?Q?9CCPYP5q+QFHHXAiAKHmtbOln3mTRj1Ig+XOBjBV3SA7afRLdqe1h/0slFQu?=
 =?us-ascii?Q?9meFEg6YsOMduBzqsBLohKfpQk6ZMiXCJOj7+5EwtB9sseeo9B19uJluMNGO?=
 =?us-ascii?Q?kIJYIABL2/4VcMTzhj9hRIcBNtdXpEVVy5FyWpf/aHyDekWm5CE+Zc67/Sf3?=
 =?us-ascii?Q?cJEw1X/rp1e2BfudeuQV7PgW+4wYkL1ul6N4hqhF4X4pQJii4+0KGAe7TciH?=
 =?us-ascii?Q?Uv1E3aAPtX6KerqKYNK11yapixZdB3o0Nn6+Clp3Or0rXxC25ZJkKnqnfjUh?=
 =?us-ascii?Q?PKnHu6jf12JuF6deDTtaAkhlq4lraZONzN3l46HEsAllAaBdIjGJnb8ym7BU?=
 =?us-ascii?Q?AobCg23Al0VPa84o/uDxNTob2GCOQ2QYmUqiZvdff/634xfV5FykMzxIw743?=
 =?us-ascii?Q?teA71qf/LJUpf8VnLHLVkJeXg6416eY3LcLFEt2QkUb7Sym8U5ZzZ4sqxFCs?=
 =?us-ascii?Q?4ccS8Pyc0fyPNv+ElXEN3fh0SwZQJzxxJXuV+uCK7UcDy21+fTMuhzF5ibX/?=
 =?us-ascii?Q?lJnMaEHLTG56DxmYuztCzh5ZBMuI60PLOzwn/bfiFe2vu6biB6Gwv+wvSgI2?=
 =?us-ascii?Q?s/4scSKVjDKI2urKtgMRFbiXQ62vqZBqI+gMPz9xmn7N9AbYTIN4AbbDz4t5?=
 =?us-ascii?Q?QOhw4X0R17El33dNqueEkiJXATR8ZpAivm1OK8McL1d/KixKsw96Szmtnor7?=
 =?us-ascii?Q?gOIi7OAqJOfUj2SqaS1dd3GUuljxK4Dw1Bgnr/9PNMVdtEYE6NGjzEmNmgFK?=
 =?us-ascii?Q?oDO5zW42UxU5/3fBkROHWwH2LA9sKRDq/vkWlS97CnR/Idma9o9Se+lIIxQk?=
 =?us-ascii?Q?ePirEs/jXFSdnJAsFM3aT1oyTNbWiFoGB3vpKauXhGTzdWavrt2xrtYpOno+?=
 =?us-ascii?Q?TD8wxCWjO1IOaiFBdex765oEpxvsGEMS+BrkXQHn/zdOXbx6YnXw8QRKnNPH?=
 =?us-ascii?Q?6mJqtzhO2IXclonbZK7K7f3nGxRDme/UH4B38CRzOO9AEPI6CxdZTD0Arwj9?=
 =?us-ascii?Q?dtQvlqCG8VSwfRZsn2sSaxk2YM6pBIOObvSaEMUiK+RnrLyMtHFQBSwKL+HK?=
 =?us-ascii?Q?9NBryVVkT0uk17opSeoBbXca96Q934B/jRpvfQ3FNg5dbJSrePySaUst4e+J?=
 =?us-ascii?Q?aiDCqsTNvrwrjOO+ViV4nBS5xA7L/YLsqEdl4UixWvE3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uo/j2s4vTKI9edoSeFP009y8+cW+VcIkhtaBCtsX1Nvgl+zcRUO5Rnx9qPhc?=
 =?us-ascii?Q?Y+QmU4ij3sMbt5FFIN831I0tHWOPXzoSClfaXz7uqhMJS4GGZmoiyaBlBT1T?=
 =?us-ascii?Q?90wvo3SqKJ23B6ZZDPgASVcfinHD1ukxSrkIHgxWRUljDsNPnodQ5/hfYNtj?=
 =?us-ascii?Q?VWN2vx4DbB2lwopPpZCqu0s4idvRcvwBRhTRbTyPBbzUH0vVrNs0VpsicK8r?=
 =?us-ascii?Q?1wrlhHJ7mw1jRp5t/VFhxBi6vs2rrJl8X6Zv2x6NSjNRII8bXNdmywnept34?=
 =?us-ascii?Q?LKRGIY3KLFqTy/nHlrtlLHUE41mLRudAKUOZAY4EBwhqVhioVI3oo/J5YQlq?=
 =?us-ascii?Q?xEw9jLa1IoViasO45G+DhWwfZGmvgSKJ5MNrxG0DFmAw+h8FoAXBo+rJkM3l?=
 =?us-ascii?Q?GBkzWF/hCueppGI4hCY20wfYhGnaBjOr4PtMX8GlRCUsSa+DhBuonb381IAP?=
 =?us-ascii?Q?/HwvX5MGk3TSKeW86zMSOMIJ2AZmQIl2xPk102e67vljMaBSaTgOTGomoqbo?=
 =?us-ascii?Q?9Jqhuvi4gnwmXugEokAAROWs0PmTue+NmLEG8AzhhFw0DHgzD4oFh+If6f2Y?=
 =?us-ascii?Q?5mh/QwfqL+55Nzup9uwUrVn8hT/Bwe+i84ge1cq1JICCW1FNXEDAwuSu5Nl7?=
 =?us-ascii?Q?Y6mxEgW37FnMTTHPPRBS+n9UTC7l0ICQdSw0sgYeU73Tk2mUuaL28ijV68vj?=
 =?us-ascii?Q?sQcF1mxK7Rzj0thvPJGRJVekNrwzYFittt1KBYqLHHgGYuIN1jKNSwCyGUhf?=
 =?us-ascii?Q?0xXvXD1bj6AHOYnah3UEy7BBJ8ILHgsLihiOmxGBaHS+n6oRd0iuvdh9ZkQb?=
 =?us-ascii?Q?P2CEBwjNRH7pDSMu2QKCCUi16PZA0IN+aqnRvF5sc0T6H/co/HKDk0xWPVc9?=
 =?us-ascii?Q?JeWY2f6olGLBgHPLKxrM6VuCgw8axzxHUYSO1ZH+YJj5a5lDqP4aowQx3Pcg?=
 =?us-ascii?Q?CdmP/TbOeiOmeQp8arfHk8Hotdh45+4Y813Lns4CJp7XPJYCJSCGsmaGxEJP?=
 =?us-ascii?Q?0YreV/BKoVKnnCwVH+/2j/sWNRze7KsKBJeIvEIi83+Le9xztUdx2eDXKnlz?=
 =?us-ascii?Q?NaRQWJT0Z4OG2qCo/T+y5l/m9cws3fCwtMwIIVD55qn7hZgmxsnGzbX0CIXs?=
 =?us-ascii?Q?8uBrw7lPH86r6M3Yl4ltcJhLtdGiDUiq/7VayIJrdHWAUkTt9IRreA17JN5L?=
 =?us-ascii?Q?ZpFY1rzr+vOcnQ8QG3sfhiScC39yGtN2ZbMQVAm5v7gLexwMZAFmI6hD+JJE?=
 =?us-ascii?Q?AIiybFmKyXbMPIrW0pcnLOOMRs0ZIVcRXj0f1Kc6TJMlFAdXDcvOblzBGwrj?=
 =?us-ascii?Q?ciTRMGrnoiifKwLTPNj8r8FXkSPOeq1RyH0G60vCd+udVPma7jhQU8oglROV?=
 =?us-ascii?Q?Ny5GwHzztWsZx58NJrixyM21CKpFrRWKChsdoFrEcB87sFbW5ufs4RyKwWF+?=
 =?us-ascii?Q?Etn3HlG01m0U93KBk7Hwry3iYWen2mD6HjzAuXZUD8xNSx9k/8OssMS9gSAu?=
 =?us-ascii?Q?ODqE0NxLPzY+i0KiJk2vG/I2NIuSwgVpoVljAYpXUq3umDysBk5Ofv3o79VZ?=
 =?us-ascii?Q?I7KDx2zBMfhxVejiu7fxlUiO09RlR28vPNnpwn0gLn+UQU3NChP18ZNgP6Zt?=
 =?us-ascii?Q?5zTMWFAdbaiLaZmF9WZcQniIG21uDRK22JHPMpDb2bCvbNGoP7gsRQNBWG2m?=
 =?us-ascii?Q?lxl0oX42ZMZmOHPeOPzJZyA9UjAyuO61/cKThnNPnOxdoagZroXILmkSuHq4?=
 =?us-ascii?Q?J95u+P4RjI1gXdT20sjadqRK1+DlhQE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5248e1-00d4-4ea5-7cc2-08de604be127
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:55.2519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iRsl6lmkqhyPkp+R7S/Bc2+Fr4VEFBQsLsiaYOxCweQMWDvPd+3PoeJrjytNn06zLoHBZvaXc8yNM/O/HK+RfmkaQt1QCICz8hcfejepkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

add mdio node to be able see switch port states

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7581-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index a9297ca6503..c5e24c76457 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -57,6 +57,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,en7581-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		snfi: spi@1fa10000 {
-- 
2.51.0

