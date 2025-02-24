Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D2EC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 11:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7471F805C3;
	Mon, 24 Feb 2025 12:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=philips.com header.i=@philips.com header.b="UylVZaeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4BB805C4; Mon, 24 Feb 2025 12:43:43 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 174CB80079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joao.Loureiro@philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgzUY1+ymBLxdgt8nss3rllShALUm4rc2xZ/lrjU/ajFX3HMTYpZrKqJcEXHrluQqkJ+tBp9n4Tfwnx7CXRMGRW3COlXZ/HlMGhOtsjtDrFKQgUsbFw5C4ZUpUoIihu3lTJSqIQshLsq7B7iWuaZgNGGxggHGbUz9WOoizIwxIFa/LKSzEREnIHzgYid/FfwZiFwPp8tamBnJyEbTzeQ13+pRCoM4yeqPB9Pyx8w0zCOnBq5tPZPwr1ZQJbzjCWuJCmG5cu6jWVYuqzgACzIv96ydhXXFP10m0L4nTvwxuY1s9Gs+uECCq782LAVYCmf7Gg2+sskLsj3doSpFJ9u3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/iTusqLpqqjJUkBj6HrRHrwFTrJ+rICmeO1NvUPxRQ=;
 b=wIeSxqp1SlqO9XnP4cbZWxEP2PiowIIx/vLjkE9Bt7PJHXODTZnd2xrcKHdke+dkQflNynvHotexdMP8aUcJPmY2vBgmLyPO5sEhiFsn0mNvMWei1YIGcI3vHXe6tkpYnbbEsFBV2nQ6S1Zo0NRsOzUJPCSzcvCMKnGV+cRBtIgdVlyWEuZFIp83LSrM3w5tvUfU/Li1DTZDeEyGaUsVD/DcjDfycNYTc/I5hzFaFsYgk0DKGUtSbYUoy7AKjgNUPjhnCy6sd3Mz3V0etxXW+jwiUzb61lAzt4rOJy7L+RRvmGnYfoXnLq3+w41Yt2MRhFfFusbcik5CVP80eLZ+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/iTusqLpqqjJUkBj6HrRHrwFTrJ+rICmeO1NvUPxRQ=;
 b=UylVZaeR48IJI3BN3FuaGhiD4g8xd9eiob1Pi6/wUyXg5VHNxBj+Ka/NFZ4CzDQPr+0RBOCUn4MWC8JRyepQ9nBN2SO6//kEKDPiYuogeTMS0yj1iuAixSQj0ii40J8D7CQ70lAHchPsoDYw0kFfQaSTTymO6zcW4aldz0U7ICU=
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22c::12)
 by AMAP122MB0213.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:196::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 11:43:38 +0000
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b]) by AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 11:43:38 +0000
From: "Loureiro, Joao" <Joao.Loureiro@philips.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] spi: Introduce initial eeprom driver mode support
Thread-Topic: [PATCH] spi: Introduce initial eeprom driver mode support
Thread-Index: AQHbRj84f5EMnTTax067/csVC11AfLNW1B/x
Date: Mon, 24 Feb 2025 11:43:38 +0000
Message-ID: <AM9P122MB02813D5E7C97871951B4EEC0F2C02@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
References: <AM9P122MB0281B0F2532C22D6EE4917F4F2372@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P122MB0281B0F2532C22D6EE4917F4F2372@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P122MB0281:EE_|AMAP122MB0213:EE_
x-ms-office365-filtering-correlation-id: 90c17afd-0858-4387-cff7-08dd54c87a8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?L2HOgEi+puixn0t5I3sRDt1u1Fh06AxxSWh0KrqjQrMo0NQIjcgDrPTog3?=
 =?iso-8859-1?Q?bhushbd8wzW4dj4EtkXnJtuumqVvkrWr5seJxrSQlBKqC/GXYnzwGsFwqu?=
 =?iso-8859-1?Q?Ng48+4M6/Vl2GSz7MvEO9fiHqrQUYnAOp0fHQa4NTF1BwkrFGv92+zi2+v?=
 =?iso-8859-1?Q?3Dr9vKcsqB9JQZHek0/QX43GgctfuJqdAqPd8TFoGaH6OzgpnBiXyTQxvU?=
 =?iso-8859-1?Q?nkaGIOYkLHind3PKUq+/139wmg9+oimH5TX6fGsCA9fNA6qulgNKrnoXye?=
 =?iso-8859-1?Q?b8pVTBPxFazd73gPw7s9d7aV/352LPODb7UQCIArgETDTcdkzrHFvZqxN3?=
 =?iso-8859-1?Q?s0Q+ht+pHIpuTYSJqzbHPA4g5oZH8Hmr33cd+VwobsS+8tTVal8agMxyGu?=
 =?iso-8859-1?Q?Nss+BdgRhSQSerh0S5ux1aBqtb9+48UKjauHTr0PTpht+ym+hUD5ORkvXH?=
 =?iso-8859-1?Q?HBfcVxrUu+zBIwX82smllQc20bDbJvrGz0j1QulyGZ3NCvith41o5nTeUh?=
 =?iso-8859-1?Q?VGyQTJ3GkE42uaNkddM9wW+0AdwuCYMnQveCEqqSUPka+oS5NLcLADjtHD?=
 =?iso-8859-1?Q?pU75IRVFiaQFCdKk/wCSXrXIKgf7/hakNCfEaQlkWkyWm5QyKHichQ7LnE?=
 =?iso-8859-1?Q?G6q6yrB5UBW7cAlBA5D4BgH4X21DDlinXZUw2VYkyUXejWgAyyUpzOgpeH?=
 =?iso-8859-1?Q?Z8ZK9P/l+T8X0SpTKxzPK4/OzGDMu2gSN7vF2Yk4hxBJXXlBT1qs1QruNP?=
 =?iso-8859-1?Q?TJ3I1tdzwndMn2lu8DQ3xxN2RJ6Syj6c1i7IvOgBj2/Tm2opCfHdxz5wBQ?=
 =?iso-8859-1?Q?hO7sFwO03nL3ddlnxbx/vrQq/8G57x3UMoVG8VaJlP7JsrJzGvFQyRnHo4?=
 =?iso-8859-1?Q?KezkWaAaG6Rc4zf/jL6QIubMIqBPIDu1gDGT2CEo6WvPRKIYiuYN5q9M+S?=
 =?iso-8859-1?Q?GuqHJBIEc0o8ZNWDFq7XsLtw47WVruYE89vxyUieoo/yuAmERg/UE61HHw?=
 =?iso-8859-1?Q?LLD32e8A8qABxQSqsNFq0n80PRUAWl2kX2I1QXc9ijO2WVgZj8i/0veGYm?=
 =?iso-8859-1?Q?HmX/8oME59RF8NzTXZJza9zFpDQtVhU552bIzX+Emk7X0+BZ96EzemWzGZ?=
 =?iso-8859-1?Q?5G1gCALaeYf/gfc0xaxVBRbm2pkgKADaAHIL9aHgHLxMF6T6S9OKokn6a0?=
 =?iso-8859-1?Q?MwcyhYyISK5DE6mrLsWBY51ly0PLmop230JzSrWHq0M6k59+ZbZb0RyOAp?=
 =?iso-8859-1?Q?xSUjEg26zAOqs0/4b1rgEpKbciTmZiojyRDW9E7VLfumFHiVDO74iyj+gU?=
 =?iso-8859-1?Q?8EE4g8hdy6G4CdA6wxToXBF3wP4tvfgA7/YOJK1+gJYGp6fjz6C3oKAXUl?=
 =?iso-8859-1?Q?vApUd35b2Yy/eV+nUFPKN8ru4UAYt0NMrUjvKjP+NEyfXs0gVZtHNI+y4g?=
 =?iso-8859-1?Q?murEsxXcVgAzV4S3Lg7l0tBvkpEeV7l/RpdHLBD76hB27DUjahJm4e5HHI?=
 =?iso-8859-1?Q?Uoytd7sgRruOqYjMme5IEp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P122MB0281.EURP122.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mPILssPWNmAgmTsgSFcSSwVTp2amNSSCT43eWODGVDvUhbeKy8laB+e9DS?=
 =?iso-8859-1?Q?Th8zxgo/sqHOCSzWcSNosqNLDdSn6/S27z9/DhwSLmPA2qAtEnPiMAcd2a?=
 =?iso-8859-1?Q?4FaVvWzhxL/9WibzN9X4zSX3VfSX+W5uk2h/erSk5Ee0d+RtQvXsG1br+K?=
 =?iso-8859-1?Q?/+1R4hWgeuGSmczrf+tgbZ5xbc70sg9zSFQp8ha6kPOQ2KwicQvIiw0w+O?=
 =?iso-8859-1?Q?ui/y8y2odlLA7/FvI7IDOz9RCEgWf6Ld1dlntNj81E814NSgJUf4uKDeMp?=
 =?iso-8859-1?Q?aTlKqUPCHhgQ43ZwVy0FtFb6ogEOw+p6JvPqj7z4Ocn6lAsC8pQ6veGcAB?=
 =?iso-8859-1?Q?s9QQKc8oO8jt27fGAWNo7rnXl0Eqbd/ER8go9LmcTxACO4j5J1wn4g1rHG?=
 =?iso-8859-1?Q?aaDwGWLvqJG9JcmqY5QOLYK/yyOz6j/Hna87jROOQpnB8vunMzvVwrMMa9?=
 =?iso-8859-1?Q?keckXzv+nJ1tlZd35eYAcHgJsRpSwEb3NDKHnovx89KxaGqixMPu/mfMfm?=
 =?iso-8859-1?Q?j8x+40gFjFnd/Pzh7GIl3gAVlDe2BiROtsJILh1XDHH34KyYW0jJdzoyCb?=
 =?iso-8859-1?Q?MKiHaNBSPEP6BzN00VHNekHT4By9rPBTkYmvNQMl/8K2qFQTRTJM21/rdm?=
 =?iso-8859-1?Q?mOjk+Zj2gsBWy1hmNhNyCw0kBchB6ewaHTuNZ7R3JjRqBaor1NhKvkEAuJ?=
 =?iso-8859-1?Q?FmvCMeqGp6nOVnLJEpCnU9oGf8CemYy6dJj4o6DGtgLKB9NcnkTBq6EvlQ?=
 =?iso-8859-1?Q?8hfcoztMtbT8PRcxNNifg2by1FIFMvXeN0UOMNZ4SXAiyc074uIYt19chb?=
 =?iso-8859-1?Q?lVmo4FhQgYJuOYREtJt0Yt2YnZ8K3cHECL2MSh2/rqWOS8Edp0DZ5wdr2D?=
 =?iso-8859-1?Q?25gufYfDzgzlsI2gz4AsoH14ZS9yi4G8avIG2V3tq1S55nAcGwRkgixB4j?=
 =?iso-8859-1?Q?08jwG9hXFBxP9Ut4rPceFUXtolOxxtqxanJHltVJ2wqiZKSSOXIvkK5bGk?=
 =?iso-8859-1?Q?Y0piwZXcBtFwOH8XrnaybTVFNwM+gelaw5KB1RMmxiL+ePO/CoNloLwqO+?=
 =?iso-8859-1?Q?xVfGgk8kzaqt05XfAnj/IvBBYxhnZmlksnuGlOhVBovGdd09D70aI80pgb?=
 =?iso-8859-1?Q?13N1nIWbx/u8aqOYzwyEF0zGga/Du4UbapI6o/t57fYX9sTty5D4fP2Blq?=
 =?iso-8859-1?Q?XaXdTLjmjmDIxG0fQAGBIxo8/nkVA520mINWSY/fWcJtfu08v/sRj/3Mec?=
 =?iso-8859-1?Q?3L8IdCA71JONTOn+Yb7stBX81w8iHzPPcYfwHWlrBbEFAim0X2npSpu7Za?=
 =?iso-8859-1?Q?VfVaE6uZwUlJOQ2dfofrtb2JatKsGYu5yYgU+NsylCXYccX1AXnryCJ6IE?=
 =?iso-8859-1?Q?HJLS3RBL5SkUQfDF4AKfqKT5S5sCxni/KMTvbYKY7apzyIJcPHBM1hGKF7?=
 =?iso-8859-1?Q?0HLJbxqN2SuqbMbFK3fScoPnpbBd6Jks0DORs16Bda3NaggltDMJFo+aXe?=
 =?iso-8859-1?Q?b7HFslTWWo9GQtrvDj7hiheNBnD4sVgKi3JpGBeSUToXgS/OTgb69RHKp0?=
 =?iso-8859-1?Q?57DCflydM9ffV8gVEwNOqnSHlq9H2wFQm3GfUirWpNTyPX+MOJxR+MhPgy?=
 =?iso-8859-1?Q?dbilxL01LyRLLkmIjrHWQ1vDCPveBLwFOm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c17afd-0858-4387-cff7-08dd54c87a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 11:43:38.2682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GN3J3HmYVpUZpPu6nM12EcZDl+8PusPZHW/zVbtLikbEOXY7Y2BHlKaLakjP9TDyFvyFk1EHbhexDOxADqKYGwoXsCvVAv2STI6rJrs8NWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMAP122MB0213
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

This patch introduces the initial SPI EEPROM driver mode support
analogous to the I2C EEPROM driver mode support. The SPI EEPROM
driver mode support is enabled by default in the sandbox_defconfig.

Signed-off-by: Jo=E3o Loureiro <joao.loureiro@philips.com>
---
 configs/sandbox_defconfig |   1 +
 drivers/misc/Kconfig      |   5 +
 drivers/misc/Makefile     |   1 +
 drivers/misc/spi_eeprom.c | 254 ++++++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h    |   1 +
 include/spi_eeprom.h      |  88 +++++++++++++
 6 files changed, 350 insertions(+)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 include/spi_eeprom.h

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283..e03ac16197 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -233,6 +233,7 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
 CONFIG_NAND_SANDBOX=3Dy
 CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
 CONFIG_SYS_NAND_PAGE_SIZE=3D0x200
+CONFIG_SPI_EEPROM=3Dy
 CONFIG_SPI_FLASH_SANDBOX=3Dy
 CONFIG_BOOTDEV_SPI_FLASH=3Dy
 CONFIG_SPI_FLASH_ATMEL=3Dy
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f40..22e46c92fa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -578,6 +578,11 @@ config I2C_EEPROM
         help
           Enable a generic driver for EEPROMs attached via I2C.

+config SPI_EEPROM
+       bool "Enable driver for generic SPI-attached EEPROMs"
+       depends on MISC
+       help
+         Enable a generic driver for EEPROMs attached via SPI.

 config SPL_I2C_EEPROM
         bool "Enable driver for generic I2C-attached EEPROMs for SPL"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cd..def79d6ec9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_GDSYS_SOC) +=3D gdsys_soc.o
 obj-$(CONFIG_IRQ) +=3D irq-uclass.o
 obj-$(CONFIG_SANDBOX) +=3D irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(XPL_)I2C_EEPROM) +=3D i2c_eeprom.o
+obj-$(CONFIG_$(XPL_)SPI_EEPROM) +=3D spi_eeprom.o
 obj-$(CONFIG_IHS_FPGA) +=3D ihs_fpga.o
 obj-$(CONFIG_IMX8) +=3D imx8/
 obj-$(CONFIG_IMX_ELE) +=3D imx_ele/
diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
new file mode 100644
index 0000000000..1638a676bf
--- /dev/null
+++ b/drivers/misc/spi_eeprom.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2024 Koninklijke Philips N.V.
+// Joao Loureiro <joao.loureiro@philips.com>
+
+
+#define LOG_CATEGORY UCLASS_SPI_EEPROM
+
+#include <dm.h>
+#include <spi.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <spi_eeprom.h>
+
+struct spi_eeprom_drv_data {
+       u32 size;                        /* size in bytes */
+       u32 pagesize;           /* page size in bytes */
+       u32 addr_offset_mask; /* bits in addr used for offset overflow */
+       u32 offset_len;         /* size in bytes of offset */
+       u32 start_offset;       /* valid start offset inside memory, by def=
ault 0 */
+       uint8_t cmd_read_data;  /* Command buffer (1 byte for command + 2 b=
ytes for address) */
+       uint8_t cmd_read_status;        /* Command buffer (1 byte for comma=
nd + 2 bytes for address) */
+};
+
+
+int spi_eeprom_read(struct udevice *dev, int offset, uint8_t *buf, int siz=
e) {
+       const struct spi_eeprom_ops *ops =3D device_get_ops(dev);
+
+       if (!ops->read)
+               return -ENOSYS;
+
+       return ops->read(dev, offset, buf, size);
+}
+
+int spi_eeprom_write(struct udevice *dev, int offset, const uint8_t *buf, =
int size) {
+       const struct spi_eeprom_ops *ops =3D device_get_ops(dev);
+
+       if (!ops->write)
+               return -ENOSYS;
+
+       return ops->write(dev, offset, buf, size);
+}
+
+int spi_eeprom_size(struct udevice *dev)
+{
+       const struct spi_eeprom_ops *ops =3D device_get_ops(dev);
+
+       if (!ops->size)
+               return -ENOSYS;
+
+       return ops->size(dev);
+}
+
+static int spi_eeprom_read_cmd(struct udevice *dev, int offset, uint8_t *b=
uf, int size,
+               uint8_t* cmd, uint8_t cmd_size) {
+       int ret =3D 0;
+
+       struct spi_slave *slave  =3D dev_get_parent_priv(dev);
+       struct spi_eeprom *priv =3D dev_get_priv(dev);
+
+       if (offset + size > priv->size) {
+               log_warning("Read beyond end of EEPROM\n");
+               return -EINVAL;
+       }
+       if (offset < 0) {
+               log_warning("Negative offset. Counting from the end\n");
+               offset =3D priv->size + offset;
+       }
+
+       ret =3D dm_spi_claim_bus(dev);
+       if (ret){
+               log_err("Failed to claim SPI bus\n");
+               goto cleanup;
+       }
+
+       // Send the read command (begin the SPI transaction)
+       ret =3D spi_xfer(slave, 8 * cmd_size, cmd, NULL, SPI_XFER_BEGIN);
+       if (ret) {
+               log_err("Failed to send read command\n");
+               goto cleanup;
+       }
+
+       // Receive the data (end the SPI transaction)
+       ret =3D spi_xfer(slave, 8 * size, NULL, buf, SPI_XFER_END);
+       if (ret) {
+               log_err("Failed to receive data\n");
+               goto cleanup;
+       }
+
+cleanup:
+       dm_spi_release_bus(dev);
+       return ret;
+}
+
+static uint8_t spi_eeprom_read_status(struct udevice *dev) {
+       /*
+       Bit 0: Ready/Busy Status
+         0 - Device is ready for a new sequence
+         1 - Device is busy with an internal operation
+
+       Bit 1: Write Enable Latch
+         0 - Device is not write enabled (Power-up Default)
+         1 - Device is write enabled
+
+       Bits 2-3: Block Write Protection
+         00 - No array write protection (Factory Default)
+         01 - Quarter array write protection
+         10 - Half array write protection
+         11 - Entire array write protection
+
+       Bits 4-6: Reserved for Future Use (RFU)
+         Reads as zeros when the device is not in a write cycle
+         Reads as ones when the device is in a write cycle
+
+       Bit 7: Write-Protect Enable
+         0 - Factory Default
+         1 - Write protection enabled (refer to Table 6-5 for configuratio=
n details)
+       */
+
+       struct spi_eeprom_drv_data *drv_data =3D
+               (struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+
+       // Make it 0xff initially to check if the SPI reply overwrites it
+       uint8_t status[1] =3D {0xff};
+       uint8_t cmd[1] =3D {drv_data->cmd_read_status};
+
+       int ret =3D spi_eeprom_read_cmd(dev, 0, status, 1, cmd, 1);
+
+       if (ret) {
+               log_err("Failed to read status register\n");
+               return 0xff;
+       }
+
+       return status[0];
+}
+
+static int spi_eeprom_std_read(struct udevice *dev, int offset, uint8_t *b=
uf, int size) {
+       // Use the read command from the driver data struct
+       // to read the contents of the EEPROM
+       struct spi_eeprom_drv_data *drv_data =3D
+               (struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+
+       uint8_t cmd[CMD_SIZE] =3D {
+               drv_data->cmd_read_data,
+               (offset >> 8) & 0xFF,
+               offset & 0xFF
+       };
+
+       return spi_eeprom_read_cmd(dev, offset, buf, size, cmd, CMD_SIZE);
+}
+
+static int spi_eeprom_std_write(struct udevice *dev, int offset,
+                               const uint8_t *buf, int size) {
+       // TODO: Implement the write operation
+       // which is nearly the same as the one from i2c_eeprom_std_write
+       // found in i2c_eeprom.c
+       log_warning("%s: Write operation not implemented. Nothing done...\n=
", __func__);
+       return 0;
+}
+
+static int spi_eeprom_std_size(struct udevice *dev) {
+       struct spi_eeprom *priv =3D dev_get_priv(dev);
+
+       return priv->size;
+}
+
+static const struct spi_eeprom_ops spi_eeprom_std_ops =3D {
+       .read   =3D spi_eeprom_std_read,
+       .write  =3D spi_eeprom_std_write,
+       .size   =3D spi_eeprom_std_size,
+};
+
+static int spi_eeprom_std_of_to_plat(struct udevice *dev) {
+       struct spi_eeprom *priv =3D dev_get_priv(dev);
+
+       struct spi_eeprom_drv_data *data =3D
+               (struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+
+       u32 pagesize;
+       u32 size;
+
+       // Ensure that the SPI slave is properly configured
+       struct dm_spi_slave_plat *plat =3D dev_get_parent_plat(dev);
+       spi_slave_of_to_plat(dev, plat);
+
+       // Read pagesize from device tree and save it into priv
+       if (dev_read_u32(dev, "pagesize", &pagesize) =3D=3D 0)
+               priv->pagesize =3D pagesize;
+       else
+               // Else take the default value from the driver data
+               /* 6 bit -> page size of up to 2^63 (should be sufficient) =
*/
+               priv->pagesize =3D data->pagesize;
+
+       if (dev_read_u32(dev, "size", &size) =3D=3D 0)
+               priv->size =3D size;
+       else
+               priv->size =3D data->size;
+
+       return 0;
+}
+
+static int spi_eeprom_std_bind(struct udevice *dev) {
+       debug("%s\n", __func__);
+       return 0;
+}
+
+static int spi_eeprom_std_probe(struct udevice *dev) {
+       // The calls below can be used to get info on the device configurat=
ion
+
+       /* Verify the chip's status */
+       uint8_t status =3D spi_eeprom_read_status(dev);
+       debug("%s: status register: 0x%02x\n", __func__, status);
+
+       if (status =3D=3D 0xff){
+               log_err("%s: eeprom not found\n", __func__);
+               return -ENODEV;
+       }
+
+       if (status) {
+               log_warning("%s: status register not as expected\n", __func=
__);
+       }
+
+       return 0;
+}
+
+static const struct spi_eeprom_drv_data atmel25_data =3D {
+       .size =3D 128,
+       .pagesize =3D 8,
+       .addr_offset_mask =3D 0,
+       .offset_len =3D 1,
+       .cmd_read_data =3D AT25_CMD_READ_DATA,
+       .cmd_read_status =3D AT25_CMD_READ_STATUS,
+};
+
+static const struct udevice_id spi_eeprom_std_ids[] =3D {
+       { .compatible =3D "microchip,at25160bn", (ulong) & atmel25_data },
+       { }
+};
+
+U_BOOT_DRIVER(spi_eeprom_std) =3D {
+       .name           =3D "spi_eeprom",
+       .id                     =3D UCLASS_SPI_EEPROM,
+       .of_match       =3D spi_eeprom_std_ids,
+       .bind           =3D spi_eeprom_std_bind,
+       .probe          =3D spi_eeprom_std_probe,
+       .of_to_plat     =3D spi_eeprom_std_of_to_plat,
+       .priv_auto      =3D sizeof(struct spi_eeprom),
+       .ops            =3D &spi_eeprom_std_ops,
+};
+
+UCLASS_DRIVER(spi_eeprom) =3D {
+       .id             =3D UCLASS_SPI_EEPROM,
+       .name   =3D "spi_eeprom",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94..e949b6159e 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -133,6 +133,7 @@ enum uclass_id {
         UCLASS_SOC,             /* SOC Device */
         UCLASS_SOUND,           /* Playing simple sounds */
         UCLASS_SPI,             /* SPI bus */
+       UCLASS_SPI_EEPROM,      /* SPI EEPROM device */
         UCLASS_SPI_FLASH,       /* SPI flash */
         UCLASS_SPI_GENERIC,     /* Generic SPI flash target */
         UCLASS_SPMI,            /* System Power Management Interface bus *=
/
diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h
new file mode 100644
index 0000000000..ce4e5aec6f
--- /dev/null
+++ b/include/spi_eeprom.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-FileCopyrightText: Copyright (c) 2024 Koninklijke Philips N.V. */
+/* Joao Loureiro <joao.loureiro@philips.com> */
+
+#ifndef __SPI_EEPROM
+#define __SPI_EEPROM
+
+#include <linux/errno.h>
+
+#define AT25_CMD_READ_DATA             0x03 // AT25 read command
+#define AT25_CMD_READ_STATUS   0x05 // Command to read status register
+#define CMD_SIZE 3
+
+struct udevice;
+
+struct spi_eeprom_ops {
+       int (*read)(struct udevice *dev, int offset, uint8_t *buf, int size=
);
+       int (*write)(struct udevice *dev, int offset, const uint8_t *buf,
+                    int size);
+       int (*size)(struct udevice *dev);
+};
+
+struct spi_eeprom {
+       /* The EEPROM's page size in byte */
+       unsigned long pagesize;
+       /* The EEPROM's capacity in bytes */
+       unsigned long size;
+};
+
+#if CONFIG_IS_ENABLED(SPI_EEPROM)
+/*
+ * spi_eeprom_read() - read bytes from an SPI EEPROM chip
+ *
+ * @dev:       Chip to read from
+ * @offset:    Offset within chip to start reading
+ * @buf:       Place to put data
+ * @size:      Number of bytes to read
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_read(struct udevice *dev, int offset, uint8_t *buf, int siz=
e);
+
+// int spi_eeprom_read_status(struct udevice *dev, uint8_t *status);
+
+/*
+ * spi_eeprom_write() - write bytes to an SPI EEPROM chip
+ *
+ * @dev:       Chip to write to
+ * @offset:    Offset within chip to start writing
+ * @buf:       Buffer containing data to write
+ * @size:      Number of bytes to write
+ *
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_write(struct udevice *dev, int offset, const uint8_t *buf,
+                    int size);
+
+/*
+ * spi_eeprom_size() - get size of SPI EEPROM chip
+ *
+ * @dev:       Chip to query
+ *
+ * Return: +ve size in bytes on success, -ve on failure
+ */
+int spi_eeprom_size(struct udevice *dev);
+
+#else /* !SPI_EEPROM */
+
+static inline int spi_eeprom_read(struct udevice *dev, int offset, uint8_t=
 *buf,
+                                 int size)
+{
+       return -ENOSYS;
+}
+
+static inline int spi_eeprom_write(struct udevice *dev, int offset,
+                                  const uint8_t *buf, int size)
+{
+       return -ENOSYS;
+}
+
+static inline int spi_eeprom_size(struct udevice *dev)
+{
+       return -ENOSYS;
+}
+
+#endif /* SPI_EEPROM */
+
+#endif
--
2.43.0

________________________________
The information contained in this message may be confidential and legally p=
rotected under applicable law. The message is intended solely for the addre=
ssee(s). If you are not the intended recipient, you are hereby notified tha=
t any use, forwarding, dissemination, or reproduction of this message is st=
rictly prohibited and may be unlawful. If you are not the intended recipien=
t, please contact the sender by return e-mail and destroy all copies of the=
 original message.
