Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC964CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F6482F00;
	Tue, 19 Aug 2025 14:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="cwX9fQP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AA081FEE; Tue, 19 Aug 2025 12:32:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C2B802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpNqSHrZ8D/sw5PXg7lof0eBTFgjUYTjd8ctULaOHzOPUdXkT2kwVSiuBNMWbH+ovhKbvvzeY+Ret1dwShcnq+d9FXvN3o/fHyAdGzTUo6HVsH+c3H6kx/AzZSVORo0pPk83srzC5Cb3cVU6lV20qSwxn1p0Sr0b3Dm6HFfqSUTdUMkxkchtU076SphDJOKYEmsq9H83AoiJrzONO0WQ2CWngm02tE4FYwc+DHo82r70/ZmS9jsB9bUxR4InP2gIVid0Doxx0DN6RcA1ZXtGB3IRhAQE17h4+6jentyc/QjlithrKUmwXCPT1XNSqKYfuh8+WVk1LHrgczsrzAkseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1Q6VIPhXEAewFnLL01zS9XCcicqAKSUNRND7eupSQE=;
 b=sEYcKm8kKl+H4fEAvyoqjtGBvqU7lJh6QZ8URJ/NcMbC75+ZgmAzphPTMXyixF7a1A/m0mJH8pIwTLVxePoeu/kJQMOR0eSaiQQDQ1/vMKvPYYtPVT3iyzgRLtF8YspqfRog10R4IjBsNvjje6JLvb6hvalhLHt3I9aLr3wKR49rXIdW23hLYoYSFORkdOieR+R4lGfYS5S3ppU7eya4fkbGAXrwUzMUGS7ScrM1wpZg32A5KjSdFhrpDc5/UR+oq7+VNRtWrvUkt3SfaisGotsEz78UZT7eZb17K+k8SGNPTcXiDiLCNNCiGjoQKxKDFXh6hPbw7bPmvVkvOvz9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1Q6VIPhXEAewFnLL01zS9XCcicqAKSUNRND7eupSQE=;
 b=cwX9fQP0UjzM9pHqheK6g783+gduuap5Qdwi7ByM7m5MlyYLrvqO+MNvMBvYqx0OzE2kGA59Jg8bpFiGX3ejmWjGyonPCMD1kINVrCpOUqxvGWhtI8j1hj2CGaKMhD6TUPmI7LAmQOwTsFqGrAiRf6X0+on5uJfddOLjuaffK4XSB9gIU7zuCIHgarAlXaZy9TUbOovzAuUt0vutQkp1O5nPJXHT8CuHFDqCPDnEFgzYFkgjbmBXkUnVkv4CQjVh6UTe/cOrCYprM6D+NsnQ4zIp9q6+jcx7f9W1EU7nCeaPGvCc0x00h46Yjwnfqf91fiqAY4JY6sN9cYxnq+0qTw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB7338.eurprd09.prod.outlook.com (2603:10a6:800:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:32:00 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:32:00 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 02/10] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v4 02/10] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHcEPR/RoU6YD4ORUqeKStFXhVEwg==
Date: Tue, 19 Aug 2025 10:32:00 +0000
Message-ID: <20250819103021.1518687-3-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB7338:EE_
x-ms-office365-filtering-correlation-id: 5e7dc430-7f67-4d92-2868-08dddf0ba18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?stpnmrOZfXwJPfMiv8+naTgj51gxyMLbbj+PCIsNzTYuXUqE2BmgypOUOF?=
 =?iso-8859-1?Q?3HJ3UzC48+q8MNUHkG1ANibjZaIRKdLikkFak1IoDYi9IyjwIoVXr9legE?=
 =?iso-8859-1?Q?/JDZbTb1mh3vYpnOvMYeWe9Aq28oFl5h7NTTXj3wMo1upvELr2ChN3P/mU?=
 =?iso-8859-1?Q?1+MKIXfSnLUGJihtSJ45PIPtQYGAJI2ajbHYYQLPuEmVwRB053YyKIDxmU?=
 =?iso-8859-1?Q?0/7byeTxaSlmOv9dtTt7Cmlu5ucD3zlsm1+U6HrnebKIj3g10Rb3Crbj94?=
 =?iso-8859-1?Q?gMWlPH54AnFSBbIOHccwraSSU9xJWEpICWuqO8vVJUBVnBD6T8dm/rJmuC?=
 =?iso-8859-1?Q?bJV/rNWX1nucKtNInlv9QD0LK5YfKV8NrHPP95HJ1Q8pVs+BNFPDOSN5bN?=
 =?iso-8859-1?Q?hBkDal/nM9r9Ltn42iI5uP5bBvMEvndx7F1+oW1kRF+6e2lXG2vu9LeFn6?=
 =?iso-8859-1?Q?vxLs9fPWLX14OBwz262+qdpt5Jk6t7WXeLV8pMC2A3k8Tuvqwi1uuPgkqP?=
 =?iso-8859-1?Q?522zhbr4cV5Ps4wONJqmMVo4Mk5USi9WmGJAPe8zvjoffKKJWTMcMxEpM6?=
 =?iso-8859-1?Q?SpTw3dAlGMj3oyPBZYwadfsr2oViez2bX+qXoNUesuoomBLlYi9TLgmCEK?=
 =?iso-8859-1?Q?JUsByQS2UENjykONTC4OU+Hcn0ijQaUUCVn5NRYcxuqemSozQv/OZjMX/D?=
 =?iso-8859-1?Q?GGgvsvVNkBnhCH3IzGfrcJe4SBZRyDArOgB0MyTsYxo7DFdqgAQNhEgmHG?=
 =?iso-8859-1?Q?tt7uswIkXS/4S8uu0moKFTJUQcW/ietBHgW1dEEjVjVB/ND8FM+WHPKsAm?=
 =?iso-8859-1?Q?iQenHi0AazNJ/v1ROr8SQHG1PP4VMy+xjBbgqC7GmzFpyKdueNlAcOwrnY?=
 =?iso-8859-1?Q?e0L74LjtViwmY5i+Li6t7+vzuzMbEb7Qeodxawyq8mVJ/BEOFKmLtglvKK?=
 =?iso-8859-1?Q?sE2s9//9SUnOR5nWZ5hPY2ohn/4FUoPPMbWwtFhlrZwplp9/bjMLQCBzRm?=
 =?iso-8859-1?Q?Aylh/IDd08FtvC/UnWUSWfjCNUScEBUs3upB9obprl4l/s65O3KFcujZcr?=
 =?iso-8859-1?Q?N6n0sR9kJOI981TbjCi90V4Sv+aD+xtbpI0McRuukkqu4/2Rz6joydSi4h?=
 =?iso-8859-1?Q?2at8Cb4NMy9A6ZnmK7f3sGt+zO7HOlt+kKmTqh43yo3lzDb7qZU3LJBNAW?=
 =?iso-8859-1?Q?6ueYtTivdgtmXodRBE2KlzYNE6d3yK51l2uUbIGcTR3HpwTYvuEqYyhXqt?=
 =?iso-8859-1?Q?ct1zKYAEKyGq8T4LSKwwhDWqFeJgo3mkQQgZqi/TWH34MURWpC2Fqb5jVF?=
 =?iso-8859-1?Q?j5lTVTHT9Ae73/odqRSVR8ttYXYlsdDTG8ccuAx6LfemGeBEOUw332ymCW?=
 =?iso-8859-1?Q?tNfgYV6XjPbhzBRSG1FrVwmCBVIjUJSXqRAdeCqmSNLUcaQ5nCwGk6zWUr?=
 =?iso-8859-1?Q?lq40L/XfPcmJeNYL36JzNQoInrBy807Eyy4rv7L3kfEUOyZubY76n4fBc/?=
 =?iso-8859-1?Q?2WfvtkIMXV5NERuXXLAXEgdyQnxDHeWv8SHf+vd7UcVN/Ar4XZpB6+B9s6?=
 =?iso-8859-1?Q?L7fsAJE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IFDHae168ooAIxmM5xJDOLmJJ1rN0lVcumj/xuvK+n4tb0G5ERRlZQTIvC?=
 =?iso-8859-1?Q?ILZ+2HQqhXO0c8nVSU9e4kIkxUsdpDoWJQuHLqHJo+uOTh00GSVJMtzMUx?=
 =?iso-8859-1?Q?M9edYBpv2vdHw4gS5LLeC8Q6OUwqP2g8y8uycimCBiKHjSU+sM3vTfSjui?=
 =?iso-8859-1?Q?f6QscyudTCdIn0G4GA6yPyDosVLehVeN6JBfwMN0Y87o9of/ynC1MOuant?=
 =?iso-8859-1?Q?tPG+BgYb4/Jg56jXLJ/+K6HBVzTAYNGNjIhKBuXWCwrsUoo/oTiHFpoHSQ?=
 =?iso-8859-1?Q?bCf2uKLn2go1iq/yX0sb6Rnfjul+5fm/RUguYreUfDsEGbH0xgQWbnMlka?=
 =?iso-8859-1?Q?bLqlk49fJe1zV9xkZtAgGJE45v+QY8awKzMX2X8jVJ4IS/s8maE8DY4BsN?=
 =?iso-8859-1?Q?PdtpKbs/e3GtEtFDzKY8rDc7C4rlSReaQ3AzkGHmWWOYljGvAfURHa4o/f?=
 =?iso-8859-1?Q?1cYc4lYvwvDLrmD/yhC1pmfWoMI1XGhu55VLQGyU57/Dmh1UsVrVqeVQRm?=
 =?iso-8859-1?Q?U9HGiFFybPYwpdJbHqrR6a+FwpwuW4zfS+dFEOWBszwxCszWWSO/7UVYan?=
 =?iso-8859-1?Q?T1rQDDfFJMh1PrISNRhF7ty9qKZr2HqWkn6Qjpv+0WJjyHFZ0Dl/qW3Ydi?=
 =?iso-8859-1?Q?+gi6QKytzRoxtIZA6tccpOh0eVCTl/oGux+94QHIBdRIj2pC90ltBu3/Nd?=
 =?iso-8859-1?Q?O9+1Eeom5S+KPLWXVVxqaPqgpYxDjkg4JtwzTSyAi42YfD38rmk3o2/xr4?=
 =?iso-8859-1?Q?QpuIUH2mpon4i4IpMpxScBP0ih9AiB30Z8gR/Qp+nShmjkqtmaTlp/xn1Y?=
 =?iso-8859-1?Q?as99sXhpBXw/31V920Rdhu9FLhMJ0F4XGJ+6RQVBKDZgtgT1v300j9ujnm?=
 =?iso-8859-1?Q?m3qLDWwmYq8Mm4kYmzX01mVgQ9bNNf07iEXiGqhXPOX8/6OZBeX/TreCor?=
 =?iso-8859-1?Q?jxKgl1OFhK8GGBSaxxmHZwwXILh8bo167moAC6xBypiVoyqLMiwBxCvx0P?=
 =?iso-8859-1?Q?TqN2kaGlyAyIHAttImYUEqLGUxHdAO0MXx3agBRAO173t6SL78pWJr+vGw?=
 =?iso-8859-1?Q?ysDYuHLCtZQvidqQgJnEjHkahB0LqAF2yQQXXAEM6j06Apx8OYMHXCCbLT?=
 =?iso-8859-1?Q?uoCYFvqyGpszJT8FveqfPwNaxNI64SFFJ79kyBr0erqot2vIHuBLEotczF?=
 =?iso-8859-1?Q?ioSRq6EOuqcUSWX4AOxFs3aD/gVp6GpYliUIUbImSEL+vhR5V32vBx879R?=
 =?iso-8859-1?Q?Fooa+Vy03Z33VjsJGFQ+lEtwxrd7CWF/r6cS/MtdVGOREI0hm38y64VG4g?=
 =?iso-8859-1?Q?Cp3i7ap3N/ttHDcXqE1hJhwxzG89VMffphsePgTalhJCTRZGXEo31VjPkZ?=
 =?iso-8859-1?Q?11LtFFWOxe6fCeRDSs08hgnUxXO/NPiwSBhdhOwKFueAsitZLHvanC+oai?=
 =?iso-8859-1?Q?WEYQuw9wlJsJP2FJ2HSE3BXGJ1e9Ndip0AcRq9jo+RkDbMwCi7pKBD5lrV?=
 =?iso-8859-1?Q?K8nlK7I01itr1ZpNd7foOFKtf+s6BHNsS+JbUlMzZsW8CNsoo4IRsG25hS?=
 =?iso-8859-1?Q?YwRaMtGb1/qFGeZs+UQ6CiJY19St9gQq+KNVaiWHP0QC1hmVaq4Tzmqf3c?=
 =?iso-8859-1?Q?Nd4QB92hf4wPjpm9XzqHVXQG2N5z0LSTre8XAhXxR1BLdhnpkk0ruQqw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7dc430-7f67-4d92-2868-08dddf0ba18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:32:00.4038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMX0MajxkbMJBrEJfl2xUwS9m0Xkt0AUe+YUHkTUhEujZpysqacBVqzuRCxvPyQvLaz7FikiZlFGs69trK8/nNzD9gM1WkEnAdBfIs7cHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7338
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

From: Chao-ying Fu <cfu@mips.com>

Implement initial board-level support for the P8700 Boston SoC.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                      |  10 +
 arch/riscv/cpu/p8700/Kconfig            |   2 +-
 arch/riscv/dts/Makefile                 |   1 +
 arch/riscv/dts/boston-p8700.dts         | 263 ++++++++++++++++++++++++
 board/mips/boston-riscv/Kconfig         |  43 ++++
 board/mips/boston-riscv/MAINTAINERS     |   9 +
 board/mips/boston-riscv/Makefile        |   8 +
 board/mips/boston-riscv/boston-lcd.h    |  20 ++
 board/mips/boston-riscv/boston-regs.h   |  38 ++++
 board/mips/boston-riscv/boston-riscv.c  |   9 +
 board/mips/boston-riscv/checkboard.c    |  43 ++++
 board/mips/boston-riscv/config.mk       |  15 ++
 board/mips/boston-riscv/lowlevel_init.S |  18 ++
 board/mips/boston-riscv/reset.c         |  15 ++
 configs/boston-p8700_defconfig          |  94 +++++++++
 drivers/clk/Kconfig                     |   2 +-
 include/asm-generic/global_data.h       |   5 +
 include/configs/boston-riscv.h          |  11 +
 18 files changed, 604 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 include/configs/boston-riscv.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4eaf0e3db71..9e176522e73 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,15 @@ config TARGET_XILINX_MBV
 config TARGET_ASPEED_AST2700_IBEX
 	bool "Support Ibex RISC-V cores on Aspeed AST2700 SoC"
=20
+config TARGET_MIPS_BOSTON
+	bool "Support Mips Boston Board"
+	select DM
+	select DM_GPIO
+	select DM_SERIAL
+	select OF_CONTROL
+	select DISTRO_DEFAULTS
+	imply CMD_DM
+
 endchoice
=20
 config SYS_ICACHE_OFF
@@ -119,6 +128,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
diff --git a/arch/riscv/cpu/p8700/Kconfig b/arch/riscv/cpu/p8700/Kconfig
index 7023575a6be..0913a6ce8f2 100644
--- a/arch/riscv/cpu/p8700/Kconfig
+++ b/arch/riscv/cpu/p8700/Kconfig
@@ -7,7 +7,7 @@ config P8700_RISCV
 	select ARCH_EARLY_INIT_R
 	imply CPU
 	imply CPU_RISCV
-	imply SIFIVE_CLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
+	imply RISCV_ACLINT if (RISCV_MMODE || SPL_RISCV_MMODE)
 	imply CMD_CPU
 	imply SPL_CPU_SUPPORT
 	imply SPL_OPENSBI
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index a637727b76b..d00f41de2ad 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-binman.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) +=3D ast2700-ibex.dtb
+dtb-$(CONFIG_TARGET_MIPS_BOSTON) +=3D boston-p8700.dtb
=20
 include $(srctree)/scripts/Makefile.dts
=20
diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.=
dts
new file mode 100644
index 00000000000..5a5c8826318
--- /dev/null
+++ b/arch/riscv/dts/boston-p8700.dts
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/clock/boston-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/ {
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+	model =3D "p8700";
+	compatible =3D "img,boston";
+
+	chosen {
+		stdout-path =3D &uart0;
+		bootargs =3D "root=3D/dev/sda rw earlycon console=3DttyS0,115200n8r";
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		timebase-frequency =3D <20000000>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "riscv";
+			reg =3D <0>;
+			mmu-type =3D "riscv,sv39";
+			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb";
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+			clock-frequency =3D <20000000>;
+			bootph-all;
+			status =3D "okay";
+
+			cpu0_intc: interrupt-controller {
+				compatible =3D "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells =3D <1>;
+			};
+		};
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x80000000>;
+	};
+
+	timer@16154000 {
+		compatible =3D "riscv,aclint-mtimer";
+		reg =3D <0x16108050 0x8>,
+			  <0x16154000 0x7ff8>;
+		interrupts-extended =3D <&cpu0_intc 7>;
+	};
+
+	gic: interrupt-controller {
+		compatible =3D "mti,gic";
+
+		interrupt-controller;
+		#interrupt-cells =3D <3>;
+	};
+
+	pci0: pci@10000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x10000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x40000000
+			  0x40000000 0 0x40000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci0_intc 1>,
+				<0 0 0 2 &pci0_intc 2>,
+				<0 0 0 3 &pci0_intc 3>,
+				<0 0 0 4 &pci0_intc 4>;
+
+		status =3D "disabled";
+
+		pci0_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci1: pci@12000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x12000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 1 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x20000000
+			  0x20000000 0 0x20000000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci1_intc 1>,
+				<0 0 0 2 &pci1_intc 2>,
+				<0 0 0 3 &pci1_intc 3>,
+				<0 0 0 4 &pci1_intc 4>;
+
+		status =3D "disabled";
+
+		pci1_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+	};
+
+	pci2: pci@14000000 {
+		device_type =3D "pci";
+		compatible =3D "xlnx,axi-pcie-host-1.00.a";
+		reg =3D <0x14000000 0x2000000>;
+
+		#address-cells =3D <3>;
+		#size-cells =3D <2>;
+		#interrupt-cells =3D <1>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>;
+
+		ranges =3D <0x02000000 0 0x16000000
+			  0x16000000 0 0x100000>;
+
+		bus-range =3D <0x00 0xff>;
+
+		interrupt-map-mask =3D <0 0 0 7>;
+		interrupt-map =3D <0 0 0 1 &pci2_intc 1>,
+				<0 0 0 2 &pci2_intc 2>,
+				<0 0 0 3 &pci2_intc 3>,
+				<0 0 0 4 &pci2_intc 4>;
+
+		status =3D "disabled";
+
+		pci2_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <1>;
+		};
+
+		pci2_root@0,0,0 {
+			compatible =3D "pci10ee,7021", "pci-bridge";
+			reg =3D <0x00000000 0 0 0 0>;
+
+			#address-cells =3D <3>;
+			#size-cells =3D <2>;
+			#interrupt-cells =3D <1>;
+
+			eg20t_bridge@1,0,0 {
+				compatible =3D "pci8086,8800", "pci-bridge";
+				reg =3D <0x00010000 0 0 0 0>;
+
+				#address-cells =3D <3>;
+				#size-cells =3D <2>;
+				#interrupt-cells =3D <1>;
+
+				eg20t_mac@2,0,1 {
+					compatible =3D "pci8086,8802", "intel,pch-gbe";
+					reg =3D <0x00020100 0 0 0 0>;
+					phy-reset-gpios =3D <&eg20t_gpio 6 GPIO_ACTIVE_LOW>;
+				};
+
+				eg20t_gpio: eg20t_gpio@2,0,2 {
+					compatible =3D "pci8086,8803", "intel,eg20t-gpio";
+					reg =3D <0x00020200 0 0 0 0>;
+
+					gpio-controller;
+					#gpio-cells =3D <2>;
+				};
+
+				mmc0: mmc@2,4,0 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022000 0 0 0 0>;
+				};
+
+				mmc1: mmc@2,4,1 {
+					compatible =3D "intel,apl-sd";
+					reg =3D <0x00022100 0 0 0 0>;
+				};
+
+				eg20t_i2c@2,12,2 {
+					compatible =3D "pci8086,8817";
+					reg =3D <0x00026200 0 0 0 0>;
+
+					#address-cells =3D <1>;
+					#size-cells =3D <0>;
+
+					rtc@0x68 {
+						compatible =3D "st,m41t81s";
+						reg =3D <0x68>;
+					};
+				};
+			};
+		};
+	};
+
+	plat_regs: system-controller@17ffd000 {
+		compatible =3D "img,boston-platform-regs", "syscon";
+		reg =3D <0x17ffd000 0x1000>;
+		bootph-all;
+	};
+
+	clk_boston: clock {
+		compatible =3D "img,boston-clock";
+		#clock-cells =3D <1>;
+		regmap =3D <&plat_regs>;
+		bootph-all;
+	};
+
+	reboot: syscon-reboot {
+		compatible =3D "syscon-reboot";
+		regmap =3D <&plat_regs>;
+		offset =3D <0x10>;
+		mask =3D <0x10>;
+	};
+
+	uart0: uart@17ffe000 {
+		compatible =3D "ns16550a";
+		reg =3D <0x17ffe000 0x1000>;
+		reg-shift =3D <2>;
+		reg-io-width =3D <4>;
+
+		interrupt-parent =3D <&gic>;
+		interrupts =3D <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks =3D <&clk_boston BOSTON_CLK_SYS>;
+		clock-frequency =3D <20000000>;
+
+		bootph-all;
+	};
+
+	lcd: lcd@17fff000 {
+		compatible =3D "img,boston-lcd";
+		reg =3D <0x17fff000 0x8>;
+	};
+
+	flash@18000000 {
+		compatible =3D "cfi-flash";
+		reg =3D <0x18000000 0x8000000>;
+		bank-width =3D <2>;
+	};
+};
diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
new file mode 100644
index 00000000000..68c5fc50489
--- /dev/null
+++ b/board/mips/boston-riscv/Kconfig
@@ -0,0 +1,43 @@
+if TARGET_MIPS_BOSTON
+
+config SYS_BOARD
+	default "boston-riscv"
+
+config SYS_VENDOR
+	default "mips"
+
+config SYS_CONFIG_NAME
+	default "boston-riscv"
+
+config SYS_CPU
+	default "p8700"
+
+config BOARD_SPECIFIC_OPTIONS
+    def_bool y
+    select P8700_RISCV
+    imply SYS_NS16550
+
+config SYS_CACHELINE_SIZE
+    default 64
+
+config SYS_SDRAM_BASE
+    hex
+    default 0x80000000
+
+config SYS_INIT_SP_ADDR
+    hex
+    default 0x80200000
+
+config STANDALONE_LOAD_ADDR
+    hex
+    default 0x80200000
+
+config SYS_MAX_FLASH_BANKS_DETECT
+    bool
+    default y
+
+config PHY_REALTEK
+    bool
+    default y
+
+endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
new file mode 100644
index 00000000000..e350121395e
--- /dev/null
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -0,0 +1,9 @@
+BOSTON-RISCV BOARD
+M:	Chao-ying Fu <cfu@mips.com>
+S:	Maintained
+F:	board/mips/boston-riscv/
+F:	include/configs/boston-riscv.h
+F:  arch/riscv/cpu/p8700/
+F:  arch/riscv/include/asm/arch-p8700/
+F:  configs/boston-p8700_defconfig
+F:  arch/riscv/dts/boston-p8700.dts
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
new file mode 100644
index 00000000000..0615c677d23
--- /dev/null
+++ b/board/mips/boston-riscv/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2016 Imagination Technologies
+
+obj-y +=3D boston-riscv.o
+obj-y +=3D checkboard.o
+obj-y +=3D lowlevel_init.o
+obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/boston-lcd.h b/board/mips/boston-riscv=
/boston-lcd.h
new file mode 100644
index 00000000000..5f5cd0fe126
--- /dev/null
+++ b/board/mips/boston-riscv/boston-lcd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_LCD_H__
+#define __BOARD_BOSTON_LCD_H__
+
+/**
+ * lowlevel_display() - Display a message on Boston's LCD
+ * @msg: The string to display
+ *
+ * Display the string @msg on the 7 character LCD display of the Boston bo=
ard.
+ * This is typically used for debug or to present some form of status
+ * indication to the user, allowing faults to be identified when things go
+ * wrong early enough that the UART isn't up.
+ */
+void lowlevel_display(const char msg[static 8]);
+
+#endif /* __BOARD_BOSTON_LCD_H__ */
diff --git a/board/mips/boston-riscv/boston-regs.h b/board/mips/boston-risc=
v/boston-regs.h
new file mode 100644
index 00000000000..4d5ea8833ab
--- /dev/null
+++ b/board/mips/boston-riscv/boston-regs.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#ifndef __BOARD_BOSTON_REGS_H__
+#define __BOARD_BOSTON_REGS_H__
+
+#ifndef BOSTON_PLAT_BASE
+#define BOSTON_PLAT_BASE		(0x17ffd000)
+#endif
+#define BOSTON_LCD_BASE			(0x17fff000)
+
+/*
+ * Platform Register Definitions
+ */
+#define BOSTON_PLAT_CORE_CL		(BOSTON_PLAT_BASE + 0x04)
+
+#define BOSTON_PLAT_SOFT_RST		(BOSTON_PLAT_BASE + 0x10)
+#define BOSTON_PLAT_SOFT_RST_SYSTEM	(0x1 << 4)
+
+#define BOSTON_PLAT_DDR3STAT		(BOSTON_PLAT_BASE + 0x14)
+#define BOSTON_PLAT_DDR3STAT_CALIB	(0x1 << 2)
+
+#define BOSTON_PLAT_BUILDCFG0           (BOSTON_PLAT_BASE + 0x34)
+#define BOSTON_PLAT_BUILDCFG0_IOCU     (0x1 << 0)
+#define BOSTON_PLAT_BUILDCFG0_PCIE0    (0x1 << 1)
+#define BOSTON_PLAT_BUILDCFG0_PCIE1    (0x1 << 2)
+#define BOSTON_PLAT_BUILDCFG0_PCIE2    (0x1 << 3)
+#define BOSTON_PLAT_BUILDCFG0_CFG_LTR  (0xf << 4)
+#define BOSTON_PLAT_BUILDCFG0_CFG_NUM  (0xff << 8)
+#define BOSTON_PLAT_BUILDCFG0_DP       (0x1 << 24)
+#define BOSTON_PLAT_BUILDCFG0_DP_MULT  (0xf << 28)
+
+#define BOSTON_PLAT_DDRCONF0		(BOSTON_PLAT_BASE + 0x38)
+#define BOSTON_PLAT_DDRCONF0_SIZE	(0xf << 0)
+
+#endif /* __BOARD_BOSTON_REGS_H__ */
diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-ris=
cv/boston-riscv.c
new file mode 100644
index 00000000000..e5cd6c42cf7
--- /dev/null
+++ b/board/mips/boston-riscv/boston-riscv.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/mips/boston-riscv/checkboard.c b/board/mips/boston-riscv=
/checkboard.c
new file mode 100644
index 00000000000..c7bf6734433
--- /dev/null
+++ b/board/mips/boston-riscv/checkboard.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-lcd.h"
+#include "boston-regs.h"
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/p8700.h>
+
+int checkboard(void)
+{
+	u32 changelist, cfg, core, uarch;
+	u64 marchid;
+
+	lowlevel_display("U-boot  ");
+
+	printf("Board: Mips Boston RISC-V\n");
+
+	changelist =3D __raw_readl((uint32_t *)BOSTON_PLAT_CORE_CL);
+	if (changelist > 1) {
+		asm volatile ("csrr %0, marchid" : "=3Dr"(marchid)::);
+		core =3D (marchid >> MARCHID_CLASS_SHIFT) & MARCHID_CLASS_MASK;
+		uarch =3D (marchid >> MARCHID_UARCH_SHIFT) & MARCHID_UARCH_MASK;
+
+		printf("Core:  class%x uarch%x cl%x", core, uarch, changelist);
+
+		cfg =3D __raw_readl((uint32_t *)BOSTON_PLAT_BUILDCFG0);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM)
+			printf(" config %u",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_CFG_NUM) >> 8);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR)
+			printf("%c",
+			       'a' + ((cfg & BOSTON_PLAT_BUILDCFG0_CFG_LTR) >> 4) - 1);
+		if (cfg & BOSTON_PLAT_BUILDCFG0_DP)
+			printf(", x%u debug port",
+			       (cfg & BOSTON_PLAT_BUILDCFG0_DP_MULT) >> 28);
+		printf("\n");
+	}
+
+	return 0;
+}
diff --git a/board/mips/boston-riscv/config.mk b/board/mips/boston-riscv/co=
nfig.mk
new file mode 100644
index 00000000000..c1e242f1088
--- /dev/null
+++ b/board/mips/boston-riscv/config.mk
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+quiet_cmd_srec_cat =3D SRECCAT $@
+      cmd_srec_cat =3D srec_cat -output $@ -$2 \
+			$< -binary \
+			-fill 0x00 -within $< -binary -range-pad 16 \
+			-offset $3
+
+u-boot.mcs: u-boot.bin
+	$(call cmd,srec_cat,intel,0x7c00000)
+
+# if srec_cat is present build u-boot.mcs by default
+has_srec_cat =3D $(call try-run,srec_cat -VERSion,y,n)
+INPUTS-$(has_srec_cat) +=3D u-boot.mcs
+CLEAN_FILES +=3D u-boot.mcs
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
new file mode 100644
index 00000000000..8fa85749e40
--- /dev/null
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+
+.data
+
+msg_ddr_cal:	.ascii "DDR Cal "
+msg_ddr_ok:	.ascii "DDR OK  "
+
+.text
+
+	.globl lowlevel_display
+lowlevel_display:
+	li	t0, BOSTON_LCD_BASE
+	jr	ra
diff --git a/board/mips/boston-riscv/reset.c b/board/mips/boston-riscv/rese=
t.c
new file mode 100644
index 00000000000..8e7e0572aad
--- /dev/null
+++ b/board/mips/boston-riscv/reset.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+#include <asm/io.h>
+#include <linux/delay.h>
+
+void _machine_restart(void)
+{
+	writel(BOSTON_PLAT_SOFT_RST_SYSTEM, (void __iomem *)BOSTON_PLAT_SOFT_RST)=
;
+
+	udelay(1000);
+}
diff --git a/configs/boston-p8700_defconfig b/configs/boston-p8700_defconfi=
g
new file mode 100644
index 00000000000..3df7ffe50b3
--- /dev/null
+++ b/configs/boston-p8700_defconfig
@@ -0,0 +1,94 @@
+CONFIG_RISCV=3Dy
+CONFIG_SYS_TEXT_BASE=3D0x1fc00000
+CONFIG_ENV_SIZE=3D0x40000
+CONFIG_ENV_SECT_SIZE=3D0x40000
+CONFIG_TARGET_MIPS_BOSTON=3Dy
+CONFIG_DEFAULT_DEVICE_TREE=3D"boston-p8700"
+
+CONFIG_DISTRO_DEFAULTS=3Dy
+CONFIG_FIT=3Dy
+CONFIG_FIT_VERBOSE=3Dy
+CONFIG_FIT_BEST_MATCH=3Dy
+CONFIG_OF_STDOUT_VIA_ALIAS=3Dy
+CONFIG_SYS_PROMPT=3D"boston # "
+CONFIG_CMD_GREPENV=3Dy
+CONFIG_CMD_MEMTEST=3Dy
+CONFIG_SYS_MEMTEST_START=3D0x80000000
+CONFIG_SYS_MEMTEST_END=3D0x90000000
+CONFIG_BOOTDELAY=3D-1
+
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_ARCH_RV64I=3Dy
+CONFIG_DISPLAY_CPUINFO=3Dy
+CONFIG_DISPLAY_BOARDINFO=3Dy
+#CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
+#CONFIG_CMD_NVEDIT_EFI=3Dy
+CONFIG_CMD_MII=3Dy
+# CONFIG_OF_PRIOR_STAGE=3Dy
+CONFIG_DM_MTD=3Dy
+CONFIG_SMP=3Dn
+CONFIG_XIP=3Dy
+CONFIG_CLK_BOSTON=3Dy
+CONFIG_RISCV_ISA_C=3Dn
+CONFIG_SHOW_REGS=3Dy
+CONFIG_SYS_NS16550=3Dy
+
+CONFIG_CMD_PCI=3Dy
+CONFIG_CMD_SNTP=3Dy
+CONFIG_CMD_DNS=3Dy
+CONFIG_CMD_LINK_LOCAL=3Dy
+CONFIG_CMD_TIME=3Dy
+CONFIG_CMD_EXT4_WRITE=3Dy
+CONFIG_ENV_IS_IN_FLASH=3Dy
+CONFIG_ENV_ADDR=3D0x1ffc0000
+CONFIG_NET_RANDOM_ETHADDR=3Dy
+CONFIG_MTD=3Dy
+CONFIG_MTD_NOR_FLASH=3Dy
+CONFIG_FLASH_CFI_DRIVER=3Dy
+CONFIG_CFI_FLASH=3Dy
+CONFIG_SYS_FLASH_USE_BUFFER_WRITE=3Dy
+CONFIG_SYS_FLASH_USE_PROTECTION=3Dy
+CONFIG_SYS_FLASH_CFI=3Dy
+CONFIG_SYS_FLASH_PROTECTION=3Dy
+CONFIG_DM_ETH=3Dy
+CONFIG_PCH_GBE=3Dy
+CONFIG_PCI=3Dy
+CONFIG_DM_PCI=3Dy
+CONFIG_PCI_XILINX=3Dy
+CONFIG_LZ4=3Dy
+CONFIG_CLK=3Dy
+CONFIG_EG20T_GPIO=3Dy
+
+CONFIG_MMC=3Dy
+CONFIG_HUSH_PARSER=3Dy
+CONFIG_CMD_CPU=3Dy
+CONFIG_CMD_MMC=3Dy
+CONFIG_CMD_DHCP=3Dy
+CONFIG_CMD_PING=3Dy
+CONFIG_CMD_EXT4=3Dy
+CONFIG_CMD_FAT=3Dy
+CONFIG_CMD_FS_GENERIC=3Dy
+CONFIG_OF_EMBED=3Dy
+CONFIG_CPU=3Dy
+CONFIG_MMC_SDHCI=3Dy
+CONFIG_MMC_PCI=3Dy
+
+CONFIG_UNIT_TEST=3Dy
+CONFIG_UT_LIB=3Dn
+CONFIG_UT_LIB_ASN1=3Dn
+CONFIG_UT_LOG=3Dn
+CONFIG_UT_TIME=3Dy
+CONFIG_UT_UNICODE=3Dn
+CONFIG_UT_ENV=3Dn
+CONFIG_UT_OVERLAY=3Dn
+
+CONFIG_SYS_LOAD_ADDR=3D0x80000000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
+CONFIG_TEXT_BASE=3D0x1fc00000
+CONFIG_SYS_MALLOC_LEN=3D0x00800000
+CONFIG_SYS_BOOTM_LEN=3D0x04000000
+CONFIG_SYS_MAX_FLASH_SECT=3D1024
+CONFIG_PHY_ANEG_TIMEOUT=3D40000
+CONFIG_NET_RETRY_COUNT=3D10
+CONFIG_ENV_CALLBACK_LIST_STATIC=3D"io.coherent:io_coherent,"
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e6483ddc88b..6b3103f6cf8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -59,7 +59,7 @@ config CLK_BCM6345
 	  clocks on BCM6345 SoCs. HW has no rate changing capabilities.
=20
 config CLK_BOSTON
-	def_bool y if TARGET_BOSTON
+	def_bool y if TARGET_BOSTON || TARGET_MIPS_BOSTON
 	depends on CLK
 	select REGMAP
 	select SYSCON
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global=
_data.h
index 506ee51cdb0..7b25de7bb68 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -702,6 +702,11 @@ enum gd_flags {
 	 * drivers shall not be called.
 	 */
 	GD_FLG_HAVE_CONSOLE =3D 0x8000000,
+	/**
+	 * @GD_FLG_COHERENT_DMA: DMA is cache-coherent.
+	 *
+	 */
+	GD_FLG_COHERENT_DMA =3D 0x10000000,
 };
=20
 #endif /* __ASSEMBLY__ */
diff --git a/include/configs/boston-riscv.h b/include/configs/boston-riscv.=
h
new file mode 100644
index 00000000000..3b3e2567214
--- /dev/null
+++ b/include/configs/boston-riscv.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __CONFIG_BOSTON_RISCV_H
+#define __CONFIG_BOSTON_RISCV_H
+
+#include <linux/sizes.h>
+
+#endif /* __CONFIG_BOSTON_RISCV_H */
--=20
2.34.1
