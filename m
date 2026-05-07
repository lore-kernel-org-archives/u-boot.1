Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42983CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4732B84BED;
	Thu,  7 May 2026 18:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B5B84BC7; Thu,  7 May 2026 18:43:58 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F99E84BEA
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wL1p7-000000006jG-3CAs; Thu, 07 May 2026 16:43:41 +0000
Date: Thu, 7 May 2026 17:43:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v3 7/7] test: py: add mkimage dm-verity round-trip test
Message-ID: <71ddfdd634aec7fc931f43f3b6c587774aa718a0.1778171184.git.daniel@makrotopia.org>
References: <cover.1778171184.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778171184.git.daniel@makrotopia.org>
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

Add test/py/tests/test_fit_verity.py with two tests.

Both tests are skipped if veritysetup is not installed on the host.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: drop unused 'struct' import and the home-rolled have_veritysetup()
    helper; use @pytest.mark.requiredtool('veritysetup') instead
v2: new patch

 test/py/tests/test_fit_verity.py | 145 +++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 test/py/tests/test_fit_verity.py

diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
new file mode 100644
index 00000000000..b18c569d318
--- /dev/null
+++ b/test/py/tests/test_fit_verity.py
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2026 Daniel Golle <daniel@makrotopia.org>
+
+"""
+Test mkimage dm-verity Merkle-tree generation
+
+Build a minimal .its with a dm-verity subnode (user-provided properties only),
+run mkimage -E, and verify that the computed properties (digest, salt,
+num-data-blocks, hash-start-block) are written into the resulting FIT.
+
+This test does not run the sandbox.  It only exercises the host tool 'mkimage'.
+Requires 'veritysetup' from the cryptsetup package on the build host.
+"""
+
+import os
+import pytest
+import utils
+
+ITS_TEMPLATE = """\
+/dts-v1/;
+
+/ {
+    description = "dm-verity test";
+    #address-cells = <1>;
+
+    images {
+        rootfs {
+            description = "test filesystem";
+            data = /incbin/("./rootfs.bin");
+            type = "filesystem";
+            arch = "sandbox";
+            compression = "none";
+
+            dm-verity {
+                algo = "sha256";
+                data-block-size = <4096>;
+                hash-block-size = <4096>;
+            };
+        };
+    };
+
+    configurations {
+        default = "conf-1";
+        conf-1 {
+            description = "test config";
+            loadables = "rootfs";
+        };
+    };
+};
+"""
+
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('veritysetup')
+def test_mkimage_verity(ubman):
+    """Test that mkimage computes dm-verity properties correctly."""
+
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    tempdir = os.path.join(ubman.config.result_dir, 'verity')
+    os.makedirs(tempdir, exist_ok=True)
+
+    rootfs_file = os.path.join(tempdir, 'rootfs.bin')
+    its_file = os.path.join(tempdir, 'image.its')
+    fit_file = os.path.join(tempdir, 'image.itb')
+
+    # Create a dummy filesystem image: 64 x 4096-byte blocks of 0xa5
+    block_size = 4096
+    num_blocks = 64
+    with open(rootfs_file, 'wb') as f:
+        f.write(bytes([0xa5]) * block_size * num_blocks)
+
+    with open(its_file, 'w') as f:
+        f.write(ITS_TEMPLATE)
+
+    # Build the FIT with external data (required for dm-verity)
+    dtc_args = f'-I dts -O dtb -i {tempdir}'
+    utils.run_and_log(ubman,
+                      [mkimage, '-E', '-D', dtc_args, '-f', its_file, fit_file])
+
+    # Helper to read FIT properties via fdtget
+    def fdt_get(node, prop):
+        val = utils.run_and_log(
+            ubman, f'fdtget {fit_file} {node} {prop}')
+        return val.strip()
+
+    def fdt_get_hex(node, prop):
+        """Read a byte-array property as hex string."""
+        val = utils.run_and_log(
+            ubman, f'fdtget -tbx {fit_file} {node} {prop}')
+        return ''.join(b.zfill(2) for b in val.strip().split())
+
+    verity_path = '/images/rootfs/dm-verity'
+
+    # Verify mkimage filled in the computed properties
+    algo = fdt_get(verity_path, 'algo')
+    assert algo == 'sha256', f'algo mismatch: {algo}'
+
+    dbs = int(fdt_get(verity_path, 'data-block-size'))
+    assert dbs == block_size, f'data-block-size mismatch: {dbs}'
+
+    hbs = int(fdt_get(verity_path, 'hash-block-size'))
+    assert hbs == block_size, f'hash-block-size mismatch: {hbs}'
+
+    nblk = int(fdt_get(verity_path, 'num-data-blocks'))
+    assert nblk == num_blocks, f'num-data-blocks mismatch: {nblk} != {num_blocks}'
+
+    hblk = int(fdt_get(verity_path, 'hash-start-block'))
+    # With --no-superblock, hash-start-block == num-data-blocks
+    assert hblk == num_blocks, f'hash-start-block mismatch: {hblk} != {num_blocks}'
+
+    # digest and salt should be non-empty hex strings (sha256 = 32 bytes = 64 hex chars)
+    digest = fdt_get_hex(verity_path, 'digest')
+    assert len(digest) == 64, f'digest length mismatch: {len(digest)} (expected 64)'
+    # Should not be all zeros
+    assert digest != '0' * 64, 'digest is all zeros'
+
+    salt = fdt_get_hex(verity_path, 'salt')
+    assert len(salt) == 64, f'salt length mismatch: {len(salt)} (expected 64)'
+
+
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('veritysetup')
+def test_mkimage_verity_requires_external(ubman):
+    """Test that mkimage rejects dm-verity without -E flag."""
+
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+    tempdir = os.path.join(ubman.config.result_dir, 'verity_no_ext')
+    os.makedirs(tempdir, exist_ok=True)
+
+    rootfs_file = os.path.join(tempdir, 'rootfs.bin')
+    its_file = os.path.join(tempdir, 'image.its')
+    fit_file = os.path.join(tempdir, 'image.itb')
+
+    with open(rootfs_file, 'wb') as f:
+        f.write(bytes([0xa5]) * 4096 * 8)
+
+    with open(its_file, 'w') as f:
+        f.write(ITS_TEMPLATE)
+
+    # Without -E, mkimage should fail for dm-verity images
+    dtc_args = f'-I dts -O dtb -i {tempdir}'
+    with pytest.raises(Exception):
+        utils.run_and_log(ubman,
+                          [mkimage, '-D', dtc_args, '-f', its_file, fit_file])
-- 
2.54.0
