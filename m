Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB93CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD9E9849A4;
	Thu,  4 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="OWF2WOXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864FC8486D; Thu,  4 Jun 2026 12:40:11 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1610784715
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 12:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5176a2fd597so4570381cf.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780569608; x=1781174408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEfXQ4vQ2OgRApyy+nkTRzJdE8ynLll0kUlr00LGuuk=;
 b=OWF2WOXiKvpxOp9D5UkULQpk3BvtAbavBkDkwRdnKCZilKAMkni0aj3jCayiWIuAWG
 m0EXdWB4RXUGnwiqYmyYvrTTB29W22sDnQzloj3xoWNyDSce6frgZpQCr4Oi3uT9dpFj
 ILFmpsaHSaKcycdyIcSDn92iQtBWBwUxwxyy23K42Mvm6OFhCNDveQ9UGtqhBWsKXzgl
 JiCT0vMCAEVy8lNDCTrVfwaMz1RXHsq+FfQ1FUgxqvJxJTr5AqBZe/AzP4G+3XNGxdvZ
 atCprjwaV9lY6Nv5m1k4POoEHQNtu2NQlUok84UzjE1bG2EliZ7OtPd03iGA+sT3zJGm
 jSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569608; x=1781174408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OEfXQ4vQ2OgRApyy+nkTRzJdE8ynLll0kUlr00LGuuk=;
 b=jdK63LD1/Ie/lwWnBDMdDsxCuv+U6CbF+Dr5DyPOEIuqTea1KPX9CF33N2jPgk/yX1
 Kwx2nWgK5lXFNOts3FzTWdaX+7ryDjRoBGS0dC0ABxvLGlxqeJGtYdYiUM151CKA3Ilz
 YQoSMLoeJT9kFyWLltpqWWLdJ0wFSamh8vPLZ13Jh6zbdp/maVOQCdMYjNNFI/Q7WTrX
 xaDjFwGUzed/LbxBWKkduntm7N7nhgtiZyOpGE3SyyrJfU7NyPVrWd69nNxM9mWgo2wi
 BnERQfZaQJk4frqltI8oIjZSnfs7NvqgpOAKo5wMExbVof6PfWWWuN+HuNT39QswT3zZ
 IB0w==
X-Gm-Message-State: AOJu0YwD5Hk1usiWLU0G0fRauRl2BM1ysX3Tk2QbdAEVe3G+FF5vcrru
 0Pv+HRdEedZMI72bhZ9vTz6fijH2I3YZnclhtYnfh10ilSwKBH/aNTXEmwvbO9vEMeUHwZBEgxq
 ChnfqYtCfQABy
X-Gm-Gg: Acq92OGguAALaoBOM+yHYTtM2XEhKhu1FeEl+en2+Ipq7xJqVGI3Q4MvuoSKQrIb1hk
 ksuPIGy74jynXyfmSI1l1F1bfLjvR+ZTEOxt5oXVriOIVHkysXA148tRk6SLWOQMcsrcKEr3P84
 18GS9YhdBHV767BaGj7Mrs2/7jfMYDmPTycTe4cX3Snq+EYMS8/ZBDv8FDAd0ZwRI+X/PSHpaWh
 nxO5UN+0WyikKlx5fw1UlucJLDKDtpwK7dAGzepXCG58JbPHgl8DVOn5ekC/3qB4R45SLGBWs/a
 gnb0BD/LGKtLpYLNeNhcH2IwwkA074Nx+oQ0YKN2+/cKbv5dd/1EAHopgAL1bQMR61gXx5LihqM
 b58p14u7cZdJNuYvX6vhxdQKYAMwZAt0cCkepqG4CH+Y2o2umNH9jXbc70eEnucZ9WIi6HWU7h5
 yLERH4DR/Zxl9ArPEgPmmTjJzN4W2VjJU8KgwFX2/av/tealNEisM0nb7C
X-Received: by 2002:a05:622a:2505:b0:50e:a1ab:114c with SMTP id
 d75a77b69052e-517786a9971mr104902091cf.32.1780569607674; 
 Thu, 04 Jun 2026 03:40:07 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05177150esm289043466b.5.2026.06.04.03.40.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Jun 2026 03:40:06 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v5] image-fit: Validate external data offset and size
Date: Thu,  4 Jun 2026 11:39:50 +0100
Message-ID: <20260604103950.77778-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260602183052.65247-1-anton@binarly.io>
References: <20260602183052.65247-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

fit_image_get_data() uses the data-position, data-offset, and
data-size FIT properties without bounds checking. A crafted FIT
image can specify values that cause out-of-bounds read during
signature verification of an untrusted FIT.

Validate that the external data offset and size are non-negative,
and that the data region fits within the FIT image bounds.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v5:
- Guard the data-offset addition against INT_MAX overflow before
  adding the aligned FIT size
- Always bounds-check the offset and size against the addressable
  range; additionally cap them at FIT_SIGNATURE_MAX_SIZE for signed
  FITs
- Return -EINVAL instead of -1 on validation failures

Changes in v4:
- Add test for external data bounds validation
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c            |  53 +++++++++++-
 test/py/tests/test_vboot.py | 165 ++++++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..a26450914d4 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1069,23 +1069,72 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 	int offset;
 	int len;
 	int ret;
+	size_t fdt_total_size_aligned;
+	uintptr_t max_offset;
 
 	if (!fit_image_get_data_position(fit, noffset, &offset)) {
+		if (offset < 0) {
+			printf("Invalid external data position: %d\n", offset);
+			return -EINVAL;
+		}
+
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
-		external_data = true;
 		/*
 		 * For FIT with external data, figure out where
 		 * the external images start. This is the base
 		 * for the data-offset properties in each image.
 		 */
-		offset += ((fdt_totalsize(fit) + 3) & ~3);
+		fdt_total_size_aligned = ((fdt_totalsize(fit) + 3) & ~3);
+		/* The resulting offset cannot exceed INT_MAX */
+		if (offset < 0 || fdt_total_size_aligned > INT_MAX - offset) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -EINVAL;
+		}
+		offset += fdt_total_size_aligned;
+
+		external_data = true;
 	}
 
 	if (external_data) {
 		debug("External Data\n");
+
+		max_offset = UINTPTR_MAX - (uintptr_t)fit;
+		/* Check that external data offset is within the addressable range */
+		if (offset > max_offset) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -EINVAL;
+		}
+
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
+			if (len < 0) {
+				printf("Invalid external data size: %d\n", len);
+				return -EINVAL;
+			}
+			/*
+			 * For non-signed FIT images, we can only check that
+			 * (offset + len) doesn't exceed the addressable range.
+			 * For signed FITs, we can additionally check that
+			 * (offset + len) doesn't exceed the allowed FIT image
+			 * maximum size.
+			 */
+			if (len > max_offset - offset
+			/*
+			 * #if (not a runtime if) is required: FIT_SIGNATURE_MAX_SIZE
+			 * depends on FIT_SIGNATURE, so CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE)
+			 * is undefined when signing is disabled and referencing it
+			 * here would fail to compile.
+			 */
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+			    || offset > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) ||
+			    len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset
+#endif
+			) {
+				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				       offset, len);
+				return -EINVAL;
+			}
 			*data = fit + offset;
 			*size = len;
 		}
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..352a0a031a7 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -563,6 +563,171 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         ubman.restart_uboot()
 
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.requiredtool('openssl')
+def test_vboot_ext_data_bounds(ubman):
+    """Test that malformed external-data properties are rejected.
+
+    A signed FIT with external data exposes 'data-position', 'data-offset' and
+    'data-size' properties. U-Boot must validate these before hashing the image
+    components, otherwise a crafted FIT could trigger an out-of-bounds access
+    during signature verification.
+
+    These checks are independent of the hashing algorithm, so a single signing
+    configuration is enough.
+
+    This works using sandbox only as it needs to update the device tree used
+    by U-Boot to hold public keys from the signing process.
+    """
+    sha_algo = 'sha256'
+
+    def run_bootm(test_type, expect_string):
+        """Run a 'bootm' command in U-Boot and expect it to fail.
+
+        This always starts a fresh U-Boot instance since the device tree may
+        contain a new public key.
+
+        Args:
+            test_type: A string identifying the test type.
+            expect_string: A string which is expected in the output.
+        """
+        ubman.restart_uboot()
+        with ubman.log.section('Verified boot %s %s' % (sha_algo, test_type)):
+            output = ubman.run_command_list(
+                ['host load hostfs - 100 %s' % fit,
+                 'fdt addr 100',
+                 'bootm 100'])
+        assert expect_string in ''.join(output)
+        assert 'sandbox: continuing, as we cannot run' not in ''.join(output)
+
+    def sign_fit(options):
+        """Sign the FIT
+
+        Signs the FIT and writes the signature into it. It also writes the
+        public key into the dtb.
+
+        Args:
+            options: Options to provide to mkimage.
+        """
+        args = [mkimage, '-F', '-k', tmpdir, '-K', dtb, '-r', fit]
+        if options:
+            args += options.split(' ')
+        ubman.log.action('%s: Sign images' % sha_algo)
+        utils.run_and_log(ubman, args)
+
+    def create_rsa_pair(name):
+        """Generate a new RSA key pair and certificate.
+
+        Args:
+            name: Name of the key (e.g. 'dev')
+        """
+        public_exponent = 65537
+        utils.run_and_log(ubman, 'openssl genpkey -algorithm RSA -out %s%s.key '
+                     '-pkeyopt rsa_keygen_bits:2048 '
+                     '-pkeyopt rsa_keygen_pubexp:%d' %
+                     (tmpdir, name, public_exponent))
+
+        # Create a certificate containing the public key
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+
+    def set_external_data(prop, value):
+        """Set an external-data property of the kernel image.
+
+        Args:
+            prop: Property name
+            value: The new value of the property
+        """
+        utils.run_and_log(
+            ubman, 'fdtput -t x %s /images/kernel %s %#x' % (fit, prop, value)
+        )
+
+    def make_signed_fit():
+        """Build a fresh signed FIT with external data.
+
+        sign_fit() overwrites the FIT, so a new one is built before each test
+        case mutates its external-data properties.
+        """
+        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+                 datadir, fit)
+        sign_fit('-E')
+
+    tmpdir = os.path.join(ubman.config.result_dir, 'ext-data-bounds') + '/'
+    if not os.path.exists(tmpdir):
+        os.mkdir(tmpdir)
+    datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
+    fit = '%stest.fit' % tmpdir
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    dtc_args = '-I dts -O dtb -i %s' % tmpdir
+    dtb = '%ssandbox-u-boot.dtb' % tmpdir
+
+    bcfg = ubman.config.buildconfig
+    max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
+
+    create_rsa_pair('dev')
+
+    # Create a kernel image filled with zeroes
+    with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
+        fd.write(500 * b'\0')
+
+    testcases = [
+        ('negative data-position',
+         {'data-position': 0xffffffff}, 'Invalid external data position'),
+        ('negative data-offset',
+         {'data-offset': 0xffffffff}, 'Invalid external data offset'),
+        ('negative data-size',
+         {'data-size': 0xffffffff}, 'Invalid external data size'),
+        ('off-bounds data-position',
+         {'data-position': 0x7fffffff}, 'FIT external data is out of bounds'),
+        ('off-bounds data-offset',
+         {'data-offset': 0x10000000}, 'FIT external data is out of bounds'),
+        ('oversized data-size',
+         {'data-size': 0x7fffffff}, 'FIT external data is out of bounds'),
+        ('off-bounds data-position',
+         {'data-position': max_size + 1, 'data-size': 0},
+         'FIT external data is out of bounds'),
+        ('off-bounds data-offset',
+         {'data-offset': max_size + 1, 'data-size': 0},
+         'FIT external data is out of bounds'),
+        ('oversized data-size',
+         {'data-position': 0x0, 'data-size': max_size + 1},
+         'FIT external data is out of bounds'),
+        ('in-bounds data-position',
+         {'data-position': max_size, 'data-size': 0}, 'Bad Data Hash'),
+        ('in-bounds data-offset',
+         {'data-offset': max_size, 'data-size': 0}, 'Bad Data Hash'),
+        ('in-bounds data-size',
+         {'data-position': 0x0, 'data-size': max_size}, 'Bad Data Hash'),
+    ]
+
+    # We need to use our own device tree file. Remember to restore it
+    # afterwards.
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+
+        # Compile our device tree files for kernel and U-Boot. These are
+        # regenerated here since mkimage will modify them (by adding a
+        # public key) below.
+        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+        dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
+
+        ubman.log.action(
+            '%s: Test signed FIT with malformed external-data properties' % sha_algo)
+        for desc, props, expect_string in testcases:
+            make_signed_fit()
+            for prop, value in props.items():
+                set_external_data(prop, value)
+            run_bootm('Signed config with %s' % desc, expect_string)
+    finally:
+        # Go back to the original U-Boot with the correct dtb.
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()
+
+
 TESTDATA_IN = [
     ['sha1-basic', 'sha1', '', None, False],
     ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
-- 
2.53.0
