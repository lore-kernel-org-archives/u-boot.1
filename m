Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED608C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82EE587B98;
	Thu, 25 Jan 2024 21:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sog5WPBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE7F87447; Thu, 25 Jan 2024 21:17:20 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84BA2876FA
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a33604b00c6so75154466b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706213838; x=1706818638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muAQPZLs0Y1yh5Cz1NYzmD3BKvyKDIPZGfuEeWyICW0=;
 b=Sog5WPBJsOCfcV6WyTNEOefnun3lX9MKxovP/cMZ3c7Rxrx7rCQwS0DR9nj/Nw3aWi
 gB8YdVTD9tm7i4oNEySilhh1C8fLbBzhhPzkPOczVr8/q4cCQTyHbeyf+kIezS0MX/mw
 snlu2fDbPPal/yzwGs+K8TMNz/Wz35Ls3dyw30eDU0gqiDDxLqMCHDkelp76Ud5XBYj1
 +h2dEQRuWTmJurIrMZI251/FaFEBx+wS7j+XzNhbuA4IaVtbBGD8yjAQ11kRO1CNS8eT
 sMcNe0BS5iLkw0v+j+xzk3n+ekiu2wef8EMJ7waV0sgJ+4NVYfPo/r2sfONVSLMZIvtg
 g8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213838; x=1706818638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muAQPZLs0Y1yh5Cz1NYzmD3BKvyKDIPZGfuEeWyICW0=;
 b=TifmFboCxRtygP25nLXEiFYtDdpD8PqMZl2x/UxuH2EBu8oaMhiLqI5JvhKySj+cMK
 hzaIe0XC69IxvFKgNr6rdVSYxFad8BV63DnBOWJAd0yBJYc0SLyssyjnRhevl7AmqKct
 ESPikpucQqd9I892E8vl30tI8hxDvkkEXbgALxIZrZ0l4VWSBM8fCXI1cvYWkGxN6i90
 0Z08mQAkm1hEQa6r63lqMUpfQUYkVIX5wvKrZPQFTPN8z8mejdnTyswVey2jw0Iw5iF1
 8S01QvlOLsi0rvIoU2OVy4R4pov0SPBjX92B6i9i36h4kpjVPylrnBZtWMK3btTn4lcK
 7LIg==
X-Gm-Message-State: AOJu0YzJXqf+KZFgN9Ian4KG2ktHClSm7eRK8fF11HO5nYZjfMyHDkLj
 1v2r0/ZBxp18ytAsO5JwN4GsJao4W03hfbln2j2DW0BD8mF77phl
X-Google-Smtp-Source: AGHT+IFXTDjxY3gJpZLmapL+M0zm08SjNZMerTz+Vp1MTjPRgzcei8ooKoq3timh3JZG7CSV4qqX4Q==
X-Received: by 2002:a17:906:741:b0:a31:8d44:99d1 with SMTP id
 z1-20020a170906074100b00a318d4499d1mr67905ejb.12.1706213837910; 
 Thu, 25 Jan 2024 12:17:17 -0800 (PST)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 tz3-20020a170907c78300b00a3472ae7782sm318738ejc.100.2024.01.25.12.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 12:17:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] boot: pxe_utils: skip fdt setup in case legacy kernel
 is booted
Date: Thu, 25 Jan 2024 22:16:54 +0200
Message-Id: <20240125201654.17685-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240125201654.17685-1-clamor95@gmail.com>
References: <20240125201654.17685-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, if boot with extlinux.conf and do not set the fdt
U-Boot will provide its own device tree. This behavior is
beneficial if the U-Boot device tree is in sync with Linux,
but it totally halts the booting of pre-dtb kernels (3.4 for
example) since it uses ATAGs. To fix this, pass `-` in the
fdt extlinux field as a signal that no tree should be used.

Suggested-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Tested-by: Jethro Bull <jethrob@hotmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 boot/pxe_utils.c       | 27 ++++++++++++++++++++++-----
 doc/develop/distro.rst |  6 ++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 83bc167785..9620562675 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -634,7 +634,12 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		char *fdtfilefree = NULL;
 
 		if (label->fdt) {
-			fdtfile = label->fdt;
+			if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
+				if (strcmp("-", label->fdt))
+					fdtfile = label->fdt;
+			} else {
+				fdtfile = label->fdt;
+			}
 		} else if (label->fdtdir) {
 			char *f1, *f2, *f3, *f4, *slash;
 
@@ -731,14 +736,26 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		zboot_argc = 5;
 	}
 
-	if (!bootm_argv[3])
-		bootm_argv[3] = env_get("fdt_addr");
+	if (!bootm_argv[3]) {
+		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
+			if (strcmp("-", label->fdt))
+				bootm_argv[3] = env_get("fdt_addr");
+		} else {
+			bootm_argv[3] = env_get("fdt_addr");
+		}
+	}
 
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT)
-		bootm_argv[3] = env_get("fdtcontroladdr");
+	if (!bootm_argv[3] && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
+		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
+			if (strcmp("-", label->fdt))
+				bootm_argv[3] = env_get("fdtcontroladdr");
+		} else {
+			bootm_argv[3] = env_get("fdtcontroladdr");
+		}
+	}
 
 	if (bootm_argv[3]) {
 		if (!bootm_argv[2])
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 8016acad09..9e715b23eb 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -81,6 +81,12 @@ as specified at `Boot Loader Specification`_:
 * Does not document the fdtdir option, which automatically selects the DTB to
   pass to the kernel.
 
+* If no fdt/fdtdir is provided, the U-Boot will pass its own currently used
+  device tree.
+
+* If ``-`` is passed as fdt argument and ``CONFIG_SUPPORT_PASSING_ATAGS`` is
+  enabled, then no device tree will be used (legacy booting / pre-dtb kernel).
+
 See also doc/README.pxe under 'pxe file format'.
 
 One example extlinux.conf generated by the Fedora installer is::
-- 
2.40.1

