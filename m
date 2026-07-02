Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A98C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 22:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9690848BF;
	Fri,  3 Jul 2026 00:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BVAwz50S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VvHRPArh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D7884832; Fri,  3 Jul 2026 00:10:32 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8768848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 00:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4grrfs3Xf0z9tRP;
 Fri,  3 Jul 2026 00:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783030229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv9RFWCW1IA/8QbKN6+j/LW7yBUtjSsJq4qHN8V8qsg=;
 b=BVAwz50SmpWOeOKllQ+g1zGBdRwRzXFvBXUM1oytTcUmVhLXr26N8lWEPHAcyOg1q1QaJ/
 3xtiDxLZNSsPbAHJMqGCRQjTg8OKjxNUTQ2ocztFTXKLD3/y9Hn413897KXFLRHyZYeY6W
 SET+hpuC/kW1DMo1Q4fIt+xgJYXRLWcUWVjZyoUaIPIEYPOO33KSMjUy0stCmAFP2SJeHi
 PdsOwPFc63UJH0oRz9Bz9e1Kcu7vmT2J2qruoFX2nkQIJgEQsszhqODp//4/i/P/DCcmK8
 4IYcp01+wn93lTzFcwPqyzkg/y249EG0umQKSLFHG8uIXIyak2YvKdOKVwg5Fw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VvHRPArh;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783030227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv9RFWCW1IA/8QbKN6+j/LW7yBUtjSsJq4qHN8V8qsg=;
 b=VvHRPArhqNjmNssCCTgYOY4PlVTR/rs6XkdJ2LH5PBA+t9mCrgHu6827m+I4mUgeJBSP5+
 5iElQWP4j6bnaQJhh5mIRZmeFMIwAhBT7hhJ8h8Y0m8PdYIeLLUSfrEVeAQ/ghdKKFtfGQ
 ReE9Bs4R2zHcikKbTgFzkJbKa7MpzIqc/ii3WiTS4aCvg3mFRXXYcP2cBON/9fdAwBhOgj
 HdfKjjNPR29KRtVIp1ThrwDFlYDPpaTCo574uayJdiJkiNL2xyP2xrzSBhqb3nDP8COMtM
 gBmRExNpzHOJHRC4xXyHlAPSBXxTCzHPmS0oW4qZvM0taDkiVScuzyP168t5bg==
Date: Fri, 3 Jul 2026 00:10:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bc777a47be63cf969c9
X-MBO-RS-META: 7pacd7xqqagzpoege83axpakdzg9fkmf
X-Rspamd-Queue-Id: 4grrfs3Xf0z9tRP
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

On 7/2/26 5:24 PM, Patrice Chotard wrote:
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
>    _ before : ctrlc() is called every ~640ms
>    _ after  : ctrlc() is called every ~230ms
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>   common/cyclic.c                   | 12 ++++++++++++
>   include/asm-generic/global_data.h |  4 ++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/common/cyclic.c b/common/cyclic.c
> index b37cd6d8ff0..714d6863d5b 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -68,11 +68,17 @@ static void cyclic_run(void)
>   	struct cyclic_info *cyclic;
>   	struct hlist_node *tmp;
>   	u64 now, cpu_time;
> +	u64 next_call = UINT64_MAX;
>   
>   	/* Prevent recursion */
>   	if (gd->flags & GD_FLG_CYCLIC_RUNNING)
>   		return;
>   
> +	/* check if the next cyclic function's timestamp is reached */
> +	now = get_timer_us(0);
> +	if (time_after_eq64(gd->next_cyclic_call, now))
> +		return;
> +
>   	gd->flags |= GD_FLG_CYCLIC_RUNNING;
>   	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>   		/*
> @@ -102,7 +108,13 @@ static void cyclic_run(void)
>   				cyclic->already_warned = true;
>   			}
>   		}
> +		if (next_call > cyclic->next_call)
> +			next_call = cyclic->next_call;

Can you move this entry to the beginning of the cyclic list, so that the 
entry with the earliest deadline would be right at the beginning of the 
list ? That should squeeze some more improvement out of this I think.

>   	}
> +
> +	if (next_call != UINT64_MAX)

Can the next_call literally hit UINT64_MAX in that one unlikely case ?
You likely do need a separate flag, bool next_call_valid, to avoid that 
edge case.

> +		gd->next_cyclic_call = next_call;
> +
>   	gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
>   }
Thank you !
