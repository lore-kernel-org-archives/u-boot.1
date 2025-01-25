Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2CC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 13:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B34F80C77;
	Sat, 25 Jan 2025 14:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SyPDfE8b";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N4e65/Ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6889580C7E; Sat, 25 Jan 2025 14:23:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3331D80836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 14:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YgFjl5Lvtz9sGk;
 Sat, 25 Jan 2025 14:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1fEckJ8OU2CAoeteAWASzYNl9LWHkp8ZLlCB9DfDb4=;
 b=SyPDfE8bOjaaBwapHuVORFYVSIvnNvDMYAYM5+HpycqyHVdaSq3Qmr6ZyJJLVi/ZENYTev
 sbKi5GilNMZDChCzVvwlhP+xPmD1CerQbY3Y3sLpzkl1gq7kaFEajcmy+sXAcfq9/+edTM
 egjttU6dWaiaCo9zLwj/AZ59WZT8tbU5sDEE8zx9uusVtasOPt0NyB+ybgtKE8fndc+kDZ
 Ohv7lTnOmG6zznfBwWk8Gi5LvAi3NVJo3z53+kQd/+gaOEDTXcHwRrHWafKpypxjLoVa/j
 hE5p0FM1Bth1zskfAl2HlDKtpU1T3x+riWliJpTZZOk2NiMq6TPHQCryUvHNew==
Message-ID: <f2192348-1c8b-4858-b138-e1a894dff92f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737811385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1fEckJ8OU2CAoeteAWASzYNl9LWHkp8ZLlCB9DfDb4=;
 b=N4e65/WwQ+xhUZafX3b29cfTNGFou2tH7Gg41Jc4KKDklIM2y+D5urgTkuG1nXhpcwBrFl
 5KZnLUZV5oKbbISrQmgeV48luDPVsHOm0oBaSFlNuUcd1f9CA79na+bS4Wud0N+HKrduMy
 jMyl9iwpcfdnEeM9KKTO2zxBY1kTOU4KYpkN5yMN06fz9pRLPzs+Q/Pm4apq7Sx2CBSOqW
 pB/ARlmcegI9pT2lMsLdFIiQGIxGTCpvA6kYlqzGTiYuOvVkYjRdtm5htl1v3SfXvRkhRs
 7889LR82JOApZWqN0JlbmC9/czZwsclyJsPy8Io+yVEIyjt0i28Ssb0NKovYNw==
Date: Sat, 25 Jan 2025 14:22:59 +0100
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
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
 <87cyghx2ru.fsf@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87cyghx2ru.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1ca8sr131595ygi5s7zt6hgkwnr1j5er
X-MBO-RS-ID: fbbc41933944702e721
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

On 1/20/25 10:17 AM, Rasmus Villemoes wrote:
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
> embedded in) being initially zero-initialized.

True

> And if the caller doesn't
> know whether the cyclic_info is already registered or not, he can't do a
> memset() of it.

This is what can happen right now, which is dangerous and what this 
series attempts to address.

> So my preference would be that we instead simply iterate the current
> list to see if the struct cyclic_info is already registered that
> way.

That I can do, but it will be a bit slower.

> Also, I think I'd prefer if double cyclic_register() is allowed and
> always succeeds; this could be used to change the period of an already
> registered instance, for example.

This would be terribly overloaded interface, no, let's not do that.

Better introduce a dedicated function for that kind of period adjustment.

> Also, that avoids making the
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

I don't think this works, because that struct cyclic_info contains 
.next_call member, which is updated over time, so this exact match would 
not work as-is. I have something like this now:

diff --git a/common/cyclic.c b/common/cyclic.c
index 807a3d73f67..d721a21a575 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -27,11 +27,29 @@ struct hlist_head *cyclic_get_list(void)
  	return (struct hlist_head *)&gd->cyclic_list;
  }

+static int cyclic_already_registered(struct cyclic_info *cyclic)
+{
+	struct cyclic_info *cycliclst;
+	struct hlist_node *tmp;
+
+	/* Reassignment of function would corrupt cyclic list, exit */
+	hlist_for_each_entry_safe(cycliclst, tmp, cyclic_get_list(), list) {
+		if (cycliclst->func == cyclic->func &&
+		    cycliclst->name == cyclic->name && // or strcmp() ?
+		    cycliclst->delay_us == cyclic->delay_us &&
+		    cycliclst->start_time_us == cyclic->start_time_us)
+			return -EALREADY;	/* Match found */
+	}
+
+	/* Match not found */
+	return 0;
+}
+
  int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
  		    uint64_t delay_us, const char *name)
  {
  	/* Reassignment of function would corrupt cyclic list, exit */
-	if (cyclic->func)
+	if (!cyclic_already_registered(cyclic))
  		return -EALREADY;

  	memset(cyclic, 0, sizeof(*cyclic));
@@ -49,7 +67,7 @@ int cyclic_register(struct cyclic_info *cyclic, 
cyclic_func_t func,
  void cyclic_unregister(struct cyclic_info *cyclic)
  {
  	/* Unregister only initialized struct cyclic_info */
-	if (cyclic->func)
+	if (cyclic_already_registered(cyclic))
  		hlist_del(&cyclic->list);
  }

[...]

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

I would expect the caller should clear the structure before attempting 
to register it again. Shall we actually memset() the structure in 
cyclic_unregister() too ?

> And unless the caller immediately himself clears ->func, other code in
> the client cannot rely on ->func being NULL or not as a proxy for
> whether the struct is already registered (and the caller shouldn't do
> either of those things, as the struct cyclic_info should be considered
> opaque).
