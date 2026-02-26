Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AECFFC5910
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 09:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3F483C54;
	Thu, 26 Feb 2026 10:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6wce7Nl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A3083E61; Thu, 26 Feb 2026 10:31:02 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7859E83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 10:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-436309f1ad7so486548f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772098259; x=1772703059; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nX6UgqRtudBVQac5p2LvXKsXA5nhzDumIyTizkUkrhE=;
 b=E6wce7Nl49gvZSdm10IN1dIzmLRcJZZkZv+rx64TXkEH2r6chW+Pag6C2uM8CMkx+a
 vY18CISY0P9pK+tEpGIBlQRuWzEIqyJMpm9u64Jw+4TXGrcsHD2AaSMZIyPBCydqRwjE
 DoCl0HeZshzgt67cSfgJVZbVa78H2FQcJZMWdFPopOJSpAKHqnpYBzVDNMzqwaAdd/Lu
 bECMvmyTEozAFZjKDYM8nk+CMuY81kp02OqhYzAQ2RxEIh0dZ46JevKBu8Tpps/I11xx
 Q9p42vK9OAQksx6Gdu3auHZl8/g7cdEWUdSp7lAZkBbuR3/f8zu2oUqKpIAyRnpIUEsE
 i5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772098259; x=1772703059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nX6UgqRtudBVQac5p2LvXKsXA5nhzDumIyTizkUkrhE=;
 b=bZ7Gvmq+gxbZwAPWyBhnqYvstqRBLSYIddhhOZcjwbaD3QiCHZDbf8kTx7SKDFgPbw
 QjHlAjaHRwLJ1fEuUaNQyEUKJF4QQGgV4vwJv7VUb5saG/LWEGO+hy7ptqHt/VROAKlT
 00sWwa7uFSkc+4VeeuSRrSftHRKo4uLksL8yos5IyAwLpcQ/HfZa3g01LfxoI0CFwXaD
 LB1ihpRtWU/sktFQe93gnkFwfwxvFMPTACFU9ggfF5+WjvL8WpfPD5sHDh7oWl3aFzZ4
 pJPalE8nGsIhr0McnLDZr8JEFAojwRPhBIW8dCFCqNlU9ncVYeD347XHx0EhZ2Tmjflj
 JmWA==
X-Gm-Message-State: AOJu0YxMtHAMm+3FJsZ8L7Trx9yBbZhoY699CA/KDAPyUgTfuMa92ehp
 alRD1AUzfJUivdlX1l38N9YmxRNQfyLxp9iyWHacnqfKzk5HUS2iMmiPB+5bYXgPK38=
X-Gm-Gg: ATEYQzxlXYEbwHxz3ztVFK+NqPCwx+VNgHNi4m2oKGxpd+eFJDjIF4w2GyLXJuWuPvj
 GprRvhs/lDkNHIU/K03GSUAWhGlNvH21/LCowRyAtJGKL7huC8CIpx2v8+J3hyP+ZJq98zxSlmE
 mIopm4GR3K8pFH4IQBuO9uxjhEXM8/Y00kxnCiRwxrZLI57MBBFHS+ujeqstNQWPvpCwvJqnJsc
 VwDJq6Qoqm8vzXwc0wSo1MZ9JtFKMvK+0BBxnlQJv80hVI9L2P8D1a7ZEqCpyaE9qCN8/+0gz9f
 Ozx/l4B9NdPRz2XSK74ydVD/XOgY/aW96DiWwpyP5J9kjKFbFvy9sKatqtfpCroGVJ2t7wTZyyS
 iBpVkrWzGSLjjznwJFk8lXC/c5nN2QDpsX5K5q6uljZXjhrJvRnCht2QtCq+L2QID18gpJJDZio
 vn8UJZAC1n3taoX4MBRY6TXiEOOgnq9M7C7V46RhmwfI0UPfXM+pN6bAulwuuYs0odGzi6z4Z4S
 Wec+20ExKxy395ozi74TcDxFgZVEnHYaqIcrA9ZQhXj
X-Received: by 2002:a05:6000:2382:b0:437:69ee:71f4 with SMTP id
 ffacd0b85a97d-439942ed2camr6492398f8f.28.1772098258639; 
 Thu, 26 Feb 2026 01:30:58 -0800 (PST)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399037aecesm10369556f8f.15.2026.02.26.01.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 01:30:57 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1] configs: toradex-smarc-imx95: Enable remoteproc
Date: Thu, 26 Feb 2026 10:29:53 +0100
Message-ID: <20260226092956.1098548-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable the remoteproc command, i.MX remoteproc driver, System
Manager SCMI CPU and LMM support to control the Cortex-M7.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/toradex-smarc-imx95_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 77b355c12d6c..ad908949b592 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -74,6 +74,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_READ=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -122,6 +123,8 @@ CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_SPL_DM_PCA953X=y
@@ -152,6 +155,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
-- 
2.43.0

