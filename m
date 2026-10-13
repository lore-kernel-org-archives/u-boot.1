Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472B4CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6D87406DD;
	Tue, 13 Oct 2026 08:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8m7Of009c5na; Tue, 13 Oct 2026 08:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6415A406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881740;
	b=YWk6u3k0079Lw08znL3q3VDg7Kqoyk06nVthYluusACq0udw/1zBqI+UCwdCdZLIxyur
	 L1das5KgrIg3ytxHqboXkT6G5i8S9wnbAEoJ9FkjNkWTH6GoSsW9FR95jAE5itjOBQJcf
	 RZwHbRrfO0gABCJ8MVVturDzsNmIZvG1CAiCmw78aEk/02VfYsEVUDgp2swU/PhQPqDT1
	 VtBNnFahfbeyzbPu2fNL59zFjPNHz8AwMmi0IJTIcF9jf6pzLopy8ZcxyJWrmG5h9biPV
	 HKTlutB1xcyfqgSi0I1R1hY7q8k5AKdQjyyP0YJSlGC4wGy/hemeUSuFuAMmw1R3VNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881740;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WGRhUvzTh5seYsA2bnAAYjq/lYSJv0lJwpS1k/2GsrA=;
	b=KaBwEXlAxcmS2T3gNE1WStP0Ff4Ame4+CI/7fwi9wtB6hNdhomuWWZJ/B3FuvL1gJ37F
	 akcaUwsF0rOv5l47ZN9+wt3lkCIl8vypXQ3v3Q2YxmkBqly/qfjS3IXaMXK9LlJo5jPfd
	 R8CsDHdwwQPxfY4VIdO0R3TzXl4iNVBiu6Y27IFBYYUCZURepX1GFkGmlNRxGe7MyhW6x
	 14AN+HtGck7PIfKkRt1s/D4PisTRKau4pSa7wGG2iPPOwb/OFSi5es5x9hufK3zzqaetG
	 8O21WHiQkxFkWOe+X5cl9j7fL/cEIQ1SFr7Z1rfwyVnYtGkR89LG+ISHVUqWnqxQUYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881740;
	bh=WGRhUvzTh5seYsA2bnAAYjq/lYSJv0lJwpS1k/2GsrA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rJtsfO35q0KxvjCoS20wSIK7JiDJydcyqWl6a8thKj1jgaYCkeFqBrWCo4BKHaOT5
	 /YYclAUrtmujpYlz3JUqcl+dS7DpIrD69AL/WPbEzo8GDlrRZzo/WZVVjpAJgQquA9
	 i6MeEX64ODmhmbj6218RWp3FQhY9c0MyEtfEHqIOkvOt0qTaK9Kiy6jYgyV8YEEuGO
	 gA5JcDB/OE7EHg9KwiyjMvJ/0JQ7V96yPSvFmVzlrBelIb7RWCxwWMfaTvCmpB+cWn
	 Hte+qdl25Lp0KpVYlwLfK42q0ruzSB3kamBVv1NhBDfF72fBSO920fowP1fW7bvn10
	 aFYyQeCiBWndQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6415A406D4;
	Tue, 13 Oct 2026 08:55:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5840D105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47F5080996
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEii-JIl9mlk for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:55:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60B3280D34
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881737;
 b=Jn4CKgd7pzLkk5JzVT1y/zKjh/TnQmLyVD4foOUN64isKoZ0xEWnjhSVJLvz1Dr+zqsd
 OZvk4bTgkz5iyGqFKFJcCVgWmuPY//boB+mYPuQn+A4mGG3TYioa8HVSsq5a2pJTi5oIb
 RWIWyPuVS4u70XYBScIq0Zx9sNvAvJOzmEUuz/vj5d9VrrAM8gpPYcgA4Ybk6fnpp/4vy
 Xz8cSCR2JDubVY4gRE0ohvlqe881qwesrbG3awpflvdm3yaHwkVv4bVmD/Bc6+cS/pk06
 hu8t/7ieVlY7Rp/MOXfzc8/2NGIPbDgKSX7cPXsx4HAdnOOipckHzaTFQCU3rDamcrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881737;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=WGRhUvzTh5seYsA2bnAAYjq/lYSJv0lJwpS1k/2GsrA=;
 b=kmV8wnNzaNfVWRBNGY3UFXAfmqKE0MWVproYWc4r3qNNaH+ugv/cmJt+QhuToJ2emo/N
 X3o9M2mrRZlu7F0wI+dmjlHTA7FVhWnRXLE4/LSsTz74xvHi1JbWYbdDpp4pEuHuIPnhe
 F6FXlQZ/Tjc1hmqDUR+2tTxdcJHq5/ehOaTRJYW1rNAwf5Q9qzcyTyuqndIwu6IFwqicS
 Tob8pNNEFUojFeIuW5rnoH/qqu6PDrSOrn3GM8JUqS3aO1+CsQFAwjpwqSwq+LxE5K1n0
 4EvfYK2Pr6QLnMWNozZhq3eDzJHLkNXVHZVHmZE3+hV2npcLhNuhOOXEcMcTfnRCDYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=dws32iuW; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::190e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=dws32iuW
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60B3280D34
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:55:36 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3p1X4psgz2tH;
 Tue, 13 Oct 2026 10:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791881392;
 bh=WGRhUvzTh5seYsA2bnAAYjq/lYSJv0lJwpS1k/2GsrA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dws32iuWSBLoR3i9U8Gsfzk899uvIvMIkmCi75XLLE1ZeFq+WcbvqdlZfn8crxyES
 NeFjOIQ/Fl3LfZ7ODvFf3Ubq7sFdzmp+r17Gp99P643Ud5XlqiE3A0UH9Jo0X2y645
 er4lnGYef4hsKQ4XDracDUqW4SON2++ZEf0y4a6fsZsKzU93MIFJ5tvjhbHywrh4ZW
 MnBb5om4CvCzIuDdhsBj7saZZ9qC2Ha2KrZuyt5eBEoM4Yrk9gmpnHXkgnevdgDXDQ
 jnwmbZAPa8AYhgAH1XOgi3haAV/e535U1th+R5e+9tke4rToO2GFk9sL8MR4g9/IaG
 a1IqISmwxi9Kw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3p1V73YNzT6p; Tue, 13 Oct 2026 10:49:50 +0200 (CEST)
Message-ID: <0972d883-9c35-445d-8f90-efd394c3a90b@0leil.net>
Date: Tue, 13 Oct 2026 10:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: Remove unused rockchip_get_clk() helpers
 for RK35xx
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <a3367c8d-6352-42d0-87d5-e325652fc225@0leil.net>
 <9c9adba7-1a83-43f9-8bbf-8473cd8cba06@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <9c9adba7-1a83-43f9-8bbf-8473cd8cba06@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 10/11/26 12:00 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/9/2026 10:10 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>>> This series takes the initial steps to try and remove use of
>>> rockchip_get_clk() to get the clock device or rockchip_get_cru() to get
>>> the CRU base address at runtime for the Rockchip platform.
>>>
>>> This series is similar to the "rockchip: Remove unneeded syscon driver
>>> for RK35xx" [1] series, but focuses on CRU instead of GRF.
>>>
>>> The CRU base addresses are fixed and known at compile time, yet drivers
>>> keep trying to resolve them at runtime delaying some operations by
>>> several ms.
>>>
>>
>> I would rather use device tree whenever possible, instead of relying on
>> hardcoded constants. Considering the contexts in which
>> rockchip_get_cru() and rockchip_get_pmucru() are called (that is, in the
>> DRAM driver will eventually be called only in DM-less TPL so cannot rely
>> on DT being present to fetch CRU from it, and in the sysreset driver
>> which doesn't have a description in the device tree), this here is
>> acceptable to me as is. But we should think about documenting the
>> exceptions to the "please get the info from device tree and do not use
>> hardcoded addresses" rule. A problem for later :)
> 
> I agree, we should use values from device tree where possible and
> appropriate. And as mentioned in the other thread, my acceptable
> exceptions are CRU, RAM and arch_cpu_init()+board_debug_uart_init() in
> xPL. With main reason being that anything in TPL (dram init) may or may
> not have access to DT, DM or otherwise be size constrained. And in SPL
> typically because of consistency, e.g. code may be shared with TPL, or
> we may need to do some one-off thing for a specific SoC, e.g. disable
> JTAG in arch_cpu_init().
> 
What I meant to say is that we should add this documentation to doc/ 
somewhere so *other* contributors know about these rules too. It's good 
to have it written here so there's somewhere we can look at until we 
have this written somewhere in the docs. I'm also not asking you to 
write this documentation, just to be clear :)

Cheers,
Quentin
