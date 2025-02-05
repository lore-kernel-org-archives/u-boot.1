Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E23C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796518083F;
	Wed,  5 Feb 2025 14:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="PgJ+1qai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AADC806C9; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3188D806DC
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/igEf5bRXiknBHlyp0JgdFL3cDxiz5B4IHfZ5rIV5j9nLgCeUuMj3es7kpkr+uxcqYiLgmsjp1P1HmKvQM9xOIaZ3xRDtlNqJ6MizxVMnbJ1UymB28fM3+t+FYGeh+tWw7qXjIiWhW6cvP3qgn6rpCExMp7UyMVe7T3sAcB+kIATslb7KIJyq5nq5QZxgOG3WPT8VwjviveuSg9ePZw7pEWOGYqBCxxVkyINWjrvizhgJ76oxHwxdKFFyEnTmjfnZbbcsCK7Y4NX1AhpSPhT3NaVcnW80JV9kovud0lMdYJ9xnpHZnaAXzX115iL7ypfxWiWrHZXoQz/iqYM4JRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVXCfpV+F7cUSYS+VV9T4D8xGvfOAxU97UNq6AgGMs0=;
 b=HY16zzZjBhsYuNM4OeZEE1FRz90f06sYANHjg48tibSm6We0N7lI1RSLlcUxuqCl15opU1Nw90ltJ9mICLuc+vnzCiTek0edUPg2AcQQMHEIgMc29LYwEXbyKTgECYV31BmmRFxpLUI7s7YVIko049YX9e9703IPFwp2lt2IeaKcFdLCeKTG9LS+dMPUM//V6EnLpyQfBrQq1g3WppdpglnjpAl2k8QeqMn7alqPyMtbUEhACEp/naCNPlMGLDYY1c9nJOg0IQmlcOozHZTGLmOspwl4Gn+k4GRy0Qz/Pr1pYKYCWSeL92nqXm47S4gQp33F91XHSeBb5bJxRXHZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVXCfpV+F7cUSYS+VV9T4D8xGvfOAxU97UNq6AgGMs0=;
 b=PgJ+1qaiddbs8yDehQ13D1excuiRixgkQvhM59BKFJq/kf82elMv34CsgIQIuc+DWkt4OZNxJ0zRt9YHCYDwYZc1uAbJ5X/Fe80fzBGWopAQR+kZPoNbRDhaSlnD2y2gljJUlDqKCdLkc9gseg+66yNG7nwLDc42ZmaRqEVChrl5SX/UhzG3RV+iNCJxHmkv680Ef3LM5p82CBWZOWS0mRetI3djEmEJDyiKtmUdUr51hiBPkDeeY/F1RmsM2aozzNiA93w1AHWY5cnEmT0Y1tgeQ3lOsjhjVM3DuhhFxd7ecSvHbi+Mv2r21EmSQZGjcSWSFZbNoRZAuHgU3hBgTw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:44 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:44 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 02/20] include: dt-bindings: mfd: introduce bindings
 for RP1 driver
Thread-Topic: [RFC PATCH v1 02/20] include: dt-bindings: mfd: introduce
 bindings for RP1 driver
Thread-Index: AQHbd7bpVwErdOpEIUy02zQldLHDbQ==
Date: Wed, 5 Feb 2025 10:15:42 +0000
Message-ID: <af9a51c8c43bad746535ff1137555fbba4874a4a.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 1e87c994-db21-4340-633e-08dd45ce0d56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DnQDB4N4kr8a0tAnbRUmk5tUvTTljNYj3O0bbXdBPWFZ8OOugGCc4UzMft?=
 =?iso-8859-1?Q?lZs6s5CneY0v1W3L5LVtd/f7BCuLNibD1KUAxVSRbTko7M6ZbNh1zMg3V9?=
 =?iso-8859-1?Q?nx5s6F1ebKmuRLUpdImbABlehJ47Lp88SAHz5s83diXIN7N4MKUyEcNrlX?=
 =?iso-8859-1?Q?V5tixnbMt3XdBstbdG7LaJzfhFReNO+GZo4Bnaxybv8pQwU7rNrsl+eML2?=
 =?iso-8859-1?Q?bXnRwKr6id+F5LD1WD4wfRZI0g7P7WN7XdroCsTM7fdhoBVTgCkTC12IDY?=
 =?iso-8859-1?Q?LOkfAOoXIbmK6FMxZi1mTpIiFTx+CS7CMf7tMsx1U+AFQtylVltm5sKT9h?=
 =?iso-8859-1?Q?HMk9mWMPRqLX3Q1XbFtNbrCJHnsV3EERKo7MqvMTNfxqQdGx9UreSqsU5w?=
 =?iso-8859-1?Q?ydYgnXC58Qpf/FxOoF6miyF9jUZFwba7Z0Q11e5eMYJ6c5L16KfNveMcyQ?=
 =?iso-8859-1?Q?bzqChuPVlQuKDjgR48C1kzkGcJMPEDiQZ7ry1UzSYaL78dnefI0yWHRYNx?=
 =?iso-8859-1?Q?32JExI/lBmdQ2Oap72PNj8MFfKLhZHBcxUytaELoOzNVo4HwV5UnSsn3aT?=
 =?iso-8859-1?Q?g4eZ2RzLwySCEjfr1ZzQNzY+uQJxlOb5MFpwTnuBTre+5UgzL5OYsPfvHk?=
 =?iso-8859-1?Q?AxZ3sfNo64gZrucdDcLaqaTze2X3qYMbJz4SX4aErtwmCAzrpsYbBVvUug?=
 =?iso-8859-1?Q?rHLnOaHy09ek8fPu3OnF4QCXIUzj7lpwhUI3iOtOOSCAHP38QXc2Fewauv?=
 =?iso-8859-1?Q?bTHSQ5Kjlyb7oXsZIHINYB7hg60W/EDtWoxRPgHB/R9Jc92LUvMroeaeCT?=
 =?iso-8859-1?Q?F7OfEndytQEDZM6ZE3IRrv6/m/GK0sx2DKehuCmyEE0yMxm0bgX1TFNLDh?=
 =?iso-8859-1?Q?5xqetvMm2LZphwpZNh85GJUZHpVoueOnEvpczHv/R4pBRlwcob/sCjhl9I?=
 =?iso-8859-1?Q?DiGCtX3Pj9vvV2NsqynKrKuHTWKzRGYkmDBjVHtlXuseJKMNeR/MX2LTL/?=
 =?iso-8859-1?Q?UV7VWXb6r3xgpQo6BkMbfzKuVqGR2GnkXqAkmwbSJtF3Uk5p5+douzZAHw?=
 =?iso-8859-1?Q?FrV3g5tAm9sQOC3l8BggJGQwMNePXE+RYUFTOX9Yvw+Ug8YcjTnJTdXEm2?=
 =?iso-8859-1?Q?E8nnchj5x2HMeo5mW+UTfgawB/slzIZvX38oEFC2AhMWtxcgsX9uiI4f96?=
 =?iso-8859-1?Q?T/CEKlQXd4sSpTHuql1IcDzgF4BrhCn+FJeqK7VStRfzD3AdQlYvo2cmNL?=
 =?iso-8859-1?Q?yfLbcYd0y+adv1YgaxK7o6JmIUGl0sJsb+sov6F8UyVdomx3jYr/yfbCik?=
 =?iso-8859-1?Q?hWfoKq2sBzsTt03XEVsm81pRWOWuD+b5dm+Z7DPPYttuBIKhLhZJC51e+Q?=
 =?iso-8859-1?Q?0MA/Gs7bpxb5lVXkUeCHZ8GciBfKu3KX5CagfY9e9sPuY3p+ZiMxbmbfxV?=
 =?iso-8859-1?Q?puAg9JtWx8u2d2AMrIpquvn27O24z1VZY3rqi0OffwJ8bAxWQ0jwQaHDhL?=
 =?iso-8859-1?Q?M/l6tR61WylNreqS1eBAl7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3RNXD+T4aoM07jbuS3RaFo8hca8s32IU2CJY2egAzXtG15bJZqzHvfkWHr?=
 =?iso-8859-1?Q?t0QGh1plc3Au3X+ALW/6StEcyySlRHrSAryY1M9a9kYARRXx26zmjYbvPc?=
 =?iso-8859-1?Q?lnWKQJrfcF6x+gYDrqzvPqnly4LPwxQaucUkj2Tdl4WheONq7Jeijurxp2?=
 =?iso-8859-1?Q?o5L9j4LWnitXqTFZuqjAkkt08UPzStv3TW/e6ZsCbaqk74DV3fN1lpRiAW?=
 =?iso-8859-1?Q?mdSbtz+9yZyHXytl++FIAab18gtS+SYeWJJpp1q+0jTQ6NoC43cmgSeMFK?=
 =?iso-8859-1?Q?3McOF9v3OgGDxusULXhg4l6XvPnzGNHVJGaeKKlKWNMD4kG45I30xCOrY0?=
 =?iso-8859-1?Q?EVVOkNG+io7FNLYoCo4+GeeharxXgR2jHNYzLDhYc9aECJGNg77g8Bg901?=
 =?iso-8859-1?Q?G2hgBfxGaT8k20xFjT1nM0wnnQs5lyda6xK8kE5urIwrfCkMgne/1/oGqf?=
 =?iso-8859-1?Q?dyHZoCTzdeyko7eYNTQUDhPO0Jbi02rtA1ULCj0pll2GXnikehJBb1u2ss?=
 =?iso-8859-1?Q?uoQyRsxVc/qCZEJpIj5TUPNypMnro2NaYMv7Rq8vy8B6DMCgubZPDpr1p7?=
 =?iso-8859-1?Q?B99R0ZD0XXfDe4CnplfG5KmTpx03qI2ZusiRkWAIMaj9i+vGWPRYfdRxLG?=
 =?iso-8859-1?Q?LWD71liOzmmXKfTYAtGoUdCro2pfHUF9qaDCJK6ATQFg5Twy583bXWWGt+?=
 =?iso-8859-1?Q?QIbbaME0K4YJuiH75836PmdLFPTzRSyiwrz4bsgOhp58gt6xI0c0wXpCVK?=
 =?iso-8859-1?Q?Zt3RALYoAAh3ImCGs12mpzaej3u4tAYHPMZphfD8chDQqfyarHoJjbRvsR?=
 =?iso-8859-1?Q?toH4uITeQXM59ROnSTkXOrm7q+LL7k/AL58UtuvH10hTXHMC4L4eJGZ2jK?=
 =?iso-8859-1?Q?iBwLcvR7lS72VOwXg9Ms7CgI9Hfr4U+Kq7eNkgMmxADctdE0esbAxWvCXP?=
 =?iso-8859-1?Q?BBxoHW3/jzlBg9Fi/9NKMbUstsNBAwELlLgqdqbrpUbmQ7x8qMcrxPoJ7o?=
 =?iso-8859-1?Q?qax7yYRleKUJCPrQcajcm7IgeZ1DXWqHQ2aHFizaENxIh3Ip6sDXMXU/AT?=
 =?iso-8859-1?Q?dq1u8pmm9pvWwo3pOdBMefd9xqQQGOyohSHlb709gGXzE0Cpvt68tOuwUO?=
 =?iso-8859-1?Q?IMjrqvIFiK5hrIavzSp4SivaG2q+0olkxMeXHWLFZR1LswlnjA4MBqSzXm?=
 =?iso-8859-1?Q?w23zcGBJjrNVQ83FB0HdxyxBkr9hXkFCVXRbT0hayOw217iRKyaTK+Wi3b?=
 =?iso-8859-1?Q?G1jBnmOVFJwVRyhMO8Z4C+Ljr4W2k/sFdBmAb6/xs3LXG+a2ZCH1VRTkcY?=
 =?iso-8859-1?Q?bcd6TiDInZScZEPqz5fHTW3UUVp5hECKPob3edkUU7B3jG0HjqZ5l3CUe8?=
 =?iso-8859-1?Q?fu8lxgnpRP9Qcjm5ckkWBW9rSo8PsXOteHBfyuBUsJv7S4OnVzgF+6jS/Z?=
 =?iso-8859-1?Q?BHOaUiAHLPEGvMmMLLFlzwn1+yf6TeekvUKB5e1FXyJFgrz/qcXQE0uvp5?=
 =?iso-8859-1?Q?07ZOzHKqtY78AAPaN8Gv5jW41xw6k4DGvGKFt0i0xXu759hxdluDDJ/0rN?=
 =?iso-8859-1?Q?YXZPT1Slks4TgTJY9JD/TPNZYjdrJJZMkUDDIqf+e3kbsU9n9eMrEXra1V?=
 =?iso-8859-1?Q?hGqreURCWQwnQYPphmIEP8q2YC1CdPiPHIZVcmqOs2aVDHEG2TVNjpQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e87c994-db21-4340-633e-08dd45ce0d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:42.1546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMtx5BSsrFOGGapnrNcGBSYforSAdHUqS6dv4Zw1I5tJstnTXDvM3OHYNj4Hvf1lyH016rwZxc1L05hDJIARibnnIVdxKlCj+hyT3onfhpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Header includes all needed defines to be used in the device-tree
bindings.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 include/dt-bindings/mfd/rp1.h | 239 ++++++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 include/dt-bindings/mfd/rp1.h

diff --git a/include/dt-bindings/mfd/rp1.h b/include/dt-bindings/mfd/rp1.h
new file mode 100644
index 0000000000..fca5729deb
--- /dev/null
+++ b/include/dt-bindings/mfd/rp1.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for the PY MFD.
+ *
+ * Copyright (c) 2024 EPAM Systems
+ *
+ * Derived from linux rp1.h.
+ */
+
+#ifndef _RP1_H
+#define _RP1_H
+
+/* Address map */
+#define RP1_SYSINFO_BASE 0x000000
+#define RP1_TBMAN_BASE 0x004000
+#define RP1_SYSCFG_BASE 0x008000
+#define RP1_OTP_BASE 0x00c000
+#define RP1_POWER_BASE 0x010000
+#define RP1_RESETS_BASE 0x014000
+#define RP1_CLOCKS_BANK_DEFAULT_BASE 0x018000
+#define RP1_CLOCKS_BANK_VIDEO_BASE 0x01c000
+#define RP1_PLL_SYS_BASE 0x020000
+#define RP1_PLL_AUDIO_BASE 0x024000
+#define RP1_PLL_VIDEO_BASE 0x028000
+#define RP1_UART0_BASE 0x030000
+#define RP1_UART1_BASE 0x034000
+#define RP1_UART2_BASE 0x038000
+#define RP1_UART3_BASE 0x03c000
+#define RP1_UART4_BASE 0x040000
+#define RP1_UART5_BASE 0x044000
+#define RP1_SPI8_BASE 0x04c000
+#define RP1_SPI0_BASE 0x050000
+#define RP1_SPI1_BASE 0x054000
+#define RP1_SPI2_BASE 0x058000
+#define RP1_SPI3_BASE 0x05c000
+#define RP1_SPI4_BASE 0x060000
+#define RP1_SPI5_BASE 0x064000
+#define RP1_SPI6_BASE 0x068000
+#define RP1_SPI7_BASE 0x06c000
+#define RP1_I2C0_BASE 0x070000
+#define RP1_I2C1_BASE 0x074000
+#define RP1_I2C2_BASE 0x078000
+#define RP1_I2C3_BASE 0x07c000
+#define RP1_I2C4_BASE 0x080000
+#define RP1_I2C5_BASE 0x084000
+#define RP1_I2C6_BASE 0x088000
+#define RP1_AUDIO_IN_BASE 0x090000
+#define RP1_AUDIO_OUT_BASE 0x094000
+#define RP1_PWM0_BASE 0x098000
+#define RP1_PWM1_BASE 0x09c000
+#define RP1_I2S0_BASE 0x0a0000
+#define RP1_I2S1_BASE 0x0a4000
+#define RP1_I2S2_BASE 0x0a8000
+#define RP1_TIMER_BASE 0x0ac000
+#define RP1_SDIO0_APBS_BASE 0x0b0000
+#define RP1_SDIO1_APBS_BASE 0x0b4000
+#define RP1_BUSFABRIC_MONITOR_BASE 0x0c0000
+#define RP1_BUSFABRIC_AXISHIM_BASE 0x0c4000
+#define RP1_ADC_BASE 0x0c8000
+#define RP1_IO_BANK0_BASE 0x0d0000
+#define RP1_IO_BANK1_BASE 0x0d4000
+#define RP1_IO_BANK2_BASE 0x0d8000
+#define RP1_SYS_RIO0_BASE 0x0e0000
+#define RP1_SYS_RIO1_BASE 0x0e4000
+#define RP1_SYS_RIO2_BASE 0x0e8000
+#define RP1_PADS_BANK0_BASE 0x0f0000
+#define RP1_PADS_BANK1_BASE 0x0f4000
+#define RP1_PADS_BANK2_BASE 0x0f8000
+#define RP1_PADS_ETH_BASE 0x0fc000
+#define RP1_ETH_IP_BASE 0x100000
+#define RP1_ETH_CFG_BASE 0x104000
+#define RP1_PCIE_APBS_BASE 0x108000
+#define RP1_MIPI0_CSIDMA_BASE 0x110000
+#define RP1_MIPI0_CSIHOST_BASE 0x114000
+#define RP1_MIPI0_DSIDMA_BASE 0x118000
+#define RP1_MIPI0_DSIHOST_BASE 0x11c000
+#define RP1_MIPI0_MIPICFG_BASE 0x120000
+#define RP1_MIPI0_ISP_BASE 0x124000
+#define RP1_MIPI1_CSIDMA_BASE 0x128000
+#define RP1_MIPI1_CSIHOST_BASE 0x12c000
+#define RP1_MIPI1_DSIDMA_BASE 0x130000
+#define RP1_MIPI1_DSIHOST_BASE 0x134000
+#define RP1_MIPI1_MIPICFG_BASE 0x138000
+#define RP1_MIPI1_ISP_BASE 0x13c000
+#define RP1_VIDEO_OUT_CFG_BASE 0x140000
+#define RP1_VIDEO_OUT_VEC_BASE 0x144000
+#define RP1_VIDEO_OUT_DPI_BASE 0x148000
+#define RP1_XOSC_BASE 0x150000
+#define RP1_WATCHDOG_BASE 0x154000
+#define RP1_DMA_TICK_BASE 0x158000
+#define RP1_SDIO_CLOCKS_BASE 0x15c000
+#define RP1_USBHOST0_APBS_BASE 0x160000
+#define RP1_USBHOST1_APBS_BASE 0x164000
+#define RP1_ROSC0_BASE 0x168000
+#define RP1_ROSC1_BASE 0x16c000
+#define RP1_VBUSCTRL_BASE 0x170000
+#define RP1_TICKS_BASE 0x174000
+#define RP1_PIO_APBS_BASE 0x178000
+#define RP1_SDIO0_AHBLS_BASE 0x180000
+#define RP1_SDIO1_AHBLS_BASE 0x184000
+#define RP1_DMA_BASE 0x188000
+#define RP1_RAM_BASE 0x1c0000
+#define RP1_RAM_SIZE 0x020000
+#define RP1_USBHOST0_AXIS_BASE 0x200000
+#define RP1_USBHOST1_AXIS_BASE 0x300000
+#define RP1_EXAC_BASE 0x400000
+
+/* Interrupts */
+
+#define RP1_INT_IO_BANK0 0
+#define RP1_INT_IO_BANK1 1
+#define RP1_INT_IO_BANK2 2
+#define RP1_INT_AUDIO_IN 3
+#define RP1_INT_AUDIO_OUT 4
+#define RP1_INT_PWM0 5
+#define RP1_INT_ETH 6
+#define RP1_INT_I2C0 7
+#define RP1_INT_I2C1 8
+#define RP1_INT_I2C2 9
+#define RP1_INT_I2C3 10
+#define RP1_INT_I2C4 11
+#define RP1_INT_I2C5 12
+#define RP1_INT_I2C6 13
+#define RP1_INT_I2S0 14
+#define RP1_INT_I2S1 15
+#define RP1_INT_I2S2 16
+#define RP1_INT_SDIO0 17
+#define RP1_INT_SDIO1 18
+#define RP1_INT_SPI0 19
+#define RP1_INT_SPI1 20
+#define RP1_INT_SPI2 21
+#define RP1_INT_SPI3 22
+#define RP1_INT_SPI4 23
+#define RP1_INT_SPI5 24
+#define RP1_INT_UART0 25
+#define RP1_INT_TIMER_0 26
+#define RP1_INT_TIMER_1 27
+#define RP1_INT_TIMER_2 28
+#define RP1_INT_TIMER_3 29
+#define RP1_INT_USBHOST0 30
+#define RP1_INT_USBHOST0_0 31
+#define RP1_INT_USBHOST0_1 32
+#define RP1_INT_USBHOST0_2 33
+#define RP1_INT_USBHOST0_3 34
+#define RP1_INT_USBHOST1 35
+#define RP1_INT_USBHOST1_0 36
+#define RP1_INT_USBHOST1_1 37
+#define RP1_INT_USBHOST1_2 38
+#define RP1_INT_USBHOST1_3 39
+#define RP1_INT_DMA 40
+#define RP1_INT_PWM1 41
+#define RP1_INT_UART1 42
+#define RP1_INT_UART2 43
+#define RP1_INT_UART3 44
+#define RP1_INT_UART4 45
+#define RP1_INT_UART5 46
+#define RP1_INT_MIPI0 47
+#define RP1_INT_MIPI1 48
+#define RP1_INT_VIDEO_OUT 49
+#define RP1_INT_PIO_0 50
+#define RP1_INT_PIO_1 51
+#define RP1_INT_ADC_FIFO 52
+#define RP1_INT_PCIE_OUT 53
+#define RP1_INT_SPI6 54
+#define RP1_INT_SPI7 55
+#define RP1_INT_SPI8 56
+#define RP1_INT_SYSCFG 58
+#define RP1_INT_CLOCKS_DEFAULT 59
+#define RP1_INT_VBUSCTRL 60
+#define RP1_INT_PROC_MISC 57
+#define RP1_INT_END 61
+
+/* DMA peripherals (for pacing) */
+#define RP1_DMA_I2C0_RX 0x0
+#define RP1_DMA_I2C0_TX 0x1
+#define RP1_DMA_I2C1_RX 0x2
+#define RP1_DMA_I2C1_TX 0x3
+#define RP1_DMA_I2C2_RX 0x4
+#define RP1_DMA_I2C2_TX 0x5
+#define RP1_DMA_I2C3_RX 0x6
+#define RP1_DMA_I2C3_TX 0x7
+#define RP1_DMA_I2C4_RX 0x8
+#define RP1_DMA_I2C4_TX 0x9
+#define RP1_DMA_I2C5_RX 0xa
+#define RP1_DMA_I2C5_TX 0xb
+#define RP1_DMA_SPI0_RX 0xc
+#define RP1_DMA_SPI0_TX 0xd
+#define RP1_DMA_SPI1_RX 0xe
+#define RP1_DMA_SPI1_TX 0xf
+#define RP1_DMA_SPI2_RX 0x10
+#define RP1_DMA_SPI2_TX 0x11
+#define RP1_DMA_SPI3_RX 0x12
+#define RP1_DMA_SPI3_TX 0x13
+#define RP1_DMA_SPI4_RX 0x14
+#define RP1_DMA_SPI4_TX 0x15
+#define RP1_DMA_SPI5_RX 0x16
+#define RP1_DMA_SPI5_TX 0x17
+#define RP1_DMA_PWM0 0x18
+#define RP1_DMA_UART0_RX 0x19
+#define RP1_DMA_UART0_TX 0x1a
+#define RP1_DMA_AUDIO_IN_CH0 0x1b
+#define RP1_DMA_AUDIO_IN_CH1 0x1c
+#define RP1_DMA_AUDIO_OUT 0x1d
+#define RP1_DMA_PWM1 0x1e
+#define RP1_DMA_I2S0_RX 0x1f
+#define RP1_DMA_I2S0_TX 0x20
+#define RP1_DMA_I2S1_RX 0x21
+#define RP1_DMA_I2S1_TX 0x22
+#define RP1_DMA_I2S2_RX 0x23
+#define RP1_DMA_I2S2_TX 0x24
+#define RP1_DMA_UART1_RX 0x25
+#define RP1_DMA_UART1_TX 0x26
+#define RP1_DMA_UART2_RX 0x27
+#define RP1_DMA_UART2_TX 0x28
+#define RP1_DMA_UART3_RX 0x29
+#define RP1_DMA_UART3_TX 0x2a
+#define RP1_DMA_UART4_RX 0x2b
+#define RP1_DMA_UART4_TX 0x2c
+#define RP1_DMA_UART5_RX 0x2d
+#define RP1_DMA_UART5_TX 0x2e
+#define RP1_DMA_ADC 0x2f
+#define RP1_DMA_DMA_TICK_TICK0 0x30
+#define RP1_DMA_DMA_TICK_TICK1 0x31
+#define RP1_DMA_SPI6_RX 0x32
+#define RP1_DMA_SPI6_TX 0x33
+#define RP1_DMA_SPI7_RX 0x34
+#define RP1_DMA_SPI7_TX 0x35
+#define RP1_DMA_SPI8_RX 0x36
+#define RP1_DMA_SPI8_TX 0x37
+#define RP1_DMA_PIO_CH0_TX 0x38
+#define RP1_DMA_PIO_CH0_RX 0x39
+#define RP1_DMA_PIO_CH1_TX 0x3a
+#define RP1_DMA_PIO_CH1_RX 0x3b
+#define RP1_DMA_PIO_CH2_TX 0x3c
+#define RP1_DMA_PIO_CH2_RX 0x3d
+#define RP1_DMA_PIO_CH3_TX 0x3e
+#define RP1_DMA_PIO_CH3_RX 0x3f
+
+#endif
--=20
2.34.1
