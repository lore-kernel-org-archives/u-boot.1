Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8661FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3705843FF;
	Sat, 25 Apr 2026 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Sh6ZGthX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FA9842FC; Sat, 25 Apr 2026 19:10:18 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BA7842FD
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 8496820AA3;
 Fri, 24 Apr 2026 12:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777027340;
 bh=GZNV7evI0C0+ZjeQ0+QFTgyN4/NebZWRA5MVCbO7d/k=; h=From:To:Subject;
 b=Sh6ZGthXCIfLY14hXkNDIJSA0WaY72F2ebEUvhJ4hDpJD7jJSymrQmx2XKW4jl1oW
 ThJ+tz2ihwY60JxIOgxqEroYw0XCj7r0pNObkgnfrR90KSUc3f+O11N8NqgiLy1a/D
 4+2keVm2pwQapGdOSetI9O743qAw/jst/x5y+NQobUvu3N7IW9GoCV5Npix/DRC8mQ
 OLp0gdQWgOJEAyzDCHosNLQQNg7f6c5yvQKEl+fCMw2FUZ6qDlb8eWxZ77U9v62gAN
 dRVmGZIHOmMQzil0/KvgDJWH/WuWQgSP0Rvyal3qX/tlef5wAn4IeIoNJDd0rfOSgj
 1RQIXLICB10sA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 01/10] configs: apalis-imx8: Enable EFI
Date: Fri, 24 Apr 2026 12:42:03 +0200
Message-ID: <20260424104213.303752-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260424104213.303752-1-francesco@dolcini.it>
References: <20260424104213.303752-1-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Enable standard EFI support, as required for booting standard aarch64
Linux distribution, following the ARM recommendations for SystemReady
compliance [1].

The RTC used on this board is not currently supported by U-Boot,
therefore it is not enabled at the moment.

Link: https://developer.arm.com/documentation/DUI1101/4-5/Configure-U-Boot-for-SystemReady [1]
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 configs/apalis-imx8_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 6ab4dd3dc575..f50ef140f6be 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -18,7 +18,6 @@ CONFIG_IMX_BOOTAUX=y
 CONFIG_SYS_MEMTEST_START=0x88000000
 CONFIG_SYS_MEMTEST_END=0x89000000
 CONFIG_REMAKE_ELF=y
-# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -35,11 +34,13 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="Apalis iMX8 # "
 CONFIG_CMD_CPU=y
 CONFIG_CMD_ASKENV=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DM=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_CACHE=y
-- 
2.47.3

