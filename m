Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C1C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 03:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB9C88600;
	Mon, 29 Jul 2024 05:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WlXanw/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8EA8877E; Mon, 29 Jul 2024 05:02:26 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED6D87705
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 05:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAemsR9eKcSssh6a7XpktsiP/SqZrd8LeSo9tenYVU5URAMl4kZqO8wQ4EvOTsr8Oq+r7DFe1cfFiCCNaOUuuH+02zKLvqu//jMGD6sQX2Q3d7H/S+nfNWgiSZeaxZ7ASRPf9uf8IN3X46PsLfKN3K2zCpSsEupUVTkBXtpfDd/OX3heVWS0BG0YifrthVQTLSZI37OUKUtprYVziGJZstbUgInTOZZclqXbRxH3TaB2Mv9Bdr9G4GR4cRxWjyaaaVYflzsGRDgnWSliCxwKV/PC51bXmKPPB6ZQYvMMO5ZB0z5OLD0EMY2pjU/fHHEpn5t+7iFIf/ctLKdl/onv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xS81Ouepqzp20hnSB6zM4t6HTop00Wn7jy1P+6dqwo=;
 b=IJkUKSTLJjxw1Of7T4taE7xvIPDJLp6EcoX9oo5Kd5FJUiEOF0HxYfAFnlAhpAtj+C1AcG8/5I/EdUiySwhaJ3iPAIq/+GfxWUraC7LY3oy+SVaAFP1E+5MGi+JdiyRMgrhwfwx1Oybufw/vnsyUbleGcNm2vJ6zE8iUDUgUiAiOtu/H9zfMHXcyrvWebHBSDNm6fTU0ufxU2h1INGRsCtOG9FgKvkms6h8j0k/hvvMQ0UJntaxo5G+QXGkRvWobD2DYGOIazCskPNbSfZOqSZQAFnDt89MqM1xCmIHJPhHTjzsrB4Hhq18WmW7nbJR+fP2r23sGbJNS+TUeAhO4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xS81Ouepqzp20hnSB6zM4t6HTop00Wn7jy1P+6dqwo=;
 b=WlXanw/TV2g96e+/MEB8S3Z7z6jdElDAEZhY0+yVJ20CYGj6VirPIDfumjY3XG6b1FYF9y1ux9J265JQTA5ywQQh2ZLHZtIwO1JhFMyzW5bgff/UyCz2vSlAN38pDgcbE6dQAQ8MSlx1JNmh4dYyy19Ci4nG7I/p5iJexm63qvKbdUXmc2oiA4RjrDJOBMIUQT5PhEsgDed27XzmWKQDIO/qgwLpxW5lG+TUEPhyfGetJy2gYsf9hSCIYb6Qm5Zb1OyUCffdja3hUoQxo+v+cTdRQ6ryU5yqhGHVr0DAraSWm00owBDbcsAWcVyazkE8vvKfOm11tVBKU5UaRscEnA==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by PAXPR04MB9666.eurprd04.prod.outlook.com (2603:10a6:102:241::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Mon, 29 Jul
 2024 03:02:23 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 03:02:23 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org"
 <sjg@chromium.org>
Subject: RE: [PATCHv3 04/12] cpu: imx: fix the CPU frequency in
 cpu_imx_get_info()
Thread-Topic: [PATCHv3 04/12] cpu: imx: fix the CPU frequency in
 cpu_imx_get_info()
Thread-Index: AQHa34GDyVSbBmZGnkmlKYky0i3vu7IJecCAgAONthA=
Date: Mon, 29 Jul 2024 03:02:22 +0000
Message-ID: <DB9PR04MB923669B83221514F9F8181CB84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
 <20240726175108.34704-5-Zhiqiang.Hou@nxp.com>
 <CAOMZO5DFkhSd9Hi=aHoJQ95aq-NbSfr=_X3cmOHUGvr2FH5aow@mail.gmail.com>
In-Reply-To: <CAOMZO5DFkhSd9Hi=aHoJQ95aq-NbSfr=_X3cmOHUGvr2FH5aow@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|PAXPR04MB9666:EE_
x-ms-office365-filtering-correlation-id: afdc79f2-7d37-4029-b0a1-08dcaf7ade53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WlZTaXhGVUdJbVFiSW14M1AvQVlqS1JQSm9QUnRyVllXQzJwUTFXTXRVM0ly?=
 =?utf-8?B?NFNWYW1FbkRnRFBpT1ZUQ0loU3hDY1ZRWTl5a0lNNStUR0RZbXpndzk2UmFl?=
 =?utf-8?B?dDY4YkREakZackdZcDB4SU81K0VJQmNaMlB3UGxpRVhLZ2hYQjVPWWFyU0Z5?=
 =?utf-8?B?WEtCa1A5MHNCdU1YdWxqTWI3UzhlTjU4TjdFRW90a0pybE9SZktIbGQxbmdO?=
 =?utf-8?B?WFBIUk5YS1lYWVRRZ2cvaE93OWgvYndGV1hxek5rQ1R3MmEzb0NBVTRtREs3?=
 =?utf-8?B?cThOaGo5OHYvQ0RQeHhGSjFQTE44TmpNV3dZVmpSQkJQRzhYNGFHeGtrd0N2?=
 =?utf-8?B?V3E1alBMc251TXF2N0ZtQ3hYaDBkUlB2OG9uUDU5K2Z3SUYwL0dKY1JKcDg1?=
 =?utf-8?B?T1VHSk8rUlVabU52MVVDdDNWcUhBdkFaMnVpQkxieEtVN2Q0QUZpeU5Mbjgv?=
 =?utf-8?B?a1NWYVc5bUVrWElDeUJIZjY0ekIySHh4bUpPZFJwWm9jTnRHTEc2ZlMxd0Fq?=
 =?utf-8?B?TFZ4VmltZDhvcEN5K245bDVKekJFb3UzdUFYSE9Ed0IyYkRrYlFuWjF2YjJK?=
 =?utf-8?B?cW84blRxbTMvSmtTQnNVWk1lbjdwZjVWbTVwa3FPUVZpVWJaYVIvaHhFV2Yw?=
 =?utf-8?B?aXVpRWk4bGg0NjloTW44TkFmcDZKUGxSaEhQdHIxdEFWZlpxdGswanlkS3pi?=
 =?utf-8?B?MnZYVFZObnI5OG12YWk4RjZ0ODRpUWF1SGYwSWpPcUlYdkp4WC84ZjhoVjRl?=
 =?utf-8?B?T0l6K0ltQWw2TldGUC9wd1VOQXpONFpmRDh2eGdpaXUvSFROcUFEMEJqc01y?=
 =?utf-8?B?R3lWUjM1akhXUFV4L0MvOE5OQXdRUDhDZlRhdHBnUVI4bUhDN0xtS2pOcVNW?=
 =?utf-8?B?T1BYNzJCQU4yY1grOXZ4QVlHbmpPNE92RzRVU29RbU94LzhzYVBGNG50czBF?=
 =?utf-8?B?MFArRUkxOUQ5ZDBZcTVsalNSTjZQZXM5QUNDUjhFbnJDY1Y2MmxqUk05RUR1?=
 =?utf-8?B?SXRXblZxVFJoQXltbU9uY0djdzdLaVNmNGhVRjY3RFRraWp1QmZPYzVKK2lX?=
 =?utf-8?B?RlhNcTdBR093Z3kybUdEMzluaFpjL2JHSld2T3BvM0Z0OERYbXVzQVZNcjNM?=
 =?utf-8?B?VGdrblAzbE9DY09FclpLMUZuNDFwM3hUQ0xtTStyTGVGR0M4OXNnRlovakd3?=
 =?utf-8?B?ZnM2NTR5QzVYcHVFaXN5Vm05eFMrVnorSG9mdVRmTXpWUWdHSEEza1FNSXFn?=
 =?utf-8?B?K0IyYXVLaXlicEdaUWQ0VVlrRG1jckFCVDNvclpvZUlaRi9JMURlaGJjT0Yw?=
 =?utf-8?B?cXhoM3U1SmhaTk03dkVRMHNEdFRMQXZwcGtzNnNtQTlxcUNsc01SKzBwc2FS?=
 =?utf-8?B?MWRoSGpXdG5iQkd0U3JxZyswWUVZSitQSnI1Qk53eTIyeTN0SWdzazVaNTZp?=
 =?utf-8?B?cVkxMlRQRVh4MXREQlRSUTgxbE55dzJKNEJQZ1NVL0xhR20yQ3hIZW95UXVS?=
 =?utf-8?B?UnBXWkN2K1kvd2NtOEN6a2hqemczRENGb1ZsN1dWNjlHdmdEYkd0SUtxdlBj?=
 =?utf-8?B?Y0ZTQzBWWlplZjIrK0RYdGJnZzBHRG82VHNZbGRtTDdlb2VxZHFKMTUwK09Y?=
 =?utf-8?B?VXNhNzRLTmIxcWt5OWJVWENma1NBT1lSZTRkSklmRVVlS0VINldVL0lvL09H?=
 =?utf-8?B?UE1qTVZBZTdDeG02aytqSU1mbzdpVjV5SnQ4ZWd0bTBHbEpQVHFyY0xXS0ZE?=
 =?utf-8?B?MUhHVlN0WXRTbzc1STc3ZzVnTkx1ZTJvVXJjdWM0WnFFSWoybG5PemlOVkRT?=
 =?utf-8?B?MTdiS29MV05JMW5MWEEyQ2RiZVVlRVl6QmJDdDRBNVg3UzVTYmFyb0Y2R0JX?=
 =?utf-8?B?L3RsRzFEek9naUFSS1hSTUtJRjNsZUVacVFKaDJtU2hHT1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0M1L1BUTkdXUUJwSDNiZWEwTXdzM1ppVW9YK2xJN2hYOVhXb0NDMXdXblJS?=
 =?utf-8?B?b0hybXJlNlNSb3ZRKzRqUDdaeWdNTGJlR0RGajJBbDZoa0tFdlhnNHNaZGtP?=
 =?utf-8?B?S1dwN1cvcjZmdEplc0pXOVcxeWRHVmV1MnQ2cVliSHFvT0FyYWtVR2FzNEN3?=
 =?utf-8?B?eEpkdmhHbkVFdmJ3YjBIeUw3K241c0pFam55eGxvdEdxaGtmMnROZWRHeTM4?=
 =?utf-8?B?dWk1Zms5aEhDK1h2TnlrME9IeUxTbUJ3bFkydklrWTRZVzI2SGQwTUw3eVZm?=
 =?utf-8?B?QzJpK3NNc2k2Y2xpdVd1N1dtM0IxTXEvVkE4RENWYjA0OVFTby9WZE9uN1p3?=
 =?utf-8?B?THFJRGJ3NkF1VmViN1pEaHNyRmxaSDNXK3VNZkcxa1hNOFdzQ2JMb25sTEN2?=
 =?utf-8?B?UG5MU1dLS1hzU1lrZTN2cjF5OGQ0bjE5ckxBaGU1MzF3ZFlQei9sM3hvaWRF?=
 =?utf-8?B?WFNtTTR4TUJZbHNjZk9iRDNsQ2xpVFVoOXZMdDJFRWYzdFMycis5YnFaYkIv?=
 =?utf-8?B?cUs0eEM5UzFjY3FRbGJLSVp0aDYwU1Y2L2o3YzBreFovKzFBVjdSRnE5NC9j?=
 =?utf-8?B?OVhJa2JNUlBEaUVCQ1lvNXJRaFFXNnc4L3FzNENjQ2VWY2dpNFcvdzZndFJq?=
 =?utf-8?B?b2VhZ0RYTHg1R2JyczFBdnhCTzFqZHUrSWJVSzd3amhtSkIrU3cyTGNWc25i?=
 =?utf-8?B?aS9JOW1Ja2ZoazdDSy9ITmoxWXJaL1NZTUpLUkh0V0JHOS9mM2ppNUJNMGZw?=
 =?utf-8?B?QzJnUjNyQXRmRzNDZDhZdGRldVdpOVlFcW9lczZ5OU1ITDR5WjZNVkd5UGgz?=
 =?utf-8?B?TFhLQlNYZWp1WDEwRkd0T3NGcWphMGkzTTl2STZsUWdiVzZXcXNnNno4Y0VN?=
 =?utf-8?B?TW84REEzWWZNN0F3S0YzUG1wOTBXdFJEaGtYdjlBUlIrZTFrL3lwcSs0cnpN?=
 =?utf-8?B?alpRZkdYYzJDMG1manVXdkNTb0NTYUZ5V0NablBiREd0QmVLRm96cTZNeXFO?=
 =?utf-8?B?V0NGckVpNWZZSEQrR0x1bitMa25iL0IySzNnY2twU0I5QmhsWHJUM2c0enNE?=
 =?utf-8?B?b3U5TWVlaE1jWXNtanltVTlreEkrWXlpSi9XczZsSTNmemZEeTJCR3YydHhz?=
 =?utf-8?B?ZHpsb2VVVlBKeHI4cHNOc3lRYmJuUHVhYWZuTUR0NXltUXc3cnJUUVZrdGls?=
 =?utf-8?B?MWdTL3ZuZ1FpQk5FYzBHL2dLY0FHcmRzZlVDOVJGbHNYek5FdnU5d2VuSWZq?=
 =?utf-8?B?dHZ0bDJ4RVRaNlBCa1NRWklVNmlKdVd6eE5yMzJ1d1UzcmhZOWpVdC9CbmNx?=
 =?utf-8?B?T0pxRkpQcTlGbTNkV3RoR3lvcVVjbyt5UkY5M2NyWVo0Wk9UWHA0S2tzTW9x?=
 =?utf-8?B?UXRiNit3ajU2TVBGdDBqM1hTcXM0YTJobDVYNWh1VjV3WDE5R1NXclVDUHZ0?=
 =?utf-8?B?NTRqc2NLV2pwY015cVROTks5SVg2R2IzajUvV1hnVTM1OGtubzIzMXZ3Z3hS?=
 =?utf-8?B?NXdIblFUNXZFTUpQaC9KWGFHMjBHdzFldDhpbktOanpjV3VZSUpURGxtSlBQ?=
 =?utf-8?B?WGwwSE42Y1M0ZHRYbXlsSDBoSEdFdkNrcXdta05vaGZzZEROWDFyY2hPNlcr?=
 =?utf-8?B?VUxNNHNWdThLb0g2R2p4dzNYS294VzZsYUdYTllsb0FZSXhiS0xOcm8vMTFT?=
 =?utf-8?B?RGdSUGlPM1BQa1ZIY0Z3MW1XRDB4amJDb0JJV2FKRi9MYUp0ZWNXZncwVkdw?=
 =?utf-8?B?TkFaeWZGcDlOdGt2dFU0MW05Mk9PM0RqRnpGZVRpMVFnWDhRbUVBbWJ0bW1s?=
 =?utf-8?B?L1lyK1Vqb2o3d0s2YTBrbWM4QTExVDJRYzRWS2xqM1Jra3ZaN0hyYzR2emZS?=
 =?utf-8?B?bFplN1BvQzF0dkF5K3ZxTHJ2L3d5ZGN5QmV1UWQ0dW9ESmNKRW5YY25DRVc5?=
 =?utf-8?B?Mk1rOWRwK09BVjVYcDRldzFYak1IT1NiVkg2Y29MVzJGa01FRExjblJMOC81?=
 =?utf-8?B?K25YbUIrTW9BbU1oVFMzMGpSVFBsVXczNFFHY3ViUjJRTy9ORWJOY2wvcmxq?=
 =?utf-8?B?OXF4dEp2SFVINFJ4MjNRZWZIWE9XMVNLY3JMajlBUW5rNGtwTC9TcFpUV2cy?=
 =?utf-8?Q?ZkEtrJlW5WsdC0sY/hhjIIKhm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdc79f2-7d37-4029-b0a1-08dcaf7ade53
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 03:02:23.0124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/2g76kiCFmaytkISygDowHBguQIhqR1w8u4JriTW6nxu7sx9gOua65yjcjMYNLhoF9cA9ba4YBi8S25G0hYow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9666
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

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSnVseSAyNywg
MjAyNCA0OjQzIEFNDQo+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENj
OiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdHJpbmlAa29uc3Vsa28uY29tOyBQZW5nIEZhbg0KPiA8
cGVuZy5mYW5AbnhwLmNvbT47IHNqZ0BjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SHYzIDA0LzEyXSBjcHU6IGlteDogZml4IHRoZSBDUFUgZnJlcXVlbmN5IGluDQo+IGNwdV9pbXhf
Z2V0X2luZm8oKQ0KPiANCj4gT24gRnJpLCBKdWwgMjYsIDIwMjQgYXQgMjozMOKAr1BNIFpoaXFp
YW5nIEhvdSA8WmhpcWlhbmcuSG91QG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSG91
IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IDFNSHogPSAxMDAwMDAw
SHp6enp6eg0KPiANCj4gUGxlYXNlIHByb3ZpZGUgYSBwcm9wZXIgY29tbWl0IGxvZyB3aXRoIGFu
IGV4cGxhbmF0aW9uLiBUaGlzIEh6enp6enogbWFrZXMNCj4gbm8gc2Vuc2UuDQoNCldpbGwgZml4
IHRoaXMgdHlwby4NCg0KPiANCj4gUGxlYXNlIHJldGFpbiB0aGUgUmV2aWV3ZWQtYnkgdGFncyBm
cm9tIFNpbW9uIG9uIHRoZSBwcmV2aW91cyB2ZXJzaW9uLg0KDQpZZXMsIHdpbGwgYWRkLg0KDQpU
aGFua3MsDQpaaGlxaWFuZw0K
