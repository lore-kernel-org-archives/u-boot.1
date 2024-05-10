Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1484EC25B74
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3118488003;
	Fri, 10 May 2024 21:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KAgTQfWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0B088027; Fri, 10 May 2024 21:24:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D44A87FC6
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 23EC161E7D;
 Fri, 10 May 2024 19:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC050C113CC;
 Fri, 10 May 2024 19:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715369087;
 bh=oYYUINpLf5HQVfZc4VZijXJu8ogaXaV55DJo53MSBDg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KAgTQfWDjgNPffQLjdfu8GjJThM2ME2FYbWOJJLwMVDwrlC+56XBxyHLH6OwymgK4
 hOwI6ohg/iKczxvOMnRuCad96UB4MbG8iPwK/jbzS8voubv1sUpkmUxcM9GcY05kJx
 JMuKcmraNO4hfFCsRnHXGkEaKm4ww6aANIvhJJeHourtK1gucYQTCfo/dy3/408BEV
 cEpPQ9QpGeZRre5dMmuBc1/0bD6DdORp1O7/p+PqeWolWJLh+EL979nOFHgHmTP+O8
 uMxZILnCQHv5uKZFtF/1x/oQyG7eK+kbKCyruZRP2FZqr8pb2ib4nHAw2ju/K4IT71
 qfdiRn/fSE4EQ==
Message-ID: <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
Date: Fri, 10 May 2024 22:24:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
To: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com,
 r-gunasekaran@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
 <20240510130830.GT2568172@bill-the-cat>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240510130830.GT2568172@bill-the-cat>
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



On 10/05/2024 16:08, Tom Rini wrote:
> On Fri, May 10, 2024 at 12:55:15PM +0300, Roger Quadros wrote:
>> Tom,
>>
>> On 25/04/2024 15:20, Roger Quadros wrote:
>>> Sync AM62 device tree files with Linux v6.9-rc5 and
>>> add in the missing bits in -u-boot.dtsi to get CPSW
>>> Ethernet working.
>>>
>>> The last patch is marked [not-for-merge] as it is not yet
>>> applied to Linux device tree.
>>>
>>> CI testing
>>> https://github.com/u-boot/u-boot/pull/527
>>
>> While the checks have passed, there are some recent conflicts introduced
>>
>> Conflicting files
>> arch/arm/dts/k3-am62-phycore-som.dtsi
>> arch/arm/dts/k3-am625-phyboard-lyra-rdk.dts 
>>
>> Those files have been removed.
>>
>> Do you want me to rebase and resend this series?
> 
> Since part 3 was a do not merge I wasn't sure what the end goal of this
> series was.
> 

Goal was to show what is required to get Ethernet working and DT synced with kernel.org.
part 3 can now be merged as the commit is now in linux-next. [1]

Maybe it is best if I rebase and send this as v2 and drop the do-not-merge for patch 3?

[1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
      commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40
-- 
cheers,
-roger
