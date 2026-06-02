Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B0CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEEA84881;
	Wed,  3 Jun 2026 02:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="BOXrBMCn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564F184852; Tue,  2 Jun 2026 20:30:59 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6738485F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-516d0db9372so103424281cf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780425056; x=1781029856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWeKDA90baQ0neksYnNg4iidUCzKkV+t+2wrZvKg/P4=;
 b=BOXrBMCnnOl1sHmRNnT2c+ylhhg/AbI7ltJxFoeQGDAArDqBVbPcOr5FYk4oWS2tFX
 WD46A9i429Nj9fOGYvDOv+EfCaf1BirfGd0mtviGa/km0DzrurMVtTB2FEmpCX8yVtD4
 xYrjBzYNqVnU64LFzSkVTS4td5G7DsDkjZt1/9Ng7o7VFs4UPITPKE0dU9MBBdpJwJPx
 HTuKdoFAJZLAMKCoDXaC2AWSjnZQuhLiHmbmRJHYc+YAtgBry/Aq8SoOZleK5WfPp8wJ
 6M5xYhJKHkG8n09mmnnJPk9wSt2z8/Qx/50j2r/MCE28yYmQqlOSq85O8HsTUW5VZLXu
 GxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425056; x=1781029856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UWeKDA90baQ0neksYnNg4iidUCzKkV+t+2wrZvKg/P4=;
 b=hC0shNdkKAjEJq8z+1OwAV7FeEihcBzWX2iENKVm5ANfZD3fOy5I17544qqfKbXoD1
 qtqiv8DXX7TTL78vZDKC4RwICQQa8Yu/8wE2927MRqkMt+/W1QKP7g3c4nusXfwiPyYG
 qvBiedpR2WcY2zTtOShd78HNvRZQgUNuBQNoPxgB4Fmd/O8f5obJhZmtJhUwGQ7nh3Kw
 hNHz4fgxlR5Tzp290K/pImXCSIEgsD0dsA6IJ+tjQns4JwLTJDh/Eex+6xUHVa+LvMU3
 5VOa7N062Wk4cHIvp6WzxRdHBS7aP8KuJMrBz3cZgABz2S88cNMLO9lK9wDwQ7mi+EbY
 nULQ==
X-Gm-Message-State: AOJu0Yz1Da1u1juwsxw13ATBQERUFXUqQQ0cyzXLY3y/YGWkdPL/cZ9L
 QQ9UPl0roa7n0yKpo6SKrBigD/frA5DZR+wzAFunczZBzFplYzgsl7Z5WguIri09LvNiIMM2LRX
 NZCGM
X-Gm-Gg: Acq92OFkcqfNV6AxDRctuHit9oIBDchkMe1QCuebr3HKb4fILpb38OcCPpw3oRJLapn
 JAd8+LDpRCfBfE54or8OpAJ2vam2jwc3x/RJiAbLTuNh8CwnuIiUjBOHo0CI1xO46PQ3VrL+kJL
 5Ky7xrOEPwuio9h+r6fHDEWSLToOJaWefyS/FmFosR8pJe/BR72sA4aYc2EU943/U7jDrku/Hd2
 1lPHYRqZH09gAUfvIwC7MZd9wj+NSPgM9vMJ5XIPj+MgJCG75A5iQS21Gb1rPHm5fQQzeuYwV+g
 Mh1nUMA+T7wGNlXOUWAssJXayQtgZs1irR7tMrsTm8mpGaNFR6beKf2DoRbB2NovBsc5HXHAW0L
 m1Ay4cW+9WwHF1ahVvUQXIHTRcb1cfArSH2HkBrV2iV5NJoouQDABH/Yc/MXb6o6CfCdPuItfp0
 lukv6N+GnXmQfhJ+6SBhYGItv1gyNsEdguHmWdeHkRJbU8llVPqhiIALEfOGapkwkE6kc=
X-Received: by 2002:a05:622a:4287:b0:517:6dbe:4972 with SMTP id
 d75a77b69052e-5177862124fmr3562541cf.22.1780425055676; 
 Tue, 02 Jun 2026 11:30:55 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e0280asm24238466b.33.2026.06.02.11.30.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jun 2026 11:30:54 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4] image-fit: Validate external data offset and size
Date: Tue,  2 Jun 2026 19:30:52 +0100
Message-ID: <20260602183052.65247-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260527112518.16085-1-anton@binarly.io>
References: <20260527112518.16085-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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
Changes in v4:
- Add test for external data bounds validation
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c            |  16 ++++
 test/py/tests/test_vboot.py | 165 ++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..b657142f626 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1084,8 +1084,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 
 	if (external_data) {
 		debug("External Data\n");
+		if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -1;
+		}
+
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
+			if (len < 0) {
+				printf("Invalid external data size: %d\n", len);
+				return -1;
+			}
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+			if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset) {
+				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				       offset, len);
+				return -1;
+			}
+#endif
 			*data = fit + offset;
 			*size = len;
 		}
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..85a1bd56af6 100644
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
+         {'data-position': 0xFFFFFFFF}, 'Invalid external data offset'),
+        ('negative data-offset',
+         {'data-offset': 0x80000000}, 'Invalid external data offset'),
+        ('negative data-size',
+         {'data-size': 0xFFFFFFFF}, 'Invalid external data size'),
+        ('off-bounds data-position',
+         {'data-position': 0x7FFFFFFF}, 'FIT external data is out of bounds'),
+        ('off-bounds data-offset',
+         {'data-offset': 0x10000000}, 'FIT external data is out of bounds'),
+        ('oversized data-size',
+         {'data-size': 0x7FFFFFFF}, 'FIT external data is out of bounds'),
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
