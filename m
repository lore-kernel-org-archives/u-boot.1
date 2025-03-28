Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09394C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83187820FE;
	Fri, 28 Mar 2025 14:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m2ohwH/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD268206E; Fri, 28 Mar 2025 14:08:02 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32E982006
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d59c8f0979so9014325ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167278; x=1743772078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Y76B+umZQi7pP3JUhlKgT5j8+3rOfSSgzZbv6gXYzw=;
 b=m2ohwH/0P3E4gb4u8mblHCVPy419aUvYmNrG4FZDjL7hf4XcMWgWRnLJ4vWm9OGu6r
 aj9FvdDVqZe6QUbi3Hm16BPPLqui/IOcpb50bmguG9FGWZRu9XDYQpz5yGKHLeNb+eCG
 vfGYDilz/vYADYjFR+lta3vtmP101FE6KUPwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167278; x=1743772078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Y76B+umZQi7pP3JUhlKgT5j8+3rOfSSgzZbv6gXYzw=;
 b=e4vRJUaxIvqNyK+ni/xmagz0QItaRkO6g6gbkn+CevFOn/wT58R0cVnsjnb9e8eqFf
 oXABmPKnNLLeAnOk/i7cMtEDVXe5HL+XldreAkrqZGAfeFcZ5NVhgWAgtuVL/YkVnIFG
 rQKBQvMQYQ+G9PRZrGLV0gotZ7kPijxtt/QAGNxvFfoemo//KV11Kown699DvBKtIHKf
 gALGKN/DnzqxEbh/f6g0LFAdgoP9/P0kBZ81H+lixIjMvRQ3cmX2fPsHNSXync0I2WfI
 RnG6Di8NzckububdJ7jYKvlcxWGCJTtiT2hs4S9DfIFn7DjCl27eBrcw/HkzWQD4gRpZ
 f6ZQ==
X-Gm-Message-State: AOJu0YyHjTHrgo2Eyrxb8zJuiITrQLBEvc4WBu71gmIHG9fwoJ8deNdm
 cFdxlHUGDnyr2nnv+ihD6IO1Q9d5SPaOzv3nGmSF4rpj0cnChqLjZmouENBMc6uL86YjFZcwsIU
 =
X-Gm-Gg: ASbGnctKIC0wGQPPyAshkdGJyclh9+plnpIDoOhCG0Q2nXWknqBA+okmz1U8HhyCmpM
 IaW8rPDsUOytWzEgvap7Deuj0hY1wSXv5LO4p9o/A1puvxEzA/ZZ4cUFKRPBg3KJE3xBCR5mSNR
 iLzp80GB7qizqBVdf1Uyq4qyISXblMJnPltSREMB4XSnaCr30zGUpEG715Tu3mHqjfQFt2/IEsN
 1pCJa8+RVuE2WdN9q8LkHldjFuXdwDy0iT9IN1Sfy/IXG8nrOOq2GdD1b0YjuuAzjvu6Zig8Rbm
 JVPpYTb5l2ZSXpZRiC4UALjCh6OOhz2BlMobRbQMw1saqpBiNaiIknGEuIlS003Xr9WYWZCB0DL
 pVGBAcMtBVh638/DC
X-Google-Smtp-Source: AGHT+IG+DoQkd0BfXkKJ1O1/jjcQP096ioxyMaGJzKhin+R26kF9t4k/Py4by+2wCLAXox/kQfNnvQ==
X-Received: by 2002:a05:6e02:4401:10b0:3d4:2a80:74fb with SMTP id
 e9e14a558f8ab-3d5d6c4ba58mr19531445ab.3.1743167277783; 
 Fri, 28 Mar 2025 06:07:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/56] expo: Test rendering a lineedit
Date: Fri, 28 Mar 2025 07:06:08 -0600
Message-ID: <20250328130713.2612648-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Check the rendering output when adding characters to a line-edit object.

Add a separate test to check behaviour when starting with existing text
in the lineedit. The cursor should start at the end.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to test rendering a lineedit

 test/boot/cedit.c | 113 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 746f60067fd..97ca63b3082 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -234,21 +234,28 @@ static int cedit_cmos(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(cedit_cmos, UTF_CONSOLE);
 
-/* Check the cedit displays correctely */
+/* Check the cedit displays correctly */
 static int cedit_render(struct unit_test_state *uts)
 {
 	struct scene_obj_menu *menu;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
+	struct expo_action evt;
 	struct expo_action act;
-	struct udevice *dev;
+	struct udevice *dev, *con;
+	struct stdio_dev *sdev;
 	struct scene *scn;
 	struct expo *exp;
+	int i;
 
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
 
 	exp = cur_exp;
-	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	sdev = stdio_get_by_name("vidconsole");
+	ut_assertnonnull(sdev);
+	con = sdev->priv;
+
+	dev = dev_get_parent(con);
 	vid_priv = dev_get_uclass_priv(dev);
 	ut_asserteq(ID_SCENE1, cedit_prepare(exp, dev, &scn));
 
@@ -295,9 +302,109 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_assertok(expo_render(exp));
 	ut_asserteq(4986, video_compress_fb(uts, dev, false));
 
+	/* move to the line-edit field */
+	act.type = EXPOACT_POINT_OBJ;
+	act.select.id = ID_MACHINE_NAME;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4872, video_compress_fb(uts, dev, false));
+
+	/* open it */
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_MACHINE_NAME;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4841, video_compress_fb(uts, dev, false));
+
+	/*
+	 * Send some keypresses. Note that the console must be enabled so that
+	 * the characters actually reach the putc_xy() in console_truetype,
+	 * since in scene_textline_send_key(), the lineedit restores the
+	 * vidconsole state, outputs the character and then saves the state
+	 * again. If the character is never output, then the state won't be
+	 * updated and the lineedit will be inconsistent.
+	 */
+	ut_unsilence_console(uts);
+	for (i = 'a'; i < 'd'; i++)
+		ut_assertok(scene_send_key(scn, i, &evt));
+	ut_silence_console(uts);
+	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5009, video_compress_fb(uts, dev, false));
+
 	expo_destroy(exp);
 	cur_exp = NULL;
 
 	return 0;
 }
 BOOTSTD_TEST(cedit_render, UTF_DM | UTF_SCAN_FDT);
+
+/* Check the cedit displays lineedits correctly */
+static int cedit_render_lineedit(struct unit_test_state *uts)
+{
+	struct scene_obj_textline *tline;
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	struct expo_action evt;
+	struct expo_action act;
+	struct udevice *dev, *con;
+	struct stdio_dev *sdev;
+	struct scene *scn;
+	struct expo *exp;
+	char *str;
+	int i;
+
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+
+	exp = cur_exp;
+	sdev = stdio_get_by_name("vidconsole");
+	ut_assertnonnull(sdev);
+	con = sdev->priv;
+
+	dev = dev_get_parent(con);
+	vid_priv = dev_get_uclass_priv(dev);
+	ut_asserteq(ID_SCENE1, cedit_prepare(exp, dev, &scn));
+
+	/* set up an initial value for the textline */
+	tline = scene_obj_find(scn, ID_MACHINE_NAME, SCENEOBJT_TEXTLINE);
+	ut_assertnonnull(tline);
+	str = abuf_data(&tline->buf);
+	strcpy(str, "my-machine");
+	ut_asserteq(20, tline->pos);
+
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5336, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+
+	/* move to the line-edit field */
+	act.type = EXPOACT_POINT_OBJ;
+	act.select.id = ID_MACHINE_NAME;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5363, video_compress_fb(uts, dev, false));
+
+	/* open it */
+	act.type = EXPOACT_OPEN;
+	act.select.id = ID_MACHINE_NAME;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	// ut_asserteq(0, tline->pos);
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5283, video_compress_fb(uts, dev, false));
+
+	/* delete some characters */
+	ut_unsilence_console(uts);
+	for (i = 0; i < 3; i++)
+		ut_assertok(scene_send_key(scn, '\b', &evt));
+	ut_silence_console(uts);
+	ut_asserteq_str("my-mach", str);
+
+	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5170, video_compress_fb(uts, dev, false));
+
+	expo_destroy(exp);
+	cur_exp = NULL;
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_render_lineedit, UTF_DM | UTF_SCAN_FDT);
-- 
2.43.0

