Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A0C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359A781B4B;
	Sat, 22 Mar 2025 22:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YI1yYl/A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I+GEI3IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4E381A0C; Sat, 22 Mar 2025 22:56:48 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B11F4810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZKtSY2cvcz9sJ5;
 Sat, 22 Mar 2025 22:56:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XFLlLlURu7eSJzn0QjiZmRUWSIrBIPTi9wdzlaGjaf8=;
 b=YI1yYl/A5UtZMOS5Whylvft85r3IRAXQAfo4iE/9ZqDGVQZrmnQChtLBmkRrMOqz6SVlZk
 GbwF62nYaubNL1kZ56fd4aabseteabuuSbvcT2wnuX8ir790jlSMmMzP7DrXSn1WvJO6V5
 kSThCpPu6RNXIDobHbThWRzmzhoWQQl5PWdQa+0xfIyQFHSFAw6pR8JRX5HnPbtX4CLR+i
 6xnB37rxFEBQXJlh7msHwUvkSspsVSL3ih7rASz6xbKk0Fwb4JDqEXN84kdBiVzpnekonE
 P5roNo6JvwWYbSWdBpuv350otXCIqTd4lkXWmmR6KQuHWwxhslE9zV2fblPYiA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XFLlLlURu7eSJzn0QjiZmRUWSIrBIPTi9wdzlaGjaf8=;
 b=I+GEI3IFtl21NsySoyx6Phjh/VMUVcmi1UZoRxtqyNZnE2PxX+88Lycx0MuAvxXQNIleXD
 42RPXo2CdfjPgwxkXcKkWCgo1F0gGtuYQBDxoLA5Gm/kJj/zDOuGEVrGf2k/dM/oXtInn8
 +D2Rh3UqEXZGqs2cckgkankvq+83DVLYN9vTsBrzs8oVV89gheJID+u23eeA3AKHuGvptV
 jBSbFwsD3ZiCgC/ZCfqBDRISJJG9suHNQPQFUFO0Dw0GK6zt0AL/aoC1u/9mzXZVythfhF
 hTPL8AGIwv9cgWxNPJFzm196TMk3f6mqShnwqvXvF7PpQjOqeofzDgcnkSe+wA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] env: Rename OVERWRITE_ETHADDR_ONCE to
 ENV_OVERWRITE_ETHADDR_ONCE
Date: Sat, 22 Mar 2025 22:55:21 +0100
Message-ID: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ywrudrcx1i8g4txek8b8sh41i5qspgzn
X-MBO-RS-ID: 94596be51f18382313f
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

Rename the variable and add ENV_ prefix, so that all configuration
options which are related to environment would have an CONFIG_ENV_
prefix. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/M5253DEMO_defconfig           | 2 +-
 configs/M5275EVB_defconfig            | 2 +-
 configs/eb_cpu5282_defconfig          | 2 +-
 configs/eb_cpu5282_internal_defconfig | 2 +-
 env/Kconfig                           | 2 +-
 include/env_flags.h                   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/configs/M5253DEMO_defconfig b/configs/M5253DEMO_defconfig
index a1ce8ddf729..4f5e3183395 100644
--- a/configs/M5253DEMO_defconfig
+++ b/configs/M5253DEMO_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_MAC_PARTITION=y
-CONFIG_OVERWRITE_ETHADDR_ONCE=y
+CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="M5253DEMO"
diff --git a/configs/M5275EVB_defconfig b/configs/M5275EVB_defconfig
index 599eaf7b9ce..d09dbf21428 100644
--- a/configs/M5275EVB_defconfig
+++ b/configs/M5275EVB_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
-CONFIG_OVERWRITE_ETHADDR_ONCE=y
+CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
diff --git a/configs/eb_cpu5282_defconfig b/configs/eb_cpu5282_defconfig
index 1c52322768e..00f24533021 100644
--- a/configs/eb_cpu5282_defconfig
+++ b/configs/eb_cpu5282_defconfig
@@ -30,7 +30,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
-CONFIG_OVERWRITE_ETHADDR_ONCE=y
+CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
diff --git a/configs/eb_cpu5282_internal_defconfig b/configs/eb_cpu5282_internal_defconfig
index a8c1b99bb05..c6cd3c74f08 100644
--- a/configs/eb_cpu5282_internal_defconfig
+++ b/configs/eb_cpu5282_internal_defconfig
@@ -28,7 +28,7 @@ CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_MII_INIT=y
-CONFIG_OVERWRITE_ETHADDR_ONCE=y
+CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=y
 CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
 CONFIG_SYS_RX_ETH_BUFFER=8
 CONFIG_DM_I2C=y
diff --git a/env/Kconfig b/env/Kconfig
index 4438f0b392c..a177a354c8b 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -43,7 +43,7 @@ config ENV_OVERWRITE
 	  Use this to permit overriding of certain environmental variables
 	  like Ethernet and Serial
 
-config OVERWRITE_ETHADDR_ONCE
+config ENV_OVERWRITE_ETHADDR_ONCE
 	bool "Enable overwriting ethaddr environment variables once"
 	depends on !ENV_OVERWRITE
 	help
diff --git a/include/env_flags.h b/include/env_flags.h
index 2476043b0e3..aac8b9ab53b 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -50,7 +50,7 @@ enum env_flags_varaccess {
 #ifdef CONFIG_ENV_OVERWRITE
 #define ETHADDR_FLAGS "eth" ETHADDR_WILDCARD "addr:ma,"
 #else
-#ifdef CONFIG_OVERWRITE_ETHADDR_ONCE
+#ifdef CONFIG_ENV_OVERWRITE_ETHADDR_ONCE
 #define ETHADDR_FLAGS "eth" ETHADDR_WILDCARD "addr:mc,"
 #else
 #define ETHADDR_FLAGS "eth" ETHADDR_WILDCARD "addr:mo,"
-- 
2.47.2

