Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE0FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE83846A4;
	Thu, 30 Apr 2026 11:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="BvUBAPE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57963846AD; Thu, 30 Apr 2026 11:01:55 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A82184683
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6cI8xAFmqfDS95+lGrYJctYBH2Y7Emd4gy3/WmqbJhMYUW2UWGACH6j/aLCgTmcgh9mLeNbM/oyKs4t9WO8pHlmqQVN4bFZ9Y/RlKE0S8X2kRUAWlXcHj4LyTczU3RDa/QXV915DcWZjNLmNaIINqwY306cHdyLGBAoX5xvq+9qQDTVdSt7o1vFTOJEk5C1XWMC5PywFuiwl1wYp6+HcK2xRYS4JS0+bp/5NcjYx5n660Qk61pMjtgYOhx/WTs8YHSsuJXtfscWB3uAwuNAJdeP1kppFTzR38NfdzIxwSZYbKFQtFEDUXhW+w6Cavot80r8CUEdWKwhjfOGZvrwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeG4nLkBVpLrNuGiCAAo5yWuDT8xPgWqqteKEQTPTAU=;
 b=a3Q6TwnOX0ojqcAc4aWJz07AMER+ZzFRyEiIGFVcZ3Rh7jLyTAArf2RZzT0Pwke8Kz1shq3MUOnLVu5yP4b7n2+0m/ZqA2z6M0vJR7gnW6wN9x0FT35nrU9i4eqIVJeTG48cYA0hVUd0okQkXw0EWehA4PwuHhkMgd4EnaxlxHwVYX9Cp+Qr19hE+09a/wG8t6ZB5GellSGybrfPXFxOX7Urm+OFaoFPp3vy9T4SD5B4jPo9kjByjTeovaugE+VlNVAgVMgjhaqAV1MBEGFnj/SSIyVyX59pZJG847xlg4JRZ6CIcrqyGkZIeaQXDXnsEjSZgGWI/gH9egmPK8BJ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeG4nLkBVpLrNuGiCAAo5yWuDT8xPgWqqteKEQTPTAU=;
 b=BvUBAPE7nhYG0QWFdlH9MFeDjDYavR1cc9vXGVV+IFVIimf0sKMU1j84bB/9WkmtVfDGy7GacelRimaHQedfhNvtfQWlESBArfcGi7TdIX/qDmmYwFW/5rBLnueMmNBeEOTtW+iYZWC2rjZYfByXkBpymOtDv6Y30bakc2s360CoC+j+JCAd4sgZBaqMzL3tqbr0cIftc7afhZxXway1c64jgKsml2kNKaa1eT+FpDSuj0h2RPSoqfv4p1rb7kvNSqJghM3XGDHvFozuXR8mbVG98reW6ZoT9/Dw7Ow4tfNRwaUvrxMkkTW3ldw8RYmuzSCMn2XSmF5ZVEhSqttHtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GVXPR10MB9609.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2be::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:01:50 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 09:01:50 +0000
Message-ID: <ca01a914-2308-4274-b538-0359ecb29632@siemens.com>
Date: Thu, 30 Apr 2026 11:01:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: ignore ENODEV for boot device hunting
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adam Lackorzynski <adam@l4re.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
References: <20260428133612.669105-1-ludwig.nussel@siemens.com>
 <CAFLszTjT691ZQudD_tJ-Os-pVnsLQjto2QeYv32tS5Us7wLWRA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTjT691ZQudD_tJ-Os-pVnsLQjto2QeYv32tS5Us7wLWRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0335.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::15) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GVXPR10MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: c393e5ad-321e-4cc0-f1ce-08dea6971d98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: vE3Are3NH1uUHz0VZnMW3Woc8o7ecCpix16WURp0FRurtJyYBXHH3aWK9TCxdxxEAFjarw4yuWUYFz/BkZ0PsTmFsLEejQUOMhUqTj0LnA7kw11SyOjrLb4+onygIbPVOr9fYOYiZyqmGDdL4AaYKkstUE60wSNUWUbG73kBpcL6nD6Wyz9jWpAryXMsoo47Ijb7Kx3xgn1N9IKBZaqxbgrwqf8XU190tW4ayQxl9h3DS0fGKj9e/TK3W/GpyPrXuoKc7Qpn0xkPp+l/Gl3McQCdzxZjjrt0lC5G42APmptgBvMtx7POEvmyA+M5tFbwjVtoqH48zYdyZHDGPUEz2MKNzfgvc6pzKJ9/dHX5lGbCkfT0VQc5fLpT8xGMtmRz8X2NWp10Fse90MsDas7xtga9PkRjtaBHG6NGAC1of2RUNHXSCebKCLSGyeqsSMfMTZPOyPgMmcXN+lqGDxQ8s8wVCUJLTkaiV0P4xxjIkJo4hhxs16GMnz/Q/D09kREMKP/4PVjIYzg6gOHRj4HXJ4h/8y4qT/Jb6WsmolTXhm/O15jFyGiNJeiNo3Ei0C1gZqfoOTFoJ/rmS7ezWOO+JhQID+hcj7QFEoiIlVS9zEKad2S1lYkQnUcLwBfUkvYJYsFrPmT+NHKMXbfGxpP9fLTSFMEF3Qeoijz6AH3MPf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2hGcTdJYWNuNHpUd0ZtdzBFcnliQ25VVG9KYWVYV3A2YmNyM0FBa3dnTkd4?=
 =?utf-8?B?NDc3UVdLai9XRXRwY0NQV1JmdktwM2NGd01MdEdBNkl4MjdsMTRkTFZtV0Jp?=
 =?utf-8?B?SWxvS3phU25ieDNOUG9iUFRMQmh3ZWdnOHJKWEdKTThaZkY3MnlUWmNyRExB?=
 =?utf-8?B?K0xxNVRmYzJwSXRXUzhxc0FWL245ZlQwOVppeFNIREFtdFdsbDNscUdsZnNS?=
 =?utf-8?B?TkkzVE5aWXphRXRySzlxN2tHOWdESzkrT2ExeXJraklrS24wN3NoVXVrZTlG?=
 =?utf-8?B?K2NWMzFYazBMRm5vbW5aNS9FTWhzY09FZHd3REw3SG8xUkU0Tk4rM3RNalBV?=
 =?utf-8?B?UFN0SlA2dHQ0cklwT0FHNStqR09nYXZXQUMvaFJKSi84bFNaMTN4YmFXNXJk?=
 =?utf-8?B?VDRzZ3dRcTQwMEI5WGFlT0V0Y1I1V0tMVXhxWUEzOFdJemtwdElhdFdiMFZP?=
 =?utf-8?B?cVZzbVUzQnNzanhHbG53WXptdjhTRlF5SWljNm1KaklIWWxHeUxlMWwwUDI4?=
 =?utf-8?B?MWlSSGNrOHlDZ2lvT0g5ZTZBMEUxUVRkTHVXaVpOTW9NUmdDQlhUOUxrdW5H?=
 =?utf-8?B?aGlaYnZvQjArSklzWUUrV1JwQ1l4VkROZ2VLRE4ycU9CVy83UEF3SDFlMGFL?=
 =?utf-8?B?TytyRDVUd2s0bzFDRDJWYm9lanF5clg2eHJYdXZQYWZOOGdQcW5ka0NEOGVr?=
 =?utf-8?B?dmMwL2lVSTRGVHM1NHg2TUFQTWYrS2hmVzBzWTNqWDlMSUFkbksxTzdIOVEx?=
 =?utf-8?B?akRHMFhaWmlnNjJUY2taRmtBMUx6TnhaUnA4eHcwdjdEUlo3TldtYTEzNm1M?=
 =?utf-8?B?N0RlZDZSbW5wRXZuM3FwMUpmKzdtQWFzdmJqeWJFbjVLR0p6VmM0VFZ2TVM2?=
 =?utf-8?B?WFBuNURLZTl5UUhncVl1UjhRbk14RnowM0RjK3FIa0tINDNpRUhJYzBEYlRV?=
 =?utf-8?B?WmtxQlhHWmhOanBOc3lWZ2JhQlRvMUZMT3BWOXRnLzRGMG9kdTBsYStMR281?=
 =?utf-8?B?K25WdUJLWnhTUmZ1QWxJQ0J1aFl5SllGS3ZkUG44U2xpVVpqMERwU3lvZWpi?=
 =?utf-8?B?Z1hFS1F4eTBNTDdhcXRqT1JRazFUb3FwQjBCVG9NU016QWg5UmJ4aE9QSTdD?=
 =?utf-8?B?ZjFiRWNISFFoOWhrNzA5Y25mNW9Uam9zbFhrMGF0RStaRjdCMmNFbE1VRGZD?=
 =?utf-8?B?QnZhK3MzY3R0YkZMazdnNnpRZnNsTXN1NHExQlF1Q3RqdjRDRlM5ZEtyV1Rz?=
 =?utf-8?B?bEV3QUw5ODdTNXhNY2h6VFE1RUVVMU5jaTdhazc5dlJ0b2RSZGp3MVd3Vkwx?=
 =?utf-8?B?MEFDWS9IMFNETHkwTGwycmF5NkdWYlZCMGZXa2xHMkZnSFpaK0V6K3dVWTdo?=
 =?utf-8?B?cFRpcitrNlF6eHBkL0cydGlkY2dtdE9WSG5QeDlBSEt1aTVMeU1mSytFWjlE?=
 =?utf-8?B?VzgxVkpkaHMyVERyM3FBbGVVZ0ViS1BMVkRLS1FpNk9vWkI3RFl5bS8yTTE5?=
 =?utf-8?B?MVAvdW5ac2lQSFQxa05hNlhrak9zd29rcWFpRk1kTkxHcEtKQWZUTjJJY2FI?=
 =?utf-8?B?Skg2bjE3RlNmcGF6TVFZU3VKclBudjkxcTlBYXlBVjRGMVNkMXAxUTVoZm9T?=
 =?utf-8?B?RS9FWFlmZVo2QXBQdm9sK0hUd2lkZGxCVFZKcGRxMmh0ZEhUVHMyMnpTekZ4?=
 =?utf-8?B?VnFnbUx3ZmhCbmdMU0srVU5kRFdsTzVZc0dGQWtJZ1FHOURmNitreEhqRW5P?=
 =?utf-8?B?SnBybWE4aFluazhDYTNOR2dDY0l4UDJNbU1DV1R0a3JqSzRvQXZQZktOQ2Uz?=
 =?utf-8?B?a0kxN2RKcWM2Znc0T2hNWk1PZSt4ZGcrc3hqMVdxbm56SHY5RmFaelMrVzVG?=
 =?utf-8?B?Sjh6K24wcGVVOHJkL1M0alA0NHRlSkc2ZGJMVVhGNGFpR2ZyUUh6QjhjRGlU?=
 =?utf-8?B?Wld0cGlvWWZFOHBmSW0rdTVRWnpyU3dzL2d4WTd1NGZPdVNiWHFMRXhpbURx?=
 =?utf-8?B?MEZYS2FkdExNTm5WVEk5eW5jcXNVQlBWQk1qOUorS0dvQ09HYUozQkpvRENY?=
 =?utf-8?B?dWc1bkdnRXlFVG9Fb0VEbnRTdkU3VlNFNnJpNjk5M3EzeENaMEdsTndtVjBB?=
 =?utf-8?B?WW1YOE5HRkVNOXhueUZQWHRIQlQwU3MxT2tyd29wdmlobHl2c3FIT3VkeGxP?=
 =?utf-8?B?VUtsZDBDR2w1Ym9IamovKzVNU21ZbUhJaWdPQnkzZnFOWFphb2tRUWdpc2hM?=
 =?utf-8?B?c29HdmhyWlBXUWV1K01WaE9ZQWNPVmtibGdGTlo5TWUxUFRzOWJRVWFub2hQ?=
 =?utf-8?B?Ynh3b0NtOG1XQ2FqRXVRSUQ2ZE16Vkllcnh2Q2hpUVR5ajVJSVpUdU9TQ3Fx?=
 =?utf-8?Q?jMD4jTCEpbk+/P2A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c393e5ad-321e-4cc0-f1ce-08dea6971d98
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:01:50.1941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8ySgkYftWiBdSgs8tiXfA6Pllsm/KTLrejQWE5lgYXjnn/M+iJQX9McNP5NP6sJYKCrZGEkzDjvb1mfxDSSlER1MpBxh6CQNyuf9BaOUcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9609
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

On 4/29/26 16:20, Simon Glass wrote:
> [...]
>> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
>> @@ -382,7 +382,7 @@ static int virtio_bootdev_hunt(struct bootdev_hunter *info, bool show)
>>        ret = uclass_probe_all(UCLASS_VIRTIO);
>> -     if (ret && ret != -ENOENT)
>> +     if (ret && ret != -ENOENT && ret != -ENODEV)
>>                return log_msg_ret('vir', ret);
> 
> I don't think this is the right layer. uclass_probe_all() walks every
> device in the uclass and returns whichever error came back last, so a
> single bogus mmio slot poisons the result for every other working
> virtio device. -ENXIO is also returned from virtio_mmio_probe() for an
> unsupported version and would still bail out here, which is
> inconsistent with what you are trying to achieve.
> 
> As I understand it, the placeholder/empty mmio slots should not be
> reaching probe at all, i.e. the bind step should reject them - or
> virtio_mmio_probe() should keep returning 0 for the 'no device
> present' case (wrong magic, ID 0) and let DM treat that as nothing to
> probe. The unsupported-version case is the only real error.
> 
> Could you take another look at 70101c3217ae and see whether the fix
> belongs there (or in the bind path) instead?

I don't know the first thing about that :) Naively changing the function 
to be called in bind() instead makes u-boot crash. It would be possible 
to change the return value in the probe function to ENOENT instead.
The driver claims to be ported from Linux. In Linux the return value in 
question is ENODEV though.

Maybe it makes sense to make virtio_bootdev_hunt() ignore all errors 
instead?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
