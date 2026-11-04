Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF445606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j3ePTnNl;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=kmH0Rj8R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FA2A606C4;
	Wed,  4 Nov 2026 01:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXQUfsGo0UFd; Wed,  4 Nov 2026 01:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD92B6066C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793757236;
	b=mVAgJEtUK8HCV8ogxE1SrIX8ES6MgwWkmJgvAF5vXHxiF/CT1XBvTv4AkWRs71r34IhZ
	 04g2So5b/3bmsP1mNarNIIEMURkareYkuVzYA2glGXEMVDSvZx3ant4kiazLx6UsAZGQe
	 5feMgCH45MsRsF35ZoSX1R5dRx1fhiXBTszVosAonVZm0bxdbXkehVvwTJevkFTAhPTyO
	 g4iIbybrA77CkltawZTGxZlgg5Oom7hTCp1VxXZnUGlgoraq7ngQrhkfXdamoFU9pHk+C
	 K7ecfWAoT0582wCOuLXGB8WYnXiAiBDke6owpATQ7tdp8tjp49ygQJSAd99NHu1Re9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793757236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vHxdIPZ/+dSF7dZYQQSYtsg89jNPc+QdopvovD6MqO4=;
	b=KFuSQIT6ai5MiPRBZIhv+fEoqDi9/NkwQmqZ0O3LXS8SQSQhhXdpiUWHqAhYJs2SrNA4
	 li2eDcO/Wycpl1JODXjfPuXOHyT7YgstvETuPNJBpMIF0AU092sPOOZ/6FTGf05FlWyDz
	 GPXGUQlqoZyXhZRZFOjxGEfIEVfi4tL50YwY+IJ/9E9sb5bpMP7/wU09m17p6ZH7XHDr6
	 dEVOUlRpcySQuk1sRiXMGGDOHjImCQHJMLbUk6cwHoB5gezZzaXvW4pDNCKScb/WYiqLe
	 o0jAmuBqQpKpbkQY4GCRQKzjTGDfGdHR/iSEixYKBG0wr4rien5PL5JJFYBM5P152nQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793757236;
	bh=vHxdIPZ/+dSF7dZYQQSYtsg89jNPc+QdopvovD6MqO4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3ePTnNlE5Li0TgnBULFH5Hnd9MXMFoXuHNp6NE2jBPFkobNP/zJ/6wRzZrlvP4JS
	 JLXf+94WVvUFPaUFN6bHxlE3GoaqnuvR1vO3VQvxbsKvZsK4aSBvl0WiXmvdBubWhQ
	 ybEqYNV8SproCP4rbdyPqKlc19m+zYNdyknjFu1xvlGrUBYjf+O5uvTQ8AjbLugUNQ
	 /VNf9Kop5OD7zEmtE+JfOdBgMZCGm5ueZeR61yFgFCDiM9163pbcQLb94mafoh3c6F
	 OnqK/ur2F3RS1iwfBAlN3YsxO6vvnINJ83KbTVDpQ/1vudmdj0f8jStCgK2L1x6ZTG
	 dut/tXQhUAqfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD92B6066C;
	Wed,  4 Nov 2026 01:53:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CEF1784
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 01:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2B9E4054F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 01:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSJRQS-tXoA7 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 01:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DFFB40517
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793757232;
 b=eak6NESsxBbLLPl5vnJdImqk0ta3aSUaZGfJOCAGgrXrDBSys8mlpihSVe8RxWIFgWfd
 BAKPR38HdPNY1XlHMrk+t0j1X6+aOVGqa4fEFkv/b03YhEXaFy64TvpxLS7E9btvEU1Oh
 e+53rS5J5eMvb64VvgDw8xWBP3vwJ2k6fUyo2DP+pyGG1GHtLWA94x42dDdTD0FgxMR9O
 fS/7AonUkbT9BS4+GXiNjQxaDx06m4+Ed3SDLWBLcYt9J60UrNpFolDyW8H6CqRyJiwYT
 L5gAOcQjUPVMF1Fopt1ZIHCpHE7piIkBrHVuJb6I4YCjtWZrIwOvpYybc7jLLpuQ1mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793757232;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
 DKIM-Signature:X-Virus-Scanned:X-Virus-Status;
 bh=vHxdIPZ/+dSF7dZYQQSYtsg89jNPc+QdopvovD6MqO4=;
 b=si57u/hS1sdD/rxUHLGzvo7l1jRFDt8YMK9D4x9Igy5aVgIp23aWqG2P/AHcmrOYI2d7
 y3zWfNDd6cmpvGhGR6JiBGwf+4gxhs2FaBbDaAzEiks8R4ywQLgZy4npUoqmaZE0Xpz6q
 dw2uaQdfJjqoUrdkxucYr+9k3blFcSO0yUKeJFGaDbiGShqpD3OScZMC79g6FVpI13oLB
 jm7Zof8z1MJpJbs7Keyaco001t4djS8cpL6Hm4XaXa4Km9cviSQuqpfBUOthjyDqn7oeV
 md8Mjyis7IGHOmJ8WAkBEmdTJtZRL++wtCxZxnDM8f/tddEacINjPjCukXWlAZ8cyqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=rock-chips.com;
 spf=fail smtp.mailfrom=rock-chips.com;
 dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256
 header.s=default header.b=kmH0Rj8R; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=frank.wang@rock-chips.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=rock-chips.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=rock-chips.com header.i=@rock-chips.com
 header.a=rsa-sha256 header.s=default header.b=kmH0Rj8R
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DFFB40517
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 01:53:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEAD08480F; Wed,  4 Nov 2026 02:53:39 +0100 (CET)
Received: from mail-m16023652247.xmail.ntesmail.com
 (mail-m16023652247.xmail.ntesmail.com [160.236.52.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E6483E76
 for <u-boot@lists.denx.de>; Wed,  4 Nov 2026 02:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank.wang@rock-chips.com
Received: from [172.16.12.33] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5366b3ebf;
 Wed, 4 Nov 2026 09:53:26 +0800 (GMT+08:00)
Message-ID: <95e91156-4ea3-4d1e-a0ed-ddd4de47be73@rock-chips.com>
Date: Wed, 4 Nov 2026 09:53:13 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: fix abort on invalid ref clock rate from
 clk_get_rate()
Content-Language: en-US
To: Peter Robinson <pbrobinson@gmail.com>
Cc: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, macromorgan@hotmail.com,
 sean.anderson@linux.dev, heiko@sntech.de, u-boot@lists.denx.de,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 chenjh@rock-chips.com, wmc@rock-chips.com
References: <20261103082732.18483-1-frank.wang@rock-chips.com>
 <CALeDE9PLaF7rB2RXn9G6ipWW+J5dentCtyNLgdwTUywgiTnooQ@mail.gmail.com>
From: Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <CALeDE9PLaF7rB2RXn9G6ipWW+J5dentCtyNLgdwTUywgiTnooQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1a442d5b709d8kunm79f8860c3985fa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQhlKGFYfGUNKQx9KGE
 hKGU1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUJCSU5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=kmH0Rj8RuclXxYANRsp9+VX7ytvQmWMzF1OG8dzMdgrV3jsrTF8Jd8hAG17a4HEauUs4PzYOFvymOg5hgRbyropkzl1HmyqQAorHnSOmp9CzkhG4Jp6sciq2/mqiZ78P/5WAKYC6WJZO8y5S+fTsWipLRYIbr+Y90mb+loE8gEQ=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=vHxdIPZ/+dSF7dZYQQSYtsg89jNPc+QdopvovD6MqO4=;
 h=date:mime-version:subject:message-id:from;
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 2026/11/3 17:42, Peter Robinson wrote:
> Hi Frank,
>
> There's a big rebase to sync with upstream Linux driver [1][2], I
> think it's due to land shortly, does the issue still occur with that?
>
> It would be good to get the rockchips SoCs with the dwc3 controller
> tested with that rebase.
>
> Peter
>
> [1] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637669.html
> [2] https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637734.html

I checked the usb_dwc3_sync_v10 branch referenced in your email, and found no code changes related to this issue.

In the Linux kernel driver, getting the dwc->ref_clk rate is mandatory, so this issue does not surface. In U-Boot,
however, getting the clock rate is optional. Some platform vendor clock drivers do not implement clock rate retrieval
for all clock IDs. Therefore, adding a check for the -ENOENT return value can improve code robustness.

Additionally, mainline U-Boot codes do not yet include support for Rockchip 32-bit SoCs with dwc3 controllers.


Best regards,
Frank

> On Tue, 3 Nov 2026 at 08:28, Frank Wang <frank.wang@rock-chips.com> wrote:
>> On 32-bit platforms, "usb start" aborted with
>> "### ERROR ### Please RESET the board ###". If the clock driver
>> does not implement the "ref" clock, clk_get_rate() returns
>> -ENOENT, which dwc3_ref_clk_period() treated as a valid rate.
>> period became 0 and the fladj calculation divided by zero; the
>> software 64-bit division on 32-bit ARM calls the
>> division-by-zero handler __div0() and hangs (64-bit platforms
>> survive silently since UDIV returns 0).
>>
>> Skip REFCLKPER/GFLADJ programming when clk_get_rate() returns an
>> error code, as is already done for rate == 0.
>>
>> Fixes: 6bae0eb5b8bd ("usb: dwc3: Calculate REFCLKPER based on reference clock")
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>  drivers/usb/dwc3/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index be198041f08..9a84ec6a60e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -151,7 +151,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>>
>>         if (dwc->ref_clk) {
>>                 rate = clk_get_rate(dwc->ref_clk);
>> -               if (!rate)
>> +               if (!rate || IS_ERR_VALUE(rate))
>>                         return;
>>                 period = NSEC_PER_SEC / rate;
>>         } else {
>> --
>> 2.17.1
>>

