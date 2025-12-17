Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0DFD66B85
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2002383C23;
	Wed, 17 Dec 2025 21:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jhGyX4z9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OaqnBpnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5740283C19; Wed, 17 Dec 2025 21:13:33 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60F9183B49
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dWlNq1NrHz9tZ4;
 Wed, 17 Dec 2025 21:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/fuwGzBVB1pcjel8DHKikgHebCCtm6WNBD9CHv2+amA=;
 b=jhGyX4z9BSLW+q56q33m/guPJJAWyRD+pdh/uKH6I0Y35OD88ErSZd8m4xQ+jzNutT96Sl
 NAlrVx9X27bDpk7okLE3zvzTpYGE7VOrHW7Dl0Y+7Uj2hqyZ7jFAyTI4kuCUUxeniQ7eBe
 /a10GN+mTtBQ/3c98pAWTeCcCFc5ADNGDRwRWPTGovE6YJQShCGBu9POphuk8LI185/ENR
 i5dZDWR2J0kC3AyU7iLvL/wtjvs3cZPojzWwwCVwCFwRgFiHLI4a6mY7pL2ofAMhg4IeBO
 sE8jl/171AwhsOtdaL8ix4jvQdQt/4SE8vZ5pgoORCvvsgN5B1uNt4OdheaCCw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=OaqnBpnl;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/fuwGzBVB1pcjel8DHKikgHebCCtm6WNBD9CHv2+amA=;
 b=OaqnBpnlWgJEVhdspYB+PSDcSQ4xnWd7FNudPGmStM3ZA5oJY69s2sHB/EqOhwvZxLDsxp
 QB8Jp1g5qga4JGJeCLqpOQhCDMZ7YBLTtJYgMwSBdEGvAd6SgLbLIJfVwMAjboxO69Axu+
 yXVkGtPRUq8uEI4uCxdbq9ZPzA8CzatzNjOYbJYZHwdcobUCMG1tRG8SUO3Fhe68g2RfXx
 CVkqcoQ2yX4YbZg1llc5+12ILd3KEw8JM+1G2gfH8wwwFHzi025nZ4V9/z40JCwefC4We/
 pXp9BJ2io9zF4XHD01mpkCtVjmhZMlQGO44mdHw9B8mN0CwoEU/uPPPhcw8cXA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] configs: sandbox: Enable environment in SPI NOR support
Date: Wed, 17 Dec 2025 21:12:31 +0100
Message-ID: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0a1275b5a5eb56f71ba
X-MBO-RS-META: kg4kdm5cft3ry8snpjg9wy7riwbmjyj5
X-Rspamd-Queue-Id: 4dWlNq1NrHz9tZ4
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

Make environment support in SPI NOR available in sandbox,
so the environment storage in SPI NOR can be tested in CI.
Enable redundant environment support as well to cover this
in CI tests too.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/sandbox/sandbox.c     | 1 +
 configs/sandbox64_defconfig | 6 ++++++
 configs/sandbox_defconfig   | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index d0bb3e3bb48..13006a0ffc2 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -89,6 +89,7 @@ static enum env_location env_locations[] = {
 	ENVL_NOWHERE,
 	ENVL_EXT4,
 	ENVL_FAT,
+	ENVL_SPI_FLASH,
 };
 
 enum env_location env_get_location(enum env_operation op, int prio)
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 70c757640c0..764bc5f9336 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -2,10 +2,13 @@ CONFIG_TEXT_BASE=0
 CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox64"
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PRE_CON_BUF_ADDR=0x100000
+CONFIG_ENV_OFFSET_REDUND=0x10000
 CONFIG_PCI=y
 CONFIG_SANDBOX64=y
 CONFIG_DEBUG_UART=y
@@ -106,6 +109,9 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index dfdaaff1eff..c7e69fdb3a4 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -2,9 +2,12 @@ CONFIG_TEXT_BASE=0
 CONFIG_SYS_MALLOC_LEN=0x6000000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DM_RESET=y
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PRE_CON_BUF_ADDR=0xf0000
+CONFIG_ENV_OFFSET_REDUND=0x10000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
 CONFIG_SYS_MEMTEST_START=0x00100000
@@ -154,6 +157,9 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
-- 
2.51.0

