Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2CACCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C05883B55;
	Tue, 11 Nov 2025 11:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="lAVjL1wU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8709583B55; Tue, 11 Nov 2025 11:10:35 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C04283AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j61BE7qpOprTs2ZBcJZKNQC0osi9I2MKq0GriJjk5ybllL+g02RwPESC+fweDgM9MKebBxX2fi+CJXNRi7vR0Rdc6QpFsmwiEYU7S1b6NbVj9YBQimG4RUFAVkmEMfauUWL3uvYdRctPwlN7T8fgaoD+qbeSPg+iHmz9FW5y1kQR/bOwuHpi/caxAmj9sYmr75ORAq7aaZK1ixFdq3sr25nfb4C175C674fL28ldLRH2rfgLilPOVKD9G+M9TORcawn8dXoGYbZwDJeXFWerMnvTdRDm1wY/YjrG8rU/sFfy+/G/CfO2vhHJGJ5Kd8AYEei5U+Cb08tTsK2E0CKo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMsigTu5/XY8vKyX/142nq9ySPyRKDG5raeQGDbm6ek=;
 b=Dv5EK5jtWt6/QmDrZlANfkWbfkWHIsU1WrHVWAd1n0X2FkzhUtZVZcDisgbj3PP6hHuIonGyeWba2667XKtaJJx8U4621DzE51btmMjCR4DQ+y/d/Z+RvaSF/oeYFO6QqFXw1ZXuSX3TpP/gjRXrZT84+fKZld79e5dZ2jPix1hH198JCLaSIZ9RpVTANiPc0StsfjNDiUqqhCCw8Ow+JXAdvZ3qD0/Flxa3+foj99XTKhoYGyCmyTZrvdgl73aIXLNhJYbaPTw8+0VEFjZGuaBTGgDcSWWLbe3G8C/AWEXUS0DO5ONXQm9SrcZIRnednQ6wjHclIU5KHmHmqsOJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMsigTu5/XY8vKyX/142nq9ySPyRKDG5raeQGDbm6ek=;
 b=lAVjL1wUM9olyZDKSa73kwoJQU7dfjE5F8xprFoaJPIroy5oI/ieoXlBoQKJcI6VXQDT1+6I9qBDXl6rOOu6TsAuxnCq1XNOyzbY/qLzyX0tTQwuoBZWkybZtIARfQgp21Cdffdbhp005sYU3qKMHd4nBGk6TJeFkoVO4AH130whhQb72bcTZT7zJFrijUQTv8yn3ZlY74jypehXLtSqbcKxLN4OOq41sL/dK9MGlRkGVrF3V9o3Z457kFd07Fd7UWoxsmrKHi+TvV9dvWUtdetymoWiJkaCKVDJF5gWkebC1E5GDnNx5wWo2mVdOziOtuvh70iHDRW3Y9H9HllSig==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by PA1PR06MB10090.eurprd06.prod.outlook.com (2603:10a6:102:4f7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:10:31 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:10:31 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/3] fit: allow signing with only an engine_id
Thread-Topic: [PATCH 0/3] fit: allow signing with only an engine_id
Thread-Index: AQHcSnpYr4kc498d7k6V/7PX2nvgyrTtUAz2
Date: Tue, 11 Nov 2025 10:10:31 +0000
Message-ID: <DB9PR06MB851219BF2BFB0D28C7211A0CCBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T10:10:31.202Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|PA1PR06MB10090:EE_
x-ms-office365-filtering-correlation-id: 18f3eccb-5058-4858-e5a4-08de210a8c26
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EEwQLYfNJix/1Tuyk/YBBOmDSH9xKDyfvREfaFyeNVXAbUDN+id7kvng2s?=
 =?iso-8859-1?Q?aBieQiE70IGItVxqfQPWbXXXXQ4VADEYZvoEkxs/HLD32KwjizapurDWwS?=
 =?iso-8859-1?Q?dUhBpuBptRn03AJeM5bvNbUyoj916d8nXyCEieId75YfNzdhaH4ZLqnU1g?=
 =?iso-8859-1?Q?kg5347fh3oteaDqrz8L8vJMS8OGv95JkaXLbUldpw+Wmp3CrlDn80i7qFh?=
 =?iso-8859-1?Q?LyuzxSaPzHIcDPdFp+uAQvNXGJh105hTeDdwyfUdACKkBhsHLrXdTS2Fr3?=
 =?iso-8859-1?Q?qiyiLxdt90rLvfWEAOFjTr6lZnRTbg07MdRbyggzNK8AVI4vaAgT+9dqyt?=
 =?iso-8859-1?Q?Jkc2UQM1FKgO9wcFefarrTB6ckYEpHWOHcFoLctN5AaTg873s1MgdSjlgj?=
 =?iso-8859-1?Q?T8KLweKMWK4PcjZAYV0faQ9SnPh/S/Vz8kjJhrk2cdaaGajIWF9n/VFMg4?=
 =?iso-8859-1?Q?e2TvTpL38AfH9nhq+BePymitIGnbubAB/o2474aAyhPhZMT6F/xVtnhlCo?=
 =?iso-8859-1?Q?/Hd8xBcs2SHr/t1+iRiZstHORqcwd05YmhSXcZG+6CwYCE2rRP4rFLj8dj?=
 =?iso-8859-1?Q?0vNhhYT2VeqP6IV9qotunbSmttJRcMvWT8L2keKgBXqMk9lN2ks8xnslY+?=
 =?iso-8859-1?Q?TKpy4QR+U16YdLomG57ukhJWRfo/7eNESvQnszdChKUIsFhL6rHyHXoqz0?=
 =?iso-8859-1?Q?fkVkPEIB2ngOUjir+Q9sWSy9hY6fcvBhohJ4OjO0eZIXpRE0x//5BEP9su?=
 =?iso-8859-1?Q?axCuLso7Luo0iJYGzGUJT8ZnQmF9boP5Vg7X3wBklsim+5f1o4E5zzaT7z?=
 =?iso-8859-1?Q?vE9g5O5IiUH2fPZb2HRghjwT7vfHRpS+tcscXs3VnY4JQpRUeXHdri5On7?=
 =?iso-8859-1?Q?8W03HPdmQWocuUpkSJjA1tKpL8yO0oSuOvVDBsdzceLqK3Y+6g6qjg073H?=
 =?iso-8859-1?Q?pulH9Mlj+QrkkABLTihk3nW2/w5PjP3i7kItlNdvcR4pc0xYGti9Y8BB7l?=
 =?iso-8859-1?Q?3yno8z/gJuiFIEuhU1j88jUKSLteHjS5ERdtwGInBYyZ5Dz+3UJlm5OtAC?=
 =?iso-8859-1?Q?U12MInH2hGNivqMIYN5MF7zBbnGeqziV0ggMKnz+/+mmq3r+vgeMhn2bpb?=
 =?iso-8859-1?Q?/R0gaGsmey7rsDTxbawsdsZK9AZ3jn3bmFwksgdh7QOXmtXkoJGJ1GIc+/?=
 =?iso-8859-1?Q?nY+LWJWMbSANBnGhbr5R+m2/sgq13Qf+sklCwMt3vxjVTgO33PkBJ7Flt5?=
 =?iso-8859-1?Q?3W0Sff7/IjYIHlucSWcGYGVgtw9acCMZUjQ8cxWtNSQWRjSFzrsS+zt4JB?=
 =?iso-8859-1?Q?4jNJjBb7VRUZAyMbe9OkpuMyW/PR9X7hjr0bWvKc/tn2yW5usGJa1mdpgd?=
 =?iso-8859-1?Q?B8noZkP2pI+jpqhOuX2LMzD2Fl1BrziyqoBfC3R4QmO386QMQvQi8awpGQ?=
 =?iso-8859-1?Q?/tyYFuaWrxl9azMD7nxs8xFAqcBRtXw6JAKNrjbqVW8CtDnKtdqr2xEU8G?=
 =?iso-8859-1?Q?Jf7OxycNMwmWXcQmD28ryfCenFWfpnWbTDwX71gzDLXANs28gtPhuqBmV0?=
 =?iso-8859-1?Q?lZrLgKXVT/C9AhPgY/mSBX2THSHz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jhv1e+LkRTohG4OgY6d2x5c9yVMh14JoQc4gCwwvk/cqFXVC/YQCoPrVaH?=
 =?iso-8859-1?Q?ew9Wij/BjVMvlCXfsBP+eF0qRKv41CjiDRee8MIo0bhc1kGPJetdjgKD/S?=
 =?iso-8859-1?Q?AADjlrPeBwX62LXYq/bSKFkJj59CZ3I9uhWh60kMQuqb8HqkPTplqtkZOs?=
 =?iso-8859-1?Q?HhyzdNU3tQQ1XPwQPj+s02BjmBjiEK9CARNm9DCX1mS4cgCbWrK4kowXma?=
 =?iso-8859-1?Q?JZYu+2UrK0gGAfYlSQCQOymgKLOQUOnGT/3/gvjZ58U3im8pU0A8Oud2Kv?=
 =?iso-8859-1?Q?GTI8AyUJm91RSrOmiRtROwQII0LwNUmKOOi712EBY3MLQqqJE3G0XwEjBu?=
 =?iso-8859-1?Q?H9IK47nv1wANLvlhHIncex930kIIw0Q8kzuohE+Lg8pFbeKdjJarQdSJ0R?=
 =?iso-8859-1?Q?F4HIQ/SjxliO9bmtq+tY8O7XBRQC2bfPVr5xNdwANrCiW1BxsPyA9shwBY?=
 =?iso-8859-1?Q?NtZGa1QxMHFF7VuANmUyLWFsr0SH3oDCP4NAc7zaBpMOCLmNz64xUt8z0I?=
 =?iso-8859-1?Q?T+XERdnXNF2ksfovyVOozYMrZ7n+x0DdUteHyfwA1CHhavmHjZPdC8H80O?=
 =?iso-8859-1?Q?FxMXsSuaBHZmy1oRy8NNKfb8ZYoeHXHgcdQ1opxI+mPxYOsMsxO6aJ474p?=
 =?iso-8859-1?Q?sX9Zci/Khi1gGz0Cc+585iJ0QebXWYr4S1IPmpCP9qB24Xy4wXTZ038gOM?=
 =?iso-8859-1?Q?Pf1cmE9W4ooNQRiQeiKJjgjP8C9SK9j3owsKQoF6DsrIQF39HGHDbx7D2X?=
 =?iso-8859-1?Q?4cW89hizUEEWIy+NroZXaL0//MX+9swBOR376HD7e5ZkhycOZvo2RpIxU8?=
 =?iso-8859-1?Q?6eahJ8EpZ6aB8+ddYqtflzeiTszCzUG6HJwLf8iExLgspVoUJoc5EnfbLs?=
 =?iso-8859-1?Q?CxcnV66m6CcYVwGQpc4s67oUt8EIFEaDQDd0UMhXnVjVGkGPksLwNr3dn1?=
 =?iso-8859-1?Q?FB6/mxUfXsceXGtLmWxPOg82ioooypN7iAgDL+ppV5YSrKYBdSzqxj1JDz?=
 =?iso-8859-1?Q?vchDeaLmrP+TiUgNis4/ddcM2x8OeYxOinwiF2ByG1gzhcSjGN2FhXuPer?=
 =?iso-8859-1?Q?/CeQR/i6oE+FBgxPEDK6cRyVlVzv8mp6GxBAaugVwDuMVBPA/blZVsPGRw?=
 =?iso-8859-1?Q?Ff9+TywqX9RQMufEVVoDO5wvUEuXbgfBux/tJReh+ZnXetFibtYmNgLuYF?=
 =?iso-8859-1?Q?RGm/KH5XiCu4n5Gi5g21clerT+5wl/MyKv2Pr8nDVI5j5lRw+PAwrl0OPi?=
 =?iso-8859-1?Q?QoeoeZkGJ04VHODN2MSkst1Jtd0XSwVhejkM7gLI7M/TXhv1h6p+vXpXmR?=
 =?iso-8859-1?Q?b9aYMgXMHcr+h2NlDENyKa/0EQDacSFVstZAr02tbrcZAhfYSDuV7JSv6K?=
 =?iso-8859-1?Q?B6gWn/kq+f+czqsJdFXgnQdpiWKgyZUVlXK34yPyxhKrau3y3FL702X2YV?=
 =?iso-8859-1?Q?eO4c8jGzzai5Oemufy3t3ODHjkRqA1T0K7w0k3oyQ01cnMCNGHK5Db6lgQ?=
 =?iso-8859-1?Q?RlhOt14EERPeKmj1y06scKZ5G6RYDFbhWE6wkveQG6q5x6xmbB9LtlvG5o?=
 =?iso-8859-1?Q?U8IWdUau4bkvpF36zfH7UOZnvUht1gRjiKODXKbIAlzIVT9Ox6hc5XljEy?=
 =?iso-8859-1?Q?9UeGKbagFFJRQrjddSRBYLhCow57H7kfBaJ3sudvqTrCUjcCoR2DD1tw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f3eccb-5058-4858-e5a4-08de210a8c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:10:31.7231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gzARLWYTJ+pLt3OgGLhqNi81lL4i/GC0z2lvsbk+V7py4MUBdJ5C1z1ZO+cEeK17ql1+yfYHOM6vBm3+LJu3epIlLOlfEAfqjhyoj0P60nZcfI6YQGvgh3p7It1oBNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB10090
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

Hi Quentin,=0A=
=0A=
> This series allows to sign a FIT image with mkimage (and binman) with=0A=
> only an OpenSSL engine and no key-dir. mkimage will read the=0A=
> key-name-hint property and pass that verbatim to the OpenSSL engine API=
=0A=
> via the key_id argument.=0A=
=0A=
Thanks for implementing this!=0A=
I was already looking for a way to implement this myself when I saw your=0A=
implementation on the mailing list.=0A=
=0A=
I have tested your patch series in our environment with our PKI provider.=
=0A=
Our PKI provider supports the OpenSSL engine API with a PKCS#11 library.=0A=
=0A=
Signing and verification with your patch series works fine in our use case.=
=0A=
=0A=
I only stumbled over a small issue, but that has nothing to with your patch=
=0A=
series:=0A=
Initially I used the same key-name-hint in the FIT description for=0A=
U-Boot proper (which is then used by mkimage for signing) and in the=0A=
description for U-Boot SPL (within an u-boot-spl-pubkey-dtb entry).=0A=
In my case key-name-hint contains a colon and several equation signs, it lo=
oks=0A=
something like this:=0A=
=0A=
    key-name-hint =3D "pkcs11:model=3Dxxx;manufacturer=3Dxxx;serial=3D1234;=
token=3Dxxx;id=3Dxxx;object=3Dxxx";=0A=
=0A=
But when I do this, I cannot decompile the final SPL devicetree any more.=
=0A=
Decompiling with dtc gives me a "Bad character '=3D' in node name" error th=
en.=0A=
As a workaround, I use a different key-name-hint in the SPL description now=
.=0A=
But as mentioned above, this is just something I found while testing your=
=0A=
patches, nothing caused by them.=0A=
=0A=
This series is useful for us, and I'm happy to assist with further testing =
and=0A=
review. I'm not sure if I can help with creating tests, but I will have a l=
ook=0A=
at the things Simon listed.=0A=
=0A=
Kind regards,=0A=
Wolfgang =0A=
