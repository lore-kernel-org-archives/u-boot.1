Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8856C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B4E884A9;
	Tue, 18 Jun 2024 17:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X9Gd0zM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9622E88445; Tue, 18 Jun 2024 17:35:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01612883E0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DC17B618BC;
 Tue, 18 Jun 2024 15:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39C2C4AF1C;
 Tue, 18 Jun 2024 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724895;
 bh=nXO9rkJWV576Z2F7fANwqDC2Dln0yQVpvmk1k7oBMCw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X9Gd0zM3iljAIxh5jSk39ZqNWT5BWEtPlTShoHum2TGNyz+DkGiKUdxjuuv8ixGUW
 19P1c5VMxT0uEk9Bosn0qSF113Cq6bbSqW2oo163c72HRbGbgON0JuIvO9yCsyYaRR
 X1ipw1KOJrUyBpZcZ+9ltxYWY1ULFWoIA7SnqVfPMMNR5+qocoqEHohfKvf5Lyowne
 m7TQ+itn/f+NOjnW8xzCfsRNOzwHdW0h6tHx8lkO3CUeuU6jXZPS5UKbmmEYUCUjyj
 IJu2IbY5pUZWx+2KuwaVmvr6FgK+iIWp9RoQJOqE0fTEKXbT8x3xnWSeUJEiRmtlny
 Ltkm49NGn1ZYg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 09/16] arm: mvebu: turris_omnia: Enable the
 'eeprom' command
Date: Tue, 18 Jun 2024 17:34:32 +0200
Message-ID: <20240618153439.9518-10-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Enable the 'eeprom' command with support for EEPROM layout for Turris
Omnia. Enable the i2c-eeprom driver so that the EEPROM is accessed via
driver model.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 08e3e21215..c8756a3a78 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -55,6 +55,8 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SYS_MAXARGS=32
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_EEPROM_LAYOUT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_SHA1SUM=y
@@ -90,6 +92,7 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_AHCI_PCI=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_DM_PCA953X=y
+CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_DM_MTD=y
-- 
2.44.2

