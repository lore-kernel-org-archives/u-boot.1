Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C50EC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC7780EBD;
	Wed, 15 Jan 2025 14:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k8CvYpWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E7080EB2; Wed, 15 Jan 2025 14:32:36 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8B7807B1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so467589039f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947953; x=1737552753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l64nGdkMMknL+lHr/rmp5Wp9k0AOsieBxNjrswNSJPI=;
 b=k8CvYpWFrwbTfT+VJVBxs2sMPqY8dqCGOE/rGX5FeLu53O1oZZAyePA8B+qi63RprS
 fOctz5TXsgKk4sOgFn6bnD3EzDTAVjnkBOmG/C31nJKO8J6dPwEOuO8MGLKwPecZrzIE
 XfK4Gu1MtlAE5Szl66vdlNmYdB/qz1z4DOehQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947953; x=1737552753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l64nGdkMMknL+lHr/rmp5Wp9k0AOsieBxNjrswNSJPI=;
 b=GLVCx9YpO2CHEvy1FRc0UePp3dQEU/+xtR8W42VEM37tl/D54H5RYdH5Oca2WZoh12
 ynmxrGmQ+LB4AKXA92Em9aHWp8RVTW2RnUJ78xW7DEIDrf/o/3BKjl1O3sIhFmBgd/K7
 lOI6Vkhk1gO26WxH6r/HbUfVDFH/Z/J0qLMKRE9/nwa1QDInXSq7UV+HihTRrKll9Rev
 mYSozOfwjq9hzsIzzhiwyfQcKWqa61oez3swYaM6MxPIXKEuupsg8kRLgTSqqq7dpt9L
 akJ1u6fz7YOMxuulsJNxJomK6jBOe7GeXu3XGrRXUPubeqDbvoMwH4Lfoedd3HUgHcYd
 ZUiw==
X-Gm-Message-State: AOJu0YwG3wYqM0cd3gUdHrQIg9WCTsZBOTDgW0/eCE8hr2WchQ7+zmVG
 xVmWub9rO4yC4cj8IrIiQX8XUBP1WwIa5zZPQleDlk5Qc8IOm3iplNwgqE+msuD87mOOVhKcZpU
 =
X-Gm-Gg: ASbGncvAH5KNXzJheeZYF4iL3rzfOPxYnTthm5Jw3GgHdBdZkOK6QzTbMyhrNt/TkpU
 XJvtHGAaDED9NrwyX0+xLLf/EhVjtiURi5409icD+eKRSESQwby3eXXOj985eVhiQcR9w3txo6T
 ZBMrrRCFqpz5pQ13S/vQNFKXleQOLwCNLUk+zVhzl8vxvkeWShoC4H4DTP9Dp7Ubej9pl6aSUaO
 owYxcUv9K/pZR6ARwfi+urlqn/xUsb53UFYPQJgX0Z3w6KuRimO1gLDqy89f2ENflQf4Gv0pZ9a
 qVs5uFZLGysuU/ke4A==
X-Google-Smtp-Source: AGHT+IEAnpFNC7WJ6lVptbDfuvOnDfPSw+slOh7Pgun5UtQy8N321JqCBpRkzuYCgp6uJgKt4capTA==
X-Received: by 2002:a05:6602:b98:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-84ce016f5d3mr2958675639f.12.1736947952769; 
 Wed, 15 Jan 2025 05:32:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 43/43] test: Move help into the suite declaration
Date: Wed, 15 Jan 2025 06:31:13 -0700
Message-Id: <20250115133114.590375-44-sjg@chromium.org>
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

Rather than having the help in the longhelp, put it in the suite info
so 'ut info -s' can show it. This is tidier, particular due to the
removal of #ifdefs

This means that the help text is present in the image (although not
displayed with 'ut info -s') so the image-size increases. But with
UNIT_TEST enabled, we expect large images so this doesn't seem
important.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c | 127 ++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 87 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 3afab422e4a..76f481f509b 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -19,14 +19,16 @@
  *
  * @name: Name of suite
  * @start: First test in suite
- * end: End test in suite (points to the first test in the next suite
- * cmd: Command to use to run the suite
+ * @end: End test in suite (points to the first test in the next suite
+ * @cmd: Command to use to run the suite
+ * @help: Help-string to show for this suite
  */
 struct suite {
 	const char *name;
 	struct unit_test *start;
 	struct unit_test *end;
 	ut_cmd_func cmd;
+	const char *help;
 };
 
 static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
@@ -75,19 +77,21 @@ int cmd_ut_category(struct unit_test_state *uts, const char *name,
 	ll_end_decl(suite_end_ ## _name, struct unit_test, ut_ ## _name)
 
 /* declare a test suite which uses a subcommand to run */
-#define SUITE_CMD(_name, _cmd_func) { \
+#define SUITE_CMD(_name, _cmd_func, _help) { \
 	#_name, \
 	suite_start_ ## _name, \
 	suite_end_ ## _name, \
 	_cmd_func, \
+	_help, \
 	}
 
 /* declare a test suite which can be run directly without a subcommand */
-#define SUITE(_name) { \
+#define SUITE(_name, _help) { \
 	#_name, \
 	suite_start_ ## _name, \
 	suite_end_ ## _name, \
 	NULL, \
+	_help, \
 	}
 
 SUITE_DECL(addrmap);
@@ -117,37 +121,37 @@ SUITE_DECL(setexpr);
 SUITE_DECL(upl);
 
 static struct suite suites[] = {
-	SUITE(addrmap),
-	SUITE(bdinfo),
-	SUITE(bloblist),
-	SUITE(bootm),
+	SUITE(addrmap, "very basic test of addrmap command"),
+	SUITE(bdinfo, "bdinfo (board info) command"),
+	SUITE(bloblist, "bloblist implementation"),
+	SUITE(bootm, "bootm command"),
 #ifdef CONFIG_UT_BOOTSTD
-	SUITE_CMD(bootstd, do_ut_bootstd),
+	SUITE_CMD(bootstd, do_ut_bootstd, "standard boot implementation"),
 #endif
-	SUITE(cmd),
-	SUITE(common),
-	SUITE(dm),
-	SUITE(env),
-	SUITE(exit),
-	SUITE(fdt),
-	SUITE(font),
-	SUITE(hush),
-	SUITE(lib),
-	SUITE(loadm),
-	SUITE(log),
-	SUITE(mbr),
-	SUITE(measurement),
-	SUITE(mem),
+	SUITE(cmd, "various commands"),
+	SUITE(common, "tests for common/ directory"),
+	SUITE(dm, "driver model"),
+	SUITE(env, "environment"),
+	SUITE(exit, "shell exit and variables"),
+	SUITE(fdt, "fdt command"),
+	SUITE(font, "font command"),
+	SUITE(hush, "hush behaviour"),
+	SUITE(lib, "library functions"),
+	SUITE(loadm, "loadm command parameters and loading memory blob"),
+	SUITE(log, "logging functions"),
+	SUITE(mbr, "mbr command"),
+	SUITE(measurement, "TPM-based measured boot"),
+	SUITE(mem, "memory-related commands"),
 #ifdef CONFIG_UT_OPTEE
-	SUITE_CMD(optee, do_ut_optee),
+	SUITE_CMD(optee, do_ut_optee, "OP-TEE"),
 #endif
 #ifdef CONFIG_UT_OVERLAY
-	SUITE_CMD(overlay, do_ut_overlay),
+	SUITE_CMD(overlay, do_ut_overlay, "device tree overlays"),
 #endif
-	SUITE(pci_mps),
-	SUITE(seama),
-	SUITE(setexpr),
-	SUITE(upl),
+	SUITE(pci_mps, "PCI Express Maximum Payload Size"),
+	SUITE(seama, "seama command parameters loading and decoding"),
+	SUITE(setexpr, "setexpr command"),
+	SUITE(upl, "Universal payload support"),
 };
 
 /**
@@ -232,16 +236,19 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (flags && !strcmp("-s", flags)) {
 		int i;
 
-		puts("\nTests  Suite\n");
-		puts("-----  -----\n");
+		puts("\nTests  Suite         Purpose");
+		puts("\n-----  ------------  -------------------------\n");
 		for (i = 0; i < ARRAY_SIZE(suites); i++) {
 			struct suite *ste = &suites[i];
 			long n_ent = ste->end - ste->start;
 
 			if (n_ent)
-				printf("%5ld  %s\n", n_ent, ste->name);
+				printf("%5ld", n_ent);
 			else if (ste->cmd)
-				printf("%5s  %s\n", "?", ste->name);
+				printf("%5s", "?");
+			else  /* suite is not present */
+				continue;
+			printf("  %-13.13s %s\n", ste->name, ste->help);
 		}
 	}
 
@@ -306,60 +313,6 @@ U_BOOT_LONGHELP(ut,
 	"\nOptions for <suite>:"
 	"\nall - execute all enabled tests"
 	"\ninfo [-s] - show info about tests [and suites]"
-#ifdef CONFIG_CMD_ADDRMAP
-	"\naddrmap - very basic test of addrmap command"
-#endif
-#ifdef CONFIG_CMD_BDI
-	"\nbdinfo - bdinfo command"
-#endif
-#ifdef CONFIG_SANDBOX
-	"\nbloblist - bloblist implementation"
-#endif
-#ifdef CONFIG_BOOTSTD
-	"\nbootstd - standard boot implementation"
-#endif
-#ifdef CONFIG_CMDLINE
-	"\ncmd - test various commands"
-#endif
-	"\ncommon   - tests for common/ directory"
-#ifdef CONFIG_UT_DM
-	"\ndm - driver model"
-#endif
-#ifdef CONFIG_UT_ENV
-	"\nenv - environment"
-#endif
-#ifdef CONFIG_CMD_FDT
-	"\nfdt - fdt command"
-#endif
-#ifdef CONFIG_CONSOLE_TRUETYPE
-	"\nfont - font command"
-#endif
-#if CONFIG_IS_ENABLED(HUSH_PARSER)
-	"\nhush - Test hush behavior"
-#endif
-#ifdef CONFIG_CMD_LOADM
-	"\nloadm - loadm command parameters and loading memory blob"
-#endif
-#ifdef CONFIG_UT_LIB
-	"\nlib - library functions"
-#endif
-#ifdef CONFIG_UT_LOG
-	"\nlog - logging functions"
-#endif
-	"\nmem - memory-related commands"
-#ifdef CONFIG_UT_OPTEE
-	"\noptee - test OP-TEE"
-#endif
-#ifdef CONFIG_UT_OVERLAY
-	"\noverlay - device tree overlays"
-#endif
-#ifdef CONFIG_CMD_PCI_MPS
-	"\npci_mps - PCI Express Maximum Payload Size"
-#endif
-	"\nsetexpr - setexpr command"
-#ifdef CONFIG_CMD_SEAMA
-	"\nseama - seama command parameters loading and decoding"
-#endif
 	);
 
 U_BOOT_CMD(
-- 
2.34.1

