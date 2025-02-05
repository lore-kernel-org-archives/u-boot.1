Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D3BC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C78A80EB7;
	Wed,  5 Feb 2025 14:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="TuzV9YLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B452D8078B; Wed,  5 Feb 2025 11:16:00 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46301805E7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHcrNfRyZ2u6TqcBhyKV8IfOC2SRtcQT3LrsKGdyICenIPbrksT/X5VKAelw5HS4rhw/VUhkJfiIXSHCZZZ0AdzAafMqRtZlT+uBJLzjESl/1ZaOYh+EhVV6OHp+/S770Ha1hXVCND3rNJ9CCeTIod2Jxn2r6J4x8eK4eWR8xxsI1OTRF5dr9CsgAyVzjRxRRJn4bQZYZ4+aswxS6J4gg7pqqmG6KZkhF0jN47CrFm5blSdjeTAYFFG8pF70xkR0izfFza5l2RNLDoVcEX9hM5Zn359gIxOMYzJMt3Su/O3KqaJGDNjlbRKhqQV0H0MDpXBx53xiVPIKbifN++ny5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8S+bW32pcJFx31RDUdzKrOpMavTv+qbTI55lZ5xZi8=;
 b=pJfpTr/IpRuybxs/9qLWhCxjI3LJIgFd/ebO+2Vo+7w0970H1HnIw9ZwTIRSHGRwtIKL88ft368zYr5NnSvis7Rfr//HoY4EUR5f9ybpAem37HCCdnjCnlSeb0N7zEItuvx8ZyCNJvdf1+DLDqMMJPB0eqtputwcfah7bvaB9oAFBJPKBjPxZsWBBUHgbP5Rn+3cS4/zr5XZRjsv8XUWYgjNJFn8vzouvS7KqPK80ILudrQZgHi+bjLtwTSBeVZM52kGhOoEH4C1Ed0zToAFV6HpKI3k1kxoCpVYIPM1NAW0em5u/X6p2vAo4C5LS/TiKgFkHUhk6dMKqrxa9zIeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8S+bW32pcJFx31RDUdzKrOpMavTv+qbTI55lZ5xZi8=;
 b=TuzV9YLrVSg+3vLeHW7S80dcT/0Lz5ilfgm7WSalFtjyAr7zeaMnj6cdEO9ut1OUUWoc3UPcKXi5MZXt1cYVBhcOblfPgus/RO8zgpGDnPCk0zFe/39HXliBHjYelnQ5g7M4ilfX5lnScu+GMUs1pcBmvxOWpseoEbbGZ/jysDxMA0Dr+TLlzdmmbEWrXIBDiB4Id6l/yL3iLSfB7OuPxKhn/gm3EyhV1kaYkGNc5/b80VSX0yzZ2sqvOFEoyuw7oLL8glpvS2eInnXKfJRfBn1Fa4EBdhcesRwtuLmCVWkUAl0rFMWXl7OjuaEBUgbHTmr+W1I0bOKXnDarnU2h0A==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:51 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:51 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Matthias Brugger
 <mbrugger@suse.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Peter
 Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 16/20] board: raspberrypi: rpi: request RP1 in late_init
Thread-Topic: [RFC PATCH v1 16/20] board: raspberrypi: rpi: request RP1 in
 late_init
Thread-Index: AQHbd7bsIxBH89OrSkKu76y12VB4dw==
Date: Wed, 5 Feb 2025 10:15:47 +0000
Message-ID: <040415712c5d1ed8130c6cba3cb2c25c1b46d587.1738749764.git.oleksii_moisieiev@epam.com>
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
x-ms-office365-filtering-correlation-id: 46eebe71-55e7-46aa-f129-08dd45ce1195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?V1EsjWu/Jm3357F3d75Y+CaOOpQ88/sWm0oCtHsAN3DbMZu1g2fbms6mSS?=
 =?iso-8859-1?Q?HipHCjkFXdKbNYHCdiSSL+ymZLaVg3aI6USHQzoaheJxXBRyHIpqqEeVC2?=
 =?iso-8859-1?Q?CsWhz5s5KWEeN310dtoUylm0yD40wQoRN9xBeQb1145oUIHP8qwf0QkLON?=
 =?iso-8859-1?Q?4UFBtxaNysOgA+eOQ0hhyuIJ7KJJM0z7q7iG6h2tdWv24dJF/f/5TtNG4s?=
 =?iso-8859-1?Q?3KyqftUSNSpwJ6leAnuar8ZwrxFpAfpXrjbr9h0jXnW/3oQCkcSDSdyZI1?=
 =?iso-8859-1?Q?QOeyDMK0OyVQ3wra9xsGhc/2rjNjNqYDAjxMZam1EISxrIs2pz4ibuKwJ7?=
 =?iso-8859-1?Q?+s/qypbocFx91jN6tSAAhS+yrm2Ys+X8P/FXRgo23JTUZ9fK7hzeYlDlkT?=
 =?iso-8859-1?Q?xxo7LPIcf3YaAKK1upeCOu5Nj+2AqFAWSyytbsvnXPZfwf2zJK9M1ztCaA?=
 =?iso-8859-1?Q?7ypACxhK3Mk3NKW3Dgcr9BTdsyuNQ92+rx5ESDMMCrUWNWg5RLTVMbw3en?=
 =?iso-8859-1?Q?9CfDGctCUJ6vjk3V0Fk5sL2+TpLnynD1qjofW/jms9jR8T8t0/Bqi2kgLk?=
 =?iso-8859-1?Q?4iJANHYVc4bXlgPXNNOAsmZszQnthrf59Ey1N1HhMgSKUNteRmOW376JXE?=
 =?iso-8859-1?Q?EpNmGtbQrW8+EKDdsJq2cc0B0D5qVO1UKvyq5U4dmtfo0i6xryzyzdczep?=
 =?iso-8859-1?Q?xVsHdr5X8vLiudivVTPAuG50mDQS+CRPGoKZIINBBP0G+X3CJ7huDBv5jL?=
 =?iso-8859-1?Q?hcxLTYmsh6OCCPQjJyxYBr2vkbn/Q3bXoeMW0I1PXlAl6q9Wf9gWO3Uzet?=
 =?iso-8859-1?Q?HJJ50SgHRHyYKl+vdZPxF2/WZBPSb7JHz9wx7dgO1qZVOxZj7kETkrRJry?=
 =?iso-8859-1?Q?TISSY5+DqBFsHzicBBEr7Iky6OmJcqC8j93I9T3txesjibfCbwLyYYmH8G?=
 =?iso-8859-1?Q?57IfW18Dh9X9mNZoR0hN8qG1Hr5bGyGFSSzSwbPtTwknRW8nNZ2sXnDgjf?=
 =?iso-8859-1?Q?uKhngrtO98Fp/OBGR8cdQvNE4DQHX0VIsTdyOLmbR3I9DY/q/gXS/c6mEU?=
 =?iso-8859-1?Q?yJFwWW7CXyMlYLDwhoXM2sSi+1gHA+xFSMcL3yVuawC6QC7LlCBQzupnxS?=
 =?iso-8859-1?Q?XvhIuVaLweBL1E7j30ywPH32pJPOeDoIRPw2mOpm0x/PKPed7KyeuWnhly?=
 =?iso-8859-1?Q?PL3JGlXUWvAXWZQdy2kwxCn+rGDxM1CXOMjJ82CuTC530egsVQWcyEtu10?=
 =?iso-8859-1?Q?cDZaN4UpqtdwkC/Ae/ZvGPfs09FLQDatEX2wmagPu7N1r9AGk27n6hdZTG?=
 =?iso-8859-1?Q?117gO3XC1AoLaDhVR0nt+32sYiAL/EsQ5LIQm1/a4W+g7SeAJP+KemkoXQ?=
 =?iso-8859-1?Q?EHsqMDEjzlVBEbUDj4SuktdVrvqsaXeYItrj9AiqoMejdZXTvbll4I2aY2?=
 =?iso-8859-1?Q?GJR/b4Lx+OqyVBbvCPc3G7GAlipah7QsRtWEHOhMop5QyNjCU5kFy6BrQC?=
 =?iso-8859-1?Q?+s5Tavm12uLbrtqEKx3oDP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9Tnn9W8MLuGA5ykY387lGyOpoKe18YdacRgz/205qtuIWGpn9E1wVxOBAe?=
 =?iso-8859-1?Q?I4lokMagIErRvVSTd9TBAnkb32iwB97Y+e80T5ZDp/Wn2KrJoLPa/7KjD6?=
 =?iso-8859-1?Q?unXBpupoSI2FsGdX26HGO0O8mGuAQR1/fWX4YuE1G7yuurVQSKpdGp5DkZ?=
 =?iso-8859-1?Q?/taHGqII4DXoJinE/Inmv2oO7lXKXnPRtG5fbL39TCQHW4C1p9GTaxFBDQ?=
 =?iso-8859-1?Q?WEcqC7lJGhnfQ8BqoGWiywPBIbHOJpa10I0xNGZbxSpCFNXj3yMOiS4CmN?=
 =?iso-8859-1?Q?X+Yjcwd4FYeS+0YL2Ifvad9ORAEOueZ3EL81p9Xi8WKqxr8AmyOq8urbhc?=
 =?iso-8859-1?Q?pfZ7XrrmaHp194XBNDghfc9XySTMy1OBhsfYnXwmtibGBqKJ70U+5BA9si?=
 =?iso-8859-1?Q?w0UnypTtRbtI5GvVbNaBneAbVu4h40CXy15TzeMuux278+2viDZ2/KVCs9?=
 =?iso-8859-1?Q?tu8R6y0r7o0KFyCHM8igxEufEw2sDBgVZq5HHQgqr/Vi2Z781xicz6rqcQ?=
 =?iso-8859-1?Q?JbJnJgnSKDPTAMiLVYW65Z1gEHvDklBkzYe72nDG3bko/LTPlqazZrLDrv?=
 =?iso-8859-1?Q?MbaC/TaMulE2CYwIYztHPtwUgKdEmJjCZjB/G6Z3o/y9xGh04lCtxG30sc?=
 =?iso-8859-1?Q?x0VTECBno/Q1BbCOHm7kAEjtKVbxdKddgeb+4stSUCJsMBojlikvO+dBnk?=
 =?iso-8859-1?Q?PE2k1AY35UYox3VAlELSBfq7WWA5GkiKharu30ERmFnuaS2j4UUk2LxAY5?=
 =?iso-8859-1?Q?T/42b4mCFETd/+NXXatjl0//2xuj8ITqE0Fb+Ct804OpSoiqYPkRzxEC+a?=
 =?iso-8859-1?Q?VfbrxwPDWywyVf1sg97U7pM4Lry8ZSpY2h9pwMXrBYO80HdN8bPDwE6P7i?=
 =?iso-8859-1?Q?vXatGSyBPTN9ku7e8pjF0o+f4NY2toPj188MIGT2qkOYyEUeUxJoq+/9Em?=
 =?iso-8859-1?Q?DAj6cQgLMJu3QKj5G4bwsc9uCETUIXTk0qhdg52UzFCkTjrxIJDPcf3I+U?=
 =?iso-8859-1?Q?K9UXteZNwI2ty8fWDJarbF6ERTs76KEv5TtTPwapug7q1IgTIRKW3Rn/W+?=
 =?iso-8859-1?Q?ih/Lnp9JJvTu5jwQJMlpMXwaJOlXPUzYnzJQ8n0ofamgcASDDF5F5ezS8c?=
 =?iso-8859-1?Q?jwMb7c3jPMCoghEnHIIviOXHp23FeUa/01JtVk4EKetTLXp7hjdop2eAah?=
 =?iso-8859-1?Q?xktkFbx6UrTsZR2lf7IiVVIRPVeZNPQ1tTHdqwQOSk94EkOL/bsQMGSd7Z?=
 =?iso-8859-1?Q?Kz116T2s1L+L+E1JQjmjl5+7Yphv9+GLPPOYMVE8nmj10Tuh9s4NgkSK5a?=
 =?iso-8859-1?Q?Rs8pUSMgvZTOJPtqH8tR1jR89L7Ac7GkfKIqjyKEhVMHEnekg6bs/Ju/TW?=
 =?iso-8859-1?Q?XmyYPAAf5C2PXt43xuUaxfnBzcQqKxAXT0k+uoB1Gcy+Q5mFYXOAOfSnQF?=
 =?iso-8859-1?Q?9Z0R4qA9QoYjtJPZMokm2DLxh54ZHc4EgngfEUalqOHDiWFE2w0cNLTLyU?=
 =?iso-8859-1?Q?dnumAsRdg5k1OrIvLV/jOCOggPRQV5QJNziQ1dDEWUHFWn6rDEj0fXC4oI?=
 =?iso-8859-1?Q?/83KpvhbSSjECJJQsZlrNsx2KgX/WLpKouAR6AH6mMmaCjTAubQnlkM1Om?=
 =?iso-8859-1?Q?6PUXgwzX+rF8elhl4ddC3w7RZcUOQ6bUjbh2Z83ZVcqtr3nvjcEH6h0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eebe71-55e7-46aa-f129-08dd45ce1195
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:47.4320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ORiPwRvoPJSgaftdc4bm/yNKciI6YQuiAhuHfQVSigwJ20ur7aAdxsDbzWgbO54RqTW/8tnd2uigt1FRMbWg+RSgUdkBjE3pkGiF/ALNPQ=
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

From: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

RP1 chip is the PCIe device which should provide transparent access to
the peripheral connected to it for the main Soc.
Current RP1 device tree node structure and RP1 driver implementation
don't allow PCIe subsystem to make a proper initialization of RP1
device with child nodes. So RP1 probe should be called after all
initializations were done.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 board/raspberrypi/rpi/rpi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 32d67eb7f4..c45b1e277d 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -593,3 +593,26 @@ int ft_board_setup(void *blob, struct bd_info *bd)
=20
 	return 0;
 }
+
+/* TODO: Using late_init to initialize pci device with ID_RP1.
+ * RP1 pci device should be initialized by the PCI subsystem because
+ * it is under develop right now and depends from the final device-tree
+ * format from the Linux Kernel. Current device-tree format violates
+ * pci driver model. So this should be changed after upstreaming RP1
+ * to the Linux Kernel source code.
+ * This initialization should be done only for RPI5 board.
+ */
+#ifdef CONFIG_BCM2712
+int board_late_init(void)
+{
+	struct udevice *dev;
+	int err;
+
+	err =3D dm_pci_find_device(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0,
+				 0, &dev);
+	if (err)
+		printf("RPI: RP1 device not found\n");
+
+	return 0;
+}
+#endif
--=20
2.34.1
