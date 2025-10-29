Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D0CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 20:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE64C81E13;
	Wed, 29 Oct 2025 21:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X/kEAa92";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lv6kTNZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB6482A9E; Wed, 29 Oct 2025 21:14:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4E18004F
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 21:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cxdkn1HZ3z9sv0;
 Wed, 29 Oct 2025 21:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761768881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RGNsKwpwOlPJocqdbunZKg77pH/tJ6vJSrN+qFtu2jc=;
 b=X/kEAa92d5KJYgXVVSWt7YNwczfZSHbLj+aCu3MxNFAT7JktrmLwePmS8TkNpV1gdnpc/6
 diRXoX5wJ1U0I1AdRnAl1xre6utSthu6YLzHa11Di5xfi0lawhJYxg/8sdCj16y4dkAMvE
 LqRCBEYR7v8WCLHXejhEpjZvsW1sY/+T7HGko6pS5DWNojqHpuqqxMb5z8I7zo8AtltM8E
 YotQX6gF3xC/7/vhEHTUARGkYkOb5Wbd7c9bi6AlPeOI7u4QBLLWuejjArfTCJSa+H9lwu
 EYJygCfU4etv8eKhyFHs7KhPghI/wdSHo1vQpYAeSMhKdzDX6Ibt9j9rE7Qy+A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lv6kTNZz;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761768879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RGNsKwpwOlPJocqdbunZKg77pH/tJ6vJSrN+qFtu2jc=;
 b=lv6kTNZzt73zHFuW7OdzbWnmd089kUAE7ynyl3AdgmX7J1dybpijiXpwIJ+U6aHuzpzkyV
 6dXwfUjxo+JGZ0sIicoWZ2plPSRttIyqjr2Z7Q/plgMjCH1+W5BAUpPBghIBOvRIU6ylQB
 JSpwdHJJUaGKguXFyELtBA+XPmBCLlSdnXvR9VcGkfkxKjmyDigMaMBuKJMFyxCCnsXqQ7
 PD572xh8UtTaKHq4+yKWjh9WpRjWVQAQm8ulHva+hYsPO7Gk0QGRz+RSo+pKLzVUOPJbJ/
 XwdJkiHnTixJrLQW0Sj1NP2s40lGMy0AMilNFkG96jMKUj73Thf16rJhBueEPA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] ufs: Keep Makefile and Kconfig sorted one more time
Date: Wed, 29 Oct 2025 21:14:10 +0100
Message-ID: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8x6tx84r9p8n3pzdqgoesyis4xsckccz
X-MBO-RS-ID: 312f921bba6123ac943
X-Rspamd-Queue-Id: 4cxdkn1HZ3z9sv0
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

Sort the Makefile and Kconfig alphabetically again. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tuyen Dang <tuyen.dang.xa@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/Kconfig  | 28 ++++++++++++++--------------
 drivers/ufs/Makefile |  4 ++--
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 68693b7d226..445270e8da1 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -15,20 +15,6 @@ config CADENCE_UFS
 	  This selects the platform driver for the Cadence UFS host
 	  controller present on present TI's J721e devices.
 
-config UFS_MEDIATEK
-	tristate "MediaTek UFS Host Controller Driver"
-	depends on UFS && ARCH_MEDIATEK
-	select PHY_MTK_UFS
-	help
-	  This selects the MediaTek specific additions to UFSHCD platform driver.
-	  UFS host on Mediatek needs some vendor specific configuration before
-	  accessing the hardware which includes PHY configuration and vendor
-	  specific registers.
-
-	  Select this if you have UFS controller on MediaTek chipset.
-
-	  If unsure, say N.
-
 config QCOM_UFS
 	bool "Qualcomm Host Controller driver for UFS"
 	depends on UFS && ARCH_SNAPDRAGON
@@ -59,6 +45,20 @@ config UFS_AMD_VERSAL2
 	  UFS host on AMD needs some vendor specific configuration before accessing
 	  the hardware.
 
+config UFS_MEDIATEK
+	tristate "MediaTek UFS Host Controller Driver"
+	depends on UFS && ARCH_MEDIATEK
+	select PHY_MTK_UFS
+	help
+	  This selects the MediaTek specific additions to UFSHCD platform driver.
+	  UFS host on Mediatek needs some vendor specific configuration before
+	  accessing the hardware which includes PHY configuration and vendor
+	  specific registers.
+
+	  Select this if you have UFS controller on MediaTek chipset.
+
+	  If unsure, say N.
+
 config UFS_PCI
 	bool "PCI bus based UFS Controller support"
 	depends on PCI && UFS
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 15329b9795a..6b2f2ccc9fc 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -5,11 +5,11 @@
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
 obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
-obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
+obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
+obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
 obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
-obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
-- 
2.51.0

