Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C428CA0ED1
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 04:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E7768334F;
	Thu, 14 Aug 2025 06:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lJ909yEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E24968334F; Thu, 14 Aug 2025 03:45:14 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9549B8367B
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 03:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLNSmDRXA7f4XvzrN6PQM7XVP7v7hlfHKCK5e6sZ53s9uH+L1mw5HzAFdkmWmYGGnwQNjv53vodM2nrXXm5H2i619lsbqqOFm1IOG02rKmEsn6fVY3kVgPyKcACW63VBMVZXivBMZ12x76JjGhmuY3L3LAw3XD39/1Ac5s7+gqrMMNdrTPgYGu8r9i4SpsXDyTiWXri7Wy1WhYsOh2SGJginDSXgBGyIY4ejEKtbG2VYLr8azd/8+9AdjPpxnHpQgEQe2CIdRk5XSfrZ807tGnCp0q25VYg+SX4Gt6EFokZUq+MXY1hqxuiy0rROaX9oYM1MubBo87SlL715Yt7iUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WrlTRpu0JG/5IX6NXJEYmXjUCj6gnjtrJcyrAzWk2U=;
 b=k4c4WyszJmQs9SCm0PcQU3PONeFo1r8uqegxVKH7L7P9y0AzL5tzGrpb/im60jdR1eM4r+forAxDCs9v0AjRP9vQVJeDgoN8UPF47tXKkKkyt/wtuTB/Vnm85sHuoWHXMahEhsQPabFvdPPk7qwTOZqSpA200lVNhG53Sn7wW8Zjwv0sjTz52SQSZHiIAK/06R6KHPHwxysYFsIaLBtnpEqD1i+ALmBV8hUgVDZK/CaBrnupRvc/PnnAarn3vA36cNEakMjQOz/BR4Srg5QoLMGFhNkh3oXff3DhjUrEV4cWDqwYkz8EN3ETOVus8KA90D97KUHl9XEVU2EnsdcUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WrlTRpu0JG/5IX6NXJEYmXjUCj6gnjtrJcyrAzWk2U=;
 b=lJ909yEmPo6wiq9rj73Bb3OivtHgPNNUu99gUOQeWbiavEy3CnpMLSOGux6sCX3TwtN6tjjF9wXEI7UFKK1mkm/blH4H820ry7NRYAlZ3AlblJqUYdF0fWjnQEbWjSTLeCs5fE/tpxbxC7g2tNplCJDtqQLySuYe99tJSeSGQSdCag9LS/aCH3NCQxSE2nGa9BpCXxHwJG++iTHDI0RJGn6/xG8qNm8GZ2wpw6qaIkH/784zHpJ//yJHGm8AKG+2sQ5KVkpbvq1Y0oeVYu1J2jEo4NFIYrUfVhCybzmkPl1jaupTE5xJ1CajGPt6QJkihkATZ4XtYaqoQPR7TZMjgA==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DM4PR03MB6061.namprd03.prod.outlook.com (2603:10b6:5:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.11; Thu, 14 Aug
 2025 01:45:09 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9031.008; Thu, 14 Aug 2025
 01:45:08 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Thread-Topic: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Thread-Index: AQHcBoFhEBHL3hwj/UehvObAJCQrPrRVpioAgAC7hoCACbrBoIAAjtAAgADAsVA=
Date: Thu, 14 Aug 2025 01:45:07 +0000
Message-ID: <SA3PR03MB71872D04D507211174FCB9BBB435A@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
 <20250806032206.16688-3-boon.khai.ng@altera.com>
 <20250806135412.GM124814@bill-the-cat>
 <SA3PR03MB7187B3809CE6E420A2715E33B42CA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <SA3PR03MB71870FAC5AC6E398C2652C47B42AA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20250813141116.GZ124814@bill-the-cat>
In-Reply-To: <20250813141116.GZ124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|DM4PR03MB6061:EE_
x-ms-office365-filtering-correlation-id: 96feb153-769a-4b0b-d912-08dddad432ef
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GBg6dRcNUzIaGjXJc3KO2vwk5NdrFdd5WAasAfsGGxB/uDgQuJuBKhevGmLD?=
 =?us-ascii?Q?EmCAti3ujSnbVjKWDvMnfvYRbOOhW06DRprvefGPAxbgeV/eUORjZnB2YAfa?=
 =?us-ascii?Q?cOeR9wv5DkuUkMSEkaU/B03EOnIolQHdJoGshnRxo4B7nmjqxMa4aYyK2Czh?=
 =?us-ascii?Q?Aemdbw0M2wHD2iOyi0F0Jy5R1m2RFmXt7LmRG8vYtykIgPf6HrOwuPwQyRRr?=
 =?us-ascii?Q?VNppvUsoa4mqxO2hmwv2i+82HwL61nVgPyXIJZQuseAmVEMHcU/RxTzHoMMK?=
 =?us-ascii?Q?mOoNGozFOhhrCBT9VWzLpXv6O+x+l0UY0z1BC/DCNrBq1wmF8kyde35b9x13?=
 =?us-ascii?Q?5Y+SoJHu0I1jg2sgLZMOm0Lcg+meIiut3pef/1utR8Z8KFyqu9u/5xkp+GOo?=
 =?us-ascii?Q?6aSorqxouZQSb3JB7nmrI+hET6aG8gxFJhJkzpEzN8OwusNQFOT5BkJ6cArm?=
 =?us-ascii?Q?++SSucSQvDjlSb16vop3j0mhDdNJInnS20g7qASTsCYep9dLT811B7hoZgYR?=
 =?us-ascii?Q?75dT3I6dWwZ08RZP9OCCtvFO8up6o+OT3142NO+YM6yO24QoJal/3kiM0vSB?=
 =?us-ascii?Q?XiGFCZOWDsN2lC+UqyyJD/JReZeXVfkelUwgDIIkXHIJLdHcFjUgNzk63YPz?=
 =?us-ascii?Q?5eJK2eDf2cTN/gdOnwhw47yVutt3befuvgkZUgPQe16zTwy2neYMsUBaL8OZ?=
 =?us-ascii?Q?Mp6K2ruby+SqfuY1Ywd6ytnKBzIegxg/+qiU7Et5wCu1udXmJFrCI3h1wO+O?=
 =?us-ascii?Q?1q0jtdV6LoWK6G5tTTHna2VT01UVCVgtRbL74C7JfeWYOsRHbir2obdj9CGH?=
 =?us-ascii?Q?IDnZEGI7e0X75bubr5IjrMTvVri5RRoT5UBSgXFdHcWG0Ia6tNfvzPhPYwkf?=
 =?us-ascii?Q?FDKhoXHE/SuTACPmyHNI3d6BpAaf+AExJs9c8fvThzSW7e0VSuy3eFJjP8z1?=
 =?us-ascii?Q?SNVI2Ydt/z+kFk2vW8R0oxJRbIXv7QGd1c69yFHoepHIzU/hqpU8dUloaMcr?=
 =?us-ascii?Q?ESTZG9Hj6BbU6kIVUHshrAffFN/Qzs1nEhMFoyT1KgTYy5Wa7NLL0Pciy1oK?=
 =?us-ascii?Q?Rn6OSSOnhm5Q+Z3TVlV1MUBWFuOEZ+DRK0kASXcBdM5fzOvmEReVnBnYd7F7?=
 =?us-ascii?Q?tfUS4uTWWhIQZhks/A+tYHOjTMTo5ONTOYWVXRgQb5h8e1LHkAP7IaKXJke2?=
 =?us-ascii?Q?zlFqGxdumnW87QWvosrA6d8XGIHMq+n3sG3Bt8mh3uGyPcvhUXrHNvnIuyUn?=
 =?us-ascii?Q?FT+DU8LpGnAN2yIx+UV3IXNlH0e0VPvcP1/MIKjaEcjVY3I40LABveUnv6WF?=
 =?us-ascii?Q?9OkqQvJU7r6GoAxHzYHIN7zwX/35P2TpZfeYpBxwzPhlvXK3lUSvjqGxls6x?=
 =?us-ascii?Q?zuKpJwxH4S9zaz8+sYAi50k0cWBKHshtEq1CoxXDwry3ncVG7IWM2i4EDKYV?=
 =?us-ascii?Q?h2JpdicJs9ndXFqSgv7e89oMHf8PLGav+Cuvhviu+yVLI3jU1bfOeA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e07K3UR77Z6CcEQUu69aYdoq90WGOiDIvXWK+0nhe4xca/8UZsJwviX6hA8i?=
 =?us-ascii?Q?zDIOeCN0K2hrMwYf8u5emc8mr9B8PADN4kTMcZLHShSMQpVBJVNBiyKDodbN?=
 =?us-ascii?Q?qiFxP8lRdOTrNfMEXeXFuzU6/1jJOZBquwcI2hKuk+YR7j2oPPP5hNH3876G?=
 =?us-ascii?Q?vJMYQCZ4SAO9wOdcb3yyfO3PjLb2tmVzhr+xeLVvwvKLefF3yi4hNyfTxU19?=
 =?us-ascii?Q?9MU1WhoDsGnJPKf3a60e+FolJdl3raNypKtoqE23XhQUFB3rCSBpN2O+wtdM?=
 =?us-ascii?Q?hT+Sg6IRlWZX5QJ0r4lDOIpLefTqjf3TEEezrF8MbuV4d+m9wQUwDHiUyZpj?=
 =?us-ascii?Q?EUzOfv3y4ybAblWRST2vICDOa2osGsYduCG9qq5txm2g2vMPhUpE/khjPcyo?=
 =?us-ascii?Q?JskUz4L/lnbcuNbaBmjg6lyyUjhql1c9aArDhztsyW4YcYX5B0tOHVpIg9eY?=
 =?us-ascii?Q?fM2cZI5C57y22CKUDNOfuHO4GFuXsBV0eBdmDowF8rIOWv1X9py6AGOMj8XO?=
 =?us-ascii?Q?BAIZrLdpNk4EDyoi6b58SEeEfWAoryG3E4FfjxkDuHL8kis2cUQtEYxmawkD?=
 =?us-ascii?Q?t0DXUujEleQi3jM6BgZcJ2Hdfi62oC2F9bSiUXKbQoGQR4mPV+/YVF6psuYp?=
 =?us-ascii?Q?nQmPwJvezymxDFhT7CwEmizgLtb/SvnfSShvlO8Fvtc3m/z4PwpiWcHaOTvG?=
 =?us-ascii?Q?IqqN6VKWvOt+XaTUtzpNKaOvR87AYMGV1NXtwYESGWhwnOkQXsoCWSsX3Rgb?=
 =?us-ascii?Q?qFF7RpUpFr8PMxTHgFnh2kfqUqyCCbuLhYG9mxZyDJyK+2sfY1dAq/UE1scM?=
 =?us-ascii?Q?/E9m8OmBSisMLEwD/J96NhULXOuG5XpPty5UGFjwrMhIwLc8uHpZ6PO4Ad06?=
 =?us-ascii?Q?iFbs4tF+6HUyhPyVfhLFCCjjTAbGw3UQAnAPFn4D5SOvRWctLwkHZJmWabPO?=
 =?us-ascii?Q?9IFjuitkVNEZRf/QoZFScXPhf0Aeo2phMGfDNPHE+5nCmYOOWrHiWlEY3vHQ?=
 =?us-ascii?Q?7nV+MYpVYjfAQv+lVCyyITPb3EYDldSpTk09O69zI5mXx+zLXgoKFnP7hSom?=
 =?us-ascii?Q?yBE8nEHQTlL3MN/XG/vjX6w2Plfe5cRc+czB3WSBSQOPqCNLCKDgF+50RoOG?=
 =?us-ascii?Q?vmwUdXfI8Fzxnde3XveU1PAs3NZhfavytTv/DGjMDfy5Goe2INFFdTrlTmsg?=
 =?us-ascii?Q?YXYztltYe2ONOd+PuLEfteK3Vy7Mr/qae0j54nXipewu2iezju86DDUl+Rjo?=
 =?us-ascii?Q?b8zt9C7/rXUxYx1qy7F1UvDfv0Ow2lXSn/sQ5FlTlHP66dGGn2B4KvQUShAK?=
 =?us-ascii?Q?A1L520Jk9KuaprTbZo7yEucdhs/fxxq9+G4ESytraiIz9n2+886eNkTga1Nl?=
 =?us-ascii?Q?vAGRMu2xyRSCTzIaBghPiqEkvjpQxZxWMqghlSMbmG1V1hwIewwe0STSL1OW?=
 =?us-ascii?Q?P9II/mOXevfZDb6o95eog6LBnOVBaVLf2nnIz5pVKp7yEjCrp+Ya5BY0Kmft?=
 =?us-ascii?Q?fyZ826aYjqRaS7+krdjfxXZ3QEwPQ5CeLukODKHsqWQqtSFARoog0miPq0AP?=
 =?us-ascii?Q?jZBBgD1deBXlS2yuiLQZlwzlmxA+yLqNe+PefCPk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96feb153-769a-4b0b-d912-08dddad432ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 01:45:07.8775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: melF8I24jcD8PPrNkk7Eu87i3V1A6nxs1kEr/WsJSV8WDMMB2b5vE7m2+Auw4v660r1Etiiv0Tfv0nD18mrvaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6061
X-Mailman-Approved-At: Thu, 14 Aug 2025 06:34:12 +0200
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

Hi Tom,

> What does your patch and config look like that shows this problem? It's f=
ine to
> have an undefined function when if
> (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) becomes if (0) once evaluated.
>=20
> --

I apologies, it was my mistake, where I have a script compiling the wrong f=
older
without both weak function, and (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))  chang=
es.=20

I'm preparing v2 patches, to include the  (!CONFIG_IS_ENABLED(SYS_DCACHE_OF=
F))=20
and remove the weak function.

Regards,
Boon Khai.
