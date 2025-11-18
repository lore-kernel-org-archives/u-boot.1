Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433EFCF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D0D83A94;
	Wed, 19 Nov 2025 00:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cnAUEpTq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nbuBRU87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC1583AEF; Wed, 19 Nov 2025 00:20:55 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 327E283946
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dB0wN5d7pz9tLh;
 Wed, 19 Nov 2025 00:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763508052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S9QUdNZjrplgRMTbQM/4I2o1LEPmh95AyGvS0Q5bbN8=;
 b=cnAUEpTq1PAPjNfy06ORTEcIveckj/on2emaHdl+/GFKhUv181r53z1kGKQUes6vklohnl
 lXLodGAudF/ydZN+seWZJggN3nmnATbaoTNQRCkbVSJ/xHLw6YJ9SYqDY+8WaG70yo50I4
 wvijCYA4XuWMZzat7wt7W4DnlrkMk9f5BhTko2JR9cXi11U0fS/KT3GFPZzMR6GZ17eLGO
 KI8xgvh7Gukt53FgkCAOSaNNAThsSChIXwpkUSyOX9EscjPpsqraXxUWUvnTDDv9s8JJ1I
 T5ibFyIM0ya9Uw4j9trirTanWFjqNlpAyrl/bwvnXvmYzI4evbHPHB3sUHwZgQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nbuBRU87;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763508050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S9QUdNZjrplgRMTbQM/4I2o1LEPmh95AyGvS0Q5bbN8=;
 b=nbuBRU873/cCP/ZT1+jnXN9N1q6LJE+eVha9i86NvfciMJcdnEws2ZZRbYayxcSjAuWPro
 4C8haj29leKQ7QXra1eq9mTB+WYPZ+cdCRpSoPQArlTqoseH3HZiKe4RbUrBPygLW76QVv
 I0h+nI6/2h9C/YEe9cyOxwxKZQdjyj677IL8OhtALjleapuwkjqmkhI3Ib9x3aiJL1SSza
 WnLayeDczYGmvCI/DA2389vnI27MT4QVe0t+3r0ZkK1u8sTMaBrbp8dmOyjrC1vPrlRML8
 XFMU0pNAZw4ydEsCCm3r/dO4WepsnCRm86RJRHQ25U5+hkV+aa31GeXA+ESkng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
Date: Wed, 19 Nov 2025 00:20:00 +0100
Message-ID: <20251118232045.578034-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5ad3db3f6366e22fd58
X-MBO-RS-META: mpz67m3cj3c9r68jz9r4ig95jazqpm77
X-Rspamd-Queue-Id: 4dB0wN5d7pz9tLh
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

Introduce two new parameters to be used with mkimage -f auto to bundle
TEE image into fitImage, using auto-generated fitImage. Add -z to specify
TEE file name and -Z to specify TEE load and entry point address. This is
meant to be used with systems which boot all of TEE, Linux and its DT from
a single fitImage, all booted by U-Boot.

Example invocation:
"
$ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
          -d arch/arm/boot/zImage \
          -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
          -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
	  -Z 0xde000000 \
          /path/to/output/fitImage
"

Documentation update and test are also included, the test validates
both positive and negative test cases, where fitImage does not include
TEE and does include TEE blobs.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "Carlos López" <carlos.lopezr4096@gmail.com>
Cc: Aristo Chen <jj251510319013@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de
Cc: u-boot@dh-electronics.com
---
 doc/mkimage.1                         |  12 +++
 include/image.h                       |   1 +
 test/py/tests/test_fit_auto_signed.py | 110 +++++++++++++++++++++++---
 tools/fit_image.c                     |  55 ++++++++++++-
 tools/imagetool.h                     |   2 +
 tools/mkimage.c                       |  17 +++-
 6 files changed, 185 insertions(+), 12 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index c705218d345..c87003a6c0a 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -251,6 +251,18 @@ Append TFA BL31 file to the image.
 .B \-\-tfa-bl31-addr
 Set TFA BL31 file load and entry point address.
 .
+.TP
+.B \-z
+.TQ
+.B \-\-optee-file
+Append OPTEE file to the image.
+.
+.TP
+.B \-Z
+.TQ
+.B \-\-optee-addr
+Set OPTEE file load and entry point address.
+.
 .SS Options for creating FIT images
 .
 .TP
diff --git a/include/image.h b/include/image.h
index 9a1c828416d..d543c6cf254 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1105,6 +1105,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_SCRIPT_PROP		"script"
 #define FIT_PHASE_PROP		"phase"
 #define FIT_TFA_BL31_PROP	"tfa-bl31"
+#define FIT_TEE_PROP		"tee"
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index 0b5dbd5401c..cb8bd519fd9 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -117,23 +117,31 @@ class SignedFitHelper(object):
             algo = self.__fdt_get_string(f'{node}/signature', 'algo')
             assert algo == sign_algo + "\n", "Missing expected signature algo!"
 
-    def check_fit_loadables(self, present):
+    def check_fit_loadables(self, bl31present, teepresent):
         """Test that loadables contains both kernel and TFA BL31 entries.
 
         Each configuration must have a loadables property which lists both
         kernel-1 and tfa-bl31-1 strings in the string list.
         """
-        if present:
+        if bl31present:
             assert "/images/tfa-bl31-1" in self.images_nodes
         else:
             assert "/images/tfa-bl31-1" not in self.images_nodes
+        if teepresent:
+            assert "/images/tee-1" in self.images_nodes
+        else:
+            assert "/images/tee-1" not in self.images_nodes
         for node in self.confgs_nodes:
             loadables = self.__fdt_get_string(f'{node}', 'loadables')
             assert "kernel-1" in loadables
-            if present:
+            if bl31present:
                 assert "tfa-bl31-1" in loadables
             else:
                 assert "tfa-bl31-1" not in loadables
+            if teepresent:
+                assert "tee-1" in loadables
+            else:
+                assert "tee-1" not in loadables
 
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('fdtget')
@@ -157,6 +165,7 @@ def test_fit_auto_signed(ubman):
     dt1_file = f'{tempdir}/dt-1.dtb'
     dt2_file = f'{tempdir}/dt-2.dtb'
     tfa_file = f'{tempdir}/tfa-bl31.bin'
+    tee_file = f'{tempdir}/tee.bin'
     key_name = 'sign-key'
     sign_algo = 'sha256,rsa4096'
     key_file = f'{tempdir}/{key_name}.key'
@@ -175,6 +184,9 @@ def test_fit_auto_signed(ubman):
     with open(tfa_file, 'wb') as fd:
         fd.write(os.urandom(256))
 
+    with open(tee_file, 'wb') as fd:
+        fd.write(os.urandom(256))
+
     # Create 4096 RSA key and write to file to be read by mkimage
     key = RSA.generate(bits=4096)
     verifier = pkcs1_15.new(key)
@@ -194,7 +206,7 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_crc32_images()
 
-    fit.check_fit_loadables(present=False)
+    fit.check_fit_loadables(bl31present=False, teepresent=False)
 
     # 2 - Create auto FIT with signed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
@@ -206,7 +218,7 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_signed_images(key_name, sign_algo, verifier)
 
-    fit.check_fit_loadables(present=False)
+    fit.check_fit_loadables(bl31present=False, teepresent=False)
 
     # 3 - Create auto FIT with signed configs and hashed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
@@ -218,7 +230,7 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_signed_confgs(key_name, sign_algo)
 
-    fit.check_fit_loadables(present=False)
+    fit.check_fit_loadables(bl31present=False, teepresent=False)
 
     # Run the same tests as 1/2/3 above, but this time with TFA BL31
     # options -y tfa-bl31.bin -Y 0x12340000 to cover both mkimage with
@@ -234,7 +246,7 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_crc32_images()
 
-    fit.check_fit_loadables(present=True)
+    fit.check_fit_loadables(bl31present=True, teepresent=False)
 
     # 5 - Create auto FIT with signed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
@@ -246,7 +258,7 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_signed_images(key_name, sign_algo, verifier)
 
-    fit.check_fit_loadables(present=True)
+    fit.check_fit_loadables(bl31present=True, teepresent=False)
 
     # 6 - Create auto FIT with signed configs and hashed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
@@ -258,4 +270,84 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_signed_confgs(key_name, sign_algo)
 
-    fit.check_fit_loadables(present=True)
+    fit.check_fit_loadables(bl31present=True, teepresent=False)
+
+    # Run the same tests as 1/2/3 above, but this time with TEE
+    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
+    # and without TEE use cases.
+    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -z" + tee_file + " -Z 0x56780000"
+
+    # 4 - Create auto FIT with images crc32 checksum, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-7 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_crc32_images()
+
+    fit.check_fit_loadables(bl31present=False, teepresent=True)
+
+    # 5 - Create auto FIT with signed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-8 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_images(key_name, sign_algo, verifier)
+
+    fit.check_fit_loadables(bl31present=False, teepresent=True)
+
+    # 6 - Create auto FIT with signed configs and hashed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-9 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_confgs(key_name, sign_algo)
+
+    fit.check_fit_loadables(bl31present=False, teepresent=True)
+
+    # Run the same tests as 1/2/3 above, but this time with TEE
+    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
+    # and without TEE use cases.
+    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -y" + tfa_file + " -Y 0x12340000" + " -z" + tee_file + " -Z 0x56780000"
+
+    # 4 - Create auto FIT with images crc32 checksum, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-10 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_crc32_images()
+
+    fit.check_fit_loadables(bl31present=True, teepresent=True)
+
+    # 5 - Create auto FIT with signed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-11 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_images(key_name, sign_algo, verifier)
+
+    fit.check_fit_loadables(bl31present=True, teepresent=True)
+
+    # 6 - Create auto FIT with signed configs and hashed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-12 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_confgs(key_name, sign_algo)
+
+    fit.check_fit_loadables(bl31present=True, teepresent=True)
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 0306333141e..6388b04e340 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -180,6 +180,13 @@ static int fit_calc_size(struct image_tool_params *params)
 		total_size += size;
 	}
 
+	if (params->fit_tee) {
+		size = imagetool_get_filesize(params, params->fit_tee);
+		if (size < 0)
+			return -1;
+		total_size += size;
+	}
+
 	for (cont = params->content_head; cont; cont = cont->next) {
 		size = imagetool_get_filesize(params, cont->fname);
 		if (size < 0)
@@ -433,6 +440,30 @@ static int fit_write_images(struct image_tool_params *params, char *fdt)
 		fdt_end_node(fdt);
 	}
 
+	/* And a TEE file if available */
+	if (params->fit_tee) {
+		fdt_begin_node(fdt, FIT_TEE_PROP "-1");
+
+		fdt_property_string(fdt, FIT_TYPE_PROP, FIT_TEE_PROP);
+		fdt_property_string(fdt, FIT_OS_PROP,
+				    genimg_get_os_short_name(params->os));
+		fdt_property_string(fdt, FIT_ARCH_PROP,
+				    genimg_get_arch_short_name(params->arch));
+		get_basename(str, sizeof(str), params->fit_tee);
+		fdt_property_string(fdt, FIT_DESC_PROP, str);
+
+		ret = fdt_property_file(params, fdt, FIT_DATA_PROP,
+					params->fit_tee);
+		if (ret)
+			return ret;
+		fdt_property_u32(fdt, FIT_LOAD_PROP, params->fit_tee_addr);
+		fdt_property_u32(fdt, FIT_ENTRY_PROP, params->fit_tee_addr);
+		fit_add_hash_or_sign(params, fdt, true);
+		if (ret)
+			return ret;
+		fdt_end_node(fdt);
+	}
+
 	fdt_end_node(fdt);
 
 	return 0;
@@ -473,10 +504,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
 		len = strlen(str);
 		fdt_property_string(fdt, typename, str);
 
-		if (params->fit_tfa_bl31) {
+		if (params->fit_tfa_bl31 && params->fit_tee) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+			str[len] = 0;
+			len += strlen(FIT_TEE_PROP "-1") + 1;
+		} else if (params->fit_tfa_bl31) {
 			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
 			str[len] = 0;
 			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+		} else if (params->fit_tee) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TEE_PROP "-1") + 1;
 		}
 
 		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
@@ -498,10 +539,20 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
 		len = strlen(str);
 		fdt_property_string(fdt, typename, str);
 
-		if (params->fit_tfa_bl31) {
+		if (params->fit_tfa_bl31 && params->fit_tee) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1." FIT_TEE_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+			str[len] = 0;
+			len += strlen(FIT_TEE_PROP "-1") + 1;
+		} else if (params->fit_tfa_bl31) {
 			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
 			str[len] = 0;
 			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+		} else if (params->fit_tee) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TEE_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TEE_PROP "-1") + 1;
 		}
 
 		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
diff --git a/tools/imagetool.h b/tools/imagetool.h
index 866b8834fd7..d0e7d6d56e3 100644
--- a/tools/imagetool.h
+++ b/tools/imagetool.h
@@ -101,6 +101,8 @@ struct image_tool_params {
 	struct image_summary summary;	/* results of signing process */
 	char *fit_tfa_bl31;	/* TFA BL31 file to include */
 	unsigned int fit_tfa_bl31_addr;	/* TFA BL31 load and entry point address */
+	char *fit_tee;		/* TEE file to include */
+	unsigned int fit_tee_addr;	/* TEE load and entry point address */
 };
 
 /*
diff --git a/tools/mkimage.c b/tools/mkimage.c
index a800f9507bf..139d1bece2c 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -103,6 +103,8 @@ static void usage(const char *msg)
 		"          -s ==> create an image with no data\n"
 		"          -y ==> append TFA BL31 file to the image\n"
 		"          -Y ==> set TFA BL31 file load and entry point address\n"
+		"          -z ==> append TEE file to the image\n"
+		"          -Z ==> set TEE file load and entry point address\n"
 		"          -v ==> verbose\n",
 		params.cmdname);
 	fprintf(stderr,
@@ -162,7 +164,7 @@ static int add_content(int type, const char *fname)
 }
 
 static const char optstring[] =
-	"a:A:b:B:c:C:d:D:e:Ef:Fg:G:i:k:K:ln:N:o:O:p:qrR:stT:vVxy:Y:";
+	"a:A:b:B:c:C:d:D:e:Ef:Fg:G:i:k:K:ln:N:o:O:p:qrR:stT:vVxy:Y:z:Z:";
 
 static const struct option longopts[] = {
 	{ "load-address", required_argument, NULL, 'a' },
@@ -200,6 +202,8 @@ static const struct option longopts[] = {
 	{ "xip", no_argument, NULL, 'x' },
 	{ "tfa-bl31-file", no_argument, NULL, 'y' },
 	{ "tfa-bl31-addr", no_argument, NULL, 'Y' },
+	{ "tee-file", no_argument, NULL, 'z' },
+	{ "tee-addr", no_argument, NULL, 'Z' },
 	{ /* sentinel */ },
 };
 
@@ -382,6 +386,17 @@ static void process_args(int argc, char **argv)
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case 'z':
+			params.fit_tee = optarg;
+			break;
+		case 'Z':
+			params.fit_tee_addr = strtoull(optarg, &ptr, 16);
+			if (*ptr) {
+				fprintf(stderr, "%s: invalid TEE address %s\n",
+					params.cmdname, optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			usage("Invalid option");
 		}
-- 
2.51.0

