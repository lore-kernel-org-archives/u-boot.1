Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE3CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D13B0846A4;
	Thu, 21 May 2026 18:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Quj8gYnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFADB846E6; Thu, 21 May 2026 18:12:38 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773C683FF5
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8uzyRBJ+AB3IrdGzBTcni3A7FUvw6o6yTV0CSBFNF/aSBRBI089RNSAurnVIMuSxzQKyhS6X8O+Q4aALQmdV3QkG7HHFoBF2E7ISubQRvQJ9EUyIgbs5MN4pmE9bEDV9RcPKQIqx9Z1fGvqOkOJDOdDFjcIEpc8zqqb6dYLUnZSej9Ma3H9W8gJnAjPOl3dN8hXOszpCiE1brtWg+Tt355BeRtXvK9r1StmO1woheNK4l6OGWzCnrTSO+XQBv+RcHLDRZ4DXmbJZx2Oj8vOGjdZjYeehIN3xqsfD75dM+3BobbxaRtBZSukjJSXwQZhKRx58nYdVPIeMeRVPHlA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc4WyTwdgbGtuXg/HdZEVhcrKFFQY/1FXh1dkql3VWU=;
 b=MLC95L9VVeq6uZETpoGp4a0KkMbuAPhbWzFynNR/IQJjxVhGgVWPy7dmaEWARnkyD1H/uAGKmzQVQkl8wFpPD7nm/yAbGxI2olCDJXiyGjmE8XO/pBaVnwCsmGFeemmzg7jNKo5IwsUukRqj/nxxpPJOGD12zvGJrJ4wttt4MNeKy6ogRjXdZdrBnZ7o+suRBZ3+Ks+gfgmvdD/vXvbp3MzCAjto2GcJXzuIhnQNy9ja1w0uF4ZdfJusQJ9GNNwqJBCwtqrcKEkEuQwNq0C2tushJMZvjASEnr1Pzo+6npK4zYaAFPPdolLqiHZ1DQNm7n0c7H2tyuz0cOca0aan8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc4WyTwdgbGtuXg/HdZEVhcrKFFQY/1FXh1dkql3VWU=;
 b=Quj8gYnUaDuOQKlOn2sTaHhXf5/N8CXKyR+oSFbV1HzRSL0qbtaOAYj/SDiApnHBdmqjOdeA8TpkcyHd4xWjFBy+zxTpO93vydiMaAXtKw462ArDeisQCH/K1Y0W1hEVAAfa8psWx0LaOWW9DrRgiRD/0YQwoZu/clNJ/jymdKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8702.eurprd04.prod.outlook.com (2603:10a6:102:21d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Thu, 21 May
 2026 16:12:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 16:12:33 +0000
Message-ID: <b1206a04-9800-4323-bf4a-cb8a14f15f8c@cherry.de>
Date: Thu, 21 May 2026 18:12:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
To: Marek Vasut <marek.vasut@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <cf2f988c-e12e-4dd3-b80e-b58f846a8d71@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cf2f988c-e12e-4dd3-b80e-b58f846a8d71@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 136b1778-4841-4926-e58d-08deb753c451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|11063799006|6133799003|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 3LdrSOAJyWUkduR/SGRB3zYHaqdfI4ezOiWMxEyIoX5g+KG4BQ0RGWrqn2i8/4hDu5B6040I0vwD3U6t9gNNS65N1iNSHBWj/4YBt54eqLAiKAZA13UmCcC6AEhlvUgcBoDYizMbTF4KJMJXmqfZXa8XqWjhUr7zOL9QGTK2JAXQcbSOQX0XhBmg+nDSStJkG5ujIoX6LH1jILehFVp2j8lpMLjmFGXVLJJM/4OrbI7mKZrYVCKYx7rL1Ac25EztmhEGLFdcYvRjrzx+Iof7L5PFWU070cntcQ7/9TUwkgv/vMG5NwZ5iXT7bY47ma1exJ6u/ueP++5VkHCNzsGZmuj09mm8ZHq1enGHuCoGu22WYnQgyjsZR8ICC5ny2rdNWtjsochV5tC3Vd+/X13vDeGoh+Bov/sG+pc70gNOcMFEfCRoI1WodEStgs37EeD3wql2316EMxjBKXRbngb9YG0gFNRO1/NpRX9J6MDRv4kzEOWRZe5xA+1YlVeWpRIXFNAe3/Zhpveo2cf/iXiorDxvvk8hs+2WbKT3eyp3v4gU0CInMgl94/GOYK4a9wi3nGGYy8g3XIhoQNyXaXcYz4ljr1YAi9DRqFnitnl+FBfGF7kUWFXqQ938/4caMY7b1/+nfMq9IDDGnQMngZ1X/ietoC8/Ivpv3IE+rkobAMBwxKrO5DSbeMIdvTdZm2Uk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9mY2hITVo3Tnl0eDJsSDdwZWpJeEpGanpNSXNmK2VZUGxMcGp6QzE1LzBX?=
 =?utf-8?B?M0x3WDZHYTlUWCtqL2xFUkJQUzlLbmtpaCtGdU10elJRa21IRWY0RjFMN1lW?=
 =?utf-8?B?cVZQRUs0bWszWmdYdzh5RU85bkxSQ2M1eUlNM3h0RG1RTUZ5dXRMVGtEeFNu?=
 =?utf-8?B?N0hTQytsL3R1ZzdjR0V4VDRqS3M1dFlLTnNJSCt5TnNYbUpub3creTRDREgr?=
 =?utf-8?B?ZXFaaFI3bXdZSXlDQ2RuVW1lTXdVN2h4T1NwSTVGWHRBREU4bFF5OURYcTdJ?=
 =?utf-8?B?YWExVSt5bDd2bkRHUm1CT3JlQmlXS3FYRVg1T0dyRHkwQnJ4b2hrUEwxRDZB?=
 =?utf-8?B?Tmt3Rk5JUysvZkhTejViQ28vU3FKOWZWQUkzdWt3aFNIdzJBbWliRFZIZEVG?=
 =?utf-8?B?ZEZxZ3FjQWI5bStPYklKUmdVUUQwcmtXMVRYN3dHaFkvMXgrQ3lTN3NnNkJp?=
 =?utf-8?B?RlJaYitaZVFPc1RSRHZBOU5sSE50bExsbElMQ3dVUGhrTEhiZm95cTRLMzB2?=
 =?utf-8?B?TXM2bGJSaTZFMmV2amVlZzAycGl2T0JRNUNaTkVBbWl3a0xOVGV5Z21ab3E0?=
 =?utf-8?B?MGJwRmRzOXhWczZLYXptbGh0bHZqRGI5M2pYcHRqQmFtblRNa0dzQ1FXWDBS?=
 =?utf-8?B?TDlXblhBNmIyZGxiam4rbDlKVDlJN1RUQi9XdXRnZDh0SDhlK2hHU3RUdFZP?=
 =?utf-8?B?dmtRNk52ZXdCelpnbWF5NkpZQTNqMks3Q0RTc0xmM1lxblZVanVSc3R0ak04?=
 =?utf-8?B?VXA3dVBrMDZJSDQ5VzI1c0RmODI4eHUwK2k5WXdDWlRKaThxSmc5ZWVvdGJD?=
 =?utf-8?B?OS9FSmQvbVQ4VzlTNThOa2V6SSt4emhJOVRpaG9sYWtaSDhwYVV5TWdrSGFJ?=
 =?utf-8?B?dmZxZUJUV25SQi9JcUhocHo5TzhiWlZvUUk4VCt6U0tZMTcrV251Q29qQjE0?=
 =?utf-8?B?dGwwT1c3dnFtUDM0a2hvM1FGMFdzOTRtcFRJSG5JZW1sR2t1MVZtOUdhUWpE?=
 =?utf-8?B?M3lxTjFiMUFOb1lVOVZJNHgrcTlQZk92TWZLb2JUZktlR3JMWjBSaTJEYjFZ?=
 =?utf-8?B?Y1NCYlRmWlVHNlhDQ2MzTnNiWDlaNUFTSVhIS2ZDZWRXOUJaOHUrQVBUcVd4?=
 =?utf-8?B?ZklEL1liNTB6T1R6UnpaYjFIRnNmSkhWUFkzYkw3M01kdk1NT2orUGovVlNX?=
 =?utf-8?B?TjlkeC9SRmtVQTZHV3A0UHNDSHRYRGFxbGQ0TmVXVTE3QmtNMktQd3JTMS9z?=
 =?utf-8?B?dkk4TWs3bGZiKzJxQzVwUmtKTU93ZUlWc1ZrN0JuTnJKZlJ3cGhWUHpwempV?=
 =?utf-8?B?cmpON1JFSmpvSHorVm0xd3Jsc0dQTVBFbUhjM0VPZlFYRjZ5dDZDSDBVNDNo?=
 =?utf-8?B?RE1ERUE3YUlBMGtwTVZ0N2VoaVBSUXZQZGpLeEZmVUtUVkZEL203NkxVN01P?=
 =?utf-8?B?NGQvWlBGTElNSThjcnlYbWg3a296L2tobWdjTk91eDF2bUFJcXZoMmp1cEhY?=
 =?utf-8?B?QjAyMlpoQmNNR2xRUnF3NjNCY1dGbDR2RktnWVpVMTZiS3pIZlVyOGMzdzF1?=
 =?utf-8?B?MCtkdk56VnduVVpybHpXYTVxQllwb2crK2xwR1lGZGFMWnoxcFUwdXRNOVZk?=
 =?utf-8?B?UkVaYTZnVFFqSzFkOFFKdXdKaEU4N2Fza3hUdFA4aVM0cmdBVDhybVYzTnhO?=
 =?utf-8?B?RG8xWVZGYjJ3cjVRcXZpc08xZWE2b2FDU2FkVjl5VFhuNFA0TjBubGFVd2xx?=
 =?utf-8?B?ZFZqelF3QWVwcWFZSzltOHpjMllwR2hVZXk5WmEzK2FtVGVlaDVEbEYyeVhM?=
 =?utf-8?B?K0JtM0g2eVBpWWFiczBsbWdUZzFtZFl6NlRvYkhrU2phckQ5NHBZRDgwcDNj?=
 =?utf-8?B?MGpLc3Z2T0RScG1BZ0R4dXViSUwxSmpsY2hONVZzZ2gzcWY1MUNubGJiQ2J1?=
 =?utf-8?B?WnROU1orR2RNa1pyK0s0ekNhMDJleW1VVXMwOVZFaFZSd21HNmVHcklXUGlh?=
 =?utf-8?B?Q0xLVjVXL1FJWTV2VS9DRzNSdWJsZG45UHpCeTBWZHovMnBlcVhkdkV4c1VM?=
 =?utf-8?B?VHpES0FNTXMzelp1N0hhclUwbjcxWlo0dHBjKzJEcCtqdVU0K1U5SmgreTZF?=
 =?utf-8?B?OFh5K2pjTlIvYUlQOFY4N1VNMHNBOU5Ic2xXSkJHeTNYOWRkb01WVnJCdUF5?=
 =?utf-8?B?QUZzbGxFNVk2MzhWam1kWjJtMFRUSHJJa2dkY2tvK1haMnNHRko4N0JjNTVS?=
 =?utf-8?B?elN2aUtRZFVRdmZCWEhoU3JVYXpBaEJ1S21SWWh5RmdYNytrQ21CZzBOcity?=
 =?utf-8?B?WFBETjBPbnFMYm9uNkJ5NThFZ3JWOTlyODhoaTZyTFpmVEFwVFVQZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 136b1778-4841-4926-e58d-08deb753c451
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:12:33.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1xFDZZO85vDsv2wsoYm+QPizINkAXvwDG00sBisDd6YUTHALq6SKn0Od6qsHjwikVlUUL0O69D5hd0O+bQTygSjdBITvF65c9mpAFUo28c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8702
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

On 5/21/26 6:09 PM, Marek Vasut wrote:
> On 5/21/26 4:34 AM, Aristo Chen wrote:
>> The get_basename() helper in tools/fit_image.c searches the entire input
>> path for the last '/' and the last '.' independently. When the last '.'
>> falls at an offset earlier than the last '/' (for example "./mydt",
>> "a.b/c", or "sub.d/leaf"), 'end' points before 'start' and the computed
>> length is negative. The subsequent size check uses signed comparison so
>> the negative value passes through unchanged, and memcpy() is then called
>> with that length implicitly cast to size_t, which segfaults.
>>
>> Restrict the dot search to the substring that follows the last slash so
>> that only an extension in the filename component can become the end of
>> the basename. This matches the function's stated intent of stripping an
>> extension from the leaf, and keeps the existing behaviour for typical
>> inputs such as "arch/arm/dts/foo.dtb".
>>
>> Reproducer that previously segfaulted and now produces a valid image:
>>
>>    echo dummy > kernel.bin
>>    echo dummy > ./mydt
>>    ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
>>                    -a 0x80000000 -e 0x80000000 -n test \
>>                    -d kernel.bin -b ./mydt out.itb
>>
>> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>> ---
>>   tools/fit_image.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>> index 1dbc14c63e4..6c129117297 100644
>> --- a/tools/fit_image.c
>> +++ b/tools/fit_image.c
>> @@ -265,8 +265,14 @@ static void get_basename(char *str, int size, 
>> const char *fname)
>>        */
>>       p = strrchr(fname, '/');
>>       start = p ? p + 1 : fname;
>> -    p = strrchr(fname, '.');
>> -    end = p ? p : fname + strlen(fname);
>> +    /*
>> +     * Search for the extension dot only within the basename. Searching
>> +     * the whole path would let a dot in the directory part (for example
>> +     * "./mydt" or "a.b/c") place 'end' before 'start' and produce a
>> +     * negative length, which the size check below does not catch.
>> +     */
>> +    p = strrchr(start, '.');
>> +    end = p ? p : start + strlen(start);
>>       len = end - start;
>>       if (len >= size)
>>           len = size - 1;
> 
> Why not call basename(3) directly in here ? Why reimplement it ?

"""
Warning: there are two different functions basename() - see below.

[...]

Notes

There are two different versions of basename() - the POSIX version 
described above, and the GNU version, which one gets after

     #define _GNU_SOURCE         /* See feature_test_macros(7) */
     #include <string.h>

The GNU version never modifies its argument, and returns the empty 
string when path has a trailing slash, and in particular also when it is 
"/". There is no GNU version of dirname().

With glibc, one gets the POSIX version of basename() when <libgen.h> is 
included, and the GNU version otherwise.

Bugs

In the glibc implementation of the POSIX versions of these functions 
they modify their argument, and segfault when called with a static 
string like "/usr/". Before glibc 2.2.1, the glibc version of dirname() 
did not correctly handle pathnames with trailing '/' characters, and 
generated a segfault if given a NULL argument.
"""

Not very reassuring, tbh.

Quentin
