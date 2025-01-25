Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C70DC0218B
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 06:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B1EC80A45;
	Sat, 25 Jan 2025 07:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737785760;
	bh=FtHexdXQlkn84eyUB545rLtz8TSYWxUM7qrssiv/4Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XQg3evzPyzjhMXFuUaXtGJxiH+urJ+4mLYMno7GkN2wj/+xKmGoEjiJbgXqQEGf/Y
	 Gg50e+/E5E3asqjjE8D9ihRhVEV3YlI8zPUJLkE07dhCusPgmCZIzhhwwLTau9la98
	 D/yvGWNaWfuStalxG0xux4w6M8nJRNkc/jOW1h8BB2Vn8wY0ONgOnYVA+iIvMhYp1B
	 5c76z3QJtoEDU/3h4kZcT6hacz+CXFpkhQ6lA2ocffS97Rex34obMN1DVcIezXnaK3
	 QH35XhGrUGKT7C0X8WCwwxVCruv4tPTWEFy3FcJ9lKnLq5oOEoeZSY1VbAIe+s+Y1i
	 CvcoS6jMKUq0A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B0A80ADB; Sat, 25 Jan 2025 07:15:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7A780A3E
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 07:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="I0G793wY"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E5721087DEDF; Sat, 25 Jan 2025 07:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737785754; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtHexdXQlkn84eyUB545rLtz8TSYWxUM7qrssiv/4Kw=;
 b=I0G793wYIfAgG1+Yz6p2se/U7CfYH8BdY6BC8jnKp/YhBW/Shhm8iBjl5KgTkbE5gEZEs3
 jccGvI56QMrwfZiv3R2X740htWNhBach9jbeVfdjdzFcfRhZMbJoFi/YLpx7TAWwVZK1de
 6+9BL+q8J4UxQkvh9lbb0HXPY+DwlL3kz8iYj0okWh7dJFZCC5SKoBhOsYSzYgajfpNtxf
 1sRDI7cR0fO4aInkL/6k4XaJSM0f6zNFpPwTLi1rPRh+ypjjNUWz7HQmpgGPlKamTJjYu1
 JORpkFSa+wVrT7N9kY0ibYNTQaQqitiLthn5FduIJyOStKzbV+cTyg5Nra/L/A==
Message-ID: <18a3d5e9-e630-d59e-e305-faba75c8f6d1@denx.de>
Date: Sat, 25 Jan 2025 07:16:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] led: add function naming option from linux
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250123114906.80724-1-hs@denx.de>
 <20250123143302.GI60249@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250123143302.GI60249@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 23.01.25 15:33, Tom Rini wrote:
> On Thu, Jan 23, 2025 at 12:49:06PM +0100, Heiko Schocher wrote:
> 
>> in linux we have the option to create the name of a led
>> optionally through the following properties:
>>
>> - function
>> - color
>> - function-enumerator
>>
>> This patch adds support for parsing this properties if there
>> is no label property.
>>
>> To be as close as possible to linux import the following files
>> from it:
>>
>> include/dt-bindings/leds/common.h
>> include/linux/uapi/linux/uleds.h
> [snip]
>> ---
>> as we introduce a new element in struct led_uc_priv, may we should add
>> this functionality through a new Kconfig option? (Which also would make
>> this optional and save some bytes for boards who do not need this...)
> [snip]
>>   arch/sandbox/dts/test.dts                | 37 ++++++++++++-
>>   doc/device-tree-bindings/leds/common.txt | 28 ++++++++++
>>   drivers/led/led-uclass.c                 | 70 ++++++++++++++++++++++--
>>   include/led.h                            |  6 ++
>>   test/dm/led.c                            | 22 +++++++-
>>   test/dm/ofnode.c                         |  2 +-
>>   6 files changed, 158 insertions(+), 7 deletions(-)
> 
> Getting things out of order slightly, sorry. The commit message should
> be updated a bit more still since we aren't copying files in. And we
> should delete doc/device-tree-bindings/leds/common.txt in a pre-patch
> because we have that from upstream now. As for size, how much is the

removed! And updated commit message

> growth? You can use tools/qconfig.py -b, and then -f LED to find some
> platforms to size compare before/after, and if you've not used buildman
> for size checking before I've put my script up over at
> https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/trini/u-boot-size-test.sh?ref_type=heads
> now for easier sharing.

Thanks for the script!

Here 2 examples:
$ ./u-boot-size-test.sh capricorn_cxg3 --branch led-mainline
[...]
    aarch64: (for 1/1 boards) all +886.0 rodata +230.0 text +656.0
             capricorn_cxg3 : all +886 rodata +230 text +656
                u-boot: add: 1/0, grow: 1/0 bytes: 416/0 (416)
                  function                                   old     new   delta
                  led_post_bind                              220     516    +296
                  led_colors                                   -     120    +120

$ ./u-boot-size-test.sh aristainetos2c --branch led-mainline
[...]
01: Merge patch series "add the support of sha256_hmac and sha256_hkdf"
40: led: add function naming option from linux
        arm: (for 2/2 boards) all +557.0 bss +20.0 rodata +161.0 text +376.0
             aristainetos2c : all +557 bss +20 rodata +161 text +376
                u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                  function                                   old     new   delta
                  led_post_bind                              128     332    +204
                  led_colors                                   -      60     +60
             aristainetos2ccslb: all +557 bss +20 rodata +161 text +376
                u-boot: add: 1/0, grow: 1/0 bytes: 264/0 (264)
                  function                                   old     new   delta
                  led_post_bind                              128     332    +204
                  led_colors                                   -      60     +60

So, may not worth to add a Kconfig option here... or?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
