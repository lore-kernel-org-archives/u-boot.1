Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B427CD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 02:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA344838BB;
	Fri, 12 Jun 2026 04:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l730pUXJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Tuxi3HjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2648488A; Fri, 12 Jun 2026 04:06:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948A0838BB
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 04:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gc2tW1m2Fz9v5P;
 Fri, 12 Jun 2026 04:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781229971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZU5kcNV7iALTOBSyOpqJrhJkprALH9RrOe2vVq+gG6g=;
 b=l730pUXJkQv4VE1GScjuqVVNO/uKdoBiNgg2ul5OlcS0qYwVTUbHk/PbkQ/S3nvI3E/PbE
 XUNWpAygjEMcuxNA1mGv9hUAg8xwXAOEOku83yKaUmVxXCQJlzyP3YpsYlyhYQOjGRCnCS
 0uNJYg/Jzkt/0QSH0vTsfAtYVL6GSlBUHbtF9jdshtQMyPfsIKFh9D18BQfNjUvx0xkj2D
 gUbQdFD9XbSL6wSIPvgVeu8MQR282NwhoNlo7CUtVqG1hx3sG12Ganiekv/3oLQvyLTqat
 jzMtnwJpcC+5xtqX1LsQIWjjh0i5+kpWvqo3KTX6CXA/oasciuGS/PfisUwudQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Tuxi3HjB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781229969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZU5kcNV7iALTOBSyOpqJrhJkprALH9RrOe2vVq+gG6g=;
 b=Tuxi3HjButvGW5WJUTMjj/rLFe0w6cqjZ+xixrl/+kPQQ1b9cU+Yk3F3TlWRHUri4ZQsdk
 7eC1fDCIwJ3etenyZdGqxfSTy+xd3/lWZgZpIpUwHiUMhyn+r9InWkWf7gIuTgVU0M6jCt
 TaacX2ZlbCQrGo4xJtoeg4dBNYCeQvwJOoeD7EmsA+hU0gHhZbmH3Imb95gjUCxD2+NCJ2
 o4jfePYqVcxs67uNIkZmrzQW0lW6uKPNgfoNXf8p3AL70f+6d9vywydR0BWsbA6lU1zhwM
 4PqkcHOdn0Q5CIL++wkGYkxiet2otNQxBmK9wKiiWaV3bkW+N8flf3nIniV0Cw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] treewide: Staticize and constify acpi ops
Date: Fri, 12 Jun 2026 04:05:38 +0200
Message-ID: <20260612020606.284001-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qy6sfrfk784y46xy3mesyysauago9d7n
X-MBO-RS-ID: 51eab79d4cb0ff550d2
X-Rspamd-Queue-Id: 4gc2tW1m2Fz9v5P
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

Set the acpi_ops structure as static const where applicable. The
The structure is not accessible from outside of drivers and is not
going to be modified at runtime. The structure may be unused in a
couple of drivers depending on their configuration, mark those
sites with __maybe_unused .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/lib/gic-v2.c                    | 2 +-
 arch/arm/lib/gic-v3-its.c                | 2 +-
 arch/x86/cpu/apollolake/cpu.c            | 4 +---
 arch/x86/cpu/apollolake/hostbridge.c     | 2 +-
 arch/x86/cpu/apollolake/lpc.c            | 2 +-
 arch/x86/cpu/intel_common/generic_wifi.c | 2 +-
 arch/x86/lib/fsp/fsp_graphics.c          | 2 +-
 board/google/chromebook_coral/coral.c    | 2 +-
 drivers/core/acpi.c                      | 4 ++--
 drivers/core/root.c                      | 2 +-
 drivers/cpu/armv8_cpu.c                  | 2 +-
 drivers/cpu/bcm283x_cpu.c                | 2 +-
 drivers/gpio/sandbox.c                   | 4 ++--
 drivers/i2c/designware_i2c_pci.c         | 2 +-
 drivers/mmc/pci_mmc.c                    | 4 ++--
 drivers/rtc/sandbox_rtc.c                | 2 +-
 drivers/sound/da7219.c                   | 2 +-
 drivers/sound/max98357a.c                | 2 +-
 drivers/tpm/cr50_i2c.c                   | 2 +-
 include/dm/device.h                      | 2 +-
 test/dm/acpi.c                           | 2 +-
 21 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/arm/lib/gic-v2.c b/arch/arm/lib/gic-v2.c
index b70434a45d4..378bdb54c89 100644
--- a/arch/arm/lib/gic-v2.c
+++ b/arch/arm/lib/gic-v2.c
@@ -38,7 +38,7 @@ static int acpi_gicv2_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
-static struct acpi_ops gic_v2_acpi_ops = {
+static const struct acpi_ops gic_v2_acpi_ops = {
 	.fill_madt	= acpi_gicv2_fill_madt,
 };
 #endif
diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index d11a1ea436e..064b93b2aa1 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -197,7 +197,7 @@ static int acpi_gicv3_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
-struct acpi_ops gic_v3_acpi_ops = {
+static const struct acpi_ops gic_v3_acpi_ops = {
 	.fill_madt	= acpi_gicv3_fill_madt,
 };
 #endif
diff --git a/arch/x86/cpu/apollolake/cpu.c b/arch/x86/cpu/apollolake/cpu.c
index f480bb1d8c3..d1f592ec57e 100644
--- a/arch/x86/cpu/apollolake/cpu.c
+++ b/arch/x86/cpu/apollolake/cpu.c
@@ -171,11 +171,9 @@ static int cpu_apl_probe(struct udevice *dev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPIGEN
-struct acpi_ops apl_cpu_acpi_ops = {
+static const struct acpi_ops __maybe_unused apl_cpu_acpi_ops = {
 	.fill_ssdt	= acpi_cpu_fill_ssdt,
 };
-#endif
 
 static const struct cpu_ops cpu_x86_apl_ops = {
 	.get_desc	= cpu_x86_get_desc,
diff --git a/arch/x86/cpu/apollolake/hostbridge.c b/arch/x86/cpu/apollolake/hostbridge.c
index 284f16cfd91..360d091121c 100644
--- a/arch/x86/cpu/apollolake/hostbridge.c
+++ b/arch/x86/cpu/apollolake/hostbridge.c
@@ -366,7 +366,7 @@ ulong sa_get_tseg_base(struct udevice *dev)
 	return sa_read_reg(dev, TSEG);
 }
 
-struct acpi_ops apl_hostbridge_acpi_ops = {
+static const struct acpi_ops __maybe_unused apl_hostbridge_acpi_ops = {
 	.get_name	= apl_acpi_hb_get_name,
 #if CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)
 	.write_tables	= apl_acpi_hb_write_tables,
diff --git a/arch/x86/cpu/apollolake/lpc.c b/arch/x86/cpu/apollolake/lpc.c
index f34c199bf73..008c4dc0037 100644
--- a/arch/x86/cpu/apollolake/lpc.c
+++ b/arch/x86/cpu/apollolake/lpc.c
@@ -119,7 +119,7 @@ static int apl_acpi_lpc_get_name(const struct udevice *dev, char *out_name)
 	return acpi_copy_name(out_name, "LPCB");
 }
 
-struct acpi_ops apl_lpc_acpi_ops = {
+static const struct acpi_ops __maybe_unused apl_lpc_acpi_ops = {
 	.get_name	= apl_acpi_lpc_get_name,
 #ifdef CONFIG_GENERATE_ACPI_TABLE
 	.write_tables	= intel_southbridge_write_acpi_tables,
diff --git a/arch/x86/cpu/intel_common/generic_wifi.c b/arch/x86/cpu/intel_common/generic_wifi.c
index 75fa4e01d8a..1a24c10ab0b 100644
--- a/arch/x86/cpu/intel_common/generic_wifi.c
+++ b/arch/x86/cpu/intel_common/generic_wifi.c
@@ -102,7 +102,7 @@ static int intel_wifi_acpi_fill_ssdt(const struct udevice *dev,
 	return 0;
 }
 
-struct acpi_ops wifi_acpi_ops = {
+static const struct acpi_ops wifi_acpi_ops = {
 	.fill_ssdt	= intel_wifi_acpi_fill_ssdt,
 };
 
diff --git a/arch/x86/lib/fsp/fsp_graphics.c b/arch/x86/lib/fsp/fsp_graphics.c
index ad25020086c..d425e80760b 100644
--- a/arch/x86/lib/fsp/fsp_graphics.c
+++ b/arch/x86/lib/fsp/fsp_graphics.c
@@ -150,7 +150,7 @@ static int fsp_video_acpi_write_tables(const struct udevice *dev,
 }
 #endif
 
-struct acpi_ops fsp_video_acpi_ops = {
+static const struct acpi_ops __maybe_unused fsp_video_acpi_ops = {
 #ifdef CONFIG_INTEL_GMA_ACPI
 	.write_tables	= fsp_video_acpi_write_tables,
 #endif
diff --git a/board/google/chromebook_coral/coral.c b/board/google/chromebook_coral/coral.c
index b4053fa097d..2bb54d59bb8 100644
--- a/board/google/chromebook_coral/coral.c
+++ b/board/google/chromebook_coral/coral.c
@@ -293,7 +293,7 @@ static int coral_write_acpi_tables(const struct udevice *dev,
 	return 0;
 }
 
-struct acpi_ops coral_acpi_ops = {
+static const struct acpi_ops __maybe_unused coral_acpi_ops = {
 	.write_tables	= coral_write_acpi_tables,
 	.inject_dsdt	= chromeos_acpi_gpio_generate,
 };
diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
index 6a431171c8d..284fb70b036 100644
--- a/drivers/core/acpi.c
+++ b/drivers/core/acpi.c
@@ -87,7 +87,7 @@ int acpi_copy_name(char *out_name, const char *name)
 
 int acpi_get_name(const struct udevice *dev, char *out_name)
 {
-	struct acpi_ops *aops;
+	const struct acpi_ops *aops;
 	const char *name;
 	int ret;
 
@@ -275,7 +275,7 @@ static int sort_acpi_item_type(struct acpi_ctx *ctx, void *start,
 
 acpi_method acpi_get_method(struct udevice *dev, enum method_t method)
 {
-	struct acpi_ops *aops;
+	const struct acpi_ops *aops;
 
 	aops = device_get_acpi_ops(dev);
 	if (aops) {
diff --git a/drivers/core/root.c b/drivers/core/root.c
index 1f32f33b295..2aa16d59b69 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -459,7 +459,7 @@ static int root_acpi_get_name(const struct udevice *dev, char *out_name)
 	return acpi_copy_name(out_name, "\\_SB");
 }
 
-struct acpi_ops root_acpi_ops = {
+static const struct acpi_ops root_acpi_ops = {
 	.get_name	= root_acpi_get_name,
 };
 #endif
diff --git a/drivers/cpu/armv8_cpu.c b/drivers/cpu/armv8_cpu.c
index ed87841b723..337661c23a8 100644
--- a/drivers/cpu/armv8_cpu.c
+++ b/drivers/cpu/armv8_cpu.c
@@ -124,7 +124,7 @@ int armv8_cpu_fill_madt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
-static struct acpi_ops armv8_cpu_acpi_ops = {
+static const struct acpi_ops armv8_cpu_acpi_ops = {
 	.fill_ssdt	= armv8_cpu_fill_ssdt,
 	.fill_madt	= armv8_cpu_fill_madt,
 };
diff --git a/drivers/cpu/bcm283x_cpu.c b/drivers/cpu/bcm283x_cpu.c
index ad638cd8fff..43e74d1811b 100644
--- a/drivers/cpu/bcm283x_cpu.c
+++ b/drivers/cpu/bcm283x_cpu.c
@@ -193,7 +193,7 @@ static int bcm_cpu_probe(struct udevice *dev)
 	return ret;
 }
 
-struct acpi_ops bcm283x_cpu_acpi_ops = {
+static const struct acpi_ops __maybe_unused bcm283x_cpu_acpi_ops = {
 	.fill_ssdt	= armv8_cpu_fill_ssdt,
 	.fill_madt	= armv8_cpu_fill_madt,
 };
diff --git a/drivers/gpio/sandbox.c b/drivers/gpio/sandbox.c
index e8f50d815d7..76aff0ed5aa 100644
--- a/drivers/gpio/sandbox.c
+++ b/drivers/gpio/sandbox.c
@@ -306,7 +306,7 @@ static int sb_gpio_get_name(const struct udevice *dev, char *out_name)
 	return acpi_copy_name(out_name, "GPIO");
 }
 
-struct acpi_ops gpio_sandbox_acpi_ops = {
+static const struct acpi_ops gpio_sandbox_acpi_ops = {
 	.get_name	= sb_gpio_get_name,
 };
 #endif /* ACPIGEN */
@@ -568,7 +568,7 @@ static struct pinctrl_ops sandbox_pinctrl_gpio_ops = {
 };
 
 #if CONFIG_IS_ENABLED(ACPIGEN)
-struct acpi_ops pinctrl_sandbox_acpi_ops = {
+static const struct acpi_ops pinctrl_sandbox_acpi_ops = {
 	.get_name	= sb_pinctrl_get_name,
 };
 #endif
diff --git a/drivers/i2c/designware_i2c_pci.c b/drivers/i2c/designware_i2c_pci.c
index ad4122c2abd..db2706fdb6e 100644
--- a/drivers/i2c/designware_i2c_pci.c
+++ b/drivers/i2c/designware_i2c_pci.c
@@ -168,7 +168,7 @@ static int dw_i2c_acpi_fill_ssdt(const struct udevice *dev,
 	return 0;
 }
 
-static struct acpi_ops dw_i2c_acpi_ops = {
+static const struct acpi_ops dw_i2c_acpi_ops = {
 	.fill_ssdt	= dw_i2c_acpi_fill_ssdt,
 };
 
diff --git a/drivers/mmc/pci_mmc.c b/drivers/mmc/pci_mmc.c
index d446c55f72b..82e393fd9d6 100644
--- a/drivers/mmc/pci_mmc.c
+++ b/drivers/mmc/pci_mmc.c
@@ -137,11 +137,11 @@ static int pci_mmc_acpi_fill_ssdt(const struct udevice *dev,
 	return 0;
 }
 
-struct acpi_ops pci_mmc_acpi_ops = {
 #ifdef CONFIG_ACPIGEN
+static const struct acpi_ops pci_mmc_acpi_ops = {
 	.fill_ssdt	= pci_mmc_acpi_fill_ssdt,
-#endif
 };
+#endif
 
 static const struct udevice_id pci_mmc_match[] = {
 	{ .compatible = "intel,apl-sd", .data = TYPE_SD },
diff --git a/drivers/rtc/sandbox_rtc.c b/drivers/rtc/sandbox_rtc.c
index 4404501c2f6..1ade5d50b23 100644
--- a/drivers/rtc/sandbox_rtc.c
+++ b/drivers/rtc/sandbox_rtc.c
@@ -73,7 +73,7 @@ static int sandbox_rtc_get_name(const struct udevice *dev, char *out_name)
 	return acpi_copy_name(out_name, "RTCC");
 }
 
-struct acpi_ops sandbox_rtc_acpi_ops = {
+static const struct acpi_ops sandbox_rtc_acpi_ops = {
 	.get_name	= sandbox_rtc_get_name,
 };
 #endif
diff --git a/drivers/sound/da7219.c b/drivers/sound/da7219.c
index 5b9b3f65263..d1d03ae91d4 100644
--- a/drivers/sound/da7219.c
+++ b/drivers/sound/da7219.c
@@ -170,7 +170,7 @@ static int da7219_acpi_setup_nhlt(const struct udevice *dev,
 }
 #endif
 
-struct acpi_ops da7219_acpi_ops = {
+static const struct acpi_ops da7219_acpi_ops = {
 #ifdef CONFIG_ACPIGEN
 	.fill_ssdt	= da7219_acpi_fill_ssdt,
 #ifdef CONFIG_X86
diff --git a/drivers/sound/max98357a.c b/drivers/sound/max98357a.c
index da56ffdd6bb..47978d4fe27 100644
--- a/drivers/sound/max98357a.c
+++ b/drivers/sound/max98357a.c
@@ -136,7 +136,7 @@ static int max98357a_acpi_setup_nhlt(const struct udevice *dev,
 }
 #endif
 
-struct acpi_ops max98357a_acpi_ops = {
+static const struct acpi_ops max98357a_acpi_ops = {
 #ifdef CONFIG_ACPIGEN
 	.fill_ssdt	= max98357a_acpi_fill_ssdt,
 #ifdef CONFIG_X86
diff --git a/drivers/tpm/cr50_i2c.c b/drivers/tpm/cr50_i2c.c
index 14a94f8d4a8..46805eaa013 100644
--- a/drivers/tpm/cr50_i2c.c
+++ b/drivers/tpm/cr50_i2c.c
@@ -889,7 +889,7 @@ static int cr50_i2c_probe(struct udevice *dev)
 	return 0;
 }
 
-struct acpi_ops cr50_acpi_ops = {
+static const struct acpi_ops cr50_acpi_ops = {
 	.fill_ssdt	= cr50_acpi_fill_ssdt,
 };
 
diff --git a/include/dm/device.h b/include/dm/device.h
index 7bcf6df2892..5d700888503 100644
--- a/include/dm/device.h
+++ b/include/dm/device.h
@@ -388,7 +388,7 @@ struct driver {
 	const void *ops;	/* driver-specific operations */
 	uint32_t flags;
 #if CONFIG_IS_ENABLED(ACPIGEN)
-	struct acpi_ops *acpi_ops;
+	const struct acpi_ops *acpi_ops;
 #endif
 };
 
diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index 2de7983f9ae..293ea0274b5 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -136,7 +136,7 @@ static int testacpi_inject_dsdt(const struct udevice *dev, struct acpi_ctx *ctx)
 	return 0;
 }
 
-struct acpi_ops testacpi_ops = {
+static const struct acpi_ops testacpi_ops = {
 	.get_name	= testacpi_get_name,
 	.write_tables	= testacpi_write_tables,
 	.fill_madt	= testacpi_fill_madt,
-- 
2.53.0

