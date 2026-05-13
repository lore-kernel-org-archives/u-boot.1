Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E4BCD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 00:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D468467C;
	Wed, 13 May 2026 02:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20251104.gappssmtp.com header.i=@wolfssl-com.20251104.gappssmtp.com header.b="qRl7gpg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C4F80F0E; Wed, 13 May 2026 02:26:45 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3838B800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 02:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aidan@wolfssl.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so642318eec.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20251104.gappssmtp.com; s=20251104; t=1778632001; x=1779236801;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5l/T5Jli0T7hzzzlhnDSmOHTDqcaOnZ7GbKMDMahDGs=;
 b=qRl7gpg4ZBA9I42Z56o4ue8j6YmVh6W9WZGsW0zCevE5Hhi4IXTqjOKKFjdNDcFMV9
 AoeduLJEZBdvqFEyDF9qUkDPF/1tPlUMtlsyVOqQ4x9XDJL5MC0o1voahK+V4VKyy1f7
 AA6kcpkXhLr1d8TFzG9sZHeSAkbYZOJg7jinl3yhkTNlaXDDtgQEsz6yObhGQQDuKQ9/
 18KN2hp5queTVKMH9vvKjuW7qeoYcQCJY+H6+p1nLJD6/XkDzuLWWobGNdGicHQSzAJ4
 KHiuI0Qfy/WRmXxLJvtqPsiV6UVR+0ECJ0SzRPDECNEhIAk0EvGf1nar4TQ5pJRuNLGR
 dQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778632001; x=1779236801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5l/T5Jli0T7hzzzlhnDSmOHTDqcaOnZ7GbKMDMahDGs=;
 b=TLPKhSM3Iv55k0bJFi3kBA4jkIInXh6kG/8E9oR6MrfClzd8jpqvb7HH0cyIHzjyzt
 Mjp8t4/9O9S51r1Fb+OCP06FZOC85GWMazMb7bQ93OCajA+jnmLozbueTPOpc2Z1WBv+
 Xzqo8MWBTH1zW3w/NSv8BFJyPNKMh7duzk7opWouMIF3jILkmkAw4PyNrrLxXAKNheqD
 pGijQkqBekwimbF49pXY9F5eZiMuHFDS8i6doDK3sWUh8uDuXPG4X5eUmEqv7xd+hF2x
 TOI63MjjzoNzmpkadCRmHiFouMPB7Lp7J8wdHYsJmgPbZLq1K99zZYHelj6IubO1F5qh
 YS6A==
X-Gm-Message-State: AOJu0YzD0hNq4gOkhE1DofcCqK+pyD/QKKwOloqJGH2LTLoDG2iYvK5h
 pX0254/TRWSrHPkKjRJ5Ej8aV5H5GaYFEGZ6/H0/iJ8rDx/+riC25gbxwFb8W28zorfhK9dIy3e
 gXL2ZQto=
X-Gm-Gg: Acq92OHPlfmQe5dRVYMJcPKR32jpgdrulz7JhwNGe5zjxjUHjJ9wMAH3QYmTaejawce
 V5Oys9+uUlQfZbZhPH30DB7K1Xx43oqsYUxeneAjSjfntG5LTSOKOuvLJgSg73DYBW9hXQcE2jJ
 44FllgrSUaAX9Lx1hsKUR1MK0zvCo6/bnAZundKP9RZ6jyChbpBJAbH/DGVJKKiAbVARxhCB30q
 brWU9m1FfXVDsNoSv3STK6Cc+E8DBLCj+RquNHWSo0tj9Crd+Pv0HS5n4pE5bjrLvsnwLjJ0a8c
 KESwPUg4dbdsYaQNjsP03Yzm3oW8kLu5viNDSVovIE993m4VoOysqVCtrlWW0M4rtuvhtynDy+y
 ATjjUux3RohluWcN2SE0NvNqMXgqcuKzFwYbUfgB763UL31dOu8YZRcd0q2pmaJJ+nlfdtHv583
 mVyLJEACXQ9CjP2o1JR818/mYzPgi6thCuh3vTeib4dOylZHYsshEqEicy7uQV08fh1FU0S9Rj9
 ENgWqSFFMnb28DBvMW9ZE7kycKYMXjt
X-Received: by 2002:a05:7301:2284:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-30117586949mr720910eec.9.1778632001358; 
 Tue, 12 May 2026 17:26:41 -0700 (PDT)
Received: from localhost.localdomain ([207.231.76.218])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884752ccsm19547827eec.17.2026.05.12.17.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 17:26:41 -0700 (PDT)
From: Aidan Garske <aidan@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Aidan <aidan@wolfssl.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Jerome Forissier <jerome@forissier.org>
Subject: [PATCH v4 07/14] tpm: add wolfTPM build rules and Kconfig
Date: Tue, 12 May 2026 17:26:11 -0700
Message-ID: <20260513002625.76915-7-aidan@wolfssl.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
References: <cover.1778619453.git.aidan@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 02:26:53 +0200
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
2.49.0

