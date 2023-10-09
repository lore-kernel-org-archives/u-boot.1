Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A304E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 10:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33DAE86661;
	Mon,  9 Oct 2023 12:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VVGw3e/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A2B86801; Mon,  9 Oct 2023 12:04:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B377186552
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 12:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696845886; x=1728381886;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=mgDdRzrJowNizQKewCbUfpFOjnBCuKRxCnrsLciY47s=;
 b=VVGw3e/fFRpua1QLvQdgxDfhYDoAcz/60xNpQrQBanWcoW6AESnW5fWK
 uMGR30CR7HTCMQLGrwLS13mUm3qWQjFB+3j0tGA1mMcECisDtYn9c1XQ5
 vD2rP8CRJbQZ+vNcu5UlVpdRRN62AxNFPNVsoFrlKSeHT8HVPkusY5zqp
 6/N/8926UPKfGqNSjQLcakSi5DyjZVBnMfLeRfYU9TjIPKxrgVS8STGsn
 JVAmkrOo9K1RH8hAFpVGgl8hS2PcLcG8eKxIIGNM8Nrapmdt2SrSnN4e3
 PJiCU6R1gw06j0VFmXjjJ86vq7KniZZGyVJb/57nfiTscaKbh6pawzbG1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="381372837"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; d="scan'208";a="381372837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2023 03:04:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="782435577"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; d="scan'208";a="782435577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Oct 2023 03:04:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 03:04:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 03:04:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 03:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmjlhAA/cXvqL5WG9IDUVEhluEEXpcEBUbXyvdcTvsu+O4NzQ6i+dZucGXOnn4TASifUughFEBbZtzaeoy0lNIVjGScIJqP+JYKvtarXVw7mg6V+X32tlta4/10a1oyo3wlFCLKYRXntan0R1IHzh7mI1I5QEOdN2qyHAYdfdfuZo0AsAfLjSOJC9rPfDg0yHLF5WNxKUsYMLq5zpYpb0NeEde1cuS4Fcje9tK+nZqx54yTclR3kZggwl8qP2lwXA/ci3PygR26E4zwyCNf+AQgizhu+MKWQTxjK1cKRGkiNGzBRhrS4BogMlRTY5rQCeDpkas89x3JbSzZsdLFkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN/yo1wmgCUn5cju8gttU1YIsjYo5r9H9cTrUqgvYYE=;
 b=bQQwe4+lq8N8kvxGXs4xaLw8/mUqbdfEwAuhdcptSOGlLuKyzTzDYYIB38+Ug+Nb/lu2B7XCLpMOqwVmrxSlhn2S5tFdi94MWXU2oKu37s4xeTyzmbRa2lO1PTMQ7STmnrq+Xf8Ut/IsV4rh7v83EZtAqEiKI59Efx+5VKZ8boL4AymmJ8e9++KsjWvC3qztUu57QDm4bHLSz8XkCa+dC9b7xaQjT/5XXkkFPsJywYZXiOnAdZWRpm5VccPdWhhQoT0KGVN/fJwhRF1p3YTCz+ITEPySwnfE2Ypi8o5e7ZkMPNvMJx3KjohpUwi0rD4L6k4u/TrvYJe0AoW5YTxEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 10:04:39 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::2283:6ae8:35f:d709]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::2283:6ae8:35f:d709%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 10:04:38 +0000
Message-ID: <0af4c686-2bc5-3fa8-ca98-0ffe4caab3a9@intel.com>
Date: Mon, 9 Oct 2023 18:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rick@andestech.com>,
 <ycliang@andestech.com>, <bmeng.cn@gmail.com>, <sjg@chromium.org>,
 <pali@kernel.org>, <u-boot@lists.denx.de>, <andrei.warkentin@intel.com>,
 <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0069.apcprd02.prod.outlook.com
 (2603:1096:4:54::33) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b7ec65-b0a0-4304-326e-08dbc8af2590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zl1yf8yBYxFyO9hBpnv4SnxnH5jYKJLHwRu4jVoAukvk9P+LfyOOTvhM4xiQImNmeucMI8gAwebD6eLnig3rsz0C0jIiZHD7cGdYkIhlGfEBxcDazJHGLuSgx6z5WKgxqmpMTGF3dZ9nNwdDvnsLjs0xKjdLi3GHRI3NVNNZHs6+BIrS4J7T8btfCnoJMWwW5d12TvNmC6cZqgIfHEU6T4HSCXeWRD9lwnbmGj70eD2uubjCOQ4mJHSqxjArSa5/LvzIV8aVqDgRNti25E8E1tIQO+quT3JgttM73nins17bej+hOAsVbq7wdrFPhtcKQYfdAmvwvEdDzDQBRVnRnwv9jRqGmRvxIJABbMPkgWU1Q9v5sbeZ/Vl61R8LfTDbOfNfrsCqwR6vUgbQ3MwR1QKrOHeds636iUzxQYoApw/wvvAyHphtVfPgt42PzUhF+eWHxHWGxKZIzHWLprGQtMVUmRVEvX+Cd7QREYq06lNvqb/BpahgMN2GlCogCyvTsFZ27Dcs3YUW637CFSo+tRjZdo1RjdeqAP/7Z1tldhb0L6vE5jrIiH4t6ISlAq2w0C0nD4I5k2cj1EXaVTvpDffdg73R6JRvKyXR4p5cLdr9GE8EPzxYAQOMx+QJIXJ37KZzdZPiqYd1Wpg9IFjFAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(2616005)(26005)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(5660300002)(41300700001)(53546011)(6506007)(6666004)(2906002)(6512007)(6486002)(478600001)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRsR2MzN0hoWElXSUhCdk1FRHRobnpLSVRqU0JERXJoRU90NExLK1dEQmJG?=
 =?utf-8?B?YUJjVmtsOHNWWk5WdTdnVUJUVVdDMHdaNFpOdTVNaElwQStaWUZTTnhWejBQ?=
 =?utf-8?B?bzBjdmt5a2I0eEJSdFlIamJONUcwaDAvdkpMT3Z2VVpMYVpRTG1mNm9rUWlY?=
 =?utf-8?B?eDc4UUloRmcwS3I4UXphakJKTjJ2V20vMFVWWk8wWHUwUGZqVTRkMjNBbW9T?=
 =?utf-8?B?UFFrZUlLZVpOeFZPSmhseUJMdEZ2dVJwdFE3dkQ4UmZONGhocitVdUFCVDdC?=
 =?utf-8?B?VGV4TE1nNytzdFpieUpNUWdDajZ6cE9IQ0lkejAyZTVMc0hEN00rR0ZHenUw?=
 =?utf-8?B?cWJVSHFVUEtVSWpQK2lKVjREQmJXSmk2bHUrRis1WjR6MEk2S3IzVndyeGtn?=
 =?utf-8?B?V2xJczlyRGZUd2FJaDJIMmVHclNyajFGcjRjcHJsQk5wY3VoV3pMSTBadWQv?=
 =?utf-8?B?SGowV1QzRHVvUDdTMXk2QnNaUm5UeE82L2o3Uy9UWVovSG5wdDNub2xoQU5r?=
 =?utf-8?B?bzB3YmhHWUorblRKODBVbnJpRXpIRDNTelh1NmNSNTlSelVoQUFBTXNndTIy?=
 =?utf-8?B?OTNDdHlUbmw0ZytNcGNHTlA5UkpuTFExNlozRVJ0OVlwNjYyTkpWQ2NKbnZj?=
 =?utf-8?B?Z2I4ZWgvQXlsa0gwMXVnSEZsYXkxYVhXZGRQMXJGMlhNWnZzZ3lmc0tpQXNx?=
 =?utf-8?B?bW0rRU5sWmNyK0VJOWxoNVBlT1RWdVIxWWdMQUpMTlZqcXQwcy9JN0UwTEV5?=
 =?utf-8?B?VFViNzBHaFI0NjRpQ0ZCYjRHR1d6ZDlaNWRpL29ZdkNyb2NtYjV2NWZ6eGZH?=
 =?utf-8?B?VXhMc0EzR0t5MUtZNDNmWitNMWpkWHRua2RUSUpNRkJYOENNYzVxQzJ2L1dS?=
 =?utf-8?B?Yy9Od0Q1enhBUTRlVS9ieU1DbzBPblVzcG9kK2pmbFpBb1VoMHVzMjBoL09Y?=
 =?utf-8?B?ODhkWUk0TmtKaHlyZmRSSWVDRGxtaEJCbFJHL0t1cC94N1p1Q3dpUkJWakNO?=
 =?utf-8?B?Uk1ub0RXMFpiRm5McnY1dTNnTHJxUzVsRWt0dFhiN3FkSUQ0OFF4emg0aEg1?=
 =?utf-8?B?M1laYm0xdXhDdkJWZFd1Z1dJd3krQ2R4WUh2N21nMExyNlFUcVc1TjIrM0dR?=
 =?utf-8?B?a0RnKytpM2hwUTA0bzBhSVM5aDdqdWl3aE1aZk4xMWF3RXJtbDZYNElHUVdZ?=
 =?utf-8?B?QTlXNmRGSEJLN0JheXQxNkJ4V2M3TXhybTlSaVI3MGZoZUl3Qi9MVC9qc3lt?=
 =?utf-8?B?YUIrNUxDZDcxc3JXUEZXVzd4RG1rVGlMbG4vdHpCWmUxdVg5RXV0Z2ZlS2xo?=
 =?utf-8?B?d0hRZmYxN1kzMzR3dktKZUlMNDJrMi9YV29sWkV0SkE1T3FXbnQ3VEpHQlll?=
 =?utf-8?B?Mmk3QWNkNFBNbXNiMk1heHBvbUdMZm1lekpSYk00b2ovR1QwQmNueVZMbGNU?=
 =?utf-8?B?TTVzODVmMTB2L2xmS29td051b0hCZUxoWms0N1d6NnNzdE1NMkVPanFDNnh3?=
 =?utf-8?B?M2xFbFlGQytPT2dMM2hDRXFMa042RmNmY2Z2YVNOR09yTmtXcXdIanlmNTcz?=
 =?utf-8?B?bzZWTkNSdGJWakZoN05MYnpsa21YbCttVXFhZzNTS21IRGpMaTFTVnJhQ0Va?=
 =?utf-8?B?dFBHT2ZQS3A1NXBmSkNQYUpxTkxmV1czSFFVNktLV0M2NEZmQkV4UE1Bazhv?=
 =?utf-8?B?Nk02ck9jdW82M0RSYkIrL2J5TXFrblhNc0JwN0RicHNBRWVWVzRUZmFTZjI1?=
 =?utf-8?B?eVZqRGxvdThSd0lyUGI5WjNubDIwc0tWRWd6alBQOG9GUVNnVmQ1OVZzUGsz?=
 =?utf-8?B?NVVMZDdxK2J4dElBT0hyS0E3eGZvSmxOWHphZkJOMVkyLzM1a2hEeU1LSjcr?=
 =?utf-8?B?QzdqdVJEN1VwUjA0MEJ3QjFVaEtUMTA1UDN3eTdteDZFSEJzR0xyMC9kRGo2?=
 =?utf-8?B?S0ZudS8xVmVma3NGT1BjQVEvNG5JUFduc0dlTEJ1NWp1cUFadnRaVDFNcmlZ?=
 =?utf-8?B?ZFdIMHd6K2dmVmZ1WjBVRnZ1aHpwd1hMek5YUXcyYVBtYTdpMGVZZnZ4bnlH?=
 =?utf-8?B?OUxTZjd2SUwzUTRNNHptT1J1Qnl2N1dab01jTnRpbUo2d3VLb2Q1bUh5REg3?=
 =?utf-8?Q?ie1G/yx2kS5hlIpqlQo+BO/cO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b7ec65-b0a0-4304-326e-08dbc8af2590
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 10:04:38.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lK0dwbhxg8K3vVLMX8Kq4J+zBnJokT4tZ4bnhjIkk8D9K7JHxr0xlBs+S7ZKJziDjaxA+f+1MySixbGQA577w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
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

On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
> 
> 
> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
> 
> This should move to 7GiB - 1 in your example on riscv64.
> 
>> board_get_usable_ram_top(), but that address is not backed by ram. This
>> patch selects the lowest range instead.
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>> arch/riscv/cpu/generic/dram.c        | 2 +-
>> configs/qemu-riscv64_defconfig       | 2 +-
>> configs/qemu-riscv64_smode_defconfig | 2 +-
>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>> index 44e11bd56c..fb53a57b4e 100644
>> --- a/arch/riscv/cpu/generic/dram.c
>> +++ b/arch/riscv/cpu/generic/dram.c
>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>
>> int dram_init(void)
>> {
>> -	return fdtdec_setup_mem_size_base();
>> +	return fdtdec_setup_mem_size_base_lowest();
> 
> Linaro is working on allowing to download a distro image via https and installing from a RAM disk.
> 
It's okay if we don't do this installation and pcie passthrough together
on risc-v, nothing is changed if there is single-range memory, 1GB is
large enough for other cases.

> We should not artificially reduce the RAM size available for U-Boot by restricting ourselfs to 1 GiB.
> 
> We must ensure that ram top is in the upper range.
> 
You mentioned a generic solution for all architectures in another
thread, it looks not trivial for me with little background on u-boot,
e.g. something is confusing to me, when a board should define
CFG_SYS_SDRAM_BASE, what happens if gd->ram_base != CFG_SYS_SDRAM_BASE,
I'm not sure if you or anyone can help drive this together. btw, the
good part of this patch is that it doesn't change the semantics of
ram_base, and the best choice is the largest range, the upper range
might not.

Thanks,
Fei.

> Best regards
> 
> Heinrich
> 
>> }
>>
>> int dram_init_banksize(void)
>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
>> index 9a8bbef192..aa55317d26 100644
>> --- a/configs/qemu-riscv64_defconfig
>> +++ b/configs/qemu-riscv64_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000
>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
>> index 1d0f021ade..de08a49dab 100644
>> --- a/configs/qemu-riscv64_smode_defconfig
>> +++ b/configs/qemu-riscv64_smode_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000
>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
>> index bb10145e6e..66dc2a1dd9 100644
>> --- a/configs/qemu-riscv64_spl_defconfig
>> +++ b/configs/qemu-riscv64_spl_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000

