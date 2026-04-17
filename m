Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4991F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:48:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B87B843E8;
	Fri, 17 Apr 2026 14:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="he8ORSig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 815A8841C2; Fri, 17 Apr 2026 14:24:48 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F4BE83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goa5iYDcMP8lbPVsVyFvV6rwVRsieS4ovJSM61KoaEq0RUYtyrwdSDm73BeohEl2mCDcJbQqCJDokaJK5XiaVMXH56xd02APEiB4OGhd3w4szMdCo3f1WsokAdVFWz8S2YEn2pDxwNAqZc3+RUsM3S4tfj2587B684R3hwSvljrgQ0Mt1lzviUCLzWcLtl8hS9x17Oalsq9AcWyVm318fQjkJQ/KBgU1ZEK6kegO4z9at3SVKzMu2KOUdiDbxSGO9/koasTVvlSIc8vFguKaMuex6jvZ39Jt1ih0hdhFUhDFOBBMk+QeY3QIU0eHZzMoJljwMIGkz10v02JHSIXf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS62jmPpz4EvZU+yyXL28zidCmbVLcgpI7lG0IhmWK8=;
 b=clrfAhAmFcthv8gVxebgnz0T/M7ltZLx3nV5riLubioHqYw3UwMUYliD1ALD52kysxBeQTEoV2gafN5VkNHGcI9oUzt5EdHEfCfMJPVnVsYTnpgVpa+lhedc2hwLnb1G3tdA20jXe74R71JXYJfkb3ix8RQ7vEqNskXfp2yE1gRChXp6+o9T3WPLkJ7M1ZWJJBp6SQ49HGEfpmVIaH8YeqMPH9HO5UOQqsUdJLDRlZPE4ZDK+Q66rpu71lESQnu3iaSh9fO/KE+E0BpruIUkcbyzTSh3O0ciqkjcEPPT3dIOYMnMUt4d4E2NLWPN11mwUrMPh6Ll9jGM8yalzY0W7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS62jmPpz4EvZU+yyXL28zidCmbVLcgpI7lG0IhmWK8=;
 b=he8ORSiglSKf3x8Q4teinFZ+r46cXqe2L+wrGhH5wd9UDOmyPAiTwR9ELWFzdQn333K1UMNgDM2YgA1CXNr8k3Iex20ZwUf1muhAfIXS2z2LPx5q4BTeXtDskg1mvx2RfjX9ZN8J/iqEW4vMfHQqmXtbKuvl2F1ZwwCtMjDgJo7yXjKHvKduVFa6QLrTDlfiq6mguuOjMTFNAIAX5+9IEva0cKgMKri1nZKV3KaOuUBvMO8jtwjtCI+N/XcEIAF1evsqS4DH9t7+99BJGq54Y2hXbkl1iNFe6xLGHJ4B/yXGTYMcC5x8Fz8B1uI8xmuPWAJW0GW+HWIixcsDwILdmQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AS5PR09MB8577.eurprd09.prod.outlook.com (2603:10a6:20b:753::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:24:44 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:24:44 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 2/7] board: boston-riscv: Add initial support for P8700
 Boston board
Thread-Topic: [PATCH v7 2/7] board: boston-riscv: Add initial support for
 P8700 Boston board
Thread-Index: AQHczmUr+q3l+GyXmECbO0GpqEJK8Q==
Date: Fri, 17 Apr 2026 12:24:43 +0000
Message-ID: <20260417122213.147529-3-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AS5PR09MB8577:EE_
x-ms-office365-filtering-correlation-id: 8af9b3e6-984f-4ac4-ae3d-08de9c7c4e4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: p20gIYjUrRqAJYY1uGUNgJ/CcdAxlMpCs1QmTCtB2jNebqcBHCuowYYV/hE64w/zdoauowGn9LlOLfQVgtlIoTrOsHWCiyJlWlUNapC4navqN9WDG5J9TOohjYnXWL4tkeJyL6MEHQ4Tw8IZuHaAZIyLX69ye1b0W+SMiCe+QeUixqRQ44RolDPpK6Lu0uJMNrFTDZHySniIG1JGNGgNad1DJFLmfgUjy3QizYrkcaxokwsATqqcfjslscgW512rwBf0Ci5y8hqEqXZt3t2V4OWdWcIUz9G3yL7AzJ7jbO7dE9imE/Qko/XqnXUwwFV+Zx+04948B/BW3ISWX3X1S9PdNpZQk1AOoLjrn2yzIcL85T+u7dtCpNoE1K5D2V2vQ3gDKLdv+hSB0p91YY5kZzJviZ+ZM7StrYUzWmngmymED+5wYH3RKCbTbDyQFqzdQv/WxQuIGQinuKCXM2TxB+91lSwcNrhBzp+fEx7GOrNtLg+mhrC5iaRggsySatyKUBd3z1YcOk8XBhRp5HBanwWGraIJGpzaajeQ7k/hPm30xEdoJ+uV1ILApYAZbyl4eE2hEqdrT1aEJ6jLxWUW4BIqd8h+MXYUnYUFwBHmQdnUuca7cOKBNQovPjAnJB2l6ur8vH3FQoZpY894oiolQW72Lu0TrcjDY10R5JHULs2psuUmfE9En1CkS1ObVhjvgsLGFnJDQYQt1vgY8ddBYhwpZsZrx7nAoLs6ZOLjFo79OgE8kX32104hb1TL3cUm6lWY3m8lrhZUsnig/FKrHasYYky3eY101yeNZ9kSOSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tFjpjmz/7dZyYa39zbP2WQCz//bY7LVshDHtLzrHC9PlFjnXegUFBV/3Ij?=
 =?iso-8859-1?Q?uPSqc29zPDVGL1N34JAkwz8IJ8tpFOfNxLji1PTjVkENurMbIxlj6LYGdI?=
 =?iso-8859-1?Q?UMOanfSHloxaHCUtYw5hEORx5LTmmCuPHol0XEWzdz0OYHSVxr6LJn4F+B?=
 =?iso-8859-1?Q?plaBnt/o89i0W/hrAvem7gvojC0jrNagqcCygskHuyUYqPN/BYazrFDX+l?=
 =?iso-8859-1?Q?ZJowdnYM9gy7pFRHM2BwkzQsYZWok1rNnvE3MLB+A3Z21yWnAYQ1v7IMlt?=
 =?iso-8859-1?Q?vStEuxKjz27pgQqFKWUxZH+e7i2vnCLwLmu4+RoxN6w00bEjUnCGo+4xMg?=
 =?iso-8859-1?Q?D8tWzQUHw1fKwl8ICTNABWFDCQQBsGs90RZlrqb6PiXMxcL7HVJhlvSxIm?=
 =?iso-8859-1?Q?wP1A6trLo5f1BXfMF+LWFefyCFA6qIwzdPWiLvGsCVnhgpP0aXhoy9G5Ma?=
 =?iso-8859-1?Q?Rv1xdwNksAbT0tOYn8B4M8VJLcHX/99P+ZC067lu+tiogrdO1ez80EbqRs?=
 =?iso-8859-1?Q?6z/UnGQj9e58bV3j7dzYOMx6lz9t1YBNJkMMHwvlSp0mvlK9d66nei+Afp?=
 =?iso-8859-1?Q?ZzO6ayGmJTpQP4KNtHlvxtxj2bEdq7lXixbHOiZx5uQCpSS7we+mIjkhFh?=
 =?iso-8859-1?Q?uTrFHuicbxnPjIMYM+SyPZYNBmJ2KvRSqGCTWpzdCWoIZjkjGCKfTwiOmz?=
 =?iso-8859-1?Q?WyFlFXZJl6nVmBr4xOeo+jhG8/NpKwxs3+iYFE1T4E7kJJ5h5qUqoWeVNU?=
 =?iso-8859-1?Q?QChGd3QfeM1Uikpt/B8wJUBXv4AVlkvMwdLc+kNTEpYvR4j6xW8wX8tU//?=
 =?iso-8859-1?Q?GX74Izetlsj+fpakESNNMJdhlXIjdovEevOERZClT17PSuVMJPcr/6JV8y?=
 =?iso-8859-1?Q?3+H18ON1b233skHRaXaQgK+vivIc87A2s8hu8UCsFAhmFBbMrL482AnFW2?=
 =?iso-8859-1?Q?fkM3ghnnKzEnyz+Zl+kDoeMV9qo5tNRAXLkESb8PUrNpA8RkVAqrPK3eun?=
 =?iso-8859-1?Q?mOxkzr0Ev/2u7H2k5QcVjm4S4ileoXjP//44oBHTOO5PEyhVicCERO21JP?=
 =?iso-8859-1?Q?SyRKWJrSfhMRxRbm7ITQMvUyAmxMquhIy12ps9pj9QcK3bwK9eifkkOo8/?=
 =?iso-8859-1?Q?rIecc7SrFZlq5pwk5SFCpvuZL7Zp/pbwznojtLmTkhiOkPeCmXfxciwIHE?=
 =?iso-8859-1?Q?bfyXyxk7Sr4gS8tQBJwoTMXMHCyunZaEdlQs2mjPVZ+9jRWLkwORhLM7eW?=
 =?iso-8859-1?Q?J9v+d3L0YE8GIuhBO3KYyBMm+1U04zIZ7k2JS6LpTv3L8D03eVtTacOWbI?=
 =?iso-8859-1?Q?KnX4cLnTRn5/qY2GlfGghPswvpghc5tENRnuFpGeSLNfuN7ttxcfcwQp/L?=
 =?iso-8859-1?Q?0bCBALly6XwBGD6JMj1r5UMDf0CEQOkxIFfr9hRTb4GDLRzRUC66Skqmhl?=
 =?iso-8859-1?Q?SK05j5RoUYwrQhZLoevzgtfJvXgDArs+rQGJs2h9ozyDUYddkTUh05f8nm?=
 =?iso-8859-1?Q?aMhkKaZH/OEGTRU6Lv1BxlKQCFbidjWFDUvOitDG3J5eqtax4Vx/Gwbh6Z?=
 =?iso-8859-1?Q?YHCY5sbMvGXKUxQ+6bpKrM5RpsNNtp2p42cO872E5xzhVzXVkja/fKGrVT?=
 =?iso-8859-1?Q?Vrio6ZtwzPRJScZN+XQp3xKAwUXkeG+1NqvEPf9Jjd4Tts2pmxB++AL2pu?=
 =?iso-8859-1?Q?WcEggexAu4pHU4y6vsrkcaBHManCtpyhJYhicZH4daPgHt/K8Ry80tqnPC?=
 =?iso-8859-1?Q?yffOGgFinY62/WfpKPC3gMJWV+Xjgf66FujOiPw79ZRmsrKlWNuZMz1rOG?=
 =?iso-8859-1?Q?cb5fG+7H3zzRlpI5Z3SBhl7Pz6KQfHM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af9b3e6-984f-4ac4-ae3d-08de9c7c4e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:24:43.6310 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5DN6QPqhCaEzsdJOqBGrRorCLeiGG9UVnK4vL+O0Rz8g8/nRBD6hTixx0XJPzETX7sZ8lbsJy9CJ7b3piSzC6+/2JKdCFQcOKwaSeX8GDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR09MB8577
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
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
index d3380c3ac3f..edb5e6da10b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -64,6 +64,16 @@ config TARGET_XILINX_MBV
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
@@ -123,6 +133,7 @@ source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
+source "board/mips/boston-riscv/Kconfig"
=20
 # platform-specific options below
 source "arch/riscv/cpu/andes/Kconfig"
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..0ec297b5c45 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_TARGET_XILINX_MBV) +=3D xilinx-mbv32.dtb
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
index c2da7b3938b..16278ca42f3 100644
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
