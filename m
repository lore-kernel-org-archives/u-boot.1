Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57B1C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E360282B48;
	Mon,  9 Jun 2025 21:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NcWfshNo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iHU5RubO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E8D8144A; Mon,  9 Jun 2025 21:27:23 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3109D82B0E
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bGMPj09ypz9spH;
 Mon,  9 Jun 2025 21:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDCJKTVfqcfdSTPTswh0bFUNcc6RlmHDbzq4t+SnAXU=;
 b=NcWfshNo87TYQkJzQ5AzCdDKl5CIePV6dkieaTjbaqH9/yb3J+9oeIg6bsYI5uyGBUchYx
 5Nvd5UQ30Yq5WTog1DUydo5+Bq+OAyOsdGIvZc9xuR6FruNSt0J/PZL5JIzzNqtRT4W11u
 oSnneBtuytUHxhhbzlRo3bBKq0RuDnponATpPEH+28yFiNF4a12ahsa6TtLORcs7tHuVRd
 IueSxmXRK/4+qNoP4GHPD4V5henAxAN2eNwDZ4ARezjtPqjYJH8V5svv3sXy4Uf9dyWgAu
 BPT2n3k+ASZy/42RiECzi/DXf4wrjMv0hP0F3kCUW0XvxzPXreyJcKFn5a+aGA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDCJKTVfqcfdSTPTswh0bFUNcc6RlmHDbzq4t+SnAXU=;
 b=iHU5RubOlMkZe+IHNkBUL1nw6CPwCcq8j5rm3rqKDOyZGHnTj8P3Db5p4uePk/5ODtBWdn
 KllCIqjQuji91c9Jv+XySb/qRK1eJUEBEF4mrJDs0I44EOYzbgLSFt/kKE5C8vO8st/kRI
 v1Dy8JQ6wUzlAM1LzeXr1JH0fHmpU4fOSrqXnnc0QShmCoQQB6VT12/MqZW17lQ4AFFNdn
 eDKa0Qoqeiks6Qnwn0VEhc1IYwgriKwbD2YEXabUSFLVFYri/PdmADwVGjKgMpih6puGSM
 bHZmbFo5suvRaoVgo+HgKsPzRwugMUp8KyPxNbBlSGorQB8v+I6qjxbnJJaxAQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/8] env: Rename OVERWRITE_ETHADDR_ONCE to
 ENV_OVERWRITE_ETHADDR_ONCE
Date: Mon,  9 Jun 2025 21:26:36 +0200
Message-ID: <20250609192701.20260-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e1c18c3fb25ba9f1fda
X-MBO-RS-META: o43t4uje6yx9zdccoh54ej3h4uziyyau
X-Rspamd-Queue-Id: 4bGMPj09ypz9spH
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Add RB from Quentin and Tom
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
index 8203ef73fce..ee47b565213 100644
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

