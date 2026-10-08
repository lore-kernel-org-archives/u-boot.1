Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A273ECA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 20:49:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B55C4090D;
	Thu,  8 Oct 2026 20:49:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6csuLQRmrfI; Thu,  8 Oct 2026 20:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C06EB4091F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791492559;
	b=HYRnXKXYgC0/8CaqjptrVjZf6ZEA2zwOEJxqxAKE17qdW4sCoWWSz5bX8hS2IUA0vAGB
	 R/XiByP6+NYsx2z9ahMQArnRtkuhsEKjs3zz0dC3mxrA5XhN38UetV8qFE0Ch4eFoPY+z
	 rg94Z1bvJLOSXneIoA8l0V6xZSil6JOZkFzsUv1UgDSZ5WUEGxe/KH88Jmzn6cvBfvmBt
	 1JiBiaeFgFjdEyR0zPAxLgVoh8CnMTOHs8icfYPRRSqX23mxvcm349FjReI3s9dx5rT4g
	 +li7ToxsRC5wg1WzDdD88VXEORIVU+enPhNWsTODivLewW4PIM4b2D8QWv3C+xr2Erg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791492559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VCrOkEez5nrVOBtb1qsNH5kAvE1nT692PrVVXwUO94A=;
	b=XCuAye4HcpEq+PXuZ36TP+H3E2w0pjeT7+a/2iUgFc6GZyp9Oph2700w6WeA1FBkkl2x
	 e9vDbJLmj/ip+OAST3O7KwZVGbhvoTv/YRSf+GqGZG1X5g8FnTyYbQcCkGXVCXpsST5yr
	 VXWVIOXb5S0pEZpDZYtX9wq5ptV9TO4mqDNLygWs58qLEmnQCi5DyVlhj7bj73mDVreWW
	 EIzhTFCWDMS6w5dfSXr1CjxI92Nh6nkjNI4ih283ebvQJxGNGZyLWAyFLt8Aj5VZhTqc6
	 cnho9ZHyZQzh2htcumXrFoK2Au1kWqp3siWPGWt+hpG7MnzAF8R1Mb0G11WY1gnmGkA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=NwVBL8MH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791492559;
	bh=VCrOkEez5nrVOBtb1qsNH5kAvE1nT692PrVVXwUO94A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVbzTTy6gNOI+kfnQ0ToSBt2pYUGQFiNpF1fvTuznmsN/iKNAPFbRdV96/T/w7CW0
	 YEVMbnHhANnBCl/baiPz6okRFBKRcUVacsbvjSdeNRj7I6WBLq8BJqs6JEeCjVNPU1
	 UZL/mXkksZjmLxSuQo9LL48O0252UBKJBZe7WKPanZkBHtS71Ff/HZSsls54rqthNs
	 b/K4To53OCspZWIOA9QWO1T4jKgNuXiYCqj+cuHkoO6LMKEP//JnTECYP53rLFEAGc
	 1A4yE8RODQn9laut16Y8igZ6cu9nZghZvxmxgqVSFPQwwB/5NXKSW52jMYEn5fCgwI
	 AsZGTBabxoT2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C06EB4091F;
	Thu,  8 Oct 2026 20:49:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E7709356
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCF5B40903
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VgExURtsyVJH for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 20:49:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D54A24091F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791492557;
 b=QOAUWq4uuntrIussyVBoFdrVC1xVaqlgsHxdB6omYrZkxKHOG2FMJZ5mOBCj23sP/Emc
 Ot/L1iQkRuCj66/xMmZSMZAUY8Jo8zROidQVH7lgmYWChGasUAZV6vqUBCQp1P42NLrJq
 EdW5xwem88Ou3YzNCKXCOdRNHRJD+mQE9u7acs6LTHKxM/E7aRDf2OIH1wQCpt7dghGHb
 ik6BuHf7Vndrhx8liuxMO5RQ8f0+H7S1hGlzEvwEFgqHLgNrvEQSxNIfAttzccF5J0DQ2
 efwUwWjPB/8G+23M7MrbLNA+3yW1GvsQzPJq9rZSte2PdrGcM8h2UTQgCzGxXfTsxEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791492557;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=VCrOkEez5nrVOBtb1qsNH5kAvE1nT692PrVVXwUO94A=;
 b=lkpG3lSa3eDrl6WiJbvKvva53Vi+R24NFdupiDWtMnT9S5/DIhIwxufY7vAFPfBaf9FU
 RvoZmymchjpKPIxqc8qhxUGdo2lKN8cKs4Y9EYE/qV+yNi8SylzLl1aZ6h8F2lV53dtzp
 IYN0eWCrA4mMtTZwhCgXpZSJgvCr+UiNjxDGrDRhbrwhd6F6dmhr3aFiBu8zlck4NwHYb
 plZ+TVK8+ixCORAb7rb+ubrRZWaZROi3JJC8SQSy0DZPYwW+vN4MZWlcUohtpfNxFmwXf
 Psg8fVNdXQ7euK61pAAuldvmqh+Rs/sLYvwf00mtFhdnhD6TgW6G5X1WtKGV3BjvHKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=NwVBL8MH; 
 arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=NwVBL8MH
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D54A24091F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 20:49:16 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j12Ct29C9zRGc;
 Thu,  8 Oct 2026 22:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791492554;
 bh=VCrOkEez5nrVOBtb1qsNH5kAvE1nT692PrVVXwUO94A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NwVBL8MHqFgBXJPyRZbudSw407NQ238mL1NOWYSaQ+huKYbmTvZdvOpX3bKoSSzth
 xK4lWrAEDr4nAQnqrQlUWLBC8BtXKgl6xMmCl2lsi9kEAq6xMDUSqvNpLp/knCdcMN
 oe0C43tsDzaHrV3TN5+5Qhm6Ra9V5kKL8A6B5R0fXcnh71XA112nK98TrXBX/v1EOD
 9dOBD3sD3zaj1SXfB+VGCHQk0DtAgtlF4a+mwhMZzRn505buX8EMfRrGnoxSgBXeoM
 GYWMKBhMez5jM77jKbpfziKnjSeDHkhe/TjePr4OEKqcLeeypZT2jOZTLvrXd4MWtS
 /iio5kFWaXW4g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j12Cr4VT4zlCQ; Thu,  8 Oct 2026 22:49:12 +0200 (CEST)
Message-ID: <d02d78ad-0116-4636-9b6b-4e3185f9edef@0leil.net>
Date: Thu, 8 Oct 2026 17:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
To: Alexey Charkov <alchark@flipper.net>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-4-jonas@kwiboo.se>
 <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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

Hi Alexey, Jonas,

On 8/5/26 9:21 AM, Alexey Charkov wrote:
> Hi Jonas,
> 
> Thanks a lot for your work on this!
> 
> On Tue, Aug 4, 2026 at 4:26 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The ore PLLs are only initialized in SPL on RK3576.
> 
> /s/ore/core/ ?
> 
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3576.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Tested it with my 41MB Falcon Linux payload on a Flipper One (RK3576),
> and it gives a very noticeable improvement in loading speed: time from
> start of BL33 to initramfs goes down from ~20s to ~3s, which is quite
> welcome :)
> 

OK but why this improvement? Which clock(s) is responsible for this 
speed improvement? This sounds a bit like CPU OPPs without controlling 
the regulator and it worries me, but maybe I'm wrong here?

Please help me understand what this actually fixes/helps with and how.

Cheers,
Quentin
