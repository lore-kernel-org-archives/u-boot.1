Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E51FC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857B681F54;
	Wed, 19 Mar 2025 15:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NgM3PaG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C602281E47; Wed, 19 Mar 2025 15:39:12 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6612981E72
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so4511668f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395149; x=1742999949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYn7oVyZQA5wQ78vkGEq8IgsL/gx56egbBLPzthI+2E=;
 b=NgM3PaG9FWRYgFDgXCcxNTw2M8VajIAyjdsXCIwVnwIo+6YkwxAAgRAGMpnJ+5Zh4G
 5ewBeG5sDsWerTTJt9CEhrnLd7QwJY1T2nuN5SgDIi2GN68k2nR4nUCfwvCDJx2Cg21f
 BkfJzP8egKaYme4wc975WwM+vzC9lnARUDwwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395149; x=1742999949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYn7oVyZQA5wQ78vkGEq8IgsL/gx56egbBLPzthI+2E=;
 b=VAKNy0m+YRznQjjM3XMe1FarojXwqgtFo0xGzTahIDfc+goqNtdy13te9u+Pci8Ne0
 6Gcz/xC0nkGY9LPKf26Epn6pf74L7HyoB9uwlKynh/hpAWujWasmObQJJ9C9TokGSlnH
 H1LPmy5tZgsBg7A+/9TQK+a9xpdbcmNNAZdvPddrQkRGQi6V18ENVwiXImy3AFO0F6jw
 Rjq/hZxFc8GtYtKsMJ4yihDDVJkxOGHoT/4Muno+HE78B3OdZUMlS5aye3FjLpHjEY0k
 FI8X2r7JKE8aDhKTOCGQXTnCIvCSm/ZhBmNISzNeDtvC17wBy5ZAPH7mqlfat92skMi2
 8WGQ==
X-Gm-Message-State: AOJu0YwDDlzbaRgLRbRnmzYkPcohUeXz8WyQoe2iQYWKuPnehxGWIXzE
 lnz82cSHyTHIIcqTXS5aQNytgC98rI1jypaHw0y2lYOjcK3MaAjHC5brrOgSND91if6Ph6F3zxk
 =
X-Gm-Gg: ASbGnctjpvS91AzIvAwzYC49I/MVKN3NPeGi+D95KXn0QfdQc54Kl9V+sD+J4mCAJhn
 HOgbejdPtb9Cg004CIniI/QlXBmPh3VSlkadzOOT5nbn7fcNBCflt3YQOLHatWHWz/sM4A+rO3j
 Ammjm68xOUjt0wU91pJZ8/XSakt5/MnRUQbRyCWe3i2QaL617KCI7GiZsOr5cztKRu19p+dbwXR
 qceTGSz/BqiwwnhKRjYzwOkuilsv4KaEnbiu9LG4LS/UDMKh+dCMzLZFKAbwQmGyPyNePot1l4j
 19dXD9cNdi/JbbGUO5uDlroXKwHUCt9xoICkq5mIKg==
X-Google-Smtp-Source: AGHT+IETgFU/oPECoYnpmZXJ6YbDVXcjl0CYbWaCuCg4U3M4yslmwpSZwVcifRyoliMiP3op9ykvvQ==
X-Received: by 2002:a05:6000:4007:b0:391:3261:ff48 with SMTP id
 ffacd0b85a97d-39973af9cb4mr3852502f8f.35.1742395148996; 
 Wed, 19 Mar 2025 07:39:08 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/17] bootstd: Provide a command to select the bootdev order
Date: Wed, 19 Mar 2025 15:38:08 +0100
Message-ID: <20250319143820.2385092-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

It is sometimes useful to select or override the default bootdev order.
Add a command for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c     | 37 +++++++++++++++++++++++++++++++++++++
 boot/bootstd-uclass.c     | 18 ++++++++++++++++++
 cmd/bootdev.c             | 37 +++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/bootdev.rst | 36 ++++++++++++++++++++++++++++++++++++
 include/bootdev.h         | 13 +++++++++++++
 include/bootstd.h         | 10 ++++++++++
 test/boot/bootdev.c       | 37 +++++++++++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index cfb298d5be5..282f1d7b5c5 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -936,6 +936,43 @@ void bootdev_list_hunters(struct bootstd_priv *std)
 	printf("(total hunters: %d)\n", n_ent);
 }
 
+int bootdev_set_order(const char *order_str)
+{
+	struct udevice *bootstd;
+	struct alist order;
+	const char *s, *p;
+	char *label;
+	int i;
+
+	LOGR("bsb", uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+
+	alist_init_struct(&order, char *);
+	log_debug("order_str: %s\n", order_str);
+	if (order_str) {
+		for (i = 0, s = order_str; *s; s = p + (*p == ' '), i++) {
+			p = strchrnul(s, ' ');
+			label = strndup(s, p - s);
+			if (!label || !alist_add(&order, label))
+				goto err;
+		}
+	}
+	label = NULL;
+	if (!order.count)
+		bootstd_set_bootdev_order(bootstd, NULL);
+	else if (!alist_add(&order, label))
+		goto err;
+
+	bootstd_set_bootdev_order(bootstd,
+			  alist_uninit_move(&order, NULL, const char *));
+
+	return 0;
+
+err:
+	alist_uninit(&order);
+
+	return log_msg_ret("bso", -ENOMEM);
+}
+
 static int bootdev_pre_unbind(struct udevice *dev)
 {
 	int ret;
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 9bee73ead58..294865feb64 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -6,6 +6,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
 #include <alist.h>
 #include <blk.h>
 #include <bootdev.h>
@@ -132,6 +134,22 @@ const char *const *const bootstd_get_bootdev_order(struct udevice *dev,
 	return std->bootdev_order;
 }
 
+void bootstd_set_bootdev_order(struct udevice *dev, const char **order_str)
+{
+	struct bootstd_priv *std = dev_get_priv(dev);
+	const char **name;
+
+	free(std->bootdev_order);  /* leak; convert to use alist */
+
+	std->bootdev_order = order_str;
+	log_debug("bootdev_order:");
+	if (order_str) {
+		for (name = order_str; *name; name++)
+			log_debug(" %s", *name);
+	}
+	log_debug("\n");
+}
+
 const char *const *const bootstd_get_prefixes(struct udevice *dev)
 {
 	struct bootstd_priv *std = dev_get_priv(dev);
diff --git a/cmd/bootdev.c b/cmd/bootdev.c
index 4bc229e809a..f05a865f609 100644
--- a/cmd/bootdev.c
+++ b/cmd/bootdev.c
@@ -138,14 +138,51 @@ static int do_bootdev_hunt(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_bootdev_order(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	struct bootstd_priv *priv;
+	int ret = 0;
+
+	ret = bootstd_get_priv(&priv);
+	if (ret)
+		return ret;
+	if (argc == 2) {
+		if (!strncmp(argv[1], "clear", strlen(argv[1]))) {
+			bootdev_set_order(NULL);
+
+			return 0;
+		}
+
+		ret = bootdev_set_order(argv[1]);
+		if (ret) {
+			printf("Failed (err=%dE)\n", ret);
+			return CMD_RET_FAILURE;
+		}
+	} else {
+		const char **order = priv->bootdev_order;
+
+		if (!order) {
+			printf("No ordering\n");
+		} else {
+			while (*order)
+				printf("%s\n", *order++);
+		}
+	}
+
+	return 0;
+}
+
 U_BOOT_LONGHELP(bootdev,
 	"list [-p]         - list all available bootdevs (-p to probe)\n"
 	"bootdev hunt [-l|<spec>]  - use hunt drivers to find bootdevs\n"
+	"bootdev order [clear] | [<spec>,...]  - view or update bootdev order\n"
 	"bootdev select <bd>       - select a bootdev by name | label | seq\n"
 	"bootdev info [-p]         - show information about a bootdev (-p to probe)");
 
 U_BOOT_CMD_WITH_SUBCMDS(bootdev, "Boot devices", bootdev_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_bootdev_list),
 	U_BOOT_SUBCMD_MKENT(hunt, 2, 1, do_bootdev_hunt),
+	U_BOOT_SUBCMD_MKENT(order, 2, 1, do_bootdev_order),
 	U_BOOT_SUBCMD_MKENT(select, 2, 1, do_bootdev_select),
 	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_bootdev_info));
diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
index 98a0f43c580..abede194cba 100644
--- a/doc/usage/cmd/bootdev.rst
+++ b/doc/usage/cmd/bootdev.rst
@@ -13,6 +13,7 @@ Synopsis
 
     bootdev list [-p]        - list all available bootdevs (-p to probe)
     bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
+    bootdev order [clear] | [<spec> ...]  - view or update bootdev order
     bootdev select <bm>      - select a bootdev by name
     bootdev info [-p]        - show information about a bootdev
 
@@ -78,6 +79,27 @@ To run hunters, specify the name of the hunter to run, e.g. "mmc". If no
 name is provided, all hunters are run.
 
 
+bootdev order
+~~~~~~~~~~~~~
+
+This allows the bootdev order to be examined or set. With no argument the
+current ordering is shown, one item per line.
+
+The argument can either be 'clear' or a space-separated list of labels. Each
+label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev sequence
+number ("3") or a media uclass ("mmc") with an optional sequence number (mmc2).
+
+Use `bootdev order clear` to clear any ordering and use the default.
+
+By default, the ordering is defined by the `boot_targets` environment variable
+or, failing that, the bootstd node in the devicetree ("bootdev-order" property).
+If no ordering is provided, then a default one is used.
+
+Note that this command does not check that the ordering is valid. In fact the
+meaning of the ordering depends on what the bootflow iterator discovers when it
+is used. Invalid entries will result in no bootdevs being found for that entry,
+so they are effectively skipped.
+
 bootdev select
 ~~~~~~~~~~~~~~
 
@@ -171,6 +193,20 @@ This shows using one of the available hunters, then listing them::
                 Capacity: 0.0 MB = 0.0 GB (1 x 512)
     =>
 
+This shows viewing and changing the ordering::
+
+    => bootdev order
+    mmc2
+    mmc1
+    => bootdev order 'mmc usb'
+    => bootdev order
+    mmc
+    usb
+    => bootdev order clear
+    => bootdev order
+    No ordering
+    =>
+
 
 Return value
 ------------
diff --git a/include/bootdev.h b/include/bootdev.h
index 9ab95cebc12..038bae10e93 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -433,4 +433,17 @@ int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp);
  */
 int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
 
+/**
+ * bootdev_set_order() - Set the bootdev order
+ *
+ * This selects the ordering to use for bootdevs
+ *
+ * @order_str: NULL-terminated string list containing the ordering. This is a
+ * comma-separate list of bootdev labels, e.g. "mmc usb". If empty then a
+ * default ordering is used
+ * Return: 0 if OK, -ENODEV if an unknown bootmeth is mentioned, -ENOMEM if
+ * out of memory, -ENOENT if there are no bootmeth devices
+ */
+int bootdev_set_order(const char *order_str);
+
 #endif
diff --git a/include/bootstd.h b/include/bootstd.h
index ac3c1922fcc..d673050164c 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -77,6 +77,16 @@ struct bootstd_priv {
 const char *const *const bootstd_get_bootdev_order(struct udevice *dev,
 						   bool *okp);
 
+/**
+ * bootstd_set_bootdev_order() - Set the boot-order list
+ *
+ * @dev: bootstd device
+ * @order_str: list of string pointers, terminated by NULL, e.g.
+ * {"mmc0", "mmc2", NULL}; or NULL to remove boot order. The array and its
+ * members must be allocated by the caller
+ */
+void bootstd_set_bootdev_order(struct udevice *dev, const char **order_str);
+
 /**
  * bootstd_get_prefixes() - Get the filename-prefixes list
  *
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0ace3d0699c..84280caf7b5 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -781,3 +781,40 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootdev_test_next_prio, UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV |
 	     UTF_CONSOLE);
+
+/* Check 'bootdev order' command */
+static int bootdev_test_cmd_order(struct unit_test_state *uts)
+{
+	test_set_skip_delays(true);
+	bootstd_reset_usb();
+
+	ut_assertok(run_command("bootdev order", 0));
+	ut_assert_nextline("mmc2");
+	ut_assert_nextline("mmc1");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootdev order clear", 0));
+	ut_assertok(run_command("bootdev order", 0));
+	ut_assert_nextline("No ordering");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("bootdev order 'invalid mmc'", 0));
+	ut_assertok(run_command("bootdev order", 0));
+	ut_assert_nextline("invalid");
+	ut_assert_nextline("mmc");
+	ut_assert_console_end();
+
+	/* check handling of invalid label */
+	ut_assertok(run_command("bootflow scan -l", 0));
+	if (IS_ENABLED(CONFIG_LOGF_FUNC)) {
+		ut_assert_skip_to_line(
+			"  bootdev_next_label() Unknown uclass 'invalid' in label");
+	} else {
+		ut_assert_skip_to_line("Unknown uclass 'invalid' in label");
+	}
+	ut_assert_skip_to_line("(1 bootflow, 1 valid)");
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootdev_test_cmd_order, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

