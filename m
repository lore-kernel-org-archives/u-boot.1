Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE6C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34304801DE;
	Wed, 19 Feb 2025 21:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nwSGkXhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F00807C4; Wed, 19 Feb 2025 21:00:10 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84069800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 21:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51JJxjLN1918798
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Feb 2025 13:59:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739995185;
 bh=y1WOOvvXdDx8w2a9eiofbuxF98DTIMz2GaS/F9x5GJw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nwSGkXhqMMM/aw31szg59NQiqEaPjsmF81Y3P2+UpnRqIbhAITmu2kxpSdy4jrhW/
 8dbJod01rzy+HDyAUdAzaN+WMprtNPK+KGODqz+i0OLqS/BIoUesXgl8ZdheS0yeQH
 DVz8NXkD2V79L/i0XHnvprjKRyZYKYON//mNYJhM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51JJxjuW027835
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Feb 2025 13:59:45 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Feb 2025 13:59:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Feb 2025 13:59:45 -0600
Received: from [10.249.135.49] ([10.249.135.49])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51JJxbpC099804;
 Wed, 19 Feb 2025 13:59:37 -0600
Message-ID: <2d6a2eae-3825-4a03-a29c-4775f38dc535@ti.com>
Date: Thu, 20 Feb 2025 01:29:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "s-k6@ti.com" <s-k6@ti.com>, "afd@ti.com" <afd@ti.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "hnagalla@ti.com" <hnagalla@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "kishon@ti.com" <kishon@ti.com>, "bb@ti.com" <bb@ti.com>,
 "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-2-c-vankar@ti.com>
 <752c404bcb63afaf78055f39d583055db44f82a3.camel@siemens.com>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <752c404bcb63afaf78055f39d583055db44f82a3.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hello Alexander,

On 2/20/2025 12:19 AM, Sverdlin, Alexander wrote:
> Hi Chintan!
> 
> On Wed, 2025-02-19 at 16:18 +0530, Chintan Vankar wrote:
>> To append a string to a tftp pkt, "tftp_send()" API invokes "sprintf()"
>> function which copies a string excluding a null character causing TFTP
>> not-null terminated string error. Increase TFTP pkt string by 1 to avoid
> 
> Is this error visible somehow? How did you stop this problem?
> 

Yes this error is visible while loading the file via TFTP. I tried
tracing back the error and it was due to string copying in "tftp.c" file
that I modified.

Since commit 'e2d96ac9ee9f81c8f72435bff55f924d27ad92d1' has modified
sprintf() function to return the string length instead of 0 so it was
not seen before. Also from:
https://github.com/u-boot/u-boot/blob/master/net/tftp.c#L347,
you can see that we are incrementing pkt length by 1 on every sprintf()
call but that was not done for the later part that I modified and that's
how I come to this approach.

>> this error.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>
>> Link to v1:
>> https://lore.kernel.org/r/20250107093840.2211381-2-c-vankar@ti.com/
>>
>> Changes from v1 to v2:
>> -> Updated commit message.
>>
>>   net/tftp.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/tftp.c b/net/tftp.c
>> index fd9c9492929..420ea9ecf6c 100644
>> --- a/net/tftp.c
>> +++ b/net/tftp.c
>> @@ -347,11 +347,11 @@ static void tftp_send(void)
>>   		pkt += strlen((char *)pkt) + 1;
>>   #ifdef CONFIG_TFTP_TSIZE
>>   		pkt += sprintf((char *)pkt, "tsize%c%u%c",
>> -				0, net_boot_file_size, 0);
>> +				0, net_boot_file_size, 0) + 1;
> 
> But it does indeed produce \000 octets, because of %c with "0" argument, doesn't it?
> 

While debugging I tried to debug the pkt string and I come to know that
before this point 'null character' was getting appended because of
incrementing a pkt length by one, but not after this. It was just
appending a string, so it was not producing a '\0'.

>>   #endif
>>   		/* try for more effic. blk size */
>>   		pkt += sprintf((char *)pkt, "blksize%c%d%c",
>> -				0, tftp_block_size_option, 0);
>> +				0, tftp_block_size_option, 0) + 1;
>>   
>>   		/* try for more effic. window size.
>>   		 * Implemented only for tftp get.
>> @@ -359,7 +359,7 @@ static void tftp_send(void)
>>   		 */
>>   		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1)
>>   			pkt += sprintf((char *)pkt, "windowsize%c%d%c",
>> -					0, tftp_window_size_option, 0);
>> +					0, tftp_window_size_option, 0) + 1;
>>   		len = pkt - xp;
>>   		break;
> 
