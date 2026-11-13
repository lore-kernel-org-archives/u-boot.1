Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AB606B45F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fg4Rjpvb;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=gJZMys3G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4F5C815C1;
	Fri, 13 Nov 2026 17:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeL3ac8b3Tfk; Fri, 13 Nov 2026 17:53:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CE668168D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794592404;
	b=lM3ZyUxmurTe9JSJ6/2msQrxKtBXzc+L7ME4mk5BRQFGhwU5CtWf6e8wFmiXWnZcOxSz
	 RNrrDglsH3EkVbpmUmeSnTL5GL5b0VhBbhBJhIV9Tp8rnUypmr83KINg06M1n692Jv5+j
	 PlAfdpmp6n1ZLjvaCsP/c5gGlDNjCnZJTf/H5DBS66Fv2p3yNXUFanr7hdEKC9QQaEHrV
	 S1qfVP95KgfucCAwf8ATQp8Kh2A5jVz20szdaLMMGtkO4/Jnf/pEUmuE1jMMxKOwYgkqi
	 g3oOJdAYITj3wc5pyzApdQ9CXVfSMkqKdwPNZunyBKzhtlol5ihuQNTToFJ67Hfg1bg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794592404;
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
	bh=WxMnNAvxbwudwZRE8pVYdqjl0w2lVtnPRVqDFE30oU8=;
	b=TB66yoEOXT7GmLZJhI+JcIoXT/mgrLXoHDnKtBlpvEpTILNTdElO11+5pdYdW2mXKT/M
	 9jVgWMTW5qW2VgDuVVsVbxoDo8f+MuWlN1Xjy2/Fy1qfcastB+WULO+q01bERvZBdMNGn
	 IBLUkJzdVhRkNJHMuyG/smhnl9Jk5bNDxk7+LvL0SYzD7HZB2LClYRwaFBkRrYHecBvX6
	 K9RSh3NWsxanxChHM1xMIKi8G8yTK7h6Xya7cTNaYJksTgfMyycUd7Kg7iIVNGqQBDOs0
	 ijsr1osVvWABM1y3iGKZ13SrBfSdTp3/dFt/QKV1QOqOMnHI5goki9A+d9R1o0WtETA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794592404;
	bh=WxMnNAvxbwudwZRE8pVYdqjl0w2lVtnPRVqDFE30oU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fg4Rjpvba68zb0Mtxs+Da4h6amQpO4PuaAW1bJTQeOZWK1WFWNvAa95VbfZl52xSE
	 fzYwQrZ/9ejmsdnF47TrV6cvQfbKj5mxkPLyAOtnYJJUV+haKSeDc5LXjxV+1rhz8W
	 KEMo58uyVASw5a78BNCjYNlgHWAHKZs3JItG3FezmrbTr5HKwE05ZzQyO9Hc2U28xT
	 BYls0zNf6ZMTfP8CT76MJSFwS1bM22dBcQm5miZfziqeKXez5SumWT6BNa5JptVCw8
	 fDPsalUnt8CqToop/QDdd4J6FzhjHFBKd3AGpahm7iCMRLW8kGWEVMhooyjVmjqNbF
	 Y1b1IsrDu6nKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CE668168D;
	Fri, 13 Nov 2026 17:53:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EA4842E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC6BB40E0A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zeaJC5FXBMFg for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9CE540DDE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c646=jd=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=gJZMys3G
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9CE540DDE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID; q=dns/txt; s=fe-e1b5cab7be; t=1794592399;
 bh=WxMnNAvxbwudwZRE8pVYdqjl0w2lVtnPRVqDFE30oU8=;
 b=gJZMys3GnYqDGnKaI2Qsg6YYxgLtP7LRuUOdL9e+W7BW6z5JrCBR08xey0r2sjoaIYx7GT9vS
 k6nlFi5smRpP45YTaR8y2aL4M7GcT+YdHIJ8S7eHGmTYoIDeIC25yk6w7w2mo9gYTri40M0Vy95
 +tQ1yu5Pmf68o4KB8xFNxU+WmV6o+rhNf/GzP/MjauFWJshj+2nmL3+tOag0d0hG+AbM5bQAB/U
 qv9824aeyjUwOAr7Rin9e36wCiEAI2ca6iD0ROWWaIOAmV7uNRVbOs6DxCV27z9F/yFN7Tinggy
 oAOZLVK+d6Erbk1r6gMSthI2FVUv7o4LdpElqge8Ygug==
X-Forward-Email-ID: 6af74e8ddb4d71024f8b24d4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.20
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b5041ac3-5958-46a7-9705-eff81a426395@kwiboo.se>
Date: Fri, 13 Nov 2026 18:53:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
To: Quentin Schulz <u-boot@0leil.net>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261111222834.157842-1-jonas@kwiboo.se>
 <20261111222834.157842-3-jonas@kwiboo.se>
 <ffdd97fa-13f2-4488-8d66-193f01ee029f@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ffdd97fa-13f2-4488-8d66-193f01ee029f@0leil.net>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/13/2026 5:40 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/11/26 11:28 PM, Jonas Karlman wrote:
>> Use 64-bit arithmetic for f_frac << 24 to prevent truncation before
>> division when automatically configuring fractional PLLs.
>>
>> This closely matches the vendor kernel implementation.
>>
>> Fixes: bbda2ed5840c ("rockchip: clk: pll: add common pll setting funcs")
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v3:
>> - No change
>> Changes in v2:
>> - New patch
>> ---
>>   drivers/clk/rockchip/clk_pll.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
>> index 74b7ff5faa03..5cb0e954ba4a 100644
>> --- a/drivers/clk/rockchip/clk_pll.c
>> +++ b/drivers/clk/rockchip/clk_pll.c
>> @@ -114,7 +114,7 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>>   	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
>>   	/* FIXME set postdiv1/2 always 1*/
>>   	u32 foutvco = fout_hz;
>> -	ulong fin_64, frac_64;
>> +	u64 fin_64, frac_64;
>>   	u32 f_frac, postdiv1, postdiv2;
>>   	ulong clk_gcd = 0;
>>   
>> @@ -156,10 +156,10 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
>>   
>>   		f_frac = (foutvco % MHZ);
>>   		fin_64 = fin_hz;
>> -		fin_64 = fin_64 / rate_table->refdiv;
>> -		frac_64 = f_frac << 24;
>> -		frac_64 = frac_64 / fin_64;
>> -		rate_table->frac = frac_64;
>> +		do_div(fin_64, (u64)rate_table->refdiv);
> 
> issue: do_div casts the second argument into a u32 anyway.
> 
> refdiv is also an unsigned int so u16 max, so this won't do anything 
> anyway. If there's an issue, it needs to be fixed also in the member 
> type in the struct.
> 
>> +		frac_64 = (u64)f_frac << 24;
>> +		do_div(frac_64, fin_64);
> 
> issue: fin64 will be cast into a u32 even though it's a u64
> 
> I think you want div64_u64() here instead no?

I think just changing to use something like following should be enough
to fix the core issue with f_frac << 24 being truncated to 32-bit here.

	u64 frac_64;

	f_frac = foutvco % MHZ;
	frac_64 = (u64)f_frac << 24;
	do_div(frac_64, fin_hz / rate_table->refdiv);
	rate_table->frac = frac_64;

The issue was found with AUPLL rate 786432000 on RV1126B being assigned
in vendor DT, it was not included in pll table and instead triggered the
auto calc and with this patch the debug print ended up like:

  frac div running, fin_hz = 24000000, fout_hz = 786432000
  frac get postdiv1 = 1,  postdiv2 = 2, foutvco = 1572864000
  frac get refdiv = 2,  fbdiv = 131
  frac = 126e97

With Rockchip common 24 MHz fin_hz clock I do not think we have any need
to use u64 for fin_64 and using div64_u64() here, casting f_frac to u64
should be enough to solve the issue I faced.

> 
>> +		rate_table->frac = (u32)frac_64;
> 
> issue: unnecessary (and incorrect) cast
> 
> frac is an unsigned int (so u16 max), therefore this is misleading. 
> Also, the cast will automatically be done by the compiler, so we don't 
> need that.

I will drop unnecessary cast and change to something like above in a v4.

Regards,
Jonas

> 
> Cheers,
> Quentin

