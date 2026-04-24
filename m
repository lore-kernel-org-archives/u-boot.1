Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B97FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D2B843F9;
	Sat, 25 Apr 2026 19:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="qNtaa+vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5119984178; Sat, 25 Apr 2026 19:10:18 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7614E84308
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9BE4820B2A;
 Fri, 24 Apr 2026 12:42:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777027341;
 bh=C+U3mwt1H7mVQhCYDUihpHAaEZUvmDSXnAQxKH46THA=; h=From:To:Subject;
 b=qNtaa+vo8RsiGuInHJhQ7xrsdxkCUxHZ5MZ1R2qwzdM2E8FspyQDyuWfRu1a60AzW
 tcX6kw6mcyxb53shnZ/VUVEnyTHDw+/+VjILDVBxTojHz+2R6jyAwNxDKzBUqg4z+z
 QYYdXTyob10ZcVOPmBiIVr2Ec4ui35ZS+QHwidW1/yvOFGZpjp2Bi+FaDnW1wEAg2M
 KJAPAymbaK6cKzj9OBsiQueCT+ASs3UAY9wJKTBE8iIOB8E8fVTENZbhC+jkJjdWBV
 o31fMTeq3rDaqGjB9Y1OThHjgelIOb4slIUvJqk/jxh/KNIhZoJSDEXsgxayZp68P5
 2WeNHA91fVs3Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/10] configs: toradex-smarc-imx8mp: Enable EFI related
 options
Date: Fri, 24 Apr 2026 12:42:06 +0200
Message-ID: <20260424104213.303752-5-francesco@dolcini.it>
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

Enable EFI related options, as suggested for booting standard aarch64
Linux distribution, following the ARM recommendations for SystemReady
compliance [1].

The RTC used on this board is not currently supported by U-Boot,
therefore it is not enabled at the moment.

Link: https://developer.arm.com/documentation/DUI1101/4-5/Configure-U-Boot-for-SystemReady [1]
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 configs/toradex-smarc-imx8mp_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 13a0e5f028b8..c6097af3ebf0 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -63,6 +63,7 @@ CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="SMARC iMX8MP # "
 CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CRC32_VERIFY=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
@@ -70,6 +71,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
@@ -83,7 +85,6 @@ CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
-# CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-- 
2.47.3

