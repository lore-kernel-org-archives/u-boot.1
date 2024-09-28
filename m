Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DBFCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D95588D78;
	Sat, 28 Sep 2024 22:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jvkHHJRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94BD488DD4; Sat, 28 Sep 2024 22:01:20 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D34288D61
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a1a3090f93so10785495ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553672; x=1728158472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd6PVmQDxHiLHT1P/NlQ2dPGfvwuM9uuWuTS4MK27o0=;
 b=jvkHHJRf5uaPkM0+g4CLxyoYnHWxC1Ah+LBDgeMQRUa6fqup7oL3icmmsTRW+dGmX3
 cFt3HnFBX2M58lG0YOcaPV6KEXcJ7Fqruc6aPUXzYM5ydFTpy5cOPtU/8KRDmpBiSdpg
 UOhKsZTIxOYKWFYShu0ipJxTwR4GUcfccG7mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553672; x=1728158472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd6PVmQDxHiLHT1P/NlQ2dPGfvwuM9uuWuTS4MK27o0=;
 b=XKcb46Bf/7u6LKeD0cVGiejUt0yxuURCnm5LXDwPqtYoMkRjTVFO6j1T56+hTXPJXS
 rdwECkiI3NJfK3JO0ID40maqofk5cTpd+lMX0iUAr2UrLt4pcX6d5YX4E3DnterDPYpO
 NEkVKOxilHcAZvJ6d18aEp5BJRFEN8ALwI0wDNKd5zeTnXoFamOCkn3B/zJ6m5Jelglb
 9DR8DlyJ0K4mLl8CfVr78dSHv8JxaRxx5RhzqiZKi44YYHz+hl4um9mfnXs8xmfOObMT
 +iXGddonRa7rqixI4CnRbv8HM6MCNXuPQa83d4GzSkztHTJ6dbMKyuf1x53FkaTUfNJP
 oqZw==
X-Gm-Message-State: AOJu0YwqF4dNJcjki7ONgBpEU/NqGCRFmSRBOn9AEqU5nV297A36veyU
 9qpOOPo6vMWbLgRWDa0Q6X56Se7yUp87Mo0MqytxJZs/tgrVaZ/Zx+telri9aHnjunYt0VX5Z4Q
 o/Q==
X-Google-Smtp-Source: AGHT+IHPTfkiJ29sktpVqHkFOj6IDS7rInCzOHX1u6sC1nyCgQolQdqTbxKoibidyk7iIeUVFQF4gg==
X-Received: by 2002:a05:6e02:1c4c:b0:3a0:a4dd:683b with SMTP id
 e9e14a558f8ab-3a345166de5mr62226305ab.8.1727553671380; 
 Sat, 28 Sep 2024 13:01:11 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Devarsh Thakkar <devarsht@ti.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Moritz Fischer <moritzf@google.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, Philip Oberfichtner <pro@denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Udit Kumar <u-kumar1@ti.com>, William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2 23/30] xpl: Rename spl_phase() to xpl_phase()
Date: Sat, 28 Sep 2024 14:00:23 -0600
Message-Id: <20240928200030.194546-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Rename this function to indicate that it refers to any xPL phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 README                                   |  6 +++---
 arch/sandbox/cpu/spl.c                   |  2 +-
 arch/sandbox/cpu/start.c                 |  2 +-
 arch/x86/cpu/apollolake/cpu_spl.c        |  4 ++--
 arch/x86/cpu/apollolake/hostbridge.c     |  2 +-
 arch/x86/cpu/apollolake/lpc.c            |  2 +-
 arch/x86/cpu/apollolake/pch.c            |  2 +-
 arch/x86/cpu/apollolake/pmc.c            |  4 ++--
 arch/x86/cpu/apollolake/punit.c          |  2 +-
 arch/x86/cpu/apollolake/spl.c            |  2 +-
 arch/x86/cpu/broadwell/cpu.c             |  2 +-
 arch/x86/cpu/i386/cpu.c                  |  2 +-
 arch/x86/cpu/intel_common/mrc.c          |  2 +-
 arch/x86/cpu/intel_common/p2sb.c         |  6 +++---
 arch/x86/lib/fsp2/fsp_dram.c             |  2 +-
 arch/x86/lib/fsp2/fsp_init.c             |  4 ++--
 boot/fdt_simplefb.c                      |  2 +-
 boot/vbe_simple_fw.c                     |  4 ++--
 common/board_f.c                         |  2 +-
 common/bootstage.c                       |  2 +-
 common/spl/spl.c                         |  6 +++---
 doc/develop/spl.rst                      |  4 ++--
 drivers/i2c/designware_i2c_pci.c         |  4 ++--
 drivers/misc/p2sb-uclass.c               |  2 +-
 drivers/pci/pci-uclass.c                 |  4 ++--
 drivers/pci/pci_rom.c                    |  4 ++--
 drivers/pinctrl/intel/pinctrl.c          |  6 +++---
 drivers/power/acpi_pmc/acpi-pmc-uclass.c |  2 +-
 drivers/ram/rockchip/sdram_rk3399.c      |  2 +-
 drivers/spi/ich.c                        |  4 ++--
 drivers/sysreset/sysreset-uclass.c       |  2 +-
 drivers/video/console_truetype.c         |  6 +++---
 drivers/video/video-uclass.c             |  6 +++---
 include/spl.h                            | 10 +++++-----
 lib/fdtdec.c                             |  2 +-
 lib/lmb.c                                |  4 ++--
 lib/time.c                               |  2 +-
 37 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/README b/README
index a88e14a0449..54ffbd0975b 100644
--- a/README
+++ b/README
@@ -1512,7 +1512,7 @@ Low Level (hardware related) configuration options:
 		Set when the currently running compilation is for an artifact
 		that will end up in one of the 'xPL' builds, i.e. SPL, TPL or
 		VPL. Code that needs phase-specific behaviour can check this,
-		or (where possible) use spl_phase() instead.
+		or (where possible) use xpl_phase() instead.
 
 		Note that CONFIG_XPL_BUILD *is* always defined when either
 		of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
@@ -1522,13 +1522,13 @@ Low Level (hardware related) configuration options:
 		Set when the currently running compilation is for an artifact
 		that will end up in the TPL build (as opposed to SPL, VPL or
 		U-Boot proper). Code that needs phase-specific behaviour can
-		check this, or (where possible) use spl_phase() instead.
+		check this, or (where possible) use xpl_phase() instead.
 
 - CONFIG_VPL_BUILD
 		Set when the currently running compilation is for an artifact
 		that will end up in the VPL build (as opposed to the SPL, TPL
 		or U-Boot proper). Code that needs phase-specific behaviour can
-		check this, or (where possible) use spl_phase() instead.
+		check this, or (where possible) use xpl_phase() instead.
 
 - CONFIG_ARCH_MAP_SYSMEM
 		Generally U-Boot (and in particular the md command) uses
diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 6c6f4fd8c3e..7497d90fb89 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -27,7 +27,7 @@ int sandbox_find_next_phase(char *fname, int maxlen, bool use_img)
 	const char *cur_prefix, *next_prefix;
 	int ret;
 
-	cur_prefix = spl_phase_prefix(spl_phase());
+	cur_prefix = spl_phase_prefix(xpl_phase());
 	next_prefix = spl_phase_prefix(spl_next_phase());
 	ret = os_find_u_boot(fname, maxlen, use_img, cur_prefix, next_prefix);
 	if (ret)
diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index ef587ef48b0..81752edc9f8 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -206,7 +206,7 @@ static int sandbox_cmdline_cb_test_fdt(struct sandbox_state *state,
 	char *relname;
 	int len;
 
-	if (spl_phase() <= PHASE_SPL)
+	if (xpl_phase() <= PHASE_SPL)
 		relname = "../arch/sandbox/dts/test.dtb";
 	else
 		relname = "arch/sandbox/dts/test.dtb";
diff --git a/arch/x86/cpu/apollolake/cpu_spl.c b/arch/x86/cpu/apollolake/cpu_spl.c
index 8798fa79d4c..8198667fa50 100644
--- a/arch/x86/cpu/apollolake/cpu_spl.c
+++ b/arch/x86/cpu/apollolake/cpu_spl.c
@@ -184,9 +184,9 @@ int arch_cpu_init(void)
 {
 	int ret = 0;
 
-	if (spl_phase() == PHASE_TPL)
+	if (xpl_phase() == PHASE_TPL)
 		ret = arch_cpu_init_tpl();
-	else if (spl_phase() == PHASE_SPL)
+	else if (xpl_phase() == PHASE_SPL)
 		ret = arch_cpu_init_spl();
 	if (ret)
 		printf("%s: Error %d\n", __func__, ret);
diff --git a/arch/x86/cpu/apollolake/hostbridge.c b/arch/x86/cpu/apollolake/hostbridge.c
index 9ee362239ef..039236df02d 100644
--- a/arch/x86/cpu/apollolake/hostbridge.c
+++ b/arch/x86/cpu/apollolake/hostbridge.c
@@ -255,7 +255,7 @@ static int apl_hostbridge_of_to_plat(struct udevice *dev)
 
 static int apl_hostbridge_probe(struct udevice *dev)
 {
-	if (spl_phase() == PHASE_TPL)
+	if (xpl_phase() == PHASE_TPL)
 		return apl_hostbridge_early_init(dev);
 
 	return 0;
diff --git a/arch/x86/cpu/apollolake/lpc.c b/arch/x86/cpu/apollolake/lpc.c
index 531ff1cd91f..f34c199bf73 100644
--- a/arch/x86/cpu/apollolake/lpc.c
+++ b/arch/x86/cpu/apollolake/lpc.c
@@ -80,7 +80,7 @@ int lpc_open_pmio_window(uint base, uint size)
 
 		lgir_reg_num = find_unused_pmio_window();
 		if (lgir_reg_num < 0) {
-			if (spl_phase() > PHASE_TPL) {
+			if (xpl_phase() > PHASE_TPL) {
 				log_err("LPC: Cannot open IO window: %lx size %lx\n",
 					bridge_base, size - bridged_size);
 				log_err("No more IO windows\n");
diff --git a/arch/x86/cpu/apollolake/pch.c b/arch/x86/cpu/apollolake/pch.c
index 32190312ff8..07ef26f6bde 100644
--- a/arch/x86/cpu/apollolake/pch.c
+++ b/arch/x86/cpu/apollolake/pch.c
@@ -12,7 +12,7 @@
 
 static int apl_set_spi_protect(struct udevice *dev, bool protect)
 {
-	if (spl_phase() == PHASE_SPL)
+	if (xpl_phase() == PHASE_SPL)
 		return lpc_set_spi_protect(dev, BIOS_CTRL, protect);
 
 	return 0;
diff --git a/arch/x86/cpu/apollolake/pmc.c b/arch/x86/cpu/apollolake/pmc.c
index 32fd0344861..bfb8a07d47a 100644
--- a/arch/x86/cpu/apollolake/pmc.c
+++ b/arch/x86/cpu/apollolake/pmc.c
@@ -115,7 +115,7 @@ int apl_pmc_ofdata_to_uc_plat(struct udevice *dev)
 				 ARRAY_SIZE(base));
 	if (ret)
 		return log_msg_ret("Missing/short early-regs", ret);
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		upriv->pmc_bar0 = (void *)base[0];
 		upriv->pmc_bar2 = (void *)base[2];
 
@@ -186,7 +186,7 @@ static int enable_pmcbar(struct udevice *dev)
 
 static int apl_pmc_probe(struct udevice *dev)
 {
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		return enable_pmcbar(dev);
 	} else {
 		struct acpi_pmc_upriv *upriv = dev_get_uclass_priv(dev);
diff --git a/arch/x86/cpu/apollolake/punit.c b/arch/x86/cpu/apollolake/punit.c
index b1503c25140..9c708e9df55 100644
--- a/arch/x86/cpu/apollolake/punit.c
+++ b/arch/x86/cpu/apollolake/punit.c
@@ -77,7 +77,7 @@ static int punit_init(struct udevice *dev)
 
 static int apl_punit_probe(struct udevice *dev)
 {
-	if (spl_phase() == PHASE_SPL)
+	if (xpl_phase() == PHASE_SPL)
 		return punit_init(dev);
 
 	return 0;
diff --git a/arch/x86/cpu/apollolake/spl.c b/arch/x86/cpu/apollolake/spl.c
index b351d73e7d8..510f8c4350f 100644
--- a/arch/x86/cpu/apollolake/spl.c
+++ b/arch/x86/cpu/apollolake/spl.c
@@ -116,7 +116,7 @@ static int spl_fast_spi_load_image(struct spl_image_info *spl_image,
 		return ret;
 
 	spl_image->size = CONFIG_SYS_MONITOR_LEN;  /* We don't know SPL size */
-	spl_image->entry_point = spl_phase() == PHASE_TPL ?
+	spl_image->entry_point = xpl_phase() == PHASE_TPL ?
 		CONFIG_SPL_TEXT_BASE : CONFIG_TEXT_BASE;
 	spl_image->load_addr = spl_image->entry_point;
 	spl_image->os = IH_OS_U_BOOT;
diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index dc6717eca40..87463748c4d 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -68,7 +68,7 @@ int arch_cpu_init(void)
 	post_code(POST_CPU_INIT);
 
 	/* Do a mini-init if TPL has already done the full init */
-	if (IS_ENABLED(CONFIG_TPL) && spl_phase() != PHASE_TPL)
+	if (IS_ENABLED(CONFIG_TPL) && xpl_phase() != PHASE_TPL)
 		return x86_cpu_reinit_f();
 	else
 		return x86_cpu_init_f();
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 934e98ac582..d837fb97982 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -271,7 +271,7 @@ static void identify_cpu(struct cpu_device_id *cpu)
 	 * Do a quick and dirty check to save space - Intel and AMD only and
 	 * just the vendor. This is enough for most TPL code.
 	 */
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		struct cpuid_result result;
 
 		result = cpuid(0x00000000);
diff --git a/arch/x86/cpu/intel_common/mrc.c b/arch/x86/cpu/intel_common/mrc.c
index c834c05d130..baa1f0e32d6 100644
--- a/arch/x86/cpu/intel_common/mrc.c
+++ b/arch/x86/cpu/intel_common/mrc.c
@@ -259,7 +259,7 @@ int mrc_common_init(struct udevice *dev, void *pei_data, bool use_asm_linkage)
 		return ret;
 
 	delay = dev_read_u32_default(dev, "fspm,training-delay", 0);
-	if (spl_phase() == PHASE_SPL) {
+	if (xpl_phase() == PHASE_SPL) {
 		if (delay)
 			printf("SDRAM training (%d seconds)...", delay);
 		else
diff --git a/arch/x86/cpu/intel_common/p2sb.c b/arch/x86/cpu/intel_common/p2sb.c
index 7aad8f8ca56..406c41013fc 100644
--- a/arch/x86/cpu/intel_common/p2sb.c
+++ b/arch/x86/cpu/intel_common/p2sb.c
@@ -96,7 +96,7 @@ int p2sb_of_to_plat(struct udevice *dev)
 		return log_msg_ret("Missing/short early-regs", ret);
 	plat->mmio_base = base[0];
 	/* TPL sets up the initial BAR */
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		plat->bdf = pci_get_devfn(dev);
 		if (plat->bdf < 0)
 			return log_msg_ret("Cannot get p2sb PCI address",
@@ -114,9 +114,9 @@ int p2sb_of_to_plat(struct udevice *dev)
 
 static int p2sb_probe(struct udevice *dev)
 {
-	if (spl_phase() == PHASE_TPL)
+	if (xpl_phase() == PHASE_TPL)
 		return p2sb_early_init(dev);
-	else if (spl_phase() == PHASE_SPL)
+	else if (xpl_phase() == PHASE_SPL)
 		return p2sb_spl_init(dev);
 
 	return 0;
diff --git a/arch/x86/lib/fsp2/fsp_dram.c b/arch/x86/lib/fsp2/fsp_dram.c
index a50dc985a3c..4c4c8334bdb 100644
--- a/arch/x86/lib/fsp2/fsp_dram.c
+++ b/arch/x86/lib/fsp2/fsp_dram.c
@@ -28,7 +28,7 @@ int dram_init(void)
 
 		return 0;
 	}
-	if (spl_phase() == PHASE_SPL) {
+	if (xpl_phase() == PHASE_SPL) {
 		bool s3wake = false;
 
 		s3wake = IS_ENABLED(CONFIG_HAVE_ACPI_RESUME) &&
diff --git a/arch/x86/lib/fsp2/fsp_init.c b/arch/x86/lib/fsp2/fsp_init.c
index ecbadaae75c..1a2bf46c5c5 100644
--- a/arch/x86/lib/fsp2/fsp_init.c
+++ b/arch/x86/lib/fsp2/fsp_init.c
@@ -25,7 +25,7 @@ int fsp_setup_pinctrl(void)
 	int ret;
 
 	/* Make sure pads are set up early in U-Boot */
-	if (!ll_boot_init() || spl_phase() != PHASE_BOARD_F)
+	if (!ll_boot_init() || xpl_phase() != PHASE_BOARD_F)
 		return 0;
 
 	/* Probe all pinctrl devices to set up the pads */
@@ -134,7 +134,7 @@ int fsp_locate_fsp(enum fsp_type_t type, struct binman_entry *entry,
 			return log_msg_ret("Could not get flash mmap", ret);
 	}
 
-	if (spl_phase() >= PHASE_BOARD_F) {
+	if (xpl_phase() >= PHASE_BOARD_F) {
 		if (type != FSP_S)
 			return -EPROTONOSUPPORT;
 		ret = binman_entry_find("intel-fsp-s", entry);
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 53415548459..71b833eb9bd 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -27,7 +27,7 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 	struct udevice *dev;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && xpl_phase() > PHASE_SPL) {
 		struct video_handoff *ho;
 
 		ho = bloblist_find(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho));
diff --git a/boot/vbe_simple_fw.c b/boot/vbe_simple_fw.c
index 4d6da9490a7..da9701f9eb9 100644
--- a/boot/vbe_simple_fw.c
+++ b/boot/vbe_simple_fw.c
@@ -157,7 +157,7 @@ static int simple_load_from_image(struct spl_image_info *spl_image,
 	struct vbe_handoff *handoff;
 	int ret;
 
-	if (spl_phase() != PHASE_VPL && spl_phase() != PHASE_SPL)
+	if (xpl_phase() != PHASE_VPL && xpl_phase() != PHASE_SPL)
 		return -ENOENT;
 
 	ret = bloblist_ensure_size(BLOBLISTT_VBE, sizeof(struct vbe_handoff),
@@ -197,7 +197,7 @@ static int simple_load_from_image(struct spl_image_info *spl_image,
 	bootflow_free(&bflow);
 
 	/* Record that VBE was used in this phase */
-	handoff->phases |= 1 << spl_phase();
+	handoff->phases |= 1 << xpl_phase();
 
 	return 0;
 }
diff --git a/common/board_f.c b/common/board_f.c
index 154675d0e40..f1bd70fdd6c 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -397,7 +397,7 @@ __weak int arch_reserve_mmu(void)
 
 static int reserve_video_from_videoblob(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && xpl_phase() > PHASE_SPL) {
 		struct video_handoff *ho;
 		int ret = 0;
 
diff --git a/common/bootstage.c b/common/bootstage.c
index 72d80ee9fe5..dd6aed7c2fd 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -489,7 +489,7 @@ int bootstage_unstash(const void *base, int size)
 	for (rec = data->record + data->next_id, i = 0; i < hdr->count;
 	     i++, rec++) {
 		rec->name = ptr;
-		if (spl_phase() == PHASE_SPL)
+		if (xpl_phase() == PHASE_SPL)
 			rec->name = strdup(ptr);
 
 		/* Assume no data corruption here */
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 81b3501ebaf..a0de495e529 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -441,7 +441,7 @@ static inline int write_spl_handoff(void) { return 0; }
  */
 static enum bootstage_id get_bootstage_id(bool start)
 {
-	enum xpl_phase_t phase = spl_phase();
+	enum xpl_phase_t phase = xpl_phase();
 
 	if (IS_ENABLED(CONFIG_TPL_BUILD) && phase == PHASE_TPL)
 		return start ? BOOTSTAGE_ID_START_TPL : BOOTSTAGE_ID_END_TPL;
@@ -476,7 +476,7 @@ static int spl_common_init(bool setup_malloc)
 			log_debug("Failed to unstash bootstage: ret=%d\n", ret);
 	}
 	bootstage_mark_name(get_bootstage_id(true),
-			    spl_phase_name(spl_phase()));
+			    spl_phase_name(xpl_phase()));
 #if CONFIG_IS_ENABLED(LOG)
 	ret = log_init();
 	if (ret) {
@@ -493,7 +493,7 @@ static int spl_common_init(bool setup_malloc)
 	}
 	if (CONFIG_IS_ENABLED(DM)) {
 		bootstage_start(BOOTSTAGE_ID_ACCUM_DM_SPL,
-				spl_phase() == PHASE_TPL ? "dm tpl" : "dm_spl");
+				xpl_phase() == PHASE_TPL ? "dm tpl" : "dm_spl");
 		/* With CONFIG_SPL_OF_PLATDATA, bring in all devices */
 		ret = dm_init_and_scan(!CONFIG_IS_ENABLED(OF_PLATDATA));
 		bootstage_accum(BOOTSTAGE_ID_ACCUM_DM_SPL);
diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index fba4a439d3a..aa6d28fa333 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -35,7 +35,7 @@ For example::
    if (IS_ENABLED(CONFIG_XPL_BUILD))
            foo();
 
-   if (spl_phase() == PHASE_TPL)
+   if (xpl_phase() == PHASE_TPL)
            bar();
 
 The building of xPL images can be enabled by CONFIG_SPL (etc.) options in
@@ -121,7 +121,7 @@ Further usages of U-Boot SPL comprise:
 Checking the boot phase
 -----------------------
 
-Use `spl_phase()` to find the current U-Boot phase, e.g. `PHASE_SPL`. You can
+Use `xpl_phase()` to find the current U-Boot phase, e.g. `PHASE_SPL`. You can
 also find the previous and next phase and get the phase name.
 
 
diff --git a/drivers/i2c/designware_i2c_pci.c b/drivers/i2c/designware_i2c_pci.c
index 11c98672265..c21c412231c 100644
--- a/drivers/i2c/designware_i2c_pci.c
+++ b/drivers/i2c/designware_i2c_pci.c
@@ -37,7 +37,7 @@ static int designware_i2c_pci_of_to_plat(struct udevice *dev)
 {
 	struct dw_i2c *priv = dev_get_priv(dev);
 
-	if (spl_phase() < PHASE_SPL) {
+	if (xpl_phase() < PHASE_SPL) {
 		u32 base;
 		int ret;
 
@@ -53,7 +53,7 @@ static int designware_i2c_pci_of_to_plat(struct udevice *dev)
 				      PCI_COMMAND_MASTER);
 	}
 
-	if (spl_phase() < PHASE_BOARD_F) {
+	if (xpl_phase() < PHASE_BOARD_F) {
 		/* Handle early, fixed mapping into a different address space */
 		priv->regs = (struct i2c_regs *)dm_pci_read_bar32(dev, 0);
 	} else {
diff --git a/drivers/misc/p2sb-uclass.c b/drivers/misc/p2sb-uclass.c
index 016c8073378..d7ce0383ac9 100644
--- a/drivers/misc/p2sb-uclass.c
+++ b/drivers/misc/p2sb-uclass.c
@@ -198,7 +198,7 @@ static int p2sb_child_post_bind(struct udevice *dev)
 
 static int p2sb_post_bind(struct udevice *dev)
 {
-	if (spl_phase() > PHASE_TPL && !CONFIG_IS_ENABLED(OF_PLATDATA))
+	if (xpl_phase() > PHASE_TPL && !CONFIG_IS_ENABLED(OF_PLATDATA))
 		return dm_scan_fdt_dev(dev);
 
 	return 0;
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 6571e653049..59894d2430b 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -722,7 +722,7 @@ static bool pci_need_device_pre_reloc(struct udevice *bus, uint vendor,
 	u32 vendev;
 	int index;
 
-	if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(PCI_PNP))
+	if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(PCI_PNP))
 		return true;
 
 	for (index = 0;
@@ -798,7 +798,7 @@ static int pci_find_and_bind_driver(struct udevice *parent,
 			if (!(gd->flags & GD_FLG_RELOC) &&
 			    !(drv->flags & DM_FLAG_PRE_RELOC) &&
 			    (!CONFIG_IS_ENABLED(PCI_PNP) ||
-			     spl_phase() != PHASE_SPL))
+			     xpl_phase() != PHASE_SPL))
 				return log_msg_ret("pre", -EPERM);
 
 			/*
diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 78e5de937cd..2753df275ca 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -379,7 +379,7 @@ int vesa_setup_video(struct udevice *dev, int (*int15_handler)(void))
 	}
 
 	/* In U-Boot proper, collect the information added by SPL (see below) */
-	if (IS_ENABLED(CONFIG_SPL_VIDEO) && spl_phase() > PHASE_SPL &&
+	if (IS_ENABLED(CONFIG_SPL_VIDEO) && xpl_phase() > PHASE_SPL &&
 	    CONFIG_IS_ENABLED(BLOBLIST)) {
 		struct video_handoff *ho;
 
@@ -425,7 +425,7 @@ int vesa_setup_video(struct udevice *dev, int (*int15_handler)(void))
 	       mode_info.vesa.bits_per_pixel);
 
 	/* In SPL, store the information for use by U-Boot proper */
-	if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
+	if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
 		struct video_handoff *ho;
 
 		ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
diff --git a/drivers/pinctrl/intel/pinctrl.c b/drivers/pinctrl/intel/pinctrl.c
index 6cfe83a593a..19525f82a22 100644
--- a/drivers/pinctrl/intel/pinctrl.c
+++ b/drivers/pinctrl/intel/pinctrl.c
@@ -273,7 +273,7 @@ static int pinctrl_configure_itss(struct udevice *dev,
 	irq = pcr_read32(dev, PAD_CFG1_OFFSET(pad_cfg_offset));
 	irq &= PAD_CFG1_IRQ_MASK;
 	if (!irq) {
-		if (spl_phase() > PHASE_TPL)
+		if (xpl_phase() > PHASE_TPL)
 			log_err("GPIO %u doesn't support APIC routing\n",
 				cfg->pad);
 
@@ -315,7 +315,7 @@ static int pinctrl_pad_reset_config_override(const struct pad_community *comm,
 			return config_value;
 		}
 	}
-	if (spl_phase() > PHASE_TPL)
+	if (xpl_phase() > PHASE_TPL)
 		log_err("Logical-to-Chipset mapping not found\n");
 
 	return -ENOENT;
@@ -622,7 +622,7 @@ int intel_pinctrl_of_to_plat(struct udevice *dev,
 	struct intel_pinctrl_priv *priv = dev_get_priv(dev);
 
 	if (!comm) {
-		if (spl_phase() > PHASE_TPL)
+		if (xpl_phase() > PHASE_TPL)
 			log_err("Cannot find community for pid %d\n",
 				pplat->pid);
 		return -EDOM;
diff --git a/drivers/power/acpi_pmc/acpi-pmc-uclass.c b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
index c289cede15b..1e94104091e 100644
--- a/drivers/power/acpi_pmc/acpi-pmc-uclass.c
+++ b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
@@ -60,7 +60,7 @@ int pmc_gpe_init(struct udevice *dev)
 	 * are different and if they aren't, use the reset values.
 	 */
 	if (dw[0] == dw[1] || dw[1] == dw[2]) {
-		if (spl_phase() > PHASE_TPL)
+		if (xpl_phase() > PHASE_TPL)
 			log_info("PMC: Using default GPE route");
 		gpio_cfg = readl(upriv->gpe_cfg);
 		for (i = 0; i < upriv->gpe0_count; i++)
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index c3745f9445b..7b48af49af8 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -193,7 +193,7 @@ struct io_setting {
  */
 static bool phase_sdram_init(void)
 {
-	return spl_phase() == PHASE_TPL ||
+	return xpl_phase() == PHASE_TPL ||
 		(!IS_ENABLED(CONFIG_TPL) &&
 		 !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
 		 !spl_in_proper());
diff --git a/drivers/spi/ich.c b/drivers/spi/ich.c
index e48ca65fe72..2264ca83d66 100644
--- a/drivers/spi/ich.c
+++ b/drivers/spi/ich.c
@@ -779,7 +779,7 @@ static int ich_init_controller(struct udevice *dev,
 			       struct ich_spi_plat *plat,
 			       struct ich_spi_priv *ctlr)
 {
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		struct ich_spi_plat *plat = dev_get_plat(dev);
 		int ret;
 
@@ -867,7 +867,7 @@ static int ich_spi_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (spl_phase() == PHASE_TPL) {
+	if (xpl_phase() == PHASE_TPL) {
 		/* Cache the BIOS to speed things up */
 		ret = ich_cache_bios_region(dev);
 		if (ret)
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index d30b008bf9a..536ac727142 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -102,7 +102,7 @@ void sysreset_walk_halt(enum sysreset_t type)
 		mdelay(100);
 
 	/* Still no reset? Give up */
-	if (spl_phase() <= PHASE_SPL)
+	if (xpl_phase() <= PHASE_SPL)
 		log_err("no sysreset\n");
 	else
 		log_err("System reset not supported on this platform\n");
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index c435162d3f9..17a29817664 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -802,7 +802,7 @@ static int truetype_entry_save(struct udevice *dev, struct abuf *buf)
 	struct console_tt_store store;
 	const uint size = sizeof(store);
 
-	if (spl_phase() <= PHASE_SPL)
+	if (xpl_phase() <= PHASE_SPL)
 		return -ENOSYS;
 
 	/*
@@ -826,7 +826,7 @@ static int truetype_entry_restore(struct udevice *dev, struct abuf *buf)
 	struct console_tt_priv *priv = dev_get_priv(dev);
 	struct console_tt_store store;
 
-	if (spl_phase() <= PHASE_SPL)
+	if (xpl_phase() <= PHASE_SPL)
 		return -ENOSYS;
 
 	memcpy(&store, abuf_data(buf), sizeof(store));
@@ -853,7 +853,7 @@ static int truetype_set_cursor_visible(struct udevice *dev, bool visible,
 	uint out, val;
 	int ret;
 
-	if (spl_phase() <= PHASE_SPL)
+	if (xpl_phase() <= PHASE_SPL)
 		return -ENOSYS;
 
 	if (!visible)
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 41bb7647fda..9823673f817 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -128,7 +128,7 @@ int video_reserve(ulong *addrp)
 	struct udevice *dev;
 	ulong size;
 
-	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() == PHASE_BOARD_F)
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && xpl_phase() == PHASE_BOARD_F)
 		return 0;
 
 	gd->video_top = *addrp;
@@ -421,7 +421,7 @@ bool video_is_active(void)
 	struct udevice *dev;
 
 	/* Assume video to be active if SPL passed video hand-off to U-boot */
-	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL)
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && xpl_phase() > PHASE_SPL)
 		return true;
 
 	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
@@ -573,7 +573,7 @@ static int video_post_probe(struct udevice *dev)
 	 * NOTE:
 	 * This assumes that reserved video memory only uses a single framebuffer
 	 */
-	if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
+	if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
 		struct video_handoff *ho;
 
 		ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
diff --git a/include/spl.h b/include/spl.h
index 3447a429e87..079a38433a2 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -74,7 +74,7 @@ enum xpl_phase_t {
 };
 
 /**
- * spl_phase() - Find out the phase of U-Boot
+ * xpl_phase() - Find out the phase of U-Boot
  *
  * This can be used to avoid #ifdef logic and use if() instead.
  *
@@ -86,7 +86,7 @@ enum xpl_phase_t {
  *
  * but with this you can use:
  *
- *    if (spl_phase() == PHASE_TPL) {
+ *    if (xpl_phase() == PHASE_TPL) {
  *       ...
  *    }
  *
@@ -98,7 +98,7 @@ enum xpl_phase_t {
  *
  * but with this you can use:
  *
- *    if (spl_phase() == PHASE_SPL) {
+ *    if (xpl_phase() == PHASE_SPL) {
  *       ...
  *    }
  *
@@ -110,13 +110,13 @@ enum xpl_phase_t {
  *
  * but with this you can use:
  *
- *    if (spl_phase() == PHASE_BOARD_F) {
+ *    if (xpl_phase() == PHASE_BOARD_F) {
  *       ...
  *    }
  *
  * Return: U-Boot phase
  */
-static inline enum xpl_phase_t spl_phase(void)
+static inline enum xpl_phase_t xpl_phase(void)
 {
 #ifdef CONFIG_TPL_BUILD
 	return PHASE_TPL;
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 4199379c872..cdc2edbd61e 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -608,7 +608,7 @@ int fdtdec_get_chosen_node(const void *blob, const char *name)
 static int fdtdec_prepare_fdt(const void *blob)
 {
 	if (!blob || ((uintptr_t)blob & 3) || fdt_check_header(blob)) {
-		if (spl_phase() <= PHASE_SPL) {
+		if (xpl_phase() <= PHASE_SPL) {
 			puts("Missing DTB\n");
 		} else {
 			printf("No valid device tree binary found at %p\n",
diff --git a/lib/lmb.c b/lib/lmb.c
index 3ed570fb29b..380d92a6718 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -749,9 +749,9 @@ int lmb_init(void)
 	lmb_add_memory();
 
 	/* Reserve the U-Boot image region once U-Boot has relocated */
-	if (spl_phase() == PHASE_SPL)
+	if (xpl_phase() == PHASE_SPL)
 		lmb_reserve_common_spl();
-	else if (spl_phase() == PHASE_BOARD_R)
+	else if (xpl_phase() == PHASE_BOARD_R)
 		lmb_reserve_common((void *)gd->fdt_blob);
 
 	return 0;
diff --git a/lib/time.c b/lib/time.c
index 872f73d521e..d88edafb196 100644
--- a/lib/time.c
+++ b/lib/time.c
@@ -100,7 +100,7 @@ uint64_t notrace get_ticks(void)
 
 	ret = timer_get_count(gd->timer, &count);
 	if (ret) {
-		if (spl_phase() > PHASE_TPL)
+		if (xpl_phase() > PHASE_TPL)
 			panic("Could not read count from timer (err %d)\n",
 			      ret);
 		else
-- 
2.34.1

