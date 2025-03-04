Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30D7C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF151801CF;
	Tue,  4 Mar 2025 17:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AB980FB6; Tue,  4 Mar 2025 17:52:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A39508004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harrison.mutai@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB4B2F;
 Tue,  4 Mar 2025 08:52:39 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.25.152])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570AE3F5A1;
 Tue,  4 Mar 2025 08:52:25 -0800 (PST)
From: Harrison Mutai <harrison.mutai@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: nd@arm.com, Harrison Mutai <harrison.mutai@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 2/2] vepxress64: add guide for running FVP with TF-A
Date: Tue,  4 Mar 2025 16:52:02 +0000
Message-ID: <20250304165204.53097-3-harrison.mutai@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20250304165204.53097-1-harrison.mutai@arm.com>
References: <20250304165204.53097-1-harrison.mutai@arm.com>
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

Add documentation on how to run FVP with U-Boot and TF-A. This helps
users configure and run U-Boot correctly on Arm models.

Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
---
 doc/board/armltd/vexpress64.rst | 54 +++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/doc/board/armltd/vexpress64.rst b/doc/board/armltd/vexpress64.rst
index a732fac899d..434cc785bd6 100644
--- a/doc/board/armltd/vexpress64.rst
+++ b/doc/board/armltd/vexpress64.rst
@@ -19,6 +19,11 @@ view", which gives a comprehensive model on which to build and test software.
 The supported FVPs are available free of charge and can be downloaded from the
 Arm developer site [1]_ (user registration might be required).
 
+The Architecture Envelope Models (AEM) FVPs offer virtual platforms for Armv8-A,
+Armv9-A, and Armv8-R architectures, including a comprehensive set of System IP.
+For general use though, the Armv8-A Base Rev C FVP, which emulates a generic 64-bit
+Armv8-A hardware platform, is a suitable option.
+
 Supported features:
 
  * GICv3
@@ -31,6 +36,50 @@ into the TF-A build: ``make PLAT=<platform> all fip BL33=u-boot.bin``
 
 The FVPs can be debugged using Arm Development Studio [2]_.
 
+Building U-Boot
+^^^^^^^^^^^^^^^
+
+Set the ``CROSS_COMPILE`` environment variable as usual, and run:
+
+.. code-block:: bash
+
+    make vexpress_fvp_defconfig
+    make
+
+Running U-Boot
+^^^^^^^^^^^^^^
+
+Set ``CROSS_COMPILE`` as usual and build TF-A:
+
+.. code-block:: bash
+
+    git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+    cd trusted-firmware-a
+    make PLAT=fvp BL33=/path/to/u-boot.bin fiptool all fip
+
+This command generates the ROM image `bl1.bin`, and a boot image `fip.bin` in
+TF-A's FIP format [5]. It contains all images executed by TF-A, including U-Boot.
+Note that TF-A outputs the built binaries into `build/fvp/release/`.
+
+If you already have a FIP image, and are primarily interested in updating the BL33
+image (i.e., U-Boot), use `fiptool` from TF-A:
+
+.. code-block:: bash
+
+    make fiptool
+    tools/fiptool/fiptool update --nt-fw=/path/to/u-boot.bin /path/to/fip.bin
+
+To run the FVP:
+
+.. code-block:: bash
+
+    FVP_Base_RevC-2xAEMvA -C bp.flashloader0.fname=fip.bin \
+        -C bp.secureflashloader.fname=bl1.bin \
+        -C bp.vis.disable_visualisation=1
+
+This setup relies on semi-hosting, as well as, having a kernel image (``Image``)
+and ramdisk (``ramdisk.img``) in the current working directory.
+
 Juno
 ----
 
@@ -62,7 +111,8 @@ tables.
 References
 ----------
 
-.. [1] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms
+.. [1] https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Arm%20Architecture%20FVPs
 .. [2] https://developer.arm.com/tools-and-software/embedded/arm-development-studio
 .. [3] https://developer.arm.com/tools-and-software/development-boards/juno-development-board
-.. [4] https://trustedfirmware-a.readthedocs.io/
\ No newline at end of file
+.. [4] https://trustedfirmware-a.readthedocs.io/
+.. [5] https://trustedfirmware-a.readthedocs.io/en/latest/getting_started/image-terminology.html#firmware-image-package-fip
-- 
2.46.2

