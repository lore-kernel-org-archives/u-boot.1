Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DE9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 11:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91D5877F4;
	Tue, 12 Dec 2023 12:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="jZAXv4Jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510FF877E9; Tue, 12 Dec 2023 12:51:26 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 034CD8718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsmwT1QA3b6yNlIkO09+qC24mn9OBPC3/JlBmojJEwh6q3s7UVUR3dX8SSFWGjfU65ahQ1rD1bFH3c/p5K94wgqXjtencnsB5dLIHJ9m2VxQ0uzRm1gqrUxyBMy/Z1YGz5QrCCkYN6V1YT3crG5P+kLGxs7xhmBKNns1Lb/LcWkqLWKO0t+Be2/DOgyN6/ew7y8u++eMihIuvQPui1zOgjHTW0l3MVM6XrFeTAL7Iqv06fyH4Mzohxpjb9cV9ALLwmM8csAgaHHI0F+GT/cFMWwUdDFz3S/dVpkVQPClOvlLE1E1YWA/nswwrnQ8ZY92p6mIemLWk3+oGo0h/GW9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DnWS9+sjZbPDLLccfokvMi+pPNmA9idljmNXd38H0I=;
 b=UtrJETdWj7i8K8U4IHeW/qhc29/0K68nIFFHR2mL6zEHKKveKKABIrLiOM8We0mMrn8dfvClCmS0CPRsIbOviix/GN/Jg6EsJtkzeB443l/8ppmH3/l5bABjaGMYx8/0aDI2H97VlHSrZsGmstx8RplMCbwKDBKMwwKbixGqiHv+pFgQzG9dRczDX59ESrneW1XkzrI7gpNQQUV1rKObrz4gyZjXJRSG6eyOrUPq2ucP+YHrx/DKmYvj2TqE/YllrOmJKGuKyg6I8qMvlmU46bAR9HukrKXkVd+GeCrOfH+UCVv8z2++x1gvuIedU8k5QJ6X+1VxmgZ1C8Wd6yEsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DnWS9+sjZbPDLLccfokvMi+pPNmA9idljmNXd38H0I=;
 b=jZAXv4JgbKsP/msbunFjFTFFRY3jLW4zhdzd1Mhkj81OWCVUSTwlX/irwqDsoJxU7iXDqA5Ai04tdfXaOtiLyhn/MO61V6e40gUxDyn4Cuy1ud9ZsWaJuVCsFHHY08ureZ5Y6GkLU12gwC2G0JojMOttPmL94f9V1cR1nkS8d3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAWPR08MB10260.eurprd08.prod.outlook.com (2603:10a6:102:369::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 11:51:22 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%5]) with mapi id 15.20.7025.022; Tue, 12 Dec 2023
 11:51:21 +0000
Message-ID: <a6eb5f19-c3e6-4d8d-a734-4be4eccc6c79@weidmueller.com>
Date: Tue, 12 Dec 2023 12:51:01 +0100
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
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAWPR08MB10260:EE_
X-MS-Office365-Filtering-Correlation-Id: f521585e-1740-4077-cbed-08dbfb08a913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUJht6YA9h8yExyei6qcX4j3zs8PUwErmGYBifjmxVsTFYNXXO/zFfePN5d3mpc+4EcaKuuedzdO8/20wWLnrFR+M30HLlHvQQkufXFzMpPqOTUHxhSWGGQ6KpDToC6XmsthV63b8jYYyGRX426vFihHolXqngPJjlpHGKq4JENcmK4IzQ0M7PO0laBlwC9EHGjfMECnN6a6TIYsisJ72YOEZ0OQrIcNwmBTuMmtjyVo60J+0RZDJzWDa/CqzbWOyBa+4L27mnPSqr4akkMdBhLqE77o0h3cAobn5YDj5oR5iSfs2HuSkgdmqqcvi0InB0pTsmabFoUH0t5fNyWJkdyH4oJiumQipQKb2jV+QQPznI+xsIdIdi321v78AGulaQc/qrbdFguQVZMxglYgcHiEf8mBX5jSvUWMuL00Z2uI8xur4EBMN/LqvRD7vxqIeE2xeT4voWBvMioNYw66hY2r/aMUHYg2o2qYRBSOb1ZA34IfKiD8uK+2UBtbufpyRjh4p70IeDO9lBOugfvEcta1qBB1DlVZzHuVppWmwNC3SAwJnAmfSlQn7CSJipWaF/BhfuuVLN7FbEN4XYFzeS2IzF0AeBG5DMi5ZJtZmmU4wlKbRCdg80HRgKKE69DBYbfhohn3+5ZHfjO8PLK62g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(66556008)(6916009)(66946007)(66476007)(54906003)(36756003)(86362001)(31696002)(38100700002)(83380400001)(6506007)(6512007)(2616005)(53546011)(6486002)(966005)(2906002)(316002)(6666004)(26005)(478600001)(5660300002)(8676002)(4326008)(41300700001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJYcVVnTEl1VVZ2ZEJkelpKSWJxKzFsWEdhSVBrSURHaHhJRlVMaWNMbVlo?=
 =?utf-8?B?WVJiU3VGT3M2Ly9oMnFZZFJBcm5FcmVZRkNNcVRFNGtVekI4eDR2OEhGQ1Ev?=
 =?utf-8?B?NHkzY0tNVFdqVnp4Ym1PalBXRzZRMzZOOUZEeGtPSWNBRmNhQmFDVTQ5cE5p?=
 =?utf-8?B?Sm41Z2JyR3BGRmt6K0lLbzdDU1NmM0J0VnFZWFRNSEVOSm1vYjRyejFhbkRM?=
 =?utf-8?B?VlpYN1F4OHBWQjFqTDQvSzZrelZTQUR3Q09GOXl1NzNMQTBYV0FRWTNRZU4x?=
 =?utf-8?B?TmNLeVBZcXUyTDVKRDBVMkNqbGF1Y3JFdjNXcTZlcVZwVkdrTXMveFBMOFVO?=
 =?utf-8?B?UVlTUW0zV3hTdWwrVEc3bkpRVFFEU1hFdEx3QWFMcWZPZFlpa3FCMG9QTDA2?=
 =?utf-8?B?cHdTUlhSdWhLeGlEYU15ZUpTbThhSE9aK3pYTjNWVjR0NXl4RlRHeDJCVlZZ?=
 =?utf-8?B?eDdSVlRFeXE3WjlVKzFlNUNYc1A4T3pUcWxEOTFkWldrRzNUK0FyUEcvTUdV?=
 =?utf-8?B?eWhTZlFqN2x3SHQ4bmlyMjdvQVRyNzFmRngrSXg0U0ZybmdGQ0JTejcxSG9v?=
 =?utf-8?B?K2xlQm5TSXRGQ1Uyd3g3R1lQc3NRMTBUUXJvUVpaL1lOZHQxQ3NGQjVxVXpH?=
 =?utf-8?B?KzFTOFBrOGpuQjRFVUhHTXZPdTVjYmRQUE8ybVF1dFJYcXdwdWRaZ015ckla?=
 =?utf-8?B?WVZaRVBIZ2ZNSVJ0b004NDAzWHdnU0M2QjdhMlNKUFd4VUVFbnIyTzZSUjVx?=
 =?utf-8?B?WkZ6c2gxWnNxTG1XdWtvMzhRODM0MTdOSlVYUm4wTVIrSGQ5QXJoWEpheGZv?=
 =?utf-8?B?SVo5bHZCRE5UWml0VmhSK2V1WDllemhRTXhnRlVHQXhCL0NTdzd1d2ZKVHUy?=
 =?utf-8?B?d0ZzRDZRcEtndmxzSVVGUDZXbXJWZXdNbk16K3VueGhoQlpldnA1emNjc3c5?=
 =?utf-8?B?R0tNSnlockFtaC9aYm1QNEIySmkzTW1BMEI2R0kwUTI5Sk0waGtoeEgwZVhw?=
 =?utf-8?B?NGRjMUUxbTJSaHlvSkRVZ0VnTEpRTHVVdEQyMTFsUnRFSzJ5K1NTQTBWWEJn?=
 =?utf-8?B?Q1Q4Z2lUYlpvbzNUNHRiWUx3eG5EcHhoQ2VORmNENVN0Sm92Y3J0UnVhVW5o?=
 =?utf-8?B?djhuS0JvSkJCMVFzVWNHVnRrbkZVL2RDcnIrZmJPSDh1QXh6Ukh6TUVHa1Zu?=
 =?utf-8?B?UVZvTm9YQ3pzcGNuSkxYcHZhWmpKd2QwbVQ1TkEwcTI2c2tjRzJHeUN5Nm9s?=
 =?utf-8?B?UkkySHg0aFg2MHprUDlQZTdIOVF2MTV0UzlYYk5TRVdKYU02Um40dzVhVXBQ?=
 =?utf-8?B?TlQ5K1hyNjdJazRnYU04VVFkYi9sbzNDZW1ZdllRZkNXSmNOS0FwUWVXUWVn?=
 =?utf-8?B?NnVGNENaTkVIOHNqMUUwQ2ZYRFVMK05sbFVJZnNkT1RXTlEwcSt2bFFQTERl?=
 =?utf-8?B?d3NQVUQ1WnhJWkF5RFF0eGMxSWlveVpiaG9YTkh1WEJYZE8xMWNuT0lJanFD?=
 =?utf-8?B?V1ZnZ1pBWnY1aEcxcGVGaFNaYWR5NCtVMXZUbUFzNVlPTXBWNDBqYXpBcHF2?=
 =?utf-8?B?TGlvV0hGV1RPbEZjZDV1bStzcm90emJoYWRTci9iL0VFd0RQVkU0ZmhXUm5F?=
 =?utf-8?B?b2pONFB4OTdCa2NyM2dRZEhiVmRhZEZUUXdxNG9ldzhqc2Y3MG16d250K2o1?=
 =?utf-8?B?akFJSCt1NkhZZXAyWHBsSU5pd1FnWUNLYW5IVmhtYnpjV3FrTFR0U2pjR3Zy?=
 =?utf-8?B?Z0dLbG9jTzZTbVdYdVlHQWIvZ0t2eDJmRmp3WWI5RDJHaUFaOFJHQVRVUXR6?=
 =?utf-8?B?d2JNekREVlN6bVVRN1lVWEJoZWRCR2JQN0lqTFRYQmplT2MvdGFLTU56YkhG?=
 =?utf-8?B?MWJWRlMwVlJpY1pjZUFRZ1NpS0tVOGpiekVSYVNJdE9jRzFEN29mK2IvTkpS?=
 =?utf-8?B?VTdtUC9MRThlM0pjOHNhWjJKUWlvWnEybkFuRlRtc0NEbGJJbWNmSER2aFBy?=
 =?utf-8?B?c0F5dm81Q3J1TnRSUThWYUlMbUlpVlVhbTZFOUVndVRib2pTakVrNHFKTFR3?=
 =?utf-8?B?WjFCazdSa2cwSzRqOU4zQ3FtRG05QlJIaXBSY2pCaVJpM0t5V2x1dll2UXI0?=
 =?utf-8?B?a05jem5mdVgzOGxCUUV1K2hGNHlidUgxUVlVMFIzaGVRVmU2NENIZWxkWmF5?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f521585e-1740-4077-cbed-08dbfb08a913
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:51:21.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqrXFZVksD48SPRUvdoro15LQVfH5U5EMehVnu9wzebswUcqvDk7WOl0ElyNsNN/C6tybRwmQG4vuRNqehXhZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10260
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

Hi Heinrich,

On 12.12.2023 11:13, Heinrich Schuchardt wrote:
> On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>>
>> This series enables the 'setexpr' command to print "cpu list"-like
>> bitmaps based on the printk format specifier [1].
>>
>> One use-case is to pass cpu list [2] based kernel parameter like
>> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
>> the kernel via a separate firmware variable without exposing the
>> 'bootargs' variable to directly.
>>
>> Example:
>>
>> setexpr isolcpu_bootarg=%32pbl $myCPUisolation
> 
> I applied your patches on top of origin/next but your example simply
> does not work:
> 
> => setenv myCPUisolation 123456789abcdef0
> => setexpr isolcpu_bootarg=%32pbl $myCPUisolation
> ## Error: illegal character '='in variable name "isolcpu_bootarg=%32pbl"

Thanks for testing.

I messed up the example in the cover letter. In your case it actually 
should be

=> setenv myCPUisolation 0x123456789abcdef0
=> setexpr bootargs fmt isolcpu_bootarg=%64pbl $myCPUisolation
=> echo $bootargs
isolcpu_bootarg=4-7,9-12,14-15,18-21,23,25,27-28,31,35-37,41,44,46-47,50,52,57-59

...which is wrong btw (the upper half bitmask is crooked).

> 
> This produces some output:
> 
> => setexpr a fmt '%32pbl' 64; echo $a
> 6
> 
> But the result is completely unexpected. Number arguments in U-Boot are
> always hexadecimal. So the output should be

Thanks for pointing it out! The internals use autodetect from 
strtoll(...) which handles decimal and hexadecimal. All other uses of 
strtoll use 16 as base. I'll address this issue in the next version.

> 
> 2,5-6
> 
> Best regards
> 
> Heinrich
> 
>> && env set bootargs "$isolcpu_bootarg"
>> && bootm
>>
>> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
>> [2] 
>> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
>>
>>
>> Changes in v2:
>> - Add bitmap format specifier to documentation
>>
>> Lukas Funke (6):
>>    sandbox: add generic find_next_zero_bit implementation
>>    linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
>>    test: cmd: setexptr: Add tests for bitmap string format
>>    doc: printf() codes: Add bitmap format specifier
>>    lib: vsprintf: enable '%*pb[l]' format specifier
>>    cmd: printf: forward '%p' format string specifier
>>
>>   arch/sandbox/include/asm/bitops.h | 16 ++++++-
>>   cmd/printf.c                      | 29 ++++++++++++
>>   doc/develop/printf.rst            |  6 +++
>>   include/linux/bitmap.h            |  7 +++
>>   lib/vsprintf.c                    | 75 +++++++++++++++++++++++++++++++
>>   test/cmd/setexpr.c                |  9 ++++
>>   6 files changed, 140 insertions(+), 2 deletions(-)
>>
> 

