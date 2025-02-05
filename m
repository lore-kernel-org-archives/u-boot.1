Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37121C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9B280BA4;
	Wed,  5 Feb 2025 14:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="eKnMusmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0671D805D7; Wed,  5 Feb 2025 11:16:00 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BE68806FE
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzCW+zWbGrj58zA1/5dlv+wbmFFC16pCafiPd7UPTm5dTPNVxCkwjKOimW9x8evSta2LFm+HyFcWl13FA01OP3apURN0GoESPcrqi+XsZPvXldGVxj0iUMjZMf5kXKb/bTlpsWA4A36YyRsBu087sEsqujmKn5emeoTsR6YFzwilD8/Z+yUWZ2T0Hp1G8tWmhTKSHPP6f29IK8CpRoathrBbHdXidWQDFQL3BLk24k3Xy5Pj3/Ne7F2MBdaH0b7NMzUSi7QrFBRO7PvisZEuGWKespShDnvc86or0Wk6hoP4bb5ma8anzWUWGIHWil9NIbHda80ToFy7+3lF7dd1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGnXHq0urpmsWE+OBh3BZXz5yHiZkJpw6T9h/7V2QtA=;
 b=LksT9WhGEYaKTfcWjWbo61RIFERPNfMRmUZt1TcF9EsG0oGvTLGDAXqvKt1wtcgW88Ckm1/4+D5G83wAMnBtzlPEb4A1SnlJ3gvrK9HarWfzFxEi0JVIbVBvPxljMUcpUnxFWv43jXDodJgSuq3wNQRZ+saIg/BYhULe7HyBhIDBHn4wKK3tAGjTzRrtmh9CbBa1ixwar8v9CrM/8/vCep8cZDdTfD7NRHCJyxv7o/PxWl9D+aMva5B6qYGPnzobhX2tDDszeu7xZLUVFsLEMy2I+/7AB6u2i5UiLTjVrakkwoL3aIlF695Y4p2ElEqFrk9t+ZzIhMSdsb9bFcOd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGnXHq0urpmsWE+OBh3BZXz5yHiZkJpw6T9h/7V2QtA=;
 b=eKnMusmFmSWvppuFLkilYO/IIXTWBHcdeJ1ypqiitMJ/DpJo266D7VDuAAAss+pz6MzW3j1FZ+O/XPP/P6kOYcmqa+P4sh5gMeJAD9FASEyxEDoO3tKcXNDmtfithlm2nsvFU5vjwk8IqK8l1/kAqNaWoEGa2G3g6SZdAZj7tfe7XGoBNtT9H9iaIZdVJ6p/uQCylw6+Mz5kI/K32as/G3vyAVywl1asSHxXDs9+yRCp7WdjQFW8abpgHnIu62txlUuuQtSlw227KRp6LFpLBGyBhUsw7j+u3F9pSMl+I2ytXqSl3dYL8q2Sf6zevb4s+sQ/TtonNiZ2nfRF1RiZaA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:50 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:50 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 12/20] drivers: reset: introduce reset drivers for
 brcmstb
Thread-Topic: [RFC PATCH v1 12/20] drivers: reset: introduce reset drivers for
 brcmstb
Thread-Index: AQHbd7brRK46kdXDi020vHGfkhgHOw==
Date: Wed, 5 Feb 2025 10:15:45 +0000
Message-ID: <8acccb9f5148d9042ba79249fba8323400374a8a.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 01df82ec-f696-444e-88ac-08dd45ce10ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GZkJdI1Buga7g6Oj8IbDHQrGd2NID4as33hHuxgBeg3tGp165/n0E2EDyc?=
 =?iso-8859-1?Q?o2MW+PAWQ5J+4tV0kBx3OF70Qs3jPwcgjjSLDMGYVmylbaPTpBnkn0yvE2?=
 =?iso-8859-1?Q?t9SPJIsQa5RM4c6GsIeYFXjxAdNy4TnweULutv75O8cTXw5K31y6AxPot6?=
 =?iso-8859-1?Q?JfA1+4MzhNwDaDqLIzUmSoWEy32yEb6aH64dXP3zazvqiEcU7mWXp8OrIj?=
 =?iso-8859-1?Q?N5iVlnRZaV/NZVxxgYAIeiXZIjnzbEqY44kmdF2Krm5z2U+gjVT1ss2nSi?=
 =?iso-8859-1?Q?feC47X5tQKp/wJcxLKgK2buWtGlhaCVQIdMW52/ZexbSTIAMnL4Alwttvc?=
 =?iso-8859-1?Q?TYB7qlrffTDTOU0qbevE+CGd43aiXGMtohSDu13VNFkAPikXFsdHC1SCN2?=
 =?iso-8859-1?Q?aq9b3g3c4yiVqlpICg+x+PkM7KqTVTqHKuees5yQCn65IZzUCNQziHOuJ0?=
 =?iso-8859-1?Q?8DR/dvWF9EQwk1Vcc8IJ6V2X2qKi460nDYC/CfLp7UC+0sbNAtpyKxryZL?=
 =?iso-8859-1?Q?eZcqdpj8cLO6L9XuTvvNpne+PHfs+9mYvlr9ewahCqQ6XMZ7s0FH+KalSJ?=
 =?iso-8859-1?Q?MazlBXdpACIF4hdHeVBZRIRbcY++KAjHLeJKoybo8veDUqrxh8e3wyasPi?=
 =?iso-8859-1?Q?9XO5hvilZ7nFopPfV2LUOV1W6XoU/esNYLMrsWCTG3sNYBJnUkTm7P9SgC?=
 =?iso-8859-1?Q?EFT5/Z3hROBCvaJJslji1BoAr9LW7sLsXGsw6JD7c+SVPnBupbPbZT7qLe?=
 =?iso-8859-1?Q?l2qwNVmE2Ezibas8IAwV5mIckzkbwWbrj/Yy+7GD1Ltc09aBb54yq4b8tf?=
 =?iso-8859-1?Q?rv1kP+VBBomMSBMFh+oJDYa76sytLI9YI+Ow2RSZBYEwRI31pWUFqHK6tq?=
 =?iso-8859-1?Q?RDU7soOjnlZWxYds/xPdO0cxb/857LvjCpt7USdakstxq5jlHBF65OnYfN?=
 =?iso-8859-1?Q?Gc5Y4vZdFZ54wNHwOFUhIk47UIVi8puZeHb11uzH1Dfqe/07yRvvZba37J?=
 =?iso-8859-1?Q?x3B+ZYjY/z1mH2obq81rzr9C5+deHc71k8qfXehtx6clXk0IoOuXRN2SMP?=
 =?iso-8859-1?Q?B3IYuFW6I73GzcaAyBtfmEFHOa3myJFOT3mnX93TCcIVqmHmSXJOFpMlji?=
 =?iso-8859-1?Q?tLt7ENRFf5RvBPmKQFm8eSfYyw6ePE1FlLXRfG19WDQn621+MrXOR89klb?=
 =?iso-8859-1?Q?kiIV4ornjwkq5AVSt/Asdg3BjM7mMyRpNNfH7Ph7BLb/tF/bnUCx6z5Qj4?=
 =?iso-8859-1?Q?DA+0Ssrk0hjchBYVQ3of1rCFNMhkvi3gBR8XvOui2AKk9tvcU907KD6J+I?=
 =?iso-8859-1?Q?c4Ge0ERTKy2Jvsa3S6an/G/m0jrgjeVZJH7+d0MpZ0IremdCh1wuI2ndh5?=
 =?iso-8859-1?Q?0LXXQ1IR1E3hwhIRez1RaVWUjIsu+Vu8hhmKflCrp3/JlnKx8CiGz9RY0+?=
 =?iso-8859-1?Q?ga+OiYODSVgkGUxS75pP+eJ0yow4yzxt2CRZgZ+zYsjjFZysoupQZDNiMt?=
 =?iso-8859-1?Q?t+MAxlOfR6nIkWmR7wW5j+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MCngpFXHxcv85Iz81A/N3SkgrfP6I03zCMyzXTLfs+xNj1td+oXnUXiTTw?=
 =?iso-8859-1?Q?CDR43Kh2Bk8k61R0ugysgxGJnr8mMFEhfq0kjVAGVf+16pCj33PtcKmPan?=
 =?iso-8859-1?Q?PsHDZVpmkPKF0mYVSburU7Z9oEculKjWDIgIYvyoLI5ney311fDKluAvp9?=
 =?iso-8859-1?Q?3xWJLXvYlwYbODK90iZurWpzNO1jx94t1zusS1zIx6pvaNYOu3sJo1r3xz?=
 =?iso-8859-1?Q?45A8h0k4gO6nHEpzuIwSoQiZSzpz3k7xgJ91xIwneO0HSpDrbs5kF9YHLN?=
 =?iso-8859-1?Q?7HOMnl3L2VXP3zS+R2cLEP2TqIJZS1vRFNos5POAaRrCnKVqISNUJ7guAx?=
 =?iso-8859-1?Q?XulCJduxyYWGYH7jOeXw1GMSx67QFP9koamWHy/UTEbM2+NgdwA6YICOIX?=
 =?iso-8859-1?Q?mhDTyVBTgscROnSddB53yRbPz0L+JLr7A57hdSm7sM9WI9YXlQOj2Pp81T?=
 =?iso-8859-1?Q?LiYNka35vbKaaKISRfipGsfLTbx8RiftgWtHQIdmAyszBk8AgFq1eeIuQt?=
 =?iso-8859-1?Q?XmeQXEWAej13NkADja23WY/i1ywh06bBr6/KzTAp8CRrrmFCbFsEf5/qXV?=
 =?iso-8859-1?Q?llXIRH35W33f2QJJglFDAgvHo8S/LtVR//hhg1/IgZydByxK8noFInE1D0?=
 =?iso-8859-1?Q?D99jMXXYB/HJHJyVQRbgb16toNnaeF2CFxXqpIwRMU5lqIME38rscbJpPZ?=
 =?iso-8859-1?Q?dob6b1uLDaDA+vr9XP5niKmBxmiB4COYSgDcR1yOQqUPYOgLb63BG2RPwI?=
 =?iso-8859-1?Q?Lon68iD/vA82eqGb9BFogEK0jEjfvA8m2CsQkKAOt2+mqnR449J7dFClxA?=
 =?iso-8859-1?Q?2S4rbz4eOBwLM9h/6UmK8PQOxNSgkbJ91eYIUDXyhOMPI7AQccmt9CvQsV?=
 =?iso-8859-1?Q?w3iVdUiJryBO/fs6Md4v6AInlfSWZaCyEl5OEuxoWSD8kr3xpH/vrXZHw5?=
 =?iso-8859-1?Q?H24Ih5JzOI/v3GZo+aUIMaY0zxPhyToeds4zon0heHcFGHm1BR+My64R+0?=
 =?iso-8859-1?Q?wvntYccDarzoCYKQ5WMzX8BrwdLr+9N7g0PX0KfNp0CA4ZAtkETEImky5u?=
 =?iso-8859-1?Q?CX7/GJqqVj0RTUZHlp5eBo9sZcH+KcIJgly0roBhU0Es7fhDbIB8ghsHcC?=
 =?iso-8859-1?Q?MkpljH6hmlAPE9PKRlyopqKQGPkyIHAGD1c9U3bF/bng29PJVGE9iZY1Tl?=
 =?iso-8859-1?Q?5jy45veU4pPrA6sB2GZkyJKHtxHcZFiu4nIJhMx32DAX+vnJLB5iguSXYX?=
 =?iso-8859-1?Q?rEjickLJn7FSahYOaz5dtYRwp+6BMXa+XrIYOhMqNe5ffyVlmACDreztet?=
 =?iso-8859-1?Q?62OFAwo4XYTIz6f/Rvx4EuxVnu4xycThhXmIGyLg9DAmPhp/bhYJfcdiR3?=
 =?iso-8859-1?Q?8CFf01OPc7ijacUbnchYd5UAIjcpt+FTAo8okSGOZIz79GalQjBRpmBBKW?=
 =?iso-8859-1?Q?KMJriKvFkEt64TS1wJdddfaxgKF/8VlMKPaGYOH831IBT8YXZj6tyeoFrN?=
 =?iso-8859-1?Q?IYfkDVdyqlKAX1E1rZdNgzZBRpm7UbDf1ehhxezq5Cexm1dFn89YjBQ5oR?=
 =?iso-8859-1?Q?jzNFS5SV9+ILCZBXxn7MIkkhfRBOmJBVfR4fiWaLoPQ9kZHPxPT/NQ2UJ1?=
 =?iso-8859-1?Q?u0Uoo/CsivPQ4GGmDaCacWRsOvfUDXsoFmqAYM8+Y7KC6K2yOGhjFecw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01df82ec-f696-444e-88ac-08dd45ce10ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:45.8496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPylEN+us/47g2xR5PBAGp0zp6KgBgqbQWoQnHGWFDRA2n7HVZFl+Gt2wn1W7//tGJEu/JzO/YWH9YlQQPTD81aXqjAWWgHcZj6Ke5uwGvY=
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

Introducing Generic Reset controller and Generic RESCAL
drivers for Broadcom boards.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/reset/Kconfig                |  14 ++++
 drivers/reset/Makefile               |   2 +
 drivers/reset/reset-brcmstb-rescal.c | 103 +++++++++++++++++++++++++++
 drivers/reset/reset-brcmstb.c        |  97 +++++++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb-rescal.c
 create mode 100644 drivers/reset/reset-brcmstb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index fe5c1214f5..cabb9dafe1 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -63,6 +63,20 @@ config RESET_BCM6345
 	help
 	  Support reset controller on BCM6345.
=20
+config RESET_BRCMSTB
+	bool "Generic Reset controller driver for Broadcom"
+	help
+	  This enables reset controller for Broadcom devices.
+	  If you wish to use reset resources managed by the Broadcom
+	  Reset Controller, say Y here. Otherwise, say N.
+
+config RESET_BRCMSTB_RESCAL
+	bool "Generic Rescal Reset controller driver for Broadcom"
+	help
+	  Support rescal reset controller on Broadcom.
+	  If you wish to use reset resources managed by the Broadcom
+	  Reset Controller, say Y here. Otherwise, say N.
+
 config RESET_UNIPHIER
 	bool "Reset controller driver for UniPhier SoCs"
 	depends on ARCH_UNIPHIER
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2eb639e4a6..45cf2f1b4d 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_TEGRA186_RESET) +=3D tegra186-reset.o
 obj-$(CONFIG_RESET_TI_SCI) +=3D reset-ti-sci.o
 obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
 obj-$(CONFIG_RESET_BCM6345) +=3D reset-bcm6345.o
+obj-$(CONFIG_RESET_BRCMSTB) +=3D reset-brcmstb.o
+obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-brcmstb-rescal.o
 obj-$(CONFIG_RESET_UNIPHIER) +=3D reset-uniphier.o
 obj-$(CONFIG_RESET_AST2500) +=3D reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) +=3D reset-ast2600.o
diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brc=
mstb-rescal.c
new file mode 100644
index 0000000000..fc8fcfa8b3
--- /dev/null
+++ b/drivers/reset/reset-brcmstb-rescal.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller
+ *
+ * Copyright (C) 2024 EPAM Systems
+ * Moved from linux kernel:
+ * Copyright (C) 2018-2020 Broadcom
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+#define BRCM_RESCAL_START 0x0
+#define BRCM_RESCAL_START_BIT BIT(0)
+#define BRCM_RESCAL_CTRL 0x4
+#define BRCM_RESCAL_STATUS 0x8
+#define BRCM_RESCAL_STATUS_BIT BIT(0)
+
+struct brcm_rescal_reset {
+	void __iomem *base;
+};
+
+/* Also doubles a deassert */
+static int brcm_rescal_reset_set(struct reset_ctl *rst)
+{
+	struct brcm_rescal_reset *data =3D dev_get_priv(rst->dev);
+	void __iomem *base =3D data->base;
+	u32 reg;
+	int ret;
+
+	reg =3D readl(base + BRCM_RESCAL_START);
+	writel(reg | BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+	reg =3D readl(base + BRCM_RESCAL_START);
+	if (!(reg & BRCM_RESCAL_START_BIT)) {
+		dev_err(rst->dev, "failed to start SATA/PCIe rescal\n");
+		return -EIO;
+	}
+
+	ret =3D readl_poll_timeout(base + BRCM_RESCAL_STATUS, reg,
+				 (reg & BRCM_RESCAL_STATUS_BIT), 100);
+	if (ret) {
+		dev_err(rst->dev, "time out on SATA/PCIe rescal\n");
+		return ret;
+	}
+
+	reg =3D readl(base + BRCM_RESCAL_START);
+	writel(reg & ~BRCM_RESCAL_START_BIT, base + BRCM_RESCAL_START);
+
+	dev_dbg(rst->dev, "SATA/PCIe rescal success\n");
+	return 0;
+}
+
+/* A dummy function - deassert/reset does all the work */
+static int brcm_rescal_reset_assert(struct reset_ctl *rst)
+{
+	return 0;
+}
+
+static int brcm_rescal_reset_xlate(struct reset_ctl *reset_ctl,
+				   struct ofnode_phandle_args *args)
+{
+	/* This is needed if #reset-cells =3D=3D 0. */
+	return 0;
+}
+
+static const struct reset_ops brcm_rescal_reset_ops =3D {
+	.rst_deassert =3D brcm_rescal_reset_set,
+	.rst_assert =3D brcm_rescal_reset_assert,
+	.of_xlate =3D brcm_rescal_reset_xlate,
+};
+
+static int brcm_rescal_reset_probe(struct udevice *dev)
+{
+	struct brcm_rescal_reset *data =3D dev_get_priv(dev);
+
+	data->base =3D dev_remap_addr(dev);
+	if (!data->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id brcm_rescal_reset_of_match[] =3D {
+	{.compatible =3D "brcm,bcm7216-pcie-sata-rescal"},
+	{},
+};
+
+U_BOOT_DRIVER(brcmstb_reset_rescal) =3D {
+	.name =3D "brcmstb-reset-rescal",
+	.id =3D UCLASS_RESET,
+	.of_match =3D brcm_rescal_reset_of_match,
+	.ops =3D &brcm_rescal_reset_ops,
+	.probe =3D brcm_rescal_reset_probe,
+	.priv_auto =3D sizeof(struct brcm_rescal_reset),
+};
diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
new file mode 100644
index 0000000000..7861f7c9ba
--- /dev/null
+++ b/drivers/reset/reset-brcmstb.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller
+ *
+ * Copyright (C) 2024 EPAM Systems
+ *
+ * Moved from linux kernel:
+ * Author: Florian Fainelli <f.fainelli@gmail.com>
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <log.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+struct brcmstb_reset {
+	void __iomem *base;
+};
+
+#define SW_INIT_SET 0x00
+#define SW_INIT_CLEAR 0x04
+#define SW_INIT_STATUS 0x08
+
+#define SW_INIT_BIT(id) BIT((id) & 0x1f)
+#define SW_INIT_BANK(id) ((id) >> 5)
+
+#define usleep_range(a, b) udelay((b))
+
+/* A full bank contains extra registers that we are not utilizing but stil=
l
+ * qualify as a single bank.
+ */
+#define SW_INIT_BANK_SIZE 0x18
+
+static int brcmstb_reset_assert(struct reset_ctl *rst)
+{
+	unsigned int off =3D SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv =3D dev_get_priv(rst->dev);
+
+	writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_SET);
+	return 0;
+}
+
+static int brcmstb_reset_deassert(struct reset_ctl *rst)
+{
+	unsigned int off =3D SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv =3D dev_get_priv(rst->dev);
+
+	writel_relaxed(SW_INIT_BIT(rst->id), priv->base + off + SW_INIT_CLEAR);
+	/* Maximum reset delay after de-asserting a line and seeing block
+	 * operation is typically 14us for the worst case, build some slack
+	 * here.
+	 */
+	usleep_range(100, 200);
+	return 0;
+}
+
+static int brcmstb_reset_status(struct reset_ctl *rst)
+{
+	unsigned int off =3D SW_INIT_BANK(rst->id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv =3D dev_get_priv(rst->dev);
+
+	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
+			SW_INIT_BIT(rst->id);
+}
+
+struct reset_ops brcmstb_reset_reset_ops =3D {
+	.rst_assert =3D brcmstb_reset_assert,
+	.rst_deassert =3D brcmstb_reset_deassert,
+	.rst_status =3D brcmstb_reset_status};
+
+static int brcmstb_reset_probe(struct udevice *dev)
+{
+	struct brcmstb_reset *priv =3D dev_get_priv(dev);
+
+	priv->base =3D dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct udevice_id brcmstb_reset_ids[] =3D {
+	{.compatible =3D "brcm,brcmstb-reset"}, {/* sentinel */}};
+
+U_BOOT_DRIVER(brcmstb_reset) =3D {
+	.name =3D "brcmstb-reset",
+	.id =3D UCLASS_RESET,
+	.of_match =3D brcmstb_reset_ids,
+	.ops =3D &brcmstb_reset_reset_ops,
+	.probe =3D brcmstb_reset_probe,
+	.priv_auto =3D sizeof(struct brcmstb_reset),
+};
--=20
2.34.1
