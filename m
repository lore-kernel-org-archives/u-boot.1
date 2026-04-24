Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED87FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AA684419;
	Sat, 25 Apr 2026 19:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d4ZwFkwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EC984314; Sat, 25 Apr 2026 19:10:20 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764C284309
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 005DE20ABE;
 Fri, 24 Apr 2026 12:42:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777027341;
 bh=2oIz6K8C6x1pkJSV/7rxuemCRAz55L+yzwPhVJSW8qQ=; h=From:To:Subject;
 b=d4ZwFkwC6C97dOXLLeeYiK/6LmQGIIRQ005vjLMWYrCQJkDjg0f+c0PYFVmjsC6vZ
 JVEznaE+8kuUScQ5ZVvzTNbA+peAQ1wyi9IRtXdZLuh9qQstLcHdRILMxV2psOxdoI
 9vIaIB4lYWf6DjjgBZ65BJ/5bkpCfObDJ2phecezrKTavmd8gkr2Ymao93jR6Nb9G2
 asf4LSvcmP3BcDVjKnmW8se0alHYxNv9+g1tSybmHaa+yfK6PRDLks6FF8y0GgqbZi
 jDLGC3kSC49toapN7h/XaPnEh0Xfo1tW9rIR75N4gUd2Ugb6o33zceVfmBj8y7AMA5
 KYvyNvoYSqqPA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 02/10] configs: aquila-am69: Enable EFI related options
Date: Fri, 24 Apr 2026 12:42:04 +0200
Message-ID: <20260424104213.303752-3-francesco@dolcini.it>
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
 configs/aquila-am69_a72_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/aquila-am69_a72_defconfig b/configs/aquila-am69_a72_defconfig
index 6a0ccd15e6db..07c9be658094 100644
--- a/configs/aquila-am69_a72_defconfig
+++ b/configs/aquila-am69_a72_defconfig
@@ -57,6 +57,7 @@ CONFIG_SPL_THERMAL=y
 CONFIG_SYS_PROMPT="Aquila AM69 # "
 CONFIG_CMD_ASKENV=y
 # CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CRC32_VERIFY=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
@@ -72,7 +73,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_BOOTCOUNT=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
-# CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-- 
2.47.3

