Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B536C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F5B887CB;
	Fri, 31 May 2024 18:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GInOB4Gh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A46F887F6; Fri, 31 May 2024 18:53:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546E08657F
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0494E62802;
 Fri, 31 May 2024 16:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E13DC116B1;
 Fri, 31 May 2024 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717174408;
 bh=te3EO146/YZmdF0QH8nBLd0wEff/auHe1vQNCso8KFo=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=GInOB4GhXPuWSltvyj9er9YOAwaKbZre5NIa5bG3DXkM/mL0xmZ4pqQKEp/L1isz3
 FIlzix/UdNA+C42c+HImxYA10b5tq6HUFlk1ApuiReo4M+Tjz1YMr3NRGhOwK2CFW6
 geKKokh7/T8tPTLurkPNqCc/T51RG+XbdVPXNIOkggjp98wPvaVh1JPufzXYfXg42N
 5ZJeor5X52yzerJQ1Zjw1y1GstZmWMbETz/emjYWoeAUuYSLtcO9/BDPI6Od1zDQHF
 hNRcan3NIKiRjdah1D3/n99E81r803hxY3rURoSYyxwQiSJElJgWPqHf1V6BjUmlzY
 B2NkOFiqMtYgg==
Message-ID: <7eb83ef8-e405-4441-b9cf-4aa6303b3259@kernel.org>
Date: Fri, 31 May 2024 19:53:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
From: Roger Quadros <rogerq@kernel.org>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com,
 danishanwar@ti.com, u-boot@lists.denx.de
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
 <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
 <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
Content-Language: en-US
In-Reply-To: <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Tom,

On 31/05/2024 19:32, Roger Quadros wrote:
> Hi Tom,
> 
> On 20/05/2024 18:56, Tom Rini wrote:
>> On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:
>>
>>> Sync AM62 device tree files with Linux v6.9 and
>>> add in the missing bits in -u-boot.dtsi to get CPSW
>>> Ethernet working.
>>>
>>> CI testing
>>> https://github.com/u-boot/u-boot/pull/534
>>>
>>> [...]
>>
>> Applied to u-boot/next, thanks!
>>
> 
> I see that this series was applied to u-boot master as well
> and then later reverted by commit d678a59d2d719da9e807495b4b021501f2836ca5
> as it was based on u-boot/next
> 
> Can I re-send this series based on u-boot/master so it can be still applied to master?
> Without this Ethernet is broken on beagleplay.
> 

This series apply cleanly on u-boot/master so no need to resend.

I've created a pull request for CI loop testing on u-boot/master.

https://github.com/u-boot/u-boot/pull/572

-- 
cheers,
-roger
