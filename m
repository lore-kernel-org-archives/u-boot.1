Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA802C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 02:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 397E888005;
	Thu,  1 Aug 2024 04:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GDCRzLpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED4A88ACA; Thu,  1 Aug 2024 04:17:50 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9733B88005
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 04:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oen+aTBmPOkuORbCfOPsYkCNJmcFT6LWs9tRkLV4qgsum8PrcvcTNdobs+b2B777SSqLZx/cnXHHWIoFYguJlAX7NjtTFyDlsTBYhKX1WCSrrjhzFnkQyqSxQIz+984JqyGvUa06dKAzcKUXFdDj7pFabwcjaeFcCamRRsI9Q79zF/tEXt3bdNSwf2uSgaTVAaQnEaZ9g8lE4/K9Y3QX2Q7YRwmfxIlt1WFF6dquBdabo1kqCDzV0T0KrnZFfU8DnZeFPxctzSD4pX8ETA/UCKD9IjlB60e0eB/Tc8QIi01xTpJObprhrlCMTc93f46WgA5EOeByQYiwyBmrhFdnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/0eREpfKGNWz3pn/Ub2DlGkUrmhexxvyZ/3i+TJ4TI=;
 b=hCZPQa5mYGt7NKABK9w7ELNwbdtVngpQ0rRQKIAdUF6wd9GucdxYVCRwk0KxfdFOXLZo/MNQmonm4zNFzJFu++zE3RytGeiLtAcC3d9F++2sNuKv6AMi4ct8EW+Y0iOtAwrzCJu15xK7G2S9iGFLXxHorjg9VSsLj7PVPyMvD7Uq74zK27Md4vUphsEq+N7Er0djcL9f5iIDPtpYvFDPfXPc6etu2sWYGVlM6DVRxEppkfjZE5GLlzegg146tDmK1OeVu1hAEuDILeVlcklLbj4qP35hq3AdaBsgzvImm4y9PlJHdc8UpLhTm7fsOpQO0Bg6Hy96l5bFawiyL64LcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/0eREpfKGNWz3pn/Ub2DlGkUrmhexxvyZ/3i+TJ4TI=;
 b=GDCRzLpkDziGTFn1csNTJI1EiYokwr6wQmfXmIFRAQb9QspDjVUICJZ5xjCjDY3ZQ1i6Smja7U+snmALzAzcsFz+oF4r93ycCXpceNFh1su1we1iMkz8QfLx4bhcCk/DBHK7/9xxhcAgU6zoIgq/fer7YJObGrJDqKRKyyNuUpZWVqwIx6lWuMI30cozdSEm8nEBAwgexZSPKdTJyF4dzL1FvgzBgUD1JGVPmaum+LPIiBSpdlplfsSApIXXh92tLho1FNtyCXFqz3OkjiFVaQC17W5v9NiKHMEhCpZkVjwY7CWUDwSk5GR4YaY5DNOVhbGPqENT5zy7qOtFPX3NSQ==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 02:17:47 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 02:17:46 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCHv4 10/14] cmd: cpu: add release subcommand
Thread-Topic: [PATCHv4 10/14] cmd: cpu: add release subcommand
Thread-Index: AQHa4k974yUthb8PW0CksAlwGaZCHbIQ6gwAgACkHSA=
Date: Thu, 1 Aug 2024 02:17:46 +0000
Message-ID: <DB9PR04MB9236CF945D9E444C5808FC2F84B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
 <CAFLszTgzXzUym-JBNk8i+50TsN81vU=Nhs_GMzvR+jmYaqMPsQ@mail.gmail.com>
In-Reply-To: <CAFLszTgzXzUym-JBNk8i+50TsN81vU=Nhs_GMzvR+jmYaqMPsQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PA4PR04MB7776:EE_
x-ms-office365-filtering-correlation-id: b19fb74b-7310-46e2-c29e-08dcb1d02265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Q3JnRW5hQ2ErWlBlVDFSMjUyaGRxWmN6RFh6TVBIT29IcFNzU2lhbUV4OER1?=
 =?utf-8?B?bmxBUTBRV2pCYm1KR2x3bU9IQ05JZFY0QU1NS1lPeWxGeWs4L005OUdocEx2?=
 =?utf-8?B?ZHZsb1NnTnNWR3Ryd1pUcUEycGVJRGNoVElKK0U0RXIwQ3h0dmlneU9qcjF5?=
 =?utf-8?B?bEFkejVBbnlGenZ4YU16T0xlRUoxMExFSVpESFQyWFNvNEJkMlY3SHR2YUZT?=
 =?utf-8?B?bFMzaHcyZ1hQMzZ6Z3F3WE5KUWxhRGc1aldqbmtzZUNUaEVjZ1Q1aTVYUVFR?=
 =?utf-8?B?amtNbmJHMnFzQUc4anpEOUE2azJORmYzeGpQT2p1UDB6SkhuSXJCUjNCY0tE?=
 =?utf-8?B?bTFtamRIdjhPREJYeXg4bmdWcDZzaEIwSDB0ZGRNekNaOFlSOWE1aVpqY1di?=
 =?utf-8?B?aS8ydVlnRXR4S1JJR3JOVTY4OVV3RlJyNm9zb3NQTnRoeVZib0dJUzBUSmNN?=
 =?utf-8?B?b2F5QkZmUlZ3SFFyeitHaG13eWdxNmZmTlNpa3RkNXJhRGZ2QWxWc2p3UEY3?=
 =?utf-8?B?UFRwTC94YXZ1d0tqS1NxS1lhWWlqK3dUMTZLRE8vMW1VNzZSelRLM0dQZmd6?=
 =?utf-8?B?cVZmUHJYbGRFamovUHdEK2l5SGNuZmt3QnN1dG1mQTcrcWtNd0Y2WXgyR2pQ?=
 =?utf-8?B?bHBUK3NDOExGWHR3aUdDMEhuMzI0SmhiSkxob3B2ZnMwVXlmR1doTjBoaFBC?=
 =?utf-8?B?N0JmV05mSUh5SHpBOWp2WTE4b2pIbFpmMDA5ZDI2V2JDY2tkV1RKU1ptOGJh?=
 =?utf-8?B?VFp2UlU2cTdPbTlwZ29RMEt3dndPb0NnM0swMTJ0SHlSM0sreHNISDJKcXNv?=
 =?utf-8?B?elZvU0tkKzJXdnhjcmk4RVQ0WnYxcHRCQkFtbDFDN2hMT1R3YkJNTUtqZUlD?=
 =?utf-8?B?VnRxUlJhNjFIaWRrKzdGaDAzVDlNSEFBRVl1WndFRHg1VmVpckVqbUQ2ZUxv?=
 =?utf-8?B?T09sM0VCbXIwcmthbzE2ZzF1V3FrbFZzL2ZLbjVmUGYwaUowRFdHT01LcGVv?=
 =?utf-8?B?Q3B3NENKMjdJOTAzRTNYV21UWEVrSXlGdlMzS1YwZkpRRmcwVmxSV0tDM0xm?=
 =?utf-8?B?WEFpZXpWOUVRUjBCM2xnMmVjMytXME9OR3RlSHpGZ3ovSDZWTm1GRFBYMi9D?=
 =?utf-8?B?ZXJUb2JDUlJUd3dKVXpqdG8wNGZDNDltR3lJUUtKV2xQalJ0K2pTWjlpTjdk?=
 =?utf-8?B?R2NRSzhOb2RLbTM1a2hQQVlCdUwyUUcvS0RCdDdGMjJSWk8rRDNLc2x1Sng1?=
 =?utf-8?B?MDdoNmpwcUluTm4xcDg5ZllEcTNUUzlueUlxTlJ1VVNiM3J1anRtcDJMRno0?=
 =?utf-8?B?UkZkTTJQeCttRW9TUU1CeGRWWDdqUkJhVFM1b2lzb2p2a0E3dkozcEFoVGM4?=
 =?utf-8?B?NjVyczZhYlRBakN5NWlFaDVDWFZSZk1GWWVUbzEzaUdkYjhPRVVlWEl2dHZH?=
 =?utf-8?B?cHZBTnVHalBUZERDYS8zQTkrVCtrUFpHdFlOaTBzYkhaWHpOWlpIQ3ZQTHUz?=
 =?utf-8?B?ZUpjMjg2RG9GZ0dqcUFlbGc1Vk5QdTBUTk1TN2xONTdUTVc5YmV4K1pObW9o?=
 =?utf-8?B?bXZ2NmY4RXJLb3FaMGMwTGF3azFJU1pIWC8wR0E3Y1BkU3kzdFdDVWhjdldM?=
 =?utf-8?B?YjFIYnpJY094YTBVc1dTNWQ5OUtGSWFkVnlKZGlMNzN2a1lZaGFvUGVNRnFs?=
 =?utf-8?B?NXV3dUZiQm02QmFGVFlJck5yc1NSbVQ3SkIrVW9zY0FDUWtiVndKYkczNy9D?=
 =?utf-8?B?K2gvMHRWWEJuQ0MwUkQ3ckNqSUNHTGZUUDQvT0w5ZFljZEhIUmtUSTg5OUIy?=
 =?utf-8?B?UHEyd0lCSjd0Tnk5MlU5OVcvYzRmRXRTMDA2WEtnOVd1N21HMElPNGZtY0No?=
 =?utf-8?B?enNQTXJQWGFmQ3VNT2hNQ0dNM3ltaEhUSlpybm4zUE4zS2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVxRXpOOGNWbWhMd0dFdmdvTk5zRUprbGJ1ZXVTazBJS0ozZTFnSkZ4Qm9R?=
 =?utf-8?B?UU5VREtpQ3NuODRwemg1RnQyUjNMY201OTlDelZKRVpCbXdvTTQ0WUNQWjQz?=
 =?utf-8?B?MUVsTTZocDc4bnh0dmF6TVhNVXkydGt1RkhqaWhrTnR5NVhUck1nZ2ZFbHZM?=
 =?utf-8?B?MHFqWjZsR2tleWlvOFM1NFpCeERtK3NqT3B6RjBYb29lQnNPM05adEtSaE12?=
 =?utf-8?B?blc1dGtmZFJPakIvR3RaaXM1ekoyQktaYjllNzJhSHZnRUpvdktGbzU2WVd0?=
 =?utf-8?B?R3VUb2hOcnRTZ3YvcmtubE9oUWhSb2JBRWQ1Z3h1cTNJWXRNSVNnTlhOZ2Jr?=
 =?utf-8?B?aFVjZmdCd0pHNEJOdHlVbUEzZ2YwS0t4NDFaNjhXeXR4ZHFob3p6RDBhdjBw?=
 =?utf-8?B?Rm8rbjhvQ2N1QjBldzVwUStGMkJYODVaVnlHQ1RTY2lIcVNpWmFLVEFkZDRV?=
 =?utf-8?B?d0ZHdUkyZDBCazBULzVxS3hGaURLQUs5K2kvTXFvNzlhVTB1dDk3ZkJUaWJi?=
 =?utf-8?B?aDdpVFFrY05YdXFyeVVSTUxkMWVlZ25SRlo1WmZuUWNIbXVnTktLSnc5Ulhv?=
 =?utf-8?B?TWFVa3FzNlJRZHZwZjIwOUk0dElLRW90WUJhL0Erb0FDNDBIYzNqbVhZYnlq?=
 =?utf-8?B?MWFVaU1FdGhRdmJCUEdWY05GUUhuR1hTOE5mK29WNVpHd3BEaS9jemk5bFYw?=
 =?utf-8?B?bnN0OEZwOHg1RjNqVHRGTkU0Q3pJUXFyV0dVdWJJOUdkdExNcGlwdGsvOGxS?=
 =?utf-8?B?RWJ5NVVJTFp3amZ6RmpkNnJacmJVeC9ZYXBEK0JsSEN0cS9leXZqa2VlRFMr?=
 =?utf-8?B?Q3psQjQzbFI0OVlvQUVnS045U0t6amZkdWNaTkp1c21VQ3ViVGJOdjlWK2cw?=
 =?utf-8?B?RmdwbGVZck1FWEgxVHNwSUxXRHRBcWFOazlqZ0J6N1l3dFFyZ0lrN0tVRHhx?=
 =?utf-8?B?SmtLKzJUTzJZdm8ySGJIbm9aUTM4Y2ROTzAwSVh1em1abjNwVWtKblBUeFUz?=
 =?utf-8?B?R01JQ2xJRkQ1N1EwQU0ySnJFQ2FJcEFiNjJKWHdObHYrTTdjVEt1YVUrdFJn?=
 =?utf-8?B?c2lDTjZXUER2WUJ6a3J4NlRBdUpvQnl0MGRIYW1YNkxkaHg5aEFoTXJTNXpm?=
 =?utf-8?B?eUZvMDIxVjFuSnpueVdvMlQ2c2NlZFlsR3NYa2FuNUpzWjlmZ1BSQzdBb2ZD?=
 =?utf-8?B?dGU0SGhHdVF6S0JwdDlhUGxLRWh5c1E0bkZUazY0cU5nZDVVZjJER21zOWUy?=
 =?utf-8?B?Z3ZCWXB3clpseHBJZm1oaWFPSDZEUisyYlNnRm5GdFYxc3ZvYjErZEdTbHRZ?=
 =?utf-8?B?dlo1RkoxSHArTG5Fb0VRamlRRnUyR0h5NXJ6azl5V2tKRmR4R0NBQzB4S1JX?=
 =?utf-8?B?cEdTYVBqbjU0TDBreFhnM0paUDlWZDZVWG9vYnA5dDZrL3ZFRFdQRDRkUmFZ?=
 =?utf-8?B?TkwvdGY4RURNNE5wZSt4V2FySmdPU2FDQWZXelRIM2Z1OTl2SnFYTC9udzFr?=
 =?utf-8?B?RXh1c2VnZ3d0b1dmbXJrckNQUm56NzY1bUxJYnQvZUFUaHNRZjFMbzlxNWhZ?=
 =?utf-8?B?cWZvV0I4dXZSNnpwSXhiVk9ZNEhXeWJuODBUTkgzKzFkcHZtbTA0YkkzZTFG?=
 =?utf-8?B?VjZYOStCTjBwaXRMdm5XYUFLOEFDN0hvcGJvbkFJa0FiRkRoaXFzeHJ2aCtz?=
 =?utf-8?B?WXR2aGhzWmVIRHRVZGVFNEcwUG9xZEVETXBVZGtxNlZQOVdibXBqbHkwVGxz?=
 =?utf-8?B?WWJCZTBxRFZOOTBqeGhZMktFNCtpMnFpRDI5a00yNUhlbGk2eXYydjhqUmZ2?=
 =?utf-8?B?UDEzQmdLdkhTem4yMlBzU1VwczZxcEJZK3QrUHVYdjZMOGRaVmtMYTNNNEpE?=
 =?utf-8?B?NlJyYmNudmlTNEFWYXlnSEFvcEEvNXJNUkRrY1UxeTJrT051ZlIwNFBRK2Rn?=
 =?utf-8?B?S0Y1L3FkaWxtekxwWURoWW1yUjRLU2hPZjdxZlIvaTRMMUswbTBsL1JBVndQ?=
 =?utf-8?B?b0dYZHNpa0ZlODcxQzU2cnk0TzVzeG4xN1dYZVA2Y0xkRXVETTFuU2RnRGJM?=
 =?utf-8?B?MDRKVWhNQWUvU3hqNDA1bjA4NlhQdTNHRG4wKzY2Y1NvNnF4cTdkZm5qYTFM?=
 =?utf-8?Q?ZRghh0wsnekcVmbW7Y3Ig1iOl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19fb74b-7310-46e2-c29e-08dcb1d02265
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:17:46.7624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: itwhpTRD9CkUSbJ3gU5f9JyMXCFWOUsPW2g/4k3JPO3tvFSnyvufA+9w4Fs7MWwB1Lx34yIFYntQ/wl0SlPsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776
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
R2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzMSwgMjAy
NCAxMDozOSBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzog
dS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4gPHBl
bmcuZmFuQG54cC5jb20+OyBmZXN0ZXZhbUBnbWFpbC5jb207IG1hcmV4QGRlbnguZGU7DQo+IGx1
a21hQGRlbnguZGU7IHNlYW5nYTJAZ21haWwuY29tOyB4eXByb24uZ2xwa0BnbXguZGUNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSHY0IDEwLzE0XSBjbWQ6IGNwdTogYWRkIHJlbGVhc2Ugc3ViY29tbWFu
ZA0KPiANCj4gSGkgWmhpcWlhbmcsDQo+IA0KPiBPbiBUdWUsIDMwIEp1bCAyMDI0IGF0IDAxOjA5
LCBaaGlxaWFuZyBIb3UgPFpoaXFpYW5nLkhvdUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBBZGQgYSBu
ZXcgc3ViY29tbWFuZCAncmVsZWFzZScgdG8gYnJpbmcgdXAgYSBjb3JlIHRvIHJ1biBiYXJlbWV0
YWwgYW5kDQo+ID4gUlRPUyBhcHBsaWNhdGlvbnMuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSBvbiBp
Lk1YOE0gUGx1cyBFVkssIHJlbGVhc2UgdGhlIExBU1QgY29yZSB0byBydW4gYSBSVE9TDQo+ID4g
YXBwbGljYXRpb24sIHBhc3NpbmcgdGhlIHNlcXVlbmNlIG51bWJlciBvZiB0aGUgQ1BVIGNvcmUg
dG8gcmVsZWFzZSwNCj4gPiBoZXJlIGl0IGlzIDM6DQo+ID4gICAgIHUtYm9vdD0+IGNwdSBsaXN0
DQo+ID4gICAgICAgMDogY3B1QDAgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAg
TUh6IGF0IDMxQw0KPiA+ICAgICAgIDE6IGNwdUAxICAgICAgTlhQIGkuTVg4TVAgUmV2MS4xIEE1
MyBhdCAxMjAwIE1IeiBhdCAzMEMNCj4gPiAgICAgICAyOiBjcHVAMiAgICAgIE5YUCBpLk1YOE1Q
IFJldjEuMSBBNTMgYXQgMTIwMCBNSHogYXQgMzFDDQo+ID4gICAgICAgMzogY3B1QDMgICAgICBO
WFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+DQo+ID4gICAgIHUt
Ym9vdD0+IGxvYWQgbW1jIDE6MiBjMDAwMDAwMCAvaGVsbG9fd29ybGQuYmluDQo+ID4gICAgIDY2
MDA4IGJ5dGVzIHJlYWQgaW4gNSBtcyAoMTIuNiBNaUIvcykNCj4gPiAgICAgdS1ib290PT4gZGNh
Y2hlIGZsdXNoOyBpY2FjaGUgZmx1c2gNCj4gPiAgICAgdS1ib290PT4gY3B1IHJlbGVhc2UgMyBj
MDAwMDAwMA0KPiA+ICAgICBSZWxlYXNlZCBDUFUgY29yZSAobXBpZHI6IDB4MykgdG8gYWRkcmVz
cyAweGMwMDAwMDAwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFp
YW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9t
aXVtLm9yZz4NCj4gPiAtLS0NCj4gPiBWNDoNCj4gPiAgLSBVcGRhdGVkIHRoZSBjaGFuZ2UgbG9n
cy4NCj4gPg0KPiA+ICBjbWQvY3B1LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9jbWQvY3B1LmMgYi9jbWQvY3B1
LmMNCj4gPiBpbmRleCA5ZTMyMzA2OWI5Li4yNzU1MjUwNzU2IDEwMDY0NA0KPiA+IC0tLSBhL2Nt
ZC9jcHUuYw0KPiA+ICsrKyBiL2NtZC9jcHUuYw0KPiA+IEBAIC0zLDYgKzMsNyBAQA0KPiA+ICAg
KiBDb3B5cmlnaHQgKGMpIDIwMTUgR29vZ2xlLCBJbmMNCj4gPiAgICogV3JpdHRlbiBieSBTaW1v
biBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gPiAgICogQ29weXJpZ2h0IChjKSAyMDE3IMOB
bHZhcm8gRmVybsOhbmRleiBSb2phcyA8bm9sdGFyaUBnbWFpbC5jb20+DQo+ID4gKyAqIENvcHly
aWdodCAyMDI0IE5YUA0KPiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVkZSA8Y29tbWFuZC5oPg0K
PiA+IEBAIC0xOCw2ICsxOSwxOSBAQCBzdGF0aWMgY29uc3QgY2hhcg0KPiAqY3B1X2ZlYXR1cmVf
bmFtZVtDUFVfRkVBVF9DT1VOVF0gPSB7DQo+ID4gICAgICAgICAiRGV2aWNlIElEIiwNCj4gPiAg
fTsNCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHVkZXZpY2UgKmNwdV9maW5kX2RldmljZSh1bnNp
Z25lZCBsb25nIGNwdV9pZCkgew0KPiA+ICsgICAgICAgc3RydWN0IHVkZXZpY2UgKmRldjsNCj4g
PiArDQo+ID4gKyAgICAgICBmb3IgKHVjbGFzc19maXJzdF9kZXZpY2UoVUNMQVNTX0NQVSwgJmRl
dik7IGRldjsNCj4gPiArICAgICAgICAgICAgdWNsYXNzX25leHRfZGV2aWNlKCZkZXYpKSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGlmIChjcHVfaWQgPT0gZGV2X3NlcShkZXYpKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiBkZXY7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgcHJp
bnRfY3B1X2xpc3QoYm9vbCBkZXRhaWwpICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgdWRldmljZSAq
ZGV2Ow0KPiA+IEBAIC04MiwxMCArOTYsMzYgQEAgc3RhdGljIGludCBkb19jcHVfZGV0YWlsKHN0
cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50DQo+IGZsYWcsIGludCBhcmdjLA0KPiA+ICAgICAgICAg
cmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IGRvX2NwdV9yZWxlYXNlKHN0
cnVjdCBjbWRfdGJsICpjbWR0cCwgaW50IGZsYWcsIGludCBhcmdjLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgY2hhciAqY29uc3QgYXJndltdKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qg
dWRldmljZSAqZGV2Ow0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBjcHVfaWQ7DQo+ID4gKyAg
ICAgICB1bnNpZ25lZCBsb25nIGxvbmcgYm9vdF9hZGRyOw0KPiA+ICsNCj4gPiArICAgICAgIGlm
IChhcmdjICE9IDMpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX1VTQUdFOw0K
PiA+ICsNCj4gPiArICAgICAgIGNwdV9pZCA9IGRlY3RvdWwoYXJndlsxXSwgTlVMTCk7DQo+IA0K
PiBJIGp1c3Qgbm90aWNlZCB0aGlzLi4ubm9ybWFsbHkgd2UgdXNlIGhleCBmb3IgcGFyYW1ldGVy
cy4NCg0KWWVzLCBidXQgdGhlIDxjb3JlIElEPiBpcyBmcm9tIHRoZSBDUFUgZGV2aWNlIHNlcXVl
bmNlIG51bWJlciBsaXN0ZWQgYnkgdGhlICdjcHUgbGlzdCcsIHdoaWNoIGlzIHByaW50ZWQgaW4g
ZGVjLiBTbyBJIHRoaW5rIHVzZSBkZWMgcGFyYW1ldGVyIGhlcmUgaXMgcmVhc29uYWJsZS4NCg0K
VGhhbmtzLA0KWmhpcWlhbmcNCg0K
