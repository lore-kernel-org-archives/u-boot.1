Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2D3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 11:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F04887252;
	Tue, 12 Dec 2023 12:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="czZ1beTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 847DE877C4; Tue, 12 Dec 2023 12:56:46 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3744B8718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=No3yzz1feHxqhdW9SpJPzHTDjuM0IMCDqSmJ9ynDl/hk8//rse5B6BxlZksK2+RIdO+yQzGmtKttDNs4oHxPApKDMPdOj+FSKxs8wrFRhstNFJr8Y89a3ZtRHKgh790xV8njYNuTgr/0jH86iszBtlYU5F+i0M8rdAxE8COioUQu9YxmTCT0/DCe/qEA6PolzQ4ysi0Q4sWEuKs350fAGwNLcEZEr1O8glbsPJHY/S6WH9hKc6MopPlXsW72c/Zsy+nkMNEqY3m3Q71TXa9TjuQlsVFwKUi7Ub9ZLAGZbGvvkenk7D+5PFHbW2J/61pBIXe77ao0qOf+lBHRrCHHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQbGKLzECiOscUcSYJ9qLbIx8n9MAtPjkt/wIzvape4=;
 b=dlDulmrbXZ+8JiJqVRkyM8jQVx6TZNMg0QkExC7ifcfpHw3amp261N92DqHUyi6QLhhXZY/1PaiSg80BQVWWOtP62p2mh1fMFPEroBa7fyunGMhAVOdntaGA4VJT/h0wKLjI9PNDte0jKF4vFUvm+UiTc4OB6e0BxQbJ1EcnJimy1s62E8uFg/1jtoZJLkURZTw+SBWBBS1ADggg5nTvS2vVU08x1FPRz0uQfVCDMFxpy6+T308KaQyuVpZvq694GFN084Lr/ERg4q+62/iUWIwg/x0GqBtFmtFKL3z1S7XlDxOs82PelcxDiXD1hDwbGPRNFKNpuih6dNJDc12GnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQbGKLzECiOscUcSYJ9qLbIx8n9MAtPjkt/wIzvape4=;
 b=czZ1beTIWczYeylSSmFtqhByPzix9O2uoXhblFbtadOczgOUsrykaHMOcXlTHMLU9hMj44bpqk4zRtJtdeGgCAtl3Tu+tMxcHu7oQheDnkhhsID+FOZFO0UtNYpXli27xOC2wkEOPjrq868lGsrrop/0ZxGgG1KER9VlOn+ixoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DBBPR08MB10628.eurprd08.prod.outlook.com (2603:10a6:10:52d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 11:56:41 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 11:56:41 +0000
Message-ID: <5f58d016-58d2-4e73-8fb3-503313f91496@weidmueller.com>
Date: Tue, 12 Dec 2023 12:56:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable setexpr command to print cpu-list like
 bitmaps
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
 <4f39df6f-2871-428e-8977-36a89b6cdc7c@gmx.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <4f39df6f-2871-428e-8977-36a89b6cdc7c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DBBPR08MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ce9d24-0384-444d-7bed-08dbfb0967bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4Kk38WBUSvj05O6D142I8GQnoGYUYMiaUefQRRqpv5IZpMaTWSr6ojWIEEdKH3qlXPCGYgPyzWHaH+iotyzeYkKj3s7KhDjVlerkqqnjfVL6nUJv/iL3k5O4hKoUAsm1AyS84TK4RwNi3TRhcIUF6q/sxyKofd9/F8UCoP80q82ebAnCBcaWC/QKUXy2EVjc3HUP++gtX6LGOAJvzYr3+wfvO01M2gesibBLVQAxZCtscCf7mzakW/vhIB9zhSNI6UcJjZNUdG9UY0Uagx3/uv35kayCB4Q7B/72HPexG4WoUAHhqTb11Fa4onkzz/8avgsWy1Mw0WLqvfagQbMOGJQsgJZLEFwd19Mjgf1Xd6oF/goYkvPsH3P0n3+snTmqfYdhmgczThDG1pJr/8iIVda9raMZW6z0y92/OkGGblKBbrOBFGi4dOUsitBinhSCXkC+TDOMSlTSVRvdLyPhI87llBX8LfqT4kOsDdbs5LetCvL+IlGmZBDQ/7t8ZbfLpO1C88kbPdiB/oIhPFY5my6ZXjucYiJ0rf7WImxdIOfIN+gtInFcfdDVoRqzomI2tn1PSxhw+kkd8RJDwlPuIEyCNbsEWR4OHxyOy7IHe51qJwB3H/xS/vB70qS0YxPOwEJkm9vkL4RRkgk6Sv0AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(26005)(2616005)(316002)(6916009)(31696002)(86362001)(36756003)(38100700002)(83380400001)(5660300002)(53546011)(6512007)(6506007)(66556008)(66946007)(8936002)(966005)(8676002)(6486002)(66476007)(54906003)(4326008)(2906002)(478600001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNvcnFLTHNqTG1EWWh3SzloU3pIOWhjNDR4eGpUZ05SMEpsOFV0RzFwUm00?=
 =?utf-8?B?R0hhRmovenpSS2hXMm9TNzlIVU1RMmYvRUs2bWxjazNXcGNpNVJqV2QrUmwy?=
 =?utf-8?B?a0RvUnNpQ0NQVGlqMWUzR3ZPT0NCay93UkozWjAzNXV0ZFQ2V2tyM1gwT0g1?=
 =?utf-8?B?dk13a0VhS2RXcE1BNDNGaW9OZzJ5SnNSZHNsaUFYTmJtdkxHN2pGUjVweS9M?=
 =?utf-8?B?YWpMYzRaRk5DeVU0MnRON1VSTjZnVmdWZXJHeTBaRkJGZVM1ekZKWUFGLy90?=
 =?utf-8?B?b0N1RGI4TDdhNzE1aWl6alhaTzlscURROGswcUg4dGM5L2RZckN3aklBc0Z5?=
 =?utf-8?B?MzF0a3ZReUdiRWg1S3pzRXRtenZOY2FmZkM2TnZ5Ylk4QXJUVVNSeExubm9X?=
 =?utf-8?B?NHV5NGYySUJaTGM1Yk5sYlJOSW4rTkZuSkxrQ0lYSWlHbFRnZTk4QlRhZlEy?=
 =?utf-8?B?OU5yc0NmVUd2L2lLcS9mN2tGS01uUDd3dGQwVlQxUEpEbmFqM1lvN25LUnNV?=
 =?utf-8?B?aXRxTFhNQkxKV29UR1REVTFJTndhWVU0eEc0MmNsY3I5b0RlRDdCVFhiR3VW?=
 =?utf-8?B?bHZqME91c2trRTJhYlRrZVJySHJOVjAzUm5pQXRmdm92c3ZUOXhlMmFRZzVm?=
 =?utf-8?B?ai9IR1RrUFZlQ2ViU2pCK1d2dnBHR2JId29UL0Vnc3ErSjBja3UrS3Z0T2p3?=
 =?utf-8?B?T3RUQ2JTc3JybEhMUE9raGtFd1FjT3JkL3JldXZncDdiaFJMcDhiL04rMmcw?=
 =?utf-8?B?YVg3NFBHaGorUm8xR2NEc2U3T05EYTB5Q3ZSY3VCMVlWR0crSHQyaUVpVnpD?=
 =?utf-8?B?VE4wcU9SbUdWemRDM0owU2xMdmV6Wi9DNHNkS2xwQm90blVjaFRpU3A3N2hq?=
 =?utf-8?B?VEdPbFhFNXVUQTFYbDhXZzdTaHk2amVBWTlYNXlVd0I1TTFTcXZwNUlRVGgy?=
 =?utf-8?B?UTlFYS9DTk1IYzNIT3pncXN1Z1RuYXpXbEpPbU8vdzBKb08wUWtvR0VMYXhQ?=
 =?utf-8?B?MWtMWURUeHN0RWp6Z1JCcm4rQXJ3ODNQSjRTbEpnblhKby90YUR2bVBSVmJX?=
 =?utf-8?B?QXVVaFhLenR5V3UrYXJrZjBEMzJoeklvcFUvenY1eXhIL0NiL0lSUGh1OVI0?=
 =?utf-8?B?Y3Z4Vm45U0R1dHA0cVV6WEdIYVJtU1hPQzlxZWkxU1E1TFh5MHNBRmhDVkw0?=
 =?utf-8?B?ZGlHTmtwakdtMmFvV29QdHhuZ3BjbDcrdk9OMmUrQi9WS0RONDJRWitkdWxM?=
 =?utf-8?B?bmtoRDFpakFxMm00ekorUGphNWk4ZDRTdTNWV1FmVmxwSFZac3BuSkMrZEpr?=
 =?utf-8?B?NXlvS0dOeGxoa3MxbGpJTHVYT25GbmhDcko0aEdOTS82UmhSa3pBYnRTVUdy?=
 =?utf-8?B?dEdFNlFVZmVrcVVENjlnVEJhZVppSGZEcUtwdDlNT0w2am4vL0NqbU5xYjl5?=
 =?utf-8?B?V0V6VnY3V2FVUEJTVm4ySlRrSzhQUGI5Q2ZWMVpwVnVBMDgxWEEzZ3NZK0h5?=
 =?utf-8?B?blFSWlo4YTFYK0hVVXpNZzFpSGVqUjkxcjlZVm42eDhhNkxFeld4clErTWhU?=
 =?utf-8?B?b1dPSzI5djd0Mm1wTFo2MHRIeHovZWZFV1gvNkJwcnF5UzZxeitMeUFqTVdR?=
 =?utf-8?B?aTNrY2w4WU9yUGhOYklwZ2hRQnpRZkRFOG02cnRuRytWZHJFQlkzb0lhNlEz?=
 =?utf-8?B?Sm5iN202SjY3UU82aFU2b2kxWC9laTUveDZ6a3J0TG45cGpqR0VMK0ljeUhT?=
 =?utf-8?B?Yko3SGlqKzVQSDNjM0FEekloZ2h5Vnk4ZDE0Mk0xQitjTko3NXFma3RnVVpD?=
 =?utf-8?B?OS80M2dMaG5YMGVxN0xEQXVvckhrRktXczVYWHcrME5TNUdrYmt5WEE2Z2pI?=
 =?utf-8?B?MVB6MTFmZnZtMyszald0TWJSeUpSQlhmUUh5QTBlelBlR2IvWEpsajRZcVhh?=
 =?utf-8?B?S0ZKZEVTVmFEbWJ1UVhOQVBZL2dvU2lQS1pXNXFmQVVadWxXbWVRRDFXcGhL?=
 =?utf-8?B?YW1PRWJ2ekpCN3NZdEFyKzlKWER1SWMrRE5XWUNVRFQ4OFB4bGYzeUdQUVdl?=
 =?utf-8?B?MUM4WjFIS2wvU3N0dUk0bmNRNXA2QlBJNkhlZmxBSWkwL1R0YjhBM2dmMHJn?=
 =?utf-8?B?WjB4SUk3aTlvckh1b0diU0xhMG1TcXFXRmZPekZPNTE2Yy94QVF2eHVHNm1a?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ce9d24-0384-444d-7bed-08dbfb0967bd
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:56:41.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQ+M+YUoBam7sfHOvA2og/XXIc19pyjfy2XIovQyQ1+RNF9F8L6+dS8S0ULrZCXLTOiQuLoyqeh1fjE+XNO1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10628
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

On 12.12.2023 12:40, Heinrich Schuchardt wrote:
> On 12.12.23 11:13, Heinrich Schuchardt wrote:
>> On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>>
>>> This series enables the 'setexpr' command to print "cpu list"-like
>>> bitmaps based on the printk format specifier [1].
>>>
>>> One use-case is to pass cpu list [2] based kernel parameter like
>>> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
>>> the kernel via a separate firmware variable without exposing the
>>> 'bootargs' variable to directly.
>>>
>>> Example:
>>>
>>> setexpr isolcpu_bootarg=%32pbl $myCPUisolation
>>
>> I applied your patches on top of origin/next but your example simply
>> does not work:
>>
>> => setenv myCPUisolation 123456789abcdef0
>> => setexpr isolcpu_bootarg=%32pbl $myCPUisolation
>> ## Error: illegal character '='in variable name "isolcpu_bootarg=%32pbl"
>>
>> This produces some output:
>>
>> => setexpr a fmt '%32pbl' 64; echo $a
>> 6
>>
>> But the result is completely unexpected. Number arguments in U-Boot are
>> always hexadecimal. So the output should be
>>
>> 2,5-6
> 
> doc/usage/cmd/setexpr.rst
> 
> has an example showing this.
> 
>      => setexpr foo fmt 0x%08x 63
>      => echo $foo
>      0x00000063
>      =>
> 
> You provide a use case for %pbl but not an reason why you want to
> support %pb. If you wanted to use the output in a device-tree
> manipulation the %pb output would have to be big-endian formatted.

I added it to be consistent with the kernel printk. Currently there is 
no use case for it. Shall we remove the %pb or leave it in for consistency?

Best regards
Lukas

> 
> Best regards
> 
> Heinrcih
> 
>>
>>> && env set bootargs "$isolcpu_bootarg"
>>> && bootm
>>>
>>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>>> [2]
>>> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
>>>
>>>
>>> Changes in v2:
>>> - Add bitmap format specifier to documentation
>>>
>>> Lukas Funke (6):
>>>    sandbox: add generic find_next_zero_bit implementation
>>>    linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
>>>    test: cmd: setexptr: Add tests for bitmap string format
>>>    doc: printf() codes: Add bitmap format specifier
>>>    lib: vsprintf: enable '%*pb[l]' format specifier
>>>    cmd: printf: forward '%p' format string specifier
>>>
>>>   arch/sandbox/include/asm/bitops.h | 16 ++++++-
>>>   cmd/printf.c                      | 29 ++++++++++++
>>>   doc/develop/printf.rst            |  6 +++
>>>   include/linux/bitmap.h            |  7 +++
>>>   lib/vsprintf.c                    | 75 +++++++++++++++++++++++++++++++
>>>   test/cmd/setexpr.c                |  9 ++++
>>>   6 files changed, 140 insertions(+), 2 deletions(-)
>>>
>>
> 

