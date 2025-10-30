Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B54FCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 22:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08E883677;
	Thu, 30 Oct 2025 23:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yG1h3sNq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dieSa430";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5C838AE; Thu, 30 Oct 2025 23:36:45 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD3E8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cyJr933xMz9t83;
 Thu, 30 Oct 2025 23:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1kX1E5gHUaOMdNlfuwG1sUnnzI6+B6/7B1+YCtevwuQ=;
 b=yG1h3sNquzBAISmbyqLIwNgrRKr3Cae7oVCVRer7eyVzfdlyhWVTqd2cpwBhlkCnikwbQP
 eRqpjD8bAwm/Xl5SSHzwZ+Nm3P87WsE4KTrDuF1NPy0d4smLzhtkOJpVwFFniiXbaG4Gkp
 /20TsSdKUrOHcm77vxWNWjI1yYjBb3p/GEWBDvZGuQ+mPcK23gJsg0LNxcGAfNPANtBg/+
 duSafuBkqfcInheh23lHmYKW80meUlokv+Oo8+6IVCpFFuMEEd6tKAlxsJDfsob+bltuPj
 j1vIq65s6Bl/51HwvfH1RKS4rRPmXSRY1wb9a9dzEaiBFKSUlQd7thtJSWo/Ug==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1kX1E5gHUaOMdNlfuwG1sUnnzI6+B6/7B1+YCtevwuQ=;
 b=dieSa430DVHRkHk7l8pbBwETMgzo2JrE2oOuRvPRBmLVMyY0bP+wh8ms/F4qywoeBO3SFA
 PVVj7NCfYKOMs8bTuCWVdK5vm0cPSBg8PvLLAjbYSBkPYgyb/B8qP8kY7rDYBRXtH0QV/l
 px8/KcjaUSegqL2hamTYTGOAJKaqAosSUh7uaUCSkILiFV5ks5gJNSdDT3V2M0XDERdAyD
 Bf9IK3QvFXnHXcNT0p2V1H1dYvL9VQtk7ViBlP25WkEHVgY5LD678AjXEpeA+vzzY5pUW2
 SawT5gUFy55QH00L4btl95r7a8jbbS8cH7H+NNtrDs31rat4+STytia0IG7UfA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 3/4] ufs: rockchip: Rename CONFIG_ROCKCHIP_UFS to
 CONFIG_UFS_ROCKCHIP
Date: Thu, 30 Oct 2025 23:35:44 +0100
Message-ID: <20251030223626.20005-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
References: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jtswaziomiri4ti1jhoeu9n7uy74nfc5
X-MBO-RS-ID: f7e094d697706e19ac6
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
 drivers/ufs/Kconfig  | 18 +++++++++---------
 drivers/ufs/Makefile |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 288d3de824c..e9e570cddc7 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,15 +8,6 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
-config ROCKCHIP_UFS
-	bool "Rockchip specific hooks to UFS controller platform driver"
-	depends on UFS
-	help
-	  This selects the Rockchip specific additions to UFSHCD platform driver.
-
-	  Select this if you have UFS controller on Rockchip chipset.
-	  If unsure, say N.
-
 config TI_J721E_UFS
 	bool "Glue Layer driver for UFS on TI J721E devices"
 	help
@@ -88,4 +79,13 @@ config UFS_RENESAS_GEN5
 	  platform driver. UFS host on Renesas needs some vendor
 	  specific configuration before accessing the hardware.
 
+config UFS_ROCKCHIP
+	bool "Rockchip specific hooks to UFS controller platform driver"
+	depends on UFS
+	help
+	  This selects the Rockchip specific additions to UFSHCD platform driver.
+
+	  Select this if you have UFS controller on Rockchip chipset.
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 18ed250d059..0358075435f 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,7 +4,6 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
-obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
 obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
@@ -13,3 +12,4 @@ obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_QCOM) += ufs-qcom.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
+obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
-- 
2.51.0

