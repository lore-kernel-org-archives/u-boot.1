Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA41C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 07:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F37828D0;
	Fri,  4 Apr 2025 09:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="qChTh1Z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509398291D; Fri,  4 Apr 2025 09:19:18 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3A6D828BC
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 09:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXyYlka03/QRnzIVe/aBS+NogB8ZCbxurfEE6noAnlb6surXQPVE5WRGDMrMCieubrQHnnCT67577f6HjH5wWRHx7a1mFAz5CSKSRolh5W1iV2KYspGCaFT/AaWoWtM97IUTXP9sEsPGkc+ug4O+H860Sc3LgcBALJ3Vk56KQ3lQbK1e4E6Lg8v/L5eUbKoMNprb9JroZX0vnEV5E4Zu19oSHxnY78e2yDiPhK2f8afle1NwWTVNDQR1BsXc7iwu1O1eM3oncQeuEKJiPaeIP64akXpLaz1fHHgfNrOcLQzKcsvSIZbTkUNOMy2Gxd07MuhDaZoHYwopIf+/7mItyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EO81U2MbN2JF4RVu6QvNYfWK1Ol428pUmSYDUaZ8SY=;
 b=xCqZxd9ak3d3duHg/Q+GMKOz7Q8nGei6qORaRxxOhyj1/umscF4UUarLEtmEdpby2yf1PxnllL9Hpbl/Z7q9EwsOHgAkUES6vh7cBjINFUKio0dGVxxrfGt4lfX/ACRgzkaBQhZzzjFYB+KD0qfM6Uand6YA4w6kLZyyu+sFsHOVzWE/WxB8/7vn0NbI3cYuiNhajmuZtZqO4YT+Qkko2r57ZEBR195EQs4PT8BJNgS6Es4bK/c6iwo1KXbqPgnGa+OQLU2h0xvf2mT8xc+2waAvIm1+1CxAn6bjSUHh2QmW2muVs3UlLSAGWrNh7WaXIsRsutYwdB7MGdSBr5CYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EO81U2MbN2JF4RVu6QvNYfWK1Ol428pUmSYDUaZ8SY=;
 b=qChTh1Z2uU+ey6l+stp4ic6NfIwR/qIaG+oPFXlP6urkMO9lP1LVkb719cN27ls/ziyEgxlWwdfzwjweUyrg3em0NVFaAoL4iTEN5jr41BTxcK5lv/Kli3tRMXdu3ieTNVMkEg1ugv5k7NQ0jGErJPY7QG/hOBwGarAUSBSt63qA+ZPyjyWz3RZlaiaeShu6VkQhRxwcPwgHX3AWj96lH9T8Zuz+maesRpj2ER54kHeIEHWAs19w5f1e2VGbOm9+MrCWqzyvrYvKwjy+pNWFEcXBMiDCYpiJh54GDY8xJAtKHk6hEz/r64qbPaVyMy1mDGXTyDhudqyfKedOtsfaYg==
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com (2603:10a6:10:369::16)
 by DU7PR06MB9848.eurprd06.prod.outlook.com (2603:10a6:10:5b0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 07:19:13 +0000
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652]) by DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652%5]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 07:19:13 +0000
From: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, Wolfgang
 Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH v3 4/4] board/BuR/zynq: initial commit
Thread-Topic: [PATCH v3 4/4] board/BuR/zynq: initial commit
Thread-Index: AQHbo5GYKz4+8xRX3ka1RCrCCrZjV7OTGbHj
Date: Fri, 4 Apr 2025 07:19:13 +0000
Message-ID: <DB9PR06MB85594B2BE9403DD45BAE44DDD2A92@DB9PR06MB8559.eurprd06.prod.outlook.com>
References: <20250402053901.8149-1-bernhard.messerklinger@br-automation.com>
 <20250402053901.8149-5-bernhard.messerklinger@br-automation.com>
In-Reply-To: <20250402053901.8149-5-bernhard.messerklinger@br-automation.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-04-04T07:19:13.320Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8559:EE_|DU7PR06MB9848:EE_
x-ms-office365-filtering-correlation-id: b4a7c422-37b0-44ba-6c81-08dd734900b8
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?T/OunGAXA8z0JoQNp0dX3eULwW9qkiwX4dCAH/sIWV1t0EqK3jbmDWEeHS?=
 =?iso-8859-1?Q?Ib0lWcIQgvyM7ipsHBfPXpG2it8N7loGlSIcIB97v+9QxVYlF8TVILe/ky?=
 =?iso-8859-1?Q?REaLbRngP+auGPFrFj4rLuuineKgE0x32M/7W/tFm6yvKlXFGyHB3dHGGP?=
 =?iso-8859-1?Q?35slYG6m0cdaSICn/GiXtXxQqsjgTBgf6pM0f46e0yKRuiVJ+hmxPz8noW?=
 =?iso-8859-1?Q?MIkTo+3FbQ2zyDjs529mJstOJlPz3lvHGstbN7TJJYW8+ShlnpTd3izJHF?=
 =?iso-8859-1?Q?zkgi2nMlFUhi849Du4nN8Lisp0iWLLliI9VRHfDlAC1HEt9SU/vdfc8GfM?=
 =?iso-8859-1?Q?FFjLJGTkchaobYgvdmsDOvDr5yjnFrBvkyxZCZUCH3He0QZGKtroqPZDEP?=
 =?iso-8859-1?Q?qpefMzE4SoUew4cmDELeGlpi9hQxK1/9h8C4eBMmIndq2plfv9oNSgRlH4?=
 =?iso-8859-1?Q?TMk7x9ZttUb93x/own46BugPgE8eQjxKPpHWB1l3snVXzWWC1AjFxapt+b?=
 =?iso-8859-1?Q?ZLJFqpBCrgWoPo58zgvPT/P1at7KOGwI/cixDIruA01XIA70/u52007Wm5?=
 =?iso-8859-1?Q?dT/bqRj+mgEEHf3LGu/Wlq5lvo/c7A24SCHl95irUT+iUAdhzZEH9YZK4+?=
 =?iso-8859-1?Q?nUKrXcpYL+LppFKi+MftlDsazePY2Be+GNZ8QuoURv78FrU9ejyS+7rU/W?=
 =?iso-8859-1?Q?g2BCJH97MJy8QuDZ/hFnFl4zN70P0I8kEf/FIoRukLTNqpYMiBL4SKHTJX?=
 =?iso-8859-1?Q?lHXwU/y93dXMfx6bycFLZBQN+8P8pCo8GpUaE49zZYKVTWXdEBNMgHb96W?=
 =?iso-8859-1?Q?S6/EiTDvJzjl6a15j/XepDFDo7sriscnSL4DA9fDZ1Fxsw6hju2gTKcRMQ?=
 =?iso-8859-1?Q?dmt726fYTkW3RAhCMrT5D6O6zP6IzUpaFqGuOfqap/b6xeiyK5+XqKXdov?=
 =?iso-8859-1?Q?rWLMGqA8gMh+gZ4KbgL+0dpyCfECjNOMPl5lB/dn7KAnYypxZMeDvG9Qtw?=
 =?iso-8859-1?Q?MVCU7WLUtxjbjDa6FnvIvmwdDtQobEHZbiqegf0ikgmxRhh1PWX1VbK0Ws?=
 =?iso-8859-1?Q?P9/Rp96VUX+8xMyf+WHGh/3TtK/DTU9f1wSPOjr0zcSnhR+rMxaxzHbWM7?=
 =?iso-8859-1?Q?CD50UtIEa8Sm6mpwligocNBA7pUjV0trlDP1KDLmfnaB7iK3EMa+CP2pOc?=
 =?iso-8859-1?Q?C7UXjD3f/YeGkEU9dnTyrkTt2gnBPbBAXbr+Q+rkO2QYhUxWpJDDPIF3LF?=
 =?iso-8859-1?Q?e5pZSO8fYzXWiqn1b8vlEPfn47Hgh/n2RR2EdxlU6wweaq8vHmrs/vEeDS?=
 =?iso-8859-1?Q?5ZGsQFxYr4R4wLha1ePZ+5pHJMWikS6GG3dPpaCnc6Vfw9QKefszgVfelr?=
 =?iso-8859-1?Q?WGekL9N+RrJ6DT9OIvyDk6Ga8kund0U0NZGeoCMjA6Ln1w0e8lxzbO6V7R?=
 =?iso-8859-1?Q?0PuxJZ2O/iOKNlDqMDBtOTLT08afXvZ3lAJKXU2shJ6vttlENdIxzo/6vv?=
 =?iso-8859-1?Q?GbqkzQ18AEU5eqZ44x+ZN9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8559.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?frhOwrkgRTN78WE8aS5lACvqeOMWruNRlXtmOmGLo1I5NFXOaRxGv5bvfb?=
 =?iso-8859-1?Q?khC114EQDDwqR8QHrDMb9wikPyGEovwnkLugY/gUJlL6heTxVa/lGoYWYN?=
 =?iso-8859-1?Q?eO3VLVvJslQBYRoWHneaKqusgeZOPekdMbTi8rHu4G5sts0zL2fqMxvrxO?=
 =?iso-8859-1?Q?PFkw+yf6wNf9Fr57ec/ao07kOKwqX6Qab7Vr9MLdIA8q87yFHFUwx7eyJj?=
 =?iso-8859-1?Q?Cn2ANRDBRyRODPx0iIGvIMZ74HMjIKddPDap/4afDBZ7VH3+Q6NkmY89lh?=
 =?iso-8859-1?Q?CjK7ARlij12Y56t0j4dZog4iJrm8PfokV/W3LI5Vq+KDU4GPlhpB6FNo2A?=
 =?iso-8859-1?Q?Choj63HlIGHhLWbMc06s0SKzZTyuhsS+mCNHTrM252T7KxJbAXQarCRZBv?=
 =?iso-8859-1?Q?KaaMO/7xa+QauhTgWQyeAboqHcm+e2FtEGNSQfzY2LRGEx5Sj2T1Y9y70L?=
 =?iso-8859-1?Q?Kdo4Uysd4dbT8RdwFWLF9fATk3uRmcNYlzKgAqujm9nmLSA7TpyahtsrSB?=
 =?iso-8859-1?Q?9+yQPVUIFobVMuhYrLDJer9VndaaCaOKSiltsJupS3WM7uOJwkHdg7Q8Fv?=
 =?iso-8859-1?Q?qYRCKB9LDLv0W/RX7wp8lT8NuOQJPfW1bvc2ErY1IvOpKzdIeND+SE5YGP?=
 =?iso-8859-1?Q?dWcmTbis8sLHclNyKkrBEcItPNYkKIfuu13vUmVE96Pj0Px8GDaMYpcRCj?=
 =?iso-8859-1?Q?Oa8a5+4R5KwcaaVpa57ccIRIOVtbTfIPNz5W4ypEKJ7kIFDOlY5/la8wfo?=
 =?iso-8859-1?Q?pjfszhh+azsf1XmqtEmeeqoNXjW5SxZbn5rRrSyEDh2JEmwik7eRRxMj7l?=
 =?iso-8859-1?Q?DteOZxv9e/i8Vl4ZMMcO9KocmL0ca4OY2bFzoey8e0VkR1G1GnRZNvS/xL?=
 =?iso-8859-1?Q?zFQsclkdJmvC+USiTYMYPs7G7Z13HKW6bE8Ix8KtTSdSwSwQY0WwCDUoc8?=
 =?iso-8859-1?Q?KLSBW26o6WEDLox3zMA97N+LaNTWqac0lC9mov0ld5u7+3UG5z2swDb3l0?=
 =?iso-8859-1?Q?RcvGvlBRh9ZMM3J0yr5PVv7q/4slj4kXubaGxSq9rbnABXj+qJNk5CLN5n?=
 =?iso-8859-1?Q?T45D3/0Ce8XBmaDXhEy9ZCux5W45wQfBhG3juoBtCNuvE5PQ2zmDdnxWtI?=
 =?iso-8859-1?Q?IhYs9ok6Ro/DblGMmsF2pMW0cFDux+iV97zjs8a857/DH9tdsILxg8ick5?=
 =?iso-8859-1?Q?FQ3gQ7TYU/F2RfbpqgWZA98neDMGw63me69HBylUW7O44E2Sj/U9jeHIzp?=
 =?iso-8859-1?Q?v7sika97Eo6SBN5FaABgIZ3zUEjncErNLZBvJblaM4wD0Ik0Bd/jn0eRUQ?=
 =?iso-8859-1?Q?hKPXJqno0slWf+a6j4r4YjRGijx4gl6lMn2WecVwnsSzw+mBwWVsDrDeKk?=
 =?iso-8859-1?Q?gh3pLEtsdg/3Ehd7dgmef+CfXJybzoSabNGnyEpRT6/N+pm3AFdd8FtPb7?=
 =?iso-8859-1?Q?1BygfcX09hWpzfgO+eIOsL3+I92XU0EUT28+wnMSIJVaYxEB70z+MgbLsv?=
 =?iso-8859-1?Q?c35HhWRVzU8ZvtkwhMJ44oDgvKq3Lv1ERriuawR2rq8Wq5pYabUXu+TcsY?=
 =?iso-8859-1?Q?aXhCVm0UJ9uwXnMHjmhjmweilhvSNx/QYPlV5xlYF/yjSWLxDWl2sYL+Gd?=
 =?iso-8859-1?Q?VSUwGOkkdIYZqILI7un6kgJQjTOpSfQ6Q0kYgQO+UrEpnZ/FNSJyIxp5ai?=
 =?iso-8859-1?Q?6bJrMwYH8/3lt7+z0cs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8559.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7c422-37b0-44ba-6c81-08dd734900b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 07:19:13.7852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iAGkwhTSsk1oAqJOx31AqkKoDh+YZovZBFoUzZPU3hLp2SmKn0oK5P6Jtb+kSf3ZE1vZf+9EXVGfB7pnXTok30c+olXVyrC4fyBfbSYZK/wL0gjBTQ/l5HHcIrHFjXJM7WZHN9kuewN7uz1wmpSRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR06MB9848
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

> From:=A0Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>=
=0A=
> =0A=
> Changes in v3:=0A=
> - Split spi_flash and qspi controller node in device tree for the usage=
=0A=
> of bootph-all=0A=
> - Merge binman descriptions into one zynq-binman-brcp1=0A=
> - Add links instead of manually including u-boot.dtsi files=0A=
> - Remove empty MAC addresses nodes from the device tree=0A=
> - Seperate B&R Zynq device trees in the devicetree Makefile=0A=
> =0A=
> Changes in v2:=0A=
> - Remove all unnecessary device-tree entries=0A=
> - Reviewed led names (no pattern restriction found)=0A=
> - Fix maintainers file=0A=
> - Cleanup of code=0A=
> - Move preboot variable to env file=0A=
> =0A=
> =A0arch/arm/dts/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 7 +=0A=
> =A0arch/arm/dts/zynq-binman-brcp1.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 10=
2 +++++++=0A=
> =A0arch/arm/dts/zynq-brcp1.dtsi=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 131 +++++++++=0A=
> =A0arch/arm/dts/zynq-brcp150-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 34 =
+++=0A=
> =A0arch/arm/dts/zynq-brcp150.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 173 +++++++++++=0A=
> =A0arch/arm/dts/zynq-brcp170-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 26 =
++=0A=
> =A0arch/arm/dts/zynq-brcp170.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 139 +++++++++=0A=
> =A0arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0 |=A0 30 ++=
=0A=
> =A0arch/arm/dts/zynq-brcp1_1r.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 28 ++=0A=
> =A0arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi |=A0=A0 1 +=0A=
> =A0arch/arm/dts/zynq-brcp1_1r_switch.dts=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 30 =
++=0A=
> =A0arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 1 =
+=0A=
> =A0arch/arm/dts/zynq-brcp1_2r.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0 21 ++=0A=
> =A0arch/arm/dts/zynq-brsmarc2-u-boot.dtsi=A0=A0=A0=A0=A0=A0=A0 |=A0 30 ++=
=0A=
> =A0arch/arm/dts/zynq-brsmarc2.dts=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 157 ++++++++++=0A=
> =A0arch/arm/mach-zynq/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0 1 +=0A=
> =A0board/BuR/zynq/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 14 +=0A=
> =A0board/BuR/zynq/MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0 11 +=0A=
> =A0board/BuR/zynq/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 15 +=0A=
> =A0board/BuR/zynq/brcp150/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 4 +=0A=
> =A0board/BuR/zynq/brcp150/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0=A0 | 278 ++=
++++++++++++++++=0A=
> =A0board/BuR/zynq/brcp170/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 |=A0=A0 4 +=0A=
> =A0board/BuR/zynq/brcp170/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0=A0 | 274 ++=
+++++++++++++++=0A=
> =A0board/BuR/zynq/brcp1_1r/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 4 +=0A=
> =A0board/BuR/zynq/brcp1_1r/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 | 274 ++++=
+++++++++++++=0A=
> =A0board/BuR/zynq/brcp1_1r_switch/board.c=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 4 =
+=0A=
> =A0board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++=
=0A=
> =A0board/BuR/zynq/brcp1_2r/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0=A0 4 +=0A=
> =A0board/BuR/zynq/brcp1_2r/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 | 277 ++++=
+++++++++++++=0A=
> =A0board/BuR/zynq/brsmarc2/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 30 ++=0A=
> =A0board/BuR/zynq/brsmarc2/ps7_init_gpl.c=A0=A0=A0=A0=A0=A0=A0 | 276 ++++=
+++++++++++++=0A=
> =A0board/BuR/zynq/common/board.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 231 +++++++++++++++=0A=
> =A0board/BuR/zynq/env/brcp1.env=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 109 +++++++=0A=
> =A0board/BuR/zynq/env/brcp150.env=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 119 ++++++++=0A=
> =A0configs/brcp150_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 121 ++++++++=0A=
> =A0configs/brcp170_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 120 ++++++++=0A=
> =A0configs/brcp1_1r_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 120 ++++++++=0A=
> =A0configs/brcp1_1r_switch_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
| 121 ++++++++=0A=
> =A0configs/brcp1_2r_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 120 ++++++++=0A=
> =A0configs/brsmarc2_defconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | 120 ++++++++=0A=
> =A0include/configs/brzynq.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0 21 ++=0A=
> =A041 files changed, 3852 insertions(+)=0A=
> =A0create mode 100644 arch/arm/dts/zynq-binman-brcp1.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp1.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp150.dts=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp170.dts=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp1_1r-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts=0A=
> =A0create mode 120000 arch/arm/dts/zynq-brcp1_1r_switch-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts=0A=
> =A0create mode 120000 arch/arm/dts/zynq-brcp1_2r-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi=0A=
> =A0create mode 100644 arch/arm/dts/zynq-brsmarc2.dts=0A=
> =A0create mode 100644 board/BuR/zynq/Kconfig=0A=
> =A0create mode 100644 board/BuR/zynq/MAINTAINERS=0A=
> =A0create mode 100644 board/BuR/zynq/Makefile=0A=
> =A0create mode 100644 board/BuR/zynq/brcp150/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp170/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_1r/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_2r/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/brsmarc2/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c=0A=
> =A0create mode 100644 board/BuR/zynq/common/board.c=0A=
> =A0create mode 100644 board/BuR/zynq/env/brcp1.env=0A=
> =A0create mode 100644 board/BuR/zynq/env/brcp150.env=0A=
> =A0create mode 100644 configs/brcp150_defconfig=0A=
> =A0create mode 100644 configs/brcp170_defconfig=0A=
> =A0create mode 100644 configs/brcp1_1r_defconfig=0A=
> =A0create mode 100644 configs/brcp1_1r_switch_defconfig=0A=
> =A0create mode 100644 configs/brcp1_2r_defconfig=0A=
> =A0create mode 100644 configs/brsmarc2_defconfig=0A=
> =A0create mode 100644 include/configs/brzynq.h=0A=
> =0A=
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile=0A=
> index 267b0179a5f..40e696c9e37 100644=0A=
> --- a/arch/arm/dts/Makefile=0A=
> +++ b/arch/arm/dts/Makefile=0A=
> @@ -297,6 +297,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) +=3D \=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 zynqmp-zc1751-xm017-dc3.dtb=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 zynqmp-zc1751-xm018-dc4.dtb=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 zynqmp-zc1751-xm019-dc5.dtb=0A=
> =0A=
>=0A=
=0A=
Sorry this is a mistake, it should be dtb-$(CONFIG_TARGET_ZYNQ_BR).=0A=
I will sind a V4.=0A=
=0A=
> +dtb-$(CONFIG_ARCH_ZYNQ) +=3D \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brcp1_2r.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brcp1_1r.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brcp1_1r_switch.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brsmarc2.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brcp150.dtb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0=A0=A0 zynq-brcp170.dtb=0A=
=0A=
Regards,=0A=
Bernhard Messerklinger=
