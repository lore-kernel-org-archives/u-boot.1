Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53955CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 19:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277C783E8E;
	Mon, 24 Nov 2025 20:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mRreBKv/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hIywU9LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9025B83EC9; Mon, 24 Nov 2025 20:42:14 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41EB083E62
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 20:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dFbnJ03l3z9tCT;
 Mon, 24 Nov 2025 20:42:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764013332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fbd2+2wkutZ5h/m71ZFWz3mX5dEQ0gTWPedeCvXEeM0=;
 b=mRreBKv/dSlOwrn/W7P4vQu9MgGqR/M61dN3wXyPIctjKAT3J5MA7MdFDgZHDLxCyTH3xM
 MpwLT507IFMilkFOTcOQqSGew4bqC9pOWk7J97eNMDN5wAJI1elEd9onZYdr6SItUrdTaE
 cHJAcg5oYfWIXyH+d6HLkf3rMKkgejE4rSxf99K8vV2JJSrLFtTmP+8frXKoLifOJse6rs
 wvEF0waKKwty8qhx0mlEBRKY+PW/JjrD7WB9KfC++lM3Md1p7wMIlDHR7+ezJikVrD9Ep9
 +cIAOni/V+ibS57gqv9mmA8R+Rg7gnO+yv9QP7iOmsQQvVM9cJBmo2aJcxb3mg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764013330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fbd2+2wkutZ5h/m71ZFWz3mX5dEQ0gTWPedeCvXEeM0=;
 b=hIywU9LLfwD740KnGDM5Y7OaIycOlQmL96g1XM2h1/JIwsgLJ+IbhIwIK5LOtzq7Ka/YLX
 U2f6XmVqVFQYHKtgs+i5bhWXigY41iKyl2b6LKeTiM4Q5cmav6eBO9dHbOfiJOzlrJ94vJ
 CxOcPKYBoEJQ9RyhdeRRVwv9wvioxvmo/n3pPlLYIBV+A8CzQo/BmYvUGISwPregLaayhn
 /PuBFwITy/7oo+xasmni8YA7dfAEcseP6M080UJc5MFKStQqh54LVn8UHDLwBxm2qUWoWg
 5GJiMKI8O32bKSIS2SWe5qn/BuEdb+NNCk84GNlB2jHwaQ4/AH5HiWueotjENw==
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
Subject: [PATCH v2 2/2] mkimage: Add support for bundling TEE in mkimage -f
 auto
Date: Mon, 24 Nov 2025 20:40:25 +0100
Message-ID: <20251124194201.83326-2-marek.vasut@mailbox.org>
In-Reply-To: <20251124194201.83326-1-marek.vasut@mailbox.org>
References: <20251124194201.83326-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: an9tioymrmsgxrgybw4a39jwrwqsqitu
X-MBO-RS-ID: 934809b30a6d0a51659
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
V2: - Update manpage to list --tee-* options instead of --optee-*
    - Update comments in pytest test to reflect the TEE support
---
 doc/mkimage.1                         | 12 +++++
 include/image.h                       |  1 +
 test/py/tests/test_fit_auto_signed.py | 65 ++++++++++++++++++++++++---
 tools/fit_image.c                     | 55 ++++++++++++++++++++++-
 tools/imagetool.h                     |  2 +
 tools/mkimage.c                       | 17 ++++++-
 6 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index c705218d345..29df21440e7 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -251,6 +251,18 @@ Append TFA BL31 file to the image.
 .B \-\-tfa-bl31-addr
 Set TFA BL31 file load and entry point address.
 .
+.TP
+.B \-z
+.TQ
+.B \-\-tee-file
+Append TEE file to the image.
+.
+.TP
+.B \-Z
+.TQ
+.B \-\-tee-addr
+Set TEE file load and entry point address, in hexadecimal.
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
index 3895e7d9369..2882942cbdc 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -117,28 +117,36 @@ class SignedFitHelper(object):
             algo = self.__fdt_get_string(f'{node}/signature', 'algo')
             assert algo == sign_algo + "\n", "Missing expected signature algo!"
 
-    def check_fit_loadables(self, present):
-        """Test that loadables contains both kernel and TFA BL31 entries.
+    def check_fit_loadables(self, bl31present, teepresent):
+        """Test that loadables contains both kernel, TFA BL31, TEE entries.
 
         Each configuration must have a loadables property which lists both
-        kernel-1 and tfa-bl31-1 strings in the string list.
+        kernel-1, tfa-bl31-1 and tee-1 strings in the string list.
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
 def test_fit_auto_signed(ubman):
-    def generate_and_check_fit_image(cmd, crc=False, simgs=False, scfgs=False, bl31present=False, key_name="", sign_algo="", verifier=""):
+    def generate_and_check_fit_image(cmd, crc=False, simgs=False, scfgs=False, bl31present=False, teepresent=False, key_name="", sign_algo="", verifier=""):
         """Generate fitImage and test for expected entries.
 
         Generate a fitImage and test whether suitable entries are part of
@@ -159,7 +167,7 @@ def test_fit_auto_signed(ubman):
         if scfgs:
             fit.check_fit_signed_confgs(key_name, sign_algo)
 
-        fit.check_fit_loadables(bl31present)
+        fit.check_fit_loadables(bl31present, teepresent)
 
     """Test that mkimage generates auto-FIT with signatures/hashes as expected.
 
@@ -179,6 +187,7 @@ def test_fit_auto_signed(ubman):
     dt1_file = f'{tempdir}/dt-1.dtb'
     dt2_file = f'{tempdir}/dt-2.dtb'
     tfa_file = f'{tempdir}/tfa-bl31.bin'
+    tee_file = f'{tempdir}/tee.bin'
     key_name = 'sign-key'
     sign_algo = 'sha256,rsa4096'
     key_file = f'{tempdir}/{key_name}.key'
@@ -197,6 +206,9 @@ def test_fit_auto_signed(ubman):
     with open(tfa_file, 'wb') as fd:
         fd.write(os.urandom(256))
 
+    with open(tee_file, 'wb') as fd:
+        fd.write(os.urandom(256))
+
     # Create 4096 RSA key and write to file to be read by mkimage
     key = RSA.generate(bits=4096)
     verifier = pkcs1_15.new(key)
@@ -239,3 +251,42 @@ def test_fit_auto_signed(ubman):
     generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
                                  scfgs=True, bl31present=True,
                                  key_name=key_name, sign_algo=sign_algo)
+
+    # Run the same tests as 1/2/3 above, but this time with TEE
+    # options -z tee.bin -Z 0x56780000 to cover both mkimage with
+    # and without TEE use cases.
+    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -z" + tee_file + " -Z 0x56780000"
+
+    # 7 - Create auto FIT with images crc32 checksum, and verify it
+    generate_and_check_fit_image(' -fauto' + b_args + " " + fit_file,
+                                 crc=True, teepresent=True)
+
+    # 8 - Create auto FIT with signed images, and verify it
+    generate_and_check_fit_image(' -fauto' + b_args + s_args + " " + fit_file,
+                                 simgs=True, teepresent=True,
+                                 key_name=key_name, sign_algo=sign_algo, verifier=verifier)
+
+    # 9 - Create auto FIT with signed configs and hashed images, and verify it
+    generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
+                                 scfgs=True, teepresent=True,
+                                 key_name=key_name, sign_algo=sign_algo)
+
+    # Run the same tests as 1/2/3 above, but this time with both
+    # TFA BL31 and TEE options -y tfa-bl31.bin -Y 0x12340000 and
+    # -z tee.bin -Z 0x56780000 to cover both mkimage with and
+    # without both TFA BL31 and TEE use cases.
+    b_args = " -d" + kernel_file + " -b" + dt1_file + " -b" + dt2_file + " -y" + tfa_file + " -Y 0x12340000" + " -z" + tee_file + " -Z 0x56780000"
+
+    # 10 - Create auto FIT with images crc32 checksum, and verify it
+    generate_and_check_fit_image(' -fauto' + b_args + " " + fit_file,
+                                 crc=True, bl31present=True, teepresent=True)
+
+    # 11 - Create auto FIT with signed images, and verify it
+    generate_and_check_fit_image(' -fauto' + b_args + s_args + " " + fit_file,
+                                 simgs=True, bl31present=True, teepresent=True,
+                                 key_name=key_name, sign_algo=sign_algo, verifier=verifier)
+
+    # 12 - Create auto FIT with signed configs and hashed images, and verify it
+    generate_and_check_fit_image(' -fauto-conf' + b_args + s_args + " " + fit_file,
+                                 scfgs=True, bl31present=True, teepresent=True,
+                                 key_name=key_name, sign_algo=sign_algo)
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

