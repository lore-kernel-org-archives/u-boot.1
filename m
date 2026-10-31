Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE89606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FSuQLX+z;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=VuPCoMbn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2A56810B3;
	Sat, 31 Oct 2026 11:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHJR1kLV0DeB; Sat, 31 Oct 2026 11:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21C1F810A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793447738;
	b=R+dtOptpDbtcTjA9tavSBpQS8WPZoQz/8eYbbpaoMP+UJ1lPLx+7DcXHWP1akflhYwqK
	 RiHwAoLq2+/xd6tR98wp6VC6u9Rr+fMDbM7PPNYqPZuqgNS4ZWle/lv3zNjhxljOFWQlj
	 vGiRMe1TozHxr0/HSSPNdZClLWheIyQApzPWnWf1u/LasiOP5bx+dEEBr51rE2MYosnMD
	 kivtp6p4x/fUrboGuhds2Jcu2IsoF15aarqE9QjhGMPHk/ZKFHTTqGW2p6exUrdhtuX5d
	 C43qoGpCKw9nL2x+Nr2JLKU3JTJ1n4GrnGT8NKMY+eJ7QbnFaUyOpIpeQb9QjJz88lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793447738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Gm/8Ls38NNoUju0vDqC7BFWuDw74CsBfv0gxQpBKwQ=;
	b=rrDthuYOOCOdwdfDKyK7gMJjEHSp311ZcvgRR9Y1RYPqp2tfzjq2TQTAFIzvszGq6eID
	 Ifcr/ytNGDgieTLjpRlk8pk5iI2V05yupqPcqQi07Btg5VSKziSjx1wfCq43AeE7l3eDw
	 dUlO60+YK6GbPEBUgB5Sy6zWT71TVGusDNdUdATp67gFkS/nNh6Xz3cV7Pe4iEkpJ2eGw
	 Sz3Mi15BwEZIbPvVY7/29dWlMnvvfX1v5iSSo7Gt34W9jMn48x4/DJjT38cojkF9KoGJB
	 wx6a7n8+bhJ+lSx9HLI2eMW2lotjBLBXqXJRf7L3NNpRpJkesdw52JXRXdfBlaTnnXw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793447738;
	bh=9Gm/8Ls38NNoUju0vDqC7BFWuDw74CsBfv0gxQpBKwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FSuQLX+zI58VqqWsAfMNRnirBhKjrDLJ9pGjolvAqocOOrrmgaJspSBcCN/1NkTtH
	 E1/DOizbnytkIC+NZl6uAINZZhfhT7SMpKoi2VBcI6BeujLnaRomGuPG6x9kFHB6Ic
	 2Sf/AHbg/gvXApb1koa+QESY2h0FQW7w0fh0ROfhIWIizn9w+8j4UFfeM8LdL+9A3p
	 s3wv0T9tNFYtLibUzBKbC+DQZPiKjTnx94TQRZ+k0fJXColy/BAvM5IgWi5lI0HHIy
	 yxkwKFtcCyfj/dbwq0oVB2sAWQvrCZmJGffub7CAPzMfOmeINTF79rvQfPohRUbolf
	 7+kV7U5OfI2+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21C1F810A8;
	Sat, 31 Oct 2026 11:55:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DB9F4BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33FB560648
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edeO9dt6x4ut for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9CA0B60638
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793447736;
 b=jg6cb5kC68/nK5JRmYr9nd0t9qPFrqSTWnCwWevy+Oi8XjCnUPLCekmCE6xA3zKWH1fU
 AwfsJ1mz1LgN0H9pSFG6BgOr1cecfAD903+6itPZThLHVbDs+umP1taH41pJIBbWjZ+co
 ZoQ6wLo/kUslPTZ53DljOUG6XvjjPNpIKSafiP4V2lprzNHXraA2ZQxk6nmem6HSUQJTH
 QFMUNYJWX6KOdg97LXMnPddnFX0BXiuFri2SLPgu++9ESbLzeY0ZwqVoVWcHM+b02YJrS
 8tAOPjujHuQWO8lxtQPCc2eSDj5qu45kx3s6soJh2dtPoaLLZlMAnVftR4zac/0woSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793447736;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=9Gm/8Ls38NNoUju0vDqC7BFWuDw74CsBfv0gxQpBKwQ=;
 b=f+VxhKOiT5Rjjqf+bW3LNj13c6998xTYmsW+WMgAidAut13tTXcl1NKrNE312ZcAZKTM
 cSDrCH0YeRH0+Cwz+Ue6WIwKJQXR4N4VFwTxOQyu3IPd0SwnBAfvQB0Ifv+mf0S3QGFMH
 G+IWsqolnueOgRW3jYIBeJwvyZeEzGjbzRX9d6ZrviFfhnnkUDhK3biPk4t7O6L7j6HHc
 xYdlFYE9nL8BQYLqljY5KeNAxJ8vxhWVeRom78ZJsYy/3x+aXCRSnkzJhMtOeQKFHyx8L
 y9k9Ga2PVnzxk9wZajyU5uJzAVcolG9CdkVdwlM7DgoiiKmQcw0v3HlgfNY9ls143Ag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=VuPCoMbn; 
 arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=0c7d=iv=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=VuPCoMbn
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CA0B60638
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1793447734;
 bh=9Gm/8Ls38NNoUju0vDqC7BFWuDw74CsBfv0gxQpBKwQ=;
 b=VuPCoMbnLr+EMxXcQLwFIfNvqLMKAt1C/idr+z02yyxORqoqgVHH0orbJm6AMNFiRv6WYxTbY
 QziRO1r03GR819ds2FNPHKoCSoeEnPBj30sYcYCuxhqOq2PX9C0JlXUe2ISSfr7BJEpYxhwd/uA
 25Pv1bjrZR2En+yg5F+ZRLDZ9khak/oOgRuQQFV3dMV0BG0AQJVBljkhayEQZBlCx/7mOAtpNnu
 ZUkFWvID6czDdbhnhpuk6CZKS+6FGotIbTFBZQa18BwcEJUUHlsQylSrR8a9MQ4fbSp5YUU/XTU
 0XzFh6HYu404r8Ixo4GOYEVQDrZ8nk9wwOvqC9h3IwnQ==
X-Forward-Email-ID: 6ae5d73418f29024d511546c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.18.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f4080655-9f66-4377-9c5c-71b722a0efad@kwiboo.se>
Date: Sat, 31 Oct 2026 12:55:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/37] rockchip: Miscellaneous RK35xx clock fixes
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <CAFLszTgT31tNCvsJ7+MRvm0LfMA4FCWcx85hFj8=TE_W3pWjsA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgT31tNCvsJ7+MRvm0LfMA4FCWcx85hFj8=TE_W3pWjsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 10/31/2026 10:33 AM, Simon Glass wrote:
> Hi Jonas,
> 
> On 2026-10-11T22:28:36, Jonas Karlman <jonas@kwiboo.se> wrote:
> 
>> Some of these fixes have only been compile tested as it involves clocks
>> or rates that are rarely used in U-Boot.
> 
> Please can you say which patches were tested on hardware, and on which
> boards? Patches 1 to 6 and 14 change PLL and bus-clock setup that
> every RK3568/RK3576/RK3588 board runs at boot, so they carry more risk
> than the one-line copy-paste fixes. Knowing which ones still need a
> run on real hardware would help the people testing on the various
> SoCs.

All patches have been runtime tested on multiple boards of the affected
SoCs, however a few of the fixes affect clocks or rates that no board or
SoC is likely to use, e.g. VOP clocks or clock rates that board DTs or
drivers is very unlikely to request. So technically some of the fixes
have not been fully tested during runtime.

> 
>> This series fixes a few trivial copy-paste mistakes and other misc clock
>> issues for RK35xx SoCs.
> 
> Within each SoC the fixes are mixed with cosmetic changes (the macro
> renames and removals, the PLL-table alignment, SPLL_HZ and the GRF
> lookup drops). Several of the cosmetic ones carry a Fixes: tag even
> though they don't change behaviour, e.g. the PPLL macro renames, the
> unused-macro removals and the PWM0 shift change, whose commit message
> says as much.

Some/most of the Fixes tags where added at request of Quentin.

Most of the issues where discovered during a conversion of these drivers
to use FIELD_GET/FIELD_PREP, and most looked like simple copy-paste
errors.

> It would be worth moving the real fixes to the front of
> the series and keeping Fixes: only on patches that change behaviour.
> Then the fixes can be picked up (and backported) on their own, while
> the tidy-ups wait for the next merge window. What do you think?

Fixes patches are already placed first within each soc-grouping, would
likely split this series per such grouping if there is a need for a v3.

Regards,
Jonas

> 
> Regards,
> Simon

