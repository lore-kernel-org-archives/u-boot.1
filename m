Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24026C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 14:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B74F87BFD;
	Tue, 23 Jan 2024 15:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="e0entl4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6478987D24; Tue, 23 Jan 2024 15:48:17 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9391687B51
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 15:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPhq4w6PIwSswHpfq44+ywMBlxQXGtOk3ELBmBeYAPIDqqMRVoWiDfV3rQhP/PsVmIBAWpn3MMVnhkv5WWSZZExnagSwsZ0/1MSSGnDpOAHGdwl2wRkiTsCrvDCZJBieQz3UpHCjjoW8igvts5/W8eep2z6T+H4cShkP7lp9eZwfmKvOYKfJuX4GQ3htupVDHQ7DkZgSpGjncvwxmO4mvdPskW2PHUNropKECHPP/3pJtl3KO/5PPcfkJVd/7DFrcHfwWGU6rtfkU2N2H5vCrlvS2eYfL/AVEtgjp5eoy3RvVqmIzMD7hj47RyF32TpMpTp5oKbgOxmBlJ2CThftYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhqwWsxEaR+4Id1gigmQ+a5kzSZCuKtU6k+LLRiITyM=;
 b=mMnXPVo6PPlahqZ4txMTuQ45PQfpYKegzTLyfxf0bs/L6vrW/9sNJnz8KW2+uGHTCiAVnD/+E8rOaEe56e2uNFAypOsdTWAgiDpGpWfimC68maljp/6VuK69AP4980kexaibNTCMSjDD1n9h/4vNezAbOz4N0Ha9EeCAdE/oIwiABFLKe2jJimVWK0d27tkgwBevQ6rH2CcMdTpPIeDhotpDSYBkAHzYU9pcZuhXRQvzBo+oBM3nkLwytZXW7CsQvgkGuc06oIdi8NkWXC7tJgoGAZBpCa3V82SJsjjXKta52aqcTZu0B75HrPvRUuAv8Fk1jxoZTuAGTonbMQkpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhqwWsxEaR+4Id1gigmQ+a5kzSZCuKtU6k+LLRiITyM=;
 b=e0entl4HbMHqDv7EoemfUYdKEtyVEn7+OooxJaWoG3Ddav+/bt7XSZhrxL8NOlJwfja6ojEqkpuvx9yUbfHj7DyjEltTI88zfzw4rLlxgjJMOSshikMamsH3a/zatXT7vDt4RLgTpqmQ22KHwiNRkMwRtM3YuGR1L0JRcViw15I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PR3PR08MB5849.eurprd08.prod.outlook.com (2603:10a6:102:84::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 14:48:11 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 14:48:11 +0000
Message-ID: <24f06dc6-2cb0-482e-abd7-d6c8196543ff@weidmueller.com>
Date: Tue, 23 Jan 2024 15:48:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] lib: vsprintf: enable '%pbl' format specifier
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
 <20240110091037.392520-8-lukas.funke-oss@weidmueller.com>
 <20240118202243.GF12635@bill-the-cat>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <20240118202243.GF12635@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PR3PR08MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ebe18c-b76d-4a89-3469-08dc1c225268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OhzDU/vqP3d66+FyVneP+hlKUBmhe61QLPuOR9/t+vqda5yp0RzfuAZYzJIeVgtv15BJVGKkyx8MMKayX4xCONUWUOEc11Q7Yb9a7mgIKqRgX19zM9G64B/VFXpVJLhqRAxMJStJPt1NDYV0Vwki4FUyix0FeKWA0inLjU9sBQNFZeQISDTN6Lg15tPerkqCBsRcmgSi7Y5ak9yNgXrWtSFV//cXX4M5M0svBPJu1bKGww8YiV0/JtgTn1zbvUShJUN/zcT5Ehf1wPf3IcPFKRiqCljvcHVhDZwfmO9csxdw+/sp5f041wE8VGvdqcJlXm0KpMCoucm7DX5CbG1qxJAuVNnAY8rdT2iLkpSdtGlFmwbKxNrD3gPD8JTQbFteePQPKf/ME9aw2UipaZUN+2Qq7sQvuIz0YgZDeopm5MJr0RwScEoZrNR56WMcGa9fbEnkAkkjNC+aFD3gi0KwFH2drFvcA0r6VBklYX8YbI4krrLr+0s4v7TAIpFKKdtUHRAD9r4oDVdn8BgHuatjvADq3qp0kAltJEyV4lqMORngfBETKlHJdFisI0iq2WE1n4+O2fC6/svtqZek/t+z5N0XI5fsECnGy/KvBPip9AZrbIURzzYFkjOFRy6yeUDkHzCf1XzBjPliwTNKXcK4wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(6512007)(2616005)(6506007)(53546011)(83380400001)(4326008)(5660300002)(2906002)(8936002)(8676002)(41300700001)(6486002)(478600001)(966005)(66556008)(316002)(66946007)(66476007)(6916009)(54906003)(31686004)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2J6dFNFU0xUZ3Myck56SlZ1OGxLZkQxUlI4QTYrWDNUZjZheTRMNWYzL2t4?=
 =?utf-8?B?Q3k3bTJhVDZ4TVRpVGRJRVVYK0w4MzEzZzVwbFhxY3hjRTFnZW9WTlNESm9L?=
 =?utf-8?B?M0FlOHpJMndIMk5pOU01RXVNc0RQeDdHVWR2V1Y2RWt4bEtCU201Tk5LejJi?=
 =?utf-8?B?K0xnTi9wbWhFclRTRkFPYlF0cGNlVjA3MCs5S2xaV3dMUjBsTWJRV0JpdkVC?=
 =?utf-8?B?bTVyMkdQNEllRlZWVWZJMTNJcEFnb0QzdEhMbjI3TUovZFJEUUE3eG03UzJ4?=
 =?utf-8?B?Z01yZzFKRzBMbG9VVzZZZTVTeURVNTJKNXBIekUveTB6Nk0yaW1FL09PbU4w?=
 =?utf-8?B?aTQyWC9RcktQaE9lMGFNQlNwYmNhaDVXSE16ZlRBWjhvQThIZDVTL1RTWk5y?=
 =?utf-8?B?aGM3ZmdJUVFrZk1vMUV6cExnTzZBaktnQzBwSnhJaS9IcGFiVDYxTXJjRldm?=
 =?utf-8?B?QXk4cDNyZkR2SGg1WmN6eUJrNzBwejlvNVJaQkJpM0Y4TjVVK0tiVGl1RGNn?=
 =?utf-8?B?TnVGeXZsbG1pVmZvR0czY0FiNUtwOEpObVdIMjg2dmlaM0lmZlg2RTdZaVUx?=
 =?utf-8?B?TytjMUpGZnJQbHYzUUZ3VHZNeXgvUkl3aytpL1VYMjNBa0s0a0VxTnhvbFds?=
 =?utf-8?B?ZDM1ZmdBZGVUMWZkN3lUb0VEVk5aYlJaQ05pOUppcG5hU2hrUllBaFFVbjF5?=
 =?utf-8?B?enEwS3pWbGd1YmxMVXNwTUZEYm9PMEkxWTJZdnlEYzNhVWJ3NzRIdEF5MVRN?=
 =?utf-8?B?OUF1czNwbi9QQ0g3ZC91WU1hakNFYUNWNkVqMmtHK3BiaEt6TFZLVk5FYUpH?=
 =?utf-8?B?a3BoT0hwaVcxbUlQUkZ4WkZxaEc5d3NUMkwyc1ZwVUJNeXpiRVdHQ1h4b2ND?=
 =?utf-8?B?VWtrMUJRaXZybzRDSVJqbHhsSCtZUlNXRGpSYnkzQW5QZTMrSGpjZ3pHTC85?=
 =?utf-8?B?bm5WN0c1MmlvdmN4ZU5NZDZNaUNBM3lzakxlc2t6VGJNOXM3Ynk0ekZMWElM?=
 =?utf-8?B?TjVQNEMrYkx4aWsrMUJPeDhyTmdJVmtONHRmRi9BTHhlVE13SEg3RXNoOUFh?=
 =?utf-8?B?NWJmMHBvWlV2YUsxQ1RLaVdYNnJOcU1tUlIwQ1VKV2RxRHl6b0NtcXc2RFBn?=
 =?utf-8?B?VExmbHJrTDBxWXdlUUtyeCs3azYzcVZTZjVxcUpGaXJOWUpmdnh6VVBqcEZQ?=
 =?utf-8?B?VFc1Rnl6TUI4OUJIRzlqdTM5Yll3aUxkUzVnc3RxYTlMb29EZzVRTTlnL1NT?=
 =?utf-8?B?Nm1MQmpPc2ovc2ttQnVJTDRrbmNnSzZGbGJCREpzZ1NMdU5ZNStuaVJ0Z1lE?=
 =?utf-8?B?ZkJRWmRrdmdLdGhZaHVOZmRPS01CcFZ0UmlxakwrcGpDZFdaWWhOeVEwNTdM?=
 =?utf-8?B?TVJjSG52VVpTWkcxNHZHblhkeWJBUUVmTXRuSUFLL1gzZ3BOS3BrTWVoZUlE?=
 =?utf-8?B?V2R1cW1uWXB5ZUNWelJQZVVWS1dxajlLU3RPbE9Ya015eFNsdFRaTjZxTEgz?=
 =?utf-8?B?bVl6Y3RaVXhobnF4NWN0ZmVKUkxWYjJuU1kycldUSTY0WXRUanlNcWRhbEow?=
 =?utf-8?B?NlN3eFlOUktuVnNoNUI3M0FmN1FOS0c0bVI1ZFRWYUx5RzJkRmN1d1Y0WHhW?=
 =?utf-8?B?M3FUd0V2WjMzTkRqL3B0cFhRVXd1a2ZwQ1FpaUhIUmo1RmNBOTIwRllMeTVw?=
 =?utf-8?B?a2E5T0s5eWJxa2wyd2RCSkFONmEyQXpyS25odGF4aHJEOXRoS0JuampEMXpH?=
 =?utf-8?B?TWgyYStZS016a2tiZWxUYkpxMUZiNlowMnpvV2thNkFrMDNlYk9xZ0VaNm5v?=
 =?utf-8?B?QlFZd2d5RFltRkllZzdxWkJURVh6bGcvVG1KVEFaUmxvMGFrRkJGTVE0TTcr?=
 =?utf-8?B?c0RnOXJaUFpIOG1FQ0VCcVpQNFc1Qm5Ya3ZEK0c3ZkhzZSt0N1pIQXBuUlU5?=
 =?utf-8?B?UzlpU2kvNlI4MzJuUFkyR21pblFid0tnaDhzS0g4MHlGYnVLUm1saWdoK0d2?=
 =?utf-8?B?cHFiM2pZODVIbkRXZTd3QjhSK09TdkJ3U2hDZnY2R20wdXJWbVRYbkFhVVlV?=
 =?utf-8?B?NzFUdm5YUnhZV3RHT2JRT0NMakJDUFNWUkxwbFhxV1FscjN1UlZ2dVdTVzNm?=
 =?utf-8?B?dHV4M3FYM0ppTGhtbFZ4dHlBRXBacE5Db24yZGpsVForRkhBNkpqOEZRWWp3?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ebe18c-b76d-4a89-3469-08dc1c225268
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:48:11.7833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RpLn5iw+WhPihcuRFYblqBO0EdTRo0me1t2rj/Oi2jVpDL3xKSWPmxkBtkVn7GGUEJXlmXl4Jce+mFQMbYekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5849
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

Hi Tom,

On 18.01.2024 21:22, Tom Rini wrote:
> On Wed, Jan 10, 2024 at 10:10:33AM +0100, lukas.funke-oss@weidmueller.com wrote:
> 
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> The commit enables vsprintf() to handle the '%pbl' format specifier
>> in order to print bitmaps and its derivatives such as cpumask and
>> nodemask [1]. This can be used to derive kernel boot parameters from
>> bitmaks such as 'isolcpu' or 'nohz_full' [2].
>>
>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>> [2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> 
> This breaks building ARC platforms, and possibly others.  Note that
> tools/buildman/buildman is happy to fetch toolchains for you, and in
> this case it's also just the current kernel.org cross-toolchain. Please
> see https://docs.u-boot.org/en/latest/develop/ci_testing.html about how
> to trigger a CI run prior to sending v4, thanks.
> 

Thanks for the input. I ran the pipeline on github and it failed for 
riscv, m86k, x86_64. The reason is the missing 'find_next_zero_bit()' 
implementation (actually it's faulty on x86_64). What is a good way to 
cope with this problem? My suggestions would be:

- Add a generic 'find_next_zero_bit()'. This would be the
'Linux way' and requires refactoring of the bitops header.
- Add ifdef-macro/kconfig to only enable the format specifier only for 
the supported platforms. This would be the 'quick way'.

What would be your or the maintainers preferred solution?

Best regards
Lukas
