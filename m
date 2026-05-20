Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2434BCD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 13:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4A3847F6;
	Wed, 20 May 2026 15:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XZGh8Xye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A795284874; Wed, 20 May 2026 15:41:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 058A0846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 15:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDA071C25;
 Wed, 20 May 2026 06:41:38 -0700 (PDT)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 E2A933F632; Wed, 20 May 2026 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779284503; bh=7idZiij8Qb0fAsUgOl32/Zb/AjPj9sC3EI8zE6dU4Dk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XZGh8XyeOoOLUZogRM0Jg7tNTIUXsqH9aWC+9AHBwU8TzviBGVWm8R+v0paioImqY
 Ku8KZRWK9EaV5lALr0HLoJf07nredHTAAC3+qARRGsyjp39r56Ii8ArCwroWaLrz/Q
 XDv0LzOVIfsQTShZBiLcxrHMOl48HLhQPHGjQ9Z4=
Message-ID: <b50fa4bb-d950-4981-9215-edc78d98429d@arm.com>
Date: Wed, 20 May 2026 15:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sunxi: a523: add gmac1 support
To: Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Schmid <lukas.schmid@netcube.li>, Lukasz Majewski <lukma@denx.de>,
 Paul Kocialkowski <paulk@sys-base.io>
References: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260519-a5e-gmac1-v1-0-c3117603b9fb@pigmoral.tech>
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

Hi,

that's a nice surprise to see support for this in U-Boot! I was checking 
lately and couldn't find anything, so this is warmly welcomed, 
especially since there are boards which only have GMAC1 (TV boxes).

I didn't look in much detail yet, but overall this looks pretty nice. I 
need to check whether we really need a syscon driver, but it looks 
trivial enough, so might not be an issue.

So many thanks for sending, and please have some patience with the review.

Cheers,
Andre

On 5/19/26 14:58, Junhui Liu wrote:
> This adds gmac1 controller support for the Allwinner sun55i
> (A523/A527/T527) platform. Unlike the gmac0 controller which uses the
> older sun8i-emac IP, gmac1 utilizes the Synopsys DesignWare Ethernet QOS
> IP block.
> 
> In addition to porting the DWC_ETH_QOS_SUNXI driver from upstream Linux,
> this series also introduces support for relevant dependencies, including
> clocks, pinctrl, and syscon required to make the controller fully
> functional.
> 
> This was tested on the Radxa Cubie A5E board, and the relevant options
> are enabled as well.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
> Junhui Liu (5):
>        net: dwc_eth_qos: add support for sun55i platform
>        arm: mach-sunxi: add syscon driver for system-control nodes
>        pinctrl: sunxi: a523: add gmac1 support
>        clk: sunxi: a523: add MBUS_EMAC1 clock gate
>        configs: radxa-cubie-a5e: enable the gmac1 controller
> 
>   arch/arm/mach-sunxi/Kconfig           |   7 +
>   arch/arm/mach-sunxi/Makefile          |   1 +
>   arch/arm/mach-sunxi/syscon.c          |  28 ++++
>   configs/radxa-cubie-a5e_defconfig     |   6 +
>   drivers/clk/sunxi/clk_a523.c          |   1 +
>   drivers/net/Kconfig                   |   9 ++
>   drivers/net/Makefile                  |   1 +
>   drivers/net/dwc_eth_qos.c             |   6 +
>   drivers/net/dwc_eth_qos.h             |   1 +
>   drivers/net/dwc_eth_qos_sunxi.c       | 254 ++++++++++++++++++++++++++++++++++
>   drivers/pinctrl/sunxi/pinctrl-sunxi.c |   3 +-
>   11 files changed, 316 insertions(+), 1 deletion(-)
> ---
> base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
> change-id: 20260519-a5e-gmac1-81a460a3a52d
> 
> Best regards,

