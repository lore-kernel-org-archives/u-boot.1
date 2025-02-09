Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16D7C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1DF80BA9;
	Sun,  9 Feb 2025 17:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hVE2LPbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB908083F; Sun,  9 Feb 2025 17:07:51 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266E58083F
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 17:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso144245439f.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739117266; x=1739722066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dytxl1g2slLQtSkD6hvePUsYCKFT83pGx1vtmWJrWJk=;
 b=hVE2LPbPufFX2aZnOeI9pP7Mwm2Wm2FLaMa2FqnfgeBLm7lwoVwViuu/NwoAespoBu
 gYqacx2ijVZ/oaA4xMMlRlM/LSrpOy1ZAX5p4vkfd35ONOIsGqMgKQ3D0Qp5MKAbmnBg
 49JR6C4cpnhZi6NyOkOARe9x3B2T0M5usSpAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739117266; x=1739722066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dytxl1g2slLQtSkD6hvePUsYCKFT83pGx1vtmWJrWJk=;
 b=AK1WpqvTZRywAwimh23yuewTZrM1dN0j0HQpD1J/NZ1lVblCJyBx31RD1aLGBVJaNx
 wow4AYQSpb6L6pThRh/K1iaqdR+YalaY1Moxg3RKdxz4jcxIDudpb34b1HNZNv4A6V2T
 P2TI/cc3T/bPxZxCZnC5obLc71V/6TvTevDcyJYbr9flJw1rGpeiTdZK/JF4L8V6bRaO
 mmHQqUMB0B39HH2jLvzzg4Y1mVFQOhT+rOdykxfnrrjki0UwZTqXo+USuDq03tEOEh5u
 3uNVHssdUc8vzShS/oN1ozsxSMgQrmy1MIKVHEsuylNlT2ua0UWqOSRSoV7hjrlyaDeu
 AbeQ==
X-Gm-Message-State: AOJu0Yw/FeC2okR8+quNZ59pJV/AoCpHmSrPeelfpdc9X3kYw6EiKOaS
 jBvRRfdajAXu/PrJBe0EZAqDhZ2KnXTGvtLsQeXzf9rbPwoqboiryIZInZECqUtzUEoHLCg+yMU
 =
X-Gm-Gg: ASbGncuQxXijdR1O5dqTbgCdTPAQzloVZO/7Dcg/M3q5OOLn9MdIhu0afUu11Ja2/Y7
 bQ0grPL4vv/a3NewF4i4GwwQmRkc1l5nfcAXomxk+ffuK6SmQfDlUqnUtKsfvHi4nHnQz3X4ppk
 qY9bVowy77a74nG3EX+9WO0ASKTGT/oAaJC4JHqWrxnKt3v8umEPFAPBs8cvD4WD484Y53Hf877
 nfSgz1tCJYNYcEgTCSYtK+sm7ZIwsQddLoG0XQj81MijpSm7MWuJmad+alJqCHwEoi8Pftr7fu6
 r1wJe5xrvSmYhDENsudrzusGAY5jDS//5TltWQrpLHTIQvh3Rn9H
X-Google-Smtp-Source: AGHT+IFL2NFFd5XDnAZCLShb/69FF82Dx7fqYDMGKcFvdXtbLJ9k+TGNt4SIzYDyrrCNzamBzA+LeQ==
X-Received: by 2002:a05:6e02:1c04:b0:3d0:11ff:a782 with SMTP id
 e9e14a558f8ab-3d13dd447d5mr79695165ab.9.1739117266034; 
 Sun, 09 Feb 2025 08:07:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ecf2d08b0dsm354812173.59.2025.02.09.08.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 08:07:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2 3/6] test/py: Drop importing utils as util
Date: Sun,  9 Feb 2025 09:07:16 -0700
Message-ID: <20250209160725.1054845-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209160725.1054845-1-sjg@chromium.org>
References: <20250209160725.1054845-1-sjg@chromium.org>
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

Now that we have a shorter name, we don't need this sort of thing.
Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to drop importing utils as util

 test/py/tests/fit_util.py              |  6 +--
 test/py/tests/test_android/test_avb.py |  1 -
 test/py/tests/test_efi_fit.py          | 24 +++++----
 test/py/tests/test_event_dump.py       |  4 +-
 test/py/tests/test_fit.py              |  4 +-
 test/py/tests/test_fit_auto_signed.py  | 18 +++----
 test/py/tests/test_fit_ecdsa.py        | 16 +++---
 test/py/tests/test_fit_hashes.py       | 14 +++---
 test/py/tests/test_fs/conftest.py      |  1 -
 test/py/tests/test_kconfig.py          |  6 +--
 test/py/tests/test_of_migrate.py       | 14 +++---
 test/py/tests/test_ofplatdata.py       |  4 +-
 test/py/tests/test_optee_rpmb.py       |  2 +-
 test/py/tests/test_sandbox_opts.py     |  6 +--
 test/py/tests/test_scp03.py            |  2 +-
 test/py/tests/test_source.py           |  4 +-
 test/py/tests/test_trace.py            | 18 +++----
 test/py/tests/test_vboot.py            | 70 +++++++++++++-------------
 18 files changed, 110 insertions(+), 104 deletions(-)

diff --git a/test/py/tests/fit_util.py b/test/py/tests/fit_util.py
index 22b971131b8..f322b50a319 100644
--- a/test/py/tests/fit_util.py
+++ b/test/py/tests/fit_util.py
@@ -5,7 +5,7 @@
 
 import os
 
-import utils as util
+import utils
 
 def make_fname(ubman, basename):
     """Make a temporary filename
@@ -54,7 +54,7 @@ def make_fit(ubman, mkimage, base_its, params, basename='test.fit', base_fdt=Non
     """
     fit = make_fname(ubman, basename)
     its = make_its(ubman, base_its, params)
-    util.run_and_log(ubman, [mkimage, '-f', its, fit])
+    utils.run_and_log(ubman, [mkimage, '-f', its, fit])
     if base_fdt:
         with open(make_fname(ubman, 'u-boot.dts'), 'w') as fd:
             fd.write(base_fdt)
@@ -89,5 +89,5 @@ def make_dtb(ubman, base_fdt, basename):
     dtb = make_fname(ubman, f'{basename}.dtb')
     with open(src, 'w', encoding='utf-8') as outf:
         outf.write(base_fdt)
-    util.run_and_log(ubman, ['dtc', src, '-O', 'dtb', '-o', dtb])
+    utils.run_and_log(ubman, ['dtc', src, '-O', 'dtb', '-o', dtb])
     return dtb
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 1d600b95c6f..137d83e1dea 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -15,7 +15,6 @@ For configuration verification:
 """
 
 import pytest
-import utils as util
 
 # defauld mmc id
 mmc_dev = 1
diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index c836834845e..e7d523a77d5 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -55,7 +55,7 @@ env__efi_fit_tftp_file = {
 
 import os.path
 import pytest
-import utils as util
+import utils
 
 # Define the parametrized ITS data to be used for FIT images generation.
 ITS_DATA = '''
@@ -224,11 +224,11 @@ def test_efi_fit_launch(ubman):
         """
 
         bin_path = make_fpath(fname)
-        util.run_and_log(cons,
-                         ['cp', make_fpath('lib/efi_loader/helloworld.efi'),
-                          bin_path])
+        utils.run_and_log(cons,
+                          ['cp', make_fpath('lib/efi_loader/helloworld.efi'),
+                           bin_path])
         if comp:
-            util.run_and_log(cons, ['gzip', '-f', bin_path])
+            utils.run_and_log(cons, ['gzip', '-f', bin_path])
             bin_path += '.gz'
         return bin_path
 
@@ -257,9 +257,10 @@ def test_efi_fit_launch(ubman):
 
         # Build the test FDT.
         dtb = make_fpath('test-efi-fit-%s.dtb' % fdt_type)
-        util.run_and_log(cons, ['dtc', '-I', 'dts', '-O', 'dtb', '-o', dtb, dts])
+        utils.run_and_log(cons,
+                          ['dtc', '-I', 'dts', '-O', 'dtb', '-o', dtb, dts])
         if comp:
-            util.run_and_log(cons, ['gzip', '-f', dtb])
+            utils.run_and_log(cons, ['gzip', '-f', dtb])
             dtb += '.gz'
         return dtb
 
@@ -290,7 +291,7 @@ def test_efi_fit_launch(ubman):
 
         # Build the test ITS.
         fit_path = make_fpath('test-efi-fit-helloworld.fit')
-        util.run_and_log(
+        utils.run_and_log(
             cons, [make_fpath('tools/mkimage'), '-f', its_path, fit_path])
         return fit_path
 
@@ -307,7 +308,7 @@ def test_efi_fit_launch(ubman):
 
         addr = fit.get('addr', None)
         if not addr:
-            addr = util.find_ram_base(cons)
+            addr = utils.find_ram_base(cons)
 
         output = cons.run_command(
             'host load hostfs - %x %s/%s' % (addr, fit['dn'], fit['fn']))
@@ -334,7 +335,7 @@ def test_efi_fit_launch(ubman):
 
         addr = fit.get('addr', None)
         if not addr:
-            addr = util.find_ram_base(cons)
+            addr = utils.find_ram_base(cons)
 
         file_name = fit['fn']
         output = cons.run_command('tftpboot %x %s' % (addr, file_name))
@@ -412,7 +413,8 @@ def test_efi_fit_launch(ubman):
 
                 # Copy image to TFTP root directory.
                 if fit['dn'] != cons.config.build_dir:
-                    util.run_and_log(cons, ['mv', '-f', fit_path, '%s/' % fit['dn']])
+                    utils.run_and_log(cons,
+                                      ['mv', '-f', fit_path, '%s/' % fit['dn']])
 
             # Load FIT image.
             addr = load_fit_from_host(fit) if is_sandbox else load_fit_from_tftp(fit)
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index e516d2cb9be..52adced17b7 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -4,7 +4,7 @@
 
 import pytest
 import re
-import utils as util
+import utils
 
 # This is only a partial test - coverting 64-bit sandbox. It does not test
 # big-endian images, nor 32-bit images
@@ -13,7 +13,7 @@ def test_event_dump(ubman):
     """Test that the "help" command can be executed."""
     cons = ubman
     sandbox = cons.config.build_dir + '/u-boot'
-    out = util.run_and_log(cons, ['scripts/event_dump.py', sandbox])
+    out = utils.run_and_log(cons, ['scripts/event_dump.py', sandbox])
     expect = '''.*Event type            Id                              Source location
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 0f2d0940562..bfc20c4b1ed 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -6,7 +6,7 @@
 import os
 import pytest
 import struct
-import utils as util
+import utils
 import fit_util
 
 # Define a base ITS which we can adjust using % and a dictionary
@@ -165,7 +165,7 @@ def test_fit(ubman):
         return fname
 
     def make_compressed(filename):
-        util.run_and_log(cons, ['gzip', '-f', '-k', filename])
+        utils.run_and_log(cons, ['gzip', '-f', '-k', filename])
         return filename + '.gz'
 
     def find_matching(text, match):
diff --git a/test/py/tests/test_fit_auto_signed.py b/test/py/tests/test_fit_auto_signed.py
index bee93e4f084..b5f872f3d0f 100644
--- a/test/py/tests/test_fit_auto_signed.py
+++ b/test/py/tests/test_fit_auto_signed.py
@@ -17,7 +17,7 @@ The test does not run the sandbox. It only checks the host tool mkimage.
 
 import os
 import pytest
-import utils as util
+import utils
 import binascii
 from Cryptodome.Hash import SHA1
 from Cryptodome.Hash import SHA256
@@ -33,15 +33,15 @@ class SignedFitHelper(object):
         self.confgs_nodes = set()
 
     def __fdt_list(self, path):
-        return util.run_and_log(self.cons,
+        return utils.run_and_log(self.cons,
             f'fdtget -l {self.fit} {path}')
 
     def __fdt_get_string(self, node, prop):
-        return util.run_and_log(self.cons,
+        return utils.run_and_log(self.cons,
             f'fdtget -ts {self.fit} {node} {prop}')
 
     def __fdt_get_binary(self, node, prop):
-        numbers = util.run_and_log(self.cons,
+        numbers = utils.run_and_log(self.cons,
             f'fdtget -tbi {self.fit} {node} {prop}')
 
         bignum = bytearray()
@@ -166,7 +166,7 @@ def test_fit_auto_signed(ubman):
     s_args = " -k" + tempdir + " -g" + key_name + " -o" + sign_algo
 
     # 1 - Create auto FIT with images crc32 checksum, and verify it
-    util.run_and_log(cons, mkimage + ' -fauto' + b_args + " " + fit_file)
+    utils.run_and_log(cons, mkimage + ' -fauto' + b_args + " " + fit_file)
 
     fit = SignedFitHelper(cons, fit_file)
     if fit.build_nodes_sets() == 0:
@@ -175,8 +175,8 @@ def test_fit_auto_signed(ubman):
     fit.check_fit_crc32_images()
 
     # 2 - Create auto FIT with signed images, and verify it
-    util.run_and_log(cons, mkimage + ' -fauto' + b_args + s_args + " " +
-        fit_file)
+    utils.run_and_log(cons, mkimage + ' -fauto' + b_args + s_args + " " +
+                      fit_file)
 
     fit = SignedFitHelper(cons, fit_file)
     if fit.build_nodes_sets() == 0:
@@ -185,8 +185,8 @@ def test_fit_auto_signed(ubman):
     fit.check_fit_signed_images(key_name, sign_algo, verifier)
 
     # 3 - Create auto FIT with signed configs and hashed images, and verify it
-    util.run_and_log(cons, mkimage + ' -fauto-conf' + b_args + s_args + " " +
-        fit_file)
+    utils.run_and_log(cons, mkimage + ' -fauto-conf' + b_args + s_args + " " +
+                      fit_file)
 
     fit = SignedFitHelper(cons, fit_file)
     if fit.build_nodes_sets() == 0:
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 7b25c7779c6..63f2f6a44e6 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -12,7 +12,7 @@ This test doesn't run the sandbox. It only checks the host tool 'mkimage'
 
 import os
 import pytest
-import utils as util
+import utils
 from Cryptodome.Hash import SHA256
 from Cryptodome.PublicKey import ECC
 from Cryptodome.Signature import DSS
@@ -25,14 +25,16 @@ class SignableFitImage(object):
         self.signable_nodes = set()
 
     def __fdt_list(self, path):
-        return util.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
+        return utils.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
 
     def __fdt_set(self, node, **prop_value):
         for prop, value in prop_value.items():
-            util.run_and_log(self.cons, f'fdtput -ts {self.fit} {node} {prop} {value}')
+            utils.run_and_log(self.cons,
+                              f'fdtput -ts {self.fit} {node} {prop} {value}')
 
     def __fdt_get_binary(self, node, prop):
-        numbers = util.run_and_log(self.cons, f'fdtget -tbi {self.fit} {node} {prop}')
+        numbers = utils.run_and_log(self.cons,
+                                    f'fdtget -tbi {self.fit} {node} {prop}')
 
         bignum = bytearray()
         for little_num in numbers.split():
@@ -53,7 +55,7 @@ class SignableFitImage(object):
             self.__fdt_set(f'{image}/signature', algo='sha256,ecdsa256')
 
     def sign(self, mkimage, key_file):
-        util.run_and_log(self.cons, [mkimage, '-F', self.fit, f'-G{key_file}'])
+        utils.run_and_log(self.cons, [mkimage, '-F', self.fit, f'-G{key_file}'])
 
     def check_signatures(self, key):
         for image in self.signable_nodes:
@@ -76,11 +78,11 @@ def test_fit_ecdsa(ubman):
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
-        util.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
+        utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
 
     def dtc(dts):
         dtb = dts.replace('.dts', '.dtb')
-        util.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
+        utils.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
     cons = ubman
     mkimage = cons.config.build_dir + '/tools/mkimage'
diff --git a/test/py/tests/test_fit_hashes.py b/test/py/tests/test_fit_hashes.py
index 0b3c85f8e23..bcde045d6c8 100644
--- a/test/py/tests/test_fit_hashes.py
+++ b/test/py/tests/test_fit_hashes.py
@@ -12,7 +12,7 @@ This test doesn't run the sandbox. It only checks the host tool 'mkimage'
 
 import os
 import pytest
-import utils as util
+import utils
 
 kernel_hashes = {
     "sha512" : "f18c1486a2c29f56360301576cdfce4dfd8e8e932d0ed8e239a1f314b8ae1d77b2a58cd7fe32e4075e69448e623ce53b0b6aa6ce5626d2c189a5beae29a68d93",
@@ -32,14 +32,15 @@ class ReadonlyFitImage(object):
         self.hashable_nodes = set()
 
     def __fdt_list(self, path):
-        return util.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
+        return utils.run_and_log(self.cons, f'fdtget -l {self.fit} {path}')
 
     def __fdt_get(self, node, prop):
-        val = util.run_and_log(self.cons, f'fdtget {self.fit} {node} {prop}')
+        val = utils.run_and_log(self.cons, f'fdtget {self.fit} {node} {prop}')
         return val.rstrip('\n')
 
     def __fdt_get_sexadecimal(self, node, prop):
-        numbers = util.run_and_log(self.cons, f'fdtget -tbx {self.fit} {node} {prop}')
+        numbers = utils.run_and_log(self.cons,
+                                    f'fdtget -tbx {self.fit} {node} {prop}')
 
         sexadecimal = ''
         for num in numbers.rstrip('\n').split(' '):
@@ -85,11 +86,12 @@ def test_mkimage_hashes(ubman):
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
-        util.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
+        utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f', its, dest_fit])
 
     def dtc(dts):
         dtb = dts.replace('.dts', '.dtb')
-        util.run_and_log(cons, f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
+        utils.run_and_log(cons,
+                          f'dtc {datadir}/{dts} -O dtb -o {tempdir}/{dtb}')
 
     cons = ubman
     mkimage = cons.config.build_dir + '/tools/mkimage'
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index ea25cc75aac..cb432f93c4f 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -8,7 +8,6 @@ import pytest
 import re
 from subprocess import call, check_call, check_output, CalledProcessError
 from fstest_defs import *
-import utils as util
 # pylint: disable=E0611
 from tests import fs_helper
 
diff --git a/test/py/tests/test_kconfig.py b/test/py/tests/test_kconfig.py
index b4a28ec7a5a..a3796ea7e47 100644
--- a/test/py/tests/test_kconfig.py
+++ b/test/py/tests/test_kconfig.py
@@ -4,7 +4,7 @@
 
 import pytest
 
-import utils as util
+import utils
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_kconfig'
@@ -16,7 +16,7 @@ def test_kconfig(ubman):
     cons = ubman
 
     # This detects build errors in test/lib/kconfig.c
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', 'TEST_KCONFIG', '-o', TMPDIR], ignore_errors=True)
     assert 'invalid_use_of_IF_ENABLED_INT' in out
@@ -29,7 +29,7 @@ def test_kconfig_spl(ubman):
     cons = ubman
 
     # This detects build errors in test/lib/kconfig_spl.c
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox_spl',
                '-a', 'TEST_KCONFIG', '-o', TMPDIR], ignore_errors=True)
     assert 'invalid_use_of_IF_ENABLED_INT' in out
diff --git a/test/py/tests/test_of_migrate.py b/test/py/tests/test_of_migrate.py
index 1692cbc48bb..e866eebbfd4 100644
--- a/test/py/tests/test_of_migrate.py
+++ b/test/py/tests/test_of_migrate.py
@@ -7,7 +7,7 @@
 import os
 import pytest
 
-import utils as util
+import utils
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR1 = '/tmp/test_no_migrate'
@@ -33,8 +33,8 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
     dt_dir = os.path.join(build_dir, 'arch', 'sandbox', 'dts')
     orig_fname = os.path.join(dt_dir, 'sandbox.dtb')
     out_dts = os.path.join(dt_dir, 'sandbox_out.dts')
-    util.run_and_log(cons, ['dtc', orig_fname, '-I', 'dtb', '-O', 'dts',
-                            '-o', out_dts])
+    utils.run_and_log(cons, ['dtc', orig_fname, '-I', 'dtb', '-O', 'dts',
+                             '-o', out_dts])
 
     # Update it to use an old tag
     with open(out_dts) as inf:
@@ -45,7 +45,7 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
     with open(dts_fname, 'w') as outf:
         print(data, file=outf)
     dtb_fname = os.path.join(dt_dir, 'sandbox_oldtag.dtb')
-    util.run_and_log(cons, ['dtc', dts_fname, '-o', dtb_fname])
+    utils.run_and_log(cons, ['dtc', dts_fname, '-o', dtb_fname])
 
     migrate = ['-a', '~CONFIG_OF_TAG_MIGRATE'] if disable_migrate else []
 
@@ -54,7 +54,7 @@ def build_for_migrate(cons, replace_pair, board, tmpdir, disable_migrate=True):
     env['EXT_DTB'] = dtb_fname
     env['DEVICE_TREE'] = 'sandbox_new'
     env['NO_LTO'] = '1'  # Speed up build
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', board,
                *migrate, '-w', '-o', tmpdir], ignore_errors=True, env=env)
     return out
@@ -70,7 +70,7 @@ def test_of_no_migrate(ubman):
 
     # It should fail to run, since the lcd device will not be bound before
     # relocation. so won't get its frame-buffer memory
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, [os.path.join(TMPDIR1, 'u-boot'), '-D', '-c', 'help'],
         ignore_errors=True)
     assert "Video device 'lcd' cannot allocate frame buffer memory" in out
@@ -102,7 +102,7 @@ def test_of_migrate(ubman):
                       'sandbox', TMPDIR3, disable_migrate=False)
 
     # It should show a migration message
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, [os.path.join(TMPDIR3, 'u-boot'), '-D', '-c', 'help'],
         ignore_errors=True)
     assert "Warning: Device tree includes old 'u-boot,dm-' tags" in out
diff --git a/test/py/tests/test_ofplatdata.py b/test/py/tests/test_ofplatdata.py
index d414a910d9f..b4d2db03deb 100644
--- a/test/py/tests/test_ofplatdata.py
+++ b/test/py/tests/test_ofplatdata.py
@@ -2,7 +2,7 @@
 # Copyright (c) 2016 Google, Inc
 
 import pytest
-import utils as util
+import utils
 
 @pytest.mark.boardspec('sandbox_spl')
 @pytest.mark.buildconfigspec('spl_of_platdata')
@@ -11,7 +11,7 @@ def test_spl_devicetree(ubman):
     cons = ubman
     dtb = cons.config.build_dir + '/spl/u-boot-spl.dtb'
     fdtgrep = cons.config.build_dir + '/tools/fdtgrep'
-    output = util.run_and_log(cons, [fdtgrep, '-l', dtb])
+    output = utils.run_and_log(cons, [fdtgrep, '-l', dtb])
 
     assert "bootph-all" not in output
     assert "bootph-some-ram" not in output
diff --git a/test/py/tests/test_optee_rpmb.py b/test/py/tests/test_optee_rpmb.py
index 1ef1c117d27..04b3b5e41ef 100644
--- a/test/py/tests/test_optee_rpmb.py
+++ b/test/py/tests/test_optee_rpmb.py
@@ -7,7 +7,7 @@ This tests optee_rpmb cmd in U-Boot
 """
 
 import pytest
-import utils as util
+import utils
 
 @pytest.mark.buildconfigspec('cmd_optee_rpmb')
 def test_optee_rpmb_read_write(ubman):
diff --git a/test/py/tests/test_sandbox_opts.py b/test/py/tests/test_sandbox_opts.py
index 16901409172..f50302cbe6b 100644
--- a/test/py/tests/test_sandbox_opts.py
+++ b/test/py/tests/test_sandbox_opts.py
@@ -4,7 +4,7 @@
 
 import pytest
 
-import utils as util
+import utils
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_cmdline'
@@ -15,7 +15,7 @@ def test_sandbox_cmdline(ubman):
     """Test building sandbox without CONFIG_CMDLINE"""
     cons = ubman
 
-    out = util.run_and_log(
+    utils.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', '~CMDLINE', '-o', TMPDIR])
 
@@ -25,6 +25,6 @@ def test_sandbox_lto(ubman):
     """Test building sandbox without CONFIG_LTO"""
     cons = ubman
 
-    out = util.run_and_log(
+    utils.run_and_log(
         cons, ['./tools/buildman/buildman', '-m', '--board', 'sandbox',
                '-a', '~LTO', '-o', TMPDIR])
diff --git a/test/py/tests/test_scp03.py b/test/py/tests/test_scp03.py
index 296d7c7d953..414b4251a69 100644
--- a/test/py/tests/test_scp03.py
+++ b/test/py/tests/test_scp03.py
@@ -11,7 +11,7 @@ For additional details check doc/usage/scp03.rst
 """
 
 import pytest
-import utils as util
+import utils
 
 @pytest.mark.buildconfigspec('cmd_scp03')
 def test_scp03(ubman):
diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
index 60013e438ba..f0437aa15ca 100644
--- a/test/py/tests/test_source.py
+++ b/test/py/tests/test_source.py
@@ -3,7 +3,7 @@
 
 import os
 import pytest
-import utils as util
+import utils
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_echo')
@@ -15,7 +15,7 @@ def test_source(ubman):
     mkimage = os.path.join(cons.config.build_dir, 'tools/mkimage')
     its = os.path.join(cons.config.source_dir, 'test/py/tests/source.its')
     fit = os.path.join(cons.config.build_dir, 'source.itb')
-    util.run_and_log(cons, (mkimage, '-f', its, fit))
+    utils.run_and_log(cons, (mkimage, '-f', its, fit))
     cons.run_command(f'host load hostfs - $loadaddr {fit}')
 
     assert '2' in cons.run_command('source')
diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 26ca017103e..3f3105ebf9a 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -6,7 +6,7 @@ import os
 import pytest
 import re
 
-import utils as util
+import utils
 
 # This is needed for Azure, since the default '..' directory is not writeable
 TMPDIR = '/tmp/test_trace'
@@ -80,12 +80,12 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
         map_fname (str): Filename of System.map
         trace_dat (str): Filename of output file
     """
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
                'dump-ftrace'])
 
     # Check that trace-cmd can read it
-    out = util.run_and_log(cons, ['trace-cmd', 'dump', trace_dat])
+    out = utils.run_and_log(cons, ['trace-cmd', 'dump', trace_dat])
 
     # Tracing meta data in file /tmp/test_trace/trace.dat:
     #    [Initial format]
@@ -114,7 +114,7 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
 
     # Check that the trace has something useful
     cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_|initr_)'"
-    out = util.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(cons, ['sh', '-c', cmd])
 
     # Format:
     #      u-boot-1     0.....    60.805596: function:             initf_malloc
@@ -156,13 +156,13 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     """
 
     # Generate the funcgraph format
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
                'dump-ftrace', '-f', 'funcgraph'])
 
     # Check that the trace has what we expect
     cmd = f'trace-cmd report -l {trace_dat} |head -n 70'
-    out = util.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(cons, ['sh', '-c', cmd])
 
     # First look for this:
     #  u-boot-1     0.....   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
@@ -204,7 +204,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
     cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_dm|dm_timer_init)'"
-    out = util.run_and_log(cons, ['sh', '-c', cmd])
+    out = utils.run_and_log(cons, ['sh', '-c', cmd])
 
     start_timestamp = None
     end_timestamp = None
@@ -241,7 +241,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
     """
 
     # Generate the flamegraph format
-    out = util.run_and_log(
+    out = utils.run_and_log(
         cons, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
                'dump-flamegraph'])
 
@@ -258,7 +258,7 @@ def check_flamegraph(cons, fname, proftool, map_fname, trace_fg):
     assert found == 2
 
     # Generate the timing graph
-    out = util.run_and_log(
+    utils.run_and_log(
         cons, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
                'dump-flamegraph', '-f', 'timing'])
 
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 691c6e6b839..2b29871b7d4 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -42,7 +42,7 @@ import os
 import shutil
 import struct
 import pytest
-import utils as util
+import utils
 import vboot_forge
 import vboot_evil
 
@@ -62,8 +62,8 @@ def dtc(dts, cons, dtc_args, datadir, tmpdir, dtb):
         dtb: Resulting DTB file.
     """
     dtb = dts.replace('.dts', '.dtb')
-    util.run_and_log(cons, 'dtc %s %s%s -O dtb '
-                     '-o %s%s' % (dtc_args, datadir, dts, tmpdir, dtb))
+    utils.run_and_log(cons, 'dtc %s %s%s -O dtb '
+                      '-o %s%s' % (dtc_args, datadir, dts, tmpdir, dtb))
 
 def make_fit(its, cons, mkimage, dtc_args, datadir, fit):
     """Make a new FIT from the .its source file.
@@ -78,8 +78,8 @@ def make_fit(its, cons, mkimage, dtc_args, datadir, fit):
         datadir: Path to data directory.
         fit: Resulting FIT file.
     """
-    util.run_and_log(cons, [mkimage, '-D', dtc_args, '-f',
-                            '%s%s' % (datadir, its), fit])
+    utils.run_and_log(cons, [mkimage, '-D', dtc_args, '-f',
+                             '%s%s' % (datadir, its), fit])
 
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
@@ -134,8 +134,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             options: Options provided to the compiler.
         """
         dtb = dts.replace('.dts', '.dtb')
-        util.run_and_log(cons, 'dtc %s %s%s -O dtb '
-                         '-o %s%s %s' % (dtc_args, datadir, dts, tmpdir, dtb, options))
+        utils.run_and_log(cons, 'dtc %s %s%s -O dtb -o %s%s %s' %
+                          (dtc_args, datadir, dts, tmpdir, dtb, options))
 
     def run_binman(dtb):
         """Run binman to build an image
@@ -145,9 +145,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         """
         pythonpath = os.environ.get('PYTHONPATH', '')
         os.environ['PYTHONPATH'] = pythonpath + ':' + '%s/../scripts/dtc/pylibfdt' % tmpdir
-        util.run_and_log(cons, [binman, 'build', '-d', "%s/%s" % (tmpdir,dtb),
-                                '-a', "pre-load-key-path=%s" % tmpdir, '-O',
-                                tmpdir, '-I', tmpdir])
+        utils.run_and_log(cons, [binman, 'build', '-d', "%s/%s" % (tmpdir,dtb),
+                                 '-a', "pre-load-key-path=%s" % tmpdir, '-O',
+                                 tmpdir, '-I', tmpdir])
         os.environ['PYTHONPATH'] = pythonpath
 
     def run_bootm(sha_algo, test_type, expect_string, boots, fit=None):
@@ -195,7 +195,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if options:
             args += options.split(' ')
         cons.log.action('%s: Sign images' % sha_algo)
-        util.run_and_log(cons, args)
+        utils.run_and_log(cons, args)
 
     def sign_fit_dtb(sha_algo, options, dtb):
         """Sign the FIT
@@ -212,7 +212,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if options:
             args += options.split(' ')
         cons.log.action('%s: Sign images' % sha_algo)
-        util.run_and_log(cons, args)
+        utils.run_and_log(cons, args)
 
     def sign_fit_norequire(sha_algo, options):
         """Sign the FIT
@@ -229,7 +229,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if options:
             args += options.split(' ')
         cons.log.action('%s: Sign images' % sha_algo)
-        util.run_and_log(cons, args)
+        utils.run_and_log(cons, args)
 
     def replace_fit_totalsize(size):
         """Replace FIT header's totalsize with something greater.
@@ -278,14 +278,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         else:
             rsa_keygen_bits = 2048
 
-        util.run_and_log(cons, 'openssl genpkey -algorithm RSA -out %s%s.key '
+        utils.run_and_log(cons, 'openssl genpkey -algorithm RSA -out %s%s.key '
                      '-pkeyopt rsa_keygen_bits:%d '
                      '-pkeyopt rsa_keygen_pubexp:%d' %
                      (tmpdir, name, rsa_keygen_bits, public_exponent))
 
         # Create a certificate containing the public key
-        util.run_and_log(cons, 'openssl req -batch -new -x509 -key %s%s.key '
-                         '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+        utils.run_and_log(cons, 'openssl req -batch -new -x509 -key %s%s.key '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
     def test_with_algo(sha_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
@@ -328,7 +328,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         cons.log.action('%s: Check signed config on the host' % sha_algo)
 
-        util.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
+        utils.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
 
         if full_test:
             # Make sure that U-Boot checks that the config is in the list of
@@ -340,7 +340,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             root, strblock = vboot_forge.manipulate(root, strblock)
             with open(ffit, 'w+b') as fd:
                 vboot_forge.write_fdt(root, strblock, fd)
-            util.run_and_log_expect_exception(
+            utils.run_and_log_expect_exception(
                 cons, [fit_check_sign, '-f', ffit, '-k', dtb],
                 1, 'Failed to verify required signature')
 
@@ -351,7 +351,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             shutil.copyfile(fit, efit)
             vboot_evil.add_evil_node(fit, efit, evil_kernel, 'fakeroot')
 
-            util.run_and_log_expect_exception(
+            utils.run_and_log_expect_exception(
                 cons, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, 'Failed to verify required signature')
             run_bootm(sha_algo, 'evil fakeroot', 'Bad FIT kernel image format',
@@ -363,7 +363,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             vboot_evil.add_evil_node(fit, efit, evil_kernel, 'kernel@')
 
             msg = 'Signature checking prevents use of unit addresses (@) in nodes'
-            util.run_and_log_expect_exception(
+            utils.run_and_log_expect_exception(
                 cons, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, msg)
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
@@ -384,20 +384,20 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         cons.log.action('%s: Check default FIT header totalsize' % sha_algo)
 
         # Increment the first byte of the signature, which should cause failure
-        sig = util.run_and_log(cons, 'fdtget -t bx %s %s value' %
-                               (fit, sig_node))
+        sig = utils.run_and_log(cons, 'fdtget -t bx %s %s value' %
+                                (fit, sig_node))
         byte_list = sig.split()
         byte = int(byte_list[0], 16)
         byte_list[0] = '%x' % (byte + 1)
         sig = ' '.join(byte_list)
-        util.run_and_log(cons, 'fdtput -t bx %s %s value %s' %
-                         (fit, sig_node, sig))
+        utils.run_and_log(cons, 'fdtput -t bx %s %s value %s' %
+                          (fit, sig_node, sig))
 
         run_bootm(sha_algo, 'Signed config with bad hash', 'Bad Data Hash',
                   False)
 
         cons.log.action('%s: Check bad config on the host' % sha_algo)
-        util.run_and_log_expect_exception(
+        utils.run_and_log_expect_exception(
             cons, [fit_check_sign, '-f', fit, '-k', dtb],
             1, 'Failed to verify required signature')
 
@@ -449,8 +449,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should be accepted by
         # U-Boot because the dev key is required and policy is "any" required key.
-        util.run_and_log(cons, 'fdtput -t s %s /signature required-mode any' %
-                         (dtb))
+        utils.run_and_log(cons, 'fdtput -t s %s /signature required-mode any' %
+                          dtb)
         run_bootm(sha_algo, 'multi required key', 'dev+', True)
 
         # Set the required-mode policy to "all".
@@ -459,8 +459,8 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         # a dev signature only (sign_fit() overwrites the FIT).
         # Try to boot the FIT with dev key. This FIT should not be accepted by
         # U-Boot because the prod key is required and policy is "all" required key
-        util.run_and_log(cons, 'fdtput -t s %s /signature required-mode all' %
-                         (dtb))
+        utils.run_and_log(cons, 'fdtput -t s %s /signature required-mode all' %
+                          dtb)
         run_bootm(sha_algo, 'multi required key', '', False)
 
     def test_global_sign(sha_algo, padding, sign_options):
@@ -594,7 +594,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         if options:
             args += options.split(' ')
         cons.log.action('%s: Sign images' % sha_algo)
-        util.run_and_log(cons, args)
+        utils.run_and_log(cons, args)
 
     def test_add_pubkey(sha_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
@@ -613,9 +613,11 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
 
         cons.log.action('%s: Test fdt_add_pubkey with signed configuration' % sha_algo)
         # Then add the dev key via the fdt_add_pubkey tool
-        util.run_and_log(cons, [fdt_add_pubkey, '-a', '%s,%s' % ('sha256' if algo_arg else sha_algo, \
-                                'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
-                                '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
+        utils.run_and_log(cons,
+                          [fdt_add_pubkey, '-a', '%s,%s' %
+                           ('sha256' if algo_arg else sha_algo,
+                            'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
+                           '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
         make_fit('sign-configs-%s%s.its' % (sha_algo, padding), cons, mkimage, dtc_args, datadir, fit)
 
@@ -623,7 +625,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         sign_fit(sha_algo, sign_options)
 
         # Check with fit_check_sign that FIT is signed with key
-        util.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
+        utils.run_and_log(cons, [fit_check_sign, '-f', fit, '-k', dtb])
 
     cons = ubman
     tmpdir = os.path.join(cons.config.result_dir, name) + '/'
-- 
2.43.0

