Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F694C35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9DC88E2C;
	Tue, 17 Sep 2024 14:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RJiFRJP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD90188E0D; Tue, 17 Sep 2024 14:23:12 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010C988DB3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luYJoBAqI64YmaseFW8ae3oRP86UanAugyXsNaoRg1nhEq9yTr6HJaUJzECO+N00BbpkY3Lns3g+jrKvbr3bI0I4+mDAkNdD27Gv8hqMSZrl20x58N6IbpIoe2KpzPWbJURHDcdrQs+vQQf5XKDRmdPMG2dtccbh0MnO1eL1Jvj3DogUd1u8qwCnUGhit/u7BQJTvzK1a3duNyWqf3vWjb/Vh0mFp7WpE3SOtZuxzh86RqZFo+cFQWV020kis5Q9XSGkXdWtnTAVV18RqI47fF3bbeZR7SYzYhHdpBEegpTWB0qtn72Do5hCcpq+ELN9FRXFCkdRKwJRWq59EbDQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZNy87FfKOYIeCaPQljeVe+FgwI8gTLwbjk0zS+IWtE=;
 b=tJvexxywiLYQEUrQ8VIPxDrfbQvdYNqkRoLI0BKcKcj57Df09vN7cVPGqH0ssNvDPQS8VA1LWLnUU2nFcZo2RW/TchoWlIKPb0bV6elx/2Yk1mTwIxpjypoPuonhQf/ywimpeJDGqCMiwPfp3qifF1a1Zlocn7MjakrLT3HFDhT4cojQpE0r/GCUygGiGwAvtqlurTo19lx6fZ/eAh8UZylsa3rRac/kCjEef60XFhg0vrPVPIAzEz7rEuJ7t2rzTxW0UaRt59yR8DPwQ8qsno/juTGvap0ehlJyA9uLrqF3Z1IvcDzHsuozugx8Wph+Jzyb5rxv09eKAqADXu9G8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZNy87FfKOYIeCaPQljeVe+FgwI8gTLwbjk0zS+IWtE=;
 b=RJiFRJP79de2XYwIBdH/5k4Mmlf9lDVBl8jg2+FyeU6OaUtLPFNw7ZiiDvo893/gNTBxZDoIRYwuCr9v4dmTOLl0M7Z5yBjfKoqmdbTCbysypfsWktBWclZt69k2lbrYm8xdNrvg3dV1qqtdXiOIjn6XLdUjot/WJHwcD5QyXhQnvvV6r71bSM8qy6CIy5VRmCTqcgDk/aY5cEAszqT3kBONfMGZsYZucJ5zSc/7/HKUeeXFb6tk8XQb0+QHLTY31C4slME65DJm8J1JprUlPDvCo8qQDIbWTBTIOvhdmfPffhqA1QFd3cABn9bSftZE2DZo015rQq3q9dDFAcTjjQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10207.eurprd04.prod.outlook.com (2603:10a6:102:463::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 12:23:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:23:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Topic: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
Thread-Index: AQHbCKmwtXn5HoU12EiUCrPjGGILZbJb5UYAgAAB7dA=
Date: Tue, 17 Sep 2024 12:23:09 +0000
Message-ID: <PAXPR04MB8459F41C85BADE5C6DC4A31A88612@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
 <CAOMZO5CQSixQgB173VjNDhxa6W9i9HdjO3122B+5iQZO_8D6GA@mail.gmail.com>
In-Reply-To: <CAOMZO5CQSixQgB173VjNDhxa6W9i9HdjO3122B+5iQZO_8D6GA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10207:EE_
x-ms-office365-filtering-correlation-id: 5c9131f3-1be3-4bde-ca7c-08dcd7137dcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHAra1BBZkdZM1FKSFZJalhJQkJjaUFRUEtLa0xBa2tUeDZQSlIxSmMwOTNM?=
 =?utf-8?B?S09maStVdy92MnZsK2hrbk1OZk92UXE3c0k2dDdNcWltTlFoUTNJNXJ1KzlS?=
 =?utf-8?B?cVlsUk9wK3hEbll1N281YmtqZnIzc3BxdWd1Y2dDUzhtY28yY1NpZXBnQXVD?=
 =?utf-8?B?L0x4bHJwUzY4SDRyV1JsTXR3c1B4QndQdmhDbkpDWjZpUTB1a3RQS2k2ZWRB?=
 =?utf-8?B?ZGtTd01MRFlMcmtKYWFzVlJPdnExc1pGYS9mNEUzR1pOUDhpOXVpKzFiczNu?=
 =?utf-8?B?alQ5MkhDVE9yS2ZHNDFSWUEvKzEwZ1F2WjJvakdsdnp1V0ZZbDhFTk1ZL1ZK?=
 =?utf-8?B?Z0M5bmVwU3VwU0JlemNYcUxwRlBqZDQxSmtsbTM2MHhTdGNQcGx5MGxVUWZT?=
 =?utf-8?B?eTliRkhJMnc4dDBlWGNCN0hWTnMrY0xSV0FUeGtYcnZ2ZnE0VnB6VXVnMjU5?=
 =?utf-8?B?OHRndjdQckE3NTMyWjVrRHNXUk0wc1BMdnpaMHJDZHh0RWxrOHU1U1hOaWQz?=
 =?utf-8?B?VE1Cend4b3Rac2l5bVkrdWZjYUJtcFMwdjNzdGt3Z0xUM2ZsSDFVODJFaG5m?=
 =?utf-8?B?T3pYZWhEb2tPSWhRM056SmxYZk1WdTZIbW84UG5qTkNpcVpVQTE4WWxkTHpO?=
 =?utf-8?B?M0FNV1VaYUprZUc5S2ZZV2J2Z1REa3ptajNSb1VLTnBaTURCKzJ1TkVvMUpo?=
 =?utf-8?B?aTNXRTBpVGhaNHppL2twZXgwbU1Mb1pnUDdOZStlbGlER1hDUkJ2TEFTcnRE?=
 =?utf-8?B?MldtbElTdmtEb242cHk3bzhRM0thVWNCczdRbjlPdnFHdGpIbVY1bEJyODkw?=
 =?utf-8?B?Zm96T1o2UnB2ZkM0SjFMS0krWEFKN3J6bWZBb0Zvckh2ZlNmUXpuQis2Wnl4?=
 =?utf-8?B?YjVUei9sTmdzaHlaSWhkdW1zUUl6MWNOaEsrTHZsSFlVR2xkR0k4eU9SOTFo?=
 =?utf-8?B?YTNROGlkQ0lOYjJ5SVNBK3M5ekVpcUJGdmd0bEQxTHdHVTNSVDMwdVQxNmFr?=
 =?utf-8?B?R0svOUlKeDg1QXh5QkpibVh5Q2haYVhlcytLYmtNcGFFalM1eW5wN0RRNWZM?=
 =?utf-8?B?VzNjOG5qRndwaDJiV25vZlk0alhHMTBoMURZeExEWWtrdHBad3Nmb3A0Q3Ez?=
 =?utf-8?B?TVF1Yzc3dHVGb2lNL3d6TWs2U285NmQ2ZjRNRitkeWxaeTB1SEFTOEEvQ2tl?=
 =?utf-8?B?cGRxWW8wdnExMWthbno5QkJJekIxMnFTc3p4c1I2QUVpMmFHOEdWV3g1Wmsz?=
 =?utf-8?B?a201aEU0SFhyUFFsdFh4cU0zcWJQOGs4SE05K2xLaGJ4ME4zSE5FbEdJZEdy?=
 =?utf-8?B?aytZU1RFN0RxcjVEeUxhU0pZRGlyYkh3SmpYSGU2Z3JFVlNBVlQ2RlQ2cXhm?=
 =?utf-8?B?NmVXSDF4OEpPWE9uNEkyNUxMaEltUHdhcEZDYThCK2Mzdkk5bFVtSUlRSVN0?=
 =?utf-8?B?QnVyN0diL0JDVzlrSU82ZCt6UitmS09IcjRac0s0bks5d3dnRDl5TURyNnFx?=
 =?utf-8?B?clhDZUNKbVZZOVQwRkp5ZVBtL1UxSkNDbmlubmlueks2d3IwUS9XWUNRVGhk?=
 =?utf-8?B?ZjdRaVdyVWt0d29IY3hSM3g1ZklnZlNWTkJDYUJtK2tKdXRIZnNramU2NGZG?=
 =?utf-8?B?SmtYZXp3UVQ5WFpEM0hiVnNOR1N4NHlkODFOdUp3TU9OclpYUXJmZ2U1Mmx5?=
 =?utf-8?B?eFcvS2lQOW9lVDBrUlVxbzZnZkRaSEZLdWNKNStMVXBXREUySWZpTXBuUW1O?=
 =?utf-8?B?OVRJdUhwTThXcVJkblpkREtYbGZDTm1UaFluMURlOFBVeHlpS2l5bUNlYXp1?=
 =?utf-8?B?bHRqNXBZRElyZzB3TjZmbUxLQnNOMXpCeGE1blpEWFFud3RMeVYyVU5PRHk5?=
 =?utf-8?B?dmkrSDNUUUNnbnF3eXZxZ1FOajQ3dWd1eTU2REZOWWEvcnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNkZjQzVnhNMk5rQ1JqTWZycGUxWEExUEVGUzFOQk1OWUR1SmpCTHBHN2lP?=
 =?utf-8?B?eXIwOWpDKzVqRm5nTVhBVU5JLzNWVCtObGFhVkN3d3RUK1FZcmJYaU1rMFdX?=
 =?utf-8?B?T2k1TEVDTnllbGZENlE1K1UwL29ORWl6S1JpK1dmeWVJTExSVE1IMFc0OG9a?=
 =?utf-8?B?a1dHRGVzUW1JeXRpZ0dLT2VLbVNKMmxhQ3U5cHg1N0grVGxjZHc3Sm5ESkFP?=
 =?utf-8?B?NG9lN1FlTy91ZFJKQTlzVm5KbTJsNWp6a2pRbDNwU29TKzFOMGdpdXRqZ0ZX?=
 =?utf-8?B?a3NIaXRSVFFialhUbDhTMXU1OHR3eHViemNVZ0hZaHFRU1d2aTVoN05LWVE3?=
 =?utf-8?B?QmlPeU1vTnQwMVFvazhZbXpDVUEzRlcrQ1dBdHh3TWpiY2xiRDdIdUNuWURj?=
 =?utf-8?B?YlVFQ1NvQnYxTGtIQUxZdDNWdDRFWkQvQ2RPYmtPWXloWkQ4THFUenk5UENI?=
 =?utf-8?B?QTVoYWhsSG5zRUNURGI0TkVqS0huQTNxRWhkaWYxTzNhMGlBTFY4NlBFdzZC?=
 =?utf-8?B?V21GNUJESFA4R01MT1R6a3JPWS9IQXpvSS8vQjQ3UXliRms0ZWtvL3pXOWlS?=
 =?utf-8?B?Q3VsRkI1bTh5di95b1NLMFVRTGRYNTJoY05BaW1vL3UzOFFLSnllMldPRlBG?=
 =?utf-8?B?dWx4WWwrMG1KMWJZQVlHMnlaS1BmTkJSNUJ2NnMvS1ZubWZ4bmxVRUliZXh6?=
 =?utf-8?B?RWk4THBScFcyY2l2ZVIwa0RZOUwxS1U3UlY1U3l0ZHNZQjI5QkR5Z0xOb2I4?=
 =?utf-8?B?UU9lUnJSdWFpWUl1aTRRTTBlakZSSXNJd05QVWxFMXhISFpOYWhIVWlLbWZW?=
 =?utf-8?B?bHJ6Si9JZXYvS3pPb3ljSTJzV0xJYkNGTnA3YWZaMnVaZnR2ZXNUbHRjMFc0?=
 =?utf-8?B?ajBTeWJ3WTdORXZFY1EzeEpLNjViN21iaGxIcWVtMSsyMld4WGcwYTRBQUdH?=
 =?utf-8?B?TmhxN2orVVRVa0FYcHZNallHdnQ1YW5HU0MzaGlGR2YzN2VtVnVYeURsQlk0?=
 =?utf-8?B?bkNLb2tYNHIxQ2FPMHFkdXQyOTE5Nzg2TFd5RTlNSW0vVUpvRWtHQ1BYSjJB?=
 =?utf-8?B?UTVMdi9ybXY5VXFBTmhGUytJUW9oekN3NUR4b1VaL3NYQ0hSUUJVRXROSEZm?=
 =?utf-8?B?Tmo5RHhtdStWV3dvcHVVUTZTQnlmYUJ0NDMvcE1ORnNHMStIS0IvUTNEdDdO?=
 =?utf-8?B?UXBsYWpYZC9ZQ0cvUGJKUkRyclcxWjJBM05Gd1h0RXZQNGZMOFdXOWpOV1lX?=
 =?utf-8?B?eUMzNGJ3dFB2eHRzazFHcHdDV1IvcHhzdjVGUUlvNVBWOHlOMkN6ZUIxRGoz?=
 =?utf-8?B?cVNTbEhsQUdETlB4eSs0RkhDWFIxRlNVWWdQY3F1SkF4NGcwQXpVR3VYK3BU?=
 =?utf-8?B?NVdPQ3lxWXQvWW84RVFYcHBJKzJiM2VUR0tQRCtBSGY1MmZVMEU3clFMdS9h?=
 =?utf-8?B?aXJaUWsrWHQyRVdxT2RwNXZiQ08zZSswWVNhYnNzejNWbXlOZHh2RXFubkQr?=
 =?utf-8?B?SGpncGxHYkp1KzZpZ2d6ZjRTdWtKZC9wNWppK1FSdjhvQk45ZCtIeVJXMnRz?=
 =?utf-8?B?UEVKMFJacklOWEgzdFV5NUxiT3RncmZad00xUWIxYklYdXdLTGN2WjJxWEk3?=
 =?utf-8?B?aTRENTc1RENIVkljOGhRdTRHN0xNaE9wRG9FVHloQkZFWkJMeEpyQ0dLalp6?=
 =?utf-8?B?VnB5VEdsSkpLbWRmM05PeWwrNDVaWGNEbkRxQXZoam5JL08xSi9Ed0JYRU11?=
 =?utf-8?B?ZTFqZHh5aWY5UXMxTG1vV3Bobi9mK2NmTFRramc4cUpDTFRKRFZud1kvdVpF?=
 =?utf-8?B?U1d2MnY0V2NyeVVLYmNKZXZHNldBME9ack5HWVF2QTNJZUFyLzdpWkVydEEw?=
 =?utf-8?B?cTRER0pjKzMxOU1JYzJndWZMb2lQOTAzYzVDYmliazQ1VUZRTGN6dHF4SkRy?=
 =?utf-8?B?dHZsaVZ6MkhWNzF2U3FENGZ3WnR2L3ZwSm95SnVXU25kK0VnQXdsbHN2dkFN?=
 =?utf-8?B?SnlmSlduc0pIcS82T01DeVAvWVJJN005czNYRTVuZGRtTHFLL1ZuRXpwOU5D?=
 =?utf-8?B?UDE0bXVBWVNhY1RURm1sd2l2UEFJODZ2ZUcreG9qR3BaajJWYS9rYUxRNStj?=
 =?utf-8?Q?qPlU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9131f3-1be3-4bde-ca7c-08dcd7137dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:23:09.4297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUeFL9LWwm8mPigXwvayyqatuAehgdLqsL+f8/0s1Onlgq7QDXqIkHyJzdt6DWWPdRsMPyU6yWaYwSmeRtRFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10207
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIxLzIxXSBpbXg5M19ldms6IEVuYWJsZSBNLjIgVlBDSWVf
M1YzIGFuZA0KPiBkZWFzc2VydCBTRDNfblJTVA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIE1v
biwgU2VwIDE2LCAyMDI0IGF0IDExOjMx4oCvUE0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFu
QG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFllIExpIDx5ZS5saUBueHAuY29t
Pg0KPiA+DQo+ID4gVlBDSWVfM1YzIGlzIHVzZWQgdG8gc3VwcGx5IHRoZSBwb3dlciB0byBNLjIg
Y2FyZCwgd2UgbXVzdCBlbmFibGUNCj4gaXQNCj4gPiBiZWZvcmUgdXNpbmcgdGhlIGZsYXNoLg0K
PiANCj4gRmxhc2g/IFdoaWNoIGZsYXNoIGFyZSB5b3UgcmVmZXJyaW5nIHRvPw0KDQpUaGVyZSBp
cyBhIG10MjVxdTUxMmFiYjhlMTIgZmxhc2ggY29ubmVjdGVkIHdpdGggZmxleHNwaSBpbnRlcmZh
Y2UuDQoNClJlZ2FyZHMsDQpQZW5nLg0K
