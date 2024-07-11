Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C23AC3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 08:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F6B88703;
	Thu, 11 Jul 2024 10:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720685388;
	bh=gBXWPXxZP7a8NdHvUpyg8fxcauELrk1D3eH08E5UYKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=teQz8X/5SlPhMgdEz4KoTL5KmsoxG+lqPqNMaOCw9oPM/oT6YdTJXqt6hgoegmLjA
	 rcVDOiEHRqgzt7z9PYuP2CQpQLPSsWKns4l1UHI9HIbVMdSeRmLud4ai+SXh5ug5uJ
	 0tP8pEbawe0OEBh02oGLE7pimzJ12WBQ8YxfCuWJP1CLfsogokX1SKjF8PiWplHc9z
	 3uaib/jpr2WxTDt1jZj2H+ejgm2D1RFpaW9x6tfMNltQoKvOYd4nBjKKU4EYp8B6ED
	 1nsMqFzEedZrOfK3SxGBoYCKGzNrQeFp4zlok0hy72zmGkqLARm993MqVqvigOWBcI
	 767gRe32OKVaQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A230E8876E; Thu, 11 Jul 2024 10:09:47 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B074D88630
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 10:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WKS7W2NStz9sbM;
 Thu, 11 Jul 2024 10:09:43 +0200 (CEST)
Message-ID: <8b1972b1-c3fa-4a14-b140-8b894f42f076@denx.de>
Date: Thu, 11 Jul 2024 10:09:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: bcm283x: remove pointless empty
 hw_watchdog_disable
Content-Language: en-US
To: Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
References: <20240710211730.2635847-1-rasmus.villemoes@prevas.dk>
 <CALeDE9NVen4Zd7Vv8c8hQwqGXPqCKrSniUaJinSXzSrzSM3syw@mail.gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <CALeDE9NVen4Zd7Vv8c8hQwqGXPqCKrSniUaJinSXzSrzSM3syw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4WKS7W2NStz9sbM
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

On 7/11/24 09:54, Peter Robinson wrote:
> On Wed, 10 Jul 2024 at 22:17, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
>>
>> This empty stub was originally added as one branch of an #ifdef in
>> commit 45a6d231b2f (bcm2835_wdt: support for the BCM2835/2836
>> watchdog). That incarnation of the rpi watchdog driver was later
>> removed in c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x
>> watchdog driver and its references), but this now-pointless stub was
> 
> You don't need a - in "now-pointless" and I think "now unused" is a
> better term, please update the subject too.
> 
>> left behind. The later (re-)added rpi watchdog driver does not define
>> a hw_watchdog_disable() function, as that is properly integrated in
>> the watchdog framework (i.e. not of the hw_* kind).
>>
>> Since it wasn't declared static, the compiler cannot even elide
>> it (though it does get inlined into the caller here, and the
>> out-of-line definition does get gc'ed by the linker).
> 
> All the things in () don't add value to this, please remove them.

I am a big friend of extensive commit messages, so IMHO all this
should stay in. If a developer is not interested in such details
he can skip these infos. Still if somebody feels strong here to
drop these infos, then I won't object.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>   arch/arm/mach-bcm283x/reset.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-bcm283x/reset.c b/arch/arm/mach-bcm283x/reset.c
>> index 9199234917f..1dc7ce50d1d 100644
>> --- a/arch/arm/mach-bcm283x/reset.c
>> +++ b/arch/arm/mach-bcm283x/reset.c
>> @@ -25,8 +25,6 @@
>>   /* max ticks timeout */
>>   #define BCM2835_WDOG_MAX_TIMEOUT       0x000fffff
>>
>> -void hw_watchdog_disable(void) {}
>> -
>>   __efi_runtime_data struct bcm2835_wdog_regs *wdog_regs;
>>
>>   static void __efi_runtime
>> @@ -34,10 +32,9 @@ __reset_cpu(struct bcm2835_wdog_regs *wdog_regs, ulong ticks)
>>   {
>>          uint32_t rstc, timeout;
>>
>> -       if (ticks == 0) {
>> -               hw_watchdog_disable();
>> +       if (ticks == 0)
>>                  timeout = RESET_TIMEOUT;
>> -       } else
>> +       else
>>                  timeout = ticks & BCM2835_WDOG_MAX_TIMEOUT;
>>
>>          rstc = readl(&wdog_regs->rstc);
>> --
>> 2.45.2
>>

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
