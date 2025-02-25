Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67725C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD3E80805;
	Tue, 25 Feb 2025 14:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wmfnMY2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45BD80977; Tue, 25 Feb 2025 14:39:07 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83BCB807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzGvJHK2ZP3n793BpW2kNliT7bGOqbQaXKTkMtQ81X8cst75T4Tcqd0TQA65wPq7YffFnHvJDBhnc51IvnWRnr6tvrmo9YVQ0lyxqKtNx3oN8k9qEwwRoEUEkfPWhogy4+Lk+21Dq/xcLZxnSjap64Py+jCjCV/tRJkeV3sVIANyNaE6EX1bVN/XlzglaHY1JNwLKbwOxNWY+/6zYG6+pxXsST71vTKshrso5dezc1TBL1moAJSXrv8NvyQ3zyEdUwdlFvp01As0x9xaM5T/KO90CoiNyb2i8hf1hul1mb4AfzxdOGo2KF/b4lV2BvhhlEiRmmlMoLRucDyBtjd+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICQw7/mVHVgb0GdR5xfb+QQmjwvnxJvWWBY7hRiTX9I=;
 b=ZmOfZvK1R/SAt+7hwhftl4N8oeMoeH8Mkc8gnuTGT/Kw5ScZ92bahGJeHKh4hDHayR875pzmH2fQTAGFlIJOGMU2SJXC6LwbsyoGVIF5S7WUy4HFwahvXuKdje8gKkf9DaucBtPMcos1VJ9dTZK7YOMOuVd3MGSMgpGi2KDNNN2Boe7Ax/i4u9/S84Se0YZHML4fL4RBB/uMOqmHAKbQqDnJDFJ9fDdBcBXRvSI+EKSBvQRFbK3oaW+qZxrV9Y0vu6LOvhbIp7XUKw5pTcbCfgR2kUR6Oi2U1nuocsj6Avm6lUWpPAU1h1E/Wxv9k2HZDB6kviCLJNeOYQCszvsKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICQw7/mVHVgb0GdR5xfb+QQmjwvnxJvWWBY7hRiTX9I=;
 b=wmfnMY2fIGuGWTwtGtOfphSrsEzbUKyPNYDJM+nozvxIt1YEiajWT5AmwdvMx5dLNoiFstzRAnN2GPVrAvMKC6OlC3YWiyTZ5zjnrpOlSiSqc5P9s0wn5ptMmWviNFLsQ721dbbwlbFojAd38n8wIjrk8BimVR+qAsyauuWMjmpgFa4H/puXfPAR3yyALUHfmBsBxWkLvs0YTH3sG0h0ISvUr9w8BonoSWfzyp7zTSXYrKKzn/Ey22qxdjdiEEkk2wSdc+uvP6pPh9tNjiXXmJck9WuwdU1rpsaqTWFexve4aNZ8KqsrgZUc6fSD9Tuo6vRC2r1EZlgguwawVv/DMw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB8194.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 13:39:03 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 13:39:02 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "bb@ti.com" <bb@ti.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>, "afd@ti.com" <afd@ti.com>, 
 "j-choudhary@ti.com" <j-choudhary@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "danishanwar@ti.com" <danishanwar@ti.com>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 05/15] net: ti: Kconfig: Enable SPL_SYSCON config for
 CPSW
Thread-Topic: [PATCH v3 05/15] net: ti: Kconfig: Enable SPL_SYSCON config for
 CPSW
Thread-Index: AQHbh3tUPgQhKsRMbUaQvV3JtN6ebrNYBkqA
Date: Tue, 25 Feb 2025 13:39:02 +0000
Message-ID: <18cf39e30ba656079a4e87e5b5fe5664026b2676.camel@siemens.com>
References: <20250225114903.2080616-1-c-vankar@ti.com>
 <20250225114903.2080616-6-c-vankar@ti.com>
In-Reply-To: <20250225114903.2080616-6-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB8194:EE_
x-ms-office365-filtering-correlation-id: 7628abdc-3fef-466b-a887-08dd55a1c40b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZmZjT1ErdWJ5TWRJYUdVTGtlazBZdkMvNSttOUNpQXJWTEdiakFteGhrQllj?=
 =?utf-8?B?dm43RzNoY21CZnFzTGJGYUhqZ1hHeHc4VFdYL0VBSG9BTEdOL1BaYUpLTnFk?=
 =?utf-8?B?TFl3LzM3NFRWLzhwUE9VMEJ4WXVJYmJFMkJqQkVQMkJKeVBsYlVPRndwc0VK?=
 =?utf-8?B?dmtyRktJeFJwZC9HNFU5dzdUTkZvZVVBOURnaUpKSncrTVhmM0pJSGg3ZjN3?=
 =?utf-8?B?dndnUTZ3anhEc3JNc1hIZUZvNnNUZElMRENIRjdlZlJKZjk3WHZISDFiMUU3?=
 =?utf-8?B?dFdXc1B6blJMbExraExhclc0eHNXSEs4S3Q0WkMybnNOMjFIN2ZGckFQeHpC?=
 =?utf-8?B?ZGM0dHZkaVg3VVhXMWZpQWMwODVCY2tZV2ZUZTBzZlVVRnR4YVBDT2dIZkNh?=
 =?utf-8?B?RHNWeTVoTWl2TG1VUWZQMFlTZXk4aC9OTlBNVzF0TVp3SzYxaWFobEpLcklS?=
 =?utf-8?B?eFlvK1o2SzFYSjJvejVmeWtNZVpUWU1Edmc3OUJ4Qm5TeFpKM3VweFVMTXRE?=
 =?utf-8?B?aUhWYXBhMlJISlJ5RnBXMG5wKzQxdHhBejMzbWd5blNnT1JIdmhtUUtpMVVR?=
 =?utf-8?B?K3RDOEpuZ1hQM1I5dHI1bWt5UGQ0b3o5emxpREpyZGhsYjdDUWpVdHFQYnZk?=
 =?utf-8?B?cjByYUREb1Uya2JobFlGMlRvVmJzZEsrejRpalVoWkMzRGl3U2o5NndVWkgr?=
 =?utf-8?B?UHdIWXpseGpac01QRWxEU2pJVE01bGJ0NUI4aWQrN25nVzJyN3RGQkkzSXl3?=
 =?utf-8?B?VlMxb1h4WFpIeVB0SUxjZ3JzTGhsZmQyNkFXVVdJa2FJbUJEUzM1dkZwTVlL?=
 =?utf-8?B?Z0Yya3dkRTkwQXJVRHkwLzNRVStrNzRvZUNxa0lnMXVhaWxmTGVyTDV5dVYr?=
 =?utf-8?B?Y0NSODdhbzVUc1NjRG12L2xuQXR3S1JJUGdqYSt4K1V1dnRZOURqSmdZOVY5?=
 =?utf-8?B?SlNEdDdxNTQyemdqT2plRVBpSk5Jb04ycjJoQTB2ZzZUaDNHb05xTEUvcXhy?=
 =?utf-8?B?RGgwSFp3NFUwemdRZnNkK1FrUjc5K1FUdXlKSTJXK2dDV0xvU2JDMzZUSlFI?=
 =?utf-8?B?MGF5ZDRuQTd3eEFzMHFzK3VmOUJGKzZ6TFoxQlZZOEJGb1EwNSsrUGFlZCtO?=
 =?utf-8?B?SWZUd1hxaUozK2IzWFd6YlZCNjRhV1l4aGZjTktOclZ1SUxlS1pIVTlEbUs2?=
 =?utf-8?B?TGNCcjc4TnVEZ2lMbUxvYW1ueGpFTDhKMGtZOHlFN3cwNkhrcFRtTEg3bW96?=
 =?utf-8?B?ZU1ucmE5MXdxWTZNVUtucEl5aytwbmZkQjlCck5aRVordjhJZVZTZFF2UE5j?=
 =?utf-8?B?dmYwanh0RlB0Z3M4ZmsvelRGMHlYc011OGtxWVZNeGVXM1liK1NmbmJLZjZR?=
 =?utf-8?B?eStGMFpQWDllS3ZtblBqZy9TNDF1cmpYdlB1Z09jWGNPRjBkR0xScUZNNjRN?=
 =?utf-8?B?VVJzcVFqMFBqWnBQVGN5UVZXYTc3eUhrWlMwSVo4MFdnZ2FEQ2FYY2szL2VZ?=
 =?utf-8?B?V2tVT2NPcHNXelUyNWlVSHBvSkxuSzdXVCtnTzQvbDN6alVpaUtUSFVLbEJ0?=
 =?utf-8?B?d3pVb1dhdmF0dVIwSng2czdITWdwWXloSFFPS2RtL09qZHRQOUpRSE4vZ2hG?=
 =?utf-8?B?RU1SVGhrNGd3YUN4eENSWHVQdStNY3VQQjFjbHNJWks1Szh0MzREcm5tYTh4?=
 =?utf-8?B?QzBCeTZDdC9mMmNHTVArTDVRYlE2OXdmajRHWDM0Qm45Ym9iNlZORks0TU8z?=
 =?utf-8?B?MkszbXBsNllmT3JyR0p3V2l4d1l2TjJGM2VwdTVTaEhxb0h0NDE3eG5lSlkx?=
 =?utf-8?B?L3BiaHN6MkUzMTV2VElqM0kwWGNtRTBvcXRUOXdFWllyNWVkek1pRjFlTkZy?=
 =?utf-8?B?SGFYSG1ZbVFwU203QXNKMEVSOG84ZWNBdURYSjlnY1NRNFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czZ0NEtaWUFhc1VrSzVKenpyMFNCdGF2LzdxVnBueVNvRkI3U2dwR0tzRWE3?=
 =?utf-8?B?Zkowbi9HUkVYR3ZHV2JaUHJCV3FrQ1owNW5NYmppZ3BpQWxXNlhoSmdqOEtv?=
 =?utf-8?B?R0VMeEwrS2xESkJETGJ2N0JDaDZIK2dDZ0hPaWNnclhxL3lhYXlhc0plSjJB?=
 =?utf-8?B?OHh0ZzZJeWpLMGlyM0xFdmwwdXJJSGduZWNsUFNFckpWWjN1REQyb2VQeXVH?=
 =?utf-8?B?QVBPZlVqeWhEQkZ6TjhwMWFHMDF1cDJyZHJ0L2g3UnJCZExuWWhtd2pxRDF6?=
 =?utf-8?B?RGVGT0xJVTZTcGhKV1Y1QWZmUVFEcEc2L3h4elA0NUJmMDRKNXU3R1pRQnVO?=
 =?utf-8?B?OXZQUmo0SU5uaGJRN0RPUUp3QldjRmpvRko4YVZJM1FlV0hqQmlEZ3hTeWdN?=
 =?utf-8?B?N3puRGRYTEtRZlJmcHpjeVVJY3FQbTNOOVlENVVNTk5vdS9QSkd6a0dPMEt3?=
 =?utf-8?B?YXFJcEJxUFJJdVVoOS9lUWtFSEJWa1lHNUpZKzIxMDB0M1MzcXFaSXdiZUlv?=
 =?utf-8?B?Uk5IVkk4eng4TGllQjhKaGtXSDQvanVOL0JnelEyOHF1cDFQTml0ak1mMWlY?=
 =?utf-8?B?eWp6clN3T3hqNUNsV0M3ZnNHOVp2RS9remRZbGhhNzM4L2lmTDV6TWdQWkhX?=
 =?utf-8?B?eFBkRE4zdm5lUG9pMnhwcktMUkY1RzZua1hESWNlVTJucnc2OG5xd01jM1dM?=
 =?utf-8?B?NUUvNVQydDE1TGNEMG54UmFUN3pCQ0FFaXpxU0QxaE9WRW4wU2dsYi9VSy8w?=
 =?utf-8?B?MFg4WWFQa2xYZUJvblFkNnlXZlgwSCtDOXlOWkZwSVdpVmVjcTE4SG96Zmty?=
 =?utf-8?B?eGpwSTN6OWNzVjM5WFdHYVFPRzNvN3NNb3BwQXhkcSt4U1dnVWJWOUJmYStF?=
 =?utf-8?B?UnNkM1M2blZHQ29KT3RmVTI2N3o1bzdpRTBnZmdVaUtqQjZEakhVWUNxT2xm?=
 =?utf-8?B?Mm9lbEl1QWxDMGRPQ0JwUmpsZGtmZm9xZnM1SU5XV2JVcnV3WjNHRUp2cVhp?=
 =?utf-8?B?ZEZaQ1hhMXBUTUQxdVNUL2JnTndNWUtRMzVNNGZsZDEzcmpIVDNnenV4NUNC?=
 =?utf-8?B?STM5VWJac3lnT3JnMXRCNmFqWFVvOXZnL3RqMDRicGFJV2NjS0JHdHZxRXVX?=
 =?utf-8?B?VDJyeXNZM3Q2ZnBMUjF3Zjd5UVZsRUJNQVYwclJCUFIrdXFuWVdTUWNJUW94?=
 =?utf-8?B?WS84dHVYR3VvOEd5MTdlbHF3azdwUXJlUHVmd3g4S2o1c05YSXpoSUZnOWp6?=
 =?utf-8?B?SDFybm01Y3hPU0o2Z0F4L2h3c2NZZ0tYVEFkbkRUWkEvVDBrbHQwSzhqRkt2?=
 =?utf-8?B?UGQ4a3pORHZoTDlJRitZeHpNUjhjZlVZbGozNkZycXNaK3Z5RWt0SzQ2TWdp?=
 =?utf-8?B?Y2xaaW1QOFMzeTY0S1NnSVBNcFI0M1V6TkpiSVdieEtmSHlIWmg0elE1d25F?=
 =?utf-8?B?b0NPVUJ5WmllTmI2d0NiNEZSb3dwL1lZMEVJZWxxSXhHVmhsWTlDd1lPRTRs?=
 =?utf-8?B?OUJiSkJrdlVrWFVVdDcxa1A2bHRiSGRJdUFGWkU4RVpNSk43N09wdU1Bd1dK?=
 =?utf-8?B?Z3ZFSlpiVTdoY3pFOGR2Q1c2cUdVSTR5M3VXbytGSnYvRFhCcEZRMHdqd09E?=
 =?utf-8?B?V2YzOTNmMUFWaCs3NGV6SEk2c29ocTF2ZDZkZzQvTW1Vdlp6NndnbXZSMXo4?=
 =?utf-8?B?YzFpSHdsRFNBMlVDWVUzLzFZNEtaMVJ6aitTNTdEUEFSVlhteHByQXZ3a0JQ?=
 =?utf-8?B?dXhUbCtvRGFuQmtwY1ltYUNUWmR3TGxMeXBYcUNvRlpueWlVOGNCYS8veWo0?=
 =?utf-8?B?ankrUFIxdUxycWVCRS9LMWJYNHIzZXB4K3BtR3l1NzBmWVpRQi9OS0hHeFVN?=
 =?utf-8?B?Y2hUbk51aGZWWG1CdmFkWFlrbmlaVW54cU9ybGZuMmR5WjNkOWwrMkdoMVdu?=
 =?utf-8?B?dno0QkgzSjdTelQ3Vi9rSzc5dy9xRmZTWWVrdkYxcU4zVmN0UmJKa3lNcHhl?=
 =?utf-8?B?a2xKTklVS1Bnak5VeUdXZVFuOWNJM1Q4WU5Hb2xMTFdUM1hyQURkOEpHVUFU?=
 =?utf-8?B?K0JNR3RxcDdETHpveHR2R0xIdjlXV1JqcUUydkYzWDNLRVluSjM1amp4bDI3?=
 =?utf-8?B?S0NCYU95cW1DbGJkWHhKNWQwUk9qeE15SU1OR1FQQmJYclB2ZldHdlZuK1hJ?=
 =?utf-8?Q?MstFZf39iIXm5kUJR7tWTeM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2156039A5799E8489AD4200E0D202D8D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7628abdc-3fef-466b-a887-08dd55a1c40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 13:39:02.3193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmsUccil931ccREIAtXVLbmbYeoT1VZMvicmYYbHOJvb16ud9Qr8+y+vITHKu8OdVZWxnK2YAc7K8fIHlkRNgrjsQa9U3GO9NwoX8A0VtaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8194
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

T24gVHVlLCAyMDI1LTAyLTI1IGF0IDE3OjE4ICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gVEkncyBFdGhlcm5ldCBzd2l0Y2ggbmVlZHMgc3lzdGVtIGNvbnRyb2xsZXJzIGVuYWJsZWQg
aW4gUjVTUEwgc3RhZ2Ugd2hpbGUNCj4gYm9vdGluZyB2aWEgRXRoZXJuZXQuIEVuYWJsZSBTUExf
U1lTQ09OIGNvbmZpZyBmb3INCj4gQ09ORklHX1RJX0FNNjVfQ1BTV19OVVNTLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hpbnRhbiBWYW5rYXIgPGMtdmFua2FyQHRpLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0K
DQo+IC0tLQ0KPiANCj4gVGhpcyBwYXRjaCBpcyBuZXcgaW4gdGhpcyBzZXJpZXMuDQo+IA0KPiDC
oGRyaXZlcnMvbmV0L3RpL0tjb25maWcgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC90aS9LY29uZmlnIGIvZHJp
dmVycy9uZXQvdGkvS2NvbmZpZw0KPiBpbmRleCBkZGZhOTVhMGI3ZS4uM2Q0OTVhNTY2NzAgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3RpL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9uZXQv
dGkvS2NvbmZpZw0KPiBAQCAtNDYsNiArNDYsNyBAQCBjb25maWcgVElfQU02NV9DUFNXX05VU1MN
Cj4gwqAJaW1wbHkgTUlTQw0KPiDCoAlpbXBseSBTWVNDT04NCj4gwqAJaW1wbHkgTURJT19USV9D
UFNXDQo+ICsJaW1wbHkgU1BMX1NZU0NPTg0KPiDCoAlzZWxlY3QgUEhZTElCDQo+IMKgCWhlbHAN
Cj4gwqAJwqAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgVEkgSzMgTUNVIENQU1cgTnVzcyBFdGhlcm5l
dCBjb250cm9sbGVyDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cu
c2llbWVucy5jb20NCg==
