Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49D7C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D47287EF7;
	Mon, 12 Feb 2024 14:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="hw3VBVzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA50787808; Mon, 12 Feb 2024 14:54:24 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED85187EEC
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvArAZWzju4CBbR5zBYdiHiTQrpKcz2UKBM6vTSPi1rXX5AbDMCv3UX7dSMwAsuiprQivQdZIbdQh4w4UPqbA0mI3/Km5L3eASHIhaDgotufzv/OD+r7vkUpBRCx6F5nOTA0ahPRk+S4rL/oqKwvoqAvE+R8vLNEbqMbRdKHIdlY7PtiX7wz7j948LdQ/Eq+Na+j8YgQZbDYpJL/ZZ1I6Az+btX/wHCcsDAhi/oFGVAKc5m3gN0FB1TY43nLif82m9SGJvhr/DoFNdcGkmMC2YbtRBoqzH+UZxokwEGlRnXOg+vEfMZBm5z9sjjRYBcVV+tDh6Ywku6Xr5395PdatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffWEVUj4BYA8RpVVI0HnyTz2JEkCz86/nGN8Ast8lzc=;
 b=ANvSkNL4/HAwtjb4UgXXx8oJq4y4LRI66VdIaQQhmt5OU0mbUYrQJMF1xZkWS/QHsCNQ6+pp3eOwfeN+YN2hjEdLsYeszuMN2yohoMZwjnUFXKMQnOiq+TRtYFxtYI2UtjtLV4vgJkEeHXRbHXtxJFPoIf7yebymF0NY8c3cINF03tl6w3MI2PxrN29J3nZtYo4dXHAS+dMeMkCu5H1Kd98+5YrAuZvOpaunkLL0USMq4siLsuvLebK2vJImea1dZArc3iZ+YnZpIDPngIGnuSVibprx+QOW0oO4CxFwc0k/iNJf+XEc6jubPtNKIB/g1RhiocmCGte0O8BWk3WIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffWEVUj4BYA8RpVVI0HnyTz2JEkCz86/nGN8Ast8lzc=;
 b=hw3VBVzJR8a51CaXl8MYDXy9vx+AyoZNoOBkTXS9qd+L+944AmkxBcb7meZFLHE5UJUKG3pG3z8gjlLLnHTbwuE3AYnLK8T0hAd1memMB12I9Zf2yMFbyN/jxGV5eCdEIXLwJ6F7aSAfUhCJyjhE//3eTzgiiUjydm+wr9dsfCrbzUmkJlVdf/EpvEdraECZjEXunzXap7RfjzZSJTZjazFTSv9FdS7MnhnB19wMplPBZefGntdDaztpEr5gWm3D0kvvk/G5yqFP/ps6ThiUCz6ASi7nLKjj2/n1+QIZem3GxFmdBfV1cfOBP7YVAuYLQ7LCGGRxiWi947jZqH4xhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 13:54:16 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 13:54:16 +0000
Message-ID: <65ff3bda-8e50-46ab-be30-a197b564391b@theobroma-systems.com>
Date: Mon, 12 Feb 2024 14:54:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] rockchip: pine64: pinebook-pro: migrate to
 rockchip_early_misc_init_r
Content-Language: en-US
To: Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-4-6c9ffe09b924@theobroma-systems.com>
 <CALeDE9NSsp7j2nmFJvPrK9CxhGM1wKcR0ZnRfSy02kFSYwVW6Q@mail.gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <CALeDE9NSsp7j2nmFJvPrK9CxhGM1wKcR0ZnRfSy02kFSYwVW6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::44) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b6d217-5f84-46ad-cb0e-08dc2bd21a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ImwrN74MT1t0S/3xy0BOUiymzeG/UVxTxubPVPsSjyQUzaqmFi2SzJfVZPhMrfb/dBFV4/SHhRsqn1FTDXaHp6rWihkvjChdHy11x6DCXZi6mmlYydyX4sdIWxFBFSg2/ZAeYm4o79K40FXkgEh6A00PtKh5mzEXOzU2wuMCGKWtWANBk8qCK6ABvU9gXCsCAwIpC0MHStfRtRcTbFl3hbsCrnyeeKqaHyjGJtUygU4EwwlgH/4Njw6Rpa3DMn7sdKmBCh4LZh/JdmepUpybsjGTBPiNx5Jbw2krPNQ712TXsc2LFo6eiiRPSUl7zYWCo5VQKckrOHTjqCfPFwDHXgOVeUT5qvLZIc+i0gmk5NzaBQqRlDAJ86zLPcOVA1IEJ4bHF8OQcFFv/RgjzysbYwYFrgX9Npam7B/pFNd93a7FgIn25eim0NwWamW/h7cKSGgL+BP1l8KD72ZyVx5SuUnTIpzZYlmiCoM5wBG7bBpFCuJOATvzimFqTwY+Jq+qJPU+AsHyiiy3eWf9bx4hS08CrucFra7aRYX+mLArfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39840400004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(44832011)(31686004)(41300700001)(2616005)(478600001)(7416002)(4326008)(5660300002)(54906003)(110136005)(53546011)(8676002)(8936002)(66476007)(66556008)(66946007)(966005)(83380400001)(36756003)(86362001)(316002)(6506007)(6512007)(6666004)(31696002)(38100700002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndoVXFUdGNSdFdTTWlqaDltdkN0d2xRMjJwcXdzSFFHRTBuSEQzdW1mbUJH?=
 =?utf-8?B?a3FMTjd5U0ZKYkljVEpjRnJLb0lKS3U3K2dpcE45TzJCMFNQd0gzcG5HcWd0?=
 =?utf-8?B?ZVdvS0tjNSttVWtQRnhURWRGUTZnVnhLUVE5S0Z5aXhJTnNPc0o5TUFPWnBx?=
 =?utf-8?B?eG9qdlZTWC9Kb2ExR2s5TkhYT2hxL2Q0OWxyUWFsakhlWWxSSDc4aW9ZUEpl?=
 =?utf-8?B?WGo2ODhOTytyc0VMMVIzMWQxakZqU2RmTHhOdmw5QkgwZU5LT1cvRDYxdm1J?=
 =?utf-8?B?U0F6azJVUDV0TFdOWk1GMkJ1ZDkrWDhsbkY3RThGZE9tNWNWdTFKc1puVk1r?=
 =?utf-8?B?bWJESGw4UVlzWjZHc2dLZXc2T0ZISTMveUdvNXNRWGROaEFJUGtPRzVUdkFH?=
 =?utf-8?B?RStQc2xaRkxMeVRxelI5azViYlJFOHYwSVBYTHdVOXVtTjJKVnpxdmU2RlFn?=
 =?utf-8?B?NTBGeHlNZmtlQURWQXN2KzVIRXZIZjlNN25sYTZVMG9ISGRBZVBtWi9XOElQ?=
 =?utf-8?B?UnZtQVRWNnB5c2JFUXZTUmdiODlaVENETXpWK2tJNk1XZjBDOXM4enpyVjd1?=
 =?utf-8?B?K3NCRmF4SHJsbDBlZFdpMnZ4WklTZUFIVTJ2NjhWNVJZbGlyTGMyTkRodi9i?=
 =?utf-8?B?aXYrbVdEWHhhRlZNeWhUY0hqdTlwbmZOZVdxM29YY013TzJxK2E2Y25iRWlI?=
 =?utf-8?B?K1IxQUE1NnN3bnYzb2dyVXlzYld5Snc4TEJoeG9sL3MwQkkrQnF0bjZTY0ZV?=
 =?utf-8?B?aUs4eVBBMDNVbWh2YjVsRGdaTm5pVGh4ZUVsRTRTYmRNb2xJR3I1amw3dkFG?=
 =?utf-8?B?bGt2a0padlp6WkdlYTROYThrM1ZaakMxT2ZzSkJqUk9xVVh5cTNiWGVVSkZw?=
 =?utf-8?B?aXJrUklLenZmeGNVNDQ4cnZRRmFFZkl6clZWUnZxVU1ZWkloR0xaUCswWEE2?=
 =?utf-8?B?b3RldmpFZXJtRkdVSGFIWW90UEFqREZCazQxbFNCSGtFdi9PTE9LZnhEenUr?=
 =?utf-8?B?WWhTeitjeStaaTg5MFFnNHRoNmRENG9WaGpYNTJPSVI1SEk5bGptbGt1bjY0?=
 =?utf-8?B?bGRtbUwxMnJXZHJxOGlCemJNZjB0Z0RhTm1Ca1M1bjhvM0xVT0tVaW5uZjFG?=
 =?utf-8?B?SFkrNjBnYnRZT1kzTFpSbU9iOURIc2kwWUZ1T2NYS2IrS1dDSkEzai9paHlT?=
 =?utf-8?B?U2ZJOEdNbEF0dWxGYTI3elhTOURSbE1UbzYvSjhNSnZYc3I2NkU2ZlE3TGla?=
 =?utf-8?B?WXQvckxpcWJma0dOV1hHQzQwVW5pa2wvSGE0OWpWK1hHS1NUK1dzVWtnZG1W?=
 =?utf-8?B?eFl3NjdGVFZ5VnUvZ012VkZrc1ZXYlZMN0tBTHQxV2gwVHVmdFJVUzRmMXlK?=
 =?utf-8?B?VHNNQU5EQ1JMOENQK2NOQ0JwV1lQUnJBQ1NqQzZWdlBWY216UHN5M3VpSzE1?=
 =?utf-8?B?YkV2VWNLMDdtM1V0OUZxcVI3RGtTUjNtQzE3SUZkN3lNY3hObEY0YzRHellI?=
 =?utf-8?B?eVJVZTdDdzQ4WXRLbTJGaHI5dEZTRTJCbWkwOTJSZWg4aHNzSk1DQUdhUkxL?=
 =?utf-8?B?VXV2bmJOc3g5YWZEWHFWaWlxVU41ZmdDNnJ1eWxuQ2s1SFFvYm0xZkhqcXg1?=
 =?utf-8?B?Z2ZvcnY0L0xlb0p0QWFwY0VSMEsrZmNXYUFpR0Rvc2cxUWVIZlp2NzFEOHNw?=
 =?utf-8?B?NGVrOFJnWDBvdWZwZjBQMmRReGM2Y2ZNajRRaTZtY0Z0b0NWRWRMSkE2OVdw?=
 =?utf-8?B?KzJTZjhVNi9tZHNNQ3MxdGJoakZ1ckNtZjFnd1lPdzAvQTAyNWpzNjlYcElQ?=
 =?utf-8?B?WFdqUjdVR0Q2QVlTd0dCU2tNbVkzczVRVUFqR21maWFLaGVVTTNhT1NMRnJN?=
 =?utf-8?B?TjJqYkxibFpOdlpBN0s3bHdQQU0yRXNFTVJmZUtRY05VTkxkWHlnNXNyeWpz?=
 =?utf-8?B?R0c3SllGNC9QZTI1L3R1a2Z3QlZWcjlTblcxR0EvT0tSOG42ODdDWjFJS0Mz?=
 =?utf-8?B?TEdRN2ZMTmZJQzhFdFJudmUzQ2tQa3A2bnFiUzNNTU00am9yQXJDVkRzNW1m?=
 =?utf-8?B?RERwNlZtdy8rUjVOekp1TFNLdGRkTDAwWSt1a2Vzc3J3RlRsVy85QnpKdm5t?=
 =?utf-8?B?MDUrMXpYVnU3cGdqRlB5Y0ppbFVoME5PaXJyQ2pCMWpud1VRQ1VPU0ZCd2dR?=
 =?utf-8?B?bzZ2OHQ2bGY2L0VrZUtKZzVUYmdqRC85UVAxS1pOUDBiYjd6ekJDVVc5dHhx?=
 =?utf-8?B?VDF2cXAxM0Z1Y2N6OHpYQUhXOEx3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b6d217-5f84-46ad-cb0e-08dc2bd21a25
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 13:54:16.3063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaiWhamMljq2dxy57dKxOMJ4aoOwpN1KL/RG2rq8oqOQOSmJ+rd0Ec2LdG0we9Y/BzejXvQWJGP7rywBRu4oil12M7hw8W9UN+Inm/zH/1pz2BO/pOrSiTUSrLP8WUAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
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

Hi Peter,

On 2/12/24 14:41, Peter Robinson wrote:
> On Fri, 9 Feb 2024 at 09:50, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Compared to the original misc_init_r from Rockchip mach code,
>> setup_iodomain() is added and rockchip_setup_macaddr() is not called.
>>
>> It is assumed adding rockchip_setup_macaddr() back is fine.
>> Let's use rockchip_early_misc_init_r instead of reimplementing the whole
>> misc_init_r from Rockchip (the side effect being that
>> rockchip_setup_macaddr() is back).
> 
> The Pinebook Pro doesn't have onboard ethernet, nor an alias defined,
> I wonder if rockchip_setup_macaddr should be gated on GMAC_ROCKCHIP or
> something similar. Otherwise:

This was discussed here:

https://lore.kernel.org/u-boot/0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org/ 
is the first message in the discussion, which raised the same question.

In short:
- gating on GMAC_ROCKCHIP is not wise,
- onboard Ethernet or not doesn't matter, it provides a sane mac address 
for any Ethernet device by default, based on the CPU ID.

Quoting Jonas:

"""
  > diff --git a/arch/arm/mach-rockchip/misc.c
  > b/arch/arm/mach-rockchip/misc.c
  > index 7d03f0c2b679..ed5bdab5a648 100644
  > --- a/arch/arm/mach-rockchip/misc.c
  > +++ b/arch/arm/mach-rockchip/misc.c
  > @@ -23,7 +23,8 @@
  >
  >   int rockchip_setup_macaddr(void)
  >   {
  > -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
  > +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
  > +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)

This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot but
want a mac-address being set in DT fixup. And for newer RK35xx SoCs the
GMAC_ROCKCHIP driver is not used.

A new Kconfig option should be introduced if there is a need for some
boards to disable this.
"""

What is the actual concern of yours for pinebook-pro and this function 
now running? I think what ultimately would result from this is at worst 
the environment "polluted" with ethaddrX env variable?

Cheers,
Quentin
