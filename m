Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C896C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 05:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697F18058A;
	Mon, 17 Mar 2025 06:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="NNNOKz7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A27780F4C; Mon, 17 Mar 2025 06:40:19 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8488E80077
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOVA4pdicX5A39Z2af4QHoo1KLyGGbZDfjV+ofoGngJNsGR7pD5rZBwhTYdL8XZDSG6liVZfBb55n/Q94f75LGGxbuscclXTk89sJtfCmoHPxJvL3SRGsQxR2wgjTtCByOB/N4ojLm+43eTG4t7tkWtrx9/ILcKYnh/evD0MmHDev0rMT7o+afyNy2oXicC7ULZWjZZugXyxnHm8vJAYXcAN1dmhvoCwIpR0joYQSJYIYVGE78KUCVe1LQwRydvhxmfyxDjwdtJosuK5AQ1M+aZqDQU+2unnNntRwqV0a5Dn2IYekx8qzuYv+1z24ua6Wri715ksfl0Er0jy+ZZLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxBu3j+SFt4LLx08E07CYMRR4l74pdN7m+O4cmXutus=;
 b=TbuucIa8dpyHu1BSlSVeDHts3aYNgVIE+i1bG/tJ4rj1Mk9F8b7kdwk9h6UolXWQZoDHRQPFAeySPM5LglPFqa9e3PAP9DDts0yKV4XYkZ98xAKg0rgRNQB2OlEoEZzCprjUq8fIne/QC5/9zrwdf4oiOANolEMGpWXBxEzEOrHTRE9Ep+VND2CawzcVeQxEvDxawFpZh2pyRF9cXyPbp9vWsxTMnzDOVMzQX9D+nkZSxcHbyZbJq9FYkcNjqqi0k2kYinMtRqSXlUh+gUVggayK3XyqMG/EHhP4xt20sAJBU8l7B/3cVBZo7UQq1QCG0Cc2VS8BPZTjeTIHoyiGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxBu3j+SFt4LLx08E07CYMRR4l74pdN7m+O4cmXutus=;
 b=NNNOKz7NEACW8b8P5aYiZwFocVBj9w9ak+tmZzunnGOLeLSndhxX1L1Q0NeibFcWCcQaNiMyjz8gekOxFOnNV+opyjFf88ztBqw8FwsWf2tOyjZtIN8ndirlox3kW58hahxeBojpLUiNxQhZABpot24ncduACK4XEjigucIZU8MG8jPBY/jO3UsqmCjnWTQvjMjicZou+92Ys/8Qv8CyP4u1bSZKPiSSZ9Zs+/AmgC68kxqenaquQFSPYjdN7dtiQsRtQRbg2xs8VI9gq439ECJvv8RInczDET0Dxl9UZsh91gOkCv2Bj8qvc+PubsS7kE6tofq9R9va9P+Cg5in6w==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 05:40:10 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 05:40:09 +0000
From: <Manikandan.M@microchip.com>
To: <sumit.garg@kernel.org>
CC: <eugen.hristev@linaro.org>, <lukma@denx.de>, <seanga2@gmail.com>,
 <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>,
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>,
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <Nicolas.Ferre@microchip.com>, <Mihai.Sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to
 at91-pmc-status.h
Thread-Topic: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to
 at91-pmc-status.h
Thread-Index: AQHbjZToUKy7+4PeG0K/Fr3c3pGYbrNlr5+AgAA9SICAAUjegIAPrSYA
Date: Mon, 17 Mar 2025 05:40:09 +0000
Message-ID: <61064ff8-ee2b-4e13-956c-8391cf324d6a@microchip.com>
References: <20250305060711.1127301-1-manikandan.m@microchip.com>
 <20250305060711.1127301-2-manikandan.m@microchip.com>
 <Z8lH93V9DUfdoiLd@sumit-X1>
 <02132f8e-79b2-4b47-b4d4-60bb9c9a793f@microchip.com>
 <Z8qPP6Z-DpMFdiKX@sumit-X1>
In-Reply-To: <Z8qPP6Z-DpMFdiKX@sumit-X1>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|SJ0PR11MB4957:EE_
x-ms-office365-filtering-correlation-id: d9d2dfd8-98f0-4803-886b-08dd65162e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?K2tEVEwwK3FEb3RRZmlTdTFnN1RGSWlmN29jbU9lZEZCZUN1Sk9wR085eG1u?=
 =?utf-8?B?dXNkSmRDNkY5UCt6bWJkSzZKcmY4TkppVmpKb3AwMklTWHF1TldaNVpoa0U0?=
 =?utf-8?B?eSt4K1M4akl0VnVqM2FaMEwxbk1hUXhPSTk5dzB0VTFCcTZ6L1lnMXdCUGMz?=
 =?utf-8?B?NGxqeFQ5RnpjaHlCMWYxVjRvYjdJRkREVUU3K0JROTdiSFhFSnZiQ1BRc28v?=
 =?utf-8?B?c0RZSElJS3pHb3Erb1VwQWgrTW4zc3BxdGtpcVlRdGJDV01RRExQbzltZDA5?=
 =?utf-8?B?QWhXTjB2UzFIcURDY05XbFdEUTV0ckFEM2FmbmZyWmdjN2RyMGhOZkltZDdC?=
 =?utf-8?B?ZVZEejZaTGdJNGJ2TTFYcHN5TFh6cGxRcmpLWHNLTkQyUkJNS3F0RGtsVy85?=
 =?utf-8?B?NXlBTUs5VmI1VG90cG4wT0VKaVdHTDNaT0pVYVdzR2Q3a0EvbTB4VU1tK1BW?=
 =?utf-8?B?aHMvaHNZMXRQN0hqUER5ZG1jaHJRTkc3V080OENzbkh3TWE3b0ZXbTVvTzBL?=
 =?utf-8?B?bVRaMHpVdG9TMzhaR2toU0lCN0dJM1pHZkI0dWVEUlcvOXMxRHY2MDBRNm9y?=
 =?utf-8?B?VmRGcmxFZHE1WGFFa1dHZXdDd1ZFd09jaXQybVF4NCtyZUpDS3dzZmJIWU1Q?=
 =?utf-8?B?TCtPK2dZb0RWeEFVMXBPZkNiYUFReWowbk9jR1hDUE1wc2VkVnpTdTBwUVV3?=
 =?utf-8?B?SU02QWlxcDhhbG9QN3FmZGRjaXhiTjg5SUpHYkNxeVZMSWZEVmp4UDFuV1pX?=
 =?utf-8?B?eGQ3TkdwMGdTQStjOWEybnQ2WW9IOC9haFo0Y3pVQ1hZQmtrWTI2V1NyZ2xk?=
 =?utf-8?B?b1dHd0l3dFUxTE1rbVNKd0JhTHpNYWR6V05SSE93V3dhUnlraGN5aC9EZm1I?=
 =?utf-8?B?THBjdnB3QUw3QUZVK2F5aWlKVmhaeTNmNW9GdUh3VjFIZCsyVVlmSjlWMUM4?=
 =?utf-8?B?ZjBWdEpxZFpiUUdnN00xemZ0YXcwSWUvdHBjSUJjUnI5WlZ2bEdvZnZOeDJn?=
 =?utf-8?B?M0lQY0w4NXlQaVdJRng5SHpFLyt3OXNCQmQraTFJTmVJS0JBeWtuVzFYUFlL?=
 =?utf-8?B?YjBGZklKUUlKQTk4OG5HcVRTaERodnB1Qkd5QnQ5ZVZFUjBCSWVQb1MwallW?=
 =?utf-8?B?VGFPK1dIR2QwcVg2TytSNm15R2VnaUZMek1wQW43dENaSWpqKzVWUWtnTEJv?=
 =?utf-8?B?akUrb2pmQVBHcmpoS1lkdENyeDB1Rll3MnY0cE1XMWowNzhCOExXN0Q0N1Vy?=
 =?utf-8?B?Yit1bzdua3dCKzdwSWRtbk1ISnZIL0hOTHNOemMyekVDZnNtbk1TeTVTSGVw?=
 =?utf-8?B?d3JzTVlhaytlUjBHRFRRUGxzeTJuTGdRazVwcXppanVSL0hiZk1VTjQrbmJO?=
 =?utf-8?B?RnNRMy9lUmZJU1pDZE1kYWN5ZGc4UVpZNHNIOUREdXdDbjNtUlJxZFdlcmFn?=
 =?utf-8?B?L2Z3ZG96NWE1MHdXRWtlWGJKZ3FUVkpEZWdRSVYvWkdGUklsT00wNnFxMjlC?=
 =?utf-8?B?ZGs4K2NxSTFHQzN2cVlyaHVvNkJuN1ZxS3IxQko3angrTFpVT3YvQkt2VlQr?=
 =?utf-8?B?Tmk0bEdWbkNVNFo2SnRIUUhaZWk5Ukg4N3BXcW5GK2hacEMwWHVqMXRyRGN4?=
 =?utf-8?B?OTFadS9nS1FoeWp2WnlzK3FTSzNFTDRYV1g2dUVkWHh4TXJlVU16M29OcGxr?=
 =?utf-8?B?MXk1WDV4aSs1dVA0bWtGY2pXeUR0clZzVmU3QnFqY1lEU0VHenBpRnhFSG1X?=
 =?utf-8?B?bTZVdm5rRVZpeDRMUGJRMTZDUkw3TGpwSnowS1p5em80K055ZHZqT09LT3hP?=
 =?utf-8?B?dXVVdENQeUxZNHNUZ2FsZ1liam4vOUQyUXZFWnd0MDFQbmZCa3pHdkFGd3Q5?=
 =?utf-8?B?VjJJMWo4dW9pUEdXVHl5T09MOTdtUGlBTXdaY0d6UXBNczdDWEZhbGNJREFB?=
 =?utf-8?Q?dws23EZ/ZZ1lBeyEt4daj2x28lNdjRwk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YThJajBqcGVCV2VMd2pNMUpzb2ZDbmZ5bXpHclNNRFBJU05UNituanFkajJv?=
 =?utf-8?B?OXh5NWVyQTZNNlprRG94UVUrbFdBdzhPSkN5SWtKOUlhOFVKd045a2ZrLzFO?=
 =?utf-8?B?MGVmZGRjYU1RUEdrOGNJM1F0S3JzVGpsWnRzM1cxWUwzS1NJNzhxNm1Vank1?=
 =?utf-8?B?eE81NHRyQmc1ajQ2WmtEZWs1QVBuU3NMMjdtdlQ3YStTS1hUcEE0TWNPNGI3?=
 =?utf-8?B?Qk5wbTV3L2JVL01uRTlEYisrcXFteENJNE9PZk1BUjRaYmhtY1o2bkFKNC90?=
 =?utf-8?B?VlVJYUkvL0EzTnQrbTk3SDhZbGdKWGJ3VE9pL3cxTmNQWkRrYjNyQjBSQzRN?=
 =?utf-8?B?bDhJQmVMYytLbHlJR2lTb3RFU3RjQ05UdW9sVjNvVjB3RXRJL3NHdG9VY3RK?=
 =?utf-8?B?Z05LV1kyeDBvUDM2eDNsR3ZDWjRNN1AwUHdKUG5EYmJVMHNabDFFbmw0MXJu?=
 =?utf-8?B?TnJEUk9wK1F6TkNjUFZsTXFwMlNLbDdiWWt1d2dmUUtmbnFQVFRWNUZuRUQr?=
 =?utf-8?B?alFSTjlmMnNodnpUbGhIR0NpWllmc05lZi9WQkVlWWdFZzcrU0N1YUV3ZGM2?=
 =?utf-8?B?V3ZweUt6RnoxdEN4WlZIZndpYnVxNkdDN0NhMVcydHNacUhaZEh0d0duckN6?=
 =?utf-8?B?a0VQR2JqRllWQ0ppTGFpb2wxQXh3WURPalQxK2k2c1pGL0pBdUhlRHFidDZR?=
 =?utf-8?B?UnB2QnVCckM5TVRXTTlSSFdvNmt5VVM3bUcyQzA3dUJsZDlKQVRQMzJ4SnlB?=
 =?utf-8?B?NERtRVBUSW82TnQzUlR3bEd2U2hnbGVJbDJ2eUJidkgvK2pwa0VKZ2p4K0Mw?=
 =?utf-8?B?TVAzVVJqZ3k3NW9QSGtZekR6MG16S0Jlczl5ZVBNYWdmNkR4bmdsN2x3Mi9X?=
 =?utf-8?B?bzAvbjl5NGIwd2M0TE0zZms2Y3ZtSTA5eXp4cUczZm8wOXlZOHN3SmxHRHph?=
 =?utf-8?B?M1Z1SnVVazEvV2s1dWtqcFZra2xML3IwOU1ON2NiWWRQR2xUS3dad0lQcWtE?=
 =?utf-8?B?WmFOejNKRWJYbkJIRld4R0VqNFlCdlhRVHBoSWV1M1ErOW1OK1I2NzRxMEFk?=
 =?utf-8?B?aG1iWWNuYjRXWnJMTDBzalZLemszU0h2L1J1d01Xc0pwK3ZSWDNkajFMZFZW?=
 =?utf-8?B?N2dIajdxNnVpc2RRYXpIU1g3bUVRVjVnTmVoRmJXeDljSTlJOWFYK0FhcXJp?=
 =?utf-8?B?aE1hRjZlaWF1L3puNDJHelUvUFVNZXJacnRsT0Q5dzJkUXhpRFhJbGxRM1U4?=
 =?utf-8?B?ZzV0blhWQjNtNUE1SEU5dE5DWlpJOFVReUo2U2x6UmRBbmdaSFIxeWptTlNn?=
 =?utf-8?B?L2Y4MXJrYWhKQW50dEx3YmlnblI0SXhsYkV3NVVlZm96UitPNDUwYWFVekVy?=
 =?utf-8?B?eVFEdFFkK2Z4RXZoOFNQQ3VQZERXRTUzbGYwUFBVY2VpaFhtQWo2eXFseUFs?=
 =?utf-8?B?L3g5d2FyS2R4Z1E5eHc4TDBNcTBqWU1TNks3bWZFdzN6K0xKc2JDTGZqK1lG?=
 =?utf-8?B?aTdLZXNkVlpzQ2JNZW9nc0YxNnEwTUljcWR3dnpjY095YzFCbHZVWFhyNjQv?=
 =?utf-8?B?YTJBNmtoVTVvdEY1cCtjSVNOTzV0dlFzbG9MMWNVeXZ2a1JhSVFqcXZzR2Ev?=
 =?utf-8?B?RGdyUlB1ZUlHNXN3eTlOUlE5UnFUV2Q4VTFIT0dPRDlsakFXZnh2WW1EL1lZ?=
 =?utf-8?B?MTZLUkZ1YllIN3lDdHNTNnJNYzdPR3p0UWJxOVdDeUhmRzhsSGVXS1FYUDdG?=
 =?utf-8?B?SENUNzlvb2JLVnB5WFUyVzdhM1FhSjRJSDByU21vVW5EQnpjaGVKWk5PcENB?=
 =?utf-8?B?Tk45UWpHaW1IOG9BdUkrZEVicnpGaUlEbTVROHQxbVh2Sm1UV3JPeHlweGwv?=
 =?utf-8?B?dDBvZ0tDRmtyc0NrUnNGajVHUGR4SW8zUlprNEhob2IxUVR6Sks1ZmFrZ0Vr?=
 =?utf-8?B?ZVFWVVM1NXRJaFlvbDE1b2RLRXVFUnJrbnBwdElmcmFCYXZuMTM0QVVBT1li?=
 =?utf-8?B?Y3RLRHNPQ2pIM1VaR3JpTkpnVUdXUmNCYnk3Z3dvOXgxL3RXSE41eVhRQ201?=
 =?utf-8?B?ZXBtdjZxVkxUampGNGNuMXJKa0dPQUxkQllzbUorN3hFNFpRKzk5c3p3RkN3?=
 =?utf-8?Q?p7P7D+JGb96Puc/VXH/GU+1sL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF6C1D4759BB344AAF1C99BD894D70AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d2dfd8-98f0-4803-886b-08dd65162e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 05:40:09.8277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODz6oNY8ORDskuX5BV0nOGCuQg3Y7hr0CdCSNSLa2pFPR3Cny7xaBWBik7OaFdwZ6jnTYoLjTOmDI2yD0It8bn9e3jvScwj9JGfjUAzRcK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
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

SGkgU3VtaXQsDQoNCk9uIDA3LzAzLzI1IDExOjQ2IGFtLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiBb
U29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1h
aWwgZnJvbSBzdW1pdC5nYXJnQGtlcm5lbC5vcmcuIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFu
dCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiAN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIE1hciAw
NiwgMjAyNSBhdCAxMDozOToyOEFNICswMDAwLCBNYW5pa2FuZGFuLk1AbWljcm9jaGlwLmNvbSB3
cm90ZToNCj4+IEhpIFN1bWl0LA0KPj4NCj4+IE9uIDA2LzAzLzI1IDEyOjMwIHBtLCBTdW1pdCBH
YXJnIHdyb3RlOg0KPj4+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHN1bWl0LmdhcmdAa2VybmVsLm9yZy4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQo+Pj4NCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IEhpIE1hbmlrYW5kYW4sDQo+Pj4NCj4+PiBPbiBXZWQsIE1hciAwNSwgMjAyNSBh
dCAxMTozNzowNEFNICswNTMwLCBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiB3cm90ZToNCj4+Pj4g
UmVuYW1lIHRoZSBpbmNsdWRlIGF0OTEuaCB0byBhdDkxLXBtYy1zdGF0dXMuaCB0byBhdm9pZCBj
b25mbGljdHMgd2l0aA0KPj4+PiB0aGUgdXBzdHJlYW0gYmluZGluZ3MgdGhhdCBoYXMgdGhlIHNh
bWUgZmlsZSBhbmQgdXBkYXRlIHRoZQ0KPj4+PiByZWxldmFudCBsZWdhY3kgU29DIERldmljZSBU
cmVlcyB0byByZWZsZWN0IHRoaXMgY2hhbmdlLg0KPj4+PiBUaGlzIGlzIHVzZWZ1bCB3aGlsZSBj
b21waWxpbmcgdGhlIERUIGFuZCBkcml2ZXIgb2YgdGhlIG5ldyBTb0MgZmlsZXMgd2l0aA0KPj4+
PiBPRl9VUFNUUkVBTSBlbmFibGVkLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2Fu
ZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiAgICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5MS1zYW1hN2c1ZWstdS1ib290
LmR0c2kgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5MXNh
bTkyNjAuZHRzaSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNo
L2FybS9kdHMvYXQ5MXNhbTkyNjEuZHRzaSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiAr
LQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5MXNhbTkyNjMuZHRzaSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5MXNhbTlnNDUuZHRzaSAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5
MXNhbTluMTIuZHRzaSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBh
cmNoL2FybS9kdHMvYXQ5MXNhbTlybC5kdHNpICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
MiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvYXQ5MXNhbTl4NS5kdHNpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvc2FtYTVkMy5kdHNpICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMv
c2FtYTVkM19tY2kyLmR0c2kgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAg
ICBhcmNoL2FybS9kdHMvc2FtYTVkM190Y2IxLmR0c2kgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvc2FtYTVkM191YXJ0LmR0c2kgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBhcmNoL2FybS9kdHMvc2FtYTVkNC5kdHNp
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPj4+PiAgICBpbmNsdWRlL2R0
LWJpbmRpbmdzL2Nsb2NrL3thdDkxLmggPT4gYXQ5MS1wbWMtc3RhdHVzLmh9IHwgMA0KPj4+PiAg
ICAxNSBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4+
Pj4gICAgcmVuYW1lIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2sve2F0OTEuaCA9PiBhdDkxLXBt
Yy1zdGF0dXMuaH0gKDEwMCUpDQo+Pj4+DQo+Pj4NCj4+PiBBRkFJQ1MsIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvY2xvY2svYXQ5MS5oIGlzIGp1c3QgYSBzdWJzZXQgb2YNCj4+PiBkdHMvdXBzdHJlYW0v
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hdDkxLmguIElmIHRoYXQncyB0cnVlIHRoZW4gd2UN
Cj4+PiBzaG91bGQganVzdCBiZSBhYmxlIHRvIGRyb3AgbG9jYWwgaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9hdDkxLmggZnJvbQ0KPj4+IFUtQm9vdCB0cmVlLiBXb24ndCB0aGF0IGp1c3Qgd29y
ayBmaW5lPw0KPj4NCj4+DQo+PiBZZXMsIHlvdSdyZSByaWdodC4gSXQncyBhIHN1YnNldCBvZiB0
aGUgdXBzdHJlYW0gYXQ5MS5oLiBIb3dldmVyLCB3ZQ0KPj4gbXVzdCByZXRhaW4gaXQgZHVlIHRv
IGRlcGVuZGVuY2llcyB3aXRoIGxlZ2FjeSBTb0MgZmlsZXMgdGhhdCBoYXZlbid0DQo+PiB5ZXQg
YmVlbiBtaWdyYXRlZCB0byBPRl9VUFNUUkVBTS4gSSBiZWxpZXZlIG1pZ3JhdGluZyB0aG9zZSBm
aWxlcyBub3cNCj4+IHdvdWxkIGludHJvZHVjZSBhIHNpZ25pZmljYW50IG51bWJlciBvZiBjaGFu
Z2VzIHcuci50IERldmljZSBUcmVlIGZpbGVzLiINCj4+DQo+IA0KPiBJdCdzIG5vdCByZXF1aXJl
ZCBmb3IgU29DcyB0byBiZSBtaWdyYXRlZCB0byBPRl9VUFNUUkVBTSB0byBzdGFydCB1c2luZw0K
PiB1cHN0cmVhbSBiaW5kaW5ncy4gVGhlIERUIGJpbmRpbmdzIGhlYWRlcnMgYXJlIG1lYW50IHRv
IGJlIHN0YWJsZSBhbmQNCj4gcmV1c2FibGUgc3VjaCB0aGF0IHdlIGRvbid0IGhhdmUgdG8gbWFp
bnRhaW4gZHVwbGljYXRlZCBoZWFkZXJzLg0KVGhhbmtzIGZvciB0aGUgaW5zaWdodHMuIEkgd2ls
bCBkcm9wIHRoZSBsb2NhbCBjbG9jay9hdDkxLmggYW5kIG90aGVyIA0KU29DcyBjYW4gY29udGlu
dWUgdG8gdXNlIGxvY2FsIGNsay9hdDkxLmgsIHdoaWNoIHdpbGwgYmUgbWlncmF0ZWQgYW5kIA0K
YWRkcmVzc2VkIGluIHRoZSBmdXR1cmUuDQo+IA0KPiAtU3VtaXQNCg0KLS0gDQpUaGFua3MgYW5k
IFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQoNCg==
