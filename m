Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2539CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B513408DB;
	Fri,  9 Oct 2026 13:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhMSbH1n_Ijj; Fri,  9 Oct 2026 13:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6639F408CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791552689;
	b=IwP6KONaMquvrGV4UybasPJCOzRP0mJd2cDlFb7pGaTLEtrPIFpw6ezbWut4Y6SF5Yuh
	 +rA3BK2nV1/rUih1YpcaBu+FF8SPCw08LIRbsgbgX5Acv1Np6V5v3grmGJpfjqj/B9Zd5
	 2oSdvnxpUnKj4io6zoogNIfIEw6y73nFtApRHhBJU4VW4OmeoRrzd0til+Yvz5BlgsHC6
	 VfUUV5ScjWULdDLRQ9T4KAFcE1eqPNILFWVc7bBitZVOXd4HK6qz/wf/Ak8etzCun5zm8
	 8pJii/+vPvFWUKfRtWcU/eyqbhAQ7HPGOy3+wjUrI1x7Vy/1cRnTV7hjAq+HK8nDi5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791552689;
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
	bh=W/hZwJs5vAZui0+dXVfdlnzVd7HhhlO6/jg9W+jIQgY=;
	b=QZAW9OV8od2xeABhwvz+aOPcSIfBE8r59eaB4JCb+8FmMWwq+xQmcdd68TSDKS2oN63v
	 PYgZNemdR2o+u/6pZzPX4xH4MhogZwfhLD4v2fZNDsJjNGUKUu7qnZwJ0ELWqAtYFyhgD
	 5/tZRA1mSV9ADD0J3r7LOiryyE/sMR5s+COFkxaGIzaQTBewj7R5eCC9IfjXXq5sI6bWt
	 BJe8zslbdCQShQdRJFXPNOC/0qArGRBNGJLAYO799pe3T/BWXL/SzFoKL8q2elI6vd2qx
	 5Y4Jah1wttvoXRfcpbijkiHXbxoRvlal1roKVrULYZvdLi04TwoMwwi3QxFdubnNKuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791552689;
	bh=W/hZwJs5vAZui0+dXVfdlnzVd7HhhlO6/jg9W+jIQgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yIt7tbdIIqbyE/TnfDixNNnpnw2cWe0cXAyQRmqhKgpJF9pG7XMcWCNaG+zB1BdHQ
	 B3a4+OlUGOhPC0qPB7xvUqtnCxdV6Q2X/lK9QRdKH1wYTD8tnJn8CzT6q1Ue6bgsgo
	 KTj2WclNYq3g0EqN62x3+mBZlGndtc0gIMIwepv3hczdeLoc4IK5UnMUxB5WG9IeIX
	 2j4p95AB/zmi09IMIJjXCVjjkv8Z+KA656TLN6TJSFXTM7Nlo9uMsy69cf0EDoxqY1
	 cpvVOE0l342GPm603UZ+GGH2WLQNGOLFshhCqQ3ePOGgOb8Ff5kKwx2EMeg84LIZFA
	 K6Sx1xfAyHFfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6639F408CB;
	Fri,  9 Oct 2026 13:31:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00EEF184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E69C960680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3xB_03tDzhjQ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 13:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6AF1C6066D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791552687;
 b=bZ6QmDYg+cTfzJwZW3GFcOurvBGMF9QoZYmc8qkliqCQmPj+X4Oybo/ZYZCsVL38srOz
 96A9N4a/OJKwJwyIH6hEBIdqadcHZGAHjEet8FikguS34iVdNT35wdMQJdVcZ7k9Jljj8
 SDQ6k4yMmEm3lSMtv8IP+Jw8vSvZXm3XH3ezQ3JR6+858MOu2XvEv0gWWgVJgeX6b2BxK
 utsz59GXW9IxaUVLDnxlZReBchkoomwvRgw0pKwoPxVxGZzxTAfRtmHqsekirNQhE5Noo
 QfMLNG4p1EEaYclJbm7BF2yougrATn9brV3fNpR0JYPZ5L0nbgNabaQWZNfm9RrNzuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791552687;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=W/hZwJs5vAZui0+dXVfdlnzVd7HhhlO6/jg9W+jIQgY=;
 b=Wxn6kYceXtzvMf89rmDmCwPYm3Z5NdZp7h95kuqt5/pI1neV9IYGhK397P50TK8t/ub7
 Oyo7Ur4MZsOoxwDn6VxrpIdM8twr/3/tmekez5ZRgP7QALDhRJxDcIHWxePj1dxo/jYMv
 mCbaa6O1F6hVBsXb3XZjnyHnSVfEjqALWN+il/c6pnmc5Z48HR8LbiDljFpBTbORMoOyi
 K48/bw/H3iLoOQhnzJRj5WJZ3E1ZqIuexAgFX8vUU0oAhcoG84jGs8CHpiiS5/xYNd0SO
 mgmjIPV1lnzjiUak0jPUoRgfaB0u4X9CF1g953CKHA7rGIXS9eA3A762uNA5X3QoVNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=UUtanAM0; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=UUtanAM0
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AF1C6066D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791552684;
 bh=W/hZwJs5vAZui0+dXVfdlnzVd7HhhlO6/jg9W+jIQgY=;
 b=UUtanAM0UjuPJVnGazaR12+to2mGshgDtK46psLqcEWh4tZgUSnvbuGVDIplJJP5ZoHTIu1aD
 xJXOGifGlN5yf52Ag2yvRE79V4LiYsowO3bEXiLLpRz7UlUxkbcLYkmhETBBDlcu9SsLd4KlTk0
 T7Hs6yY6zQlHBjApTH22EbCk/OaX1sheJLUEcg94wNHrTDaxn0z+hf8UlLcmTAFCicTJwt+Kfhr
 UflRp+pbfBxKskd23z9YuwGruqER/spWXgQMukc7jzcRGbzvC6KOItraD6B8cEYGqpwqYQ5UzUG
 UuSLbfWJ0QGL2qHB0PCYITdDuhLFDTzmkyOHoA0IaDzQ==
X-Forward-Email-ID: 6ac8ecabec5a50a7d2b6f1a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9f2ff3bd-94bb-46ef-b882-e8da3f17e377@kwiboo.se>
Date: Fri, 9 Oct 2026 15:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] rockchip: rk3506: Remove unneeded syscon driver
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-9-jonas@kwiboo.se>
 <b0e408bb-4a3a-43ab-badd-93718a963584@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b0e408bb-4a3a-43ab-badd-93718a963584@cherry.de>
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

On 10/9/2026 12:08 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 12:57 PM, Jonas Karlman wrote:
>> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
>> to get a regmap or use a constant to get the fixed base address.
>>
>> Remove the unneeded RK3506 syscon driver to discourage new uses of
>> syscon_get_regmap_by_driver_data() or syscon_get_first_range().
>>
>> The generic_syscon driver will instead be used for the compatible
>> previously matched by the now removed driver.
>>
> 
> Same remark as for the patch for RK3528 except that here it's worse, 
> there isn't even an upstream DTS(I) for RK3506. Just slightly reword to 
> avoid the misleading claim.

Good catch, and yes there is no upstream DT for RK3506.

The DT at [1] is likely ready to be upstreamed, just not enough time ;-)

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3562/arch/arm/dts/rk3506.dtsi

Regards,
Jonas

> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

