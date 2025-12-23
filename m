Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E78E6F096
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7F68412F;
	Tue, 23 Dec 2025 15:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v9B3Hq4K";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C+zWdOy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10DC7840DF; Tue, 23 Dec 2025 15:31:45 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF3284119
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dbHWf5v3rz9t0J;
 Tue, 23 Dec 2025 15:31:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766500302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgOLZfTwuk7slj9ycSGI8EJckoENqHA67c7KjDWNyEw=;
 b=v9B3Hq4K2gmTzixthxpj/QwFDSgR4lvhvbFG33/UTZoXafIiSpBGNEeHlbZVVQ07cueGYb
 obdV0W4n3rfd0JiRadvMfB0lnidegkMFW13ujx+WI9/qjWy55JP5Va100OZcN0APTyXm0d
 OmK4qKMb3J2onYfLoHFJP4CG2dvMIMbuEOEiDX7rEYIie+5SreSXBvyiIwgRPQBS1NHTSz
 /TRrv4vaBIKu5jXQJpyImfk5ffXLM55B6+mdAJ3t21LhgvYGXyVydiwQnCzZezjIESgUQj
 Hlof7ePHBCZdy1lGqt47GB0V5eRspCfmknHFPWFP7kyDkpNaXGocc3czQ8nsAA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=C+zWdOy3;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766500300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgOLZfTwuk7slj9ycSGI8EJckoENqHA67c7KjDWNyEw=;
 b=C+zWdOy3pNoogbrbCdvc+8w55SG9odkfzDVwnPrIfEXLA8t1jO7+sSaOfroDK3bj7Zg2gY
 ctwI8oplvYhyEowsh08dqJaS4kpOqnWXJ+HCqj3n4hQpZWYM7NFZHcaI/2O+7Yp1fsLdyb
 3eeMgvVIkM7QfQd2unhTcMdxKgbwQ5Wr6VLA1UFDrPNY5pz2jW07jeQQtkDkfOJgnZos1C
 kDO0k1+Zeb6E+QNyX6RPMr/ahPcP9DicbqLQhB1AKPHmKOQIBFggl6kacXcYnHq89aXVFn
 ZjNmL4TfH26PYBiSkdijdRFvKDbumlRSV6oc59lnZiwX2sQiokuPmz+QBPXaVQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] configs: sandbox: Enable environment in SPI NOR support
Date: Tue, 23 Dec 2025 15:31:12 +0100
Message-ID: <20251223143130.16266-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
References: <20251223143130.16266-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 245fca030b3a9334378
X-MBO-RS-META: w6khdusd6siemupqi9qb7mpq4acgxkid
X-Rspamd-Queue-Id: 4dbHWf5v3rz9t0J
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
V2: Enable ENV_REDUNDANT_UPGRADE
---
 board/sandbox/sandbox.c     | 1 +
 configs/sandbox64_defconfig | 7 +++++++
 configs/sandbox_defconfig   | 7 +++++++
 3 files changed, 15 insertions(+)

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
index 70c757640c0..22de4acbd88 100644
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
@@ -106,6 +109,10 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_REDUNDANT_UPGRADE=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index dfdaaff1eff..97f5d5dc074 100644
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
@@ -154,6 +157,10 @@ CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SECT_SIZE_AUTO=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_REDUNDANT_UPGRADE=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
-- 
2.51.0

