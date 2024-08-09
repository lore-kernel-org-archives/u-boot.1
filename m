Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D82CC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510DF88BA5;
	Fri,  9 Aug 2024 17:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aEcInulS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756DE88BA5; Fri,  9 Aug 2024 17:13:02 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D28889B8
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7c3d8105646so37005a12.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723216378; x=1723821178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YM6HXYV8McWIYU+cHWWbGFgtbvhYSPq/GUBtlMz+G9g=;
 b=aEcInulSqZhsfsb3UW5LpbcwiwEkHTUo80PP0xlJoxQBYLcabd45YroO4gmgv1s0cV
 N00cfctjlleeYezyGp3X5oMhm/Izw0XY3DYukepjVxavbT30gZSjcyQWBvtH35eBekPv
 la0tQccnjt7ZNVJki06tbRk7l/ocx8ww5f0bM3Mb3Yj9eAHlCWQa9HvfIzIVVdItMpuw
 aKDTSvxJ9LnsNnfN5S9bjcrivpshgSRkFj6inZUwTP4PZKZ9kGEraaFg6zSRljmhnS6G
 FgrqnlAuXg0kl5LQ0Onfm2Qb0JERwA75Bjdw+r5jCLsE8PkFs4F7h1gEkZSH3iBFiJKZ
 /TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723216378; x=1723821178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YM6HXYV8McWIYU+cHWWbGFgtbvhYSPq/GUBtlMz+G9g=;
 b=HfLCVGg40cvtPxoNdqO3G0A1B1qr4rvU9RHsngq6Rs4FO43wP/J9VLr3TODgUX75Wr
 ouGBtpmuVGiwqECfxLdn60Gzd666Zl+MiuiJxqArCWVTGe4nDF5BLfCQ8rC3z5dXUiDc
 1Pvdqz5kopNHf4aHivgb8NYtzst7xhvLbXgKnEDsXc7edKC/p3NuXIAURfKalFm03gz8
 nPh95XsOQU/9CVwTxF0Iz2Pyr8C2PqIKi2dkJHVYChUYKnHx/r3HkFhNof8hATveHBcW
 xrnvGY0brmYzCnXBHpn/b5e9rn1SY+Ff08S8kgp9vCdtKIgz4i6/CU8Agh/uC6TJON+3
 yHqw==
X-Gm-Message-State: AOJu0YwvqklcJBmDWacm7LmAgLqNPY9QJ7TKyesUzKlbHC4n6hBAN5ug
 9vyb3Qbok6MorET+sIfbr5Va6/HSPqy1ISBABuIoqez6P8xK0+x1
X-Google-Smtp-Source: AGHT+IG3xPxME0I1MmZ53dC7H/kirF4ym8U5/F7buze2mFcV9jLpRSjkYCtD4EIFtZ1KHmEZYOnitg==
X-Received: by 2002:a05:6a20:4322:b0:1c3:c1d0:226 with SMTP id
 adf61e73a8af0-1c8a0411547mr1347948637.7.1723216377087; 
 Fri, 09 Aug 2024 08:12:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c7cd:c377:d374:237c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9f5aasm11351556a12.6.2024.08.09.08.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 08:12:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] tqma6q_mba6: Convert to watchdog driver model
Date: Fri,  9 Aug 2024 12:12:47 -0300
Message-Id: <20240809151247.539068-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi |  3 +++
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi  |  3 +++
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi | 15 +++++++++++++++
 configs/tqma6dl_mba6_mmc_defconfig    |  3 +++
 configs/tqma6dl_mba6_spi_defconfig    |  3 +++
 configs/tqma6q_mba6_mmc_defconfig     |  3 +++
 configs/tqma6q_mba6_spi_defconfig     |  3 +++
 configs/tqma6s_mba6_mmc_defconfig     |  3 +++
 configs/tqma6s_mba6_spi_defconfig     |  3 +++
 9 files changed, 39 insertions(+)
 create mode 100644 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6q-mba6b-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi

diff --git a/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi b/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
new file mode 100644
index 000000000000..bb17ba9b4249
--- /dev/null
+++ b/arch/arm/dts/imx6dl-mba6b-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6q-mba6b-u-boot.dtsi b/arch/arm/dts/imx6q-mba6b-u-boot.dtsi
new file mode 100644
index 000000000000..bb17ba9b4249
--- /dev/null
+++ b/arch/arm/dts/imx6q-mba6b-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "imx6qdl-mba6-u-boot.dtsi"
diff --git a/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
new file mode 100644
index 000000000000..78457ef68f4f
--- /dev/null
+++ b/arch/arm/dts/imx6qdl-mba6-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "imx6qdl-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index 1a1d253c50ee..1534a2e9262a 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -65,5 +65,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index c6a1c7cf3d7d..5eaa9eb270ce 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -69,5 +69,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 27f949c6ef68..3fcc1f8d54e1 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -65,5 +65,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 5d3ce79c35d9..a7ffc9edb5b4 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -69,5 +69,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index a9ed0d3fc2c6..7839c4858478 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -65,5 +65,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 9cd8c3dd20f4..c3bb44025b34 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -69,5 +69,8 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

