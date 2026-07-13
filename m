Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABCAC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFB984B64;
	Mon, 13 Jul 2026 17:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Qbf/KFM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C96184B77; Mon, 13 Jul 2026 17:10:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F5384AED
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5a7b=FI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783955441;
 bh=2dm6VvP5ibDpbk1m/zvGT/ZUdkm3I74kCV4QWafW1+k=;
 b=Qbf/KFM0wypzIJs7Ng2S+Q6LFmBWWx1tJcgMUzKMwnV1BSmCtBBOHGbBmiYcYbgGRRmMVF8FK
 SzRgG7c5hJzvyD3tCcVfxOuglUL8Sa2j6zBdRb8WIHrFtf9/UBDKYGU0fY0uZ0JrNjd8+mmoeB+
 aLWOLW/Svn/WVMYFXzUgg3GpCB+diihaXomkFHn2f+R/IQml2tQNpsw35vBJ6ohcU/N6AHZDccN
 i2UcdetIweiszHvxJHlgMvodLhPX+DNrCzvJlswhGmPy+P+s9Ks4U5AxgDU89hzJJYY0Vv38Xo3
 prZndr/UO9qi2wrKSLEXiS+kD2Sl/Qs/5FdjVYLq9Djg==
X-Forward-Email-ID: 6a54ffedc414db019cbe5b8a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.10.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c3739f28-d508-4b0d-bf7b-628c88a8d0df@kwiboo.se>
Date: Mon, 13 Jul 2026 17:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] Kconfig: serial: Depend on correct xPL symbol
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-10-jonas@kwiboo.se>
 <CAFLszTgPO+zQybrxDMwDgmY6XJWryVCJnGBQNRy0JephytBhZg@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgPO+zQybrxDMwDgmY6XJWryVCJnGBQNRy0JephytBhZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 7/13/2026 4:30 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
>> Kconfig: serial: Depend on correct xPL symbol
>>
>> Change xPL_SERIAL_PRESENT symbols to depend on the xPL_DM_SERIAL symbol
>> intended for the related xPL phase instead of the DM_SERIAL symbol
>> used for U-Boot proper to make CONFIG_IS_ENABLED(SERIAL_PRESENT) guards
>> work as intended.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/serial/Kconfig | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> @@ -81,7 +81,7 @@ config SPL_SERIAL_PRESENT
>>  config TPL_SERIAL_PRESENT
>>       bool "Provide a serial driver in TPL"
>> -     depends on DM_SERIAL && TPL
>> +     depends on TPL_DM_SERIAL
> 
> BTW this makes the workaround in ns16550.c redundant:
> 
>     /* TODO(sjg@chromium.org): Integrate this into a macro like
> CONFIG_IS_ENABLED */
>     #if !defined(CONFIG_TPL_BUILD) || defined(CONFIG_TPL_DM_SERIAL)
> 
> That guard sits inside CONFIG_IS_ENABLED(SERIAL_PRESENT), which with
> this change already implies TPL_DM_SERIAL in a TPL build. Please can
> you add a patch to drop it? I'd be happy to see that hack go :-)

Sure, I will add a patch to drop this in v2.

I was initially unsure if we needed this after the
CONFIG_IS_ENABLED(SERIAL_PRESENT) change, so decided to ignore it.

Very good to have confirmation that this indeed no longer is needed :-)

> 
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> @@ -91,7 +91,7 @@ config TPL_SERIAL_PRESENT
>>  config VPL_SERIAL_PRESENT
>>       bool "Provide a serial driver in VPL"
>> -     depends on DM_SERIAL && VPL
>> +     depends on VPL_DM_SERIAL
> 
> Just below this, the help text says 'This option enables the full UART
> in TPL' where it should say VPL - it would be nice to fix it here or
> in a follow-up.

Sure, I will include a fix for this typo in v2.

Regards,
Jonas

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

