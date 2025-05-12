Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6094C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D21080C83;
	Mon, 12 May 2025 18:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMlU2Eaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D07FC826AA; Mon, 12 May 2025 18:39:41 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A942880584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcmvbkbc@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af51596da56so3844528a12.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747067978; x=1747672778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QYgeAKCqEAIVkIpqiiV8ddnlAk1/jE+TzsTox3rorWg=;
 b=DMlU2Eaf1mmnDKI3yiDXaBj9uZgY1XfpSZ0zleE1bFKotM8WsFw2R7/s59wU2iVf5n
 k3gCeCzUQcq7y5i/fRkBqNFhhuJxVN2DQOs8gAYD6qySZr5s2q/GDspXk/dhcIt/Qoo6
 r25d4XMnPD0MHMpirtCJ3GaGFJxbhlIU2jZo2A2yJG+CeOEQenJgsAIHT2t2J5cb3p5U
 FguPip4fSCxdDzBgf1Nn5zviKF7K8V17mE7reW/K1Ugh9KYh5QAI0Nw5IYoJwZpyTR34
 JHsU+4V7s5kwh3M8ss0Gfnb6/m1ZXnSiA7X6dZ40YwhFtL0LUssPq+o3O8iNIZiN/syC
 Z8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747067978; x=1747672778;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYgeAKCqEAIVkIpqiiV8ddnlAk1/jE+TzsTox3rorWg=;
 b=NC+6zjMgN0tg//uAx0v0ho93RbkaCoPa+NlMnAmSVrZPlzeak36xpe4f3ZoHrGDEKh
 Zw3qORkONmTCBCQmHZlosxgYT6FjfgondGOY/YGhDcEtboYAOvam+3bxVQfpO6IFg0nV
 muCCYvqR5uFSa3Mh8r8oIeXcjnFPwEDYTN76LBNv7/yz/DXnkGwsjk5Dcgw28hP4Y8df
 i0KqaHJGN7h48AP1T+z0fzt6gjkLMV2zigyorMTRvlqxS4Ljnk/PGjyG0azMd308CxMw
 xF/IWnAg64hAIHN1lBgGTVArI1Ik9VEsof5+3LuhuFwND69stQK1F89DHBQYPMH5+6vo
 uiCA==
X-Gm-Message-State: AOJu0YxZXP6VGMg5uEBFtI7KQUI5tDngaeea1jHKb4wkOhIYovkQ53C5
 X0xdAou/HA9lfPxuMuje3NV8TvNIl+v5sA1taQdnMCAQhXryOz/3wEiXvg==
X-Gm-Gg: ASbGncuozHUpnxCXRxgUYc0USbG8V2vfYB/od2v5J6t1pfV22Wq5wSwON3Qk3tKV4u7
 nI5Kr94DzmYnk5ieOaWTb3k/Uu8YJkMMQelFWu0UXlDx3qbhvNsrbnLfcTo5rFV6RnxPgC2wkn9
 v2yJhAvo6bOVjisgoMZ/BM+j6GFKB4EIbZM/z+uNJUhmusqjbipggVqmqHuBBMztZc53vNkOxyt
 aE8ep9vm4jx6RM8COrJSr4XzOHroe4rxDiQE5pD58xp0QFOqLy7W8UiohOXG2HXNzEOtE9+wB/b
 hINNSwBdIqLVQHmzDNrmDCS+rbG6aUlffL5GGPhhp4fC/tMmMegco2xuVdkirLpFJ0b+/KrC/J4
 2WvzyA055mQUi4H5PhG46WPu29UTf9y8=
X-Google-Smtp-Source: AGHT+IFTnpxLIB2FmcZ01ZT9AASKauy0oC7oYPH2ExuC1BT1oQ3vyoP+czcBmK/dRshwgSW5Fn4SpQ==
X-Received: by 2002:a17:903:2f88:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22fc8d98a75mr250211285ad.35.1747067978036; 
 Mon, 12 May 2025 09:39:38 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc829f195sm65145285ad.209.2025.05.12.09.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 09:39:37 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: xtfpga: enable DM_SERIAL
Date: Mon, 12 May 2025 09:39:31 -0700
Message-Id: <20250512163931.4184305-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Enable DM_SERIAL for the xtensa architecture and update xtfpga_defconfig

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/Kconfig             | 1 +
 configs/xtfpga_defconfig | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index ea33d07c086b..38284d22020b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -361,6 +361,7 @@ config X86
 config XTENSA
 	bool "Xtensa architecture"
 	select CREATE_ARCH_SYMLINK
+	select DM_SERIAL
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
 
diff --git a/configs/xtfpga_defconfig b/configs/xtfpga_defconfig
index b96dc10d85be..8303c9398da2 100644
--- a/configs/xtfpga_defconfig
+++ b/configs/xtfpga_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_LEN=0x40000
 CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DEFAULT_DEVICE_TREE="kc705"
 CONFIG_SYS_MONITOR_LEN=262144
 CONFIG_SYS_LOAD_ADDR=0x02000000
 CONFIG_ENV_ADDR=0xF7FE0000
@@ -28,6 +29,7 @@ CONFIG_CMD_SAVES=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_DIAG=y
+CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="uImage"
@@ -46,7 +48,5 @@ CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_SECT=1027
 CONFIG_PHYLIB=y
 CONFIG_ETHOC=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_SYS_NS16550=y
 CONFIG_SYSRESET=y
-CONFIG_OF_LIBFDT=y
-- 
2.39.5

