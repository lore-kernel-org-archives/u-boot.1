Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4668CD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9678407D;
	Thu, 11 Jun 2026 20:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h3cSYpp0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MxF5RZRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B0984664; Thu, 11 Jun 2026 20:04:53 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BE0839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 20:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gbrC62fQ2z9v6C;
 Thu, 11 Jun 2026 20:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781201090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6/JKjC1EsHPArhQnOjpWtdPNmSKtGsEg1OQE49Zmhsc=;
 b=h3cSYpp0A0i5vlRL4ZrpIuLmDzkHlohhvsu6E8aqW1chBLu+ZNJpwgvXd/kF2/YMP8meMk
 gGD2+D9o2HFA56al1HFJPMF1AlFQcftt7mQDc3av2eWzu5mqxBiI0jo9hxpcix8UzE7w3C
 MoPgpPL2yqED2BaHUjaWeQwuMV7n6woZfsfKPrbVsbr/b9bhSZzKbqQL92eklQCD2Uw5KK
 9qGndS6TAaQ22p3O6f5eRybi9B5zxCe4YsHWJ7KMlP4lV4V9awfA9RqoySM+TDkZDjSQkk
 5mlF2HcLgiKFlAP2q78paRXKiy3DaHnvGsH4frwwV7h+twIc0Z0t9QeF3wUX4g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MxF5RZRE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781201088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6/JKjC1EsHPArhQnOjpWtdPNmSKtGsEg1OQE49Zmhsc=;
 b=MxF5RZREMWuIKZuxz5MCGJb/8ewo7CMWjXcDCaw/YVrxNjQ+xH0efnA8eJBeuTPJ6QVhYE
 0rTHgcETSQltHqTl0f1gDo1EWn+nml53ZPYf134LJYith14l9pNBf9o+WGGeYlWPNrmx04
 bss2Gvb68sobOMfIqQ/2THKe+suqGq6SYcci67ethadVWPkAE5RHXYkY6+ZeriSug5IxAM
 BCbZYKGOj7nfrO1M2sayg9RdmEy7XDpUT09NiAPFz/pTU53IPW1tFimf8ZFWWiUS4UG9ot
 /mUHEEYJ8IsXCO/NoerJy3S93oCDAxxoT5O0/SAppuarLRSFbVJT9awsCfCF3w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Build u-boot-elf.shdr for R-Car X5H Cortex-M33
 RSIP port
Date: Thu, 11 Jun 2026 20:04:26 +0200
Message-ID: <20260611180444.145699-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 81xxb68749jfhke9c7fgw87xsq8bdqt7
X-MBO-RS-ID: b4d5a1b16e4d67dfcf4
X-Rspamd-Queue-Id: 4gbrC62fQ2z9v6C
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

Currently, the default build target for all R-Car Gen3/4/5 is the
u-boot-elf.srec, which depends on u-boot.bin and other vital build
artifacts, which get built as prerequisites. The R-Car Gen5 RSIP
port benefits from u-boot-elf.shdr being built as well, because the
u-boot-elf.shdr contains header used by the BootROM to load and
start U-Boot on the RSIP core. Because u-boot-elf.shdr depends on
u-boot-elf.srec, switch the default build target for R-Car Gen5
RSIP port to u-boot-elf.shdr. This way, both u-boot-elf.shdr and
u-boot-elf.srec are built for R-Car Gen5 RSIP port.

Fixes: 9d47a5a4d560 ("arm: renesas: Add Renesas R-Car R8A78000 X5H Cortex-M33 RSIP port")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 8428d039a1c..99b896b6cf1 100644
--- a/Kconfig
+++ b/Kconfig
@@ -548,7 +548,8 @@ config REMAKE_ELF
 
 config BUILD_TARGET
 	string "Build target special images"
-	default "u-boot-elf.srec" if RCAR_64
+	default "u-boot-elf.shdr" if RCAR_64 && RCAR_64_RSIP
+	default "u-boot-elf.srec" if RCAR_64 && !RCAR_64_RSIP
 	default "u-boot-with-spl.bin" if ARCH_AT91 && SPL_NAND_SUPPORT
 	default "u-boot-with-spl.bin" if MPC85xx && !E500MC && !E5500 && !E6500 && SPL
 	default "u-boot-with-spl.imx" if (ARCH_MX6 || ARCH_MX7) && SPL
-- 
2.53.0

