Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B61C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAA380780;
	Wed, 29 Jan 2025 16:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A39C807E1; Wed, 29 Jan 2025 16:24:39 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADEE80762
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YjmD24wRfz7KW;
 Wed, 29 Jan 2025 16:24:34 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YjmD13h0rzCL5; Wed, 29 Jan 2025 16:24:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 16:24:23 +0100
Subject: [PATCH] rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB to
 simplify Makefile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-tsd-have_vendor_common_lib-v1-1-631525b51458@cherry.de>
X-B4-Tracking: v=1; b=H4sIACZImmcC/x3MQQqAIBAAwK/EnhPMjKivREi5Wy2UhoYE0d+Tj
 nOZByIFpgh98UCgxJG9y6jKAuw2uZUEYzYoqRpZqU5cEcU2JTKJHPpgrD8O78zOs9DKasRW2po
 05OAMtPD958P4vh8BKhw8bAAAAA==
X-Change-ID: 20250129-tsd-have_vendor_common_lib-42c4dd70c3e4
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The build system uses HAVE_VENDOR_COMMON_LIB to automatically include
board/$(VENDOR)/common/Makefile, therefore let's use that to implicitly
include board/theobroma-systems/common/Makefile and compile the common.c
file when building proper.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 board/theobroma-systems/common/Makefile        | 9 +++++++++
 board/theobroma-systems/jaguar_rk3588/Makefile | 3 ---
 board/theobroma-systems/puma_rk3399/Makefile   | 3 ---
 board/theobroma-systems/ringneck_px30/Makefile | 3 ---
 board/theobroma-systems/tiger_rk3588/Makefile  | 3 ---
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/board/theobroma-systems/common/Makefile b/board/theobroma-systems/common/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..c1cadb4b913e8da8bc182f8142b16b2443891343
--- /dev/null
+++ b/board/theobroma-systems/common/Makefile
@@ -0,0 +1,9 @@
+#
+# Copyright (c) 2025 Cherry Embedded Solutions GmbH
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+ifneq ($(CONFIG_XPL_BUILD),y)
+obj-y	+= common.o
+endif
diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile b/board/theobroma-systems/jaguar_rk3588/Makefile
index d43bf194b687cacc556491ecc9041c4da8fd207c..38b73d2846c48f8afad31349d0cf3c593969366e 100644
--- a/board/theobroma-systems/jaguar_rk3588/Makefile
+++ b/board/theobroma-systems/jaguar_rk3588/Makefile
@@ -5,6 +5,3 @@
 #
 
 obj-y += jaguar_rk3588.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/puma_rk3399/Makefile b/board/theobroma-systems/puma_rk3399/Makefile
index 2256e72cda1986ffa9502447a5d7d975eaea504b..d962b56f11123afe4573b64b0d8728fc0a0aa576 100644
--- a/board/theobroma-systems/puma_rk3399/Makefile
+++ b/board/theobroma-systems/puma_rk3399/Makefile
@@ -5,6 +5,3 @@
 #
 
 obj-y	+= puma-rk3399.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/ringneck_px30/Makefile b/board/theobroma-systems/ringneck_px30/Makefile
index 4d108f2d011f07d0fff141158af39a55726348f7..31ada1a69422cdb7bb85bc6c737e2a98187bc62c 100644
--- a/board/theobroma-systems/ringneck_px30/Makefile
+++ b/board/theobroma-systems/ringneck_px30/Makefile
@@ -5,6 +5,3 @@
 #
 
 obj-y	+= ringneck-px30.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile b/board/theobroma-systems/tiger_rk3588/Makefile
index 94b0859eb356c31c3358c453ae46ea8cc64a50c0..900647735fb129fc9252a1cb14ed19d74e8026a0 100644
--- a/board/theobroma-systems/tiger_rk3588/Makefile
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -5,6 +5,3 @@
 #
 
 obj-y += tiger_rk3588.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif

---
base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
change-id: 20250129-tsd-have_vendor_common_lib-42c4dd70c3e4

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

