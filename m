Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7537AC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 286D980F2B;
	Thu, 30 Jul 2026 13:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRPD2mkBITqe; Thu, 30 Jul 2026 13:58:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B23C80FB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785419932;
	bh=oDM6FSYA+L8SCt0+JAeMIb6n9wTrk9AixFqAyf/R7n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVk7RHesNetbuqeA4Iy2A0/E1xs9AOfWIyFH2W41z8KSEbYE6o9HMNuJSxW2Gamph
	 o7Req4IfszaUMUv74JMxwf97lSDmmYHee6eWXsPWGpzpc2YFKhtghjMZhB3J344fIi
	 gmB+uXlB73cNVGgjbWd8ulQKUXa5qOozUojwF6BKTBSgM3cNAGtumme4GwuFamcteC
	 aaR7cCo3fKby+dlmR7RL3dT7d98tTs+EJ2iep6mK0FGqywy0dAW9rYbclBh04rc2Xf
	 jXxLqAPiZoiKiN96fhOUurUcXCRT8PhLbMQ3Y/mfv55LOu2m5GeDmTAxtFSo62sGCv
	 jVz9G58z8p4Zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B23C80FB2;
	Thu, 30 Jul 2026 13:58:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3662969
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27D8080F2B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOmg1sPcJHI9 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:58:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 37FAF80FB2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37FAF80FB2
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37FAF80FB2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdyarbXKTtKZh8wWQuTqkha+c3Q7emlUVxKnvExIKu0ztw/g/F18KiW1ZfGQ1ZTEydIhlPN6n2aamYctKJlvgLtlo7b2DrZmvpqH+ptlcPci2oHFI42j60xFMzToVBD9S++f6SnM+1c2n4UtWdHIoccKySBAjox5QEluiDDFvMLOIGLyyyqQrBYJRYYrIFirqNVq2lh72riXrId6zi3q1aKvTjQH21imws7GdmEC1R+WuPiBB0kYtQHNBVKpab7nHmMhtsgODNz3WedcPth1yvknf1agaAP2QpP1EytEXiyHw0mwbcmKJjlrMTQFbSNUJaI5lhLB02TLZvteoqUEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDM6FSYA+L8SCt0+JAeMIb6n9wTrk9AixFqAyf/R7n8=;
 b=FbMRCEzrbfJg2k+zUtypx4DTFn5txHKMKRWgwlQjQnS4GAHsm9j0xKB2Ju4U7VN4ObdbW9nfEcY3zFp+vp2WtfcIe3Uyq2oRIAnK38KDSzZL2jNhES4yKWx2YePceWJyLb+Frfx4rUzEUz6CjbVXPEXElvRbIkVEP7zR8Yavb2GX1IKFvVTDuA7ivZqrj2icYDalV3lOsZcJxVzcZKyc4HxQLlvul53IKq0Lm5t/PpyqdI/z3LYtgliTrYpQyzuka4KORCUKfPedWy22Y6CB+54FATSEVos7OXlGpz5GfdQF3Eqze2w6YUHsuPhq4zNrHdkwyvdlAXUVb9KK0kCuww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by GV2PR04MB11564.eurprd04.prod.outlook.com (2603:10a6:150:2b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:58:42 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:58:41 +0000
Message-ID: <80aedaa6-3b5b-41b1-b315-2f970b4be4e5@cherry.de>
Date: Thu, 30 Jul 2026 15:58:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: Drop OTP nodes from u-boot.dtsi on
 RK3528/RK356x
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730120907.1209949-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730120907.1209949-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|GV2PR04MB11564:EE_
X-MS-Office365-Filtering-Correlation-Id: 711e49f1-2afb-4447-fd51-08deee42a98e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: EVnCBKHKtghaw4tgec97WxtSK2gZTpG6Zz4hCTmWJs0IgMBk5g39pKC4A+gHnBI1UUcxzxmMAXJjVIjKSzMQqaq036+HFekgo44m36wlghflhnfeKCkpJp+yjRHtxvX+lgL6Lf4pVD7OK8KcXSQrWUJ9yKkXLvwpQL04sWXEXXJhFTpM1skK9Bq7iloURG+GJM9hNh12VovSflHRGpx9nqM01tsI3ii4AC169Ahyq57r2dEg18qL5GnAmcX8Yu+p2pUEU7YF8QnRmAYdBzI3eYhn7sBan9unWl++9VRkQs8kYAhIjAmX47KuGglqfGl/Xu3PvAxBYB8iIfkFGcs40XRzJzC751pE5TLsC0nMymZrqoo0ICokefTY9WgA6df14bxSf5utXorPADB+XcWibmg1emyI0DDso7Ujfe40FEVQvnhsOepnhTUjWU7dJEeU2Y3q1JQiDXpFX5/Wt72VK5AlTP6rptU8tdWcwxYqUL2A0BW0pnbM7ysgOW22Ybe9JkBj3Vtnurn28Y8buPTN8oG0Xy6kxDBe0bt2v9bE1dvMZOvyl3Voq9auZIcfga8iCz4wDH+mE19t/N2w2TOt2XRWWPYcOGr4wFALDuM1ztcsHp9Nn2LW0aXSGr7nyxd6pQ8Dyp56a3ml3/05cbivlVmNygmkyny3gB178YVNsSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1FuQjB2OWhzWHkvc3JsQnFUYlNUSExIN0JTVGZVV01KWFVMSTczOGYxUVRS?=
 =?utf-8?B?eElxc0oySWlMRlRZUDhoVFpMNGpJeXFhK1lZdTdSbXVwQ0VxNGJhcFJteThR?=
 =?utf-8?B?SWpQK3U3ZG9FdkI5eWxZOGwxSjR3K3BhakFZNUErMXdTOXA0MUdTNTBtNkVr?=
 =?utf-8?B?Q2xRNkMrWHJZSFdkTFNNcERWV2dkZkhkRGFyVEZOUjh1WXQrNWFYcWRWdTlB?=
 =?utf-8?B?dTFXMjdETXhqTzRrUmRBa0lJSC9CRGVIczZsOEpyMnFkRllqOVpkZjdBWnZN?=
 =?utf-8?B?MWtJNEJqWGQ3SjA1b09XNkV2OHA2YW5MUWJ6U1kzNEl1L0kxMERvZ3o5ajhT?=
 =?utf-8?B?bG5BNER5Nk5TUU5pSUpndkdCellyRGNIVU1neHExZjk3Q0FhbVN1a1Yva2di?=
 =?utf-8?B?RzFrcGhpZEhBWjFRWHdYcnZpQjZtdm9oVm1KNVFRemo0Sk14bDhzZXRENmhr?=
 =?utf-8?B?aDlZSytmaGptVUNaejZZUCtiYm9mK2FNZHZRMC9ZYUNkWnZhbnlvMGRUdWZI?=
 =?utf-8?B?bm81cGV6M2dQeDZPalF2L2ljaDh6YzJ5MXQxWURsMVQ1YjJ5Y2tnRCswbkFH?=
 =?utf-8?B?d3RxU3RDK2VnTFQ4YzlSckVGdFZxVk9kVUJGaERmcCtNRTlkam9jVWp0K3Fk?=
 =?utf-8?B?QlVzNm92QmNqdytSTDV6Qm52M2NUUzBvcWVGenB4UXg1YkhGNGZvM21uVGIv?=
 =?utf-8?B?cm1vcTlpS0RiWFhMUmJTVkUyV1FaMVRnYUNFSUNhUjB2bVB3dnM3RFBZRWZw?=
 =?utf-8?B?VHlURGF5KzdLazRqVnM3cTE1QlBKRnN4dG9LZm1tZ1ZuQ0l5UU5BcWRBZHZV?=
 =?utf-8?B?ZDRaNUYyOFhtb2xrSzFvdVl5Z0grTGZTWkU3VlhIQ25FYm95UURxbXp4R0k3?=
 =?utf-8?B?Mmd1c2FDdEdYdFZScUhLSFFuRlBkMXJyLzBtK3dtVEFWVVVJUjI1bFBBWFBY?=
 =?utf-8?B?UkhvaWswTmQ1RGV4Z3dpQ2VQSlZuUm94dHRYQnFEdHhYclZTQlMwYmVheWV2?=
 =?utf-8?B?TXpJbHplR2VZN2ZTVEJKZldXNTZnRWhjVjVVV2hxd0t6NWloenR4Y0ZXV2RP?=
 =?utf-8?B?a29ERVhNVDJ2T0JST1I5OVBzZGdsNldwaG1QVWRIVktmSjhyb1NiR2c1dEZR?=
 =?utf-8?B?Vk5GMUt0UkxNQk1tMitmTGpwZ2dlTEY2WExQN21zVWZNbnV4WmxpQ0ZxS1Zp?=
 =?utf-8?B?VTNoSGJtTXUzMCtjTWdoWndrR1FYQ2RRZ0p6dUtCcFFCZWMwRVJBb3hSaUlk?=
 =?utf-8?B?Y01ERE91YlVUbGJ1b05reTFKd2VCOVRlSHM1azVlVFdyYlZRWDN5V1lWUXNB?=
 =?utf-8?B?SkIyYzRuaE03ckZ2bUxCcUt5eUc2ak1uajZzU0k3MDlYVlg4YmZ3M0tpUXpo?=
 =?utf-8?B?MUtyd01OYjRMbzZ4UENmZ2p0RjRKQmpTYVE3cENIakFld25jSTlSZVIrZkMv?=
 =?utf-8?B?d2UvdzZ3NkRNK0R0SHBBUWllOWE1dllZY3BhMUZWZVZabW9lNmxublBNZXVa?=
 =?utf-8?B?UmJIeGdwNXNub2lGNkVNa2RQQUNUME80OWkxK20xZStBcUZEUFA5MFFXVDZY?=
 =?utf-8?B?SnU4RlRtVWRDalFFYlBzdkRKUHBaR3I5RnJKVXdKTFhYSkViWjVud1ZacnZh?=
 =?utf-8?B?SDNnZVJwS01vMDJlcUdoUnI2ODVIdW41S3RnbXVITWZQSHo4YjZFZmFmSStm?=
 =?utf-8?B?MmJDekJVZlJ5Zm9kWkVwNFV6d01ZZU93UUo3VU00dHJEaXdKLytnamw5Qlc3?=
 =?utf-8?B?b2JDdVY2aVNmTFl3L1VtNC9EaGRoYm1vKzJJeVQ2Kzdjc2d1T1JPR3BLV1My?=
 =?utf-8?B?QWRvRlB3c2dXN1JvYnBKMXE2eVhuYnlqOC8xSk9hSGF6d0tpTHhIU2RvbTY4?=
 =?utf-8?B?OHVTUENOaTBaWjU0dHNnL24zWkVzWHhGN2xZRTFZS0dyWG9VbTV3VTR4dEhk?=
 =?utf-8?B?K3R3T1dmTGhtZERETC9wUWZmVGV1WDJJWkc4d1AzSmtrcUhsL05zY3pQNGk4?=
 =?utf-8?B?OVcxZG44RTEvS2xuUG9yblZFbi9id1BPNCs3eGdvZUE2OUdtRmd4aDU4M21P?=
 =?utf-8?B?eXFsSGxBTmd4VC8xN0Ywc1pMeXZGMFlJbGZFTTNoNE45N1E0ZnF1WHRzYTR5?=
 =?utf-8?B?TWxWbnpEUHNBZjVsUGxXMHVSS3VqREZXNEdyR2x6aHZIQ1IrYXRhYldOck85?=
 =?utf-8?B?TGk4N2VhQ3hwSDUvOHQxclBtUzJ6WS9iTm05UkZXaUk4VmFON0EyUVZtc1lh?=
 =?utf-8?B?dDZqVXVEYmhrT0o5V0NwNHIzMWJjWmw2YVZyQ040QWxTUGRicWhKZWhibHVQ?=
 =?utf-8?B?WXRvL2VFSVVVWUU1dmRHcXEzanh4KzM1N0dUNnVOR2hJbENtcGRxdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 711e49f1-2afb-4447-fd51-08deee42a98e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:58:41.6069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gf5lhLcCtA2/PfMNzvWqcKXivG4z0ZtK6zndzOGZONMZVf4FWQn1rt4ruJI7UGsLMiUC5W9vJ+iTF5U41XFonA+kW9AdiT8abkQTy9mpx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11564
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDM6FSYA+L8SCt0+JAeMIb6n9wTrk9AixFqAyf/R7n8=;
 b=TNc0jNeN2/FFW51I3Yy+jIsXG8neNeeeRFsuAerTc3BSmSdkbYLB0XHTF+poXl0SRfaixoEVi6EosqL77HcIzWCF4RZt3b8+UndK4WVRU0cikubBqi2RvMcgIdl292hTVuBt+7Vj7ZwfL9yUFk0WXBxEqA5JnEiai2DJtmn7k5k=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TNc0jNeN
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 2:09 PM, Jonas Karlman wrote:
> The OTP nodes for RK3528/RK356x was merged in Linux v7.1. Remove the
> obsolete OTP nodes from <soc>-u-boot.dtsi now that dts/upstream have
> been updated in commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of
> dts repo [1] into dts/upstream").
> 

I appreciate you followed-up so quickly, thanks!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
