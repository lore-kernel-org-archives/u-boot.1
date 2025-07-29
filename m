Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB1DC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B240C832F9;
	Wed, 30 Jul 2025 07:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Sx3bPZBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA5582E34; Tue, 29 Jul 2025 18:25:08 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512A482B20
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w29Uw+Qab6CE0YEGweaBLGyf6FnE7mbhtlaDQQdSI5rJP4g37n9efY9JxUEWsntyb7kxXp5tFY6cuktSYB/grvbCk3X02ntbURutUt4jxCX5KXJBRP36cAbP2hX+/16LLKZF95nYLoXVmicdIHwG0xegIze/ZdPp/JlKgnVmCg3NEUpIznqdQTYgZ5cu3Rs/WQpdhFkr4h8Nwvd4kudy/9hdBuxMKX84ivGeF8Tp4sOgm9k8XOTwpSRFZtLv0VCEo3QK7Cx1DX2yFv4fYjLNGVHBWM3MfGgz8MDkyvoZEXh58jT5rWUy9wHlKG7qvGoxdWIlcBNDNEvQYZff2x2uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/oYx0cTHnQYCLdompo36cjK3WEpLv5lPYoHVOs8VOg=;
 b=tdC9Q/KoZP03CaqERhkYprkJD3lUySuwOTqbQX3De028ovao5XEV9bZAIbho8RYqEZZwqnT855oNtymW2RopMT7Z8ICmBkDFKk2R5KFMHe0xbCMGBxBfNwz8MRtd64n2HfeG0bhhwMRflb7U90uM0UlNP2FDTdPfh/HIBY+T2hIe6atO+Q/c0saY8lDVOxa8JRa80L5BffpckMIHpl8tm9B4K9gUZ8MFE14ngsOoawhJu76mdaGkm3ytf9l/MBdBNUL6Fhnw78ZQehFwjVIkum27xqDC7AmTsIaydOCjtoJL/GCaBTOWiagvnKYiTOxtIFG5hJQIQR00M/leYLhBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/oYx0cTHnQYCLdompo36cjK3WEpLv5lPYoHVOs8VOg=;
 b=Sx3bPZBNQpUeAFbtkU0VMUVeXtrVaIb2kWIgLnK9qVWp2zJS592DVi/RIqdnuDz1ovvhjGgrb694c35lQokQtGgIYvXRy8j+Nb+Ly7WV47v1KNV8G3h+D9MewMVa+fRUtoI87TAceyV3p2VcPRY1H7B5E5jF9fciVYh+Nvw1JcIgVY/JmNz/w4bwp1Qx9SXMdPHu4Q4GwwIwpQqm+F9CcAsw4jZakrrptOHjMZFtJMpjZR/HbTPCyzBUV/qCE5YdBlL9bVX1xVtft5w9U/PzdJlMKExjcXmDAdGVr+Nuw2Ua9zryqLO1S9eYIEPEHBmUofZNZjOa02wSUIJx10RoDA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:25:05 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:25:05 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 11/12] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Topic: [PATCH v3 11/12] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Index: AQHcAKVX9hfL5FaFPUmS8JdZ737PgQ==
Date: Tue, 29 Jul 2025 16:25:05 +0000
Message-ID: <20250729162035.209849-12-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: a52f6fbe-e27f-429e-8248-08ddcebc79e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wyPjQPP/dZrL44FMAaWj+lXvfNVbacwLEXIDPE4XIBUzOwzhY/HjNgSWP3?=
 =?iso-8859-1?Q?EW0zOcqdzlOiiZtnOkyzchz8FULgawrNury8wSXpR2aHT9JCQQri/WhZuz?=
 =?iso-8859-1?Q?/ZihOE8egfHCNL6K9G/MdgsFpxZQA7npbtyEvc8B4VBoEGmJKtuIpWMRN2?=
 =?iso-8859-1?Q?puEFE408542idvV52kuKXHjTn3bI/eMFs35Gcq6f4jYp6dcb7m6J+Idfu4?=
 =?iso-8859-1?Q?LxAi1m4fqkr1zXBxYVA03YR3okhbTZLinuSk6tPe641u2l+HgnNc/DnEC0?=
 =?iso-8859-1?Q?Q4mjao0ZzUqDSO4BXcqSLt42dI6TtDRMphdL6uBdcqg38sc7dScPkEltwH?=
 =?iso-8859-1?Q?0GuGPaxnehNFpqxT7UHFGvRQwoV5xq9/QB0cHKQ4hG0aGM/+aXPyeD1fYO?=
 =?iso-8859-1?Q?1rdnbPOIdSr6X82QnCKc3A5fTde0NE1oVw8ZYqxbsVEVi+ELQR0olm0yg8?=
 =?iso-8859-1?Q?YMdikys7N+rdRokvXLGs1CF5FVexHCyNpCVkEVVVY4bHLuP21+CHXms/Pb?=
 =?iso-8859-1?Q?If8ysNFahK7og09mcRaEb5WrQJpGh7Y1ik/p7o9O+6+IH8cu68QNQhukmN?=
 =?iso-8859-1?Q?5crMqukqEAqMm5Z1lITMnlGTtMvVb2oOcJndqFrhTAviOiEiw0jx4vfTZB?=
 =?iso-8859-1?Q?x0PUWUpYbokKbSTUauKCbG3RFGHifYj7Qx46+p0Xwi3IRASEGq+hq5CU6y?=
 =?iso-8859-1?Q?OMp1mUcArNz1+P24SBxwfohEYIDB+lWL8BLIk7vIClt0YGLhXfphhZwKOH?=
 =?iso-8859-1?Q?SaLMQ6Bj2yoPBMQENeVlAx1zluhYa0z/a4Iktd+NsS8vDPXt1+yMNbEkre?=
 =?iso-8859-1?Q?o9P98axLU6r8yPJEiTVaDp7w8q4hh6JkYkr/yzEygnjUx+rH8Yfm3/jzvd?=
 =?iso-8859-1?Q?d5XRuttDKoOwVKuOelP25qfqnaHEuphp9EMJRxq9lIfEiG37MYODOtRsoZ?=
 =?iso-8859-1?Q?ixP/2UxpNEu86l3NJaaY9jIK8vNisq3yUBIbbEpa6EQwqNXYDXUBjnqa+Z?=
 =?iso-8859-1?Q?e9oKCc/8jFmzCPzF7LPZuaSsCDXRtqlSEb0Whv1VCnHfQlWd58ayucooHy?=
 =?iso-8859-1?Q?8JKCJHOxCicKOs7w8LyuhPGWW3kG3ajx6aU3RIDWIaBvwrpTO/E+fSxbTg?=
 =?iso-8859-1?Q?wb+c2CSajLqx7vDda920tcQZPfmQ0DGUgdbQsGAXC/7zsz0s8dAlpkzL4F?=
 =?iso-8859-1?Q?v/Rk1RbL360QDc9YqjMbY9zLRJ0VPbIGEOCudgsVQKpwQE9E7WQnfiLE+7?=
 =?iso-8859-1?Q?vBdpJS7CcrxGrRmDB2zbJdAUOJoT2ct6kxJlAFE2mDAw0+wqMaM6wmxl75?=
 =?iso-8859-1?Q?X8zKe1TQuFKWFRliOee7uvWV9dSHtN+g5lhkprzINWAppNTloNu7L9iWmD?=
 =?iso-8859-1?Q?Qm7jmocsNnbM5mey6Jk7ObmvAEp3kw0V24YINIg9UVvTdU4KpcaXdtqSzh?=
 =?iso-8859-1?Q?s/J/A2ZdjPL63KI5v76icXGnT9x+pu6C9CsSP+3NsZOLyvi5MGitB7bxEK?=
 =?iso-8859-1?Q?2AyC+j1DdE8ZWsCpK9FEI9m2VuaGcTPQcyXkqNrdNN/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FSaxqAF5rLdsxn6wz+JEFQmciTYeAI+knCQgMPJZ5sKixpHcwWmHU53Nq+?=
 =?iso-8859-1?Q?AAynIcUhMqPoD/sJtir+BxPs78E+YGGxZBAYn9GVyGjhzhrdizmtugpvzJ?=
 =?iso-8859-1?Q?GVGVR5MYSEH1eNkWj4Nn60cTyOZ0IjAlDpDjkOzxJzHSS3pERb78Ci7uHT?=
 =?iso-8859-1?Q?PtcQKqNAMuHk1HIFNXnB5QwhBXfovvvc/Rq2zpAsc0p0ei89kzBmjgEGsf?=
 =?iso-8859-1?Q?VOpa9vTOcmEWNH5KO+1Y6jeZJgMVsJGyqdiJ0DMG/4sqoyDoUDvZ8humrm?=
 =?iso-8859-1?Q?f0roaE7g3E2IYiooUqqcyXxZLaoopp/KRM8UYUJFfRZ+2K1T5f2guB2lQZ?=
 =?iso-8859-1?Q?SecAJOUlqQ7ptismP5frNC5PEF/gaFYSQKTTjurbwUw7S6MaUAY4a5mHwK?=
 =?iso-8859-1?Q?LSmSv97h8AYz1hOuRp/14Du4n2MFuS3HZzH4Otsu4AS8RbOY2ceL+Uidv4?=
 =?iso-8859-1?Q?T2DxKmFsbk6MRyTSGXwB8kSjgfgs1ZA5ySsdGeh8mUDbngT2iveJvmENDx?=
 =?iso-8859-1?Q?vmjBIUtwWYMubF1YVPKHN6Qg+oyp2CZXHQFyjsAtm1lc/aHKdk2GIASQkN?=
 =?iso-8859-1?Q?B3kd8IxJk5mIukDkA8SiL0I53iahqy0zTFqB9557zMwtAR8MzdQfjffCP/?=
 =?iso-8859-1?Q?okZPkywACZb9lnDPfllYkF72n5nv3RJGXmUXmJITMRs0PGLWOP84kudKpP?=
 =?iso-8859-1?Q?YasUgtjaLNNMcg6PAhUeVdFD5GWfRkXY3DmUUj62J8xH3HBoD5KIG8oE5e?=
 =?iso-8859-1?Q?K5jI2yNNMZhLP2sLWzEfHSnlfnX5d+VqJB3x7nDkwiclqpoTMk2j603yi9?=
 =?iso-8859-1?Q?A3vS5Q61TAX02ACUwCmD3s4ltJSWkw/zQvq+HtcCZ3TzTY5+zeAAz20EBH?=
 =?iso-8859-1?Q?d5oBkZEOlhQ2/6xm5C/gu/TrJ53qey1T3SLaUhW0ki7ibeZcafHu2rgmrQ?=
 =?iso-8859-1?Q?66ZpnKFCLlEPQ/1UrqDI4l5yJebFlj29tSw3bwsV9YMdw72+mWRwJ9QxL9?=
 =?iso-8859-1?Q?YhYEFP3ArEtYJrVAm1ISR8amHo/ndP6nwv39vx9oAVnCRJLS5x+OGgyFMt?=
 =?iso-8859-1?Q?MWABi/Y/QIswRlA+dlRTYLNWNf+OaRyn36Rw8gaOOtgIYd8AF+eVQy8fsb?=
 =?iso-8859-1?Q?hyy9zYCXCab8l270pey3/m66+RyzyyBbMyt5rK0b6MK4G6XOZvBBV1VFOT?=
 =?iso-8859-1?Q?JjafpISuHorWzGaAYf5wBonCH3aKOsgiCaAWSRE96/SWF2lMaja00Q0EjQ?=
 =?iso-8859-1?Q?cOOtRB7L5qMvFxc6KB88FctdW+1mYMVoVIFjttYHDhBkXMi84b5KAt+gZm?=
 =?iso-8859-1?Q?NA+ymjUjM4bghkrXAoi9qH8Cxg4OsXIxJ1pWMSy1i2otIJIPaQGN69Z+MS?=
 =?iso-8859-1?Q?pEPt69clzM2Sm5WsGJzpmT6YKWRQ4Gfd+zZH2PeEw4Gu08CboL0an00ZrX?=
 =?iso-8859-1?Q?9G51j4UIvJQwNru0sqB04r/ljeTy+jL1aHVraBE4yjnKahe+R6i1ddZ3bZ?=
 =?iso-8859-1?Q?veDMuSlqdWR9WVnD5jViZ3OtC27NCvCjFx/sNH0Y7r9QXegfojtB3G/RiA?=
 =?iso-8859-1?Q?ngL3abh6dgixOpXXmf8jT7kKIrTfRsetMHFgbcaD6E9aOlu/d7PKJmc88z?=
 =?iso-8859-1?Q?tdmyCruXCeug6kJSxnBmV19KBCk7mVn4OPlUGn1THtLEJi1hJ4jdPHgQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f6fbe-e27f-429e-8248-08ddcebc79e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:25:05.0124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQhEJASAsG/nxcT72R/8+7mg62N7cZRXDTZraqjIh0KS/MNudbsRX6F7N6EFeucWkpPuRGgSkcCYFjiOfeH46hfYWi+sReJ8F45olPICE+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
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

Introduce the 'startharts' command for RISC-V targets, which prints
or executes commands to power up and reset all harts and jump to
0x80000000. The command supports optional cluster/core count and
immediate execution via the 'g' argument.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/include/asm/arch-p8700/p8700.h |   3 +
 board/mips/boston-riscv/MAINTAINERS       |   1 +
 cmd/Kconfig                               |   6 ++
 cmd/Makefile                              |   1 +
 cmd/start_harts.c                         | 103 ++++++++++++++++++++++
 configs/boston-p8700_defconfig            |   1 +
 6 files changed, 115 insertions(+)
 create mode 100644 cmd/start_harts.c

diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index 6c47de9a633..20868eee419 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -77,8 +77,11 @@
 #define CPC_SYS_CONFIG		0x0140
=20
 #define CPC_Cx_CMD		0x0000
+#define CPC_Cx_CMD_PWRUP	0x3
 #define CPC_Cx_CMD_RESET	0x4
=20
+#define CPC_Cx_VP_RUN		0x0028
+
 /* GCR_CONFIG */
 #define GCR_CONFIG						0x0000
 #define GCR_REV							0x0030
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index b04dcde943a..0e2f4c277d3 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -12,3 +12,4 @@ F:  arch/riscv/lib/mips_gic.c
 F:  cmd/display.c
 F:  include/led-display.h
 F:  doc/README.LED_display
+F:  cmd/start_harts.c
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 298a3ca6ce3..d319cfdbf3e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2327,6 +2327,12 @@ config CMD_DISPLAY
 	  displayed on a simple board-specific display. Implement
 	  display_putc() to use it.
=20
+config CMD_START_HARTS
+	bool "Start harts"
+	depends on RISCV
+	help
+	  This prints commands to start all harts and go 0x80000000.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index a313ddb1f29..baec824260f 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_START_HARTS) +=3D start_harts.o
 obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
diff --git a/cmd/start_harts.c b/cmd/start_harts.c
new file mode 100644
index 00000000000..0d074778b6d
--- /dev/null
+++ b/cmd/start_harts.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <asm/arch-p8700/p8700.h>
+
+int start_harts(struct cmd_tbl *cmdtp, int flag, int argc, char * const ar=
gv[])
+{
+	int n_cluster =3D 1;
+	int n_core =3D 1;
+	int run =3D 0;
+	int cl, co;
+	long cmd_reg;
+
+	if (argc > 1 && argv[1][0] > '0' && argv[1][0] <=3D '9')
+		n_cluster =3D argv[1][0] - '0';
+	if (argc > 2 && argv[2][0] > '0' && argv[2][0] <=3D '9')
+		n_core =3D argv[2][0] - '0';
+	if (argc > 3)
+		run =3D (argv[3][0] =3D=3D 'g');
+
+	for (cl =3D 1; cl < n_cluster; cl++) {
+		cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+					CPC_OFF_LOCAL + CPC_Cx_CMD;
+		printf("# Start cluster %d core 0 hart 0\n", cl);
+		printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_PWRUP);
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_PWRUP), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+
+		printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_RESET);
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_RESET), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+
+		cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) + CPC_OFF_LOCAL + C=
PC_Cx_VP_RUN;
+		printf("mw.q 0x%lx 1\n", cmd_reg);
+
+		if (run =3D=3D 1) {
+			asm volatile("sd %0, 0(%1)"::"r"(1), "r"(cmd_reg));
+			asm volatile("fence");
+		}
+	}
+
+	for (cl =3D 0; cl < n_cluster; cl++) {
+		for (co =3D 1; co < n_core; co++) {
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_CMD;
+			printf("# Start cluster %d core %d hart 0\n", cl, co);
+			printf("mw.q 0x%lx %d\n", cmd_reg, CPC_Cx_CMD_RESET);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(CPC_Cx_CMD_RESET), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_VP_RUN;
+			printf("mw.q 0x%lx 1\n", cmd_reg);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(1), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+		}
+	}
+
+	for (cl =3D 0; cl < n_cluster; cl++) {
+		for (co =3D 0; co < n_core; co++) {
+			printf("# Start cluster %d core %d all harts\n", cl, co);
+			cmd_reg =3D CPC_BASE + (cl << CM_BASE_CLUSTER_SHIFT) +
+						(co << CM_BASE_CORE_SHIFT) +
+						CPC_OFF_LOCAL + CPC_Cx_VP_RUN;
+			printf("mw.q 0x%lx 0xff\n", cmd_reg);
+			if (run =3D=3D 1) {
+				asm volatile("sd %0, 0(%1)"::"r"(0xff), "r"(cmd_reg));
+				asm volatile("fence");
+			}
+		}
+	}
+
+	printf("go 0x80000000\n");
+	if (run =3D=3D 1) {
+		void (*addr)(void) =3D (void (*)(void))0x80000000;
+		(*addr)();
+	}
+
+	return 0;
+}
+
+/***************************************************/
+
+U_BOOT_CMD(startharts, CONFIG_SYS_MAXARGS, 1, start_harts,
+	   "print commands to start all harts and go 0x80000000",
+	   "[<#clusters:1-9>] [<#cores_per_cluster:1-9>] [g]\n"
+	   "    - print commands to start all harts and go 0x80000000\n"
+	   "      If the 3rd parameter is 'g', execute all comamnds."
+);
diff --git a/configs/boston-p8700_defconfig b/configs/boston-p8700_defconfi=
g
index 3df7ffe50b3..85ed687107e 100644
--- a/configs/boston-p8700_defconfig
+++ b/configs/boston-p8700_defconfig
@@ -72,6 +72,7 @@ CONFIG_OF_EMBED=3Dy
 CONFIG_CPU=3Dy
 CONFIG_MMC_SDHCI=3Dy
 CONFIG_MMC_PCI=3Dy
+CONFIG_CMD_START_HARTS=3Dy
=20
 CONFIG_UNIT_TEST=3Dy
 CONFIG_UT_LIB=3Dn
--=20
2.34.1
