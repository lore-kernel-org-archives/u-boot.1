Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41313C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B023B8210D;
	Thu,  8 May 2025 09:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746689229;
	bh=kyZyK3LhRmza4OlUSF+0AQjyTapvei1TPh30GVgFstw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpfqfIOsVfo6vkPDHjbAAAg741BSmR474VzSKaMDDY+io5cPGwfbEo80gVhRk3alt
	 lQwvzNLwQLPrToVLlzkLZgIGrLewUYYtPLZRzKeP1uyBY6fC3cWTw1xi2uiLtB7Vhs
	 m9YIdM1uz9Kav6DNctIdx/CQ5nVEK/kzk3x9GHku0rf+OMJzKw9xAn5Kho1wIwe1AG
	 3mmZlwQ1SKGtIkKi5ZhK7LwqmDIHtZBeg1JL/yCmX9p9lfKyB649X9cdudMlFHEtLi
	 fLsIrYwOzYJzfCpq0uH51jruSp0RL+Jzq1e9fCk3b0iNVPnPT/+g8ipPC7q0zj9dIn
	 vMLKvxUKcznSw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA578211F; Thu,  8 May 2025 09:27:08 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A28F8059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZtNxM2rhvz9sqP;
 Thu,  8 May 2025 09:27:03 +0200 (CEST)
Message-ID: <eec062a0-dd7a-48e7-886e-507a1345d0da@denx.de>
Date: Thu, 8 May 2025 09:27:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] cyclic: make cyclic_register safe to call on
 already-registered info
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250507105821.484442-1-ravi@prevas.dk>
 <20250507105821.484442-3-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250507105821.484442-3-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZtNxM2rhvz9sqP
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

On 07.05.25 12:58, Rasmus Villemoes wrote:
> Now that cyclic_unregister() is safe to call on a not-registered
> cyclic_info, we can make cyclic_register() behave like the mod_timer()
> and hrtimer_start() APIs in linux, in that they don't distinguish
> between whether the timer was already enabled or not; from the point
> of the call it is, with whatever timeout/period is set in that most
> recent call.
> 
> This avoids users of the cyclic API from separately keeping track of
> whether their callback is already registered or not, and even if they
> know it is, can be used for changing the period (and/or the callback
> function) without first doing unregister().
> 
> See also this recent'ish message from kernel maintainer Thomas
> Gleixner on that API design for timer frameworks:
> 
>    https://lore.kernel.org/lkml/87ikn6sibi.ffs@tglx/
> 
>    First of all the question is whether add() and mod() are really
>    valuable distinctions. I'm not convinced at all. Back then, when we
>    introduced hrtimers, we came to the conclusion that hrtimer_start()
>    is sufficient.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Many thanks for digging into this and improving this cyclic interface
over the time.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   common/cyclic.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 75662d9f613..ec952a01ee1 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -43,6 +43,8 @@ static bool cyclic_is_registered(const struct cyclic_info *cyclic)
>   void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>   		     uint64_t delay_us, const char *name)
>   {
> +	cyclic_unregister(cyclic);
> +
>   	memset(cyclic, 0, sizeof(*cyclic));
>   
>   	/* Store values in struct */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

