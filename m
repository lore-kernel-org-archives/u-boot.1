Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77185C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9D482D4A;
	Fri, 20 Jun 2025 01:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="plj+/BoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E21382D4A; Fri, 20 Jun 2025 01:55:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B858182CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU0aGqNhVg271PNGCg9JbmsXjOY6mONsOjnXNcNlq34MosIV+Uie7AbIW3r8ElOsD3arbI/YhXEZM0kKKTZ6DERQJWRWwVSntUpGRR/lQj05u4FWQ0n5Iajifk+NeelKm4n7nazOiJfBL2k5Bze0GrWztlhTZP0RslWHwuYOWNFv1tVVEJEC+stWbJZ1/C4Kvxg2lHbHlXnbdCSgL9MWOHMmTtVJySEQgdXhZFW5DV7uXz98cQrovNnGEvdtKE7y8BecTuDthCK9piVNdS893kZlx7IFyX2SbbVwnLkOZi4gHzFWpfFa+iy7XIQD3LBN0xRZ3J40e658nA2n+eOZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPokPK9E3d8HrPecQXKMwW3XRoBFhkrd+9iSYAsLqVY=;
 b=Ku56RW0084UJz4+xWpdjwPTvd7R1qXIrsM7sf6qStjAojoUouhWV/eRUbbZKPBb5NepUSSCPpj22IXFdkC49sRBiTlAOPVswratiN4MGJeluKJ8XV8Josx8yKCaHyNAqalkrBalB5TbktMWG0BfM/NIYya8CCK2uYEArhQUBLpkyqrkwDWfla0gdJVrhhgHdGNxHaD3H7QssnOBwQ4qqf0hM4l5l8a0ojyp6X89djw6DQDe5hAlisj9AjXBnY7wnNIZ8R9IUBrw66sZfzLBvlPp9xG7snJBn9p7/Efi2pnwY4xhpig1k/pumyAlr2UN1wC3nax5IM5uHuTxVo+aaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPokPK9E3d8HrPecQXKMwW3XRoBFhkrd+9iSYAsLqVY=;
 b=plj+/BoK2CV0w/UJHwor2iFYYR8/BVNFb0E9aQVNG4sm1sOAws9iaE2IQ4vlo3OzKD04Z+8kQY2miCsoQMyKCx8LpMZjzt+dCZImgDMAW+af/ub+bomHk4QlSkOjFArdNuUTQLmPKG6p5DRnRSmAhyRF8GjoPiXPYHSwhOVHGTUaTQqXIQwiikW2DLacTi8OJj2eVrY1Hsb92NAyzhg54bRc2P5i+Y+JLnHNHswNGpX+D8cHdCKjhceBY+4Ru4LnCpbP88PChgVKFEVfayBc1Ur5JLpVlETSKjiKkvDoVprRSAJVveiueGM3WAnOU+rO5mgPy3veZdHSbpQzvMqGMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10560.eurprd08.prod.outlook.com (2603:10a6:800:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 23:54:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 23:54:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 0/3] drivers/spi/airoha_snfi_spi: dual/quad wires modes, dma
Date: Fri, 20 Jun 2025 02:54:45 +0300
Message-ID: <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: cc270094-ba06-414e-254f-08ddaf8cb136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e3/vvRvXFPARP8jINEf6LFfcdWQNTMYgZQzsYLowEQos6gIDkgOg9YoSMxF0?=
 =?us-ascii?Q?TWbEx1CZx0NMSUvy5ksDG9AiSdEPG4vnMctgCUkigSXCY5UnzmRse3EWE0ul?=
 =?us-ascii?Q?swbdrdLmeEnn+s7WOMAzHltvlcvu3bXUrv5M0WUnO7WO4DUlgCp6mfidSsRc?=
 =?us-ascii?Q?F8M3FbvVNswc/YhewD/SBrqhnjsU+3W2PFQd1nI8LFRNaPjxgPhfJHguE8FG?=
 =?us-ascii?Q?IzppRyeK5cwHIOKOAjaWxKeys/njlyEWN/XxzlnMWhxLkVZjIRcP6fi6owPI?=
 =?us-ascii?Q?3L/8inVyzmZDbhhRAtonjssvU5h1n7ciV/LUrqlGhBDAECrl+vUxM21VdDUT?=
 =?us-ascii?Q?0DR5oEyXPT+FpiYQ6rNUFX+XMFE8SqBpAy0zX30wccW0L6huV73WPbCs2/Pk?=
 =?us-ascii?Q?tzB9ctSIaYzyFT0JfE02LAFLktEKlVlTO+m3aSrhsxbAbwRo623ox+W0ZJR5?=
 =?us-ascii?Q?rzEn+dnhh5TlkdEEjxFvEECyaW2i3AiohSaK6H7iuBr97/9sAVrvtur8PxaP?=
 =?us-ascii?Q?DfcQf8uCM3hvB7HCYH+kyF4uB2yogqTX7F0kT3HndJX8vleELTh2QlL17dPu?=
 =?us-ascii?Q?8DkAKGteZObZclDstSV9ErCRx9EQFpTp53032+QTnffSPzOrkKKqCDooUTq1?=
 =?us-ascii?Q?J73xG4gqYaEToOp/8TRfSI/QSUlHgM+vXZyXfmwRS7FO8YYMU6FTZfhRODKA?=
 =?us-ascii?Q?7qxAL7fXBFt7OrkSH2/TOSa2fxcLNQmnR/bv1TvEImzIp7XKMxxYzxkCCZm5?=
 =?us-ascii?Q?c0pdAGD6x8I5GYARIDuHfoAkQcqhRAkbTsl/ugE113GhT63WMwXKddpdvUmR?=
 =?us-ascii?Q?cOki8WbFTvwMSO8ixgl9/r6BqDhkC0As5TyaAPI8PSIz4NLoZC2iyjNUtzSx?=
 =?us-ascii?Q?VcVWXaO68JhXVqhsx5snV/Q3X0QXQEa8nFWqkWnKdngV74ON9eSF/vKnNPr+?=
 =?us-ascii?Q?CDxPFGRQPiou2VDn8r1zcZih7Lur8d7SvQPHWdQO733pD6KmB5aTqbKp91Kt?=
 =?us-ascii?Q?JYSCoEj6sTq3ni7kKaRJL+jTYWJF3FQ9RdeW9xzl9Po3YOh6qXVCerXagJcD?=
 =?us-ascii?Q?wN3ozAUpaYg/soGJq1WQBFLNOX5wc3ibiTcbsXDNmd3jq+Bgo2hiKh/mWPpO?=
 =?us-ascii?Q?R908j1dWyYc2LbZ2czFb2z6keTbcF9wYsm29CdMkHd8RKqXTnZLykQPRpDVZ?=
 =?us-ascii?Q?tAYCabQ9gFfn7Dq+iKq4vi5uy4aHCMSa8lCJzIgynCm1giwe0AWKsVnyUF8O?=
 =?us-ascii?Q?QlQxOOIvmSmE9nP0mJ/pPXo7HPNRogVjj32Ju+E92N41/z8rjlEtK8tEI220?=
 =?us-ascii?Q?IQtHR1ii3nE6+BIbkibq2O+K0ePEmHezO+1ytQtCoBZ6WAJEg8T2xmdSSVaG?=
 =?us-ascii?Q?cPUkjpyls8AaZyuEACfSbbrS7noU06hpA7S/iMnRyNImrJPM8LBxH5shZgrP?=
 =?us-ascii?Q?bguBg/m6n+Zc6d2M2xsC2DZkei5E+MwJgfd6c7Akyi8y4N3hu5xX2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OeN0+WlMf9FbQS02AX4c4AANlWkKG2ZiAlqogPPLuudUrQNrN4XiwDsq9DQc?=
 =?us-ascii?Q?cB6jwffYEEbAGQYAxf4bzQc8ZntMmRLwDyXzwgZrnYCgi3t3pgD1/HNLAJVT?=
 =?us-ascii?Q?Zpqa1OEjhW0nVJCoQPH0YvZ0WwaKJJ1wyWD6pyGUkvuXLz75JMV3Pl4cIsYl?=
 =?us-ascii?Q?Ak8wBeJeTv/MM/D+z7uBv9YQXTRvtUTy7pFxD3qWhvJqZ6nF/3MkeZrZBsG5?=
 =?us-ascii?Q?dNAV0EUSD31M9k3OBZEurXz9mjgeGCtmhBaBUQXb4mnP9sa1DMKAqy3S7Opl?=
 =?us-ascii?Q?XufMXmCyT9Jk8nZ9KfVmKj1m5IgaKa1kUGkkVlEjLykiGewH5sp1KfMJGunM?=
 =?us-ascii?Q?ltP562UIXyjohyXp3O0iYIdCImNZjbpPKj2pQp0y+eJ9NmZ5cyjgycyHgdCG?=
 =?us-ascii?Q?ORbPAf7A9QY3uh0blG3m6haeiEvvha99YqZIgtcBSRj+mi5AlmghBdGb/0xc?=
 =?us-ascii?Q?Z/9pHt1m2WElLdeo0H5QQghjTlcgJo4M4E9duJoc07GiFhg1A91n2cjlTwsi?=
 =?us-ascii?Q?rVxrpJ03Y4y2MXJnW2mhSdzOrMR3dsPUOVdy6pbkt9l62V3ysWUaPoNnEMCZ?=
 =?us-ascii?Q?BoIFEapQUFjHxWPhLP2N6lio94zsQnnBxfN9ivvx00bg/xCqceXdy8Xqvqp0?=
 =?us-ascii?Q?8ZpWwuhh3RcrX1Y8K49jETMtwhFqxvNBhsdePXwSPOLlpRVzvH798p2igAYC?=
 =?us-ascii?Q?hbN8do0r9fVFTL6Do44Rb6tPyVk5ZeOOskHTlXtOx8IfXpuEtZ/KSMNXk4pb?=
 =?us-ascii?Q?uqlSkG7/gTTVIVRGPFNZJw4gHGrBil2DGTFlyDlKDrCsJa2Qhcaw9AMCp/AZ?=
 =?us-ascii?Q?qU0tFZ3PoAeNenk3xr29ucfXDYASJdhiOAXTz810kbWkDVCgT1ZNpp7rR/Rr?=
 =?us-ascii?Q?I2fxNYEPCjVF1Wv6b2ERgsc0VchljyrhPfcoRtImIW3giMKp7eO3v680S+2E?=
 =?us-ascii?Q?8L4w+ceCXlLq6i8C1ANaA06LqT/1I7C+ZbLqrJ8P/WKOHqIxYHRl0gKZmYBI?=
 =?us-ascii?Q?GN1d6gzSbvQ48DfUeW+bhm3jpyj4xvSydwRffiWLIbe09Rafdfy+WWF5zKcF?=
 =?us-ascii?Q?jMvBrxtfBwPsk/owi6hb1ARnLgVceppL51FP998VO+m1xi/g9CWjIxa5484c?=
 =?us-ascii?Q?Puio9ydz6Tew4B8pAUa8LxG+ZMxGR6NL0ZyYn9iUfeBO8ihMgHfXT/koNrL9?=
 =?us-ascii?Q?rZRkDyyIAinpEQEpLr3I47+pcZA4u1vA3pcSa3zIf4++7FMN3ArHqUX8KJr8?=
 =?us-ascii?Q?xMrw7fAZdW7oVriIuMe9CMx2n4y75gF/hbCkqja4VjfFpecjEzexwpK/5XMR?=
 =?us-ascii?Q?Ds2BkwLBcUy8fbBPsb7zLiUowVcVXlnc0Aw99f3N0QWuF6F84DG4ppgsioHH?=
 =?us-ascii?Q?Hx6R4vp1QAt6jTHg8WfYm2Nc6SILRVN1v0yOFjsYLM+g7YoD0fKGuRFrJ8m/?=
 =?us-ascii?Q?p5VYb5eX3alk8CSNx6+lol6eGMfyzT1l4YUUPfeNzg876CurqKl+p9F9znrv?=
 =?us-ascii?Q?yJuDCU97SVNJJ48fLOnSeCjZ54BCo3vWRBJRtQRbZAC3lcU4ye9VrS5vdjal?=
 =?us-ascii?Q?B/0221SWuyqrInVTZr1YfG8nItUWgYdp7aERz4bBBVfe3V2JCC1Jq7pwO/bn?=
 =?us-ascii?Q?R3T6z47aFiubIKbewL4wNmM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cc270094-ba06-414e-254f-08ddaf8cb136
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 23:54:56.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMBgLqJulT2CLxWv0Em0FmSICCNc4LDyq8cBvEDo478ClHevdOAXLGsQGHJNNt34PHo10OSqC3Og8GY9VniEwSbTpItYvy/iHZkJn3uArgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10560
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

This patch series adds
 * Support of 2-wire and 4-wire spi modes. It speeds up flash read/write
   by 2 (or 4) times on the corresponding hardware.
 * Support of DMA for spi-nand cache reading/writing/updating. It speeds
   up flash read/write very much.

Only 2-wire mode has been tested so far. It works fine with en7523/an7581
chips.

UBI attaching
-------------
before: 17 sec
after:  2.5 sec

reading of 0x1000000 bytes
--------------------------
before: 17 sec
after: 2 sec

Changes v2:
 * dma support was added

Changes v3:
 * fix clearmask in some calls of regmap_update_bits()

Mikhail Kshevetskiy (3):
  drivers/spi/airoha_snfi_spi: remove unnecessary operation
    adjust_op_size
  drivers/spi/airoha_snfi_spi: add support of dual/quad wires spi modes
  drivers/spi/airoha_snfi_spi: add dma support

 drivers/spi/airoha_snfi_spi.c | 641 ++++++++++++++++++++++++++++++++--
 1 file changed, 603 insertions(+), 38 deletions(-)

-- 
2.47.2

