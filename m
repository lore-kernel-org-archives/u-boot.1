Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A41D0E6FC
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 11:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AFC88D5C;
	Tue, 22 Oct 2024 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729595538;
	bh=isho2ILFY4PguhNGtG/Y7/m0du5wnynEan+P2GEIxyk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W0NGM5y2dKDnS1lYA/gNnYdakOteDMKGCeDylXLC/y2FpBZ5f7wo5sb20/qPXoqTx
	 lx0k0uWPyxwd46oTaUCnPhSB45e0hJzLLi7uyxibWGDRqNWcU+5L+thkIWDaewput/
	 I8qwO0VqxJ9IIW/RIClb1BvjrJWsVthSZqufy0ZjZiquRhKhp9fEh1BcvWUwf3ut7W
	 +axMs1YIggN9BwlLePbAmKh+Y9HP2u9HHk8O6pr+bmz7dSdFP7MGejuNZrAXU2DHWf
	 HRfiMXn8TJOJ01pIRmQCFJF10ilrb0YDuxwvOKE7JObyckTlgFTee9tX5lBijiztxz
	 OxDnS3Q9CxcdQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F8C488D8D; Tue, 22 Oct 2024 13:12:18 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774CC8641A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 13:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XXqJZ2xn3z9sRJ;
 Tue, 22 Oct 2024 13:12:14 +0200 (CEST)
Message-ID: <55ae2931-b5e8-43dc-90a0-3108755505bf@denx.de>
Date: Tue, 22 Oct 2024 13:12:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 06/13] test: dm: wdt: replace cyclic_run() by schedule()
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-7-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241003212802.3810-7-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XXqJZ2xn3z9sRJ
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

On 10/3/24 23:27, Rasmus Villemoes wrote:
> This is the last place outside of cyclic.c that references
> cyclic_run() directly. Replace by schedule(), so that cyclic_run() can
> be made private. This also better matches what I believe commit
> 29caf9305b6f ("cyclic: Use schedule() instead of WATCHDOG_RESET()")
> intended to do.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   test/dm/wdt.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> index 1df2da23c6c..4d751b7e8cf 100644
> --- a/test/dm/wdt.c
> +++ b/test/dm/wdt.c
> @@ -3,7 +3,6 @@
>    * Copyright 2017 Google, Inc
>    */
>   
> -#include <cyclic.h>
>   #include <dm.h>
>   #include <time.h>
>   #include <wdt.h>
> @@ -14,6 +13,7 @@
>   #include <test/test.h>
>   #include <test/ut.h>
>   #include <linux/delay.h>
> +#include <u-boot/schedule.h>
>   #include <watchdog.h>
>   
>   /* Test that watchdog driver functions are called */
> @@ -131,7 +131,7 @@ static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
>   	/* Neither device should be "started", so watchdog_reset() should be a no-op. */
>   	reset_count = state->wdt.reset_count;
>   	val = sandbox_gpio_get_value(gpio, offset);
> -	cyclic_run();
> +	schedule();
>   	ut_asserteq(reset_count, state->wdt.reset_count);
>   	ut_asserteq(val, sandbox_gpio_get_value(gpio, offset));
>   
> @@ -141,19 +141,19 @@ static int dm_test_wdt_watchdog_reset(struct unit_test_state *uts)
>   
>   	/* Make sure both devices have just been pinged. */
>   	timer_test_add_offset(100);
> -	cyclic_run();
> +	schedule();
>   	reset_count = state->wdt.reset_count;
>   	val = sandbox_gpio_get_value(gpio, offset);
>   
>   	/* The gpio watchdog should be pinged, the sandbox one not. */
>   	timer_test_add_offset(30);
> -	cyclic_run();
> +	schedule();
>   	ut_asserteq(reset_count, state->wdt.reset_count);
>   	ut_asserteq(!val, sandbox_gpio_get_value(gpio, offset));
>   
>   	/* After another ~30ms, both devices should get pinged. */
>   	timer_test_add_offset(30);
> -	cyclic_run();
> +	schedule();
>   	ut_asserteq(reset_count + 1, state->wdt.reset_count);
>   	ut_asserteq(val, sandbox_gpio_get_value(gpio, offset));
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
