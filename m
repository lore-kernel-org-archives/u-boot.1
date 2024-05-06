Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB5C25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168398866A;
	Mon,  6 May 2024 16:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aIW4nKpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B2AB8864D; Mon,  6 May 2024 16:39:08 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426DC88624
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715006346;
 bh=FY+6xnScvT00pJhA42jtHzD+Z+8lx1MWy3PnSSDmpxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aIW4nKpDIz+g94Hl31lnJkl3rncLBewMVmjacT+GzCE3nDjrj1h9A2dn0y9QcMwPk
 sDbq5vrDpxCDOT+zNwgyMNN9YqWzNkN8FHQ3YgJ71VaQze9A09irgC9eyWXpaj1DP/
 aKujTx7abqDjZtvI0jA08lmpCb+XbpW4DMMTnXcnHSBurrqQFLoIyMk/ARpT9uLC1Y
 XCAjp4vln6AGi5cRr0batAOilbZnkaobOLPceqt+7cQ7dMAgMd6N4vcdasqo3IUiDh
 Z2EhtxlRDWaY5y+6t193iikrEPnMRsUIE2z6NMrzb+R0f5gBnOAAW/dcz8PQpplVEi
 c7xTLbbX3NKIA==
Received: from pan.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B82B3781107;
 Mon,  6 May 2024 14:39:05 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v5 6/6] doc: board: Add document for DFU boot on am62x SoCs
Date: Mon,  6 May 2024 15:38:46 +0100
Message-ID: <20240506143846.1252377-7-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506143846.1252377-1-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
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

From: Sjoerd Simons <sjoerd@collabora.com>

Both AM62 SK and beagleplay support DFU boot in a similar way now;
Document how to actually run DFU boot for both boards

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on beagle play
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
Changes in v5:
- Typographical corrections

Changes in v4:
- New patch

 doc/board/beagle/am62x_beagleplay.rst | 14 +++++++++-
 doc/board/ti/am62x_sk.rst             | 37 +++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 7784e62b0b..cdc610264e 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -268,7 +268,19 @@ for details.
      - USB Device Firmware Upgrade (DFU) mode
 
 To switch to SD card boot mode, hold the USR button while powering on
-with Type-C power supply, then release when power LED lights up.
+with a USB type C power supply, then release when power LED lights up.
+
+DFU based boot
+--------------
+
+To boot the board over DFU, ensure there is no SD card inserted with a
+bootloader. Hold the USR switch while plugging into the type C to boot into DFU
+mode. After power-on the build artifacts needs to be uploaded one by one with a
+tool like dfu-util.
+
+.. include::  ../ti/am62x_sk.rst
+    :start-after: .. am62x_evm_rst_include_start_dfu_boot
+    :end-before: .. am62x_evm_rst_include_end_dfu_boot
 
 Debugging U-Boot
 ----------------
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b12dc85f06..d5f7fe3b03 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -105,6 +105,20 @@ Set the variables corresponding to this platform:
 
 * 3.1 R5:
 
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.1.1 Alternative build of R5 for DFU boot:
+
+As the SPL size can get too big when building with support for booting both
+from local storage *and* DFU an extra config fragment should be used to enable
+DFU support (and disable storage support)
+
+.. prompt:: bash $
+
+  export UBOOT_CFG_CORTEXR="${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.config"
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
+USB type C DRD port on the board. After power-on the build artifacts needs to be
+uploaded one by one with a tool like dfu-util.
+
+.. am62x_evm_rst_include_start_dfu_boot
+
+The initial ROM will have a DFU alt named `bootloader` for the initial R5 spl
+upload. The next stages as exposed by U-Boot have target alts matching the name
+of the artifacts, for these a USB reset has to be done after each upload.
+
+When using dfu-util the following commands can be used to boot to a U-Boot shell:
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

