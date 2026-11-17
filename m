Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44937606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=flelstzh;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=ak5lHH3X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55B9660874;
	Tue, 17 Nov 2026 09:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mv4kJfAZ2HOi; Tue, 17 Nov 2026 09:19:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2177460865
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907184;
	b=rL0dtkJL/UemK7rkaJxEI9ExPbeY5ly+oP6cEpObrszSUnEu2vwZ29cLwUxl8SlZD2+z
	 usEOjUaHbPZtjJcmGGQ1aKFdjrbjIjdIZf64zT5aNPmDgJAEjmyhIiP0Xygp7nw2ATAEi
	 1chyNN78EOVakJ0xLwvpJG11G9zBHxYlnTfExSbXIQxCvCk42PknqitncQTMvJhMT3Xzq
	 aQbZyiilodYQ+1u3MFE8DlUgv4cE30Y3XrxVPvcrG5o3VQUQFE7wiYUj92nMpYAJApNkF
	 /6/e2ZSz2nrPcAGToW6y0EFrv8ljjsgBHy9bbzOiEz7z0itZAiVw/OTtElZh8SMLwIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oVxE/GOFDzpoodqYd1GvvzKFhEzuzkJDO2NMoIuT3w8=;
	b=YWlOy7G5dYRCNjjTpXj+7iB39Sqi7Dv03VM4LhukPs4N/dOSzo6Z/SrnrZGvkt6tiV0C
	 ugxJVyTwVzap2zUrJUbp1LjfAOrscUAPIOIvbPw4YWcHmVL0MAcf4HsRy7/JyLJSntjjV
	 rhhfYWAvmCk0XJ1JQ/FThCtOT0lQVywEW+lt/V4pNnOVrBaxevreFLXbZFnKznyrglR8w
	 k9kFID20cUTutcTFm299jx2eos7ZFEXpiEXJE3PnpeEzBC4QCLFmlrhJEUsgP88tJExVa
	 952B6btcympU2lFkG+EjRpvj8a8/ugC9AZX3toDe1KsmTgaQuQ633xGHNXL829xCUSA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907184;
	bh=oVxE/GOFDzpoodqYd1GvvzKFhEzuzkJDO2NMoIuT3w8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flelstzh7a6sygzsxeiUYyI1Hd5g2gGdhZn7xl/vLIlEkIUsVStR8hAzGJccrBAzt
	 ls1I7n/8aJ8rRHghdEZjKJZrqcWOGBxvf4wJo9GbweWG6qRJDepl3TZ3LrMcdB7j7J
	 Cj9LbV8hTBx5Tg5tWhnAgQlrVR7XlZ89l+ZWv5vF7vFLjvYkHIW4YqqCBuS+C8sySR
	 PByORcHLf6rrSupV7Gdx220YD3IlfujP7Q89mQ/RmPSJgVQwzfWEqYigeiXvv0mPGz
	 IQupSQL2ng6/00eeOXnPjxPGdJcGNGQ7OwacILyn7l0zTnoPMdUg+BUn8Tz2KBgUIp
	 qR/y7gFPkljKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2177460865;
	Tue, 17 Nov 2026 09:19:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B9091E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D66340507
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lb6qNNRtpoMg for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A2A8040433
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.125.25.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.8;
 helo=smtp-1908.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ak5lHH3X
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2A8040433
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:40 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTK1f4Nl4zyL5;
 Tue, 17 Nov 2026 10:19:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794907174;
 bh=oVxE/GOFDzpoodqYd1GvvzKFhEzuzkJDO2NMoIuT3w8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ak5lHH3XduGEddNYAHQj/KVWsJooPrpvVJlnTyg4wOWWY/jYTCzc75g7VZtq4t4L4
 9rMuiOIs1Jrxvm9LlX3e+u3d0hyG+m1IXSSmO37WP4/iCJF8r70XykX2kBGUFsBG8N
 sLvY7xvkyh52x4x22qOH6QB4IL5Gk5aeQQPOf1Zuci51CzgRkxNcW4G5sMoMO7OaPo
 Ky8751WavheybiWRqurcIATp40sFGquGHZGiA7xriGLupNgoJdGbxHOTU+c9Epqhhz
 tWEi2o00R/WkfDzZlXTHAfmgp59hvaNp9k7WX7WlTSGn52ubfu9Rj8TYkU9arHZBOW
 HYVPj6ZUeuPmQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTK1c3XGyzgYQ; Tue, 17 Nov 2026 10:19:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 10:19:03 +0100
Subject: [PATCH next 01/10] rockchip: be consistent on the "wording style"
 for BootROM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-doc-follow-up-v1-1-2cc0910f9455@cherry.de>
References: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
In-Reply-To: <20261117-rk-doc-follow-up-v1-0-2cc0910f9455@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, Johan Jonker <jbx6244@gmail.com>, 
 Shuqiao Zhang <stevenjoezhang@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Jonas suggested[1] to have a single style for Rockchip's BootROM, so
follow the recommendation and update all mentions to follow the new
style.

[1] https://lore.kernel.org/u-boot/1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se/
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/boot_mode.h |  2 +-
 arch/arm/include/asm/arch-rockchip/bootrom.h   |  4 ++--
 arch/arm/mach-rockchip/Kconfig                 |  8 ++++----
 arch/arm/mach-rockchip/bootrom.c               | 10 +++++-----
 doc/board/rockchip/rockchip.rst                |  8 ++++----
 drivers/clk/rockchip/clk_rk3368.c              |  2 +-
 drivers/clk/rockchip/clk_rk3399.c              |  4 ++--
 drivers/clk/rockchip/clk_rk3528.c              |  4 ++--
 drivers/mtd/nand/raw/rockchip_nfc.c            | 12 ++++++------
 drivers/usb/gadget/f_rockusb.c                 |  2 +-
 tools/rkcommon.c                               |  6 +++---
 tools/rkcommon.h                               |  8 ++++----
 tools/rkspi.c                                  |  2 +-
 13 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/boot_mode.h b/arch/arm/include/asm/arch-rockchip/boot_mode.h
index 6b2a610cf4c5..5e2859a2bb79 100644
--- a/arch/arm/include/asm/arch-rockchip/boot_mode.h
+++ b/arch/arm/include/asm/arch-rockchip/boot_mode.h
@@ -15,7 +15,7 @@
 #define BOOT_CHARGING		(REBOOT_FLAG + 11)
 /* enter usb mass storage mode */
 #define BOOT_UMS		(REBOOT_FLAG + 12)
-/* enter bootrom download mode */
+/* enter BootROM download mode */
 #define BOOT_BROM_DOWNLOAD	0xEF08A53C
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
index f9ecb6858f04..c5b0a0956083 100644
--- a/arch/arm/include/asm/arch-rockchip/bootrom.h
+++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
@@ -16,7 +16,7 @@
 extern u32 SAVE_SP_ADDR;
 
 /**
- * back_to_bootrom() - return to bootrom (for TPL/SPL), passing a
+ * back_to_bootrom() - return to BootROM (for TPL/SPL), passing a
  *                     result code
  *
  * Transfer control back to the Rockchip BROM, restoring necessary
@@ -26,7 +26,7 @@ extern u32 SAVE_SP_ADDR;
  *
  * This function does not return.
  *
- * @brom_cmd: indicates how the bootrom should continue the boot
+ * @brom_cmd: indicates how the BootROM should continue the boot
  *            sequence (e.g. load the next stage)
  */
 enum rockchip_bootrom_cmd {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index c1dbcce1e27c..2dc45aa54077 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -600,25 +600,25 @@ config ROCKCHIP_USB_UART
 	  SoCs will enable this routing as a debug measure.
 
 config SPL_ROCKCHIP_BACK_TO_BROM
-	bool "SPL returns to boot ROM"
+	bool "SPL returns to BootROM"
 	default y if ROCKCHIP_RK3036
 	select ROCKCHIP_BROM_HELPER
 	select SPL_BOOTROM_SUPPORT
 	depends on SPL
 	help
 	  Rockchip SoCs have the ability to load a second loader binary
-	  after the SPL phase. If enabled, SPL will return to the boot ROM,
+	  after the SPL phase. If enabled, SPL will return to the BootROM,
 	  which will then load and execute the U-Boot binary.
 
 config TPL_ROCKCHIP_BACK_TO_BROM
-	bool "TPL returns to boot ROM"
+	bool "TPL returns to BootROM"
 	default y
 	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
 	select TPL_BOOTROM_SUPPORT
 	depends on TPL
 	help
 	  Rockchip SoCs have the ability to load a second loader binary
-	  after the TPL phase. If enabled, TPL will return to the boot ROM,
+	  after the TPL phase. If enabled, TPL will return to the BootROM,
 	  which will then load and execute a SPL binary.
 
 config ROCKCHIP_COMMON_BOARD
diff --git a/arch/arm/mach-rockchip/bootrom.c b/arch/arm/mach-rockchip/bootrom.c
index 1db38546d553..032a134e4f50 100644
--- a/arch/arm/mach-rockchip/bootrom.c
+++ b/arch/arm/mach-rockchip/bootrom.c
@@ -25,21 +25,21 @@ static void _back_to_bootrom(enum rockchip_bootrom_cmd brom_cmd)
 void back_to_bootrom(enum rockchip_bootrom_cmd brom_cmd)
 {
 #if CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT)
-	puts("Returning to boot ROM...\n");
+	puts("Returning to BootROM...\n");
 #endif
 	_back_to_bootrom(brom_cmd);
 }
 
 /*
- * we back to bootrom download mode if get a
+ * we back to BootROM download mode if get a
  * BOOT_BROM_DOWNLOAD flag in boot mode register
  *
  * note: the boot mode register is configured by
  * application(next stage bootloader, kernel, etc),
- * and the bootrom never check this register, so we need
- * to check it and back to bootrom at very early bootstage(before
+ * and the BootROM never check this register, so we need
+ * to check it and back to BootROM at very early bootstage(before
  * some basic configurations(such as interrupts) been
- * changed by TPL/SPL, as the bootrom download operation
+ * changed by TPL/SPL, as the BootROM download operation
  * relies on many default settings(such as interrupts) by
  * itself.
  */
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index dd53a651c621..2dfbfa5f5f8c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -339,7 +339,7 @@ Notes
 Mask ROM mode
 -------------
 
-Mask ROM mode is the fallback mode of the boot ROM,
+Mask ROM mode is the fallback mode of the BootROM,
 in which it listens for USB commands 0x471/0x472.
 
 Options to get your board into Mask ROM mode:
@@ -351,7 +351,7 @@ Options to get your board into Mask ROM mode:
 
 Methods of last resort (USE AT YOUR OWN RISK):
 
-Short the following pins briefly while powering the board, so the boot ROM
+Short the following pins briefly while powering the board, so the BootROM
 cannot locate any boot firmware and falls back into Mask ROM mode:
 
 * NAND: connect pin 8 and 9 of the NAND flash with a needle.
@@ -475,7 +475,7 @@ Note:
 3. Package the RK3066 image with U-Boot TPL/SPL on NAND
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Unlike later SoC models the rk3066 boot ROM doesn't have SDMMC support.
+Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
 If all other boot options fail then it enters into a Mask ROM mode on the USB OTG port.
 This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
@@ -578,7 +578,7 @@ Back to ROM
 ^^^^^^^^^^^
 
 Rockchip SoCs have the ability to load a second loader binary.
-If enabled, the TPL/SPL code will return to the boot ROM, which will then
+If enabled, the TPL/SPL code will return to the BootROM, which will then
 load and execute a SPL or U-Boot binary.
 
 
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 630253fbb1df..5cc7a2a1a3bc 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -139,7 +139,7 @@ static void rkclk_init(struct rk3368_cru *cru)
 	rkclk_set_pll(cru, APLLL, &apll_l_init_cfg);
 #if !defined(CONFIG_TPL_BUILD)
 	/*
-	 * If we plan to return to the boot ROM, we can't increase the
+	 * If we plan to return to the BootROM, we can't increase the
 	 * GPLL rate from the SPL stage.
 	 */
 	rkclk_set_pll(cru, GPLL, &gpll_init_cfg);
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 6e87db18be07..33ac2702ba5b 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1383,9 +1383,9 @@ static void rkclk_init(struct rockchip_cru *cru)
 	rk3399_configure_cpu_l(cru, APLL_L_600_MHZ);
 	rk3399_configure_cpu_b(cru, APLL_B_600_MHZ);
 	/*
-	 * some cru registers changed by bootrom, we'd better reset them to
+	 * some cru registers changed by BootROM, we'd better reset them to
 	 * reset/default values described in TRM to avoid confusion in kernel.
-	 * Please consider these three lines as a fix of bootrom bug.
+	 * Please consider these three lines as a fix of BootROM bug.
 	 */
 	rk_clrsetreg(&cru->clksel_con[12], 0xffff, 0x4101);
 	rk_clrsetreg(&cru->clksel_con[19], 0xffff, 0x033f);
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index ee4284d65d03..2132f0495ba5 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -1604,7 +1604,7 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 
 #ifdef CONFIG_XPL_BUILD
 	/*
-	 * BOOTROM:
+	 * BootROM:
 	 *	CPU 1902/2(postdiv1)=546M
 	 *	CPLL 996/2(postdiv1)=498M
 	 *	GPLL 1188/2(postdiv1)=594M
@@ -1659,7 +1659,7 @@ static int rk3528_clk_init(struct rk3528_clk_priv *priv)
 	}
 
 #ifdef CONFIG_XPL_BUILD
-	/* Init to override bootrom config */
+	/* Init to override BootROM config */
 	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_50M_SRC,   50000000);
 	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_100M_SRC, 100000000);
 	rk3528_cgpll_matrix_set_rate(priv, CLK_MATRIX_150M_SRC, 150000000);
diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index d23a651f3692..71bc4999d053 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -461,7 +461,7 @@ static int rk_nfc_write_page_raw(struct mtd_info *mtd,
 			       ecc->size);
 		/*
 		 * The first four bytes of OOB are reserved for the
-		 * boot ROM. In some debugging cases, such as with a
+		 * BootROM. In some debugging cases, such as with a
 		 * read, erase and write back test these 4 bytes stored
 		 * in OOB also need to be written back.
 		 *
@@ -537,7 +537,7 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *mtd,
 
 	/*
 	 * The first blocks (4, 8 or 16 depending on the device) are used
-	 * by the boot ROM and the first 32 bits of OOB need to link to
+	 * by the BootROM and the first 32 bits of OOB need to link to
 	 * the next page address in the same block. We can't directly copy
 	 * OOB data from the MTD framework, because this page address
 	 * conflicts for example with the bad block marker (BBM),
@@ -559,7 +559,7 @@ static int rk_nfc_write_page_hwecc(struct mtd_info *mtd,
 	 *
 	 *    BBM  OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
 	 *
-	 * Configure the ECC algorithm supported by the boot ROM.
+	 * Configure the ECC algorithm supported by the BootROM.
 	 */
 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
 	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
@@ -641,7 +641,7 @@ static int rk_nfc_read_page_raw(struct mtd_info *mtd,
 	for (i = 0; i < ecc->steps; i++) {
 		/*
 		 * The first four bytes of OOB are reserved for the
-		 * boot ROM. In some debugging cases, such as with a read,
+		 * BootROM. In some debugging cases, such as with a read,
 		 * erase and write back test, these 4 bytes also must be
 		 * saved somewhere, otherwise this information will be
 		 * lost during a write back.
@@ -699,8 +699,8 @@ static int rk_nfc_read_page_hwecc(struct mtd_info *mtd,
 
 	/*
 	 * The first blocks (4, 8 or 16 depending on the device)
-	 * are used by the boot ROM.
-	 * Configure the ECC algorithm supported by the boot ROM.
+	 * are used by the BootROM.
+	 * Configure the ECC algorithm supported by the BootROM.
 	 */
 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
 	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
diff --git a/drivers/usb/gadget/f_rockusb.c b/drivers/usb/gadget/f_rockusb.c
index 77a89b47d990..0855aa4238d2 100644
--- a/drivers/usb/gadget/f_rockusb.c
+++ b/drivers/usb/gadget/f_rockusb.c
@@ -590,7 +590,7 @@ static void cb_get_chip_version(struct usb_ep *ep, struct usb_request *req)
 	rk_get_bootrom_chip_version(chip_info, 4);
 
 	/*
-	 * Chip Version is a string saved in BOOTROM address space Little Endian
+	 * Chip Version is a string saved in BootROM address space Little Endian
 	 *
 	 * Ex for rk3288: 0x33323041 0x32303134 0x30383133 0x56323030
 	 * which brings:  320A20140813V200
diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index cb904db20b4e..c8d711afaa32 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -51,7 +51,7 @@ struct image_entry {
 };
 
 /**
- * struct header0_info_v2 - v2 header block for rockchip BootRom
+ * struct header0_info_v2 - v2 header block for rockchip BootROM
  *
  * This is stored at SD card block 64 (where each block is 512 bytes)
  *
@@ -74,7 +74,7 @@ struct header0_info_v2 {
 };
 
 /**
- * struct header0_info - header block for boot ROM
+ * struct header0_info - header block for BootROM
  *
  * This is stored at MMC block 64 (where each block is 512 bytes), or at
  * the start of SPI flash. It is encoded with RC4 with the below rc4_key.
@@ -123,7 +123,7 @@ struct header1_info {
  * struct spl_info - spl info for each chip
  *
  * @imagename:		Image name(passed by "mkimage -n")
- * @spl_hdr:		Boot ROM requires a 4-bytes spl header
+ * @spl_hdr:		BootROM requires a 4-bytes spl header
  * @spl_size:		Spl size(include extra 4-bytes spl header)
  * @spl_rc4:		RC4 encode the SPL binary (same key as header)
  * @header_ver:		header block version
diff --git a/tools/rkcommon.h b/tools/rkcommon.h
index 5d2770a80f1c..98b1a405b3e4 100644
--- a/tools/rkcommon.h
+++ b/tools/rkcommon.h
@@ -26,7 +26,7 @@ int rkcommon_check_params(struct image_tool_params *params);
 /**
  * rkcommon_get_spl_hdr() - get 4-bytes spl hdr for a Rockchip boot image
  *
- * Rockchip's bootrom requires the spl loader to start with a 4-bytes
+ * Rockchip's BootROM requires the spl loader to start with a 4-bytes
  * header. The content of this header depends on the chip type.
  */
 const char *rkcommon_get_spl_hdr(struct image_tool_params *params);
@@ -35,8 +35,8 @@ const char *rkcommon_get_spl_hdr(struct image_tool_params *params);
  * rkcommon_get_spl_size() - get spl size for a Rockchip boot image
  *
  * Different chip may have different sram size. And if we want to jump
- * back to the bootrom after spl, we may need to reserve some sram space
- * for the bootrom.
+ * back to the BootROM after spl, we may need to reserve some sram space
+ * for the BootROM.
  * The spl loader size should be sram size minus reserved size(if needed)
  */
 int rkcommon_get_spl_size(struct image_tool_params *params);
@@ -44,7 +44,7 @@ int rkcommon_get_spl_size(struct image_tool_params *params);
 /**
  * rkcommon_set_header() - set up the header for a Rockchip boot image
  *
- * This sets up a 2KB header which can be interpreted by the Rockchip boot ROM.
+ * This sets up a 2KB header which can be interpreted by the Rockchip BootROM.
  *
  * @buf:	Pointer to header place (must be at least 2KB in size)
  */
diff --git a/tools/rkspi.c b/tools/rkspi.c
index 63770b61effb..19b52fa664a5 100644
--- a/tools/rkspi.c
+++ b/tools/rkspi.c
@@ -27,7 +27,7 @@ static void rkspi_set_header(void *buf, struct stat *sbuf, int ifd,
 	/*
 	 * Spread the image out so we only use the first 2KB of each 4KB
 	 * region. This is a feature of the SPI format required by the Rockchip
-	 * boot ROM. Its rationale is unknown.
+	 * BootROM. Its rationale is unknown.
 	 */
 	if (params->vflag)
 		fprintf(stderr, "Spreading spi image from %u to %u\n",

-- 
2.56.1

