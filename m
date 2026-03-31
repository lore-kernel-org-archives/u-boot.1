Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD97109B463
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5194883DA6;
	Tue, 31 Mar 2026 15:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hF4mzGpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F06284010; Tue, 31 Mar 2026 15:05:20 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA77283A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 15:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPAIH2PLsVoe9yp0b11ums2tVPhryfUwpeH2BozJ5iXt/lNnrFWZtoYLpaE9/GvJtWVfT5crQeLQfdpCAed6IulOBgHDPFqHynCJjF0gcnY+lYbAUKUaPe0ZQyUfvNh3fxlawG3sc/E+INsSbkJiHYqXRoS6RwPKWqN9jJx0mJ25tOZoLox/bGj0GDkvj9t+7fneL0WJpyEInwCPnNwe9u5ss49uISUvByUbr2hnIAiYk/7cOG0kZB738U8MvMCthxU9zy6Rlp52SLwyldfYkH/zuY3jfKYW3DTxH+Z3aKSjcgcp1cGWqgMYIQkoRSSIbLk5d6pMsBaDlUx/l0P/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ0Nk2tMFVimC4jZMnbJmPvemFZke98yxh1Fx3Q5Qw4=;
 b=N2bf3icgfg3U1zF/4IPIJLgE0F6DWEpbt2zNHezMhWGK4SbImBArY9C5OZyPg9MP2WB4eh1EkuO6+CRllPSXiy46ej3A6ywLSrJSW5l9A8Q4ov0CcCy2XXoH1BDkSM0RCrRE4rZcGeO5QOtu+IMIRF/dd4v/o11Z7R25c5e8/Bvu+rGhX7r+46GABxbqC5vO+PXcAzApNT/ZkvNMNish4OOJguMZCFsiFMtNhliLYHIHdKpF0epirNkeXPQkyYSckVtin8rA0MOn0cR9KmqITQh/VsglnzeZwYnChLvuQmuC6ZXqIr+qFeY6bK3cXe2Jpc+r/vqZp2OKSf6eCdhlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ0Nk2tMFVimC4jZMnbJmPvemFZke98yxh1Fx3Q5Qw4=;
 b=hF4mzGpCSyjyj6JobVgB95n82Za1AY2OFQCngBp/pKMJuFuxeTEGUGKbAaqIumjeU8zxVZP+lrk0Nq0B/5yqPpTfL9s6OkYrDcJZFkWOWipJop/7mjbSk2/3u9ASLxFNaBxHcstKjXpmV8fuI8yWwJsZpIhDU90R6Us56LXda9xsU0Wd+Io1w1FMgnR18zqOqa+190+Zjo4R514wKR4B8EbzYWfv+3Vb4uDzEDTe5r2Xx8e8paa0Um5taPNReU1RQ6XqYf2dCBrCUCObvfwFxf0ozMyHm9DCrhetmYA65P8mGrkbdEPu6lVygDlAjdsQfHBMpYj+Ua842oo51nzE4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR1P264MB3711.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:143::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 13:05:14 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 13:05:14 +0000
Message-ID: <fdb2027c-c81d-4421-8f7f-13b75e733a45@softathome.com>
Date: Tue, 31 Mar 2026 15:05:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] drivers: crypto: add software ecdsa support
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-5-philippe.reynes@softathome.com>
 <CAMDkj5xpnbA0m4XHZhxMeVRr8OvidUmJST8aAUSfR1bArnYn8A@mail.gmail.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <CAMDkj5xpnbA0m4XHZhxMeVRr8OvidUmJST8aAUSfR1bArnYn8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0161.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::18) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR1P264MB3711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa533c1-8b47-4132-859a-08de8f2625a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gQZlNihzatBGJheJS1qQHi0Ej+Yid1nMt6F/6SPS+WuhOqBp5ggqyDLmoXqB7nJxBkM+K5v+JktddmDCe9Z2f4Bp/C7ut+Wk9I47la67kHQ5HOKm6Sv3Q2xeJcsr4+qnPrvcoBi9kjmXex1iKEbjcLwJtzXT6X3prV9bWVPkA3KZe0MJ5e+LYWtstOj3yIBQg/H0tq2bDOHPgaqb9hRI0Jn0OEozgL+fChz+qnEcYsA9P1s9rUIdDF1Bh+7Hy4hglQzBJfD4k0je5iSp9mTywP8XCfsmRNw/OklRkBGYHL9MIkgDa4QJnnbRCv2ZcmIPOLZCqLEr0H4z3pT6td+MiDHMnSxPWu0wCtFMwEVHH0zq4mjWqsO1BZRUiJbUzyjQybkxtOMiEAr6+UbBIyPYA44ne6AQzJx3yXgU7gmjRHlFuvy/1sT+5Mh9PO713OjprjswvMMDJbzMdea/SUdiufkN0v4tR6Raq8fGQSwqYJ1BaeDJPxCKu9ApjdZKq0Bw5GCbz5taFqLyx99z3p+y12TEoKskWvpsidbXH3+79CQDr1S8T7Z6hHdvIfuzBAW0B0FTvK+TEx0+o0XLPP/nDXQL1wAdlJ4QeLcEFgmRd+/7EmKNQBIeRA6E0J4RuPQdk7+rMU/x5bNW/tzjIHPMHZJ6xHBpN1SfsE6BQU5xiVlVrGYBV02HLW3blYf5Rjqx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ZEb0xmNytKSDdENWpmMXowQjd5UWtVWGJxalg0d085b20yRnFSZHBZTU9K?=
 =?utf-8?B?SXhyWGhVNGZnR1VkRE5UN0dkYlNZNGsrd0NkUXM3QUxQNXFFajFjMjRjRnNk?=
 =?utf-8?B?OXgvdUNWU2c1N1JqLzBEOVBCRklKVjFpc0UwRTYybzYwWWMrS3UvQzV4ZFor?=
 =?utf-8?B?a3VRVVQ4eFVCeVd1UGJCTjRvU3o3OVM0bC9pVEEyZVhUTnB5TGNyOUxYQzFy?=
 =?utf-8?B?YmNpelE5MmY5RG96Q1FzeGppV09Ua1VKVGJXeFBKY3V2TGxoRU1QeHgvQXZL?=
 =?utf-8?B?ZDNuSmdXOEUzRyt1TzRxQWZrbVAyVWd5QlRNNEhsbW1OY1Z0WGZTb2ZCQnJh?=
 =?utf-8?B?cUdkUU9Oa21taitMWm5BS0NhTzJLVTY3Y2dXVXlNNk5wN1BMTVdJM1NCRU5G?=
 =?utf-8?B?L1V4M1lDQWdDeFBoUitlT25jNUF3M3pJaUpDSVZRYlN6Ui9qSVZLVGhFRlVD?=
 =?utf-8?B?bXkvRXd4dFFITHBMbmdZZ0Y1d2VhTkJYWnVzUm5icUVidzcrY05ZKzZOOTdW?=
 =?utf-8?B?WjJCb0FhRWpWTUhsdVQ5SU00bzU2bDczUkRiQk5oVGlJa2tlcEZWb1JwY0Zj?=
 =?utf-8?B?UVhDU3Fab21zWVhYUmRVNisxc0gwSmU1MTZibXZ5VlM5M3F3d3lxR2JCeUgw?=
 =?utf-8?B?Q29aSlZTeU1nUzk4SEtOa2tpWVIvZ05iOTFtTE1XMTBodjk2azgybUFodFA2?=
 =?utf-8?B?ZXBSOWNrY25zanFaSWRlWW9ZME1pU0J0UnRJR1psc0hiTU0rWlhHRlpQMDJp?=
 =?utf-8?B?elpiWGtIVHQwcHBySUQwbVdISXVMNzllWHArTzQwOW9mU0FJRFAvSmhCS0Q5?=
 =?utf-8?B?R2U0dXErREtnTGFLbFVCK1hUOVB5Vm1kQWx4UmJvdEhUM2Q4a2lEaCtkeUFB?=
 =?utf-8?B?YmU4TXBmWjNzWXRDSDBzbmgrNm9pYmIxSmtqcEtSQzl3VmxwYzhGRnczVUdB?=
 =?utf-8?B?NFVIV1dubHVhNnlOeGJ6clpYc056N0R2bjRVSTBuV2ZTOUNNajZjb2lYSkpX?=
 =?utf-8?B?YmQzMDhFejZkY3VWVXBwdFpXOFRnek1vUVlCNUplUlRXRHZVWmY5aWlxd2lN?=
 =?utf-8?B?MnAvY08xVlFLSmt0blBKendTclprSWpKRGJDUlorMGxTRnNIV0ZWZ20ramIv?=
 =?utf-8?B?QVo4ME0rK1F6enA2Qk1NSmdwNDhZTHpuU0IvWnlmQ0RwNFJoOWl3NGlacGJK?=
 =?utf-8?B?VlVFUWZlbk5kMGhRT2svczVScUNEeXFaZ1NSYS9raVdSeVZGVWVpbVl6Qi81?=
 =?utf-8?B?aUozMTd6bUMrcGZIOURNOVRsNk5XQjdMNGRIaE93YUdGWHcyTzhsV0drZHdR?=
 =?utf-8?B?S1pWdndPaVArVVRRY05ELzV2alo4M0NJaUFQSFhtVW5CZzhQWmNndlJ6MFUv?=
 =?utf-8?B?dUhnQVZGcU5xc2FEeDFEREFoSGlWUVNNYkRYVFIySkU1WlRyWThObzczbmJj?=
 =?utf-8?B?Rk5VdjViWWVRVjBESkxBenpObTRJelROSlorUDd0Z0NGU2Z4R0NXSE1YdW12?=
 =?utf-8?B?YTlkekRablRSS0FxbitzS2lXVU80STUrdVNmTVZMNHNFRHB1UlBLSHp3ZUEx?=
 =?utf-8?B?Wis4S01ja3NUY25uTVlHbGI1SkxFQ25pYWNTSG96elBqRzJQOUxXSmRUdDU2?=
 =?utf-8?B?bExhYnNkZS9xM0xteTY5RnB3MGpWNmYvR1Z0aVVHSmZoQ3FVNS9HQWp0dytS?=
 =?utf-8?B?UGNSOGZldTZ6UDhEb0dRdUgzRlJ0THR6R2hwTWpZSXVtNTR1eUl5SENycnlL?=
 =?utf-8?B?WDBKNitqQVkxRVdmWVUyeUxERnhHbk51eXg1U1BiZGhrUDE5M0FYc0E2OG9N?=
 =?utf-8?B?ZWNHOWFQSE5uVCtTSDk3NmRsYXNpcEN5ejhjVjZIclJVMndrY1VObEEwVHNB?=
 =?utf-8?B?UVh5dFZFemF1Sm1maENRTHIxYjN4UXZUYlNKRlV2ck02Z1lsL2dKVk0xVG53?=
 =?utf-8?B?RnR4N1dKUWR3K25qMVROZHRHSFFTS1ZqS0R6MjhGNFJLOFhhYlpLWVpjOW9m?=
 =?utf-8?B?emRmeWc5YkVKRFVlYnhXZWFZaEplR04zdHcxN0wvWVNWcXlCTGtxM25tM2Rv?=
 =?utf-8?B?clRyU2ZhUFBYNWVuTGpEdmNSVC9GL2grUGZuZWlFZW56dG1oWGxraE1EdjZJ?=
 =?utf-8?B?R3ZIbFA3Z0tJR0R0dlZ6RDUxL2RGUFpzL3NkR1MrcU1FVlROWHUva2ZtVGF2?=
 =?utf-8?B?K01WaXlUK05LKzc5ZU9MSkNwS0Z3U0M4eTN2QWVieVRrTVNkZmpFRXROOGd2?=
 =?utf-8?B?c005SzFUR1RESWFTejZYL3FISGgvN0pTWXJ5MGs0bkdTWlNzcGpMOFN2cEM4?=
 =?utf-8?B?ZDhmell2SDVvSnA1SG0vaU1IVDJRc2dkYUNNRm5CVVVEQ01ZZjNHOFlMVW5R?=
 =?utf-8?Q?+g4wYDUB2N5ljAJ2yHMWP+vEtcJcInUXl9d9ZdeU/Isej?=
X-MS-Exchange-AntiSpam-MessageData-1: 1Nh9baFlmhGSyggCIhR1cEhIEr9uB+dRpx4=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa533c1-8b47-4132-859a-08de8f2625a2
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:05:14.0046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9j8lJb8QM2+GGEOdgikiZEna8Yoho9I8Yw3Uv0n5B/oVd3dJXbWyS9ESwVL3faScI2cgLsNMOBuqpc/tHJXyXyuTyzohSAKDk8+mpv1VTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3711
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

Hi Raymond,


Le 20/02/2026 à 17:40, Raymond Mao a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> On Thu, Feb 19, 2026 at 8:26 AM Philippe Reynes
> <philippe.reynes@softathome.com> wrote:
>> Add an software ecdsa driver so it is
>> now possible to use ecdsa signature on
>> board without ecdsa hardware support.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> ---
>> v2:
>> - no change
>>
>>   drivers/crypto/Kconfig          |  2 ++
>>   drivers/crypto/Makefile         |  1 +
>>   drivers/crypto/ecdsa/Kconfig    |  6 ++++++
>>   drivers/crypto/ecdsa/Makefile   |  6 ++++++
>>   drivers/crypto/ecdsa/ecdsa-sw.c | 33 +++++++++++++++++++++++++++++++++
>>   5 files changed, 48 insertions(+)
>>   create mode 100644 drivers/crypto/ecdsa/Kconfig
>>   create mode 100644 drivers/crypto/ecdsa/Makefile
>>   create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>>
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index 0d58e3910fe..cf49e5c0f7e 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -12,4 +12,6 @@ source "drivers/crypto/nuvoton/Kconfig"
>>
>>   source "drivers/crypto/tegra/Kconfig"
>>
>> +source "drivers/crypto/ecdsa/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
>> index e4a4482b7f3..8170e4cae9c 100644
>> --- a/drivers/crypto/Makefile
>> +++ b/drivers/crypto/Makefile
>> @@ -4,6 +4,7 @@
>>   #      http://www.samsung.com/
>>
>>   obj-$(CONFIG_EXYNOS_ACE_SHA)   += ace_sha.o
>> +obj-$(CONFIG_ECDSA) += ecdsa/
>>   obj-y += aes/
>>   obj-y += rsa_mod_exp/
>>   obj-y += fsl/
>> diff --git a/drivers/crypto/ecdsa/Kconfig b/drivers/crypto/ecdsa/Kconfig
>> new file mode 100644
>> index 00000000000..308824d8421
>> --- /dev/null
>> +++ b/drivers/crypto/ecdsa/Kconfig
>> @@ -0,0 +1,6 @@
>> +config ECDSA_SW
>> +       bool "Enable driver for ECDSA in software"
>> +       depends on ECDSA_MBEDTLS
>> +       help
>> +         Enable driver for ECDSA operations in software. Currently
>> +         it supports multiple ECDSA algorithm.
>
> Same comments as I placed in your patch [0/9], ECDSA_SW is not
> required and can be replaced by ECDSA_MBEDTLS.
I have discovered that this driver should also depend on ECDSA_VERIFY.
Otherwise we may define a driver (defined in this file) without a device 
(defined in lib/ecdsa/ecdsa-verify.c),
and that leads to a crash à boot.
So I have kept this config in v3.

>
> Regards,
> Raymond
Regards,
Philippe

>
>> diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
>> new file mode 100644
>> index 00000000000..8f9e5a767f8
>> --- /dev/null
>> +++ b/drivers/crypto/ecdsa/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
>> +#
>> +
>> +obj-$(CONFIG_ECDSA_SW) += ecdsa-sw.o
>> diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
>> new file mode 100644
>> index 00000000000..0d526371ecb
>> --- /dev/null
>> +++ b/drivers/crypto/ecdsa/ecdsa-sw.c
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
>> + */
>> +#include <dm/device.h>
>> +#include <linux/types.h>
>> +#include <u-boot/ecdsa.h>
>> +#include <crypto/ecdsa-uclass.h>
>> +#include <dm/platdata.h>
>> +#include <crypto/internal/sw_ecdsa.h>
>> +
>> +static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
>> +                              const struct ecdsa_public_key *pubkey,
>> +                              const void *hash, size_t hash_len,
>> +                              const void *signature, size_t sig_len)
>> +{
>> +       return sw_ecdsa_verify(pubkey, hash, hash_len, signature, sig_len);
>> +}
>> +
>> +static const struct ecdsa_ops sw_ecdsa_ops = {
>> +       .verify = ops_sw_ecdsa_verify,
>> +};
>> +
>> +U_BOOT_DRIVER(sw_ecdsa) = {
>> +       .name   = "sw_ecdsa",
>> +       .id     = UCLASS_ECDSA,
>> +       .ops    = &sw_ecdsa_ops,
>> +       .flags  = DM_FLAG_PRE_RELOC,
>> +};
>> +
>> +U_BOOT_DRVINFO(sw_ecdsa) = {
>> +       .name = "sw_ecdsa",
>> +};
>> --
>> 2.43.0
>>
