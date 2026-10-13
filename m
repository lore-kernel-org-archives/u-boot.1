Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049EDCC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD4516072B;
	Tue, 13 Oct 2026 14:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WY8s2ag83yOZ; Tue, 13 Oct 2026 14:24:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14EF36073C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901472;
	b=ExJAVgirSnyJEKOtrQhOQ5Jp+6Hd6y6nIuKHO7ypMRy6SgEF6a6R8X8TVzL9BTKQQ0rP
	 Q05UjjVID8i2vqAo/5nbMpWZ9ZH7dWRCpSwRfEDe/YU0JhdPhkbMAcErU3yk7SawOwUby
	 d4kSc0jhmwIV2gmIJwjgN1aAvCVeD+v4Il3ytnIUf8YTvJ0AS6Hdn+psqfaG2JngkgdhN
	 usdR2LnsI4HTssHC/Ln3WfUpQWslHav2Ogy9ESzLVOFXU/Dj73eGhQUpK76mu1d/zapAO
	 2dvN5K12i8y3mTpxyX8I/c+SC7Hu03BVYsJcMux6C6oT3rvsolmkLsKV9cj+be5VxyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901472;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Go2jadT7RbfVrealklh5ScqMA0b0XYelJ3LsUY43uBQ=;
	b=Pvic1/LujsZtoVqwtlX63qwAggqSRgaMYWpPb/ACNscaaEn+KX9dS2J///yonXEhhOSD
	 26eG1lkq0VSsHJjwO2H119Q0k/NY0/qA997JJG3z2L+RWmT0V+sRiuY15aolHZSgGXMij
	 4l7IbXTbb2xyAapjYi1Y+VnGiyDHrLrW0xsaa+CIYyforPJ5VfqEhAJp46bUYH/m5PMuh
	 NHlYQi5qPV66AVGb8f2FvLgoi0h8Ir15idU9E7thwOGWlModw0kX3iTehQN0+ckwAxe9S
	 +8IKSmvyFY9spazpPyqVltOYhw/YpwpHo1V73Ebq3ODqHK1M1Z1tyk2tB9CKP47e+ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901472;
	bh=Go2jadT7RbfVrealklh5ScqMA0b0XYelJ3LsUY43uBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=an7/vhUEOniNW2dMmkQNZql8QXZ705fm6SV6ywcY3LcQ726mB0dJMaWspjagCZAtV
	 YSkCavcw/sCJhXH+/e1N4Hmvm7MfMzyS4CaeS/v0sFIsGWSUc0mkFYZ2sC/BtjpK8/
	 DP8awP8koTyCfkFNTiAG7HwJbsBGpNWj9EluB9eVGaLQozZfKoIKquOQuYoIfyQl/8
	 JkA7LgFOZr7pNaMz2mn/1dE8UO5VGnKbEVACUGFX18WGGc093sCWFMZYW3xjzkbDzk
	 4qhZGIIlT3cbIJxuBJBuV0Tlhj9sg7AI8pbjAY6FaqZ2URCsKi7+sUOhJUhnLSKKgo
	 HOCsY+CH2PAvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14EF36073C;
	Tue, 13 Oct 2026 14:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B1291DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CA8680849
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01Xgerr44n4k for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 675258083F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896567;
 b=IyqX7qF6IQm6iNnUrJn+Q08NEWifvge12VITbtnV6C0c42wlwoZ+GNTnA6fa+hC6QK22
 fQouSwnIFnHrrwmAMHSLKg0VqUtfQiCdGcUYcHsqDUuv8ezirthucqP8p7ABZKjajaIlz
 For4cK2pVZjyPX2Lm/8bjl0B9OArbnRLGyWc9cozRbIQDz5Ak+Jm5Cm1/gTp0Pf0Ku2gL
 BDXXDuID5lpiAM2pvertzGMRx6SlMUZ7Ll1qbf8GIX68lhWEP22LoZ3ryQilXFzavT0WI
 5y4MQItRNKO2fbmBX0w9NqCrcRp2e1lS35d4BN3PH0SGoA9vhN95aRs1m/R1CbuBZCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896567;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Go2jadT7RbfVrealklh5ScqMA0b0XYelJ3LsUY43uBQ=;
 b=J6gcnLLxl3Rx2Wadbdl+F42vwd2X7cObnMIzhtTKmw6BJ3gvGdeQ8qzJKOdwz23rTVuP
 Q/FuGp5WFhKRe+hn2PqNwgkC61v3DP9wQhpuaWEaFQXoyClgp0IbFL4li7rryKI4OQ6J/
 FXtK983TVwLDpcEEJqG8wNtmFroKBwbX9lTAtgAntphkWiAm/myZIi28hXbTARdMRweF8
 GqALFUX/Nq+DjZMvA58/MwjYVpcltkP7eJdZ/FBUYeCIWBpSoXkMZ4L3DMnz6tWRS4lnP
 FZp/J/ECINvWYW5hPzEmwxAxRrE2KoUN7KE7JG9bxmivqSkYduT5gvMojT+050xkF2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iO1nZs4w; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iO1nZs4w
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 675258083F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:02:46 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2a6d40404fso33256166b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791896565; x=1792501365;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Go2jadT7RbfVrealklh5ScqMA0b0XYelJ3LsUY43uBQ=;
 b=iO1nZs4w5sfCD1Pk/X7ss+eL1dv0cjgzMQv2e+y7a35cZBikbmWYSYo0K46EN79FIB
 6yiocj+Qj6v61uAFsKYJVqPd7v/O5paG+2YYJuhz4LMWkdaO+Je7D8sQPdkq6tETVaSf
 jLRwp30IZCxNDLruyHc9wrMbR3EW91rQHcIifDaTSI5eoULtY0/zRdXtgR94GbV5VcSS
 Po0sCP9hDzoBgJar90eXw7206gjxclnmbWF9dDofnue37SucBWrT2oqMvG6ssz4XikXb
 8gWUS2P9SP1p9/O8zNll+wMQwnzDcI4udVQjmKdXK/AUCpvTW6VZgzRfqKmu4uy3Rv4W
 FFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896565; x=1792501365;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Go2jadT7RbfVrealklh5ScqMA0b0XYelJ3LsUY43uBQ=;
 b=NyT0Iah+EYu6a2cbyy9KebYpZEdQNKohqdV4IIjh3u68ce6nuSmcwuaHb9uJCo3QXb
 SOmdhd2veOSarkJJWqU/6f0IhkR1EEVENqna+Ud8d/Y7jHV9l3e60B5GegEabr8q9Vr6
 G14ldAOg7d3KbfH3ln2VNY2/kPWigGLVgaSgzGRWTTOm6kVXmA8VUaFULFASyPmAG6hx
 JTfZbO4HnEjNIC3bIwFcKFtRTl2BgGoPUcjRqqoeWGO/lqGHwGWMRfXj5jqbc0Z1YeoI
 0G5IIzI1QiFIrzme9D2OfT0nbgO3TKYNSAceZDsoAmO67pLm34+b04v2T1C7XlM8L234
 IaRw==
X-Gm-Message-State: AFq9FYId3vPvWvvpLFUFKge6gP6tKEbHYMzMYThd2W+1qKa8ORWyRJpf
 suxq2cn0YFYgcCwJXMNZaEkOfFU63x3MekDESKVbii4ZWW46sRQthEf+swyeF8K4Y6Q=
X-Gm-Gg: AYBFou1No7ORnth0nI/XnABVRm2YmRrXxOXcq5ICfNF6PNNT+wpBrAg/apShypp3Liv
 erT3kpCq4FKC2tN0TLaxa6TvIE/LEihY5hWE7IEMXzyBT3D2TlYYtOV6zSS/e4k5NjyYwniN7Mp
 070byXFQ4ILbP1U13uYeUBdxUMawha1R225dNiBhavbaFjnFOTl7vzZAFj6d7PPVLwTmPAnknCl
 mtVfof+HPkBaUHbWPgXL9QkaQ/ECnMLApjl5AuvB7lx5O9QDyJDOJgdVSI7VrXt5j1tq9JEU2Kr
 Hz+0gZ5QBqrkTwUbhtv1rLk/bugL65mEUSMysiJHAr1b389a1UnXVrN/Tl9UgtppEJOtq3WD9/V
 TYJYd3hJdSqKhsVKMjBOW/9nxxao9sQBuLQDZQe607UD+8aA9pHEWVz2IhTbnSfpAdM3BkrHlBb
 g1fs+5QtIGvmd0nm4qubHw2IFLzBltzVj3e0cfx86b40uq36/JRDHEPdj1cNtZLFtyYeF/U+ICL
 NEhRNFN3EY5zHygEbssnS2PzskKjww=
X-Received: by 2002:a17:907:d22:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c31a96e70d7mr1355810966b.0.1791896564649; 
 Tue, 13 Oct 2026 06:02:44 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c34722912a8sm275385566b.34.2026.10.13.06.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 06:02:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:02:42 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com
Subject: Re: [PATCH v9 00/26] usb: dwc3: part 2, make the resynced code work
Message-ID: <as4r8p_70JTOl068@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80e9e892-24de-4cba-b84a-35bdcb6a903c@cherry.de>
X-Mailman-Approved-At: Tue, 13 Oct 2026 14:24:30 +0000
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

On 2026-10-02 16:17, Quentin Schulz wrote:
> Hi Anders,

Hi Quentin,

> 
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> > Hi,
> > 

[ ... ]

> > 
> > Older changes are listed in v7 [6] and v5 [1].
> > 
> 
> I applied both series on top of current main (c92d8c3c431e "board: beacon:
> Remove i.MX8MP Beacon EmbeddedWorks Devkit support") and tested on RK3588
> Tiger (three DWC3 controllers exposed) and RK3399 Puma (two DWC3 controllers
> exposed). For each board, one of the DWC3 is routed to a micro-USB OTG port
> which doesn't seem to work (before or after your patch). Considering it's
> historically finicky in Linux, I wouldn't read too much into this. For
> RK3588 Tiger, the third controller doesn't even appear in the usb tree
> output. On RK3399 Puma, it does but no USB stick detected (either via a
> micro USB-OTG USB2 or USB3 adapter).

Thanks for testing on both boards, the logs help a lot.

You say the OTG port fails with and without my patches, so I will
leave that one out of this series.

With the defconfigs the OTG controller is not bound on either board.
dr_mode is "otg" and there is no gadget support, so dwc3-generic skips
it. That fits Tiger, but you say it shows up on Puma. Did you use
another config there?

> 
> Tests are performed like this: I insert one stick in a port and power reset
> the board and run the commands. Tests for different ports for the same
> boards are run with a reset in-between tries. If you want some other tests
> or a different test procedure, I can do that too, but only in a month as I
> will not have physical access to my devices for that amount of time.
> 

[ ... ]

> 
> usb write: device 0 block # 0, count 64 ... WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> 0 blocks written: ERROR

Do you see the halted warnings and this write error without my patches
too? And does the Kingston stick fail every time on that port?

> 
> # RK3588 Tiger: Q7 USB P0 lower retry with another USB stick
> =>  usb reset && usb tree && random $loadaddr 0x8000 && mw.q $kernel_addr_r
> 0xffffffffffffffff 0x1000 && usb dev 0 && usb write $loadaddr 0 0x40 && usb
> read $kernel_addr_r 0 0x40 && cmp.q $loadaddr $kernel_addr_r 0x1000
> resetting USB...

[ ... ]

> Total of 4096 double word(s) were the same
> 
> I also have two SanDisk Corp. Ultra Flair that are USB3 but they are
> consistently detected as USB2 in U-Boot for some reason.

Same without my patches?

No rush, I know you are away for a month.

Cheers,
Anders
