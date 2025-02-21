Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E472C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5E380F6F;
	Fri, 21 Feb 2025 18:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740157680;
	bh=ZYIePkbqaBQKd2milXWVTA4pF69O9n/Kh0JoPwUFU/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q2BSe4S7DoyI1gCMRnP2KaSBteHSCOd7f6cwVdwmUi5X5ntDSDxc2oOE10t/vsLA+
	 mdbiiWH4PpG1wcnebUc5oo9MXIvjkIzIIqX6rD1vBHfQsi9ohtVw6BTU7+4M5afKea
	 XZbtYm+vUkgWoEHOOJGr9l/9qrX0PR/EroyCwbDb6zDpKjYSXNWr6oHTsa/7sVruzl
	 /nA/rONrlMZrJVGjcM6rVp0AkOgeEyFqiqVSLbpRNvI4vQN0qPjRGV1azq1olnWLJ4
	 2KtWANM3BI0JiVSAQeSb3YukPyxKmPB/ZG90roiejbQZAphkvAQEH2bxc67o7bn44V
	 GOvi0YtTb08mw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC6F80F6F; Fri, 21 Feb 2025 18:07:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5833680F56
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="XuuX85Ik"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2136810382D3C; Fri, 21 Feb 2025 18:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740157674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYIePkbqaBQKd2milXWVTA4pF69O9n/Kh0JoPwUFU/I=;
 b=XuuX85IkHD7mxDqvEaNRWZN1UTjmwL0olb3BPvKRuJ0RWwGkJqAtxSDS51W9XThyhfYuDL
 6QoRS8WXlqpz9EAgev2T3nf+RmAR8F8Vz9MGs18EA7w4lLUF0LGAYGGeSpkC8cpUtFf9/g
 nCjMXY/pf0AR7up1Unqjmsupcc9VUmbR3xjOvYG3OnjELj1sRDP55l0hp1kZ/9jC4kbnfb
 DRJd1Ky+ezS2D1GPw8A3xb159sKGvWx52W4RMcqO1FPxg7dumQ2uIoaoaUHfFVSFZLePKf
 OHZKfe2FI/dx4V88uXnhYLxIjfgS8B8Jj+3UoxsNNnNmPLCe1nueCqcpco12jw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication on
 Data Modul i.MX8M eDM SBC
Date: Fri, 21 Feb 2025 18:07:17 +0100
Message-ID: <20250221170738.184822-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250221170738.184822-1-marex@denx.de>
References: <20250221170738.184822-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Deduplicate the config files again, move CONFIG_BOOTCOUNT_ALTBOOTCMD
into common imx8m_data_modul.config .

Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/imx8m_data_modul.config             | 1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig | 1 -
 configs/imx8mp_data_modul_edm_sbc_defconfig | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 2164c754915..37e11e518a8 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -13,6 +13,7 @@ CONFIG_ARCH_MISC_INIT=y
 CONFIG_ARM=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_BOOTCOMMAND="run dmo_update_env ; load ${devtype} ${devnum}:${devpart} ${loadaddr} boot/fitImage && source ${loadaddr}:bootscr-boot.cmd ; reset"
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index ef1d73c2f73..66cb1331ded 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -37,4 +37,3 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index 5024c093b99..ea8109bf049 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -52,4 +52,3 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
-- 
2.47.2

