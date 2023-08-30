Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33225C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 08:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA0F8643D;
	Wed, 30 Aug 2023 10:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VzPVT/Ok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBB086520; Wed, 30 Aug 2023 10:07:23 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30073863FD
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 10:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.115] (unknown [176.236.51.75])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DE2066071DF;
 Wed, 30 Aug 2023 09:07:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1693382840;
 bh=eWLwQXolLdHbuXvtq1XHx68b4NJRi3UQHsUA1e7kVKM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VzPVT/Ok5bOMs/cb09Tr2iROHGw4+3G932x1S6ljloawEn7V/wiHFYwcKv2uvn6QP
 rAKRx1lm7GmT7LhyumY6MuTzVyom7azp5VBhVJsXUXyusCz6cqBBMOtvZxkKFhr1/E
 VuCt56n245ODzeUz5iLuRqExeiGcz6KOq3JBE2tKlimwlb3Wnb6oRtQ2g8cIZIIZJI
 6SNdPCoqeNy9GnnvjZLRf0Sdb9Y7G1gijih3puBT8gaEzPlJSnaLGOf4Bm8rhRbomj
 m08JapKvIWJLf94OSpTNhDJ5dqeoJRCu7Wy8kItv8g7tOXiDdu2tJLBE/C3KnyjHHM
 LJEZllCmkeuvQ==
Message-ID: <00646f8c-d217-56c7-b6ab-bea73caf6e0e@collabora.com>
Date: Wed, 30 Aug 2023 11:07:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/5] at91: sam9x60-curiosity: Misc improvements
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>,
 Durai Manickam KR <durai.manickamkr@microchip.com>,
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>
References: <20230823135856.376351-1-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230823135856.376351-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/23/23 16:58, Alexander Dahl wrote:
> Hei hei,
> 
> while working with the sam9x60-curiosity board I noticed some things
> still have rough edges on U-Boot shell for that device.  With these
> patches (and some more config options enabled), the following commands
> now work as expected: reset, led, button.
> 
> The whole series is based on atmel/next.
> 
> Note: some things here might be useful to implement for other Microchip
> boards.  However I currently only have this one board, and I'm not sure
> if this is a direction appreciated by Microchip?  So you might see all
> this as suggestion.

It is appreciated by me, so thank you !

Applied to u-boot-at91/next


> 
> See notes on patches for specific changes from v1 to v2 and below for
> summary of the changes.
> 
> Greets
> Alex
> 
> v1 -> v2:
>    - reworded some commit messages
>    - reenabled CONFIG_SYSRESET and CONFIG_SYSRESET_AT91
>    - split up LED patch in two new patches
> 
> Alexander Dahl (5):
>    configs: at91: sam9x60_curiosity: Sync both defconfig variants
>    configs: at91: sam9x60: Switch to new reset driver
>    ARM: dts: at91: sam9x60-curiosity: Sync LED nodes from Linux
>    board: sam9x60-curiosity: Let LED subsystem init leds if enabled
>    ARM: dts: at91: sam9x60-curiosity: Sync gpio button from Linux
> 
>   .../dts/at91-sam9x60_curiosity-u-boot.dtsi    | 18 +++++++
>   arch/arm/dts/at91-sam9x60_curiosity.dts       | 50 +++++++++++++++++++
>   .../sam9x60_curiosity/sam9x60_curiosity.c     | 18 +++++++
>   configs/sam9x60_curiosity_mmc1_defconfig      |  2 +
>   configs/sam9x60_curiosity_mmc_defconfig       | 17 ++++++-
>   configs/sam9x60ek_mmc_defconfig               |  2 +
>   configs/sam9x60ek_nandflash_defconfig         |  2 +
>   configs/sam9x60ek_qspiflash_defconfig         |  2 +
>   8 files changed, 110 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 0498ff933813932ff057cdc314ab46df4a596d06

