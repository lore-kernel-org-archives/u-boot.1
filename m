Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18409C55182
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 07:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA0AA4076D;
	Wed,  5 Aug 2026 07:53:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XrEmY2F9QPP; Wed,  5 Aug 2026 07:53:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5EE5B40722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785916388;
	bh=LAoBoTsu75pgFaKSJyg8KC/mJBASDxyDCDu34l0COy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yokQHbq+XATeIljJUk+5eo5fCYy3H1asqDQlILyGmbaf9xtwkTIL2FRH4LsIyeHiV
	 dE3qaibGN/m9QWUEOJJQZmX5ieAfW/kwOSDzXSEaUZKVW8k9LeajCPnP9rdGFrYF/V
	 tLhAdkN4yYhrCgZ6llL6s3AJ7l6dzm0DnLWDnP5Rjjt33rPbrsQhrLV6e4jmveg+O7
	 Tii8FoXdUctW/A+v2QRwn6HNfCbAgUZk63wla7WcNblddw62m//TRISQsMvdsXKQG5
	 5GXBr/KvJeRF6qGt6P6GsrINmVwdcZLXqQ+6opDPfETL8u7T0nEZMvZpxjoDinZ1bh
	 Mq3t1UNO/T50Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EE5B40722;
	Wed,  5 Aug 2026 07:53:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47FD3313
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39C0440722
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfaPE8Kfjg_w for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 07:53:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=1695=f6=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 325104063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 325104063A
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 325104063A
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 07:53:04 +0000 (UTC)
X-Forward-Email-ID: 6a72ebdd905e4aa53f44be42
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <13059510-2693-45f9-ae9e-4a6f61e8c4e8@kwiboo.se>
Date: Wed, 5 Aug 2026 09:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
To: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-4-jonas@kwiboo.se>
 <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785916384;
 bh=LAoBoTsu75pgFaKSJyg8KC/mJBASDxyDCDu34l0COy4=;
 b=Cu9KLUuHTGGjO6/5ettSQDGZQnjwFJAB6oOHFcoQo3RSulLbHNyRoLS1m7cyl0RELJV7Gxo82
 82Ni4KSPtWoCw4wv2v5cTuMIXj2+wuFiv3lgIcq7G4tsuJTD3P8Teb/SoPVoxVA0hMHo77prLyL
 LC316O0MrbXR+XVanPqucIyCXElVutXC+WqY4x2h1yE3IhzeUmtjkozquOsK9mtq8L0eYlUwUva
 FgiGejMoSe5DBI6C1e4TQ7wU2yY4wShUkLSS7dp7lMNlB8fD+B3MBLvovE7YZ5+k0MBCo/fex+P
 yza5L1lAbZIPhzFbdFExjNDZER1ME44URyCvrhvMEA0w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=Cu9KLUuH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 8/5/2026 9:21 AM, Alexey Charkov wrote:
> Hi Jonas,
> 
> Thanks a lot for your work on this!

Thanks for testing!

I think using the 'probe after bind' flag ended up being the most
logical way to ensure the clocks are initialized early in SPL.

> 
> On Tue, Aug 4, 2026 at 4:26 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>
>> The ore PLLs are only initialized in SPL on RK3576.
> 
> /s/ore/core/ ?

Hehe, correct, my bad, that is what happens when one tries to send out
patches in the middle of the night ;-)

Will send a v2 unless Quentin wants to fixup when applying.

Regards,
Jonas

> 
>> Ensure clock driver is always probed after bind for SPL builds to
>> initialize core PLLs and clocks in SPL phase on RK3576.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>>  1 file changed, 4 insertions(+)
> 
> Tested it with my 41MB Falcon Linux payload on a Flipper One (RK3576),
> and it gives a very noticeable improvement in loading speed: time from
> start of BL33 to initramfs goes down from ~20s to ~3s, which is quite
> welcome :)
> 
> Tested-by: Alexey Charkov <alchark@flipper.net>
> 
> Best regards,
> Alexey

