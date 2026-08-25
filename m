Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04712C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC97A80CE9;
	Tue, 25 Aug 2026 04:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0D3ukzXJ75R; Tue, 25 Aug 2026 04:41:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787632877;
	bh=B0UQVpN9VkUADkNO2SBBa9D12S4OIm1c39zg0ZDcpuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HvLTMbvyy4iqTX0Sfj9bW8mQ4YOFiC3QfE//SX3AECEoVjr9+3K18V+KMEbb3bC7f
	 yQ74dI6WGLzDg6QernR0gtuBlq25VbbCgW4ZnuUHdCtqwKo54fgRXrEl0S7sY9UME2
	 PTn2FPjme5TvbYvBakFpIBm9qBuV8qXiB4z2IfsohMevHRLYikXkJF+CXuPUDbFd4t
	 YYu2KrbSIgXddvPxhKDTS8S4ht5yAPk+n2JelZ71Flq0u3nZviBWfPo+Q9P1ad62IJ
	 5kB11jI8UTLyOz9i71lYFSjxrm22Zf8EWuslzlwffdzqAJ5I5gEs+HOFrK/eq1po6G
	 PIoUOX31zAxvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED7A80CC4;
	Tue, 25 Aug 2026 04:41:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB616118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E932440077
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irefJrNNAgON for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:41:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=ddcXzGj0
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDD9E4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:41:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 996BE11CB6C; Tue, 25 Aug 2026 06:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787632864;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=B0UQVpN9VkUADkNO2SBBa9D12S4OIm1c39zg0ZDcpuY=;
 b=ddcXzGj0197H83ZIVy7tIz/9KoSmBU+sc8Ka8hb3PVIWiXuZ7tj1xQ64S5gcWcUI+fu/nG
 Kezz/U5ndnboF/IwC5SP2kuX3qHsMYrAFlZ3JzjVvXHuvUBzuTPxZIddE3yCCrfhDkZj1T
 xdto1G2790rDOCYl/OTdHBV0/g7uuOZafSYrK9rAmt2wvEJ7d0e+6tzHAtZ9lepxyhMMZd
 xG/QFn40TDr9ZijosyqALL5J+xAdhWDCzNDA0bG+Fx1P+VrbfW8heRXsXYg44aAgAEIlSl
 OoJjsBQDZxdx2CXPK5LwrB3+Oc4EPr9xgYpgiOFFiPeiLY3k7dAxvZ0YL/7StA==
Message-ID: <5bf45815-25ee-0047-0bbf-9f095e35c137@nabladev.com>
Date: Tue, 25 Aug 2026 06:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/4] i2c/clk: spacemit: k1: fix I2C bus configuration
 and clock handling
Content-Language: en-US
To: Junhui Liu <junhui.liu@pigmoral.tech>, Yao Zi <me@ziyao.cc>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <aoQBacTKiBXUDddj@pie> <e4ad1d7a-ad9e-3cb1-e1ed-ad95f22b5b14@nabladev.com>
 <DKX8OE4FZYCZ.29V2B6GDFTPSY@pigmoral.tech>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <DKX8OE4FZYCZ.29V2B6GDFTPSY@pigmoral.tech>
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

Hello Junhui Liu,

On 24.08.26 16:21, Junhui Liu wrote:
> Hi Heiko,
> Thanks for checking.
> 
> On Mon Aug 24, 2026 at 4:21 PM CST, Heiko Schocher wrote:
>> Hello Yao Zi, Junhui Liu,
>>
>> On 18.08.26 08:53, Yao Zi wrote:
>>> On Sat, Aug 15, 2026 at 11:40:20AM +0800, Junhui Liu wrote:
>>>> Fix two issues in the SpacemiT K1 I2C driver and clock provider.
>>>>
>>>> The first issue is that the controller bus mode is selected using the
>>>> functional clock rate instead of the requested I2C bus speed from the
>>>> device tree.
>>>>
>>>> The second issue is that the TWSI functional clocks incorrectly include
>>>> the bus clock enable bit in their gate masks. As a result the I2C driver
>>>> can operate with only the functional clock enabled, which diverges from
>>>> the device tree description and the Linux driver (both expect separate
>>>> "func" and "bus" clocks).
>>>>
>>>> To fix the second issue without breaking intermediate states, the
>>>> patches are ordered as follows:
>>>>
>>>> - First add the missing bus clocks (and their parent chain) to the SPL
>>>>     clock tree.
>>>> - Then update the I2C driver to acquire and enable both the functional
>>>>     and bus clocks by name.
>>>> - Finally remove the bus gate bit from the functional clock definitions
>>>>     (except TWSI8, whose write-only register requires the combined gate).
>>>
>>> Personally I think it's okay to break booting in this case as long as
>>> you explicitly point it out. Merging the conceptually related PATCH 2
>>> and PATCH 4 which together fix description of TWSI controller clocks
>>> would make the commit description shorter and clearer. But it depends on
>>> you.
>>
>> For me the series is okay now, if you (Junhui Liu) have not prepared a
>> v3 with the merge Yao Zi explained already ... I will pick v2 up for next...
>>
>> Please give me feedback, what you plan, thanks!
> 
> I don't plan to send a v3. I think the current structure and patch
> ordering in v2 are fine, so please feel free to pick it up.

thanks for clarifying. I will add it to next, as the fixes you
reference to, are there.

> Thanks to you and Yao Zi for the review.

You are welcome!

bye,
Heiko
> 
>>
>>> For the whole series,
>>>
>>> Reviewed-by: Yao Zi <me@ziyao.cc>
>>
>> Thanks!
>>
>> bye,
>> Heiko
>>>
>>> Regards,
>>> Yao Zi
>>>
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
