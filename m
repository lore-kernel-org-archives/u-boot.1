Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F210C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 04:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E477782B0F;
	Thu, 15 May 2025 06:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tAP/9WNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB1782B20; Thu, 15 May 2025 06:39:58 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2EF382AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1ZEbguBagKIwLN5btD2k8KnPsjL6PHkbjYdf2OySoLPg8/jFdaY1Ctya6dvUOkgHoRrNYgc4v9YHY1YPQ0D8tMHtnprCPyRh+57SDdj6uwpxsgmB/tpwkBqj707PCPaRGz6trxAhX/KVq79ip2EjaqiiK1wdqPPWHN6Xxl1LTwFoQoqBCfjjtyRlwtzqCwFjHct8qaSxXyyzsOCOlXZ7iOhkj9xg0YXha8jjInFLMpEzWKI7glsq2JZa6i1kDJJn2uNqIttW8ma/FnAmZ8EHePgpqAtHAJ7iH3veecqfy8hl3UK/eVi7KkJVwCxtkntveXe4izqKR9dEoFxo/7wzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTSGdQQUne8di1aVzL7ZCUW6+FusjOxGdlDJnxmP87o=;
 b=oFh6/Bo4T3bvBPw23Zrnt7JA/qnIowglsQBp9/UKFKTchLWV1qse2VFowsySigL6gp0x8qHFnXImt0eTxjGkx+EvQkRil/nmEiSjzvGRwkV1iqsj9sQ3D+EeeQI0rLVebnIkXi/x0lv/wbPahLVkO+svrBIGfB2Y0cJgw2bCcuVMN+vjhnMXM0/X54q4hTIXqPmwoSHJh1vNCsS/6o1GrUXAFd7nDKSHIi/y5Cl4bwNrvsUNMekPHx9f/HDFejuAYUEOZK8IP0J5Z2tenSrCP7nPRzLJAQ1mIWTmm3mLOUHsbRQYrC5QOU/3aW28lKzumNAZk5YAuTDWN5YRpiWRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTSGdQQUne8di1aVzL7ZCUW6+FusjOxGdlDJnxmP87o=;
 b=tAP/9WNACJ8t7C05XkHaIqR7g9sm8XxXVVBeMlgbStdkYzOYz5ZSKhhnLXx3sf3Z5tPVaNtCVMxz3tau6PnspJvpaYoo6LGlElzvCmHzWu3t/W0/VW+NIib7+1ljwFa+BVgL5oipqmUfxgUSNS8X9jC+OR6Cc//TqIgpc7oNXjjkUv2XGy5aH748qR+/0AGy2FYcZtPAkjHF9NwNAWnjwB4aZ5jcZQjpjE6JmZBjOZpBQqEDzC5p4u9UYEBlGKzdNq0LMmbMN95W0MJVsbc3EjER5SFA8AskB8xwBOYrk98rOYgX+ApFIxUO9TZgv7vjVMnP6H+6NkNjdenPwdoOCQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN5PR03MB8041.namprd03.prod.outlook.com (2603:10b6:408:2a8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 15 May
 2025 04:39:52 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 04:39:52 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: Yixun Lan <dlan@gentoo.org>
CC: "Meng, Tingting" <tingting.meng@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Thread-Topic: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
Thread-Index: AQHbsnv13tg2hI0F00OJ4bQ+0r6OBLOtqSdwgBQpNwCAEW9DkA==
Date: Thu, 15 May 2025 04:39:51 +0000
Message-ID: <LV8PR03MB8137AFC699016BB60F06C6B3A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250421051126.13799-1-tingting.meng@altera.com>
 <LV8PR03MB81376E5ED82217C31D926AEBA7B82@LV8PR03MB8137.namprd03.prod.outlook.com>
 <20250504022432-GYA457276@gentoo>
In-Reply-To: <20250504022432-GYA457276@gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BN5PR03MB8041:EE_
x-ms-office365-filtering-correlation-id: b52c2e57-e58c-46b9-2d4e-08dd936a885a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yMohx/n9c9j33EGJfJEK+ADHLrGT2+gdMyB9IwHRdnEDy1/Yh9kTqywhkRpv?=
 =?us-ascii?Q?KRugwlIXjmEz8Xy0S9J7+wAcYaU+BkahV9kjXZ3tShAkdvscYx/DUyDOmbQ0?=
 =?us-ascii?Q?qwZrSS2imM+xIUCStQF4az+P9/zRGVxNCNTDGCxSP30HomQ6gBpMShls+0ab?=
 =?us-ascii?Q?1VyfLB7y3PLWJMZ3euNkgZWfPHxjBEYpmbVMam9U8hEn/DhYwubPTaXYyyLe?=
 =?us-ascii?Q?KpjLCVDbkfNb6e+sICVv8F9ZgGSGYnNhgDMpYNEz055+OrAHwgMuKX9NM0Jn?=
 =?us-ascii?Q?+/7QMQ58MwMaFCPWYQFAY9Hp43NRAegYyW897oYmCPlkQaxARyLveMRGJa8G?=
 =?us-ascii?Q?W3kx9pHIDJ2Jdb0G7bWJ4Nmq0y3ujZUkk0Oyamsd9mOXpSdS/r8stP2FxVfm?=
 =?us-ascii?Q?h2pesl6NdMAc3y5u/oZps67o0uuiqNWyVxNTgbY0AA0SAHx6a9zlylYzTxyd?=
 =?us-ascii?Q?c76oCQQe1I8s26rg0+mM82OayEjeBGw1Zy9DNC4sSjPy5/I8xORI9KKBI8CJ?=
 =?us-ascii?Q?bKhZanrjk2OgbD3QwHtKtzMmPIaN9USk6npdU1+QeszxQuSoQcW6nqrG8Eo3?=
 =?us-ascii?Q?leJeZnLF4COnWNsu3jM3ndZCamQf3nYTh/d0JvU9dWfNBQND9VtITPn89Cyr?=
 =?us-ascii?Q?Mn9kZIg+v4rIcIkrXLL5LVuU15ellUiJkyGBntTIE6OcU/pmVEKHg3kF8afs?=
 =?us-ascii?Q?9A2l8pxrsy8/wPzGDbNd5a80PHB2rEyJX/p2KZ6zIXSX4XRhxxFw7ornBxmR?=
 =?us-ascii?Q?ZL2WFUOW+ya+6KzUqrghmiSkUwvMoWW1GrPdW7KOreUDGRp23VYw/FHKlgau?=
 =?us-ascii?Q?owxZt/dZdxTSzi9OjDYIET4Gy6CILydIiRBeBLMyM/EsKOVHHKfuWEmOOHa5?=
 =?us-ascii?Q?WvhSvHHMPDRPMhMN4v8tzHPiE6fQMh4UL8aNEsTYuROcgetgEs2QtOuDFv5E?=
 =?us-ascii?Q?dNtJ/6CWaIWS2d4Zep/AU+Qkw8Btpa84j195W3L6aMK+3LQv9w6BtAl711fw?=
 =?us-ascii?Q?J04wOHeOm4UXeE64tPITK20AJIrfKa2MPuPhak0O+ZbEm9n/lAub6J4T9V55?=
 =?us-ascii?Q?s77ZqSJW0S4II1N3QesINZ1XrOqWZ0FIz3AR3Y3SwHh/bb0MxY+bZ1RSSFp6?=
 =?us-ascii?Q?PcCtAJzPRYJPZKA25elufLZBHcqG4P5eRRaiIagd0SZESQ1MMGVvpUdQmQHb?=
 =?us-ascii?Q?c7QgcRltvpJ8fqF0fyg5r6/IXDgwR/+taauimAYz6DWlPnP5h7V/XX9zc62N?=
 =?us-ascii?Q?RwKTRGwhzUZjlYfYr8AfVEOeTaswkLeCVhb/Jb5wdYnIG43OR8PKS91viJvD?=
 =?us-ascii?Q?2lypuc0HXUk+dNGj9c/obyCAos0gHrafx3tPgB355wnXm0W5xiZiov6KqPrY?=
 =?us-ascii?Q?6nc6XE0mjt8pyNxKG8YvbsOclFcj9o0c1cVa0i5T8Ptw9++lKfElnv1/o5NT?=
 =?us-ascii?Q?ymdNBE/5L2upcoTXz2dpX44i08zb/yUUPUaiibyr6gsXMaxijrdLHQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gIB8jiUD327I+BIfSYZ7lxxOPJgrKgAaoG+kpMUYXl/toY4uuR/L7UtpVQU?=
 =?us-ascii?Q?ZqDo/p8TKjcjGRDnzbvPjytNvXPxFF5VcCN6EdnJI3XdZpKsR1N//Wrpf7Us?=
 =?us-ascii?Q?7Q7vr3MUZdtU9CiEcZYnFBMJK4eoBT2nwbJhfBK0xvQF2dx9RS/vygFbcmm7?=
 =?us-ascii?Q?MQJ3AF3aluiwY67rdHcApVqyS/bzfsANryocdzFAeoefk+Zj0uu61dWmtOSa?=
 =?us-ascii?Q?tTTL64qWFHa2Jlv6wgpoWtbbI6zdpZFkE2K2s02Y203AHyLEDwThA7QPUIxV?=
 =?us-ascii?Q?QnAbTTwVUKUCDPc43XK1IrkrGi6Dg07vxaGy8ApNvaJZ9rEY2MtojvR7Uv8d?=
 =?us-ascii?Q?wKF7eGymmWhFISGlylhG3zdTL6EL+lRZkq1erJYWDU7aoUKNgA5NfaHHio0y?=
 =?us-ascii?Q?Mr2pw3gVW78Pv/X5pkYAs5Zn3iygt0ofpUE9XwEk+A13PIinNAysbCNg8k2B?=
 =?us-ascii?Q?1ddV7F9pGyf1mj/yxA2ViFJ2A6W/334j8oZpSxJOkX9Pfe7SrFYZoesy/UbW?=
 =?us-ascii?Q?ET+lzWBo9sgQG4VKd1U+IFua9BvexD/GWXLfLwNhOPsj/ZApX5W2AZH16W2h?=
 =?us-ascii?Q?tnPTA/eifXY3pHrjnQ4FzxmF88dfES49DmgnVY8xylDytUKYTj68dBFTrC6G?=
 =?us-ascii?Q?IYcQpXpp8jkmIpLK42lc4xEBGJuiZeu5YXibnNUI7XXulNeMh+A3HDCqL5NC?=
 =?us-ascii?Q?tLrTgo7z/p3zbVqU1yyLA1WCdA2v4F//e9bHspll3Lh1V2oQXZXIzrpcjkco?=
 =?us-ascii?Q?0betLptBLIO8CnmrlCkiVWauWhluqffwC8xLa+CJMi1+TV1gMMqgrAb0zI4v?=
 =?us-ascii?Q?xX7oNQxklF4xYiHl1yzPloVkgm3PgqK8k6xSQL5BsSpIH/SH4VQg+STEAA8Q?=
 =?us-ascii?Q?N9bpIt76rdwlhmgBG4+BpByQYWK9j7AAIXK07hhXrV1QOjUkENMr1RkUYWdB?=
 =?us-ascii?Q?cGuj+QcxHQBXbejkd5U8th4k6mrOCJBfmXVkNziK2Sl0Ct6/F9fgq3NZHHCi?=
 =?us-ascii?Q?jJVfNJJBwTqcfy8Zu758S4dpIz4H0fRzCE7DozY7eqWpCxI9YfsqO9Ujs4E+?=
 =?us-ascii?Q?Utkul5FeHlBS/Rm7sysPhSrpHMIMLmlmQoDkdpjY1i7aFIBygjoK2gez5jn7?=
 =?us-ascii?Q?aPS24OHv85AhfmoN1S/usQuARa/NqAgJjDBN1MrxUJYsNe37r8VsqxRi4CrW?=
 =?us-ascii?Q?kiuqDzbK+9DbYubCPMac2Yf1814B22H2rlFE1dCSI5Ahr3KeFWc6Pk6EoHpV?=
 =?us-ascii?Q?xUywsY1pdxrh9bCZGAoy9ZriQnxvtpHVqToqBiPFVM+T9zO7mT6YYuqznLYm?=
 =?us-ascii?Q?/xe4MUnPqchiJ9f4kD2TI6tqptZxtdOa66c159ELfxOSAfgQFqYe6gEKgvjF?=
 =?us-ascii?Q?L9MVglLgVQO5FenAXNpInn1JT2HFddAzEkdxe/hpUsUB+O9Vb/YTWONgW3yc?=
 =?us-ascii?Q?+mPONsLZlKNqHvqueDPoUBDagZ/jK7BawUUNt/Mf6OglqF0k5hKXorpQnlEz?=
 =?us-ascii?Q?H75y37zdQxSERtb/saFPfLJ7pwQVHkNJuNBCG+29x6YkDkiEyu+oFy26QU3p?=
 =?us-ascii?Q?ORzJMwttXKKMmOJnb043OxwARaOqph6sgiSXWy6P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52c2e57-e58c-46b9-2d4e-08dd936a885a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 04:39:51.9672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUBINEpttHWX+jqew9nDN3fBoHNYkhpJl5J/5UKEQGrDbPCX5iXfjsQ8H/mPAJIj/bwkJIMVVvLkoAae9eiDclJznA9d3TlVq/pxr/55ezM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8041
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
> From: Yixun Lan <dlan@gentoo.org>
> Sent: Sunday, May 4, 2025 10:25 AM
> To: Chee, Tien Fong <tien.fong.chee@altera.com>
> Cc: Meng, Tingting <tingting.meng@altera.com>; u-boot@lists.denx.de;
> Marek Vasut <marex@denx.de>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish
> Ahmad <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: Re: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping region
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt
> email attempting to steal your information and/or compromise your
> computer.]
>=20
> On 06:32 Mon 21 Apr     , Chee, Tien Fong wrote:
> >
> >
> > > -----Original Message-----
> > > From: Meng, Tingting <tingting.meng@altera.com>
> > > Sent: Monday, April 21, 2025 1:11 PM
> > > To: u-boot@lists.denx.de
> > > Cc: Marek Vasut <marex@denx.de>; Chee, Tien Fong
> > > <tien.fong.chee@altera.com>; Meng, Tingting
> > > <tingting.meng@altera.com>; Hea, Kok Kiang
> > > <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> > > <dinesh.maniyam@altera.com>; Ng, Boon Khai
> > > <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> > > <alif.zakuan.yuslaimi@altera.com>; Rosdi, Danish Ahmad
> > > <danish.ahmad.rosdi@altera.com>; Zamri, Muhammad Hazim Izzat
> > > <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> > > <jit.loon.lim@altera.com>
> > > Subject: [PATCH v1 1/5] arm: socfpga: agilex5: Add MMU mapping
> > > region
> > >
> > > From: Tingting Meng <tingting.meng@altera.com>
> > >
> > > MMU mapping regions were added for the second and third DDR
> memory
> > > banks.
> > >
> > > Signed-off-by: Tingting Meng <tingting.meng@altera.com>
> > > ---
> > >  arch/arm/mach-socfpga/mmu-arm64_s10.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > [...]
> > Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
> >
> You can simply reply to cover letter to give all patches a Reviewed-by (N=
o
> need to do for each)
>=20
> and use tools like - b4 trailers to collect

Noted.

Best regards,
Tien Fong
