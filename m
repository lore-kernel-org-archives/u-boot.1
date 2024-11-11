Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395CAD2E9E3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6C089384;
	Mon, 11 Nov 2024 13:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="kQmYgOYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2B188C0F; Mon, 11 Nov 2024 09:35:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4586D8932E
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.schweizer@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB8Shsds6/MPhXEuV8CPRVwjY8Eh23GM2eAQ5uRfYYW1iO4UByURplWjTzifrpOBygh9CX7qJAymuCSq2KXGNk1KPn5Q/Sh4TsDR7zb/ft5VfcJSbmcbx69dv8oGcIgMkCJhOQDnnLO33Py1rPygDNK8TjKkxJOQO5xhP1XlKPyj3APLhWWRtgXKeBncdibYEdcVzNCdjPhx34+DjYikXQm4vI4FIaeTApJWVt5yBtoogqkcj+uLB64enPA2VYsx06USfdMe+DYhbkZZhGRiWoc+fNsL7IoU87ZIURQUKcrrPGOoCTgIT3XKXxMY5e/b7NrSSBpnu9XiPaXFAFJm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UZDeu0FF6NaeowUEpoGledGuE0KDTrkMZsiANI4N7c=;
 b=FhtePfADF+jp8BQs7AXWycT5JfRfLYR4rylpmAnpidhOQE8Al4lzTEmeLecbzJj7bWWAaH/jMfJ++ULPAGBRm5irb1ylR40RS3zD5kNaAaCijWoS5WtCMwGgj185rvQGXTHHUp1+gGf0914bhOC4/u9xui9Iw/1qTsYZYhth/dW3iOP9c2wPfbsFBu35AAb3rIW2E9tcnSixXuAMGVCRlpy+4TBL+qZrU5cgcLdb3j5CldlGWpVDgsecQ+0d833cvBmY0Oaet9qvM9cc2NISyG6adCTVVH7g4zKs3Jri2mkQcwrKSiJSCQzpy3HY6TUJOhgenax3nKHvKYu/44voiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UZDeu0FF6NaeowUEpoGledGuE0KDTrkMZsiANI4N7c=;
 b=kQmYgOYHqyUNIe8oImTwAN+C0R31GWoMxZLslkEWKCHMhM/idJ8ALLs03Dgww98V6QTHrzdtDqK5t9p0+RuejfwvJlmt10OV69h9aTL/Lm8aO5+86c3a0QSBo0Ujqn894UlKWAyw6vbrLT+TxY6QL2E9t9euRP6YVs8G/kUbFv1P4HEpmo7nDvN0eWvm+qXtSr1sMHHjK+uvy0cTyMo/ecy2zJ5lbQGAIPSTTYyZ4/xLzFtnCy8reOVNgYsIb2RiL87n7xmBuzQOCS3GGr9agy991VYdprTa+g2O4YYqc75AzSaKSAtZkcMB9zlce0NYdWkp1X3Qs3qEY+KHDhs0lQ==
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::15)
 by GV2PR10MB6982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 08:35:17 +0000
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6f39:3186:8eba:e3c2]) by AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6f39:3186:8eba:e3c2%5]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 08:35:16 +0000
From: "Schweizer, Walter" <walter.schweizer@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "Leto, Enrico" <enrico.leto@siemens.com>, "Sverdlin,
 Alexander" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v1 08/22] siemens: capricorn: use DCD_SKIP entry
Thread-Topic: [PATCH v1 08/22] siemens: capricorn: use DCD_SKIP entry
Thread-Index: AQHbMZ4kP4ElS4wnv0mpBsOgxkU4YLKxxgaA
Date: Mon, 11 Nov 2024 08:35:16 +0000
Message-ID: <1f2dfebdf27fac0813731a07046956f56a888ef6.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-9-hs@denx.de>
In-Reply-To: <20241108052143.26874-9-hs@denx.de>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7524:EE_|GV2PR10MB6982:EE_
x-ms-office365-filtering-correlation-id: 1d391cc6-6ff2-4a78-d11c-08dd022bc4fc
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T09zaXBVS0xSR0I4UzluYVVsdG5JSTVqaVJNNTN2YUpvekJZU2o5OGd1VU9R?=
 =?utf-8?B?dlRTb1Z4RVp3Z3grVTg4Tyt1MGkvWmRKZk5uOUNNUnRubDFVb1VxRTVkT2M4?=
 =?utf-8?B?N2gvbWFQdk5Ka2QyZkRKdmMvZHRXMURYTVhLd3ZxdEg3aThMQy9TSmdtRGR5?=
 =?utf-8?B?ZzBkQloybDdVMFhPVVAzdnNiNlcydWgybDRWSUJrTFhmS0l6cFZKQUo5NGp3?=
 =?utf-8?B?Mm9GMzJiYmpuSXR4Y0l2alFFSjRYUVlnVzJOYmx4cmNna0haYVdnc1ZENVQ3?=
 =?utf-8?B?NjhreVlJd2tVTUJYQnNHUkJ3ZVJBWUI2Y0t1Vjc1L2hPbmpvQnpEbTBiZ0FM?=
 =?utf-8?B?WTZWZnJLTUs5WnRDT21sSyt4clN2cmt0eDhKclUzVjJqQ2V6VXlPRHlCVk00?=
 =?utf-8?B?ZWJ5TTQrcGIyL2FZdFRJVU1ZOFJtLzZ5K2d2Y1o0bWRMQVA3SithcXRXM0x2?=
 =?utf-8?B?eEsrZHpBYWtjZHVLY2treUx3Q0RGMXpoUEhSekhlVjU1RnA2SVZPeWRMV2lO?=
 =?utf-8?B?NW5RM05ieUlTZFpFZHFjeWtKZFo4NUF0aDB1ZFRSRmJiWWx3MFk2Wk5TcEdj?=
 =?utf-8?B?Q0g1bDVhdTAyRGxSbCtZRHB6ejBrdkw4NnY3Mm03ZlBocDVkMFUvcUo0RC9u?=
 =?utf-8?B?eFVyTGdwVjNKa1h5MVd3N0wzcGhVaTdTdE5LS0JzMXdvUjF4aWgybTZqUmor?=
 =?utf-8?B?VHU4SldRcUE3TU1YYVpzZTUybTA2dUczR3BlWkJYaDFhdHFsbGs1SXZodWR4?=
 =?utf-8?B?VW5KSllsR3JzcWs1eVliUUx6TXA1YmxVOTR6RFBnYUdNQ1dZREhrQ3ZoTkxQ?=
 =?utf-8?B?WFVNcmdZc0ZmLzRCeTZuRVFKSDcrTmZDKy94OEtzRnZiSHNpR01uRmh2R212?=
 =?utf-8?B?SVRXL1l5b210UWp2cGpEVE94dHNHU09aMVFCMzZOdEhSZTlWQzNFckg4dUJ1?=
 =?utf-8?B?dE9vaDNLaUJybTEzVUZ1VVVxVlEvUThaS0JIUzB1ZEk1RkoxdmkyUTdWR0U1?=
 =?utf-8?B?R0lpVEdUdlhESExYRXZKekFHUEc2RjI0N3dpcUJWblJyRWJoTTlsUmhUb0hK?=
 =?utf-8?B?MVVRWFFFK2U2ekZUdmJLNDNXQWxGZnU0N3JwbmxoakRWVlpETi91ZXpQWlZT?=
 =?utf-8?B?TTEvdXFJYUgzY0ZGZ0RBb2kwdU1NM1pRc0VPQ3Z0Z2xQclg1aDl3QmgzMjF0?=
 =?utf-8?B?S2VMekRVMmpMZkNWNk8wMUFkWHlwWEdLZko5TmdUSXlIRkdaQTdGRGZ5SXZ6?=
 =?utf-8?B?U05IRWxMWXhKeUpCenFLTzRQTVV6aXg0M25LWXZ5ZzVnQlZzOXZxd1NZR3Jz?=
 =?utf-8?B?ZzJuV3h4ZmxyOXA2VFJWZHdKVWI4TGFjUjlLTXdaZDFvblVrYWdUWG51R3Q3?=
 =?utf-8?B?alprQVk5NnIrVDh5T1k4dm9ZSFBIM3BEYm1JSlZJMUFLajRkRTNZTXBLdFhC?=
 =?utf-8?B?MFB3U3hvKzR6YzZFUFhQQjVmMW1lc1Era2ZTdkpQK3Q0TU54dFgrTVhFTXZi?=
 =?utf-8?B?bWNwdXRnWDFicWJHcm9EdzhlbWRyd29NTTNoRTA0S0Q2cjE2akNzckJlNGdY?=
 =?utf-8?B?WjBZQTlUR1hIbE1QMTB1azJWaVQ1VnFBbHhmVC9BQmRRYmRXT1pZYks2TllF?=
 =?utf-8?B?V1JoU3lNV3kvUXFNZnY0OUh3ZG9tOGZralFRSkZNa1VERXBZa2dsa2J3M3pI?=
 =?utf-8?B?Vy9jajBTZ0QrN2wvUjNaWklPVEk4c3hseVJjbWJ0STZQa1d2d3F0bTdMRFRP?=
 =?utf-8?Q?ubVdEI8nV8ibSNIgO5KVmh9pHgNouHABssjTSgn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STNWL0wrcWh0MEJCRTJadWdZdUd0ckpGVVVrZ2xZNlgyNmhTK3B3V29WemdC?=
 =?utf-8?B?NzJtRDNjclkrZEVISC9OQytJalhKV1FHZFArb0pkQUNnU1BDQTBOTmk0SjYr?=
 =?utf-8?B?eUdubDN0a1RLSHJTQWQ4UWU3bFZnZ2JOdXpyeklvRitPcVd4WmYrblBGc0hj?=
 =?utf-8?B?QkdzWUZ4dDhVMko0Rk56RktvM0JJMzVkK3VRRXdjdnB6SG1EWndmc1VseTY1?=
 =?utf-8?B?cWNGUnVaNEtHekdnclR2enowZFA4d2hwRWEvQVVRSDFua3VVYkt6NVFzMmdi?=
 =?utf-8?B?VjhvODNsallHbVluL2ljaWdoa0xlNDZaR0xXSzlBUGRXZ2hWNlh0TlNTVnFG?=
 =?utf-8?B?WVBDMHFsWW0xQW1LcUZOV25KbG1qYmlDT3hxNXBzakk2VHoxVFN0dGdTdDJS?=
 =?utf-8?B?eGZIeU1mSzBTeXBpZzVRSW95Z0xHUk4rdGtxVTlXQW43d3hvMHVjR1AybUxB?=
 =?utf-8?B?dDFyK3F5cVpsN1p3elU1eXkybGh1eXhhdnhSQ3J5N0VSMWNrYUxjcWVsNHY3?=
 =?utf-8?B?b01raTZ4bUEyZ1hnWDgvTkROczNNVnBxYVRUNzdGeGRyeXdZWnlucHFvclFS?=
 =?utf-8?B?ZTBvNE9TL1czamxLN0NNTU40UTh1eUNzUGhrVHZLMXRKc2V2SzFPS2xFVlJI?=
 =?utf-8?B?Q2RSc2FhNVp3cVdnVytVbm1QSlIzd0lkc3dpUWpOaDJwMkJ1WGswOG5uQTJI?=
 =?utf-8?B?SjVxM1I3MmFxa0FSTk82dVUvaHdNQ2pIZ0FXUURjYjJyd28yS0s0c1hqa0tx?=
 =?utf-8?B?bzNma2hQSTlqK21WWStBbzA0U3pTNTQ0VFBSeFF5RllLOFc1aWU1SUhOTHJw?=
 =?utf-8?B?cDlYb1hnaTdaSEt3UWJnN2dIcFk4MUJYRjhYUjNkN25xY2xlY3BVMlkzQklU?=
 =?utf-8?B?emxKQllOUGpRaHJlWXVPUzloOXRsNXcvV3lFL1VKUEltNmhKOVhKZGFTZHdo?=
 =?utf-8?B?TTVZa1BPS1pSd3NSWUxJdTlBc3ZUeGNkc1dPa2RrNGRxcnI0YmlIWDM0Qktr?=
 =?utf-8?B?Q2ozWjB4WmxmM1dFWjBsZDhXVXNpSGZjcGxnVTVLVTJMVkkwakRUNkoyck4v?=
 =?utf-8?B?YkZmL0o0UmhMaE00TzF4M2NLOVUvYVB3NzYxaTdEOHJ1WEdaY01KTmZEMyty?=
 =?utf-8?B?M1NoU0ZncTJWRlhjWUZEeHo5eVUzYi9ySkZmRVd4M3V0OHA0bzNHNkpid0Y3?=
 =?utf-8?B?ZWQvRnpjeHduR2pKalI1NUFXckI4a0NCR1FHV1d4N244QklObjl5dmxHSjkw?=
 =?utf-8?B?WHg0ai9lSU54ZlA4U0FuWlBvUE9XWm5HWGFyV3hpc1VHdW5XNXQ1ejBtVmFS?=
 =?utf-8?B?UDdqcmJqU1QwcHI3ZU5rNWN1aElGUnFkTEVoYW9neTc0YzJPVmEzNW5iMzJ0?=
 =?utf-8?B?YzNOTDRKVU96MUVVVkswRnQ5bkpiSjNndjJscnFMUGxxQVZST2VhNFl0Q3do?=
 =?utf-8?B?RWR6dkkwelFOSXI4REFHMU1wcEhoOXBKR3NORUEzRksvTzFyME1TQS9UeEIr?=
 =?utf-8?B?NXNwdVdOWmh4dHBTbEZ5RGVXRUhlb2dTNllBRnNlZHFYRitIblNDSTdUMWhz?=
 =?utf-8?B?amFKZHV3UW1EUk1EdGJCT3JzbllucDZHa0tBQ3g5dWxWRlF3cDRTVjRxYU1M?=
 =?utf-8?B?UGR0QzJuZ2FCM1Q5RTE4Z1Q4REEyS3lCUjV1a3gzY1I4amk3cmE0eko1Y2Np?=
 =?utf-8?B?Q0FrdS9sbVBTN2V0ZnhXWEdtdEY2R0dQb29kbVdZRk9sdVgzWDFXai8vcCtY?=
 =?utf-8?B?MU9OUXFweUxuSmJNWmVDVlovcGNFZkxLRUtMTlNpMEhSMGpadWJwQzZTVWh2?=
 =?utf-8?B?Y1ZNTUtybGxFblI4WHg0ZEd2L011UEpXZ1lQdE43Mk9iSHFhN3VaY29qc3N4?=
 =?utf-8?B?aDU3NmRRUjlPUE5RTHplb09NUzRYQThtM1lWNWI0cUNpMVJJTmFVK2I2eG50?=
 =?utf-8?B?U3M3M2lBWTYrWGdtVWxBWTV3b2NvVytnWC94YmdlS1VJNWdPNW92MTQ5WGJJ?=
 =?utf-8?B?ZERaOW50dk5CM2JDaEQ2dXovaGlVNXBNWjh1MFRUTUNneG1MdXVnYkU2WXRv?=
 =?utf-8?B?V05TTjhBeWt4NVJPZXZ6ejFGUi8vS1FxS3ZVMERaK3h5dFlJZmo5TDJ5UENE?=
 =?utf-8?B?QVdmV3NHTVo5N1pHU3RwK1NESEZDb1VLUEtReFc4aWpnb2trc294Q3A3K3RP?=
 =?utf-8?Q?yZ/ZlmwvaD0a01zSDOXCv2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B31FAAEAC8ECDC479C878729E943E24F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d391cc6-6ff2-4a78-d11c-08dd022bc4fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:35:16.7935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yOwe1LEx+winRfqnEUkNW68q+YL9QXsMyxC+9Zg0kjuSQ8fxCCzUP3DKCxNGPH2d9Zo8IQI41bHOnHJ5HXew7Txq0I2yi++2nZKg9p1O+rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6982
X-Mailman-Approved-At: Mon, 11 Nov 2024 13:26:21 +0100
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

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA2OjIxICswMTAwLCBIZWlrbyBTY2hvY2hlciB3cm90ZToN
Cj4gQm9hcmRzIHdoaWNoIHVzZSBEQ0QgZGF0YSBpbiBTQ0ZXIGNhbiBkcm9wIFNQTC4NCj4gDQo+
IFdlIHRyaWVkIGluIG91ciBtYWlubGluZSByZXdvcmsgdG8gdXNlIHRoaXMgYXBwcm9hY2gNCj4g
dG9vIGFzIG90aGVyIGlteDhxeHAgYm9hcmRzIGRvIGluIG1haW5saW5lLiBCdXQgd2UNCj4gZmFp
bGVkIC4uLiBpdCB3YXMgYSBoYXJkIHdheSB0byB1bmRlcnN0YW5kIHRoZQ0KPiByZWFzb24hDQo+
IA0KPiBXZSBjYW5ub3QgdXNlIERDRCBpbWFnZSBpbiBjb250YWluZXIgYXMgdGhlIFNDRlcNCj4g
ZnJvbSBzaWVtZW5zLCBkb2VzIHRoZSBSQU0gaW5pdCBvbiBib290IGl0c2VsZiENCj4gDQo+IFNp
ZW1lbnMgU0NGVyByZWFkcyB0aGUgUkFNIGNvbmZpZyBmcm9tIGkyYyBlZXByb20gYW5kDQo+IGRl
cGVuZGVudCBvbiB0aGlzIHNldHRpbmdzLCBpbml0aWFsaXplcyB0aGUgUkFNLg0KPiANCj4gQWRk
aW5nIERDRCBkYXRhIHRvIHRoZSBib290Y29udGFpbmVyIHdpbGwgcmVzdWx0IGluDQo+IGhhbmcg
b2YgdGhlIFNDRlcsIGFsc28gRENEIGRhdGEgaW4gY29udGFpbmVyIGltYWdlIGlzDQo+IHN0YXRp
YyB3aGljaCBkbyBub3QgZml0IG91ciBuZWVkcy4NCj4gDQo+IFNvIHdlIG11c3QgZHJvcCBEQ0Qg
ZGF0YSBpbWFnZSwgYW5kIHRoaXMgaGFzIHRoZSBzaWRlDQo+IGVmZmVjdCB0aGF0IHdlIG5lZWQg
U1BMLCBhcyB0aGUgdGFzayB3aGljaCBsb2FkcyB0aGUgaW1hZ2VzDQo+IGZyb20gdGhlIGNvbnRh
aW5lciBvbmx5IGxvYWRzIHRoZSBpbWFnZXMgdG8gYWRkcmVzc2VzLA0KPiBhbmQgaWYgZXhlY3V0
ZWQgYml0IGlzIHNldCwgc3RhcnRzIHRoZW0uDQo+IA0KPiBBcyBub3cgUkFNIGlzIG5vdCBpbml0
aWFsaXplZCBmcm9tIGl0LCBhbmQgdGhlcmUgaXMgbm8NCj4gb3B0aW9uIHRvICJ3YWl0IHVudGls
IFNDRlcgaGFzIHNldHVwIFJBTSIswqAgd2UgY2FuIG9ubHkNCj4gbG9hZCBTUEwgaW50byBpbnRl
cm5hbCBSQU0gYXQgdGhpcyBwb2ludCwgYXMgdGhhbiBTUEwNCj4gYW5kIFNDRlcgYm9vdCBwYXJh
bGxlbC4NCj4gDQo+IFRoZSBTUEwgaXRzZWxmIHRoYW4gdXNlcyB0aGUgU0NVIEFQSSB0byBjb21t
dW5pY2F0ZQ0KDQpJIHRoaW5rIHRoZXJlIGlzIGEgdHlwbyAidGhhbiIgc2hvdWxkIGJlICJ0aGVu
Ij8NCg0KPiB3aXRoIHRoZSBTQ0ZXIGFuZCBpdCBzZWVtcyB0aGF0IFNDRlcgb25seSByZXNwb25k
cyB0bw0KPiB0aGlzIEFQSSByZXF1ZXN0cyB3aGVuIFJBTSBzZXR1cCBpcyBhbHJlYWR5IGRvbmUg
YnkgdGhlDQo+IFNDRlcsIHdoaWNoIGhhcyBhIHNpZGUtZWZmZWN0IG9mIGEgInN5bmMiIGZvciB0
aGUgUkFNDQo+IHNldHVwIGlzIGRvbmUgYnkgU0NGVyENCj4gDQo+IFdlIGNoZWNrZWQgaWYgU1BM
IGlzIGFsd2F5cyBzYXZlIGluIGFjY2Vzc2luZyBSQU0gZm9yDQo+IGxvYWRpbmcgaW1hZ2VzIHRv
IGl0ISBGb3IgdGVzdHMsIHdlIGFkZGVkIGluIG91ciBSQU0NCj4gaW5pdCBwYXJ0IGluIHRoZSBT
Q0ZXIGxvbmcgZGVsYXlzICgxMCBzZWNvbmRzIGFuZCBtb3JlKQ0KPiBhcyB3ZSB0aG91Z2h0IHRo
ZXJlIGlzIHN1Y2ggYSBzeW5jIG1pc3NpbmcsIGFuZCB3ZSBjYW4NCj4gYnJlYWsgdGhlIGJvYXJk
IHRocm91Z2ggZGVsYXlpbmcgUkFNIHNldHVwLi4uIGJ1dCB3ZQ0KPiBkaWQgbm90IG1hbmFnZWQg
dG8gZmFpbCBib290aW5nIFUtQm9vdCBmcm9tIFNQTCENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhl
aWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KPiAtLS0NCj4gDQo+IMKgYm9hcmQvc2llbWVucy9j
YXByaWNvcm4vaW14aW1hZ2UuY2ZnIHwgNCArKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL2lt
eGltYWdlLmNmZw0KPiBiL2JvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL2lteGltYWdlLmNmZw0KPiBp
bmRleCA0MzUwZTI5NjdjYy4uZTQ1ZjJjOTU4OWUgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3NpZW1l
bnMvY2Fwcmljb3JuL2lteGltYWdlLmNmZw0KPiArKysgYi9ib2FyZC9zaWVtZW5zL2NhcHJpY29y
bi9pbXhpbWFnZS5jZmcNCj4gQEAgLTksNiArOSwxMCBAQA0KPiDCoA0KPiDCoC8qIEJvb3QgZnJv
bSBTRCwgc2VjdG9yIHNpemUgMHg0MDAgKi8NCj4gwqBCT09UX0ZST03CoMKgwqDCoMKgwqBzZA0K
PiArDQo+ICsvKiBza2lwIERDRCBkYXRhLCBhcyBmaXJtd2FyZSBpbml0aWFsaXplcyB0aGUgUkFN
ICovDQo+ICtEQ0RfU0tJUCB0cnVlDQo+ICsNCj4gwqAvKiBTb0MgdHlwZSBJTVg4UVggKi8NCj4g
wqBTT0NfVFlQRSBJTVg4UVgNCj4gwqAvKiBBcHBlbmQgc2VjbyBjb250YWluZXIgaW1hZ2UgKi8N
Cg0KLS0gDQpXYWx0ZXIgU2Nod2VpemVyDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
