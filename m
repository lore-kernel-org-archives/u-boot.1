Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB5CC79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 19:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B317240B7B;
	Fri,  4 Sep 2026 19:18:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOR7i4W6w0U3; Fri,  4 Sep 2026 19:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 867AB40AD4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549513;
	b=IutiI9eNv86Z2n3RRNYpYKaSI1mVToIIdDTiAHMfqBIJvG8AFZon1EeVJoW18LrPTlzW
	 5pr6ajgW9fU+CX8PT/uNVNCfP/bttpZ4LGJYesnf+Oiz2yoo5ILQ0VmgpHq9hGNSqNJL5
	 /J8a9Y3x+S6KOi3oVREeWnKb/UBwAE8FiE5NUM3bVqPIZr4/q/w5DFcOqQutshfWc8S2n
	 BtqwG7lUqyR9E4tId4UA0vehegNYU+ZhDXzuO58N+D/dFOOFhg3K4bkLHKGBaUQjoIp9D
	 zk0vQKxZm3m8q2Hovy8wUU7dJMS5ewfQjY1g6ZzBTgZn4DU35TRozi4XsUFmnokiV7Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788549513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=58KnlNaawtguXfx+Ew0VvNV3i9DL/4zFxg7Q1aIFMZk=;
	b=UpFRmWSMI7+CSlMYEwnY/w5J0NXR89omPT0hljmc/+3U8+EhZivXPh3yDGBJJAQTnsyF
	 jZIC5Se9tyjERnLZW4M+NLJm+hzr1SRfmuF3c9+vnSF/W+tQ4XVJkeXC0o/6s0+YpqDg2
	 QjjFF3ozwT/5tU8sJcwYswCyDj44ot8Q0hMBEjjTy7m4OScouOymPuoE1KQ0LbYwQztwo
	 HzTQpiBnvJeNAE8ZGhNZK4RM7WCVMWOXd6qr8aFDjmDCZBfF65SoQgxhWIrgCA0OA954e
	 zdH08ccVYfF+qlGEm7hqaVEbmp0UhcuIusEw7Dg+gUr6Y8jnqpBoGZIOSxlnoCj2wsw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788549513;
	bh=58KnlNaawtguXfx+Ew0VvNV3i9DL/4zFxg7Q1aIFMZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=veIZ2HTjAFiVWfeXTCp2QKusgIWNiWqK9owdXbkjBpA81g2HwUiLMzUQACMoGRsIJ
	 PM8Zk4zgWJjoNjjCyE5SJHYBAgRAgn6NnXHc2pyN6k88c3T8AqQpM+ErzHZGmXVc84
	 xohVHAny64OsrHfITpwC+n1kWBsPXhHDqtcyk/9DnUHMmub/hOy0tgGpj3+BjA9HPK
	 77gWA2sjWbh77Zan+ahwR6Yr6v4ZlGdRbSkOn8mz4U9OKIwsxJE3BIkDFJOH6KQk+n
	 +JbwrCK//5eZM/FzCUkPl8LEmwfbKmKKczgVLxMKi5yJ0SZW2w2+1WhPGPw5bNTtpa
	 nyYWmbfwnp8KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867AB40AD4;
	Fri,  4 Sep 2026 19:18:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C93A9388
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFA5280F19
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBXu-jGF_0YH for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 19:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7436480F17
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788549510;
 b=jet+1NDmkp2dLiwduBe2r9BzoTVMoVK8czx2SIZkXTlcV54+qlLFKp8DBq30uU+yVuZ8
 ANBfui5AUw+TfxYdQfskIzMilEyiEqgrRyc1rq2FW1Qni2ZzgcR5EiXn+mv+53FGWdisv
 DdITGZfXK5LnmgDmLVmR/asKkEaiYegnoHLXb7vcFR7bIdY5pwmLdmT+FgE+2ozGQYbWg
 Z3/wrHm1zzORgn3i1b2x305YZMIRqYwdqfAao1QTHDhC302Niw2vwO1PJkb0/MOqEXSSA
 35saYzvOOb8HRpcBCNV8zYjZcz38PEvx/mc5UaZSPnQXi3bcOqAn4XR5+EiQpT7oGOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788549510;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=58KnlNaawtguXfx+Ew0VvNV3i9DL/4zFxg7Q1aIFMZk=;
 b=X1dkAafswKVmxgoJl7z7gyp16INfOQTQpTIVxURJUKM5KIfBuqVIqeC/l/pN4pQy87mG
 Ig5Yvsh7QkJwfp4Q+awOqOe5iETgKf/AagQCZTy2QrwzzbBDnUvemCGXuoprvcXLUaKzn
 BQVB4xDvWH8QgpWtWmqpyClEg8MLNYWAhKGwVau3ixTCbqkClChntspvtcz8lDHJUO5f/
 Ks7CCO51dGufZwIgnOJtex0Z/zorWBdfbhni786YLOC8ImlHIA55s4tHGzuzH4n6KDw8G
 EVAddX3NetOPxyGo+FtYa+4P/ulC10jKdT2q2bTUmhXQUBqOhXnApd5Lr49M61sd/wA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b="Z7/Vi5IT"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Z7/Vi5IT
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7436480F17
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 19:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788549496; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GB1nwp6EstPnVWu/UYJGv1Jp9T+cZny5pXRoQ5sp0Xc73NCkiZ9KBurvu7lepNQjdnlJIlDZOI/jgbUG/U5K/fKrl/1SbAGPUDKztMakI0SxwvqPXLSM61n/ZD0X9++Pm1TKoF7jpM/IXjhsl6gBC3j0e4iPZBcM1voH3P4JHic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788549496;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=58KnlNaawtguXfx+Ew0VvNV3i9DL/4zFxg7Q1aIFMZk=; 
 b=A29KHJ/b562nqDvkFQU7BV9WsWlIh7gdVzIWS0PNa2aUx7vSQqIGGGayz+iBbtCaQ+C08J2ExQjr43XxelwdSn+iVtcKuC3Qyt+QRblKnZQSLe5CVR9zhaX4uHvJKMNcpJi2S86PTefUfb8hpQMKfeMEVf5N9hwtP6JaNssPp9I=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788549496; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=58KnlNaawtguXfx+Ew0VvNV3i9DL/4zFxg7Q1aIFMZk=;
 b=Z7/Vi5ITr9+mHwsI8KHEZdDq2WhLTqGir+yU/s/chaOJ8WqbEMRXHphuWhVWCKif
 XB22hU8ULhCAt1sd0sBwhU51c0pbO9zkLpK7zyQL2cd8FycLDIh+qh7SIzlHain4z0p
 5jAsaeJKw7HHsmBRRGHJdUZCRsHozVYdy7QfU5Co=
Received: by mx.zohomail.com with SMTPS id 1788549493168552.7783812857151;
 Fri, 4 Sep 2026 12:18:13 -0700 (PDT)
Date: Fri, 4 Sep 2026 19:17:55 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] riscv: timer: Fix M-Mode timer
Message-ID: <apsZY2QgTXuJUivy@pie>
References: <20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-riscv_fix_early_timer_mmode-v1-1-210e769b0ac2@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.530.38
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Sep 04, 2026 at 09:12:55AM +0300, Nikita Shubin wrote:
> RISC-V timer is missing timer_early_get_rate() for M-Mode.
> 
> Also timer_early_get_count() is guarded by RISCV_SMODE for no
> clear reason.

This driver is described as "support for a generic RISC-V S-Mode timer
driver", which should be the original reason to mark it as S-Mode only.
It should be intentionally to split M-mode (riscv_aclint_timer.c,
guarded by CONFIG_RISCV_ACLINT) and S-mode timers, since riscv_timer.c
reads ticks from TIME CSR, while at least SiFive cores miss it in
M-mode, and rely on OpenSBI to emulate them.

But this separation is indeed unnecessary, there are as well cores
implementing TIME CSR, so riscv_timer.c works on them even in M-mode,
too, e.g., T-Head ones.

I've summarized the situation here[1], but didn't find enough time and
energy to send out a series to fix issues up...

Anyway, please fix the Kconfig help text, too.

> Make timer_early_get_rate() use RISCV_MMODE_TIMER_FREQ in M-Mode and
> move timer_early_get_count() out of define.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/timer/riscv_timer.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
> index 1f4980ceb38..65f174fb879 100644
> --- a/drivers/timer/riscv_timer.c
> +++ b/drivers/timer/riscv_timer.c

At start of the file, a comment mentions "This driver provides generic
timer support for S-mode U-Boot". Please update it along the way.

> @@ -33,14 +33,22 @@ static u64 notrace riscv_timer_get_count(struct udevice *dev)
>  	return ((u64)hi << 32) | lo;
>  }
>  
> -#if CONFIG_IS_ENABLED(RISCV_SMODE) && IS_ENABLED(CONFIG_TIMER_EARLY)
>  /**
>   * timer_early_get_rate() - Get the timer rate before driver model
>   */
> +#if IS_ENABLED(CONFIG_TIMER_EARLY)
> +#if CONFIG_IS_ENABLED(RISCV_SMODE)
>  unsigned long notrace timer_early_get_rate(void)
>  {
>  	return RISCV_SMODE_TIMER_FREQ;
>  }
> +#elif CONFIG_IS_ENABLED(RISCV_MMODE)
> +unsigned long notrace timer_early_get_rate(void)
> +{
> +	return RISCV_MMODE_TIMER_FREQ;
> +}
> +#endif
> +#endif

For platforms like starfive_visionfive2_defconfig where both
CONFIG_RISCV_TIMER and CONFIG_RISCV_ACLINT are enabled, riscv_timer.c
and riscv_aclint_timer.c would each provide their own early timer
symbols and causing linking errors when building with defconfig.

These platforms might depend on the IPI functionality provided by
aclint_ipi.c, which is also guarded by CONFIG_RISCV_ACLINT; and
riscv_timer.c might not work on them, either, thus simply disabling
CONFIG_RISCV_ACLINT isn't an option.

Regards,
Yao Zi

[1]: https://lore.kernel.org/all/Z7dMY_GqLHsC-5gl@pie.lan/
