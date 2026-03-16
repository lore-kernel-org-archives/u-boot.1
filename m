Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F9F30295
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 01:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B452844AE;
	Mon, 16 Mar 2026 02:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="psYNPe8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFEF844AF; Mon, 16 Mar 2026 02:25:17 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BBB84496
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 02:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d75d698ee6so2300893a34.3
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773624314; x=1774229114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3F1rm9h+hEWQP/2GKOOR4Y9rYi07heuEixTYQdnNNUg=;
 b=psYNPe8K14UwZSbyahEU91CBheBeLLWRM1nsMaMGLq70EqoCzXeKSAzW9dzUlvBfSm
 ZbACFEG6fyhKHURh+KzYPwVRwnvzGhkcqmEGspHEpdkPA43ue5nABD2Tt4afEIRe9ZXu
 vKNWgozxYdxyRCy4N7oQcV6zLBWfx1KssFEhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773624314; x=1774229114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3F1rm9h+hEWQP/2GKOOR4Y9rYi07heuEixTYQdnNNUg=;
 b=gqkfSP0nSX01qhumL0yFaOkwJdFoQAizJn1x64fBhTXJ9PYi7UAcysxV60GIlDxgyB
 odfNmyOFPH+Anal7yKU2PwASNf24Ru1aw0v1YzeD6aslFl3CnX1snG+RhZDtPCm0Kh8o
 Wv9hgB59JU+FKI9OrV53d85urnIHOoVw4l7FcuX5q3GtUTGPh1RI+WaGZaFwPZtb+to9
 IYVbGFr29dxC18xQUc3PQBqTB15AchZSys7aOYtaRLra/c705TxMHAAx38IsUR2dWAjd
 skyIIjQhEGd9Zeehz+tAKPtGvrp6RY04OYF4ha9Zva6jcZKmUlv6P95G9ir6p/GFXJoQ
 WkuQ==
X-Gm-Message-State: AOJu0YzmTO2u7+fXdBmEfC12u2Ub1+In68cSP/cbuuM9Fy2eHAyT9Bfl
 nb3r5jzK3CvFjtJhLU8Gb40hg0n3irpzB4xai37qkM2X7cxEW9HUV1GfGAxEfhgk+IjVwuol/X8
 4uyBYSIc=
X-Gm-Gg: ATEYQzzAKqClGglPCUL2Q90+IXj4fe3FmXM3awzIElvhlyta0cj2btP1vNLnL+UHpH1
 puv1CNC2Dot1ikp8ylXgCu0Im4MM5UXu9tKIRTlxtmb9WOAgUGj4ydq6hi79wggaXZSdS51pz2X
 FYBC7qZ+1AYrCZuUxiaSFsB9Quq13iPzAmGHXXgbCDZ4CeKuYe7dZkxKDZhtdZNJKR/4G1RABCu
 PZg70kxotdNQwP0mu0e/ZEQELUeMDtrTRFedeYmRO2o5MhSfhJLrEUMIGdU/HLYvyKm06qSK1xo
 RFpf+GHEEz7oYq7YeDuqK6C8KqPog2Q+6Q9xU+Q7oUu8nyUwYqeMF38iEBv4iFNCsOv2CRRJ28x
 k8SvdSoXkz6OAYv1CrliJRBWfJ/r+IL1p9puzY60SHLs6QonPTcUh0kI+gJOl6r5cdVLkzY6WAZ
 bTpRi+mrTH+UwBtC6o8DgJUdYbSculUb/RJGVlwCTYRalWtoDdKiHqjaU7AHRI6eLAbG8WZRMNi
 NjHMzqHpZG6dbCvZF+PlMqMGonjEL5TdDemp6pq0oV44WTVzCE=
X-Received: by 2002:a05:6830:3805:b0:7cf:db31:1b7d with SMTP id
 46e09a7af769-7d782449a47mr8269991a34.5.1773624313651; 
 Sun, 15 Mar 2026 18:25:13 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm11307659a34.20.2026.03.15.18.25.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 18:25:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2] FIT: Image pre-load signature support must select not
 depends on FIT_SIGNATURE
Date: Sun, 15 Mar 2026 19:25:11 -0600
Message-ID: <20260316012511.1898638-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310162618.1163914-1-trini@konsulko.com>
References: <20260310162618.1163914-1-trini@konsulko.com>
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

The options to enable pre-load signature support (full U-Boot or in SPL)
must depend on FIT_SIGNATURE being enabled, and not select it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Update tools-only_defconfig to enable CONFIG_FIT_SIGNATURE
---
 boot/Kconfig                 | 4 ++--
 configs/tools-only_defconfig | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 4e9bc9491a06..d81e56e8528c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1809,7 +1809,7 @@ config SPL_IMAGE_PRE_LOAD
 config IMAGE_PRE_LOAD_SIG
 	bool "Image pre-load signature support"
 	depends on IMAGE_PRE_LOAD
-	select FIT_SIGNATURE
+	depends on FIT_SIGNATURE
 	select RSA
 	select RSA_VERIFY_WITH_PKEY
 	help
@@ -1826,7 +1826,7 @@ config IMAGE_PRE_LOAD_SIG
 config SPL_IMAGE_PRE_LOAD_SIG
 	bool "Image pre-load signature support within SPL"
 	depends on SPL_IMAGE_PRE_LOAD && IMAGE_PRE_LOAD_SIG
-	select SPL_FIT_SIGNATURE
+	depends on SPL_FIT_SIGNATURE
 	select SPL_RSA
 	select SPL_RSA_VERIFY_WITH_PKEY
 	help
diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 42ec59575100..3b7eea55f77b 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -9,6 +9,7 @@ CONFIG_EFI_LOADER=n
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=n
 CONFIG_BOOTMETH_CROS=n
 CONFIG_BOOTMETH_VBE=n
-- 
2.43.0

