Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC78EC3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 04:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3FA988714;
	Fri,  2 Aug 2024 06:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YQzntL/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6E88870E; Fri,  2 Aug 2024 06:11:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122A288859
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 06:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVos490Fi3jQX0cgbGR0ZplTqrAQDrmO8xuG361OMxorYYQc8A1l/qlQU1tcOOhbyCFyruCHVdjGKWQjhSHqMUyga+AlKx22WDHCRqC3cuOw0uzFzQV6KyN9qKmkvV88FYjycoQK2Vx3mMuYJKMzVkNbeJ8e3XyssAtJ0vA2OtlXfSvyjOn/vimdifbq7rk/oKR/1f5sh7ct5yOsc23lpCwQjfJhyyx4vjoULxCl0iXTbYXshTRRCLk5DgVEpt8o2s/5EjeMo5ixk0QxRJuJVvQqCD1416FnMdOZOkmK8nkwh/5oIl6Pmvcl1FUE/twAyldVgDfnydQGITO1qk7+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AE4/pLwLfzMrWQ/dfNX/UAeuOKVNGOmhFLmMkA7wgI=;
 b=pSY5uEyFXAzaLCyZ95rucqBkl7bGN1Yz0cnf6vGCMakbP0Q7HnZBEm8y1pwXw/7a26hc2SWD6820gsebWuse55s5/mfwsCHj+Y9FMNyDweJNhHzBEVaQgLGkk8V4MCKDQnyiN+LPwWTZxDr/PGUfkx/ozMc/Yc4P24gkIdzBckAiudDx6sdvuck9cQi/vi4AReEUz8dRLIHBDzgp+diPp+IoloE4HaR8IrDwGRA4SAbl2vC+c0ka0VZxNch7lmieDL/hXzb2APukejASLZrbM4iYhmO58KTyeV1fYc33tWM4NBqoq6dx+VkmQHuL/uN/Oq1YCFz8Fx2L82I5HDrKgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AE4/pLwLfzMrWQ/dfNX/UAeuOKVNGOmhFLmMkA7wgI=;
 b=YQzntL/KBIsUNBc8BDXnYW8FktGBPuktOVtSJdH0zqbiTm8ezQJORmuNQgRRE0FmoQ9KP6UU0NzVlK7hYnLjk55upQvtAg63l3KwkktIgHqSLJpcq+5wqN+QzbP+HfxVm5zdOj0VlOOiRHg4r2CNGrGNDh4O+3iyBjHU3M5CtPCK3l3Lw1R2Uk88SFEhP7hIDKnNRhFll4AUMP0ASW2HG88KMSfy3rG8DAkhl88PdWMJaAEPRIEAWlrAhUofxdgM5wJowGnd06ir/WUg7gNu3t3xf7k3jvRysNbIBXjy8qalagdCpvOkTYgmFjfbGSRPswOCoXs+FH7DuJfJ1E3bRQ==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 2 Aug
 2024 04:11:31 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 04:11:31 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCHv4 10/14] cmd: cpu: add release subcommand
Thread-Topic: [PATCHv4 10/14] cmd: cpu: add release subcommand
Thread-Index: AQHa4k974yUthb8PW0CksAlwGaZCHbIQ6gwAgACkHSCAAO9IAIAA3VIg
Date: Fri, 2 Aug 2024 04:11:31 +0000
Message-ID: <DB9PR04MB9236EC3F27922EF408ABC33584B32@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
 <CAFLszTgzXzUym-JBNk8i+50TsN81vU=Nhs_GMzvR+jmYaqMPsQ@mail.gmail.com>
 <DB9PR04MB9236CF945D9E444C5808FC2F84B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAFLszTg7casCckSwQuC0VqYYaDvyOwnzQRUu6tTLESKGvhS+Zg@mail.gmail.com>
In-Reply-To: <CAFLszTg7casCckSwQuC0VqYYaDvyOwnzQRUu6tTLESKGvhS+Zg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DU2PR04MB8616:EE_
x-ms-office365-filtering-correlation-id: 2f46760c-d8b7-4a06-7187-08dcb2a93079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SWZObUNnb01lSXJ5UGt3RUc0VFc5NXRhbGMzMUFYTXFkZ21Ha1dVVzJsczhk?=
 =?utf-8?B?SkJWd1J0TFRNUEVzRVdQQWkzcm9WMCtFZFRwdHoyMzFDQjNaQjEyUTlzSVdU?=
 =?utf-8?B?ckRpcllxUDI5QWxkODVEbUswN1o2WDdwdzNacFJjMkwraUpYcG9Ta1NROEZ5?=
 =?utf-8?B?TXZ6R0Ivb1Foc202LzVsOXdpZVRUeU9LMlVSUkF1MElISWNMWHpjMHNkWVBL?=
 =?utf-8?B?eFZWczNMOHpoSklWSURVM3F1KzlFQVJyZDNSVndFbU5SQzBXc1JDZ3MvYzlz?=
 =?utf-8?B?ZExpTW4rejNDZ0J1WXhTc3ljVzJZMFgweXJOdzlEMDJ3MEFpYlNtU1FHK1h3?=
 =?utf-8?B?SmxEWTdIK2M2TzJmS29teDFpODlVaVNvdTA3NmVuRHkxVzlvdE9IMVRYellF?=
 =?utf-8?B?ak9lbjdzR042cWY3UEpBN041OVVMTGgzc040cFpuMGNPS3ZNYkk1QmQ4engw?=
 =?utf-8?B?WG1ORDN0NUppYnM4MHNPRW1PbEVpU0xDeHpDQVBRLy8vZ3VJc1BXWUhlSFFY?=
 =?utf-8?B?cCsza2FCWmlFaXdjN3NpMmNhS1JDaURkMGQwV0FRNFhOL3dxUVJ6cmp6NjNC?=
 =?utf-8?B?SHp2MXFVUnZrb1ZIclBYT2ZVWGcra281SUM4T2hxUTgxc1JjbHJCWVFpbHp0?=
 =?utf-8?B?NEdObTR6SVVnTWtpQTNTc2pLQVQxQnZaT0MvK00xVHZFRVpSTllQTXNVemta?=
 =?utf-8?B?QW9PQlo3ZWFpdjk1QlBPbU9tVDY5WkJ2WENCZTJWd2JMSWpuRzZjTkp1YVRm?=
 =?utf-8?B?eGluYk9ReVFFcXdzUUVUanc2alZleFNRckYyYVRDa3cvNVo5elI0aWFWT1ZZ?=
 =?utf-8?B?UGd4Z0k0UDlYNVRLYzFHNmdSSzNJMEo3N1phTHdCTUo5Rkl3L3FUeGlka1ZG?=
 =?utf-8?B?KzJCN1hUVWtuTjhxSjRyaXl2UDNLbGtTWU5Hem5KbUdyd3p3di9Odm9oaFhr?=
 =?utf-8?B?d3paUWt6TVU2Z1A1UTh5KytoTTlLZUZ5eDljN3RXVnB0SERiTjJFWUw1UXdo?=
 =?utf-8?B?VWFhWlVETEs0WXVPaE84amMvZUpLODFpSTFDaFJVTWcvYkJnUEhwelphdGJZ?=
 =?utf-8?B?ZUpUbVp6enIzN1BKRlVJeWJhYkdPUk5FamdWVVZjblRLak9KMTN3UElFRThV?=
 =?utf-8?B?ZEorWDJRT1A3MklTMEhMNUdDZTZ0NFlIbzdpTzA3RWw2VWRKRDRibG9LUnRr?=
 =?utf-8?B?SUtzOHdzdnNQcU90Z0pnZGQvc0lNMlJ1c3VWWjQ4TGNUdnJXMHBXY0tJdnNR?=
 =?utf-8?B?N241dytudnA2OCtlS1B4V1F2dXE4V0JEV0NkeUlXRU16U3ZYM2Y4M2huQjFL?=
 =?utf-8?B?ZVdKS3lGdzNDamp0ODJ3REdVZzdoZy9WN0syMkphSXN5Q2FmU2R2bUlEUVAz?=
 =?utf-8?B?dHlRSHdsdTJOY2dJWEdsSzREMTRPeUt4NUs0aFhFMUYrano0VUo0S283bGFK?=
 =?utf-8?B?NUd4eU9ZYmdYM1NyRnl6WFlnelYzVnpWSFU5WjAvVGk1TDgwTnBYL3ROZDVS?=
 =?utf-8?B?YVpvWUdSdWRoMERJTGRINWpYVHgwSzAzdER0RHE2b1RSQmdUa1hUZHhnK3Uw?=
 =?utf-8?B?a2xKNzVMVG1kYlVMWkdvcmd1Mm5OL2ppRjZpNkhxMGNKSVU4a0JpYnNQeFgx?=
 =?utf-8?B?RllPaGhLUmNjTGlvQThlTkZBVDFmZGcvOFR5SS9MbGQxU2VwWGdzRjRVUGVE?=
 =?utf-8?B?NkhSbm1xbVcyM1F0aVp6aUdqcnoxd1k4QkhoM2N3b3VHcG1hK2U2UGNrUnZI?=
 =?utf-8?B?MUVTUnpJVEs4M1lnMzhKTlBWalJ3MXpmRGpIdU9KUERzNE5DN0dFYTExRS9j?=
 =?utf-8?B?Ylkwc3RTc2NBNVBRdlp0NnJNUHJKZzBLd1FHT21MK015Uk9SaE5vRjJRdFFw?=
 =?utf-8?B?YnU0SmsyRURNOGNYTW43UVBJTVp5NGVISjY0czk2Slh1S0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnJYaElrOTQ3cE1QUS9GSG5YbU1GUGE3VW5DOU16WllzdlB2MWtTaTNEUWVJ?=
 =?utf-8?B?S1Z1YnZ1RFFtRTJFVjQ3T1lqSWpQQ25UeDFqSU5NRHBzMnk0OS92NXVwRFRE?=
 =?utf-8?B?WU41L05walhESm5GZitlNUhYMncvRFZ2WnltOC93RDFxcURUM2FXZzBFN3pJ?=
 =?utf-8?B?NkIyVUx4SnJCOTJaOC81bnoxZVY0VVhvWHhYK0w3eXRxbjUwT09kUDVjSDFP?=
 =?utf-8?B?SWFRN09ndVdrZFVEWHFWc1VUTVVoTDBIZFhvWFQ5RFlUcjh4b1lrOFkvNExx?=
 =?utf-8?B?MDYzZFpqelczYjFnejFEdWYwSGlkZEVjWE5XZmowVDRwZm9uUVYyRi81OWVB?=
 =?utf-8?B?NTRFeGE5YlVoWis5aXVDSFFmN1ptWTJoeEUxV0E0bDVLR0tWY2xOc3FlZ1I5?=
 =?utf-8?B?dWFGdTlnUnI2N1VDbVdrckowSEJRS0t1UmNrNFliNDFUd1RUYlhlYW1XODZL?=
 =?utf-8?B?Z2wxbFM2WFF3S01xOU5IM0dUVFdpbzhqcnZiWit4QmZQb2FMSVdldVlJSzBY?=
 =?utf-8?B?ODBQVVFINVFkd2ZmVVM2NjZSNkdRREZ2bUU1RFF6eGpOWGlxRStaOStDRjMz?=
 =?utf-8?B?MnpTbEFubUNja2ZKcllmamZCNm9xUmFRUnNnYVN0MGJFNjZOcEtoMTh3MkFG?=
 =?utf-8?B?MEdwbHU2VG9HVjZZeGlNUmRFYURFVVhES0hYNWo2RE9CbXRRNy9PWEU5NFUr?=
 =?utf-8?B?N0xRVFNSUUNtUURHVWN4VlpzdEhFK1I1QWcvZ3BSUjF3Mm9xUUR5KzBXWDRu?=
 =?utf-8?B?aXkvTTVmRTJ1ejZpbHJ4bWErejlTKzlqOHNyQks0RnRhUEJhcnV3Y3hKZ2hP?=
 =?utf-8?B?ZnhBSmlReElaSzF3SWZEcXVPdnRRTVl5VXVRTHBmZ3FJZDVTV0FoUm52dGxi?=
 =?utf-8?B?ckZaa3J0dzRvOFAyM0hjbUFwbXZoL21VbGNrSnhUdkt5OXN4N1RtUXNIV28v?=
 =?utf-8?B?M21aT0tzRThQaGVHVGIxcUJkM1I1ZXl4U21YNW4xb2ZuYVZWdmoyaHkyTVc4?=
 =?utf-8?B?ZmZKME9Hemx2L1luR05pOHFPQk96cXhYNXRTbXdEVjRFQUorZUJqZ3J1QStL?=
 =?utf-8?B?bFFrRDBUUTJrN3dvS2NMMUtGY2daVHNCdzAvZkF4cHFURERjNEhwckxuTzhh?=
 =?utf-8?B?YWJKNnlBazhGbDNqejJJRWRmR0FVY3FabWdwaTlORVAyN1ZtdVd0WDlXTDdZ?=
 =?utf-8?B?dW1SeEJKMVhMcW1CWFl4R01aNjNQZGJ6alJIc2tUY05heWVNenNKOGduUXht?=
 =?utf-8?B?WDdiRysxRUpselRtL3F0TXY4allIaXZyQk43RE9BbkhxVmgyOGpPNEx3WkJV?=
 =?utf-8?B?OWRUT1pIcjlaRWt5YmIrRGFVb3pSQlZhMjVhNmZ1ZXBWeVRSVFFpMHZPRG1I?=
 =?utf-8?B?aTRKZ3FrTWYvYWtGMUtjSnZKcE91cGg1VHRJWEhFQ3VhdXVTSGFNSnU4NXBC?=
 =?utf-8?B?WUtVUmQ1Q0d3bE1TdS80enpOMnlKeHcxM2Z2NGdSSWJNUzNIVnZQN3NzMjN4?=
 =?utf-8?B?cVE2dGFIUTA4WjB0bWRyNTYrR2JYUVg1cGF2V0FkUFNwVGQyVlBOa0Q1VEZT?=
 =?utf-8?B?c3JGa1BYb2MzZjFHaWZtd1BQSVVKMUg3WEZGSUU5eThlMGVsbWxoK1FpMkJn?=
 =?utf-8?B?OEtUWFhyNmMzakVuQXJLUzNYTC92UzZLZlRhZE1NR3pPWUN1TXY0VFBjazhq?=
 =?utf-8?B?MENtZ1BWRStITXZBTDFMWW9SenkrYmJocHlVakZoRWVPWVdZYll0SEl1eUd2?=
 =?utf-8?B?MXVKdVRMRS95alYyVysySFVxemViMEo3UjF5b0xZRjExb0M3Mm0xcHFzdmlB?=
 =?utf-8?B?anRXTnplak9sRDY1dHo4Znowa21YQWE1aENxb3VjWVBEWStyZ1J4ZWZOb0Y1?=
 =?utf-8?B?dGFQN25BaWFrYURXNCtyZjFNblhtT3dLMnJuUklZSzBsV0piKysvN01Cd29a?=
 =?utf-8?B?dys1TG1BQ2RLK2tlNEFzR0k5OStXdUg2ZVZ4ZUJjdVB6TVUvT1MxOHNOYTdD?=
 =?utf-8?B?Y2ZGY3ZPVTViWW11QnQ4ZndFRWhDckZISE0rTVEvR2tHYWVHUlV2Z0tPWEs1?=
 =?utf-8?B?R1VjVVp0UG84WnZLdDJXQW9NRzI0MFNlSkVkMDl3VWY4WVZ4MjFaUzdBa1JW?=
 =?utf-8?Q?Ce8r9VbXb0Sg0P/nkSo7u1AzH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f46760c-d8b7-4a06-7187-08dcb2a93079
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 04:11:31.1739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v1YtPbMAHBqoVBO057gE3lk7bJyQ68vOcvF3Utcfc4Vx3RVKxB86FxQL1nvW2vxbsKo50UH0scv1j8T0K5of7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8616
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

SGkgU2ltb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24g
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMSwgMjAy
NCAxMDo0MiBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4gPHBl
bmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb207IG1hcmV4QGRlbnguZGU7DQo+IGx1
a21hQGRlbnguZGU7IHNlYW5nYTJAZ21haWwuY29tOyB4eXByb24uZ2xwa0BnbXguZGUNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSHY0IDEwLzE0XSBjbWQ6IGNwdTogYWRkIHJlbGVhc2Ugc3ViY29tbWFu
ZA0KPiANCj4gSGkgWmhpcWlhbmcsDQo+IA0KPiBPbiBXZWQsIDMxIEp1bCAyMDI0IGF0IDIwOjM3
LCBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgU2lt
b24sDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBT
aW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVs
eSAzMSwgMjAyNCAxMDozOSBQTQ0KPiA+ID4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhw
LmNvbT4NCj4gPiA+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdHJpbmlAa29uc3Vsa28uY29t
OyBQZW5nIEZhbg0KPiA+ID4gPHBlbmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb207
IG1hcmV4QGRlbnguZGU7DQo+ID4gPiBsdWttYUBkZW54LmRlOyBzZWFuZ2EyQGdtYWlsLmNvbTsg
eHlwcm9uLmdscGtAZ214LmRlDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIdjQgMTAvMTRdIGNt
ZDogY3B1OiBhZGQgcmVsZWFzZSBzdWJjb21tYW5kDQo+ID4gPg0KPiA+ID4gSGkgWmhpcWlhbmcs
DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAzMCBKdWwgMjAyNCBhdCAwMTowOSwgWmhpcWlhbmcgSG91
IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEFk
ZCBhIG5ldyBzdWJjb21tYW5kICdyZWxlYXNlJyB0byBicmluZyB1cCBhIGNvcmUgdG8gcnVuIGJh
cmVtZXRhbA0KPiA+ID4gPiBhbmQgUlRPUyBhcHBsaWNhdGlvbnMuDQo+ID4gPiA+DQo+ID4gPiA+
IEZvciBleGFtcGxlIG9uIGkuTVg4TSBQbHVzIEVWSywgcmVsZWFzZSB0aGUgTEFTVCBjb3JlIHRv
IHJ1biBhDQo+ID4gPiA+IFJUT1MgYXBwbGljYXRpb24sIHBhc3NpbmcgdGhlIHNlcXVlbmNlIG51
bWJlciBvZiB0aGUgQ1BVIGNvcmUgdG8NCj4gPiA+ID4gcmVsZWFzZSwgaGVyZSBpdCBpcyAzOg0K
PiA+ID4gPiAgICAgdS1ib290PT4gY3B1IGxpc3QNCj4gPiA+ID4gICAgICAgMDogY3B1QDAgICAg
ICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+ID4gPiAgICAg
ICAxOiBjcHVAMSAgICAgIE5YUCBpLk1YOE1QIFJldjEuMSBBNTMgYXQgMTIwMCBNSHogYXQgMzBD
DQo+ID4gPiA+ICAgICAgIDI6IGNwdUAyICAgICAgTlhQIGkuTVg4TVAgUmV2MS4xIEE1MyBhdCAx
MjAwIE1IeiBhdCAzMUMNCj4gPiA+ID4gICAgICAgMzogY3B1QDMgICAgICBOWFAgaS5NWDhNUCBS
ZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgdS1ib290
PT4gbG9hZCBtbWMgMToyIGMwMDAwMDAwIC9oZWxsb193b3JsZC5iaW4NCj4gPiA+ID4gICAgIDY2
MDA4IGJ5dGVzIHJlYWQgaW4gNSBtcyAoMTIuNiBNaUIvcykNCj4gPiA+ID4gICAgIHUtYm9vdD0+
IGRjYWNoZSBmbHVzaDsgaWNhY2hlIGZsdXNoDQo+ID4gPiA+ICAgICB1LWJvb3Q9PiBjcHUgcmVs
ZWFzZSAzIGMwMDAwMDAwDQo+ID4gPiA+ICAgICBSZWxlYXNlZCBDUFUgY29yZSAobXBpZHI6IDB4
MykgdG8gYWRkcmVzcyAweGMwMDAwMDAwDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5
OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IFY0
Og0KPiA+ID4gPiAgLSBVcGRhdGVkIHRoZSBjaGFuZ2UgbG9ncy4NCj4gPiA+ID4NCj4gPiA+ID4g
IGNtZC9jcHUuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2NtZC9jcHUuYyBiL2NtZC9jcHUu
YyBpbmRleCA5ZTMyMzA2OWI5Li4yNzU1MjUwNzU2DQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9jbWQvY3B1LmMNCj4gPiA+ID4gKysrIGIvY21kL2NwdS5jDQo+ID4gPiA+IEBAIC0zLDYg
KzMsNyBAQA0KPiA+ID4gPiAgICogQ29weXJpZ2h0IChjKSAyMDE1IEdvb2dsZSwgSW5jDQo+ID4g
PiA+ICAgKiBXcml0dGVuIGJ5IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiA+ID4g
PiAgICogQ29weXJpZ2h0IChjKSAyMDE3IMOBbHZhcm8gRmVybsOhbmRleiBSb2phcyA8bm9sdGFy
aUBnbWFpbC5jb20+DQo+ID4gPiA+ICsgKiBDb3B5cmlnaHQgMjAyNCBOWFANCj4gPiA+ID4gICAq
Lw0KPiA+ID4gPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGNvbW1hbmQuaD4NCj4gPiA+ID4gQEAgLTE4
LDYgKzE5LDE5IEBAIHN0YXRpYyBjb25zdCBjaGFyDQo+ID4gPiAqY3B1X2ZlYXR1cmVfbmFtZVtD
UFVfRkVBVF9DT1VOVF0gPSB7DQo+ID4gPiA+ICAgICAgICAgIkRldmljZSBJRCIsDQo+ID4gPiA+
ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHN0cnVjdCB1ZGV2aWNlICpjcHVfZmluZF9k
ZXZpY2UodW5zaWduZWQgbG9uZyBjcHVfaWQpIHsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdWRl
dmljZSAqZGV2Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgZm9yICh1Y2xhc3NfZmlyc3Rf
ZGV2aWNlKFVDTEFTU19DUFUsICZkZXYpOyBkZXY7DQo+ID4gPiA+ICsgICAgICAgICAgICB1Y2xh
c3NfbmV4dF9kZXZpY2UoJmRldikpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChjcHVf
aWQgPT0gZGV2X3NlcShkZXYpKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gZGV2Ow0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJl
dHVybiBOVUxMOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMgaW50IHBy
aW50X2NwdV9saXN0KGJvb2wgZGV0YWlsKSAgew0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCB1ZGV2
aWNlICpkZXY7DQo+ID4gPiA+IEBAIC04MiwxMCArOTYsMzYgQEAgc3RhdGljIGludCBkb19jcHVf
ZGV0YWlsKHN0cnVjdCBjbWRfdGJsDQo+ID4gPiA+ICpjbWR0cCwgaW50DQo+ID4gPiBmbGFnLCBp
bnQgYXJnYywNCj4gPiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4N
Cj4gPiA+ID4gK3N0YXRpYyBpbnQgZG9fY3B1X3JlbGVhc2Uoc3RydWN0IGNtZF90YmwgKmNtZHRw
LCBpbnQgZmxhZywgaW50IGFyZ2MsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
Y2hhciAqY29uc3QgYXJndltdKSB7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IHVkZXZpY2UgKmRl
djsNCj4gPiA+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIGNwdV9pZDsNCj4gPiA+ID4gKyAgICAg
ICB1bnNpZ25lZCBsb25nIGxvbmcgYm9vdF9hZGRyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAg
ICAgaWYgKGFyZ2MgIT0gMykNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVU
X1VTQUdFOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgY3B1X2lkID0gZGVjdG91bChhcmd2
WzFdLCBOVUxMKTsNCj4gPiA+DQo+ID4gPiBJIGp1c3Qgbm90aWNlZCB0aGlzLi4ubm9ybWFsbHkg
d2UgdXNlIGhleCBmb3IgcGFyYW1ldGVycy4NCj4gPg0KPiA+IFllcywgYnV0IHRoZSA8Y29yZSBJ
RD4gaXMgZnJvbSB0aGUgQ1BVIGRldmljZSBzZXF1ZW5jZSBudW1iZXIgbGlzdGVkIGJ5IHRoZQ0K
PiAnY3B1IGxpc3QnLCB3aGljaCBpcyBwcmludGVkIGluIGRlYy4gU28gSSB0aGluayB1c2UgZGVj
IHBhcmFtZXRlciBoZXJlIGlzDQo+IHJlYXNvbmFibGUuDQo+IA0KPiBXZSB3aWxsIGhhdmUgZGV2
aWNlcyB3aXRoIGh1bmRyZWRzIG9mIENQVXMgc28gZGVjaW1hbCBpcyBwcm9iYWJseSBnb2luZyB0
bw0KPiBiaXRlIHVzLiBVLUJvb3QgdXNlcyBoZXggZm9yIG1vc3QgdmFsdWVzLg0KPiANCj4gQW55
d2F5LCBsZXQncyB3b3JyeSBhYm91dCBpdCBsYXRlci4gV2hhdCB5b3UgaGF2ZSBpcyBmaW5lLg0K
DQpPa2F5LCBJIHRoaW5rIHRoZSBrZXkgcG9pbnQgaXMgdG8ga2VlcCB0aGUgQ1BVIGNvcmUgc2Vx
dWVuY2UgbnVtYmVyIGluICdsaXN0JyBzdWJjb21tYW5kIGFuZCB0aGUgaW5wdXQgPGNvcmUgSUQ+
IHVzaW5nIHRoZSBzYW1lIGZvcm1hdC4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg==
