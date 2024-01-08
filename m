Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FB6C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DC487955;
	Mon,  8 Jan 2024 01:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyN/bLox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE84087A21; Mon,  8 Jan 2024 01:15:03 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74F787955
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7b7fdde8b56so147305939f.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672899; x=1705277699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qiEUhFOB3eyVwbrvouvAoY0O3xiBhYzlqh3z9E1+akI=;
 b=PyN/bLoxtsN1xfx+bAv1YDZoFcLIcN88cTw2TkRjnaj95o0Uqn1HLkfMdAEXLpcINO
 Rk5EKMVOZVDMfDZBxEKNPyGOLpxPDRcVkmU4qBnrGzmgCIWI6OCTdcDWE9/SGw39Rwx7
 +a7ASxXJmbpVRBB/1lpQjjuFUlPzXaPK54vLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672899; x=1705277699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qiEUhFOB3eyVwbrvouvAoY0O3xiBhYzlqh3z9E1+akI=;
 b=JxpmCgcPLMCcsUdsieEDn0m8LYepKsqWaBI8gjptq6LSb1loceTuZXe50tZ9Rl89OA
 LdeJ7mXUNfA4lI0xzwjtWBnR1mDJZG6iD+fOpvncCiOr3akswV3DyMiXmoTN19TBnYGx
 AHWycLUmv7v6T9mG/UVPKEYy5f+jq5PC2TaT4tGby85akKQhkJiKkiuDlTr67xo97Vmv
 HPXDlUo4rHwAZupTJpwmUZ9ihW+PWucL7voG9wIu1mcmERQnjAIdEww7P15RvaKtCfZD
 hnn7VFbsoh3p7XvvojijSYq7tm79k0ElKC978JT056QV4fpOaIHN6nDGTt0thEZAPbXU
 zQ9w==
X-Gm-Message-State: AOJu0Yzg7NdDhJmbJBSoig7qEH6gujPUULcrH5+/y5P1gLGZPastCwBz
 n9Ga0a/8K3jQMlPpA6MuXlVnLGcFrwOdPXljm1ACGHW8MFsW
X-Google-Smtp-Source: AGHT+IG1ez+ETkI/WIt735vAXWFpxQktyR1jDn3CpSqfzqz6608wMNQfLwIDrGyRPNeeRHYsaLpKWg==
X-Received: by 2002:a6b:3f42:0:b0:7ba:7fd1:a638 with SMTP id
 m63-20020a6b3f42000000b007ba7fd1a638mr4102751ioa.16.1704672899363; 
 Sun, 07 Jan 2024 16:14:59 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a023407000000b0046dc488fe32sm1873420jae.82.2024.01.07.16.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 16:14:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/2] video: Allow querying the font size
Date: Sun,  7 Jan 2024 17:14:54 -0700
Message-Id: <20240108001455.35638-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

All the font size to be queried using the 'font size' command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/font.c             | 17 +++++++++--------
 doc/usage/cmd/font.rst |  6 ++++--
 test/cmd/font.c        |  9 +++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/cmd/font.c b/cmd/font.c
index cb39c88063f..c7fe2a70a49 100644
--- a/cmd/font.c
+++ b/cmd/font.c
@@ -56,9 +56,6 @@ static int do_font_size(struct cmd_tbl *cmdtp, int flag, int argc,
 	uint size;
 	int ret;
 
-	if (argc != 2)
-		return CMD_RET_USAGE;
-
 	if (uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &dev))
 		return CMD_RET_FAILURE;
 	ret = vidconsole_get_font_size(dev, &font_name, &size);
@@ -67,12 +64,16 @@ static int do_font_size(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	size = dectoul(argv[1], NULL);
+	if (argc < 2) {
+		printf("%d\n", size);
+	} else {
+		size = dectoul(argv[1], NULL);
 
-	ret = vidconsole_select_font(dev, font_name, size);
-	if (ret) {
-		printf("Failed (error %d)\n", ret);
-		return CMD_RET_FAILURE;
+		ret = vidconsole_select_font(dev, font_name, size);
+		if (ret) {
+			printf("Failed (error %d)\n", ret);
+			return CMD_RET_FAILURE;
+		}
 	}
 
 	return 0;
diff --git a/doc/usage/cmd/font.rst b/doc/usage/cmd/font.rst
index 8ba149d7599..fea0df3f745 100644
--- a/doc/usage/cmd/font.rst
+++ b/doc/usage/cmd/font.rst
@@ -10,7 +10,7 @@ Synopis
 
     font list
     font select <name> [<size>]
-    font size <size>
+    font size [<size>]
 
 Description
 -----------
@@ -31,7 +31,7 @@ This selects a new font and optionally changes the size.
 font size
 ~~~~~~~~~
 
-This changes the font size only.
+This changes the font size only. With no argument it shows the current size.
 
 Examples
 --------
@@ -41,6 +41,8 @@ Examples
     => font list
     nimbus_sans_l_regular
     cantoraone_regular
+    => font size
+    30
     => font size 40
     => font select cantoraone_regular 20
     =>
diff --git a/test/cmd/font.c b/test/cmd/font.c
index 1fe05c1ead5..9c1eebf799e 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -60,10 +60,19 @@ static int font_test_base(struct unit_test_state *uts)
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("cantoraone_regular", name);
 	ut_asserteq(40, size);
+	ut_assertok(ut_check_console_end(uts));
+
+	ut_assertok(run_command("font size", 0));
+	ut_assert_nextline("40");
+	ut_assertok(ut_check_console_end(uts));
 
 	ut_assertok(run_command("font size 30", 0));
 	ut_assertok(ut_check_console_end(uts));
 
+	ut_assertok(run_command("font size", 0));
+	ut_assert_nextline("30");
+	ut_assertok(ut_check_console_end(uts));
+
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("cantoraone_regular", name);
 	ut_asserteq(30, size);
-- 
2.34.1

