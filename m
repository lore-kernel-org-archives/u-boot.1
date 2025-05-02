Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33F2C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC64B82AD2;
	Fri,  2 May 2025 16:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WoL80qRT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E2682A8B; Fri,  2 May 2025 16:48:14 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31A782AAE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8616987c261so73134739f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197290; x=1746802090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Y76B+umZQi7pP3JUhlKgT5j8+3rOfSSgzZbv6gXYzw=;
 b=WoL80qRTXAbyBspfknR95fRmh5foS/ZqweRQGr8AaSr2e7oPBGe2lYIUZQcNbfaCf2
 4neTmR4aVy6BEa5sQXy0Iw8gIbqkm/QSZLna1G+P6xefeVIqRbsNh7LrhGVz5V+weUfp
 6Q+ipCbGvcBZQzAwK/3SxhWEiu1aPwRW3yTpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197290; x=1746802090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Y76B+umZQi7pP3JUhlKgT5j8+3rOfSSgzZbv6gXYzw=;
 b=vhB70/SXOYTTQRPqDJhZzUikq3vzHkYCb/2g/6OPuBsXyOIagDlC3wID2Oj9c1SYuL
 b4ptUL7/N5SSlkn0vvjlARAUyfrpCE25LCcypPo/YgxpTz7hks6C1aJTHiL82nPa0If/
 KXAyg3vZVvc5rIQQuDDLeWpVNHBjUkiNt6EpXYHe5zZo/I2lpUcnwhcdKjNZwm1jeA5W
 Y2ACDMQkdf/4qNzZwVcgwXhtmhwludoYO+1xGwv7uS9AOePHqoRT0ofMqRr9kITh178Q
 jjIV3LtgqpiRBS6LrNhH+c62ZNdLIoR+U0FlK/NBrI4h1G+qWccjPy8Tt5DiNhFAUZz2
 us7w==
X-Gm-Message-State: AOJu0YxqRhf0Ysj+CmiESsrEyME7f+jGUYAgvL4TwIoCoy09pImM0BbC
 okV6zPchCMZ1+TMRfXCR6Bp/ypRWbQRcVvBMIab1YvzeIJGLS3PelfLgxBCj2ST9JoRspkq+T0k
 =
X-Gm-Gg: ASbGnctxpEcxgF886H6tMsKe5WEv1MNp5ePCdGn96fVKsjbliRbGjRpkCgt/3UY2m/Z
 6u4ZDQ7nQZAM2WI3z5I69MAmmep6qwT5bvrsvDWQDl+57BHsdLgozHO+x0NMH6zK6FRVACn3RQr
 yNQhY+T2xmx+Rih1dcnt11+rdxH1sso0hqjn3G+b4+2MhtTDOyskpnBEoeJbqMkmjhPQH0FuqW7
 W4rgle2M4xnV+kqIaacGvDm+CQLMkzuzTqOPOVZUp6qRDfismFjE4DPvQ25nIQ28jsFd9swMfDq
 9VwYuZr7E03iUW/ul8heQPMYejMDh2qFNxaNNNoi6l0WpzM37de/c2wINfSiTHr+qDnJu8AHQPW
 Hlw==
X-Google-Smtp-Source: AGHT+IGaXP1nG1EF6OtzWshOJhS64ge3PNlHz52dj99fpoMQMcVkPYzkpiqmtFbx2Lyzl8dhuJQ/GQ==
X-Received: by 2002:a05:6602:b83:b0:861:d71f:33e3 with SMTP id
 ca18e2360f4ac-8669f9adb5cmr431684239f.5.1746197290017; 
 Fri, 02 May 2025 07:48:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/60] expo: Test rendering a lineedit
Date: Fri,  2 May 2025 08:46:23 -0600
Message-ID: <20250502144718.313633-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

