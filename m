Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7215C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 16:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58B64882CD;
	Fri, 31 May 2024 18:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zs0eqCbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE93E882F1; Fri, 31 May 2024 18:32:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF9988284
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 18:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C007E6290C;
 Fri, 31 May 2024 16:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C445C116B1;
 Fri, 31 May 2024 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717173163;
 bh=15NkxmH+izFvjZhpPNqR/wYJHUP47bUyIJhsLT1zziI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Zs0eqCbVwvGfKYVSO9Ye6TbSPrS8Hje9FJUq9xrMF/cVwCSY17IMUG6pRrtoDJrdy
 xZUG6KkNvlGy5FcMfS3Tl1oPdHfH1XUqTojTPaJ/ycK50V1pNuGkI8Cpgb0iErgrQ8
 dsKG/BiikeDnMyxzj6WwD5aEd3ucZu6lJ42uE1EfsJhpAY5A8xDcS4OhNSDdOPkP6g
 TwCskHs28hV+yIRK+Kd1JEGfxB5ou75t5W1c3ke+1hZJ/4neFTMQ/XKB9KAgLHWsex
 ysmbDuUXo0bgarV8KDoIU6lHA9CDDEn4Lc02renbI7k175TdFs2gURamOmF7e9wTHS
 THuOQwP71d5Nw==
Message-ID: <95fad9de-5fd3-4dd4-8a13-850dc81da26d@kernel.org>
Date: Fri, 31 May 2024 19:32:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com,
 danishanwar@ti.com, u-boot@lists.denx.de
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
 <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <171622056331.1577131.5584438868595064237.b4-ty@konsulko.com>
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

Hi Tom,

On 20/05/2024 18:56, Tom Rini wrote:
> On Mon, 13 May 2024 15:13:53 +0300, Roger Quadros wrote:
> 
>> Sync AM62 device tree files with Linux v6.9 and
>> add in the missing bits in -u-boot.dtsi to get CPSW
>> Ethernet working.
>>
>> CI testing
>> https://github.com/u-boot/u-boot/pull/534
>>
>> [...]
> 
> Applied to u-boot/next, thanks!
> 

I see that this series was applied to u-boot master as well
and then later reverted by commit d678a59d2d719da9e807495b4b021501f2836ca5
as it was based on u-boot/next

Can I re-send this series based on u-boot/master so it can be still applied to master?
Without this Ethernet is broken on beagleplay.

-- 
cheers,
-roger
