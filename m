Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727DCF53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9294841D6;
	Mon, 16 Mar 2026 19:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wolfssl-com.20230601.gappssmtp.com header.i=@wolfssl-com.20230601.gappssmtp.com header.b="T/ga9gCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFF108418A; Mon, 16 Mar 2026 19:15:33 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4410084179
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=wolfssl.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david@wolfssl.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46708149af2so2535869b6e.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wolfssl-com.20230601.gappssmtp.com; s=20230601; t=1773684929; x=1774289729;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuQ1S28478xt2WQ1tdo7rx4UK9rESNerPfZhZaHT350=;
 b=T/ga9gCrI0SBdYysgmLCPB6OuKX0IJN2LkisBOvXFIMp0U0RliDZ/SWGo2MmXbrnER
 iHZzCgw3VRq02dSamtX93NeHE6n9aRLTS71v7wTxURbb3TPTaQq9fQ8S7kpY3Q9YXvX5
 jWGNzn7egRDPKmOCZ9m7qFhV/oUEpOjXOGOyF4zvD8NHi2F6aDBLtdi3KMMaVEqR3wXq
 CMV5goWCzAWECtkBsneFosN95+eIc2GVMeKOAB1hgirm9yqghVZO/tASERQpqGedU4Mb
 jFCJ0nKK5JS8aRJNgfNEvfxH2BY9qk2wyhAGMuicgXtQTFo1Fj3HOVh1NDDxZymmD41s
 S44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684929; x=1774289729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PuQ1S28478xt2WQ1tdo7rx4UK9rESNerPfZhZaHT350=;
 b=IiJdLkK4nCKKRPKaaa7GKtpy2aiVQZ0d/vpw2cD92s6/3x/qg4nDyyo1Y5DSTbus65
 4KkOgz99gfh74yILlqOoAnEgBDjiJ23QxSJY2g36gR1Z2MVk5ca3vdHApoek/V0WRhWi
 AO2zl1dQ2eusbvTtVMFwxB7C16rBS2/HsoZ74LYjvjD2p1T2DBdIfBt2wEtGzDkz+cae
 zEO0415Zi5Kkh1b6G1wo7V1DaKbNk2jNKrVZXa4XXc6HBRwfeamInPKdCDrOTO35Me7b
 qTpNBjq2hqxTkWyw5ViPtPBWAUhqXF0GihSsETXRH4XSMkfeYEhm1BgSZptNSQauW1P9
 s0dA==
X-Gm-Message-State: AOJu0YwlgseU+VPgHf7pmLi3ERUHpJSGkSlqGw5/mnoP1MpN3WMw3jNh
 Naw7lvTh7LlJfyw0fWKYu1ixupznIqEn7W/YBw4vgXdL9Y6TGIM2M1zaXnNS7aGu9WRFOPyq/xY
 n/i5G//4=
X-Gm-Gg: ATEYQzxpCyYz8GTPx7pKjVJIg765KwFOa9f5aSwKHsKz9i+OJ7G0EoaaRDNyKg4fkg0
 zcbQdKAWeemhPxoz53FHfC5whPFupKiDLgeFn65ULhyCZr+rRubpawZ3oWtan94FUMEb43Rbi5+
 ql7Gw4/oUqs87Y1vcMNpBP+zFrGEecgu0rDGlES457Q+HNWcFYqt/CiA3cOZtjvkffZuAXAJKjJ
 Ohwez9TPOlDcyOwATcmQeQlBN4Ix1ZXEu/pOoXqSWNVfjeW8mCKXu8jTW5+xPqfUv45MUv36nia
 bW0DC15wi9HSN5wfH0bP2H0EqBs7H2nHmokERULxuHlzqQE+usjQmnIRWcsyvLSzE4QCnkrkR7x
 823i6foojSxftB9+194mGUtbfEAU5ii+VROv3lJiRjegWF7sPR/9reBHvdnY0j83Ov4YjbYJLKm
 m23upTuXnLbpELagpdYQPe3Q==
X-Received: by 2002:a05:6808:16a6:b0:467:631:8b89 with SMTP id
 5614622812f47-467570a61bemr7899100b6e.23.1773684929331; 
 Mon, 16 Mar 2026 11:15:29 -0700 (PDT)
Received: from localhost ([2605:59c0:2082:bc08:ab40:208e:38fb:2546])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342fb528sm9966906b6e.17.2026.03.16.11.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:15:28 -0700 (PDT)
From: David Garske <david@wolfssl.com>
To: u-boot@lists.denx.de
Cc: Aidan <aidan@wolfssl.com>
Subject: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 05/12] tpm:
 add wolfTPM library as git submodule
Date: Mon, 16 Mar 2026 11:14:34 -0700
Message-ID: <20260316181447.2986278-6-david@wolfssl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316181447.2986278-1-david@wolfssl.com>
References: <20260316181447.2986278-1-david@wolfssl.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:09 +0100
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

Add wolfTPM (https://github.com/wolfSSL/wolfTPM) as a git submodule
at lib/wolftpm. wolfTPM is a portable, open-source TPM 2.0 stack
licensed under GPLv2, providing native API access to all TPM 2.0
commands and a wrapper API for common operations.

The build system additions:

.gitmodules:
  Registers the wolfTPM submodule pointing to the upstream repo.

lib/Kconfig:
  Adds CONFIG_TPM_WOLF option under library routines, which selects
  SHA1 and implies DM_RNG.

lib/Makefile:
  When CONFIG_TPM_WOLF and CONFIG_TPM_V2 are both enabled, compiles
  wolfTPM core source files (tpm2.c, tpm2_packet.c, tpm2_tis.c,
  tpm2_wrap.c, tpm2_param_enc.c) and the HAL layer (tpm_io.c).
  Sets -I include paths and -DWOLFTPM_USER_SETTINGS.

Signed-off-by: Aidan Garske <aidan@wolfssl.com>
---
 .gitmodules  |  3 +++
 lib/Kconfig  | 13 +++++++++++++
 lib/Makefile | 18 ++++++++++++++++++
 lib/wolftpm  |  1 +
 4 files changed, 35 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 lib/wolftpm

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 00000000000..3f95a7c3eb9
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "lib/wolftpm"]
+	path = lib/wolftpm
+	url = https://github.com/wolfssl/wolfTPM.git
diff --git a/lib/Kconfig b/lib/Kconfig
index 931d5206936..24477ea53c9 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -500,6 +500,19 @@ config TPM
 	  If you want a fully functional TPM enable all hashing algorithms.
 	  If you enabled measured boot all hashing algorithms are selected.
 
+config TPM_WOLF
+    bool "Enable wolfTPM support"
+	depends on DM
+	imply DM_RNG
+	select SHA1
+    help
+        This option enables support for wolfTPM in U-Boot. WolfTPM can be
+		used to update ARM specific platforms. Enabling this option allows
+		U-Boot to interact with the TPM using wolfTPM commands such as
+		firmware updates, PCR extend, and more. It is especially useful on
+		platforms that require support for secure boot and other TPM-related
+		functionality.
+
 config SPL_TPM
 	bool "Trusted Platform Module (TPM) Support in SPL"
 	depends on SPL_DM
diff --git a/lib/Makefile b/lib/Makefile
index 70667f3728c..76025cc77d8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-y += list_sort.o
 endif
 
+# U-boot TPM
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
 ifeq ($(CONFIG_$(PHASE_)TPM),y)
 obj-$(CONFIG_TPM) += tpm_api.o
@@ -64,6 +65,23 @@ obj-$(CONFIG_EFI_TCG2_PROTOCOL) += tpm_tcg2.o
 obj-$(CONFIG_MEASURED_BOOT) += tpm_tcg2.o
 endif
 
+# wolfTPM with TPM 2.0 support (including TPM firmware update)
+ifeq ($(CONFIG_TPM_WOLF),y)
+ifeq ($(CONFIG_TPM_V2),y)
+ccflags-y += -I$(srctree)/lib/wolftpm \
+             -I$(srctree)/include/configs \
+             -DWOLFTPM_USER_SETTINGS
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
diff --git a/lib/wolftpm b/lib/wolftpm
new file mode 160000
index 00000000000..664db130d57
--- /dev/null
+++ b/lib/wolftpm
@@ -0,0 +1 @@
+Subproject commit 664db130d57bfa18a3254a0ddc126da1beeb9895
-- 
2.43.0

