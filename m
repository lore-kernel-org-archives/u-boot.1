Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FECCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F4A807B1;
	Mon, 20 Oct 2025 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BNzE2wXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE5880422; Mon, 20 Oct 2025 17:03:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 041C880422
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5603=46=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1760972623;
 bh=8lpqLST6IHmyaOAgHqRyVo/fc2vIJH3kC/hgt0rTmyU=;
 b=BNzE2wXFA1yIdHWOIorAm6PNLJwHEUG8q0/pUuvCJk7YLq26RVpHfMHa8XI8kPaUSuD1RSl/i
 ReotQZX5FLth9KBOwUOd4o+g1i+aBNyyDQfW8XBXatLC2xnL2Ec2N0FnJeshjJ0BNv1mWV7fWn/
 08iUPwZQCAPmwVRjd73R+pltqxhLlbbAR7RQP1QXxBs58TCLginUNevHYsLYEh6wXbcQiM5p9AH
 5tR8M1IaCmp26NBJPzO2E4GI6J+0dl5ZyKaDkyeK7BZlsjFamuUzKjGfGFZb7e/hgs2GswK0Gqj
 VoRZUrTj8+7bkEXqwM4dwZFf0v4Hl7v9+lqVP4zpqGLQ==
X-Forward-Email-ID: 68f64f4823e747b398bd260c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ba095360-147b-4c22-b2fa-8a3c17000381@kwiboo.se>
Date: Mon, 20 Oct 2025 17:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] clk: rockchip: Remove negative error returns from
 clk_get_rate
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20251015-clk_ops-v1-0-5f80f827407e@linaro.org>
 <20251015-clk_ops-v1-8-5f80f827407e@linaro.org>
 <aa7d67c4-5abe-4a71-89b1-866fb677d232@kwiboo.se>
 <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4f84711c-8d08-419f-bef6-ff97858751f8@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Andrew,

On 10/20/2025 2:03 PM, Andrew Goodbody wrote:
> On 19/10/2025 21:28, Jonas Karlman wrote:
>> Hi Andrew,
>>
>> On 10/15/2025 4:32 PM, Andrew Goodbody wrote:
>>> clk_get_rate() returns a ulong so do not attempt to pass negative error
>>> codes through it.
>>
>> On Rockchip the clk drivers only implement support for a subset of all
>> clocks supported by the hardware, mostly to save space for TPL/SPL and
>> not having to implement logic for clocks not really needed by U-Boot.
>>
>> Because support for all clocks is not implemented the existing working
>> error handling actually help us catch clock issues on the Rockchip
>> platform. E.g. when a clk is referenced by assigned-clock-rates in DT we
>> get an error and can fix the issue, or decide if we can safely ignore
>> setting the clk rate.
>>
>> I do not understand why you need to change the way the clk ops work,
>> just check with IS_ERR_VALUE() inside the clk-uclass or similar if you
>> really must remove working error handling from the callers.
> 
> OK, so here we have a question and it is one that I wish had come up in 
> the original discussion. IS_ERR_VALUE() and other related macros are 
> from include/linux/err.h and are introduced with this comment

I have no idea what the original discussion this relates to.

In U-Boot most/all? uclass functions is documented to return >= 0 on
success and -ve on error, I do not really see a reason why clk funcs
should be changed away from this documented behavior.

> 
> /*
>   * Kernel pointers have redundant information, so we can use a
>   * scheme where we can return either an error code or a dentry
>   * pointer with the same return value.
>   *
>   * This should be a per-architecture thing, to allow different
>   * error and pointer decisions.
>   */
> 
> So they are clearly intended to be unambiguous and used to add 
> information about errors into kernel pointers. It also suggests that 
> there may be other implementations of these macros for other architectures.
> 
> Much of the error checking of the return value from clk_get_rate() is 
> done with IS_ERR_VALUE() despite the return value not being a kernel 
> pointer and with this default implementation it does happen to work just 
> as long as your clock rate does not collide with an error. OK collisions 
> are very unlikely but it does still feel like an abuse of the macro to me.

The U-Boot documentation for clk_get_rate() clearly state that we should
use -ve error code for errors. And the safest way to test for error
codes will be to use something like IS_ERR_VALUE(), so why should we not use it as
it does the job very well?

Also for Rockchip the clock rates do not really collide with error codes
as the typical max clock rate go up to 2-3 GHz, and in U-Boot we
typically only reference clocks with less than 1 GHz rates.

/**
 * clk_get_rate() - Get current clock rate.
 * @clk:	A clock struct that was previously successfully requested by
 *		clk_request/get_by_*().
 *
 * Return: clock rate in Hz on success, 0 for invalid clock, or -ve error code
 *	   for other errors.
 */

To me this patch/series just look to break this documented and working
error handling without any justified benefit or replacement.

Regards,
Jonas

> 
> Is there any official guidance on this use of IS_ERR_VALUE()?
> 
> Andrew
> 
>> The current working clk error handling has really helped me time and
>> time again on Rockchip platform during soc and board bring-up.
>>
>> This is a NAK for me without first having a proper replacement for all
>> existing working error handling that is just being left ignored after
>> this patch/series.
>>
>> Regards,
>> Jonas
