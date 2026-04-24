Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF660FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA05843E3;
	Sat, 25 Apr 2026 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="zAPkFx2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A84843E3; Sat, 25 Apr 2026 19:10:18 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25BE84178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4C3E820A93;
 Fri, 24 Apr 2026 12:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777027341;
 bh=f60sOsqS/TJsoK7gldV1Zu8hBmLzKhp08x7CH2MYsOo=; h=From:To:Subject;
 b=zAPkFx2t8DbY/CEbhWjJHR/WzofuIMH3i8x9EHx4mfO4th5Oyiuz1f0pxqw7735Mp
 RWphNB83iADNDspjiaYVPjUd2zsL/qE5y77NQ0aegn7aGfheg73Fil2gj+lcOGDWii
 vafrlX4kt3iucjqp3fIpz73q70ScVNYY7C0ZCvhNJeZOTl0eYPKyJGAz9HnfTQkaXb
 +g0EkeJpJc5x7bLz78ZnmUuM4M7+UzHc7kpIcTnrG+sZ3bzS/KtEnPcyto0ftBTeDF
 RBWMdaxzjO7WqRtzh/CySzZfPpgv6vfCyY7eCz7SIVtGyuX3T17QY0m7o6hLxUtEoB
 zSuciM/wEYiWg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 03/10] configs: colibri-imx8x: Enable EFI
Date: Fri, 24 Apr 2026 12:42:05 +0200
Message-ID: <20260424104213.303752-4-francesco@dolcini.it>
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
 configs/colibri-imx8x_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index fd6a6b47fcfc..abca8a96d630 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -19,7 +19,6 @@ CONFIG_IMX_BOOTAUX=y
 CONFIG_SYS_MEMTEST_START=0x88000000
 CONFIG_SYS_MEMTEST_END=0x89000000
 CONFIG_REMAKE_ELF=y
-# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
@@ -36,11 +35,13 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="Colibri iMX8X # "
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

