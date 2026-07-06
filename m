Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F572C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 09:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46038807C4;
	Mon,  6 Jul 2026 11:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dEviLAe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C02D884105; Mon,  6 Jul 2026 11:04:15 +0200 (CEST)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3F980398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 11:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783328651; x=1783587851;
 bh=ruNJbJPVDEiiRNfG4Vml8YK3OehgQViddcD9327cnrc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dEviLAe3CyI6AHjRwRHgzIkYuNVZK38XYkJjJflFxhXxvOUD7IMV0+TytfSWZ8l7M
 iFPai/kop1W25d17yr+tHYBIQc77zgyZab8CXx+e2YHl5Ap84dhiuVppJoBfNA5fW6
 R0TSt31z6qQ5ZN72MeAHjxJE4EBpZ87quZbOBDCVjKJQ5HA2j2fwCKNeaVJx1pDJIe
 vD5xLWJQ2WsvGRUT+hkdz9hV39b7njlukyuYE1FDIjm9qHTPpFGN0i68ybOiL7yspj
 8lb4U9yNEjN4yP6wW4xk2X4LEqu5gCdR1hU142xo8w9KuZlKUx0GeFqYvFzrFVm/CU
 deDjmp6/I16/A==
X-Pm-Submission-Id: 4gtz1j743Yz2ScmJ
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: "Patrice Chotard" <patrice.chotard@foss.st.com>
Cc: <u-boot@lists.denx.de>,  "Stefan Roese" <stefan.roese@mailbox.org>,
 "Tom Rini" <trini@konsulko.com>,  "Marek Vasut" <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
In-Reply-To: <20260703-optimize_cyclic_run-v2-2-81762cff0b17@foss.st.com>
 (Patrice Chotard's message of "Fri, 03 Jul 2026 12:12:45 +0200")
References: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
 <si6XBH4Bxhdlhio2J4oJEDmHBeZYLa-W8YwddESQB-JgOw43EpfwAPNbrY_dFeXyeUQtW-xV6Bi8nSRc9IDAzA==@protonmail.internalid>
 <20260703-optimize_cyclic_run-v2-2-81762cff0b17@foss.st.com>
Date: Mon, 06 Jul 2026 11:04:08 +0200
Message-ID: <87qzlgwktz.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jul 03 2026, "Patrice Chotard" <patrice.chotard@foss.st.com> wrote:

> On STM32MP157C-DK2, when using the "ums" command, in sleep_thread(),
> ctrlc() is called every ~640ms which doesn't allows high reactivity when
> user press CTRL+C in U-Boot console.
>
> In sleep_thread() loop, ctrlc() is called every 200000 iterations.
> But schedule is called on each loop iteration.
>
> Optimize cyclic_run() in order to parse the cyclic list only is the
> next cyclic to run is due.
> During cyclic list parsing, save the nearest cyclic timestamp, which
> allows to exit from next cyclic_run() call if no cyclic will be executed.
>
> This allow to save computation time :
>   _ before : ctrlc() is called every ~640ms
>   _ after  : ctrlc() is called every ~230ms
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>  common/cyclic.c                   | 16 ++++++++++++++++
>  include/asm-generic/global_data.h |  4 ++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/common/cyclic.c b/common/cyclic.c
> index b37cd6d8ff0..10ea0711ba1 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -68,11 +68,17 @@ static void cyclic_run(void)
>  	struct cyclic_info *cyclic;
>  	struct hlist_node *tmp;
>  	u64 now, cpu_time;
> +	u64 next_call = UINT64_MAX;
>
>  	/* Prevent recursion */
>  	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>  		return;
>
> +	/* check if the next cyclic function's timestamp is reached */
> +	now = get_timer_us(0);
> +	if (time_after_eq64(gd->next_cyclic_call, now))
> +		return;
> +
>  	gd->flags |= GD_FLG_CYCLIC_RUNNING;
>  	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>  		/*
> @@ -102,7 +108,17 @@ static void cyclic_run(void)
>  				cyclic->already_warned = true;
>  			}
>  		}
> +		if (next_call > cyclic->next_call) {
> +			next_call = cyclic->next_call;
> +			/* move this cyclic to list's head */
> +			hlist_del(&cyclic->list);
> +			hlist_add_head(&cyclic->list, cyclic_get_list());
> +		}
>  	}
> +
> +	if (next_call != UINT64_MAX)
> +		gd->next_cyclic_call = next_call;

Are you sure this is correct? There are at least two things I can think
of that might be wrong:

(1) Doing > or < comparison (as done in the next_call > cyclic_next_call
line), that should never be done, because the logic around timestamps is
that we do allow wrapping, assuming the two timestamps being compared
never represent absolute times that differ by more than what can be
represented in the signed version of the timestamp type - that's why the
time_after*/time_before* family do a subtraction and a signed compare
to 0.

(2) What happens if we have a single cyclic consumer registered, with a
rather long period (say 1s), hence a long time till its next_call, then another
cyclic consumer is registered which should be called every 50ms. Since I
don't see anything added to cyclic_register(), it seems that the new
consumer would be ignored for almost a second?

I'm also not really sure what the "move the first expiring timer to the
head" logic is supposed to achieve. Either way, if any timer has
expired, we'll run through the whole list, so while the first expiring
timer would then be handled first on the next cyclic_run(), that doesn't
mean we'll save any runtime. And this exercise seems to be about doing as
little as possible in cyclic_run(), so can you explain what the pointer
juggling does?

I assume that what makes cyclic_run() somewhat expensive isn't actually
running through the cyclic_list(), but the get_timer_us() calls done for
each entry. Could you try to see what something like this (entirely
untested, but you get the idea) would do:

diff --git a/common/cyclic.c b/common/cyclic.c
index ec952a01ee1..2616c4d5bc6 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -67,26 +67,28 @@ static void cyclic_run(void)
 {
        struct cyclic_info *cyclic;
        struct hlist_node *tmp;
-       uint64_t now, cpu_time;
+       uint64_t now, after, cpu_time;
 
        /* Prevent recursion */
        if (gd->flags & GD_FLG_CYCLIC_RUNNING)
                return;
 
        gd->flags |= GD_FLG_CYCLIC_RUNNING;
+       now = get_timer_us(0);
        hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
                /*
                 * Check if this cyclic function needs to get called, e.g.
                 * do not call the cyclic func too often
                 */
-               now = get_timer_us(0);
                if (time_after_eq64(now, cyclic->next_call)) {
                        /* Call cyclic function and account it's cpu-time */
                        cyclic->next_call = now + cyclic->delay_us;
                        cyclic->func(cyclic);
+                       after = get_timer_us(0);
                        cyclic->run_cnt++;
-                       cpu_time = get_timer_us(0) - now;
+                       cpu_time = after - now;
                        cyclic->cpu_time_us += cpu_time;
+                       now = after;
 
                        /* Check if cpu-time exceeds max allowed time */
                        if ((cpu_time > CONFIG_CYCLIC_MAX_CPU_TIME_US) &&

Because the time_after_eq64() test really doesn't take anywhere near a
micro-second, nor does fetching the next element from the linked list,
so using the same value for "now" until we actually do hit an expired
timer should be ok.

[I also want to move the computation of the new cyclic->next_call to
after the callback, so that the callback can update its ->delay_us value
if it needs to be called at another frequency, but that's a separate
topic.]

Rasmus
