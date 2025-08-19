Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D58CA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FCAE809A5;
	Tue, 19 Aug 2025 14:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="AeO0UW3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E420D81FEE; Tue, 19 Aug 2025 12:31:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE71802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtN1hsd2z6hyNgMIIlNoYDy8j8x4unhvqLk/FWLx1SoF8r2Jo8XCHGszB2SOmoovBW++/dHCj6mEEAbSFF5op/oFA2qrx6zZmY9PA3OhS/3hnhkewdGByaBKfVA9NJRtxj2+GCLqa19tCRuo8Jdn7FGzt7TiVXVLlhaHg3208YnAbk7r3XBxhTmsQ4854kHXQ1nwoowgNiOp3py8WRQlCWJrG9rELpqodXVzAi62M6iH02rzhf8agCMRrwdSPBjH3AXPtt8ImRUvCyL4qPgkpYrqrS7sdFOF932Pa9lKGkxPS+AtiQ9rzZVXwzjPC9ufC/1URhVeJhwsTGOG12rTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdFEnDMURguy4E6AdEVxCp8OABUG8pQ3TOiW244J84g=;
 b=g6RvdhOe09ZjEus4h+UHLetqblRXX8s7iYplWCSJXJZgUk2yddzK/+ufdb4JKBkhrNnxUoinnSQKHBC+KdfX8daUwu/fByhdLwGI7FGN8J6Sd9f2i6mA68nlbGB9DkQE8NpateocbV4agNSHPPh5nPqTp+jDiyNp2Taw6YPaApdzdqUtCn17FHlPkusbDedihxHIDCy05tpb4YkbbiF4gF+8nC4WFnAn6BBuME9iGorNwOzeKeR3IcOE4QNZ0Iq4J2U4i1qnkbpUEdlyXHV+hBx5F2zb5p91wSRNtuUAXrZtEtntCJN58mUdR3RzS1qaDJDFesEXvZvNg5LVYN/+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdFEnDMURguy4E6AdEVxCp8OABUG8pQ3TOiW244J84g=;
 b=AeO0UW3tr3ew2HtZVQM+hPW6v41y87/NjdMA56rDX30bJm0LEIW3B9uUyuhxTAPLMNTrd1kCb6ysgH21rroyjKyXw/qPdbKGIWagpKA6TBaoAMNeug/bGU/xUTEuoD2yIe+NHKEpxR3ix7n4wPe4tNcJp1rm7RfkrQRlBVCM9iAIn7ZbKdx1y+ZEshlV8GVAhNLn+p290SFx9JCQObYfwsemke9MKoQxTeXQIl+wH0837qZYbsQF0cHcsA+y0zqodgIxWwbJYIZwA5Syslu5bZfWlLtby+RcUGS8y8DWrPz/+g6YKskgSOnCeNHGIMZQAU6/qSoqrapjRwMKd9Dwlw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:31:16 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:31:16 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v4 00/10] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcEPRkpWLpVBAirEyx7IeqUIb+VQ==
Date: Tue, 19 Aug 2025 10:31:15 +0000
Message-ID: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM0PR09MB4321:EE_
x-ms-office365-filtering-correlation-id: 00b5bcb2-6bc9-4b0e-728f-08dddf0b8712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OodCm8H54aVirx/EKE13IYAyfa986pmtdHiphE3gDgd2cNP5IQdBACg+7S?=
 =?iso-8859-1?Q?BsG3ARaDCutd1qO5CWUZ/hrCfBhDG6bJcxa/lz7rHgOjp+tVDbV4+oQbaq?=
 =?iso-8859-1?Q?bW0i8f6nBnfSKfIOERLX839KRTo6mVpHqdYQGDTUsAFUHHZNKgGhbI/qII?=
 =?iso-8859-1?Q?HzMKUoT8Ft5XDD9Nn+OgHWH9G8VWXrM77Fipj32zO8ijBp2qF6D+Uu4tcH?=
 =?iso-8859-1?Q?BZKRV4alRUJZHOEbx04frdqoMUnDbeg+E4aYRTRV/YfiC8Ezh9+GFi2dhR?=
 =?iso-8859-1?Q?SJ8qG3ZbuUn+GVm/O8DrBpVhSMt/ivUZqD8JUdLpSfhWGB+dskm9yGih4b?=
 =?iso-8859-1?Q?unFs59SxktEoxhFZ0ONHDkGmytFECe6+K4qbUKfTyccziI/HSXnn5DHKdo?=
 =?iso-8859-1?Q?GPRMp33pXBj7bme1t0J+apsT+MQvdWKjFqkpKRj2qYAWeaEaw9k6WodNWI?=
 =?iso-8859-1?Q?5T4G9kKm8cDDAThbuz/qW+vqPKvHavOoENdA5aCihsXTZvc2tj1b53VkK7?=
 =?iso-8859-1?Q?mQVCDIrzJii1za1INcMesHI7jQfFiTYzKhOcg5SIGgU+JvaeCYA2hZG/v5?=
 =?iso-8859-1?Q?6tjR9OqWF4G7LBnKRjABOJKqF4TAMVhdN00jznXSd5v03pO8cuzRx0r/vj?=
 =?iso-8859-1?Q?8bANLJZw399NVkPmbQBTp3FL/5dYiZ44huUvymMj9aPmZYbUJNZ8i9jxxM?=
 =?iso-8859-1?Q?98JtRbntib2Xh3Kn8h/ZtLrlZ4o5xqWg1Dc2DM+lNK0vpe9RM8UIYESsZ3?=
 =?iso-8859-1?Q?ZgnQBwRwErmvqRlPIW4PpJ7KLX21du49oxVtPYHwboRZDGYd0Ho7t2c5pa?=
 =?iso-8859-1?Q?67B0BxPf+MxKQHDBn2Kluf0fh97SowehuOhf2vm3zgGrQAPyClnC8wXQQb?=
 =?iso-8859-1?Q?pQI3jLx9DMDFHRdbE+SN6UPZXMG2j7riPAHsj8uTe9WfBFFEteasZbK2SK?=
 =?iso-8859-1?Q?JB8MBJZPD8SJRminyWOyyJDfvV+CF3lKUSJ/xbY5rbeIDZGNOn51Cu9zWy?=
 =?iso-8859-1?Q?fa0c1L24Ys6Oe8NERjZG5q+f/rv3lQbOjB/BTMWevmfF9OJZvj+lorpgcw?=
 =?iso-8859-1?Q?dTK2mDdoPUBaeZBG9DD3n2cc8YRV7Iq5iD+5HfkGQtXZsKZOrnQsdyFqt6?=
 =?iso-8859-1?Q?ksQfCcm7nPNV7QJ0YPXpB46OYwBqprv4vxHjTDtA74QUb0qIBwUGc24AgT?=
 =?iso-8859-1?Q?l0A9ieorHBs5ic6O3e2bLTO6vLER2YEHvFjsgULt3kJcryCrZp9M5aK2UK?=
 =?iso-8859-1?Q?Zdqzjnq7qz1gs42I7QRdAkn8Jg37++QdqXrX5vy0Old1gqiHH/+GflEhlp?=
 =?iso-8859-1?Q?o26S+WeW2pqGkh3verjUnNM1B4K06QBdOUjFtrQFCeRT3uTFvuH4I5ll2S?=
 =?iso-8859-1?Q?qJ+i/LfCNRWVd23YgZljPPXBA8HYdPisJlYbF4bqqlV1XSfTRMw2JGVNe0?=
 =?iso-8859-1?Q?249vipveNeYYkyJIBO+hwMvyTIcFH8pg2dwqvTRL4Pf4ncbNpkChd72zaR?=
 =?iso-8859-1?Q?7zROG57m3NDBzBdO3Q5n+0b8WxvdBV1FAxOuykpc9o74egTlUWVHWnhTZC?=
 =?iso-8859-1?Q?54M4kOk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F4l2PResPGStW9KAlyyvkRa1GBzFlJ8X9i9kg8elQwJ+hsQKbt9V3vKFzD?=
 =?iso-8859-1?Q?UAzyr82LHCatlc9BLFOpMA4grhNlltfv8yiu/jZgfOsy2dJibJAalMThyD?=
 =?iso-8859-1?Q?U7gQAFnh21SvKjMdSfY9wFThzCd29UhCyw9TsJLRwBieSdfGNvOAMC6/rB?=
 =?iso-8859-1?Q?mEkvqmaoV6zCzSjCVgkO4nxOBo7D7G3BcdfAGlFwJKI8DRCyut3886WCtU?=
 =?iso-8859-1?Q?N4rJHjBGq/ayhPrRtqeVVzLvnPyzJ4SfAISry/R8Gg1mxviF1dnoVpAgqy?=
 =?iso-8859-1?Q?bH20R01mX1X9tDVKJcRJtfowS6uK33BEbLDvCiyr6rtfKEj6/RLMayzkKl?=
 =?iso-8859-1?Q?1uGFAh++nZqBngCPNhMm+CKGGVj/bcnRw4P/1leOkBkW57/1DAGmbeoV/V?=
 =?iso-8859-1?Q?5OwsbTlKoGQ7rDQ07YZt5znXcPBHGblJd4AGN2dTwjRAjJffnx/C40ggTJ?=
 =?iso-8859-1?Q?w+27UUM+45NetZUDUEJZjjQ/PmjXNl1/h7QQnV87mTRVeZYzke3USfbOAE?=
 =?iso-8859-1?Q?z4qYYOyMZIA7p4xaFp2XfKQQ2oeg608h8RiPgBEFyJQDVoSoIBW1ZA5May?=
 =?iso-8859-1?Q?Y+Ftgz6C93CBy5n5QCRh+pIFknfMnDZ/yFTI+RXN0x4/5nmjz35VOu/23l?=
 =?iso-8859-1?Q?ML/KnTjYGsIHLS+gH1bgrASvEumKQIpD99xXHvBuQXuYIILEOYacd5lb5J?=
 =?iso-8859-1?Q?/EqAAGsKl5E+8UohD4fziMeeBcM8IDt0AazfN6FzGb4A5g9VD11fXroRg3?=
 =?iso-8859-1?Q?pUyBQeZ8YyWzsPyXYj8XCHBGEcQQp9cqbHy7R/A8RQe2Fp9fyELsLDD4VX?=
 =?iso-8859-1?Q?MW9J07PNS9l2beWh292vlVCYkEf3lYAmuR7GLRkpbbLkrg6tFmZSRIy8aV?=
 =?iso-8859-1?Q?yLF1+ciYhWGiw6+QgzdG2iO7fMwpUfN3VEo3n1RkUA5nk+jeWp+KnG7G+k?=
 =?iso-8859-1?Q?AYrTkQTA3s19Xti0GCGg+t6WnPZo5DRxhc3KOrnaJUKLr1eclkapIJzAwH?=
 =?iso-8859-1?Q?phy+T/fsU03hiYPtEuagOT3qxhlUBl4NuO0Lax4diab5oq9NFnE21WPosw?=
 =?iso-8859-1?Q?POBeLh8Baf7LjsAYLGSGvYRsCBj5HvueqOSZ6vISknrYQw7jJ59eXJO4cF?=
 =?iso-8859-1?Q?cVfPjP5JUkHuB8eBPAEJzUiuEGAOycMtJe07gX1al/31w3RoF8HQnisW5f?=
 =?iso-8859-1?Q?uDZOuoOBnTpFIQEXOYn965LZalCkSLU+3xABz5UJzuYFKEuBCOaAupD1GW?=
 =?iso-8859-1?Q?37FrCgxHWqzaWOtgQ93XnjcYWyZGVskabd6WonCs5rizVpxZoSAfKZzRxX?=
 =?iso-8859-1?Q?9XQfz0IZg7/mc7vKqp3yLbooXXrTTIR58xjHB5vh8tG8ZxwyqtcHknd88D?=
 =?iso-8859-1?Q?8bvHdFEmD0z8uPoDcysmQ/OSI8DS0YwsulsyZQ8G/QER+B9ss0z88Zcwce?=
 =?iso-8859-1?Q?pva2niQMWlkgZ/faoWz1sXXt8Qot4ZIEQK19ZgfH0CU4rYdZG+LcVAhPYo?=
 =?iso-8859-1?Q?dxD8NM6KBMurkwu6Ewy3367GEEhA/2fkYgYcvt/ppH8radrK/qnsE8yn1G?=
 =?iso-8859-1?Q?gLERushQ+P42a6SaEz+2z3s4XOH/KPPDj7HEHwi+OiaXxpDdn/1QTYRgVZ?=
 =?iso-8859-1?Q?hybz3ndNgC6CdDQ8mwRRO4hUe5TofzQf8yxB56ybzdUI9pbNj6T5keig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b5bcb2-6bc9-4b0e-728f-08dddf0b8712
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:31:15.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xF2iPXqbtdgyYMWuyLBNfVVurolsqqN+yW5MV8ZzIFf3JN1kSWJj6gU07MJHZKNCqjNs4eyu26Z054TDNJzGuAfSDpKcMlnVtZi44r7Te8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4321
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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

----
Changes in v4:
- 02/10 - Use riscv_aclint_timer and update CPU timer settings
- 03/10 - Fixed inconsistent empty line usage in gpio-eg20t driver
- 08/10 - Replaced inline assembly accessors with generic macros
- Dropped AMO instructions emulation patch
- Dropped P8700-specific timer patch

Changes in v3:
- 01/12 - Split original patch into CPU/Board parts
- 02/12 - New patch: extracted board-specific logic from original 01/12
- 01/12 - Relocated object rule for p8700 into p8700-specific Makefile
- 01/12 - Explained .word usage for mcache instruction and replaced it
          with symbolic macro
- 01/12 - Replaced inline assembly lw instruction with readl()
- 01/12 - Removed p8700 code from start.S, moved to harts_early_init()
- 02/12 - Fixed operand spacing in assembly
- 02/12 - Replaced hardcoded address with properly macros
- 02/12 - Switched from riscv,isa to riscv,isa-extensions
- 02/12 - Sorted DT properties properly
=20
Changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----

Chao-ying Fu (10):
  riscv: Add initial support for P8700 SoC
  board: boston-riscv: Add initial support for P8700 Boston board
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add support for MIPS GIC syscon on RISC-V SoCs
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  libfdt: Allow non-64b aligned memreserve entries
  riscv: p8700: Add Coherence Manager (CM) and IOCU support
  riscv: boston: Add support for LED character display command
  cmd: riscv: Add 'startharts' command to start multiple harts

 arch/riscv/Kconfig                          |  22 ++
 arch/riscv/cpu/p8700/Kconfig                |  14 ++
 arch/riscv/cpu/p8700/Makefile               |  11 +
 arch/riscv/cpu/p8700/cache.c                | 103 ++++++++
 arch/riscv/cpu/p8700/cm-iocu.c              |  75 ++++++
 arch/riscv/cpu/p8700/cm.c                   |  92 +++++++
 arch/riscv/cpu/p8700/cpu.c                  |  13 +
 arch/riscv/cpu/p8700/dram.c                 |  37 +++
 arch/riscv/cpu/p8700/p8700_platform_setup.S | 169 +++++++++++++
 arch/riscv/dts/Makefile                     |   1 +
 arch/riscv/dts/boston-p8700.dts             | 263 ++++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h      |  61 +++++
 arch/riscv/include/asm/arch-p8700/p8700.h   | 144 +++++++++++
 arch/riscv/include/asm/global_data.h        |   2 +
 arch/riscv/lib/Makefile                     |   1 +
 arch/riscv/lib/mips_gic.c                   |  47 ++++
 board/mips/boston-riscv/Kconfig             |  51 ++++
 board/mips/boston-riscv/MAINTAINERS         |  15 ++
 board/mips/boston-riscv/Makefile            |  10 +
 board/mips/boston-riscv/boston-lcd.h        |  20 ++
 board/mips/boston-riscv/boston-regs.h       |  38 +++
 board/mips/boston-riscv/boston-riscv.c      |   9 +
 board/mips/boston-riscv/checkboard.c        |  43 ++++
 board/mips/boston-riscv/config.mk           |  15 ++
 board/mips/boston-riscv/display.c           |  33 +++
 board/mips/boston-riscv/iocu.c              | 104 ++++++++
 board/mips/boston-riscv/lowlevel_init.S     |  20 ++
 board/mips/boston-riscv/reset.c             |  15 ++
 cmd/Kconfig                                 |  14 ++
 cmd/Makefile                                |   2 +
 cmd/display.c                               |  51 ++++
 cmd/start_harts.c                           | 103 ++++++++
 configs/boston-p8700_defconfig              |  95 +++++++
 doc/README.LED_display                      |  26 ++
 drivers/clk/Kconfig                         |   2 +-
 drivers/gpio/Kconfig                        |   7 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/eg20t-gpio.c                   | 140 +++++++++++
 drivers/net/pch_gbe.c                       |  37 ++-
 drivers/net/pch_gbe.h                       |   1 +
 drivers/pci/pcie_xilinx.c                   |   9 +
 include/asm-generic/global_data.h           |   5 +
 include/configs/boston-riscv.h              |  11 +
 include/led-display.h                       |  33 +++
 net/eth-uclass.c                            |   2 +
 scripts/dtc/libfdt/fdt_ro.c                 |  11 +-
 46 files changed, 1972 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/p8700_platform_setup.S
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 cmd/display.c
 create mode 100644 cmd/start_harts.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 doc/README.LED_display
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h
 create mode 100644 include/led-display.h

--=20
2.34.1
