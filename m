Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CA9C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 10:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297A2805E7;
	Mon,  3 Feb 2025 11:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JgGQlGW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C18380711; Mon,  3 Feb 2025 11:08:16 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546ED805DA
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpTIvhYToRpPuro817I7bUpbljZ0mnDH99F83JQV1OF9ZqEnTMRvb+EZrB31220MKFVlCKywYlk5tFM7kIeEP4zOXltJ/5Jpl8SyrU7dwDadhy4Bl3CciCY9cH8wS7dQwB8eqmADr7hJXA5KinEcqWuIEP3KfEkaZ3EtRw+vkSndMhuRnLKhiM5xdemgQOxGZA4iJBKpBx+aUg8WV8y0zeC85gpZLH8EK8O3MQqW7T/E03jU6pndcDFI85TPsHEVyLVui2Dgs/9xSbe4IzhAFXZYMqv/0/O2+Vou4Et0DWjvjca6IsIl3pOxbmBWSm83DEOUJdn+YWVsmlVC7O006g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdWuQh5kkvoQWTOKCaIDSjnl00MxgP5+Pq4dmp97p3g=;
 b=q1B/R/SwetYrvnyjMqzpIjgARrMcgbubC4/4Clbs/IzAb9fbU83+Y+lPbB5gUdMlCEVwfex2kj9YuR7tIDVSmUYMIOm+H/ovEm6rXEOLOzRAXJVH3rjOiLQljeL8/aheH4MqgrxvRJkHcyukaX33xG8IKPYbKx2su2YV3LDP6J4jx56zhv8F1RKa6EKeVZZLgZTPtV6e8KnyK8fhRusDqF8vVBeFMhKUFLx2fsyytZV5xI5mCHXVqwV0wYAl8YzxMTHdtdv3c+G2QlfY7oUrzQDU++WTQ5P+YSm3oSPl5xL64NdTyUi+CM+RsnqeIJIVutJ6iAmwz3MgITOKdYpOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdWuQh5kkvoQWTOKCaIDSjnl00MxgP5+Pq4dmp97p3g=;
 b=JgGQlGW1QV6bWBPMhl6iuwOUfv/jwY8X0W48KnjUpzxUQdAvuxvso1emc9O/2ucNJD0g+8o3pFJbn4jSnF8KR+ng9l3c5JOnrP2axsjCmRgsBbmdDPWUPQmHKZt/Boe8lmXkya7L/17yzIno63HNI+qFDVtakcdWzHUwdegfd447tNex1RJ4qtF1oR4k8J0IDaFUBdB8yydfbpcCwQjW39YEqrbC3Nk6RjWJFWrE1SPLjkLkk+1W/wAQ0y0XS4osSptCulz6OQnPBNS9CzwKqYPJ1FYlq9SaeH7OQkZbpHpVv0MVFomYTn9mNcKxw7ekbsgiiDLbyjhMKb0iRKX5KQ==
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PR3P195MB1056.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:08:12 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%6]) with mapi id 15.20.8398.017; Mon, 3 Feb 2025
 10:08:12 +0000
From: Daniel Schultz <D.Schultz@phytec.de>
To: Wadim Egorov <W.Egorov@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "nmorrisson@phytec.com" <nmorrisson@phytec.com>,
 "d-gole@ti.com" <d-gole@ti.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 3/3] configs: phycore_am64x_r5_defconfig: Enable
 PHYTEC_SOM_DETECTION
Thread-Topic: [PATCH 3/3] configs: phycore_am64x_r5_defconfig: Enable
 PHYTEC_SOM_DETECTION
Thread-Index: AQHbcHI/rZG65uWiq0CTE8zKeSNWWrM1ZiwA
Date: Mon, 3 Feb 2025 10:08:12 +0000
Message-ID: <02d31fb8-42c8-44d9-bf2d-dd4385914c4f@phytec.de>
References: <20250127041612.985929-1-w.egorov@phytec.de>
 <20250127041612.985929-3-w.egorov@phytec.de>
In-Reply-To: <20250127041612.985929-3-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0P195MB2484:EE_|PR3P195MB1056:EE_
x-ms-office365-filtering-correlation-id: 38c4c361-f83e-47fb-ce93-08dd443aab16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TXFGNHBMTWJQaGtlVnBXU1g2bzc5WmhRenBoak4zTVVpSXBRVndmandJYU00?=
 =?utf-8?B?OVlubzk1bzBGMnJtUUVzRGY1dUZZS21XcjEya1BoMjlLODVSOThabG8wQ0Rv?=
 =?utf-8?B?bDM5bE5PaWRrcGZtYW1LNHBFd3JvT25VMGdFZW9VdGk5dUUyS1dDYmlESGxa?=
 =?utf-8?B?aStiaDZNdkNIb2pZdkxVbFc5T1IzSkc5dmxaV25NdUdhcE8rUVhPejUzWkJw?=
 =?utf-8?B?TVdLUzlLZitpbDJ2U3NPSjhkRnRWOTJzV1NQanhtMG44L0lBRFVTZ09LeE9p?=
 =?utf-8?B?SkZKUkVmd0xJZWRacjkrdTlkbkVuOVFsZFlBMXZTT21LdTU0czNTWmhLTlR2?=
 =?utf-8?B?RGdMKzVIRHVvQlBvMTlsT1RFL05BQUt1d0xhNGRjcEJNcnpmdjFMd3NpTFBr?=
 =?utf-8?B?a2lONFB4MWlZSmVyK0V5OGtVQW9OMUlSVUUrbXBYWjF5RVY3RzZTS2lGQmp1?=
 =?utf-8?B?dW9hUzNjZmdPdXAvb2FxWmRsSDJaVzByUGFzNGlaaEJQS3g4VmtlVTB3MHND?=
 =?utf-8?B?Q2JIYXRVSkgrd3AxblBlQitLNWp3eG16Q1VtbHEwb3psS2FWelQ0OENxU2dx?=
 =?utf-8?B?NHkwUU8xK1hTL0dRMTVSV3VlUnQzNFZIOE9yUGNXK3hPR0MvN3B6dUFxaDJH?=
 =?utf-8?B?VFJneFNQRlJqaVJBK2VOMXdMSDBsaEpmMWg1MlpJQzdhUTZuS2IrUjJPQzQ1?=
 =?utf-8?B?OWtmcVc0RzBsQk9NcW1BZEJiTkQxNi9nVCsyUFBuQXovZDlYeGlHWm5xVTNS?=
 =?utf-8?B?VmxreTVYZkJ0UUpIODJ6b3VGVC9hUjlsY24vbS9uZlVoc2cyQTZpMkJ2ZTd4?=
 =?utf-8?B?L2FVL1hmYWxWN096bGgwMWlVZStXUm01WDN1RU51eER3Uk4rQm8yUE9kSklR?=
 =?utf-8?B?QnhDL3VHNzRyMkVubTVsUzVYSlhtanJqbUtIek5LSW1wcU9ZQ2RncUJOT3du?=
 =?utf-8?B?Q0x3Ui84WDk4WWtpSjJudmI5dmpRa1RMblFvS09OZkQ1eGRTMXpYUlRpcG5C?=
 =?utf-8?B?M1NsTWNQRThVYnRiRklONnlxNmRlMlBqaEdmM0JQa3JvNG5SRFROKy92VU9X?=
 =?utf-8?B?RU1VczhVd0E5ZkZLV252djlwd1ZVMUZFVmVSbkhaM1dXOUg3SzBFeFNmeEV2?=
 =?utf-8?B?WHVQN1VYVWFraS9uZGczWjNESlRYTEE4T1A3N2FKVFlVRno4NnJCMnN6dFdv?=
 =?utf-8?B?UTFlZUpXb05UaXN4NlJ2MmptK1lDajJybkJLMHFFQXYvRFd2SlgyNE1qY2Rt?=
 =?utf-8?B?a0E4aElZMXRTMHRsdDZCajVkR3RmeVd4ZWZaMTQrMlpNVy96MzR0dU1ybEd2?=
 =?utf-8?B?cVJHRFpEd2txVEpkRVdiOEoxbktkV2Y1aEx4MFR2T0h4b2dWK21JdGFLcVZs?=
 =?utf-8?B?Nk96R09NeXpsNS9RZ0J6bStzcFpzRExEOHRoeUx4eUxsZUVqNlk3NU1hWWt2?=
 =?utf-8?B?djIwV1NMNGdNM2srTXk5R2FNc1ovV1hsbk9Ub1Vib2hBMDVCUEZPVXp2Y0I4?=
 =?utf-8?B?Um5WUjlUV0MrRGJtT0FEalZOOWVScjAxa3F0TlR2MVpDZFhpMzlYQkVGL09q?=
 =?utf-8?B?UXVOV1VuSk5CSXRBVU8vS0R1RERVT2x3dTBJUEpQN3d6TDh4U3FOQkU4d2ps?=
 =?utf-8?B?dzJwVVlOeXZiMzg5RjNQZVBheFlMTDQ4MFl1ZXFNN1FxSHhoaU5qcDRLTTFQ?=
 =?utf-8?B?WHhxRmV0WHh3M3J4TFE4TkNYNUFocXNtRHdmYzZJTkIyV0JWcHgyRHZLeTVU?=
 =?utf-8?B?aFFkUm94cGM3dTlKVXJvYU4xVmJBc3U1SlArRHRsWE4zanBjUkY2dEpPMHo1?=
 =?utf-8?B?elhiVE9maEpuaGtpU2xmN2E1bTdLNXJXK1A1a1RQZXdTbVRPbytlck1lWE1Y?=
 =?utf-8?B?K0N5anViZzl5c1JaS0F6alhyTUtCOU91dGJReEh4dUR3eVR6TVUwVlI2dGZT?=
 =?utf-8?Q?SgUuEXiSJZLckMHFjgKtx+sCknnD0CIz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhoc2J0Zy9hZFdGdVFzU3FhcE1OZUlTTkRYRFpickFBQW5ORVhDWUcvNldu?=
 =?utf-8?B?SmJiYnZHaFRYVmRNUjBmT1B3Zlh6TktZNWUzUnh1NU90NHlkVmY1NVB6MXJQ?=
 =?utf-8?B?allSU0NRNnlDRWVoU0E1cStGWnhhaThFVjVaN3o4UUo5bWorZXc2aU5CWFpz?=
 =?utf-8?B?a05sKzZraVR6NktSdWJvRXR6bVNVejRuK0xTc1R0M1FiY2lpNjdpS3dOcy8r?=
 =?utf-8?B?SWIrVktmVjFrbUVPOXdvOTZrdFMrZWVjZVJNQms1SHBXemJPTU4zY1hsbEp5?=
 =?utf-8?B?QkdoamtQRkM5dFFENDJyWmozZjRuQXNRZEh0MFI4OTRyaEVPVzRzblk3UGpq?=
 =?utf-8?B?TXFvZ2FEWk5qOEYvU2dDSk9URlJTUW9qVVlFVXovL3lxdzZtTDdPN2MvaGY3?=
 =?utf-8?B?R1BpR1NFcFNCOW5sdGdvSUowdDVaYVUvT3dSRk1QSUlrSE4wN1VKZ2RGZUI2?=
 =?utf-8?B?NVFnL1psWWVrb2JqNTQ1SlFtNnNtV1dSbkJ3cXhlZ0RIVVlQQVF1RGdXdHEv?=
 =?utf-8?B?ZTZQakgvdVgrNmlUaHozK2UwS0lTUCtqM3NkUmloVnRpVzhnR1ByOWl1VUEv?=
 =?utf-8?B?OW1LZ3FtMitVNFJkSno0SWFIdjhuMHpQSGxMMERBQ0xBb3hsRzZ1WmE0ZXJY?=
 =?utf-8?B?a3ZCQW5XL0tSZkYrSGlUakRhU1JzOGZZZmZTSDZZWWQyenlEcU44aUNSdGJX?=
 =?utf-8?B?SjZkOEd5akorNnA1eGVIQWdCdEFwaFBvSkVMUXE0RVhhSFg0SjdTL1NnMnZa?=
 =?utf-8?B?SC9uQjNNRXpreUxTRHJsQ2dnUkdkUjM0dWorcDBQSmxuUHY1WWRwTDBSNWdn?=
 =?utf-8?B?elNPVExuWTZ6bER3cVJualpiazNjZnFmczNJUjFMM3luNUh5emcxbWYwMGdh?=
 =?utf-8?B?dWhWOHkxVTRleHZLb1FwYnlBSlczS0JabEJpRE9YUTV6U1pOVVhCZ2xEK3lS?=
 =?utf-8?B?b3NoWWlMUEdpdnZWcFVOU2I0Q1doZDlsY2FkOXFzTTFJbml0M1IzaWlyLy8x?=
 =?utf-8?B?dVN1anlWU1V0UlAwL2txTDFoZnZSNHYrbmVaRzY5eHVUNktOTUlFajVUS0My?=
 =?utf-8?B?TDRqR3R4b0gvSXFzT2d4eTRSVDdyZ2Y4WG9XYXpBT0VsdU10RGxhZ0FWWGZE?=
 =?utf-8?B?Vm1Ybkh4NzAvb3IvR0Z0a1YxbE1YQi9ESEJmK01zb1pMODZwdEd0SDljV3dK?=
 =?utf-8?B?OEY3ZHRYWWNRWkRMOG1BSlo0ZHBPalZwL2hBc2J2blVoL3lGdmQ4bFg4V0lS?=
 =?utf-8?B?V1RyMmVhMUF0NkdhbnZxUzQ0T1J4S2hJcHF4M3Bhekc1ckFIbkt1MmtjenAy?=
 =?utf-8?B?b283WlZXNVNXd3IvN0NPTGRYazVYVkdwanlsWVA0Q1U2SXhibDVNcDkvR1Ji?=
 =?utf-8?B?K3o0aW5qZER5b000WGpsYUFzbTVkZ1huWDVZUTBRK0dCUlpYeWVzSVNiUGRr?=
 =?utf-8?B?NCttbUh6RlUwV2l5czRlT2pFN014Sm1oMEpRWFJUd3gwb3AyckppdFNZVjdj?=
 =?utf-8?B?Q2JGWlExZlFKNE1QanJDNlQ2eGtRY0NLNmRFeUVWSVpkZ2NXS29YMVFoNmpx?=
 =?utf-8?B?NFo3Y3Yya1hGMm40VkFYSDBnTmhMWEV6eE05TzVIdkhuR0JMTXhsbXBnWTV0?=
 =?utf-8?B?ZzNvTTg3M3pZWlJsb2Q3Qjh2NmtyWkhJTm5yM3JSN2NJeEo3a2pkdnBaNE83?=
 =?utf-8?B?bHBkM1M2RVFWN0sxTnhJdXd3UnhGSU5PRVFIelJrN3lwSHF2b2pJeEZsand6?=
 =?utf-8?B?Nm00S3dqcDh2K09Ca2h1YVFpMnZzT3QrZktLOTVLOUxOOHNNSS9ESll2c1FC?=
 =?utf-8?B?V29Za2Flb1lJRDg3TmNrc3M5cHpsY3dBczk4WG1MbVllTEZhMGFVU25HUkR1?=
 =?utf-8?B?ZEMzRXhRSGNibEszMmhhR3c3RGxSY1BOejlLZ2szdE9MeW1zZmVnbWFoRmhR?=
 =?utf-8?B?dEJkUGI2c0Q2SHc1dTkvNUkzSklPZUFKU3pQVk5iK1NJZVNVTFV6YmhlSUc2?=
 =?utf-8?B?V3R5YU9tQVZCemVUUGVWM2liY1c5cVBxQm0vWEswM0x3c2FZSzZ1U3UyWWdM?=
 =?utf-8?B?MVZBeGlOQ0MrRHlPMEZDaDNNcG5WSDRoS2J5Z21OSlA1UGtLb25SK1hGYU9a?=
 =?utf-8?B?cVZhY0xxVFdOY2ljUm5IVEFTRTB0T2hqYldYbVRaeW4zdnZwQjROUCtOUHY1?=
 =?utf-8?Q?az9cUl6wAecycm//c+UXDos=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83E7EC277C13044F884C25952F0A1F90@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c4c361-f83e-47fb-ce93-08dd443aab16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 10:08:12.5584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs//U/n1kBUUs8FSwGapmtOb14opO0Y+WRv6XeB15gEYVHhVqm+EBnH5TzMF9Eh7hMODQMdQHkaoQ+3kOVRl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1056
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

DQpPbiAyNy4wMS4yNSAwNToxNiwgV2FkaW0gRWdvcm92IHdyb3RlOg0KPiBFbmFibGUgY29uZmln
cyByZXF1aXJlZCBmb3IgZGV0ZWN0aW5nIGFuZCBmaXhpbmcgdXAgZm9yIGRpZmZlcmVudCBSQU0g
dmFyaWFudHMuDQo+IEFsc28gcmVzeW5jIGFmdGVyIHNhdmVkZWZjb25maWcuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFdhZGltIEVnb3JvdiA8dy5lZ29yb3ZAcGh5dGVjLmRlPg0KVGVzdGVkLWJ5OiBE
YW5pZWwgU2NodWx0eiA8ZC5zY2h1bHR6QHBoeXRlYy5kZT4NCj4gLS0tDQo+ICAgY29uZmlncy9w
aHljb3JlX2FtNjR4X3I1X2RlZmNvbmZpZyB8IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3Mv
cGh5Y29yZV9hbTY0eF9yNV9kZWZjb25maWcgYi9jb25maWdzL3BoeWNvcmVfYW02NHhfcjVfZGVm
Y29uZmlnDQo+IGluZGV4IDJkOWZmOTVkNzgxLi5hNzY0Mjk4YjE4NiAxMDA2NDQNCj4gLS0tIGEv
Y29uZmlncy9waHljb3JlX2FtNjR4X3I1X2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdzL3BoeWNv
cmVfYW02NHhfcjVfZGVmY29uZmlnDQo+IEBAIC01LDkgKzUsOSBAQCBDT05GSUdfU1lTX01BTExP
Q19GX0xFTj0weDgwMDAwDQo+ICAgQ09ORklHX1NQTF9HUElPPXkNCj4gICBDT05GSUdfU1BMX0xJ
QkNPTU1PTl9TVVBQT1JUPXkNCj4gICBDT05GSUdfU1BMX0xJQkdFTkVSSUNfU1VQUE9SVD15DQo+
IC1DT05GSUdfTlJfRFJBTV9CQU5LUz0yDQo+ICAgQ09ORklHX1NPQ19LM19BTTY0Mj15DQo+ICAg
Q09ORklHX1RBUkdFVF9QSFlDT1JFX0FNNjRYX1I1PXkNCj4gK0NPTkZJR19QSFlURUNfU09NX0RF
VEVDVElPTj15DQo+ICAgQ09ORklHX0hBU19DVVNUT01fU1lTX0lOSVRfU1BfQUREUj15DQo+ICAg
Q09ORklHX0NVU1RPTV9TWVNfSU5JVF9TUF9BRERSPTB4NzAxOWI4MDANCj4gICBDT05GSUdfU0Zf
REVGQVVMVF9TUEVFRD0yNTAwMDAwMA0KPiBAQCAtMTYsNiArMTYsNyBAQCBDT05GSUdfRU5WX1NJ
WkU9MHgyMDAwMA0KPiAgIENPTkZJR19ETV9HUElPPXkNCj4gICBDT05GSUdfU1BMX0RNX1NQST15
DQo+ICAgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9ImszLWFtNjQyLXI1LXBoeWNvcmUtc29t
LTJnYiINCj4gK0NPTkZJR19PRl9MSUJGRFRfT1ZFUkxBWT15DQo+ICAgQ09ORklHX0RNX1JFU0VU
PXkNCj4gICBDT05GSUdfU1BMX01NQz15DQo+ICAgQ09ORklHX1NQTF9TRVJJQUw9eQ0KPiBAQCAt
MzQsNiArMzUsNyBAQCBDT05GSUdfU1BMX1NQSV9GTEFTSF9TVVBQT1JUPXkNCj4gICBDT05GSUdf
U1BMX1NQST15DQo+ICAgQ09ORklHX1NQTF9MT0FEX0ZJVD15DQo+ICAgQ09ORklHX1NQTF9MT0FE
X0ZJVF9BRERSRVNTPTB4ODAwODAwMDANCj4gK0NPTkZJR19PRl9CT0FSRF9TRVRVUD15DQo+ICAg
IyBDT05GSUdfRElTUExBWV9DUFVJTkZPIGlzIG5vdCBzZXQNCj4gICBDT05GSUdfU1BMX1NJWkVf
TElNSVRfU1VCVFJBQ1RfR0Q9eQ0KPiAgIENPTkZJR19TUExfU0laRV9MSU1JVF9TVUJUUkFDVF9N
QUxMT0M9eQ0K
