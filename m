Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA7CC369A2
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F07683560;
	Wed,  9 Apr 2025 11:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i+VGHWlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433668359F; Wed,  9 Apr 2025 11:15:18 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06A58353A
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er7ZLYlYvu7brP+uV57ImlsMkPsvItS3IK06FBhRJbdcGYCCcwEYhgEUizyNUSCjfgRKhllxWxQO9fVGTNkjLLWIYWeZkuKTbzd+5If95uRdU4QQ+gqDVyoPnBplKHYy92VAe2IgblaRG6LQOah9mDKVefbmkdWoXWl9qOZ79Z/FHaUUsOkq2GBeWPCGp7UsoIElXuImrxke64fljYpuawrjTwCIRSqpZzrmvxhxDLdwDG44c6QmtTiZoekStqFp9UyEaq94qLIWVtTb0U4AXQ06KgHx4yg0rdHsI2Isn/gG+Ag1VUfP1rAKNbz46m0oz2fEZxzT0CAvvGqp97D6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l44UqnUk/mFeF3b6a0EvK+SeWcxYsIGbTv9qcK6IC+8=;
 b=xUViWFVYB/q/BtvtlnC9CJTZQxwzwR/5irzhrvwYz2+smEiK7Xr88La0baCoZFd/QyKGMjkl/c963oAVAzqDQBSl88VCnFGcZ2gcF/S3+WWk5+weg/YLGqD0HTIEoVgaw3aCKo0vxfXncwqnAsS4A+V4mGem60DW5Aje0JIVVo1jbDYDCMbvUCm4xvsJZfm1i+JpsTXF4ljzJzpYrXuQBEISdLG2MO1GfAiVkKWmCKaOGiYHZNz0HZ+3O38U9mf2H+E7kWh2OIOg0vEOCt+T4EyAA7yVSz++/0kVxaJjkn4YbKVu8I+HLVw7iOXYM7aW+TZI5SBgvgzrY/+iuYtQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l44UqnUk/mFeF3b6a0EvK+SeWcxYsIGbTv9qcK6IC+8=;
 b=i+VGHWlfRF0B8e3aVwOSwSBocgROsdzXVLdu4GRqI+xUo1LP3F0bpkE+/B64Jdt7i5vXf4gOkc6CMS6SkPZC8y68SP+gLJkVi5Ayz9ZBdSWvEPmU5mDceUqklv5aG+HQ6gM5+Noi2u2CuXKPMAndHyH7CwjfQPAeIWP8syy/hoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU6PR04MB11134.eurprd04.prod.outlook.com (2603:10a6:10:5c2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 9 Apr
 2025 09:15:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:15:10 +0000
Message-ID: <5a2d27ee-f732-450d-9a80-fedc8b2acec9@cherry.de>
Date: Wed, 9 Apr 2025 11:15:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] rockchip: binman: Correct the OS prop for U-Boot
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU6PR04MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: e3276c76-1549-41fd-1c18-08dd77470588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZiswQTlOOWZ3YUhDaktsQkxtY0JsOEJKcXQyWkhwNFBmMHBRUU9Hb1RQV2dm?=
 =?utf-8?B?ZTdLbGcxbU9aT1VqVmE2UFhkOFlxT1NjVWJ4Sll5dFhtZHRXcDk2NU4yWmRy?=
 =?utf-8?B?c2kydGd0YUdnbThjREZTdlFVMGowbjA4aFY3YjhmaGlxWUtSZ0Q0WmMwRXg4?=
 =?utf-8?B?bGkyYndwZUQ3M1NqdUhVWXRGZklMZG9zeGlpN1d0dkg5L3pmT2JPbnlNOXZ0?=
 =?utf-8?B?RVpSMHI0RWp5VzM5Nkw5Z0VpUkRIWGpiWFJ2MUdHOVhpalREK0g2dmtOVk1O?=
 =?utf-8?B?dlp3UVM5eCtwcWxBSG5CQmQ1Z0lxOTRNMEtjUUJYOGhIZTFRM2dDckNyWFBS?=
 =?utf-8?B?MWFPVGczckk5d0wxcGF3SEJNd3NSbVZ2MitwS1Y5OUlUWExESDJsVllDTHli?=
 =?utf-8?B?c2VMcWNROEZxK2FaUnhJUitabk85YTdxemx1MzEvVjdyMUJjalhGWCtSdmht?=
 =?utf-8?B?ZDNvaTM2TUtrZTJ2YU1SRVNJQzRDVERUVk45TDd5cS9QRXJPY1c1cVBYRWU5?=
 =?utf-8?B?ZUJENklJTi90OWtSaGNXUExWendpeE9WNEFtVlJZUzA3UXdtRUMwcUM4ekFs?=
 =?utf-8?B?UW5ZVVc5cjc3SVJYMWphRm9SQnZDZk54eVhoZE1nNzFycVNiTDJzMjhuUkdH?=
 =?utf-8?B?cDZRSFZ4L0JNVnZrNk5DK2gvSXRGRHR1ZHhJSnQ1eVllM3kwUGtxNVV4VWJM?=
 =?utf-8?B?QUd0cFRxcmJubHQ2MXMrWnZRcTg5ay9rM1JTaUJkaUk2UkdqeTY3Z3Q5MEFy?=
 =?utf-8?B?S0t0eGhUU3R1MTBIRkQ3WVBIdkZRUmdhdTBzdURVMk90TXNJNHo0NHowSDB0?=
 =?utf-8?B?cVgvQUVEY3Q4ckN0ejdETVRZdXY4a1lwZ0ZsTW1pTFlwWGRobm9EdGNBczNI?=
 =?utf-8?B?WEdCdzRZVW9GSDF1bDhPZGJ4OG5wcURidWkwc2haa1NwY2w3bnh3TU02TEVj?=
 =?utf-8?B?aEd1QWdrUTFIM01GTmFxU3NKSGtjU1Fod05jVjFFVG5uQ1g1c3crY1U1N1p4?=
 =?utf-8?B?SmxnOFRJd25PZUtpVWNXOVU0QUhZbm42UWxGUU4xMEFIKzJkUE9Zd0p5YkRY?=
 =?utf-8?B?b3FKb1lEYllYU0ppVDBNRXlhSk9jTWxRVXVvOEZzS25TVlFydkViNVdlWFFj?=
 =?utf-8?B?dU1mVnFOSDJGT3I3alR5VHBoOHJ6OEYwUUluQmZMSldSdnZMUzRRUmJhcURD?=
 =?utf-8?B?Y0l6TlIyUlcxYVIweDFYZWxBNkVmRHpidnIxb2ZOZWpQM3ZwUTN0KzQ4WFds?=
 =?utf-8?B?ZTZuUEV1YlJDRmIwZTMrL21lZUZoYWdQV1d1eXhYY1o3N2g3T1VDblU4WGJx?=
 =?utf-8?B?cnVVUmgwYlVNWUY2RmF2czBIWWoxR0JLbUMybklkV3ExR3lwalM2bk5oUjJH?=
 =?utf-8?B?U05LYXZQUVBML2xjVjVQalk3ZGxtVngzUmNtZjJlbmpqcnlWdE9FbWZraytX?=
 =?utf-8?B?REc3bTgwcDVnYnJZSmkvYnNGa2doZEd1RXFlbmlUT0hBd1FIcmNaWWpyK2tW?=
 =?utf-8?B?dTY2YWhhZWljbk9HSVMrSlVBbEJjVDJhaU55dEZCMFJ0bVBTa0d1NlJOTDBk?=
 =?utf-8?B?NWRpa1IvZm9vdGtOTTltMFZoWGgrWUt5bmk0UE1uRW83bnVqcjlGK3ZYWi9n?=
 =?utf-8?B?Z3R2UUVHZTNqV2FYQTdhYXdSdTdReUJHWXFGWEtIZjR2ZFdrUEVuQll1c1d4?=
 =?utf-8?B?eWw3eWpnK0lVdlRUZVE5SWd0ci91ODN3VENHY1JnTnNtWDlveFNheVN1Rjh2?=
 =?utf-8?B?VW5hSW0rdHVTWElYWUFMbFU0bmdQREN6R1Bneml6OWFRRWN2Sk9QUzlyclFo?=
 =?utf-8?B?UXozUVVWUUNVUS85LzFNWWo5cm1oN0ZqT0hyRlk3czhwOEpkMFdYaVZPRExz?=
 =?utf-8?B?M2w0ZU9Ya3llMUpvdjEySlVwY2JCTjFQcmM1NjdqdERmSzhBTzIwY3psTktN?=
 =?utf-8?Q?PPEXFmUXRbI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVuZ2pZZ2xVSkZXUFFwZ2gvUnc4Y0YrWkhrMU1lRnkwMkxrbU5sQ1FFeUJn?=
 =?utf-8?B?NzcrK1Zra1RqUWQ1Ylg0UUFaTHVXNnpVbGZlMEdsZHdZa0Z5WkVjRHU0c1lR?=
 =?utf-8?B?REVHUFNVVEd6NGJwZHp0UmxBM1haVUh0QjlPQzlnZXBtU0xjMFdoZE9LTk9H?=
 =?utf-8?B?S1RZbFk4L0VKczJuL0JzN3VITTh5TUpINTFZaGxNaXZpbHpCeWJRNTFVQ3Er?=
 =?utf-8?B?aHZMNnBPU29ObEtBZDZ2V3JXdUZBd2Y2Q1NiSUVIQnlCOGp0TFFzTkRONTBk?=
 =?utf-8?B?bFVNU0pCUG1Uc21JRGNCQXZRdVAxMTVSU1BoWldEWlcxNDU4VjlPYTRteU40?=
 =?utf-8?B?SE9sMzZNdVhGNUhGMElycVJYbDRnYnFVRGsxeTBRQk5teXRobDlrVWdhSU9O?=
 =?utf-8?B?b2JMbGxiVWhDcFU1d2FDM0lMQVN3bXp3UEI1NnM0TGpzSzhFZjZyVVgveUpl?=
 =?utf-8?B?cXp6bGdCdFlNOHFQMko3b01iMlcyNmpXQ3JFanppamdEU3RUT3V5UGQyR01i?=
 =?utf-8?B?dGFqSWJlNDAwTFJDd2t2cWdUUlRST2t4S2FrUGtZbXFGQUlZaUpxaExFWkFO?=
 =?utf-8?B?YUxDSGpBOTlXVDFsbXRFZWk4ZURJLzIwQnFQN0M1MzdHNWdLeUluMTc1R09n?=
 =?utf-8?B?R3dVQ1l0TmtwdXpTV3p4b1EydFUyKzFpYVhGTzgwcklXK0x3T2hJRGlZVWFZ?=
 =?utf-8?B?OUZFRHhQdDZSOUgxV0ZCMXY3Wkk1M25jSTFDdlhqWWptZjRUWkgzR0ZEZ29H?=
 =?utf-8?B?akxxc08xYjdlN3hPSlFrV1JhY1Uwdm1ZWDJMcFFiTHdoa21jY0ptQ1Y1QitH?=
 =?utf-8?B?SHhOK3EzbFJIVGNhT3E4ZHF3ajkzUm83cDAyT0ZWa01xYTZhTFcrdVo3RWZF?=
 =?utf-8?B?L1JXYXhvQ2JCOHJRU0d0RUFQOHRjV25hYitBSFN2cVFaVDJGOVpxcHdzbjVB?=
 =?utf-8?B?NGhkbUhoS05SV0VxcmlhZ1RKRmFyUDYyRUNGSUhYY21RWmEwaXN4TWhkRTFI?=
 =?utf-8?B?NzdObVB5eVE5elpPRUU2bEcwc0dyVXJDb05EQzNTQng2SHZmd0hmSjI2RjhI?=
 =?utf-8?B?ZG1Kb2lLdDVMamFvUUZZUFpSWkNYMFJQT1Y5aHZuOXBrU09LNTZwcm9kNGZI?=
 =?utf-8?B?b0l0RGprQjdmcTFBOEwva2xHVHR4dmYycXEydlFvVEM3VVhZNmNweWpnU1BO?=
 =?utf-8?B?K1pHdllsWVRxK1p1M1RmeUlTVHAveXVMSkVMNVF5WXdXYmplVkozNWVhOVh6?=
 =?utf-8?B?RnZtTU45Zlo1NGFNdGtDK3R6TmlER0ErQ1ZBdk1zV09ZdmxNNVhFdEVSdWFw?=
 =?utf-8?B?WEVZR1ZoOTNqSHYxWE52ODdZc01jbElvQ3ZGQlVCQXlRVnNSdlNyUWxZWXZC?=
 =?utf-8?B?Y2p5aEk4YzNURjVxZ2dYOUVTdzN5Z2E5V01DaWZkRW9ZMVNKTWtrclVuMjJO?=
 =?utf-8?B?bW1uUTcwYytxSFl3R25zeFB4SnpQUk5MYSsyZHN3VTVlbjhvd1dTR0orL0hJ?=
 =?utf-8?B?c25yNXZiUStFVkF1MDVJUDRLeExMb2Q2N0pYSytDR2hBeFZwMEYrQzYxM0Vz?=
 =?utf-8?B?d3FIVm9ES2kvS1h2c1hDdkJWSVdpZFVCS3E0TklKOFV1QXQzcHN5ckRkMXJL?=
 =?utf-8?B?YW1jWmVLS1BzeEx3bnlvNkR6NFJhQmtyMUVrTVR2eGtid1BMdGt4L25OK2k5?=
 =?utf-8?B?bXVTR2FlbjlFd1JIOEhqS2VLMXVBUW9scm03L0NnUkwxS2crT3RHSEg4dWh4?=
 =?utf-8?B?QWYvTFB1NHQzL2wxT3MwZTBzWEREZi9aUXMvY1NOMW1yOFBsendmYzQ2Q0xi?=
 =?utf-8?B?VnFMRFZQb2Ryc25uck9wb3dvbW1QZ0NKS0xwdWVKMDNMSVF3UnRZUkpZWmV4?=
 =?utf-8?B?RTZDWmFCdGhjUlA2cUpBb0RoeUR0YXgvU1VyemFZSlJCM3NaaWF1dFZ5Y25k?=
 =?utf-8?B?WDdsa21RNnNjajdNdHBNdWFQd3RNbHlDWm41ZThPY2VVWUhVM2pkbDQzSmcx?=
 =?utf-8?B?dExycHZSWmlVekxzYmFsc05SaEZkdEc0b1lNczdZN3pYajdZRVY0b2dxdHZS?=
 =?utf-8?B?RVpXNFBkVVVZYmRDZ1dtVEpNL2tQWVRSV3pIZEJGQ2Q1R202VkY5YzFaL2hx?=
 =?utf-8?B?VkxhZ2tDN3Zicm5uRDZlSU9HSzhwMHk3dkZ0VWFVbGM3ZFlEUnY2bC83bjQx?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3276c76-1549-41fd-1c18-08dd77470588
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:15:10.3206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaVz0jR+vLQBotG2NUCf7ReHyzXuhgEq35byhDbRYuiXtZga0TiVKcXh9B7MFt6skBbfSuELUAbV0m/6jtnXWZInUJMPr79wpfn1T9PNDM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11134
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> The U-Boot image is currently being identified as an invalid OS in
> spl_fit_image_get_os() due to case sensitive compare.
> 
> Use the correct lower-case value to fix this.
> 
> Fixes: e0c0efff2a02 ("rockchip: Support building the all output files in binman")
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v4:
> - Update commit message
> - Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
> ---
>   arch/arm/dts/rockchip-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
> index c8c928c7e508..e9ed1d4b5738 100644
> --- a/arch/arm/dts/rockchip-u-boot.dtsi
> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> @@ -50,7 +50,7 @@
>   				u-boot {
>   					description = "U-Boot";
>   					type = "standalone";
> -					os = "U-Boot";
> +					os = "u-boot";

It seems like it's not the only place where this is wrong?

$ git grep 'os.*=.*U-Boot'
arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi: 
             os = "U-Boot";
arch/arm/dts/k3-am65-iot2050-boot-image.dtsi: 
             os = "U-Boot";
arch/arm/dts/k3-binman.dtsi:                                        os = 
"U-Boot";
arch/arm/dts/k3-binman.dtsi:                                        os = 
"U-Boot";
arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi: 
                 os = "U-Boot";
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi: 
           os = "U-Boot";
arch/riscv/dts/binman.dtsi:                                        os = 
"U-Boot";
tools/binman/entries.rst:                os = "U-Boot";
tools/binman/etype/fit.py:                    os = "U-Boot";
tools/binman/test/343_fit_encrypt_data.dts: 
           os = "U-Boot";
tools/binman/test/344_fit_encrypt_data_no_key.dts: 
                  os = "U-Boot";

So we should probably fix those as well.

Cheers,
Quentin
