Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CDDC3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 02:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF67F88755;
	Mon, 29 Jul 2024 04:58:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JfJd6rD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BBE28304A; Mon, 29 Jul 2024 04:58:45 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABBE88755
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 04:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvHq7oAaPPcjHLlft9BuQwwlXG6F4pXbk2EyOqtlWc3jGG1NXj3PNriGGqOiswHH8wVNUKYO820Rrx19Opqt30UuBa3ugBaJT8JC2TKXsZmja/M1p1/ikTBgpkxLjA5W8xJ28y9eNsCaIStcI/AIfZMbYgqJVsk33qQwCF5TyqwVL08Tf2TupQp//R1RBVolTN8r0WFXzUghCNWH2/vlZsPT2plO770Kw2xsd7npFgNONcLnZmMM6V8B0O/cqqBFTKl1H2j1XDMb79I8djmUPFZg7jhXSbylMWG8xA7Jcn5/SttcUNKwdnygPc2lFYFb0KpnTxVlCLXX/ho3utCKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfuJ+P562B0L9tSrB41GG6O4JWegt03SEpjzYce0SAc=;
 b=CvgLhAHnXiu+JCFrNPP/p7w59rAY6C9tLVRYhU39dO6XvDwfoBDVDN4coIECMv/d9ddaEWfnUQp2IJJKsMvMWNcL4MUa507A/EzRueRpMB/0uvTNAyfCMfZlNj8YXpyh104fs8yo+60vQfDdCCwxYvbLPhUjeby8JpuvmiAkR9Gct2N9wvdRF5/Ln2dLl9Aoe/8nLkj9dKvWVhCDOMTXqup7+qdX8qfVYwZq3WA9N0DQlFhO8sJl1H479rFZ8u9EWtaQtlmevywrTYliBw1oaAs8Mq8jyM1F4j0o15rfNVa9qp4PjhcRtf37obhee1/Uf1x+XDAYtrqvZSA2r9om+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfuJ+P562B0L9tSrB41GG6O4JWegt03SEpjzYce0SAc=;
 b=JfJd6rD+MTvLqf6oB3C3AZCD17ijf9XESKFiVXOsi5aF7SURnSgHG3PrV7wdOZ1nDtjwwLFPfw7g1LTTfGZFKYIg6lwga09G/Eh6HCgnCvVkiqbLwIMi8bEMpdtU0sclDeV8Zv+5IyiJxspyK5KYGdUsuoxH68Ods9CiUbN8fkfhMwCLjDMebaxMdrpJoNKM8o9+q4WcUBUd6pC0e+DOratth3JtVB6DR/jdsngoTuAIktImQfTJ8u9+cTRVSQD/OOPt1+phH4K3rMWCHQcazawFuMFkSq0v9IDvQlwyVy4huKJibrRJnMR+BCiY5lusFVM6VHG4Nqy5l7Wiy1vGkQ==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DUZPR04MB9981.eurprd04.prod.outlook.com (2603:10a6:10:4d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 02:58:40 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 02:58:40 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa30Pexqt2O5+IbECip2K9bcxtxrIJCysAgAAa8iCAAFLTgIADi5uw
Date: Mon, 29 Jul 2024 02:58:40 +0000
Message-ID: <DB9PR04MB92365B699215D4D5A325334384B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
In-Reply-To: <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DUZPR04MB9981:EE_
x-ms-office365-filtering-correlation-id: e7e1c62f-5220-4186-e9e5-08dcaf7a597a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cmhnWmVqdEo5S1BxMW9aSnRTUlk2U1NVYVphQnpyTC9OMnlKTm9rM2tLVWtR?=
 =?utf-8?B?NG1qcjVBYVlmbFRYaUNQUSt3dnhMSEFVNnRWdFFtMFZIU3RaTWdSb3gyZFl5?=
 =?utf-8?B?dlhsTE52SFM0VjhJM1M5VUtyM2VjWWtzQ1d4bnlyd0JaK0tpdGpXNjhVcG9n?=
 =?utf-8?B?NlRPdS95bStxblYyTVNrd0ZhVTFscDZsZEpFWjk1SEhZMDJyNnVMVkJZd1dy?=
 =?utf-8?B?clQ2enFLbXpWbU9GRjRqRTlIcFB4Zlo0VU5yT3BxMTd6ZlU2dCtPNEo0RVph?=
 =?utf-8?B?Z1hrdGJnS3oyRWp3eXQ1VUR5Slh6NzhQSHpZU0ZLc1RQT0UvYUg4UVdyM2JP?=
 =?utf-8?B?VFhYc3VXTW9lcFRibnhtaVFZTXBPa1o3WDBWTllLQ2xBbEQ5anIrMUlCRzJn?=
 =?utf-8?B?cmZLSStRMmxseXpqTWdtalJRdk5CZ1RnRFdqTnRROGJnSXVSZG9WZGROVEhz?=
 =?utf-8?B?Sk9qcHJsMXh0UVJTQ0JsZ0hMSEJXRkdvdHJhZlJHSXBnKzBLZjhqOWdnT3Vx?=
 =?utf-8?B?dHo0N0dmR3J1Q3VsTEpITTBjR3d3c2dNdXRBZ3UzMEpBbllEMEk3RVVGK2sx?=
 =?utf-8?B?cUpvclFTMUh5eG9xWnM4aFNIcXgyNEhXcENOZ2lnckhmVzQ4VmJ2aHh5Y1E2?=
 =?utf-8?B?Wko1TUR4NW1hekFjbzd5eXhoYWVmVzdlWFZXdm1rNTZWTlduVjBPa0ZvYWhE?=
 =?utf-8?B?YmNGelBlelZycy9JRkVRdW1SZURqZHpXQTg1UlJ1NHNFRy9FdTdSZTNpT0FJ?=
 =?utf-8?B?RWFxZ3V1alpkejA3Nmk1eXp0S3VUUm9veTNXbndRODZCUlZCbFE2NVJVU0lo?=
 =?utf-8?B?eXZJZVpBS21lY1lFZXR0TU1vRkI3RHplcVZxVFFxTlNXTmc0RVlPQWdMYSsw?=
 =?utf-8?B?MUJsYjk1MTEyM1NQVkhBS1VRTnVPY3hya2NIV1hsTG5LNTkvNVF0QnJJd0o3?=
 =?utf-8?B?Z01YUm9NWjJqa0hOdHRnZWJ6aUgxaDV1alBXSnhOYjM1SWxpaVVKT1dCUXRu?=
 =?utf-8?B?a2dHWEtjSGRYNGM4NWc3cHgvSUtDaW9uWEM3ZEdpcGJvZEU2R1FxWlNSNDB6?=
 =?utf-8?B?R2t4cC9vdzkzanZzbVl3T213UEZCZ1NOT3pkampGN29kMXRuRVhZSUZhYVZs?=
 =?utf-8?B?UjlYWVJuOE1xdHN2NzJ5ZDd4RDltQXdBQ3FYTEVHOEYzaDQ3QU1pM0NoYjNh?=
 =?utf-8?B?UzhTOG5qT0J5bUJKWnllYS9UYWdMNTVma0VwNUMrNjZpWDRUei9xUlYrVGcr?=
 =?utf-8?B?ZEIybXBXWnUrNW1tbGhCYjZnWVkzay9qbmVQYVNxaFEySXVISmJrbnFqMTdP?=
 =?utf-8?B?bzRQa1hJNkdoT0xIa05DaWNKYnJ6VHMwRkdoQ1dtWXA4RTJwMzMzUG9keWVt?=
 =?utf-8?B?OEUxbjVOQm1VdnhneWJuT01ZMEEzNFZKM0tQMzAzbjNXOU9IcTBnQUxxTnlv?=
 =?utf-8?B?eGVDdG14S2tDUUNEM2Q3MlVZdmpnTUgyeFFPTnJpMmYwUzh5OU0zNjhleCs5?=
 =?utf-8?B?cnAzMU5ienM4M1pEWEpKRjFIcWVaOG5DZEkwbVhkYWpGcEdUSC9ydTRLOVhh?=
 =?utf-8?B?ZGs1UEU5SVlkZFJ5dFhFY25wajRNcmtpRTJOb2kzeWxmL3hJa1BIWGdLZVhk?=
 =?utf-8?B?SmZSNVIzdTNVVWtweU5hNStwZ0UyM21XZ1BDelFUZENybldNb3NTa3Rnd3Z2?=
 =?utf-8?B?ZTRlWGJqemllQ1NVTDNITTRFNmswK3huZTJJQWlCdHB4MmJHR2JwdGNKVnA0?=
 =?utf-8?B?S04wSExGSEZLUENQNEt4dVNsWG5zeXVvQjU0bDRBSzJPS3BvcnZLZ2c5bjRN?=
 =?utf-8?Q?YZSN00ZGiIArGc2Rwk2PCl4ZZZcUOjh6Q8Kh8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXluVmRLVnh6TGtBdE9oRXNMMUtCQ3pTcC83MGFNZnVPdE40dmV0bVQ2U2VR?=
 =?utf-8?B?QVdaMFl6aUhvd2dFSk43YlVZSHJ3YXdPZ05xdzA3Q0tickc4R093N0JPd1E2?=
 =?utf-8?B?eG1Qc1RicUJ3SXpyMVNFUkRTYUNGUFJ6Ui93Q0dsRGxnRitRS3BIUzdDb01V?=
 =?utf-8?B?aHN5THFnZnZodnB4T0RqWFlRMGZYMWM4RXQxQm1oQnFPYno0aEROQ0dTc0Rn?=
 =?utf-8?B?VHpRemRvZUZtWWMyQXpIRGYwVTh3SStLaEhEcG1Xb2hUbEVqdlNjSHl5YWc4?=
 =?utf-8?B?UXRIaEdzL0NCNEpPblNiZFhEdDd3SWtPdVJzVzdMaWNaTkpmbWdoRlZsSXZo?=
 =?utf-8?B?Mmt1YmdWc0M1dVljUzRsbmRhSmNHNlkxMFJ3cXFsZTduVnB2cm9mSGxibWVT?=
 =?utf-8?B?VW1IL21PYURvZ2dDRWhKZVpUNWdCcHp6Y3VpNXNvY0lnQitZYmJoK0x4cHRw?=
 =?utf-8?B?YTh3cER5S1FGbHgzV0d0c3RSZGFEenZrMzZBTUU4eWZEbHAwejB1dHhtRzZx?=
 =?utf-8?B?RG5sRCsxdEhkWnZ6NGswY3lJVTlLc3pQNDhVd1hNcGN1R2thQ1pOTktOWjFv?=
 =?utf-8?B?MGwrSFJ3QmVpOTJBNk4xdmFRN0dWVEQzNllDYWhnUE5TWlhjODY5TWd0eEpa?=
 =?utf-8?B?MEx1M3VCTnRvWCs3cFlxQmNsbHdoZTJCM3g4aGVSMjIvZEdVUEFPUUxTZGJ3?=
 =?utf-8?B?YjB1MWZXNm41TkpQWGo4ZlpRdjg4SzlSbTRwcFRtR2F6dnVWQlp1bWJYV2Er?=
 =?utf-8?B?QzVtZkxPRWtwenFnUU1HWjhnTzNZbENKQ2ZNQXU3UWxGWElTMDRjVGhDSmNw?=
 =?utf-8?B?UVI0N203K2lKSkRxbkFkMjkvR1YrOE8yS2NnTVdSTlpSN2tJSncrRzZrcnBM?=
 =?utf-8?B?VitlQXN2bnhVZzdFeTFGRVFTeFpndzVOai9vNy9tK2dVTWl2Mlg3WmtkbXlF?=
 =?utf-8?B?N3FaaFpleGNIRmhpdkplVW9wSGxTcTdJMFdjdWVIWm1sbTBNcThRbzdxNHNi?=
 =?utf-8?B?cEZJblZkaWkwVGhMM0lGTzdEZkhhUnZEdzNaQlZnekgzTHp0eFdwZmJuZmla?=
 =?utf-8?B?RHdtSlJxNTRXRFErWlQvL2V0aGJhNUROSG0zdjQraFZ1bEEzZnlCUFFLWWJM?=
 =?utf-8?B?ZTVSWTVYSEdxaVNaTGhzOXZjdDA3a25BWERnejduUCtxWTdCb2I4c3cvc1Vm?=
 =?utf-8?B?cCtaVnAvUFlCdk1WTDVvOWZXUzgrMnlXZ0R0RUcwQmUxekpEODgyM0c3SEpE?=
 =?utf-8?B?ZWhJYTJVZFE4NTBneWJ3T29raHVyc2svWFFpZTBXMnhQeDMxM3BBRjRMUEd0?=
 =?utf-8?B?SStWNUdNaFI2N1k1SlNSOVgxSDhpZUphTXR5dGJTWS9VVm1POGNxdEEzSURw?=
 =?utf-8?B?Y05taE5mbFNXdUoxZVY4VUVrSjJzNVQ2aGd2TmFhOGdFUGg2R1Y4Zkh4OFAx?=
 =?utf-8?B?NEVycEhjWURxN1gyQzVDWnhzRkFWNFp4VzZzUHpHTWRoNmcyNWsxdlJ4QUxX?=
 =?utf-8?B?NzJ4Q2QzeHZ1b0t0N0R1SVMyVFd5REFZQ3lsMWovdkpRQUsrNlRoOVk5YkxF?=
 =?utf-8?B?QzRGcE5oZ0diWHpNN2xWdGpkWHpjRXBGUzZQaDVZQnVtMUlPYVg5bnowbGl0?=
 =?utf-8?B?OXoxemt5K1VZclF5ejczOGdweFp2NDlQbnpYSHF1blNPTDFBb3RNeWlmaHJu?=
 =?utf-8?B?eDVWYnZGdE1kQWMxQlV3bXc3WWs4MjNGbkZYeE44bVJJZUM1YXJZa2FCbCtK?=
 =?utf-8?B?czZESzlwUUVRSndDdEtoZzk0eGVrbWtlMHEvdXlWN0d6Qk56Y1J5cDlyaWRY?=
 =?utf-8?B?T2c2UUR2cytlODBUSzVlaGZadEl3ZmxEN1RKbEF2TUpzU2hZRjhsV2UraklP?=
 =?utf-8?B?enBLLzhDT3hRemVmeHphMkU2V2pTbnlnR29xVWc1SUtuR00rK1ZNQklBN1Z1?=
 =?utf-8?B?c0Z1ajVkM2l0QzdrZGdXUTVtT0l3VFhDa3hyV2FidzA5Q0ZnOFRyYUgrSVZx?=
 =?utf-8?B?VW5kY2lHazVLZmloM0Q4cmU5enBpbnZtSExGanU0R3JmN1NxZ1FaTVRHUisw?=
 =?utf-8?B?dXh6OGlzZXp2SFFtQStsNEI0UkdiMGd4eVBRc2MwQWdGOW1EdzJVd1lQaGwr?=
 =?utf-8?Q?nzAMbyrJW87od/qedLT4VvXtY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e1c62f-5220-4186-e9e5-08dcaf7a597a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 02:58:40.1756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5+5xWiCnUNN2O00YNHoUsfzrB+pP6BSDTiFJeHlHxQ3ok+h8RzrUhMxi/fzzj1bH71xx3X1s8QmjJQVSU0DNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9981
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI3LCAyMDI0IDQ6
MzggQU0NCj4gVG86IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IHUtYm9vdEBsaXN0
cy5kZW54LmRlOw0KPiB0cmluaUBrb25zdWxrby5jb207IGx1a21hQGRlbnguZGU7IHNlYW5nYTJA
Z21haWwuY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjJdIGNsazogaW14OG06IHJlZ2lzdGVyIEFSTSBB
NTMgY29yZSBjbG9jaw0KPiANCj4gT24gNy8yNi8yNCA2OjAxIFBNLCBaLlEuIEhvdSB3cm90ZToN
Cj4gPiBIaSBNYXJlaywNCj4gDQo+IEhpLA0KPiANCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4+IFNlbnQ6
IEZyaWRheSwgSnVseSAyNiwgMjAyNCAxMDowNSBQTQ0KPiA+PiBUbzogWi5RLiBIb3UgPHpoaXFp
YW5nLmhvdUBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGU7DQo+ID4+IHRyaW5pQGtvbnN1
bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsgc2VhbmdhMkBnbWFpbC5jb207DQo+ID4+IGZlc3RldmFt
QGdtYWlsLmNvbTsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0h2Ml0gY2xrOiBpbXg4bTogcmVnaXN0ZXIgQVJNIEE1MyBjb3JlIGNsb2NrDQo+ID4+
DQo+ID4+IE9uIDcvMjYvMjQgMTI6MjkgUE0sIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPj4+IEZy
b206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4+Pg0KPiA+Pj4gUmVn
aXN0ZXIgQVJNIEE1MyBjb3JlIGNsb2NrIGZvciBpLk1YIDhNIE1pbmksIE5hbm8gYW5kIFBsdXMu
DQo+ID4+DQo+ID4+IFdoeSBpcyBNWDhNKFEpIG5vdCBpbmNsdWRlZCBoZXJlID8NCj4gPg0KPiA+
IEkgZG9uJ3Qga25vdyBpTVg4TVEgYW5kIGl0J3Mgbm90IGluIG15IHdvcmsgcGxhbi4NCj4gDQo+
IFVoIC4uLiB3aHkgYXJlIHlvdSBhZGRpbmcgdGhpcyBwYXRjaCBpbiB0aGUgZmlyc3QgcGxhY2Ug
Pw0KPiANCj4gSXMgdGhlcmUgYW55dGhpbmcgKGRyaXZlcj8gYXJjaCBjb2RlPykgd2hpY2ggcmVx
dWlyZXMgdGhlc2UgY2xvY2sgPw0KDQpZZXMsIHRoZSBjbWQvY3B1LmMgbmVlZHMgdGhpcyB0byBw
cmludCB0aGUgY29yZSBmcmVxdWVuY3kuIFRoZSBmb2xsb3dpbmcgcGF0Y2ggZW5hYmxlcyB0aGUg
Q09ORklHX0NQVSBmZWF0dXJlOg0KaHR0cDovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
dWJvb3QvcGF0Y2gvMjAyNDA3MjYxNzUxMDguMzQ3MDQtMTItWmhpcWlhbmcuSG91QG54cC5jb20v
IA0KDQo+IA0KPiBNWDhNKFEpIGlzIHZlcnkgc2ltaWxhciB0byB0aGUgcmVzdCBvZiB0aGUgTVg4
TSBmcm9tIHRoZSBzb2Z0d2FyZQ0KPiBwZXJzcGVjdGl2ZSwgYWxzbyB1cCB0byBxdWFkLUE1My4N
Cg0Kd2lsbCBoYXZlIGEgbG9vaywgYnV0IEknZG9uJ3QgaGF2ZSBhIGlNWDhNUSBib2FyZCB0byB2
ZXJpZnkgdGhlIGNvZGUuDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
