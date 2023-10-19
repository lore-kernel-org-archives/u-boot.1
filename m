Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D678CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE603871E6;
	Thu, 19 Oct 2023 12:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697711737;
	bh=7P6dh9sVCs+9vuEo14R7fGQz8lnlEKVDQSsY6ggu1A4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4XcjKx256RzdOggxVklgAHUQMOfIL3J+vhATtk0P9TdTzP0fLMh2nn85tDjwk8Nn
	 rtUxKJgTys7vDywGDUQ48qntox506dv38YdkUyOcYGwN61M39nXLpLJIMMXGgx7THr
	 SfeO3CMzcOtgz7Bkfysi7sws0ihQACCUpZ6y3Q4oV8Flk7/SteyiidKKu3OelmnHvL
	 /RKNlmItO03LB2aJp4GCElDKxWd48vcJNnoYRxybg3faN6kqo44xSVc1tYGS2hE8hS
	 N9jYpT78e/myGQ2qXqNa8rH/qnA+Tb3eXFk2Tu1uqFge6ivoZK+8R1KVQ/w2aTtJDf
	 nzSOdRxQnNGCw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F028D8722D; Thu, 19 Oct 2023 12:35:35 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E640871BD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SB3yX1CJ8z9sZs;
 Thu, 19 Oct 2023 12:35:32 +0200 (CEST)
Message-ID: <e11af1b4-0ce2-4e0c-93b2-babad3c22a49@denx.de>
Date: Thu, 19 Oct 2023 12:35:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] sandbox: watchdog: Avoid an error on startup
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Doelle <paaull.git@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>
References: <20230810155316.1356323-1-sjg@chromium.org>
 <dd3fd61b-563b-4b4f-d411-b5b14aed9944@denx.de>
In-Reply-To: <dd3fd61b-563b-4b4f-d411-b5b14aed9944@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SB3yX1CJ8z9sZs
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

On 8/11/23 09:10, Stefan Roese wrote:
> On 8/10/23 17:53, Simon Glass wrote:
>> For some time now running sandbox with -T produces an error:
>>
>>     Core:  270 devices, 95 uclasses, devicetree: board
>>     WDT:   Not starting wdt-gpio-toggle
>>     wdt_gpio wdt-gpio-level: Request for wdt gpio failed: -16
>>     WDT:   Not starting wdt@0
>>     MMC:   mmc2: 2 (SD), mmc1: 1 (SD), mmc0: 0 (SD)
>>
>> Use an unallocated GPIO to avoid this.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 1fc45d6483d ("watchdog: add pulse support to gpio watchdog 
>> driver")
> 
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-watchdog/master

Thanks,
Stefan


> Thanks,
> Stefan
> 
>> ---
>>
>>   arch/sandbox/dts/test.dts | 2 +-
>>   test/dm/wdt.c             | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
>> index f351d5cb84b..14ec17a3fef 100644
>> --- a/arch/sandbox/dts/test.dts
>> +++ b/arch/sandbox/dts/test.dts
>> @@ -935,7 +935,7 @@
>>       };
>>       wdt-gpio-toggle {
>> -        gpios = <&gpio_a 7 0>;
>> +        gpios = <&gpio_a 8 0>;
>>           compatible = "linux,wdt-gpio";
>>           hw_margin_ms = <100>;
>>           hw_algo = "toggle";
>> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
>> index 653d7b1c8b3..2bbebcdbf28 100644
>> --- a/test/dm/wdt.c
>> +++ b/test/dm/wdt.c
>> @@ -54,7 +54,7 @@ static int dm_test_wdt_gpio_toggle(struct 
>> unit_test_state *uts)
>>        */
>>       struct udevice *wdt, *gpio;
>>       const u64 timeout = 42;
>> -    const int offset = 7;
>> +    const int offset = 8;
>>       int val;
>>       ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
>> @@ -115,7 +115,7 @@ static int dm_test_wdt_watchdog_reset(struct 
>> unit_test_state *uts)
>>       struct udevice *gpio_wdt, *sandbox_wdt;
>>       struct udevice *gpio;
>>       const u64 timeout = 42;
>> -    const int offset = 7;
>> +    const int offset = 8;
>>       uint reset_count;
>>       int val;
> 
> Viele Grüße,
> Stefan Roese
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
