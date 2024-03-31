Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFC2CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9152C87EFA;
	Sun, 31 Mar 2024 22:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="avQ7ucuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6005A87EFA; Sun, 31 Mar 2024 22:29:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEFC87C82
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711916973; bh=DmmEAwsG5gMUuYMu+l+99aEBFejjVdPvlsfZKdjqrfo=;
 b=avQ7ucuZ91bBGwNT1/exTBOZdwsdAzE26PwMRlDdTsf3PYfM5J/UeuHPb2TrGApX5P4H6GcXu
 u1xfsPYfTxJoQDORT+PMcWM573Q7YhzzThqjlVcvcW7+INDv/cK2se9t3y/VxEb1nCma+DD2A8u
 gW2lFZWElMrlRtjaNsTAPLiQ/3POg+20YaFsUclHgv7z1mbDvGw0zjfpnr4Qw8oWuxZ0GkADUvO
 5jBn8jFNIWa2KcCsXwB5+/2a7kmvQibbCdB5UA8b/KxOdpKlcESNFBGF5ynvvbhW7Afo4+vzaUQ
 Z48GzC3tjqCVd1Wgv0NwaTgCi/YRXS+aG4mlzKlNoHsw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/31] rockchip: rk3399-gru: Fix max SPL size on bob and kevin
Date: Sun, 31 Mar 2024 20:28:07 +0000
Message-ID: <20240331202921.262323-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c7ab8fc6b45ed44f7252
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

Chromebook bob and kevin only use SPL and not TPL+SPL like other RK3399
boards, this mean that SPL is loaded to and run from SRAM instead of
DRAM. The SPL and U-Boot payload is loaded from SPI flash.

The U-Boot payload is located at 0x40000 (256 KiB) offset in SPI flash
and because the BROM only read first 2 KiB for each 4 KiB page, the size
of SPL (idbloader.img) is limited to max 128 KiB.

The chosen bss start address further limits the size of SPL to 120 KiB.

  0xff8e0000 (SPL_BSS_START_ADDR) - 0xff8c2000 (SPL_TEXT_BASE) = 0x1e000

Update SPL_MAX_SIZE to reflect the 120 KiB max size limitation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/chromebook_bob_defconfig   | 2 +-
 configs/chromebook_kevin_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index d0321948697b..58e76f11472c 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xff8e0000
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 120c11c04972..5adc276a746a 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -31,7 +31,7 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_BLOBLIST=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x1e000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0xff8e0000
-- 
2.43.2

