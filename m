Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF980CD8C9F
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5D184704;
	Mon,  8 Jun 2026 01:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oAMHJv4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E5483314; Mon,  8 Jun 2026 01:05:35 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1833846A7
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4862ed6ab36so2117909b6e.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873531; x=1781478331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKNQP+9qmZbIdX9t/FxGrEKW9ICx7jAIg5X+c7BSn38=;
 b=oAMHJv4r9vYoveS3Rw044aTkhFBKy+GkdYx264d0Wp85DVMleXREtEHpiOd8K3lwzr
 GDPdWUotlfBNRatjW8DdS300a4fmZyPKFB7ezmx+d91hH1eqwMMNO+uWO3g44Dv/s1YJ
 3l3LpNEBw3ub3VMzNjczmgluODeaH3DgEILsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873531; x=1781478331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OKNQP+9qmZbIdX9t/FxGrEKW9ICx7jAIg5X+c7BSn38=;
 b=bzCPvQA67+g/sK3HQPJxGw49qycjXqi9CkD7szX16rtvvcwBzIzk99wUovPgJ2N2L7
 ndWQP4bnEUZAsA7W8inqwK0+2tWmpijEKf6x+mR21vSiv7FdK8gB9jMvP224adVdQyno
 cf6LprnP+TUY+nq4YWhlphcQoTiOUfEKPwHfzLgbMv1Sm6xQUN4wxqTcq4NrwEMCxR0L
 xryFfHzHQ/qBx6i27R0U76W2f6b39BxmbDcHSjeeBHUMvjwS8iOreWinyl6r1faKvS4W
 vtkCaOimTq+k++gQ2xKYK7doViaS9QcrV7QzQs/Qr8Vfz+7JD1I1caC4Pti+Q4rpEfbT
 /7DQ==
X-Gm-Message-State: AOJu0YzXIatJmKIb2oqI7TGWmcUeZjCPNDF3gX36PuMZ169zfdHiM11R
 kYgxDJpSXbtf6CyLB0cSBWO6lvzYvZJTvem/QLHqOjspLceBkcs4skFvykcbN22evVPGO57kIum
 5DgzBAA==
X-Gm-Gg: Acq92OGuXVSb2p3GfFh3a6giZB/tb9L6+ZONt2kSMScmHj/Le6OXY0VF3EEe1aeR3eC
 9vdm+/Dw6Y2luq/67iORDs0nNOSL5YVxDQSzw/slEWZQGvB+tpdpMRV3R0BnR4aT+faRNByz7uV
 Vem1cgMWpYqpfFFxnIhS+EwlXwNumrCWAtuiS2hbo4DOlqPQwgCa8MGtKoV497NUTbQ4W+kMUle
 c7OWe2kkM1v51IMwv9z+LyeLW5gRBpZzA5IV3aYvZaX1XbvocINkqgdLcX3RuXHag8Wrij3rIwD
 3UT8CArQmZiSMWWnpVxwfWWdah2cmDRrP/jvONwuK/xDSPopEaM6iUegr/K401Evy3pwkJjQrZD
 Z/0v3Ncv06neYPdtrqGiJWONn+KnHNvuFMhRuosb0tmjpZ2QzQg9McZkNbwdDmCp2QrZSi0E4mr
 uLVSj17nheEPL+rYtM6jUOV96AC+SUhgXnlkuSDhU=
X-Received: by 2002:a05:6808:6901:b0:47b:ccf2:91e1 with SMTP id
 5614622812f47-4868dcb822cmr7856199b6e.21.1780873531593; 
 Sun, 07 Jun 2026 16:05:31 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 1/5] binman: Add an entry type for the Intel OSIP header
Date: Sun,  7 Jun 2026 17:05:10 -0600
Message-ID: <20260607230519.3022520-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
References: <20260607230519.3022520-1-sjg@chromium.org>
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

Intel Atom SoCs (Medfield, Clovertrail, Merrifield and Bay Trail) boot
via an 'OS Image Profile' (OSIP): a 512-byte '$OS$' header which tells
the boot ROM where the OS image lives, where to load it and where to
start executing. On the Intel Edison (Merrifield) the OS image is
U-Boot.

The Edison image embeds this header as the static blob
board/intel/edison/edison-osip.dat which is an empty stub in the tree,
so a fresh build emits an all-zero, non-functional header.

Add an 'intel-osip' entry type which builds the header from devicetree
properties, computing the checksum and taking the load address, entry
point, logical block address, image size and attribute as parameters.
The same sector doubles as the eMMC's protective MBR, which the boot ROM
requires before it loads the OS image, so emit a GPT-protective (0xee)
partition entry and the 0x55aa signature too. Use it for the Edison
image in place of that blob, and remove the now-unused stub file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/dts/edison.dts                |   5 +-
 board/intel/edison/edison-osip.dat     |   0
 tools/binman/etype/intel_osip.py       | 121 +++++++++++++++++++++++++
 tools/binman/ftest.py                  |  25 +++++
 tools/binman/test/entry/intel_osip.dts |  17 ++++
 5 files changed, 165 insertions(+), 3 deletions(-)
 delete mode 100644 board/intel/edison/edison-osip.dat
 create mode 100644 tools/binman/etype/intel_osip.py
 create mode 100644 tools/binman/test/entry/intel_osip.dts

diff --git a/arch/x86/dts/edison.dts b/arch/x86/dts/edison.dts
index 7af8507e456..9c7630161e9 100644
--- a/arch/x86/dts/edison.dts
+++ b/arch/x86/dts/edison.dts
@@ -171,9 +171,8 @@
 	u-boot-edison {
 		filename = "u-boot-edison.img";
 
-		/* This is the OSIP */
-		blob {
-			filename = "edison-osip.dat";
+		/* OSIP ($OS$) header pointing at the U-Boot image below */
+		intel-osip {
 		};
 
 		u-boot {
diff --git a/board/intel/edison/edison-osip.dat b/board/intel/edison/edison-osip.dat
deleted file mode 100644
index e69de29bb2d..00000000000
diff --git a/tools/binman/etype/intel_osip.py b/tools/binman/etype/intel_osip.py
new file mode 100644
index 00000000000..ba762180762
--- /dev/null
+++ b/tools/binman/etype/intel_osip.py
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2025 Google LLC
+#
+# Entry-type module for the Intel OS Image Profile (OSIP) header
+
+"""Entry-type module for an Intel OS Image Profile (OSIP) header
+
+This generates the 512-byte '$OS$' header used by the boot ROM on Intel Atom
+SoCs (Medfield / Clovertrail / Merrifield / Bay Trail) to locate and load the
+OS image. On the Intel Edison (Merrifield) this OS image is U-Boot.
+
+The OS image is expected to immediately follow this header, i.e. at offset
+0x200 in the containing section. A single OS Image Identifier (OSII) descriptor
+is emitted, pointing at that image.
+"""
+
+import struct
+
+from binman.entry import Entry
+from dtoc import fdt_util
+
+OSIP_SIGNATURE = b'$OS$'
+OSIP_SIZE = 0x200           # The header occupies one 512-byte block
+HEADER_SIZE = 0x38          # Size of the parsed OSIP header (sig + one OSII)
+OSII_OFFSET = 0x20          # First OS Image Identifier descriptor
+MBR_OFFSET = 0x1b8          # Start of the protective MBR (disk sig + table)
+MBR_PART_OFFSET = 0x1be     # First MBR partition entry
+BOOT_SIG_OFFSET = 0x1fe     # Legacy 0x55aa boot signature
+GPT_PROTECTIVE_TYPE = 0xee  # MBR partition type for a GPT-protective entry
+
+# Sector count placed in the protective MBR entry, matching the reference
+# Edison images. The on-disk GPT is authoritative, so this is informational.
+PROTECTIVE_MBR_SECTORS = 0x03a3e000
+
+class Entry_intel_osip(Entry):
+    """Intel OS Image Profile (OSIP) header
+
+    Properties / Entry arguments:
+        - intel,load-address (int): DDR address to load the OS image to
+          (default 0x01100000)
+        - intel,entry-point (int): Execution entry point of the OS image
+          (default 0x01101000)
+        - intel,lba (int): Logical block address of the image on the boot
+          media (default 0x800)
+        - intel,size-blocks (int): Size of the OS image in 512-byte blocks
+          (default 0x3000)
+        - intel,attribute (int): OSII attribute byte (default 0x0f)
+
+    The header checksum is calculated automatically (an XOR over the header
+    bytes). A GPT protective MBR and the legacy 0x55aa boot signature are
+    placed in the final bytes of the block, as the boot ROM requires a valid
+    protective MBR in this sector before it will load the OS image.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.load = fdt_util.GetInt(self._node, 'intel,load-address',
+                                    0x01100000)
+        self.entry = fdt_util.GetInt(self._node, 'intel,entry-point',
+                                     0x01101000)
+        self.lba = fdt_util.GetInt(self._node, 'intel,lba', 0x800)
+        self.size_blocks = fdt_util.GetInt(self._node, 'intel,size-blocks',
+                                           0x3000)
+        self.attribute = fdt_util.GetInt(self._node, 'intel,attribute', 0x0f)
+
+    def _build_header(self):
+        data = bytearray(b'\xff' * OSIP_SIZE)
+
+        # OSIP header: signature, revisions, checksum, pointer/image counts and
+        # the header size. The checksum byte is filled in last.
+        struct.pack_into('<4sBBBBBBH', data, 0,
+                         OSIP_SIGNATURE,    # 0x00 '$OS$'
+                         0,                 # 0x04 reserved
+                         0,                 # 0x05 header minor revision
+                         1,                 # 0x06 header major revision
+                         0,                 # 0x07 header checksum (see below)
+                         1,                 # 0x08 number of pointers
+                         1,                 # 0x09 number of images
+                         HEADER_SIZE)       # 0x0a header size
+        # Reserved area between the header and the first OSII descriptor
+        data[0x0c:OSII_OFFSET] = bytes(OSII_OFFSET - 0x0c)
+
+        # OS Image Identifier (OSII) descriptor describing the OS image
+        struct.pack_into('<HHIIIIB', data, OSII_OFFSET,
+                         0,                 # 0x20 OS minor revision
+                         0,                 # 0x22 OS major revision
+                         self.lba,          # 0x24 logical start block
+                         self.load,         # 0x28 DDR load address
+                         self.entry,        # 0x2c entry point
+                         self.size_blocks,  # 0x30 size in 512-byte blocks
+                         self.attribute)    # 0x34 attribute
+        data[0x35:HEADER_SIZE] = bytes(HEADER_SIZE - 0x35)  # OSII reserved
+
+        # GPT protective MBR. The Edison's x86 mask ROM only boots U-Boot from
+        # an eMMC whose first sector is a valid protective MBR; this OSIP header
+        # doubles as that sector. Without the 0xee entry the ROM drops to DnX
+        # instead of loading U-Boot. The entry covers the disk from LBA 1.
+        data[MBR_OFFSET:BOOT_SIG_OFFSET] = bytes(BOOT_SIG_OFFSET - MBR_OFFSET)
+        struct.pack_into('<B3sB3sII', data, MBR_PART_OFFSET,
+                         0,                       # boot indicator (inactive)
+                         b'\0\0\0',               # start CHS (unused)
+                         GPT_PROTECTIVE_TYPE,     # partition type 0xee
+                         b'\0\0\0',               # end CHS (unused)
+                         1,                       # first LBA (the GPT header)
+                         PROTECTIVE_MBR_SECTORS)  # number of sectors
+
+        # Legacy boot signature at the end of the block
+        data[BOOT_SIG_OFFSET] = 0x55
+        data[BOOT_SIG_OFFSET + 1] = 0xaa
+
+        # Header checksum: XOR over the header bytes (checksum byte counted
+        # as zero, since it is still zero at this point)
+        checksum = 0
+        for byte in data[:HEADER_SIZE]:
+            checksum ^= byte
+        data[7] = checksum
+
+        return bytes(data)
+
+    def ObtainContents(self):
+        self.SetContents(self._build_header())
+        return True
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 9a3811c1732..7eab0fdf071 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -2047,6 +2047,31 @@ class TestFunctional(unittest.TestCase):
         data = self._DoReadFile('entry/fill_empty.dts')
         self.assertEqual(tools.get_bytes(0, 16), data)
 
+    def testIntelOsip(self):
+        """Test that binman can generate an Intel OSIP header"""
+        data = self._DoReadFile('entry/intel_osip.dts')
+        self.assertEqual(0x200, len(data))
+
+        # '$OS$' signature and the self-cancelling header checksum
+        self.assertEqual(b'$OS$', data[:4])
+        checksum = 0
+        for byte in data[:0x38]:
+            checksum ^= byte
+        self.assertEqual(0, checksum)
+
+        # The OSII descriptor picks up the devicetree properties
+        lba, load, entry, blocks = struct.unpack_from('<IIII', data, 0x24)
+        self.assertEqual(0x1000, lba)
+        self.assertEqual(0x02200000, load)
+        self.assertEqual(0x02201000, entry)
+        self.assertEqual(0x4000, blocks)
+        self.assertEqual(0x07, data[0x34])
+
+        # GPT-protective MBR partition entry and the legacy boot signature
+        self.assertEqual(0xee, data[0x1c2])
+        self.assertEqual(1, struct.unpack_from('<I', data, 0x1c6)[0])
+        self.assertEqual(b'\x55\xaa', data[0x1fe:0x200])
+
     def testTextMissing(self):
         """Test for a text entry type where there is no text"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/entry/intel_osip.dts b/tools/binman/test/entry/intel_osip.dts
new file mode 100644
index 00000000000..b13c3f8fae6
--- /dev/null
+++ b/tools/binman/test/entry/intel_osip.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		intel-osip {
+			intel,load-address = <0x02200000>;
+			intel,entry-point = <0x02201000>;
+			intel,lba = <0x1000>;
+			intel,size-blocks = <0x4000>;
+			intel,attribute = <0x07>;
+		};
+	};
+};
-- 
2.43.0

