Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20159606A334
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gnFHCjKU;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YhMRUDXK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E320F81116;
	Sat, 14 Nov 2026 00:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NSl8LjzVE4l; Sat, 14 Nov 2026 00:00:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 358A181801
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794614429;
	b=p3cByEcqeEGHuZbA8bLKkLNYgkfwCJN+XcDFid+/V229O0kzTyGFKOnWTFL0WEfq0BQX
	 Bo7C7T3LB33kRi4jYAi8tXe+/KJdbBE67tqCDueNYOg7WwBAg7vhCWOOiQ41pyZbX2odQ
	 2BHgWcAAjzEYW7YzTZjM31Oj/bRCvWzHYFchfkQx1b6cJ+iRNoJaOkLOqIxeGKggdACP7
	 6ZSmHlut8nzCBtvzxzt9pzzF1tiCzTrrMoPGjg9msHB8XFAKb6J0OxYNG31IZ79uSeJYY
	 VV9c6x26P/9ishtVUQgrU0e6VZ6J7bSWPbXiK2kTJWtRTaY1CD0xerZlGpp52rQpofg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794614429;
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
	bh=/OndkVRKNmKv+cw1GIrwjjG6T7cdToABaE14AwfHKwg=;
	b=tH05kbbQHs0PhPEjwzpSkepkD5G0NS3W2aIHprWGGDa+QmJy7ETxvC3xfrqG2i6sVqdM
	 36NC6crtKOODBPZYoZfLRrzvk0wjRs3LcAsBYA+4Iaksjb9cwFJWcitza4xYwIgZjfRnE
	 lYFEGmqYH4ZGeWhu5K/MCIRYZ1DzPXugdD1iZbkjfejlkeHXJBzyRH86OPDLVUUjsDyoQ
	 Ug1ShDJ3Jsaph/yLfpOEXRGcP58PW30Xva9HLQbzkWuRKTshEYXBo9hj0ZfAXhmWc4dSr
	 1esdyD+WsFk6TyoqCFhVXxhxKa8A/+VjxgM380X4BPZ3SJalEivMhj/ErBAypTh4Yaw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YhMRUDXK;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794614429;
	bh=/OndkVRKNmKv+cw1GIrwjjG6T7cdToABaE14AwfHKwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gnFHCjKUHD8xWMvuFm6NewOCV4Q3H7kYuuob0TGZhhojH8XsW1wB4fPUElGtdqMcS
	 oY/u2Ww4po2Ri5oVWRCKh8w0b4JbEqXWCtoWXRBJ5+QhpqBS3LNKsv7p6KkG23qpBW
	 1cKLETrN/GZtV80csnqPji8KVNzgr11vCw9xQa6qYpKSQQNH4i+MwMU5Wj+bo4ULOX
	 7lmYWmuO3xGNMXyEx27a68XnTTvPqTTex3MmZqLgZZNwkK2la/WQ4/iRRsrVTb9EOR
	 3jefkrHCk2u8tOulcgWfMAnQWNJvpr9w1SZj7+U+2KkMub2mj6/YudWrgQcyILHy6H
	 bH/vQyM1wUREA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358A181801;
	Sat, 14 Nov 2026 00:00:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F4B61E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1431681801
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:00:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oqmb3aCkdIRl for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:00:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3BFF781116
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c646=jd=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=YhMRUDXK
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BFF781116
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794614421;
 bh=/OndkVRKNmKv+cw1GIrwjjG6T7cdToABaE14AwfHKwg=;
 b=YhMRUDXKBpWC2ZLHM0GmLfXKSLvYQ5/rHA9drIm6tQOKKNiVG2TE1rPkNaAnvmsOFSkIfyxmD
 17+ndw4+WdhoPqjqo93r6fbPp+mI4SuqXMDF3msiQ3urSetnA1ygGkTjVdGuAIEtShD9x351629
 BQTxnXYnL1zjq3qXtB0IiRfOm84ezsO0gQKu0NG6rznq/4un5si0n+o/sR1hPl+Ys16CNCwItx+
 SVzTpL7xOtcF6N7OvWUzhtU92BVJugbk2iVGkkwnw/PtSZS9RrnOTtJZQDvXVTjPVmL+BMioiz4
 PUZcBd/QgSZWs/zc678+Hff+obiLABz/HOaFPtXMdL6Q==
X-Forward-Email-ID: 6af7a48af68a4e08a5c3199b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.19.21
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b39abc06-2c35-4b1f-8b48-0511ed58e6a1@kwiboo.se>
Date: Sat, 14 Nov 2026 00:59:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] clk: rockchip: rk3576: Use correct mode register
 for VPLL
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261011222930.1085075-1-jonas@kwiboo.se>
 <20261011222930.1085075-20-jonas@kwiboo.se>
 <8cd70f39-0ede-4d94-b9bb-ee4dc635a71a@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8cd70f39-0ede-4d94-b9bb-ee4dc635a71a@cherry.de>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/13/2026 6:50 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/12/26 12:28 AM, Jonas Karlman wrote:
>> Change to use correct PLL mode register when VPLL rate is changed.
>>
>> Fixes: 3919310b37ec ("clk: rockchip: Add rk3576 clk support")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Looking at the other clocks, I **think** RK3576_BPLL_MODE_CON0 and 
> RK3576_LPLL_MODE_CON0 are completely wrong?

They should be correct and match what you describe below?

> 
> The offsets should be
> 
> (0x27238000 - 0x27200000 + 0x280)
> (0x27240000 - 0x27200000 + 0x280)
> 
> no?

Correct, the MODE_CON0 are expected to be the offset from base parameter to
rockchip_pll_set_rate(), i.e. priv->cru, 0x27200000 for RK3576.

With below defines in cru_rk3576.h the MODE_CON0s should end up with same
values as you describe above, or am I missing something?

  #define RK3576_BIGCORE_CRU_BASE		0x38000
  #define RK3576_LITCORE_CRU_BASE		0x40000

  #define RK3576_CRU_BASE			0x27200000

  #define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE + 0x280)
  #define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE + 0x280)

I see now that there are exact GRF base addresses in addition to relative
CRU base addresses, maybe that adds to some confusion?

For the pending future refactoring series I have instead opted to define all
exact CRU base addresses, and instead uses something like:

  #define RK3576_CRU_BASE			0x27200000
  #define RK3576_BIGCORE_CRU_BASE		0x27238000
  #define RK3576_LITCORE_CRU_BASE		0x27240000

  #define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE - RK3576_CRU_BASE + 0x0280)
  #define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE - RK3576_CRU_BASE + 0x0280)

To avoid mixing defines of exact and relative CRU base addresses.

> At the same time, I don't think it matters since we won't change the 
> LPLL and BPLL (LITTLE and big cores PLL I believe?) in U-Boot. It seems 
> that the kernel has it correct though and they have
> 
> #define RK3576_BIGCORE_CRU_BASE         0x38000
> #define RK3576_LITCORE_CRU_BASE         0x40000

This also seem to match what is currently used in cru_rk3576.h.

Regards,
Jonas

> 
> Thanks!
> Quentin

