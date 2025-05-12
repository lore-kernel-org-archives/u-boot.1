Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C086C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A130B80C83;
	Mon, 12 May 2025 18:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PPSD5ckW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VqLHlrmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4748982991; Mon, 12 May 2025 18:45:48 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A85B80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Zx58B15Lnz9sQ5;
 Mon, 12 May 2025 18:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TY6NoTCmCFAlGtc/fcJG1FKxxmOzYWAvD5uA8AFpSpk=;
 b=PPSD5ckWqnABGhjVn5HYsakmlCpwyQGQ7Kvp2OPoVNaVWFWnfxoPDrxvCnTzE4ePvfNgeL
 uyLmMkvpwYfmKcFyGSi7HY5TZ3AebK/udy02UsZK7IH+yqhfUsMkGazuam8CIAiXsxX3YT
 2tBf24geHMVjfSdOPaKHbWvAT0zBSLiXB+MwzWF/fD8KnOsogsM8Ktbm7aYSajM+E/pSs2
 34zC+6ut4FcvMuUzT0JpsuL1v/3Ka/yx+QacX6+1sllAYQowasoc3IWlPT7DD5jQANSejH
 kfvWsLSUXe0eklclOjjbHdQcwDEhnVu8Tlc5bt1rh/rMTSjpRIf1QSA3o3I3Hg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747068344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TY6NoTCmCFAlGtc/fcJG1FKxxmOzYWAvD5uA8AFpSpk=;
 b=VqLHlrmwQIugTzh/KnG2eJjp9AzlrCXXbpo0ZtDm5x550/w75toLtS/8gt9tvjcggvS8QB
 +IuaIdBGCkJVLQLNwgkGYHT7Egd+TbW9GMADokeJh28YJ6HH8buMFbRAQsNMVtIbr0obud
 MedTmn4aAd2zKqnjYPqz0jCXUHc1ubPjGCuED+xHFRYMILMIHP59izcvwEyqtD0Khb6z0o
 7KKW2D3ZgAox4avFfo07kLt5MRDt4kFHIvUXNCe+R0MWnD9aqDA4sc2le3uARuFsjls9au
 nhtF1m9zyK4uG/RjvLWbiLZB890YIE1NVaZIKtSRDOXk3FKYKDuGwRzkwu3r7Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Auto-detect ROM API table on STM32MP15xx
Date: Mon, 12 May 2025 18:45:14 +0200
Message-ID: <20250512164536.147793-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 17de77ef747e0109cd2
X-MBO-RS-META: n8r6m3zeb6xuzofuebmikpwdez6sz9jw
X-Rspamd-Queue-Id: 4Zx58B15Lnz9sQ5
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

The ROM API table location is passed to the SPL by BootROM in register r0,
make use of this, store the content of r0 and later use it to access the
ROM API table to determine current boot device.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/cpu.c        | 3 +--
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index 18175fd12cc..9ab5a3ede52 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -330,8 +330,7 @@ static uintptr_t nt_fw_dtb __section(".data");
 void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
 		      unsigned long r3)
 {
-	if (IS_ENABLED(CONFIG_STM32_ECDSA_VERIFY))
-		rom_api_table = r0;
+	rom_api_table = r0;
 
 	if (IS_ENABLED(CONFIG_TFABOOT))
 		nt_fw_dtb = r2;
diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index caeeeca863c..07d99034861 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -64,7 +64,6 @@
  * - boot instance = bit 31:16
  * - boot device = bit 15:0
  */
-#define BOOTROM_PARAM_ADDR	0x2FFC0078
 #define BOOTROM_MODE_MASK	GENMASK(15, 0)
 #define BOOTROM_MODE_SHIFT	0
 #define BOOTROM_INSTANCE_MASK	GENMASK(31, 16)
@@ -189,7 +188,7 @@ void spl_board_init(void)
 static void update_bootmode(void)
 {
 	u32 boot_mode;
-	u32 bootrom_itf = readl(BOOTROM_PARAM_ADDR);
+	u32 bootrom_itf = readl(get_stm32mp_rom_api_table());
 	u32 bootrom_device, bootrom_instance;
 
 	/* enable TAMP clock = RTCAPBEN */
-- 
2.47.2

