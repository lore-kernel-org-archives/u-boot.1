Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AB9C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 23:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5DF180EC0;
	Fri, 21 Feb 2025 00:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vUxxPD7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BC780F56; Fri, 21 Feb 2025 00:14:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BE7807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 00:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1740093247;
 bh=Zmj8Ab86jJzQy0sjkuPt26Y05A56VeYyaWlNAmIFbt8=;
 b=vUxxPD7tmxoNMJfFCK0o9W5AYpo24R0e+dzY7YlkrMIlhQspYIwXyuq4YSrTx/3leb62l3v+b
 bodwPSlfi01eP7qdtSn+g3GQ05vHxIfghjl0wDgrLwWigJXaidMUy03ZgboAbSJRrS7uq76sd7S
 /7Q6UNtLzia/kIbfO6BPLnELo44QQ1mQW11PjET1UL3gAoDW1TDRRjq/z5Hp/yMb//JqARrEZed
 CVWWyt6e66WpBRa2NnfEsCHOJqb3yYph9ZPMoCwjeq8CKA2yD6CWsoI1tg0Rrz6doho7J5e4+EW
 jwTiv5+CaEJfk+yysslEg3i9WSYFG1J0Sby8No8pU/yQ==
X-Forward-Email-ID: 67b7b73cdf490aa3bbad1bad
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] Add support for RAM boot from maskrom mode
Date: Thu, 20 Feb 2025 23:13:49 +0000
Message-ID: <20250220231358.432367-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The BootROM in Rockchip SoCs will enter maskrom mode when boot firmware
cannot be found in nand/spi/mmc storage.

In maskrom mode the USB OTG port can accept one of two custom commands.

Initially a 0x471 command to load TPL into SRAM. After TPL has been
executed and it has returned back-to-BROM, a 0x472 command to load SPL
into start of DRAM.

This series add two binman images that can be used to RAM boot from
maskrom mode:
- u-boot-rockchip-usb471.bin that contains TPL to init DRAM.
- u-boot-rockchip-usb472.bin that contains SPL and the normal FIT
  payload with i.e. U-Boot proper, TF-A and FDT.

These images can be used with rkbin tools/boot_merger to create a loader
image to be used with rkdeveloptool or rockusb tools, e.g.:

  Create loader image:
    $ ../rkbin/tools/boot_merger ./RK3588MINIALL.ini

  Boot from maskrom:
    $ rkdeveloptool db u-boot-rockchip-rk3588-loader.bin
   or
    $ rockusb download-boot u-boot-rockchip-rk3588-loader.bin

Or directly with tools such as rkflashtool or rkusbboot:

  $ rkflashtool l < u-boot-rockchip-usb471.bin
  $ rkflashtool L < u-boot-rockchip-usb472.bin
 or
  $ rkusbboot u-boot-rockchip-usb471.bin u-boot-rockchip-usb472.bin

This series depend on the "rockchip: ROCKCHIP_COMMON_STACK_ADDR
improvements" series [1] and the "rockchip: dts: Create a template for
the FIT" patch [2]. See [3] for a branch with all depends.

[1] https://patchwork.ozlabs.org/cover/2050003/
[2] https://patchwork.ozlabs.org/patch/2044607/
[3] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/ramboot-v1

Jonas Karlman (3):
  rockchip: Move TEXT_BASE to 8 MiB offset from start of DRAM
  rockchip: Add support for RAM boot from maskrom mode
  rockchip: Enable RAM boot using ROCKCHIP_MASKROM_IMAGE

 arch/arm/dts/rockchip-u-boot.dtsi       | 33 +++++++++++++++++++++++++
 arch/arm/mach-rockchip/Kconfig          | 19 +++++++++++---
 arch/arm/mach-rockchip/rk3308/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig   |  3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig   |  3 ---
 arch/arm/mach-rockchip/spl-boot-order.c | 15 ++++++++---
 boot/Kconfig                            |  3 +++
 7 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.48.1

