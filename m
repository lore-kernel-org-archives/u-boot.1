Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C97D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD4B890C5;
	Mon,  4 Nov 2024 18:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cz+rUKKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B544588FE2; Mon,  4 Nov 2024 18:51:51 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AD188FAB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ac817aac3so175813539f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742708; x=1731347508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCkMrcznTuktTaPZ3PhIzrucNAzZFdOC+8tMnfyeBrM=;
 b=Cz+rUKKTgEaZNtLLuo3rSbUZKMbOzhQNSH5YtnwYMOPH8wXbnr0H8VFzBW6fbn5uGL
 D+/hT6Y1ez/Py2nznDdpunuvGnSe8CZLmJSQjhuJnoE7QrB2kz4vEXJhOpl5mXKhMqxp
 VbiB0Qu9tglEzPO2tEf1w2TjPWk/7NjqtShCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742708; x=1731347508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCkMrcznTuktTaPZ3PhIzrucNAzZFdOC+8tMnfyeBrM=;
 b=iuDyCEoU+Nks+T0mw4bYPJfT0fdcbIa5qclg2EF5TriTYr0fBWZvgOv5Ty2kNrnSz3
 b7kxXMJCAl9joWT1FKh/4kjF7MB+X7Cjya4yzyPJlIs5Jpne4PyuWXTjCdKr4yXM/5Yf
 g8drKOQICpbtZGubI/7yoi6i3gu8OmyrLFXP8+IX3h0pvfzSAoGEVMUyb21bn07/71IN
 HkEEz8Q3ltSOabpXCVtUqxr6xzB8LDJ1PVbHY32aH1HU41/WQYY1N28t78BDpqxu18q1
 KHRaMnYEMvHsr5NIcuTXqcZrf4ahzOxbgcspf5gCHPjm46IS3I6dlD9X6ixSkIctgPrC
 najQ==
X-Gm-Message-State: AOJu0YzPBqtRM122s6T5qu1shKK8r0R9haF4eGoSHlaagBpPAFS/FQx8
 aXHcGfdgvnBoKc4jpDAuZoIWyf7/cOGUlu8XXpu34iYuXgb50VObIMF5RsJQictM6Ug3DqTz+8A
 =
X-Google-Smtp-Source: AGHT+IGpGVEdnIxAn+BaW8ScxtgbYlkxMUhqaFisOQS/AXGYxu1QCn8g5jt3eEay1Lm46io8LLsmvQ==
X-Received: by 2002:a05:6602:1507:b0:82c:d67d:aa91 with SMTP id
 ca18e2360f4ac-83b566cc65dmr2473578839f.1.1730742707783; 
 Mon, 04 Nov 2024 09:51:47 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 19/19] fs: Record loaded files in an ad-hoc bootflow
Date: Mon,  4 Nov 2024 10:51:10 -0700
Message-Id: <20241104175110.1048449-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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
index 670b9253f61..8b11378a085 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1322,3 +1322,23 @@ static int bootstd_images(struct unit_test_state *uts)
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

