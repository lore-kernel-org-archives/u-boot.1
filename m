Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F19CC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DDC560603;
	Wed, 26 Aug 2026 04:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZ445IxlhYRj; Wed, 26 Aug 2026 04:18:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787717887;
	bh=G0tub5C4+SWBwmLZuC3X9FpBsDEG1X2Vjh11As3eMpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJ+9uwpf9WrcWqVUQG3QrY1maNvHoqEwxc36FOmDuc93d99p2rCCk2BwfGKXlH7qh
	 neTc86z5SdnjPC6cKOM68Ho/FZRwsy3rTWdMHNe84pc1D+s8jFzVaVeO2I4P6KnERk
	 eI7j9+S6oJ5pp8BY8NUt3YVLSggOrSN+QBv+2/61i7+5O72Lf9ZgAin7PCUhSy6PtR
	 HCCUuwdX/SpgL+rLxlZcKiGYvYQydwkQqKkQrgmL7/x0cKkuu/7Rlm4q/pnSPV2O+Y
	 HYWDq6iULjoCCaXyAc321FkiLTb/iWN6MM2f1YrwxrviTGscAximc1f6YVRZkS5AcX
	 Yq3xB81PUd3CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D2AE605F5;
	Wed, 26 Aug 2026 04:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 280E0355
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 04:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EA1C40073
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 04:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jqoZWFUxBzhZ for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 04:18:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=U2bQ6vwD
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F202C4000B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 04:18:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C682D11CDC3; Wed, 26 Aug 2026 06:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787717878;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=G0tub5C4+SWBwmLZuC3X9FpBsDEG1X2Vjh11As3eMpI=;
 b=U2bQ6vwDjapWnkZ17amHZ3q5QaS9Kkqiq3bdWocZEgWNel9cuE1/0uFdk5LT+6N4+oi+zh
 Vl3+pl3yXIwc1cqvx+eY9O7GUrA0UBCh8pNRq62UfkcK+jqC7/bB+PdhWfkFKcfVADn3sB
 WNUF9KR+Vt6B1wq7o41l/illFgHgyXj5x7ArmUwl/w08ZJHqG7s81Nh6Ytj2BURoL070Y/
 rwO114BZ9JQPMhYnErtO4l4qFQa8NKu/su+Vtrl9l3CsewMtiXQUJLL2gGCL8uopcOswfP
 DCTvw/OVEPv7B6JhGaHSuzqHVM0njoglDKNFgC5GnUSEMgbL6vv820YmXWI0Nw==
Message-ID: <bf21b912-3699-db99-9226-870df57322df@nabladev.com>
Date: Wed, 26 Aug 2026 06:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Please pull u-boot-i2c
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20260825112101.4107921-1-hs@nabladev.com>
 <20260825200237.GC523975@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260825200237.GC523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Tom,

On 25.08.26 22:02, Tom Rini wrote:
> On Tue, Aug 25, 2026 at 01:21:01PM +0200, Heiko Schocher wrote:
> 
>> Hello Tom,
>>
>> please pull from
>>
>> The following changes since commit 2d379a529c257606946831a6dac1c37de6a3f8c0:
>>
>>    pinctrl: airoha: sync with linux-7.3 driver (2026-08-22 15:58:30 -0600)
>>
>> are available in the Git repository at:
>>
>>    git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git tags/i2c-updates-for-2026.10-next
> 
> For next time, please edit .git/config to have the https URI for "url"
> and then this for "pushurl" so that b4 will see this as valid.

I am sorry about that, I reworked my setup a little bit, but I have in
.git/config (as discussed in my last pull request) already:
"""
[remote "gitlab"]
         url = https://git.u-boot-project.org/u-boot/custodians/hs/u-boot-i2c.git
         pushurl = git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git
         fetch = +refs/heads/*:refs/remotes/gitlab/*
"""

as I made this mistake last time too...

I checked my new setup and found a bug, made a local test of the pull
request and it looks godd now... so, hopefully this is gone...

> 
>>
>> for you to fetch changes up to 35c2947b5b217962e8d88e2a0b7f507a037a0676:
>>
>>    clk: spacemit: k1: remove bus gate from TWSI functional clocks (2026-08-25 08:22:24 +0200)
>>
> 
> Applied to u-boot/next, thanks!
> 

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
