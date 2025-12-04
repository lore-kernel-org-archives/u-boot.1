Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390BED1CDCF
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593BE83B95;
	Thu,  4 Dec 2025 05:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pIFwMA+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055DF83C08; Thu,  4 Dec 2025 05:14:48 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4309883B1E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwy6edL1iB3/os+jzS8IUsYJEJk7R31uZ76FyKZrt4mzWG1ssnYoYtD997ID6LzImXMnpBwWitHK/PXM95IHtS1VzuC9Zzc7TIPA/ux7kKx9FMWAGcv3gT6pQU7eBkKmzdYZljcpbRWdDeVuTvEXf+Gi8keHz1YVcYndpHM/Y7pJG1YU5jY5Vn4cx5LgkIZLZjBAKQjC45FeTIgNtyQYbfoBsDUUHEfRCOducY5fZSjfKGJVYKDXd2LWeFjFMt0cMPl+R7+M8BafTrx96nKEHxInh6IPOltiPC3TAuSGr4M+ltt8CO8/ESmbNzTzcZSdhqE4r3ZmDYUY8lDOX2FafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE0X3gV2Y6LEcBX4Y9pdyGGvZ6KNPUzqenRLikb7eyE=;
 b=mxfpPr7tQQwx+rojcFORTGTdgq4uIjeExZIe4xzPIqlQ6fp6ht6tcJWtmJMliDKvXNyhSLerf3zh4OHL+r2wKACs3Xb2+yK3TXomWasZjOYkHKXV3NQKhPOfrFRQxFkECjT2fioASmPku+hV9xGC7tS51JtIgt8M7Nhc+rTJ3lwiGn1T/asBclXN08HPbHuWLlIufzFw7SAAtUBoaGzwDAc+a9ihP978diYufDWI1KvxwiSQFB1j0mTFktzfyAVWdJfGgXBIeyIacyzK4WxOqmcHAEfMsbL5kTiaUW/de6FNYVzPy7qP51N5NgHpXnho4Dt42bVpJ7w8UsNyXtqNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE0X3gV2Y6LEcBX4Y9pdyGGvZ6KNPUzqenRLikb7eyE=;
 b=pIFwMA+U9ac81AR5YDQ5kV9rQHOSjqnT1er/MGcPpTce6JB43pcujrISHqLZiGhsmqWNafbO4kT76aLf53M6DHZ0QlvPq48Vkv+AUPVtCOjgmAIcxNHM1Gq4zzD7oTQqzhWwq/mgY5rJVBnlF0+SY1+MbTKVhj5ZvHXnWLT/Vc+odH/Klh5+mmsEHqWoy31//tn3XjBNe9R+UtzN6GkTKCKSL/2tBAGUzGsXi8mdJUj/hjDNlsAAMCIolGWQ3s4PDZ37C1k+VEixOCFwf3KRCibOFv5Wq5IW0gOesCL8W4M2W6PrdZBfyD4+G/AZnSUCdo/GKs00DeNGxP4Y51vpHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 00/19] net: airoha: PCS and MDIO support for Airoha AN7581 SoC
Date: Thu,  4 Dec 2025 07:14:14 +0300
Message-ID: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4592d1be-74b2-406c-3992-08de32eba66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umxDuGZHhvSBkQwifI2HJ7zgHLFw0A18UASa0w4bdBIAES9qZLbri23Qt/q9?=
 =?us-ascii?Q?XqnT3+EONKiwl6T+yN4RIHa9iMW7k4H9TGZYtXoBNQT/rgmYcc7LckIpj+Fm?=
 =?us-ascii?Q?Y4jqQrzmo6cLhpYUPH4Y9H8Sa/nGNtn4F1dYv5Yq0jF2O4doKVY5kybyHiFE?=
 =?us-ascii?Q?UBHObveE0OodJbAxk/4YzGYNByV+NmgJ8iWs38Mqep5uTjxIrXoLkMFI3zWw?=
 =?us-ascii?Q?Xz0r7L+tRH8B+cqLEwmiBhHVrH9UM4G5DsYoiCI0keWBWOZTb9ClzbheVgv2?=
 =?us-ascii?Q?vEQS+95WUwkT2XS2yGK7bAU2sywrjwrUTlP1edWWmQMMp/TA0OyGuSFHb07/?=
 =?us-ascii?Q?jnEiKxpX72WmldDFDpqNsv3/Y47Ppc4YOLc1ZjcJtE5wV93dc99v9qs6u7Xq?=
 =?us-ascii?Q?f0bKrW8PX0ZZy3AjVS6P4MrIdzoMfyRB0SKtvdfhTfiAOdeHU86WXdYcY41v?=
 =?us-ascii?Q?ccFmrZKNy+rQ1uKifrC70hWcZuYPIMYvlimAaPAAl21TM0xmnoB48SAQLIgF?=
 =?us-ascii?Q?yH+efpz40Evs5oij+dFFQjhHGLgpjKvXbBp5CZjDO4FTXLMm5nmA8yVqNfzu?=
 =?us-ascii?Q?S5c42sPH4+4npjR+eHJof+cFw4QXWWzvWhQIQOL2hcjw5ktNXKIhhD7SvO/L?=
 =?us-ascii?Q?dg49LYqlS2rF16IvKHMw91HfUMQLSmQzzO9ulW6XeqBSMp/iwwy6oYSeuXNX?=
 =?us-ascii?Q?sLv2NIVkyPmWD4mpFaQmbTj2sl5Qhi20m1r8sLKxADsQ6cTsA7s0QT1McQFP?=
 =?us-ascii?Q?JsBTQjgAWRn6+zdYLYNbwq6UVkNxZxn4SzAPQw7ur7Fz6Lo6u4aZN1vxhxAV?=
 =?us-ascii?Q?5Ug7JcUF4V8NoQEOP7/hRBPCWki3uJZdEi0rx5fZ3LUDgaUHDZxL1CAEAWDf?=
 =?us-ascii?Q?kXGInuRiBpm1dqQGC/GalEaUA+2mHte7TNcrVx+uaD7PQF7CPzf4raqf7F7V?=
 =?us-ascii?Q?Ql6EzLS3dfDdt3UhbOXvg73JdOnoZHrzuanpmPYBqMNHhAPvadJY9G4gxtAk?=
 =?us-ascii?Q?U+/QDBXrTTAVO5aRg+GT9qNkL39LzWJxwY9ocFmfYCiFq9WbG4uoS68V9k9M?=
 =?us-ascii?Q?ejWDg5FF5ls2hzZldCcmFn7ZJQbjr8YDzv+jbOLCIZlakx2lA7LrsKf6bry9?=
 =?us-ascii?Q?RZ4ynklx0YbExmE/wDkQGgjc80KJnfWW+6FnNrGYfaNZ4OFIEUTjeqCREMxz?=
 =?us-ascii?Q?57/GcB4sVBJA9ZDIkSKE6FGPYjVrV2t+FskTTenybb4cP2OfR9C6Vx1AR6zB?=
 =?us-ascii?Q?Dgkl1Oic2B43amRlaeLcELvwgstcFZYpg1tSbDriyWGdYM8Z3bOhLELgxSF/?=
 =?us-ascii?Q?7Q8JxT/0hDscqxnoci2P6kbahDTKoNJCIreoD153lmhl7+sHM4F+0WyxzzGv?=
 =?us-ascii?Q?ZZaPOZK34OEnmHwXCOf0BU7hP66FGp0WnJRAi1BWtluBU6tcv64UDBEDaMIE?=
 =?us-ascii?Q?CvKK6jDRCASomC5RztjrVi8oPyDHMQeXH1NTzBWXdXkHnpfdWJxE22dJ0S1N?=
 =?us-ascii?Q?u/BE5qnsZ3kEcdIXVLf2VZixDDm7nK8ht1grQOYZZaa9cFUYlUknXPOxJQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GLMsBLIMSHOJxmwAqtTakHKiD2wvESn8cDPH5U9JEFJeNP6fBGSQ0mZOy155?=
 =?us-ascii?Q?NP2/vAUhx2NM0CzDR6uQ7dxuNLs0STJf663+sNe4VVYFL+7OieYCwvANie52?=
 =?us-ascii?Q?oJGsrO2nc8BqAb1dyfxr46loKZU64KYRJlwhQJUsQjUk6W/S9ZQ11OvOAxLD?=
 =?us-ascii?Q?csleRO8+29i0q2i8qu8ME8NsGOkrisfV2wva5/WVRxmTI3zBfNYRz+ftvIiD?=
 =?us-ascii?Q?bz0wuNG+1AZlPjBw7nsQDFa+ykfG5S3yX6Ig90iSiNVs78me9ANo++K5nySX?=
 =?us-ascii?Q?KMRSCbK5eG+ZylfeT5XMbCSB1mMaP5K2Biu6/chj6C1af2LWlnRl8SoUEZsd?=
 =?us-ascii?Q?uXKCGIrAOZGMw2BRyqp64A0BcDNgJAu3m6q3UYaZAg6hWjoOp0t5w/cXX/pG?=
 =?us-ascii?Q?J4L0EaRZ90TjXDXSmRCOK1yMUDj4MKfTi/trCZJUHwtbo2YBCaI/w20Zv5Vb?=
 =?us-ascii?Q?UbmOR40y3Q3867tJTFQJPPxi2+aIW1d6YC+svpkoc+j0k1UJ7Z/GNPC8Bsw4?=
 =?us-ascii?Q?D1lCndIIYmQANGXRMoQNpZJ6rZxlGVn6C62rGv4R6hpSDjonf8VCrUMgGlJo?=
 =?us-ascii?Q?Sou5k1pEPRWXh88EHn/kd9RCbst2pl8Igeyc3qPpag8UthQik4HmaXzhwQGA?=
 =?us-ascii?Q?96+OzhvImL5VCQuDQat2y7lzDGAt3H2OaBuLhpHhqJGOJP3ShxV4xRwCZJxV?=
 =?us-ascii?Q?5+AD01LUe35/c6Tcqv72UeyI/Yjm8UtzF7bDjzwp8uddIxca7BnY05jz9jZs?=
 =?us-ascii?Q?v24Vc48/VTAV59ENKIBYIFR3v9y3VCaYr8SY4QciQ2aBc+KAQqKsJUfaSRXl?=
 =?us-ascii?Q?SLoJ6h2vVHLE5IRV5JA+1cAsFxlJUD+wWFqYE7RhLTsaF8g50iPHwh0A1SIJ?=
 =?us-ascii?Q?52jcY1S0X23E2JpJox6VGbHk/Puv/v9mEtHSleVNQYsq9MSwl2FjCdruRnK4?=
 =?us-ascii?Q?gz1Oxluzw4M13vtw79akvP4XDjAc36d0zf6DzFdoSpVOaTcgQSBq+DsqhaV2?=
 =?us-ascii?Q?E5Z+RaM04Hi/LCmYO3ZcUZORgiNMUNc+JVXroQq1O+wfW7dtLGkD2p5WktGJ?=
 =?us-ascii?Q?qZFrHe0BXKJW5KjcycGuQOKp7Z/mPdTWctcX6rRtRHUIrTpYiVpXsgqawkZo?=
 =?us-ascii?Q?FcuaHk4gSlU8IEqr9rPUbIHeI/yXQ/DArr2/EjnceiN9kQqxPgcF3w/abmLc?=
 =?us-ascii?Q?DIFrzPjhmy1spCOtj+GUYaZLKFyOb+Lf9MyImK50qYUlttJZW+XvMxxik1Kp?=
 =?us-ascii?Q?rYmsI+h0dMkKT3pYiNGRhCbOXWPtrykoZLkDffphLysMO2jNWYhj3Xdg2xzI?=
 =?us-ascii?Q?c/oCuu/7iHxS7EcjzLk4UEXVlPo2d28DVh27s8dVWSMKWcNR3QVmu6xtRkG0?=
 =?us-ascii?Q?+pRpv8fwqrd299HlpjTshazd3hLOQ5nNC37XdXvFTExrC/lwJbbsUb2H8C/V?=
 =?us-ascii?Q?+3JABULXfvTlwgjgLQOkEFcfHWqLyiY73SmjwaQnHle2aZGGQT92VZxUghGf?=
 =?us-ascii?Q?D4LsWkGVwGnvf5b/8sS8bJ4QLzbWADtk1+BidEU8g6Xg5z4Kj0RGsuHg70T/?=
 =?us-ascii?Q?1rhcy+DYUgzP3mKx5PcoisgDLw5Smq6dL6UU4ra94Z8U9xFin2wc84Uw6uhP?=
 =?us-ascii?Q?rpbhv+ZpgdJQ5z/4kvrTDzg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4592d1be-74b2-406c-3992-08de32eba66c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:42.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WygnSXcDbFki10YGsKabq1ChXk9qO1rh73PBYwV8Dr28d+4omBAK+m9m/GGc1c7z1PAgeJ7hifp+VYUSMnvGBRdSxdp6M0wM5NyTPqQCix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

This patch series consist of
 * PCS and MDIO support for Airoha AN7581 SoC created by Christian Marangi
 * Fixes and improvements of the Christian Marangi patches.

PCS and MDIO support patches were taken from 'package/boot/uboot-airoha/patches'
directory of the OpenWRT-24.10 clone repository

  https://github.com/Ansuel/openwrt/commits/openwrt-24.10-airoha-an7581-stable/.

Original patches were created for U-Boot-2025.01, so the following changes
were implemented:
 * patches were adapted for upstream U-Boot
 * Airoha AN7583 SoC support was dropped (not supported by upstream U-Boot)
 * minimal support of Airoha EN7523 SoC was implemented

@Christian Please let me know if you have any objections against these
patches getting upstreamed.

Christian Marangi (8):
  net: airoha: add initial support for multiple GDM port
  net: airoha: add support for Airoha PCS driver
  airoha: add PCS node for AN7581
  configs: enable PCS for Airoha AN7581
  net: airoha: fill in support for PCS/PHY in Airoha Ethernet driver
  net: airoha: bind MDIO controller on Ethernet load
  airoha: add mdio child node to switch node
  airoha: enable DM_MDIO and MDIO CMD by default

Mikhail Kshevetskiy (11):
  net: mdio-mt7531-mmio: fix switch regs initialization
  net: airoha: allocate string for GDM port name
  net: airoha: declare airoha_eth_port as U_BOOT_DRIVER()
  net: airoha: do not call airoha_fe_init() from GDM port independent
    code
  net: airoha: init switch before GDM port initialization
  net: airoha: pcs: improve/fix building rules
  net: pcs-airoha: unify code using SCU regmap helper
  net: airoha-pcs: an7581: sync with linux code a bit
  airoha: add GDM1 sub-node into EN7523 ethernet controller node
  net: airoha: makes PCS support optional
  net: airoha: use mt7531 mdio for GDM1

 arch/arm/dts/an7581-u-boot.dtsi        |   76 ++
 arch/arm/dts/en7523-evb-u-boot.dtsi    |    4 +
 arch/arm/dts/en7523-u-boot.dtsi        |   18 +
 arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 +
 configs/an7581_evb_defconfig           |    5 +
 configs/en7523_evb_defconfig           |    3 +
 drivers/net/Kconfig                    |    5 +
 drivers/net/Makefile                   |    1 +
 drivers/net/airoha/Kconfig             |   12 +
 drivers/net/airoha/Makefile            |    4 +
 drivers/net/airoha/pcs-airoha-common.c |  827 ++++++++++++++
 drivers/net/airoha/pcs-airoha.h        | 1220 +++++++++++++++++++++
 drivers/net/airoha/pcs-an7581.c        | 1375 ++++++++++++++++++++++++
 drivers/net/airoha_eth.c               |  368 ++++++-
 drivers/net/mdio-mt7531-mmio.c         |    7 +-
 15 files changed, 3908 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/airoha/Kconfig
 create mode 100644 drivers/net/airoha/Makefile
 create mode 100644 drivers/net/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/airoha/pcs-airoha.h
 create mode 100644 drivers/net/airoha/pcs-an7581.c

-- 
2.51.0

