Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC9BC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1C78073D;
	Wed, 15 Jan 2025 14:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kIw8OPtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9873D80805; Wed, 15 Jan 2025 14:31:36 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D1A80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so44397175ab.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947892; x=1737552692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAmXwXa60yOkKUC2ZH8HOcyYgNlV/pkgcyRz6T7GCek=;
 b=kIw8OPtUI9WQARGdDI2M1pT8wecz7KjWG0LFzOog41kssoKdgiyyx+eDlzC0LBZQ3B
 jqtZugJpFoY9Bdzl23+A2/tDgRD2m69bbE0TmMC6OzcVRDtekZXmdv3bYlg58rUEqkLP
 mt/oxi2LnWihOu9m+aKY7K08DhRrgWe5fclHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947892; x=1737552692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAmXwXa60yOkKUC2ZH8HOcyYgNlV/pkgcyRz6T7GCek=;
 b=N903uDgSpluqYIDgt9cd02jXoNA7dwg213nJY+5V9zWfFKWiaaVAQS+ftYkevausKO
 3rv3+OilKDAu1dUAISxHs528Z61ymOz03s/EU5FsQHU/dcXe3GtA8BkMo5UGsBioQOwd
 hQGUPwg74JK0UdFutKkFFof3m38EWyeQ82Z9CQjzjzDKoP49qvIvYAXFfeP7HLSiEP+n
 LHj/CSFnTNUr5DV9qxibpCS0DeqUnlqdajFvc754BgIBtgqEuNQHarLtm76rZPvtbZ1d
 u+GryMmUM4IgwciXYiEopWvRG+W9YOmOSj3vZQCmr86Oi82q6O81m9CXJnCOPgWs4E5K
 0nvQ==
X-Gm-Message-State: AOJu0Yy/7Lzp1vMQrmiEhpXphEENnT7XM1SiITcCAALZr7rbRQu6f1ry
 piFOvoILHlaxVOHb9LejbTd+TO51+vyNWImq9Xx3wHWqDe/jjyOCQ8DvlSmo4DX9lQcS4EQ+lRA
 =
X-Gm-Gg: ASbGncvvSClsnIHFfJPcWxCXAfxc1PA4xjMeSuAsX6iI27pp1D2x/R+5DWb0XlnGJhv
 S+oYrzSIPzIndUvX+VBxISy8zqTvf1snIxhXQOgcDsaPVMIPP7D7kJCu6lVzuFxGaAWBk/cUGvK
 yEbg3raULoXtYCJ5n+vQKTxwKSMj/2BN30L8gL5/ajhC3nLS7aBKmr17N46jZWDL7NxaTKerWRw
 WHBaJftTSZoSyaUOl9iq4vnO0XYfhDPG275OZXq1OiwX8R9WMV7KjtQsLt5lTuSKKaY4kPze3hW
 c0aTQRtCk0OOLq4xtg==
X-Google-Smtp-Source: AGHT+IFINHxdFFomt0lIR8cWVIE/VD5dW9KkoPmTePUtpdBGd6+tXxGwA1YwERVmwqKwD1FmJTSZ2w==
X-Received: by 2002:a05:6e02:8d:b0:3ce:87e3:c26c with SMTP id
 e9e14a558f8ab-3ce87e3c4c7mr18837975ab.5.1736947892365; 
 Wed, 15 Jan 2025 05:31:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/43] test: Rename test suites to match their linker-list name
Date: Wed, 15 Jan 2025 06:30:37 -0700
Message-Id: <20250115133114.590375-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Some suites have a different name from that used in the linker list.
That makes it hard to programmatically match the name printed when the
suite runs to the linker-list name it has.

Update the names so they are the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/cmd.h    | 2 +-
 test/boot/upl.c       | 3 +--
 test/cmd/addrmap.c    | 2 +-
 test/cmd/cmd_ut_cmd.c | 4 ++--
 test/cmd/exit.c       | 2 +-
 test/cmd/mem.c        | 2 +-
 test/cmd/pci_mps.c    | 2 +-
 test/cmd/setexpr.c    | 2 +-
 test/dm/test-dm.c     | 3 +--
 test/env/cmd_ut_env.c | 3 +--
 10 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/test/cmd.h b/include/test/cmd.h
index c200570e423..3d1e3e3bddb 100644
--- a/include/test/cmd.h
+++ b/include/test/cmd.h
@@ -10,6 +10,6 @@
 #include <test/test.h>
 
 /* Declare a new command test */
-#define CMD_TEST(_name, _flags) UNIT_TEST(_name, _flags, cmd_test)
+#define CMD_TEST(_name, _flags) UNIT_TEST(_name, _flags, cmd)
 
 #endif /* __TEST_CMD_H__ */
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 99f02b7951b..ef65cf34055 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -432,6 +432,5 @@ int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(upl_test);
 
-	return cmd_ut_category("cmd_upl", "cmd_upl_", tests, n_ents, argc,
-			       argv);
+	return cmd_ut_category("upl", "cmd_upl_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/addrmap.c b/test/cmd/addrmap.c
index b34be895f5d..43897615aa9 100644
--- a/test/cmd/addrmap.c
+++ b/test/cmd/addrmap.c
@@ -30,6 +30,6 @@ int do_ut_addrmap(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(addrmap_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(addrmap_test);
 
-	return cmd_ut_category("cmd_addrmap", "cmd_addrmap_", tests, n_ents,
+	return cmd_ut_category("addrmap", "cmd_addrmap_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/cmd/cmd_ut_cmd.c b/test/cmd/cmd_ut_cmd.c
index e77fa1c7f01..ad192563c5a 100644
--- a/test/cmd/cmd_ut_cmd.c
+++ b/test/cmd/cmd_ut_cmd.c
@@ -13,8 +13,8 @@
 
 int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd_test);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd_test);
+	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd);
 
 	return cmd_ut_category("cmd", "cmd_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/cmd/exit.c b/test/cmd/exit.c
index af58a57fca7..cf65c05e283 100644
--- a/test/cmd/exit.c
+++ b/test/cmd/exit.c
@@ -116,6 +116,6 @@ int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(exit_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(exit_test);
 
-	return cmd_ut_category("cmd_exit", "exit_test_", tests, n_ents,
+	return cmd_ut_category("exit", "exit_test_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/cmd/mem.c b/test/cmd/mem.c
index f1bbab6055b..d6f2544a4e9 100644
--- a/test/cmd/mem.c
+++ b/test/cmd/mem.c
@@ -14,6 +14,6 @@ int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(mem_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(mem_test);
 
-	return cmd_ut_category("cmd_mem", "mem_test_", tests, n_ents, argc,
+	return cmd_ut_category("mem", "mem_test_", tests, n_ents, argc,
 			       argv);
 }
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index a265105600c..0c57d15d636 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -35,6 +35,6 @@ int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps_test);
 	const int n = UNIT_TEST_SUITE_COUNT(pci_mps_test);
 
-	return cmd_ut_category("cmd_pci_mps", "pci_mps_test_", tests, n,
+	return cmd_ut_category("pci_mps", "pci_mps_test_", tests, n,
 			       argc, argv);
 }
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 21a3268bd81..9b3277f2ad9 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -485,6 +485,6 @@ int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(setexpr_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(setexpr_test);
 
-	return cmd_ut_category("cmd_setexpr", "setexpr_test_", tests, n_ents,
+	return cmd_ut_category("setexpr", "setexpr_test_", tests, n_ents,
 			       argc, argv);
 }
diff --git a/test/dm/test-dm.c b/test/dm/test-dm.c
index 4bc2c45db61..7cfbefe02da 100644
--- a/test/dm/test-dm.c
+++ b/test/dm/test-dm.c
@@ -11,6 +11,5 @@ int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(dm_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(dm_test);
 
-	return cmd_ut_category("driver model", "dm_test_", tests, n_ents, argc,
-			       argv);
+	return cmd_ut_category("dm", "dm_test_", tests, n_ents, argc, argv);
 }
diff --git a/test/env/cmd_ut_env.c b/test/env/cmd_ut_env.c
index 9f16a978f2a..494b5db395b 100644
--- a/test/env/cmd_ut_env.c
+++ b/test/env/cmd_ut_env.c
@@ -80,6 +80,5 @@ int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct unit_test *tests = UNIT_TEST_SUITE_START(env_test);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(env_test);
 
-	return cmd_ut_category("environment", "env_test_",
-			       tests, n_ents, argc, argv);
+	return cmd_ut_category("env", "env_test_", tests, n_ents, argc, argv);
 }
-- 
2.34.1

