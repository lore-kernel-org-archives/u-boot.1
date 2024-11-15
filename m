Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53180D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEA1896F8;
	Sat, 16 Nov 2024 00:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1GCgx/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A057F89724; Sat, 16 Nov 2024 00:20:27 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BEFD89731
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a4e30bffe3so8180805ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712823; x=1732317623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+1VJxVX2epxjZ/p6MeS2gI2pokwHOgX+xG6RmmAO0U=;
 b=g1GCgx/ttuoTfgUvhucxrl0a0TcO8abC9HrI+QUpktGvOk/dPcwmDJRfqHfm5L1QFh
 Wk50LKErSeu5lQmamh5X8p2FM6onW1TjmS818FxrJXRzjpwwCnATf4fuadUC4e7i657q
 IrCfwBjqscucKhx2i57PJBsyRsMsi2kHleYHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712823; x=1732317623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+1VJxVX2epxjZ/p6MeS2gI2pokwHOgX+xG6RmmAO0U=;
 b=TabLXI7R3ZwQsh/Yq9L8LiQ05lNIAAZ8DLfaSuU+Ilksp8Il4GCVGta+Kj4oGsKSm/
 GeBN9kvTDQI8+jppHuG8n0wOV/N+oppbvbKoxgS5vlSNkdFNLo7V23id8JchZfisB6TC
 1B8YV85Tjwoi7c+qw0Q0VR47IkCAH+yyAcbrx20EBxjkj/039rsJ4c3CqNPGyVJcGxT0
 zGYxAoloeXCeqjMCawxrYJJMa0TEAIFKl1SjBXlVSHhMMcaIAyK9ArhbTd0BKPKaiF9R
 5TS0PY1k7yscl6XMXZxU/qaEj5D3/S7sx4dF3xv17eFl5ukWFP6VRISxw3nTGvMI4VVh
 BnRg==
X-Gm-Message-State: AOJu0YwooYly6/k8MW3CpYKQiYTlVwYdsFeOrrfXFz54lUm4d3QxDL+c
 o7KA2xiZLZxAARBexhuh0nXG9ikHoPnPV34KuN01fes5cVoevXAVjDSYXhiBUuapCEdEEGbq6BY
 =
X-Google-Smtp-Source: AGHT+IHQkOdHWnjLvFk0OKh9NqbeKZTizm11jzTjXoeJJIYx4QykGwt+WcekGZ7BX9ac3nWnDZT09g==
X-Received: by 2002:a05:6602:6c08:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-83e6c299f59mr603765439f.3.1731712823572; 
 Fri, 15 Nov 2024 15:20:23 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 19/19] fs: Record loaded files in an ad-hoc bootflow
Date: Fri, 15 Nov 2024 16:19:26 -0700
Message-Id: <20241115231926.211999-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

This makes a start on dealing with images loaded outside the context of
bootstd. For now, it just records these images. They can be listed using
the 'bootstd images' command.

Often, very little is known about these images, but future work could
perhaps use the filename or contents to detect the type.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Rebase on top of -master (which now has bootflow_efi() test)

Changes in v3:
- Add new patch to record loaded files in an ad-hoc bootflow

Changes in v2:
- Drop patches already applied
- Drop patches which add new image types
- Update to use a new image-type enum in bootflow.h

 doc/develop/bootstd/overview.rst |  3 +++
 fs/fs.c                          | 15 +++++++++++++++
 test/boot/bootflow.c             | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index e3ce97cc4f5..c46bd7a5a90 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -486,6 +486,9 @@ be visible.
 Once a bootflow has been selected, images for those that are not selected can
 potentially be dropped from the memory map. For now, this is not implemented.
 
+In cases where images are loaded outside the context of standard boot, an ad-hoc
+bootflow is used to keep track of these. They is visible with the
+``bootstd images`` command (see :doc:`/usage/cmd/bootstd`).
 
 .. _BootflowStates:
 
diff --git a/fs/fs.c b/fs/fs.c
index 1afa0fbeaed..d56c95c1b26 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_CORE
 
+#include <bootstd.h>
 #include <command.h>
 #include <config.h>
 #include <display_options.h>
@@ -734,12 +735,14 @@ int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	    int fstype)
 {
+	struct blk_desc *dev_desc;
 	unsigned long addr;
 	const char *addr_str;
 	const char *filename;
 	loff_t bytes;
 	loff_t pos;
 	loff_t len_read;
+	int dev_part;
 	int ret;
 	unsigned long time;
 	char *ep;
@@ -783,6 +786,10 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	else
 		pos = 0;
 
+	/* save globals before they are cleared */
+	dev_desc = fs_dev_desc;
+	dev_part = fs_dev_part;
+
 	time = get_timer(0);
 	ret = _fs_read(filename, addr, pos, bytes, 1, &len_read);
 	time = get_timer(time);
@@ -806,6 +813,14 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	env_set_hex("fileaddr", addr);
 	env_set_hex("filesize", len_read);
 
+	if (IS_ENABLED(CONFIG_BOOTSTD) &&
+	    bootstd_img_add(dev_desc, dev_part, filename,
+			    (enum bootflow_img_t)IH_TYPE_INVALID, addr,
+			    len_read)) {
+		log_err("Failed to record file\n");
+		return CMD_RET_FAILURE;
+	}
+
 	return 0;
 }
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 14de5b591dd..749d79d3295 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1390,3 +1390,23 @@ static int bootstd_images(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
+
+/* Check creation of ad-hoc images */
+static int bootstd_adhoc(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("load mmc 1:1 1000 /extlinux/extlinux.conf",
+				0));
+	ut_assert_nextlinen("595 bytes read");
+	ut_assertok(run_command("bootstd images", 0));
+	ut_assert_nextlinen("Seq");
+	ut_assert_nextlinen("---");
+	ut_assert_nextline(
+		"  0  ad-hoc               invalid             1000       253  /extlinux/extlinux.conf");
+	ut_assert_nextlinen("---");
+	ut_assert_nextline("(1 image)");
+
+	ut_assert_console_end();
+
+	return 0;
+}
+BOOTSTD_TEST(bootstd_adhoc, UTF_CONSOLE);
-- 
2.34.1

