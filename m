Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1569FF8D762
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 16:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC4983FC0;
	Thu, 16 Apr 2026 18:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="WXaSZ5sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1758407E; Thu, 16 Apr 2026 18:37:27 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76FFB83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 18:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 16 Apr 2026 16:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776357442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELaY8TrMSd+sKTO9jt/qP1cuHAYWp5L6umjH4XkkH/c=;
 b=WXaSZ5sxNF95JvFowtlwihm0yDNgKmfSi4/igRcWFzpms/tO+0lFHd2X9vyOb+MxpXypca
 a7eiuPNBgHUk6LERpJqCv7YvMVlUkHUUHU9XWteAMa6bvOeCqkJOYkUtWkCEgeEVA123v5
 7/F3y+Cw4QykMtr+V9fOjuLJ0eR/c1PGJ65N+QxRAhfPmSiYAMZKFKM4ShTyQSJDiJPPfq
 7Utn9xbRVQElPT6Evw7DNSk3gJoh6ECIUdAbgW5U7EH/ylWHlG/BNlg2wTypr9hAShrpK9
 xNUEbCkvp5c9RTQCWVI9h/YzDRKQVQdLgIvGmzvzq09k5iiRkRHa3bwi6nZjkA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent (TI.com) <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v4 4/4] doc: usage: autoboot: update content
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
 <816f3c33-8a7f-42b8-8461-0d89521d66b6@gmx.de>
In-Reply-To: <816f3c33-8a7f-42b8-8461-0d89521d66b6@gmx.de>
Message-ID: <tdli60.32el09vzaixrw@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Thu, 16 Apr 2026 15:49, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>On 4/16/26 16:57, Ferass El Hafidi wrote:
>> The autoboot documentation is quite outdated. While converting to rST
>> for being publicly accessible in the docs website, document all basic
>> autoboot options in there instead of referring to the README (which
>> no longer mentions any autoboot configuration option), and don't instruct
>> defining CONFIG_AUTOBOOT_PROMPT with a C #define (as CONFIG_ options may
>> only be defined in Kconfig).
>> 
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>>   doc/usage/autoboot.rst | 31 ++++++++++++++++++++-----------
>>   1 file changed, 20 insertions(+), 11 deletions(-)
>> 
>> diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
>> index 3b6f040008b..5d16fd2c3a2 100644
>> --- a/doc/usage/autoboot.rst
>> +++ b/doc/usage/autoboot.rst
>> @@ -3,18 +3,28 @@
>>   .. (C) Copyright 2001
>>   .. Dave Ellis, SIXNET, dge@sixnetio.com
>>   
>> -Using autoboot configuration options
>> -====================================
>> +Autoboot configuration options
>> +==============================
>>   
>> -The basic autoboot configuration options are documented in the main
>> -U-Boot README. See it for details. They are:
>> +The basic autoboot configuration options are:
>>   
>> -::
>> +CONFIG_BOOTDELAY, "bootdelay" environment variable
>> +    The "bootdelay" environment variable sets the delay in seconds
>> +    before automatically booting.
>>   
>> -        bootdelay
>> -        bootcmd
>> -        CONFIG_BOOTDELAY
>> -        CONFIG_BOOTCOMMAND
>> +    To disable the delay, it can be either set to 0 (to still accept key
>> +    input to stop booting) or -2 (to also disable listening for key input).
>> +    Setting to -1 has the effect of disabling autoboot.
>> +
>> +    The corresponding configuration option defines the default value of
>> +    the "bootdelay" variable.
>> +
>> +CONFIG_BOOTCOMMAND, "bootcmd" environment variable
>> +    The "bootcmd" environment variable defines the command that is run if
>> +    the user does not cancel the boot process.
>> +
>> +    The corresponding configuration option defines the default value of
>> +    the "bootcmd" variable.
>>   
>>   Some additional options that make autoboot safer in a production
>>   product are documented here.
>> @@ -84,8 +94,7 @@ CONFIG_AUTOBOOT_PROMPT
>>   
>>       ::
>>   
>> -        #define CONFIG_AUTOBOOT_PROMPT \
>> -                "\rBooting in %d seconds"
>> +        \rBooting in %d seconds
>
>The default is 'Autoboot in %d seconds\n'.
>
>Why would you put a carriage return at the start?

See patch 1/4 that makes AUTOBOOT_PROMPT be used regardless of
AUTOBOOT_KEYED. When AUTOBOOT_KEYED is disabled the default
AUTOBOOT_PROMPT is "\rHit any key to stop autoboot: %d".
It is only "Autoboot in %d seconds\n" when AUTOBOOT_KEYED is also
enabled.

--
Best regards,
Ferass
