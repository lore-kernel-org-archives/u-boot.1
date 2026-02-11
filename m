Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819E3ECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2638883D9C;
	Wed, 11 Feb 2026 19:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eDTsvKfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAFD83B30; Wed, 11 Feb 2026 19:22:52 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4A783B30
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcmOuOHzK57oaTkE1czmXdebFvHIQQyclSsHQvhxpRjYTLm15BZf51WV/JLgEc0imq68EOyJIm2gO2SSe3DOLe+csaGnbvPetl070x+EvrjSwxIBGKM5KZAoWKa5qN9seT/C9oCvo3QdkG+kVnVBShs1ksmbrPbwOG766ZSmXidSfhYlouNubchFe2bqlPVjDL1tLVsNLKq6xdVM5cQ1kmvH89RF4llJgz1qX5C0++mUOXucYZpbMJy57FnZapGpHjqY4MFPU0gXk6MQXtDjMpBUQPk5GzNCgK8GUrUvjqNXKSmiRCuP1XTMVRo14HKg24lwc6tu87jm8lHcyMpJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7owWYaJArr7BVbvLpDeYQGOlT2cMYrX/no0axNwQPs=;
 b=AiLOinNWLgwu64d+XH4nFXtxUt9/3jnJ9rl4/w+jnof+4Fes4rIfCltR5D6It4Xb66YN58r2WbZBCRwIAuQejW+2meeCRRaWFiNDPdMVZYrludkMUdrKylkNqCNClh2vOhdvIe/p2347yrYSCt4F8BSgRMabg6zm6Fh/eLpE03oWETU7GUqOL0ELE7eyzmRzNLSEGzCAPpwToKUF3cGtKxj1ntXsPQfoSfruRuaui1gYARUc56Mn3nBPkZke4xhrwfN6nNFcTYTn2aYSsF4NqOyB39jl4YgRzeNyYAdh77ybKRwvx4NG8VY/CqSsMCBDbN6tz02zWiQVJBjsKMGeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7owWYaJArr7BVbvLpDeYQGOlT2cMYrX/no0axNwQPs=;
 b=eDTsvKfEiGdduh8IsPAECIuH5VzMh5fPoxC+QlVcxxCMnD/pYzgRUL4/im12O2nbbejjLBzCevQqDdwqJ7eLQY5DX7Rxj/oRRVZsznDjyDRKqUgDOz4hsZG2LY4NQCwQNmmacX19NY94jZ55MjATM5/Pw1xzIDMFJg8FSQJEXmINl14QhktuVnoKoMGogg5Gf2nM9Xu+Kyppz/lZ2ycoH8fgvuQjt2ZU+l2lR4AFzSL87dzuNOcqGrgH/hxKMJHXKEuqpFptWBqRxvDdu2onHxii2qR96MltyYRVh5B2VC2V95g+Uu0S+48QO1E2TKRXb+i0P/UtvsO7hhFuskIQcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:22:42 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:22:42 +0000
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
Subject: [PATCH v2 00/16] net: airoha: PCS and MDIO support for Airoha AN7581
 SoC
Date: Wed, 11 Feb 2026 21:22:14 +0300
Message-ID: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 475f2254-67e0-4a42-861c-08de699a8bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8mLCRwqx6WNl1G3OxtrBdC4h/nnNrHMEkVieukOw3F9r3R4mvBd5j+7hlpT7?=
 =?us-ascii?Q?3OAIveswbHpLE6U3V+aZGQYaPFjyjWjtw3MC9T3XqVV3xPvila0B8Z+cShmP?=
 =?us-ascii?Q?S6M0nYmiYFs5iBu3rsmxt9/0+6hREgXC3Qkq7NoSVe1cbi4BcCWZRMIPjmyD?=
 =?us-ascii?Q?XiKSbINKcch6vnZ0MN4d22q+oj1p7cyjz/sNEw7SF5wAlw7P0iw8pGJHusoj?=
 =?us-ascii?Q?WjjLVEklrjsNnIToCWlm99DRC1o7129lY7r3Aqc9P+ghXiRErjsZ6ZgD43kD?=
 =?us-ascii?Q?cRlsNl5zyhKEVvllB9CDbbINcRPSCOhE24ZJhn3e56tsFgzbucNpONHP3VOt?=
 =?us-ascii?Q?JN1F5sIZtYzZNysV49ltz6187huRHXP44+oFt6d9Xoj5B5L5/9qqiUKuxKmj?=
 =?us-ascii?Q?19or5184GDiJIjMZsQwKe7aBfvcWr0GzfdKvxbvV20X3tugpSaCe0MpUwVPJ?=
 =?us-ascii?Q?74D1Ti9KRjxkAdxcPGUE1MbjUaANV7rqymVV001q+lmzXh52bHYrAgyN4tIz?=
 =?us-ascii?Q?aCsWFgcsIwQSagfmWTRnYNzQk8siHa7UjaA2ceq4sPWI3GXhmBEqv7QFsFCY?=
 =?us-ascii?Q?Mgq5tj5/PKDBIrva4gUz4C9jONb0dYmyy4h/UwWQigQKhQrqzSjX52DrHhIi?=
 =?us-ascii?Q?mc1KYNx/KnFwm9w+skQjb4REPuIn9xZafNmQrosnUrfDLGxKuS9KTEGHw/P0?=
 =?us-ascii?Q?Y8lyieCC9QPKfuWTVHx8YHDvtrHVWQUQR0o45OtIOd38xKarHA1I5P6mLlTw?=
 =?us-ascii?Q?sbLT7hLiwBko6glHGXiAniBWaBGI2baNO/H4YcEVeFnowrZcOqG07nYIz4f8?=
 =?us-ascii?Q?nA/Clvjs2FSN7GmkyCNQxQGMkGJD/QPtGd6fWUC4pDg+CCBsXCKqAedrvy7Z?=
 =?us-ascii?Q?K6iLILhJziFaS0SGG4pvU0kNrWNR15nfgHjfc1lT4l0y0XCEmjBg+TKLdIyo?=
 =?us-ascii?Q?H+pSz2SmhbsLXsR4gnIlYohdqH71A+d2xQ0cCQ/+6rC+Myma07wS8d6bD1Qy?=
 =?us-ascii?Q?k8eQ7HrgkajsaWX2WBzHpj1gWlRb12gDVt5uZYW4xk/q+uU9p4pgKlZAR2ah?=
 =?us-ascii?Q?NsF7NSl+bbbzBNe9Iu3R5nC3fT1C+txnRp9o3/xajq4RKfKr0a7t5qS6v7nz?=
 =?us-ascii?Q?MF5w6PxVJ0gLCV3+Y+0rQRFJaPIZXrO0YMvaNoHXC7a9mqmSiTRpN+rVc3Ly?=
 =?us-ascii?Q?p9csRBXC7l9iVsqjKRMEwKub/6u5OtESVMuBe4edbTvtOx2kjXcqcpq2iJ4R?=
 =?us-ascii?Q?jsjYFy81kq9YOm5uefyn5PiK5TB08I4Fp5eVjNcuzBlkgrpcfM1wpIY0PSA5?=
 =?us-ascii?Q?pHirzi2mgZwxfBU+Mf4tlOG4h8kFGDyLmZra2t2XTgpH695fip1plJSQa0M5?=
 =?us-ascii?Q?MXUTSgRZxmgvwvab/IEfnAnq/N5CEUL3zDlwh41sp6LrnAFYEY57EDYwFHHY?=
 =?us-ascii?Q?UZIZ/HpOA/yi/cjCHu4va228LkpN8QW0iCoepFj7aUYHnTblnsm+gTLQb/R9?=
 =?us-ascii?Q?1eOPoqEJN/k+9TJ2Ew1/zOy7/knInf//1ZvB9uCPxLzyIKRl0aanrTgpAvY9?=
 =?us-ascii?Q?4+2ItHPqDN0KcX/06rE4WwL8Th9VRFRVGu7yQkH5v9XNKaUIRv8B+YKbA2RA?=
 =?us-ascii?Q?bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(13003099007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cOmS8hx7sc2Cn9RxNoPcrPtdSqT1xSXOEOiE15LQryYio5pdL/h3Bnbe/5+g?=
 =?us-ascii?Q?v51lnrBfN9/RW9TxrajrjvTDlgFGaWMbxNb751SSeQUKCw8Ik2leW5dpNPCF?=
 =?us-ascii?Q?pTUK4AzcpvofwyonaS+voGx8U79TN+bjNVgkJukr23SkVEQTrQLm1Fu5fQRs?=
 =?us-ascii?Q?LOWeQ8AFsBJ2/Bdvq/B/Yt1HqTHwNH8/Mu3DUhSKpraYTmmkjI286CHYItw5?=
 =?us-ascii?Q?cJs6IDsLbnWDtwfsCORxV9jI4iqh6a6UCY00tU4tvaOZulAeqc+XW2R4T98/?=
 =?us-ascii?Q?IFOP4Pnnh7NlV7hQ/lfs1xm+BJYnMEGNcEeDClm4vyfNXSvZSpLYbGl07jNS?=
 =?us-ascii?Q?G3WS44AgLFzhALpK5TnoCTYBy4qDqMZYdfhPM5C/uFwli+S3Jwkrn35vUg9N?=
 =?us-ascii?Q?5r1k4VvDRb+mz8NRsTYyq7nU6vn80eUOXKoxDTn0ROyfToDrMWxhxMhZtOfb?=
 =?us-ascii?Q?AGO++FTx+07RsFmY7pxVCJSG8WibCj5+NyZxatpTbLVgHtYQilJ0yeL8aRmN?=
 =?us-ascii?Q?XnbL6yQ1AH0ar907fcSnzCUJnXEtV65kNqW9YRiIpglwG+IDOcq7Icw6rBBp?=
 =?us-ascii?Q?9UIjmaHF7ke5ErmTuh2ElOHeN9dMgJTRERjBQfxtHAQtrCWLL/KRHRjEBdFK?=
 =?us-ascii?Q?T2EoYv0s4fkG9WzSKt6AeRk1iffhD1NKz9juZ0gvYltMJVTs3hRAt6P2yCrq?=
 =?us-ascii?Q?TckUmnqEBk0dvVt8NN2f216qYDCpwWzocixX+283MvZyOoAsqEJ1xLNFEiRu?=
 =?us-ascii?Q?/u82LEqqn20iFDUGlSklhpBlVyJVXyBzW/2Vkl8GS3G3uB9lCd8XwYsflbjj?=
 =?us-ascii?Q?szxLy+Q3oRzLSxvF/xD0W9vHMZI7PBLdOr6Ua8oThDWFbUgniajOWLiyijwv?=
 =?us-ascii?Q?6VqbtoHiOgrbji0TNlH9YE+LYSjZh1EQsxfvDWVMWmGXBK4lFSmFuWqC2T8k?=
 =?us-ascii?Q?lTSXm0dylQnhXPguvzvOSBZsuTokTuxbHxRuAj26/0yJj4NKDW+d5lyKvO4z?=
 =?us-ascii?Q?UQD7F2DYS1/1xXhJgX80mdBodAo+BxxQWW4dtvv7VSms3v3kgrm0maljpycj?=
 =?us-ascii?Q?LAIwLlBA3n1BWbR9QUAEA/Ngp61F3I0URnadDkd+dE8q+qPQi3XN0D4FlKS8?=
 =?us-ascii?Q?qJ2tGVrIFwxPDy5ZtWeLNLKb+kmn4744mb2NKEiVfHcN/da9w+LpzYY3dO8c?=
 =?us-ascii?Q?rdu3ZTtJa/MCvl7L7TzGzmq4laWE1JPWm6eNvU1j/e3BXcxgZFQuB4Zd6MFj?=
 =?us-ascii?Q?e8Jrk338TQrf0sIy+g+U0Cle4QQyyBPHwigXMHH4RvRKJMJWS04PrbvrYH0i?=
 =?us-ascii?Q?8AQMBTB8GDtD7pabqba7hR+o0BciD3vL26nCRZAuUHqNk59fSurYH3LoyKxh?=
 =?us-ascii?Q?JJEYW8CK6U+Dj0oSk/62cXmhRsnSl5x3HMAGbLuWBXY9j5tAxnpgowlpbJqz?=
 =?us-ascii?Q?eqfSO19HQRJJNZsqlARjJkuWBZ6ZcJxX0eWdLmD7rbkqPEIyHEZ+8gTWXPMS?=
 =?us-ascii?Q?3UBK2Vq3CfknZ4O3dM4UpV5Vpot55YvGBfTK0lSgX7OSi0QzCzYRDy//7Fht?=
 =?us-ascii?Q?ZXqr6oWECx56W2vCgMxAGbTwQJHOwxCaaqReKbhzrbq22l98gAfuvT+QCRbj?=
 =?us-ascii?Q?tlt+1T+7InnR0ABzJhfZYUSia4bEcne7YzUQGt6GKFIRZUxG8WjPtDXecIBe?=
 =?us-ascii?Q?JSpbQwtlpXjhHOyIIED+2woMqWJ6M9kfiCRzv6tObPAJlCpUTjtpshrs8oCK?=
 =?us-ascii?Q?42pwhe80OwP/Uc3vSSjP6l1rRd30dMg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 475f2254-67e0-4a42-861c-08de699a8bbe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:22:42.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXmZnfnW//Ld/aiMucCgby6d214+RTn5HfwRL/T7GsfpQ57MPrx5/dmXHpSGWxWzbiuSJZ/dJjbsSe/AmHIRigXeJUYTscABmFtkN7JRTHg=
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

This patch series consist of
 * PCS support for Airoha AN7581 SoC created by Christian Marangi
 * Fixes and improvements of the Christian Marangi patches.
 * Minor MDIO related fixes

PCS support patches were taken from 'package/boot/uboot-airoha/patches'
directory of the OpenWRT-25.12 clone repository

  https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/

Original patches were created for U-Boot-2025.07, so the following changes
were implemented:
 * patches were adapted for upstream U-Boot
 * Airoha AN7583 SoC support was dropped (not supported by upstream U-Boot)
 * minimal support of Airoha EN7523 SoC was implemented

@Christian Please let me know if you have any objections against these
patches getting upstreamed.

Changes v2:
 * update cover letter
 * update patches for U-Boot-2026.01
 * use https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/
   as an original patch source
 * drop some patches to be more close to original Christian Marangi code

Christian Marangi (6):
  net: mdio-mt7531-mmio: use common header priv struct
  net: airoha: add initial support for multiple GDM port
  net: airoha: add support for Airoha PCS driver
  airoha: add PCS node for AN7581
  configs: enable PCS for Airoha AN7581
  net: airoha: fill in support for PCS/PHY in Airoha Ethernet driver

Mikhail Kshevetskiy (10):
  net: airoha: avoid out of boundary writing/access to gdm_port_str[]
    array
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

 arch/arm/dts/an7581-u-boot.dtsi        |   71 ++
 arch/arm/dts/en7523-evb-u-boot.dtsi    |    4 +
 arch/arm/dts/en7523-u-boot.dtsi        |   13 +
 arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 +
 configs/an7581_evb_defconfig           |    2 +
 drivers/net/Kconfig                    |    4 +
 drivers/net/Makefile                   |    1 +
 drivers/net/airoha/Kconfig             |   12 +
 drivers/net/airoha/Makefile            |    4 +
 drivers/net/airoha/pcs-airoha-common.c |  827 ++++++++++++++
 drivers/net/airoha/pcs-airoha.h        | 1220 +++++++++++++++++++++
 drivers/net/airoha/pcs-an7581.c        | 1375 ++++++++++++++++++++++++
 drivers/net/airoha_eth.c               |  321 +++++-
 drivers/net/mdio-mt7531-mmio.c         |   24 +-
 14 files changed, 3845 insertions(+), 51 deletions(-)
 create mode 100644 drivers/net/airoha/Kconfig
 create mode 100644 drivers/net/airoha/Makefile
 create mode 100644 drivers/net/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/airoha/pcs-airoha.h
 create mode 100644 drivers/net/airoha/pcs-an7581.c

-- 
2.51.0

