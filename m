Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B88CF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 11:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF90388599;
	Mon, 23 Sep 2024 13:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VYxjO2Kz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A0C188B79; Mon, 23 Sep 2024 13:04:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0818588599
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs5OTSoyf2mJhkYYzFsVe6vRr4d5Py86APx97TSGqfOy8k1SyzNitvh42XbQUTjlmL0K7+XmFWkLKQUS8MUKZJejcZX1EdoqFfWMFYmF+Hp33AxNqwIxGcsimJHouEy20ZmghCerW2fmVROiwcYCRhiu77JmwDB8HRW+33vCpcpRcKgqgq3vdDsKzbonX94ramhj3XB/c5YtEqwzeg5UYMCT6IIYnUCj8SAR3mWeaX8BCvRI7Vl3vbchgTDyS2HhhCpl/LY9S9nFMnkFF4CadH9sbtOrEvrfe6Lg3CJk/HsoW5XZ0nZeCX5MyPgHpmGzHaR0mbp0HZM+R03sC/7KqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJa5QaGnhp9qRwKGHzRMysm6FOmKrhuY8m8LnV3Rj18=;
 b=LI84IRG16GdaY5mRaYI/fP3GeReX22NmtlosKTaowuWm5ZJsyQj+sKghTg7Edsfqu9/9Bs5/mDsCQ4kxbT8i237iNeLAdpegVs1Ol6mrVk8dj4P6/LKj08m6S6FFE5uWUITN4VTOAp3kL85s2kn4r6qrqqXizmZRyntzmyGq3PC5S6DHgBZ+2sPE3OXqg6KasSdSOAZB1PP+aTp24MQ/97LPzrQBpJjHUpsb0RdYKtpoXDtefXSZ8UNGL31V7p84a7z/slWhCX991ZCvs5XBEjKaKfusCWkvM6RSc48z2oURto4y380AvNf0n31l7MwjZgbUMG/wRQggjPQirEZHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJa5QaGnhp9qRwKGHzRMysm6FOmKrhuY8m8LnV3Rj18=;
 b=VYxjO2Kz3imcofiSv4j34LPp4jljqA1h4LF9HFjB/jPAjwp21aiklgvvm5nmgqcvwY4l3ilum/FKqDgaySW4uGq0SIIMRalCNrHDGQReRjbxCIkqKG5OoCP5z355/wjyuWJzPAr/cF51rl5l1CeC6DZri9m3pkad3FsqXqzEd+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 11:04:29 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 11:04:29 +0000
Message-ID: <ac08af71-7469-44db-8b48-56ac46b1c4b9@cherry.de>
Date: Mon, 23 Sep 2024 13:04:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] env: mmc: refactor mmc_offset_try_partition()
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Marek Vasut
 <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-2-rasmus.villemoes@prevas.dk>
 <376f36e2-1fa4-4fea-9af9-2c2e491cedbd@cherry.de> <8734lwm8wm.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <8734lwm8wm.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAXPR04MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 242e0a03-6384-4fb1-1456-08dcdbbf7eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzJ5ekJFMURoMDYwZFh1RHhoS2xFMXE4ZThxVXNoNzFDa3crSElwSW84TDIr?=
 =?utf-8?B?dEtiTHMvZWwvOXllSzdZNm5VcWYvZjd1MnY3VmhXdnRTUjZkMHo0WUdDelBU?=
 =?utf-8?B?NGo3UDJYVlNBMHVDSzJwLzI2V1diWHFkN21QaWQwWU1EVWhLYjB5djlhZUZC?=
 =?utf-8?B?MS9ISmNaS1VIVXNGdHJNQXBnTDd1dTY2SE9oS2Y2c0k1WEtYL3o1Y3lQTTlw?=
 =?utf-8?B?Wno5WFc0ZEMxc2ZyYWlrRmM3MlMrKzVQM1EvWU52NUFHNENRbUJzeldpdDND?=
 =?utf-8?B?VjFqZ3BHWFExUk4wYVhMK1F1eXppMzFyelBCd2VIQXdWQ3dqWldMeENXS0Jn?=
 =?utf-8?B?NXhsZEU4SHh4V3hHcTlicjh6UHY5RkpNQ2lKWHpJTWFTSjJQeEdNTDVzdk1r?=
 =?utf-8?B?Vi9kdWdxZ1lWQjNJQUlVZ09HSGFyUHJUUlFmNjJENzBVcE0vblRlYVZHK3o2?=
 =?utf-8?B?endsYXNuS0g3VWZWcElKWm42N2VkWjhSVVRUcms2SnZaTDlOdVVEUzZqT2c5?=
 =?utf-8?B?REM1WWpzUTRFd3hqWjdyUkFyZDhvaWYzZ3krOTJWaGUvOHVyamxnZXhqQjc2?=
 =?utf-8?B?Um93MDQ1L05FYkx1Q0VPSHpZRENaeXo2R0tRQUZMN0phWHFNejF5WVczQTFa?=
 =?utf-8?B?MDMzWm9jUlV2aVJpOHVidVYrWU5VbnkxRk1iaXhTZGlKNzFiRko2WUJ0aCtN?=
 =?utf-8?B?QlJKa3BHbEJNSlhsZFpRSTdUcVZNSTFJODEvelI3RFFkcDZFVkVBMjh3L3Q4?=
 =?utf-8?B?MWhlM2tuS2FMY1VnL043MVRWS1ByUTVoSjNTM1RlZ2RDRGd1cCtmeDhzbERX?=
 =?utf-8?B?Q1ltSys2TUVZaE1GRmI2VjZjTXlyTndhODB5R21SUHVLSGR0T2VuQ2RGWDJw?=
 =?utf-8?B?YVREa3dOS0JYUEhaL0lYNTk5cm03SDlQYlpWMGdaR3EvMVl3QVBHUVpDSlRF?=
 =?utf-8?B?ek85R29PRThVbFpVR3UvMkdOa1pmUWlwREljcDZFSGV3M0FkM0ZxaWcrd0Jq?=
 =?utf-8?B?QTRuK295UVdzZ3dhbGRPL2dYY0JmajI4N055aEpwREhUR2YxQ3pLUHVnMTR2?=
 =?utf-8?B?RXQ4V25DOVVPaTJyNmNkVjBJMFNJbm1QckpPWGNoQWhrQlY3ZmRHWmhDNHZH?=
 =?utf-8?B?b1RLVVREekQ3RUEzRzcydTU5QUlNblMrZ0RTbnlXOTlwcHA3M0NGZnJzNTQ0?=
 =?utf-8?B?RkMrdklTMnZhV25RMW1BTUJkSFNQczkvMmZQNXE4a0txbXdCbGdUVkU0SzIw?=
 =?utf-8?B?c1dpNzU4WWcwVU95N01pVzI2dFEzbTJrZnJobkdld25ONmI4eGpWS25GZ2N0?=
 =?utf-8?B?YWZ1RU91M053TVdBZ3NZVGJ1MitJUU5yOWdDZXRMTFkxNU01RW9KcUdMVjN6?=
 =?utf-8?B?a2dYYnJBdU9zN3Z6dHdVQ0VRRm4rUWl4OXZhMGoxaVRybHpqT3VVaUkra3hB?=
 =?utf-8?B?bUsvR29qNm02QVZYOWcvZHd1Y1lrOExIUGVPTmcvaE52dlRwR3ZZU3Y3bzJz?=
 =?utf-8?B?TTF2dGxPNGVjS3BjdTNIMW83VVpWa1ZxbjVQZ2ZMdEVJdnhDeWg2T1JZVktM?=
 =?utf-8?B?cjNoZFpuTmVVdHRSTENVSCtYMGIxYWN3YUhXKzFZc0tMaStMMkFiVE8wSmhq?=
 =?utf-8?B?RG1QNjA2RW51cmxjcmZ6VEdETU0xaWtFU1pTNXcva2xJaFpUQTdyWWdtNURU?=
 =?utf-8?B?cHNsSEpudTcrNzk4YUhPNjZYQjY5NldTOWJueGJWZllGTWZQSFRtcUFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlluaG9kUTQzM1RWbXRxdkd4d0RRZkUyWHlEVk96bEp0OXFBeDFVdTdjcjV2?=
 =?utf-8?B?R2lxSzZJMThQbnc5ekQrUTc1WTJMZk5TVVZuM3NBZ2lqdmZGWjFmajNwR285?=
 =?utf-8?B?eXkyS3FuSi9mbFlINkJWM0FkQ0tyVThWZG5iYmFUSXIrWXJyOTIxd1NUamhu?=
 =?utf-8?B?K2RHME9Ib0Y4K0t1OWhBZVBrVnFOY3BYVk81MUpQdzVENXpsYktvbkpnQ05h?=
 =?utf-8?B?SCtYZHVCOGJhbzA2c1RaMW5tdm5OWGViaEx0UCtobXAyQ1VHZnovODhTRFlB?=
 =?utf-8?B?Y0NwMXFBdGhMUGxzZ1FWRFI4N3dUVWpWNE5yeXJ0TjZORWdXTXl5c1hSSThJ?=
 =?utf-8?B?WXJDT2VtSnlLSWFDVWpYNmtQZHllYTZjZ0M5SG56SFh6UG9QNnlkT2YzRHUw?=
 =?utf-8?B?RGUrWXRpRHhQMG9BdjJPRm0rYkNVY2wyRmZGbzVFWEpsczYrRk1ycEVyRDBL?=
 =?utf-8?B?Q0p0NmpIbitHQVk3cFBYdEx4bVVSelpCVkNJdHVrWFR6endIVHB2bWJ4bXl0?=
 =?utf-8?B?dFBGT1d3dDE5QjJsR3E4cGJyZ0xZNXQxelR4bFVJbHAwSVdlalBWS1Bvckxp?=
 =?utf-8?B?K0FHRGx0VEI5TGZKeWx0ZUlCQWs0Q0s5eXdvam15WC82a3hpamEzUW9QN3A5?=
 =?utf-8?B?MFVSelVMa1BmTWNmeDZ2NUVOUFhsWWZDQmNJMGhPRHd1dmhRYjEydmxSMTBl?=
 =?utf-8?B?V3JwM1lqUGE4V2lVZUlxWUVrQldBcFhIVkpudFhEc3UzVzBKayt2cjJiNkhj?=
 =?utf-8?B?aFhMazNKd3NmOXVWVVpuRmNhV1hYSGZldEpuNlRyaEhIemdFU2FpcEUvbC9J?=
 =?utf-8?B?R2RPR3FVdXhIWU5tdXRteEtRdW45b3p4bm12bXdHNXVtZUxnTHN3clBFMHZT?=
 =?utf-8?B?UEtDNEdnMlJOTy9kSXlVY3luVTFYeTNvM0JyeXNhNWVXcXVUem9ydzUrNHBZ?=
 =?utf-8?B?dVZJR3VUTHFCeWllRHkyV2xSYXZFV3dGV3A2K0dtYSs1dWFQd2IrVEhLTmhP?=
 =?utf-8?B?RFJISDN5TnFLa0xodU9WMFdDUnI2NG9YeTAxeHBCV25EeFJpZGxCOERzTDVN?=
 =?utf-8?B?bFp0NWp3Nmt1VTJpZ213V2IySjM3VCtLZ05SV3FFajNXQkQzN2s3MlQrQ2JN?=
 =?utf-8?B?djhFS2kweC9vZnlteUFQSGlJazVPMFlTVjMwTFh3L3lOV2pLazIvTW12U21O?=
 =?utf-8?B?V2hyNm9CNElUWThLTWhZZGVkVW1zM1lDSE1RWDBva3ZZZjQvU05TektYb1Vi?=
 =?utf-8?B?VGM4ODdocWlGak82dVR4dHFZWGdvT1FWN01OV2duMS94YlJCSlV0ZjB3NHdK?=
 =?utf-8?B?MWE3NlNxTlJSK0VpWTVzdldLbjN2b0h0OG1mbzRZSEtzbEVFU1dvTjJYNmNw?=
 =?utf-8?B?c0FVYjIyc1pGSG9tdkp0MnU5b2dTNFp0SitVUk1xYlVhVXV2YmkvbmxZamp5?=
 =?utf-8?B?NDFuYnp5eGU2T2lBOHFKai9FY3JLMm1QczNOSUVHZ1RITlFhTys2eS9tOVdC?=
 =?utf-8?B?amNFWlZpdEE2cnE5eTZkdzd0Z2dITWU2T1VwUDBsZndjR3RpWHBLbThWbjNZ?=
 =?utf-8?B?L2FXMmpuQXg0WlBDMm9WRXZnczBtMWVLSDR3Q3ZiNTNqcnpwM0pqYlZ4dG1x?=
 =?utf-8?B?UFdKaURZVllldGVFejFVWUxSUmVOdmlSQ0Z2T0NwZkRaS2tUV3c1bGVsU1Bl?=
 =?utf-8?B?eU84ZVlJUzNRSnZOR0szamFPaDBuRFZ2UUppY3NpK1pMM3ZBRG0zV1ExR1Qv?=
 =?utf-8?B?Q2ZqMmFJc0dabi9CeXhwZnVWZjlZdE5ZTmJST2RuWnJMbUIrOU1VWHhCRFJF?=
 =?utf-8?B?QU9BendmcmlnZDk4eVVSZnBiQTh2dmVJUktHWDhPTE00UTRNVjh3L2xCQnBN?=
 =?utf-8?B?ZFBSeXZJZjU4VS9yMHBzaHRDb1pjbDhYOXJGRWVQOG9zTXVzaFR1UGtWRitP?=
 =?utf-8?B?NmRWMXZwVTRpSnF4ZlkyOUI5VFdGaHdCcUpGblZKVTBPNExmZ013a0hJVDNv?=
 =?utf-8?B?eW9vYXhZN0JDRzcraWZnM1JRai9aSDRrdjdFMTQrTFh0NDZTc1E0bzN1RlRW?=
 =?utf-8?B?bTI4NC9ueXl4cEFZTkRIV213ZmpPTHlOV0RLOUphbm9lTHY5Z0h0NzIrUTIy?=
 =?utf-8?B?bXlKVWdLNmEvZHIzWWxHS2J6NzN1Q0ZXVDhZYVRHeklPTE94ejRVeXdjdDRw?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 242e0a03-6384-4fb1-1456-08dcdbbf7eb5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 11:04:29.2670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sS1LkCmfO+cuMpRDZddVTtTWyg4UQornSrura6Wuhlhkw6aCZ9JvjlNX65nY5fbPg5DvfHtbUThnbS9JYACMqHlmR7bgMQEdNYTOTGxqbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
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

Hi Rasmus,

On 9/19/24 8:53 AM, Rasmus Villemoes wrote:
> Quentin Schulz <quentin.schulz@cherry.de> writes:
> 
>>>    -	for (i = 1;;i++) {
>>> -		ret = part_get_info(desc, i, &info);
>>> -		if (ret < 0)
>>> -			return ret;
>>> -
>>> -		if (str && !strncmp((const char *)info.name, str, sizeof(info.name)))
>>> -			break;
>>> -#ifdef CONFIG_PARTITION_TYPE_GUID
>>> -		if (!str) {
>>> -			const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
>>> -			efi_guid_t type_guid;
>>> -
>>> -			uuid_str_to_bin(info.type_guid, type_guid.b, UUID_STR_FORMAT_GUID);
>>> -			if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
>>> -				break;
>>> -		}
>>> -#endif
>>> +	if (str) {
>>> +		ret = mmc_env_partition_by_name(desc, str, &info);
>>> +	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {
>>
>> nitpick: it's guaranteed that !str if reaching the else if based on
>> the condition of the above if condition.
> 
> Ah, yes of course. This was just because I tried to translate the
> existing
> 
>    #ifdef CONFIG_PARTITION_TYPE_GUID
>      if (!str)
> 
> logic as closely as possible. I can resend. However, I plan to send some
> followup cleanups and simplifications to env/mmc.c anyway later, but
> didn't want to entangle those with this bugfix, so perhaps it can be
> done as part of that.
> 

It was required with the old implementation because it is not an else if 
condition. It isn't in the new implementation as we'd be now using an 
else if condition there.

If we wanted to be really pedantic, I would suggest to do:

if (str)
    foo();
if (!str && IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
    bar();

to match exactly the same logic as what is being replaced.

But that would cost an extra check which really isn't necessary. I would 
recommend just ditching the !str check.

That's a nitpick, so up to you for a resend.

Cheers,
Quentin
