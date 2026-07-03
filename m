Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C45C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 21:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C75847C3;
	Sat,  4 Jul 2026 23:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TpEy6RCo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jli95ynj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1738341A; Sat,  4 Jul 2026 23:12:13 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74EBF84671
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 23:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gt3Gg1lgfz9ssd;
 Sat,  4 Jul 2026 23:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783199531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwOIUGffGvGKdFb4xoVRxxPTDLF07e89guaPoSuC+0k=;
 b=TpEy6RCo8DR7/nKjkmhzSkfMkORpJFOt5Ml5k+mSZZLzFZ9a/lktLKAVW8si6ie/aSM11d
 pv43lHKbxYR+4a7Y8Kvd2GowFX0cTmojMjZYZRP7jxSZn0bFHCnqWiBeub1OSXjVsydx5S
 Sgi6fozWSdZb2KFDLBgP+C8hTZ3OxbAviLy6SRZJ8CC4XPReSFDKihNkkXtPxWC29xYq/q
 mYRUggD7e+54yahoMVJoRsSgilQ3niaqydHMRsxji0dEOO+WVSe0tCB835oE6tagt+TjS2
 /V5GHzW62oYW8Mk/DsmB/h93CULx+Bq80Eh2XgzPEFesuKCasVoHAXdgIwomTg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=jli95ynj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5ce8de52-2fec-4d08-a9e6-cfc69edbaa0a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783199529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RwOIUGffGvGKdFb4xoVRxxPTDLF07e89guaPoSuC+0k=;
 b=jli95ynjsEWT2aNKYtfLfpqgCpeLMtKcGO7AQuo3jFu4ZmmZ0/OdRIbmUjC4Z+1+9EZear
 jXIlAs8EkRgZv1QyY6yRL94gGJ4OaPiYIv1KO9WdP+unX0GzHSlTteazETW2EdslbRFpnB
 u4olf4macHLp6Genq+5mp527tC7Y74fWEcFbd2QVfhjvAzS+AXL3Sv6Onv71Y/hxtM6IvG
 PFYHQkJTt5xEwgdSBx7Pmpa+s0HfyhpNvbnaQaCwY5xCQCEuiVKK9RqcH2l6Q9tAxI0i+J
 Aj62V4/AMXjr/HVbxsWK2VHlZkFi05l3P/cNA8NkSEpy/2n5UaHP3OnsgEcrBw==
Date: Fri, 3 Jul 2026 16:38:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] cyclic: parse cyclic list only if next cyclic
 timestamp is reached
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-2-92c5a7011f54@foss.st.com>
 <b9c4b762-6abd-4025-bde5-ab911fd5f683@mailbox.org>
 <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0d9f5186-8342-4a11-adf3-2ffc2e5267f6@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3b3msdgtmhz3wfi6agg13uhugonq6gt9
X-MBO-RS-ID: c579170f830bd66fbc6
X-Rspamd-Queue-Id: 4gt3Gg1lgfz9ssd
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

On 7/3/26 11:55 AM, Patrice CHOTARD wrote:

Hello Patrice,

>>>    +    /* check if the next cyclic function's timestamp is reached */
>>> +    now = get_timer_us(0);
>>> +    if (time_after_eq64(gd->next_cyclic_call, now))
>>> +        return;
>>> +
>>>        gd->flags |= GD_FLG_CYCLIC_RUNNING;
>>>        hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
>>>            /*
>>> @@ -102,7 +108,13 @@ static void cyclic_run(void)
>>>                    cyclic->already_warned = true;
>>>                }
>>>            }
>>> +        if (next_call > cyclic->next_call)
>>> +            next_call = cyclic->next_call;
>>
>> Can you move this entry to the beginning of the cyclic list, so that the entry with the earliest deadline would be right at the beginning of the list ? That should squeeze some more improvement out of this I think.
> 
> Hi Marek
> 
> I did a test, it doesn't bring any noticeable improvements, but nevertheless i will submit a v3 with this update.

Does the list iteration exit when it finds the first entry that is not 
going to be executed at this time ? If it does not, then there will be 
no improvement. But for this to work, the list would have to be surely 
fully ordered in incrementing timestamp order, is it ?

>>
>>>        }
>>> +
>>> +    if (next_call != UINT64_MAX)
>>
>> Can the next_call literally hit UINT64_MAX in that one unlikely case ?
>> You likely do need a separate flag, bool next_call_valid, to avoid that edge case.
> 
> In case, no cyclic has been registered, we don't parse the cyclic list and next_call stays set to UINT64_MAX
> We don't want that next_cyclic_call be set to UINT64_MAX, otherwise in that case, we will always exit cyclic_run() before parsing cyclic list.
Consider this:

+	u64 next_call = UINT64_MAX;
...
  	hlist_for_each_entry_safe(cyclic, tmp, cyclic_get_list(), list) {
...
                 cyclic->next_call = now + cyclic->delay_us; // = ~0ULL
...
+		if (next_call > cyclic->next_call)      // False
+			next_call = cyclic->next_call;  // Not set
...
+	if (next_call != UINT64_MAX) // False, branch not executed, but it 
should be executed ?
+		gd->next_cyclic_call = next_call;
...
