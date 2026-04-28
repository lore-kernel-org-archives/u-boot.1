Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7CEFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 03:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4641484348;
	Tue, 28 Apr 2026 05:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SMMp8xzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2F88439F; Tue, 28 Apr 2026 05:32:42 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B4E184277
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 05:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yI+m7cRYeyKq9fB/ldptPM4KTnZSEHTWutiZ0/eOenyNbhtZwqsv2PBE78VdpXmOFXgl55US+o9JsyG47em0XTyadLY65KTlhmXaXYvYYx5XwluM1Onnb3syZkCG48KZoBNRCKADQeo62dqzO4JC9zs/eXHAg8dV0Jpg/haUBhM81MBY/7q7qTB6WR4VOLFW5dHuo50AOmR5biX8+M2EBwInnwBBJ25j3bMV3nWJZ2Ffa4z2Z1oUa9/6ENJVkChUXJZ8YM4zlz1dOuVxAYZlCelGBflPZUdIVItQsQcfWrShVkC3dw4hz+11+hGkSv9qrld4FhQDRJU4RcdOmjVSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xSkKETGpZbQi4ME3Wl59FI+hqUA82Cu5/cYRyXLFIs=;
 b=KvCdMcNXtsCSWdhYrkVZKke/4JG3bCJi+oGeYxM0BfLUfjfI1cfb6NJCXcd+XDTd0QbYglKWXyjYrnK25tDxWduen1B6tpWJLDDPdW19P2LO4ijFE3oslcalzvQv9AVX9qjmlvmO7QtkTOwM27VYoMWElEtWM11bO59sFalWTT18oPS6BrbCllcX3JgbfFJ3p7k2olRdkiQpqXm3x0UGsabW2J/KkcVlyP7WacGxRpAcK4CZP4LmuuwdOiuaVuK8V6sF8XZ4vY6PCPPcWcpW+aJdWE1Mkdl2fPCSdLihqZ94ltk3LoqvlVBU/TyhdyKfLMbM+Cu/dDr2WxeLDgR75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xSkKETGpZbQi4ME3Wl59FI+hqUA82Cu5/cYRyXLFIs=;
 b=SMMp8xzzxkT53O+dVxY3wmfeutxU4h2G+IJFlvBhMcNh5FTDF25C9Ta4u8jXr/2BXOar7irC83wKKfuH97x/PN7fNzL5WD+1/0QQcgSyL0jvOlX8FH6di1WITOU9ZV7D2YSv5h76bmg2TLIapiVQTappz33wmbXQ5aZeDfVHduHOLhnu8BeoV2BImXUzmM639Rcl925Az141NptFcfiKI0L9wtpaKdERiaxMcBJzhWd6Vrgdm/C1EHftOUwHanJNJ/wO4UtCK0ic0oSUL6xpNuJf+tsHAAt75JuZB++ZuYfumIArQRGeCEOuf86cITg1aJbRyAEy4CYrFs4j8iiM9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BN9PR03MB5996.namprd03.prod.outlook.com (2603:10b6:408:135::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.36; Tue, 28 Apr
 2026 03:32:36 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.021; Tue, 28 Apr 2026
 03:32:36 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in U-Boot
Date: Mon, 27 Apr 2026 20:32:27 -0700
Message-ID: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BN9PR03MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9c6d15-f42a-40c8-bb36-08dea4d6ca91
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 4PTzqfRfdVsDArJc2GFemOdnSlD5UwhIA4J1EUhOiOZHRcVr9oF/LIzC0wbH7RiwOsKxQXc7aKoeUh89L+IKOCZDkcKTvKBS4cBNZk6uV9j6HbYYcCbIf6mg806/ygDAS4z0mGbH2OYr4jQIrzVMqLqsquo2KlcdrAtb/nxreYvQM1jh7kkhC1XKWQ8ebWpE2+NGapGC2sc3Jf/Ig7oYkbhnh9wlPKmOr01J7mqFcOKituwstjPRGYrw7J7LSxUHFMxjhJJftEUj9fFymvIZL3i4HyJPdUDUc8Zv2qM5wgjfPZNc/E1xszGCEN5DxgjRYCLHKOr1mJJAfis1NqUm2zeyTRs2VCdrH19eqwzVYnHwNIUrm/RRlMP/ofm8sYZIcm0C2Np73OvsHwmLxUJOiLaNDw6AGI6T7orngSAKhW1KMXt06d5PCDKmJTLo8eFHn3AMI6gm84DRxPcRkcbj0w7WU1K+9DFIVsc5a6WG947xSugdiXGNb8Qzw9NEXqWwOgzRSNC/0PUYtgHykGE7spB3luiYvyICblCq3D9tMJgry/s+hwONyZ4BOtVP/A8f9ghuVV1Koh/IyuFdw+PFYei+8UYmiE4rnzEjdY/yGgx3bTHe+WAPETfa//kfjd6VSl9b51d4fWoJUrFa9pG7PkKzikb1ojYHF/i8V0gRT6hPbO0J/EmjSh2LgWDJ65uHZG276kMSbBUW4a4zHdwaRXocB7zJexdjDm1mXGDZXJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ixd63Ltj/lyJ6/f1vs5elTrwe3CEaA3tAr2cFROtJEr5ms/mbDyoftKzEhIJ?=
 =?us-ascii?Q?fGGmg7+zl1fFlaT/BSTYOFs/LQ5ZWgzrt4qyykzh/r53x4OrLgEtlEtDjanA?=
 =?us-ascii?Q?umqdtXwcolTIzqqDu3+vjnpjl5DIleS7I1vJv04jbUJKsTtiz6pVewrbjp5G?=
 =?us-ascii?Q?NZXgXxgTSCP+EOTugQpRA/EP6mJcKeZf7DMT6a2YC8J9zfkHqfxTFfXnN5aX?=
 =?us-ascii?Q?znZ0Ypw7GDxx5TYOix3JTfmrTlvYZyLp0LutnABW1VC+5g4KxhY9fR50sfjT?=
 =?us-ascii?Q?vHwFQ0qbIrUxVIElFwfjiV6Oe33pQCOYcqx83DX7JcPT0eLX2mET2p83KMr/?=
 =?us-ascii?Q?zK6mjNVvl+KbC28XIAUfGKTxgh0r7jBGdQ1NRar8IhGoVBJJY5QQFco4owLf?=
 =?us-ascii?Q?mNuaXyGkfqsIitF0t3flpBzrtQmxR4Guh7rutHdyLhYdPmQKO3oXDruhlnQ+?=
 =?us-ascii?Q?qSWl4k5M4pD17juBFJLve/RM6RkwvFzkG25GWgSAeLAxeTejG0ReR6THSF9x?=
 =?us-ascii?Q?NOcB8a50W1OAEunufXntypGu6xXSt+hEzYNZRdnmRrv7vXYMSfyxPPa3u1x4?=
 =?us-ascii?Q?hu7MLonNqwcp5MLjU3u9P17YSEgSHcoVAVsW/HUlL18z5dazIn7pNKYd7QO4?=
 =?us-ascii?Q?UTaAauEzszg5ASC3yLiSg7AUH3+g5VeUuzlzcHsnG42SXN8rh9hcYNLcBJs2?=
 =?us-ascii?Q?SX8Ars0HQHEgpJIFxIPj9sCEIaRANYUuhI1DfcCsUzlfVXza/LSS4Xy9No+k?=
 =?us-ascii?Q?aobN3HCcxpe0sOMnNCRqRRpPSAzm87h4/mz605WwzvvnHFt19sS6SdmWspXY?=
 =?us-ascii?Q?MkLrHdfUvcWginlGtImW9/6r1M0pKx09CBwadUS9qxogmiVtAzLAYYG6/SG0?=
 =?us-ascii?Q?WT6R8/SizwjL55W02LxLak4ZqT2Tq9lAqvulNvRsvZ+nv/qF0s6USMgIl8X7?=
 =?us-ascii?Q?5uQrsn5+4a+iIfxL1VEqVOU9JQ8Qb+4bPnwOXfCF9H3JWD6c9X9DDEFAXNR1?=
 =?us-ascii?Q?IitZOgHDiwuO4MBERcqiaPegtsW/KteAXgaFf2xCgBN0fxqjlUPcR8ZJSVCV?=
 =?us-ascii?Q?swu8wnz5bE+o4/7sG6IgLloszis5pztEK867eKbs6wxOybLO4wVkYTUGWreH?=
 =?us-ascii?Q?A0oL/fk1UiIX5y5flqpDHoa3wfMjiAFwQWK02a+MYZnOuUOnyHj/tzCE/7Oq?=
 =?us-ascii?Q?FrhKUOIwu1occ0/oX/Yv+ikH29JsO907NyQhVARQ+q8fYoRmCOrmviP7VjBD?=
 =?us-ascii?Q?tN1mxyhsmei/X4xRl74aVr3W++CY7CNv3VCcQxNTlXsWZyvH3D5HJ1gLEzL/?=
 =?us-ascii?Q?8Iq113YH2wPcSodAZKYy0iMpeoctqN7ncliDzqgwrRKLuvNkf3ncq5M8WH7Y?=
 =?us-ascii?Q?7GQu4qeAFPURGOumD6tyq5FjLOEIWFDi2eVfstnscuO7CDWnNMOL1vYH6jdN?=
 =?us-ascii?Q?oRKzYk6Cxj+LK3yuWfHartDxroBDDOufXnLfBU8DbMJYLOOxZyY9wWfRsk0M?=
 =?us-ascii?Q?iJ8E+tzVsIfSVnvesarSxKjy/HAfJ30F0UkZHZGoURBmvIa9yOUqMOgev/3f?=
 =?us-ascii?Q?n0rizUa6v7QjaWvAX+e4gg5l5tcW51Fuv6NREQDbZfE822E4q60Q4+pEhvCz?=
 =?us-ascii?Q?uzyN5mEUM780XMj6ZPcdtlbpmL9y90fJKX5ktkFZyjiO2kBYv1Z70Cjw04G+?=
 =?us-ascii?Q?YE+LYr67Ogh67Gd7aizpjFSjCMp+0eHjpZwr+popafnoAfAiHfy/Nvf6HE8e?=
 =?us-ascii?Q?mOC/yLxo45OS5qZjo8GxOgBJNFiQWNU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9c6d15-f42a-40c8-bb36-08dea4d6ca91
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:32:36.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLwBBKcAmnbhg28acaA97tJIajH2h+IJ7C/DuoBYAGNvMqDRfisY/e5GWl/cL5FZjVmTAWgXrc6X9DKTFXXmP5VpWiPocffxv9z/6vwYH9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB5996
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
        1. Update MMU/dcache setup across Gen5/Arria10 using common driver
        2. Add ECC scrubbing support for Gen5/Arria10
        3. Add DRAM size checking for Gen5/Arria10

This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
Tested on Arria10 devkit with RAM boot as well

v1->v2:
--------
- ECC scrubbing, Gen5 DRAM size checking, and shared dram_bank_mmu_setup() is set as optional via Kconfig and
  defaulted on only for the reference Arria10/CycloneV boards to avoid SPL overflows on size-limited Gen5
  defconfigs.

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com/

Alif Zakuan Yuslaimi (3):
  arm: socfpga: Consolidate dram_bank_mmu_setup()
  ddr: altera: gen5: Add DRAM size checking
  ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10

 arch/arm/mach-socfpga/Kconfig        | 21 +++++++
 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
 arch/arm/mach-socfpga/spl_a10.c      |  4 ++
 arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
 drivers/ddr/altera/Makefile          |  4 +-
 drivers/ddr/altera/sdram_arria10.c   | 34 +++++------
 drivers/ddr/altera/sdram_gen5.c      | 64 ++++++++++++++++++++-
 drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h     | 15 +++++
 10 files changed, 252 insertions(+), 49 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.43.7

