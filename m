Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF77C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0A38855B;
	Fri, 21 Jun 2024 01:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=vegan.im.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=vegan.im.it header.i=@vegan.im.it header.b="tM+Ywn5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9B887D9B; Fri, 21 Jun 2024 00:08:06 +0200 (CEST)
Received: from cherry.hrnz.li (cherry.hrnz.li [95.217.163.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE968785E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=vegan.im.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ulli@vegan.im.it
Received: from pumpkin.internal.hrnz.li (pumpkin.lan.hrnz.li
 [IPv6:2001:470:5881::7])
 by cherry.hrnz.li (Postfix) with ESMTPSA id A29861B9BD0;
 Fri, 21 Jun 2024 00:07:57 +0200 (CEST)
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ulli smtp.mailfrom=ulli@vegan.im.it
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=vegan.im.it;
 s=default; t=1718921277;
 bh=sHZhynVDq4DL2jxvM46N1E5eoGD2ukRaPXwZiu2boM8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=tM+Ywn5S55jRqH/PO11+5+I7HJcaSDI8W9kKBvT8zdVMyOHMvhzPaxF2jFrkxdK5B
 L5N68Xo0EzXqStjdklVY+23AjBWl21XkdeKh5WxIOuq5wkVbWENjcNH8yXlnxY1A4w
 n6e5k/avbg8x1yoAOQJ5QQxapb8ZZlsAg0VrGxy4=
Received: by pumpkin.internal.hrnz.li (Postfix, from userid 1000)
 id DE28D305D4; Fri, 21 Jun 2024 00:07:56 +0200 (CEST)
From: Ulli Kehrle <ulli@vegan.im.it>
To: Sebastian Kropatsch <seb-dev@mail.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: rockchip: Add FriendlyElec NanoPi R6S
In-Reply-To: <20240607202111.453943-2-seb-dev@mail.de>
References: <20240607202111.453943-1-seb-dev@mail.de>
 <20240607202111.453943-2-seb-dev@mail.de>
Date: Fri, 21 Jun 2024 00:07:56 +0200
Message-ID: <87sex75kub.fsf@kehrle.me>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 21 Jun 2024 01:10:51 +0200
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


Sebastian Kropatsch <seb-dev@mail.de> writes:
> The R6S is very similar to the R6C, the major difference being that
> instead of the M.2 NVMe socket on the R6C, the R6S has a second RTL8125BG
> Ethernet chip, which uses the same PCIe lanes that the R6C uses for its
> M.2 socket. Other minor differences include:
> - 12-pin GPIO FPC instead of 30-pin header
> - IR receiver (pwm-based)
> - 5V fan connector
> Other than that, they are the same, which is why the difference in
> U-Boot is only the missing NVME config option in the R6S defconfig.
>
> Please note that I was not able to test this device. I only chose to
> add it due to it being a very similar implementation to the R6C, like the
> NanoPi R5C and R5S are similar. It should however boot just fine and even
> both RTL8125 Ethernet ports should work in U-Boot since RTL8125 is the
> same chip used in the R6C, using the rtl8169 driver.

Hi Sebastian,

it looks like you forgot to include the hunk that includes the board
config board/friendlyelec/nanopi-r6s-rk3588s/Kconfig into
rk3588/Kconfig.

> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index a9e400861a3..051d50e26f6 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -257,6 +257,7 @@ config TEXT_BASE
>  source "board/edgeble/neural-compute-module-6/Kconfig"
>  source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>  source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
> +source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>  source "board/indiedroid/nova/Kconfig"
>  source "board/pine64/quartzpro64-rk3588/Kconfig"
>  source "board/turing/turing-rk1-rk3588/Kconfig"

Other than that, this appears to work great on my Nanopi R6S (with the
device tree from linux-6.9), including all three network interfaces, but
no working status leds for the rtl8169 ports. I have also noticed the
minor inconvenience that only the first two interfaces are initialized
with nonzero MAC addresses (because rockchip_setup_macaddr is hardcoded
for two interfaces?):

> => pci enum
> => net list
> eth0 : ethernet@fe1c0000 7a:d9:6d:ad:cb:26 active
> eth1 : eth_rtl8169 7a:d9:6d:ad:cb:27
> eth2 : eth_rtl8169 00:00:00:00:00:00

I don't think this is a huge deal as it works fine when manually setting
a MAC address and other boards with three or more interfaces (like the
NanoPi R5S) also behave that way. What do you think?

Best regards
Ulli
