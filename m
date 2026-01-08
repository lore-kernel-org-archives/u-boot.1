Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57ACD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF798419C;
	Thu,  8 Jan 2026 14:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YYv14eUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686E38419C; Thu,  8 Jan 2026 14:36:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C5B84172
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1767879380;
 bh=YGTgS3dzSyw9xiiM7rrrZf1cs/RawMG5u8c9+r8Ga34=;
 b=YYv14eUF0g3Z4QTOqXV13wHHDEsagw6WZ6uRQ/o7dIibs+vx+wdRq00jP3waALKIQVybTTwPS
 IuUE+MbUnIhE8jTJX0JE8duiUbR4aOhXIOkZvP4UjLHB82C43bkIsh7bfUd3fjrq03rbC2tVvg1
 V+UHK+5AwgLNUpLPYBvg8DgmqgKy7Oh92km/DL7h3IUQbAtCWhL3qFQKtV8TKGaI/BrbNGm1bvC
 D4Qm5jJrLg+qot43B5x04h7QKv0q4cd1YVhsKquA17C+L4FZM1wL65st3luROtj37zeNHQLnsJW
 o+CYyHs1SONRpFkkrELZ1PunQNry1C4rQbtTNDeC+PVA==
X-Forward-Email-ID: 695fb2ce2b5f20405ba817b0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: rk3576: Fix DMA transfer of TF-A to PMU_SRAM
Date: Thu,  8 Jan 2026 13:32:28 +0000
Message-ID: <20260108133234.4001390-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

The firewall block access to pmu sram for non-secure masters by default
after reset (0xffffbfff) on RK3576.

This series changes the pmu lookup configuration to match the default
lookup config for ddr and system sram (0xffff3fff) to allow loading of
TF-A using DMA. It also drops the u-boot specific no-dma/fifo props
currently used to workaround the DMA load issue.

Mainline TF-A will re-configure the firewall to use an even less
restrictive lookup (0xbffe3ff0), so this change is not expected to have
any real security implication.

This has been tested on a ROCK 4D and NanoPi R76S with loading TF-A from
eMMC, SD-card and SPI flash.

Trying to use DMA transfer without this series:

  U-Boot SPL 2026.01 (Jan 08 2026 - 13:18:01 +0000)
  Trying to boot from MMC2
  ## Checking hash(es) for config config-1 ... OK
  mmc_load_image_raw_sector: mmc block read error
  Error: -38
  SPL: Unsupported Boot Device!
  Trying to boot from MMC1
  ## Checking hash(es) for config config-1 ... OK
  mmc_load_image_raw_sector: mmc block read error
  Error: -38
  SPL: Unsupported Boot Device!
  SPL: failed to boot from all boot devices
  ### ERROR ### Please RESET the board ###

With this series applied:

  U-Boot SPL 2026.01 (Jan 08 2026 - 13:21:35 +0000)
  Trying to boot from MMC2
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  INFO:    Preloader serial: 0
  NOTICE:  BL31: v2.3():v2.3-940-gb0834f9a2:derrick.huang, fwver: v1.21
  NOTICE:  BL31: Built : 12:00:50, Jun 27 2025

Please note that the technical details and naming of the involved parts
may be wrong as this is just been based on the limited details in
firewall.c/h from TF-A source and printing out content of FW regs.

Jonas Karlman (2):
  rockchip: rk3576: Allow pmu sram access for non-secure masters
  rockchip: rk3576: Use DMA when loading FIT images

 arch/arm/dts/rk3576-u-boot.dtsi        | 4 ----
 arch/arm/mach-rockchip/rk3576/rk3576.c | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.52.0

