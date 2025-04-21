Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F725C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 06:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F7981F6B;
	Mon, 21 Apr 2025 08:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="t0ktywSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F3182006; Mon, 21 Apr 2025 08:34:49 +0200 (CEST)
Received: from SJ2PR03CU002.outbound.protection.outlook.com
 (mail-westusazlp170130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E480D8129F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 08:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEFGLd/EgajeoCY/Gp7/TXei2GQ29ipztlF7eAht5/QInLu/9OyplXQQMiqSML9X1Q1LAd/qjEDE9IX6gAHi0Ia/KetyWtsoF0pYDT8+fEvwma5xxLKfI1WvjFahx7wwp3xYYlfyilxz9jdzFsr/ZxIYfjpzTRIX1AqC5EsA0dPSJkbJnZGXxR+Gc3CqM/dx1nUAmKTULHnn4QRX+l2dD3Dw5szeA+Ovh1FaK5MybzppOH+DOdQc/WJsePnaMfoSydLIacONAWmjaMiGVEZu7zrNm0OKroVBePJf/Lm0gsvFENkWvEaTEj+tVKFzwgTVSw0HYuosmkLnlbGtxbfZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py8ZUmTL1uN/o10A0l30V1F7Yc7Q9MZ5x66/Z1fVKVc=;
 b=TfWx5LjRaL1wWXT4wLKTbKbIRx8adZjQBQxq4uau3qhQftHKL+SsGiAOsRQBctBDg6q2R3zA5UM5pw5IfVoeCFuMs/qNk76UP0Co8tWjTg2pybLHlxF8hzh92+sRaSsT0VEhMv7KruYtFFbMshSsbE/QyE42QlrAOTMdkxcyfxY6jGflhVpZbmVVRf4zcPGI8MAtfJyNLB2NbSq7bLbIvzTFV9sYjD8zg9t7PV+bAhggf2aRN3qxIk6vDmePpQlT6ypYiRNhYi0M8ORDo//SlpP7wAJDDD93LMSoRlKj3dAYETKRrT4tky002vTFLleV7ttaz4iiQfpO3A/GQxQIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py8ZUmTL1uN/o10A0l30V1F7Yc7Q9MZ5x66/Z1fVKVc=;
 b=t0ktywSG1YG6qYSixjicutvhg6k97jIa/zXK6CGQoCGFxG38OirVQGqll/e1yEAtJDRprrwAMkTVUs1bpjQBhwDNrEVBUXLM1OEGjlqy8zoV7Ew8foPBUpzds+UBj7cgLoww50hYSNDc9hfn0gNo8HMUY3x0y+CCi7dUfX0gJo0l7DylKcuUJ84Vko2WiexWfcvjOz99+hBsgQi/0PdjYsQMV0b2A0hlV5sBav3c8JtWygCfmHGQ9ppvxTNo2a+gRcuUNHx/4IXw0ZavQdZ/3YRvDHB8cUBK8lOgL1IX2XLwJ+EwUtPz0yyVPQH6NHTbcUgYzUD3Egl59AyY4YzxVA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5500.namprd03.prod.outlook.com (2603:10b6:806:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 06:34:44 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.031; Mon, 21 Apr 2025
 06:34:43 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, 
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 3/5] arm: dts: agilex5: Update CCU configuration
Thread-Topic: [PATCH v1 3/5] arm: dts: agilex5: Update CCU configuration
Thread-Index: AQHbsnw+XsiwQK8pCUGC++zRHrz/6bOtqe4A
Date: Mon, 21 Apr 2025 06:34:43 +0000
Message-ID: <LV8PR03MB8137D2866190713DCC60BCD7A7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250421051410.27615-1-tingting.meng@altera.com>
In-Reply-To: <20250421051410.27615-1-tingting.meng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA0PR03MB5500:EE_
x-ms-office365-filtering-correlation-id: 214c29cc-9797-4920-45da-08dd809e9a59
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/Omy/jk37q3NZDcAV5G5Pl2LbFCqnKE0BJd5pbGwE6IJgLjmBm1YORPW6IA9?=
 =?us-ascii?Q?ESezmOhYJaBB9sXNZ+FCNEHyaCITRuLYfyQwoWCGGhxBLVZvYLVd77whg3ad?=
 =?us-ascii?Q?plvto4B6fa0qtQnxn3HdIcuK3zteRVUZ/AER7WehRbc1zYExf/uHCEKVUAum?=
 =?us-ascii?Q?YcT+WMw0Umfkz7fk4FTlBUhcX2vZiS2egqRFpQlRE5k2ewiTXLHGB7AAeNWe?=
 =?us-ascii?Q?8XAsl8FCS369S9hekAmGB4U/RbDrWUffyn4wosp/OoE0vzVZyW6WcFDhftPu?=
 =?us-ascii?Q?YxoMX+duyrosI5ai9fSSDAZLFN5EU6oCxpKKBWGiBJqV4RC1/kUD4xyzyGtL?=
 =?us-ascii?Q?OKrp8RFpRSqND6+HRQQx+4WvFV0nZC/X5g72LblqaTrJdsDCsABuMtCHj2UB?=
 =?us-ascii?Q?E1PeoeKSNU6i3eDUDVq10uoVBFCtouJv+1Fmb3Fh8eO2F+M8IfBr3HXQC4Ek?=
 =?us-ascii?Q?TscbitXeoCYwrc2zPUp6kraapseUKFm4ufil8k1Vx8qROsT3Ge62z1pm7Xn9?=
 =?us-ascii?Q?zP41ewfipYaruGn4ZManBRYyS6GL4ffaV6mrbbNI5ZPHbSeb6h4baKHY94H9?=
 =?us-ascii?Q?URcEkXmpJr+Gm6+V+yBssBL/ZL8ek9yFBJDwEVEjWu6K3lEKnryXcocI+O9B?=
 =?us-ascii?Q?TlF/PCIjfKGGM6lKRcygfao0YZ+g8xcqVVa2sMGgx0dPrdFWDzJjWARVsiw5?=
 =?us-ascii?Q?gtxVlFmPXg6/rw/DN++h2kd8oAiNfofsd95cX/56pJ+q6k+qEdXK5jA6CgLN?=
 =?us-ascii?Q?iSst5GOJQcaVzLEx1ukYzzoVcFzuzHXLAJPjmF4ECmYmomxAcnhHRsfnuZ5S?=
 =?us-ascii?Q?h1J1GE+9GOzwiUbJSesFH33CJmeNDOIc5t2QgR6j2/3+IdAwsWZxSoaf+v5c?=
 =?us-ascii?Q?DbklLfnnmHrjVyeyY60/btuuoHLp48M3IcPHX19fZ5a4sSEiMXdyBcpk3fD8?=
 =?us-ascii?Q?wvZHfPTF82q3sHp015Y3VLhdJnz+a8lndbpbp7WT8D7/NpDODm3M/4FjCPL3?=
 =?us-ascii?Q?faND6D8SCkfDgS7o30V7Yfh+BG4agj/kxTsvBqc+MrAGb0Ebm2zIIPVDiHDL?=
 =?us-ascii?Q?GOc/U8kBlijS4WoCPLlrPGnC8UwpVaPW0JF2nDU7aiYkT6SAOK+GH+8gFYMG?=
 =?us-ascii?Q?EhbNKaKpjsMa3uN4rSSyqOoZBaDRryzjzFbuS/GtfiQ4WnXbRjjQdKRGW90r?=
 =?us-ascii?Q?YjvCZgW8n2yI0BND41TAEuJ3P8ks6CsjlFWPxV6IDfIdbHJ/gD7MznxFDjuh?=
 =?us-ascii?Q?i7NpKjGOuweSERBTBEeHDgT6v3nyAx9urdc9aSut2soCBLsKxoa6eawbmkje?=
 =?us-ascii?Q?9hZWZ382Hhc9qJW0J6lK7bo81UFC6l/ChvWhvq5awu8YulupTuddKHz6IeiE?=
 =?us-ascii?Q?tOU0Txlkgit653HkEutKaV0SCWHC6uotjwMZADO304nl5gMhLVB1Lm2g7P9z?=
 =?us-ascii?Q?jIkZ32zGsw9Jm9nt2eKIebTXnCCIgiAeNtX73Apz4mXdhyiEkTE9uw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LcUKlaV1nr4c7uKOvBsMD/VqizQNWJCizHuOGpQFR4/DCEPfxG4Cj/G/Nga9?=
 =?us-ascii?Q?A/oVD85xkSIZwtDdVm3l4zZoZHvDMnsR22LPPmPnSPuGhzK/cmDJqoKPxm3+?=
 =?us-ascii?Q?UVy1s+QQEXtL/nDAhz5JW7J8d1zuOzejYRK/Cf4L1u5vEcqLWcJh0HbZ5CTY?=
 =?us-ascii?Q?r27Xvy8EZ/EUh3E27gw5JPElFVT+K9IACZFYvqUCbmEp2/nQvt6+wqqQtdb1?=
 =?us-ascii?Q?qVFRU18obycosj5EfltYKDx1gQx9Oicp9v0diSvfEJcT4QszCxBEdr6QL4ow?=
 =?us-ascii?Q?kbqtxki/rvkHPVx7QADIIFx7yyyh6/fUUhQtRZeqd9/A7oxnLsIECr3F9Fdc?=
 =?us-ascii?Q?upWos0uj5NQ7UzHzRbCZAnzmpPt99ZNrpTkCTdVw8FyekXN80+UvD9/wBedG?=
 =?us-ascii?Q?4oMwDA6pOlIQsdomueA3iJlCgBjL7WrqWQZmvsjFoxdtfmlv87lORt+PARmP?=
 =?us-ascii?Q?6MMJVBG/QKBFxNPfFG6w3+Aiig5sDvLkeus346RssCHGmkHmsvz9nXOE0F29?=
 =?us-ascii?Q?glcOK1uwGSJxZ+FIbK8TstYxktZA4zQrNfUbPkIX4EF2Eae53Qmr4giCwoM0?=
 =?us-ascii?Q?MZCen1t1/iB8KjS6fDFnWu+fp5PDQcpLYYS+ohTkGbqD54x9CllSTnrZkQiI?=
 =?us-ascii?Q?Igx4YyqrEiJnKrVgcPTmvEvYI9a/wcRE+TJZaaq/zMMbYWasOFi0gCg9wZO0?=
 =?us-ascii?Q?3ny5SBaXruF5phBYVrFkrW02If7z0RPW22q9HWI3Ej/J8lqTn3+GoBBTHpoe?=
 =?us-ascii?Q?8s0Un1o7iKbvIGJvpgkm+q0EeYNWXWLxAFaY2hYh/4AxuKFToFdT9P8DtDDe?=
 =?us-ascii?Q?frbgoUpc/b6HE8oYsA5BCBQhtqXfWh5oqtCxoAkwpdaB36/lKPa4KBlWQjW2?=
 =?us-ascii?Q?2KU3bey/SesImUUGgq7G1eR4+cnGIkvnegl5zSsRLwwM+Lw3bfxaMPNz9B1V?=
 =?us-ascii?Q?bdaePeWbE9LMjFL55attoqTj74xCwZ7CesWyNqL1ysWZHxeToGnzrjqJWXm0?=
 =?us-ascii?Q?D9Yi0SbZRPBxZt9JyXd7VFHka9v3uTiXZ4I+JGZgrsGWRM8/uOcah7je+SQG?=
 =?us-ascii?Q?vVL1BLhxJduQ1ej3hnYeHRaWzFX/0BAC9rHyoAOaMMPQUCJqANlZZLYznRGS?=
 =?us-ascii?Q?XTpoTWew+oHNeAuYCYrK3WZAyZwhPVkFXatlOUF+6n91IFt/1xBWI0iD9W2T?=
 =?us-ascii?Q?ckKiOor5IddbhtmRZwHWp1E8DFAyoLqxG6sANe4lXy/2xjaR+EKZPANjSpfI?=
 =?us-ascii?Q?qMO+JqDG6El0cKlXW/cXu+2enCgFUmAC7yS7wDagDY2tCibcp4mZO1MZNAek?=
 =?us-ascii?Q?kku4IKrgSqMOej1B1bDFYsPHfRDcW5r9oMKaT69ByhJJWbc8zI+LcysAYNR4?=
 =?us-ascii?Q?CK5A756xDNdHDyJNQAAMIMoZvfNEJcWYS5AqFGCWAU3xH5hGrTv/ai0rSqdL?=
 =?us-ascii?Q?Q043IY0SUfhyCWE2We6c+YCbJVX+pVgLjEitJu+UrH1wCVmgN7f5Hpi2MT4s?=
 =?us-ascii?Q?Rk+8gCqVrWXd8VpPT8rDNREsZlBtFVtSAOTE6g6zpwSFpO2jaaKN5uuNFV4m?=
 =?us-ascii?Q?OTjYTT+uYS9zdgJIu3G96de13MvE7HuHGV0P45Jl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214c29cc-9797-4920-45da-08dd809e9a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 06:34:43.8746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lKPPkFEAJR9QUbLJ8rb4g70aiVXIztp4wSgxHPBeRp1qorCu5e+Q99+NZKLS+mKDeIEuV+8nHZFUpfnG4M1W48t747c/TjcNytz1r4UNfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5500
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



> -----Original Message-----
> From: Meng, Tingting <tingting.meng@altera.com>
> Sent: Monday, April 21, 2025 1:14 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v1 3/5] arm: dts: agilex5: Update CCU configuration
>=20
> From: Tingting Meng <tingting.meng@altera.com>
>=20
> Cache allocation for dirty writes in the CCU system cache was disabled fo=
r
> performance optimization.
>=20
> Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> ---
>  arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> index 8d6503dd091..dd6cb558f82 100644
> --- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
> @@ -208,7 +208,8 @@
>  				intel,offset-settings =3D
>  					/* DMIUSMCTCR */
>  					<0x00000300 0x00000001
> 0x00000003>,
> -					<0x00000300 0x00000003
> 0x00000003>;
> +					<0x00000300 0x00000003
> 0x00000003>,
> +					<0x00000308 0x00000004
> 0x0000001F>;
>  				bootph-all;
>  			};
>=20
> @@ -218,7 +219,8 @@
>  				intel,offset-settings =3D
>  					/* DMIUSMCTCR */
>  					<0x00000300 0x00000001
> 0x00000003>,
> -					<0x00000300 0x00000003
> 0x00000003>;
> +					<0x00000300 0x00000003
> 0x00000003>,
> +					<0x00000308 0x00000004
> 0x0000001F>;
>  				bootph-all;
>  			};
>  		};
> --
> 2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

