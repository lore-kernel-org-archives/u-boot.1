Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D66CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601A384E21;
	Sat,  9 May 2026 02:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="iC9DUXPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C7884E0B; Sat,  9 May 2026 02:04:46 +0200 (CEST)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6C784E0A
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 02:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-12c8c9c4cd8so2159753c88.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778285082; x=1778889882;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktXImSmp24jPe3o0Ul/H4vgOE24na+wCFd6yUC51Ax4=;
 b=iC9DUXPgRAWLNxNet5Uk5KcFxvdgUuBM/tiTXUabxEc98KcA1Sb7FD8pWWixPn23ZL
 k/XMHCjoWxJigSBlkdH2dE114+HnzIGZomKfzV3i0JVJ3qeallEfZfZZLKDIr28BdFY0
 wumfZIb2gaJ4/JrT3CYLlIs85SoMQkx9OZoe0yZgFpleUrp25oy5NGYzlFK89mpRx58c
 K6szSqBtDmUzD0Q2lCt8Azu5mBquB207octAlNQAs/+dGpQAQ5EwtzlRnTl9jRBgbp+N
 x+aGCwmv2GrLCVGLj8FkEVKpdGGKEalPaj8+WsjLGSu5bqDqjqfldpztdWOPVRwR5o+Y
 TqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778285082; x=1778889882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ktXImSmp24jPe3o0Ul/H4vgOE24na+wCFd6yUC51Ax4=;
 b=rvjNlHAumUV1T9qPTiEET4m44HsnsWWlRrytBIrktwMmX6QYzRyaE37SdxpaNljLoa
 a/3PeMhTvRHa3oMzGcK8MQRqD+idorbeUNOf+9MnfcShs/66MGZKsVbDowfVenb1x9BU
 DAv9Pfv+IcxoVqDeCy6XW2FOKzc6cUhW76eLRupBPdptYX61BX/VYlauS3TY2dSiusah
 17di9MQv3TvE8V3LOEIabtAb6vOqxyFzFQtuYOYKgAngrf9sajdtqsiyZSRSjvGC3L1c
 18/kwk5YHE3MQ9lqIbSm1osZx/PH/Kt33gVckphh9xrFV3H6oLMOyRiK/Yx5o5fqVHRD
 9/IA==
X-Gm-Message-State: AOJu0YyU/kOkpz6Vm6LXC46iQLSan3tuTGcVZvBUb+KYC6tNLpR9xgc/
 MjjD2Hlsogr3D0w+7iBkbnn2eT0klNC7h3d9yNZrzCNZqmrSK3Xr+Wv6miBbWev35iTgiBTgpmd
 cIV9S
X-Gm-Gg: AeBDiesyRYfdyDHXCWLuezL4iOk1L1s3P5urv7nLp4La8407gfirm2KXOWpZns5mutp
 O7m+6Oxo7yoHiSptdCL+iwtKLHPhEH70Y++rNve0oHnsQyv+Rpjy9xDK0LpK+Rr5Y/YTCp3SoUK
 TFnlVvy+EW/6LgSMudPBOXkgJfVBfPLC2yDEVCS9N9SD1ukr9wTQzmJ19iQuL6Re0xB4dQHYrmi
 T41fwCOYGBdkYUOPAtkdoDT/IW9OH2VKSI/3zK7T7XZcq/7R6uWMKU5Kn9BCJ+SEO721/aD4v2h
 CAeVRibU+qutn5Jk0cCvLweJkJMNogQMbIE1Hzx3DMe9iWfzh3uHmc3+wtqp4hKtidOVVb+/9+2
 xoRtFraJZ0EavgZSJ3hap0Q5LrsYM8n0tEZQXQx752PJRnWxhNkM6qfCoOyFHGGGMnRMHQa+huu
 PjHG2FUJtW6vf54vnEb4C7b1q51z3a6DJVR8bmqL9gl+EAEtEqbGwntr2cA4nymLG8UpCTIUkpl
 z95+L204qH0gVitSwo0Ww==
X-Received: by 2002:a05:7022:4588:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-1323ae990d7mr4252670c88.11.1778285082034; 
 Fri, 08 May 2026 17:04:42 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132787673ffsm5505030c88.15.2026.05.08.17.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:04:41 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: David Garske <david@wolfssl.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 05/12] tpm: add wolfTPM build rules and Kconfig
Date: Fri,  8 May 2026 17:04:12 -0700
Message-ID: <40dab2a66e32cda7db755402a27403307709f9a7.1778277334.git.aidan@wolfssl.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778277334.git.aidan@wolfssl.com>
References: <cover.1778277334.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:11 +0200
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

From: Aidan <aidan@wolfssl.com>

Hook the wolfTPM source tree (imported as a subtree at lib/wolftpm/ in
the preceding commits) into the U-Boot build and add upstream-pull
support to tools/update-subtree.sh, matching how mbedtls, dts, and lwip
are maintained.

lib/Kconfig:
  Adds CONFIG_TPM_WOLF under library routines, depending on DM,
  implying DM_RNG, and selecting SHA1.

lib/Makefile:
  When CONFIG_TPM_WOLF and CONFIG_TPM_V2 are both enabled, compiles
  wolfTPM core source files (tpm2.c, tpm2_packet.c, tpm2_tis.c,
  tpm2_wrap.c, tpm2_param_enc.c) and the HAL layer (tpm_io.c).
  Sets -I include paths and -DWOLFTPM_USER_SETTINGS so wolfTPM picks
  up include/configs/user_settings.h.

tools/update-subtree.sh:
  Registers the wolftpm subtree (path lib/wolftpm, upstream
  https://github.com/wolfssl/wolfTPM.git) so the existing pull/pick
  workflow can be used for future wolfTPM updates.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 lib/Kconfig             | 13 +++++++++++++
 lib/Makefile            | 17 +++++++++++++++++
 tools/update-subtree.sh |  7 ++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 931d5206936..b7dc422e94c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -500,6 +500,19 @@ config TPM
 	  If you want a fully functional TPM enable all hashing algorithms.
 	  If you enabled measured boot all hashing algorithms are selected.
 
+config TPM_WOLF
+	bool "Enable wolfTPM support"
+	depends on DM
+	imply DM_RNG
+	select SHA1
+	help
+	  This option enables support for wolfTPM in U-Boot. wolfTPM is a
+	  portable, open-source TPM 2.0 stack licensed under GPLv2. Enabling
+	  this option allows U-Boot to interact with the TPM via wolfTPM,
+	  including firmware updates, PCR extend, and other TPM 2.0
+	  operations. The wolfTPM source tree lives under lib/wolftpm/ as
+	  a subtree (see tools/update-subtree.sh).
+
 config SPL_TPM
 	bool "Trusted Platform Module (TPM) Support in SPL"
 	depends on SPL_DM
diff --git a/lib/Makefile b/lib/Makefile
index 70667f3728c..0753e33d69e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,23 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
 obj-$(CONFIG_MEASURED_BOOT) += tpm_tcg2.o
 endif
 
+# wolfTPM (TPM 2.0 stack, including firmware update support)
+ifeq ($(CONFIG_TPM_WOLF),y)
+ifeq ($(CONFIG_TPM_V2),y)
+ccflags-y += -I$(srctree)/lib/wolftpm \
+	     -I$(srctree)/include/configs \
+	     -DWOLFTPM_USER_SETTINGS
+obj-y += wolftpm/hal/tpm_io.o
+obj-$(CONFIG_WOLFTPM_LINUX_DEV) += wolftpm/src/tpm2_linux.o
+obj-y += wolftpm/src/tpm2.o
+obj-y += wolftpm/src/tpm2_packet.o
+obj-y += wolftpm/src/tpm2_tis.o
+obj-y += wolftpm/src/tpm2_wrap.o
+obj-y += wolftpm/src/tpm2_param_enc.o
+obj-y += wolftpm.o
+endif
+endif
+
 obj-$(CONFIG_$(PHASE_)CRC8) += crc8.o
 obj-$(CONFIG_$(PHASE_)CRC16) += crc16.o
 obj-$(CONFIG_$(PHASE_)CRC16) += crc16-ccitt.o
diff --git a/tools/update-subtree.sh b/tools/update-subtree.sh
index 536b3318573..c5963e6a3ae 100755
--- a/tools/update-subtree.sh
+++ b/tools/update-subtree.sh
@@ -17,7 +17,7 @@ set -e
 print_usage() {
     echo "usage: $0 <op> <subtree-name> <ref>"
     echo "  <op>           pull or pick"
-    echo "  <subtree-name> mbedtls or dts or lwip"
+    echo "  <subtree-name> mbedtls or dts or lwip or wolftpm"
     echo "  <ref>          release tag [pull] or commit id [pick]"
 }
 
@@ -47,6 +47,11 @@ set_params() {
             repo_url=https://git.savannah.gnu.org/git/lwip.git
             remote_name="lwip_upstream"
             ;;
+        wolftpm)
+            path=lib/wolftpm
+            repo_url=https://github.com/wolfssl/wolfTPM.git
+            remote_name="wolftpm_upstream"
+            ;;
         *)
             echo "Invalid subtree name: $subtree_name"
             print_usage
-- 
2.47.3

