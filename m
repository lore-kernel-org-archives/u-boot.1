Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4F9C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF8783990;
	Wed, 28 May 2025 10:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="brkitcW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E46083A07; Wed, 28 May 2025 10:26:37 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D43839B9
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-7c5e39d1e0eso436509885a.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420793; x=1749025593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3NCR4HHEogUuLn08kTDgozEL9ydRgj8JXh2CZ5oJOY=;
 b=brkitcW0P1sspXL9chY8OrFKqzh4H0PYn62rk2oKso3XKqpMVHgHyB1YVOCFgbVa5w
 /d04E0Q3IwueB9UMbiSbACgl+S2oO7EGKSLiIiHWs3nNpF4d6YVIci9F7lWpPCVMYNAz
 yRBX0u9pycAkbpKzitSlTCq9ZYm5tY0BKSa58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420793; x=1749025593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3NCR4HHEogUuLn08kTDgozEL9ydRgj8JXh2CZ5oJOY=;
 b=rNhkFe0Qg8IgDM+QFE6BR9u9oNjo81Sy47qsm8+Favln1xl2eJrFJZZJpeDsw9/uvm
 tkjiuxXjrqshXc9Azsh5Z+S20HaeHpuobR4T2q9fdjLaRIdMOhEvJIBQIdExOzjQJh9w
 JxusURvsBrrB61yxHhV5PbrXKn88atBkUa1zMW8JrPI8+un45uxNs2q783iAwZpZSIik
 u+Ng7OmdGfipqxi0AF6SjBAVipc6tCoHk9dlM2zip7ZsZBZAeyHsKwSz9ykL6z8WyKiI
 1IBHBAPbElH6RgnMgHTUd3H9YdfirZgGxk48CXbEjJShrpEppdfoeVK3guH2ZRnT1kKG
 J8hw==
X-Gm-Message-State: AOJu0YwJSja5vk449NVepHUv6hoGgoJ1AvnDBcUpW6PvLrRi/p5QD0ww
 pWmiq+VkYHBmW4vonHWRghGWxSLaSLF5olJ6Z8LgX8s2veoH2jjXh52Gv5GsJgHzCogfKCLx11T
 i5QNd28LPZeE=
X-Gm-Gg: ASbGncvaxSPxYGMR2exc+zg70DSPCw03BbVipeaANd5hFwEu7GJhX5p15H3yOK/5zQA
 TAJx7q6VrcUQfGlYyspIBkcAVyqPLzk5POdkHpYmWM0Ceme09wdn9aQABtSHBcv5ljivN6MscBV
 L89Q2zKSxEVbnJv9Wm+WDl5N/lQacxgKit8rUUorGwbucCqwPInnjFwIT0Qp1FfD2Z2ecw1f9sC
 JqhiQDsUOQ6TmB+S7xipyYPPPz0UR7nqgKTTUTBRWG4jDeoCH6go1qVRlzhXu6rfjePhK6hcyzN
 dD76J1qgU9ysDaaYn3ulHTEMNSlpDT3QxjymEafnYr2GvEtfznQDAK/X2CfPYY2WHGjoNkkeFOR
 1SqEcdmkgDSs8gMXYPwFg9o4=
X-Google-Smtp-Source: AGHT+IEuQ1B3NVhSc3bPw6wZzi0JRGI2vdKSYfqyRRExUcvaJzNcWvBjN/ePB14Do+3t8vuiGH3siA==
X-Received: by 2002:a05:6e02:1606:b0:3cf:c9ad:46a1 with SMTP id
 e9e14a558f8ab-3dc9b6d148amr130725805ab.13.1748420782191; 
 Wed, 28 May 2025 01:26:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/27] efi: Provide an easy way to debug with gdb
Date: Wed, 28 May 2025 02:24:44 -0600
Message-ID: <20250528082520.152391-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Add a Kconfig option to easily enable debugging of the app using the
recommended method. Provide some docs too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/u-boot_on_efi.rst | 39 ++++++++++++++++++++++++++++++
 lib/efi_client/Kconfig             | 12 ++++++++-
 lib/efi_client/efi.c               | 36 +++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index f1f9113b01f..d20d5b00ec6 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -338,6 +338,45 @@ Additionally something like (sda is assumed as disk device):
 	append  root=/dev/sda2 console=tty0 console=ttyS0,115200n8 rootwait rw
 
 
+Debugging
+---------
+
+Debugging the app is not straightforward since it is relocated by the UEFI
+firmware before it is run.
+
+See
+`Debugging UEFI applications with GDB <https://wiki.osdev.org/Debugging_UEFI_applications_with_GDB>`_
+for details.
+
+Within U-Boot, enable `CONFIG_EFI_APP_DEBUG` which will cause U-Boot to write
+deadbeef to address `10000` which you can catch with gdb.
+
+In gdb the procedure is something like this, for a 64-bit machine::
+
+  # Enable CONFIG_EFI_APP_DEBUG in the build
+  $ grep CONFIG_EFI_APP_DEBUG .config
+  CONFIG_EFI_APP_DEBUG=y
+
+  $ gdb u-boot
+  # Connect to the target; here we assume 'qemu -Ss' has been started
+  (gdb) target remote localhost:1234
+
+  # Set a watchpoint for the marker write
+  (gdb) watch *(unsigned long *)0x10000 == 0xdeadbeef
+  (gdb) continue
+
+  # Execution will break as soon as the marker is written.
+  # Now, fetch the relocated base address:
+  (gdb) set $base = *(unsigned long long *)0x10008
+  (gdb) add-symbol-file u-boot -o $base
+
+  # Now you can set other breakpoints as needed
+
+For a 32-bit machine, use `unsigned long` for the cast when setting `$base`
+
+The address of 0x10000 is defined by `GDB_ADDR` which you can change in the
+code if needed.
+
 
 Future work
 -----------
diff --git a/lib/efi_client/Kconfig b/lib/efi_client/Kconfig
index fec5b7e004c..7ac6497ec09 100644
--- a/lib/efi_client/Kconfig
+++ b/lib/efi_client/Kconfig
@@ -70,9 +70,10 @@ config EFI_STUB_64BIT
 
 endchoice
 
+if EFI_APP
+
 config EFI_RAM_SIZE
 	hex "Amount of EFI RAM for U-Boot"
-	depends on EFI_APP
 	default 0x10000000
 	help
 	  Set the amount of EFI RAM which is claimed by U-Boot for its own
@@ -80,4 +81,13 @@ config EFI_RAM_SIZE
 	  other smaller amounts) and it can never be increased after that.
 	  It is used as the RAM size in with U-Boot.
 
+config EFI_APP_DEBUG
+	bool "Enable GDB debugging"
+	help
+	  Enable this to allow GDB to stop the app at an early stage, so it is
+	  possible to set the symbol offset. Since the app is relocated to an
+	  unknown address, breakpoints will only work if this is done.
+
+endif  # EFI_APP
+
 endmenu
diff --git a/lib/efi_client/efi.c b/lib/efi_client/efi.c
index bb1d9e24f84..8b825c7a66e 100644
--- a/lib/efi_client/efi.c
+++ b/lib/efi_client/efi.c
@@ -18,6 +18,31 @@
 #include <efi.h>
 #include <efi_api.h>
 
+enum {
+	/* magic number to trigger gdb breakpoint */
+	GDB_MAGIC	= 0xdeadbeef,
+
+	/* breakpoint address */
+	GDB_ADDR	= 0x10000,
+};
+
+/**
+ * struct gdb_marker - structure to simplify debugging with gdb
+ *
+ * This struct is placed in memory and accessed to trigger a breakpoint in
+ * gdb.
+ *
+ * @magic: Magic number (GDB_MAGIC)
+ * @base: Base address of the app
+ */
+struct gdb_marker {
+	union {
+		u32 magic;
+		u64 space;
+	};
+	void *base;
+};
+
 static struct efi_priv *global_priv;
 
 struct efi_priv *efi_get_priv(void)
@@ -116,6 +141,17 @@ int efi_init(struct efi_priv *priv, const char *banner, efi_handle_t image,
 	priv->loaded_image = loaded_image;
 	priv->image_data_type = loaded_image->image_data_type;
 
+	if (IS_ENABLED(CONFIG_EFI_APP_DEBUG)) {
+		struct gdb_marker *marker = (struct gdb_marker *)GDB_ADDR;
+		char buf[64];
+
+		marker->base = priv->loaded_image->image_base;
+		snprintf(buf, sizeof(buf), "\ngdb marker at %p base %p\n",
+			 marker, marker->base);
+		efi_puts(priv, buf);
+		marker->magic = 0xdeadbeef;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

