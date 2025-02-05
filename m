Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDE1C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA4680EFB;
	Wed,  5 Feb 2025 14:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="dkl1DIPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA04980207; Wed,  5 Feb 2025 11:16:01 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EE180762
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtlxa+PFmqjx/cF9JFfJu/Kjylgh5TMeBv5iU2QnPbwCFdAAGgrHvuzsrC8YSfOhy3X+nuq6YJA8KwoDS4QgRk77HknNZMg0a+peW8tgmE5WigUWHwms9gySw8l3f4lOjhw4M62Xoqv+stByG2TRL/z//SqiUaQSojfPsKB5VVmPOksnbdJqO8Xpb8TVy86XeyGfS4VTjOY4Xt7JH+/zc6WunWema6ej4SJPeienzzu5jOkkcWBwjzIAHA+7erkWV3j2gOf8Wl01ijnSEw9cdleOZKfkekOIPoL9tbo2D/0KSWR4lC5iOLWuiZPk1hmAuU13irqgLT5FXr4By/frRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSElq+PL1nRdZyrbvVqqaQou3N3sLZXtfGeYXZdeeYQ=;
 b=KlG0A6S5dfSPyR2vSTlLVPDd0YiHODsRayHBjDVYkG5IndsqTkZzJYvLp5yqUI5DF6wUV0JRhQr3Ue2h/urz9Wp42Uh1zLv2Qkb/PY1fjyXGsVoy1hdC1fxINf3/D3unzW1nM+NNAM1qIztWAMkvr6M8WIpfI+biI22pmHIF49aBfCiJEoH7utbhPFlwBO/Y8/ZnxCYb54cenOMQxNmItbh7LdlQwm9elQHjbRGrkazKH19qIYa89E+zCh1kK/gxXzFmS3dKlxO7eGHTaYvYcS5UmG+NoB6UVAvCzXG0UgyZUybuKwdSiYkykmSIr32szCEMMNy3sm5N6kScFrXi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSElq+PL1nRdZyrbvVqqaQou3N3sLZXtfGeYXZdeeYQ=;
 b=dkl1DIPiwxxH1df9f08/FY0UYp3yoIFHKIt2/mV33Axehl3r1+QxIJELdiJ72zBTc50iTxWo1eosb6B4weUWD/AIP3nTBoufMg9T8nSHgKbz7QJp7z3h44pXO9CBDRJZzqNmUTNSOGvAPe6rPVFzddsQxuRYPbi6gQsfcsXHeL7cYN/44KT2Ui0yIX1xfvGPZJq3TDNRgBH00vbcLPJfxvJAGrcIm0JR/Rc8BALH23kfU7yulgae/AOwkIqUchrAvjmfGojDV1h5uRqRwCi6IY5B42AL7I+TqQS/zdu6uE8DTBsuF4JUD0Y/e3+8U3DG9MraIUomWZ3rMVlCylheFw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by PAVPR03MB9336.eurprd03.prod.outlook.com (2603:10a6:102:30b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:15:54 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:54 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Oleksii Moisieiev
 <Oleksii_Moisieiev@epam.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 20/20] bcm2712: enable linux kernel image header
Thread-Topic: [RFC PATCH v1 20/20] bcm2712: enable linux kernel image header
Thread-Index: AQHbd7btQUke+GD7XEqvTxcwYzoQPw==
Date: Wed, 5 Feb 2025 10:15:48 +0000
Message-ID: <fb1005ae274eee0f539564a4a3c1f6fc9350f40c.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|PAVPR03MB9336:EE_
x-ms-office365-filtering-correlation-id: 29481125-da80-44b0-2b9d-08dd45ce132b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?oZymarK7cu68ukanEnVnOO4+qgDqsBdkSumbVu1w39p73h5g91iWnxi+Kx?=
 =?iso-8859-1?Q?P7Vcum0vSaRv8WtK5uZRmj85vujyotMMwKRLvCWgjVV9Dl294BAOpHc242?=
 =?iso-8859-1?Q?inLgpwfcRMyjY+lV0YY6z/KbG7DIyKTHlNKS2BfW/p3Lw80nzHkIJohCU9?=
 =?iso-8859-1?Q?pXPnxbsjJl7Vo6brBW9CGmxqqPPLRuhHmxyrG+coVtXX4dmCjzey+8MZMS?=
 =?iso-8859-1?Q?Dzu4ZA4a8ZbITlpGBUmrP7OjuIg82gtN4Kh7oepKlFzTcBI9/lE79BaWnk?=
 =?iso-8859-1?Q?ditI1DvzJNgq/5ugmeZcHvaaVZGCyfu4onX0d7Y7LpOwGLjPwzniukYB2o?=
 =?iso-8859-1?Q?mMUBc3SUncWY+/08NAt//zvFUSr/1IJf87X4CcDnE7b+1yXE7+HEYVM5X6?=
 =?iso-8859-1?Q?qnr4w1i25DASioncy9s2qwwSeLCSZ9BcRIg5fB3cl4L4v4JDUhSQSKDe5M?=
 =?iso-8859-1?Q?kWO1mmjlQQCSe5IvuaJJ7hZryiujCIJ2VjLiX/PdMUeYfru3vsOuHF0TuC?=
 =?iso-8859-1?Q?AuJv5o3a8CpiPzHbVvF/ZitIdVyNdPIGMB2enBRDOaVMbEq7muv96k7JSf?=
 =?iso-8859-1?Q?2le2+x9aLjcWeAaoQxJthViU5hJB6rqV2oPFDbcvNWFwUtbtyapPvKABf6?=
 =?iso-8859-1?Q?8vQzcIhURxqTgLgq2d5Aq8Afe13ZD8kqg2LdeKE+LSYA6qFU1bwMXDUwH/?=
 =?iso-8859-1?Q?0X+DoLKh62ZleT818EykKLGDq/VQ4XGfraRhws7HjDoP/QnPORRrWoNscG?=
 =?iso-8859-1?Q?vQn4VWUTEZPdf7uaF04ZzAPunDK3tDzyTAfNTpTbJ7CH88eydkp0/E7ivl?=
 =?iso-8859-1?Q?SDxnup6/iFj5Ze5YB2qZjbw3EHc+RlubqQWteRN+YHk3Ngvt5YAeXV9/RZ?=
 =?iso-8859-1?Q?jUFhYqxmWMrhU/n12K715FI5CHsg44ypZOSxMLMhPNb+PU1Q3F44Y6ypXz?=
 =?iso-8859-1?Q?dQj6vsw3AkQdWQ2Lnzi4jzB/cW/NUX9h1CIENXC7nvvtsKfpWL46froRiU?=
 =?iso-8859-1?Q?bMSy+32wyFpYvvlL4cNfy/CmBia8Hhg5tJbP6J+WaTkFOeNyAZscu0aZIg?=
 =?iso-8859-1?Q?zmaMuXppiVFcuy1mU2KsjvJqOcomuogOJhSeSvaMLWOTBnoKWCrwrFruWD?=
 =?iso-8859-1?Q?93M4TRcFEbREl8/3R8xtn/1Zl+1NYfI3cqJE8cI3lJsHclq7ttxF2eLJHj?=
 =?iso-8859-1?Q?c2B/55Pze4Xqwl5vwxd9Ny6ZmH+9yIRvz7PfTr9A45PY1oyx3CcmIY/Vdp?=
 =?iso-8859-1?Q?JE6vch1JTgEYLTB9yD/iYJSuGN+0dqXXbrEBTKis6BW8UQ+T2G3xmc8uud?=
 =?iso-8859-1?Q?N96aEQNsI10LB3yzNbjabwDc4JNsptNzydePGSaLsNxscLX0OIItlsN8NQ?=
 =?iso-8859-1?Q?OUfuqj+TXFEVlppY7aFmGDSkQZ296NGDbDvOeHfI8cxENlYLsn2X0r0Sfq?=
 =?iso-8859-1?Q?oZWbuglZTwd9L3Yj+tPKRX7lCTFDu/zYoZiqmx/dxVI73ZKbN9i8/HG7gB?=
 =?iso-8859-1?Q?oH039n5l+lSqvS7a4YvYEX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?395U8kffpxtLvoZkpOMLewjrriSrP4Y4vcjUhKDRpVih21Z4BpBN3A5x0y?=
 =?iso-8859-1?Q?D+bNp4EXw+I3U29MJVe4XD9Z6gN8FQH3I0619mqPA/wqUnnFT04n2cZaJa?=
 =?iso-8859-1?Q?75sq9xZeTMTcl1urRH1CGh1PnU4SHYDnKnYxdSD6iYucs99IFfrCFQqUMv?=
 =?iso-8859-1?Q?cF5NUp6l1xyhEfiipA7wfnm8qTMCKKUJGlA2WJ2PZQ+ulkQdyv1TiMu9sv?=
 =?iso-8859-1?Q?VhmPvX7oyxPwiPEJCR7geXhIfEVfDcmXpc9a3Fopm2O38NOIqWhoCgv/+9?=
 =?iso-8859-1?Q?ZiDGhGo/iDeuzJCOiPUkvLU/kt2e5/IaDX9wNARTTSkIBUSfc3GQKNl9LE?=
 =?iso-8859-1?Q?IVFmAJE0qB7nKvxYct0zEe3HoawIx0EQpN3DzyhvVIxJ9hlmRLEj1KKGCa?=
 =?iso-8859-1?Q?U79RfgUaa0Aoi+qwND5pA9YQ6+Rr01rGjHCpz7fh6wgo0PJP8jSWI6QvjD?=
 =?iso-8859-1?Q?bqSX/gYEHOt5yxeGGYmVrjWANOkpf3KgX629v2iNybuMrTZh4sJUQQ0jxm?=
 =?iso-8859-1?Q?9p++nN8ppyvKxCKJFNLssfTWrwLbrKDoixjbjX8qDd8A6uShgjzoqCDA6Z?=
 =?iso-8859-1?Q?HZkwHgXUlovX9a/AhUhSswsavJOAiKLGoDQ7aiPcNssyiGqfjQiIU3bn/E?=
 =?iso-8859-1?Q?ZtvA0x/+YQwG8/oSWNBBZfdObGw1cL4Y9+2kiHKAXiaTwLX9U5sWfLmBXe?=
 =?iso-8859-1?Q?PQwdoQ00X7AnxBgYlk6fMlcCtdCdS4HHTyZCVC3undivThSfD+EnwglXiv?=
 =?iso-8859-1?Q?O4kySQS8dxX4KmHEhovOLkOz1KYvuSZgDJKKk173o5Wzzc2/O1zfG+c8eP?=
 =?iso-8859-1?Q?PaJLt6g+pO8mFsJqjUWsQwmkvPJpyKgHtBaMcrOx0P+kdN1XpF/iCmOeeN?=
 =?iso-8859-1?Q?yvzYaqbUJ0IIyEIznEC+hKOUVL5VmnX41IYe3RXV7/0XIkLQ7rMzMA0g3d?=
 =?iso-8859-1?Q?FxKLaQxnHfi8OVezvdpKIRqxfwyn+3eU8yUNX/NUFM1bgidvnccYwLUjut?=
 =?iso-8859-1?Q?BcZQfX2r6J+eWWorQZt42dPBdsnvOOEvtY/cBenVkqMYVFXlED1a8XOwDp?=
 =?iso-8859-1?Q?oZCDSCizOAr65KZ7hj+kEd2y9vkhVU5WwBmYN3GAL0VcIlaBNe49/urWUM?=
 =?iso-8859-1?Q?kOisnAK5vicRGvOTgXahBTVLSAzDWN0QGM9350R847VWDucqcfrkiU6Idb?=
 =?iso-8859-1?Q?Xc411fodZV5FBEu8r610pQkZzB4fNiXW/q/yPqg9+VFRc6s4M+THH45GGq?=
 =?iso-8859-1?Q?Mzk/AzCGbPAMn1xd0WmjeKzyAYqUAetuVNN1IVpLsXBzV7EYEIgwz6cS0H?=
 =?iso-8859-1?Q?E8oGopg7q//7kjPENQw9sEvPmZ9YyvbTg/iFNfnaODdZruJUVudKGxbDzZ?=
 =?iso-8859-1?Q?Kh+KVgJNvxPqBqQxBuGi7QMFUJ54UcENftL6RuxuGfiZ3U1apEG9g6fLt/?=
 =?iso-8859-1?Q?GTiI9j9YLvvY4GDigcCjL32JDVUP4DVOHLJgAbPB9Gwovi2EytK1CfWE7U?=
 =?iso-8859-1?Q?O+xD+L/RrMLjOyp1pSTxev+lUFVT5yWhLBSu3RdtM8CX1YLe8SsenG8QpL?=
 =?iso-8859-1?Q?nJ92JlHCJyh1UiIq3fUJs2jwEDs6m+8o2rWwEcZ24TsKscSlrZWxEdUdrD?=
 =?iso-8859-1?Q?lKD71yitvdI1tnllGMwnIATKhhTCRTLMqE2OR6Rx6yX5n0MUQ3wFM5rg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29481125-da80-44b0-2b9d-08dd45ce132b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:48.7317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9MSn4Nazese649Fd8R8b9xBjgM+z+HCoQVekgHTWKF65Q7KzRP1jxAQRtvfEGdmRu/pCdFVFqAM4IQUzxZ8bLV1ZN/9uYi5E3K8U31iDow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9336
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

This change is needed to make OP-TEE operable on RPI5.

This is somewhat convoluted, but in the essence, OP-TEE image is being
loaded at address 0x80000 and we can't change that. Problem is that
last versions (like 2024/06/05) of RPI5 firmware tries to load
non-kernel images to the same address 0x80000, thus, overwriting
OP-TEE image.

This patch enables Linux kernel image for U-Boot, so firmware will
treat U-Boot as a kernel image, placing it at different address,
namely at 0x200000.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Tested-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

---

 arch/arm/mach-bcm283x/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index c7509146be..9cc8f66de1 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -46,8 +46,12 @@ config BCM2711_64B
=20
 config BCM2712
 	bool "Broadcom BCM2712 SoC support"
+	select LINUX_KERNEL_IMAGE_HEADER
 	depends on ARCH_BCM283X
=20
+config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	default TEXT_BASE
+
 menu "Broadcom BCM283X family"
 	depends on ARCH_BCM283X
=20
--=20
2.34.1
