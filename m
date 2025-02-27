Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE145C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B57A80FF0;
	Thu, 27 Feb 2025 11:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="1/v5if3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE53810F1; Thu, 27 Feb 2025 11:37:33 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A5F80F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manikandan.M@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyyQaDeSOG0peyc4kVWULdze9gS40Ms26jE60robx/cf59bvw8QLDUNkHXkThrTv735virrd04XIBrqnBHX3lgNBPbqOfARcIEQAxZJL5SW68bAetyadrnOk3NRYHpjJjr7WBy1N1l/cXojpw0RAFAdn5iGb+DrGhgIFdFSdCiIxyKNU6hH28ZDnahYvKOUrXpuRNsetUGjKfF/nPV0k3ogIdaxrmkIunmRUXXIdb533IO/iTBLqUsvEg1uvAM6BWU/pI8ttGmTJLR1/MPISNJ7LdLsxdp1aMGbyvn99Pz4TEvQTEuBHMSZBp3Qq57xlrsjaBCtTn0JbraFCVHnj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kakRjSOm7C2I0Sd36jFr6ddUELUcxY/L+TvOitIAYMQ=;
 b=oHNWyqPDRvj2qCieLZiSNgT1ASgV7YPJ2eu0siLHeojp5tqOzyEYZhP9SEyDAWn79ChX1+FlqrBKUjat9vll94nkTUTd1R4G47IaLywNEEyX5dmw7/zz6zOcnfLR8etYpzuVNPU3n3rX52jEYmfxiD4M1pG7xCiyZxqGctvMBTJsV7nI/CmtIy+H0byJM3N+Lmz8G2UNDtKCdQrFoUrMgYwy67pzUWBTImthurY7f3Np0D3iOgWzBXf1leMlsCrVoeWCqg9Lh03sVg9f1ywUdG9iGjGcyZlTQQqI6pYArui/qqxKGcHhoWzJDuWpfesOjyUxfV1adEnqKszi724cjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kakRjSOm7C2I0Sd36jFr6ddUELUcxY/L+TvOitIAYMQ=;
 b=1/v5if3NDDrGdYDyU+4oceMWRxEFXxfq3EuJQNSBIikaBEQ5+XZpVHhfavSIg6V0arFOkvYZDcMDw0xw5smmt4mQpsonVdX5Qa0Mi0stKstuqGZqnsTL1o1kuKB+I5pNLRtH0xKFvMwl4XQ6UD/RiZjnQLezqeSLuzOdfcLcRGZXorLNk3IZ+R9boPx2VhvhJl8nz9ufjgS03g0ecuEFjQFdFmXHswSl+i18ytLm5feY+KtxrjtM/mTpp6FpdNfuvDec1Maify1HpE5H5ffa+wmnEHI3heDFKRE88pjERtYZd+TFG0IZTAPqBIMUazKaP9+37QJZy5YUr0zuEApElw==
Received: from PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 10:37:25 +0000
Received: from PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d]) by PH8PR11MB6609.namprd11.prod.outlook.com
 ([fe80::ebc1:5d63:a07c:60d%3]) with mapi id 15.20.8466.024; Thu, 27 Feb 2025
 10:37:25 +0000
From: <Manikandan.M@microchip.com>
To: <sumit.garg@linaro.org>
CC: <eugen.hristev@linaro.org>, <lukma@denx.de>, <seanga2@gmail.com>,
 <kever.yang@rock-chips.com>, <marek.vasut+renesas@mailbox.org>,
 <jonas@kwiboo.se>, <festevam@denx.de>, <Oliver.Gaskell@analog.com>,
 <aford173@gmail.com>, <prasad.kummari@amd.com>, <caleb.connolly@linaro.org>,
 <andre.przywara@arm.com>, <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <Nicolas.Ferre@microchip.com>, <Mihai.Sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Topic: [PATCH v2 1/8] dt-bindings: clk: define additional PMC clocks
Thread-Index: AQHbiPsjoBcXgMo1hUCbV6M9r8wp7bNa5k0AgAAO6IA=
Date: Thu, 27 Feb 2025 10:37:25 +0000
Message-ID: <c2a277d8-b1bb-4b32-9245-81aba4ba13be@microchip.com>
References: <20250227093559.797618-1-manikandan.m@microchip.com>
 <20250227093559.797618-2-manikandan.m@microchip.com>
 <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
In-Reply-To: <CAFA6WYPEDujKz5jVW7ySynXi2T9kQWdJ+1MVBA1mGzMpBUMJmA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6609:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: f1850f62-3a9e-4817-ebac-08dd571ab9da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VDVoT2lXblJnRzRqN01Ca0wvWjhNVDFGRDhQS1BHSk1BS3JKYlFFK01vTk5V?=
 =?utf-8?B?ZkxMUENMZ21zd29LRFlYNHFGK1pNbGRuMU1XWnJoL1ZoZS9jTyt5ZEpRNzJu?=
 =?utf-8?B?aE9tZW1KMSt1WGpGN2hxdndUNDlzSEVuZ3lnNmNCbFZwUUgveEhsQ3JaSUta?=
 =?utf-8?B?b3ZzbmMwbDlpK3ZKcmRqOVlSa2NWYU54d2VnZENQNHRadDF3OTNLL1BhVVFS?=
 =?utf-8?B?STIxSmpNalR4anJYbEVEWklRa3dKQmxIcHBsSFZ3eUk5V1lZYUs0S3o1WGsx?=
 =?utf-8?B?WDVZVWhTUzBwZFB1bk1xQi9zWlpjS21JUG5FWTY0ZE4rOExuNU9weXJsZDdF?=
 =?utf-8?B?T0ZTYVFPc0d4VlFaaEFTSHoyeUFlS0Fzd3hseG5hd0p4RjF0N1dMZ3pWM0Yr?=
 =?utf-8?B?WHpGbitrUzI0L2VlbVAwNlcxUjEyWlpJM0hsT2xFa3dmUzVYaDgyRUtjS2tF?=
 =?utf-8?B?dzdIR0pDc3JjMjEzRk5wR0NqdFN4TTF2ZUVpMjlFUlFjRW9na2RjajNCWHVS?=
 =?utf-8?B?RHNYVDNrUHU4bm56SHpNcDBXZHVPYUpUeWtNdy9TY3hMdWFwZ1o1NzJjREVZ?=
 =?utf-8?B?U203OERFRXJUZk04ODQ1bmtQNGhNbkhVL3VydThiQ1M4NTQrSzFtcmh4MU4v?=
 =?utf-8?B?M1l3MHpEUVkrYmhrQk5aUGVmSVBSODBwaFhVc0YwSUIzMjJXd2cwYW4wZmM5?=
 =?utf-8?B?dG1McWZlNVNnL2c3QTYzSUxWVWkyWXFWWTNHbFBMWTFPdWZwSTFpL2xSVUhL?=
 =?utf-8?B?bjQremZJVDhZOEpRZzVWL2psU1pwTGJKZ1FBSkJBNFZ5SEhxY0tNTU8vdThO?=
 =?utf-8?B?M3lxM3dHclBNTXM1R3ExSStGaWdEcWY4STd4aTNtYWZqb0NEa0drcXhwTDJE?=
 =?utf-8?B?N1NzVmQ0RjdmbVMrVVEwYTU5WGYrOXp0bi9sMVI0N01iUFI2ak0zS2RIWm9I?=
 =?utf-8?B?VGZpNllmdC9hQXI4K1NWVDVXUkEwdzk4RjBad2NCVFQxOVFLQXMrQ2UxZm9a?=
 =?utf-8?B?MnRDTURVaFhJMXkzREhDMnVweGh3MnQ4RVQreXVmWnQwU2pHQjJDSUtrZjAy?=
 =?utf-8?B?eGt6SzRrUHRuTndlK3hoSW1EM0pNbWNKY3lRMWdPZkIwV2Z4NC9hTG85Ulp1?=
 =?utf-8?B?U0hiS0g5R0kxM05jNTJjdVAzYzE1cE1hWnZvaXdoaUd1c0U1YldXT3hYWlhO?=
 =?utf-8?B?MjNZc1l1L1RkVi8zVEhUR2traklBZDBQRkRERlIzY0lQVG9odHE2YUlHUm9Q?=
 =?utf-8?B?WHFkOUdGSWNTTFJuOTJNR3M1b3VPZ0RJVytYaFNNQklMZStMY2RZTlJRRFd4?=
 =?utf-8?B?NGdGY1doL3dGVWFiMXBvWTBCMjIyaVN3MnNzNVVTSXNWYmJhVE9JMTRtRkpG?=
 =?utf-8?B?MWJhNDZROUoxYjROR0IvQnNyaUlibmphb05ha3FuUmhlK0Q2VjVpSFYvV0Zr?=
 =?utf-8?B?dFpIek1WRUxTZGppb3JLZWNBRFFYS2FRc0l6NXRPTm14TXRqMmxiSHNaV1h5?=
 =?utf-8?B?cVE5enpVZXhHc3VMQ1F6Y0M2N09IM3U3QmlET2JkUHVYdjFuTGUySkNlTUdX?=
 =?utf-8?B?QWRiaU55M0t6bEpBQ2prdnZHYmc5V2d2RUs0VURaSnE0SE84SXdSYU9uMDA0?=
 =?utf-8?B?WTJuSFUrbzdrNjIvSnhERU5wMlZXU3RuMC9tc0MxTGZYVUx6N2U0VjZXbEVD?=
 =?utf-8?B?RC9kRXEyU3BHdHo4YXdzM2s5WGdsaU1ZTFNYdGNRUW11UHVrTnZyTTA5M0lC?=
 =?utf-8?B?YUU5TnNSakxIZFBkNGl0OXkrb3VmMW5tc0tGcmp5SkE1WE16Z3N6Uld6dkRO?=
 =?utf-8?B?UXVPd3FxZUR2cUhHS09HS3luYVc4WlpJNUNGZ2ZJYmhkZzVzd25uWVBVM0VP?=
 =?utf-8?B?WFZhRjNaVmU5UDFBSUc3WjZvOEVnOXNieEdTOFduYVFMZXZPZGJRMFg0YUtQ?=
 =?utf-8?Q?YGgCt+FAl+8jWQOtb+lM6VOWheYiQDEx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6609.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3hrVXduV3dkNkFaMmU4WjlZWHg2VTh1S2lCb3p4SGN3bTdSL1M2UXBlV1h2?=
 =?utf-8?B?U3FXU2t1SisrUkovOWhCRWd3ejZrZ3JabVZUbTR1NVFpTmpXeStIL0UxMWx5?=
 =?utf-8?B?NTRDNEQ0N1VvSFVnMEZzZW1VMGRRck5KL3Z2bE9ERGlMTnpROGo4ME5seStY?=
 =?utf-8?B?c1llb3cvNG9QRmJZa2FaWmtIMmZ5RUtuS0RwTEdEUG9CR2VtZU9yejRya3lF?=
 =?utf-8?B?NGw0eng0YmgzYmlJbHpHbEg2WXd1NlhHcUROWVYraUJSeXFBTGpaT0RnbjBB?=
 =?utf-8?B?cjI5dkRsckQ1Rk9sR0J2VUIzZmU0WXlXbHNCVEZvbS9uRmJrL1YvZFNTNnhy?=
 =?utf-8?B?akU0U1JjQzNqYW55S3pvd2xCRzVSL1RUVGJuTXVjQncvSENLWGlLL0cxa3B2?=
 =?utf-8?B?TmZ0TnNvQ2RsV2cxaHcxZHdUR2ttclhVbDNzOHRZU0pCcEZ1OUFTN1ZnZEdZ?=
 =?utf-8?B?M2Z5ZVJWaW1JUlJBcy9Hamk4WXJuZkNMWTdRQWx1V3NKNUtBNnpYK2krRXZq?=
 =?utf-8?B?RHNHM0pEaTRINE9tMTB6SnNBZ0s1OFJuUDR0UUJhZUJZTlcrTFBSbS9oMWU4?=
 =?utf-8?B?TDFOTHZUb2dSNnEraEgxeUdraFZ0YTZ6WlpyYUl3K0VpZHJ4QTdsR3FLMjUv?=
 =?utf-8?B?N2lkV3REd0NuOHJqMEZkUldyMmNXVk9FcDBiM3Bsay9BcUFnQ1lkR1c1cStZ?=
 =?utf-8?B?azBmZmFDSEk0MjVsRCtpelJ5K1pzWHZreTk3TmptZmF1dXVhMDNTcktkU1Vi?=
 =?utf-8?B?TnF4eG4xSzRGTzcvTExYcWRTQUV1UmxiaDlkWi94Rk5YcHl0WEFhRnV2ZWZq?=
 =?utf-8?B?YTNCRHQ2WFB2aTB5MkRSWjBYS1FOazZkVzlackl3VWtNaXlWU0pkd2g0ekVW?=
 =?utf-8?B?QjJ6TmRxTGR1VEJjMXJFaWVVckZ3TUNrU2VheFdHRkM4RXdFcnJqcXVKVVFu?=
 =?utf-8?B?NDBLMUcyV2pJT2NkYlEvdmFIYkRQSzdCOEZWbENPOXY0R083ZFo5QU9iUVIy?=
 =?utf-8?B?QjNqdVBKSml5d1JGVFRZdnVoOFl3STNINVBaRFBnZy83NjloUlhjaHpaRkFC?=
 =?utf-8?B?WVREK2hRYWNPTldvQmhoRlFXNEQ0aHR2Q1gxNldUV1BQS0JCWGNBZjZPRXY1?=
 =?utf-8?B?OWpUazExS1dmRVZGQ1NiblNLMFZBZzNtc0x3NnowbVRoTFpQNWVSWFNkOW02?=
 =?utf-8?B?RndpekRiQVBHalU2em1DTVZJWXVJd1M2T0RTOER6Y0NFVDZtTGdubUhwdXdC?=
 =?utf-8?B?TDhXdEUvUE9jSHd2dkRSYUthczF1ZVlhZ0lDSk1CT0p2YTFyY1NKbHM1Wkww?=
 =?utf-8?B?cEdWTlNqdTA5RGV3WVhXT2w2NzBaVHNBTHhtU2c1VGJBbEFOS1l2cWR6WU1J?=
 =?utf-8?B?MmpoTzlBNXd0Z0pZMGF6ZFlTNDV6SnlSTkZwQkVHclBUWStnSlNGa1dYWU5t?=
 =?utf-8?B?QjNBUFREYTR5VVZmSGpRYmNHK2ZLWnlIMGZUUHVldHgzT3RuZ1JxMmU2bEFl?=
 =?utf-8?B?RVIzeTNnQS9ydWxzQ0J6ZFpzVGpZRk9lNjkrY0cxZk5keFd4STBQWGMvYk53?=
 =?utf-8?B?dUhqakRrS00vcDROZkE3cFRoZ3RlYlVhTzF2Y3pSU055d1k1NVJnTVZ4aUVW?=
 =?utf-8?B?QUErV25JcjN0KzNqSCtheUFhY3FlaFZjbjFDOG9EZEliMTVZNlBqUi84a0lz?=
 =?utf-8?B?V2dFZ1FFSHBaeHpFU08reWRWejJDTDR3VUVxVHhOcE9yblF0Lys3c2wrMlEw?=
 =?utf-8?B?UDNlZ1lXczJJL0k0cEVBdDVnVkx3UE1YRHRqdkNlTU5wVURINk9yaUd1dHlY?=
 =?utf-8?B?Tk9qTW9FRkJJSUxaTDlCQjE4a3AyZmhUZ0JhYnI5TDdjRDAvNnloMHprUjdw?=
 =?utf-8?B?WjFHSm9JYUNWL0tnbU5GU2NFUTlpeFRXTGJMQTV6eWxsWXFEMjFOTTRud3pp?=
 =?utf-8?B?eUxQMjRBOThsSlZmeVZnTkRvWU90SFB0MDAyUEhlODkweTVDUHRLSWxpN2E2?=
 =?utf-8?B?VkJGY3lSN2lrZVRqRzdXT0IvTUJEeUZsVlJESWlteTkvUTEzUzVlTmk1UEcv?=
 =?utf-8?B?SGI2b3BsemkxSDdQa2Nvc2dDMHRWYWJRYXREdlhoTGx3NGpxaG5nT2RMWGhO?=
 =?utf-8?Q?5obDHAT+zLWPcQw+4PHL+121Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4370C03374239E4882C8FD489B9C7431@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6609.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1850f62-3a9e-4817-ebac-08dd571ab9da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:37:25.4817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UUAZSw3STS57n5RWAi9R2GgLnKKmsLIRd19oBnZyiAN4Jf7oKH5KNIT9F2Zn5ySvkBUh0kESqAu7uCW0dMkMjsfJySGizxhfFdTbARNYUNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
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

SGkgU3VtaXQsDQoNCk9uIDI3LzAyLzI1IDM6MTQgcG0sIFN1bWl0IEdhcmcgd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCAyNyBGZWIgMjAy
NSBhdCAxNTowNiwgTWFuaWthbmRhbiBNdXJhbGlkaGFyYW4NCj4gPG1hbmlrYW5kYW4ubUBtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4+DQo+PiBBZGQgUE1DIGNsb2NrIGRlZmluaXRpb25zIGZvciBN
Q0sgYW5kIFVUTUkgd2hpY2ggd2lsbCBiZSByZXF1aXJlZA0KPj4gZm9yIHRoZSBzYW05eDcgT0Zf
dXBzdHJlYW0gRFQgc2luY2UgdGhlIGNsb2NrIGZyYW1ld29yayBpcyBub3QgaW4NCj4+IHN5bmMg
d2l0aCBMaW51eCBhbmQgYWxzbyBpbmNsdWRlIHRoaXMgaGVhZGVyIGluICdjbG9jay9hdDkxLmgn
IGZpbGUNCj4gDQo+IFlvdSBzaG91bGQgcmF0aGVyIGRyb3AgdGhlc2UgbG9jYWwgRFQgYmluZGlu
Z3MgaGVhZGVycyB3aGljaCB3aWxsDQo+IGFsbG93IGR0cy91cHN0cmVhbS9pbmNsdWRlL2R0LWJp
bmRpbmdzL2Nsb2NrL2F0OTEuaCB0byBiZSBpbmNsdWRlZA0KPiBhdXRvbWF0aWNhbGx5Lg0KT3Ro
ZXIgU29DIERUcyB3aGVyZSBPRl9VUFNUUkVBTSBtaWdyYXRpb24gaXMgbm90IGFkZGVkIHlldCwg
ZGVwZW5kcyBvbiANCnRoZSBsb2NhbCBEVCBiaW5kaW5ncyBoZWFkZXIsIGRyb3BwaW5nIHRoaXMg
d2lsbCBsZWFkIHRvIGlzc3VlcyB3aXRoIA0KY29tcGlsYXRpb24uDQpXZSBjYW4gZHJvcCB0aGlz
IGFsdG9nZXRoZXIgd2hlbiB3ZSBzeW5jIHRoZSB1LWJvb3QgY2xvY2sgZnJhbWV3b3JrIHdpdGgg
DQpMaW51eC4NCj4gDQo+IC1TdW1pdA0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2Fu
ZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+
ICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbGsvYXQ5MS5oICAgfCAzICsrKw0KPj4gICBpbmNsdWRl
L2R0LWJpbmRpbmdzL2Nsb2NrL2F0OTEuaCB8IDIgKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bGsvYXQ5MS5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbGsvYXQ5MS5oDQo+PiBpbmRleCBhMTc4
Yjk0MTU3Yi4uMDE2YzZlMGM2MjAgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdz
L2Nsay9hdDkxLmgNCj4+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xrL2F0OTEuaA0KPj4g
QEAgLTI0LDQgKzI0LDcgQEANCj4+ICAgI2RlZmluZSBVU0JfVVRNSTIgICAgICAgICAgICAgIDEN
Cj4+ICAgI2RlZmluZSBVU0JfVVRNSTMgICAgICAgICAgICAgIDINCj4+DQo+PiArI2RlZmluZSBQ
TUNfTUNLICAgICAgICAgICAgICAgICAgICAgICAgMQ0KPj4gKyNkZWZpbmUgUE1DX1VUTUkgICAg
ICAgICAgICAgICAyDQo+PiArDQo+PiAgICNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hdDkx
LmgNCj4+IGluZGV4IGFiM2VlMjQxZDEwLi43MjM1YjNiYTAxZSAxMDA2NDQNCj4+IC0tLSBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oDQo+PiArKysgYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2F0OTEuaA0KPj4gQEAgLTYsNiArNiw4IEBADQo+PiAgICAqIExpY2Vuc2VkIHVu
ZGVyIEdQTHYyIG9yIGxhdGVyLg0KPj4gICAgKi8NCj4+DQo+PiArI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2Nsay9hdDkxLmg+DQo+PiArDQo+PiAgICNpZm5kZWYgX0RUX0JJTkRJTkdTX0NMS19BVDkx
X0gNCj4+ICAgI2RlZmluZSBfRFRfQklORElOR1NfQ0xLX0FUOTFfSA0KPj4NCj4+IC0tDQo+PiAy
LjI1LjENCj4+DQoNCi0tIA0KVGhhbmtzIGFuZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0KDQo=
