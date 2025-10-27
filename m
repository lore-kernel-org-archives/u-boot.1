Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B49CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 17:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3165E83893;
	Mon, 27 Oct 2025 18:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PpVF8KMV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b+FJSDFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D486B838E5; Mon, 27 Oct 2025 18:07:18 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15858384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 18:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwKgS3ZlBz9tV8;
 Mon, 27 Oct 2025 18:07:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mr36WL/xjY1i8LzNfyLwu3zoL+kY/ssPejDKspTULMA=;
 b=PpVF8KMVWskPoEF8ICG0GLPHL4/0Vb1mGxWpqpkJJBEpNnGyov5VEGCk0SDdGoZvsVRaqx
 XqkDbRPraw1J12fA+XLaTZfBIXHjxN+3+xZQ+OAlogF19zuv9BSTSvV8P172GMXcHqZCku
 dwIeOJ5mjXiuSVHMusW/ms0IM2VeR9m3IToUu+cqlhQUDukjFKiR/EVg/xx4Usc/pFfPTB
 xx5JZJE2N5Xp74n9pIVpn9vZ4dg7ZLB+dnFwbjX2l247OnWY2qMCHcQMckMVsd04+sd8oS
 OP+xPK5bsvy4S5WviAYDqALeK6bMA+Ygieg+LBUmAjMxKQRZfQaFBQWwafbjSw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=b+FJSDFe;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761584834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mr36WL/xjY1i8LzNfyLwu3zoL+kY/ssPejDKspTULMA=;
 b=b+FJSDFe5U8kjoaxXSXMu2UXdzbO1Btb7ENYyJecT8qA5+dcdOFhWMBVoZgOeFn7tZIFg/
 46QPnt+BPfD1qzFFPT2DRkaFCwzi9Ah9fhd7tGy9iTuvvK5bVDdf5svohh9Y4zl1fMT1bC
 TmpxgkHc96y1EIHtpc9O7UIyEpfcnlOLOFOKEJY0uxTw5aBhNT0p4U9Kvs8tTOMznlsV2j
 zL1qoGGCwfRtBdul781oNGZHVMwuSSIXnc0QloFBJlVGFtd0qhISS926c51kT/2b8duk0t
 QpVR6jry7RmoJ+jp9yG/7lu5OxkJHcze/5ZgfMVPQY0UCvUPbWhCkOg5gD2Q/w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 1/6] ufs: core: Keep Makefile and Kconfig list sorted
Date: Mon, 27 Oct 2025 18:06:22 +0100
Message-ID: <20251027170706.29302-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 74925adef437fc5943e
X-MBO-RS-META: oyzeckdqfgf7ddcc1bsmff1hstkuy3xi
X-Rspamd-Queue-Id: 4cwKgS3ZlBz9tV8
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

Sort the Makefile and Kconfig lists alphabetically. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/ufs/Kconfig  | 38 +++++++++++++++++++-------------------
 drivers/ufs/Makefile |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index b08ca08b07c..b466374fe40 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -15,17 +15,6 @@ config CADENCE_UFS
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.
 
-config UFS_PCI
-	bool "PCI bus based UFS Controller support"
-	depends on PCI && UFS
-	help
-	  This selects the PCI UFS Host Controller Interface. Select this if
-	  you have UFS Host Controller with PCI Interface.
-
-	  If you have a controller with this interface, say Y here.
-
-	  If unsure, say N.
-
 config QCOM_UFS
 	bool "Qualcomm Host Controller driver for UFS"
 	depends on UFS && ARCH_SNAPDRAGON
@@ -39,6 +28,25 @@ config TI_J721E_UFS
 	  This selects the glue layer driver for Cadence controller
 	  present on TI's J721E devices.
 
+config UFS_AMD_VERSAL2
+	bool "AMD Versal Gen 2 UFS controller platform driver"
+	depends on UFS && ZYNQMP_FIRMWARE
+	help
+	  This selects the AMD specific additions to UFSHCD platform driver.
+	  UFS host on AMD needs some vendor specific configuration before accessing
+	  the hardware.
+
+config UFS_PCI
+	bool "PCI bus based UFS Controller support"
+	depends on PCI && UFS
+	help
+	  This selects the PCI UFS Host Controller Interface. Select this if
+	  you have UFS Host Controller with PCI Interface.
+
+	  If you have a controller with this interface, say Y here.
+
+	  If unsure, say N.
+
 config UFS_RENESAS
 	bool "Renesas specific hooks to UFS controller platform driver"
 	depends on UFS
@@ -48,12 +56,4 @@ config UFS_RENESAS
 	  UFS host on Renesas needs some vendor specific configuration before
 	  accessing the hardware.
 
-config UFS_AMD_VERSAL2
-	bool "AMD Versal Gen 2 UFS controller platform driver"
-	depends on UFS && ZYNQMP_FIRMWARE
-	help
-	  This selects the AMD specific additions to UFSHCD platform driver.
-	  UFS host on AMD needs some vendor specific configuration before accessing
-	  the hardware.
-
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 2a378e45111..548306fb99e 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -7,6 +7,6 @@ obj-$(CONFIG_UFS) += ufs.o ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
+obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
-obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
-- 
2.51.0

