Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CBAC624B4
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC238763C;
	Thu, 23 Nov 2023 12:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jAqH5jn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751A38763C; Thu, 23 Nov 2023 12:39:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B24E86FB2
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9e86=HE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1700739538;
 bh=kMhcV3HAON17/rjSK1PwoaJCAL7E2wgR3PPGw7h/h44=;
 b=jAqH5jn6xS/bUeJyHMW+YZ53W+QPJhOT4tb938hLTy9YyDJ9D2nqmo5jf22CXRoNY66fWM/69
 /OcVoXu0rutGI+iY6GfkprwItYiWycEZY5ByLp03A22pKMbWurla7EPotOEmBm1Q4DbF08TFiF0
 COqkdKx0CC70FyfoNzMujeadbYdJBA3dzQlkX6iQ/hhN+YVxTb6gNZgKLNZtfyITh98L7GaF0Vo
 g+mWaflhL2zI8V/xZ0dDumIW/C/Ge+dL/8Lgx0ydXxar30Csirt+zSVXJaXEa3pKcG6BA7GLH2O
 +Lz7w6ZSUtCd5kwTTHuqN4HizkLxrqqu85mUPPrp8Rlg==
Message-ID: <894ebcd8-6246-4bdb-97ec-58c609f050a4@kwiboo.se>
Date: Thu, 23 Nov 2023 12:38:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: eMMC errors on RK3588 (rock5b)
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, Tom Fitzhenry
 <tom@tom-fitzhenry.me.uk>
Cc: u-boot@lists.denx.de, kever.yang@rock-chips.com
References: <87pm01oxd2.fsf@tom-fitzhenry.me.uk>
 <65cd4f1d-10fe-4701-b362-3995f8f0bfe8@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <65cd4f1d-10fe-4701-b362-3995f8f0bfe8@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 655f39d251fb2157a0025238
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2023-11-23 10:58, Eugen Hristev wrote:
> On 11/23/23 07:22, Tom Fitzhenry wrote:
>> I am able to reproduce this on RK3588 QuartzPro64.

I have also been able to reproduce this and made the following finding:

rk35xx: drop ddr52 mode to fix write
rk3568: change txclk tapnum to fix write at hs400 speed
rk3588: enable hs200 mode to fix write
rk3588: drop hs400 mode to fix write

Have not had time to complete test and send patches, should have some
time later this weekend to complete test and send patches.

WIP: rockchip: rk35xx: improve emmc write
https://github.com/Kwiboo/u-boot-rockchip/commit/cb1521aea8dee730bddcc5772afa28aa71fc69f9

Regards,
Jonas

>>
>> I cannot reproduce on the vendor u-boot, used on stock RK3588
>> QuartzPro64. That works fine.
>>
>> I thought "[PATCH v2 RESEND] mmc: dw_mmc: reset controller after data
>> error"[0] might fix this, but after applying that, I am still able to
>> reproduce the issue.
>>
>> 0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@collabora.com/
> 
> 
> I never said that patch would fix this issue. It fixes another problem 
> that was happening when the controller was resetting. But that issue was 
> arising only in a specific scenario which happened only during my tests. 
> So the fix is here, it's helpful, but not fixing this issue.
> And it appears that this fix will not be accepted to upstream, as it's 
> months since I am resending it.
> 
> Eugen


