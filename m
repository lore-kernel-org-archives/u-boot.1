Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC5C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F189A83CD3;
	Sat,  9 Aug 2025 03:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="08blyFzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C0E847E1; Sat,  9 Aug 2025 03:06:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E77847E7
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8NorCvh2GM/PfDxkg6DuldGRSBIEWjpHFzJhX0qsQE9kDcN1v7uU24u4WKku9WiEO/s80KlkTLlFFc4U8CovaTr+EXbMPAakwA+001ka3RgQjMwKHLx3wRVokHaakxNVPspKbqlvGWy6auulGm29aFSa21vbyD3wOegjIVtNZ/VpIdPu//8bBsPUJ69is76x8akwWaxePEmkc9c+AqCzAod3Fjq0C/y+J0oeYXhHwJKYcLe9RJRn8TspRMBLK4Ebc/CswmF28PjDrU0MychnLd8cRRZ6P6xVd5foDhhKe5kZynKBhh0q8ZWeAK3Y8InbSBR8ifJTnJ5rTZArDOmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUAInFk5Lr60h5oRq7VeaB5dHNJ2GyzQoKgLwAAL/Ws=;
 b=Ssj8eNlDU51I2wviDr/61NJgx/VbLbfTjnA86a4QHFPAkV/MEHTe4zM/fAi1xLyHTkG4ddlEPFirAxKdl/umOKdcHTkk2KRy4JcgtGc9FgwEenmS4eUDciOgL3DuPfkPD+PA93gs8Pp849ngluTBoHZJiuDB/PMqdnp2ZtcLyePtu/VmOsIWak2kV1YF9RafNeTNBMRN5XJSKD+o/ewFIBN8pe/K8Xa5VMXA7zM6CiuhtiyQBWgg3k3vOHijETNfAMQ+2OcvDksKtMMMcifjPMBo/2izOf+yObhbkWsneZ6JPEndP7sn/9OtEJ6EOCWfElIB7kaJrURu9g6MZR2t7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUAInFk5Lr60h5oRq7VeaB5dHNJ2GyzQoKgLwAAL/Ws=;
 b=08blyFzUf64mwMtco7i/aCSiGLQvEgnKA2qdIZAwUpTmvllLURoDCl7yh5pzH5j+OVggRDGaRnA0l5aS2330JE04NHkKirwA0UciGcmJUAYpYk/qdSFTKf8urHoRdiABDtNQBGDQ8AY3kKgCx47OlSehJCT3fcnNu71kaNFAj3vc/seG0vBz/2/WDPo4lcYRFzslu6LVgWKa8F80JffXuT/TWfzBmdGhboQHtzC4oqeHo30ucwcCcuNfkm0RiHL9NQ79ckm3yeE/p2R9iieeF1kyR3p1Fakb/8E8kJ1FhKW6a3jTXnFdvjK54qeCqwzgbq3ZTAmnn2MXzG/q+iHqpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 15/24] mtd: spinand: add support of continuous reading mode
Date: Sat,  9 Aug 2025 04:04:47 +0300
Message-ID: <20250809010457.3125925-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: b510a225-53f9-426b-d07f-08ddd6e0d1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?plL6u627/mnEHegwxeq0fxCxUJIUzIz8O3RpraDpYYjEFjqjRCCW9jpN/jE2?=
 =?us-ascii?Q?KpTIaKF9llHRD1+5vuhqGTDQ6Wv1UJCtIQYObO3xVeQRPm8/ne0gJcg6Rf22?=
 =?us-ascii?Q?g4ep/vJhsEvObH99U2X01LGRYpSypjpIRqWgju/IoC9q7ZOOfj+Nx2fXAtOV?=
 =?us-ascii?Q?cPeUD8ry1J20hDY2t7eyWXVmc4XbblyUxj1lFzP84rcQqfhBt5+7widtSjbW?=
 =?us-ascii?Q?DePAxdWRJ+cFKS6b5Gak55nzxOfc+KgySQKieOz4eyea94TO2uHS3JqLFQ7C?=
 =?us-ascii?Q?e26ZtkaL12resX0c8BBkZ5Or3ssJyYJVuK4QcJPeYZ/BynnDIX08Wnvk0tJG?=
 =?us-ascii?Q?UQmKQDmFnYBpUUgFwPM/jbwBemxlsXXmtjBQ71d2SczQZyWrXU5GUIuZI0FW?=
 =?us-ascii?Q?bhPUJ2r8JzIsWPXZULTn4wdlNhH1nxHA66wYGQaxXaAR23jkJSx9A1l567HG?=
 =?us-ascii?Q?y3lZXJWdWKyEOm3DXHc3E5RL/n2kDH3dfkxsXoMeYCHa06FHjUngnPcVS2Hy?=
 =?us-ascii?Q?NH9cOGvWyIZdNxflz3KBHepYJ3583ZCiu3XUUocb2VY2PMgFJzy844n+eSY4?=
 =?us-ascii?Q?nx7/cLiRHNtA1UXbnBZz+zNYrLD4sQj5+4tdlWuq0tRgtO7mQzdJeeO8u608?=
 =?us-ascii?Q?kaONB2dVDY3fw8r7rYCs7uYXetQ3U3QcrSYl+ZOIiipmIpi061Ks21TprOGJ?=
 =?us-ascii?Q?sOjtrSRk4M25mgjeDAwrb0pptWQUxPB5icuGD6PzVcMg7VPbIbq8cq5tGStI?=
 =?us-ascii?Q?G62Z8c3hKTis9ng9vE129n6QtvlHcbwtNifT4NDI9hz0WDhMoOXWSomESWTV?=
 =?us-ascii?Q?wYqlGUhhxk+UwLf5LgEVEDtTVJ9O6qZR+CyDntlY8tY4kf7oe327XDGk9w2v?=
 =?us-ascii?Q?zqzpEroKwrUBu1bt9LzesE2Il+6s47RuEQlPbSuXTJLjkuIV59adL30GfcPi?=
 =?us-ascii?Q?GDUrr++v84V+Xx7iN7NsA+rSVS+hWfcn4yNYrYPioxF2DOLWzWI3Osl1cjLR?=
 =?us-ascii?Q?M3mV0WxtNrHDjGoLMzb6j4EBEyy4BRnbGX1/Ezo+is6TOpJ4IpxSGLB1lHs/?=
 =?us-ascii?Q?+Q+eMSGip2nQzKnT4YEKbGX19vUsqnt8Ojjh6MA8CqsZh2+ohad9EqU9sIWb?=
 =?us-ascii?Q?EQbrcZZnPnRe/HE+Nu9R8T5dn1iIuIC6zWhmNQuUXSvhRAPzNIp4+N9kiaVm?=
 =?us-ascii?Q?5ZQNKnbBEd7GpybQg8fb+IK6dpAA0OpeIZfbxf5Zk14tJ08KptwFuhaneuos?=
 =?us-ascii?Q?qX8uCgGjLzFHwPUAj9d68yYkXIsPgxzHbUzhiNrOdULeMO+88NbVVhFtgNI2?=
 =?us-ascii?Q?1VEVur0yJ3oq0s4dCLaUeQqINfhKmAhEAs4pJTus/VpDwRySxnBe1Pc+UrEb?=
 =?us-ascii?Q?+zDyY5vCnQUv13D7wk75CAfoIHYU3Y6Pg4AdkHAW6v15RrnPVhUmkAyv6+l5?=
 =?us-ascii?Q?VO1aYjcSl2+Z589D9os+5H5f9sXBVyfeYwi5Zo32qT3uiJ2MSGsJMknHDwlr?=
 =?us-ascii?Q?APJnqGP33wBCVyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAelESjtwMjDOlfO07FuApsQPN9jDm+QTblWPVxVV7YXx13HMqPNl6aCmRie?=
 =?us-ascii?Q?3/DuYG2DyMJowXOvJ8kC74u5RIz4PZzQGqBOzi21Pn66G90R+am2w2pqqsKt?=
 =?us-ascii?Q?IBxX+rGTNVcUMbiemHv1HxfXvhhoF03a0M9wLyGgZ2lMg/TLWVLj8MyHkZ3N?=
 =?us-ascii?Q?/IPqLfnb7Ls/j6pDFeRBjBZYfuBbylascNckmy+nMCzi1Wf9CZHq33euJWAa?=
 =?us-ascii?Q?cFEVB4XGk7aGrfapIWS/TG13GdzISRahA5pTVOyStGWmji9NiG2zaTq4a3MA?=
 =?us-ascii?Q?S6MxJcafrCeMI5OOhrIF9MQmepHNDXk4iTg+5UeQnWG+3Qjl7DKz3clcfYIp?=
 =?us-ascii?Q?89qLfu7tuIL/bUZBBtou5xMJFp6SyugVvO6A6JBQJOcUsMgQc4ZeJGtKyqP/?=
 =?us-ascii?Q?/iutV4nbPmjtER5mZFvsHAd/PNecv/5QxrdIaYnpXWEzESMBgpWWVUfXUkDO?=
 =?us-ascii?Q?v6qU91EBHtnsxc70tQd+0gD8MN3Zi40tzMZZ+FaaPLIdiTWY5GSbh0P6fIfw?=
 =?us-ascii?Q?KQ4k+4viTEfmqruMLmP1sO5+x1EYKr30S68Q52FwNUSGYIaj+LkNNJqn+8Cg?=
 =?us-ascii?Q?99aqb87hcQNS9NQ6q67KI2aL7Lb6/ROp+Vdh08Cf9U0jWCHusBEy5M+dlIAa?=
 =?us-ascii?Q?4An9uZ9S5Okkx7Trr3hyz5v59wscIgNMltrA5qiIRzebeLWdrIklSAmE1QRw?=
 =?us-ascii?Q?8sGywTusmaHML3ajSNaBWUse8B2b8lKmcZztFKh+mRTFirdbSRyi1aMwV8vn?=
 =?us-ascii?Q?Xpl7jSmIvfZm1ykjXDIzAweyy5k1KflRkQdItKA3gdzWi8usl46EQzThtwDP?=
 =?us-ascii?Q?qnj1VAGjIgE2pIfiYntU2JWFFV6FO+H210joTcf0jW5rZFqn//vCRQ5sK3Pz?=
 =?us-ascii?Q?tblzvPDSqb3oXDRNSchR9zdRZ5IaTTYSWwWZiLtvkNx8NlK109MIYQ6hI1Cp?=
 =?us-ascii?Q?wCq0hJR2tQA60bSqiqeQea02+81NwTwK0zgu1+Gq4HMwbjxBpam4/GRbSlMu?=
 =?us-ascii?Q?XpBw+lgnaV+7qp8pn0tyF+zdV0WT1BmOrQr3kDp1YZgFs5uz3qqIQO2RKp64?=
 =?us-ascii?Q?XLqS49OAtBaV3obuRkb4aipREFIt75Np75r+IcPuaeSP9+1Dpd1oJ4pT8ps8?=
 =?us-ascii?Q?5iG2Ubx2atkUgkLxs1KKWlxHDfjXlWmAw9XbSQJhpqewTyFiIDCMtsSpuwYC?=
 =?us-ascii?Q?zPuurPgDG1fySNzh2yDZJ2U2SGWzqB6vGO2cRNidh67oLuR+GVwLXFJC4bb9?=
 =?us-ascii?Q?j7N7+akhRLDPcnRtTNYj8jVHXIhJAQ+0x9m4snEMuwo3ztRXmAzV6xHtWUqU?=
 =?us-ascii?Q?IzXmWK5u1QZEWfsAZYVpKaHqM3QSrUiDxl0AqMIRuy/rbEZms2Gbl5axrdJN?=
 =?us-ascii?Q?eDtVapBUK9QU4UwEq9K2az4fjm5Ai/6CrqUwgQMik9ba2SyWKr9B53Han/w7?=
 =?us-ascii?Q?gKOPtQ1mbWiiGo0AmogCtRNDU4PqSwrr+Axig8b1d+jdbyVV12JoWl7YdCjn?=
 =?us-ascii?Q?VzO0YuqN+NsKgobGE8uUvkXW/ut6QRhQtsA11K8XbqilEBMiTvWOFzYa5s4p?=
 =?us-ascii?Q?FX+ZHAAyokTVtV2hecroeqAeU3blxy7qZ4d/qGKhxHOY5PXYG4Tv9dCSnVh7?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b510a225-53f9-426b-d07f-08ddd6e0d1e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:24.0318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9f1VYB0rX6pmnLSyG+Nr2kMXitmwLM2A2QnlX0elU4wXr6P4d2jiz6wt+odOM56CTzvquFUahRUasAWIyVBVtjbdYTyYg8T/IBt6UQoWYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

The code was ported from linux-6.12. The original continuous reading
support was implemented by Miquel Raynal <miquel.raynal@bootlin.com>
in linux commit 631cfdd0520d19b7f4fc13b834fd9c8b46c6dbac
(mtd: spi-nand: Add continuous read support).

Here is an original patch description:
--------------------------------------
A regular page read consist in:
- Asking one page of content from the NAND array to be loaded in the
  chip's SRAM,
- Waiting for the operation to be done,
- Retrieving the data (I/O phase) from the chip's SRAM.

When reading several sequential pages, the above operation is repeated
over and over. There is however a way to optimize these accesses, by
enabling continuous reads. The feature requires the NAND chip to have a
second internal SRAM area plus a bit of additional internal logic to
trigger another internal transfer between the NAND array and the second
SRAM area while the I/O phase is ongoing. Once the first I/O phase is
done, the host can continue reading more data, continuously, as the chip
will automatically switch to the second SRAM content (which has already
been loaded) and in turns trigger the next load into the first SRAM area
again.

From an instruction perspective, the command op-codes are different, but
the same cycles are required. The only difference is that after a
continuous read (which is stopped by a CS deassert), the host must
observe a delay of tRST. However, because there is no guarantee in Linux
regarding the actual state of the CS pin after a transfer (in order to
speed-up the next transfer if targeting the same device), it was
necessary to manually end the continuous read with a configuration
register write operation.

Continuous reads have two main drawbacks:
* They only work on full pages (column address ignored)
* Only the main data area is pulled, out-of-band bytes are not
  accessible. Said otherwise, the feature can only be useful with on-die
  ECC engines.

Performance wise, measures have been performed on a Zynq platform using
Macronix SPI-NAND controller with a Macronix chip (based on the
flash_speed tool modified for testing sequential reads):
- 1-1-1 mode: performances improved from +3% (2-pages) up to +10% after
              a dozen pages.
- 1-1-4 mode: performances improved from +15% (2-pages) up to +40% after
              a dozen pages.

This series is based on a previous work from Macronix engineer Jaime
Liao.
--------------------------------------

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 210 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h    |  90 ++++++++++++++--
 include/linux/mtd/spinand.h |  19 +++-
 3 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a8fb3177f8a..a52cc91dd3c 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,13 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+
+static int spinand_cont_read_enable(struct spinand_device *spinand,
+				    bool enable)
+{
+	return spinand->set_cont_read(spinand, enable);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -323,10 +330,22 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 
 	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
-	if (ret == -EBADMSG)
+	if (ret == -EBADMSG) {
 		mtd->ecc_stats.failed++;
-	else if (ret > 0)
-		mtd->ecc_stats.corrected += ret;
+	} else if (ret > 0) {
+		unsigned int pages;
+
+		/*
+		 * Continuous reads don't allow us to get the detail,
+		 * so we may exagerate the actual number of corrected bitflips.
+		 */
+		if (!req->continuous)
+			pages = 1;
+		else
+			pages = req->datalen / nanddev_page_size(nand);
+
+		mtd->ecc_stats.corrected += ret * pages;
+	}
 
 	return ret;
 }
@@ -368,7 +387,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (req->datalen) {
 		buf = spinand->databuf;
-		nbytes = nanddev_page_size(nand);
+		if (!req->continuous)
+			nbytes = nanddev_page_size(nand);
+		else
+			nbytes = round_up(req->dataoffs + req->datalen,
+					  nanddev_page_size(nand));
 		column = 0;
 	}
 
@@ -399,6 +422,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		/*
+		 * Dirmap accesses are allowed to toggle the CS.
+		 * Toggling the CS during a continuous read is forbidden.
+		 */
+		if (nbytes && req->continuous)
+			return -EIO;
 	}
 
 	if (req->datalen)
@@ -639,24 +669,20 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
-			    struct mtd_oob_ops *ops)
+static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
+					 struct mtd_oob_ops *ops,
+					 unsigned int *max_bitflips)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
-	int ret = 0;
+	int ret;
 
-	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
-#ifndef __UBOOT__
-	mutex_lock(&spinand->lock);
-#endif
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -673,18 +699,152 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret == -EBADMSG)
 			ecc_failed = true;
 		else
-			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ecc_failed && !ret)
+		ret = -EBADMSG;
+
+	return ret;
+}
+
+static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
+					    struct mtd_oob_ops *ops,
+					    unsigned int *max_bitflips)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct nand_io_iter iter;
+	u8 status;
+	int ret;
+
+	ret = spinand_cont_read_enable(spinand, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The cache is divided into two halves. While one half of the cache has
+	 * the requested data, the other half is loaded with the next chunk of data.
+	 * Therefore, the host can read out the data continuously from page to page.
+	 * Each data read must be a multiple of 4-bytes and full pages should be read;
+	 * otherwise, the data output might get out of sequence from one read command
+	 * to another.
+	 */
+	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
+		schedule();
+		ret = spinand_select_target(spinand, iter.req.pos.target);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_ondie_ecc_prepare_io_req(nand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_load_page_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US, NULL);
+		if (ret < 0)
+			goto end_cont_read;
+
+		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ops->retlen += iter.req.datalen;
+
+		ret = spinand_read_status(spinand, &status);
+		if (ret)
+			goto end_cont_read;
+
+		spinand_ondie_ecc_save_status(nand, status);
+
+		ret = spinand_ondie_ecc_finish_io_req(nand, &iter.req);
+		if (ret < 0)
+			goto end_cont_read;
+
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		ret = 0;
+	}
+
+end_cont_read:
+	/*
+	 * Once all the data has been read out, the host can either pull CS#
+	 * high and wait for tRST or manually clear the bit in the configuration
+	 * register to terminate the continuous read operation. We have no
+	 * guarantee the SPI controller drivers will effectively deassert the CS
+	 * when we expect them to, so take the register based approach.
+	 */
+	spinand_cont_read_enable(spinand, false);
+
+	return ret;
+}
+
+static void spinand_cont_read_init(struct spinand_device *spinand)
+{
+	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
+	if (spinand->set_cont_read) {
+		spinand->cont_read_possible = true;
+	}
+}
+
+static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
+				  struct mtd_oob_ops *ops)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct nand_pos start_pos, end_pos;
+
+	if (!spinand->cont_read_possible)
+		return false;
+
+	/* OOBs won't be retrieved */
+	if (ops->ooblen || ops->oobbuf)
+		return false;
+
+	nanddev_offs_to_pos(nand, from, &start_pos);
+	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
+
+	/*
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so it is safer
+	 * and easier (can be improved) to only enable continuous reads when
+	 * reading within the same erase block.
+	 */
+	if (start_pos.target != end_pos.target ||
+	    start_pos.plane != end_pos.plane ||
+	    start_pos.eraseblock != end_pos.eraseblock)
+		return false;
+
+	return start_pos.page < end_pos.page;
+}
+
+static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops)
+{
+	unsigned int max_bitflips = 0;
+	int ret;
+
+#ifndef __UBOOT__
+	mutex_lock(&spinand->lock);
+#endif
+
+	if (spinand_use_cont_read(mtd, from, ops))
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
+	else
+		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
-	if (ecc_failed && !ret)
-		ret = -EBADMSG;
 
 	return ret ? ret : max_bitflips;
 }
@@ -821,6 +981,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
+
 	return ret;
 }
 
@@ -846,6 +1007,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 			   SPINAND_ERASE_INITIAL_DELAY_US,
 			   SPINAND_ERASE_POLL_DELAY_US,
 			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
@@ -902,6 +1064,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1131,6 +1296,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->set_cont_read = table[i].set_cont_read;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1256,9 +1422,8 @@ static int spinand_init(struct spinand_device *spinand)
 	 * may use this buffer for DMA access.
 	 * Memory allocated by devm_ does not guarantee DMA-safe alignment.
 	 */
-	spinand->databuf = kzalloc(nanddev_page_size(nand) +
-			       nanddev_per_page_oobsize(nand),
-			       GFP_KERNEL);
+	spinand->databuf = kzalloc(nanddev_eraseblock_size(nand),
+				   GFP_KERNEL);
 	if (!spinand->databuf) {
 		ret = -ENOMEM;
 		goto err_free_bufs;
@@ -1283,6 +1448,12 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_cleanup_nanddev;
 
+	/*
+	 * Continuous read can only be enabled with an on-die ECC engine, so the
+	 * ECC initialization must have happened previously.
+	 */
+	spinand_cont_read_init(spinand);
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1330,6 +1501,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	spinand_ondie_ecc_cleanup_ctx(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 910ef56ed0c..9285edd5c4b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -101,6 +101,8 @@ enum nand_page_io_req_type {
  * @ooblen: the number of OOB bytes to read from/write to this page
  * @oobbuf: buffer to store OOB data in or get OOB data from
  * @mode: one of the %MTD_OPS_XXX mode
+ * @continuous: no need to start over the operation at the end of each page, the
+ * NAND device will automatically prepare the next one
  *
  * This object is used to pass per-page I/O requests to NAND sub-layers. This
  * way all useful information are already formatted in a useful way and
@@ -123,6 +125,7 @@ struct nand_page_io_req {
 		void *in;
 	} oobbuf;
 	int mode;
+	bool continuous;
 };
 
 /**
@@ -638,19 +641,19 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
 }
 
 /**
- * nand_io_iter_init - Initialize a NAND I/O iterator
+ * nand_io_page_iter_init - Initialize a NAND I/O iterator
  * @nand: NAND device
  * @offs: absolute offset
  * @req: MTD request
  * @iter: NAND I/O iterator
  *
  * Initializes a NAND iterator based on the information passed by the MTD
- * layer.
+ * layer for page jumps.
  */
-static inline void nanddev_io_iter_init(struct nand_device *nand,
-					enum nand_page_io_req_type reqtype,
-					loff_t offs, struct mtd_oob_ops *req,
-					struct nand_io_iter *iter)
+static inline void nanddev_io_page_iter_init(struct nand_device *nand,
+					     enum nand_page_io_req_type reqtype,
+					     loff_t offs, struct mtd_oob_ops *req,
+					     struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
@@ -669,6 +672,43 @@ static inline void nanddev_io_iter_init(struct nand_device *nand,
 	iter->req.ooblen = min_t(unsigned int,
 				 iter->oobbytes_per_page - iter->req.ooboffs,
 				 iter->oobleft);
+	iter->req.continuous = false;
+}
+
+/**
+ * nand_io_block_iter_init - Initialize a NAND I/O iterator
+ * @nand: NAND device
+ * @offs: absolute offset
+ * @req: MTD request
+ * @iter: NAND I/O iterator
+ *
+ * Initializes a NAND iterator based on the information passed by the MTD
+ * layer for block jumps (no OOB)
+ *
+ * In practice only reads may leverage this iterator.
+ */
+static inline void nanddev_io_block_iter_init(struct nand_device *nand,
+					      enum nand_page_io_req_type reqtype,
+					      loff_t offs, struct mtd_oob_ops *req,
+					      struct nand_io_iter *iter)
+{
+	unsigned int offs_in_eb;
+
+	iter->req.type = reqtype;
+	iter->req.mode = req->mode;
+	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
+	iter->req.ooboffs = 0;
+	iter->oobbytes_per_page = 0;
+	iter->dataleft = req->len;
+	iter->oobleft = 0;
+	iter->req.databuf.in = req->datbuf;
+	offs_in_eb = (nand->memorg.pagesize * iter->req.pos.page) + iter->req.dataoffs;
+	iter->req.datalen = min_t(unsigned int,
+				  nanddev_eraseblock_size(nand) - offs_in_eb,
+				  iter->dataleft);
+	iter->req.oobbuf.in = NULL;
+	iter->req.ooblen = 0;
+	iter->req.continuous = true;
 }
 
 /**
@@ -694,6 +734,25 @@ static inline void nanddev_io_iter_next_page(struct nand_device *nand,
 				 iter->oobleft);
 }
 
+/**
+ * nand_io_iter_next_block - Move to the next block
+ * @nand: NAND device
+ * @iter: NAND I/O iterator
+ *
+ * Updates the @iter to point to the next block.
+ * No OOB handling available.
+ */
+static inline void nanddev_io_iter_next_block(struct nand_device *nand,
+					      struct nand_io_iter *iter)
+{
+	nanddev_pos_next_eraseblock(nand, &iter->req.pos);
+	iter->dataleft -= iter->req.datalen;
+	iter->req.databuf.in += iter->req.datalen;
+	iter->req.dataoffs = 0;
+	iter->req.datalen = min_t(unsigned int, nanddev_eraseblock_size(nand),
+				  iter->dataleft);
+}
+
 /**
  * nand_io_iter_end - Should end iteration or not
  * @nand: NAND device
@@ -722,13 +781,28 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  * @req: MTD I/O request
  * @iter: NAND I/O iterator
  *
- * Should be used for iterate over pages that are contained in an MTD request.
+ * Should be used for iterating over pages that are contained in an MTD request.
  */
 #define nanddev_io_for_each_page(nand, type, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
+	for (nanddev_io_page_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
+/**
+ * nand_io_for_each_block - Iterate over all NAND pages contained in an MTD I/O
+ *			    request, one block at a time
+ * @nand: NAND device
+ * @start: start address to read/write from
+ * @req: MTD I/O request
+ * @iter: NAND I/O iterator
+ *
+ * Should be used for iterating over blocks that are contained in an MTD request.
+ */
+#define nanddev_io_for_each_block(nand, type, start, req, iter)		\
+	for (nanddev_io_block_iter_init(nand, type, start, req, iter);	\
+	     !nanddev_io_iter_end(nand, iter);				\
+	     nanddev_io_iter_next_block(nand, iter))
+
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63626c9c27c..2f8212e4037 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -175,7 +175,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -336,6 +336,7 @@ struct spinand_ecc_info {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @set_cont_read: enable/disable continuous cached reads
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -354,6 +355,8 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +382,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONT_READ(__set_cont_read)				\
+	.set_cont_read = __set_cont_read,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +428,12 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @cont_read_possible: Field filled by the core once the whole system
+ *		configuration is known to tell whether continuous reads are
+ *		suitable to use or not in general with this chip/configuration.
+ *		A per-transfer check must of course be done to ensure it is
+ *		actually relevant to enable this feature.
+ * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
@@ -457,7 +469,12 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+
 	u8 last_wait_status;
+
+	bool cont_read_possible;
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 /**
-- 
2.47.2

