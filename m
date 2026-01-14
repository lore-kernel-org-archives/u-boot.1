Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C30ED31A28
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F37838BB;
	Wed, 14 Jan 2026 09:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="dblcwcBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECECF838BB; Wed, 14 Jan 2026 09:28:34 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C033A83655
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 09:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=b24oqV4YQABXLyTm3Z5B9YO3FPLqs4k4pjWpq/TV9So=; b=dblcwcBFDsraWwCNEYdR3tkCOO
 LUdl6d7XinBdaY/siU8g0KTwmFsxhyFuImWDbv/pjpHOtIvSJIMs1XNbIEAUeqt6Guc7EmSVWBFSY
 +lUuTqvrp3cSPA2o6+iLMCkLvTUiR/SsPQJd/Q1QZDBr9hM/BoGwJi5F4IUBu5SvQ3nvvpxUzX/Fo
 pSYzVFq2PKZRLHl1u9at0foNVvCuQtJ1yidlPt+3SV6grxM+7wArrFeZexQU00I8Ft4mFqV5Ngk6T
 W9vxwWP/SjkEIifZ7w+NOgW54lrvQiPiN1qNxXlBjuUcMe331JEGQLujDxJgZqZpAruU5Z8S1NfwL
 zpoz8RgQ==;
Received: from i53875b96.versanet.de ([83.135.91.150] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vfwEv-002G0M-QJ; Wed, 14 Jan 2026 09:28:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, trini@konsulko.com, u-boot@lists.denx.de,
 Daniel Bast <2790401+dbast@users.noreply.github.com>
Subject: [PATCH v2 04/12] rockchip: board: qnap-ts433: Update documentation to
 recent tool versions
Date: Wed, 14 Jan 2026 09:28:14 +0100
Message-ID: <20260114082822.4007128-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260114082822.4007128-1-heiko@sntech.de>
References: <20260114082822.4007128-1-heiko@sntech.de>
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

ddr_tool was migrated from a binary to a python implementation ddr_tool.py
The ddr-init binaries were also upgraded to new versions.

Suggested-by: Daniel Bast <2790401+dbast@users.noreply.github.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 doc/board/qnap/ts433.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 5e5f0394ada..2cd7cf13d67 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -36,7 +36,7 @@ modification and also a new maskrom downloader can be build:
 
 .. code-block:: bash
 
-    $ tools/ddrbin_tool rk3568 tools/ddrbin_param.txt bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
+    $ tools/ddrbin_tool.py rk3568 tools/ddrbin_param.txt bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
     $ tools/boot_merger RKBOOT/RK3568MINIALL.ini
 
 Building U-Boot
@@ -45,8 +45,8 @@ Building U-Boot
 .. code-block:: bash
 
     $ export CROSS_COMPILE=aarch64-linux-gnu-
-    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.34.elf
-    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin
+    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.45.elf
+    $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
     $ make qnap-ts433-rk3568_defconfig
     $ make
 
@@ -87,5 +87,5 @@ example as package of that name in Debian-based distributions:
 
 .. code-block:: bash
 
-    $ rkdeveloptool db rk356x_spl_loader_v1.21.113.bin
+    $ rkdeveloptool db rk356x_spl_loader_v1.23.114.bin
     $ rkdeveloptool wl 64 u-boot-rockchip.bin
-- 
2.47.2

