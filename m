Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2ACC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B8080586;
	Wed, 22 Jan 2025 10:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737537911;
	bh=R5mm5PWB7M0aD3EeMWFX5f0c1KwTNkPzD9RPN0Ze1yc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uk9wa0QHu7+5f0vdPBu+cZsJtdkKpU2zHyr/y/14944t+/5Jg2tY9tGwn1149aKUW
	 YvU7HmbB9/kWWi8F0ldXWUOLO+3bjwanzcbKkSABmXDPpzkPPpGUVt08YVdcyvEEVd
	 7T6N18IOGbxY8iQF9Yki4U4mzMmOGZQy/Xp32Vl5j6itHkvTQLQ0Dcv8209RcMteFS
	 mjPPonqGpI1V0ybHJRHqbIjUuKbSUgyWgKFsrlfWSlYi16EhuVNNJZajtVjN5ppi+Y
	 rQ7I+MvMcT4hAotUOxiKlznrDMLdFu0346bHE1E7hP/O/gCmWLFjebjiKcaKTQKGjt
	 RbxFO4wOrJbww==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C0880763; Wed, 22 Jan 2025 10:25:10 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB6980283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4YdJZX0hw8z9spb;
 Wed, 22 Jan 2025 10:25:08 +0100 (CET)
Message-ID: <d62f61b9-4837-48ac-bf22-64d4fcdb4228@denx.de>
Date: Wed, 22 Jan 2025 10:25:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] cyclic: Prevent corruption of cyclic list on
 reassignment
To: Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Aaron Williams <awilliams@marvell.com>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ronald Wahl
 <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
 <87cyghx2ru.fsf@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <87cyghx2ru.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Marek,
Hi Rasmus,

On 20.01.25 10:17, Rasmus Villemoes wrote:
> On Sat, Jan 18 2025, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> 
>> Make cyclic_register() return error code, 0 in case of success,
>> -EALREADY in case the called attempts to re-register already
>> registered struct cyclic_info. The re-registration would lead
>> to corruption of gd->cyclic_list because the re-registration
>> would memset() one of its nodes, prevent that. Unregister only
>> initialized struct cyclic_info.
> 
> I had considered something like this, but I don't like it, because it
> relies on the cyclic structure (or more likely whatever structure it is
> embedded in) being initially zero-initialized. And if the caller doesn't
> know whether the cyclic_info is already registered or not, he can't do a
> memset() of it.
> 
> So my preference would be that we instead simply iterate the current
> list to see if the struct cyclic_info is already registered that
> way. Also, I think I'd prefer if double cyclic_register() is allowed and
> always succeeds; this could be used to change the period of an already
> registered instance, for example. Also, that avoids making the
> interfaces fallible.
> 
> And cyclic_unregister() could similarly just check
> whether the passed pointer is already on the list, and be a no-op in
> case it's not. Those extra list traversals are not expensive (we're
> traversing them thousands of times per second anyway in cyclic_run), and
> I doubt one would ever has more than about 10 items on the list.
> 
> IOW, I'd suggest adding an internal
> 
> bool cyclic_is_registered(struct cyclic_info *info)
> {
>    struct cyclic_info *c;
>    hlist_for_each(...) if (c == info) return true;
>    return false;
> }
> 
> add
> 
>    if (!cyclic_is_registered(c))
>      return;
> 
> to cyclic_unregister(), and have cyclic_register() unconditionally start
> by a
> 
>    cyclic_unregister(c);
> 
> and then proceed to initialize it as it does currently. No other
> changes, apart from documentation, would be needed.
>      
> 
> 
>>   common/cyclic.c  | 14 +++++++++++---
>>   include/cyclic.h |  9 ++++++---
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/common/cyclic.c b/common/cyclic.c
>> index 196797fd61e..53156a704cc 100644
>> --- a/common/cyclic.c
>> +++ b/common/cyclic.c
>> @@ -27,9 +27,13 @@ struct hlist_head *cyclic_get_list(void)
>>   	return (struct hlist_head *)&gd->cyclic_list;
>>   }
>>   
>> -void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>> -		     uint64_t delay_us, const char *name)
>> +int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>> +		    uint64_t delay_us, const char *name)
>>   {
>> +	/* Reassignment of function would corrupt cyclic list, exit */
>> +	if (cyclic->func)
>> +		return -EALREADY;
>> +
>>   	memset(cyclic, 0, sizeof(*cyclic));
>>   
>>   	/* Store values in struct */
>> @@ -38,11 +42,15 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>>   	cyclic->delay_us = delay_us;
>>   	cyclic->start_time_us = timer_get_us();
>>   	hlist_add_head(&cyclic->list, cyclic_get_list());
>> +
>> +	return 0;
>>   }
>>   
>>   void cyclic_unregister(struct cyclic_info *cyclic)
>>   {
>> -	hlist_del(&cyclic->list);
>> +	/* Unregister only initialized struct cyclic_info */
>> +	if (cyclic->func)
>> +		hlist_del(&cyclic->list);
>>   }
> 
> So this already shows how error prone this approach is. You are not
> clearing cyclic->func, so if the caller subsequently tries to register
> that struct again, he would get -EALREADY, while a subsequent unregister
> could would lead to exactly the list corruption you want to avoid.
> 
> And unless the caller immediately himself clears ->func, other code in
> the client cannot rely on ->func being NULL or not as a proxy for
> whether the struct is already registered (and the caller shouldn't do
> either of those things, as the struct cyclic_info should be considered
> opaque).

I like the approach suggest by Rasmus. Marek, do you see any flaws using
this version? If not, please send an updated version.

Thanks,
Stefan

