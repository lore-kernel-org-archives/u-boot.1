Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36DBE77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8168973C;
	Wed,  4 Dec 2024 17:32:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=philips.com header.i=@philips.com header.b="qeWk0Fyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C17AD896CA; Wed,  4 Dec 2024 12:38:12 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD62896BA
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 12:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joao.Loureiro@philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/eSc+QjzzjDJ3yq1+0hLICp6RyZUpZqlyQj/DS1zoPhzyT8w0LazENoPfa6mrdMSOONt3kLyZupUYA4n1kz701vzZrImewGFaVDYTDt+vAr+BFuokYMFSPatDbp4aowuto5Z+Rk3stoVqM39UDOhoYBrVDw6PUe9uLEA9E56IsYDRn84MZ5SCLo+Tgj6mmXf8Nr1Xo7gzEJ84eUa2+0zOhhqKlHXl3JNUOKAuUc46YVLbgWXvvqP5TsMuS+t8V0Ulq/jEFgE+B16B+vjpS9MykV2r54LCWOYlQ6uBgo7YLUz5H7TYX2JWoeAN/wkW+2lTY2ytVwvCaBeABAXNY9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNCEey7O8kOYcBZp/zYMsLVZCMZ7lj73Y53Tzjk6xks=;
 b=WCD5br5qaLIxgxSKKVTR2rvRLlGaYU3mtgc477Xb5xRjkSKs1c1A8k8CsKcmailZVFluN+xxmBM7A4PaYLxsxG/nPw4mKEfPCE7nNrXchhTup3x6M686WtPD2iRdoeGA+ksnlWOGqUCaQO5Rw7uTBDP8lqEYU/LsZpWykZsK57InTLr0AZODQ5TiuqQNWz4Cfd6UYh4OVCR5MIqWRikaxtGIaO6j8p0U5D8pQ8E/ZLD7nF/Qp07RqX1OFzYb8sFGCjc5D4JGbXlZwm3RTFZzYMHeg8q4xj5k05D87WfE7lbiCHnlFcaxLAF79+/1HJaprtsgP/uz03S7bEFY5kDPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNCEey7O8kOYcBZp/zYMsLVZCMZ7lj73Y53Tzjk6xks=;
 b=qeWk0FyfM4r3FyZnsbeJS8Z5QiD0yGHSk4Oq9mazKiXDcxjz/WnJFT0Z0Jy/0qxuwI6UH/Gw2lcanJlhb35aNmqTdxd8AaKtsrznUUqOsQ/26of6BkJhx3CIdeK+A34Hx8iTshgl6FRBapzqugF58iQj4YQoEDFxwnThnhKouVA=
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22c::12)
 by VI1P122MB0239.EURP122.PROD.OUTLOOK.COM (2603:10a6:800:177::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 4 Dec
 2024 11:38:07 +0000
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b]) by AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b%5]) with mapi id 15.20.8182.023; Wed, 4 Dec 2024
 11:38:07 +0000
From: "Loureiro, Joao" <Joao.Loureiro@philips.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] SPI: Introduce initial EEPROM driver mode support
Thread-Topic: [PATCH] SPI: Introduce initial EEPROM driver mode support
Thread-Index: AQHbRj84f5EMnTTax067/csVC11AfA==
Date: Wed, 4 Dec 2024 11:38:07 +0000
Message-ID: <AM9P122MB0281B0F2532C22D6EE4917F4F2372@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9P122MB0281:EE_|VI1P122MB0239:EE_
x-ms-office365-filtering-correlation-id: 922eb68f-c01a-4b84-4f4b-08dd14581f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?iiHrxYyxNRrCV8k9lDg8boCqv40QzQHn4s3+4wSL2rh2gfCkOHUjEN/b5J?=
 =?iso-8859-1?Q?x/oIS1a6XOHZy9zThEp0vjwYRinVw6HvGZm5H4dVhYolI8wKtxpZbrQ4ce?=
 =?iso-8859-1?Q?a3pQ8ymyhO5puRoTMGmncA6017kK82VJ60yIkik1Pz7EN4Eh75jddZ8i0E?=
 =?iso-8859-1?Q?dTav0fTsaaqDHGg7qvGIfT6DZ18XiQLGbAU6mPqaRUrOJudS797f8e0/6O?=
 =?iso-8859-1?Q?OavpITggqv0938qfH0yGGG2W12eBjeldrjpKF51Bi0kVGrsxlVwzLwTmxg?=
 =?iso-8859-1?Q?1ys5q4kRCculvzC65JncUXTbiBXTDyGfMaZK8LYp8BV1q4lDnN3ce+Q5Zo?=
 =?iso-8859-1?Q?pxXjpwkAZFyzgjzKbAEH0d2OsHqzHRVEBJZJZwUzRmhBLNxgAGt59O/Mpm?=
 =?iso-8859-1?Q?HjfqaXAvjVnacA74FR8Z9n0MyYkJFZZc19txD7fG++5AhDeInyIgDMxUta?=
 =?iso-8859-1?Q?X7bD4ScFvqLvmZK1u8L8zXtW3Hrpm2qxYE6W16BlrvZkRwFDKtrN7f3njZ?=
 =?iso-8859-1?Q?0ZavdyzmhDcNL4NrVgL5MGFLoeMN6T9KfXZKIF0JvnBHvDUai7Amy74tMS?=
 =?iso-8859-1?Q?Ox/Z1QQYy9Z289xYJqb+oszcmaXfb/kbVIz2BOIPxJbwb0YsRP/gIGbM4I?=
 =?iso-8859-1?Q?yBob736nFs3rkwOp8DWiYhYROTnud55gVhkW6K6nuBFxipWSA+10Ge5nbE?=
 =?iso-8859-1?Q?TYJxlh0Nyu6D/a6mjjR+OgyBc1mjqaS5LDuOgJ6lZignfQGqrB19zf0nFs?=
 =?iso-8859-1?Q?zY12d+afZn/TljIN9P4yAgxeAouHNF34ayjRodSRjSO1PecMF8dMu/WuHZ?=
 =?iso-8859-1?Q?YPTZm6I0g0r8xpUVSuB63tJEvIMOEwy+g7iiFhy0gjwdu18aCRQKQAxRz9?=
 =?iso-8859-1?Q?95bbob7bR7ni9VLomu98GZOui+UVYPMl2VfZmk5wKOMnKjMByL1DaUUxvO?=
 =?iso-8859-1?Q?4l3imUPFQ1AwkkOXAz27hzJucQWIt2crx3Se+CrJ3OSb71DG0SUlmFjC0s?=
 =?iso-8859-1?Q?sR4xybS/6Jj+loq9Qi5sKi7BEzkxFes3atk38TI3XIV0RIbDm6uYIahzEr?=
 =?iso-8859-1?Q?YqLnewI0cKAuXbHDdagkr3r/PB1rfly4yZUDsdvDEWw84djzh8nZ8cuQ2b?=
 =?iso-8859-1?Q?yRnCK0pdHMq7dYnSmShglAHzsaNUoxncflWTA2sKKjRJuZIRAOVXbo0J3p?=
 =?iso-8859-1?Q?RM3U8ymuRev64w9Of77rl3/65XID0mYlMEfsb2fSotixN+suFUtSwPopJ2?=
 =?iso-8859-1?Q?Gas06f1swZMhdHZCYpCq8mgUDhc/Yg6aFx7p/w1bStFdjEabtRfG0X0qTW?=
 =?iso-8859-1?Q?xgSvC6fcOmkP0q5WQwfTO+Gm2FXP7i1r3ngIWK07vwDZ5hZE0swtAG97sw?=
 =?iso-8859-1?Q?a5k638QNOmE62uhFWuF8dedzb+LPwKUTxpZe7zidUZH6JPDRGtexYXwbt+?=
 =?iso-8859-1?Q?NM0COGefYwr2tSGF7l4NpyfDpb0MzTNynMy43w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P122MB0281.EURP122.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HQ7W1aNnhxCzeh9OvHAPT8rxGKCHedXbxjXuiQc8ikopZKImLp8h50Qnns?=
 =?iso-8859-1?Q?bllGBJTkFIDVnljUlmF6uFEgid+1BsV/QJlX4S797j1rGnr9jxa7JMp741?=
 =?iso-8859-1?Q?4jTF1HttSlaXKqPXNn0GGqc5fvHFydsRKYRBfJN4nYIKjlUHJkqYU9kXjB?=
 =?iso-8859-1?Q?v0+RuJzux8pgUAUT4ge4ioVnFtQGq3nC1MojRCy23RCYr3PTclILkhAgTV?=
 =?iso-8859-1?Q?/ynZZHm4J9t7lJbbCCYBET7w5mI/8j19Shf0hblXBD24DfWHcafnrTMSpt?=
 =?iso-8859-1?Q?IracMdDyr8wuAlnvGIeZ5uLExKPLwfdLMNmjN4ymeDDHeeDVYvJa4aeKtH?=
 =?iso-8859-1?Q?6KKYgh/7JAu3xFoM0PtXGgr20HcbY8jX1m/69gZfhv15YG++aK1ky3ijRE?=
 =?iso-8859-1?Q?bh6oOJBuvE4UgGcSMLJn60Ucme+WNbSA2tw9EM/1k/20opRncFJx3Rx5FF?=
 =?iso-8859-1?Q?uOLJD5X4u+RwQvsOk5YeFMPtMVmaZsuYrCO/AQPH6YZNnLn0zRjptjc/vF?=
 =?iso-8859-1?Q?LW/OIHb56BKtuKwA9Ylae0Z7tVGNmiH1IQpPOh/ZhphoXIa7/J3TLtJT97?=
 =?iso-8859-1?Q?2psXRaqVExJhMR0F9fZjAcbdh0IsANeUDqkMeRg80GFHaGh4cCH7F5qVyG?=
 =?iso-8859-1?Q?ns6jrC6AXpp7tA8XymtOz1FTsIwcL/eJudvZ+/JWPdQVXbQLDJfL2yP3XR?=
 =?iso-8859-1?Q?DMoxIm4Z8DSnxUytn1ui5f8Mq9ezSkhHnPiT5zPfSb/FlzNnSWrVoN215d?=
 =?iso-8859-1?Q?3XbyhqEnmJq47GZxP9tJ4GzMGM5djn5bPyRxG4mr1C1uqDQKpPctqPmWsm?=
 =?iso-8859-1?Q?/Ksevz0P1mBPXodrAoJYYvdGyOrBPuSOH7x2F61zpZg2nEJ1qMWRrIuSXN?=
 =?iso-8859-1?Q?1Q2sykVIGFMdvQ1UfFHOZJnHrQrCFIm29cXnqFTEv3zR7GCXXo317apv6O?=
 =?iso-8859-1?Q?LNKF/OgmeFI7YSfOsz9ZCk5f/imt0oU5VnIggV7B3zHF6veMBy+ah8VVfB?=
 =?iso-8859-1?Q?TO9DpSah9YDg1NVkQqVyA0FPagufhXn30pdqEaCBTRbcixxq/yTtYjqYDC?=
 =?iso-8859-1?Q?rkR4KnKq+ZXYHMJbZ/4rvioIgQpsABuZhMd4oxdubuzvVv9zmirBdPjMm/?=
 =?iso-8859-1?Q?xnZxNUbPjFtk2AeP/E8hLPMcecswsnV+slgtl8LipWPbCmycPalIBHjyUL?=
 =?iso-8859-1?Q?HuytzFTXkJh+cS17LeA/eylTxmhIKV/TnOr7Q9L78j/oMCQKWLTNAFifyH?=
 =?iso-8859-1?Q?hrOiTbzPOToz5DuBSdZH/iGpZae+v/LdZJ/ouI3g0VXIchIpsxapWM0J5G?=
 =?iso-8859-1?Q?LpNSYy/c4A7P4BhpZAoQQpE8u62CfwUIeIgXTRH7uAhycIhInL6P+raQuo?=
 =?iso-8859-1?Q?tDzceq1bldnpAVYuuD6gNM0YfvAeqMuC/YEwOnNakVwYnlaKhXBxXrDF5G?=
 =?iso-8859-1?Q?CJXOFvuNqJR9q2P+VrT0n07KDuxVkKk71IPyeOLTvyqWWKRSX0x2gPzWYe?=
 =?iso-8859-1?Q?6NY1l144N3dIm7EhrTQAQebA6pZaf/LUQyWrGu2oLfBpmmGh7NLx3wj9TR?=
 =?iso-8859-1?Q?gOMqj+rTHUxSsQq4x5Agh2xrnBJLFmRXn1TrBiMgGSUo7xzrwz4FH4Zbph?=
 =?iso-8859-1?Q?6+Mgyq/A6IKfhvz/6/e+llVcodKgKWDjIl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 922eb68f-c01a-4b84-4f4b-08dd14581f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 11:38:07.2590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IsAJOxkhnk6kl5x9lc0AfZ+pItvm7htLFsOGnmp1FLXm11XUBPXShAR6WIJh2lvLZz9zqCgfOJ0q0KlHonu39NNsMP5sin0mp4LqbPNUvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P122MB0239
X-Mailman-Approved-At: Wed, 04 Dec 2024 17:31:58 +0100
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
+       u32 size;                       /* size in bytes */
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
        UCLASS_SPMI,            /* System Power Management Interface bus */
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
