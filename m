Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B3BEED612
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670BF84051;
	Thu,  1 Jan 2026 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FUYpIaLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E13C840A2; Thu,  1 Jan 2026 15:17:50 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DD583BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 15:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DEFDD4003D; 
 Thu,  1 Jan 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767277068;
 bh=srDubR1uFUiq1hjWnFmyHIr2tKXcLAAU9cz5ofWl/Cg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=FUYpIaLlDwA8e0bfsycD+376zfKMXyIZym8NarBjYB2zXcmeu83eVCBWU4Hscv0ac
 Sua7SX9a70hqTuHYW5AM9iDeD4OjTK8JZJtVWa8MRPNshW+NtEOeZhY04H+60F5GEc
 97xdQ3WAh18YA1oa27Tltw3UVi+cP9LFDeN3fP3+dnOq8syq4mleSBAD0Bs8Jk65Q9
 EPRCXZd0YrykjWolLaWFf61+ylI3peUQ+cfAMZj47x0GFAxMrN4/dSW19853yvqJqj
 r4g5205jLHfyZot2yBkT2CBzCYY/QQXJeFdrjgFY5/Unx9rrEo1YM67rzOedF2xXmx
 xaLnAlYUTZpd5AG5NNl4K5BNSf6HHZSrymsH/B0Z3FxowMeOCbbr2h5mRsM905oA0q
 7EHt8jWFRSafWa2SM+rNC4xHw6ozRK5CkRooEy/QpDB57gdUS31qSmSHY0uU/mVmCr
 +MUpqvZualSOqFX/HcBEKiDA+jeQhceg6EYoj0on15QhAH2dtfUfpKAYAUtVOkINwQ
 uU+HyiQopcRW9sHvexdKLPfxOCGk+aVduaeABUUzxeGMNn2nFPOQta9yIU67eZ5SSg
 Eu44qlukwe9tnffW5WAiVGzP50mxZPsVkBKaa8QGdtkvYxQopvTwQtJNTDAlBX0obY
 vnx8bN+sFBmvc+g9VlUcfok8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v2 1/1] doc: describe QEMU VGA emulation
Date: Thu,  1 Jan 2026 15:17:43 +0100
Message-ID: <20260101141743.17676-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Describe how the QEMU defconfigs can be used with an emulated GPU.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	fix typos
	tweak some wording (if -> whether, like in -> as shown in)
	place video emulation after block device emulation on the index page
---
 doc/board/emulation/index.rst |  1 +
 doc/board/emulation/video.rst | 63 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 doc/board/emulation/video.rst

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..bda2240725f 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -15,6 +15,7 @@ Emulation

    acpi
    blkdev
+   video
    qemu-arm
    qemu-mips
    qemu-ppce500
diff --git a/doc/board/emulation/video.rst b/doc/board/emulation/video.rst
new file mode 100644
index 00000000000..0e08c47787f
--- /dev/null
+++ b/doc/board/emulation/video.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Emulation of a graphics adapter
+===============================
+
+Currently QEMU's ``bochs-display`` is the only emulated GPU that U-Boot's
+generic QEMU defconfigs support. It emulates a PCIe-connected graphics card
+with VESA 2.0 VBE extensions.
+
+The following parameters can be specified:
+
+edid
+    controls whether EDID information is available. Allowable values are
+    ``off`` and ``on``. The default is ``on``.
+
+vgamem
+    specifies the display memory size. The default value is 16 MiB.
+    For UHD resolution 32 MiB is required.
+
+The following configuration parameters are relevant:
+
+CONFIG_VIDEO_BOCHS
+    enable support for the Bochs GPU.
+
+CONFIG_VIDEO_BOCHS_SIZE_X
+    defines the display width.
+
+CONFIG_VIDEO_BOCHS_SIZE_Y
+    defines the display height.
+
+CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE
+    sets the framebuffer size that QEMU can use for a device driver that is
+    enabled after relocation. This should be chosen as
+
+    .. code-block::
+
+        CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE >=
+        4 * CONFIG_VIDEO_BOCHS_SIZE_X * CONFIG_VIDEO_BOCHS_SIZE_Y
+
+Here is an example QEMU invocation for qemu-riscv64_smode_defconfig:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 \
+      -M virt \
+      -device bochs-display,vgamem=33554432 \
+      -serial mon:stdio \
+      -device qemu-xhci \
+      -device usb-kbd \
+      -kernel u-boot
+
+``mon:stdio`` provides a serial console, ``qemu-xhci`` a USB root hub,
+``usb-kbd`` a USB keyboard.
+
+To start QEMU without GPU emulation, use parameter ``-nographic``, as shown in
+the following example:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 \
+      -M virt \
+      -nographic \
+      -kernel u-boot
-- 
2.51.0

