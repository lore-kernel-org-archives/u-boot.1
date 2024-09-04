Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C481CD3431
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F5388CB8;
	Wed,  4 Sep 2024 10:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="VAWS9LRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C6A888C8A; Wed,  4 Sep 2024 10:18:47 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D4788CB6
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeP7eFqXyCIm/ExK2XpI6pKVdZwZcli0GBOwKeWOyKm9R7xkAz13P+L+9Cgg1b7uegETCqqR9SKqLcRL5s7boDzRRRdeSFhGc4lRdN7/EeG7R0bw4FPIlR0waQ/EUPfQakRWiOqzuH1BLMo9uNKcpE9ozkQJLGzDSf8aYWzV5rRLnFrUtHnyfdPBUjWTv75QtGJTg/MMHoWumvEm+IPxEwXKd0BgHRJ/PjQ3hDjwrJnB8Ifbxe9ib/rnWB67Ly4PCPJY7Hcs+vgDt/1vmUQqpY2spBIYxtY+X1G2Ca6D+LkVcSIzbemfKEP8JaJsyYknVG5VwbD4k+JIob7pvLKxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/19m0jz1AsOstObv2pRlX8rI07ZGRovhgVOR6zFQzY=;
 b=aVloRHS8rgckcM3c2Q72CN45k5C45jed/kcWNe5Aupg1UBa2+jOA+Ot14XaSoKDLthwr90B/fWGsIA1cad4XsOwoOdJLt17Arp5Se3r3+uXxuCeYiLNcnmX71kpeY4WBeENWvKXj/FasEGgTyA16uSKHKVWw9Y3S35E6GHLyPvOadogdtyCRx8CMBHuxkblMyxqGalK97405z8wCbUedvqQz8RalHUks2XoTMqi9GW98oVYoD+V4xYIopyHu6KpxXD/Wx/lwR9bqLJJPlSbzZ2dkgVLhNeNRkJE9hl88lpyEMFPtX680wrqx7jDCO/62HN7f4RactLGisWenrt2IMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/19m0jz1AsOstObv2pRlX8rI07ZGRovhgVOR6zFQzY=;
 b=VAWS9LRePlCToSekW9eHMjSE5tNZ1+DaE+DKUIoN9MlDHYn/qtGIGvj0hyO7Pke7czy0e9Mak07Mnl1U+29pz/lx/Jsh2b/leee2cUt5T9FsH/AddDDZoAr5lef6F/R1/oJHoe3YM/iT9ulPR/E09Zo29BTu0ZY/G9c4dlEopPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB5233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 08:18:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:18:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] treewide: drop redundant "type string" for SYS_SOC and friends
Date: Wed,  4 Sep 2024 10:18:40 +0200
Message-ID: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: b75c10ce-4d0d-49a2-d8a5-08dcccba3013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNjVL/ncQXMfP8mp0QjDNBqy8DGLrdbMXHtRqAXHpFzDc0wD5eXV15NUfDtt?=
 =?us-ascii?Q?gg6EYSkQ/vlnhgxbcJ1MIc/gNoWaXCemXVFS7KJCqFxJOFb2ex+iBzvyDx/Z?=
 =?us-ascii?Q?Zdk29ysCnY4UQaB+WhMN6FuijNfX05Y6aShQzNxbm8ELz3hm4vadyD2x9PUo?=
 =?us-ascii?Q?Aq+dR6M0GSTGQpKioLn/lLmUt2I4/LwSSRwl9K8Glz37sK2mArzKUm3cOxaj?=
 =?us-ascii?Q?aAik6MjJM5nj/HDN5pwtGyxTfWMW6KGdw/cHfMc+R0LvM1PxXg8h36MN4ApS?=
 =?us-ascii?Q?Bn4myj/SWVjB7fsv0ahxl7N7NIEihNjx7e5rK+qYMFF+HSeAleiPC/nuPWM0?=
 =?us-ascii?Q?7fAICXj/GE+LDNcAXCL25/r+PMJ+Vm4ppxMJjWg5JY3flP9bgj+9qkf2F2n3?=
 =?us-ascii?Q?bfCq+kNk3X2RglEkCMICdvRPWuT6TkEpW9FVniaJOLNSrVOhTx8twZTQQAIP?=
 =?us-ascii?Q?cOcM+AEpZxnyhQI4EBksDRz2ilifbSJSZus+05B6rhsGNlz0sInM9QshxlJ9?=
 =?us-ascii?Q?PjZBO0UpoJjbqxZCjqitF3BojWx3FMIq9USnuqR+nnRu60BRHsClSF8BF85i?=
 =?us-ascii?Q?pXmvhTILNZHWbQpyds1iZH2iW/VwmDGJYh4CcWWwCeYx+g2rYZZwOS0ERHHf?=
 =?us-ascii?Q?nClIVirunzQhS1qVafoVzwjz8dCaWl+rKsJhXLvXntmyAQZoMjxgC07dXrQD?=
 =?us-ascii?Q?dq50XlxSXonNfwt+NaI+cfX7CKef2DF2geIREplQg/xppHkUjtHwCsZcfyJK?=
 =?us-ascii?Q?QYCICc2jasVzYPQdrnrO7Mv1vpueyhDRnk5IaP7heWz8AmNyYELUZPQZxLw6?=
 =?us-ascii?Q?8VmfU599ddfOhkIkGn7vaD1A/KF3dDMFeyCBrFOXrfHThFbmhqVwgdx8KHfX?=
 =?us-ascii?Q?vxkbOwXF/2sYtw7QlFGE8i89OWthlcc3sNXqa1SjvTYZhDuV94gEiP9pqfiL?=
 =?us-ascii?Q?nO+Eocpo1bpsl98RlGU5sh9tGfBl5YgMSXuVN/XbUMw5Z2IrR48CmsWHH2tP?=
 =?us-ascii?Q?MgCJaLU72uEVnj1gHyREdCHEh6OP6a+6ltoihCsXHC3VwpXVUhGJJWONM8ER?=
 =?us-ascii?Q?t26XgseADDZdxXOZnZ9BLCR2cn5fBmDf2ltKYPbznCYiqvkFURhx+NLhBp/h?=
 =?us-ascii?Q?K2QakJeA6ScjL9+QaN8KBYkghI7sCVS1KEnLBKsOZgZehOB5r4r3UIz3PdAL?=
 =?us-ascii?Q?M+vvDwY4smQET0WRPcKFtZycQNXcgmkTTXLUNKviEPGjtMSqv1mQwr28kGh6?=
 =?us-ascii?Q?ztopqiVo7n2Lnn3i9y2sTztCrgihauvuU0TkmLHN6QbamHbEVziO+NOkblzc?=
 =?us-ascii?Q?VFuvPygICrfE3wN3sx48jhe/Zd8Yce2/92S6FUHSIAjt+h0LmIZZMJ+Pi67R?=
 =?us-ascii?Q?Kb1XKVGynG7GSx036n0b97+dzmhSvIHzteggtvlPrhJSVoWtjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LukLignDBsRezMMqFgEIuw6BwL9pFssJ5jgLGA5QCW/Qmp4D15evrJ6KgmdA?=
 =?us-ascii?Q?JFZ7OkJXzeTeyv3hZbRV1tkrmyM5SpcLjm+W6rM9NdUlTR4ouC8qoKQLRraw?=
 =?us-ascii?Q?QMkPVptpTgJQYOkOf3mE44sM3z6IuU2KVhcfpdcYGPM+TReLxUlBhJKSjQgn?=
 =?us-ascii?Q?3e2+CcylAk7hkcnvaKHTJxIxEK/1uw8DwCo1kVVgFuDO+/TewAhmGPszUI+O?=
 =?us-ascii?Q?l6taa5MPTKGmx7tsaTNANZ4kRjolGozZ7qfqubPPeTB5wloRAWAWOmOe4dKo?=
 =?us-ascii?Q?d40osSfzUpX/8ifT+UoQPJjHP4HWNntb35NUkmhkLD/5N6u/oI9MmONUEuh5?=
 =?us-ascii?Q?hw1oGCUSDRjDveg0GJq9vzLfbfN+IRfeH9VGoT9BVLbvwaTGQyvQjvGpNWmX?=
 =?us-ascii?Q?yH8JAPiVY00HrKGUY0yR9lUXNgUCvcv6qmoR3ZXg5ZQdc6x2Sgh0LRPI9Kot?=
 =?us-ascii?Q?+VKCsGPgoJKJWNsgGuuMFI8GXbBenWaGAeHVtaI1EGVJtH/gauA2/o/luCoN?=
 =?us-ascii?Q?kcdAe7FQBQJ26RP7Wg7XNiicv/XlhIn7VycXh2eyiJpKGKdBEz4cHxQRypjA?=
 =?us-ascii?Q?o9HGr7IOwgUOpVSShLFDxT8mxGNfi1iYug3jxVGitpd2P3RFpIfb0bhmug8B?=
 =?us-ascii?Q?UiQV5i7ObkAnmPtFmnuCNfLkodlmoPQ0MuSLFuZgllB3jpCWuae+KYrFCKBR?=
 =?us-ascii?Q?OsoNqxjKvz2TgRxLfbmF4wA3hmQonDFFwfdOjLsr6++0CHyrmo0YjTlYYJoh?=
 =?us-ascii?Q?qfmYDn5KPkYwitPVK6/qZ+vH7si5So4MUgLkDHaovSPSfV327eZVeOGetu/E?=
 =?us-ascii?Q?gUxPcIGqnilipIIDCOE1zKc5hQ7nEWfOe6yeaFFM3Q4XYYM0S4dx1aNxXuSC?=
 =?us-ascii?Q?WCAp+VxETiOpwHPQ8KBMH1gBLZckhY677D1pKGWbxIRWmBPOdIFOHn6mhka5?=
 =?us-ascii?Q?SpiQP/HG2UC3Oyk4ksFZmN0hntuO1bkFeUTDdWsjn1nB2TudPxL+GIZY1Cgz?=
 =?us-ascii?Q?V64tei9MX1cg8wBKfczEZLVOxK4JeZR0SrrKK74ULBJJEwvRXvZLQ+aBy1jY?=
 =?us-ascii?Q?FJ3XEbF5/0kbsNwjWkG6EA6X3aZaJHdUBHwIBx9+T0c0hKicfO3NOOzOF160?=
 =?us-ascii?Q?XFkoZSIS+RhLlDd/wmfQ92MyTOEKvyhzg+eogl97l+bxEoItaKDGYrVQvjwE?=
 =?us-ascii?Q?IghdPhNlYpJxVIZbu5gcxE3d8+o+ZGOzn2WG1ncdYDBPtZSYGWNHGpEsPeKB?=
 =?us-ascii?Q?yADHhTUd+n4spNrJ8vJ/+yP8T9shZBTr9oHcuytWV1Jy9Q+ODNHP+KjD6KI6?=
 =?us-ascii?Q?5A83pUujrHFe8x5n0h1az3bwpNN0dsgJ1BIinpueb/ggeTt1XVj475jNn/CI?=
 =?us-ascii?Q?zTE215M77Znr9xtIvwtfNW0WVVPhFQx0623CMBz+fX3gmaOKtS68hD+K4s4X?=
 =?us-ascii?Q?wkJkyGdZKLLnhetNMk1qNo+34HVrSZ+b9I2SP38a8c3vCUdvwpMCm3re8ndn?=
 =?us-ascii?Q?Gdp9fysf11tp6k/oJq6YGoBQWL9O2cnLK62PWRnRoEWERdIe/709HdBSEIBb?=
 =?us-ascii?Q?DooD4KJsBRWMwAWlvfp7UqU2PE5L9iAsEHN0GNC4ob5C+QjeHmLpzAYBVoB+?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c10ce-4d0d-49a2-d8a5-08dcccba3013
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:18:42.3932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEfcT75lW7SmZVzKIgV14qFPNFSFDouP0HT7PcwabTaub3WUmO40JfJ4pxgKYmrMUPxOJZ+vus6ifndv9zOO4PR99pAdGQMsKvslhgdE8gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5233
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

The Kconfig symbols SYS_ARCH, SYS_CPU, SYS_SOC, SYS_VENDOR and
SYS_BOARD are defined in arch/Kconfig as having type string, and most
board files simply amend those definition with suitable

  default "foo"

or

  default "foo" if BAR

stanzas. But some also include a redundant repetition of the type.

Homogenize the code base by removing those lines.

Generated by

  find arch/*/ board -name Kconfig | xargs perl -i -g -pe 's/(config SYS_(ARCH|CPU|SOC|VENDOR|BOARD)\n)\s*string\n/\1/gs'

with the trailing slash in arch/*/ ensuring that arch/Kconfig itself
is not found.

This does not change boards which add a prompt string, e.g.

  string "Board name"

because I think those change the semantics of the symbol into being
user-settable.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/mach-octeontx/Kconfig        | 1 -
 arch/arm/mach-octeontx2/Kconfig       | 1 -
 arch/mips/mach-octeon/Kconfig         | 1 -
 arch/xtensa/Kconfig                   | 1 -
 board/Marvell/octeon_ebb7304/Kconfig  | 2 --
 board/Marvell/octeon_nic23/Kconfig    | 2 --
 board/Marvell/octeontx/Kconfig        | 2 --
 board/Marvell/octeontx2/Kconfig       | 2 --
 board/cadence/xtfpga/Kconfig          | 2 --
 board/cavium/thunderx/Kconfig         | 3 ---
 board/freescale/imxrt1020-evk/Kconfig | 3 ---
 board/freescale/imxrt1050-evk/Kconfig | 3 ---
 board/freescale/imxrt1170-evk/Kconfig | 3 ---
 board/kontron/sl-mx6ul/Kconfig        | 2 --
 board/kontron/sl-mx8mm/Kconfig        | 2 --
 board/sielaff/imx6dl-sielaff/Kconfig  | 2 --
 board/st/stih410-b2260/Kconfig        | 3 ---
 board/st/stm32f429-discovery/Kconfig  | 3 ---
 board/st/stm32f429-evaluation/Kconfig | 3 ---
 board/st/stm32f469-discovery/Kconfig  | 3 ---
 board/st/stm32f746-disco/Kconfig      | 3 ---
 board/st/stm32h743-disco/Kconfig      | 3 ---
 board/st/stm32h743-eval/Kconfig       | 3 ---
 board/st/stm32h750-art-pi/Kconfig     | 3 ---
 board/sysam/amcore/Kconfig            | 3 ---
 25 files changed, 59 deletions(-)

diff --git a/arch/arm/mach-octeontx/Kconfig b/arch/arm/mach-octeontx/Kconfig
index 542f4804760..c2bef89b905 100644
--- a/arch/arm/mach-octeontx/Kconfig
+++ b/arch/arm/mach-octeontx/Kconfig
@@ -13,7 +13,6 @@ config TARGET_OCTEONTX_83XX
 endchoice
 
 config SYS_SOC
-	string
 	default "octeontx"
 
 endif
diff --git a/arch/arm/mach-octeontx2/Kconfig b/arch/arm/mach-octeontx2/Kconfig
index f6158df9086..c6a477be7c0 100644
--- a/arch/arm/mach-octeontx2/Kconfig
+++ b/arch/arm/mach-octeontx2/Kconfig
@@ -13,7 +13,6 @@ config TARGET_OCTEONTX2_96XX
 endchoice
 
 config SYS_SOC
-	string
 	default "octeontx2"
 
 endif
diff --git a/arch/mips/mach-octeon/Kconfig b/arch/mips/mach-octeon/Kconfig
index 624039df253..5d2186bba55 100644
--- a/arch/mips/mach-octeon/Kconfig
+++ b/arch/mips/mach-octeon/Kconfig
@@ -2,7 +2,6 @@ menu "Octeon platforms"
 	depends on ARCH_OCTEON
 
 config SYS_SOC
-	string
 	default "octeon"
 
 config OCTEON_CN7XXX
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 70eebb4bd22..3876c3f7f98 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,7 +2,6 @@ menu "Xtensa architecture"
 	depends on XTENSA
 
 config SYS_ARCH
-	string
 	default "xtensa"
 
 config SYS_CPU
diff --git a/board/Marvell/octeon_ebb7304/Kconfig b/board/Marvell/octeon_ebb7304/Kconfig
index b3244f751b1..c8dd0268f36 100644
--- a/board/Marvell/octeon_ebb7304/Kconfig
+++ b/board/Marvell/octeon_ebb7304/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_OCTEON_EBB7304
 
 config SYS_BOARD
-	string
 	default "octeon_ebb7304"
 
 config SYS_VENDOR
-	string
 	default "Marvell"
 
 config SYS_CONFIG_NAME
diff --git a/board/Marvell/octeon_nic23/Kconfig b/board/Marvell/octeon_nic23/Kconfig
index 468bbb756e6..ad8d5083354 100644
--- a/board/Marvell/octeon_nic23/Kconfig
+++ b/board/Marvell/octeon_nic23/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_OCTEON_NIC23
 
 config SYS_BOARD
-	string
 	default "octeon_nic23"
 
 config SYS_VENDOR
-	string
 	default "Marvell"
 
 config SYS_CONFIG_NAME
diff --git a/board/Marvell/octeontx/Kconfig b/board/Marvell/octeontx/Kconfig
index 45d115916c9..bdedd24b7a8 100644
--- a/board/Marvell/octeontx/Kconfig
+++ b/board/Marvell/octeontx/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_OCTEONTX_81XX || TARGET_OCTEONTX_83XX
 
 config SYS_VENDOR
-	string
 	default	"Marvell"
 
 config SYS_BOARD
-	string
 	default "octeontx"
 
 config SYS_CONFIG_NAME
diff --git a/board/Marvell/octeontx2/Kconfig b/board/Marvell/octeontx2/Kconfig
index 99291d795b5..8664b3e3e50 100644
--- a/board/Marvell/octeontx2/Kconfig
+++ b/board/Marvell/octeontx2/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_OCTEONTX2_95XX || TARGET_OCTEONTX2_96XX
 
 config SYS_VENDOR
-	string
 	default	"Marvell"
 
 config SYS_BOARD
-	string
 	default "octeontx2"
 
 config SYS_CONFIG_NAME
diff --git a/board/cadence/xtfpga/Kconfig b/board/cadence/xtfpga/Kconfig
index a64961e6d6a..9d3a7aa67ac 100644
--- a/board/cadence/xtfpga/Kconfig
+++ b/board/cadence/xtfpga/Kconfig
@@ -17,11 +17,9 @@ config XTFPGA_KC705
 endchoice
 
 config SYS_BOARD
-	string
 	default "xtfpga"
 
 config SYS_VENDOR
-	string
 	default "cadence"
 
 config SYS_CONFIG_NAME
diff --git a/board/cavium/thunderx/Kconfig b/board/cavium/thunderx/Kconfig
index 3d4b260ea29..1add150b45d 100644
--- a/board/cavium/thunderx/Kconfig
+++ b/board/cavium/thunderx/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_THUNDERX_88XX
 
 config SYS_CPU
-	string
 	default "armv8"
 
 config SYS_BOARD
-	string
 	default "thunderx"
 
 config SYS_VENDOR
-	string
 	default "cavium"
 
 config SYS_CONFIG_NAME
diff --git a/board/freescale/imxrt1020-evk/Kconfig b/board/freescale/imxrt1020-evk/Kconfig
index 3cb8fb1e6e9..6618a9b3b57 100644
--- a/board/freescale/imxrt1020-evk/Kconfig
+++ b/board/freescale/imxrt1020-evk/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_IMXRT1020_EVK
 
 config SYS_BOARD
-	string
 	default "imxrt1020-evk"
 
 config SYS_VENDOR
-	string
 	default "freescale"
 
 config SYS_SOC
-	string
 	default "imxrt1020"
 
 config SYS_CONFIG_NAME
diff --git a/board/freescale/imxrt1050-evk/Kconfig b/board/freescale/imxrt1050-evk/Kconfig
index 068130beca9..04ade6ec900 100644
--- a/board/freescale/imxrt1050-evk/Kconfig
+++ b/board/freescale/imxrt1050-evk/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_IMXRT1050_EVK
 
 config SYS_BOARD
-	string
 	default "imxrt1050-evk"
 
 config SYS_VENDOR
-	string
 	default "freescale"
 
 config SYS_SOC
-	string
 	default "imxrt1050"
 
 config SYS_CONFIG_NAME
diff --git a/board/freescale/imxrt1170-evk/Kconfig b/board/freescale/imxrt1170-evk/Kconfig
index b433d6e5df0..ad7cd4aeb9c 100644
--- a/board/freescale/imxrt1170-evk/Kconfig
+++ b/board/freescale/imxrt1170-evk/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_IMXRT1170_EVK
 
 config SYS_BOARD
-	string
 	default "imxrt1170-evk"
 
 config SYS_VENDOR
-	string
 	default "freescale"
 
 config SYS_SOC
-	string
 	default "imxrt1170"
 
 config SYS_CONFIG_NAME
diff --git a/board/kontron/sl-mx6ul/Kconfig b/board/kontron/sl-mx6ul/Kconfig
index 782e099cec2..7a4ffbed289 100644
--- a/board/kontron/sl-mx6ul/Kconfig
+++ b/board/kontron/sl-mx6ul/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_KONTRON_MX6UL
 
 config SYS_BOARD
-	string
 	default "sl-mx6ul"
 
 config SYS_VENDOR
-	string
 	default "kontron"
 
 config SYS_CONFIG_NAME
diff --git a/board/kontron/sl-mx8mm/Kconfig b/board/kontron/sl-mx8mm/Kconfig
index 1cfe9ee64bd..1597bcf894d 100644
--- a/board/kontron/sl-mx8mm/Kconfig
+++ b/board/kontron/sl-mx8mm/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_KONTRON_MX8MM
 
 config SYS_BOARD
-	string
 	default "sl-mx8mm"
 
 config SYS_VENDOR
-	string
 	default "kontron"
 
 config SYS_CONFIG_NAME
diff --git a/board/sielaff/imx6dl-sielaff/Kconfig b/board/sielaff/imx6dl-sielaff/Kconfig
index 7876ab14c07..cad15ac30b5 100644
--- a/board/sielaff/imx6dl-sielaff/Kconfig
+++ b/board/sielaff/imx6dl-sielaff/Kconfig
@@ -1,11 +1,9 @@
 if TARGET_MX6S_SIELAFF
 
 config SYS_BOARD
-	string
 	default "imx6dl-sielaff"
 
 config SYS_VENDOR
-	string
 	default "sielaff"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stih410-b2260/Kconfig b/board/st/stih410-b2260/Kconfig
index 441a83cbaea..2dd7411b8b4 100644
--- a/board/st/stih410-b2260/Kconfig
+++ b/board/st/stih410-b2260/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STIH410_B2260
 
 config SYS_BOARD
-	string
 	default "stih410-b2260"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stih410"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32f429-discovery/Kconfig b/board/st/stm32f429-discovery/Kconfig
index 3c93df20afa..cde6900871a 100644
--- a/board/st/stm32f429-discovery/Kconfig
+++ b/board/st/stm32f429-discovery/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32F429_DISCOVERY
 
 config SYS_BOARD
-	string
 	default "stm32f429-discovery"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32f429-evaluation/Kconfig b/board/st/stm32f429-evaluation/Kconfig
index eaa40db8a74..b168bf8d5db 100644
--- a/board/st/stm32f429-evaluation/Kconfig
+++ b/board/st/stm32f429-evaluation/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32F429_EVALUATION
 
 config SYS_BOARD
-	string
 	default "stm32f429-evaluation"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32f469-discovery/Kconfig b/board/st/stm32f469-discovery/Kconfig
index 622a8d82d81..688523b52af 100644
--- a/board/st/stm32f469-discovery/Kconfig
+++ b/board/st/stm32f469-discovery/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32F469_DISCOVERY
 
 config SYS_BOARD
-	string
 	default "stm32f469-discovery"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32f4"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32f746-disco/Kconfig b/board/st/stm32f746-disco/Kconfig
index 86ace17377c..382b86e5bc9 100644
--- a/board/st/stm32f746-disco/Kconfig
+++ b/board/st/stm32f746-disco/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32F746_DISCO
 
 config SYS_BOARD
-	string
 	default "stm32f746-disco"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32f7"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32h743-disco/Kconfig b/board/st/stm32h743-disco/Kconfig
index bc116bcf32f..0f0f56e1a78 100644
--- a/board/st/stm32h743-disco/Kconfig
+++ b/board/st/stm32h743-disco/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32H743_DISCO
 
 config SYS_BOARD
-	string
 	default "stm32h743-disco"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32h743-eval/Kconfig b/board/st/stm32h743-eval/Kconfig
index ff86de25f7d..0fffa888e70 100644
--- a/board/st/stm32h743-eval/Kconfig
+++ b/board/st/stm32h743-eval/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32H743_EVAL
 
 config SYS_BOARD
-	string
 	default "stm32h743-eval"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
diff --git a/board/st/stm32h750-art-pi/Kconfig b/board/st/stm32h750-art-pi/Kconfig
index ab2d0f227d7..6bd6a13d2a1 100644
--- a/board/st/stm32h750-art-pi/Kconfig
+++ b/board/st/stm32h750-art-pi/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_STM32H750_ART_PI
 
 config SYS_BOARD
-	string
 	default "stm32h750-art-pi"
 
 config SYS_VENDOR
-	string
 	default "st"
 
 config SYS_SOC
-	string
 	default "stm32h7"
 
 config SYS_CONFIG_NAME
diff --git a/board/sysam/amcore/Kconfig b/board/sysam/amcore/Kconfig
index e13ee8f6e90..b5c81dda237 100644
--- a/board/sysam/amcore/Kconfig
+++ b/board/sysam/amcore/Kconfig
@@ -1,15 +1,12 @@
 if TARGET_AMCORE
 
 config SYS_CPU
-        string
         default "mcf530x"
 
 config SYS_BOARD
-        string
         default "amcore"
 
 config SYS_VENDOR
-        string
         default "sysam"
 
 config SYS_CONFIG_NAME
-- 
2.46.0

