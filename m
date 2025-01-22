Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C361C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CCB807F9;
	Wed, 22 Jan 2025 16:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737559024;
	bh=9qAVgvb3Cn3zSOVpmI5I0KrISk6mwAgbqLIxnVTD1o0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DT5hX3uz/BUK4sL4Asnegjt2fb3FlT+AvWvA7tWIeXvPG0oxPW4H5PrMWiCjm/8Gp
	 Yyn6F6EfBhtY6Alr+HtszndzSiRoYZ7ahy/ChZJ3HqWkwH9PTySq72TK9e8S1EC3Ay
	 huavKCexHLWj4I8Or2S6+50WWSvJRNSTERyqroIJHEHClpP+EkHpeOroOVFUtVn7kr
	 TIiIW7rnBCxHGmwxCeE4zG6wxatf9bq90A2MqUSPnIyfATnKpntiHu5SSRoe6dUkM1
	 1V0aoMBxSY4S+h47g8dX0qpq9nZqbYQmBkZiHqT2ignpTBrIR5NJ7Oihnt6zOX8AQs
	 J6MigU5O2awsw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D9680817; Wed, 22 Jan 2025 16:17:04 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337F18078B
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YdSNW5d7Xz9sch;
 Wed, 22 Jan 2025 16:16:59 +0100 (CET)
Message-ID: <f161fd16-0251-4266-b007-3e7b9ed6431f@denx.de>
Date: Wed, 22 Jan 2025 16:16:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] cyclic: Fix rollover every 72 min on 32 bits
 platforms
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250114132814.1250117-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250114132814.1250117-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4YdSNW5d7Xz9sch
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

On 14.01.25 14:28, Patrice Chotard wrote:
> On 32 bits platforms, timer_get_us() returns an unsigned long which
> is a 32 bits. timer_get_us() wraps around every 72 minutes
> (2 ^ 32 / 1000000 =~ 4295 sec =~ 72 min).
> 
> So the test "if time_after_eq64(now, cyclic->next_call)" is no more
> true when cyclic->next_call becomes above 32 bits max value (4294967295).
> 
> At this point after 72 min, no more cyclic function are
> executed included watchdog one.
> 
> Instead of using timer_get_us(), use get_timer_us() which returns a
> uint64_t, this allows a rollover every 584942 years.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> Changes in v2:
>        _ Replace remaining timer_get_us() by get_timer_us(0)

Applied to u-boot-watchdog/master

Thanks,
Stefan

> 
>   common/cyclic.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 196797fd61e..fad071a39c6 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -36,7 +36,7 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>   	cyclic->func = func;
>   	cyclic->name = name;
>   	cyclic->delay_us = delay_us;
> -	cyclic->start_time_us = timer_get_us();
> +	cyclic->start_time_us = get_timer_us(0);
>   	hlist_add_head(&cyclic->list, cyclic_get_list());
>   }
>   
> @@ -61,13 +61,13 @@ static void cyclic_run(void)
>   		 * Check if this cyclic function needs to get called, e.g.
>   		 * do not call the cyclic func too often
>   		 */
> -		now = timer_get_us();
> +		now = get_timer_us(0);
>   		if (time_after_eq64(now, cyclic->next_call)) {
>   			/* Call cyclic function and account it's cpu-time */
>   			cyclic->next_call = now + cyclic->delay_us;
>   			cyclic->func(cyclic);
>   			cyclic->run_cnt++;
> -			cpu_time = timer_get_us() - now;
> +			cpu_time = get_timer_us(0) - now;
>   			cyclic->cpu_time_us += cpu_time;
>   
>   			/* Check if cpu-time exceeds max allowed time */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

