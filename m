Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41834CD37B2
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 23:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AD284711;
	Sun, 10 May 2026 01:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIsVXLue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85398485F; Sun, 10 May 2026 01:02:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63A28470B
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 01:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso1688613a34.3
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778367740; x=1778972540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/crUnX78+xBAlOjkEcBwcKfNbG8nPLJzqdC0oxmSHoY=;
 b=pIsVXLueiSUHCu9qWs4yOzTlsp33Rrbzv8p5tdI9/wu2GU8Qat3Vz/SuDSVsoh1pqO
 jCUlXUETos8cDjUcS8hsqJStZRJQ+Ic3B1tKNDFaDACayZbfuWFj9OVuincZ+h980sKd
 ty/49MkDpD82UFi8ZupydX45jMi3uTxY+QrxX+9jN7SnvfTbvxy1Pdf8kLhCcsx83K0f
 5+PLJ5kbgNqapNr8Jh0lEprTOj/U5543PZOflpLKbfofLPbk+2eQDPq3qA4gp/aQjb1G
 FAJ4HJxzdaCXESpYSC5rnk9OlsQt8UaeGxowkLccR8fQ3nAFoc5BobhHx4gkpJC1ZuDT
 oAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778367740; x=1778972540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/crUnX78+xBAlOjkEcBwcKfNbG8nPLJzqdC0oxmSHoY=;
 b=kS3xd/+htuvthqBrRJDBIg9I8ZQVGVcSAXDGgQrArNHkHcLe0XuKskvDT8O7ogDIb0
 NB3UpPJcZWIIfA0YjoBnzroilq3JePBMVc1sUJfTedb0+pskB01HNkRBiY6lF7NaEHSI
 fr0do29uhB8IEPRFOjqncq15H8y0R2xGrbQ1Bj9wqRt4STi3z1UkH2SBMK2pkFaR1faR
 IU1ThSDGF/cBXmHjytk6ENM+HLVCaqZvWSZA01RRp4xSkEDKcOWzXCdm+09y6l7PoT8c
 CMXj0UacJDuUG47ZjVHIoWwscx7HiBGnahzmWQDlKajRS0+FTSAW1yXIUQIYIXAiqq3Y
 9tEg==
X-Gm-Message-State: AOJu0YxjdkdPE8IEaOrF7gNl76z8k0w+WX5kWxLhlrSHY5bO7dZ8s6aj
 9uzYjn43Ls86UuB7cP5KC0KlIV2/ein3TgSnHefQ/BChm6jN/N4PbWKVEtX4PT71
X-Gm-Gg: Acq92OG2Rtoa51IpzwcSjOs9ouWasKParymPtHJcgSfrWpgEOzrnaL6Vf+cOwPO8HcA
 kU0vaSQVFfuYGrsv/F/YDujZjl22Z1Va3ucbmwwY+AYt2uRlh6o8WwqyHk1LewshKpCVHNEx2V3
 +Ca0aYRvPuCvtNH2j8pNiNyULYKIlRG6/zLC/b2HCtxK+bZCLGDj6G0gl2uWStEdBsVU3wv9iXH
 6u6UyDrr6ObE4CkHmTBiE611F9QnfHbIqwVm1KNjy57fby9FkICHkiueKXFUzwAGCKNQ4syaPTI
 BBnIakhMFuEaCzMMYlp5hLzRe6TNDX/zoKIhNMRLjJjyeJykKlaSzbvJPUq2PeXaO1VnS9ijWWn
 /gBipdQQCdnhq14SE+pq8DQq1mpiC2lJMYAyxHXnw34oFkUwiHRifmC32XpB6yYuwvkVexNiUMc
 84oeI2KxFcu+ykzQM4UE44utb65ViB9B/+9OhAJ9jcylSFFzu5OqpQ64AtDOQQB/EGKSpk5Dx10
 L2KHRd7wmuvvn43nE2O657r/JlyJ7mAg3hMEWD/bAkOSXfqx74Cl1yCGEMbU7EnT1Gu+7aZ
X-Received: by 2002:a05:6820:883:b0:695:66d5:6a72 with SMTP id
 006d021491bc7-69998d47f38mr10788660eaf.50.1778367739648; 
 Sat, 09 May 2026 16:02:19 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-113-237.hlrn.qwest.net.
 [71.218.113.237]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dc00acsm3261043eaf.10.2026.05.09.16.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 16:02:18 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Philip Molloy <philip.molloy@analog.com>,
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH] env: add Kconfig option for static flags list
Date: Sat,  9 May 2026 17:01:44 -0600
Message-ID: <20260509230147.1308308-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Environment callbacks can already be configured from Kconfig with
CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
require board headers to define CFG_ENV_FLAGS_LIST_STATIC.

Add CONFIG_ENV_FLAGS_LIST_STATIC and append it to ENV_FLAGS_LIST_STATIC
after the legacy CFG_ENV_FLAGS_LIST_STATIC value. Normalize existing
CFG_ENV_FLAGS_LIST_STATIC definitions to end with a comma so the Kconfig
list can be concatenated directly.

This lets boards configure writeable-list policy and type validation
from defconfig without adding a config header solely for env flags.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 README                             |  6 ++++++
 env/Kconfig                        | 13 +++++++++++++
 include/configs/capricorn-common.h |  2 +-
 include/configs/hmibsc.h           |  2 +-
 include/configs/imx6q-bosch-acc.h  |  2 +-
 include/configs/iot2050.h          |  2 +-
 include/configs/socrates.h         |  2 +-
 include/env_flags.h                |  3 ++-
 8 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 6836a917c79..b963ce23078 100644
--- a/README
+++ b/README
@@ -1107,6 +1107,7 @@ Configuration Settings:
 		Use buffered writes to flash.
 
 - CONFIG_ENV_FLAGS_LIST_DEFAULT
+- CONFIG_ENV_FLAGS_LIST_STATIC
 - CFG_ENV_FLAGS_LIST_STATIC
 	Enable validation of the values given to environment variables when
 	calling env set.  Variables can be restricted to only decimal,
@@ -1133,11 +1134,16 @@ Configuration Settings:
 		r - Read-only
 		o - Write-once
 		c - Change-default
+		w - Writeable if CONFIG_ENV_WRITEABLE_LIST is enabled
 
 	- CONFIG_ENV_FLAGS_LIST_DEFAULT
 		Define this to a list (string) to define the ".flags"
 		environment variable in the default or embedded environment.
 
+	- CONFIG_ENV_FLAGS_LIST_STATIC
+		Define this to a list (string) to add to the static flags
+		list.
+
 	- CFG_ENV_FLAGS_LIST_STATIC
 		Define this to a list (string) to define validation that
 		should be done if an entry is not found in the ".flags"
diff --git a/env/Kconfig b/env/Kconfig
index 7abd82ab6f3..ca8f9aff19e 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -34,6 +34,19 @@ config ENV_CALLBACK_LIST_STATIC
 	  If the callback name is not specified, then the callback is deleted.
 	  Spaces are also allowed anywhere in the list.
 
+config ENV_FLAGS_LIST_STATIC
+	string "Static flags list"
+	default ""
+	help
+	  The environment flags are associated with variables in a static
+	  list. Define this list in the same format as
+	  CFG_ENV_FLAGS_LIST_STATIC.
+
+	  When CONFIG_ENV_WRITEABLE_LIST is enabled, the 'w' access attribute
+	  can be used to mark variables as writable.
+
+	  Spaces are also allowed anywhere in the list.
+
 config SAVEENV
 	def_bool y if CMD_SAVEENV
 
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index ee13d2ab950..95a05d64d68 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -48,7 +48,7 @@
 	"sig_a:sw,sig_b:sw," \
 	"target_env:sw," \
 	"upgrade_available:dw," \
-	"ustate:dw"
+	"ustate:dw,"
 #endif
 
 /* Default location for tftp and bootm */
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
index 950ec8b190d..cca562a66c9 100644
--- a/include/configs/hmibsc.h
+++ b/include/configs/hmibsc.h
@@ -10,6 +10,6 @@
 
 /* PHY needs a longer aneg time */
 
-#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
+#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw,"
 
 #endif
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index 84da8250684..5662b59343e 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -54,7 +54,7 @@
 	"fitpart:dw," \
 	"mmcpart:dw," \
 	"production:bw," \
-	"ustate:dw"
+	"ustate:dw,"
 
 #else
 /* SD Card boot */
diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
index 5c58c7bbaab..fe3fd5405d7 100644
--- a/include/configs/iot2050.h
+++ b/include/configs/iot2050.h
@@ -43,7 +43,7 @@
 	"board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"	\
 	"mlfb:sw,fw_version:sw,seboot_version:sw,"			\
 	"m2_manual_config:sw,"						\
-	"eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
+	"eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw,"
 #endif
 
 #endif /* __CONFIG_IOT2050_H */
diff --git a/include/configs/socrates.h b/include/configs/socrates.h
index 006d649f6ed..9cd0abd60aa 100644
--- a/include/configs/socrates.h
+++ b/include/configs/socrates.h
@@ -108,7 +108,7 @@
  */
 #define CFG_SYS_BOOTMAPSZ	(8 << 20)	/* Initial Memory map for Linux	*/
 
-#define CFG_ENV_FLAGS_LIST_STATIC "ethaddr:mw,eth1addr:mw,system1_addr:xw,serial#:sw,ethact:sw,ethprime:sw"
+#define CFG_ENV_FLAGS_LIST_STATIC "ethaddr:mw,eth1addr:mw,system1_addr:xw,serial#:sw,ethact:sw,ethprime:sw,"
 
 /* pass open firmware flat tree */
 
diff --git a/include/env_flags.h b/include/env_flags.h
index 123fdbcb0ba..98b50c72227 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -89,7 +89,8 @@ enum env_flags_varaccess {
 	NET_FLAGS \
 	NET6_FLAGS \
 	SERIAL_FLAGS \
-	CFG_ENV_FLAGS_LIST_STATIC
+	CFG_ENV_FLAGS_LIST_STATIC \
+	CONFIG_ENV_FLAGS_LIST_STATIC
 
 #ifdef CONFIG_CMD_ENV_FLAGS
 /*
-- 
2.53.0

