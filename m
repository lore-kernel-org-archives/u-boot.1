Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E43EC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6568879C8;
	Fri, 12 Jan 2024 09:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qRKP2YTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5729879B5; Fri, 12 Jan 2024 09:53:25 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D0D879AB
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705049599;
 bh=CtHm90/BSZBaA0TyjKDSlQog7TdE3fPM/RgGftWx3sc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qRKP2YTP9Ed+Nl9RNejLbAB2X/lLHXpt/Mf7PId54SctRuCNaKvkIIUD0e7iC88Cf
 3s9sbTvOYWLZ88jJKXYtYI+/J9FFAhZPU0BmRx9SLxh8K0UcqkAftowVjkI72t0Of7
 NBVQQCGQls+oRlC/R+MdKY8LN4Iodn+D1dDu3xOZ/Yu6CdD+YRNYIjpxcXJ/k4YZHn
 cftsOkbMi1GtV7Xg/VQ65sL+SnKwytIo/LU3lvHdZoewMYKLTNu5zonWWYzTtMMnhb
 IOpn/Ty7ky4lMap8DXeavV4MDkM+hG3NEY1vM3He0CaPABCx7Wa5egeylY8neL91d4
 siFaQUdUEsu4Q==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0FC783782035;
 Fri, 12 Jan 2024 08:53:19 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id ADA349ED7CD6; Fri, 12 Jan 2024 09:53:18 +0100 (CET)
From: Sjoerd Simons <sjoerd@collabora.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Judith Mendez <jm@ti.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v4 7/7] doc: board: Add document for DFU boot on am62x SoCs
Date: Fri, 12 Jan 2024 09:52:22 +0100
Message-ID: <20240112085317.1866449-8-sjoerd@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112085317.1866449-1-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
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

Both AM62 SK and beagleplay support DFU boot in a similar way now;
Document how to actually run DFU boot for both boards

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

---

Changes in v4:
- New patch

 doc/board/beagle/am62x_beagleplay.rst | 12 +++++++++
 doc/board/ti/am62x_sk.rst             | 37 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 7784e62b0b7..4c8b0845845 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -270,6 +270,18 @@ for details.
 To switch to SD card boot mode, hold the USR button while powering on
 with Type-C power supply, then release when power LED lights up.
 
+DFU based boot
+--------------
+
+To boot the board over DFU, ensure there is no SD card inserted with a
+bootloader. Hold the USR switch while plugging into the Type C to boot into DFU
+mode. After power-on the build artifacts needs to be uploaded one by one with a
+tool like dfu-util.
+
+.. include::  ../ti/am62x_sk.rst
+    :start-after: .. am62x_evm_rst_include_start_dfu_boot
+    :end-before: .. am62x_evm_rst_include_end_dfu_boot
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b12dc85f06b..904a54cd5ff 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -105,6 +105,20 @@ Set the variables corresponding to this platform:
 
 * 3.1 R5:
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.1.1 Alternatively build R5 for DFU boot:
+
+As the SPL size can get to big when building with support for booting both from
+local storage *and* DFU an extra config fragment should be used to enable DFU
+support (and disable storage support)
+
+.. prompt:: bash $
+
+  export UBOOT_CFG_CORTEXR=${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config
+
 .. include::  ../ti/k3.rst
     :start-after: .. k3_rst_include_start_build_steps_spl_r5
     :end-before: .. k3_rst_include_end_build_steps_spl_r5
@@ -251,6 +265,29 @@ https://www.ti.com/lit/pdf/spruiv7 under the `Boot Mode Pins` section.
 
 For SW2 and SW1, the switch state in the "ON" position = 1.
 
+DFU based boot
+--------------
+
+To boot the board over DFU, set the switches to DFU mode and connect to the
+USB Type C DRD Port on the board. After power-on the build artifacts needs to be
+uploaded one by one with a tool like dfu-util.
+
+.. am62x_evm_rst_include_start_dfu_boot
+
+The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
+upload. The next stages as exposed by u-boot have target alts matching the name
+of the artifacts, for these a USB reset has to be done after each upload.
+
+When using dfu-util the following commands can be used to boot to a u-boot shell:
+
+.. prompt:: bash $
+
+  dfu-util -a bootloader -D tiboot3.bin
+  dfu-util -R -a tispl -D tispl.bin
+  dfu-util -R -a u-boot.img -D u-boot.img
+
+.. am62x_evm_rst_include_end_dfu_boot
+
 Debugging U-Boot
 ----------------
 
-- 
2.43.0

