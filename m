Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38089CCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 22:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA8F838CE;
	Thu, 30 Oct 2025 23:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EGPcX5gc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IOZdeSPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4DA8334F; Thu, 30 Oct 2025 23:36:47 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D6683893
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cyJrC589bz9v88;
 Thu, 30 Oct 2025 23:36:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twFJ64PR6rWllko3n9BWcHMP/GkhLcYuALY9JoW6Zf4=;
 b=EGPcX5gc7oJAP20vM5ixa1AFlGaeyC0+djOYqMLq0Ws1MOJgQwTzI+KN50OxLEjRPk4CYR
 Cc4eQRsojcb5tPZthIrpfl5DNIwQYP34A3gw0Y4i3WVznyWg4vVy8vWzWSjc8zD0cbg81h
 38YWuuw614fwAc0Gwu+r/wqJZ1+un5uqQNwE92QhMf+M+bpOhOJtOEQ+c9G87gNAKt8nC2
 9N8FCu+HtS+YknaofgCza9Fv0z804UR6RG57RjFhn9r42qtktPd/0xj6Q4KJ0soqZcDB/4
 EK6qeOi9NIVf4RLr6xtYLdPuXiBzri5BqCSKBHS4ys/0KVZV/+HTHPIyS0Gk9A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=IOZdeSPW;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twFJ64PR6rWllko3n9BWcHMP/GkhLcYuALY9JoW6Zf4=;
 b=IOZdeSPWZZgng3gff/zoVp0Wd99poEHIZUEjMxQedADGTQm686PCnz83sVa6d/r2WUhA6+
 GWT4NPQys5IZAkdpZY531vSdX/1do/LC7IIfgU54hAt5zcSKXzhKy0b1Vl4dVN43wb8CUt
 iHMnuyppIYJNBJ+qsraUaxAgdJrzkfeMcFC7xZEQJ1jX33RPi61x3Hh6eqVEGbyjQnEYvw
 ovlXaOM5vXYoaw8wZ5XrD5oXMYQbxNUYs+havPOGb+GbCEop5ih6YtpCIihpMcyDk/0UNA
 sLs5Y3/WQDNCmvud51a1dCamUeh81wSPIg6fsGBBqXZivC3YciI6RGfLek0nEA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 4/4] ufs: ti: Rename CONFIG_TI_J721E_UFS to CONFIG_UFS_TI_J721E
Date: Thu, 30 Oct 2025 23:35:45 +0100
Message-ID: <20251030223626.20005-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
References: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pwpumx5abk8nebkode3rptizdfhe5t83
X-MBO-RS-ID: 63899626d6bcc1ad4c5
X-Rspamd-Queue-Id: 4cyJrC589bz9v88
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
 configs/am69_sk_a72_defconfig    |  2 +-
 configs/j7200_evm_a72_defconfig  |  2 +-
 configs/j721e_evm_a72_defconfig  |  2 +-
 configs/j721s2_evm_a72_defconfig |  2 +-
 configs/j784s4_evm_a72_defconfig |  2 +-
 drivers/ufs/Kconfig              | 12 ++++++------
 drivers/ufs/Makefile             |  2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index d91cc71aacc..746b36a34ed 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -8,7 +8,7 @@ CONFIG_TARGET_J784S4_A72_EVM=y
 CONFIG_CMD_UFS=n
 CONFIG_UFS=n
 CONFIG_UFS_CADENCE=n
-CONFIG_TI_J721E_UFS=n
+CONFIG_UFS_TI_J721E=n
 
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
 CONFIG_OF_LIST="ti/k3-am69-sk"
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 75d7d332d30..86d598c0e73 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -197,4 +197,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6164
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_UFS_CADENCE=y
-CONFIG_TI_J721E_UFS=y
+CONFIG_UFS_TI_J721E=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 01faa33c042..da9abf47de8 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -202,7 +202,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6163
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_UFS_CADENCE=y
-CONFIG_TI_J721E_UFS=y
+CONFIG_UFS_TI_J721E=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index a231c12d803..16d01a4b5a9 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -189,4 +189,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_UFS_CADENCE=y
-CONFIG_TI_J721E_UFS=y
+CONFIG_UFS_TI_J721E=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index dc6321cd615..5cfbbf8514c 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -172,6 +172,6 @@ CONFIG_SPL_DFU=y
 CONFIG_CMD_UFS=y
 CONFIG_UFS=y
 CONFIG_UFS_CADENCE=y
-CONFIG_TI_J721E_UFS=y
+CONFIG_UFS_TI_J721E=y
 
 #include <configs/k3_efi_capsule.config>
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index e9e570cddc7..6c75bb2a079 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,12 +8,6 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
-config TI_J721E_UFS
-	bool "Glue Layer driver for UFS on TI J721E devices"
-	help
-	  This selects the glue layer driver for Cadence controller
-	  present on TI's J721E devices.
-
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
 	depends on UFS && ZYNQMP_FIRMWARE
@@ -88,4 +82,10 @@ config UFS_ROCKCHIP
 	  Select this if you have UFS controller on Rockchip chipset.
 	  If unsure, say N.
 
+config UFS_TI_J721E
+	bool "Glue Layer driver for UFS on TI J721E devices"
+	help
+	  This selects the glue layer driver for Cadence controller
+	  present on TI's J721E devices.
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 0358075435f..e7f3c1d30c4 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,7 +4,6 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
-obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
@@ -13,3 +12,4 @@ obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
 obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
+obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
-- 
2.51.0

