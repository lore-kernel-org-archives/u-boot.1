Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595FCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 14:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F799832AD;
	Tue, 28 Oct 2025 15:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HcDSVsHJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KheEpJdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C0382E34; Tue, 28 Oct 2025 15:23:48 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8EB80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 15:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwt0K2Cd9z9tTM;
 Tue, 28 Oct 2025 15:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=My8zA2WamrMKMi2o3T1SMCZygeFKs3qx4XgODvZpOoc=;
 b=HcDSVsHJtf/esdfwJfOFus22UbH9F/hsKd5/2u7u8dvCGsDHXEnO0S4wrkupPsyGk6uoEZ
 QqVfw5ApKr3TJb4oJtf2+656qmH+NfvUK0WNCKLVInGbpGL1o8vBp6OC9B4Nciv8Bnshzl
 pG+vDMbsklfoHfIGCiho4EyPqCicZJ5RWlH/VbHmKvQlK1V3fJu2k74MGdS9qCANjcSw4f
 5HedW4lB4pdlGZPAf23hO2EOtL/VmAFNikRttgXELB4LSv5bD/6pXpEO9H2LY70ITgLFtI
 JBxENo9CLRyPIzmvyg2f6KMOA89+A3d9b1U6/KYvrbazz6TOeYlxfLoBFRD+Ag==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761661423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=My8zA2WamrMKMi2o3T1SMCZygeFKs3qx4XgODvZpOoc=;
 b=KheEpJdShA7rzh6dhWHkZTma4BTKMuYMs5Qg8iF7pOAwJKl8ZNp4nKxqAh0KAmdCOGF3Jp
 hmCMKFjRHBC/F2EKqoMRQ8yeifZJhUPsyg8xuWdHDWhX0ASNG8hifqzhIhG3HrsXErw7Nm
 J/2gTuKKbvwIr2AR0wB2xRUciak2RdzcBIUPvOxBV6vG2QgyrsdvLXBLCrnlty3IIgKvku
 DJeHyfFisaWj1HsTb2sxgE/qGvvvy+fY7oNnV7SUQusSN+1gP6+YMGkOnEDpiFG0UESyaN
 JmlUut3RQDX02OyC7kcqZGMAdR47Vj6krMNX2Q7PvX05/MGfaSYLWBmltSpmRA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH v2 1/7] ufs: core: Keep Makefile and Kconfig list sorted
Date: Tue, 28 Oct 2025 15:22:21 +0100
Message-ID: <20251028142335.18125-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3d93d657257119ebd9b
X-MBO-RS-META: 695zsgmat1aok7s4birijix486yo4ir3
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
V2: Add RB from Neil
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

