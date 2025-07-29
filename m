Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2196C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC4A831D8;
	Wed, 30 Jul 2025 07:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="dKU+vEuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E28983045; Tue, 29 Jul 2025 18:22:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3C582BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/1vWc7dDmwcJPE9VNUNLrEceikPq8VqoW/3o0KnUWeJQXwI9YcjHDE7e+qZStU0gF25A45ZLNZkk3q6goocUM2tM4lCSA0y5aDqAy7qTYktO2fg+aQY3D9t8LWyfrtHVcB7zBKb5BweSJaw3h1OCyQS4UU3l8VH81wREnNbfrSImLcz0k7/xlK/RZzcSaaQF0kQzISqYHm6wbjqki/+Xa1qMrb83CuiPNYQKhh7tRJWCx2K6XvUqQHS9QROWn1P3eRMgonyrmTCdnTw9Tv72AA1gniuFqSpndN1bM9eiKf8801z3Lq28Hxu+LBa1wn27LHK1tSJUx6X1f3SdikGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWyKor9K9qHwdZUU/G9hYAVxpveBVSBADO/jBCKWyug=;
 b=OYLRqJ4AMksQnMD3V4yS4d4kPHaDUT530zXCcQGaqPT60nW/cazj30ZmWSL0EJ4V+E6Sq+f4VhJsXEEm+D4F83BLkc1fUD45Wd1QtYzi4pzF0rBCYYQIMdcIHXlDWdB9Pkt4zVpFwHR7XKjoLlvHuRVGuSzncHp1j7N3IQdU6m47ltqHfIIOr/Do2QqtYqOgr4lN9RnCcIYk62BGlvibaLFLhb1MeD+KJ0pvb/fT4AhlnQ2U2Ll0u5unrjCmPmkZqH2I4JMQ9tSLB/GaTmKlmscmSdqHzUI7f5m2WIFB/LI4cb86tIBq3QMFSPDYBbhfwl/g5S2nRTVGUCMAH55LxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWyKor9K9qHwdZUU/G9hYAVxpveBVSBADO/jBCKWyug=;
 b=dKU+vEufLY7kDhnE2M0vSgVOoRE8N2WHJVnjckrNtCuI0hq07OEu3BZQAjk9r9ktfK1ri/WQTnqoYRUv1nzV85C+WBN0JGPcv4YJVbHqAaWQDK+7PRWGyHG+8tXVC6HV5mf5Cxl4redPJDQRFH2Z9buv3toKJau4UutB76sNGuF5FVNKPhqQuBwdZyb/EUY2mgim+dmqjEGLXkU4bTM2vkx0PddnSHxsyfzmgwi4CWJpqwzstgUk1X/3rPbdtlVB6FbvkoJuBUktzcKeMWX7tHtOxysLXFzAd3dQb23Lne6K7gha+fOHDnAnTJsVrVZ7aCdQCNQHf70bOc/Ur596RA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM7PR09MB4021.eurprd09.prod.outlook.com (2603:10a6:20b:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:22:27 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:22:27 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 02/12] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v3 02/12] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHcAKT5+qQusmftbU6Mgo9UCAiVcA==
Date: Tue, 29 Jul 2025 16:22:27 +0000
Message-ID: <20250729162035.209849-3-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM7PR09MB4021:EE_
x-ms-office365-filtering-correlation-id: 22be6a68-6d77-43b2-6a09-08ddcebc1bbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GAaBL8oBPNG+P5uEvjJ2q145/yU7AUy4WmqLhCXGDvTEed4uaUZ51mRK0u?=
 =?iso-8859-1?Q?UHGcS/GGOjNJzsI6IkIshvJIL7wTcVVRiDmw9mf415tDhRekQxMygMy0fY?=
 =?iso-8859-1?Q?2znuHzA+HDB2/wOt63IociX2RbEDFq4y1f+4Uxlz94LTH1zCDbO5ep62gl?=
 =?iso-8859-1?Q?AVSvgqxteU6Xen9u1QEIyBX2TkLoB6ge4/NXXE+Ynp3pF3f+9/997Pbb/w?=
 =?iso-8859-1?Q?CCUWVHaORUb66R5BQe6PE/UBZ1EwiGjcVEYDj+I8uMXpssN+AKEXxpagF+?=
 =?iso-8859-1?Q?+H7tunhfX6MB8jQ/V3T1qDKQ88o5eg1sy1Ru/C5Zrg2ZLc3McPRJzRhKgL?=
 =?iso-8859-1?Q?1K8L4aOwChyQgvKm5MKxY2sbI+iJ257xEPv8WrzZZhVyMtn0+UCyJ995Ui?=
 =?iso-8859-1?Q?1CdIyAe8gvipVgo2pgZ3AmJJ4CgL+zPr7HKvbfLlAl2lPfD1+el5Ib6eql?=
 =?iso-8859-1?Q?2uVVSMxvWPshWmvzqiZ7OfFD+b/AX9YOND6S2FFv78WL0Gl1GQxUx1x4XA?=
 =?iso-8859-1?Q?lwQN8vk6fGLnZ3M6wfPzKy70rB7losaXbP5i1AAPPy48kzSTK9nGOV6NvN?=
 =?iso-8859-1?Q?2zbdqilOsh0L/Vpl/+XxZT5zuI0dQhtvDVDTNOqWUpBy3Ul0hOcF2ijb1t?=
 =?iso-8859-1?Q?6iwPzokIOyiq0xvzroCu9Xzgmk2k8W8uCoP6ykuPfQb1tZQe/GDon4QDs3?=
 =?iso-8859-1?Q?W+iQWRFpHxVxGqbBJ7Lf4WGDutCpVqrOcbqB3IivkfPLIknVBmymFfSPUJ?=
 =?iso-8859-1?Q?7Ovkgi+c7Tr313fFq7laqMjXlxqxUrh/3W0noAikg93KToncfWGMzc8uwh?=
 =?iso-8859-1?Q?ie7HyHfZx5Wx3yIOeI0fBTNmf0ck2wHloLJIV6WOLu92KM6ufZAVPfsZMH?=
 =?iso-8859-1?Q?le32ftrvm+2Ee2wiftXh3/q8f6d4KXctwH1vgQWSFmMQsKeuKR8F6AXUwg?=
 =?iso-8859-1?Q?x+GFdpbcJAj+yARCuIIO5HikMtBPeQAvtgcuQDmSy7nLJlOIT48dLVYnun?=
 =?iso-8859-1?Q?4SEzDvbB8v7E2tniaK/X0rHtzV6Gx57hsQv+IV1Te+Qmnz5fO4AHyiwzrp?=
 =?iso-8859-1?Q?Up9usUNHpeZaFhf8s5LWalThvDwgfzAOTSRdDPmJnhe+7E7DHH2JhP6oBQ?=
 =?iso-8859-1?Q?Fk5qyYpwdmjDOFnN5uk0Hz1w1KLv0CAKXLtwNlQ3Wc5HLnE43YC0qkVLn2?=
 =?iso-8859-1?Q?yAsP8+PGDsaQv7PCkZH/bHiyBWOyYgE3Y5xn0o61o2zMfZcHP2lI8fYFmf?=
 =?iso-8859-1?Q?lj6SydmszVfymmJzn8hZEVMl7yrWPdlvy5H8U1KzJwvVyW3QI5Dk50g16N?=
 =?iso-8859-1?Q?5ui0xPswXIHX1dV8aMYjHiccMJSkEaAVlBThtoAn1JM4p5SqCY855e85LI?=
 =?iso-8859-1?Q?lyhMv6fWy3P8EmZiT4oWusNYVNOrfasv5KFGQyepwC3Yu8hlageLdscnbJ?=
 =?iso-8859-1?Q?+Ha9Y3yVcGCHnsBz07L4Tu/kcrumlZj6E6Dle1W+m66fb6RWcK0Pv1Z7GZ?=
 =?iso-8859-1?Q?CPtOtt+bNQowrux1bs+LGqshVrqQkgju0qWWOdjVXgR/3Bhw1NpaiG+iF/?=
 =?iso-8859-1?Q?/QAkX7E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QEdosaCc+ihtxGStPtRN9/RV3dRZY2HeTjH8mQN4lxExIM6n6j4MX4uLH5?=
 =?iso-8859-1?Q?awhUSRTv8SLWFFm3ofjKLLAxAfKtajuJeThMoWUfODGHZEKR4ROOqOgjkZ?=
 =?iso-8859-1?Q?bD3IPcGCfr/z3aROBJpzee2cFlWmAFSyJ2d8MGgYaZ0BYsOPKkyeYaK2Jo?=
 =?iso-8859-1?Q?RA41rLfFVuNjpu6A+eUB/n1d6S1Tv95ZhvHw4LJeC/leiC34uI7JLOXMQ1?=
 =?iso-8859-1?Q?XhUatfxNcEMnwkM/Y5zL5MneLH30Vyes1nfANdZUK5EPV2p1q2Ucjr8Li/?=
 =?iso-8859-1?Q?8/Ebaczv7YyND9+fPX36YQDGggmiGRDcliSPGYBKYbs38o3QW0sQHwu87g?=
 =?iso-8859-1?Q?NRYrDnDdcAG60xSGZ9lqAwWXYwt1GKi8eST3ybNTropvWwdpLuyEREItek?=
 =?iso-8859-1?Q?uWT7yxRrCMhJSd/4O9kQQBUCES66oo8x5/ANCKOiaEesy51RmnKPxoP5fO?=
 =?iso-8859-1?Q?LdiY7iUzkR/iLqytw4x30MiacG4mfJyjc85CSz2WC/xtEKat8fpJ0CnlAB?=
 =?iso-8859-1?Q?0bH7vywQAzV6fFhPYNlAznVnTHoYnCG+b9INn+mOgOs9ZJGc72Ftu1CaHv?=
 =?iso-8859-1?Q?iF+NiONRbcpkO27k7jdGTV3LaChQ6qNucXo/J65bOKpqQnYeZJ2d5+5wFI?=
 =?iso-8859-1?Q?xsYD7Cd9pEZ2TzIZAM1zxzOySMcCiHP4I5lclvleRZ6l2twt4pFHPZ3ulM?=
 =?iso-8859-1?Q?A6FFol+nwiPveHJqIz7AJju4RQQgZgCQntk9qL3zmgl8IcvVf3vlYhNgOK?=
 =?iso-8859-1?Q?GwA2kBO3zXgPgPC1wijAwpvXC1VkiZcXh+VVNPjrdxWE73MOiyIfjOH6Bz?=
 =?iso-8859-1?Q?MVUSRQcYuGZGhnlK2+9vAh4YSCI9XYBgYfpeBHV69ONEMfcYOe8PdfqKsn?=
 =?iso-8859-1?Q?awZpymk2LusrPccHy+MOn4jRAGabBt8cttRvlmTA8xN/bjXuiG91Tnspq6?=
 =?iso-8859-1?Q?wpBUuEWXtHeVut9uJH8+5CwX70OI+ugwJyDgC+r++X5k19SofoYp5PXaHM?=
 =?iso-8859-1?Q?agjzwJA6RpGyUktv6q5vQvlPQJkVelgPuIfSiz17Tv7od7hyEi6qr4/bma?=
 =?iso-8859-1?Q?PGaWrX8OP7uPIyWlRV1twzg7AUXsQohXLrxzHm9TbyR/bq7xUerbm9B2s3?=
 =?iso-8859-1?Q?5sPklXe1tA3EMe4gQ0hfhXkGpzcu2gNb8gkkZ64MdadjE2o6DdZboY5Exl?=
 =?iso-8859-1?Q?a8voV2+6qaZ5FD1Zsjd2YXZ7Yc3LhFEu3IiF8+W4EFfsQ+Yr828Utxl55b?=
 =?iso-8859-1?Q?cFhmS4uOTcX1XbjF2tSpjpTQ1w2ebiuwP3zayKqKNhpb0G4qFqhABVaqiM?=
 =?iso-8859-1?Q?mbbagyPMIQBYgU0tGQLOS4JjGbB75uZMMbhz6R9I1nL1uvOxHw0cEXeNra?=
 =?iso-8859-1?Q?FOcGCumDxZjX4VHhbOCSBUYr/L1LQGwlfP85e1Dw+zkCyCqqO5MQ3vy/mE?=
 =?iso-8859-1?Q?8Zp3TFN3b0+9LkN2teRxA/Cfu9eTBNlUovolgRZ3gTIKLSvsI4kIP906cD?=
 =?iso-8859-1?Q?bBdq9EH73OjvNa8/z5b+1rknTQE1/K4z7BPYL2vV9fW+5qT5mRnIk/6FCS?=
 =?iso-8859-1?Q?f0KWdVgjF+6LbhXUvn68fzjO3z8JgACZMle7CuzH44eZhCzJpo14MiNgoZ?=
 =?iso-8859-1?Q?Pewpd7II8KW5BEcH/zon7q8MqapE4SZjxe2J45JrqmBdzXrkyXHDrWYQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22be6a68-6d77-43b2-6a09-08ddcebc1bbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:22:27.0539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOv2qiNnx4dhzslKtIL8w3Mo2LD3rhnw8QDetajcjlZzxqQU5Ufn13CwulOFFLcGTpcZ2ofore+U6xrc/yMuvnfZXo6y9O12Dy7eXkgtJI0=
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

From: Chao-ying Fu <cfu@mips.com>

Implement initial board-level support for the P8700 Boston SoC.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/Kconfig                      |  10 +
 arch/riscv/dts/Makefile                 |   1 +
 arch/riscv/dts/boston-p8700.dts         | 256 ++++++++++++++++++++++++
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
 17 files changed, 596 insertions(+), 1 deletion(-)
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
index eb721edca2c..b05e0622908 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,15 @@ config TARGET_XILINX_MBV
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
@@ -115,6 +124,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 2b10c2d6c01..1531013f798 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_TARGET_TH1520_LPI4A) +=3D th1520-lichee-pi-4=
a.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_ASPEED_AST2700_IBEX) +=3D ast2700-ibex.dtb
+dtb-$(CONFIG_TARGET_MIPS_BOSTON) +=3D boston-p8700.dtb
=20
 include $(srctree)/scripts/Makefile.dts
=20
diff --git a/arch/riscv/dts/boston-p8700.dts b/arch/riscv/dts/boston-p8700.=
dts
new file mode 100644
index 00000000000..5f52ff58a3e
--- /dev/null
+++ b/arch/riscv/dts/boston-p8700.dts
@@ -0,0 +1,256 @@
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
+		};
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x80000000 0x80000000>;
+	};
+
+	gic: interrupt-controller {
+		compatible =3D "mti,gic";
+
+		interrupt-controller;
+		#interrupt-cells =3D <3>;
+
+		timer {
+			compatible =3D "mti,gic-timer";
+			interrupts =3D <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+		};
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
