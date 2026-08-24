Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA34C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA6F4406AE;
	Mon, 24 Aug 2026 08:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxratDU2Xp5K; Mon, 24 Aug 2026 08:22:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787559769;
	bh=E0zFX/11JqFYF+bWrZ2LEzhY/v8kzLOrZwjvJo5Y3VI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZxqDb5HpsOYmmw5z1/ki5ToAKdQD9Pfh2IdJRa0PdrTHXB6fRirmiKmVho+BWb3BB
	 v4vuvAC5H250l5GQgjaISl/rbKTvOZJHY+x0zfZpb/bvKnQX0g7RuXPrH1xdaWZNjt
	 OVIZ+2Fc04kCcGubPsKXDMYwvVEk/tEuRemgQwu2OGH+L7Vg7rJV7BG95jiYxO+yRy
	 ravApyMAaFZZSbI3k1A2P87OIVYa77epoXDIN0KE42aNSEC/Fy8BPfORl0eYqCqXl4
	 8hREnozFA9M4ERCnPMvhxrALssRSJ5vnwUqORFSylQB2zmr15wbzUpiHlmhjwAJzpX
	 aEi1hLxfAorsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08D8440565;
	Mon, 24 Aug 2026 08:22:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFCF029B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96842400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:22:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byuj4vXGrBoi for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:22:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=AzUhbbPj
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B6D94005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:22:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6F0F811A644; Mon, 24 Aug 2026 10:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787559757;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=E0zFX/11JqFYF+bWrZ2LEzhY/v8kzLOrZwjvJo5Y3VI=;
 b=AzUhbbPjDlhYYulMA2HIQMxtm8C2q4MrMe/V22kopKon7ozgMepkUmerHhT5U4ypRCbNWE
 L8JDp0mQLn14SksKITBnqS5KAx/9esXotN8fCXs9KMCscM+5p16WjoIE5OFaZVRnSPIwmw
 4iC3+4+KpjGxNh4HUOyl6Z+wTn9RSoPkcFjyu1vxTZhhm0Ptx5hTI8I912WvCKKNrhs/To
 n/4I4Vn5WThrS09R87N9/ulBDKPrPWCtQh5jgz9zjfgRH9eZd2QCzNNXv9bzGZDudukLOA
 7AcI3JRO3V+xOoUUnbqEiwd6ZWjlI+qmhv30Faxnx/+LJVLeuhAfdlwvVYlc+Q==
Message-ID: <e4ad1d7a-ad9e-3cb1-e1ed-ad95f22b5b14@nabladev.com>
Date: Mon, 24 Aug 2026 10:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/4] i2c/clk: spacemit: k1: fix I2C bus configuration
 and clock handling
Content-Language: en-US
To: Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Lukasz Majewski <lukma@denx.de>,
 Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <aoQBacTKiBXUDddj@pie>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <aoQBacTKiBXUDddj@pie>
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

Hello Yao Zi, Junhui Liu,

On 18.08.26 08:53, Yao Zi wrote:
> On Sat, Aug 15, 2026 at 11:40:20AM +0800, Junhui Liu wrote:
>> Fix two issues in the SpacemiT K1 I2C driver and clock provider.
>>
>> The first issue is that the controller bus mode is selected using the
>> functional clock rate instead of the requested I2C bus speed from the
>> device tree.
>>
>> The second issue is that the TWSI functional clocks incorrectly include
>> the bus clock enable bit in their gate masks. As a result the I2C driver
>> can operate with only the functional clock enabled, which diverges from
>> the device tree description and the Linux driver (both expect separate
>> "func" and "bus" clocks).
>>
>> To fix the second issue without breaking intermediate states, the
>> patches are ordered as follows:
>>
>> - First add the missing bus clocks (and their parent chain) to the SPL
>>    clock tree.
>> - Then update the I2C driver to acquire and enable both the functional
>>    and bus clocks by name.
>> - Finally remove the bus gate bit from the functional clock definitions
>>    (except TWSI8, whose write-only register requires the combined gate).
> 
> Personally I think it's okay to break booting in this case as long as
> you explicitly point it out. Merging the conceptually related PATCH 2
> and PATCH 4 which together fix description of TWSI controller clocks
> would make the commit description shorter and clearer. But it depends on
> you.

For me the series is okay now, if you (Junhui Liu) have not prepared a
v3 with the merge Yao Zi explained already ... I will pick v2 up for next...

Please give me feedback, what you plan, thanks!

> For the whole series,
> 
> Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks!

bye,
Heiko
> 
> Regards,
> Yao Zi
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
