Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD04C48260
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 00:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257F087B71;
	Sat, 17 Feb 2024 01:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="u6k1dROj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2367879AF; Sat, 17 Feb 2024 01:58:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C15A878DF
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 01:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4c2a=J2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1708131502;
 bh=WuLNJkjnFF2KRXOOFQoZPwN19n6S2SbO82RH1nzWThw=;
 b=u6k1dROjZZyC/Ev4mBHXRfQd1ck1BtFRpcd2Y86VC97uskkzuCC2oCkowncVj4Sa8DpqyVzbR
 GT9vlbSELu1UT67MqXuKG+BM7dDnIaquvZ9k4vImYQCAqWYgVoT/Gzm57QareTujnUmy8q08TLo
 hNj66ZS//4DGUOk3GKeta+NNZaXnTT0bxS3aSlvzF2JeUqkcaDPuj2YZ/HEA6rMJEqsEUYcgm+s
 xnu+4HdcIL+h7URMGouHQm9sjK9VSLT2E/AH7amMvPP02AtRwRfMKteCWvc2sOOlx6uE+9nbS1o
 5FfylNa9ypgXVs3LNYsMnP5zFmVbvhqfZqYNgQxUwV1w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/2] rockchip: Update stack and bss addresses on RK3328 and
 RK3399
Date: Sat, 17 Feb 2024 00:58:08 +0000
Message-ID: <20240217005817.2150377-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65d004ae20aeacdad56da2da
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

With the stack and text base used by U-Boot SPL and proper on RK3328 and
RK3399 there is a high likelihood of overlapping when U-Boot proper +
FDT nears 1 MiB in size.

Trying to run U-Boot proper close to 1 MiB in size with debug logging
something similar to following can be observed:

  FDT 00000000002fc4e0 gd 00000000002fddf0
  FDT overlap
  resetting ...
  System reset not supported on this platform
  ### ERROR ### Please RESET the board ###

Fix this by changing stack and bss addresses used on RK3328 and RK3399.
The addresses chosen for stack and bss is a combination from both boards.

Changes in v2:
- Rebase on v2 of "rockchip: rk3328: Update defconfigs, DTs and enable
  boot from SPI" [1]
- Use correct address 0x04000000 for 64 MiB offset in commit message
- Collect r-b tag

This series depends on v2 of the following two series:
- rockchip: rk3328: Update defconfigs, DTs and enable boot from SPI [1]
- rockchip: Read cpuid and generate MAC address from efuse for RK3328
  and RK3399 [2]

A copy of this series and its two depends can be found at [3].

[1] https://patchwork.ozlabs.org/cover/1900345/
[2] https://patchwork.ozlabs.org/cover/1897743/
[3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3328-update-v2

Jonas Karlman (2):
  rockchip: rk3328: Update stack addresses
  rockchip: rk3399: Update stack and bss addresses

 arch/arm/mach-rockchip/rk3328/Kconfig         | 2 +-
 configs/chromebook_bob_defconfig              | 2 +-
 configs/chromebook_kevin_defconfig            | 2 +-
 configs/eaidk-610-rk3399_defconfig            | 4 ++--
 configs/evb-rk3328_defconfig                  | 4 +---
 configs/evb-rk3399_defconfig                  | 4 ++--
 configs/ficus-rk3399_defconfig                | 2 +-
 configs/firefly-rk3399_defconfig              | 4 ++--
 configs/khadas-edge-captain-rk3399_defconfig  | 4 ++--
 configs/khadas-edge-rk3399_defconfig          | 4 ++--
 configs/khadas-edge-v-rk3399_defconfig        | 4 ++--
 configs/leez-rk3399_defconfig                 | 4 ++--
 configs/nanopc-t4-rk3399_defconfig            | 4 ++--
 configs/nanopi-m4-2gb-rk3399_defconfig        | 4 ++--
 configs/nanopi-m4-rk3399_defconfig            | 4 ++--
 configs/nanopi-m4b-rk3399_defconfig           | 4 ++--
 configs/nanopi-neo4-rk3399_defconfig          | 4 ++--
 configs/nanopi-r2c-plus-rk3328_defconfig      | 4 ++--
 configs/nanopi-r2c-rk3328_defconfig           | 4 ++--
 configs/nanopi-r2s-rk3328_defconfig           | 4 ++--
 configs/nanopi-r4s-rk3399_defconfig           | 4 ++--
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 4 ++--
 configs/orangepi-r1-plus-rk3328_defconfig     | 4 ++--
 configs/orangepi-rk3399_defconfig             | 4 ++--
 configs/pinebook-pro-rk3399_defconfig         | 4 ++--
 configs/pinephone-pro-rk3399_defconfig        | 4 ++--
 configs/puma-rk3399_defconfig                 | 2 +-
 configs/roc-cc-rk3328_defconfig               | 4 ++--
 configs/roc-pc-mezzanine-rk3399_defconfig     | 4 ++--
 configs/roc-pc-rk3399_defconfig               | 4 ++--
 configs/rock-4c-plus-rk3399_defconfig         | 4 ++--
 configs/rock-4se-rk3399_defconfig             | 4 ++--
 configs/rock-pi-4-rk3399_defconfig            | 4 ++--
 configs/rock-pi-4c-rk3399_defconfig           | 4 ++--
 configs/rock-pi-e-rk3328_defconfig            | 4 +---
 configs/rock-pi-n10-rk3399pro_defconfig       | 4 ++--
 configs/rock64-rk3328_defconfig               | 4 ++--
 configs/rock960-rk3399_defconfig              | 4 ++--
 configs/rockpro64-rk3399_defconfig            | 4 ++--
 39 files changed, 71 insertions(+), 75 deletions(-)

-- 
2.43.0

