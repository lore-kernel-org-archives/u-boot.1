Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7AC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973E087D97;
	Wed, 21 Feb 2024 13:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="FL5lvHPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvllA8Ea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDECD87E1C; Wed, 21 Feb 2024 13:00:29 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2E987D78
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 13:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1708516823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=83QJyc9GxvVyl8LCsRSiYCz2fhYy48Lnt53vqYplNtk=;
 b=FL5lvHPn6TJjd03RYv7D+RVa+dbxL9gc+FbNxHR01FgldRvJyOWXViNq1QAdxT+XsCdnlr
 D9qL9VvXp5bAAEQ2afFmRxFgznunPFuPi6yDrqg+kp1OU9UcS5y6035Y5xZqUbUJyu6mgq
 LkilWDi/n4EnL8lh+VGsuZjz/sr6BaQpHmdzA6Bo3eF+dXFfGJ/4gPWClKIwvg2FEEktsp
 tDkukJYbI3akXH9Q45W8ogvzVYjXpSaiGNgVjODTi9YCk1LEWD3SoVdsy43gPdxV8pgL3M
 wRn8EQb1vzh2FgVNhUsajtf5wdbxqR28tZ7ZCjEXzJyzHU5WIc6tnhU5yW8HcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1708516823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=83QJyc9GxvVyl8LCsRSiYCz2fhYy48Lnt53vqYplNtk=;
 b=hvllA8Eah4hgnx6OWaUrNNaA60oQr7wqYuUm2d7RQZ0AOlHHup1yKqYUpdh0vg7ntC9Jjw
 iKaDqWa7vtZVuQCQ==
To: ycliang@andestech.com, yanhong.wang@starfivetech.com,
 chanho61.park@samsung.com, wiagn233@outlook.com, namcao@linutronix.de,
 sjg@chromium.org, inindev@gmail.com, rick@andestech.com, mps@arvanta.net,
 bmeng@tinylab.org, u-boot@lists.denx.de
Subject: [PATCH] starfive: visionfive2: switch to standard boot
Date: Wed, 21 Feb 2024 13:00:14 +0100
Message-Id: <20240221120014.149193-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Distro boot scripts are deprecated. Use standard boot instead.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 configs/starfive_visionfive2_defconfig |  2 +-
 include/configs/starfive-visionfive2.h | 14 +-------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visi=
onfive2_defconfig
index b11be7ac86..aec751f871 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -31,8 +31,8 @@ CONFIG_RISCV_SMODE=3Dy
 # CONFIG_OF_BOARD_FIXUP is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT=3Dy
+CONFIG_BOOTSTD_DEFAULTS=3Dy
 CONFIG_SYS_BOOTM_LEN=3D0x4000000
-CONFIG_DISTRO_DEFAULTS=3Dy
 CONFIG_BOOTSTAGE=3Dy
 CONFIG_QSPI_BOOT=3Dy
 CONFIG_SD_BOOT=3Dy
diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starf=
ive-visionfive2.h
index 29c74470c7..049b0a0630 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -15,17 +15,6 @@
=20
 #define __io
=20
-/* Environment options */
-
-#define BOOT_TARGET_DEVICES(func) \
-	func(NVME, nvme, 0) \
-	func(USB, usb, 0) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
 #define TYPE_GUID_SPL		"2E54B353-1271-4842-806F-E436D6AF6985"
 #define TYPE_GUID_UBOOT	"BC13C2FF-59E6-4262-A352-B275FD6F7172"
 #define TYPE_GUID_SYSTEM	"EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"
@@ -48,7 +37,6 @@
 	"type_guid_gpt_loader2=3D" TYPE_GUID_UBOOT "\0" \
 	"type_guid_gpt_system=3D" TYPE_GUID_SYSTEM "\0" \
 	"partitions=3D" PARTS_DEFAULT "\0" \
-	"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
-	BOOTENV
+	"fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0"
=20
 #endif /* _STARFIVE_VISIONFIVE2_H */
--=20
2.39.2

