Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C55CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC1883771;
	Thu, 16 Oct 2025 15:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="acD4zXeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4090832BC; Thu, 16 Oct 2025 05:35:45 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF80800D7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 05:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQs9f8CoaR5TvLQEFOFIynANlZCXqGCaPsBojBdCjLMc5uohoT2qTSkJ0RYNDA+L727wtYpPFn6pAIh2rwgKKYybg/chwhwXoC0rKWzPHU/AjMdOa810k8N1lals7AQO+QtwK0G3ewy+uWPOCljDWYb/EBl3XAlRDRbw74yMVyCP43Z5DJbjd084iFbTVP0gaDQ5zfoNWot+Ie4D/rCv/k4WphFnsfhtb3JePjYRMyPO2PInSkZxeiE/Kz4YRzmNKJTq33357DE37duic9gFbxKqvMhxSdoOu1zWJJt+wSTh0w0JLzCP9Hk4c53iGLltK0ho2lBgcEKxUHdsN+wlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdxL7wcYBfklbGvgLSOX1c9PWXoiSVq+w3vrtZbowow=;
 b=tPNgnx07djDGTB+4EDFJrfeefHt8gB6hDXikEkPwbuhEzgI4yff/XId9WPZwNWOVUOBPekF+EVGRtdCsxEuwh0Lyg1USW4XD12q+Yl4f135+My5URQ+6NPFmzLHdFbbg9uUJi9o6Dzx8qkSBFQXOkWiG/aYvyE4ptbOJQDLLV1bsfaABQBuBU3bUJdgH6sOVibVB0biMZjlqsxJ+3XLfmBKCR3smekfza3W+o5gwBFEcJRVzGqmkCOi1a/8WAGZCsCIFd1WxEAl4WLmUDELkpS/Ph7A5YvKbRFNm11189hXI/b/JWJAz4RmJrKIhnYUDi070jlvI/kPXOjm80gINSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdxL7wcYBfklbGvgLSOX1c9PWXoiSVq+w3vrtZbowow=;
 b=acD4zXeEZ4RSxtCP4p+7UVnJEZ6VvyGW/nnkdTgf2M0xsjVkLo43APevDdq9t4vvIpw1MFq6JNH7pG8BQPKH8LNtBvRLX8ujpF+Q7VQu/ABjGqcWSYCWP/4mNixrxAHpNF3J5YOVRi3IT3ko0owzR892lAnv1fb6Zc9ej662jRlHqIZEdviMVF9azT/5IJXpQMR1uLDBzLRovus1e7hzCFFykQz51sXdC7SwFA5oAxa0E9pGDFezPq5HzgXo4kVSr/UyInI47WJ3FDkF01Fqn0fOsLoaz8ZMdOMg9C10m2nC+4AdchGnmFrHHAAIkK3q5cbQ/nmrSGJIQwEMdbX3RQ==
Received: from BY1PR03MB7190.namprd03.prod.outlook.com (2603:10b6:a03:52d::10)
 by SJ0PR03MB5549.namprd03.prod.outlook.com (2603:10b6:a03:281::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 03:35:40 +0000
Received: from BY1PR03MB7190.namprd03.prod.outlook.com
 ([fe80::554b:ee27:5c43:7ea0]) by BY1PR03MB7190.namprd03.prod.outlook.com
 ([fe80::554b:ee27:5c43:7ea0%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:35:40 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: Jagan Teki <jagan@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: RE: [PATCH v1 2/2] spi: Enable Kconfig and Makefile for xSPI
Thread-Topic: [PATCH v1 2/2] spi: Enable Kconfig and Makefile for xSPI
Thread-Index: AQHcPPNJE3oBiqbEs02CNISba3k18LTDyTEAgABYjHA=
Date: Thu, 16 Oct 2025 03:35:40 +0000
Message-ID: <BY1PR03MB7190AE015407D2A34A2B6131B4E9A@BY1PR03MB7190.namprd03.prod.outlook.com>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
 <20251014101354.11182-3-boon.khai.ng@altera.com>
 <20251015221752.GV6113@bill-the-cat>
In-Reply-To: <20251015221752.GV6113@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR03MB7190:EE_|SJ0PR03MB5549:EE_
x-ms-office365-filtering-correlation-id: b3c07c5e-7ca2-4e67-ad69-08de0c651464
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kfKMHGS/8XOnC10QMGUlRpYwnigVZNcX0DIEUMs154OmuoyBfjTnD9U+Uj8n?=
 =?us-ascii?Q?UOPAida5Ei1eOugkwOc6GnhcsnUHFZGeEq58de9mz77BJz/WQHkSvl24lhRH?=
 =?us-ascii?Q?W/IDsYwUdsEDmmp12poHFMcT5O72/JPLwLorrIyOh0zaumzgxnjhfh6LoiRL?=
 =?us-ascii?Q?Zzqm2NzRDYoJZtqoRdpGuL7mEAQCSKL1SdvN5msbj2lx0+Dys1YILvUcvme6?=
 =?us-ascii?Q?AD0Q58aphsDxvDvmG02mjJAws4o4U3l/X4fVnzvqgzeqjpTcOZXqrXryDysZ?=
 =?us-ascii?Q?U/qrxoEd0RsguPFF4oCtQ4kaGeBPhqQxlji+qvJ4DVkDfFAevT7hhs8tZC41?=
 =?us-ascii?Q?TTCkuBG2X2fXxxVNY4cltFgbuG5Ge5neS8KstmtfdwlrRPh+5p5jhrHBnIfP?=
 =?us-ascii?Q?7bNnvMg+QdEj4mzGhcprhR3qbaRcT4FYuB5femnAqx+tfR8oocSX/IQiAE9O?=
 =?us-ascii?Q?XfvtgrOsEBvFwZw+hMFggg0bwyFy0+4aiF+8tRNu2aigwuncc+R0S/kcBcJt?=
 =?us-ascii?Q?IImrilsm5MKlfee0UFB1KAisr6MnAzGFkfqxG4T3Y06vzu/lBAuHYhevHLAq?=
 =?us-ascii?Q?JRgo4e4uvYkF3afT0n4HpdGQJuG1D4PWtmA8kqbXQXXgr2EqLMeYSaMPtl1l?=
 =?us-ascii?Q?ynMTwhktPqTXXAWUVSgC1XVBAzsG5u5hcjtJASH5nA59jcTxjkB0l8p3K6Vi?=
 =?us-ascii?Q?Ya9CMSp249mzA2VthRjdW5B0BGIcTCM9HH9vowXUj7zadiOT/EyefWB1a7da?=
 =?us-ascii?Q?vSHFzBnZAWiGQ9nB+pDTEbE1+WcwHnAJBsf6fF44Z1CSrVQoIoOz73PBmEXH?=
 =?us-ascii?Q?ud4F2PgPWp0C711loJ1Jomwj18d2Ty2HTl+dl9rqWZ6WORzI9nKOeCvuK0CM?=
 =?us-ascii?Q?n5Q015mJZVUXvmsflWTsksFEn6Iu1uwU5mv8Lmnx2TBrmlG0juZnHIPuhmph?=
 =?us-ascii?Q?NKq8NOFX/+D1dRk7ssvZksBBBR5ATMQ4K5usr3+NXKcvxOoTjTY472o9kg45?=
 =?us-ascii?Q?A0cI3IESb0c3lyKJVgO3hZINniD6TLdKqULwam7Bj0Ppxlpp6/h4kZjH1dw0?=
 =?us-ascii?Q?/JxG+Vmy9hhEuta5Ne3zN0ZgeZytA933rcoyiy21f0qZ6WJVeJ4bQKy3nvjb?=
 =?us-ascii?Q?W3pCwjMeuQX+qjqJcbU0A4EB+kHAF+ZYqQ3t056BM07u5XE+BMaCMyZHx51P?=
 =?us-ascii?Q?0kdutTysXsyvdPm5T9Ujeq1FXkQWuYDGMeIJiXJyGzU6lSXGlTucfS+wIcxf?=
 =?us-ascii?Q?2mjDpCttqWAgATkQLWIZbdE6uFrtQRwEA7cuIAMSG5VpP0mX4GguboIbHgSa?=
 =?us-ascii?Q?3nqoDlKfVSwifZxcPF5PdnHyoI+ORV0vwNSQTWEwC87DA0zuWYs5iF8p48ht?=
 =?us-ascii?Q?ry2ncG9GAeNRiezosRqECzHEELUy2ND3du5Neynvot/fy3pIFEgyr3vyCUrZ?=
 =?us-ascii?Q?BFgwLqvNA3WinC3QLlGoGwERtswbFu3ChuPd5IRHdHXBMW8LV8SO7GRIeVML?=
 =?us-ascii?Q?DCaIKT0auMYcxedHPcFMSgH/2gbEDWzN6kpy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR03MB7190.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G66tlKwYL5d446YVdCzolULHn1uOPqulaGpypEYpXgyPW5tGvSgoSpU7jpoL?=
 =?us-ascii?Q?hO5NPxIAuXl+PX6Oqtdjn0aF+RYTJzGxVYcu6zstBcgGe5QgsAn29kIitdrn?=
 =?us-ascii?Q?L9S/AeYGjZUKpealigUbXFuKFxFLHqetGkrr+LwITvyi4na1KmPr2vrV/Sm9?=
 =?us-ascii?Q?HWG6PxPAahAoffbEXwAvbqkQ7AOQ0A9OXu2bOJImDMFmRrfK+pJcXHnT0VtS?=
 =?us-ascii?Q?wLRO69033Om1FcUsTdJG5D0X48LdvIVKXjNVj1cx/3yhRxCHNzwqqXpEQ/3+?=
 =?us-ascii?Q?HZxvhM83H3bvDm3HPoLgIQTVtd/hGyJPwFsQRQ5GPaiNz9GVUwaj2ihCvKvq?=
 =?us-ascii?Q?OIEgJMNlp1QIM4Pyujza+JSu462xBA/8FQk2YMvJwU56ZG2hPj424ZNNv/5y?=
 =?us-ascii?Q?9448AGFX57EleJz9TVEKQJCkVRuCwgHFzgjHgWAc74ayPWvA3oxuDqOlLSxn?=
 =?us-ascii?Q?CfjamnnlC85fQoeG9RLw1AhVjY9iHuxXTshCRwISiA5X+DfOv7hd+j4jNp7I?=
 =?us-ascii?Q?WL8nTQtZ0xQ+kjE0DPv8a3wR3AmE68AONS2KEz02xZCPImuwE0Fx8z2+cJjn?=
 =?us-ascii?Q?O9VeXAKNNF8ZkWRKONKWEFC/PWFkjUvtuRfumSFP8GM/yh5eclc/E7sp+uDP?=
 =?us-ascii?Q?GlN/SuGqtx8F8X8ORpUzyeBrRz8fbZssnjiqiBE4mBf+05lnN9YtxHBUUGeK?=
 =?us-ascii?Q?kPxC+NGjmQNXPtRIN0yYC7rH1DGhxCPW2kCACPjsu6Yx4qyDeJ7a5upzvCDM?=
 =?us-ascii?Q?AN2oTYJ9IyskF5PdZ1/6RBc8TNAQxcxjFqmiTjMwkRZJGQc5rXMKpICLII6U?=
 =?us-ascii?Q?As3IiS88RuDqkJMofuRomDr0Yo8xxxypQ/ozdN8v5mTeTIzc/pgBPK3inkm5?=
 =?us-ascii?Q?x1LVYHAWLYkzJfo3gwJguc5PvsaAN0iSf4yqBcxopof7mOu2gYvycizXou37?=
 =?us-ascii?Q?ZXAj2haGdTSA157TcgVoF8+ycHkUI5VfqJfMIKSXDp3LDpQM7kx14x1utVJU?=
 =?us-ascii?Q?Uh3oDc5xA14WfNULP2iJ3osM0XPGcprftyDFZRfrzSyrc/H5THUGPZP+CyQW?=
 =?us-ascii?Q?ErxF7nqGtFM4fH49Z4TEGSrReqIAvYsnJw1r7H5N2cXGMBh093mjBeHNrHp+?=
 =?us-ascii?Q?ANOb/hnTepGBZqFZGRwbLKKvPyPnBzLh6vGy0S2aKmi+n0MovqYGbS8hsfda?=
 =?us-ascii?Q?F1puqfAlgnHm3gGCx0tCq9VEvVjzRhqfF1oeLX6BnkZolC9uomm7Iq5AL9Ks?=
 =?us-ascii?Q?6ijhvCIVmzO+Td6pBURvLcSvJZgkaSgN/o9I2hVTw5OGx6AsaNKCCkGlAPLF?=
 =?us-ascii?Q?xOLiZnYFRk5TH1yXM+U2ltOQmzoBSK91nq71tZ2mttmoZjZUxjs88bKdM9op?=
 =?us-ascii?Q?WsZ2ucsDwahvQYMaAc4nIZRoBcmIATf17aXvtRBF8nTNGrsR7lKvS2C5di0+?=
 =?us-ascii?Q?FfZWHjM5eZFsdiiuNT68wjL6IlGFmq3P/BG/MC7ADM1Ixvpfb/RF3fCeIBtS?=
 =?us-ascii?Q?AG/9vEFFBGmxznCordzkoRrhQd7hr++PsXnWhTPYXUOyMvFsWdAtmSmz9EzY?=
 =?us-ascii?Q?i50qFwNEQnbgKF9PdHE3fwldRMdx9L2V31CEyysDb0ccV7mqhlVoiWP3qBEX?=
 =?us-ascii?Q?0ARbKR3Um/WmqexW3WYHY47B91OPnTdQNB5P4QArlHvW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR03MB7190.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c07c5e-7ca2-4e67-ad69-08de0c651464
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 03:35:40.6078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6T66lWusHv8XnDWiUGe3z1VhMNKKq/Be2R17ciw1hAVpsqxbb315Myppa3jSmzowPbgKm/yiiJQaXeCPXfqZGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5549
X-Mailman-Approved-At: Thu, 16 Oct 2025 15:06:00 +0200
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

=20
> This should be part of the first patch (and then the cover letter can be =
follow
> the '---' if you like, or retained).
>=20

Okay, will combine the Kconfig patch into the first patch.
