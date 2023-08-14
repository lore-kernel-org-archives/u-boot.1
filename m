Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885ECC04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F66B869F5;
	Tue, 15 Aug 2023 00:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QydjPJp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A977286A02; Tue, 15 Aug 2023 00:41:34 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFC1869EF
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3490cce32c4so23762245ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052891; x=1692657691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1nU3vbCRujW5Je7yPN+hXfkuOt24PI0w1jGVf0ePPM=;
 b=QydjPJp0p32Ck6rT9AiUiEe5ygcSCXXEdwZfBPjZGPWrghXzUVxmU067oClxvnZc8z
 iUIY89gz6Mr55R26k9irdMsclQYqPlxnQHY27VJflg/w1eEliuREK4nROb+EoscpVACq
 ygIh9YVFcZMiwmmgpzP49JK2oJ19VtwbrBkvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052891; x=1692657691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1nU3vbCRujW5Je7yPN+hXfkuOt24PI0w1jGVf0ePPM=;
 b=Ey6nSETJ6tOt6UXAbbSklsY/1Y6w+fnijSze9tMuqxzKzGC6fRzasYik05aXdihiJT
 8LL85mIh6lwydbbG62HlWtk5jLpKLlKrzhHXVgSI9mHXRJRn7bQhXfmq5NuNxCvPh4y8
 WDFavIa/Qs1ohn5m7z+82PHEy5/oXq+nTLxV02E+jwZ5FuqtAPtpZptdan2QbXj9Vtfj
 mX5BBF0fBIuzD8yM0e8R2valdAjiDdxaG7ppWaPfJNHY2yr9WnHXLkBbS93/scdqxpT7
 5tr5ittqErmSXo+eqXuRXude7i4v2jAXp+dJGcDL2pvnyooUvhSZ9zijo5Slu4ZYk/s3
 DWTQ==
X-Gm-Message-State: AOJu0YxWoRWgUE3i8LEPpNK8hKgsHedPIKRaZpK1xaiBLR6SVlXoIPF3
 7S4B7JtCSxi9snYxTsgUmMPVdcYyut14iAiKMqw=
X-Google-Smtp-Source: AGHT+IHu22aG+UAPVHKcRN/KnOvEKyf13bK0UV62bMv38kl71l94zm8lOlhpJL4Q/9baQhvqZKa7Lg==
X-Received: by 2002:a05:6e02:1ca1:b0:349:796b:2299 with SMTP id
 x1-20020a056e021ca100b00349796b2299mr17019575ill.6.1692052891048; 
 Mon, 14 Aug 2023 15:41:31 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 18/19] expo: cedit: Support reading settings from CMOS RAM
Date: Mon, 14 Aug 2023 16:40:38 -0600
Message-ID: <20230814224047.535491-19-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Add a command to read edit settings from CMOS RAM, using the cedit
definition to indicate which registers and bits are used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c            | 99 +++++++++++++++++++++++++++++++++++++++++
 boot/scene_internal.h   | 12 +++++
 boot/scene_menu.c       | 16 +++++++
 cmd/cedit.c             | 36 +++++++++++++++
 doc/usage/cmd/cedit.rst |  9 +++-
 include/cedit.h         | 12 +++++
 test/boot/cedit.c       | 11 +++++
 7 files changed, 194 insertions(+), 1 deletion(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 725745aba55d..73645f70b6cb 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -39,6 +39,7 @@ enum {
  * @mask: Mask bits for the CMOS RAM. If a bit is set the byte containing it
  * will be written
  * @value: Value bits for CMOS RAM. This is the actual value written
+ * @dev: RTC device to write to
  */
 struct cedit_iter_priv {
 	struct abuf *buf;
@@ -46,6 +47,7 @@ struct cedit_iter_priv {
 	bool verbose;
 	u8 *mask;
 	u8 *value;
+	struct udevice *dev;
 };
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
@@ -619,3 +621,100 @@ done:
 	free(priv.value);
 	return ret;
 }
+
+static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
+{
+	struct cedit_iter_priv *priv = vpriv;
+	const struct scene_menitem *mi;
+	struct scene_obj_menu *menu;
+	int val, ret;
+	uint i;
+
+	if (obj->type != SCENEOBJT_MENU)
+		return 0;
+
+	menu = (struct scene_obj_menu *)obj;
+
+	/* figure out where to place this item */
+	if (!obj->bit_length)
+		return log_msg_ret("len", -EINVAL);
+	if (obj->start_bit + obj->bit_length > CMOS_MAX_BITS)
+		return log_msg_ret("bit", -E2BIG);
+
+	val = 0;
+	for (i = 0; i < obj->bit_length; i++) {
+		uint bitnum = obj->start_bit + i;
+		uint offset = CMOS_BYTE(bitnum);
+
+		/* read the byte if not already read */
+		if (!priv->mask[offset]) {
+			ret = rtc_read8(priv->dev, offset);
+			if (ret < 0)
+				return  log_msg_ret("rea", ret);
+			priv->value[offset] = ret;
+
+			/* mark it as read */
+			priv->mask[offset] = 0xff;
+		}
+
+		if (priv->value[offset] & BIT(CMOS_BIT(bitnum)))
+			val |= BIT(i);
+		log_debug("bit %x %x\n", bitnum, val);
+	}
+
+	/* update the current item */
+	mi = scene_menuitem_find_seq(menu, val);
+	if (!mi)
+		return log_msg_ret("seq", -ENOENT);
+
+	menu->cur_item_id = mi->id;
+	log_debug("Update menu %d cur_item_id %d\n", menu->obj.id, mi->id);
+
+	return 0;
+}
+
+int cedit_read_settings_cmos(struct expo *exp, struct udevice *dev,
+			     bool verbose)
+{
+	struct cedit_iter_priv priv;
+	int ret, i, count, first, last;
+
+	/* read in the items */
+	priv.mask = calloc(1, CMOS_MAX_BYTES);
+	if (!priv.mask)
+		return log_msg_ret("mas", -ENOMEM);
+	priv.value = calloc(1, CMOS_MAX_BYTES);
+	if (!priv.value) {
+		free(priv.mask);
+		return log_msg_ret("val", -ENOMEM);
+	}
+	priv.dev = dev;
+
+	ret = expo_iter_scene_objs(exp, h_read_settings_cmos, &priv);
+	if (ret) {
+		log_debug("Failed to read CMOS (err=%d)\n", ret);
+		ret = log_msg_ret("set", ret);
+		goto done;
+	}
+
+	/* read the data to the RTC */
+	first = CMOS_MAX_BYTES;
+	last = -1;
+	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
+		if (priv.mask[i]) {
+			log_debug("Read byte %x: %x\n", i, priv.value[i]);
+			count++;
+			first = min(first, i);
+			last = max(last, i);
+		}
+	}
+	if (verbose) {
+		printf("Read %d bytes from offset %x to %x\n", count, first,
+		       last);
+	}
+
+done:
+	free(priv.mask);
+	free(priv.value);
+	return ret;
+}
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 23e29cb349b0..695a907dc6af 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -234,4 +234,16 @@ int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
 struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
 					  int id);
 
+/**
+ * scene_menuitem_find_seq() - Find the menu item at a sequential position
+ *
+ * This numbers the items from 0 and returns the seq'th one
+ *
+ * @menu: Menu to check
+ * @seq: Sequence number to look for
+ * Return: menu item if found, else NULL
+ */
+struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
+					      uint seq);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 602fe24580af..e0dcd0a4e041 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -46,6 +46,22 @@ struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
 	return NULL;
 }
 
+struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
+					      uint seq)
+{
+	struct scene_menitem *item;
+	uint i;
+
+	i = 0;
+	list_for_each_entry(item, &menu->item_head, sibling) {
+		if (i == seq)
+			return item;
+		i++;
+	}
+
+	return NULL;
+}
+
 /**
  * update_pointers() - Update the pointer object and handle highlights
  *
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 95d5c22c2f75..2ff284f4cde6 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -210,6 +210,40 @@ static int do_cedit_write_cmos(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_cedit_read_cmos(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	struct udevice *dev;
+	bool verbose = false;
+	int ret;
+
+	if (check_cur_expo())
+		return CMD_RET_FAILURE;
+
+	if (argc > 1 && !strcmp(argv[1], "-v")) {
+		verbose = true;
+		argc--;
+		argv++;
+	}
+
+	if (argc > 1)
+		ret = uclass_get_device_by_name(UCLASS_RTC, argv[1], &dev);
+	else
+		ret = uclass_first_device_err(UCLASS_RTC, &dev);
+	if (ret) {
+		printf("Failed to get RTC device: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = cedit_read_settings_cmos(cur_exp, dev, verbose);
+	if (ret) {
+		printf("Failed to read settings from CMOS: %dE\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
@@ -243,6 +277,7 @@ static char cedit_help_text[] =
 	"cedit write_fdt <i/f> <dev[:part]> <filename>    - write settings\n"
 	"cedit read_env [-v]                              - read settings from env vars\n"
 	"cedit write_env [-v]                             - write settings to env vars\n"
+	"cedit read_cmos [-v] [dev]                       - read settings from CMOS RAM\n"
 	"cedit write_cmos [-v] [dev]                      - write settings to CMOS RAM\n"
 	"cedit run                                        - run config editor";
 #endif /* CONFIG_SYS_LONGHELP */
@@ -253,6 +288,7 @@ U_BOOT_CMD_WITH_SUBCMDS(cedit, "Configuration editor", cedit_help_text,
 	U_BOOT_SUBCMD_MKENT(write_fdt, 5, 1, do_cedit_write_fdt),
 	U_BOOT_SUBCMD_MKENT(read_env, 2, 1, do_cedit_read_env),
 	U_BOOT_SUBCMD_MKENT(write_env, 2, 1, do_cedit_write_env),
+	U_BOOT_SUBCMD_MKENT(read_cmos, 2, 1, do_cedit_read_cmos),
 	U_BOOT_SUBCMD_MKENT(write_cmos, 2, 1, do_cedit_write_cmos),
 	U_BOOT_SUBCMD_MKENT(run, 1, 1, do_cedit_run),
 );
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 3d6f26e631d6..f415b48699ea 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -135,7 +135,14 @@ This shows writing to CMOS RAM. Notice that the bytes at 80 and 84 change::
 
     => rtc read 80 8
     00000080: 00 00 00 00 00 2f 2a 08                          ...../*.
-    =>  cedit write_cmos
+    =>  cedit write_cmos -v
     Write 2 bytes from offset 80 to 84
     => rtc read 80 8
     00000080: 01 00 00 00 08 2f 2a 08                          ...../*.
+    => cedit read_cmos -v
+    Read 2 bytes from offset 80 to 84
+
+Here is an example with the device specified::
+
+    => cedit write_cmos rtc@43
+    =>
diff --git a/include/cedit.h b/include/cedit.h
index 2970965b5f67..f43cafa5aa24 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -110,4 +110,16 @@ int cedit_read_settings_env(struct expo *exp, bool verbose);
 int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
 			      bool verbose);
 
+/**
+ * cedit_read_settings_cmos() - Read settings from CMOS RAM
+ *
+ * Read settings from the defined places in CMO RAM
+ *
+ * @exp: Expo to read settings into
+ * @dev: RTC device to read settings from
+ * @verbose: true to print a summary at the end
+ */
+int cedit_read_settings_cmos(struct expo *exp, struct udevice *dev,
+			     bool verbose);
+
 #endif /* __CEDIT_H */
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 010aae615b97..ab2b8a1f9ffa 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -182,6 +182,17 @@ static int cedit_cmos(struct unit_test_state *uts)
 	ut_assert_nextlinen("Write 2 bytes from offset 80 to 84");
 	ut_assert_console_end();
 
+	/* reset the expo */
+	menu->cur_item_id = ID_CPU_SPEED_1;
+	menu2->cur_item_id = ID_AC_OFF;
+
+	ut_assertok(run_command("cedit read_cmos -v", 0));
+	ut_assert_nextlinen("Read 2 bytes from offset 80 to 84");
+	ut_assert_console_end();
+
+	ut_asserteq(ID_CPU_SPEED_2, menu->cur_item_id);
+	ut_asserteq(ID_AC_MEMORY, menu2->cur_item_id);
+
 	return 0;
 }
 BOOTSTD_TEST(cedit_cmos, 0);
-- 
2.41.0.694.ge786442a9b-goog

