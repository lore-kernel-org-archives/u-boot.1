Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C6ECA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 22:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D167832EB;
	Wed,  3 Sep 2025 00:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vvx0luQv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f08bPI1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A34D8334A; Wed,  3 Sep 2025 00:02:16 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E90832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cGfq94DlMz9srG;
 Wed,  3 Sep 2025 00:02:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756850533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1xhyKYb4OZ/L0PPZ7Q/tgUL7h6WLQkcyAEpJOZ1yVdA=;
 b=vvx0luQvuVaSQx/FiNiy3qkUljGBu1hU618KPzSbh5U2ytWBXkrdemwn0AqnYMIeVyn5Ix
 3jetb3NqfIwi9ltSv3D5vQlC5aACHQHhv4JVZXTqpECBqwcV0edkzr2bD2st/gE4K/ij4O
 gPR0pVZKeFWM0TdPVaI4EKjhjSpLBAC+F7CEOXWDBGIPdbjeSRtMCoQG/wmJxZ2TAibUi1
 SC0WWkxZsFrx9O7q4n2laMG3vnio/bed3NjEbKmc7buNaB3tuoT76e7sOEiOU4EPGShMBj
 mrQzG3YHt0z+XVoLu0Y344Ua6pvKWAWlqHqUJTgjt0Mm4L/8fdpKZXv91FfSqw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756850531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1xhyKYb4OZ/L0PPZ7Q/tgUL7h6WLQkcyAEpJOZ1yVdA=;
 b=f08bPI1XerLy5EMoIpYn84GvcZIDZ/0MlffF7O6jSdylPytem2I8xJvp8+f34pdXHTBug5
 0tqDlL3VMWVqTHD//wjqtR9DisUYuz3fBFMZ5NBTXL60NVtXhTaYgsItffBgFzL7h20J5f
 JThZu4wPvcPxdq5Qg//3b3Fl0DmiWnPuueIaw+2N/vhI103llALqp5gKHtUUCynZy4gg4v
 fQML42YkKwSLrm5XdS2DBzkF1JWNc16k5q9RmOWuCT4lZbXvqoh1k3a/lYfNtqmWlTr00m
 sKIR+23XT8rmbeDuE66V+IHi4CRbBsy3Kqjk7WKXPG/nUB9wQ/ksz4Jc4d7Xog==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mkimage: Add support for bundling TFA BL31 in mkimage -f auto
Date: Wed,  3 Sep 2025 00:01:55 +0200
Message-ID: <20250902220159.448431-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5d0e1608d861ad4c5b5
X-MBO-RS-META: wjibej7or65onyeje1btb4d7gi1fnsg1
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
TFA BL31 image into fitImage, using auto-generated fitImage. Add -y to
specify TFA BL31 file name and -Y to specify TFA BL31 load and entry
point address. This is meant to be used with systems which boot all of
TFA BL31, Linux and its DT from a single fitImage, all booted by U-Boot.

Example invocation:
"
$ mkimage -E -A arm64 -C none -e 0x50200000 -a 0x50200000 -f auto \
          -d arch/arm64/boot/Image \
	  -b arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dtb \
	  -y ../tfa/build/rcar_gen4/release/bl31.bin -Y 0x46400000 \
	  /path/to/output/fitImage
"

Documentation update and test are also included, the test validates
both positive and negative test cases, where fitImage does not include
TFA BL31 and does include TFA BL31 blobs.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/mkimage.1                         | 12 +++++
 include/image.h                       |  1 +
 test/py/tests/test_fit_auto_signed.py | 67 +++++++++++++++++++++++++++
 tools/fit_image.c                     | 52 ++++++++++++++++++++-
 tools/imagetool.h                     |  2 +
 tools/mkimage.c                       | 15 +++++-
 6 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index d0a038a880a..75b6b48a0cf 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -239,6 +239,18 @@ Set the
 command will not load the image data, and instead will assume it is already
 accessible at the load address (such as via memory-mapped flash).
 .
+.TP
+.B \-y
+.TQ
+.B \-\-tfa-bl31-file
+Append TFA BL31 file to the image.
+.
+.TP
+.B \-Y
+.TQ
+.B \-\-tfa-bl31-addr
+Set TFA BL31 file load and entry point address.
+.
 .SS Options for creating FIT images
 .
 .TP
diff --git a/include/image.h b/include/image.h
index b695cc39447..fc2f2487095 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1104,6 +1104,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_STANDALONE_PROP	"standalone"
 #define FIT_SCRIPT_PROP		"script"
 #define FIT_PHASE_PROP		"phase"
+#define FIT_TFA_BL31_PROP	"tfa-bl31"
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index cdfd341c6f5..0b5dbd5401c 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -117,6 +117,23 @@ class SignedFitHelper(object):
             algo = self.__fdt_get_string(f'{node}/signature', 'algo')
             assert algo == sign_algo + "\n", "Missing expected signature algo!"
 
+    def check_fit_loadables(self, present):
+        """Test that loadables contains both kernel and TFA BL31 entries.
+
+        Each configuration must have a loadables property which lists both
+        kernel-1 and tfa-bl31-1 strings in the string list.
+        """
+        if present:
+            assert "/images/tfa-bl31-1" in self.images_nodes
+        else:
+            assert "/images/tfa-bl31-1" not in self.images_nodes
+        for node in self.confgs_nodes:
+            loadables = self.__fdt_get_string(f'{node}', 'loadables')
+            assert "kernel-1" in loadables
+            if present:
+                assert "tfa-bl31-1" in loadables
+            else:
+                assert "tfa-bl31-1" not in loadables
 
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('fdtget')
@@ -139,6 +156,7 @@ def test_fit_auto_signed(ubman):
     kernel_file = f'{tempdir}/vmlinuz'
     dt1_file = f'{tempdir}/dt-1.dtb'
     dt2_file = f'{tempdir}/dt-2.dtb'
+    tfa_file = f'{tempdir}/tfa-bl31.bin'
     key_name = 'sign-key'
     sign_algo = 'sha256,rsa4096'
     key_file = f'{tempdir}/{key_name}.key'
@@ -154,6 +172,9 @@ def test_fit_auto_signed(ubman):
     with open(dt2_file, 'wb') as fd:
         fd.write(os.urandom(256))
 
+    with open(tfa_file, 'wb') as fd:
+        fd.write(os.urandom(256))
+
     # Create 4096 RSA key and write to file to be read by mkimage
     key = RSA.generate(bits=4096)
     verifier = pkcs1_15.new(key)
@@ -173,6 +194,8 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_crc32_images()
 
+    fit.check_fit_loadables(present=False)
+
     # 2 - Create auto FIT with signed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
                       fit_file)
@@ -183,6 +206,8 @@ def test_fit_auto_signed(ubman):
 
     fit.check_fit_signed_images(key_name, sign_algo, verifier)
 
+    fit.check_fit_loadables(present=False)
+
     # 3 - Create auto FIT with signed configs and hashed images, and verify it
     utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
                       fit_file)
@@ -192,3 +217,45 @@ def test_fit_auto_signed(ubman):
         raise ValueError('FIT-3 has no "/image" nor "/configuration" nodes')
 
     fit.check_fit_signed_confgs(key_name, sign_algo)
+
+    fit.check_fit_loadables(present=False)
+
+    # Run the same tests as 1/2/3 above, but this time with TFA BL31
+    # options -y tfa-bl31.bin -Y 0x12340000 to cover both mkimage with
+    # and without TFA BL31 use cases.
+    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -y" + tfa_file + " -Y 0x12340000"
+
+    # 4 - Create auto FIT with images crc32 checksum, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + " " + fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-4 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_crc32_images()
+
+    fit.check_fit_loadables(present=True)
+
+    # 5 - Create auto FIT with signed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-5 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_images(key_name, sign_algo, verifier)
+
+    fit.check_fit_loadables(present=True)
+
+    # 6 - Create auto FIT with signed configs and hashed images, and verify it
+    utils.run_and_log(ubman, mkimage + ' -fauto-conf' + b_args + s_args + " " +
+                      fit_file)
+
+    fit = SignedFitHelper(ubman, fit_file)
+    if fit.build_nodes_sets() == 0:
+        raise ValueError('FIT-6 has no "/image" nor "/configuration" nodes')
+
+    fit.check_fit_signed_confgs(key_name, sign_algo)
+
+    fit.check_fit_loadables(present=True)
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 331be5ae71d..10849733816 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -173,6 +173,13 @@ static int fit_calc_size(struct image_tool_params *params)
 		total_size += size;
 	}
 
+	if (params->fit_tfa_bl31) {
+		size = imagetool_get_filesize(params, params->fit_tfa_bl31);
+		if (size < 0)
+			return -1;
+		total_size += size;
+	}
+
 	for (cont = params->content_head; cont; cont = cont->next) {
 		size = imagetool_get_filesize(params, cont->fname);
 		if (size < 0)
@@ -402,6 +409,30 @@ static int fit_write_images(struct image_tool_params *params, char *fdt)
 		fdt_end_node(fdt);
 	}
 
+	/* And a TFA BL31 file if available */
+	if (params->fit_tfa_bl31) {
+		fdt_begin_node(fdt, FIT_TFA_BL31_PROP "-1");
+
+		fdt_property_string(fdt, FIT_TYPE_PROP, FIT_TFA_BL31_PROP);
+		fdt_property_string(fdt, FIT_OS_PROP,
+				    genimg_get_os_short_name(params->os));
+		fdt_property_string(fdt, FIT_ARCH_PROP,
+				    genimg_get_arch_short_name(params->arch));
+		get_basename(str, sizeof(str), params->fit_tfa_bl31);
+		fdt_property_string(fdt, FIT_DESC_PROP, str);
+
+		ret = fdt_property_file(params, fdt, FIT_DATA_PROP,
+					params->fit_tfa_bl31);
+		if (ret)
+			return ret;
+		fdt_property_u32(fdt, FIT_LOAD_PROP, params->fit_tfa_bl31_addr);
+		fdt_property_u32(fdt, FIT_ENTRY_PROP, params->fit_tfa_bl31_addr);
+		fit_add_hash_or_sign(params, fdt, true);
+		if (ret)
+			return ret;
+		fdt_end_node(fdt);
+	}
+
 	fdt_end_node(fdt);
 
 	return 0;
@@ -421,7 +452,7 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
 	struct content_info *cont;
 	const char *typename;
 	char str[100];
-	int upto;
+	int upto, len;
 
 	fdt_begin_node(fdt, "configurations");
 	fdt_property_string(fdt, FIT_DEFAULT_PROP, "conf-1");
@@ -439,8 +470,16 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
 
 		typename = genimg_get_type_short_name(params->fit_image_type);
 		snprintf(str, sizeof(str), "%s-1", typename);
+		len = strlen(str);
 		fdt_property_string(fdt, typename, str);
-		fdt_property_string(fdt, FIT_LOADABLE_PROP, str);
+
+		if (params->fit_tfa_bl31) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+		}
+
+		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
 
 		if (params->fit_ramdisk)
 			fdt_property_string(fdt, FIT_RAMDISK_PROP,
@@ -456,8 +495,17 @@ static void fit_write_configs(struct image_tool_params *params, char *fdt)
 		fdt_begin_node(fdt, "conf-1");
 		typename = genimg_get_type_short_name(params->fit_image_type);
 		snprintf(str, sizeof(str), "%s-1", typename);
+		len = strlen(str);
 		fdt_property_string(fdt, typename, str);
 
+		if (params->fit_tfa_bl31) {
+			snprintf(str, sizeof(str), "%s-1." FIT_TFA_BL31_PROP "-1", typename);
+			str[len] = 0;
+			len += strlen(FIT_TFA_BL31_PROP "-1") + 1;
+		}
+
+		fdt_property(fdt, FIT_LOADABLE_PROP, str, len + 1);
+
 		if (params->fit_ramdisk)
 			fdt_property_string(fdt, FIT_RAMDISK_PROP,
 					    FIT_RAMDISK_PROP "-1");
diff --git a/tools/imagetool.h b/tools/imagetool.h
index 57be608210a..866b8834fd7 100644
--- a/tools/imagetool.h
+++ b/tools/imagetool.h
@@ -99,6 +99,8 @@ struct image_tool_params {
 	const char *engine_id;	/* Engine to use for signing */
 	bool reset_timestamp;	/* Reset the timestamp on an existing image */
 	struct image_summary summary;	/* results of signing process */
+	char *fit_tfa_bl31;	/* TFA BL31 file to include */
+	unsigned int fit_tfa_bl31_addr;	/* TFA BL31 load and entry point address */
 };
 
 /*
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 361711c53b2..b6e18686d1c 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -160,7 +160,7 @@ static int add_content(int type, const char *fname)
 }
 
 static const char optstring[] =
-	"a:A:b:B:c:C:d:D:e:Ef:Fg:G:i:k:K:ln:N:o:O:p:qrR:stT:vVx";
+	"a:A:b:B:c:C:d:D:e:Ef:Fg:G:i:k:K:ln:N:o:O:p:qrR:stT:vVxy:Y:";
 
 static const struct option longopts[] = {
 	{ "load-address", required_argument, NULL, 'a' },
@@ -196,6 +196,8 @@ static const struct option longopts[] = {
 	{ "verbose", no_argument, NULL, 'v' },
 	{ "version", no_argument, NULL, 'V' },
 	{ "xip", no_argument, NULL, 'x' },
+	{ "tfa-bl31-file", no_argument, NULL, 'y' },
+	{ "tfa-bl31-addr", no_argument, NULL, 'Y' },
 	{ /* sentinel */ },
 };
 
@@ -367,6 +369,17 @@ static void process_args(int argc, char **argv)
 		case 'x':
 			params.xflag++;
 			break;
+		case 'y':
+			params.fit_tfa_bl31 = optarg;
+			break;
+		case 'Y':
+			params.fit_tfa_bl31_addr = strtoull(optarg, &ptr, 16);
+			if (*ptr) {
+				fprintf(stderr, "%s: invalid TFA BL31 address %s\n",
+					params.cmdname, optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			usage("Invalid option");
 		}
-- 
2.50.1

