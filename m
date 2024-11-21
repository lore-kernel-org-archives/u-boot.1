Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E8CD6ED26
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 13:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1A9896BB;
	Thu, 21 Nov 2024 14:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="v4CzIaaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10E9489672; Thu, 21 Nov 2024 14:04:37 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E45896BB
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI66ECSocZRqLQhXWf+yxpcrlHb6H7/VR+MykicyE/Wbl3mrZjOljcEGY34nnVGmkGyexaxvER8HHCWhtkMQg09e16ktl3qrZFq1Dv550bdy5q+nbi540JHsMeugJX406f7ljXOLSginmOipm4dp755LsUl4h4CSrpYd9lkIW8jI2nKs2Wb5AskRRa+Tjhhy5XG3eS7kSgphxtQscxvcF2Bfo9GGaU4o76WViQfPVEslYoOkeBLIczywB7WlardmM5Hd0vZW89g+AkK+5Y+zyIl/s3KJFdIh4yk+5SHVgf008Htt6wGbdN+9X8QSpwxTOheCXVgNbdUzphCPTO9QSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTbTT6E+zhKLIW8iqbyTm1nRpiWtzhZDVAPukd3HF0M=;
 b=XFaQB4vwuTYvO33IE7FtVa2fNvH20L29p+zDcQnBSwhn1IbcnvSF9QSWTzaqZQi6kEDZo4/BhPlOoduQIUr58EthoxUUeDF67YJOyjVf3TphQ/FAecCFzFm5moVKU3DG3HNcFiHtQiNHkELHEXmJ/qkDyzwR5VuGuIxwZmtZdzanAPWWtCZjLOHQeGrqfsvpPQd2DYPRq3JfmjjQk42croqFC8NsNURZhJQSldu/S7fpAvGV/HYA/P3vWfTt8FG3zLtjtWR8NMQKmPpE0LX3WNs6rE/oWMVX38IAPibZzprIdy1XQ3IwU2tcqpegvpCYyP4JRIUKDgGTFJSyoYgQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTbTT6E+zhKLIW8iqbyTm1nRpiWtzhZDVAPukd3HF0M=;
 b=v4CzIaaBLfEQflVjejbmFnWLWj4Z3SBSVwx/C3aH+7c7us221iSuKE5uKa3m7nU6XJkhP/txqa2D1S+hGUErkxceVe/Xc0JTNPYnuZrYI2m5IHEBEmveD8vyHz4/hKpBfOR6vzbdV65Nnhoo+QzDldXnh3RvUmK9u2MIwhzX0MVZBxJUT9+81lnSKYq1mzrZDnMAyaPdxkbc865dUp6yXh5yLld9fou8IuKnzu5DqUqPBagCF5h1yFPNUpAKpo35a+aCgDiIXGq5Z88UtAM9venpspmRhO1bUpDvwXKeeex5EdUMZWgCp7Mtgj/WFDSAmEFCjKN1BRMBpyn06HvC0g==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7452.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 13:04:31 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 13:04:31 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Zini, Alessandro"
 <alessandro.zini@siemens.com>, "Leto, Enrico" <enrico.leto@siemens.com>
Subject: Re: [PATCH v3 14/20] siemens: capricorn: small board updates
Thread-Topic: [PATCH v3 14/20] siemens: capricorn: small board updates
Thread-Index: AQHbO9XpcnGrnImBJEeS7z4jIh69vLLBtCEA
Date: Thu, 21 Nov 2024 13:04:31 +0000
Message-ID: <beb72e44f01c4ba41cdd32b3e13dcb2f0d001b79.camel@siemens.com>
References: <20241121052601.72880-1-hs@denx.de>
 <20241121052601.72880-15-hs@denx.de>
In-Reply-To: <20241121052601.72880-15-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7452:EE_
x-ms-office365-filtering-correlation-id: c899a178-4457-42fa-d859-08dd0a2d09f5
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WXIrRm1IeFhPYitVRER5dENXSXkxMUxpTDQ0SVdQOVBsdUtFN0NGYzRULzdO?=
 =?utf-8?B?dGxHdnNQblVGemRjdFduOHEzMkpnOWZRc3dSNGh1SWtHTU1Uckt5U2RaTzVR?=
 =?utf-8?B?MlArbi91QmJCSEVoUEFrTDJTZUVGL2NxcWVjV1ltZDRwRHcxM0hxSWU0ZnlS?=
 =?utf-8?B?cmM0OW95eGxMMWRDM3FabWpKcjVmcFZrbUVhTllkMFhNbENMV2NSa21XZ1Jv?=
 =?utf-8?B?Tm1hSENYODRtYjN1cDVEQnpBY1dzV01FT3NZS0JlQzRYcnRwWWxON0dudEVk?=
 =?utf-8?B?UGoyZ0R5WkhaSzI4WitPTzMxdk43SWNNVnVMaWtsSSt1QVlXenE0V2lETUhW?=
 =?utf-8?B?OS9HT1hTOSsxbTRxVEZLQ1M5RS9uVjlic0NEcVkreU1SeHM2cFQvcVFDM21I?=
 =?utf-8?B?RGxIOVA2YkxJTk5DQ3YzM1RFWXVzZUdkV3R6YWJvajZNK1pUL0ZYMHJKY0kx?=
 =?utf-8?B?aHVLOFF6UDB4TjBVbUNvUG51OFA3dC9tdTJiTms3SnhFM3ZoUzgzU05oUzF0?=
 =?utf-8?B?WEQ3N2VNV0dlTzVzOG1OOE5SVlVVaVVwcU12UzlVZm1GdlF3b2NIY1YvRUkw?=
 =?utf-8?B?UmM2MTNnWHZlVUxkSW02ZlV3OVR1bGtwYlhvQkpDU1BISVBkajUwUTZnN2s5?=
 =?utf-8?B?RS9DUkEzU21jN0NQRXdQclJvdFNiL2NxdnpEN2JieWNCNC94Z2VTbWhpbW9U?=
 =?utf-8?B?MU9KRmprNW9QM29zelRDNTlReEp4L20wRUptb1JqSDdXbnkwa2lkSW5xRG9S?=
 =?utf-8?B?a1Q3U1J1YW9NaWxFMk0ycDdrVC8zWW96OHhMWlhNNC9QSTNNcUs3UUhTRnp5?=
 =?utf-8?B?NmlDK3BjODRJeXkrN1FWa0FNTG1aVy82aWMxNGE3UXNYL2VSODVCVjFOKzQ5?=
 =?utf-8?B?L1FRd3RwMS8rNXJKbkwxV2p2RDBWOUdHMkdkS2NFWWFMOFgwdFdmVTF6NzNz?=
 =?utf-8?B?NmVabE5qT3lUVXlWdlFzVzdwQUwvcUFuTmdDVEhVWmZZbnlCVFVvWHJmYUpI?=
 =?utf-8?B?bHIySERpSjFWdG4zOUFoSGxjN0VPWml5OFBOWWFkOEM0VG5lQW04UUhuamE2?=
 =?utf-8?B?MmxrVWhOZXZXa25DdERGNnhldlBOUGNpejFUUjdTUFh4ektYY3I5V0k5Q2FJ?=
 =?utf-8?B?QW5MU2tEMXh5TWxVZUN2ZzBDY1dad3U4Rks4SUZYWDZzSG9EUlkwdXJodmFB?=
 =?utf-8?B?QmVEQkJzV2tMRkw4TDBHMkkzNHFSazd3VjViUjJtL3lkcFhNSnVNR0ZTalpn?=
 =?utf-8?B?eUI1dE11OEJ6eHE5ZGxiZ1RRbUFTQzY1QnAyVitLUlQ5SjBqeXFrTk5Odkkr?=
 =?utf-8?B?MlpEVEJmaWR0SHdXSWVLKzk3NW9odEdTT2JuVGNaSHBucjhyOExaM2RTT29a?=
 =?utf-8?B?Z3VHczJvTFFXeVEvVi83TVNMTUZkMWRnaDBjZS9WQko2VXpVWlp2cmJQUTg3?=
 =?utf-8?B?dmNFbWk2YXdoOXZYTTRsdFFNd0VDUDVvdEU1dWtwb2pCaEpVZG9JMUdUSW40?=
 =?utf-8?B?VDM1QzFXWnZ0VllHRWJ4SENPeDRkai9TdWhocU83NUxqdUtBcy9rUzI4dUlR?=
 =?utf-8?B?MnhFTGpEY0pacGpXNzQzLy9BeXlRekxGWDF5eCt0VGJRUW5NdHFHUUo4R1l0?=
 =?utf-8?B?cUUwZnJaNGRtMmwyWGxhclBBT2FuQ0tVWU54d3o3ajhvRm8rMFE5eEJZNGVM?=
 =?utf-8?B?UzZ4eXBRWFV4ZjBQYVIyVUNLaTJ5Q1MzTk5zTDVjQlQ0WkJXUHU2amFPQ1dE?=
 =?utf-8?Q?vkioyJJwMx4S+IDL9LLhen3W1bDx5JJXfO/G5GO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUtHdkFuVWliV3ZsUy9iMU9JMWN5aVU2RnptZDRyMEFvSzM4M3B0cU1YdjEr?=
 =?utf-8?B?SENITnV3SWF1TUVLVUZHSjFFeEhIMHEwT29mcUErams5cWpNUlkzZFJYdnBP?=
 =?utf-8?B?VFc2V2t2NWhYaVUrZk4yY1l2cTAra21xZ24yTFZkdnNjWnJSK3NweTJONDYr?=
 =?utf-8?B?dE9LMnRLcFdWeG56bjdLdnRwa1JtRkdxOFRGVkcrb1hJOWtRQWJ5NGZZQ0dU?=
 =?utf-8?B?TUYvejd5SFZiNFJUOEx4V2ZjcU1YZmFzM1Z6bFNQSDVQemp3Q2RoZXA0Szgw?=
 =?utf-8?B?N0k4T1BWMVVvU0ZNV2dxNDd1U3o5SHJpT1RiWWxJWHlvU05BT0QvUmszV3JC?=
 =?utf-8?B?eVlaMGlvd25SQVI4T2lId3pJSmhEN0RMNmhLSEFiOU9QK3c1cy9qclVMSHB2?=
 =?utf-8?B?eHFQbnJ5UVYvUXdBdzBlTXIwUGFieHZXaUx5L0kwUnlGSDMxQmtrV0JxdlhF?=
 =?utf-8?B?RzFna28vejF4Vkd2bWZxaU95WVdqNXRkWXp0bVp6OXNaNzVCdzZXTjJRQnYx?=
 =?utf-8?B?NjRVMk9UOHlBaHNoc3dTRVk0d0dYRXA1WUp1Z2RGUG5LUGhHdDBlNWsvd1VN?=
 =?utf-8?B?SWZ4bjUxMU9LbnRvVGZzTk8rVU1VeXRYU3hzS3FwUVNVVmhIK2k2ZmpuYjhX?=
 =?utf-8?B?WlpDTzNNVVcxS0EwdERsY09FQlRhS0RyVGs3NG5IWlBMbzlZRW1wUDdmVy85?=
 =?utf-8?B?cTdhRDd6WlVHZW1zS1VJWHdyWkFCcSs1TlFPbW9ZcHhVMWpoQVR5RzkxYlNl?=
 =?utf-8?B?dzJkV0tvK3VrNjJiRzFjU1AwbnNPNHZUMmVXM09MZTdrT2RGa3doQXRtZ1M5?=
 =?utf-8?B?OG5oSVJod3JzcUxSZXRBZHEzL2dsZTFwOUFuUjBLOVFaZ0RIRWdqNkdadTR4?=
 =?utf-8?B?WU9DYUozaGsyRzh1c2tuRW1mK2RENkpWbEwwekhZSGltNVZweW04Zk10TmU0?=
 =?utf-8?B?TDUwRTRFM1BESTBhb1Z1UEEvd0JJTEl0c09KMlQ2b0lKcHpKNWNoTzZRbDVu?=
 =?utf-8?B?b2dvcjhQSjJVQWFHQWswcjBLVGhDZVdEb2h2QjRxc1RuT1puWHE4V05obGpM?=
 =?utf-8?B?d2ZZQ1FqMnFMOEZWeEhWSDQ3MDhwVW03WDFqc0VFMTBGMk9KaGFzdnAzVjZn?=
 =?utf-8?B?NERGNHNmUFY4clVpUzJ4N0tIUGFualhqU1Z4bUdWOCtZR2pjOWJHWEl3bHB0?=
 =?utf-8?B?bTRaTWdRa1BXZVVLTmt2V0FnS2tjSDdHSklnN3BScGplbHhpU3F3bHk3TFk0?=
 =?utf-8?B?ZStVeVRDZlpCN3liOXVlSTd3U3YvVVhBRE1OREd2ZmZrRlIwZTkydFJxeVov?=
 =?utf-8?B?V2Zyb0FNc1FXSEpydDJ2eVFtVHR1dWx2U1JoTFhSN0dFRzh3MmdzbC9zUTk3?=
 =?utf-8?B?VWFQQjgyNk5tTVVzN2dhZWJHbmVTNWNnT0dGbnFUSlhleTJsMTdUQUcwMG9o?=
 =?utf-8?B?NTVuM1pmUlRuUVhXTG1PVlZnUkJoVjlzeDFObFlQSHcrWWNRa2tyNFZIM0Rr?=
 =?utf-8?B?VHBrL0FsSHdKeTR0aHJpQlhkN2RsOU1DeFljTE9lWS8zbUg4bW84bUJpU0Fx?=
 =?utf-8?B?K1g5cXY0NkdlN1ZiaG9EYUI2ZXZYNHg0MWZlbkFxenJDS0QyVWFwd1ducmdW?=
 =?utf-8?B?bVM5NFVkOFdxazJFV05CYWxudlR4cktGZzNtWWRxZElqMUZJeVVNS0xsdW9q?=
 =?utf-8?B?Z3FxdEdzZk5YeWtkckh4ZU4vdFBHdkt0K0dwVE5aNWFGUlE5TnQ3QmFXa0tx?=
 =?utf-8?B?K3pWYzNrRGxYdWU1azBDRzJhMWVsWmJ1NDVHdnVzNnF0d3hxTjZXczVXaEtO?=
 =?utf-8?B?R2o1UnVPb1dIZmZBcEZqcjJQQlZQL1FGN1FHSkRCOEVvWCtxVlBxaVlpcWd0?=
 =?utf-8?B?ZUZVWVc5d09ZUkNxWW9FRjM5amppQWhQdjBIZ0w4TzZVc2wyR2tvWExLK3BZ?=
 =?utf-8?B?R0NOVklEZHRVUXh5MnNUUVZORi80UXNxQzQ0UE15aWhPR1FFMllrREhrL3p3?=
 =?utf-8?B?c1A2R2RwWExkNlVrRTBtQmdBRkFzVnBEQlIrWGFYcE4ybTM2VUxZTTA2VGRE?=
 =?utf-8?B?WWhaNFlIT0RyUjROODczbDVaVnBWSXBEelRSYWhON0NaeEoyQmcvcmRIU05C?=
 =?utf-8?B?cnBQMFNVUkVOU0c4T0VBSnZyMWtpYXZDZW1XdTQ4Y2w0YUpJNFRCMnF2Z1p6?=
 =?utf-8?Q?dJseK+f7cIt/1bQsSnlySMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CF1636EE12C56499B6C715F8EEBC99E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c899a178-4457-42fa-d859-08dd0a2d09f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 13:04:31.2734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KLhswtjs+M0GWugL67JzgelG56hItw+MSTx7sQYSZS+bzg3zC0XGA7URl3fU/zQ+mct4bFCbOQ2daSCJp1PyDJzT5nAfw8T9FdvxDdwz0lY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7452
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

SGkgSGVpa28hDQoNCk9uIFRodSwgMjAyNC0xMS0yMSBhdCAwNjoyNSArMDEwMCwgSGVpa28gU2No
b2NoZXIgd3JvdGU6DQo+IHdpdGggbmV3ZXN0IFNDRlcgYnVpbGRfaW5mbygpIHdvcmtzIG5vdywg
c28gY2FsbCBpdA0KPiBmcm9tIGNoZWNrYm9hcmQoKSBub3cuDQo+IA0KPiBBcyB3ZSBvbmx5IHVz
ZSB1YXJ0MiBhcyBjb25zb2xlLCBkbyBub3QgaW5pdCB1YXJ0MC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEhlaWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVy
IFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0K
PiAobm8gY2hhbmdlcyBzaW5jZSB2MikNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gYWRkIGNv
bW1lbnRzIGZyb20gRmFiaW8NCj4gwqAgcmVuYW1lIHN1YmplY3QgbGluZSBhbmQgcmV3b3JrIGNv
bW1pdCBtZXNzYWdlLA0KPiDCoCBhbHNlIHJlbW92ZSB1bm5lZWRlZCBjb21tZW50IGluIGNoZWNr
Ym9hcmQoKQ0KPiANCj4gwqBib2FyZC9zaWVtZW5zL2NhcHJpY29ybi9ib2FyZC5jIHwgOSArKy0t
LS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3NpZW1lbnMvY2Fwcmljb3JuL2JvYXJkLmMgYi9i
b2FyZC9zaWVtZW5zL2NhcHJpY29ybi9ib2FyZC5jDQo+IGluZGV4IGFkNDc0ZDliYWEwLi5iZjA0
ZjEyYzc1YiAxMDA2NDQNCj4gLS0tIGEvYm9hcmQvc2llbWVucy9jYXByaWNvcm4vYm9hcmQuYw0K
PiArKysgYi9ib2FyZC9zaWVtZW5zL2NhcHJpY29ybi9ib2FyZC5jDQo+IEBAIC02Myw4ICs2Myw3
IEBAIGludCBib2FyZF9lYXJseV9pbml0X2Yodm9pZCkNCj4gwqAJc2NfcG1fY2xvY2tfcmF0ZV90
IHJhdGUgPSBTQ184ME1IWjsNCj4gwqAJaW50IHJldDsNCj4gwqANCj4gLQlyZXQgPSBzY19wbV9z
ZXR1cF91YXJ0KFNDX1JfVUFSVF8wLCByYXRlKTsNCj4gLQlyZXQgfD0gc2NfcG1fc2V0dXBfdWFy
dChTQ19SX1VBUlRfMiwgcmF0ZSk7DQo+ICsJcmV0ID0gc2NfcG1fc2V0dXBfdWFydChTQ19SX1VB
UlRfMiwgcmF0ZSk7DQo+IMKgCWlmIChyZXQpDQo+IMKgCQlyZXR1cm4gcmV0Ow0KPiDCoA0KPiBA
QCAtMjcxLDExICsyNzAsNyBAQCBpbnQgY2hlY2tib2FyZCh2b2lkKQ0KPiDCoHsNCj4gwqAJcHV0
cygiQm9hcmQ6IENhcHJpY29yblxuIik7DQo+IMKgDQo+IC0JLyoNCj4gLQkgKiBSdW5uaW5nIGJ1
aWxkX2luZm8oKSBkb2Vzbid0IHdvcmsgd2l0aCBjdXJyZW50IFNDRlcgYmxvYi4NCj4gLQkgKiBV
bmNvbW1lbnQgYmVsb3cgY2FsbCB3aGVuIG5ldyBibG9iIGlzIGF2YWlsYWJsZS4NCj4gLQkgKi8N
Cj4gLQkvKmJ1aWxkX2luZm8oKTsqLw0KPiArCWJ1aWxkX2luZm8oKTsNCj4gwqANCj4gwqAJcHJp
bnRfYm9vdGluZm8oKTsNCj4gwqAJcmV0dXJuIDA7DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
