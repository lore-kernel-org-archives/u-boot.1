Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109DCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C73803C6;
	Mon, 11 May 2026 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nfQe60J2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5DF81E18; Mon, 11 May 2026 15:07:11 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36A9800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOXMfoHxGzjuzkfOzkK0Qi5ZpErY7ZhFTsaEaevV+cit6t/KxLxpm44Jp/fhTNg7F05ugLHQ2Dn5TU5OB/f0hlGjPAZV14RxzjBlQ0sWgI5Td+0jMrwrSwqn7VsjmDassP/SI37TyoodY1oPGw6g2QiBJiP9F1p2ePSWElk/uF4ouES8B2iKK01Fg5VeD2Zl0+rH/DQy6y756SxxsFaF3v0ZhqQj/rTr83ty7EGQT81Y3nyuIVPippqkoLsweZUwHXBu0855Le19KJFt2+0XCtGkIE8tTYvxBJ1FQv0EqJ22AdheTxtBd39ysN9lCoru4td+bsixL3keu1PZRMgE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vBqNMImcGS5Sub1ORmM+uoWg9kGDQhxIFzC5XgP9AQ=;
 b=Glx8W2tBI6jzpNFhHMW0ZRik0Eht7YsW7mLqO3i2c3IXcZfHplRxzRq4W27wqTH5x0DIVJJpyHdSJt5yV6JR+MQHhx38oti23j+OUjst67N6Z0fU6A/Qlsmn3fNAUD9vMY897Ducz/fZu7Ex/vgUGJc8erNhdQMau3lBE7spRfHMdwe+yhfiPuA0iUo4iUeosshJLQKRPgud27VPOGpGzTE+3+5Udc3OeibsVqzIQmS6mdPCorDWafpgUOj3P/9fE8aahspKcxqXozVipgh7L/f7ma8yfeDklp7NmnbkThb19o/oMRiMhvIB3AfAUXyhryOwVyEyd0RlXqmeokSEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vBqNMImcGS5Sub1ORmM+uoWg9kGDQhxIFzC5XgP9AQ=;
 b=nfQe60J2GuI3YSf/TMVeG97JSZVPxEOXnPmsqPeJELTVNTt6uDKYW5ezGn4hnZ7gpJhzufZb2DvQpLFndF7LSy41sLNwZgTaac1AmNPqa2qBGsOgE/zi2IwlwYxtckqRTMVPi8qdV0iiIGhUuw9nJYNaAGK2ukGCUiAsA+6u/U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB9829.eurprd04.prod.outlook.com (2603:10a6:150:116::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 13:07:04 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:07:04 +0000
Message-ID: <79db42ce-89be-4c2b-913e-dfeb94bd4d3d@cherry.de>
Date: Mon, 11 May 2026 15:07:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] led: Fix toggling LED on initial SW blink
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>
References: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB2805FFE6CC316B1923542634DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B9E.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::629) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d24a68-1511-4909-4626-08deaf5e3280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|11063799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: tInlXUN/ZLB9etEiScVZhqg9KIflgxsFZAAnG6G4wQmgJ0NxlyImEuwGm8pjrWIq7F4sPUnghuGPFYYBIKidt4Y9DEnYGrwyMZUEMpf8LSEz5LuJumseU/0NvTZXM6zGhNbPBjIKG2+WuGvwlCpcywC3xKbCE2BIAMimURSaNxm9XB5KsCDc/nUa4ZznbBeAJm4AZDleAJzuzj7/kbxqT7NDVoQrr5t/5TG80pS6v1313Z6kTtmonqbbLQnZEL+lLUYuXzd6Vstph3qi6UVNade546PcIkjfBwO/rhRQHjHVHoGrpZ459ZfQ3Pv/96XL8jXRvbq0xiPSfJVZFQffMJnRKSwgoZC2D8yJD3OsRFgOxRXwwdZ3RZb9Wz2wXjY7TlLd8tbL/wzmV9xLhD3StgNLIgH3iqnOM25c5si8uXhzqyf+9hsFtPcQIJvYa/aV+IrMfRO+W2Q4/1Fpgfwh1/QcnM8zR7VrFPesSisxhn4M8RV8rrSdJ133+KWq19bUKJveqSe2IiEaGSpbKT5EZaZ7UyeOl5Cw2LTMc71eRA8gmGyZxeY0zr4i9sH04UVaDtwAIn0c98pmb0KVD5HRUXpbolx2gujkGWgQ2bfN9xSnuyvT/MD5OISZtd+dXUCRZtc/SWO5PSazVDpT/KEP+bQOw2x+eGLmowOFYxEXm6RC1L78N/Cu7A4KvkUsNyKE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(11063799003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWx0YkxmMTFST2JONkY0anpsQ0IzaHRBYlRvVUNDaGMvSjdxWW5KbHpJMEZV?=
 =?utf-8?B?TEl4MGFxZWN3WnA0MzRrNndXOW0rVHlOOHh1ci8wcHNoN0VGM1lqMGZxenFF?=
 =?utf-8?B?NERWU2pjWnJpd3dHWlI0eStmQm1Bem5KcU5lbGIvS2pzWXBOalc3dlNpOEpD?=
 =?utf-8?B?SnNscUhKYUtrd2IzNzJaSHdVdHJ3ZlhneC9CczJVOVlTY1o3NEhudFRoT1Ny?=
 =?utf-8?B?NExiaXhEc2x0VEk4d1pRWTloU21iWFV3YndxUHJmUjR6ZzF5cGNwTTBmK2xK?=
 =?utf-8?B?d0Z0M1FQZ0NlS1RaSk9SS0RUdlMrL0tDa1M4S3J3RFl4TmZSTXh1TS9IaUgw?=
 =?utf-8?B?NGNkQWEzdjArQXdtTWx0T1hEUXR6NFJsckkxQWZCVDV0d0NzYWowUFI3ZEpC?=
 =?utf-8?B?VDU1MFg3dVFRK3pFZmd3VHhqL0hxYWFOMiszbmtQcWp2TXJOWmZ4aGE3TTBQ?=
 =?utf-8?B?eXBoVTAxY0J0NHpRS0h0YUtGK3BGUzRnS09DYjdPTm93YnNQc0N5MWVwMEt1?=
 =?utf-8?B?VDZZVVdRcSt6ay9rRlNjOUM2UzUwQjVoc3RqRXRwbmdSNk5wVCs2STc2bHRu?=
 =?utf-8?B?ZzJPSkh1K1JGckJCS081WmpCOVJ2eGs2M3Z5d2dPczBoekE4STIyNGo0YUg5?=
 =?utf-8?B?a01DYnRzL2RmRFlaM2MwV0FMc3Vvb2FTc1FrZlF2aHVGTnczM25XSHZydlIy?=
 =?utf-8?B?VkhmYlA4N0RvWTllU3J4ZkpmZGw0OVFSOGwxWE51eCtZTHo2R2Z1aThKRkJ3?=
 =?utf-8?B?N3RtZ1g5OUJ2SklTZDAvbzYwSCtNQnFEb0ZkbWs5d2tNdXVaeUNhYmRobktw?=
 =?utf-8?B?OG0wUnVXMHR4cU9RNVFZQmFwc1V1c016cVgwWXZUdUs5Sk9QaDNOR1JhRk51?=
 =?utf-8?B?NldMYWRRZW5kd1EyYitKUS9reEFSQ2w2M3FBT2F1b29sL1NFUDhhMGdYQXFw?=
 =?utf-8?B?UjlBdStjdjk2TEhiZ1AyNVhJRDUvUjBEbnlDV2paLy80R2ZRaU54OVorajRF?=
 =?utf-8?B?NjY0MGlTSXg5V0szeC9sWVA5MWpGeHFkV3RIUXZKeGljVFFUQUVTVUQ3OFUr?=
 =?utf-8?B?WTUvdXhPeDl5SGhRVys2cHBFd3liWWFvaEpUNy9DVDRUcjFBQ0xtTm92ZVM4?=
 =?utf-8?B?K0wzSVkwTHRGdmpQTEFnNmpQVklXRDhielBiRTc3eit5c1hUSThzQnA5UER0?=
 =?utf-8?B?T01oQWxNZlFzLytEU1ptNlIxWEdlRStFY0lpZUYyOEZjajF1WjZkZ2J4VExj?=
 =?utf-8?B?YVk3RU1GaTVCNUVwdFZJV3hZcGNFdm5sOXhYNFpkTnRYNkFTYTBMVFB4Umcx?=
 =?utf-8?B?VEg1djgrS3oxcmNQZVdVaUNIZGJvRFk1WGJyeEphaGx4SGZ5MU5MYktRZHdR?=
 =?utf-8?B?elU2NDVIYllhVTRIczVMdysvN0w3U1gxQ0wwTmJzMThuUDh6dU9WSWJVL0ti?=
 =?utf-8?B?OGdZK0JDYnc3SXlNNTZlSVBLSlJMSDVkQVMwQ1hTMXNXWm1zRWJPUkNYTGVN?=
 =?utf-8?B?SlVNQzNRSEVyeHhDamQyc0tuNzMzWDVVZFY0SGc0aUY3djRKMEVTVjlxYUJL?=
 =?utf-8?B?NnNoVnBWK2YyRFhFRlFlMlNLbThZTDA2eWhrM0tQbHlzc2VtWkNIWVg1enlL?=
 =?utf-8?B?VFJwZVg5SGNCbU5XakwyYnp6R0s1QlVyRHJ1c0R4T1JONkI1WjBCTTFpZEhs?=
 =?utf-8?B?WGdaeHZxcWw5WGZ6VldVeEk3UlRtTDBCWDU0R0ZCc3phTml2eUlWWGFYT0ho?=
 =?utf-8?B?WEJZRDlhTDB1cFNMNmtETHVZQUhmNjllek1PdW1lWXVPVExkTGRodjJFbUFW?=
 =?utf-8?B?VTRFVFZxNDNoa25ObTc4MTFJZitjWkl3L1AwQ2JqRHJlMVY3a2RVWE9lYzdH?=
 =?utf-8?B?VnBRZGxmVzl4TGV0Y3k3M05OWGt1cmZiQ2tHZkVBUUlPNFR1WUlFVzdYWVlM?=
 =?utf-8?B?Zmg0Lzhzd1Z0RDBJWXVKZWMyYmpRTjI1V1pMTmRLVnVucHJtNnB0MkZPb2lJ?=
 =?utf-8?B?dENaODR4WkNsT1ZWSjEwUWREVUxkbG1rKzdjU2hXZHI1MnNvVklVN2dET3ZP?=
 =?utf-8?B?NDRJc2NYRzgvTkx2VlZGTU9WRVlRUzVIMzkxQlpZenlKTnZnLzZic3FnTmJy?=
 =?utf-8?B?Y0pIMGhxOWlaRW5iTS95b0UyRklIWFEzUGt0cGdmaU9OV2FJaHVNcXdxcjhB?=
 =?utf-8?B?NnMxS1dYTUVIMnFoeEU0MmREWlFQY2l2OThVUXVmY1hPZEI2c0E5NzcyS2xr?=
 =?utf-8?B?dno3YUNLSFFHWnBMTHJwTWNuMmVjWGdhSUV3YmlGUDFDTmFVcXRzclMwZWpC?=
 =?utf-8?B?TERlSWVPRzlGWHhtc3l1bW5aRjUyNC95T1hOZENyeXNlWEVid25vdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d24a68-1511-4909-4626-08deaf5e3280
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:07:04.4128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfTBip8VuzfprgxcuOOF1oj664/fiZxdqsBnQ+nLVk0bmj7mhj5hVX6XsMPi8Vomp588/hIOghQCBcTlxUtJbxsffy/wXddfM3P/4QOtZN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9829
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

Hi Francois,

On 5/9/26 7:30 PM, Francois Berder wrote:
> If the LED is in the ON state, it is briefly set to OFF
> then to ON immediately due to falling-through in the default
> case.
> This commit ensures that no fall-through occurs and thus
> a LED initially in the ON state is turned off before blinking.
> 

Fixes: 9e3d83301e4f ("led: toggle LED on initial SW blink")

Adding Christian in Cc so they may provide additional context if needed 
if this isn't the proper fix for some reason.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   drivers/led/led_sw_blink.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index ee1546d02d4..4190fde8f0f 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -114,9 +114,11 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
>   		case LEDST_ON:
>   			ops->set_state(dev, LEDST_OFF);
>   			sw_blink->state = LED_SW_BLINK_ST_OFF;
> +			break;
>   		default:
>   			ops->set_state(dev, LEDST_ON);
>   			sw_blink->state = LED_SW_BLINK_ST_ON;
> +			break;
>   		}
>   
>   		return true;

