Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F96CF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F2A283D8B;
	Thu, 20 Nov 2025 09:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D4NxpCwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0157083E0E; Thu, 20 Nov 2025 09:07:40 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EA783D3C
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTj7Kbh9acaC4tv6s6jdOxoqE1KWiBohK+dOVI9hGZagLzZiIJhUYuLEyppn5bOw5Is7xbuNHvNjimOy9WVc574pPN5CE2L9BVyleaLyklOwSoKjYLdXO4XhTHTFwABIJIWoPvGdQccWLVm1xprUm5zGsTTiYhgDCLphZhnlpQweyxvTMkCanORyIQQqVpn7TkOLRiaaXy7Kl9bw3Q1mkStKIaDne3WXRP1/2xfNN7Ln35tAHldZgKIeH7HLiHbjVKV3t3Gu1rZz7gIxeHfvwinJceP7PNT+yTwm1PyAye4EYEZtIs/HEfXmjdmNAn/CGYVdAXO5LjlObRm31j18ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/f0GJLlDmc/bIG7en57cNU9eXOpWxr9C5RWfdgw+DQ=;
 b=VVR4ngltiH9aY4ow6SEBqkUkOhNlSC0yn1WooQpOpPkLxXY5MPeo+bJQSKKj/gz7v75uJg6uFpLNE8c8Zgn46XKx783n3N4YzBRdwpE8wCv/XhRHcv/tmtFkUsdMsus7IpbiCC1ztwzgcW4gJuVlwwfceBoKWNG/DsP4gXdWzm+zYiUPh56BGNGv2BRe+4KvI+5Pk7KoRFDJuaW+gConfivPRhMsMwTJOWtbmUvkW+VkZm3O6rON1uq9yCQ2U23WAEdy4d0K700F/Iy1w3NOZ/etUnY5lcroDtkveXKiUuf4rpVjutRaYQKPSGa150ROoFMrnpGEuCeeJZ2ZyM+Qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/f0GJLlDmc/bIG7en57cNU9eXOpWxr9C5RWfdgw+DQ=;
 b=D4NxpCwy8phnHiqwpXU05rYB5eHUjCeYSk25STjGGbGjs5LdTwC5KkDre8lmLIwRDumDScdufxHxU6b383yF4ZhWHBTIQeHFW3orbXwl0sFVzThssnzdRDfV5XdJy/6jX3yUGBQd8fjRT99oNZNw11P1N7duoATXTBPrBSQZPN3FrP8fOJ1oLe64hn5ElwYTFlCDTiNHVGPuwt79D8e1oYMyYMn3POPlM4y2vMcryfo/nIua/WTCyotQuniKMQoRmCSkH8WDwqq1771AqCntypP6f9vF6DQdvS5yjkU21Mw17gxRklY3n/boUwGa9nVjf+cjJARn94xEJy2eBZydaw==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM9P195MB0968.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 08:07:36 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 08:07:35 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Leonard Anderweit <L.Anderweit@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>
Subject: Re: [PATCH] net: tftp: Remove tftp_init_load_addr error path
Thread-Topic: [PATCH] net: tftp: Remove tftp_init_load_addr error path
Thread-Index: AQHcWS/Cr8YHO5VKaEOchfPJEcRhYLT7NxQA
Date: Thu, 20 Nov 2025 08:07:35 +0000
Message-ID: <f6796887efbdc39e906067bd6737a3f82ff4aee0.camel@phytec.de>
References: <20251119083709.2000844-1-l.anderweit@phytec.de>
In-Reply-To: <20251119083709.2000844-1-l.anderweit@phytec.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM9P195MB0968:EE_
x-ms-office365-filtering-correlation-id: c7cd9475-9ba6-47b4-25bf-08de280bdd21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QmthWU9GWkpuL25OYUZoQUIwT05oYUlRRnRHZC8zc2FuR0kvY0ZWTXp2MVRB?=
 =?utf-8?B?Z1NLMmhlRmRKUHBIUi9obFRyWHY3TkhlTmlybFhqRWxhWEtCMGhrMFZsc29W?=
 =?utf-8?B?SkN3MGJQQ3psdDZGTHM2VWlRd1AwNmZVZVdaZ0pralRLdmp0VjVyYzFaSENP?=
 =?utf-8?B?THdtWVVSTnJJbW9oUmtsb04rZ25rY25uMko4MExZMVdmU3FBcHlpRTkxU1NM?=
 =?utf-8?B?blpRVm1RcEh6TmY0NnhRV0dTK3IyTklvNmpUd3NGL3IrNjQ3aEJmZS8xR2pq?=
 =?utf-8?B?NnV1NkkyZzZlRDlCczdZUG8rVi9NRFUzdzdYK2VMNWFhdWdXa0kvQ1U2ZXJh?=
 =?utf-8?B?MXUyd0dkWjA5djlkNzcvQTR6R2JvNHNXc2pOKzZNMVFPNnhRcHUxMU5wTnZG?=
 =?utf-8?B?Rm1uZmlFUFg1eFhYdDN0bC85Z1JFK3JLL0tXekd6T1JveE9Hb0tSaklPSjd1?=
 =?utf-8?B?QTlvWCtxSitYNTRTSkFSQkNOOGNhY21DNGJ6UCtwN3dTWFo4RTlmUDhmcjFk?=
 =?utf-8?B?bCtTcjNCWVdMN3ZJaGFNaHg1NFlPSnpBaVhJMUR1dzZicloxdFNvQXh4ODhz?=
 =?utf-8?B?b2Z6WlQwTzZMU09EUmcrbW1ScEpaa0J4MVJKR1JiZ25HYTF0SWtGSEF6K3Ra?=
 =?utf-8?B?ZWt3cEJnK1hVTktQQU8xTHBkMFVuWWpOTkVKb3Vvbm0zc0JGV2ZSQ01BQ3lE?=
 =?utf-8?B?TWZpOUZwM255Z015c04wUkZnS1NWdE9EVFNEOWZDeHl4c3JLdWd0S0Jybi9t?=
 =?utf-8?B?UGd0bzBmN0ZLdGFKalVQd3JjZlo5ekdObVB2Zk9BU2JveVZMaUdGUS9uNXlG?=
 =?utf-8?B?SXFZeEJIR3J6OStPaEtJc0FoTnNSbCtzQ25YKzJNOE9ldHZGWFR0K1p2alEz?=
 =?utf-8?B?c3R2KzFLbzNtSXhkam1HN1BLRTdZUFluRTFsYmt4SGx1NHlMMTNpOEs2cUV1?=
 =?utf-8?B?K0dUcVRIKzBESEhrdkNMNmVlZ0FZRDd5UmdQZXozUDB6Z21lOTlFcStqVmFP?=
 =?utf-8?B?ZTFIQVlhd0xPUHN2clRYL1ZrOEZaaEt6UDdqVGZZQ1VlUldHd2hsZVNqbXVP?=
 =?utf-8?B?WWlWMEtpRTNJaUd2dWtWdHJ0Vm8rUVVBMGc2aVpzVitIZ0tpWnd6VS9WamRq?=
 =?utf-8?B?TytKMFVuQmxSZ3p2WkdaVVMxd0pHVjIyUWY5aG9CVi9LYUNMeU9ucTBUalpw?=
 =?utf-8?B?eEt1b2pPaHZ0MlZBY0NDRFdZcHZuQ3BHR1EvZ09pSWJFeGdRN3I2bXFQK0VI?=
 =?utf-8?B?eG01WjM4bVg2MGx0UTdRWTJySFNOR2VITmxlM3ZpWkloN1BIaHBmQWZXS3dz?=
 =?utf-8?B?MmJTVEhBalZmd3dsakdvNVRjbi9DWGI3RmhmMHpGMGJ2NFp5YTF6YjF6TjRz?=
 =?utf-8?B?TU5XZTFRNEM0NXZjWlJQdkRlcjIxL3RMM3RVUWlYM3RyN0Y1NFRoOXZIaVc1?=
 =?utf-8?B?VWl3SjMzdDlqaWp0UlpQL2FMdFpibWQvSlRSYk00YVp0VDV3MDNqZXRpSmJn?=
 =?utf-8?B?SXdmT1IxcHg0YXFpV3UyclBvbWZBSjB0SDlnbHF5L3NaVVk5NEFIY21OeHNZ?=
 =?utf-8?B?R1YxR3V4QWNTZzJ6STlIUjU0aWE2Z0NqV2ZEQ3JPcDduNVhaaDltbUszVmtD?=
 =?utf-8?B?ZDA4TWdvL3Rqckl4N0Rzc2RZQkN3em05Q29TRUQwajY4SEd4Y0c0SEg2ZG9R?=
 =?utf-8?B?MUh1dFZYeUlabW14L0hNN0xiQW9kSFI4UnNOb3c5T1pjRENXdTZQRi8xenBH?=
 =?utf-8?B?bVRDS21NTEhHd2lxa2MzZC96UjFNcWRuS0p2dHM0WVJ6RjhqeEd3eXFUZks1?=
 =?utf-8?B?UnpPbm9MS2pad3NyZlU5c2Z4Y2pIWFIxQmlCSUpUZ2tUQ2FBcXc3d2J3S0ht?=
 =?utf-8?B?ZEZjMkErMDh1aEFZcVJMM0pHN1dJNlNqdXpYTnJQVmNUaUJjTVc5NlRBQjRm?=
 =?utf-8?B?YU9SVm8rNFBrSmJsa0c2N2grVVFmTFZHSjBSd1FFMVNxYmdLZUVMT2VpWDNY?=
 =?utf-8?B?S0dFekhqYnBEcG1NelZGWVg1cGxwTnNXc1dzbGFJWnhTN1piR0FYbnhUTXBB?=
 =?utf-8?Q?vrxRqW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxLd0hCZHRmR0NUcVRWQmI4WG13enZIcnJmUkNJL1d2YTQxWS9HWjY1eDNF?=
 =?utf-8?B?MGhwYVd6anZmZ0Z4QVNqa3k3UTlBai9xeXVHTHQ0MHZXMUg1VHk4MmhtZU1T?=
 =?utf-8?B?UWxsQmkvaVVIbjJGRWh5L0Y2Ulg0Z2ZhaTJpeVFtUGpDMld6WUREdjZRaUFz?=
 =?utf-8?B?NHM1OHhXU3hIS0dsWW1hdmJGUlMzUDJTYUhTUGVQS0tvSW9waDNoWS9XZGFN?=
 =?utf-8?B?VzVpUmVwWFNjbjM2Qnh0ek5IeWZnc1R5OE1tMFNxejFmYTJxNHJRY3ZFTUwx?=
 =?utf-8?B?ZER2M0o4aVVmWHZqcTRCTzlhS3VwSzV2Ym8vSStnM0djS0syZTZ3MU1aNFh0?=
 =?utf-8?B?MElzUUQwYlF5Y1o2SlptRnE2QXNMczdrNjg0aGxxNVZKUjB2SysxaisrVU02?=
 =?utf-8?B?aHoxcUxXcm90a2lWL25yUzdwbGpqMGlSSmJKbHZyK1Zwc0JwaUpKdlgwN2RC?=
 =?utf-8?B?UVdSeGp5MEtxMEEyQ1E1VVRWQnQ3L0dvcm91NDhyczY5SUtzTjBmS1VuWmNn?=
 =?utf-8?B?U1ViakhYRVdJT0ZiOEVuU3pmOC9UK0FvckpiWkNqR1RkMVdCSFB1TmRyUDUw?=
 =?utf-8?B?clhoNG55elFBMHl5L1A5NEo0aVJ1WGVFNmg0L0F1QjlEbTk4NkR6WWk3UU5t?=
 =?utf-8?B?bGFWZEVTUDJCdE04SkZZeU14NVdweVVsQU9wWXhPNnY5b21UUWFhb2ZWUUts?=
 =?utf-8?B?OWJpNXlhaCtIZG8vQXRRZ2tjaFluTDlrQzkxNmVReW1BNjFTbFJPRmlOTHk1?=
 =?utf-8?B?eFlvTU1iM2gyMzdvSEJHMStKZExsYVE3cFRxVER0eFgrM0tWSzQ5MEtTdExU?=
 =?utf-8?B?Vy9VUFo1RmpBcTk0aXpxYVlMekZBVm0yMitIc2FwdXNHOTRGbWxxWUZmR3Fj?=
 =?utf-8?B?eGY3eGNDdDRCTUNvYjYwVDVuMlpzSkwrVEd5cUZWQ2hodUpSYWRhYjRSN0RE?=
 =?utf-8?B?NGk3TUFHMzgrMVdpdk1aejhKVTEzVFB3cFJ0ZjY0NjdaVzNSODNZUzdnK3Zv?=
 =?utf-8?B?VGdxbCtsMHA1ZStGQSswcXN3eEEwNTN3dzhTSUhZQ3g0aWMxQTBhd0VMNVBu?=
 =?utf-8?B?SFp3TDd0akFBeGpOTE5Bd0xpaDVWNk5Wa28rTDl2NUpFRXIyZitLSzlFMmRM?=
 =?utf-8?B?U3NWcTlDd0lyTSt6WTFpeTQ1cmQxS0o0U0VEK2Q4NXJqaWFiLzloa042WDdC?=
 =?utf-8?B?My85dy9DTTROSWJBaEsxdVNnS3MxelplN1NsTlBkTDZRckFDZ1ZkZm12eGtq?=
 =?utf-8?B?MHpMaU1YL1Q2ZENhSGpEQVNIbXBqQm1QMjczRjRUelJqcXo4Q2lHM2JIZS83?=
 =?utf-8?B?b2ZoS1VyMVlFMkxrMVV5dEc5cmgvZ3oyUjgvTFcrTHdscFZEdGdHKy9hR094?=
 =?utf-8?B?dUdlcTVNb2ZZQnF5YW5ZbC8rUTY4aU9ZNUhnWGdXUTY3OWhYU0VZRTBpcG1n?=
 =?utf-8?B?NDI3M2RSY1hDVlhkelFmeUxjdnFZbFVyMEYxa0pjVzJJU2EyNnFNZG9wZEM2?=
 =?utf-8?B?R3lUbmZPNG9YRStlZEpzNDk1UmFJV1BzSzRuRzVOcDlnZ2YxR25nTUxkZmlU?=
 =?utf-8?B?VUhmSEtFc1BxRy9weHl1QzE2UXlMKzVkb0lOcTExc2Y4cDc2TFBaQis0YXJh?=
 =?utf-8?B?ZXRvS052ZjIxTHU4MUtNUkFJcUZ5VGVzaFpVQUUzWTQ2MUhWdG9oa2krUjQw?=
 =?utf-8?B?RUdGSG5EZHBHWlJQRXRzbjg4ejlYQTcyZ3cvbXgwdDJGTzBVMTI5Y1o0L0ZQ?=
 =?utf-8?B?bmlWTVVzd1AwK2V4c3psMnpJYVVyeFJoNE1qSDhYekltenZQM2VUeWxuNTF0?=
 =?utf-8?B?TXBuTlVja3VFbjlMNkhmLzM3VXkxbFh6UFdrd0xlcWpSZytudU9ybXZWRUpN?=
 =?utf-8?B?MEJZRGl1Q3ZYN2VYRFA0SUo2MWVCajdOMUZMVVJFc3JWQU9vS1lOQzZjRVF1?=
 =?utf-8?B?TlNGb0QyMDkxTmxnNHYwSGljR3NkRjVQa3dvV3p1dFArRU92S0N1N2tYLzZ1?=
 =?utf-8?B?YjRaRGRyYWVkbEZpUzRaYVhNYzl2SkxJaXNnVGtWb1FCMWRKenp3aWxWUytB?=
 =?utf-8?B?R0NhZlVtQTRwL0pVS0ZMOG5BdXlXaDh4bFh0L1ZwaUVOaHNDekMyRE5CWkZR?=
 =?utf-8?Q?2RE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55B808B02DC7EC46A8879B76F7A003D3@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cd9475-9ba6-47b4-25bf-08de280bdd21
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:07:35.2558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8EMVI/tt4smEWPMmJHN6ffhjOdDUz+LVeg8l/DWM1z7HzouB5ffwD2AnwM9KKmL2aEhxh9tJh0jgDSFvsfsiOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0968
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

SGkgTGVvbmFyZCwKCk9uIFdlZCwgMjAyNS0xMS0xOSBhdCAwOTozNyArMDEwMCwgTGVvbmFyZCBB
bmRlcndlaXQgd3JvdGU6Cj4gdGZ0cF9pbml0X2xvYWRfYWRkcigpIGFsd2F5cyByZXR1cm5zIDAg
c2luY2UgY29tbWl0IGFmNDVjODQ4NzFlNAo+ICgidGZ0cDoKPiByZXdvcmsgdGhlIGxvZ2ljIHRv
IHZhbGlkYXRlIHRoZSBsb2FkIGFkZHJlc3MiKSwgc28gd2UgZG9uJ3QgbmVlZCB0bwo+IGNoZWNr
IGlmIGl0IGZhaWxlZCBhbmQgY2FuIHJlbW92ZSB0aGUgZXJyb3IgaGFuZGxpbmcuCgpJZGVhIGxv
b2tzIGdvb2QsCgo+IAo+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQW5kZXJ3ZWl0IDxsLmFuZGVy
d2VpdEBwaHl0ZWMuZGU+Cj4gLS0tCj4gwqBuZXQvdGZ0cC5jIHwgMTUgKystLS0tLS0tLS0tLS0t
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPiAK
PiBkaWZmIC0tZ2l0IGEvbmV0L3RmdHAuYyBiL25ldC90ZnRwLmMKPiBpbmRleCAxNzYwODc3MTA3
ZmEuLjE4ZjcyYjZhNzRhYyAxMDA2NDQKPiAtLS0gYS9uZXQvdGZ0cC5jCj4gKysrIGIvbmV0L3Rm
dHAuYwo+IEBAIC05MDEsMTMgKzkwMSw3IEBAIHZvaWQgdGZ0cF9zdGFydChlbnVtIHByb3RvX3Qg
cHJvdG9jb2wpCj4gwqAJfSBlbHNlCj4gwqAjZW5kaWYKPiDCoAl7Cj4gLQkJaWYgKHRmdHBfaW5p
dF9sb2FkX2FkZHIoKSkgewo+IC0JCQlldGhfaGFsdCgpOwo+IC0JCQluZXRfc2V0X3N0YXRlKE5F
VExPT1BfRkFJTCk7Cj4gLQkJCXB1dHMoIlxuVEZUUCBlcnJvcjogIik7Cj4gLQkJCXB1dHMoInRy
eWluZyB0byBvdmVyd3JpdGUgcmVzZXJ2ZWQKPiBtZW1vcnkuLi5cbiIpOwo+IC0JCQlyZXR1cm47
Cj4gLQkJfQo+ICsJCXRmdHBfaW5pdF9sb2FkX2FkZHIoKTsKCnNpbmNlIHJldHVybiB2YWx1ZSBp
cyB1bnVzZWQgdGhlbiwgY2hhbmdlIHRvCgpzdGF0aWMgdm9pZCB0ZnRwX2luaXRfbG9hZF9hZGRy
KCkKCllhbm5pYwoKPiDCoAkJcHJpbnRmKCJMb2FkIGFkZHJlc3M6IDB4JWx4XG4iLCB0ZnRwX2xv
YWRfYWRkcik7Cj4gwqAJCXB1dHMoIkxvYWRpbmc6ICpcYiIpOwo+IMKgCQl0ZnRwX3N0YXRlID0g
U1RBVEVfU0VORF9SUlE7Cj4gQEAgLTk1MywxMiArOTQ3LDcgQEAgdm9pZCB0ZnRwX3N0YXJ0X3Nl
cnZlcih2b2lkKQo+IMKgewo+IMKgCXRmdHBfZmlsZW5hbWVbMF0gPSAwOwo+IMKgCj4gLQlpZiAo
dGZ0cF9pbml0X2xvYWRfYWRkcigpKSB7Cj4gLQkJZXRoX2hhbHQoKTsKPiAtCQluZXRfc2V0X3N0
YXRlKE5FVExPT1BfRkFJTCk7Cj4gLQkJcHV0cygiXG5URlRQIGVycm9yOiB0cnlpbmcgdG8gb3Zl
cndyaXRlIHJlc2VydmVkCj4gbWVtb3J5Li4uXG4iKTsKPiAtCQlyZXR1cm47Cj4gLQl9Cj4gKwl0
ZnRwX2luaXRfbG9hZF9hZGRyKCk7Cj4gwqAJcHJpbnRmKCJVc2luZyAlcyBkZXZpY2VcbiIsIGV0
aF9nZXRfbmFtZSgpKTsKPiDCoAlwcmludGYoIkxpc3RlbmluZyBmb3IgVEZUUCB0cmFuc2ZlciBv
biAlcEk0XG4iLCAmbmV0X2lwKTsKPiDCoAlwcmludGYoIkxvYWQgYWRkcmVzczogMHglbHhcbiIs
IHRmdHBfbG9hZF9hZGRyKTsK
