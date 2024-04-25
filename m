Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15163C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844E089082;
	Fri, 26 Apr 2024 01:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086102;
	bh=G+w1lCXKPy4x+Q/D46mDRJMPEtWCuJYfWy47IQo2Szo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UyYVqaWMeA9yC83smy6rdCqRXhJcoLnezQA6P5EzsaoSEL5Vb8kTYtZNyJokwPvuX
	 baQ6rzVpYyo63tBeCWjS9e28SWYvQB6iiq7Gm+85EWQsTCxEmvcoff4RRYG++8/dlw
	 B8ENmZZpnjb7ZRC5OY2ncXz90McreWPtKdS4HxmcIXu4Yu0uCRjTKDQFm9GPmgVD/3
	 2XUF96XfzgPizar5p0ivgAYyT6uXSCaBUz1qfSf0HStCnkdANBEY8r3zNCHp18q+mO
	 4rVfCCLZGZlza1jZEoELq2L5mEqr8etTELpVmbbX0oCRibVngJOtmhW5gnTmh9jp/b
	 4f2buMGVSOJhA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 28965886E3;
 Fri, 26 Apr 2024 01:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086101;
 bh=G+w1lCXKPy4x+Q/D46mDRJMPEtWCuJYfWy47IQo2Szo=;
 h=From:To:Cc:Subject:Date:From;
 b=Fo/yZJk9rUzby4y9DKZQW3Fpv7nrSFEc5//Tpl/G+OlWrToBTf4aR5ysKnxLk2GpF
 5MgsWUtpcZ7AiERD36Oj9ephpyoJZEOjWV/l6neFaTMsRjgkazFoIDtZC8M56SWUfB
 aczMi17BqV8X0raZuBB3TfizvLQ4nkuDiA9F8W6PmMuoQ8Z6TUBluT/X/6Z20Y60ic
 vOP2VH/uECCkCFnS1esgf8YyFl9EYX9wj8tV2mWf7+5PB1UCUKBJNbAPkOk18nhZ02
 dsmS6GUZHqMNGOwHfnCnKAkeHJ1+XVZJAMfrdykJ7xMmPE7BlFsXIrIychU9lMYROq
 O6odS2ydvY2FQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
Subject: [PATCH v2 1/3] binman: Add nxp_imx8mimage etype
Date: Fri, 26 Apr 2024 01:00:35 +0200
Message-ID: <20240425230102.497160-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Add new binman etype derived from mkimage etype which generates configuration
input file for mkimage -T imx8mimage, and runs the mkimage on input data. The
mkimage -T imx8mimage is used to generate combined image with SPL and DDR PHY
blobs which is bootable on i.MX8M.

The configuration file generated here is equivalent of imx8mimage.cfg, which
is the file passed to '$ mkimage -T imx8mimage -n imx8mimage.cfg ...' . The
settings generated into the imx8mimage.cfg file are configured via supported
binman DT properties, nxp,boot-from, nxp,loader-address, nxp,rom-version.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: kernel@puri.sm
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
V2: Fix pylint errors
---
 tools/binman/etype/nxp_imx8mimage.py | 74 ++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/binman/etype/nxp_imx8mimage.py

diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
new file mode 100644
index 00000000000..3585120b79b
--- /dev/null
+++ b/tools/binman/etype/nxp_imx8mimage.py
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2023-2024 Marek Vasut <marex@denx.de>
+# Written with much help from Simon Glass <sjg@chromium.org>
+#
+# Entry-type module for generating the i.MX8M mkimage -T imx8mimage
+# configuration file and invocation of mkimage -T imx8mimage on the
+# configuration file and input data.
+#
+
+from collections import OrderedDict
+
+from binman.entry import Entry
+from binman.etype.mkimage import Entry_mkimage
+from binman.etype.section import Entry_section
+from binman import elf
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_nxp_imx8mimage(Entry_mkimage):
+    """NXP i.MX8M imx8mimage .cfg file generator and mkimage invoker
+
+    Properties / Entry arguments:
+        - nxp,boot-from - device to boot from (e.g. 'sd')
+        - nxp,loader-address - loader address (SPL text base)
+        - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.required_props = ['nxp,boot-from', 'nxp,rom-version', 'nxp,loader-address']
+
+    def ReadNode(self):
+        super().ReadNode()
+        self.boot_from = fdt_util.GetString(self._node, 'nxp,boot-from')
+        self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
+        self.rom_version = fdt_util.GetInt(self._node, 'nxp,rom-version')
+        self.ReadEntries()
+
+    def BuildSectionData(self, required):
+        data, input_fname, uniq = self.collect_contents_to_file(
+            self._entries.values(), 'input')
+        # Generate mkimage configuration file similar to imx8mimage.cfg
+        # and pass it to mkimage to generate SPL image for us here.
+        cfg_fname = tools.get_output_filename('nxp.imx8mimage.cfg.%s' % uniq)
+        with open(cfg_fname, 'w') as outf:
+            print('ROM_VERSION v%d' % self.rom_version, file=outf)
+            print('BOOT_FROM %s' % self.boot_from, file=outf)
+            print('LOADER %s %#x' % (input_fname, self.loader_address), file=outf)
+
+        output_fname = tools.get_output_filename(f'cfg-out.{uniq}')
+        args = ['-d', input_fname, '-n', cfg_fname, '-T', 'imx8mimage',
+                output_fname]
+        if self.mkimage.run_cmd(*args) is not None:
+            return tools.read_file(output_fname)
+        else:
+            # Bintool is missing; just use the input data as the output
+            self.record_missing_bintool(self.mkimage)
+            return data
+
+    def SetImagePos(self, image_pos):
+        # Customized SoC specific SetImagePos which skips the mkimage etype
+        # implementation and removes the 0x48 offset introduced there. That
+        # offset is only used for uImage/fitImage, which is not the case in
+        # here.
+        upto = 0x00
+        for entry in super().GetEntries().values():
+            entry.SetOffsetSize(upto, None)
+
+            # Give up if any entries lack a size
+            if entry.size is None:
+                return
+            upto += entry.size
+
+        Entry_section.SetImagePos(self, image_pos)
-- 
2.43.0

