Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CCBC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 15:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E40F87919;
	Thu, 25 Jul 2024 17:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aAH3O1yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB8C879AF; Thu, 25 Jul 2024 17:32:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EE00881C1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoFL4FSzgiDnmTk7UrqayXoK2oox50vGezEgzj23AWGLhlfVGTVvDI47mylB5ZBEvNzYzVNAV0DN6yfPztTPoJV9rZtbF40jIpagIAa21gmoeRj9Ri5GJ5v1OBis5BJnj6vOXP+7/81jYKcN0GFYW716h4Yuw5K/GcNxA1yGB+c4h7LzV+AOuA6lzPRqQIbGGCNa9Y0JkkdZx04XTuX2t9ubNmx0UfD4klAVTE7zu3TBZ2QWHXRaPAia1loWaxkeR7vswfta+axUd2ILxV47LGaDWRUTQ3x9H80H4glasXZ3PRWBnTapltz1yBY26lHU+rOg0zCGu2GvU8K60Pah/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eAs6QTn1C9z2JGBlQAZrow9+LTfYURBw+hYXLxqpJM=;
 b=jhG5xd8mA3bvdwZtj13pjPXgyg/rtr6TaeVc8LrevBkWNxLljNEfECtgNkJnRZ9oLY6a8ALHMAokeejGg0OsNFqQpfYByH5JVB/lsNtnhcYphawxrbBVdZJtPhDWfwATgEZDLgU+Lv5PU278YLohrtiun/4WtRoTzt+q3cs2FgH7w5AC2zeMhlKZbedRc2uPQCBxJPvm9FRhc7Ic66BXzxM94h5zg0eGcSy7P6WqoXip9o+WKx+zAI6ZCC6HRgQNkjxVlxcGwOzf2cTo8QzLQMWd+yTLbzyQor4q8UAA6W5jFilby05b5Ip1HMax69cteyl8jXa1KhGfEa5xWmOeZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eAs6QTn1C9z2JGBlQAZrow9+LTfYURBw+hYXLxqpJM=;
 b=aAH3O1yWcF6uncmVJDAb5TweXYJ9r2DDLBf7tuDD4GFEat2bTP/VrH92pCy84RbQ6ms14anZB34u3LI8NSckWQdTjlqUCGZoriHGPiAO1x1Ki7jysX58GMfQfmRvCqghlpEkmFPikeATWBT+hHgY4Sqhj42tGSuu1FGp8sN9wFNx6XbZsQ9CWDl4bsCYXYCOE1NhTry+/VajN0wawjWKFsv9BeLqkNnc05Nu9FRIB43UCoZ9EWlNMA/nReew1bvP+ucA2y7MrjR5ohwtRnKKMcQP8T8MfL/Dm7iRm4iEUBpyiOut6q+cpeu7YD/cT0eDTX45fJnwwL8tFnidX0DyrQ==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DBAPR04MB7269.eurprd04.prod.outlook.com (2603:10a6:10:1a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 15:32:30 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 15:32:30 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>
Subject: RE: [PATCH] clk: fix ccf_clk_get_rate
Thread-Topic: [PATCH] clk: fix ccf_clk_get_rate
Thread-Index: AQHa3mKN7U19CG9BQkGdhXtEbE4r3rIHDK2AgAANqsCAABI1gIAAAwEwgAAMZoCAAEjvYA==
Date: Thu, 25 Jul 2024 15:32:30 +0000
Message-ID: <DB9PR04MB92369C9EC2FF1DB10D7E4E8484AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
 <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
 <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOf5uw=nNter1RSuxvaXZ0NFkoOkqAKyQs2_97Ap4W5KhXSQmA@mail.gmail.com>
 <DB9PR04MB9236322AD261E061C1DB573484AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOf5uwkQF5P1EknEauK6j=jB39LNeMEzvZ7secN6tb4K1pmt2Q@mail.gmail.com>
In-Reply-To: <CAOf5uwkQF5P1EknEauK6j=jB39LNeMEzvZ7secN6tb4K1pmt2Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DBAPR04MB7269:EE_
x-ms-office365-filtering-correlation-id: d58385e5-bf10-4122-6de1-08dcacbeff3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmhzWjYvVE9nL0RKOUNiRkRzcW9IMThFWVNoL2YwRVh3NkJ3VzlVU1FwRzlk?=
 =?utf-8?B?UThvLzJBaE1qellHV0ZVL080RDhSOE4zOXEraW94T25QRU11eUVtVlVuQklQ?=
 =?utf-8?B?aWx0UlgyMy96YUpLNkg3SG9IZ3J3WjNPZXBMeGRwV2grSnFDaXJoQVhzRDZW?=
 =?utf-8?B?aHZISGZFVUNCSXo5eFBGK01MWGxzekZDY2I5WXFkYXJLb3MvSnpieW5VQVVG?=
 =?utf-8?B?TUZYbmxkWVlPTTdtVFh6WVNPYysxUlVyc3VsL21kV1RjM0lvMWZOb1QrdHFa?=
 =?utf-8?B?V0UvaXRsL1cyQzgrZGZtVnlWTEk3SExNVVVWdGFCbmdLMndIVEN2R3htUkRT?=
 =?utf-8?B?NjZZbllhWk1sL2JpeHpsdWhoSHVYU2xNSlJEUU56UG90VU9HTWc1d3lyZ0sv?=
 =?utf-8?B?VnpBUnN5MkRSMHgzWkwzSFAzWHluMm00dFJBOCtzZ045SStFQTh3NUllbkk4?=
 =?utf-8?B?T1JHSVltaXE4aVRldWRqc3ZyMmdSTER1eVhmUnk4QUpEZjIwSlhDbFZqWGw5?=
 =?utf-8?B?Y0lpREdVR2pjY2dCQjdGd2hoU3BvU0dYYzVUcnlaU0dVTHdiWndlcVZyNGI4?=
 =?utf-8?B?ZjZFcEM3alF5Si9DLzJ4Z3lkU3hjOURRUlFnRVZUNE1HQ1pUZWpvd05iN3VP?=
 =?utf-8?B?R0ZEU1hxSFlqTWVRaGtzK2s2cW1KRXBmOVNOWHhNY2FlQW05WlJNNmdWSFFt?=
 =?utf-8?B?YUw4cEtYU2txMFJlMkZrVkphb2JQSEJyS0dzNndvQzgyWDYrSXNLc0luOENr?=
 =?utf-8?B?UmtaTDU3dnpYU05pZWQzdmFFZlovL2poVHhwM3JGYmlOc1RUU0t4Rkllb3dx?=
 =?utf-8?B?WCtkY05hZzVBVXBFc2d3OGJYSkNITmR6Q2hWdHA5OEp1NkVzenZvOFkwNVJI?=
 =?utf-8?B?bHpaRzJPeWg2NHVtUUF3V3l6a1hUUmthV2xvZlIzRDFhKzFMN1IwWFdjOWNm?=
 =?utf-8?B?UTIzYmYwY3poMHN2Y0phQTBlUm5DUDNybCtvN2tIUWdXdVBCYWl1Tmh6bkVT?=
 =?utf-8?B?dDIxQlB3ZHh0cDlYcjNKTmF4U09zYnVKZEJMVzJuSVpWcldOckJDWnFGQjRp?=
 =?utf-8?B?NXYwcDRLc3Y0SlQ0b2xrbFZNSEY2NEV3T3p5NTkzZVdKNXVtV25CZmdDRFFx?=
 =?utf-8?B?R0dqNFk5c0toeWZEMmNhS1haYXl2L2lZZFNpeWpDeENBeGVzNlBtaXh2cU4w?=
 =?utf-8?B?Y0dBR1lScjZUNXoxV2o0Z2w3b1luTUQvYm9PWTZremZ4SnJJcU1ZQk9qR3p4?=
 =?utf-8?B?cGs2Q0Y3QXZ1N1ljU3krUUxHTzVhanVMNXQvNzBkRzh0TGthWGk1Vzg0bVJ1?=
 =?utf-8?B?MnBDbEhYVCtjN1dWbzI5OEEzZUFqZG1QVTU0RkYzODFndXRNSWRzRTRIU0Y0?=
 =?utf-8?B?b3VxWUtiNW15c2hvcXJnSTN0d1YvT29vSm9BZGpCVGpNNGdRUHpKY01Pa3RH?=
 =?utf-8?B?VXVKblVXNHRCbkJNeGo2ZE9QNEtkRnMzUitBODJibnVxL0dUaFNpOVEwOEo2?=
 =?utf-8?B?cEpCdTNIWFpVMGlZOWVQbUJoUVBYVEF5Ynk4ZnNhdU12citEN0VIZEFvcGFi?=
 =?utf-8?B?eVpHbzl3MkVRbEFMWGpKWlNGSzZHVlZSdHJwTlIyVWtmQ2VPc25mRHNJVzla?=
 =?utf-8?B?emJFdWplY2xiUGt0YXh0YUhPUXpxbGVjUFFBS0U0Q2Uxdy92NjZWT1J2dVQ3?=
 =?utf-8?B?Z1I4c0JaS3ZGejZ5a21MenU5UFBGMHJnNXZ5VkZtSmUrMUlGQ2xnV3lHSG9j?=
 =?utf-8?B?eDB2eVV4Q2tPNVYxKzZ4cyt6akpoam9jKzFpUC9aZjM4MjQ2Q2YwcHAyay92?=
 =?utf-8?B?SGNCNlhFZjJYUWZmRUt4bE4wN3FHT1h5UTR2RkYzb2J5UERtbXcyemw5cVhp?=
 =?utf-8?B?alBVSFYrREN6eU45amc3REdQekdHMFFZOC9CeUE5V2FnMWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFpsYktpd1Ira1hMbkZRamIwWWEzcVMyZmowa2preVFLdjlWQnR6RnlaL0NX?=
 =?utf-8?B?ZDJwU3VuWmVkSU9odWlyZmpMc3dFWUhwN1hrRG9CeTFjQmhSQ0FXSXh3Q1Zl?=
 =?utf-8?B?dy9BWFpqRU92WjZnQ0NjUTljd3dyMnZDcGxKZURVaklQQ1IxM0JoMGdlWWor?=
 =?utf-8?B?ODBmWUJaRWtMSWpYWW1zSGlVT0QxTWZ6Y1o1WXVnOU1XMW8xWGFJVmthQkxQ?=
 =?utf-8?B?cjk2aEcyU2d6T0pSVFAwZmNJNUQ0SVU3YThqcFh1OXBTMFFLWGV6c01QZDFR?=
 =?utf-8?B?NlJFUmg3dEZIcm1XV1cyWVNmTVZzdjRYTkVTZjNuSDB6YnhnNHNKbnluOWdi?=
 =?utf-8?B?Z1dtU0doL2diSjhXTTFxTE1kZkxqNUpBK2srY04zK3JseFljNnFONGRiekh4?=
 =?utf-8?B?Z3Y2dUk5cUIyN0x3cEJBZkExdUZoYjJsZDBzNmZWcWdRK3pqd2Q3MFRaMmsr?=
 =?utf-8?B?NTNiN2JyMllpSkNGWWtacXNYdUJZazE1OUYvTWNXOXhmVjltMlhqTjlnalNO?=
 =?utf-8?B?YVZrVjZXS0xPbVVNTHRKb3pKbDN6RUdEaXFrNDZGTVA5ZWdpVGVtWjdFOFVh?=
 =?utf-8?B?b3RnYlNTUmJzN0Rxck10UmpudnNBZTZxVWh1OTdIUExsS0c5NlloZTAxUWtt?=
 =?utf-8?B?ZGlvRVhiT0dlUXpUdzdjczBpVHUxVkxQSzFwcHlBb3owU1hIS2pFNm5KcnVP?=
 =?utf-8?B?dUpGemRJOXd6Z3NNeWxZZjdodnV1RUxVbGh5RG1LTGdaOGN0RHRVMVNxckVj?=
 =?utf-8?B?RWhYd2s4R1N1Sm5GZHN0Unl4U2FxRUdRUTRrVm42UWFQeHhmakNkWEZQOU5j?=
 =?utf-8?B?elB0RUpJV0dCazRETGN0dnpEblBwK3JReWhRcEt2WGdpQVRWdjIrcXYyTjRj?=
 =?utf-8?B?UWtCamdkWVYyUHJFZ056UCtYc3dFZnVWR29UKy8vY1drQkNMTlhiYmV6R0hu?=
 =?utf-8?B?QXVwaXdXQVNIQVo0TmRYRWhBTmVGb3Q5S0RUaHo2dzdsN3FyMUF5MmZmMzZ4?=
 =?utf-8?B?Ukl1NGxlKzNkNmkyaXU1clJSVHN3bHVPZzVGR09RVE5BZ3F6ZUFLOHhabzda?=
 =?utf-8?B?RTBaQ3p0TGIzeGtsT2pFV3NBQkZ0MFFTVlE3dENjK01jaEdDNnplcThNRGZh?=
 =?utf-8?B?LzUvOXNFSUhXUzVpWnZZeS93VUlpWHdoS1JXZVhpd2pNTVN3NTlpbWhERkI2?=
 =?utf-8?B?Y2phZzhaQ0hRbDJTYjFMeDJlQ3RzcGFmVHM3VVFrUnN5dW15TGJQbW14Yys2?=
 =?utf-8?B?STBnTGh5V053VnZad1g3RHNuVExzQVZEQVRvaWJVOVJCS0d6Wks2VHNoQkVU?=
 =?utf-8?B?bHNsZldmZnVDdjFCTkZBNFlWVlB5YkRwUkt6WlhQbGJ1SDlsQTB6YVNIcWRU?=
 =?utf-8?B?dTRhRnI3Tno0SHQvRE1QVjlkb2wrRHQyejUwb3FHKzdSS21FOVZLdk1zT0xV?=
 =?utf-8?B?KytVTlBKcVE1SVh2VDJvUDFWcEFhZzFtVlBwZ0xjRmsrZXA4MElpM1BleTBz?=
 =?utf-8?B?RUFMM21nUjdGTktwZUhtQUlQMUJxdkJxRExtdVdkdmFaMUVaY2x3MmJoMlkr?=
 =?utf-8?B?cWFHRmlZYXRMSDlnQ0FqSkhKaDIrQjRUV2JqbE9scksyaklrbWp4VG5MaFdi?=
 =?utf-8?B?QnVrVGF4bUZxdTJmdHJBRnhlT2dSMi9lbm1CSFcvVlN1dVYrd3BVSlVJUGFB?=
 =?utf-8?B?K0xGcEtiQnV4dk1Vd2l3ZExWdUVsNHBCV0E2WUJJWXl0bnExQkhUaWJoZzdU?=
 =?utf-8?B?a1F0eGpqR28wazZ0eGhya3l6NDJLc0h0N2tGVDlsNEwvQ0ptdExUTmFOSXB0?=
 =?utf-8?B?aG1xY045WllRcjhyZjZqQmloekd0b3FYQmxJL1hwWVZueEhUVHFQbThBZjVE?=
 =?utf-8?B?QTFqWFo4d3RvOHU0cGwwazRrd05mams1ZzJSejladEVVWTBTdGFPdXIrVzNz?=
 =?utf-8?B?VDdRcy9LeEZUdmM1ZjhMWDZLOCtOZzZQeWVEc0tnOE5FZy9xd0tnVDZqeDhZ?=
 =?utf-8?B?bllNWExmNEFWWkNXK0dFNDJFZG0zZzQ4NnZBNXMwOStHQ3V6SHM2OVU4Mm5i?=
 =?utf-8?B?cUZOelVGQWh3dXdzUVM4QVNPd3pPd3FRaDBpdXVaOGVoc0FmQ01qcnZwOU9s?=
 =?utf-8?Q?kmaEDIU5E19vTgYRaCJffN0iC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58385e5-bf10-4122-6de1-08dcacbeff3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 15:32:30.5122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k0kZQ6XeU5/Ix744dHXlNGcqTHpnI2F9tL9tXyvyuMNn8hPxku5jZApd/6vKzX+3TGAmtJkjWUMWxCNE+V8Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7269
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

SGkgTWljaGFlbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDY6MjEgUE0NCj4gVG86IFouUS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3Jn
PjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+IHRyaW5pQGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVu
eC5kZTsgc2VhbmdhMkBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gY2xrOiBmaXgg
Y2NmX2Nsa19nZXRfcmF0ZQ0KPiANCj4gSGkNCj4gDQo+IE9uIFRodSwgSnVsIDI1LCAyMDI0IGF0
IDExOjU44oCvQU0gWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpIE1pY2hhZWwsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNv
bHV0aW9ucy5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNSwgMjAyNCA1OjI2IFBN
DQo+ID4gPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgU2ltb24gR2xhc3Mg
PHNqZ0BjaHJvbWl1bS5vcmc+DQo+ID4gPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5p
QGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsNCj4gPiA+IHNlYW5nYTJAZ21haWwuY29tDQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGZpeCBjY2ZfY2xrX2dldF9yYXRlDQo+ID4g
Pg0KPiA+ID4gSGkNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEp1bCAyNSwgMjAyNCBhdCAxMDo1M+KA
r0FNIFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IEhpIE1pY2hhZWwsDQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4g
PG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gPiA+ID4gU2VudDogVGh1cnNkYXks
IEp1bHkgMjUsIDIwMjQgMzozMiBQTQ0KPiA+ID4gPiA+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcu
aG91QG54cC5jb20+DQo+ID4gPiA+ID4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyB0cmluaUBr
b25zdWxrby5jb207IGx1a21hQGRlbnguZGU7DQo+ID4gPiA+ID4gc2VhbmdhMkBnbWFpbC5jb20N
Cj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGZpeCBjY2ZfY2xrX2dldF9yYXRl
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIaQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVGh1LCBK
dWwgMjUsIDIwMjQgYXQgOToxNuKAr0FNIFpoaXFpYW5nIEhvdQ0KPiA+ID4gPiA+IDxaaGlxaWFu
Zy5Ib3VAbnhwLmNvbT4NCj4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEFzIHRoZSB0eXBlIG9mIHJldHVybiB2YWx1ZSBpcyAndWxvbmcnLCB3aGVu
IGNsa19nZXRfYnlfaWQoKQ0KPiA+ID4gPiA+ID4gZmFpbGVkLCBpdCBzaG91bGQgcmV0dXJuIDAg
dG8gaW5kaWNhdGUgdGhlIGdldF9yYXRlIG9wZXJhdGlvbg0KPiA+ID4gPiA+ID4gZG9lc24ndA0K
PiA+ID4gc3VjY2VlZC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHVuZGVy
c3RhbmQgeW91ciBwb2ludCBoZXJlIGJ1dCB0aGUgY2xrX2dldF9yYXRlIHRoYXQgY2FuIGNhbGwN
Cj4gPiA+ID4gPiB0aGUgY2NmIGNsa19nZXRfcmF0ZSBjYW4gYWxyZWFkeSByZXR1cm4gLUVOT1NZ
Uy4NCj4gPiA+ID4NCj4gPiA+ID4gd2lsbCBhbHNvIGZpeCBpdC4NCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBJcyB0aGVyZSBhbnkgdXNhZ2Ugb2YgdGhlIGVycm9yIHNldCBvbiB0aGUgbGF0ZXN0IGJp
dCBvZiB0aGUgY2xvY2s/DQo+ID4gPiBXZSBuZWVkIHRvIGJlIHN1cmUgdGhhdCB0aGlzIGlzIGNv
cnJlY3QgdXNlIGFjY3Jvc3MgdGhlIHVib290LiBUaGUNCj4gPiA+IGNsay11Y2xhc3MgZGVmaW5l
IHRoZSBlcnJvciB0aGF0IGNhbiByZXR1cm4NCj4gPg0KPiA+IFRoZSBwcm9ibGVtIGlzIHRoaXMg
ZnVuY3Rpb24ncyByZXR1cm4gdmFsdWUgaXMgJ3Vsb25nJywgaWYgdXNlIHRoZSBlcnJvciBzZXQs
IHRoZQ0KPiBjYWxsZXIgd2lsbCB0cmVhdCBpdCBhcyBhIGdvb2QgdmFsdWUgaW5zdGVhZCBvZiBh
IGVycm9yIG51bWJlci4gVGhlcmUgYXJlIHNldmVyYWwNCj4gQVBJcyBoYXZlIHRoZSBzYW1lIHBy
b2JsZW0uDQo+ID4NCj4gPiAyIG1ldGhvZHMgdG8gZml4IGl0Og0KPiA+IDEuIGtlZXAgdGhlIEFQ
SSdzIHByb3RvdHlwZSwgYW5kIHVzZSAnMCcgdG8gaW5kaWNhdGUgZXJyb3IgY29uZGl0aW9uLCBi
dXQgYSByZWFsDQo+ICcwJyByZXR1cm4gdmFsdWUgaXMgYWxzbyBjb25zaWRlcmVkIGFzIGVycm9y
Lg0KPiA+IDIuIENoYW5nZSB0aGUgcmV0dXJuIHR5cGUgdG8gbGlrZSAnbG9uZyBsb25nIGludCcs
IGFuZCB1c2UgYSBuZWdhdGl2ZSBlcnJvcg0KPiBudW1iZXIgdG8gaW5kaWNhdGUgZXJyb3IgY29u
ZGl0aW9uLiBOZWVkIHRvIHVwZGF0ZSB0aGUgY2hlY2sgb2YgcmV0dXJuIHZhbHVlDQo+IGZvciBh
bGwgdGhlIGNhbGxlcnMuDQo+ID4NCj4gPiBBbnkgc3VnZ2VzdGlvbj8NCj4gPg0KPiANCj4gdW5p
dCB0ZXN0IHN1Z2dlc3QgdGhhdCBlcnJvciBjb25kaXRpb24gYXJlIGV2YWx1YXRlZCBzbyB3ZSBo
YXZlIDMyIGJpdCBvbiBhcm0NCj4gb2YgdW5zaWduZWQgbG9uZyBzbyB3ZSBjYW4gbm90IG1hcCBh
bGwgdGhlIHBvc2l0aXZlIGNsb2NrDQo+IA0KPiByYXRlID0gY2xrX3NldF9yYXRlKGNsaywgODAw
MDAwMDApOw0KPiB1dF9hc3NlcnRlcShyYXRlLCAtRU5PU1lTKTsNCj4gDQo+IE5vdywgY2FuIHdl
IGhhdmUgYSBjbG9jayBncmVhdGVyIHRoZW4gMkdoeiBpZiB5ZXMgdGhpcyBub3Qgd29yayBhbHdh
eXMgb24gMzINCj4gYml0LCB0aGVuIHRoZSBtYWNybyBJU19FUlJfVkFMVUUgc2hvdWxkIGhlbHAg
b24gY2xrIHJldHVybg0KDQpZb3UgbWVhbiBrZWVwIGl0IGFzIGl0J3MgYW5kIGxldCB0aGUgY2Fs
bGVycyBldmFsdWF0ZSB0aGUgZXJyb3IgY29uZGl0aW9uIHVzaW5nIElTX0VSUl9WQUxVRSwgcmln
aHQ/DQpDdXJyZW50IGltcGxlbWVudCBhbHNvIG1ha2UgJ3JldHVybiAwJyBhcyBlcnJvciBjb25k
aXRpb24sIGFuZCBtYW55IGNhbGxlcnMgdHJlYXQgYWxsIG5vbi16ZXJvIHJldHVybiB2YWx1ZSBh
cyBnb29kLCB0aGVzZSBuZWVkIHRvIGZpeC4NCg0KdWxvbmcgY2xrX2dldF9yYXRlKHN0cnVjdCBj
bGsgKmNsaykNCnsNCgkuLi4NCglpZiAoIWNsa192YWxpZChjbGspKQ0KCQlyZXR1cm4gMDsNCgku
Li4NCn0NCg0KQ29udHJhc3QgdG8gcmVzZXJ2ZSA0SyBlcnJub3MsIEkgcHJlZmVyIHRvICdyZXR1
cm4gMCcgYXMgZXJyb3IgY29uZGl0aW9uLCAwIEh6IGlzIGFsbW9zdCBuZXZlciBhIGNvcnJlY3Qg
dmFsdWUsIGFuZCBhbGwgdGhlIHBvc2l0aXZlIHZhbHVlIGNhbiBiZSB1c2VkIGVzcGVjaWFsbHkg
b24gMzItYml0IHBsYXRmb3JtLCBkb2VzIHRoZSBjYWxsZXIgcmVhbGx5IGNhcmVzIGFib3V0IHRo
ZSBleGFjdCBlcnJvciBudW1iZXI/DQoNClRoYW5rcywNClpoaXFpYW5nDQo=
