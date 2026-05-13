Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC9FCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7783B838BB;
	Wed, 13 May 2026 10:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTia3kTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7400683E36; Wed, 13 May 2026 10:25:22 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE7B8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/54FGIrZE/QZYgvxqulktSTRQT/SwBYhOwFEmxqZWNyKFju5HbiXq7yPg6vMg+RaAXDzBxBvPAlYMWEbwRXFXLhCWc90YPz38CWCIisstmEfp1OD413M833n0GMq8t93XWMo37vPojoA7H6rFbl2PXeQf7UeJCn8LKCnBTImxsrUzKwbn0m/azvGPAQabk12tVcBA/tsJDQF4YkUpHyuPbm+xh9Wr2Kt1MiDDZwzMgQVi73ydZX+Dd59OdowuiX3/VfQBOF4Zc7d4eUUzCLzccWuJmqzOvlZ7hFjOMQGtYyqjuuaWpCIZFm6yu7c238yUBOPM9baYZhzqniazl5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIjWzvt0CWXpA1GDBj0DleanDINcu3Mi8RrPL6QBMow=;
 b=PhmC3SlrtLUiEP5T4w+kEFfzqJNl7tDe1Hxat86dehTvlirfHbKuVYG8bag+Pfl9dyD/DtHBDXzjNTvoCkBLfFQlEzsJCMPUfzYvD1KngWuyhogNpGiLf5In56Ez/4Dyv6ZL2uuY5IW5bERz8SlrRwl64wnSuMKhKtzWEmTAOCyVbJiIT46QVJPuupCysopkxxeSsJoNLXuQRpPg1zJ4sEOiPBVe8l++FEuqoYCu4PLE+aQ7RollGhALSL0fLXc1Xm+WOHM9Fpl6M3gJF1j7yl99Db4RHilORaEh6dZnTjuVnqa5OrLk7dp+yysNIhlsg9xRqVOorNMMul8pZQTBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIjWzvt0CWXpA1GDBj0DleanDINcu3Mi8RrPL6QBMow=;
 b=LTia3kTFo2nQwf5fZF1Pf1Yeglzgmm343wB0oVN0mlEv/qUYeHIBos9SZymfcQdw/eshNmabSNJ3vErOjxaliah6tJ97OIZNObwiJOh2auNo7Jh7fLpb8NJu1ySfvaCVGmWxGugGrlrl4i5fbBiP+FtMx36UZ8LG6BUISe20sfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:25:14 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 08:25:14 +0000
Message-ID: <25bffa37-8be9-406f-9433-483796431288@amd.com>
Date: Wed, 13 May 2026 10:25:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] reset: Add reset_reset() and reset_reset_bulk() API
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@amd.com
References: <cover.1777984225.git.michal.simek@amd.com>
 <2a5fee05be84fa1cb333f3ab3db732311da321cf.1777984225.git.michal.simek@amd.com>
 <CAFLszTgRUg5Dk82Gq9FVJ99cn+15Fw7RkwVsiRgZwH2tqHVS=w@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAFLszTgRUg5Dk82Gq9FVJ99cn+15Fw7RkwVsiRgZwH2tqHVS=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae424a6-664f-42bb-6c83-08deb0c92855
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uRShK1D0pw/Hbs5fXta+AzZ0YFP3Oga+uxO9JsJqEsk2jt4G7u4ZlH/pEXp+2aJ36TNVls06U8MaGyaAywir2q3CZHtObWl6V7+xwoU2Ct955gXA5glGnahr+NnhVN9anN6wstXb2rGYqO4uNrhRxRG860e+8xKEXBtY1vPj0Ou7WqOZkcUXmR2+mF0nUizTmAjtjmz/ygx4NOuKBOxt3h7mAORRGMa/OKbTZ7K8KlssDdd969w3QGoUoyTFstpLYKzvIEZeRSAKKP7/wYHQHvducWUsgcjZawGvfNtjLmhlBMHKyFoZcQkqEfxmx8mFRSdDoQXCVaBIB1pKexxJSX8CbV9i78m8A/OOmcAqzMoyoiRmsip1ncraqihh6x81WCMCacDFw+Rr72O8p8bmnE9w2WqlT/YGOR5lbtI+xfgBChrAiYEhAP6yeyF1ubxc2GJYsLlx+QtxR7yvJlKKnpMXLEIVZIWMeWgRlguC5ovMIJQ7BdEqKKsZ0xBteOcnN+Ooondx/g4EJsSQ0GwsDLHPubJ5kg4cAhVs7jyz40Yc+p0w5InI3059kQEGzpQdSdwY1uZlHTSuiHu+J0XhR9NvdmT1VTF84aXlryuRlF1oC72UWsD5QoCMwUdqFr5gG7DJsmGyl0yKPWdRmeV4+vGdTOuAhwHOTBjX2XRUHP9OfXgyZXc4cJhg+cfH0DP9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVEM2lKcjFFM1J1c2RTbE9rQk5lVWR3eGtLTHo4bDlzMW92YThNYlZzVzNO?=
 =?utf-8?B?ZUxxRFRHeWJIQVAwbCtWdkVqem55Zk1DQllKYjZaVWZNYUpOZ3RyTGR2bzQv?=
 =?utf-8?B?TEtQZEZOaVpoZXg2bnBpbkVvcmZ2cFd5SlErTVhhUCtpWG84aGoxV1VqYWtL?=
 =?utf-8?B?eUdud25oNmsrZXNyUTNyZThDVi9yVHBTcHBsL2JXS3pJNnV6TTJLUmpDZ3du?=
 =?utf-8?B?d3Y1blpXWldQMStENmtBMjBTTVVLYjdqcnRaZGFvcVI2Ky9WZGVJUE1tSHhu?=
 =?utf-8?B?bnRwZXBsY0tXQUxyTVRQTmw4WVRKYVpvR0xTVFl5Z2lBb21HdHMrTHplM3Ew?=
 =?utf-8?B?cVRVNE9VK1FQL2c4bWdHcHJJVUpuelVHS1VCQVREVGNJYzBHY01pc0pNMGM3?=
 =?utf-8?B?M0pEbjVYV3RHaVR4T3BCUzFQWmNlR0d5V2JWdERZdm5KZEJjYy8rQXpHdDRK?=
 =?utf-8?B?T3NENHVFVjdpVUg1ZHUrckhwQmtqSDNSOHJLODFVZUw3Qm13TjFaTk1KeGtR?=
 =?utf-8?B?a3JCZXFqQVByYkdKUStRU2hISjVRYnBLQWttSmVYV1crc1ZvNkc4cjJPbXVt?=
 =?utf-8?B?blV4WkxvVUJKZXZzNURCdFRwQXQ2TmdSOVdaZlNSZFVTY0t3eXR3VTlteStF?=
 =?utf-8?B?Y21Od1o3U0ZoSVRLaXlCaVg1ZW4wZGhINmp6VWlxZFBVMkhxZzVpa1Yxd3I3?=
 =?utf-8?B?RG5Wc2lYUlZ3dUk4MGxSSUFKNHp0b3dEampkQVlzM0NDY2JPM2hhN0NIUmx5?=
 =?utf-8?B?MHlMdDNWRGZLWGFWMWRXVGt2d3dmdGZreTFxQnY1Wk5tczRlY0g0d3ZXN2Zi?=
 =?utf-8?B?Wlp3cWRJQmNNdVV2TUhzUjVUT3N6dmVwYXliUWNjR3YrL0xBVTNnM2p5cG00?=
 =?utf-8?B?TURQN2tsS3dEdTQ2Qnl0QXhTVm9YYTNNMHhNTUh1ajF5c3JkQncrTjgyMy9U?=
 =?utf-8?B?OU1rcitWNmFVSTg1RzYwN2ZOQzMwREpNRHJwd2psbkFmMnVkRVV6YytKSURt?=
 =?utf-8?B?N0cvV2RoYStlR1JKNlFDeFYxcldWeFFxUko1OU1RV2MrakVnekYxSmdibW1k?=
 =?utf-8?B?cFdMUjMyRzdMcU42TDVWa1B5bW1jN2I4NGFuSXlLS1lQRHdIRVN4WFpIUERh?=
 =?utf-8?B?RmNGRjg4c0t1c21SVDlrZWl3aE96djlHelIzc1VLSUhVaWxRSVI2OG9qNkN2?=
 =?utf-8?B?dFZBWDRKNlp3enU5QzBYcEhSZ1gxZHA0Um1OV09DV0pXWFRjMy92UGNKbWw4?=
 =?utf-8?B?OU4zeUFlb0FZajZGMnU1N0hqYUYwMnFDQjFrSjQrcWtyWGNLRXRPaThUeW0w?=
 =?utf-8?B?T1VJVE9CT2hiMUMxanFIYkhTM3Q1SW9IYXVsUW1HeldoT3I5SzVHWHNJaWRR?=
 =?utf-8?B?bkc4RlBPV0E1S3lFaWlDNC9JdGp5NC9pSUFCcVVSVEhmbWRiU280bVpPbExi?=
 =?utf-8?B?TXJjVm1TY0o0WUpZejNnTEhwWTNKdlZGRkZIL3htcTJUNFI0a3ZHbDQyNmhJ?=
 =?utf-8?B?d016aXF1dy9qVWVkSXVRZnM0UWtGKzRvcWl6clBTK3F2ZXQzUUNLODlBWWQ4?=
 =?utf-8?B?Vy9pRVRjNGpVQ0RkK2xIbUJVaDFMZzhHMTIrSmFMYlNjckpxN09jUEpQRVNS?=
 =?utf-8?B?Ky9PemhuTnhYd2E2eWJJaHdNR1cxMm9DYXMveTNBVmtvRTZCaFozZVpiTTdj?=
 =?utf-8?B?Z2xubUl3V0F4eFRwVVBWbkg5eUhNWjF3bndOMklXalQvR3BDQ09aMU5XSWV0?=
 =?utf-8?B?UElFKzRDbyttaHRuUjBXSVJwUU5adS9Ybm05MlJ4OEx2dzRlV3hWdWs2aXQ0?=
 =?utf-8?B?bm5EWXh0b1czaXZpLzdpVkdNTm9hUFZocUtycFdYTllqYjhub01WMXZ6a2xo?=
 =?utf-8?B?Wlo0SHVab01iVks0ZDBiRWtjeTlVVmhUc1NlMVdsRCtPa3U3ejZuTGMwaGo0?=
 =?utf-8?B?MEhSKzUzMGdqNTR4cFRML1E0Y2lRbTF6TWMzUjBoR2JndDJnOXc5VFNCb2VJ?=
 =?utf-8?B?LzlKSFRseTVvMTFNNUhhMWE5cURyUDRpZHRacGNLcS9aME1UNE5CclB1QndI?=
 =?utf-8?B?TTcvL0ZaaGpwM3QySzBWOURaWW5rcm9Cbi8vUDZhWVpOZys1bW1JM1NoQnM3?=
 =?utf-8?B?UkVrT1hoc2FsRFk4WE0rVWhma1B2cFhkUnp2YkwzaUZLb1lwRTdyREozYnZ4?=
 =?utf-8?B?MFhQM0xEdnF2YzJleUx4YXErRk8ySnFKTmVSblBmazNIeWNOa3o5VlhFa3Qw?=
 =?utf-8?B?ekZNN1dYM0lXcmp4V2ZBdHVsNTBUUmtEN0FheVhvZVE5ZjJXYVo2Y0RqSnQ3?=
 =?utf-8?B?OFhwZEsvZ2JjdXo0cjlOUFkwcnlyWlpWZnBLOXlPK0JuSmxzOS9jQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae424a6-664f-42bb-6c83-08deb0c92855
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:25:14.6121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pc9Op/Kq2KNIhAISjO2wgcaJJaCXPTRwgUVtgAZRli2YqFX/7SOodlmOWyGoKxh8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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



On 5/7/26 23:11, Simon Glass wrote:
> Hi Michal,
> 
> On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
>> reset: Add reset_reset() and reset_reset_bulk() API
>>
>> Add reset_reset() and reset_reset_bulk() functions to the reset
>> controller API. These functions assert and then deassert reset signals
>> in a single call, providing a convenient way to pulse/toggle a reset
>> line.
>>
>> This mimics the Linux kernel's reset_control_reset() and
>> reset_control_bulk_reset() APIs. The new functions are useful for
>> drivers that need to cycle a reset line during initialization or
>> error recovery but with also passing delay parameter.
>>
>> If a driver implements the rst_reset op, it will be called directly
>> with the delay parameter. Otherwise, the reset core performs
>> reset_assert(), optional udelay(), and reset_deassert() as fallback.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> drivers/reset/reset-uclass.c | 34 ++++++++++++++++++++++++++++++++++
>>   include/reset-uclass.h       | 12 ++++++++++++
>>   include/reset.h              | 41 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 87 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> optional nits / thoughts below
> 
>> diff --git a/include/reset-uclass.h b/include/reset-uclass.h
>> @@ -76,6 +76,18 @@ struct reset_ops {
>> +     /**
>> +      * rst_reset - Reset a HW module.
>> +      *
>> +      * This optional function triggers a reset pulse on the reset line,
>> +      * asserting and then deasserting the reset signal. If not implemented,
>> +      * the reset core will use rst_assert followed by rst_deassert.
>> +      *
>> +      * @reset_ctl:  The reset signal to pulse.
>> +      * @delay_us:   Delay in microseconds between assert and deassert.
>> +      * @return 0 if OK, or a negative error code.
>> +      */
>> +     int (*rst_reset)(struct reset_ctl *reset_ctl, ulong delay_us);
> 
> Please document that the core inserts a udelay(delay_us) between
> rst_assert and rst_deassert in the fallback path, and clarify whether
> an rst_reset implementation must honour delay_us or may treat it as a
> hint. Without that, authors don't really know what to do with the
> value.

ok. Will fix in v3.


>> diff --git a/drivers/reset/reset-uclass.c b/drivers/reset/reset-uclass.c
>> @@ -225,6 +226,39 @@ int reset_deassert_bulk(struct reset_ctl_bulk *bulk)
>> +int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
>> +{
>> +     int i, ret;
>> +
>> +     for (i = 0; i < bulk->count; i++) {
>> +             ret = reset_reset(&bulk->resets[i], delay_us);
>> +             if (ret < 0)
>> +                     return ret;
>> +     }
>> +
>> +     return 0;
>> +}
> 
> Just to check - pulsing each reset sequentially means the first
> finishes its full assert/delay/deassert before the next starts
> asserting. For the cadence_qspi case in 3/4, where multiple OSPI reset
> lines are expected to be asserted together, the previous code did
> assert_bulk() / udelay() / deassert_bulk() so all lines were held low
> simultaneously. The new behaviour is different. Is that intentional,
> and have you confirmed the cadence controller is happy with it?

You are right that behavior has changed but it is aligned with what Linux kernel 
is doing.
We are using only one reset line that's why not an issue for us. But it saves 
one firmware call (per reset line).

int reset_control_bulk_reset(int num_rstcs,
                              struct reset_control_bulk_data *rstcs)
{
         int ret, i;

         for (i = 0; i < num_rstcs; i++) {
                 ret = reset_control_reset(rstcs[i].rstc);
                 if (ret)
                         return ret;
         }

         return 0;
}
EXPORT_SYMBOL_GPL(reset_control_bulk_reset);


If it is problematic we can go back to assert_bulk/delay/deassert_bulk in 
cadence driver.

Thanks,
Michal


