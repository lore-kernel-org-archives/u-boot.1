Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5170FC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0977D810F2;
	Wed, 19 Feb 2025 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Rt0pjIPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105F8809A4; Wed, 19 Feb 2025 08:26:19 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF891800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBMRHcHf2E2O2ehC/CJv4WVMqhKxB/yuzK4OP8GtqyQoE6xg90xG9QVeN1oLjm0bm1bEcpxG8gcmln7spmMiiZlhw5Q5XldVRgGswnzoGjg3kELqKt8n4BO6zGqMzJMBQOihLakV9VMySwpbBLFq6hwkzV2fSrCVA0hLRbP511kPgOe0ZqSdGDHaudVW+r8fIA4w5zISPD8OGY2Bpx4N/rEh8m1Zk4kNcHo2L4X56XfqwqnxsnU97fL8yntLJbgCASAVigdP5qpZrzp+8FMETs6EPQXwyXDLX25WZ8XhFUp7Ti/3J5Eg13A2iUomy3NWEUytPLZRMVr2CqZOBB+ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/SdC8+qqF49+6kjIkOTnJcAqrGICA1bEJfHt27EG20=;
 b=mglXR31+Tofgiyh9xLsTZ0L48B75sGint0NgQGNB086DkBWD4xgFiETMiFqz1L9vQOqWmEGroT983F3fR7+B1bODsw2H/amG/u3wtxQLo80HJedG2mV2ffeFL5r2lGLt0tArucTXmMP6PAepsqbSaGQiTKg1M+bJTOrjOy+zrxL96dR+V8AUTvVD3ob7HIDe0j9aWRY2RRKiFD/Kl46q/o78alMU/OLEu2j9YRW+2wTB3LCYUdgUeGtSAaYIyArPXEXRrABdvurFAs5yNv1Drbz49Sv/UAv6f2EFR+92iqnpWzWp83POdP3bbp1Tv8RgfjuhNYivtUBJ68tlQMlpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/SdC8+qqF49+6kjIkOTnJcAqrGICA1bEJfHt27EG20=;
 b=Rt0pjIPEFxVuq9ejywbHPNhIDhtkKx70aacTpZsdRICTqr/cAlGo2kOlvVRd7q+izwMwqAUq9MEx1FZBPJpTnmseLMBwHZJHjME2SQ69N2YnsrXELZyP5jxD980xAbatMpxmJDFCvx9v4mh9Z5FzgdE5WabIOpSFr0MWznp7/6v6Uyd79mJbVSuYnxVMYJgWsIQedVHjBsKLWafJeoDpnXBuft6W/5u+AIv518oC4xizZaS58zTNjtlTFGuVq/kLpTExPoR4lJOrAfl6BKpW4t6AI80XV1BiYUrPNWKjzQes2KU6l5ds6Anyh5fjjWMan9u2vb8ywlYyCstVV9BQDw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:26:14 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:26:14 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 24/26] arm: socfpga: soc64: Add support for
 board_boot_order()
Thread-Topic: [PATCH v2 24/26] arm: socfpga: soc64: Add support for
 board_boot_order()
Thread-Index: AQHbgeAxwwZoHtTVB0Sk3zZXUpH3DLNOO1WA
Date: Wed, 19 Feb 2025 07:26:14 +0000
Message-ID: <SN6PR03MB358382B0F9EC7F8CE31EA415A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-25-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-25-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 652c675e-3d58-44bd-8532-08dd50b6b159
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?n2MAMxf2bYFjPcSBCDZuQGIxTcN1ZOnMmzlhYJQX+ujqHPCRrXMKqqlfyVIx?=
 =?us-ascii?Q?2kejwSpAeMMJxsjUqpA7iqhp01jL/lJMzYeo2ZzbySi/cmMUXY2Up/fc2sc1?=
 =?us-ascii?Q?Mv9+WEG1LlvA5sypLdCsu9l30hp94aFP7nvA3T6dXneSjNCbdW3IoowHx+uV?=
 =?us-ascii?Q?ayY/O4J52S4bRwiG/AbPeFwnydBSFIvbG6x1KLlFWS4EAbzuGmK+vN6usdZ/?=
 =?us-ascii?Q?EZQzWscnMh4zaR6FcHXST5WLE07F4/6nqVo2+hCjAh76bUAyYzi5iBUJgH4r?=
 =?us-ascii?Q?fZf2q0KTQn6duuOkgD2EeUXMa6/XsyWLmcGG08RxlrCplvkb9SqH9w8Pn4pe?=
 =?us-ascii?Q?OxGySTZqAqQKVtzuEaJcrx6I32gxbCx3lLmU6Zy3e3ZpTWTZrY4zb8Gl7OC/?=
 =?us-ascii?Q?bKbsNTzZD2stSS115TXaMcBp26AFS/u0OQuUGGT93I0JDVce+GRFYKmQpTQV?=
 =?us-ascii?Q?fOecjG1pkRVobu365931ow5/T5tAE+oNxDMAImB0D2G+SAIT3T8E0XdiskJ3?=
 =?us-ascii?Q?UxErYrKT0W1YQOD8mBXEnNgjMm+IChRSTZS/D8KAsPy/wYx6D7ofLBUllfDV?=
 =?us-ascii?Q?OVSnZe6AMGiOkKRGLuYWgIAm0HDV8oQ9weSMhDy02+qG6dG53WxCyUR8E1VI?=
 =?us-ascii?Q?QNMyHqthUhloW5j5ILp7MvwljrqnyjvZaKRIILJnEv7+oaZbrnJGBLfNgr/U?=
 =?us-ascii?Q?w85OVQEpBBDMOrPwmS2jlhCsir2QUkUcMprTsw2SttfUWGYK/Og3Qe+yyF2j?=
 =?us-ascii?Q?m342KZkCigv3QlWmT1f1jp9nr9NDorU/IrOIv01344yX8I9wf6JnXPpJ7fru?=
 =?us-ascii?Q?8/KcLGKAvHdwSDBTZXMR84/6bbozmnECI7PoqZRf04KBNqUmQzo19TqxGaBH?=
 =?us-ascii?Q?nGEWZbqQGswX22bmkk7igu0edUsZIDcJoUepW5MJuXcLk5YqVrx/K9N21Xga?=
 =?us-ascii?Q?BOzfUoV9lx9XSGPWFfAx5QI7Al2QmZJg7Vnkh3SInJjjuo8geavOs2WkAeLV?=
 =?us-ascii?Q?z0hYKdIjQtgtywpPqbfF3hiN7iJB/1s922dQKgDQSUc9lxlkdchkTVosilFb?=
 =?us-ascii?Q?5JYdXbwFXfhpChF3GCTZ86xi5YQkzTmRi5h1+J3frvu+2TxP9uwX0fyYASp1?=
 =?us-ascii?Q?gzDQsvWcimffjWv3sfTlhupsIGb22PZeDsjrZex8rPgN6uOm2cdYf99DOOW3?=
 =?us-ascii?Q?QaWW4LEjsASUdXkHWZ31YbfW+S7JHWZxf3HFgZb4TEQjZdsC44lFxRJSHBsW?=
 =?us-ascii?Q?mI73LHqPjWlg+ve5k9u2Bzj2MoAvsP6xUaySHWoxNbmADfVX6wTcbGecm9u5?=
 =?us-ascii?Q?jADnyxPvFbBkXVZlepf6cNOfXAoZGF54+seGyUei2prHGNqJz6S4n8EH15MT?=
 =?us-ascii?Q?Cvo6B012WW7Kglf3jCCKCC5M/I8un7KP7IRQL11sBcqvTVCT7E2Fw9amjgbF?=
 =?us-ascii?Q?i7R3AUKY7H/+7WC7G0c7Vwe/2ZSzDMLq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DcloD9Qum0CzDbQn1B5UpRMJ21nJQzxpSFB9KfNJIVq/KZfpoOevfIgvnsIA?=
 =?us-ascii?Q?EupE0tQ8j1WeKKktZn/lQ7Xal2I6gMSL/YVdVOQqritd/y3aVcRHMHBE/F74?=
 =?us-ascii?Q?/qPJlmKg0MvJHOrO0VbYggfLO2Z6P1yDH4XX6NSK9j4SpsBk67qfTfES3mEW?=
 =?us-ascii?Q?rN1ZwvrPY+l6H0D+kIPzm8JfY9J0wA6IgiavS+w4WIcd9Y9gMX7zjQN9eWFj?=
 =?us-ascii?Q?pLbKPVR0xpKQGGz8NdA3bMj8tfcF1rMAArCXWchAStqgwDei4xyN8lSbM0dF?=
 =?us-ascii?Q?lufc95uy1vuYKMeqZ/mIBbKwqOq6UjWjxkS0KS6k+OoR97RtKZM5sA6d9eRD?=
 =?us-ascii?Q?wZ+DNzl1gcuWPkvK3vy22RpozM1qxU4yjGMmN2xS6wveDZXeUxpmbObawpu3?=
 =?us-ascii?Q?FF4zS/tks07gi/L4QoASXg3PHCSRk9N+oyjnfqubG4iulukh2p6484q5xj6Q?=
 =?us-ascii?Q?6kkFOD6IcWlekrfX10kFqVB3sBGEPlxZ1MlT3f3s6JNrLj/4vGe7Qmme6pzc?=
 =?us-ascii?Q?YunGeFHhvBVdUz52Zt8Qv4U+afkL+3n88aj/cHPq9D72KaL3zNm3ouwUA0si?=
 =?us-ascii?Q?0nvm46y9OjWORxv4+t0m/fKHyt1gt/SSSuSSyCFqfq4AbtZVcZtNmbuTDnvm?=
 =?us-ascii?Q?8QQCVK+7wsXEAv9mO39/uUgNtrLzGFwAUuYFHlBRWAxA0qAJb1tJsk/bJ2KZ?=
 =?us-ascii?Q?/7ww23bSRA19QBujgocNigVPXa+WINZV4vXrh2pXB7xdHd9jHkK9QQrJc7Ek?=
 =?us-ascii?Q?qvMyZJ3KxVc8cyuzao3Rc+Leqtp1PxoCbW8k9qDI7Y2OW2FYa4ZaImiS3fp3?=
 =?us-ascii?Q?MN4pCTKAteUG0nymlzzG189/2vyRR5rFiVDBUQEqy/317XEVgWDIjYK4+DIk?=
 =?us-ascii?Q?a9Vkpfk0NWmoB1WeQNuLR9UKI2Y7d8TcGOy9RJNflub21eqMdSvKWCkk0O9b?=
 =?us-ascii?Q?u857Ay86uxfjlEEToDDcB6PW3Q+jTj18KJ20hvOKV60PLziKs2EIdPktKU8/?=
 =?us-ascii?Q?VKgdphmrgkqaq5LvFk7F2RJi9QzKBhWi6KJHGFM36BDdQ/FyIvt53Ma45JKh?=
 =?us-ascii?Q?m9HsbqzcREspKdr88aIG9psh0d4sJH6q5UplD4BRELT3hMnT6KfVu3hDVhKC?=
 =?us-ascii?Q?HalyyIHGogjjBIuxc43b2za7DTvlZel1nZHa+7V1if6puCRmNtToQuLK9ZDh?=
 =?us-ascii?Q?sIp8a6iPu6KWnI/HD7enndVBSivNvyQVAn6jc8/rGv+Y0zffmPiFg8gYoWE2?=
 =?us-ascii?Q?16G3ZlObkgrf4mEbvKz96FEkpyhGITlDDl9NT7Q8nLI33RfhSPs81oIpkeYb?=
 =?us-ascii?Q?anf8aGoISpvhI8glr2DnPwvmaErt4Y5m//knhf+2alG8LIsSfpiJrAmXpS5n?=
 =?us-ascii?Q?93KuaY2MDwBsTkcmAHP7XB3r/Sg9U27PlgHK3idrkgmsmQTSOXY/wNx7fBgg?=
 =?us-ascii?Q?7Ga7iGIthLnir54rpMJRDhSSaVkwUDKdc455LUGYtyi/7i+ZRhRxE4RcNxQP?=
 =?us-ascii?Q?PsUoNbwa0e+JC7FyU4tVMKDqwCuHUF2JGJ6TF/5SSw8o3GXVc3HY+aOnjJtT?=
 =?us-ascii?Q?Bz20RPM/baVrFeJfqPj0gMCuXCJ6xDygUhgYElJL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652c675e-3d58-44bd-8532-08dd50b6b159
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:26:14.6098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATZCdKbV+JU7DtoVrRMx6IBg58QuyFij/RKiM/Km/Za+7M3YEEWvroDiDbi3t1CNPwvOTWVNJnalPMBTLFGEyjnU9qLDxnlo0YGt0ItBzIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 24/26] arm: socfpga: soc64: Add support for board_boot_o=
rder()

From: Tien Fong Chee <tien.fong.chee@intel.com>

Add board_boot_order() to retrieve the list of boot devices from spl-boot-o=
rder property in device tree. This board_boot_order() would be used for all=
 Intel SOC64 devices.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/spl_soc64.c | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_=
soc64.c
index df89125cb29..651d9fc9cb8 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -16,6 +16,109 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_MMC1;
 }
=20
+/* This function is to map specified node onto SPL boot devices */=20
+static int spl_node_to_boot_device(int node) {
+	const void *blob =3D gd->fdt_blob;
+	struct udevice *parent;
+	const char *prop;
+
+	if (!uclass_get_device_by_of_offset(UCLASS_MMC, node, &parent))
+		return BOOT_DEVICE_MMC1;
+	else if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent)=
)
+		return BOOT_DEVICE_SPI;
+	else if (!uclass_get_device_by_of_offset(UCLASS_MTD, node, &parent))
+		return BOOT_DEVICE_NAND;
+
+	prop =3D fdt_getprop(blob, node, "device_type", NULL);
+	if (prop) {
+		if (!strcmp(prop, "memory"))
+			return BOOT_DEVICE_RAM;
+
+		printf("%s: unknown device_type %s\n", __func__, prop);
+	}
+
+	return -ENODEV;
+}
+
+static void default_spl_boot_list(u32 *spl_boot_list, int length) {
+	spl_boot_list[0] =3D spl_boot_device();
+
+	if (length > 1)
+		spl_boot_list[1] =3D BOOT_DEVICE_SPI;
+
+	if (length > 2)
+		spl_boot_list[2] =3D BOOT_DEVICE_NAND;
+}
+
+void board_boot_order(u32 *spl_boot_list) {
+	int idx =3D 0;
+	const void *blob =3D gd->fdt_blob;
+	int chosen_node =3D fdt_path_offset(blob, "/chosen");
+	const char *conf;
+	int elem;
+	int boot_device;
+	int node;
+	int length;
+
+	/* expect valid initialized spl_boot_list */
+	if (!spl_boot_list)
+		return;
+
+	length =3D 1;
+	while (spl_boot_list[length] =3D=3D spl_boot_list[length - 1])
+		length++;
+
+	debug("%s: chosen_node is %d\n", __func__, chosen_node);
+	if (chosen_node < 0) {
+		printf("%s: /chosen not found, using default\n", __func__);
+		default_spl_boot_list(spl_boot_list, length);
+		return;
+	}
+
+	for (elem =3D 0;
+	    (conf =3D fdt_stringlist_get(blob, chosen_node,
+			"u-boot,spl-boot-order", elem, NULL));
+	    elem++) {
+		if (idx >=3D length) {
+			printf("%s: limit %d to spl_boot_list exceeded\n", __func__,
+			       length);
+			break;
+		}
+
+		/* Resolve conf item as a path in device tree */
+		node =3D fdt_path_offset(blob, conf);
+		if (node < 0) {
+			debug("%s: could not find %s in FDT\n", __func__, conf);
+			continue;
+		}
+
+		/* Try to map spl node back onto SPL boot devices */
+		boot_device =3D spl_node_to_boot_device(node);
+		if (boot_device < 0) {
+			debug("%s: could not map node @%x to a boot-device\n",
+			      __func__, node);
+			continue;
+		}
+
+		spl_boot_list[idx] =3D boot_device;
+		debug("%s: spl_boot_list[%d] =3D %u\n", __func__, idx,
+		      spl_boot_list[idx]);
+		idx++;
+	}
+
+	if (idx =3D=3D 0) {
+		if (!conf && !elem) {
+			printf("%s: spl-boot-order invalid, using default\n", __func__);
+			default_spl_boot_list(spl_boot_list, length);
+		} else {
+			printf("%s: no valid element spl-boot-order list\n", __func__);
+		}
+	}
+}
+
 #if IS_ENABLED(CONFIG_SPL_MMC)
 u32 spl_boot_mode(const u32 boot_device)  {
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
