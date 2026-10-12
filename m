Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0BECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:11:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4399D40663;
	Mon, 12 Oct 2026 16:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZtzsmp59SqQ; Mon, 12 Oct 2026 16:11:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60F6B405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821484;
	b=VqMHRWYfULCOylyImaEnBgX8UHCI38r2BY+I8AjwDsBKuPSngAI/gv+Krh8nJTL16vhf
	 AZM2yMhpqDGLPu1HfjxTfshkv/n0hEC3eUhtdIX98DyRL4tVOcJnvBOeaWTQuOPIDV8eX
	 xdwTGLdt+RL4OkiYiCZFvLIw9BTKYS20PorM0pz2p2Y95nuSPmdYMhknvXQu3YuwQneTO
	 ruOFbvNolmE6P/m56FjMZuS7jbEmdTQ9xUBMaJOpcFSGfKMjksjN2mQYdmP/KHkr1hZic
	 u6+ocsVqjWujedXHYxqhtr13tZVI0eGw0bwv+AEJy7ove7BvYI+ftH7MhFnANCmXKcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E6T2WrC3idd5vABD4L/jI+OOl4x6/pFq8zPdBbCDoO8=;
	b=Xc30Oc1Ntub//3eZHw1uFu0MLId9wsvVbNI+v6myUd+jwBYmo6cFHT0/HLqlHQyGv+Lt
	 3Rs6I4gTyl5f4n+kRS9+dNcE97uF4ZyObKPcRbiW7zo0eb7nZd0//9Z8HjsFsD2ca3z/M
	 87V34nIgzTbzbC8l8or/rda5rOJG4SmOdYNkCao6WabXSNebYh0hAaLl4YRFlFlCeTM5Y
	 1+3IsrTArtnU8ApsGjF7/r2kA1jmJc83eQtmpJN2SM2mWzTQlHUkcZZblxm//anB8NghP
	 oSDURxjpon+19wh9+RFC68fuWOTd+3tGUY/p8aIkD09XQ8Ryk06R7XTu8Bm7eAR8vJg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=TevwRpR2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821484;
	bh=E6T2WrC3idd5vABD4L/jI+OOl4x6/pFq8zPdBbCDoO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NmBbizCn1pOKbWQDl3CqFKxbsPhmuwHBetalAyIAfbHRfPULGzBe/w0RlYFg34Qz0
	 JArgL8FI+jmh2n20KC1FUOV6e04ewywCikCpC1ugf9kphXmm91i9t7bSsa7AY/qCcV
	 +ZSS902adwn1BVzqF6F5di4/PtsOnHLzJSw1TCe2jAL+6RECOTaJPX9HExP1xXyaj9
	 ccPRGTCJHqGxPxoJH5lEh6nvS8gfc8FyRMSbU3kHG1Ou9X2XbW8b8UzewVIhHyHpki
	 DereIGZA3aHBJRiY42S1yr6+fbidr6kZVXw8UdEOKq4a9dppNiSTUQ6qm2WaTRZ0x0
	 30bGg8jwE8F8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60F6B405A4;
	Mon, 12 Oct 2026 16:11:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79852380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ABA9405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:11:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CnIocz1Au16l for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:11:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0382040572
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.157.188.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791821482;
 b=GUI6yfX7d63sU7LWZG0I1o4xbhIOZwuAsWWc7AM6Ljtgqbw6hPY6C1jSC8yip2CjE3ea
 M/dK25jHIc3CU7d8L6xHxK8A4WmEgoJOFFUJlBABgpI7KzhVbPnj4MH1edNpGwGgZTPQ0
 jYt6bHoegTbplMnzr2Rz4g6hyolpfD/5riuah2/b5OA+7DO6f1RkiRlbbIZvuSsyiSzEQ
 3a63zUJb8AEjdoUn1/hZV6lvJ/aKi6VVDa1vn/o4dva1CSxLvOz9IqI/FaRO7nJ4En37m
 QAM4peHFA/1daxrZ8/60611BtbPJ5y23UuxjziX1H+Zu/DGJx8s4Va6/CLA3sMcqTiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821482;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=E6T2WrC3idd5vABD4L/jI+OOl4x6/pFq8zPdBbCDoO8=;
 b=gZp7nncgfa7//ibrV5V5iNLldwaQ/Fy0ibdopolGIr3oVasY1LQyGwmSv2My5r7lzlYF
 rlQ6z8uR7c9Aq0KDLFS3B5TchHQMcKYDqKcDTgQhmftvDhkDpyTiGhZ/53O37P00YaCCP
 JrFNTu9s85mxpTAQbaqUCbw0Zk2+brcGQrqcfmhfJhD74AXRPjBME2gWHCVgtzGgQ8Sli
 yQiyRCUI0aerllp+LLLdHFokN4TcjXlRPk7Qndk5oRRSuh1jsPAvDN0FDlQoJUW590bc6
 M/m6r4o2BPHKSOwfcqSe04aKR6VXRn/njbaCuNTdMz7xMXGDscxMXnfkSVEqo1iQMqw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=TevwRpR2; 
 arc=none smtp.remote-ip=45.157.188.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.12;
 helo=smtp-bc0c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=TevwRpR2
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0382040572
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:11:21 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3MsH3kvBzkNh;
 Mon, 12 Oct 2026 18:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791821475;
 bh=E6T2WrC3idd5vABD4L/jI+OOl4x6/pFq8zPdBbCDoO8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TevwRpR2Y/t5RbMQzTY/4ci1nUnHkEIMOMAT3e1hUHIuc1eS3Q8i81zw4DFnhN6Jn
 tKAl0ti4szcRqpvszO2dDYgrBuJKgLc+yRfhOORnpETtR8rIFVWtl77iB5t20i1bDv
 zNBd9RKBeg6Aq8StX0Xf0YaMdISK6bCNiMAs6lidMXKm9rsvtF0XnO6RA+rt6b3BMs
 YoFdI0lLYGdTvENVsLm7zgK97WGHPqR4AcjefdLLeOmPq/ckHVl7NRKW5l2hkmOAU1
 JYLuB038OBmHZfL2fjdLjI2xhTVtSKyOy/wzQ4pyRbVmQl3Vzc9boSHDup7njoaUL4
 9HTPAPPuUkZ/Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3MsG2rxJzK01; Mon, 12 Oct 2026 18:11:14 +0200 (CEST)
Message-ID: <fdb4cc14-505c-4dfc-b6bb-4b13f7c84275@0leil.net>
Date: Mon, 12 Oct 2026 18:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] rockchip: Always init clocks in SPL build for
 RK35xx
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261012111552.1173161-1-jonas@kwiboo.se>
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

Hi Jonas,

On 10/12/26 1:15 PM, Jonas Karlman wrote:
> The RK35xx clock drivers typically initializes a few clocks when probed,
> with some clocks only in SPL. However, the clock driver is only probed
> on demand, so this initialization is fully skipped when no SPL consumer
> requests a clock, e.g. when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the SPL
> boot_from_devices() call.
> 
> This series flag RK35xx clock drivers to be probed after bind in SPL to
> help ensure a deterministic probe and clock initialization behavior
> prior to booting from devices.
> 
> This should help restore old behavior, e.g. that SPLL is initialized on
> RK3588 and CPU core rate is initialized on RK3576 when booting from
> RAM/USB.
> 
> The series may possible depend on the series "rockchip: Miscellaneous
> RK35xx clock fixes" [1] for a clean apply.
> 
> Changes in v2:
> - Update cover letter and commit messages
> - Collect r-b and t-b tags
> 
> [1] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/
> 
> Jonas Karlman (4):
>    clk: rockchip: rk3568: Always initialize clocks in SPL
>    clk: rockchip: rk3588: Always initialize clocks in SPL
>    clk: rockchip: rk3576: Always initialize clocks in SPL
>    clk: rockchip: rk3528: Always initialize clocks in SPL
> 

The RK3506 clock driver is notably missing from this list of "RK35xx 
clock drivers". I'm assuming this is because support for the RK3506 
clock driver got merged after commit c6bba31dbdd4 ("rockchip: 
spl-boot-order: Defer probe of boot device"), so it means if it's 
broken, it just never worked in the first place and we should rather dig 
into the problem instead of doing what we do for the other RK35xx SoCs, 
was this your conclusion as well or did I just incorrectly extrapolate?

Cheers,
Quentin
