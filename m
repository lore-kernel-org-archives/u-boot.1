Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58572E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D931F8952D;
	Thu,  5 Dec 2024 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hima.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=himagroup.onmicrosoft.com header.i=@himagroup.onmicrosoft.com header.b="copeAZyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E3689326; Thu,  5 Dec 2024 12:14:34 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB24288EFD
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 12:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hima.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Fabian.Koch@hima.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbELe2OeR8kVwLYDw08i3R4ALaCSvOFDbqLuKFFqyb1TGqJgXn96uWCjMv6Gge4392t2cWrgCINNhGanB4jMU+Q7+E13Hp3k+vGSYX0zNyPgZaXH2yl/ePkTstqujJiLz90YMTW4U7Sc+z6+YNWmomYsINavsobh9umb+QI/36SZPTYOaNcK4g1y+kba2m93UElQgF1lW+oWLP5DVINLhF4hr+Hfq38Hnx3Zl84JOsKiHiXO1t4ERC9CZ/VGMGW8jste1Pf522T7uk2lEWAP8cTNaX1qnFqXQRanh+WhpWIatyP+8LBASGLpiZl2prhOzigDTjTwWnxLyxgvTlO9Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NsnRkGuDLpoumdSXcCpgdcADDSLxSOKCtPSYfmRwOI=;
 b=Qjfju2zSRP1q2riHeK7DEBnw0imf/SBDK5i7VC47QaPuiIE++m3ac7RSFymE3Ag7/OA3aynZaXmQg24/UTfPBeq8nOKSorQ9j2B3QTsrxje0AEEWelQAICYu1Ga5VgSlGCzykWmqx2t0p3xEgSw/CgYrDfOCsrLwi4upfVqEyNyNq3TBKaOWBH+9K/hNJ9egAIEJWasWd/2YPE9PUPTw8tz8rYVP9nt0ZEmw3K1ri++uQdBMV/xEt7/6RCzp95B/Mco2gA81hY46qPxIgGhAw2jgxAvJq0qoX226ykAJ8depFc6XUCXetHnIjNtZCVLyZEA0+1dzcE13hPoxB8O/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hima.com; dmarc=pass action=none header.from=hima.com;
 dkim=pass header.d=hima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=himagroup.onmicrosoft.com; s=selector2-himagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NsnRkGuDLpoumdSXcCpgdcADDSLxSOKCtPSYfmRwOI=;
 b=copeAZyZJsPetTk5cFNSvDfC9pKmq7dIv5swicVBrhVjlTIAylVyCzbPjOTYOk/c1qELjZoSNREAho2GDzha0r9KpgLBJCGKeuW4PXmFQzNiUkohCyZkZ/5NXd2i4w5ja2SoBjiEcr55WbBY3Xm+Gg5TqxNnFriD5i74kTuGGMpNerKswWJJiJsAzwAvtOinF2aKT/24hNOmvSeum4Ci8dIe+f2X5YzGMTLyoHdWFAKWX316xrq2DmUVaNb47JCG2qeIt92rSfIioVKwKONK95E4kMAwSVqVNrHE+ctzSCpHHx6SsFIep7xDE1T/HGAigpGkNPseiocz2zCN237hMw==
Received: from AM6PR04MB5558.eurprd04.prod.outlook.com (2603:10a6:20b:9a::19)
 by GVXPR04MB10083.eurprd04.prod.outlook.com (2603:10a6:150:1b6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 11:14:27 +0000
Received: from AM6PR04MB5558.eurprd04.prod.outlook.com
 ([fe80::dc6a:4b90:d909:a75]) by AM6PR04MB5558.eurprd04.prod.outlook.com
 ([fe80::dc6a:4b90:d909:a75%6]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 11:14:27 +0000
From: "Koch, Fabian" <Fabian.Koch@hima.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: How would I do signature verification of standalone binary?
Thread-Topic: How would I do signature verification of standalone binary?
Thread-Index: AdtHA8KDiZPpCuekT+Kq+yJKEt5b+A==
Date: Thu, 5 Dec 2024 11:14:26 +0000
Message-ID: <AM6PR04MB55584A5EF725E8DF69629DF39A302@AM6PR04MB5558.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_ActionId=c2eb3231-9370-4d88-8671-0223bd0604da;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_ContentBits=0;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_Enabled=true;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_Method=Standard;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_Name=Internal;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_SetDate=2024-12-05T10:51:22Z;
 MSIP_Label_30b0d713-a5c0-44b2-81ea-002580e1d24c_SiteId=daa14706-6b65-4aec-b001-90a7bef6399d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5558:EE_|GVXPR04MB10083:EE_
x-ms-office365-filtering-correlation-id: 6d26e463-a2fb-423e-560f-08dd151dfb3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nyAK8+12JEY6Pl7yiaoSGKp6x3Zso2Ae3lR/rVBRFm4H5FrZVI2jb9AoSOu3?=
 =?us-ascii?Q?ujCWsacWMUugIThj5WFEci1qhz5wz76gK9nU5wgSHWxwia8BOsaDcnVVovzv?=
 =?us-ascii?Q?0m6P1FQrlfjN0QwtCQ0B1rY7JzdPAYegXGPrliO+tX6+qODxkjqeMB8XdbVn?=
 =?us-ascii?Q?QsiyiZS0vUdkff9MRieYOe53EPvlwXS5v2/Mu3JXfO3kD3OAwSxwCAXJ4AeI?=
 =?us-ascii?Q?juaFXNbEwdRxQfZH4pFTg2PMxcZSybRpMdYV4+h427BNX9ZEmLy9KT1Fy8GU?=
 =?us-ascii?Q?67LxDtNHpck+Mj/VXtznqUlc6ybAX6P7s36p/cbKvlpRsVFJIkKqGJktlDgo?=
 =?us-ascii?Q?ImqQvOQZTB5JsHQCKqrc6nuKu6EKnR5Nzt/gAhzMky1/o+hu15mOP9dIZIcG?=
 =?us-ascii?Q?A+xw0QYPQcpWqURsVRtm5RfAuiB8taSXEEKma2EeuaYXmIIQGywIvg6Il+cB?=
 =?us-ascii?Q?EtR9Q9GUkRz0sWUGhtJN40YpZplbqig+9vY9QjoGsfxF3VMBrbuj9vqGjeDZ?=
 =?us-ascii?Q?bwO96g87DMko64swLpgnC4lbF5w/4h3YUrZ6QFhLDDnkgauh6Kra7gBGy1Kd?=
 =?us-ascii?Q?fxTG/JL7TXH1XaNPxww2BAAqpuf275GXarUMzWGzUY6sAztiybOMuFQQ6G3v?=
 =?us-ascii?Q?WzNEom/RDf1d3C2+ve8BKkMEAf5/VwJUtIJPahrFd9kjJXVsesVUCyTEkHqF?=
 =?us-ascii?Q?Zh3ZZyHnhth3GSsq2oUA0cYj4yCRoyn6TV6Zkst9RfymfBgfti7JFsgYISrC?=
 =?us-ascii?Q?bAtE490wJcPPbOXUT/CXoj0VpjQuUaqr/6MlyIL9kuPfY+HEGxafNncov1Qx?=
 =?us-ascii?Q?Z5U0Yt59T7kGvAbiAx6P/OMsLof0rlOn/Xy4z3WBXorjNC6rCLYic+9PZZNu?=
 =?us-ascii?Q?IBndtNoHTjpnxOqsJ5CeyVqqU+9I7IHOkmh4iKlPwxFTvn3zY/N00/ehziQ1?=
 =?us-ascii?Q?7k9qDxDuRfRr/JaeKtEhAUhKwK7QbRm0MzGEERnUxoS1MuFG3lBZ6BN2WcgI?=
 =?us-ascii?Q?XaTqBW6v6UPkQQ/zvYGRWmUC7ia+XsTUg6P5srxchYPlWO9fI63eOlwPrS+4?=
 =?us-ascii?Q?B9s1oioR3BtjYC/J+z385sd0TblIHbB/iq6vpFKesWKWoAv8vxvpC7Jodvm4?=
 =?us-ascii?Q?YSr6+PLkqaUpQXox+Q17oiIasU8MqqXUV+/rvjTgq8WXhdbf38bkCGYW3a92?=
 =?us-ascii?Q?qBxyyQdH8Hc6J+N2+xDaVF80MulAbXx2ziI2E3701YCJ98adwQFkG/pzpPbi?=
 =?us-ascii?Q?Su3Wl/koCnSFgQ0670yq2DEwzxtUSBhJJ4OVXZW/O+BD4ZdO5nXEQp7VGAZc?=
 =?us-ascii?Q?FfJ5ob8ID3WhLj5TyN8ZnBuIb7tGeGZdwUAGD1eZtxtEbzPxp16MB7drO0wv?=
 =?us-ascii?Q?JV6qkGDzMbZOSwZNqorDPKgg2sj8qSpL+TtAfMrW+EoMrAGgow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5558.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v3CLVMNGfWmi0126nvwoBXd1XdqBZ09vQ5LP3PJBZom/s0pOjwI+3h/du9AB?=
 =?us-ascii?Q?IOx/Np7L1dHlyxrZpG6UR54d/STHqbsCU5YvX3ZCUeWCIEVod4eMxw7abg8+?=
 =?us-ascii?Q?CrVDFK8i/jMxATweX8i7f3KpdOHSXgudH4nWT1a3MIiiDiAPwyBE5+lydKaa?=
 =?us-ascii?Q?NlP/juRoQMCio6dCJSpCNxVeXGSFPbkn9ZRAuHhV7yMOXOHJJkp++BOOrs2y?=
 =?us-ascii?Q?6LJYtBs7IXkx4HNrrILOt23dtI2HpnVabkfjS3gt03Bm9WSivEJFi+ni4688?=
 =?us-ascii?Q?d1WO3kjQQZ+ZEAunOgrwvL8pmIErxdEvFZvO/wIUcNHgRgNAcc5YuPYWiEkz?=
 =?us-ascii?Q?PLzKUUnXOQF6a07dSD8jAAY3rjTkBGFrweLDDEet4euHIKcchsJGf10DdH7k?=
 =?us-ascii?Q?KScrQ9LZVeGa4EJ2yWEuSpZemGf8/NfgfKhpcgGHudaplMmclJ4dKvm9Euj5?=
 =?us-ascii?Q?TRCbZXQIG7W6J8HwaTtQC7N8g0SuXwclW4vQlPv+VMHcSdvoB8QrayQluRl3?=
 =?us-ascii?Q?zloIpAVMPVVP3GSvVyeFRVqEwiwhbaFNjP+kkxk3O7BNH6jLhyXxJ2y3AvKm?=
 =?us-ascii?Q?3pjABRa1kWl6LKZswq0H0b+T2FakDcWXYnCGmVVSR6lkc5svO5FM7S54/XfO?=
 =?us-ascii?Q?6vnZUipW/Sfl03XY+rfCw2D2bF+IN25Zu5cLN4ZXmzfXZdwQ/gejpiwuM2cX?=
 =?us-ascii?Q?2ozogZeWxELuT0H0oIljEcd1gfWy9wl/pwMM8MzgPtcG7vi14hkxPwiSlV1g?=
 =?us-ascii?Q?Z712zpxV+GOEHgYN/0UG7TcitmL0VY8dqkKO73HNin01leZ2Ao+AmdYq2+3v?=
 =?us-ascii?Q?FKEgLu1u++RHm1tsRJVL7Tv3/1D0BIXOtyEVnW1Zv2rMuLxjMngfSs1ZR+Tw?=
 =?us-ascii?Q?QbVlpeqYRGEeQM4kJhZtuGlhedNRKHLUt780jPFCuhEgCi8U+Spe7BOnwL6M?=
 =?us-ascii?Q?CZHXnS7dWEpsWMdpRxG+koaI64iPMNXzpaZoq1NcDYuuQ+ABy+1l9pfYayLS?=
 =?us-ascii?Q?ojuTHejrj2UDLXUoaeltOvvsaGxDKn8sFKPaR0wEH/dkGRoFG6KWT8r9uBKU?=
 =?us-ascii?Q?IPlko2MzUn/1ypvLHPPNlIVAi33cjhsrBTR2XYj9/YAYCZ5axTFkQv9d/FBf?=
 =?us-ascii?Q?bH9ObTY3jE1i6Iq/+8X4DnojOoBmiOE5l06C9EZy+mACsaMvfD+czAnu46+0?=
 =?us-ascii?Q?pv/gYKW23+Oz1l78bUsSjrXfzYP64JGuR5ffAmf7h+oMOYaWxmhbgk345ejr?=
 =?us-ascii?Q?VqQEl55H8gm2NrS0+5vEMk5mWG4xvYHggjl8iYsxX23OCLKFcCNGC+WdXR5x?=
 =?us-ascii?Q?jVj6fV7ZIM1h30AODk+6K0LAjnSCcTz/lalb2ACW+W5+KHdVxgY2nF3mknfa?=
 =?us-ascii?Q?BCIq95K+lhAOLPcdoguMEY3GyrG8DH6DgLFutZWHFWdtceQg4mEOmFBSZWMv?=
 =?us-ascii?Q?3pvTd9I6JIoUPLHZFM8GANjeBnK4Wb2FO9BN6tJJcvPocnu9IO+kjfwLndAo?=
 =?us-ascii?Q?1OMLOq1etJ6TNKrRbeZcswlNVz5Epfjs2syLDSnWeIUF+x/kehcDkWyFuvlm?=
 =?us-ascii?Q?mbrqTWDKqHx1J8QNizMQVTKAzNFMsXda6YlFb/kN?=
MIME-Version: 1.0
X-OriginatorOrg: hima.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5558.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d26e463-a2fb-423e-560f-08dd151dfb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 11:14:26.9623 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: daa14706-6b65-4aec-b001-90a7bef6399d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+ieEmhNwGX5DqII0Wad/UhcdePurK4EWje7Kg9MTU5LJSzcqsc47Jwfpirv3qtvRT0WuTZMZmyRMXKVXCJPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10083
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey all,

I have a SoC which does secure boot in a multi staged process.
(ROM loads a signed SPL to an aux core, which loads another signed SPL to m=
ain core, which loads a signed u-boot.img)

But the thing I want u-boot to load, verify signature and then run/boot is =
a standalone binary app, not a Linux Kernel.
(It does work fine when I load that and run it with the "go" command, but n=
o signature verification is done as of now)

All the research I did pointed towards using signed FIT images and then "bo=
otm" to do the verification and loading.
But I cannot get "bootm" to load a FIT containing only my raw binary standa=
lone app.

Is that road a dead-end and I need to do something completely else?

I would love to stay as close to vanilla u-boot (or at least the SDK vanill=
a version) and not implement a fully custom signature verification.

Any pointers would be highly appreciated.

kind regards
Fabian

Informationspflicht nach Art. 13 und 14 DS-GVO: https://www.hima.com/de/inf=
ormationen-DSGVO Information obligation according to Art. 13 and 14 DS-GVO:=
 https://www.hima.com/en/information-GDPR

HIMA Paul Hildebrandt GmbH, Albert-Bassermann-Str. 28, 68782 Bruehl bei Man=
nheim
Gesellschaft mit beschraenkter Haftung, Sitz Bruehl, Deutschland - Register=
gericht Mannheim HRB 720409
USt-ID: DE 144286400
WEEE-Reg.-Nr.: DE87326515

Geschaeftsfuehrender Gesellschafter: Steffen Philipp, Geschaeftsfuehrer: Jo=
erg de la Motte (Vorsitz), Dr. Michael Loebig

Diese Nachricht und saemtliche Anhaenge sind vertraulich und duerfen nicht =
an Dritte weitergeleitet oder sonst veroeffentlicht werden, soweit nicht au=
sdruecklich etwas anderes bestimmt ist. Falls Sie nicht der beabsichtigte E=
mpfaenger sind, bitten wir Sie, mit dem Absender Kontakt aufzunehmen und di=
ese Nachricht und saemtliche Anhaenge von Ihrem System zu loeschen. Auch in=
 diesem Fall sind Sie weder berechtigt, diese Nachricht oder etwaige Anhaen=
ge zu kopieren noch deren Inhalt einem Dritten zugaenglich zu machen.

This message and its attachments are confidential and can contain privilege=
d information which may not be distributed or published, unless expressly s=
tated otherwise. If you are not the intended recipient, please notify us im=
mediately and delete this email and its attachments. If you have received t=
his communication in error, you are hereby notified that any dissemination,=
 distribution or copying of this communication is strictly prohibited.
