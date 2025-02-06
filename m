Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A28C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 16:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFE080AE1;
	Thu,  6 Feb 2025 17:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mAEL9fxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDD8780BA8; Thu,  6 Feb 2025 17:54:38 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1DA80A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 17:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZingkP1sW824Qr4kTzaIkC3AB9eBb9QYWEK2ZL75Yl1NLNeqqlquzilhf2px8ea/iC9wvcwJ6i2D+OPXf288FrymSMSSM4gkjrzaYUp75CFfGo1y20uuBw3U9+f4QKULQ7zaWYhbvKc0hwM1PTtsKlOZxA6fTeuJlNvD3G765S3hbdyb0rRo8SFA3OBnMXxA1vW4A8cd76H2Ujv1uf0QVn7/LPcCtHLG+59jyzKqXd7MrWnCMqXD0Ygn4Wfo8kMq0ig0yEE0ub0tLco1wZA8K8xZMPqw+fGQuSpS8gXrdVqQ9AyHGg0iJIJgOBl8iA+TWdQ3IBn9QdICJ7i+tbmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqkT20LB8iCh/2nQ584Qq+nQNTit6Wi6nV7BuR5dZHU=;
 b=Dqfs8GiXr2U3hVCCVKtmIzQryz1nXlnjO2OMu+QOKPV1/Go3H7tH/6Yvqln1I6tlsSOtYkjTt+f2wTF4k5mWrZ7NhqNXk8lX39HjElChnKiJSDHvKDvjNkAfRFopz8rT9VPfAEk/5SAygajg7wbZh/sivzBw2wdvNvZPZ69C+docQg03ZvwHM8KYMZYLXSZ9iq1csk4Te1hyNTKc/1W8L25+C52vzMvWKYeY+MZyOFduQ/dqCtNz+QaXHsc7n1lbnpBsIet0voWSAd+X0+1a/MdeZae08NlqVoKpnLfbpm+vbQ4dOuC574NmAhV1NHREJ/yiXJKgNCdhzee99Z02wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqkT20LB8iCh/2nQ584Qq+nQNTit6Wi6nV7BuR5dZHU=;
 b=mAEL9fxhBMBLmyFZIreEUjHPplI5YzWRfJKV6JY3fXMVS+Ju4tNuklrPylu82dP8VIMOCmEq+/RZp4hA+5cGpLIv2eVNUrb1TUdDs7i1AWEmN0RAMpyWBbyjhYT0Eb4EJu/jnmGrsRQR6IblIkVyk4HaEhXpF9sb/YWzq4BLm4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 16:54:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 16:54:34 +0000
Message-ID: <7178d2ce-9c13-4ab7-9c56-aff84b65461a@cherry.de>
Date: Thu, 6 Feb 2025 17:54:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: Fix binman error
To: Simon Glass <sjg@chromium.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, trini@konsulko.com,
 jonas@kwiboo.se, dsimic@manjaro.org, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, greg.malysa@timesys.com, bb@ti.com
References: <20250129132529.807031-1-naoki@radxa.com>
 <20250129132529.807031-3-naoki@radxa.com>
 <2d237669-cab8-418c-ad47-0cf936d76a86@cherry.de>
 <CAFLszTi7EuM36eSrKehuH_fOkbkE0ZX79jkpZAAn7PonS1EgNQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTi7EuM36eSrKehuH_fOkbkE0ZX79jkpZAAn7PonS1EgNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dc7d7c-8473-4d85-417f-08dd46ceeef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODZwVGZ5NjdBOEFaMVZFUE8wMjhsN3I3TFBiQUwvN0VTRWNRSGV0cm93ZVc2?=
 =?utf-8?B?eE8zMDlGVmNtRXZvT3E2WFhpa0JxNFQvYWloNkFyVmtBNmJxeVY2ekFVUG4y?=
 =?utf-8?B?RlNyclVnZDN2cDByYTVnMGJXK2Z3Q01XSlAwMVh6ckZqdjNDSzNNRWtzbVJy?=
 =?utf-8?B?Z2ZIeU5QQVAwNkxwMEJ4M0wwRmpDTHJUWEllTW4xN3FKVzdjTk5NUHlvSEt1?=
 =?utf-8?B?R3hBdjY5cVMwd2g2QUIrYTIvRCtjNlM0TEJMNlpjajlLOXRwU2FnWjlKb0J2?=
 =?utf-8?B?NDBmeE5tQ0FsWk1RSzJPYWcyNHpUeXVEckJGdkZFMGx0Q0IyNDR2OC9jZ1lU?=
 =?utf-8?B?Z1pNYm1BU3Z3Si9ES1oxZmlBUTFqLy9Hd1NoNmhYdW5nVkJCeEM5MmIwOHRZ?=
 =?utf-8?B?YXRtOTNNVTRNbHZjaklsanhya0tycXdQbFI3MFdNSzlrdHUweXVER3l3VU9X?=
 =?utf-8?B?SFBUN2FYS2tDZzl0eS96RHJwTVZPVmRPY3g4Rmtrbi9wOE9SN3RlRXczN0hR?=
 =?utf-8?B?WVpIaEtxSVZxYmR3ZzBVNC9DSm1PV0xUbEM5OXJ1VitRYi82QmlaVFBFVENi?=
 =?utf-8?B?NEt6aXpMUG9qTEV0aitXZ2o5UXlMWlBkODVUZUVvRjNjOE5icncvdkVndzY5?=
 =?utf-8?B?UUVGOG9mcVFlUTI1Qkpaa1lxd25MZkoxSjJRblVrd3hLREdYek5ZdkNxN0Vt?=
 =?utf-8?B?M0IwK3F4b05pN3YxMkdGMzJwQU9ZLytuU29VWUE4cjV6R0diVzZBNzMrbUk1?=
 =?utf-8?B?Wk5SSlcyTEpJK1RSSTlBN21Da3FIaVMreEQ2UnArVVNWN2taaW5ZUVhNWU8v?=
 =?utf-8?B?bWlEUHQ3Vm9HYlY5MjVkbDNGaXpjOG5lb2ZLdlRiNEt5WUxpODBaQm8zSlNS?=
 =?utf-8?B?Z2tMYnZRZWJsQUIvUW1FS1lrcXRRZVlZSURuWUtMZzhBZGJybXovRGU4ZFNs?=
 =?utf-8?B?UEQwcnN0S3VNSG0zN0dabmFPMVdzbkgwdWlhdlhnUlN0cHNlLzJXT1ZyazRX?=
 =?utf-8?B?RlZQRDRNZGZZN25BbmUraGJtQVIzT2gxdkk0dVNUSlFaNE0yeFZBc0lUTGg0?=
 =?utf-8?B?eHZxa3dhU1ZPZ2I4ZlRSZDA5SklHeGNtWS9SaEo2MnFLWVIzSHl2b3FmK3Q4?=
 =?utf-8?B?WnQzSkEwVXVHOFdSb3ZVSUxmeUJRZk5UWGlCZXV1QXJVVm8rVVVBbmNCYk5X?=
 =?utf-8?B?KzRuSjA2QmNVZ1lYOFg2SnZZa2tBRXVDZXI5c0NMVVBEVkhxamZHNEJWYnVY?=
 =?utf-8?B?VEN2blR5K3FkZmFEUzY3dnBuMlQrQnU3blRaZ2VsUWN2Y3h5MnArQXpsRU4v?=
 =?utf-8?B?NWk0aWlzQjNHczZrd25NN1ZGV0ZaS1BvYXAxRnRjbDM3S1JKR0ZhV1RmWjkw?=
 =?utf-8?B?bktWeHlWRW1QVmNLR29ZYlZldjFraU9mNTVzYStDYTFxZmpGQ1JVL0cyK1A1?=
 =?utf-8?B?bUVTajIrK1UzazJNWWFHTERoSXoxc3JJYnIrcWJTRTlmZ3FIQmxvdEtvOE5z?=
 =?utf-8?B?dFgrVUxxTnFDZGh3S2VhNVpCTS81MHM3ZGFObW1EOTdUUHpHbmxDRVFRdTho?=
 =?utf-8?B?THpQcWNjWVdSenFDWENPTE96SHk3Vnh1VmgxUkN3M0d2eThvWW1Fcmw4elZQ?=
 =?utf-8?B?TmdkTWp2SlFiRlpMdGRRbGxUY082R0hoaHF0ZUxjRnZ6VVZreENUZmxWOHFs?=
 =?utf-8?B?ZEVUQ1haY1JMcDNsT2FsUkU5MmI1YXdISGNsZ2ZWQXRkTnh3OVBEcEhYUkZH?=
 =?utf-8?B?VER6cFpYaDY1Y2VMcXFzTDA2UlRKVEZoeWRDdEZzdDRvK1N5aktpS0x3OFBI?=
 =?utf-8?B?ZUZXWjFKL2lxSWxocXMyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JRMU4rejl3T1B0bVFtOUl3b1NrRlg2VlJqbE92VFYxZktzUzNEVmNWTmFB?=
 =?utf-8?B?MDcwS2FUT3ZJeUJibjVkM2w5amtGZXdBYlpQZUxOaWJsd3FWZnlnMXBoYm8z?=
 =?utf-8?B?a1RhMlIrckVldkQ4cjBpNlBPUTRIaUNVQi9LNEM3alJzMHFrVzlOUzdoRTNo?=
 =?utf-8?B?OXlIcHRXWVhmbVF2THdWUXF5cEcrTjFTKzBPYTFFVHF3Q0cwenAyWWZFTktC?=
 =?utf-8?B?ckhkaXRqK1cvT3VRYnZPZHlBVTc1a1FhMURMRkJPNW40N0swREVjbHF3ZjJx?=
 =?utf-8?B?aW1PNWNBUG9ubWhYNWFSSkRUcXdkNWVSbDZhVThyc0wvTGc4eExJS1BzSXpk?=
 =?utf-8?B?V1hwc1BZYStiV1hHWERrYS9teG02V2Z3aEZMVEtHemZ6V3lZOGVuWXhJYWdY?=
 =?utf-8?B?UnNUTHZXNDFsdGRtT2o3RUF4T1VhT0k1VHZlMEtpY3o4UmRWYWQyTzM3bm1F?=
 =?utf-8?B?TGVMTkttTEFRcS9BbkJLelMrTUNTV1BQKzIxRDBDV3FlMUJ5dmwzNGg5SDMy?=
 =?utf-8?B?RzE4YnZNNytGQTlOQWsvUHpLQ2NUVkw5UDlIR1JHVGNWQnFuUHpzZ3ROOVRs?=
 =?utf-8?B?dGgyTGtEZUVIWDNncC9iVTBPaFc3YitHTlNVREkxODBLMzI0Rzh2MXMycVEv?=
 =?utf-8?B?TGsvaFF1NHhBQW1kOFJNaGgwNVk0b3NWbzNBRlpWQkZSUTFqUmJwa3VrVkpk?=
 =?utf-8?B?V09KNTQ4bUpXNThMRmZnbHJBSWFBcklPYk9wYUxGR3EzbnFmb0JtMVJTS255?=
 =?utf-8?B?RjlmV3V2UHRWWXNlQ0NCVTBMR1VFYTlxMjBoSjhseHllMnc4endiZEdndXBy?=
 =?utf-8?B?VkV2dTFrYXB5UGYzWmtIUTFZMklRbDF0U3JNUE9pQ2J3S3d1aEFZQ1pFdUkv?=
 =?utf-8?B?ejdLeUZHbUVjeXFsQk04cjQ2RGMwS293RkdOc3YyNXpJTTNabXVQSHVUQzN3?=
 =?utf-8?B?bjg1N0thaFN3c2lRMjNndHg2UDdUVXZZYWdBNldFRVhsaSs5UE5LTjZBeFhI?=
 =?utf-8?B?blVrUmdzSUlOUHJiNVVtTjJjRTMvelVDd1RvVXJMNGt1UEpyamcxNlFRVHha?=
 =?utf-8?B?Tnk5dHBDS1hJY2VCeHMxZS9KU0REL0lzY0d6WjRUeE9PMmR1RHkweXVHN0Rp?=
 =?utf-8?B?VVI4ZTFZWkNVcGltVXhkT0xsVys0aU8walRTY1ZUN0VxOUVPbStyOGhkWUZM?=
 =?utf-8?B?WElFY2xOdkFHZXRFV1FUbFhNd1pzYkJrUFpta3lVM25iNEVHTCtnbFBwU3VD?=
 =?utf-8?B?QTZSeGtnWHpJRmhpS3djNi9LSUN4N0EyeUQ3TGo4d20vM0JPT0JoMG12Ly81?=
 =?utf-8?B?M3U5dHRiMjBRMENJR25HWEpkRjZQRTUxSnJib1NXU0Frbjh6L3NaVWNpenc5?=
 =?utf-8?B?b0hnM2FPZFJJSGlxbEFqZVZUVTZ6Vlc3ZEV0bzlPOG9kMjdHZCs3cHpyNGdr?=
 =?utf-8?B?TVdMdHcwT01oZkNrblkrRW5INTRubjdwSUFHOG00bnFKY1J4blNqRDBMR09S?=
 =?utf-8?B?MlYvTDU5NWJCYmpRdXErTkh1cGpRZ2M3NDhCWDA3cHJsalpKL3FmRVRlNVhX?=
 =?utf-8?B?SEtDT0tVdVcycVczVUVIQ21seTVXanQ0OVE0RUNWSHQxUCswVXZqWmhOZTZi?=
 =?utf-8?B?dlhkeVBaT3VDdE1Za3NCYVd6ajV3MkhmQ0lxNlYxTnAwY1BFT3RacVhRQmM3?=
 =?utf-8?B?cmZ4bXZNaHBZOWJ2NzZWWFJxZW5SNHdheVN4ZExsK2I0OHQ1aHVoemlDR0V6?=
 =?utf-8?B?eHpnV1d2RmFZRTk4K2hCRlNBUWxtcU5EWmF6N2xaUGNLOGhnVXpLRFRpTnhq?=
 =?utf-8?B?QXM0dStWWk1PKzBGd2UvcHZzWmd6SXJHOW5SZHZEN2F3a01TYmttM0hHMFJ0?=
 =?utf-8?B?WDRIb0NrV2QvYTBkV0xxUVBTWWNmZVNBb2Z2NWJsRUhqM290ZnJyTThtZjdr?=
 =?utf-8?B?VGNHVFM4QkRjSGIwZFo2ZlY0OVc3QVp1TVQxWWF6Qk9zQ04xMk1jVitxRFBk?=
 =?utf-8?B?NHhGSnE4RzA3V24wRXZyeHpHdWJFMGRxQXRmemRoa3pkelRaVVg3TEJUL29O?=
 =?utf-8?B?WXhUSEFCc3VGeXF4Ym82Q2d2Y3A2OVZweEcvQncyWjRzbGU2WldYN0xmSU5r?=
 =?utf-8?B?eFQ5OTljVXEzSGsyMEdwZ3NwNVJZaThnaXd2QXdqekk2QWNvWkd6Y0lGTUJi?=
 =?utf-8?Q?3wtlCICxf6BsSKiTAHLZRo8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dc7d7c-8473-4d85-417f-08dd46ceeef6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:54:34.4349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRDgTUK4bs4UPR2gt2QdXvluiXLxqEnjsHmHl1LJNfQB3AlLN/hoNGfsYl/T3BQKCCELytobBTIbD7iRnDVMZ+rQtVJ38I/liB5qiaiavbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202
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

Hi Simon,

On 2/6/25 1:46 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Wed, 5 Feb 2025 at 06:00, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Naoki,
>>
>> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
>>> After adding the below configs, binman produces an error.
>>>
>>>    CONFIG_SPL_DFU
>>>    CONFIG_SPL_ENV_SUPPORT
>>>    CONFIG_SPL_USB_DWC3_GENERIC
>>>    CONFIG_SPL_USB_GADGET
>>>
>>> binman: Section '/binman/simple-bin-spi': Symbol '_binman_u_boot_any_prop_size'
>>>      in entry '/binman/simple-bin-spi/mkimage/u-boot-spl/u-boot-spl-nodtb': Entry 'u-boot-any' not found in list (u-boot-tpl-nodtb,u-boot-tpl-dtb,u-boot-tpl,u-boot-spl-nodtb,u-boot-spl-dtb,u-boot-spl,mkimage,fit,simple-bin-spi)
>>>
>>> Add "no-write-symbols;" to u-boot-tpl and u-boot-spl.
>>>
>>
>> I'll be frank with you, I have no clue what's happening :)
> 
> I means that simple-bin-spi has a binary inside it, u-boot-spl, which
> uses binman_sym_declare(ulong, u_boot_any, size). Most likely it is
> the one at the top of common/spl.c
> 
> This symbol is filled in (by binman, at build-time) with the size of
> the U-Boot binary. If there is no such U-Boot image then it cannot do
> this.
> 

Why is it not failing right now? Why does it fail when you enable 
CONFIG_SPL_DFU, CONFIG_SPL_ENV_SUPPORT, CONFIG_SPL_USB_DWC3_GENERIC, 
CONFIG_SPL_USB_GADGET for Rock-Pi-4? This doesn't generate the 
u-boot.itb file we need for simple-bin-spi as we anyway take the fit 
blob generated by simple-bin instead.

It would make sense to always fail if this relies on u-boot.itb to be 
built for simple-bin-spi as well?

I suggested to use only blobs from simple-bin in simple-bin-spi but 
according to 
https://docs.u-boot.org/en/latest/develop/package/binman.html#image-dependencies 
this is undefined behavior. Maybe we should use a template 
(https://docs.u-boot.org/en/latest/develop/package/binman.html#templates) 
and rebuild everything for the SPI image as well. I saw such a patch in 
your VBE part H series I believe, maybe it makes sense to have this 
merged separately?

This feels somewhat wrong though, if I'm not mistaken every binary used 
in simple-bin and simple-bin-spi is the same, to the exception of how 
the idbloader.img is generated (-T rkspi/rksd), so it doesn't make a lot 
of sense to me to go through a complete rebuild of all binaries, instead 
of just running mkimage a second time with the same set of binaries. But 
if that's the only way to have something with defined behavior AND 
working, then so be it.

Cheers,
Quentin
