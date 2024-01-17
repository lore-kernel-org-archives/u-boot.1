Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD69C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F228E878A5;
	Wed, 17 Jan 2024 13:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OmqACUTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A71C878A5; Wed, 17 Jan 2024 13:23:14 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95440874CC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 13:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=174673432a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40HBhoNc027384; Wed, 17 Jan 2024 13:22:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Mok8pCLhJQ5OvXzenayWxIpT0hkFhZpdNzWOBJg19vA=; b=Om
 qACUTOPbqGvw9yfmFYTJxyFHkTKOgCauYzk0vYTrazrFJJ1T0YXiyaSejzIc7XKB
 GT0Hn3UXLBVOH/W2eztOXBCWzYkrQUhAb7n4jAVFd0DKAn4kwydh8s7PyeW5bdPG
 rBbm82PnCvu9CXPgu3vIUZVWeVyZZrXwX+WjWuWEotsG3YBj8bOgcUECDtHeDmXa
 qo3TPhodho5ooceIDr0MFVh9YEGrxrZr39wbKrUufWV36BEQNGt8gxxPrCkO6inO
 OIpeuXsXN334Y/X3+1A35i+0rUbt5IFos8Mz+TWQcxV2+czdeag7ipFH9uuQJ40S
 +o4275ytWLt1kJPte3QQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vnbqc8y1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 13:22:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68992100079;
 Wed, 17 Jan 2024 13:22:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B065226FA0;
 Wed, 17 Jan 2024 13:22:53 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Jan
 2024 13:22:52 +0100
Message-ID: <0dc107fb-8c85-4f98-aa8a-35e404bfa21b@foss.st.com>
Date: Wed, 17 Jan 2024 13:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: console: Fix print complete stdio device list
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Bin Meng
 <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240116161231.741794-1-patrice.chotard@foss.st.com>
 <CAEUhbmUOy-iJ9SEiA8atU=V5CG+DAAxtQ9HJXO2A5_W=hwe1jw@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAEUhbmUOy-iJ9SEiA8atU=V5CG+DAAxtQ9HJXO2A5_W=hwe1jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
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



On 1/16/24 17:29, Bin Meng wrote:
> On Wed, Jan 17, 2024 at 12:13 AM Patrice Chotard
> <patrice.chotard@foss.st.com> wrote:
>>
>> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
>> stdin or stdout or stderr are missing in environment, as fallback, get
>> these either from stdio_devices[std] or stdio_devices[std]->name.
>>
>> Fixes: 6b343ab38d ("console: Print out complete stdio device list")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>  common/console.c | 23 +++++++++++------------
>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/common/console.c b/common/console.c
>> index cad65891fc9..8bfcfce5643 100644
>> --- a/common/console.c
>> +++ b/common/console.c
>> @@ -1049,6 +1049,11 @@ int console_clear(void)
>>         return 0;
>>  }
>>
>> +static char *get_stdio(const u8 std)
>> +{
>> +       return stdio_devices[std] ? stdio_devices[std]->name : "No devices available!";
>> +}
>> +
>>  static void stdio_print_current_devices(void)
>>  {
>>         char *stdinname, *stdoutname, *stderrname;
>> @@ -1060,19 +1065,13 @@ static void stdio_print_current_devices(void)
>>                 stdoutname = env_get("stdout");
>>                 stderrname = env_get("stderr");
>>
>> -               stdinname = stdinname ? : "No input devices available!";
>> -               stdoutname = stdoutname ? : "No output devices available!";
>> -               stderrname = stderrname ? : "No error devices available!";
>> +               stdinname = stdinname ? : get_stdio(stdin);
>> +               stdoutname = stdoutname ? : get_stdio(stdout);
>> +               stderrname = stderrname ? : get_stdio(stderr);
>>         } else {
>> -               stdinname = stdio_devices[stdin] ?
>> -                       stdio_devices[stdin]->name :
>> -                       "No input devices available!";
>> -               stdoutname = stdio_devices[stdout] ?
>> -                       stdio_devices[stdout]->name :
>> -                       "No output devices available!";
>> -               stderrname = stdio_devices[stderr] ?
>> -                       stdio_devices[stderr]->name :
>> -                       "No error devices available!";
>> +               stdinname = get_stdio(stdin);
>> +               stdoutname = get_stdio(stdout);
>> +               stderrname = get_stdio(stderr);
>>         }
>>
>>         /* Print information */
>> --
> 
> This can be further simplified to:
> 
> char *stdinname = NULL;
> char *stdoutname = NULL;
> char *stderrname NULL;
> 
>     if (CONFIG_IS_ENABLED(CONSOLE_MUX) &&
>          CONFIG_IS_ENABLED(SYS_CONSOLE_IS_IN_ENV)) {
>                /* stdin stdout and stderr are in environment */
>                stdinname  = env_get("stdin");
>                stdoutname = env_get("stdout");
>                stderrname = env_get("stderr");
>     }
> 
>    stdinname = stdinname ? : get_stdio(stdin);
>    stdoutname = stdoutname ? : get_stdio(stdout);
>    stderrname = stderrname ? : get_stdio(stderr);
> 
> Regards,
> Bin

Right, i will send a v2
Thanks

Patrice
