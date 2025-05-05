Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF98C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3669F8212B;
	Mon,  5 May 2025 16:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6CF82A2F; Mon,  5 May 2025 16:47:33 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42a9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30F58212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zrkry3PzCzg43;
 Mon,  5 May 2025 16:47:30 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Zrkrx1LnHz4yg; Mon,  5 May 2025 16:47:28 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v3 0/2] rockchip: remove u-boot.rom generation
Date: Mon, 05 May 2025 16:47:17 +0200
Message-Id: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXPGGgC/43Qzw6CMAwG8FcxO1uzjfDPk+9hjAFWXGNk2AGRE
 N7dgR646fHr4fe1nYRHJvTiuJsE40CeXBNCtN+JyhbNDYFMyEJLHUutFNjCX9k9oIfSuQ7YVff
 KUgu+JSipAVNHqpRJYXQdiaC0jDW91obzJWRLvnM8roWDWqb/24MCCdKkaZ3HZaKj/FRZZB4PB
 sViD3rjafnb08EzKk0yxCzNZLb15s/yjM8+fKX7XjDPb3T3E14zAQAA
X-Change-ID: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

This gets rid of u-boot.rom generation as that was used only on Rockchip
Chromebooks and their maintainer (Simon) seems to agree[1] that
u-boot-rockchip-spi.bin should do the job now so we don't need to
generate it anymore. This was agreed for RK3399 Chromebooks, I'm
attempting to do the same for RK3288 Chromebooks as well so we don't
have anything requiring that u-boot.rom anymore.

Since HAS_ROM is only guarding this u-boot.rom generation, they are
removed too from the individual configs.

Note that none of the patches were tested outside of a simple build
test.

[1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- removed patch 3 as it's now handled by fit templates, in another
  series about to be merged,
  (https://lore.kernel.org/u-boot/20250413195949.432730-1-jonas@kwiboo.se/)
- Link to v2: https://lore.kernel.org/r/20250220-has_rom-u-boot-rockchip-spi-bin-v2-0-d1768ee87808@cherry.de

Changes in v2:
- made u-boot-rockchip-spi.bin 8MiB for RK3399 Chromebooks and 4MiB for
  RK3288 Chromebooks, as requested by Simon, to match u-boot.rom,
- added R-b from Jonas,
- surrounded &/binman/simple-bin-spi in chromebook dtsis with ifdefery
  on ROCKCHIP_SPI_IMAGE to not pollute the Device Tree if it's not
  there,
- Link to v1: https://lore.kernel.org/r/20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de

---
Quentin Schulz (2):
      rockchip: rk3399: do not generate u-boot.rom anymore
      rockchip: rk3288: do not generate u-boot.rom anymore

 arch/arm/dts/rk3288-u-boot.dtsi        | 24 -----------------------
 arch/arm/dts/rk3288-veyron-u-boot.dtsi |  8 ++++++++
 arch/arm/dts/rk3399-gru-u-boot.dtsi    |  4 +++-
 arch/arm/dts/rk3399-u-boot.dtsi        | 35 ----------------------------------
 arch/arm/mach-rockchip/rk3288/Kconfig  |  5 -----
 arch/arm/mach-rockchip/rk3399/Kconfig  |  2 --
 6 files changed, 11 insertions(+), 67 deletions(-)
---
base-commit: 9dbe8d889546efd6c1a3470092588b9b6820158f
change-id: 20250211-has_rom-u-boot-rockchip-spi-bin-df31b06ad2f3

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

