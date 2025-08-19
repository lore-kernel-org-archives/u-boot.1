Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E008CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201A082D21;
	Tue, 19 Aug 2025 11:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uo7IUoFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D73A82E05; Tue, 19 Aug 2025 10:36:39 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6196D80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6E1/4CmG3Z//OLVRlO00kpYwxpXWgmC8p1A+y3GCPbXxS23RqYdzJjSS44mUaDYk/ZJ02ZjDA4U+6jZwu1/Erpfyhmp7sxj+ZpasUfsuAnfoMKZYul/OnsnmYLRNutNSF+Isk9Le73Bre9hzXBTgcPnKGLr8r4WwJHrW4pej/VYhjhNK0mDOO5Z/Dv6L99SVArl6k1WJN+sNmm0KW7OCqYcVOLRx7HmQQ2o2nwRQGO9P+QbFeONVjQgcR2frylCejW4qDRwuW4lPyjN+IA/qlhBIE8Ywvg90DiNE39gry4u28Px/lR74nNCIm6UvgRWnsXFvGFk6BdNLLruxo4KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AdHPhGDNGko8/gQDA1tSVNQxjzycFHHnOpJ3559k+A=;
 b=mbBSn27xC+lZXclw/x90SI6nSyLVQvlN0oIhdF0Pdt8tQ6Q4NqGGXXH2Ewm6jNRbSs3gae4VAVwD8EaPgCdSgI3Ehb7F4VkFUx7l/uAn3ZgwyxFM4IjSIfxb667nFCQ8MoDxHNRUqfw0tBI3K+32qKs1tOTYRBrLAwoqQxLj7tE8g1Ww4hDp5U0qYZeh13naUUU8cMaTjaEZXd6k1b1pKoW8t8b7N3V39RrtqDx/YtxrGMCrX2A4E52MBeJEjUK8M1nteDGsarC0KsGspa/W5Btms4UTAk/RIkdwA0p9OkbwBThB9uffvbrGy0uX0Zd8L21eeI/2O7fqQYIu0J6rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AdHPhGDNGko8/gQDA1tSVNQxjzycFHHnOpJ3559k+A=;
 b=uo7IUoFlloExdvImriRz7rFVqa+GTvxR5GDZpAWiQWBd5DyftIZfmjufR8EN47SuMLyyp/EdoPdWQMsrzsu4EylxE2dbA2+NlmQRRZsQr9lDZBdezisWCwpxX0DzJOx7IM4XwxZ1mMW75DH7oe3ekd5FWYHOmoDrSGD3vAEl89L5nIHKJqScoCfbLR8GAGY7JYUb/3c4aNTKq4uF6BBRsw0u583hos39qDTdSFaraHtOxbd/48ngospT9doQT1odiMHyPLH4F+Mzql1dBgP5EDNrjJ/PZ2UucoBsSwTBG5Amm0fT5O1gm5yZZBqoN+RXOajSMOW0oSeZqfzpfajT+g==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA3PR03MB7442.namprd03.prod.outlook.com (2603:10b6:806:39f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 08:36:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 08:36:32 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v2] mtd: nand: cadence: Fix device assignment to avoid
 warm reset issue
Thread-Topic: [PATCH v2] mtd: nand: cadence: Fix device assignment to avoid
 warm reset issue
Thread-Index: AQHcENk8zXAoFv+HWkaVb+kFMfxo07Rpo2eAgAABVYCAAAIS8A==
Date: Tue, 19 Aug 2025 08:36:32 +0000
Message-ID: <PH7PR03MB6942AFBAE5A7BBB90BEB4D15F730A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250819071636.25197-1-dinesh.maniyam@altera.com>
 <CAOf5uwn_ne64ydAOCvYe-=-FJgk+mXxMF1+m=J65=C_ByHN6YA@mail.gmail.com>
 <CAOf5uwmu+0_qeYV=40-SObiFshhp5K7OVzQv5=uPSmAG_R76kg@mail.gmail.com>
In-Reply-To: <CAOf5uwmu+0_qeYV=40-SObiFshhp5K7OVzQv5=uPSmAG_R76kg@mail.gmail.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|SA3PR03MB7442:EE_
x-ms-office365-filtering-correlation-id: 637e8e77-fe97-495a-3d48-08dddefb8056
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700018|7053199007|8096899003|13003099007;
x-microsoft-antispam-message-info: =?utf-8?B?UGpTMjBISjhGdHkyUCs1d3FNWEhjUFhic2krdnh4a1IzSmdZTTBlZTVxWmJX?=
 =?utf-8?B?cDhwWXJTVUNLS2FsRFJSdCtUT1E4WFpsR0s0YmRYalFQQTlDL1JLK3ZJOWZs?=
 =?utf-8?B?c05CaTlJZnJpS1N4ZUdGZnBlNlBIckluK3NiM0NMYzZVVmdDL3laUjBnYUZK?=
 =?utf-8?B?SThYcHlyY0FOVjlaUHRnNjIvNVdWVW1xeXByRXd0T21URVM3dTlmQlNnY3Zx?=
 =?utf-8?B?dHV5aU9ZbEV2ZmF3Tld2M1g1SUwrY2FvWC9yL1krcjlkSzl1OWszOXIvWExn?=
 =?utf-8?B?SFlaSjVHTXdVZVdqKzRpUnVCSnk5M1BuUmNJS05vNEtPUkRIZ2ZVbDZBUlI4?=
 =?utf-8?B?ejJpR1ZodmxlbWNqQXBTTzBDdXorbTEwV3R1TWZOT0xpWUltNExJVGpEVHNQ?=
 =?utf-8?B?KzNwNzd2emtUSG1PakdLQjU5c3pOWmJxMEhhZm42WGlvVW1zZWc0R1VIVXFO?=
 =?utf-8?B?WGtHRStXeVIxTGpPckE4Zk8rN2cvaFZZdWFaOHJqTGcrMGZYM2txNGxudGNm?=
 =?utf-8?B?WjBPSGl6Mm9hQi9ESVRiK1Nab3YwczFONDJNZDVaMk5tY0JUeG5Qai8rOXI2?=
 =?utf-8?B?VDQ4bmRFVGRabS9IdXBVM1VxS2g5TWtxK2RuQXFrcEhMZHNqVlRZd21CeGZj?=
 =?utf-8?B?YmxTWi9rZm1lN1ovUFBKUHNrbitMTm9RSjdlZlRPVVBwUlVNZVYyVzNhYjBB?=
 =?utf-8?B?RHJ1cjU0RC8xTi9tSlM1VHUvcmtka000czkvREhEcHhNMlJKMnN2ODhCYTJY?=
 =?utf-8?B?ZUpjZFJRZGpmZjAyK1pwQnB0WlRtTFBpMGh6SFlNdWJQSWI3RjhWNUJCcE94?=
 =?utf-8?B?WDZzQVYwUVA5bHBzcmpMQWZtb2JnNUpHZ0oxS3E5SmlSdDZhUGF2akh5QWFW?=
 =?utf-8?B?MFg4cFBkYTVnSEt6eFlKelhkUGRXb2J1VzBFa3ZBaFE0V1g5R1dYdU9ERzNu?=
 =?utf-8?B?R0xiRUdITTM2ZDMwMlpFQzlmVlMrVEtKZ21vQ2JnTHRiUUhDRk1WL2FiYXpU?=
 =?utf-8?B?aUhCUjdtWkxjRHJoWHZkdElFbytHdjNhUkkzdjFzSGtUSThNejJWeTVTdzZC?=
 =?utf-8?B?Q1BIdS9jdmplbGpMdWN6UG5icWpDRGNONXVPVkgrVHMwZWJla3dmYm9ORVU3?=
 =?utf-8?B?VGI4T0hFWXc5RVArRFZKQkFwcmU5VEVtclVBZnhiYm5qTXdUVXhzTkd4Mkxq?=
 =?utf-8?B?b010MDFZbVRSMlVBNDRuclJoYmltbGVCdGV0UElMR050T2JxT2EzY0lRS1lJ?=
 =?utf-8?B?YXMxN2syRlpqb0VDWHVNY2swOE44bnpZZmR5QjFWYkIzYzliSHQ0QmluUlQ1?=
 =?utf-8?B?cnhKN2ZmUjJSWWhMakVrQ3liNFRjL0psMDgwUzIyMUkxaHg0OEJnWjJEOG5P?=
 =?utf-8?B?YXVvRWE1RmhRMDNhdG5ma09kbDFBVFhwL3V4ZDFsaFZXS2hhS0MrMW0vWjBp?=
 =?utf-8?B?TkoyRUtHdEZuWUNPNEJ1SUJaVDFIakcvU1ZYQjRDeGYvdCtIdmVpTU5SbXNh?=
 =?utf-8?B?Qk5CcisvZENUd1d5d2lxSUYzN2x1MUdEY2ZheTBMSFpDZ0FXbEMyZGFDb1BB?=
 =?utf-8?B?SFpFeFVwUnFVUG5XbHFaUTdoS2U3ZlRsbjc2T0IrbGpOQ3BrUnpBUlY1RzNB?=
 =?utf-8?B?OWtxVy8reWxoenlKQjRPak8rNy9HaG9MbjJDTUl4NlF0RElrcktza0pLS0hu?=
 =?utf-8?B?SWR1UTJrREt5WWgvY2U4TTRTOG00YlhFejQ5UmcyZG1IbHNZZDR5V2lIYWM1?=
 =?utf-8?B?bnBKWnNHcWZCU1lTV2dyYVlvTG5aRE9WTkJzay9aeFJPbHNaVWFCUi9HT3RX?=
 =?utf-8?B?cjJGWmpLbkpObFI0TkkrZG9WcmZuSHNUUFhGWms0cVFGN01vUks5c2lSYlRR?=
 =?utf-8?B?SFE0VFRuV0NmMGNiUnZmRWE1N0sxT2k4QmZycDdjc0VxU3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018)(7053199007)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0pqVDVqeURIb3pBWVpld0tCeUtrWmZ4a1ZFQ2IyZEVxbXB0WFp6UkZiczVR?=
 =?utf-8?B?MWtMd1JLeG5DOW52blJBdDdlNkJOQ2pmVFd2OXZwZklYQkZrT0g2ckVTMWNr?=
 =?utf-8?B?UEtYa2kvVHJnd3hjUEF5a0NFOVRrSWVUaERaeld4VVNjRFBnTDBTeWV2bktL?=
 =?utf-8?B?U28wRlBPUXV2NlBHRlF1YmtPSTh2c2k0MGZXSTU4ajE5cmtINmlYUVI3Slpt?=
 =?utf-8?B?WHp2YXBpaFJKTW9LOFFrZThrb3lpY2wyS1RMMWh5NkpMQXVmSTI1YnU2ZTZ0?=
 =?utf-8?B?N0hLM3hPeE9ldnZYN3JqN2E4OUlEdndzQ0NyRzZWUEVFZ2lENWRoT2tiNjZ0?=
 =?utf-8?B?Vzd0alkzNWlBTmlUQUh0V3d1bG56VHJ0cEdvVHhDbmFPYUE0UjJmdittM2kz?=
 =?utf-8?B?cTZ4ZHZJTDhRajJOa1JsK0c5c2lQTU9vWmdTT1h3eVp3VVJBUzdQNnlYaGh1?=
 =?utf-8?B?SHY5ZmV1bG9tVmN6L1VuMGR0SUF5T1ZSUW85UkdSV0J3ZjBleHZTQ0wwWTV5?=
 =?utf-8?B?dW1YQUEyREsyYVNwd3ZoNEg4R284QUY4OGx0VmptZGNzNW14Vmt4dk5mOTM1?=
 =?utf-8?B?YThxVm03d21YaTNLNnk5NXhBMC9MR2FBb0QxRzhXZURXSlVlSzljdldhZXBO?=
 =?utf-8?B?VW0wVHZiZzFwNjJYVFQ2bU1YTytiSXpldVFEYlIzMGgvaHBIN3phRDhDcktk?=
 =?utf-8?B?ZUJ5MGFKTGdnSzF5R3QrYUtvTWxLN0UyMjJ4TnhqbUYyMVEzUmp0NGJOS2xH?=
 =?utf-8?B?L1FDWlNHMk9IRHJXWUprNUtoUlUyUXYwTlpTU2FHT3MveWl1WjE0YzZobzc5?=
 =?utf-8?B?NG14OHByaVQxdWc4ZHdjU2hMTjVtNWd0N2JOOXYrTllZazFrRjNuUEZlZUVp?=
 =?utf-8?B?dW5SWWhickhLQmJxeS9McWhwV09pbW1pZFExVEx2bTZ3bmVwYlhlRlJiekY2?=
 =?utf-8?B?THdSZ2hja0M1cTFFTVd2VFZTSzVrOGUvYUZOTmk5WVQzaVBFWmVEcHhWV3Ez?=
 =?utf-8?B?R2NWNWVsZlhxeVluaE83bnlLdjdsc3h1clBPbXU5ckFMZmxtTUI3dmNkUXBu?=
 =?utf-8?B?VjRGZHFSamVsZUtIVVo1dnEwN0JNM2xpbDVyMjlDd2RGV2Z5c0o4QldadXpM?=
 =?utf-8?B?OEdjMitSZytBYTFBRWVEMFFrTlQwemdHYjA1UkxHaVpkazRPbUV5ZnZ3T0dz?=
 =?utf-8?B?VGpSK01TVXp2djVUa21YR2NtcnU3SVVNUFlpRktzb2NuTEl0YjJITW1ORlln?=
 =?utf-8?B?TkRMOTRndFFWSHREaURFSjF0emFkVitXaFc5NEw1UjMyZW5lU2duczk1UGZC?=
 =?utf-8?B?djhndlMwbzNGbEVRdnhZWVo4R2hFZ3RTLzZQM0lQdVh3S1pGR0liTlludHh4?=
 =?utf-8?B?QTRRRDRuVURtWkw2Nk5leWFVMzJzZG9kWldqeXhyVVRkYjdCOXI4OW4xa2Yx?=
 =?utf-8?B?QmVVYXNjcFQ5dWgrS000NDdPRFZPeDg4Ujh1U0taVWJTa3dQdHJ4azFMNmRx?=
 =?utf-8?B?aDJxc3RZS1ZmVTRTVWJIcjdFbnRXMExPK3dvUUFXOTRyeGRFY2diZVJoL2NZ?=
 =?utf-8?B?cnpOSFBxZ1doTy8wQnhFK1o1b3FmWm1tOUxLZzQvY0hMOUpLbHBiZHJMYUp3?=
 =?utf-8?B?S091aFhPRGNFWnJDSE9maVEzSURXQ054MG9ueEJmNGdrdURvMDNuVTF3RHpB?=
 =?utf-8?B?OVFWWVpkSVdMOVluTXNieEdSMjRQWElBYUJmc3Uzam82YkduaTZOejNmUVFC?=
 =?utf-8?B?NS90eU1FWmYrem02MWswVnQvdThYTUtUT29wYzlqSWxDMWxmdFdmU05aV2h1?=
 =?utf-8?B?dWRJcGthL0JpK1VxWSttM2k0QTFwMHB1N1EweHJCVFhLTEswbTZPWUFobVMv?=
 =?utf-8?B?RllYTWZnQjRNWks1YzhuSjM0OWVodEIycDEzMmlHM0wrbTc4NGJaeEVpOWdu?=
 =?utf-8?B?SDVXRFZHeDNDNUk4enJwbWhRbDlScnkyNW1YZlVNSi8vMlliek1MN3hiMjZY?=
 =?utf-8?B?OWsyeGxmV29CZWV3S3VRWG9lTm13VnF0YUwvNU03a3VKd1pVRG1YUU4vZ0dG?=
 =?utf-8?B?WEFvWTd4RnliQjBLK0toZ0N2bTFrQW01YW43eEhWZ1pXSTN1T01hNFdDelg3?=
 =?utf-8?B?OVB1T2RpUDV1eVpiQ2xETXdkTEhHRitkWFVWTWxZVWNzY3NPRytNSThhaWVY?=
 =?utf-8?Q?wGs3/fU7Bn2s41MHuoWQheFlW8AgyC/lNL+LvWetQwdW?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637e8e77-fe97-495a-3d48-08dddefb8056
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:36:32.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /841UWhuuNi2UlKlHA87iw9uxy9iFbkjaz9ikKFaLekKL0ObEB1EYjWoxdDqukYv/Vo9eE/jmXBTqIZf1iEgiPgn/NLq9FS4vjfTcoKnShc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7442
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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

DQoNCkZyb206IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxhc29s
dXRpb25zLmNvbT4NClNlbnQ6IFR1ZXNkYXksIDE5IEF1Z3VzdCAyMDI1IDQ6MjggcG0NClRvOiBN
YW5peWFtLCBEaW5lc2ggPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQpDYzogdS1ib290QGxp
c3RzLmRlbnguZGU7IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24gPHNpbW9uLmsuci5nb2xk
c2NobWlkdEBnbWFpbC5jb20+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IFRvbSBS
aW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbyBCaW5hY2NoaSA8ZGFyaW8uYmluYWNjaGlA
YW1hcnVsYXNvbHV0aW9ucy5jb20+OyBDaGVlLCBUaWVuIEZvbmcgPHRpZW4uZm9uZy5jaGVlQGFs
dGVyYS5jb20+OyBIZWEsIEtvayBLaWFuZyA8a29rLmtpYW5nLmhlYUBhbHRlcmEuY29tPjsgTmcs
IEJvb24gS2hhaSA8Ym9vbi5raGFpLm5nQGFsdGVyYS5jb20+OyBZdXNsYWltaSwgQWxpZiBaYWt1
YW4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+OyBMaW0sIEppdCBMb29uIDxqaXQu
bG9vbi5saW1AYWx0ZXJhLmNvbT47IERpbmVzaCBNYW5peWFtIDxkaW5lc2gubWFuaXlhbUBpbnRl
bC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBtdGQ6IG5hbmQ6IGNhZGVuY2U6IEZpeCBk
ZXZpY2UgYXNzaWdubWVudCB0byBhdm9pZCB3YXJtIHJlc2V0IGlzc3VlDQoNCg0KW0NBVVRJT046
IFRoaXMgZW1haWwgaXMgZnJvbSBvdXRzaWRlIHlvdXIgb3JnYW5pemF0aW9uLiBVbmxlc3MgeW91
IHRydXN0IHRoZSBzZW5kZXIsIGRvIG5vdCBjbGljayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIGFzIGl0IG1heSBiZSBhIGZyYXVkdWxlbnQgZW1haWwgYXR0ZW1wdGluZyB0byBzdGVhbCB5
b3VyIGluZm9ybWF0aW9uIGFuZC9vciBjb21wcm9taXNlIHlvdXIgY29tcHV0ZXIuXQ0KSGkgRGlu
ZXNoDQoNClBsZWFzZSBhZGp1c3QgeW91ciBzaWduYXR1cmUgc2VlbXMgdGhhdCBpbnRlbC5jb208
aHR0cDovL2ludGVsLmNvbT4gZG9tYWluIGlzIG5vdCB2YWxpZA0KDQpNaWNoYWVsDQoNCkhpLA0K
DQpTdWJtaXR0ZWQgdjMuIFNpZ25hdHVyZSBhZGp1c3RlZC4NCg0KVGhhbmtzIQ0KDQpPbiBUdWUs
IEF1ZyAxOSwgMjAyNSBhdCAxMDoyM+KAr0FNIE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaSA8
bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbTxtYWlsdG86bWljaGFlbEBhbWFydWxhc29sdXRp
b25zLmNvbT4+IHdyb3RlOg0KDQoNCk9uIFR1ZSwgQXVnIDE5LCAyMDI1IGF0IDk6MTbigK9BTSA8
ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbTxtYWlsdG86ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNv
bT4+IHdyb3RlOg0KRnJvbTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGludGVsLmNv
bTxtYWlsdG86ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPj4NCg0KVGhlIGRyaXZlciBjdXJyZW50
bHkgZG9lczoNCiAgICBtdGQtPmRldi0+cGFyZW50ID0gY2FkZW5jZS0+ZGV2Ow0KDQpUaGlzIHdv
cmtzIGluIExpbnV4IGJlY2F1c2UgYHN0cnVjdCBtdGRfaW5mb2AgZW1iZWRzIGEgYHN0cnVjdCBk
ZXZpY2VgLA0Kc28gYG10ZC0+ZGV2YCBpcyBhbHdheXMgdmFsaWQgYW5kIGl0cyBgLnBhcmVudGAg
Y2FuIGJlIHNldC4NCg0KSW4gVS1Cb290LCBob3dldmVyLCBgbXRkLT5kZXZgIGlzIG9ubHkgYSBw
b2ludGVyIHRvIGEgYHN0cnVjdCB1ZGV2aWNlYC4NCkRlcmVmZXJlbmNpbmcgaXQgYmVmb3JlIGFz
c2lnbm1lbnQgaXMgaW52YWxpZCwgd2hpY2ggYnJlYWtzIHRoZSBkZXZpY2UNCmhpZXJhcmNoeS4g
QXMgYSByZXN1bHQsIGNvbnN1bWVycyByZWx5aW5nIG9uIGBtdGQtPmRldmAgKGUuZy4gcGFydGl0
aW9uDQpwYXJzZXIsIHJlc2V0IGFuZCByZS1pbml0IHBhdGhzKSBvcGVyYXRlIG9uIGEgZGFuZ2xp
bmcgcG9pbnRlci4gVGhpcw0KbGVhZHMgdG8gZmFpbHVyZXMgZHVyaW5nIHdhcm0gcmVzZXQgd2hl
biB0aGUgTkFORCBkZXZpY2UgaXMgYWNjZXNzZWQNCmFnYWluLg0KDQpGaXggYnkgYXNzaWduaW5n
IHRoZSBkZXZpY2UgcG9pbnRlciBkaXJlY3RseToNCiAgICBtdGQtPmRldiA9IGNhZGVuY2UtPmRl
djsNCg0KVGhpcyBtYXRjaGVzIFUtQm9vdOKAmXMgZGV2aWNlIG1vZGVsLCBwcmVzZXJ2ZXMgYSB2
YWxpZCBoaWVyYXJjaHksIGFuZA0KcmVzb2x2ZXMgdGhlIHdhcm0gcmVzZXQgaXNzdWUgb24gQ2Fk
ZW5jZSBOQU5ELg0KDQpGaXhlczogZWJjNDFjYWQgKCJkcml2ZXJzOiBtdGQ6IG5hbmQ6IEFkZCBk
cml2ZXIgZm9yIENhZGVuY2UgTmFuZCIpDQpTaWduZWQtb2ZmLWJ5OiBEaW5lc2ggTWFuaXlhbSA8
ZGluZXNoLm1hbml5YW1AaW50ZWwuY29tPG1haWx0bzpkaW5lc2gubWFuaXlhbUBpbnRlbC5jb20+
Pg0KLS0tDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIFRyaW1hcmNoaSA8bWljaGFlbEBhbWFydWxh
c29sdXRpb25zLmNvbTxtYWlsdG86bWljaGFlbEBhbWFydWxhc29sdXRpb25zLmNvbT4+DQoNCiBk
cml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlX25hbmQuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5j
ZV9uYW5kLmMNCmluZGV4IDI3YWE3Zjk3YTQ1Li40NzcxNDQwZDFkZSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbXRkL25hbmQvcmF3L2NhZGVuY2VfbmFuZC5jDQorKysgYi9kcml2ZXJzL210ZC9uYW5k
L3Jhdy9jYWRlbmNlX25hbmQuYw0KQEAgLTIxOTYsNyArMjE5Niw3IEBAIHN0YXRpYyBpbnQgY2Fk
ZW5jZV9uYW5kX2NoaXBfaW5pdChzdHJ1Y3QgY2FkZW5jZV9uYW5kX2luZm8gKmNhZGVuY2UsIG9m
bm9kZSBub2RlDQogICAgICAgIGNoaXAtPmNvbnRyb2xsZXIgPSAmY2FkZW5jZS0+Y29udHJvbGxl
cjsNCiAgICAgICAgbmFuZF9zZXRfZmxhc2hfbm9kZShjaGlwLCBub2RlKTsNCiAgICAgICAgbXRk
ID0gbmFuZF90b19tdGQoY2hpcCk7DQotICAgICAgIG10ZC0+ZGV2LT5wYXJlbnQgPSBjYWRlbmNl
LT5kZXY7DQorICAgICAgIG10ZC0+ZGV2ID0gY2FkZW5jZS0+ZGV2Ow0KDQogICAgICAgIGNoaXAt
Pm9wdGlvbnMgfD0gTkFORF9CVVNXSURUSF9BVVRPOw0KICAgICAgICBjaGlwLT5zZWxlY3RfY2hp
cCA9IGNhZGVuY2VfbmFuZF9zZWxlY3RfY2hpcDsNCi0tDQoyLjM1LjMNCg0KDQotLQ0KTWljaGFl
bCBOYXp6YXJlbm8gVHJpbWFyY2hpDQpDby1Gb3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmlj
ZXINCk0uICszOSAzNDcgOTEzIDIxNzANCm1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb208bWFp
bHRvOm1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQoNCkFtYXJ1bGEgU29sdXRpb25zIEJWDQpKb29wIEdlZXNpbmt3ZWcgMTI1
LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MDQpULiArMzEgKDApODUgMTExIDkxNzINCmluZm9AYW1h
cnVsYXNvbHV0aW9ucy5jb208bWFpbHRvOmluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20+DQp3d3cu
YW1hcnVsYXNvbHV0aW9ucy5jb208aHR0cDovL3d3dy5hbWFydWxhc29sdXRpb25zLmNvbT4NCg0K
DQotLQ0KTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQpDby1Gb3VuZGVyICYgQ2hpZWYgRXhl
Y3V0aXZlIE9mZmljZXINCk0uICszOSAzNDcgOTEzIDIxNzANCm1pY2hhZWxAYW1hcnVsYXNvbHV0
aW9ucy5jb208bWFpbHRvOm1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQoNCkFtYXJ1bGEgU29sdXRpb25zIEJWDQpKb29wIEdl
ZXNpbmt3ZWcgMTI1LCAxMTE0IEFCLCBBbXN0ZXJkYW0sIE5MDQpULiArMzEgKDApODUgMTExIDkx
NzINCmluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb208bWFpbHRvOmluZm9AYW1hcnVsYXNvbHV0aW9u
cy5jb20+DQp3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb208aHR0cDovL3d3dy5hbWFydWxhc29sdXRp
b25zLmNvbT4NCg==
