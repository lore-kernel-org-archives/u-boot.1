Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C2510F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3901D8418C;
	Fri, 27 Mar 2026 17:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="paXxURgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1264983FC6; Fri, 27 Mar 2026 15:12:15 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CD981E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgVGXtm3cj/FOtUjBXp3VKVLa6kSb+wX5A34uYTo+H6S0B9DzI9W6OOg175LECm+SCoCC74NY4vxzU6YovnUVWkfYQ8vcAMjbQt0I1XhmzZtCwNqPcG9DU0XrkwD+S1QCp9umuEmNorPpCQPYkjHryMTJFBt4BMEy6OaWwZW8BDUA11cc/kqESHLuZ+o7Q68n+ZEvxqIgHDf/n+LFtrFa3SInqPZHingkXaQ424V3N7K6IjtpujF9BUzpYUzVL5YXPyQ+fYSM2hMgRp9idmCMwPXjG2HPnRxAjxTjTLxuQWH6JrPT5bQalTM3yiKCD4WLWTNM4jhBUMR9PFu3thbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUxEmHw4iY+h6ihOT2E4hZB2UyR5IahxXQePz7MxmAc=;
 b=jwudpqpNJqLrqnXROGQtelqxwuvz6Eec0st4j1wxvG2SSKThuy0RFNUkGN3LQkFceLNZw8kOZfWORf82Dv4sU/rzou6Gs54A4lf/j0j0DYuYZhJeYKlp+HEqeyjFzmHdu8PxfU9HZGnJHYVmUT0cmSfWUs7PO2fojx77b5/SPIcn97DmFLS/lgac7IAPeGVuU+DXyO3oahlf8m4VGvLmOkGBSlZP/PESYjlVS2FYVWjle0sUXniCUIczG55Q0uWEiNvF/MS+L3NjYI13PpxFn4Z4eow9r0fth1d4YwuoUjNWNnQYwikK1Hfie6orAMk+RhxaOWiKjQOtdziV2Dn00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUxEmHw4iY+h6ihOT2E4hZB2UyR5IahxXQePz7MxmAc=;
 b=paXxURgfl6S0x/nb/GsbeoyYvsSLaw9yJgza02H9Ka/LmEA11gAZwZR8GViogxte3IWnOMIcLz5glucVNJ0h3OnAJwWTZqI2ZK1jgm4o0xACMC+NxmAIMDg6R8qBL6q19NpzxAouM9Qu6+h/YgIVW38g4F5at8DAWq5FY1b9rNQFVsql5Ea91wAQyZni5JePodb8JKt/jJ2qMT5rgLJ3oB81AnJX480jf0HBU2CanTZIsChisCy/HlhUNO+nxHS4m7oFhi0RU01OMrhjBSsgQQzeNGSsKd51VqfABBUqCPK+CFmNbMtFB/DMLFjavO3bVIHaWtjXFa6fqDnBpUDK+A==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DU0PR09MB8167.eurprd09.prod.outlook.com (2603:10a6:10:5a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:12:09 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:12:09 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v6 2/7] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v6 2/7] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHcvfOzrd8wJ8stDE+IQR7gNy02mw==
Date: Fri, 27 Mar 2026 14:12:09 +0000
Message-ID: <20260327141029.628483-3-uros.stajic@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DU0PR09MB8167:EE_
x-ms-office365-filtering-correlation-id: 9558d634-4b02-4f5a-b5dd-08de8c0ad5c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: qPMhoHIG17wVaELCz10Xvf5Oq4gg/yafs0AilgE43UmtzJ0SjqRN9NEe6QOiAYfAJ8ZN2gPz0aS8G0Q6R49ljfl2QOwFSQKpvwtOF/h5ziqwoJ6m/X8MZoKji3UzC4WK7CAHl2g22IfcaUVFdm7DYWKWk4XASUq5UhtsDLdI2eEFwJe0K/AGMOtwi+TmzvIfSfCDVNQB6Xa9SkBzfQmYvOrCC+cH/IuKud4k9m9LhJL5cFsrVFZfjfUppd5g2NR9bZnFg4NoZxF/Om4VsLkzO8eAfRVLbG4ah0IDCpnqGY/iPstE/+G60WXbbA9EemzUuboT5B5HgB+oDL17lys2qPReEOTKcwQMOdElIB5BZ/P9NvVeINXyPQXUUWPEQlcHZJuq2PVJPeUfnXWQn1poZ8fBfRqmgjPXKm49ne7nuQNBPQUvkPALD4485ceRfXFKEastiRkDgWEVMY1bmNto/3+L5888JjGsfsqDoj5A9h/zBUBxv2v9hlsXhGzkxlUgHC63hti6p4VCnnpOwbfunrOuhYLb5eu0ME8lV3X3BLZJrSgwIL43FIxHWgzKug/+K0x2/uSsySBAciBZKeEKsXSciMAvf4cIC4GD90pzRHYvvkKSZj//jKcG+IHO/lTn7/glOqmUcwBJ9qkLZYhMAzduVXCw8ZnUq7DVQvRYhZGHDrAmIYFNZtl4JGR56Ckr3BYbWajPgZjXag5u59EuDTHeBoiDe4Qr9Ty3aU97HvRbqu50BXPSnLSKaLN4SG4VbuMkFdtpRJZqw5xC4Pl3uSwcrZBW9IA31104sz101sg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k5NPE9Ncj6CnHAdVLCazorZ4tK7F5JtxSO75ymTDuborUBSTNnzb5D3Uzj?=
 =?iso-8859-1?Q?Jg+NJ0Y0yYxsL/r0hAffCgZ1MHFN5lOvz5De4XRQMpAdXlqlctX6w1I4cV?=
 =?iso-8859-1?Q?nLNM5bO1ruDFxu4ATTQMdXPglUlLAiO/WdT4fpfR2H6cx31gFvX5wkt213?=
 =?iso-8859-1?Q?zU9ewHLkGN84Tu3k8De2PoxxQ+tq6iy6qzKz0z6ROorQrq90qtQbMCIwyY?=
 =?iso-8859-1?Q?SXWeDeIiE8YgVHxC6J8YIaRsixSOjmhL4up7Cx8iaIDwUclM2horWd/muf?=
 =?iso-8859-1?Q?d1eAQyJkziz1OR1M0+EvGR/+oBcFD45z6nfujhu5rKMfg+qf6p3dmOHlXs?=
 =?iso-8859-1?Q?jhvhdxgLnh5kiKR2Irt3W5Ybm8gYL4Q2RWOFfsr0bEyhjQzmd5MPljm+S8?=
 =?iso-8859-1?Q?ycrYYWXsVvZ35kWgvX+iXFA0wl+GMjezhbbPXp2LQaZ/qLW3PXxTOGLaG0?=
 =?iso-8859-1?Q?JBj/XkKNn8i6OCJor8jsmQk4EeVTMkWsS5z57HlOXnhYWmgDuNXEU1QgbN?=
 =?iso-8859-1?Q?9nBXYZAKemRdWmJIh301Nx5OBKggs4DUvV+ByK0v69hmWcb7CWnB3M0byH?=
 =?iso-8859-1?Q?3AELEDQlCXKRpD8XUiHzYSqZ9darmXqUVylhMLWdsR77lAte9u2jeTtt1D?=
 =?iso-8859-1?Q?shtFXW88dHqza9Sdzb3GWw4t4zQ8uX3thjSqt7rqVUQV5QIj4/H2+noFFl?=
 =?iso-8859-1?Q?rPueFQq9PQfrsCYhdsRLdiHZWD01BiL3dorqe8QXVqO9YE8lAXRdpAu1mm?=
 =?iso-8859-1?Q?yM0dpMZXuRE2nTtwAtraA3+idOHQHH3xT++6k2jK4ofjCfJFjsvMf7Q5Uq?=
 =?iso-8859-1?Q?BKvv+JwlwuOT5hjxxGqDw9b3P4bIW73PAmhl6uXJWwl+kVk//11xOtKECr?=
 =?iso-8859-1?Q?/AXKfbGVdXQAr/RJI/y1oCbGgYjpOrlpxcWkQ/FEUgBqPkhfQJ5p/0XKey?=
 =?iso-8859-1?Q?NS3mIzdoqVXJ3Mdg6Vf31N1ah0BNFHv+usUAxiN4MLIQCid9DV860bMm28?=
 =?iso-8859-1?Q?9DRtgS289JJzmEv6vC45RuMiYah5PBiC0fNKpM4mDmtM17boMgx/j7md4w?=
 =?iso-8859-1?Q?QXB7rLQpEJ+017//dVF66x2+SVc9oTIPww3CMe5Ik9Dl5yFyrgYmxbC+kJ?=
 =?iso-8859-1?Q?EA/vDEoWLddzxsTxN4WC9pY8aA+F6/fHRo83rh0AQzQM/RTRguVd5Wakl9?=
 =?iso-8859-1?Q?Vm63ND3/H8w3LyPeGWba6XTzWyzHTrN3YtNuekoiXLnZe4VkCzChwdZgyR?=
 =?iso-8859-1?Q?wseC2gB5WeebQ6CkRGwK66/3mlQ9Epzk85RJhfz436AcbsltimoKI8bWyj?=
 =?iso-8859-1?Q?9ea+f58oVzojp1IAvycAvtQwJe4pP9D/qx98SwIrQzoCPvrzTXJnWIKDZ7?=
 =?iso-8859-1?Q?adqwRk7zt7+fQrRjU0pj41ZQRwAPfireus/+kaVmCjpN9UENezY+9F3Bq0?=
 =?iso-8859-1?Q?i4xYEOUjGKBb/TAN2UYPpVf4rod40Dt/x9pB5zBtEhrhwLjooiGr+WKN76?=
 =?iso-8859-1?Q?iBSoT4h2xwxV1qP1nDUvDqP/pF0YkAhTexMBlVAVe30sV+VhQ3yD8W8Ap2?=
 =?iso-8859-1?Q?fNmyST3Iia48glA9nNT6qNFenrR5J5sXrhP9zmrFBrZHWCBZD5ekiJyBo/?=
 =?iso-8859-1?Q?n7OCn0QSxWBWccHU2TjJew/eJIpEvEM+1WXIpB7gb9eHrM1TlcEW645S4B?=
 =?iso-8859-1?Q?5A/HRCffbcCiiZS01ki8ADGa7GwilpqCKrAw/PJUObDdeU1ls5xwrhJcmd?=
 =?iso-8859-1?Q?s+DTvgabnMJ7gFWgl/51f/aROM8HfEfcaqnSblm0RZI1Dc0SYGEkPxz1h2?=
 =?iso-8859-1?Q?VBsNJcTZb6aAPPnDQ4QMIagYJfABWOA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9558d634-4b02-4f5a-b5dd-08de8c0ad5c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:12:09.6933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: msE1Mi41Uap/a+HkC0fUKHoI9bQElCOAXhcZRF8JZRcroVrdlyP/7RN+iv/TGIfL+Wwz9z0mzDm+hHbslOl3m01RBMqcqYWaKAvAQqyTpb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB8167
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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
 arch/riscv/Kconfig                      |  11 +
 arch/riscv/dts/Makefile                 |   1 +
 arch/riscv/dts/boston-p8700.dts         | 264 ++++++++++++++++++++++++
 board/mips/boston-riscv/Kconfig         |  43 ++++
 board/mips/boston-riscv/MAINTAINERS     |   9 +
 board/mips/boston-riscv/Makefile        |   8 +
 board/mips/boston-riscv/boston-lcd.h    |  20 ++
 board/mips/boston-riscv/boston-regs.h   |  42 ++++
 board/mips/boston-riscv/boston-riscv.c  |  48 +++++
 board/mips/boston-riscv/checkboard.c    |  43 ++++
 board/mips/boston-riscv/config.mk       |  15 ++
 board/mips/boston-riscv/lowlevel_init.S |  18 ++
 board/mips/boston-riscv/reset.c         |  15 ++
 configs/boston-p8700_defconfig          |  98 +++++++++
 drivers/clk/Kconfig                     |   2 +-
 include/configs/boston-riscv.h          |   9 +
 16 files changed, 645 insertions(+), 1 deletion(-)
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
index 9e2cbe775d2..1d27e999340 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -61,6 +61,16 @@ config TARGET_XILINX_MBV
 config TARGET_ASPEED_AST2700_IBEX
 	bool "Support Ibex RISC-V cores on Aspeed AST2700 SoC"
=20
+config TARGET_MIPS_BOSTON
+	bool "Support Mips Boston Board"
+	select DM
+	select DM_EVENT
+	select DM_GPIO
+	select DM_SERIAL
+	select OF_CONTROL
+	select DISTRO_DEFAULTS
+	imply CMD_DM
+
 endchoice
=20
 config SYS_ICACHE_OFF
@@ -119,6 +129,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 9b347fc3b50..63e3bd4c95f 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -16,6 +16,7 @@ dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
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
index 00000000000..8207017c6ce
--- /dev/null
+++ b/arch/riscv/dts/boston-p8700.dts
@@ -0,0 +1,264 @@
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
+	compatible =3D "mips,p8700-boston";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200n8";
+	};
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		timebase-frequency =3D <25000000>;
+
+		cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "mips,p8700", "riscv";
+			reg =3D <0>;
+			mmu-type =3D "riscv,sv39";
+			riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c", "zba", "zbb";
+			clocks =3D <&clk_boston BOSTON_CLK_CPU>;
+			clock-frequency =3D <25000000>;
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
+		clock-frequency =3D <25000000>;
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
index 00000000000..bada4b6752d
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
+	def_bool y
+	select P8700_RISCV
+	imply SYS_NS16550
+
+config SYS_CACHELINE_SIZE
+	default 64
+
+config SYS_SDRAM_BASE
+	hex
+	default 0x80000000
+
+config SYS_INIT_SP_ADDR
+	hex
+	default 0x80200000
+
+config STANDALONE_LOAD_ADDR
+	hex
+	default 0x80200000
+
+config SYS_MAX_FLASH_BANKS_DETECT
+	bool
+	default y
+
+config PHY_REALTEK
+	bool
+	default y
+
+endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
new file mode 100644
index 00000000000..d03491d0f0c
--- /dev/null
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -0,0 +1,9 @@
+BOSTON-RISCV BOARD
+M:	Chao-ying Fu <cfu@mips.com>
+S:	Maintained
+F:	board/mips/boston-riscv/
+F:	include/configs/boston-riscv.h
+F:	arch/riscv/cpu/p8700/
+F:	arch/riscv/include/asm/arch-p8700/
+F:	configs/boston-p8700_defconfig
+F:	arch/riscv/dts/boston-p8700.dts
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
index 00000000000..60343368a68
--- /dev/null
+++ b/board/mips/boston-riscv/boston-regs.h
@@ -0,0 +1,42 @@
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
+#define BOSTON_PLAT_NOCPCIE0ADDR        (BOSTON_PLAT_BASE + 0x3c)
+#define BOSTON_PLAT_NOCPCIE1ADDR        (BOSTON_PLAT_BASE + 0x40)
+#define BOSTON_PLAT_NOCPCIE2ADDR        (BOSTON_PLAT_BASE + 0x44)=20
+
+#endif /* __BOARD_BOSTON_REGS_H__ */
diff --git a/board/mips/boston-riscv/boston-riscv.c b/board/mips/boston-ris=
cv/boston-riscv.c
new file mode 100644
index 00000000000..f3fd2ec8348
--- /dev/null
+++ b/board/mips/boston-riscv/boston-riscv.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Imagination Technologies
+ */
+
+#include "boston-regs.h"
+#include <asm/encoding.h>
+#include <asm/io.h>
+#include <linux/types.h>
+#include <asm/arch-p8700/p8700.h>
+
+#define PMACFG0_PMP3_SHIFT	24
+#define PMACFG0_PMP3_MASK	(0xffUL << PMACFG0_PMP3_SHIFT)
+#define BOSTON_IOCU_NOC_OFFSET	0x10
+
+int board_early_init_r(void)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_MMODE))
+		return 0;
+	ulong pmacfg0 =3D csr_read(CSR_PMACFG0);
+
+	/*
+	 * Make the flash region (PMA entry corresponding to pmp3) uncached by
+	 * setting the CCA field in CSR_PMACFG0[31:24].
+	 */
+	pmacfg0 &=3D ~PMACFG0_PMP3_MASK;
+	pmacfg0 |=3D (ulong)CCA_CACHE_DISABLE << PMACFG0_PMP3_SHIFT;
+
+	csr_write(CSR_PMACFG0, pmacfg0);
+	asm volatile ("fence" ::: "memory");
+
+	return 0;
+}
+
+void wait_ddr_calib(void)
+{
+	while (!(readl((void __iomem *)BOSTON_PLAT_DDR3STAT) &
+		 BOSTON_PLAT_DDR3STAT_CALIB)) {
+		/* busy-wait */
+	}
+}
+
+void setup_pcie_dma_map(void)
+{
+	writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (void __iomem *)BOSTON_PLAT_NOCPCIE2ADDR);
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
index 00000000000..498ccb15b4c
--- /dev/null
+++ b/configs/boston-p8700_defconfig
@@ -0,0 +1,98 @@
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
+CONFIG_BOARD_INIT=3Dn
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
+CONFIG_BOOTARGS=3D"root=3D/dev/sda rw earlycon console=3DttyS0,115200n8r"
+CONFIG_BOARD_EARLY_INIT_R=3Dy
+CONFIG_PCI_BRIDGE_MEM_ALIGNMENT=3D0x1
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c88931c8ec4..3d5829544ef 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -60,7 +60,7 @@ config CLK_BCM6345
 	  clocks on BCM6345 SoCs. HW has no rate changing capabilities.
=20
 config CLK_BOSTON
-	def_bool y if TARGET_BOSTON
+	def_bool y if TARGET_BOSTON || TARGET_MIPS_BOSTON
 	depends on CLK
 	select REGMAP
 	select SYSCON
diff --git a/include/configs/boston-riscv.h b/include/configs/boston-riscv.=
h
new file mode 100644
index 00000000000..f1ee6f6032a
--- /dev/null
+++ b/include/configs/boston-riscv.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __CONFIG_BOSTON_RISCV_H
+#define __CONFIG_BOSTON_RISCV_H
+
+#endif /* __CONFIG_BOSTON_RISCV_H */
--=20
2.34.1
