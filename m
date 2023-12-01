Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50CCC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A11487638;
	Fri,  1 Dec 2023 11:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701427148;
	bh=WP0oeGVnS48Z12X4nDr38Tj+uOvuLtcqoIbXYOy467M=;
	h=Date:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwqIQKSeR7JPUPuyaajiLUqAdNANn67E2Pbf4xqJb9JOoVBf/sWO6NC/C31B2MCuK
	 m9MKf1cYkwLTkiDDnqzILzWMPCNXOVTktWz4DSmtXIrmLD1PTHEVlYKhIHAk7wOoYs
	 wBRRWXDNL9pa51f8rRyKUaKvp/tmqQf12dUGU4beI959h2/pHD6jqtzNEL2Nyqq5kb
	 izAiH95EPHMtHNKWQEbGOMprKx64yCfp57JVxWUm891yCCBkdJPvBmKvkdfua5A96b
	 La09gEYIWt3vXSosY3RsbUrLuMMDeOj/QiN41ahJ7k4RVmgnXJvJabS/KqrpKswEVs
	 h5K+0AufSI+aQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FB487677; Fri,  1 Dec 2023 11:39:06 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC40870E7
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ShV0h3sV8z9sRG;
 Fri,  1 Dec 2023 11:39:00 +0100 (CET)
Message-ID: <0b88174d-4342-4d84-af71-ebd63ecd0e59@denx.de>
Date: Fri, 1 Dec 2023 11:38:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Correct watchdog timeout print message
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
References: <CGME20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8@epcas2p1.samsung.com>
 <20231127010520.3170033-1-chanho61.park@samsung.com>
 <9f5c0ad9-6e7c-4451-a06c-3d9989358057@denx.de>
In-Reply-To: <9f5c0ad9-6e7c-4451-a06c-3d9989358057@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ShV0h3sV8z9sRG
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

On 12/1/23 08:37, Stefan Roese wrote:
> On 11/27/23 02:05, Chanho Park wrote:
>> The wdt_start function takes timeout_ms as a parameter and starts the
>> watchdog with this value. However, when you output the message, it shows
>> the default timeout value for the watchdog device.
>> So this patch fixes that part to output the correct timeout value.
>>
>> Before -->
>> StarFive # wdt start 3000
>> WDT:   Started watchdog@13070000 without servicing  (60s timeout)
>>
>> After -->
>> StarFive # wdt start 3000
>> WDT:   Started watchdog@13070000 without servicing  (3s timeout)
>>
>> Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the 
>> cyclic framework")
>> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> 
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Thanks,
> Stefan
> 
>> ---
>>   drivers/watchdog/wdt-uclass.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/wdt-uclass.c 
>> b/drivers/watchdog/wdt-uclass.c
>> index ed329284decb..65a4bc1f90ed 100644
>> --- a/drivers/watchdog/wdt-uclass.c
>> +++ b/drivers/watchdog/wdt-uclass.c
>> @@ -141,7 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, 
>> ulong flags)
>>           printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
>>                  dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
>> -               str, priv->timeout);
>> +               str, (u32)(timeout_ms / 1000));

Unfortunately this commit break CI build - I tested using Azure CI:

test.py for QEMU platforms qemu_m68k:


Successfully installed attrs-23.1.0 jsonschema-4.17.3 pyrsistent-0.20.0 
pyyaml-6.0
+ tools/buildman/buildman -o /tmp/M5208EVBE -w -E -W -e --board 
M5208EVBE -a CONFIG_M68K_QEMU=y -a '~CONFIG_MCFTMR'
Building current source for 1 boards (1 thread, 2 jobs per thread)

Starting build...


     0    0    0 /1       -1      (starting)

       m68k:  +   M5208EVBE
+m68k-linux-ld.bfd: drivers/watchdog/wdt-uclass.o: in function `wdt_start':
+drivers/watchdog/wdt-uclass.c:144:(.text.wdt_start+0xc6): undefined 
reference to `__udivdi3'
+make[1]: *** [Makefile:1765: u-boot] Error 1
+make: *** [Makefile:177: sub-make] Error 2

     0    0    1 /1              M5208EVBE
Completed: 1 total built, 1 newly), duration 0:00:21, rate 0.05
##[error]Bash exited with code '100'.
##[warning]RetryHelper encountered task failure, will retry (attempt #: 
1 out of 2) after 1000 ms
Generating script.

Could you please take a look?

Thanks,
Stefan
