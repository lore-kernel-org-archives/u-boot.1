Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCE6E8FDC2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 00:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DAE86EB8;
	Wed,  4 Oct 2023 02:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qb9qVZ+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 823C386DD1; Wed,  4 Oct 2023 02:58:52 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ADD086ECB
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 02:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2739c8862d2so349700a91.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 17:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696381128; x=1696985928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RiSIfEN1GKk4Xdzl2+ZdztbYd+jXHq71vO+kRSzltlM=;
 b=Qb9qVZ+piyUu/sVa2O+LUw4SPgskYXs69mVqz6VmLGyz5hkQxMmMT18Rg8bDo22wYr
 VFLuD/doU3GMQF56vzT7/UfQYEmIzzzDYpXQA0WRe0snsznJNUckJjvFLVouQxTrtpQg
 iQaALK2jFHTn18w7K7NFqiaJ3y19eFs7/R4AsT3RfsPFu2kVSW9pG8OF7f2DGspeKmVO
 UAM9JA7YFOHBEPaaaR+xG/dyMwJpd/GX3Iwyt98Eau8ZiDFhgncHU/2fZA1gMDdyPzQ9
 bLNFHjZzQzqLM0poKMEaCkWDOtfVIXLfWZn5JRLUGE5qItPaKw8nKZOgBajJ3FJlKxsY
 NxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696381128; x=1696985928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RiSIfEN1GKk4Xdzl2+ZdztbYd+jXHq71vO+kRSzltlM=;
 b=VM1TKktESxYYTxj0F75yE/CDT55rEs+XzZTlIMqs6//yOwWxs1PCfWtprAM5bh0QPY
 Dc1iKv8FJJVSuNQEaQu1XNo8d23W3oXDC53h2xt+FISRu6/F5RuA4+TzkvNowF3sfnom
 5FLGoZlc4YL2LCkqaEzCdXAytePBKVKYRsKRLb2IsZZIbm6+Szs5VedelIXqz2eHyZEm
 lzRrRBlV4tFPACvkv0Xl/QQ4JMfSs1oEBTQDtLxnigtDfHyGwZ/mXRDkXWClq0v+dG3t
 un+zRUnv9SwxU4fHyXNdZ+26aET37UWVKZLuKpD7lyEHaL5yOEdmZpdzpsfCelGA7/ge
 ayvA==
X-Gm-Message-State: AOJu0YzPQ3ZQRKp6oJiIhxR/kIEp7K7Fs0Ia7ZGQVsOGNbm5POY9CyMJ
 gAhLCSC78eCR9nbHvF5vqRYoLDWXC9I=
X-Google-Smtp-Source: AGHT+IFVdvLKZWSHbRQTmY4scfkAQQLV5a5fBJEe8FlugXuqVInos2smS9zTpYfPr66VLTV8zobPgA==
X-Received: by 2002:a17:90a:3c8f:b0:269:34a6:d4ca with SMTP id
 g15-20020a17090a3c8f00b0026934a6d4camr889604pjc.0.1696381128565; 
 Tue, 03 Oct 2023 17:58:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:548f:fb1f:d9ce:ebf6])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a17090a4a9100b0026b6d0a68c5sm208879pjh.18.2023.10.03.17.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 17:58:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: otavio@ossystems.com.br, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] pico-pi-imx7d: Unselect CONFIG_CONSOLE_MUX
Date: Tue,  3 Oct 2023 21:58:31 -0300
Message-Id: <20231004005831.2193997-1-festevam@gmail.com>
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

Unselect CONFIG_CONSOLE_MUX to fix the following
error for the input, output and error interfaces:

U-Boot 2023.10 (Oct 03 2023 - 21:23:18 -0300)
...
In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0 

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Apply for all pico-imx7 defconfigs.

 configs/pico-dwarf-imx7d_defconfig  | 1 +
 configs/pico-hobbit-imx7d_defconfig | 1 +
 configs/pico-imx7d_bl33_defconfig   | 1 +
 configs/pico-imx7d_defconfig        | 1 +
 configs/pico-nymph-imx7d_defconfig  | 1 +
 configs/pico-pi-imx7d_defconfig     | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/pico-dwarf-imx7d_defconfig b/configs/pico-dwarf-imx7d_defconfig
index 2cd906a63da0..8a99b813daee 100644
--- a/configs/pico-dwarf-imx7d_defconfig
+++ b/configs/pico-dwarf-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx7d-pico-dwarf.dtb"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
diff --git a/configs/pico-hobbit-imx7d_defconfig b/configs/pico-hobbit-imx7d_defconfig
index b63281e53322..9a51a958a686 100644
--- a/configs/pico-hobbit-imx7d_defconfig
+++ b/configs/pico-hobbit-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx7d-pico-hobbit.dtb"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
diff --git a/configs/pico-imx7d_bl33_defconfig b/configs/pico-imx7d_bl33_defconfig
index 546e1e6545d3..b5eedec82757 100644
--- a/configs/pico-imx7d_bl33_defconfig
+++ b/configs/pico-imx7d_bl33_defconfig
@@ -24,6 +24,7 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
diff --git a/configs/pico-imx7d_defconfig b/configs/pico-imx7d_defconfig
index f11e1f4ef413..02af6533e37a 100644
--- a/configs/pico-imx7d_defconfig
+++ b/configs/pico-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="ask"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
diff --git a/configs/pico-nymph-imx7d_defconfig b/configs/pico-nymph-imx7d_defconfig
index 2cd906a63da0..8a99b813daee 100644
--- a/configs/pico-nymph-imx7d_defconfig
+++ b/configs/pico-nymph-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx7d-pico-dwarf.dtb"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 3e26aae40053..5b479818d88e 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx7d-pico-pi.dtb"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-- 
2.34.1

