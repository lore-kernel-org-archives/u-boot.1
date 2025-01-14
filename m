Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBC7E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32500805CD;
	Tue, 14 Jan 2025 14:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JS+b8Vad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD50980657; Tue, 14 Jan 2025 14:20:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B4558022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=31090870d4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EAnHTP005088;
 Tue, 14 Jan 2025 14:20:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 qqlkF4IIs1CKd6IjktYb2lkl7cdo9Lu+GcHVMJBBMyo=; b=JS+b8VadN5nmgHZQ
 D1h/TIHhblTCBDet11xfHYcG/Yte0NlJVUGo2Uee+EmD7qDVXoYUf5jmHVnjXC4r
 PCSkMj2o4LZq+JvoRmGANkNMBZYeEaW8BNILS7IEZTl9IB+aDjzANRHZZbhDDj4O
 3D7ceJwn/stLZwDygttutJ30xwnfPt7jjQ6kl+8hxgtt+E7zjKA8bR0cM0eQr5ml
 ETm/bYjb8SHmh9lfBUzCzX81I/J/sRpdSWBFLZVzq2+CvBd2IY0Ye8iucP9/5mc6
 fYdjUHUNyFKcZM8Kehm2kTeVBw5uUGtx0e5G7tx7aqxcic5t64dVBiFwHvv+W8Dd
 za4Ckw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 445pgt0kpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 14:20:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B357D40046;
 Tue, 14 Jan 2025 14:19:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9AA6B29ADC4;
 Tue, 14 Jan 2025 14:19:07 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 14 Jan
 2025 14:19:07 +0100
Message-ID: <44119479-07a7-4679-9be5-3d914d55d554@foss.st.com>
Date: Tue, 14 Jan 2025 14:19:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cyclic: Fix rollover every 72 min on 32 bits platforms
To: Stefan Roese <sr@denx.de>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20250108150940.558671-1-patrice.chotard@foss.st.com>
 <ef52a3dd-3851-44e8-878e-09c10265ff7b@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ef52a3dd-3851-44e8-878e-09c10265ff7b@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 1/9/25 08:56, Stefan Roese wrote:
> On 08.01.25 16:09, Patrice Chotard wrote:
>> On 32 bits platforms, timer_get_us() returns an unsigned long which
>> is a 32 bits. timer_get_us() wraps around every 72 minutes
>> (2 ^ 32 / 1000000 =~ 4295 sec =~ 72 min).
>>
>> So the test "if time_after_eq64(now, cyclic->next_call)" is no more
>> true when cyclic->next_call becomes above 32 bits max value (4294967295).
>>
>> At this point after 72 min, no more cyclic function are
>> executed included watchdog one.
>>
>> Instead of using timer_get_us(), use get_timer_us() which returns a
>> uint64_t, this allows a rollover every 584942 years.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   common/cyclic.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/cyclic.c b/common/cyclic.c
>> index 196797fd61e..e3f03a19d55 100644
>> --- a/common/cyclic.c
>> +++ b/common/cyclic.c
>> @@ -61,7 +61,7 @@ static void cyclic_run(void)
>>            * Check if this cyclic function needs to get called, e.g.
>>            * do not call the cyclic func too often
>>            */
>> -        now = timer_get_us();
>> +        now = get_timer_us(0);
>>           if (time_after_eq64(now, cyclic->next_call)) {
>>               /* Call cyclic function and account it's cpu-time */
>>               cyclic->next_call = now + cyclic->delay_us;
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Thanks,
> Stefan
> 
Hi Stefan

I found another issue regarding cyclic.
I didn't notice it due to debug trace i activated to find this issue, but
after 72 min , i got :

ERROR: cyclic function watchdog took too long: -4294967293us vs 1000us max

This is due to remaining usage of timer_get_us() in cyclic_register() and in cyclic_run().
they also need to be replaced by get_timer_us(0).

I will send a v2 for that.

Patrice
