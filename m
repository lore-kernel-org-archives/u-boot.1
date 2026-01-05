Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79724C79FBC
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D2183E62;
	Mon,  5 Jan 2026 20:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="m0HplMCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E6C8398C; Mon,  5 Jan 2026 20:47:39 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4E0839A8
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=e80aWNFkLS9d2v3TJDELwuqd3ZBOc0VABxUzDODJUtA=; b=m0HplMCRipjWYr15mXo7TO26F3
 oGw/TCjYmuOIhiPPQDrDVK+pXkJ+1JzS6qxFi05tFHN8JC4fHfijH5lbim0YlnuvmyczISOGEANqV
 qDnCXgInOhya+xNsdKUlS4LYAHR6hUsqceTG73HnRAFuPIHFVO5OI3GxYptSbRy27Tx0KeHHg0+5f
 Kg90ptDzIg080FyzGyXPc5jQ5gOT9NzwyKFc0Hjk1XJ8/PdmIqZ8K1r+cZ1cDpsxe1TMWblICJlwc
 euY6RlMM2+GF9ZAa6wPhK35foa+6+VGMhLVRDmqUwlanC48GKHno/P5SpSI+m02bPxT1AtQLRPECB
 UvAUN/sg==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqY9-001AcR-0E; Mon, 05 Jan 2026 20:47:33 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 05/12] rockchip: board: qnap-ts433: Add instructions for how
 to use upstream TF-A
Date: Mon,  5 Jan 2026 20:47:16 +0100
Message-ID: <20260105194723.2928608-6-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
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

Upstream TF-A has basic support for RK3568 for a while, but only with the
last release finally gained also cpufreq support.

The only known missing piece is enabling the ARM crypto extensions,
but otherwise upstream TF-A is fully usable now.

So steal and adapt Quentin's wording from tiger-rk3588 on how to use
either upstream or vendor TF-A.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 doc/board/qnap/ts433.rst | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
index 2cd7cf13d67..5c81dc953a6 100644
--- a/doc/board/qnap/ts433.rst
+++ b/doc/board/qnap/ts433.rst
@@ -39,17 +39,43 @@ modification and also a new maskrom downloader can be build:
     $ tools/ddrbin_tool.py rk3568 tools/ddrbin_param.txt bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
     $ tools/boot_merger RKBOOT/RK3568MINIALL.ini
 
+Get TF-A
+--------
+
+There are two possible options, pick one or the other.
+
+Prebuilt binary from Rockchip
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. prompt:: bash
+
+   $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.45.elf
+
+Upstream
+~~~~~~~~
+
+.. prompt:: bash
+
+   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   cd trusted-firmware-a
+   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3568 bl31
+   export BL31=$PWD/build/rk3568/release/bl31/bl31.elf
+
 Building U-Boot
 ---------------
 
 .. code-block:: bash
 
     $ export CROSS_COMPILE=aarch64-linux-gnu-
-    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.45.elf
     $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
     $ make qnap-ts433-rk3568_defconfig
     $ make
 
+.. note::
+   If using upstream TF-A, one should disable ``SPL_ATF_NO_PLATFORM_PARAM`` symbol in
+   U-Boot config (via e.g. ``make CROSS_COMPILE=aarch64-linux-gnu- menuconfig``) which
+   will, among other things, enable console output in TF-A.
+
 This will build ``u-boot-rockchip.bin`` which can be written to the
 on-board eMMC.
 
-- 
2.47.2

