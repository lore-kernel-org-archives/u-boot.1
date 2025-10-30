Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C319CCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 22:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EABC83887;
	Thu, 30 Oct 2025 23:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JkjDzL4r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bUyko0jT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DA083887; Thu, 30 Oct 2025 23:36:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C4E8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cyJr64gR3z9syH;
 Thu, 30 Oct 2025 23:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm0/xcnX3Oks78l12fBvIkeNxiPddBTVFuGWWYCtwAg=;
 b=JkjDzL4rudShWAKTXPL/4X4QWqBJGOb1PPTpCEn0Y6CZaVvwUetieQhtGFFGF0LT89RPDA
 GbJIjnefeJn728zw4qTkdeYaOMp6dkT/MzLWgzSHwjZIscGZIdCkuGb7/Hh89eOsOrwYnE
 udg4H1qdex0p5XYLvRwcms9rHrcVBZCSt558FBMv2rs6TxO/dqY/4MziEAW4lWpid/XyOq
 CxhQEVnZquhDr1a8jkIEGIxrLDh+O+31U23m7RnsTa5yQQTp3ud60j945cE3WNXJ+vYuMa
 0M6aX7dmdi2icOJ2uNtSMwyb8BBIn8DuCq1NkZll/JIUlx+gMcpi6TFBTnScBA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=bUyko0jT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm0/xcnX3Oks78l12fBvIkeNxiPddBTVFuGWWYCtwAg=;
 b=bUyko0jT08aFE7QJwYnIIyIdLq8oFyKc5ynhnmq4xIOYcWL6TmCFjVsPEIyKF7SHRZsB+A
 f3XCqCwLNfInc+/liAnWZsf1EJQTMA/ThO6KktQdyaTXOpLsFO0td+QcGiEiXW0rC6daNN
 YogIvEWqCWhVAy8xE5BD1PZnv/0t/jswNtbDMOJR4htfk71vroqlI+/VuRvfhYFABGqNEd
 2CP3p9dmxi6KpI3HKFF+1+0ch4t7U8jFn7Io0wLd7jsBS6iDhoZhoFSNGdJOnUq6ULXqvr
 oi/3OYdfkafg0EHN798CvqQw5ZTreYyXy/zpnsbOfBUtn/J9OGh+b1uKs1L3zw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 2/4] ufs: qcom: Rename CONFIG_QCOM_UFS to CONFIG_UFS_QCOM
Date: Thu, 30 Oct 2025 23:35:43 +0100
Message-ID: <20251030223626.20005-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
References: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ns1wrx9p5bcrmzax7i5bnr1yo17ahoo6
X-MBO-RS-ID: bdcf683403c998142df
X-Rspamd-Queue-Id: 4cyJr64gR3z9syH
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

Align the Kconfig option with the rest of the subsystem, use
CONFIG_UFS_<vendor> format for the Kconfig option.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 configs/qcom_defconfig |  2 +-
 drivers/ufs/Kconfig    | 14 +++++++-------
 drivers/ufs/Makefile   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 8bdb3cf7c58..0247f5cb08b 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -151,7 +151,7 @@ CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_UFS=y
-CONFIG_QCOM_UFS=y
+CONFIG_UFS_QCOM=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_FONT_8X16 is not set
 CONFIG_VIDEO_FONT_16X32=y
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index e77b144a470..288d3de824c 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,13 +8,6 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
-config QCOM_UFS
-	bool "Qualcomm Host Controller driver for UFS"
-	depends on UFS && ARCH_SNAPDRAGON
-        help
-	  This selects the platform driver for the UFS host
-	  controller present on Qualcomm Snapdragon SoCs.
-
 config ROCKCHIP_UFS
 	bool "Rockchip specific hooks to UFS controller platform driver"
 	depends on UFS
@@ -70,6 +63,13 @@ config UFS_PCI
 
 	  If unsure, say N.
 
+config UFS_QCOM
+	bool "Qualcomm Host Controller driver for UFS"
+	depends on UFS && ARCH_SNAPDRAGON
+        help
+	  This selects the platform driver for the UFS host
+	  controller present on Qualcomm Snapdragon SoCs.
+
 config UFS_RENESAS
 	bool "Renesas R-Car S4 UFS Controller support"
 	depends on UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 656988ef9ad..18ed250d059 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,12 +4,12 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
-obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
+obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
-- 
2.51.0

