Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A84C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB6484994;
	Mon,  6 Jul 2026 17:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="lkqGnJ7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBBE849F3; Mon,  6 Jul 2026 17:07:14 +0200 (CEST)
Received: from mail-wm2-x01.google.com (mail-wm2-x01.google.com
 [IPv6:2a00:1450:4864:31::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7BB84997
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b4e7be03so2614985e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783350431; x=1783955231; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3WIBKxrBSo2z3rlq6PZGtm/IU4NsNtg3BGbQ6M02Lmc=;
 b=lkqGnJ7ll2gDp93/1qPXg8fGbXfIsIm2CKwoFatgfQRMpbY4y08NVDZS+0i3rnZW3g
 /Qnc7p2d045qJbLMIne04HFwasfFDaNdn+GOjJScP6OXcY9S/NusTGeRNOSFAtI+Lllo
 OOOTf5omPpIRdtn5CvQn+SE8BCsXSlSMm9uVPNM69g7OWAV6FjMBGZHmc6zgVz5jNswn
 +zOzvGdxaXkDDC7372ZyjtkbDRDA8CbL70HcU471L7j89wK22Apy328DGOmhgNlGSDRl
 JE+byP8ZF3u3IbyZFbBYP+zWlHfuYHqR1OtTqnTB7LNrU0Ls0XXoP9utCqCHwWT5d1T0
 tMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350431; x=1783955231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3WIBKxrBSo2z3rlq6PZGtm/IU4NsNtg3BGbQ6M02Lmc=;
 b=NvYkFNbqZ9yYT6x+ORTG0olFyNs0qTz9/VTc5ROknHoI3cKiclIRBQM7aCmqlErtb0
 nQUXNHgPDd3Hdq/UH0QZm7qimWnpq0pQhFsjREkyylpxYyzYjs8nt8WgVYGICAv3GmVZ
 2RZjJQigYnRbJRVGRGizgbO77y+ACCj1U+N3iex8khprXBXPthunhZG5OLmxWSJ1+gM+
 N7redqrj8M/XYhczgI0il4Iu3k3pnyYy75zMiEPgtbGdsaFhnWoH3kpVZpst9yoWL27u
 3V/fIwngmblMAzA7GF9R9HrKF2JUx+t4Zp5p0EvsJj+/qKaucqvDydHOaSC/HrrOhZSf
 O1Ow==
X-Gm-Message-State: AOJu0YyHIvFJ65f6tHrqQCW/155txRU9pBvF014JmtR2eBLW2F9RD0zM
 RmX1ov8g5sHRuQrM1wFfkE2S+460RAOfhnMheVlzjtXPdrVEw/BhFKe21mkoF9A3sWI=
X-Gm-Gg: AfdE7cnjBotC63VPd+EIMNBxh2JG0+TB4twcI/4E7k4q5YoF4disurP7FrEcsa9W0OL
 CgLiIbaQtJydnCWO+CS6e2U8ZX1nuUlIg+1T/ytys5NLnCr8XaGQT3JPR2rC82PWoU/l+9BhcTM
 9kKh6gGNufjD7TcmNu8hYEAthxEVEdX45XzlZd9ocj6oDrdNSr8jSdbzl0lAFdZLbcOq0I6Bk7A
 DsNXT3ExNPqQBEW+AIZzzOw15FahPCnIO704GN7Jl0OrEUJF+A/AlFWsSpu+7ghkX8pt23pISdV
 3yUPM+hgjRLRriTp97KxS0Oe3OwtfbdYAUkQ9ckOYhl62vsJ5i/toYkkCUXBX8JLhbDQI9XZXpS
 6vat/HvQ54PkvOKnwPV0IHZtEyeAOsL515F5Yuo3exzmfCiA7SS8ZVkWAPUoMRVcsAKxUCVL6I7
 xzlm4Ty7cyZqMwJFdXGNbEzNEFHIIwXLF9KRYFlU+XnGNu0zKjVr0gOjM6
X-Received: by 2002:a05:600c:4f81:b0:493:bb4d:4dfe with SMTP id
 5b1f17b1804b1-493df08c88fmr9937425e9.23.1783350430788; 
 Mon, 06 Jul 2026 08:07:10 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm281421265e9.11.2026.07.06.08.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:07:10 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 06 Jul 2026 17:06:45 +0200
Subject: [PATCH 4/4] test: bootstd: add firmware-FDT source tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ccaione-upstream-ebbr-v1-4-e742cdd6abe5@baylibre.com>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

Add sandbox coverage for firmware_fdt_load(): a python fixture builds
mmc11.img, a GPT disk with A/B 'firmware' partitions whose first
partition carries a FAT filesystem holding the FIT manifest (fdt.itb:
a base DTB plus one overlay, with a default configuration that applies
the overlay and a base-only 'conf-base' configuration).

The tests cover the happy path (default configuration, packed size,
both fixture properties visible), configuration selection via
'fw_fdt_config', and the fail-closed semantics: a missing pinned
partition and a selector naming a configuration the manifest does not
ship are fatal errors rather than -ENOENT, an unresolvable
'firmware-fdt-source' phandle is -EINVAL, and only a genuinely absent
source returns -ENOENT.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/sandbox/dts/test.dts |  24 ++++
 configs/sandbox_defconfig |   1 +
 test/boot/Makefile        |   1 +
 test/boot/firmware_fdt.c  | 292 ++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 110 +++++++++++++++++
 5 files changed, 428 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..97199d1812e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -49,6 +49,7 @@
 		mmc8 = "/mmc8";
 		mmc9 = "/mmc9";
 		mmc10 = "/mmc10";
+		mmc11 = "/mmc11";
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
@@ -122,6 +123,14 @@
 		filename-prefixes = "/", "/boot/";
 		bootdev-order = "mmc2", "mmc1";
 
+		/*
+		 * Not read by U-Boot: the firmware_fdt tests copy this into a
+		 * live 'firmware-fdt-source' property at runtime (and delete
+		 * it afterwards), so the source stays unconfigured for every
+		 * other test. It also keeps a phandle emitted for &fw_fdt.
+		 */
+		test-fw-fdt-source = <&fw_fdt>;
+
 		extlinux {
 			compatible = "u-boot,extlinux";
 		};
@@ -1348,6 +1357,21 @@
 		filename = "mmc10.img";
 	};
 
+	/* This is used for firmware-FDT (firmware_fdt) tests */
+	mmc11 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc11.img";
+
+		fw_fdt: firmware-fdt {
+			compatible = "u-boot,firmware-fdt-block";
+			partition-type-uuid =
+				"384e979b-eb76-435a-a3a6-1a071dbad91d";
+			partition-name = "firmware";
+			filename = "fdt.itb";
+		};
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..2d54de1c746 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -25,6 +25,7 @@ CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_BOOTSTD_FIRMWARE_FDT=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..90704e6cbbc 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
+obj-$(CONFIG_BOOTSTD_FIRMWARE_FDT) += firmware_fdt.o
 obj-$(CONFIG_FIT) += image.o
 
 ifdef CONFIG_VIDEO_SANDBOX_SDL
diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
new file mode 100644
index 00000000000..ef137f82648
--- /dev/null
+++ b/test/boot/firmware_fdt.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the firmware-owned devicetree source (firmware_fdt_load()).
+ *
+ * Uses a sandbox mmc image (mmc11) carrying a GPT 'firmware' partition with
+ * a FAT filesystem holding the FIT manifest (fdt.itb: a base DTB and one
+ * overlay, with two configurations). The image is built by
+ * setup_firmware_fdt_image() in test/py/tests/test_ut.py.
+ *
+ * The shared test.dts deliberately does NOT configure a firmware-FDT source:
+ * a configured source turns the fail-closed semantics on for every EFI
+ * launch path, which would break the other sandbox EFI tests. Instead the
+ * bootstd node carries an inert 'test-fw-fdt-source' phandle, which these
+ * tests copy into a live 'firmware-fdt-source' property for their duration
+ * and delete again afterwards.
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <dm/root.h>
+#include <linux/libfdt.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define FWFDT_PROP	"firmware-fdt-source"
+#define FWFDT_TEST_PROP	"test-fw-fdt-source"
+
+static ofnode fwfdt_bootstd_node(void)
+{
+	return ofnode_by_compatible(ofnode_null(), "u-boot,boot-std");
+}
+
+/* Bind the (disabled) mmc node that owns the firmware-FDT image */
+static int fwfdt_bind_mmc(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	ofnode root, node;
+
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc11");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+/*
+ * Configure the firmware-FDT source for this test: copy the inert
+ * 'test-fw-fdt-source' phandle into the property firmware_fdt_load() reads.
+ */
+static int fwfdt_configure(struct unit_test_state *uts)
+{
+	const void *prop;
+	ofnode bootstd;
+	fdt32_t val;
+	int len;
+
+	bootstd = fwfdt_bootstd_node();
+	ut_assert(ofnode_valid(bootstd));
+
+	prop = ofnode_get_property(bootstd, FWFDT_TEST_PROP, &len);
+	ut_assertnonnull(prop);
+	ut_asserteq(sizeof(val), len);
+
+	/*
+	 * Copy the value out first: on the flat tree, inserting the new
+	 * property shifts the blob region the old property value lives in,
+	 * so passing the in-blob pointer straight to ofnode_write_prop()
+	 * would copy from the stale location.
+	 */
+	memcpy(&val, prop, sizeof(val));
+	ut_assertok(ofnode_write_prop(bootstd, FWFDT_PROP, &val, sizeof(val),
+				      true));
+
+	return 0;
+}
+
+/* Undo fwfdt_configure() and clear any environment the tests use */
+static int fwfdt_deconfigure(struct unit_test_state *uts)
+{
+	ofnode bootstd;
+
+	bootstd = fwfdt_bootstd_node();
+	ut_assert(ofnode_valid(bootstd));
+	if (ofnode_get_property(bootstd, FWFDT_PROP, NULL))
+		ut_assertok(ofnode_delete_prop(bootstd, FWFDT_PROP));
+
+	env_set("boot_dtb", NULL);
+	env_set("fw_fdt_config", NULL);
+
+	return 0;
+}
+
+/* Happy path: the manifest's default configuration applies base + overlay */
+static int firmware_fdt_test_load(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	/*
+	 * Configure before binding: on the flat tree, inserting the property
+	 * shifts every later node offset, so a device bound beforehand would
+	 * no longer match its (shifted) devicetree node.
+	 */
+	ut_assertok(fwfdt_configure(uts));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(firmware_fdt_load(&fw));
+
+	ut_asserteq_str("fdt.itb", fw.name);
+	ut_assert(fw.size > 0);
+
+	fdt = fw.fdt;
+	ut_assertok(fdt_check_header(fdt));
+	/* the size reports the packed devicetree, not a padded buffer */
+	ut_asserteq(fw.size, fdt_totalsize(fdt));
+	/* the base property is present... */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* ...and the overlay was applied on top */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+	ut_assertnull(fw.fdt);
+
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_load, UTF_DM | UTF_SCAN_FDT);
+
+/* 'fw_fdt_config' selects another configuration the manifest ships */
+static int firmware_fdt_test_select(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	ut_assertok(fwfdt_configure(uts));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base"));
+	ut_assertok(firmware_fdt_load(&fw));
+
+	fdt = fw.fdt;
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* the base-only configuration applies no overlay */
+	ut_assertnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_select, UTF_DM | UTF_SCAN_FDT);
+
+/*
+ * A selector naming a configuration the manifest does not ship must be
+ * fatal: -ENOENT strictly means "no source configured", so the inner miss
+ * must not leak out and let the caller fall back (fail closed).
+ */
+static int firmware_fdt_test_bad_config(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-nonexistent"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_bad_config, UTF_DM | UTF_SCAN_FDT);
+
+/* Pinning a partition that does not exist is a hard error (fail closed) */
+static int firmware_fdt_test_no_part(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("boot_dtb", "9"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_no_part, UTF_DM | UTF_SCAN_FDT);
+
+/*
+ * Without the runtime injection no source is configured: -ENOENT, the only
+ * case where callers may fall back. This also proves the shared test.dts
+ * stays inert for every other sandbox test.
+ */
+static int firmware_fdt_test_no_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-ENOENT, firmware_fdt_load(&fw));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_no_source, UTF_DM | UTF_SCAN_FDT);
+
+/*
+ * A 'firmware-fdt-source' property whose phandle does not resolve is a
+ * broken configuration and must be fatal, not mistaken for "no source".
+ */
+static int firmware_fdt_test_bad_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode bootstd;
+	fdt32_t bad;
+
+	bootstd = fwfdt_bootstd_node();
+	ut_assert(ofnode_valid(bootstd));
+
+	bad = cpu_to_fdt32(0x7fffffff);
+	ut_assertok(ofnode_write_prop(bootstd, FWFDT_PROP, &bad, sizeof(bad),
+				      true));
+
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_bad_source, UTF_DM | UTF_SCAN_FDT);
+
+/* A manifest using external data is refused: it must be self-contained */
+static int firmware_fdt_test_external(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts));
+
+	node = ofnode_path("/mmc11/firmware-fdt");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-ext.itb"));
+
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(ofnode_write_string(node, "filename", "fdt.itb"));
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_external, UTF_DM | UTF_SCAN_FDT);
+
+/*
+ * When both partition-type-uuid and partition-name are configured, both
+ * must match: a name matching nothing must not fall back to whichever
+ * same-type (A/B) partition comes first.
+ */
+static int firmware_fdt_test_part_mismatch(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts));
+
+	node = ofnode_path("/mmc11/firmware-fdt");
+	ut_assert(ofnode_valid(node));
+	/* the type UUID matches both A/B partitions; this name matches none */
+	ut_assertok(ofnode_write_string(node, "partition-name", "nomatch"));
+
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(ofnode_write_string(node, "partition-name", "firmware"));
+	ut_assertok(fwfdt_deconfigure(uts));
+
+	return 0;
+}
+BOOTSTD_TEST(firmware_fdt_test_part_mismatch, UTF_DM | UTF_SCAN_FDT);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index dce5a37dd35..15c36fecafb 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -614,6 +614,115 @@ def setup_rauc_image(ubman):
     boot.cleanup()
     root.cleanup()
 
+def setup_firmware_fdt_image(ubman):
+    """Create mmc11.img for the firmware_fdt tests
+
+    A GPT disk with two firmware partitions (A/B) sharing a firmware type
+    UUID; partition 1 (label 'firmware') holds a FAT filesystem with the
+    FIT manifest (fdt.itb) carrying a base DTB and an overlay, with two
+    configurations: the default applies the overlay, 'conf-base' does not.
+    """
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+
+    mmc_dev = 11
+    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    fw_type = '384e979b-eb76-435a-a3a6-1a071dbad91d'
+    sect_size = 512
+
+    # Compile a tiny base DTB and an overlay, then wrap them in the manifest
+    src = os.path.join(ubman.config.persistent_data_dir, 'fwfdt')
+    mkdir_cond(src)
+    base_dtb = os.path.join(src, 'base.dtb')
+    ovl_dtbo = os.path.join(src, 'overlay.dtbo')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {base_dtb}',
+        stdin=b'/dts-v1/; / { compatible = "test,fw-fdt-base"; '
+              b'fw-base-prop = "base"; };')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {ovl_dtbo}',
+        stdin=b'/dts-v1/; /plugin/; &{/} { fw-overlay-prop = "applied"; };')
+
+    its = os.path.join(src, 'fdt.its')
+    with open(its, 'w', encoding='ascii') as outf:
+        outf.write(f'''
+/dts-v1/;
+/ {{
+\tdescription = "Firmware-owned OS devicetree";
+\t#address-cells = <1>;
+
+\timages {{
+\t\tfdt-base {{
+\t\t\tdata = /incbin/("{base_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t\tfdt-overlay {{
+\t\t\tdata = /incbin/("{ovl_dtbo}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t}};
+
+\tconfigurations {{
+\t\tdefault = "conf-overlay";
+\t\tconf-overlay {{
+\t\t\tfdt = "fdt-base", "fdt-overlay";
+\t\t}};
+\t\tconf-base {{
+\t\t\tfdt = "fdt-base";
+\t\t}};
+\t}};
+}};
+''')
+
+    fs_dir = os.path.join(src, 'fs')
+    mkdir_cond(fs_dir)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(
+        ubman, f'{mkimage} -f {its} {os.path.join(fs_dir, "fdt.itb")}')
+
+    # An external-data variant, which firmware_fdt_load() must refuse
+    utils.run_and_log(
+        ubman, f'{mkimage} -E -f {its} {os.path.join(fs_dir, "fdt-ext.itb")}')
+
+    fat_img = fs_helper.mk_fs(ubman.config, 'vfat', 1 << 20, 'fwfdt',
+                              src_dir=fs_dir)
+    with open(fat_img, 'rb') as inf:
+        fat_data = inf.read()
+
+    # GPT with two same-type firmware partitions; the FAT goes in partition 1
+    fat_sects = (len(fat_data) + sect_size - 1) // sect_size
+    utils.run_and_log(ubman, f'qemu-img create {fname} 8M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+    ptr = 40
+    for num, label in ((1, 'firmware'), (2, 'firmware_b')):
+        utils.run_and_log(
+            ubman,
+            f'cgpt add -i {num} -b {ptr} -s {fat_sects} -t {fw_type} '
+            f'-l {label} {fname}')
+        ptr += fat_sects
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    # Splice the FAT image into partition 1
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+    start = parts[1].start * sect_size
+    disk_data = disk_data[:start] + fat_data + disk_data[start + len(fat_data):]
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    return fname
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -626,6 +735,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_android_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
+    setup_firmware_fdt_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()

-- 
2.55.0

