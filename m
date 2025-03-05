Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701EEC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 12:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF75808B6;
	Wed,  5 Mar 2025 13:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=philips.com header.i=@philips.com header.b="PLFWVtC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F30C80E94; Wed,  5 Mar 2025 13:26:55 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DDF807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 13:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=philips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Joao.Loureiro@philips.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEXrH9vabNkD/hC+pXuuxQ9kWfI8X2AOuZcFsSzFe7tccLI7IqqBI3Hh7XRSZdbpcdWzvyMx/BKFKLWcMP12A+kiX6BXqRyczviDg2IG/E1CAIJAxXEXre+afAEhMSyjUe9M+q3k9n/V9vv9Tn5k9pXi2Pnz3WZmJQ7za+OQpQwfC4iIo4E9cVsrlX6Z7oizPGEpfB5DOzWRzXDNdlyWNqL/94SCR0wsay1ZFQJ3IslyGmAXbdluSXk+K77a8H713K1grQQEjPh21mtpz7uUbTszlzszJGH5j6IHwJxeSgyQrAtNQM0vnRVsRtWly71WA1zetI+H9tln1kyqUyx8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1CtGkG6NqOSd7RTxUn8hsmRgA4ujstsP+5EPjT3EJE=;
 b=q3tIjeiwhmJ7/PyUaWZeeFhk4ilu9Mt9bj6B98CZ+yuM77nj11oPwRZlDgZo/PKn9upOyOaChcJwT4b//CloYwcplL5TSTlNgSlYsZkbhi3FKICJv80hydU27UJ6yVu4xT8DHOa+rBaaWGRuZq35tsIwIms5PjC3y67NODHfTv9flMwuSJ34N+TBrU9y70Mvv9xE8uYVhYBmynqZGqpkOevyAXanB4L1jHeoblRtY7oFS/dNzNWZydGQpLqwGcqmg1mR/c28TmRHWs5YnKqtiP5CpT4wTZjk4u0sDmx0sO8NyZeNOZmJz+ALRYM+ESgzziNRUDgQ8Ec9JIMcYzNYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1CtGkG6NqOSd7RTxUn8hsmRgA4ujstsP+5EPjT3EJE=;
 b=PLFWVtC5zyPhoJkNip2nOHNDxwgW4RwBPqaLpmDdYd1AHZfmxtcozsjBmZKrSN1d8bxaLvKwk7PnGFWXFuqvHH2It7+zJ5HofLLNNjFA22aZk0D3rZXi2qftu+Ev20G58vqcq0EktfBHPs9xnQYfpNum+48jZCeYpwh+Ck66QtU=
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:22c::12)
 by GV1P122MB0303.EURP122.PROD.OUTLOOK.COM (2603:10a6:150:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.30; Wed, 5 Mar
 2025 12:26:50 +0000
Received: from AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b]) by AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
 ([fe80::126e:8fab:cea:b00b%6]) with mapi id 15.20.8489.030; Wed, 5 Mar 2025
 12:26:50 +0000
From: "Loureiro, Joao" <Joao.Loureiro@philips.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH v2] spi: Introduce initial EEPROM driver mode support
Thread-Topic: [PATCH v2] spi: Introduce initial EEPROM driver mode support
Thread-Index: AQHbjcnedZ0FkuGGE0qr44bAExCBzA==
Date: Wed, 5 Mar 2025 12:26:50 +0000
Message-ID: <AM9P122MB0281B24BE5B8A8E6A3F2D343F2CB2@AM9P122MB0281.EURP122.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: AM9P122MB0281:EE_|GV1P122MB0303:EE_
x-ms-office365-filtering-correlation-id: f5021946-fbd7-49ba-1007-08dd5be10134
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Y+6Un8MmI7tDV5HCPvfggwtjl5oAjcQTgtpSFzfoRy/Z+buLu1ydkUoxwH?=
 =?iso-8859-1?Q?16HyasKHu9ItEoVm7Ac04fY801tSocssCCEXlSys3sFLOTCpKOmzP5Ye8i?=
 =?iso-8859-1?Q?lVj9BD5A5IT2ve6AEsiQH5tPcIdweETknhTMOrchsmaH62q3J6F4JxzvX7?=
 =?iso-8859-1?Q?Lzx7U/194PUiuctqhmGEudHWPcaobsKGWsxcbTqZRTDOQGV7+3nyto2HF5?=
 =?iso-8859-1?Q?hpUYmQ+0bvZfZixzykEqDabiqpGcxo6URdPbko/Ix/Y/qxQi2bpbkckxa/?=
 =?iso-8859-1?Q?j5TxNjRHD5ciEN5zkQcA75g8Do2zYOkvtV3kMhgEX+xDNOhPtmHCoTP1Hb?=
 =?iso-8859-1?Q?gwGGOF+b1l4+13fZ2XrmWjr0gw68xaiTf2CQv4DObs6TKey2bPrReNa1lX?=
 =?iso-8859-1?Q?v9WAZCqXba0rKqf0yT9LUAjfv+HrMRbHsf8R8YdqkQSk4xxF3f2wPgvEoq?=
 =?iso-8859-1?Q?tkzaFB59cUJT73FoEOVzFvXgo3XBttbB7dBpCT8GgdscoHDNBC3hKOK955?=
 =?iso-8859-1?Q?hQlJiVMatY+vqBu5Y9hkA+V1uF+YMcarpEAmdImRx0ycvgi1LbCU9p8U+i?=
 =?iso-8859-1?Q?r5PTtZOjNHJRBIbvhRvG5mz6NoLBndDw78O3ohDpCGjuShJyC4UFGFFC/Z?=
 =?iso-8859-1?Q?/I1DbN2+7zaWYQ5N77HmgMV/WcsZJXqr6zyv6o+3ad5aUAr8S/dUd0o0I5?=
 =?iso-8859-1?Q?b3iMYyljJn7uby4XOts/7EKl7l3M021M5IhSOVZW3g2Y6QOefIACeTeLXD?=
 =?iso-8859-1?Q?koJYfUPWaljk98o2HChm5IV5o2cFoeSbZHHpG7uAU7+wUmUse5VacxSXjK?=
 =?iso-8859-1?Q?bXeYf2Cfin/E21Ww4cUsV2lKwqhGMFaR0R/wbSrx4Zxx8Dbk3seHrMZW/s?=
 =?iso-8859-1?Q?mZbbNwkx/vX1UTw8zHwtXtTGiHD/xONCVSc3Vd/CR1aQnly2+S/u7dIkLY?=
 =?iso-8859-1?Q?D6sHeyW6Rpcfug7EB5L8D7833CNDcGj/cLxUSItrBBbupH/ufuRofy0fvD?=
 =?iso-8859-1?Q?id36Dzv+R5s3ObsJuHvj224zYTYm59EleXw98wjej8QCvy/hTmXd+zweVq?=
 =?iso-8859-1?Q?QQyHbRpTmXkN+g31lCgOatGH+gZYeaFbgYg7NZFXk4nQaIA8dhSd7tLz8B?=
 =?iso-8859-1?Q?CjJahYt6wzXf6+fpkx3PRior4vXu+rUsKCEgmxTykDhjoZeU9wo82f738u?=
 =?iso-8859-1?Q?QFrZK8au09iXUWTmzM/3lfzfe4jhG/HCP/6d4diWwzl5208ELsfOlBaXuB?=
 =?iso-8859-1?Q?4zgKRhNI7hf1WLlm1baYHuaCmKsyW5OdumzZW9c6TvWB1EWamTr3tlYuA8?=
 =?iso-8859-1?Q?+PJrUXYAVHPjKujAQNrETARFOPcJI0ik+ValH+Jh1JAZK1DtOHCkaoAjbf?=
 =?iso-8859-1?Q?BZQgnjopbLJB5gT7mZpHOx37v8hDRj4eLjpZ1UzDQqBx3iIbAk+OR1s2Dc?=
 =?iso-8859-1?Q?pIjHPthTkb4tNa5+5XN8qpFJjWREtap2Cp5UeA/EH4ez9v9In+QNPYR+3H?=
 =?iso-8859-1?Q?QIJFp6Mn8aXAHZ0mmHIcFF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9P122MB0281.EURP122.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uDEYGK2Z0EwlaJTzf+CXPdgXUUnFdi9zdczARyMAhV0AfjFVS89adSOrh6?=
 =?iso-8859-1?Q?RII6MiefctLQrEWiWirqY1qjLIqws9nodGUv/XgctDO8Il4Pzp58diZTga?=
 =?iso-8859-1?Q?R6yBA7UjvHH1DpyXm/rTpxdJonWS/VjNDdD+ApIc9T7i2qTpadFkgQe59P?=
 =?iso-8859-1?Q?oFLzEC1R3owg8S55L4MR/2UlixZfeUaTPIs2iYF71p3FODpKkffJvfNa2D?=
 =?iso-8859-1?Q?WqA+xddYdrEkCjXFfaS23RAOtKDQZSFxfrYfHSK8v0bpYe9TgBL6Kdb9+B?=
 =?iso-8859-1?Q?10C8OWoWvPDWLRHUXsxpN5JT8dHBTEzeohIDWB9TrEMl0RwDo/yzaBt7ny?=
 =?iso-8859-1?Q?q1hVDxv4e8GrbaNPqQjpZEhTjNja/eP9BJjmZCu41XbqYy+3OaOleWA9cf?=
 =?iso-8859-1?Q?W7CIpiGmYd+Cthd8iVzyt9W9UknlSRGC8zL3W6nZqi33SGTR2EugEM4RnT?=
 =?iso-8859-1?Q?msfDR8l5hGs8DVQbDgcExXOPIQ5JPAiwxRy75UHlxs3zkI1+xPliGAdygE?=
 =?iso-8859-1?Q?2b5Td6QiuM1/lQpGxau47ULCT5BZMZVzFVPv3M4oMLDyf0vG5L+FiGpzLk?=
 =?iso-8859-1?Q?Apy8WywTWPR0S75xeolxY40WTez7RwmV2um0+i/hM17DJzeznpp2McfU7A?=
 =?iso-8859-1?Q?VVR/bFJ56/Ms+P2H3K0AlRCoMXBH+28m3Na1hCmwgr6OFcnwrNPPi/AhKJ?=
 =?iso-8859-1?Q?otl8tptqBcgPyvM6yDB4VbawEb2p0JHDxAZubJOMInLMhwOj35muFu0xGT?=
 =?iso-8859-1?Q?GL9iw9/WUzbnOooxLvP1cJB62TuDF5zXoNc6zTjPAjxw6xxcLZrxw0uZDs?=
 =?iso-8859-1?Q?8h8lIIc5xruElgJ7hisWr0b7xcuuWDrwed5m8LCQuORVhdaSULCt8dGmAn?=
 =?iso-8859-1?Q?pRWz+LhG+ZsItbeZsLjiN0qfK9pUiuG1VygHIF9JPN4A5aEErDhpmxpFZR?=
 =?iso-8859-1?Q?CHnyEl35KzuDB2Hs2COf/rHAaBfpjGpu7ueBcr1SU+gAc2WvVMj0QN+6Lu?=
 =?iso-8859-1?Q?A+yWw/dLhKkRnt6i83iMG+O+MjqOEktcWl3J4FZv1EdmHvpRfGcRsVBEhd?=
 =?iso-8859-1?Q?wgcMGO7vmmyb+yWARQKS9M1xV63SxJ+LnHniu8NIoj5qZ9hkE8ZT/lpB/d?=
 =?iso-8859-1?Q?7/rtqzl3zKwiM1eFNzmBXxOVAVVdpcxD0RcNamaqOzcw7hwxbyZhMWsnGY?=
 =?iso-8859-1?Q?WgWvvTW7hKL55ONRjSY6ja4DIyRxmFfJwhOio1DMADGyJYdJ3Us+DoUtPq?=
 =?iso-8859-1?Q?PUazfPl2uPXjjUfCXYJIbe7aNJhtwyjODHQGg4TCYXkSOLG+e9kAqpnRNl?=
 =?iso-8859-1?Q?mL3DRcbraQRZm/Sqw9yjLJekBHca0jC6RTnhr4wmod9pIVCnOfZCdWcnDv?=
 =?iso-8859-1?Q?Z0i6EyhbjdMgB7HdIAzFFXWU/3swVfaeCy/tYVcvyzDZGznPM4Mz6DrJGy?=
 =?iso-8859-1?Q?/1UmY+UEoWRMBWVxfy7RSPDGJClLF1cR0+hci7xSHC7PZhrfpaHuzzaGnm?=
 =?iso-8859-1?Q?MZU++YdqapfCd02oh7fgpHQJbOJaC5+rxhFdOJQzrafDuhyM96mLskzbVA?=
 =?iso-8859-1?Q?nsR7ECHRPTCBGMMm9EFOfURSYpwF/ezKe/qoGdkLKSstW0xbpW+8uFkfRY?=
 =?iso-8859-1?Q?Q6Fyi2VkhXj4z7UwcAAk87ozKkYzUOL0wn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9P122MB0281.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5021946-fbd7-49ba-1007-08dd5be10134
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 12:26:50.2070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymyUG4nA4EFLZWXQaOyzYh96wtdljW2KwimuC6Lvo0p+m87T1nxoXC2Mvpfzm1HKcdi4n59Qp8ZiYE+VnSxyDkzgHiEi3UA9Vf+Iat1d2H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P122MB0303
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
Changes in v2:
- Fix checkpatch.pl issues
---
 configs/sandbox_defconfig |   1 +
 drivers/misc/Kconfig      |   5 +
 drivers/misc/Makefile     |   1 +
 drivers/misc/spi_eeprom.c | 262 ++++++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h    |   1 +
 include/spi_eeprom.h      |  88 +++++++++++++
 6 files changed, 358 insertions(+)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 include/spi_eeprom.h

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 7b35ad8a88f..a26b9286401 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -234,6 +234,7 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=3Dy
 CONFIG_NAND_SANDBOX=3Dy
 CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
 CONFIG_SYS_NAND_PAGE_SIZE=3D0x200
+CONFIG_SPI_EEPROM=3Dy
 CONFIG_SPI_FLASH_SANDBOX=3Dy
 CONFIG_BOOTDEV_SPI_FLASH=3Dy
 CONFIG_SPI_FLASH_ATMEL=3Dy
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..0ef5de114ad 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -578,6 +578,11 @@ config I2C_EEPROM
        help
          Enable a generic driver for EEPROMs attached via I2C.

+config SPI_EEPROM
+       bool "SPI EEPROM support"
+       help
+         Enable support for SPI EEPROM devices.
+         Currently with only read access.

 config SPL_I2C_EEPROM
        bool "Enable driver for generic I2C-attached EEPROMs for SPL"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cdd..def79d6ec92 100644
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
index 00000000000..9a0cc77df7b
--- /dev/null
+++ b/drivers/misc/spi_eeprom.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// SPDX-FileCopyrightText: Copyright (c) 2024 Koninklijke Philips N.V.
+// Joao Loureiro <joao.loureiro@philips.com>
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
+       u8 cmd_read_data;       /* Command buffer (1 byte cmd + 2 bytes add=
r) */
+       u8 cmd_read_status;     /* Command buffer (1 byte cmd + 2 bytes add=
r) */
+};
+
+int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf, int size)
+{
+       const struct spi_eeprom_ops *ops =3D device_get_ops(dev);
+
+       if (!ops->read)
+               return -ENOSYS;
+
+       return ops->read(dev, offset, buf, size);
+}
+
+int spi_eeprom_write(struct udevice *dev, int offset, const u8 *buf, int s=
ize)
+{
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
+static int spi_eeprom_read_cmd(struct udevice *dev, int offset, u8 *buf, i=
nt size, u8 *cmd,
+                              u8 cmd_size)
+{
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
+       if (ret) {
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
+static u8 spi_eeprom_read_status(struct udevice *dev)
+{
+       /*
+        * Bit 0: Ready/Busy Status
+        *   0 - Device is ready for a new sequence
+        *   1 - Device is busy with an internal operation
+        *
+        * Bit 1: Write Enable Latch
+        *   0 - Device is not write enabled (Power-up Default)
+        *   1 - Device is write enabled
+        *
+        * Bits 2-3: Block Write Protection
+        *   00 - No array write protection (Factory Default)
+        *   01 - Quarter array write protection
+        *   10 - Half array write protection
+        *   11 - Entire array write protection
+        *
+        * Bits 4-6: Reserved for Future Use (RFU)
+        *   Reads as zeros when the device is not in a write cycle
+        *   Reads as ones when the device is in a write cycle
+        *
+        * Bit 7: Write-Protect Enable
+        *   0 - Factory Default
+        *   1 - Write protection enabled (refer to Table 6-5 for configura=
tion details)
+        */
+
+       struct spi_eeprom_drv_data *drv_data =3D
+               (struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+
+       // Make it 0xff initially to check if the SPI reply overwrites it
+       u8 status[1] =3D {0xff};
+       u8 cmd[1] =3D {drv_data->cmd_read_status};
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
+static int spi_eeprom_std_read(struct udevice *dev, int offset, u8 *buf, i=
nt size)
+{
+       // Use the read command from the driver data struct
+       // to read the contents of the EEPROM
+       struct spi_eeprom_drv_data *drv_data =3D
+               (struct spi_eeprom_drv_data *)dev_get_driver_data(dev);
+
+       u8 cmd[CMD_SIZE] =3D {
+               drv_data->cmd_read_data,
+               (offset >> 8) & 0xFF,
+               offset & 0xFF
+       };
+
+       return spi_eeprom_read_cmd(dev, offset, buf, size, cmd, CMD_SIZE);
+}
+
+static int spi_eeprom_std_write(struct udevice *dev, int offset,
+                               const u8 *buf, int size)
+{
+       // TODO: Implement the write operation
+       // which is nearly the same as the one from i2c_eeprom_std_write
+       // found in i2c_eeprom.c
+       log_warning("%s: Write operation not implemented. Nothing done...\n=
", __func__);
+       return 0;
+}
+
+static int spi_eeprom_std_size(struct udevice *dev)
+{
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
+static int spi_eeprom_std_of_to_plat(struct udevice *dev)
+{
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
+
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
+static int spi_eeprom_std_bind(struct udevice *dev)
+{
+       return 0;
+}
+
+static int spi_eeprom_std_probe(struct udevice *dev)
+{
+       // The calls below can be used to get info on the device configurat=
ion
+
+       /* Verify the chip's status */
+       u8 status =3D spi_eeprom_read_status(dev);
+
+       debug("%s: status register: 0x%02x\n", __func__, status);
+
+       if (status =3D=3D 0xff) {
+               log_err("%s: eeprom not found\n", __func__);
+               return -ENODEV;
+       }
+
+       if (status)
+               log_warning("%s: status register not as expected\n", __func=
__);
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
+       { .compatible =3D "microchip,at25160bn", (ulong)&atmel25_data },
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
index 270088ad94f..e949b6159e6 100644
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
index 00000000000..61236a37775
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
+                                  const u8 *buf, int size)
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
