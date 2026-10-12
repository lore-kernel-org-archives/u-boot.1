Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6776CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71740405CC;
	Mon, 12 Oct 2026 16:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLi94B6Ehd5A; Mon, 12 Oct 2026 16:42:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AF33F4059A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791823333;
	b=P8eHaPAXUSTaYH5rZJDzYLVaMO+Dqju21Srkx0XDGCHoqvjfj4qKZcnuMDlK5kMgmKqo
	 AMm8MSgN13yWrgqsRltw8rLVnJbu7OvfawtncYohHvMGNgFpktLy5pjTWj1bV5Oc6cVcU
	 Db1f0mwwzMKRUZ7hxNXyYZdS3kl9vreQS6QNxdbScE5VgxcD7t/bQk3iQ7BOjMkfoYxkT
	 b7kJhq25jNi/yXNFjMUvoiXhI7zaGb/75n9a0KqCzY5twSDPXjHhFxjb6+n5y0+g8FfrK
	 1mKoHmgA3aObfLhLR/vqaQ3WmSSmqpS1FI4Vqk8OVmkDPxTpP6gY9/+64oyUAtA2j4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791823333;
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
	bh=2fjwur4unR7DOATK3IGrKR3e41wFVQfONl9wBN9R5Ho=;
	b=SLJttiuQi5TNpeo9LnssGZMJF9MyLFXn0PRDJd4GbQ0C5t0GEX3d61oWbk5IhVpDdxOt
	 mKt6u66CgvYBM7jZlUInTIV4GmxBpAgB+jlpYjAHOKGmDADEDr7eCpgqIVTkf3e1yY27o
	 X6MDCMs8A/94upgHLE8VYkP252raWkkS4mLZkiU/Hh9ubNnkOn13rA5cKGiJbmyWg0PZ0
	 7OrBFH31teo3v2XNakTSSkdVZQk5iQsiHXrGEwgW0VC3ZGo222K3xjqKTsDnIfRNbitWH
	 nD9I4dbK3r8cg9ka38ym5EpDDSmoAoU0dmM5YTIbsNJyK423qDF7NTvlthmVgjNX1Zw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791823333;
	bh=2fjwur4unR7DOATK3IGrKR3e41wFVQfONl9wBN9R5Ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cw1OobYZ/wLpxqbONimIHMBOk8MgJhQUjzVRCHDxVNCwlG2MRwusbOW2eFBx5IAVk
	 m8b7N5Hx8xXhK22xf+2diuaTivafhmXXzVkch1rglBKB5bEZJqd5NQ2rPE4j+9BrEy
	 vx9NFvRFULy35mFjlNaqealVXBcaldiXtq9zYBc8rzZbwVbmc+6JnPiYjsg5zWMRwA
	 yQyQb6HQd6WKr4jk4ghmpblfXvf7JGUQoTfuAjETNRY0eKOjQiqrvCdiWz9h2+i/Go
	 lrgbqf/7pdqR6sEAsZIWMJE623vLMJv8QF2jbFwfpiO9H5WglP5ap8ysCSJCXpI+bB
	 wf59gRwDOJPdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF33F4059A;
	Mon, 12 Oct 2026 16:42:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52052105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43CD2606EB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoVeo7aRKpWF for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 25C7060670
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791823331;
 b=X7J4BeE/EqCM0QeVVgXyvdyKZd7n8gpXCyETU2oF90Z917VxMkDGtyJJcn0GCUc+v/jd
 qoOBj496Teans/Ps8k6/jX/Nt3DzgI2Em8DZIyVtvHmkcn4S8eK3vAKEWwVofB5otZRen
 0H//dVPww4NgScPyNa4/+X04Fg+xg8gbBa01hd2rX5pbSZH6OE4iHR1SNK7vKw2kGhkyo
 sbYkvPnS8EOzRo1Ja+OZAZviK1JGFdqwrQkHMkmwaHUtxPwhwJ8078rd4JCx4wg3aaUcG
 8vN2Voh2nnsE95zFk/mBJwgy2bU4iarEnUjA0LRN+sdJqrBuGJ95epcLsRECvlUs3Fw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791823331;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=2fjwur4unR7DOATK3IGrKR3e41wFVQfONl9wBN9R5Ho=;
 b=spOx9+hqGrEqLH1jL+UFysSM1YQ3syeDGpGWEEIVUPugDjXXl7kTb9jUqkw8RCI+aBUg
 15eong3erz2lDHQNnJg1kIlsQRNq7uxv+mv09Vdyz+yFrbPo+4s69fTLziOuX3wu2OjEW
 0F6JSSsKKqDSL2DiTE8S7jGSS5s0b7CN5sECttQCEAmLAepQl0ItE8muCf6X9zqXFO1ms
 feLl8b77TuFeir5V9TKuQXdtiNpAiN8ZarPN3VKtBr6QVhbK9uR9Xi31/czWBCs6o2HGd
 m0EI65NXjThz7n4EaC+YRYIui2PHg/qUp9Xt8SdCMtHeRlavy268v3PrPACbNuBZ7pg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=cuqoMsvr; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=cuqoMsvr
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 25C7060670
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791823329;
 bh=2fjwur4unR7DOATK3IGrKR3e41wFVQfONl9wBN9R5Ho=;
 b=cuqoMsvrm3OQwomW5RZWqfPqMs0rvTRjU7WK7sTlOXVdeFI/mshUWbFOxdFRDxTXvVk1laCCA
 M2usza1wkGCNhDMY7vU77r/qjzX6YWYu13qbkV28DTvesYQ2PmV14G1P7PvS5e1m4N4qsvPoWfZ
 zwcBTFueukNtcAz6qQ7bAeZ2P/3I+7Az47oCHHIWuCQk3+zlP25Gay/uvhl7w4vltDlQOBNbnpM
 Oo6xk4vD5eNWY5uz62sp6plC6HSP+LWftdUGx+BBUz3S89mx13kPjYyFhsAEHENasoXOFN2zaO/
 5BkJdB+YjWzw0tbvugf0wV5MYLAU7CBbm1z3TSd6mXvg==
X-Forward-Email-ID: 6acd0dd98cb5e368044b3fdd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1cc0daef-1c0d-486c-990e-a7ce0445e27e@kwiboo.se>
Date: Mon, 12 Oct 2026 18:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] clk: rockchip: rk3568: Always initialize clocks in
 SPL
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <20261012111552.1173161-2-jonas@kwiboo.se>
 <dfe79f19-2fa3-42ca-87a0-e80ee086c7e6@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <dfe79f19-2fa3-42ca-87a0-e80ee086c7e6@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 10/12/2026 6:00 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/12/26 1:15 PM, Jonas Karlman wrote:
>> The RK3568 clock driver initializes ACLK_BUS to 150 MHz when probed in
>> SPL. However, the driver is only probed on demand, so this
>> initialization is skipped when no SPL consumer requests a clock, e.g.
>> when booting from RAM/USB.
>>
>> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
>> of boot device") all boot devices where typically probed, with a side
>> effect that clock driver likely also where probed, prior to the
>> boot_from_devices() call.
>>
>> Flag the clock driver to be probed after bind in SPL to help ensure a
>> deterministic probe and clock initialization behavior prior to booting
>> from devices.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Reviewed-by: Simon Glass <sjg@chromium.org>
>> ---
>> Changes in v2:
>> - Update commit message
>> - Collect r-b tag
>> ---
>>   drivers/clk/rockchip/clk_rk3568.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
>> index 9f3e9322161e..5a05f1b4de00 100644
>> --- a/drivers/clk/rockchip/clk_rk3568.c
>> +++ b/drivers/clk/rockchip/clk_rk3568.c
>> @@ -2934,6 +2934,10 @@ static int rk3568_clk_bind(struct udevice *dev)
>>   	struct udevice *sys_child;
>>   	struct sysreset_reg *priv;
>>   
>> +	/* Ensure clocks are initialized after bind in SPL build */
>> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
>> +		dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
>> +
> 
> There's pmucru in this driver as well, shouldn't we also probe it after 
> bind? Or how did you decide only the cru driver should be probed after 
> bind and not pmucru?

Good catch, I am not sure if I decided to exclude it or just missed it.
Looking at the the code and DT references I do not think we need to
probe pmucru other than to be consistent, at first glance it looks to be
related to video and pcie. It most likely was not probed until U-Boot
proper, but will look closer and run some tests.

> As a general note for the commit log in v2, they are good enough for me. 
> It clearly states we go back to what we used to do as a stop-gap measure 
> to fix various issues we hadn't when we used to probe all boot devices, 
> and hopefully we'll fix this properly once we know better. I don't 
> really like it, but I think it's reasonable.

Fully agree. At this time I cannot see how we can solve this more
properly but as you mention hopefully we will know better in future :-)

Regards,
Jonas

> 
> Cheers,
> Quentin

