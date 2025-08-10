Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5036DC87FDA
	for <u-boot@archiver.kernel.org>; Sun, 10 Aug 2025 22:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3065683423;
	Mon, 11 Aug 2025 00:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="edyB0s0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBDDE833FC; Mon, 11 Aug 2025 00:27:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6368683420
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f248=2X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754864829; bh=F6IJwgujK07UZiX43WQkE+QSqZM5fA3YW9Mr+kqcuRA=;
 b=edyB0s0EZy4T0DD6+FZKyydwPcWKTgNLTEvNkftj/o7rWOccZlibZdCrPXxKeeacMflOtifhM
 Rm88GIiFVf7bpIVYjoyT2i0rraG1NDiTnZL8YweeZYngw7DGKQRhRyoMmulmmNbh/P2R+mknLPJ
 nOvzVUAlduaIAYnDy7O1yLklWSKjN4+/b3Ga/Q30Ck+dKAXahFTM73+nK3u/RExRoswsB6oNqld
 tzJSD+IOzUconKKmHiD24FBkU4djIMWNYHlOhMdTr2fiBQukIoyTsikazCuaNbaW0rh/Tcno7UA
 g0bfh6d4GE/1XSXByZQlQggKnjTy67QKTC3sIYfgn91Q==
X-Forward-Email-ID: 68991cb9b34c1b14a67b38e3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 3/3] rockchip: rk3588s-rock-5c: Add support for ROCK 5C
 Lite variant
Date: Sun, 10 Aug 2025 22:26:31 +0000
Message-ID: <20250810222644.4095072-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810222644.4095072-1-jonas@kwiboo.se>
References: <20250810222644.4095072-1-jonas@kwiboo.se>
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

Add Kconfig option OF_SYSTEM_SETUP=y to support booting ROCK 5C Lite
boards with a RK3582 SoC. CPU and GPU cores are failed based on ip-state
and policy.

Tested on a ROCK 5C Lite v1.1:

  cpu-code: 35 82
  ip-state: 00 80 00 (otp)
  ip-state: c0 80 04 (policy)
  remove cpu-map cluster2
  fail rkvdec1
  fail rkvenc1
  fail cpu cpu@600
  fail cpu cpu@700

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: Update commit message to reflect updated policy
v2: New patch
---
 arch/arm/mach-rockchip/rk3588/Kconfig | 9 +++++----
 configs/rock-5c-rk3588s_defconfig     | 1 +
 doc/board/rockchip/rockchip.rst       | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 4e7942ada875..afc26b0b3c6a 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -269,14 +269,15 @@ config TARGET_ROCK_5_ITX_RK3588
 	  Powered by either 12V, ATX power-supply or PoE
 
 config TARGET_ROCK_5C_RK3588S
-	bool "Radxa ROCK 5C RK3588S2 board"
+	bool "Radxa ROCK 5C/5C Lite"
 	help
-	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
+	  Radxa ROCK 5C/5C Lite is a Rockchip RK3588S2/RK3582 based SBC (Single
+	  Board Computer) by Radxa.
 
 	  Specification:
 
-	  Quad A76 and Quad A55 CPU
-	  6 TOPS NPU
+	  Quad/Dual A76 and Quad A55 CPU
+	  6/5 TOPS NPU
 	  up to 32GB LPDDR4x RAM
 	  eMMC / SPI flash connector
 	  Micro SD Card slot
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index 2748fb488c2d..f83d3f6d6c92 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -18,6 +18,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 726eed4ea45b..c025191302bc 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -153,7 +153,7 @@ List of mainline supported Rockchip boards:
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B/5B+ (rock5b-rk3588)
-     - Radxa ROCK 5C (rock-5c-rk3588s)
+     - Radxa ROCK 5C/5C Lite (rock-5c-rk3588s)
      - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
      - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
      - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
-- 
2.50.1

