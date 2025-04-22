Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA96C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 19:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C391C80F9C;
	Tue, 22 Apr 2025 21:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="ocTaImIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05CDF810E8; Tue, 22 Apr 2025 20:36:26 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119EB80F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
 by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MI37mr020108
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:message-id:mime-version:subject:to; s=
 pps0720; bh=VMbncLorGC9YWVhXC1pMZ+lDJEZGsxDoRZuFyuL9ogs=; b=ocTa
 ImIJ+xpoNEfYK6j8suiEQ8YEXcitcTjiOXd/efd8JOiZ2nq81vKgQNIdT3pcnhOg
 yDHM0CULq81giYvlXwAMr4/kF/OJ4XfE9J7oeGG9dkv/covEZF4F0VxdWtob28PK
 QeBsrgpP5gi4P2DswtBsEuv4Wp+AbrgQrFxUNZpJ80IMkpTLdOdmggADzhXmgdwX
 SAaZeVktENIBH0sbqL1Iav6a4rja3uFpUnPtLj57oVMcfSB7DFSx0S0FmoK/5uWx
 l2xa1d7M2EqXoqt6rxpkiar9ilmOBDod7i4F51el35h28gMSYWWNk8xW6riwExSm
 8jSo9kXHpwTJ38QVDw==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
 by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4642ghg48y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:36:20 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 75685130BD
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 18:36:19 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 06:36:19 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 06:36:18 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Tue, 22 Apr 2025 06:36:18 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Apr 2025 06:36:18 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DidofYfi8ZQmOGrfyTyB4aoUmZponNn8KzTyheiBVwe276I3W25Gt4P1jJaoTPw2sbEvSXmZB5zY+WoPqpQMzzURYUSIEBB+/+F2M8RWdF+ylHwYUGCtCvQf0AniizN4IqD4MrsIvXTdsEOCf7Yjg0k8zPBBDjP/Y8h5jtCYgruO/eYKzK9DsEA27FWYIOLM4FhQbQzxRoYcsxkd7FxTwNWhf2v02IwWvHgtq+lbXN0z2ArLT7PAWIqy/yl76VK2OYPF2JzYh96lzOYe4GDpP/qleDluS9FntzxVXYBmarO1jlDKR0ags5MQKD7haNBVhx34crz3ns4M0MkN20ew1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMbncLorGC9YWVhXC1pMZ+lDJEZGsxDoRZuFyuL9ogs=;
 b=PmnT8UdpoBPv7d02XPxbkOluzJ4REVoSJxSxN5V8WGtn3CvYzDpRUx/3pB5A0pSA7A53oxZpffXPTxmgOe4C8Rh5Kzr0PrKzU+8Qa0JIme0E9unoIJ/bPj7yli+XpmKRPeL0W1aLEvpwUiyMSChgVAjnW2ZeOQywUZYi0DhVy3guIxlphbgfrECEhJHTfVVqBgBGckO8dcUMr74etQ+7O1927YCi77tMJYyrqF51Jtdh02gYKibWlD0fvYLuaS9qUajFvykmEJymcDiCym36RaCQAaLyAGcJDG8YUY5VA+F/iXAOJN3ohp8swjH68ScO9rEbJgvdZV9fsJDxUtXo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 MN0PR84MB3024.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:3cc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 18:36:15 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 18:36:15 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Wiznet w5500 support
Thread-Topic: Wiznet w5500 support
Thread-Index: AQHbs7P1niICEprfvUOJM72ihHrWUA==
Date: Tue, 22 Apr 2025 18:36:15 +0000
Message-ID: <DM4PR84MB1976607AFF39ADF74D9AAF7BD6BB2@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|MN0PR84MB3024:EE_
x-ms-office365-filtering-correlation-id: 6b48ed68-f380-4418-9ef5-08dd81cc90b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?zpWWFANc0SJZafQKE+VSRSWRlKsCLef0rsH7Wd1ufKkRYursFn3de8LE?=
 =?Windows-1252?Q?gn0+f4PFQvBGCeEJ6JOfXJ2uTVzh7Wzit+zDTfYIIHC7Id/8X/udXU+N?=
 =?Windows-1252?Q?Rdp8rWGqpCHD9tRPAV4bjiMY9UE/ghnj61dnQkAnthz3h5ANadNFsF+G?=
 =?Windows-1252?Q?jvBi92Ur8It9fXyAHbcriP6ulgzFA7DAuaNkY32mK49fDpIfgzqmjM6R?=
 =?Windows-1252?Q?RfQOtsAmaPj4nmRiB8Kn2GQEsLoprNFVan8iYDAGDf2PBMR2k4V5Biyk?=
 =?Windows-1252?Q?t1XdxergX2z+JFSUbNgBjkMZcK45xxwone0uHH1D8seX1lifjxLBPJ8W?=
 =?Windows-1252?Q?fSsdHMB8JQ3d7AeGjWZH5JV1CdzSGMCJFzuyz7mVTbq/nVvPTiPORuKD?=
 =?Windows-1252?Q?kE7ND6iE8BIRwouKpglfy5VOIOSdpGB9Q8f5PrfvlIoxLVyQW5HkcmFl?=
 =?Windows-1252?Q?EmkVNJkCfgssxKFou5UyNv4T+W5FQYo1GB+7ORBE1dqi6W+8Xqt60aiK?=
 =?Windows-1252?Q?P0E0YbiOu2kXKrqNe1iSkmHZFuMex1eGjPcJilgbudz3yo6LWzPe7W1Y?=
 =?Windows-1252?Q?7GehwFj4earVN9q4dTozp03xkziF/KLA4RwjOuHmGkGmLJzgRrcYokdA?=
 =?Windows-1252?Q?lkh23nfFjiloDy4dzb70VrpgrzOJdb5SEO22CIXcJazp3JTmFAQYdt7A?=
 =?Windows-1252?Q?ocvF4mzUqnOyOgNjlWpabZ3PIyHYG5GtaqkQt0AVtyJGfvSmIZhGjVFD?=
 =?Windows-1252?Q?HhfSSlqYwTxs9sYZinXdiJqHYgTKUOfOFEsNR1ObFRV9k554BeYKqjMo?=
 =?Windows-1252?Q?XMS9TR860/ceFUu9NjlX+HDu4TtraOm01pXIbiBMKAjoU6MwNdDpP5W7?=
 =?Windows-1252?Q?RY/YCEUsvRzx4qE9O581OLTHlqd66ZB0JgfvvfIoQjdAkYlxyKYF+sMn?=
 =?Windows-1252?Q?eXr+Dg93/fA/1SWCaig65MWIUIf1igS2augCRKRTAg91zwmkjmZVeToO?=
 =?Windows-1252?Q?agZH8y5X17uzSB0eUhf3WsshXAcaReqmpHi0auQoFmhl3QOcEFRLigsZ?=
 =?Windows-1252?Q?dvpC7smPViPtleMU5LgRYZpw3HUFkUd9i1vzaNJZC04o8xL4hEogPoIE?=
 =?Windows-1252?Q?rvcctiu6axjv3VB6uNrqMgk97+/Qe75qmQ3m9TkD0Bnw0mvlARdoZfmb?=
 =?Windows-1252?Q?iFOz3HFgTt5WbMVkICeiTzlUtTW33t3fWseIm8NyeGzFGeTv4H9df14i?=
 =?Windows-1252?Q?dqqE9tMN50VqLfOSDqOgjTX1J6e9SxxUdhPjcHX9BzBxK2nltgxiE/SO?=
 =?Windows-1252?Q?U1V3vEstmxoztLUW3YECgLHpcnfDTGTM47V9MFVjEPw+xXyDgmZXlo5r?=
 =?Windows-1252?Q?2hGAJTG8Afl5QWSQW4gFGhPaXb1zGd8mboFUb4yn2hOFGFAzlq79gVDG?=
 =?Windows-1252?Q?wfu7kpDc+5Jid9KJS3epaFGZ7xose2ZqAdRoQy73Ewiv+LJcJZTrY/qC?=
 =?Windows-1252?Q?Ix0Ag3sVyCRR6EEOSNCIwN3Mr9JlsgBaorsxb7fwFo1R7l/4zpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?jCkkoREyBRXp1Gb55FC6WWUbB6iGTbW+PKwdazS2chYOVIuP7y1UrFR2?=
 =?Windows-1252?Q?d76y30xnbj0bsK54B663NzjAHYyZKS139i0V595E60P7gwaOr86ob+ul?=
 =?Windows-1252?Q?E+/NBlx3IlN8BJo86j2Jk/7p1PJ97O/e4hxuWgfSuAKQHGt6vRzkbEoZ?=
 =?Windows-1252?Q?0UtHX/rjT1Qa84KdsIfNFXINj0nolNjHPwTpZPyyIOdnPJdx9mJOfWwK?=
 =?Windows-1252?Q?nm0uxLJb2hQjEJp8cfbYaJSE8KdcL98C9s8ZKbSD+A+EW8lT3qGO0zTA?=
 =?Windows-1252?Q?388i+XWK1eKaZ4eqFo9593gQLA389r5vbs1oXkgOmeTHRfpy9aogi5nG?=
 =?Windows-1252?Q?uY0Dg/vldM0qQLb3a/1WM5z3gSqtGJ2nBLEliSHDvYuT3oPyzK32JZBb?=
 =?Windows-1252?Q?iZ8VzOXUAdsuF4FTC0d7AAc2FaMijNFR+Vgb0tAMbjcLFX9/VFztJaWi?=
 =?Windows-1252?Q?2kvzb/wuAGG8rGVMbXJL+7qW58ctvJWVbTAZwS6Zzd6WNoDKe94o9E14?=
 =?Windows-1252?Q?yxpjduqZ4SZE/sMixN9/MgXfeUquRVGO+ihwr99FmuUBKhJNjw8EvJ5a?=
 =?Windows-1252?Q?3AqcNukqL91rAF9Stcvscs0u8yKt9eioCpyHbHSJyK1qii2iF7NJJ57+?=
 =?Windows-1252?Q?ppYA+ykjLKS3QB4YlyR70B/Yyomcpn9j+jAGj2uzGpa4IkBFQ6osJ2El?=
 =?Windows-1252?Q?doQLL7xr82PC/yLw/5ZZ6qjHImj7DYjf/6qnAgNyCFfbnQqdRMM5+65F?=
 =?Windows-1252?Q?4cVzDQ9qoYrikK24sfTKMmy+UOAGMnluYBNWSihFxkmCokSwzpbqSZPV?=
 =?Windows-1252?Q?Ug2o0n8UFRB+nbCsKDYGUa7a5E7JVm5+mvwPaoaLRPGfA/2IfTPSZ529?=
 =?Windows-1252?Q?VbqnHFkX6pkIGlhzK1H+l6PGFzHI+B6z+LVk+5VpcdgM5UlcjkfkeF51?=
 =?Windows-1252?Q?+PjHgx3rfzck9ZdGSNICfnX3xjgCVyK9fkC0Y+YAYEastLh+FoolShfP?=
 =?Windows-1252?Q?FPBep3HOw7p+fdtE+ODbo4UUj4To4FWe9n22mEjq8095mIgNdQ3G7giG?=
 =?Windows-1252?Q?gMYCTdswQb78RPDyIp4fbU0lIFlOtuC4Vlh9nNIWpIO3HcnK0Djduo5W?=
 =?Windows-1252?Q?kH0N5T7FlQbqARFKb/UrK+lsDkl4UIo6u74XKDDHwtfKdhKz9vD/HNHQ?=
 =?Windows-1252?Q?uu+ngUbvPciDprNHwkh2DglI2C0+sEtbn3fqnqcwBvbqGRMYJReP8ATv?=
 =?Windows-1252?Q?gfn5R2Ivjc6ChOLVItqyglvw0OfQZ7h1Ed6VjaNUbIO9WWeaIDomOdBy?=
 =?Windows-1252?Q?tMb+BBfo2AgEhOuHXP0QzjYpSHMqNAqxC+x3ZDY2EPEj1gfqNsQ0F7mw?=
 =?Windows-1252?Q?ESsg/VXxoxxCtM5hfpJyxqqe+UrXdFL8aUu/XSiJeUuzZDZTaPBItQht?=
 =?Windows-1252?Q?i1F6x/h0Hmv+ucEJmbgsGjDP7h81mPEL22XCF2soQ/gT5p53Y5a37jwS?=
 =?Windows-1252?Q?z1MnvKnjgrcQo4SHd2d/wk7cRUDC0D6utjMKSE5lQYudejEouiX0YtNS?=
 =?Windows-1252?Q?IaLVS6SoXgU24Hgw2fruB6dTimONC9SLmNjZz+b3FlJ+O4LEIYtt7CQe?=
 =?Windows-1252?Q?Bn3BmsyKVf2lzzi1ICX9VyQyTfiPDMLbiXXgntXj/YvTTFu13YyUatT6?=
 =?Windows-1252?Q?qx4XJ7Kmh+v50c5tg69Hnqo5JeGrZfYd?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b48ed68-f380-4418-9ef5-08dd81cc90b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 18:36:15.7561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGmIftqMZYFH5W9ncKzmMOq6aHzIQdEPHrE9dbSeqX19wQY5NwggPd8ZKOzBBEHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3024
X-OriginatorOrg: hpe.com
X-Authority-Analysis: v=2.4 cv=a4gw9VSF c=1 sm=1 tr=0 ts=6807e1a4 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=XR8D0OoHHMoA:10 a=eYv95HnKAAAA:8 a=NEAV23lmAAAA:8 a=wXsZwmCh3ulJF_Io-7wA:9
 a=pILNOxqGKmIA:10 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=gKO2Hq4RSVkA:10
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
 a=Fc7fxMuEZ4-5KipR1OOC:22
X-Proofpoint-GUID: _NNyNnVDBD2zDd_Lenue35iv2cCDaRGy
X-Proofpoint-ORIG-GUID: _NNyNnVDBD2zDd_Lenue35iv2cCDaRGy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_09,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220140
X-Mailman-Approved-At: Tue, 22 Apr 2025 21:41:40 +0200
Content-Type: text/plain; charset="Windows-1252"
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

Hi,

I have written a small patch for the wiznet W5500 adapter. (https://docs.wi=
znet.io/Product/iEthernet/W5500/overview).
I am in some ways ready to push it into u-boot following approval from HPE,=
 but as that will be a first for me, I just wanted to get feedback from you=
.

The wiznet device allows me to add a network adapter to deep embedded devic=
es like PCIe board and boot them by using ethernet through a spi bus or gpi=
os by using the soft-spi drivers through u-boot. Usually, such devices boot=
 locally through a spi-nor or other local storage. I want to promote a PXE =
like approach as to ease firmware updates, improve security, and boot speed=
. The wiznet device can load raw images at about 1.5MB/s in memory and the =
u-boot is in charge at bootstrapping the second stage through the in memory=
 copu.

I successfully tested it by using a raspberry pi 4 device through soft spi =
as we do not have a driver for it inside u-boot. It works at around 360kB/s=
 compared to 400kB/s through the linux kernel.

Wiznet device needs in fact 2 drivers, one which behave like =93PHY=94  and=
 one which is perceived as an ethernet adapter. Both needs to be linked thr=
ough a phandle as to use the relevant xfer function to push and receive the=
 data.

So, my patchset will contain some work for the spi subsystem and some for t=
he net subsystem. Do I need to break them down, or a single patch would be =
good enough ?

The code is inspired from the linux kernel implementation, but has been ada=
pted for the lack of interrupt management, and improved performances in seq=
uential mode as linux kernel support work queues.

If some of you wants to have a look, I published that work here before subm=
itting it

https://github.com/vejmarie/u-boot/tree/w5500

Let me know if you believe that support of wiznet inside u-boot would make =
sense, and if you have any questions

Jean-Marie
