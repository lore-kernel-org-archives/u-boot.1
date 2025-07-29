Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB94C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60272831C6;
	Wed, 30 Jul 2025 07:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="BhJSXHz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE77283045; Tue, 29 Jul 2025 18:21:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE51582BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3sB2TdVdQlSrv7kcNkFI/OlYxF911djIpuuumYiOELe7sL6nNL4f/224Uofi7UyO/JWatqju2vvMKQK1IuxW/50R9CKzvPPeEBqJ0R+OXmd6fGh9o6ojq5vCqU+2zEzu1kwKiLbjA2A2wVoy5bNmfhXj/aFIKN1l2xXxp2rORQWVLZtoY0zObdwuRItveqTaKJaRjLbW948GkrgeUvuPaWTfxInog9eihINYWWX6po2Ws4MYLKLNgIyC4I09ujvd8w3ytgQuDbc/yeY1G60zatQMf7RU2TD2Mm4DLvVVbjghmlhqCK8aggCs3FbN+DcOgn5YKQeq9cPVLODWZTz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nweui5HZb0T8MQ9qTB/Kd29Mz2eyxuY8T5LC7F5B9TU=;
 b=n0qhG6feUoDS06grS1eELEV/H45Y7BxIV0HQingQxJu1uysO4Fad/rmwcbf6Zh3JqJo87+O9OWw/vUVtAOMENnSALT9ThGgBVcBfMjD1928qJnMerqMY2Ne54owyoP+YnYXMw96KeIAYNWYoygexGUh5SijWvXpAkPbRK95+0npPhvO1PFCVWTMFpwHsaYP/8c90+VG16bWdAIyvc4wJ++yTY64OCCnhv7hVVOq69akg3nwZyvkQEsd8o1G/erFG0GaTuigLIWPeOJpzwkFdaYumGIVm+kgSFXTOx6sVaRI27/CQCCkbBPHJmh6fZD/IvxujQULoO5DeZZDGSnBtCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nweui5HZb0T8MQ9qTB/Kd29Mz2eyxuY8T5LC7F5B9TU=;
 b=BhJSXHz6dTT5m5ADs9DaunSsPvHPZvG/8hAxSgRlUXUa4Pa8z4SOKahbQiDjdssGtbQHQ9H9lQ+4/3YTwxPjp+vbgT53QPIRvfYPvdpP6oHDBSY8MUucu0OAz56qSgLLZK5wtLCob+9prdpBuw+Oq5z4TyhGH0cmKYRerD/y9J/xTTOD8aJjBSHphOISd2beeEgk3VdksOYkC8qC4Zk/nPKWzi5BHb2+JZp5KWYI4GbfNDt5CowQrsR/sn2c3QXCsW9QWSlLrbdydzvd1hqKE318yod6WYY4eE+rkYw9cH6lHRwyKAdDejkbdNVP8UHZC7Eb7x6DHQ1Cjb/cesxvQA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM7PR09MB4021.eurprd09.prod.outlook.com (2603:10a6:20b:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:21:18 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:21:18 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v3 00/12] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v3 00/12] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcAKTQ9/YfzQOFMECS9muHsfmN6A==
Date: Tue, 29 Jul 2025 16:21:18 +0000
Message-ID: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM7PR09MB4021:EE_
x-ms-office365-filtering-correlation-id: f09a20e2-fe9e-4c32-5ff3-08ddcebbf2c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bv6OMxqSFqldDIimT7XShMp3HgtclvCCGyTw7ATj+OTDN2TBI1m/ixKHA6?=
 =?iso-8859-1?Q?TCMlSF9AcHe++1dqh3gBI33FQUNRLaxqLuoCpeD+sBtOM3TMw3MNZ2WID/?=
 =?iso-8859-1?Q?0PPm7eovF5eGftW9q1/ZOKTJL5r9dR8ECVVwf1Nt+3z9+0o7xXpcuMnUqF?=
 =?iso-8859-1?Q?eFfLt/clFsgGfZvM4Os58mjTM3PfPWeRWmsEzp2U6kJSY8Bz8Mf7MoXwd1?=
 =?iso-8859-1?Q?4mRWQP4kTz0toJkVXZHoBryPTLPz/XLN1cyIfVzxfuUGr5f4W7XYAtjs+Z?=
 =?iso-8859-1?Q?cV6FAuP55Ezn1d+mUOmOwM5+KtKoGSufIBQJHPIEC1yY7s8urd4PuJmRLV?=
 =?iso-8859-1?Q?b4OViMMwySU4DZzoccNyf14r0JJUhP7GBC7tR17GftbX2ipLBVfhuLZzEf?=
 =?iso-8859-1?Q?jQ4EnxeyRQE4Ymuh+W7Qo9x6FBUQCo0/bGy+lLKDZtN2lXXlqmKcKncO2M?=
 =?iso-8859-1?Q?lKm7O5NQtlVAamK2IM27K1rVaTsuERs6Dmd7QLD7bY9Blz6R/fuILyyfMH?=
 =?iso-8859-1?Q?flibb5Al7mS1Ufzw/EzeugMDiPan/cZ8kUFxvfI5BQ6j7is50//WPB8Qjh?=
 =?iso-8859-1?Q?WkJbKL5hKQv++348L7dJLiufOWzd9nNjreelPNPS2+xbVKBbgir6sgCKB9?=
 =?iso-8859-1?Q?PYZ3kBoY5+OvtcIn39nLQaVpInig38Cbo7HuKhWdmNc7deDEdWi4dGAEox?=
 =?iso-8859-1?Q?SxCaYc3/AwftkIR9fKjkRcKEOC+wT+R3lmvO+x4Pcj1M/QjCw85HlX9RfZ?=
 =?iso-8859-1?Q?4R1J3jcRpGOO9IQLcuF6KZ+jhdNpkcp8dUrgW/2XVsyM9bszdGxN8HSlS0?=
 =?iso-8859-1?Q?LeiopmsDj9rvjM0uQeFIcqCl0Ti8vJFzEigXIQKR+ApZmv7RIYK1vEHEyA?=
 =?iso-8859-1?Q?z3l7bNWIb2yvPT16b/np8TuZ4y3proUvzn2LUhFshBQWU1YC786sxoTTCC?=
 =?iso-8859-1?Q?dVafcPgUiVplzE8eTTKEhfdHskuPlzhecZs3ijb4IkyzjxQz4R04aWXTCS?=
 =?iso-8859-1?Q?ZEek9CF/b1QkXa9ojJhRzDc+MseynHIv+4oivzi/+QI2uLt8+MxXCHFDYY?=
 =?iso-8859-1?Q?lcycqjMjpzQXPnfTNXz/ZNfmcwPT860Y7Fnq1zwrWbl9TYdm8P1W8/nO61?=
 =?iso-8859-1?Q?V/RNJctt20TdB4wrVivsmzHOZ2nnZa3L2cfFk34AV73/il3mQDTdEIxJmy?=
 =?iso-8859-1?Q?JVdd8otF3RvghwsbWkkUxYrnoXAp3uxl6G8qoc7nBNJkCWa8BEnErGA4//?=
 =?iso-8859-1?Q?fjeQPsT6t8HbNoZe1taeqpuwAi2c+m6OKxkTShIzDO6WdidaBkN5qVoKD5?=
 =?iso-8859-1?Q?2g1Lw5nFIgTUjtK19VdLZt6hZEUJNDEwueBaRuxngHDD4hbdM7XG6SJGAR?=
 =?iso-8859-1?Q?ZhFAnh6sjSA2DBsRThqRQmUIQ6qempx2yT3SkIehH3VmphuMM5YXkMDY6y?=
 =?iso-8859-1?Q?YoRxbb/Gl4wDtVa1x5RVCelBwN4apfpbgAnb3+v3o7KebbzM+gdXBq4tSV?=
 =?iso-8859-1?Q?VTKhYf2g1sCUVNTsoTZW0987PtnX80BpGNNUN0CtLxqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?97sNkJ08mJWotgHtAy/1Xj3TPX2x3olZ3zxjxT4WYkreDogakom2au9EBh?=
 =?iso-8859-1?Q?G5DVS6EvDb+wtqWQC8R/rCbkHhYcTBrFMDOkEJ/h/AGL0KXUyWiaXfXABk?=
 =?iso-8859-1?Q?eMnBMt2B6i/W5dcd4HoS5HgGIzyji+Zs2QL+i8OHYNvUY2qT4HiKSWhcn0?=
 =?iso-8859-1?Q?UrdRzAQQ+h4uExZjbeAgXtk/PkSt90kVJOn2jhGu85i6UZdNP9cuYW+j3T?=
 =?iso-8859-1?Q?lqweS+lOMrtNV/FK8IJXoxP5q3c06ZpeMYOkGhnIemQorlh1IerZXifsas?=
 =?iso-8859-1?Q?fnXov8gw5LX+j0iEYsTaoyKwlzPpw6ullcvkhY94dhiz5cTqy0BIW/SBQQ?=
 =?iso-8859-1?Q?NRTbFLvlHPXg75CF6Ih5p0P/wto9nvqmD6o6rFGYboTAjjT4lsESm0hl7r?=
 =?iso-8859-1?Q?JUimx5JM/AJWq5/ISCAp9EsYOvc4By7qfV1Em0tGxZE7ZBEGMba68TgcZj?=
 =?iso-8859-1?Q?OKT66IfPj7GVVqYrBFfCxwxzgNixTh1QIc8Zrb76o4cltuvLlCcG4vacRs?=
 =?iso-8859-1?Q?Y+UZ2c+D/QJsabrptEQZWDaHbgcqGnOOLjwhKz5eXXGaERULpky0Un4Z6h?=
 =?iso-8859-1?Q?0CSiDjJHKn96hO/TzMOYiXR69H/iJ8axGEHMRgNYo5ztNzVEZr1kfkjfPq?=
 =?iso-8859-1?Q?gBXkjTa2/EAStxbB92YoafDGzGXlyP/3w6RVUNqkWYvQEOLS3GmbsRPSYh?=
 =?iso-8859-1?Q?CG+5x5eRm1QM4+67rpS2RaAtvMCLHAbUH0yDWivKrTfLOyfmtpnjxZTQzV?=
 =?iso-8859-1?Q?G+kfYniOzQwvjNKvtUpY4oHvE9JCTQvxROaUZH5NkC2vZYxjBN8PfbqoVv?=
 =?iso-8859-1?Q?0RM7K31rdqXr01ymHnQYjbGQuyGmQg+/ElBkZEU7txcscc/TE7XTyGimf7?=
 =?iso-8859-1?Q?bT6F6hM1IwIDqG3eZnkgm2lQSFrYm169JJ2e7q3ulDXTGSmomiNsadhZIK?=
 =?iso-8859-1?Q?cuHFipQysw0jxZ/Yaa6Uay/SS24zRW9DFRiZ/8t7YdMSeq4cs4R7Vrf8Bl?=
 =?iso-8859-1?Q?Bi/aiYitTTzln2J5Z0F5UTTyf4mV7WHEu7gaPuHnkrlmVOYnr3vUOJr9MP?=
 =?iso-8859-1?Q?diRzfvnSORj/AHjdAKMCrTcdBmTRUyyidWTWGq7GVXAEHGfHOUbaQTLVJ0?=
 =?iso-8859-1?Q?2+sAswnj4QWjh2ojoMwrOquUPiVdqkXzWsG71HyUnwBeZGqceJBDL8OIHM?=
 =?iso-8859-1?Q?jvJd4EDYsTVWXeX1p6RNe7yS4tR/lPu4OZHw+Slzny1/4qAjVFurud2UMu?=
 =?iso-8859-1?Q?UP13asdqzREpg6wu1s6KOvPoEXiURjp3E67EzaxDz44Vo/irHLiTzazL+k?=
 =?iso-8859-1?Q?OTy34ih53LgzktW/kaQuukA1P7neXqNPE+uzzqpVpheKorHvEPPcnZc2Wl?=
 =?iso-8859-1?Q?tQJ3dCvSjKkUI3Uauv/CUHYx3VaQ4DcIfi+VIVRPdQHk8uTJPiMZ6ZqGnq?=
 =?iso-8859-1?Q?EjVUMP+/H6Rswsz5LYn8Ba7vMPP3xpbe6hx3cYQ594DshFFe6OatR1kFrF?=
 =?iso-8859-1?Q?5ykqjYGeh/HkoW61UeS+PbXwbXKqb7V6dABKcqhqFsRIt5sKA8hxcKetm2?=
 =?iso-8859-1?Q?8YIfPwn9h2+x9EecB4iE94sDvESYmk/qGRtA0Z6FCDojIOr8NPghDA3QOO?=
 =?iso-8859-1?Q?Hexeev3hC25+SIoG2y5TmatlNJFJTczfFtzVLAej8vPMZtWR23CmQYmA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09a20e2-fe9e-4c32-5ff3-08ddcebbf2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:21:18.3332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNDqVhbIWlBgDxPbWc3nFJsyetnpbd2+V3c/w8vrDkNsfmNf4CKAJ02bUxAE6827uM74sqcG5dJRFmSQtC5zMcwb0q8ugwRt0lYp9b/PNkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4021
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

This patch series adds platform support for the P8700 processor
running on the Boston board.

P8700-F is a high-performance RV64GC SoC that supports hardware
multithreading and optional multi-cluster configurations.

----
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

Changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----


Chao-ying Fu (11):
  riscv: Add initial support for P8700 SoC
  board: boston-riscv: Add initial support for P8700 Boston board
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add support for MIPS GIC syscon on RISC-V SoCs
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  libfdt: Allow non-64b aligned memreserve entries
  riscv: p8700: Add software emulation for AMO* instructions
  riscv: p8700: Add Coherence Manager (CM) and IOCU support
  riscv: boston: Add support for LED character display command
  cmd: riscv: Add 'startharts' command to start multiple harts

Uros Stajic (1):
  timer: p8700: Add support for reading time from memory-mapped mtime

 arch/riscv/Kconfig                          |  22 ++
 arch/riscv/cpu/p8700/Kconfig                |  15 +
 arch/riscv/cpu/p8700/Makefile               |  12 +
 arch/riscv/cpu/p8700/cache.c                | 103 +++++++
 arch/riscv/cpu/p8700/cm-iocu.c              |  75 +++++
 arch/riscv/cpu/p8700/cm.c                   |  92 ++++++
 arch/riscv/cpu/p8700/cpu.c                  |  13 +
 arch/riscv/cpu/p8700/dram.c                 |  37 +++
 arch/riscv/cpu/p8700/emu-amo.S              | 254 +++++++++++++++++
 arch/riscv/cpu/p8700/p8700_platform_setup.S | 169 +++++++++++
 arch/riscv/dts/Makefile                     |   1 +
 arch/riscv/dts/boston-p8700.dts             | 256 +++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h      |  61 ++++
 arch/riscv/include/asm/arch-p8700/p8700.h   | 144 ++++++++++
 arch/riscv/include/asm/global_data.h        |   2 +
 arch/riscv/include/asm/io.h                 |  86 ++++++
 arch/riscv/lib/Makefile                     |   1 +
 arch/riscv/lib/interrupts.c                 | 299 ++++++++++++++++++++
 arch/riscv/lib/mips_gic.c                   |  47 +++
 board/mips/boston-riscv/Kconfig             |  51 ++++
 board/mips/boston-riscv/MAINTAINERS         |  15 +
 board/mips/boston-riscv/Makefile            |  10 +
 board/mips/boston-riscv/boston-lcd.h        |  20 ++
 board/mips/boston-riscv/boston-regs.h       |  38 +++
 board/mips/boston-riscv/boston-riscv.c      |   9 +
 board/mips/boston-riscv/checkboard.c        |  43 +++
 board/mips/boston-riscv/config.mk           |  15 +
 board/mips/boston-riscv/display.c           |  33 +++
 board/mips/boston-riscv/iocu.c              | 104 +++++++
 board/mips/boston-riscv/lowlevel_init.S     |  20 ++
 board/mips/boston-riscv/reset.c             |  15 +
 cmd/Kconfig                                 |  14 +
 cmd/Makefile                                |   2 +
 cmd/display.c                               |  51 ++++
 cmd/start_harts.c                           | 103 +++++++
 configs/boston-p8700_defconfig              |  95 +++++++
 doc/README.LED_display                      |  26 ++
 drivers/clk/Kconfig                         |   2 +-
 drivers/gpio/Kconfig                        |   7 +
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/eg20t-gpio.c                   | 138 +++++++++
 drivers/net/pch_gbe.c                       |  37 ++-
 drivers/net/pch_gbe.h                       |   1 +
 drivers/pci/pcie_xilinx.c                   |   9 +
 drivers/timer/riscv_timer.c                 |   7 +
 include/asm-generic/global_data.h           |   5 +
 include/configs/boston-riscv.h              |  11 +
 include/interrupt.h                         |  19 ++
 include/led-display.h                       |  33 +++
 net/eth-uclass.c                            |   2 +
 scripts/dtc/libfdt/fdt_ro.c                 |  11 +-
 51 files changed, 2630 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/emu-amo.S
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
