Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C6C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154228171B;
	Sat, 29 Mar 2025 16:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IampmW5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6DF8171B; Sat, 29 Mar 2025 16:06:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EDF805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1dca=WR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1743260798;
 bh=p8lkc5uAE5Etyx8C8YSqvw+/bafBDTFN8I82kbL6CAw=;
 b=IampmW5XODegcHI3co0kYRTwhw1BobwfhOnmco1ltBwLTtDhu3tX9oA78GLC1BUnrmux3i8pE
 AfrpaxCz37GlRsop9i8QHJlEBj+RX0+1+pyW+cuxFdszICQKJl1SjA6RR5Omd8YmErcDR0OWPvl
 2gbA1OECxHZLI3FXbd+OsDItc3GckVVGgbVo5xi1UlXMDS1kukV95SyI1qIxuPdzJRNNkAVBAvq
 R+vblPQfcJkfX3WVRQmJfY0PAMwLkhaN+g4Pioj/h3p7JDFkvGVtQwa0a3kBJ7Mewgd5Oii+azd
 M7nYqz4ciwa40G07rpnKK6TFubeA/K4l/uTwP9s5I0Xg==
X-Forward-Email-ID: 67e80c7821787eb134711edd
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 00/10] rockchip: binman: Use a template for FIT and other
 improvements
Date: Sat, 29 Mar 2025 15:06:03 +0000
Message-ID: <20250329150626.2879942-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This series split out generic Rockchip binman image related commits from
Simons "VBE serial part H: Implement VBE on Rockchip RK3399" [1] series.

These are generic binman image patches fixing an existing issue [2][3]
and that other series [4] already depends on.

They are being split out to ease continued work for other U-Boot
developers as the main parts of the VBE series have not yet been tested
using the mainline U-Boot tree, so cannot yet be seen as ready.

Changes in v4:
- Patch 1-7 matches corresponding patch in Simons series, possible with
  minor updates in commit messages.
- Patch 8 drops changes to defconfig-files.
- Patch 9 adds support for using crc32 as checksum algo.
- Patch 10 adds a default value for SPL_PAD_TO.

This series holds off on any defconfig changes to let it be handled by
next "configs: Resync with savedefconfig". Changing SPL_PAD_TO to be
storage media relative has also been held off and is something that can
be picked up in a series for a future release after this has landed in a
release.

See [5] for a copy of this series on top of patch 1-2 from [3]. This
series does not depend on those two patches, but are related for a full
cleanup of use of u-boot.itb in Rockchip binman images.

[1] https://lore.kernel.org/u-boot/20250328153522.3555472-1-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
[3] https://lore.kernel.org/u-boot/20250220-has_rom-u-boot-rockchip-spi-bin-v2-3-d1768ee87808@cherry.de/
[4] https://lore.kernel.org/u-boot/20250220231358.432367-1-jonas@kwiboo.se/
[5] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/binman-image-refactor

Jonas Karlman (2):
  rockchip: binman: Support use of crc32 for SPL_FIT_SIGNATURE
  rockchip: Add SPL_PAD_TO Kconfig default value

Simon Glass (8):
  rockchip: binman: Correct the OS prop for U-Boot
  rockchip: binman: Factor out arch and compression
  rockchip: binman: Add an fdtmap
  rockchip: binman: Create a template for the FIT
  rockchip: binman: Un-indent the FIT template
  rockchip: binman: Use the FIT template in the SPI image
  rockchip: binman: Include a compatible string in each configuration
  rockchip: binman: Use the skip-at-start prop in simple-bin image

 arch/arm/dts/rockchip-u-boot.dtsi | 296 ++++++++++++++++--------------
 common/spl/Kconfig                |   1 +
 2 files changed, 162 insertions(+), 135 deletions(-)

-- 
2.49.0

