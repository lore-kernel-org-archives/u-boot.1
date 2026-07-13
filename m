Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4949B84BA3;
	Mon, 13 Jul 2026 17:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tyNjOGWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B1784BB4; Mon, 13 Jul 2026 17:02:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE68B84B8D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5a7b=FI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1783954962;
 bh=NGtZA0hr99g5IQtkGWUQW2FSf8pRjkzRVKHpeEh1wvQ=;
 b=tyNjOGWLtNJCkMk5T6nrLJonbN5S28Zcu/rqEn9b4zBUewQo4OPK2Ylgdsk+dW8DYXTfJqyCT
 90qIXrrl/yVwSliEYCYJ9bz5FRtFiVirkeNgFI2UlC/4HeYwhDZKMZYyVF0smYx8MlliEs0GtNS
 M8zHqXYqrXqvz7RwFuugNMj50X22R/UoydhVEaU7LdH8/2AsE5BvmdIOUJuUTkfVwQJ+lNzYjk/
 6XPc0dT+1X69/jHModkxpKVqyOd/uUja5/nVISRlHLaGfRAFwD246nIBuTsIN/MIWFXVf+Hw9iD
 L04c/0HHptPaFIfJzYZqYuWgSxIx7xIci7uzEImM3upg==
X-Forward-Email-ID: 6a54fe10c414db019cbe55ce
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.10.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <587d0ac0-000e-4b32-a806-f7bf69f284fd@kwiboo.se>
Date: Mon, 13 Jul 2026 17:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
 <CAFLszThMyQzP4FaF4DDhdkiJ_Rs6b41tUK36=x6bA2xQBYX-LA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszThMyQzP4FaF4DDhdkiJ_Rs6b41tUK36=x6bA2xQBYX-LA@mail.gmail.com>
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

On 7/13/2026 4:28 PM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
>> Kconfig: i2c: Depend on correct xPL symbol
>>
>> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
>> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
>> drivers/i2c/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
>> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
>> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
>>  config TPL_SYS_I2C_LEGACY
>>       bool "Enable legacy I2C subsystem and drivers in TPL"
>> -     depends on SUPPORT_TPL && !SPL_DM_I2C
>> +     depends on TPL && !TPL_DM_I2C
> 
> This also changes !SPL_DM_I2C to !TPL_DM_I2C, which fixes what looks
> like a copy-paste error, similar to the DM_SERIAL fix in the next
> patch. Please can you mention this in the commit message too? I
> checked the boards that enable TPL_SYS_I2C_LEGACY (the mpc85xx
> P1010RDB / P1020RDB / P2020RDB NAND configs) and none enables SPL_DM
> or TPL_DM, so there should no functional change, but it is worth
> recording that this dependency is also being corrected.

Sure and great, I will update commit message in v2.

> 
> With that (assuming you figure out what Tom raised):

It looked like SYS_I2C_EARLY_INIT is the culprit for size change.

See [1] for my findings, and I am still not sure if we can live without
the call to i2c_early_init_f() for the handful of possible affected
boards.

My gut feeling, without knowing anything about the affected platform,
says we should accept the dropped call to i2c_early_init_f() ;-)

[1] https://lore.kernel.org/u-boot/975a650f-88cf-4b2d-8f83-2df3f93ab25d@kwiboo.se/

Regards,
Jonas

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

