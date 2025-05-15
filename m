Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8C0C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CD782BD6;
	Thu, 15 May 2025 16:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hpe.com header.i=@hpe.com header.b="ApPd+Cvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDCAE82BD7; Thu, 15 May 2025 16:02:13 +0200 (CEST)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076D482BC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=verdun@hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7XCwC015725;
 Thu, 15 May 2025 14:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps0720; bh=MzOnZnV9tpFA0HSr7DC9BVZdR0
 WJUWgfwY/rnoYda1s=; b=ApPd+Cvuk8nubJ4sTRJjzNj7e3xj/zxxgmtc7gKehD
 fjDjcKz+f10ET2L32f4crGFc4ioA8vghr5ig5pQaHu1ZrHt49cJbXBhnCrMagwL1
 imVdsaCWbxp9/OvJhCVffw6w5uEqjEay5FpDC0NQq9et9lpMsTRdypSllFyjWWsO
 qi/qB7i/4e/7MCjOFi42WPVh3GPShKk6jdWN1y1/TiG+E75zViF+N+FNw1ntWcM3
 FaAJpj2zS2sR19ija1rJn17VRD3GYAx4oDfBzmMttx8Nb2ERv/TFnYAYqeyCLQUb
 oV70Y5u8ggFrtf0ZeTrYP/6W1fMgMgRKczBYkQL+qCbw==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
 by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 46nb393j93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 14:02:03 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 948AE5C3D0;
 Thu, 15 May 2025 14:01:49 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 02:01:39 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Thu, 15 May 2025 02:01:39 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 May 2025 02:01:39 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRjZO8QFh5Q1n9aqM8tCFjo1ILMM3p91dgdBjtWY1MaufCkTbs7Ed6hbYqqFP1ECQYrotwkJI5E1A+vKoezeLwlz8ChwUVdazHlJGXz/Ox3I5olCz1fTRVlz8OOlKZ41ioqilBHyUi9zYPRD3XNe1j99HHXQvUVSbmfy2GA1mj++sX4dZt55HmpfN/dLDARkQP5TQeXQJWpChnGUtCxEeedU/OTPgo6h9MiC0t+2nXy/IXqina+dSrC4xL6URdSd3u6xQ5ZW32HMqGnJwC2pCcHISNQ2zd5Xp4Hq3CPVxNK7wKHW8Oc4vGtCtXDK4iRgv8yvtxoETgXHKZuQspg9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzOnZnV9tpFA0HSr7DC9BVZdR0WJUWgfwY/rnoYda1s=;
 b=w0E+7EUX2WyhZ4jzI61SivHqErB0GGe2nMZNbvB6yjP8mH7ktpBynuW0WVMmLvccHKuK15jfcIeo/1/SeueV/Luz85U8SgVr1VH52oeebqPmSCzVat2QXp0kiKcN52dQufI/MNWmzdaLUm1zPjlyFOCVvUIXNfw1u5Cly8w7cFU12p4327m544xkBqsYZfQ+3Cwkd+5s0kv+LjQdx+GrGUDjnUhqhu5ZcbzNoJ+6CqfXZ58YWBoOCjnFEgxG1LAdaR9E0sCCiSliUAkiZmH2qObQjx1268NP+4gP09C2lP/l8HScLzSSB/x81BXaoOZfrdQ9hXHne35ZUVgAoB1n0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 BY1PR84MB3940.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:4b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 14:01:37 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 14:01:37 +0000
From: "Verdun, Jean-Marie" <verdun@hpe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Topic: [PATCH v4 1/1] Initial support for Wiznet W5500
Thread-Index: AQHbwp7xIrnosPKZPkmFc0YqeiDvV7POpWqAgAAZ0gCABP0Mmg==
Date: Thu, 15 May 2025 14:01:37 +0000
Message-ID: <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
 <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
In-Reply-To: <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|BY1PR84MB3940:EE_
x-ms-office365-filtering-correlation-id: 548dabd3-1665-45bb-d699-08dd93b90294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?dYFjHOsJg3tnQyKaywSfj1oArAoYBhAirxCuL6ZHF1n5gPz5ueAjlOmU?=
 =?Windows-1252?Q?I361GJAj5I+FOBTzTBnYhe+PtGyUpHxzw7vHaWD2Bqrl6ZepaCgHc+nW?=
 =?Windows-1252?Q?/350M+T9f0kAyJK1sEzlVgWpNMt6BS6ABPmW5YQaLgPN1URxPBIGovw5?=
 =?Windows-1252?Q?xpJqXu5tTrsu9WZipmyj6JhjtVHgJQi+MUVVpygPQP062Amx42s+OgHV?=
 =?Windows-1252?Q?2842DchKPQ7AQ6eaVejf5mS7kZftfg7n6DwaEPf2UQVGTbyg8idER7cm?=
 =?Windows-1252?Q?UadIHm9Le/DXK5bln/NAkOby65DSYOFbgGoJre7vEzePwQb6/D0Blku+?=
 =?Windows-1252?Q?fXpELIKHpBPcEbdbe/2ffazDfko5cMSp2Q9COtPmr40+ELjpV5vljXL4?=
 =?Windows-1252?Q?2KHxG4lK8saSQVROOu9wpNlIzrFVEtbVWNpRRuqGpxFRSqabcuZIpZAI?=
 =?Windows-1252?Q?uVhgk3n7/lYHI3js2y1efgOSCwsKsQFpPfKnustbxXh84swQvznPmFqi?=
 =?Windows-1252?Q?xIV0vmhZmTooE1BVJ5/qZPLTCuXT4IjqExiMbRJL7Ntw3cki7NmfRMY1?=
 =?Windows-1252?Q?0hiHsRW/Smu751zfX8HEiCFZ4e0aFm9ql5BaahS/2yJKarB3UuEHYc++?=
 =?Windows-1252?Q?doJZ7F0S4ONwg/Qe0mnLCxoxK5QLGCKiq2HVdtlv2njjJcBOx2xnmyhz?=
 =?Windows-1252?Q?cxZdblgHkcZCjUcvwoe9asVqDcVLaMxRyHwshYhwk3Y6lgQxAtMWZERe?=
 =?Windows-1252?Q?VW12r44NXs3waXKhIJU+/eURHJA0zsQGEc+FVTKeD6CM1vJGWyqC9/Ci?=
 =?Windows-1252?Q?4S/Q5Oj8JjGSpABdMDrZ9lQXD8Kg7xjCnIZfUlSDFX1VEW9PJUzfZV2M?=
 =?Windows-1252?Q?xuraEZn0FqUoBLgrV91X1DqaiCyxb9uiMER+Em5tO4ZEVBcUuXsFc0gM?=
 =?Windows-1252?Q?yJI1wsOPZiBu0ictC3KrNUe+O4NrmJ5n7vNLvYjZQt6g1NGUKRMdJurA?=
 =?Windows-1252?Q?Fm2apG5C7uXQGULBRmpyIp3frF7y+jFv2Gf1XpyGyEcZmQloH60wD5Rv?=
 =?Windows-1252?Q?gh2MMkk1gm/tayjtTKzLJLM9qJz+slSnGjimWK5nRVhrTvjb475F7Qe6?=
 =?Windows-1252?Q?cnhgn48dmLtU60pkMWSNFJ1jH+53c8gNST0dZB/qRH79U82yxJcDZNdL?=
 =?Windows-1252?Q?7RKMVU9OyFEMgyj9hTv0PswzP5lsE4ykGLEYiLN8HrkColxNCqYaP3mL?=
 =?Windows-1252?Q?EwtJ2xEcyuv0oipoKLjsYH2ggXfpcnZGxXFK8Fh+77e5BTVh2d0ILeSb?=
 =?Windows-1252?Q?lM4FhoMsC+fUV32q3C0hTnus1omqorJUoQShEyS1x4D44nZ7bpcxWJZG?=
 =?Windows-1252?Q?WcHH+FuwEJ+dLmoFAvpsqvZzc2HbiYOlQM9wSrh/w/hv5vG+gckXFTU/?=
 =?Windows-1252?Q?y/HKO909wWHKNnqGlLEi5zEH8KQ2h6XEKeMBAkHQsL2o0zqocLea6d5j?=
 =?Windows-1252?Q?sz5b9TriK8S70P7yABM5Acy5unzov/waVb5FJwGbdDtmUwHcG+kRr3jG?=
 =?Windows-1252?Q?6pB+XQTLn5xo9zUlUFu3oziQsAwX/v3ICo7jFA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?DP3xhHX1iy09C4ezcHgfneIGGIkzzRWpGo1BluqKNwlXrXb/eNlv0Xbf?=
 =?Windows-1252?Q?t3NZbZJ42rDMtp3dkIgvqNbTLNNb5gxUls32/TxipQb8ufu+RasLAS3q?=
 =?Windows-1252?Q?/+rL57u+X3FVYyyHalnheuZ2QQsKuQ4D70Q3KGg/Y9RIDIEbrHKwHix/?=
 =?Windows-1252?Q?G0hqHNbu30P/RwC+99leDrkphxMmAHEm7cFCpoSEyZPmQsehTTDOxTxZ?=
 =?Windows-1252?Q?Bep2/KKnKR0cUf4Qoo7LASMrDD0vT19rzB/KB6MnmmY2r+yktpGQZZv4?=
 =?Windows-1252?Q?O3pzBIdTKOUQdZOLz3HJ6D3GHAGo+z4TLSZP+TBKy057p6m8FDSIfZBV?=
 =?Windows-1252?Q?Pofl/64+H4UdJsyeUCqR3YuD2OnAP8ECTscp+NQFcGSGXEcaXjOPAuFo?=
 =?Windows-1252?Q?RvtPewSjhCu0El8rVp9uPPRm4qi0OMgpjunkWPRmED1Uk4Q2H7ZY6jJH?=
 =?Windows-1252?Q?8Heck4w+173wXcmQC68BxChKC5n3r3F236Vjsz9/z1iKGOYJEiM4gURp?=
 =?Windows-1252?Q?UX1mpgc3BcO1jfNaGD5nA1nRI0oU/k5mtQAIv0+/eFGJ5U2ITbE85pY8?=
 =?Windows-1252?Q?araUAKXRgtEICHRXaDoDIu+6WVDBCU/s1tre3D4+Cb1KcmBbXuJGB3gx?=
 =?Windows-1252?Q?xn5yJTX5uxH5OaOA35f8VeAFH0EaeMrvZr2yiAny8trr+t72LMNIYgDm?=
 =?Windows-1252?Q?e/PKPrjGNF7kdM+TOQ3qrUgwL9vVyB+6DumhiPOwvSEJT5ejGCZza8Ys?=
 =?Windows-1252?Q?QfbTPPbdV5dTcNN1GDUF+LtkfFFkDa7xy0kdK2Pk8asZA+HiT3cucVM7?=
 =?Windows-1252?Q?Ul7knZHGo4eLYLscpWICyKoUFppZsvMgTPBgS4xyaRZkp8qrzyND8EXZ?=
 =?Windows-1252?Q?g7BXz2sXtc7E/4e1n7ISyMaL6xvUxf8DUgXoNENjTpPSjroypVr6zmDq?=
 =?Windows-1252?Q?0WGF21ZiFYSo5JSun+NI8uD6u7q48r+G3vyN+iOsyqL5wOnJG9jPX59v?=
 =?Windows-1252?Q?erunsgtAemmPCvVMkMckQVgSty5wUmDcl1WaazXmrEzaU70SGQY9nRwo?=
 =?Windows-1252?Q?29rvV+6KB3HJRFtulsBhdvKjs9wUvj2XeioLpRhdkTb2q1WpHMq3a6gL?=
 =?Windows-1252?Q?ghs2HVpVCMHoh1Ks0Iho2TXVBRmzifF6qarKba8KmZ/JoM5xtc3SQIFa?=
 =?Windows-1252?Q?ShQCxZv1zdhEtC0eF8WoUSyDgiW39b9t/6PjpAYwVSYD/hwWWZc4WBXP?=
 =?Windows-1252?Q?sX3l2ng3vkNjVqJHeHDQGOtAsWD3Psl/MEKBnC824msIP1sbWqLCFF0B?=
 =?Windows-1252?Q?8VFpPDHErEaESAoVsLtuPciwT8ADVK+ewYtZyyWUuXJmv5cXv0vK5MK6?=
 =?Windows-1252?Q?gugOWU0naq/MB+sa8MHsh6jONOc8kHjgcXtg5v0ced/gGP3y2HDL2HGc?=
 =?Windows-1252?Q?FqLbmHId7u1UmfI0J6CkWFLRN6ifEpzmpJOgVJ6v35WLOiLaLO1FAst7?=
 =?Windows-1252?Q?GvUlaclEoGrXcpWVKPjAfZ++xbQk/9kekeNRMmMnRG8vIoy3VpT2jtPm?=
 =?Windows-1252?Q?Z4YLQB9Vlk2y/aB2a2RNqLjBdiRnsns8tm+xKLb73NOsqdDsU6gCYwrL?=
 =?Windows-1252?Q?ug3sixjW9Eh13YqEIf6FG4EGNba5nxlEZ/+lPDqc8wfQ3KaD4Mg1ID+t?=
 =?Windows-1252?Q?MwLAfonTd9YN8LpeTewFXznDYd2PYwy3?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 548dabd3-1665-45bb-d699-08dd93b90294
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 14:01:37.7495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoNEEsEnJGaNji55475BXuy7ZphOgBeGiVVAYyBrQvpVzh0f6eAEvMwl3iDVbo8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR84MB3940
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: brijdylHgGmr4LkUenMxokkVF0LiXFUp
X-Proofpoint-GUID: brijdylHgGmr4LkUenMxokkVF0LiXFUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEzOCBTYWx0ZWRfX89e4hZD4XnJ2
 nVzKBB+qxmTJ5hbHq1HQwbhKTQdegx25J1H9ZPvtVNXnElGfK7XUjpp+NzDbDFBZRRHGobOkbrQ
 UqgA7IcHMDnKEvtayUpybnF7C6nw+MNJ6pi6jKhV0FxgPrQm1qiUo/4Jo9Af/278dYxRwI00Zpj
 ADDGesYE2u092YNAwYNWmonm9a2rZQbGz5H91sMK85cyHVI8O2lK8Jp3NuFqiOR2T4uKWcqSMjM
 Y5p41vWe2yGk0N/A9QBd/n933ALw4nL8SwQ2HTy+/BYi++6s5sqX1fmceUE1We+nbC9vt/2NEyC
 e+QuT16ymVRnaGXtdJiJroHj4OHjl8Rok2OO9kkPaN2abpPYTIpk73o+dLhcl7VS9x0CtU6SF0H
 iz66pwS3
X-Authority-Analysis: v=2.4 cv=ZawdNtVA c=1 sm=1 tr=0 ts=6825f3db cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=TNs0_0OCmGBN542uoIwA:9 a=pILNOxqGKmIA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=CWZRypDgFSe3Tpt_hdwA:9 a=Z99kZr0ukzhtYgOL:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150138
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



>> This is dangerous too. How do I know if the returned data is an error
>> code or actual data?

>> Right now, xfer returns 0 if successful, -1 otherwise. I would suggest
>> return ret only if it is < 0.

>> Or even better, propagate the error code and return data through a
>> pointer as argument of the function?

>> e.g.

>> static int w5500_spi_read(struct udevice *dev, u32 addr, u8 *data)
>> {
>> [...]
>>     return xfer(dev, cmd, sizeof(cmd), &data, 1);
>>}

I could do that but that won=92t be the same logic as the linux kernel
driver approach which is mixing up ret and data as return value of
this call and many others too.


>> Considering the only difference between w5500_spi_read16 and
>> w5500_spi_read is the 2 or 1 as last argument of xfer() call, you
>> probably want to factor them out into a common function to limit
>> duplicated code.

>> If you have access to the info, I would suggest to NOT use a u8[3] array
>> but create a small struct which specifies what each u8 is for so it's
>> easier to read and debug later on. This applies to all other functions.

I can do that

>> You really need to justify that big of an array, why do you need that?
>> Can't we malloc it based on len?

I switched it to a malloc for next patchset


>> Looks like endianness swap to me? Is this supposed to happen if you have
>> another endianness for the SoC than the one you're currently using to
>> test this?

I don=92t have access to anything else other than an ARM SoC to test it. It=
 seems
required to swap the bytes from the SPI read process


>> -ENOMEM?

Done in next patchset



>> Please use log_debug()/dev_dbg instead of debug().

Neil initially asked for debug, I can swap to any, just let me know which o=
ne.


Cheers,
Quentin
