Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED2C48BC4
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 21:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E13E87CD2;
	Sun, 18 Feb 2024 22:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wN9zeM/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B37287EB9; Sun, 18 Feb 2024 22:54:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D78F8765B
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 22:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=abeb=J4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1708293276;
 bh=LCYrw1UKpyK8A1El/8XobKcvkZDQmrr1dggXWIgDGAA=;
 b=wN9zeM/5MrNAjLaI7pKFpj6fHdwrdaQxBbAcFI4t2qCYOZeTkiET2UV9VEBxGuwSDOJs/Lfhz
 wNiqzd7Cc117h9dGU9lQ5T24rFtMZxa5naPuzL+qeakfxBc+kbfLTXajPlBklyhSNS4s1bpw6CG
 EYBOtG7zw6mPBaVQz3KKqvzHagYuVcDwc190Qwv8XtpfVXRUcE7mLZECApGK+vD6W207AeFSOCH
 /LUU7CBq/RmcQJe5PMayjqoV2BczLa64LcCQ+cFfxoorCvRhlx3oU1kSHJp9eBowmPHmo2sBlHx
 OFyBlyUrAaMdP5klNHdijbu48oSRf5ClglPZUvRexnMw==
Message-ID: <4a3806e8-8899-440f-a800-1d24c25a3ecb@kwiboo.se>
Date: Sun, 18 Feb 2024 22:54:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] rockchip: Update stack and bss addresses on RK3328
 and RK3399
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
References: <20240217005817.2150377-1-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240217005817.2150377-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65d27c9af583e5e67397e467
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

Hi all,

Please ignore this series for now.

The simple malloc heap created on the SPL init stack is still in use
after SPL relocation, so memory layout needs to rearranged once more.

Also the RK35xx boards is affected by a simple malloc heap and stack
overlap issue.

I will re-send a different version once I have addressed these issues.

Regards,
Jonas

On 2024-02-17 01:58, Jonas Karlman wrote:
> With the stack and text base used by U-Boot SPL and proper on RK3328 and
> RK3399 there is a high likelihood of overlapping when U-Boot proper +
> FDT nears 1 MiB in size.
> 
> Trying to run U-Boot proper close to 1 MiB in size with debug logging
> something similar to following can be observed:
> 
>   FDT 00000000002fc4e0 gd 00000000002fddf0
>   FDT overlap
>   resetting ...
>   System reset not supported on this platform
>   ### ERROR ### Please RESET the board ###
> 
> Fix this by changing stack and bss addresses used on RK3328 and RK3399.
> The addresses chosen for stack and bss is a combination from both boards.
> 
> Changes in v2:
> - Rebase on v2 of "rockchip: rk3328: Update defconfigs, DTs and enable
>   boot from SPI" [1]
> - Use correct address 0x04000000 for 64 MiB offset in commit message
> - Collect r-b tag
> 
> This series depends on v2 of the following two series:
> - rockchip: rk3328: Update defconfigs, DTs and enable boot from SPI [1]
> - rockchip: Read cpuid and generate MAC address from efuse for RK3328
>   and RK3399 [2]
> 
> A copy of this series and its two depends can be found at [3].
> 
> [1] https://patchwork.ozlabs.org/cover/1900345/
> [2] https://patchwork.ozlabs.org/cover/1897743/
> [3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-update-v2
> 
> Jonas Karlman (2):
>   rockchip: rk3328: Update stack addresses
>   rockchip: rk3399: Update stack and bss addresses
> 
>  arch/arm/mach-rockchip/rk3328/Kconfig         | 2 +-
>  configs/chromebook_bob_defconfig              | 2 +-
>  configs/chromebook_kevin_defconfig            | 2 +-
>  configs/eaidk-610-rk3399_defconfig            | 4 ++--
>  configs/evb-rk3328_defconfig                  | 4 +---
>  configs/evb-rk3399_defconfig                  | 4 ++--
>  configs/ficus-rk3399_defconfig                | 2 +-
>  configs/firefly-rk3399_defconfig              | 4 ++--
>  configs/khadas-edge-captain-rk3399_defconfig  | 4 ++--
>  configs/khadas-edge-rk3399_defconfig          | 4 ++--
>  configs/khadas-edge-v-rk3399_defconfig        | 4 ++--
>  configs/leez-rk3399_defconfig                 | 4 ++--
>  configs/nanopc-t4-rk3399_defconfig            | 4 ++--
>  configs/nanopi-m4-2gb-rk3399_defconfig        | 4 ++--
>  configs/nanopi-m4-rk3399_defconfig            | 4 ++--
>  configs/nanopi-m4b-rk3399_defconfig           | 4 ++--
>  configs/nanopi-neo4-rk3399_defconfig          | 4 ++--
>  configs/nanopi-r2c-plus-rk3328_defconfig      | 4 ++--
>  configs/nanopi-r2c-rk3328_defconfig           | 4 ++--
>  configs/nanopi-r2s-rk3328_defconfig           | 4 ++--
>  configs/nanopi-r4s-rk3399_defconfig           | 4 ++--
>  configs/orangepi-r1-plus-lts-rk3328_defconfig | 4 ++--
>  configs/orangepi-r1-plus-rk3328_defconfig     | 4 ++--
>  configs/orangepi-rk3399_defconfig             | 4 ++--
>  configs/pinebook-pro-rk3399_defconfig         | 4 ++--
>  configs/pinephone-pro-rk3399_defconfig        | 4 ++--
>  configs/puma-rk3399_defconfig                 | 2 +-
>  configs/roc-cc-rk3328_defconfig               | 4 ++--
>  configs/roc-pc-mezzanine-rk3399_defconfig     | 4 ++--
>  configs/roc-pc-rk3399_defconfig               | 4 ++--
>  configs/rock-4c-plus-rk3399_defconfig         | 4 ++--
>  configs/rock-4se-rk3399_defconfig             | 4 ++--
>  configs/rock-pi-4-rk3399_defconfig            | 4 ++--
>  configs/rock-pi-4c-rk3399_defconfig           | 4 ++--
>  configs/rock-pi-e-rk3328_defconfig            | 4 +---
>  configs/rock-pi-n10-rk3399pro_defconfig       | 4 ++--
>  configs/rock64-rk3328_defconfig               | 4 ++--
>  configs/rock960-rk3399_defconfig              | 4 ++--
>  configs/rockpro64-rk3399_defconfig            | 4 ++--
>  39 files changed, 71 insertions(+), 75 deletions(-)
> 

