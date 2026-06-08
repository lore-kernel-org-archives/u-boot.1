Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D88CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 812FC846B1;
	Mon,  8 Jun 2026 16:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IH5FkYME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138D484704; Mon,  8 Jun 2026 16:22:50 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0253B846A7
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPWWOg4RJuMi4E+3VnAzN7s70tgPRF6XZYJdrf9B3GpV0w96ET1Fta8h7yJPbCkVjoNevCRBYL/nHjILe4qb3u72s/P3KuJc+kgmk5BibFrWqVjNWWiaSFKb7y2++bveMzshbh7OcTUuJUXtDw27Vd/uMezLRtHc9t261OV0LbsiahEpJN/5SqzX4Tf/SndBtqZAzGMUWpgiqepNqsw84YgBzz8grrOvOvlyrW9QtMCi4cEUQ+M4XUqO8FfmqFtPOuj+JtIaM9+4924zm/8CXWNYS1hn9gUWlAmuQll5ZZCAst7JEG2u+lCYfSil949V2twz9w7SYzWUMGma7SlFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvQT0kAuJdINoo09ATUm2yIyQZxfcNiRzKZQ2aycijo=;
 b=GaPTJy+Zt13/N/2ZDIfhV8HlpRtpkv5uQ9sY8JyncqixnUAd2nbzVrecAn1waoIj/kiwvx2lnXb0m5CKp69cOAjWv9zHnL9RIlDcfy1kINDW3KOOIOUBrl9HrojDAaQUosOLVnVMMDlRtCyD+Fe1gwLFZvZEZq+MeHzRam7CHWKfxe/sLTtcc07n24vvsfRzwI2+mSugWcb+ISuvlGnqJ/xBekwmj7HYN4EiViBdmZbWXZh4s+mJTAfB6AU6zAz882yU4QyhR9g3637ih/zfOf8S5EBlwvoqo9g7RCDqgNLXdF11CYKJ5CWVnheToU2u24O4+5i7JVaxvo38d6ZQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvQT0kAuJdINoo09ATUm2yIyQZxfcNiRzKZQ2aycijo=;
 b=IH5FkYMEpG/hoJ+NAVuid0/QXbhyfJMw7J49RwReoOmypVpey1EZ+5aHKix/Njec6WbulVNnKzh28dYGlrsbhMyM5A1rpjl3y/6iqnkY/TKB3WBf8kgD2vY08PERazPnppNoopGGItueVHm+OD3IDmjkkmuWoi3p5cOu4BK6tdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU0PR04MB9696.eurprd04.prod.outlook.com (2603:10a6:10:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 14:22:44 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Mon, 8 Jun 2026
 14:22:42 +0000
Message-ID: <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
Date: Mon, 8 Jun 2026 16:22:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Tom Rini <trini@konsulko.com>
Cc: Daniel Palmer <daniel@thingy.jp>, sjg@chromium.org, u-boot@lists.denx.de
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260608140454.GH382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU0PR04MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cce1a7c-9f5e-4c19-37cf-08dec56966ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 6pjDtzDqetKiU/AK2TDkwQsVlE8fNKZBhEPapw3Ltq4YUrnB1iYGydFgalsZKskk42uERZhemHbfR24ISBhJOjKaafud9hzA9Yf/n78UOtNbgfNccWXCbVCA011bit27fj1S83b2T5xgE12dsF/e1FYJfYmyieN+s3LunIuefWytqgsvp/QSYCZCKI/vRD5OKDIw5b8a8rO40iAB6UBH42uiJHJZZbyZEmCjvlA1yD0wmrH4DvahzFluTrvPASqBBKN0OXGTOXyg6NOSVtIZDvKvSPdDUOA1aM61jOv9rXe54qZInY2HiS7Z6X1hLo+7WyOq1FUm1ucpViAJiN0IjV0z6oUq5vc5LcdZItRGWLiTL0PfN4EOpYj0smAsgZfaNHSc9h6bezB1/6Nr3O6Fb6D2yxE1ww/23gdFrifD6D9p9yNg/G9MULZIxBDG6E3hzlQC2cYL9bV6GqTO2fTcC3A6XF1tUDNRiCyjFGHketeR0uzHCtkmCRIFYwWlx2NZ/NqGd4W9ssefw1ZrrE+keJPvb8nP89gs801GQBk+PDRUR1Zl/BFGJXnjVBanZ253h7+l4tESZ+PnVdHMyTlvk+bRPWd7VLw5/LspB2jwZ5q3WHtHzIfYqM+0rGtXtaJUqQsaxrW/oWet3JKdRyEorW41coWImekbW9PYYFDROGdTDGbfh2EzsYvcyMtlV1ZO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTMzaVBZY0tEZjJwRWpqUlpDVHI2SE94R3BoTml1cWpZakx4NGlJdThPUVlR?=
 =?utf-8?B?MTdCZ1RsWit1R0RRYlNlTG55Tm1SWTNQeld5SWVxRFp4MzEyVEJmQTdpeS9x?=
 =?utf-8?B?R2hZVkJJYStRS0t2R1VGZEpYc2hVZmJGSmE3VWVSL2FOeFdmQ3k5RitlSk0x?=
 =?utf-8?B?NG9LYmlQQklUYjluekoxT0FncEdlRy8rU2hPTHA3U2FveERwVDJpN1Vna2NM?=
 =?utf-8?B?d1doOEZ6MGhFOWdqdVA0TUVaVm5HS3dKNTZ6VnZKME93aDBVY25ReFM1WU81?=
 =?utf-8?B?ZmdlWkZteld4Lyt5TGg5RTlHSHk2dk1wQ3R0em50NTZSUU44MFBYMktZd09h?=
 =?utf-8?B?VnNwSTRrYzJyNmYvVTdKQ0E1a09qOUtSamhQa3NHK1pZZCsrQUppaG10Rkpk?=
 =?utf-8?B?aHR3WWlCcVQzS0JITXZueGdzcXJYV1RXNWdZZW93bWR6SEI1SmFqVVNUMFhU?=
 =?utf-8?B?TlFTWDhzMVNvVnUyNlRZNWhoMFBEUXJsTFFGMnJuRTkyeVpLVms1cWxRK0xS?=
 =?utf-8?B?ak1mclhmeGdTNndFV2RhcUpzQWhtbGZQbm9ISlJ2QmlMZlU0ejFKQ2pyb3ZS?=
 =?utf-8?B?NDRJWkFreEMvdG9LYk1RTkcrV0FSYjJvNUdvWC9taHFmUzhnSnZVMmU2eXhu?=
 =?utf-8?B?Snl5ai91bzVVUlJuRngrRC9nYVlXSnRZa1lEWGVmRmxwWldKYXdYRlA2dDFV?=
 =?utf-8?B?ckVNMmFOZjM1Y3F5WklHVG4rdWw2bWZyUmJwZ3J6dkpFS0ZTTGFJUmVoOUhw?=
 =?utf-8?B?WmZvbStpaDhFQXRsck5BcTlhVEFtelRLOStnYmdycmxoanhuZVVURk9LQ3lB?=
 =?utf-8?B?K2ZXU3VBV0gydHBOMTdkTW9aQXlsWUlYbjBOc3lNYlZJbjFCMnpHMjhaSXkw?=
 =?utf-8?B?cXFuM3ZMTXYxMW5MT05JK3d3Y0svUGVvdmRTWmZMNlRqK3lLaXJpSEtpLzdt?=
 =?utf-8?B?aHlTSHdMZTluMEw3ZkpHY21ldDhPWnFIY0FrR2pTUFhQV1UxdHo5Q3NJbW5o?=
 =?utf-8?B?VzdpdHY0T1FOWE53RHJVb1NXRlFxdG9ReDh4d2NMOEZldEszenM0cmFkWHgx?=
 =?utf-8?B?TVRkY3lvQTJNd2FuSnZ6QWJFVDBmamVMdFpMV2ZyeE9LbHkrNWNqVmFveU95?=
 =?utf-8?B?OXFkbjZmeHFlT0h6QWthMmJDeWtET052dmFSQTAxNUNZUWZmZUVraHUzSlhp?=
 =?utf-8?B?VVdpMUVINEt1TGdjN05jNkswS1VHSXdwTVZKaE8yQUJiZXlLSGZjZnJsNGNV?=
 =?utf-8?B?bzhrQm9OQ3hWWGk3NmJRWEFTMGxwODUreFBaUzlWWndoYnFhWEdoNUgvY3Vr?=
 =?utf-8?B?ZUIxVFdYd0NCMFBObllEbHpEeUxRYzFXVFcwSnVrbnZyNHIyYk9OSVZtN3lp?=
 =?utf-8?B?YkYzMUYvcUY5SmVpdmlwdFpROXQ0QS85QXFscGNJY2Fnb3NQWVpCaC8rTXJD?=
 =?utf-8?B?alM0TlFTcWhjMmtKQVVVK2pTVDdmdXZic3MveUNvWENwZ0I1ZnZzdTl5KzhL?=
 =?utf-8?B?dDNGeGZhZWxLT2JGRHFUTW43NGxodkxxWHB1MGlYWlBaWTlhMHVTaVZUOWxk?=
 =?utf-8?B?NXNabWtXeE1kMHpOMWg2ODVpbGlRRE5aMStuL3NUeUF6LzYxUlZhQVpoZlZq?=
 =?utf-8?B?dzF2UDJsYytGQ0pzZzUwSVhOWUVyS0hzMW5jVkpRY3lPVkNqMzlqNnVqV2Zr?=
 =?utf-8?B?Uis3dFlpQUtaUi9Zb09VaGJHNXJsOU1pYVRyUjVOQjBkVllyc25yU21GeGph?=
 =?utf-8?B?NjNkMVVUclJQVlFWY2IvZldTNnJOME9DeDZXUllGZkxrYlZueTNHamhuRElB?=
 =?utf-8?B?VUJaTFJQOG82Sy9KdWJITm1VTTFoZjV5ZlBtekd1NHlUNGhyaHNsV1hIbjN6?=
 =?utf-8?B?UndJYlc5aFpOV2d0ejlsTWdJZjJHREY5eG5kMkZUTXcwTHpZOG1ISlpoU2o5?=
 =?utf-8?B?SVJxVFVDVHMxWVM4UTE0R1ZockErYWZqN0Rxa0VCdFdHWFI5bGp1bUpLeDJQ?=
 =?utf-8?B?WFZEVHNjSDVhcDF4QkNEbG5HY3lLZUJXYjAweVJxc2ZiUWNjYVlWampKZzhk?=
 =?utf-8?B?elFnazhjQ09VdWhZbC9Oc0hqb01pQjRsZDhiblJjdlpzVndBYnVibVJoNE8z?=
 =?utf-8?B?aXlMN2d4Mnh4bC9aVTFISmYvRWVTMnE5ZVBKNkEvVnpJYjRSdVg2YVR4Z0NX?=
 =?utf-8?B?d2hqNHdHRzlnM1ZteEVhNlFwRUlGcVZkZHVQVFc5ZnptaG1BWEJuU2FTdzN2?=
 =?utf-8?B?TEtraytkYTNLdTlibFMzVmdwcTV5eHhwbmZlcmw2TmJjOVVSNjhKRlRLSkkr?=
 =?utf-8?B?VklhbjQydEUvbngrVXFVZlBGSXVod001RVJQc0xtbFFmaXpjVnR5UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cce1a7c-9f5e-4c19-37cf-08dec56966ed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:22:42.3747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRs67I8rLgEePTV1DGwqrmyvusLwtCt3qlzNYHA5MAv3g2ZL78MPbXkAFo4Q+co8qrB0hpasxcPdJy/Kz7nA7EplALyuqgxKAk1q0dMCe0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9696
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



On 6/8/26 4:04 PM, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 03:59:11PM +0200, Quentin Schulz wrote:
>> Hi Daniel,
>>
>> On 6/8/26 3:06 PM, Daniel Palmer wrote:
>>> - CONFIG_LOADB causes the xyzModem code to get built and that code depends
>>>     on CONFIG_CRC16. If you don't have something else that selects CONFIG_CRC16
>>>     you can unselect it and then the final link will fail:
>>>
>>>     LD      u-boot
>>> /usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzModem_get_hdr':
>>> u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined reference to `crc16_ccitt'
>>>
>>> - Add CONFIG_YMODEM_SUPPORT, make that select CONFIG_CRC16 and make
>>>     CONFIG_LOADB select CONFIG_YMODEM_SUPPORT.
>>>
>>> - SPL/TPL already have Kconfig symbols for ymodem support but the spl
>>>     ymodem code has issues building in the TPL phase and doesn't seem to
>>>     be used:
>>>
>>> /usr/bin/aarch64-linux-gnu-ld.bfd: common/spl/spl_ymodem.o: in function `spl_ymodem_load_image':
>>> u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): undefined reference to `spl_load_simple_fit'
>>> u-boot/common/spl/spl_ymodem.c:138:(.text.spl_ymodem_load_image+0xdc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `spl_load_simple_fit'
>>> make[1]: *** [scripts/Makefile.xpl:546: tpl/u-boot-tpl] Error 1
>>>
>>> - Remove the ymodem symbol entirely for TPL.
>>>
>>> - Select CONFIG_SPL_CRC16 for SPL.
>>>
>>> - Finally, since everyone is now using the ymodem support symbols remove
>>>     the special rule for loadb in the makefile.
>>>
>>
>> When you need to list what you're doing in a commit log, it usually means
>> you should be splitting the content into multiple separate patches (in a
>> single series is usually fine/recommended).
>>
>> What I could identify (slightly reworked, which better match how *I* would
>> write the patches):
>>
>> - changes made to common/spl/Kconfig.tpl with the justification given above,

And I also see a mention of CONFIG_TPL_YMODEM_SUPPORT=y in 
doc/usage/spl_boot.rst that would need removal

>> - adding the missing CRC16 dependency to CMD_LOADB,
>> - adding missing SPL_CRC16 dependency to SPL_YMODEM_SUPPORT (possibly
>> squashed with the CMD_LOADB+CRC16 patch above, I'm undecided on what's best
>> here),
>> - create new YMODEM_SUPPORT symbol and migrate CMD_LOADB + common/Makefile
>> to use that,
>>
>> This makes it clearer what the purpose of each individual commit is:
>> - remove dead code
>> - fix existing support for CMD_LOADB,
>> - fix existing support for SPL_YMODEM_SUPPORT,
>> - quality of life improvement by migrating the CRC16 dependency from
>> CMD_LOADB into a new symbol + making use of that new symbol in
>> common/Makefile instead of "hardlinking" CMD_LOADB with building xyzModem.o
>> (which is quite honestly confusing, so good to see this fixed!),
>>
>> What do you think?
>>
>>> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>>> ---
>>>
>>> v2: Fix the SPL/TPL stuff as brought up by Tom. This opened a can of
>>>       worms when I tested if the TPL builds or not so I decided to just
>>>       remove the TPL ymodem stuff. It didn't seem to be used in any
>>>       defconfig and there isn't a CONFIG_TPL_CRC16 to enable the needed
>>>       crc16 code anyhow so maybe it hasn't been used for a while?
>>>
>>>    cmd/Kconfig            |  1 +
>>>    common/Kconfig         |  4 ++++
>>>    common/Makefile        |  1 -
>>>    common/spl/Kconfig     |  1 +
>>>    common/spl/Kconfig.tpl | 11 +----------
>>>    5 files changed, 7 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index c71c6824a196..503fc51f6bb4 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -1412,6 +1412,7 @@ config CMD_W1
>>>    config CMD_LOADB
>>>    	bool "loadb"
>>>    	default y
>>> +	select YMODEM_SUPPORT
>>>    	help
>>>    	  Load a binary file over serial line.
>>> diff --git a/common/Kconfig b/common/Kconfig
>>> index 8e8c733aa295..0db74aa580e4 100644
>>> --- a/common/Kconfig
>>> +++ b/common/Kconfig
>>> @@ -1274,3 +1274,7 @@ config IO_TRACE
>>>    	  confirm that the driver behaves the same way before and after a code
>>>    	  change. To add support for your architecture, add '#include
>>>    	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
>>> +
>>> +config YMODEM_SUPPORT
>>> +	bool
>>> +	select CRC16
>>
>> Is there any reason we wouldn't want the user to be able to select this
>> independently from CMD_LOADB?
>>
>> I'm asking because this is both invisible (no prompt) and has no help text.
> 
> I think this should stay hidden as it's *not* hidden for xPL as it's the
> equivalent of CMD_LOADB but it's the symbol for the library portion. As
> a maybe clearer result, maybe the library symbol should be
> XYZMODEM_SUPPORT / xPL_XYZMODEM_SUPPORT, to control building
> common/xyzModem.o ?
> 

I'm not sure to understand how the rename would help here? I'm assuming 
we have an issue of the symbol having a different meaning in xPL and in 
proper. If I understood correctly, YMODEM_SUPPORT in proper is for 
building the library and using it, while in xPL it's both for building 
the library and add support for loading the next U-Boot stage over UART. 
Is this what you meant? Are you suggesting we split "build library code" 
and "load next stage from UART" into separate symbols?

Also, lib/Makefile has

obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o

which is.... odd? Shouldn't this handle the case of "missing" SPL_CRC16 
dependency? So: does it really not build if SPL_CRC16=n but 
SPL_YMODEM_SUPPORT=y? If it does not build, is bringing SPL_CRC16 too 
much? We only need crc16-ccitt.o I think, and this will also bring 
crc16.o into the SPL, which may not be desired (size increase).

Cheers,
Quentin
