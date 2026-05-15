Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1423DCD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01467848F3;
	Sat, 16 May 2026 03:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B908488B; Sat, 16 May 2026 01:39:04 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A358480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wO279-000000004l9-1104; Fri, 15 May 2026 23:38:43 +0000
Date: Sat, 16 May 2026 00:38:39 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Daniel Golle <daniel@makrotopia.org>, Anshul Dalal <anshuld@ti.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Shiji Yang <yangshiji66@outlook.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v5 7/8] test: py: add mkimage dm-verity round-trip test
Message-ID: <0d42718e936000ed4214bb2e82b7bc9ea26cfe4a.1778887196.git.daniel@makrotopia.org>
References: <cover.1778887196.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778887196.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Sat, 16 May 2026 03:04:00 +0200
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

Add test/py/tests/test_fit_verity.py covering:
 - mkimage writes correct dm-verity properties for matched and
   mismatched block sizes (4096/4096 and 4096/1024);
 - veritysetup verify re-checks the digest against the .itb's
   external data section;
 - mkimage rejects dm-verity images built without -E.

All tests are skipped if veritysetup is not installed on the host.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: no changes
v4:
 * verify the computed digest with veritysetup verify against the
   external data section
 * parametrize test_mkimage_verity with matched and mismatched
   block sizes to exercise hash-start-block != num-data-blocks
 * use run_and_log_expect_exception() with the expected diagnostic
   for the no-external-data case
v3: drop unused 'struct' import and the home-rolled have_veritysetup()
    helper; use @pytest.mark.requiredtool('veritysetup') instead
v2: new patch
---
 test/py/tests/test_fit_verity.py | 175 +++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 test/py/tests/test_fit_verity.py

diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
new file mode 100644
index 00000000000..5952c189858
--- /dev/null
+++ b/test/py/tests/test_fit_verity.py
@@ -0,0 +1,175 @@
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
+The computed digest is then re-verified by running ``veritysetup verify``
+against the external data section of the .itb.
+
+This test does not run the sandbox. It only exercises the host tool 'mkimage'.
+Requires 'veritysetup' from the cryptsetup package on the build host.
+"""
+
+import os
+import struct
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
+                data-block-size = <%d>;
+                hash-block-size = <%d>;
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
+def _fdt_totalsize(path):
+    """Read the totalsize field from an FDT header (offset 4, big-endian u32)."""
+    with open(path, 'rb') as f:
+        magic, totalsize = struct.unpack('>II', f.read(8))
+    assert magic == 0xd00dfeed, f'not an FDT: magic={magic:#x}'
+    return totalsize
+
+
+def _run_round_trip(ubman, tempdir, data_block_size, hash_block_size):
+    """Build a FIT with dm-verity, verify written properties, re-verify with veritysetup."""
+    mkimage = ubman.config.build_dir + '/tools/mkimage'
+
+    rootfs_file = os.path.join(tempdir, 'rootfs.bin')
+    its_file = os.path.join(tempdir, 'image.its')
+    fit_file = os.path.join(tempdir, 'image.itb')
+
+    # 64 data blocks of 0xa5
+    num_blocks = 64
+    data_size = data_block_size * num_blocks
+    with open(rootfs_file, 'wb') as f:
+        f.write(bytes([0xa5]) * data_size)
+
+    with open(its_file, 'w') as f:
+        f.write(ITS_TEMPLATE % (data_block_size, hash_block_size))
+
+    dtc_args = f'-I dts -O dtb -i {tempdir}'
+    utils.run_and_log(ubman,
+                      [mkimage, '-E', '-D', dtc_args, '-f', its_file, fit_file])
+
+    def fdt_get(node, prop):
+        val = utils.run_and_log(ubman, f'fdtget {fit_file} {node} {prop}')
+        return val.strip()
+
+    def fdt_get_hex(node, prop):
+        val = utils.run_and_log(ubman, f'fdtget -tbx {fit_file} {node} {prop}')
+        return ''.join(b.zfill(2) for b in val.strip().split())
+
+    verity_path = '/images/rootfs/dm-verity'
+
+    assert fdt_get(verity_path, 'algo') == 'sha256'
+    assert int(fdt_get(verity_path, 'data-block-size')) == data_block_size
+    assert int(fdt_get(verity_path, 'hash-block-size')) == hash_block_size
+
+    nblk = int(fdt_get(verity_path, 'num-data-blocks'))
+    assert nblk == num_blocks, f'num-data-blocks {nblk} != {num_blocks}'
+
+    hblk = int(fdt_get(verity_path, 'hash-start-block'))
+    # With --no-superblock, hash-start-block = data_size / hash-block-size
+    assert hblk == data_size // hash_block_size, \
+        f'hash-start-block {hblk} != {data_size // hash_block_size}'
+
+    digest = fdt_get_hex(verity_path, 'digest')
+    assert len(digest) == 64 and digest != '0' * 64
+    salt = fdt_get_hex(verity_path, 'salt')
+    assert len(salt) == 64
+
+    # Re-verify the digest with veritysetup against the .itb's external data.
+    # With -E, image data sits after the FIT FDT at (fdt_totalsize + data-offset).
+    data_offset = int(fdt_get('/images/rootfs', 'data-offset'))
+    data_size_full = int(fdt_get('/images/rootfs', 'data-size'))
+    ext_pos = _fdt_totalsize(fit_file) + data_offset
+    expanded = os.path.join(tempdir, 'expanded.bin')
+    with open(fit_file, 'rb') as src, open(expanded, 'wb') as dst:
+        src.seek(ext_pos)
+        dst.write(src.read(data_size_full))
+
+    utils.run_and_log(ubman, [
+        'veritysetup', 'verify', expanded, expanded, digest,
+        '--no-superblock',
+        f'--data-block-size={data_block_size}',
+        f'--hash-block-size={hash_block_size}',
+        f'--data-blocks={nblk}',
+        '--hash=sha256',
+        f'--salt={salt}',
+        f'--hash-offset={data_size}',
+    ])
+
+
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtget')
+@pytest.mark.requiredtool('veritysetup')
+@pytest.mark.parametrize('data_block_size,hash_block_size,subdir', [
+    (4096, 4096, 'verity-equal'),
+    (4096, 1024, 'verity-unequal'),
+])
+def test_mkimage_verity(ubman, data_block_size, hash_block_size, subdir):
+    """mkimage writes correct dm-verity properties and the digest verifies.
+
+    Run with matching and mismatched block sizes so the
+    ``hash-start-block != num-data-blocks`` path is exercised.
+    """
+    tempdir = os.path.join(ubman.config.result_dir, subdir)
+    os.makedirs(tempdir, exist_ok=True)
+    _run_round_trip(ubman, tempdir, data_block_size, hash_block_size)
+
+
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('veritysetup')
+def test_mkimage_verity_requires_external(ubman):
+    """mkimage rejects dm-verity without -E with the expected diagnostic."""
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
+        f.write(ITS_TEMPLATE % (4096, 4096))
+
+    dtc_args = f'-I dts -O dtb -i {tempdir}'
+    utils.run_and_log_expect_exception(
+        ubman,
+        [mkimage, '-D', dtc_args, '-f', its_file, fit_file],
+        1, 'dm-verity requires external data')
-- 
2.54.0
