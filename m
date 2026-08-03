Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAB3C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE565607AD;
	Mon,  3 Aug 2026 12:27:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Q1-DMeEaOMv; Mon,  3 Aug 2026 12:27:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E75CF60791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785760053;
	bh=lkCxH0k/Z5yI9mUAsmnpBMVdBZs8GkFJL3igiMtmHpA=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=uesdfHgmWAZ1EFsd6M9eDeTIC94xvvX7J6OpKAHqYjTiiKCjdbGZ9EKgwf3ZyUR5k
	 csk9sK7SCqZMpc4RaMuKVHlvAN3coaO2nM9gtOr2pFyo7KmlUPBt1Wji8LY1oMp1Vy
	 9kp85Uu8idKBBq0PAQxBg4G3suk2cesg+uVFdAlWyj8yKD6/KuGrai8Zur0IdR+3jh
	 BDAdKhXsczU2qwVOGXKDFqB6UTqYNIVSRnrGRlrlMYnHx3mafakQNRGo7Bu2ZMQqVP
	 BpBH0pc4lxjZRZ5QivHI7Ae6bGtqqdcy6PcxbpZa7Sq2vimIUZsD2q2Ax0PcaRsSLn
	 mAYECiuXdW7cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E75CF60791;
	Mon,  3 Aug 2026 12:27:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BA90218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1907D6079D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rwEuKiowOatQ for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:27:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E4C696072F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4C696072F
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4C696072F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:27:29 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hDGCM3kh0zMlG1;
 Mon, 03 Aug 2026 14:27:27 +0200 (CEST)
Message-ID: <2949c427-c5d9-4105-9b5c-45cf194e5a3e@mailbox.org>
Date: Mon, 3 Aug 2026 14:27:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] cyclic: get rid of cyclic_get_list() helper
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>, u-boot@lists.u-boot-project.org
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
Content-Language: en-US
In-Reply-To: <20260730105515.421677-1-rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: r5nhjfrp43qj49fcrs3tdcgb379z7hct
X-MBO-RS-ID: 00b01ddfa1b209740db
X-Rspamd-Queue-Id: 4hDGCM3kh0zMlG1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkCxH0k/Z5yI9mUAsmnpBMVdBZs8GkFJL3igiMtmHpA=;
 b=SVROxzGT7bk5GZO/RU+Ypu0vc9q/qDEprYkVf1c4xRlyEs3T7qf8HRvXm2Y8YZS7g7LuRC
 UK2DeNYGKFZGyA2YdY8OPP4QCW0Tu0uC7sQw4d1aD6EsUz4APaNbtLaLJT/6on598G9i47
 zLY72JIaYZKePFDegQceKi6XTPzwxAhUFPG+9gVCIO7xrTUksVYaiaK0QQP0e43mKGYncr
 zD8bOboWQSBjhEGWfu0bjd8iIY1q0OvAuLayMbcDLJWzdCI8FaWOpvS4RctEGWcjHEPOl+
 DqrMGP09NM5rQ/HHKO1e4RIV757Ci9uxDYNUtdFc/koV1LJNiDCVfXCz4yC3Cw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785760045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lkCxH0k/Z5yI9mUAsmnpBMVdBZs8GkFJL3igiMtmHpA=;
 b=d4wPCJyBNMcWm2+pe//O2st0++ZsIj8FSJbJ552khlCUPbtErzZW4DHS7Iaojp7f68PPlr
 oNdNW5vu7NHh9EFktwS092pp80qHmYDiqzJgg+EnbKslnw21juHVhoCk04FHz4rszm6CO3
 EzfCDxjU+k84bBBQjMUsUIXe0rVPxQDbf6w5O5jK2zSHbMl+BNd4vQknzzvICtpSt3/IeR
 4G5tVMKDsg242B61oiw3j+LANqwzuZ0gg1bEdcfJ6XqIx2+LlzwWRcQIFjpvX2kkiUDHik
 68R80CZQltDSCZEuApDjcv7f/LTRusJlMqUeN3c8eEAHzDXivx44IniIR1JooQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=SVROxzGT; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=d4wPCJyB
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=d4wPCJyB;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 12:55, Rasmus Villemoes wrote:
> As the comment indicates, this was used to silence a warning without
> having to add casts everywhere gd->cyclic_list was referenced. But
> nowadays gd is not volatile qualified, so this helper is not needed
> and only obfuscates the code somewhat, because the head of the list
> being operated on with the hlist_ or list_ macros is usually not
> obtained via a function call.
> 
> Remove the helper and refer to the list head using the idiomatic
> &gd->cyclic_list.
> 
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   cmd/cyclic.c     |  5 ++++-
>   common/cyclic.c  | 14 ++++----------
>   include/cyclic.h |  9 ---------
>   3 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/cmd/cyclic.c b/cmd/cyclic.c
> index 339dd4a7bce..880cd648aae 100644
> --- a/cmd/cyclic.c
> +++ b/cmd/cyclic.c
> @@ -16,6 +16,9 @@
>   #include <vsprintf.h>
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
> +#include <asm/global_data.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
>   
>   struct cyclic_demo_info {
>   	struct cyclic_info cyclic;
> @@ -64,7 +67,7 @@ static int do_cyclic_list(struct cmd_tbl *cmdtp, int flag, int argc,
>   	struct hlist_node *tmp;
>   	u64 cnt, freq;
>   
> -	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
> +	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list) {
>   		cnt = cyclic->run_cnt * 1000000ULL * 100ULL;
>   		freq = lldiv(cnt, timer_get_us() - cyclic->start_time_us);
>   		printf("function: %s, cpu-time: %lld us, frequency: %lld.%02d times/s\n",
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 573e715587d..2bc3c773f27 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -22,17 +22,11 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   void hw_watchdog_reset(void);
>   
> -struct hlist_head *cyclic_get_list(void)
> -{
> -	/* Silence "discards 'volatile' qualifier" warning. */
> -	return (struct hlist_head *)&gd->cyclic_list;
> -}
> -
>   static bool cyclic_is_registered(const struct cyclic_info *cyclic)
>   {
>   	const struct cyclic_info *c;
>   
> -	hlist_for_each_entry(c, cyclic_get_list(), list) {
> +	hlist_for_each_entry(c, &gd->cyclic_list, list) {
>   		if (c == cyclic)
>   			return true;
>   	}
> @@ -52,7 +46,7 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>   	cyclic->name = name;
>   	cyclic->delay_us = delay_us;
>   	cyclic->start_time_us = get_timer_us(0);
> -	hlist_add_head(&cyclic->list, cyclic_get_list());
> +	hlist_add_head(&cyclic->list, &gd->cyclic_list);
>   }
>   
>   void cyclic_unregister(struct cyclic_info *cyclic)
> @@ -75,7 +69,7 @@ static void cyclic_run(void)
>   
>   	gd->flags |= GD_FLG_CYCLIC_RUNNING;
>   	now = get_timer_us(0);
> -	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
> +	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list) {
>   		/*
>   		 * Check if this cyclic function needs to get called, e.g.
>   		 * do not call the cyclic func too often
> @@ -129,7 +123,7 @@ int cyclic_unregister_all(void)
>   	struct cyclic_info *cyclic;
>   	struct hlist_node *tmp;
>   
> -	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list)
> +	hlist_for_each_entry_safe(cyclic, tmp, &gd->cyclic_list, list)
>   		cyclic_unregister(cyclic);
>   
>   	return 0;
> diff --git a/include/cyclic.h b/include/cyclic.h
> index df8b725e3d0..ec2c53b6ecf 100644
> --- a/include/cyclic.h
> +++ b/include/cyclic.h
> @@ -78,15 +78,6 @@ void cyclic_unregister(struct cyclic_info *cyclic);
>    */
>   int cyclic_unregister_all(void);
>   
> -/**
> - * cyclic_get_list() - Get cyclic list pointer
> - *
> - * Return the cyclic list pointer
> - *
> - * @return: pointer to cyclic_list
> - */
> -struct hlist_head *cyclic_get_list(void);
> -
>   #else
>   
>   static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,

