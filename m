Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1637C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5718070C;
	Fri, 17 Jan 2025 01:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wVkHQCgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84BB80312; Fri, 17 Jan 2025 01:10:29 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A63928073F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 10A953F851
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737072620;
 bh=8/qf7ks47hvXcBqm2u6wCHUm0oOXQNO84XAPzqPga6s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wVkHQCgq5+fE3elzU4VNKZ512lxhdaUXffGf/1S7ODnrCIcTJNqPWSwIr56OdMFhn
 6xRCLZaBXMi8e9YQjc1/ONb4HISSf6wb1u4vB33PMpNsz/8V9A39EdQEM/LnlfUSEh
 Gpnzi2ehY29eTVxvEDQ0pHYA2E8t+j0J9MjH2IGWzcG3uMCNt7/YoCrsYD6MmmVrCg
 S1uaoBhWUIL3/MYfhxGvDUJX1KqTNw+ISNZzT0FHzDBckqIyJnIJC85bDNGROD5/po
 05eH0iYZ2JJJl9ZzneEfXMETXs2wr5ZJHSH8bgaQKiqfSKyMyS1HZm4zFkqed7hKJX
 S8S94aj5cVbsg==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d9f2ec86d1so1203258a12.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072616; x=1737677416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/qf7ks47hvXcBqm2u6wCHUm0oOXQNO84XAPzqPga6s=;
 b=Dutn1hySOuVQSE2TOcqvN8mqIZIZtOftbAEKE58Ij+JjagD761dDSZfBCcYaPKMHql
 101s31DNVpuuFmVtkX9Hc9H1vWHqq8sQkk/HghwdGP/PDAVUDxX76XLJfXbjjUNUPSWr
 yC7atxSpGn79lzrP1NTo2LhdhVniAPcphwWH+h0rHXYyceogFVsawdajvTKaOTgiy/7L
 ZWBLp5XpNagZyXyKutXt56ErwkjQqge7RiId5EClTZpwu/MA+W9hC9P5erngGBZ5uaua
 cQOFI1bohek7EXHUMcRTBxfbiiGQcqecoL7VB21e9dN8zwdf5S75fvRGubyQnETSj58B
 4Qlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW41ViExR/gfT10R90XhhI8GxOCnKMbEPmwSKIPE0iClLunws+SzJLPm9QF9DQC+oI06RwMA+c=@lists.denx.de
X-Gm-Message-State: AOJu0YzbM/1EyNdgF5ZfwP+c8gOAw4GHi4fzfpf3NB1zhxKq6N3ug66s
 SrlDWeWI3iWs/e3l9ytJOAiJWIIDAeOwqYL2w3oV4gHuRj+K2l/WFsypiWdX4yJWXwjQzDCwo/g
 qT2R1Y4bnRyp8wwqxx19xkiVBUQyNZWXVMie5bhhwURF0GFCnpmo+hn+MykIRrZHcT1M=
X-Gm-Gg: ASbGncuXxKpgv+yfpPz0TX9KijFVfBQmYsZc1hSpUsQbNDnl4Xv/IpPE4lTInLfBfMg
 JG8GOHNcVJB66dWMFmBJy1b1CnZY5Q8Gb/UmRVuWQPasXEdBx49ucn4yheokHrcA+7WehvGe1n6
 Ep6W1VKGcu1TtOjUlYMoHvDL2wOBmRl3JbuB4F0EZLcS2hR95pKhJj2DEVAa+mEd6JfZarsLhvH
 Dpvw3noqEp91nIPRGW7nTRhz55DVsO1QfDRAiXltCLK4kITcU5LvGZP0TLMItrpPB2Vsk7ZlG5A
 w1Bo3m1IrAtcNA==
X-Received: by 2002:a05:6402:2742:b0:5d9:f21e:ffd with SMTP id
 4fb4d7f45d1cf-5db7d2ff8ccmr1352805a12.15.1737072616251; 
 Thu, 16 Jan 2025 16:10:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM53VZ/uJY3BMhgSXwiP26LdDlBE9jhb4WEu0XTTLDas427dfbUVld7yDw58g9gIxaQxJprw==
X-Received: by 2002:a05:6402:2742:b0:5d9:f21e:ffd with SMTP id
 4fb4d7f45d1cf-5db7d2ff8ccmr1352759a12.15.1737072615785; 
 Thu, 16 Jan 2025 16:10:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d27117sm71986466b.75.2025.01.16.16.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:10:14 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] log: enable filtering on functions
Date: Fri, 17 Jan 2025 01:09:53 +0100
Message-ID: <20250117000954.531785-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
References: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
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

Up to now we could only use log level, category, and file for filtering.
Allow filtering on a list of functions.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/log.c             | 42 ++++++++++++++++++++++--------------------
 common/log.c          | 13 ++++++++++++-
 include/log.h         |  5 +++--
 test/log/log_filter.c |  1 -
 test/log/log_test.c   | 10 +++++-----
 5 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/cmd/log.c b/cmd/log.c
index 519ec76f3b5..64add6d8b5a 100644
--- a/cmd/log.c
+++ b/cmd/log.c
@@ -115,30 +115,27 @@ static int do_log_filter_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	/*      <3> < 6  > <2+1 + 7 > <      16      > < unbounded... */
-	printf("num policy level            categories files\n");
 	list_for_each_entry(filt, &ldev->filter_head, sibling_node) {
-		printf("%3d %6.6s %s %-7.7s ", filt->filter_num,
-		       filt->flags & LOGFF_DENY ? "deny" : "allow",
+		printf("%-3d: %s %s %s\n", filt->filter_num,
+		       filt->flags & LOGFF_DENY ? "DENY" : "ALLOW",
 		       filt->flags & LOGFF_LEVEL_MIN ? ">=" : "<=",
 		       log_get_level_name(filt->level));
 
 		if (filt->flags & LOGFF_HAS_CAT) {
-			int i;
-
-			if (filt->cat_list[0] != LOGC_END)
-				printf("%16.16s %s\n",
-				       log_get_cat_name(filt->cat_list[0]),
-				       filt->file_list ? filt->file_list : "");
-
-			for (i = 1; i < LOGF_MAX_CATEGORIES &&
-				    filt->cat_list[i] != LOGC_END; i++)
-				printf("%21c %16.16s\n", ' ',
+			printf("     Categories:");
+			for (int i = 0;
+			     i < LOGF_MAX_CATEGORIES &&
+			     filt->cat_list[i] != LOGC_END;
+			     ++i) {
+				printf(" %s",
 				       log_get_cat_name(filt->cat_list[i]));
-		} else {
-			printf("%16c %s\n", ' ',
-			       filt->file_list ? filt->file_list : "");
+			}
+			printf("\n");
 		}
+		if (filt->file_list)
+			printf("     Files: %s\n", filt->file_list);
+		if (filt->func_list)
+			printf("     Functions: %s\n", filt->func_list);
 	}
 
 	return CMD_RET_SUCCESS;
@@ -151,6 +148,7 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
 	bool print_num = false;
 	bool type_set = false;
 	char *file_list = NULL;
+	char *func_list = NULL;
 	const char *drv_name = "console";
 	int opt, err;
 	int cat_count = 0;
@@ -160,7 +158,7 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct getopt_state gs;
 
 	getopt_init_state(&gs);
-	while ((opt = getopt(&gs, argc, argv, "Ac:d:Df:l:L:p")) > 0) {
+	while ((opt = getopt(&gs, argc, argv, "Ac:d:Df:F:l:L:p")) > 0) {
 		switch (opt) {
 		case 'A':
 #define do_type() do { \
@@ -199,6 +197,9 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
 		case 'f':
 			file_list = gs.arg;
 			break;
+		case 'F':
+			func_list = gs.arg;
+			break;
 		case 'l':
 #define do_level() do { \
 			if (level_set) { \
@@ -229,7 +230,7 @@ static int do_log_filter_add(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	cat_list[cat_count] = LOGC_END;
 	err = log_add_filter_flags(drv_name, cat_count ? cat_list : NULL, level,
-				   file_list, flags);
+				   file_list, func_list, flags);
 	if (err < 0) {
 		printf("Could not add filter (err = %d)\n", err);
 		return CMD_RET_FAILURE;
@@ -388,7 +389,8 @@ U_BOOT_LONGHELP(log,
 	"\t-d <driver> - Specify the log driver to add the filter to; defaults\n"
 	"\t              to console\n"
 	"\t-D - Deny messages matching this filter; mutually exclusive with -A\n"
-	"\t-f <files_list> - A comma-separated list of files to match\n"
+	"\t-f <file_list> - A comma-separated list of files to match\n"
+	"\t-F <func_list> - A comma-separated list of functions to match\n"
 	"\t-l <level> - Match log levels less than or equal to <level>;\n"
 	"\t             mutually-exclusive with -L\n"
 	"\t-L <level> - Match log levels greather than or equal to <level>;\n"
diff --git a/common/log.c b/common/log.c
index b2b5f3c81ba..b75e404420b 100644
--- a/common/log.c
+++ b/common/log.c
@@ -192,6 +192,10 @@ static bool log_passes_filters(struct log_device *ldev, struct log_rec *rec)
 		    !log_has_member(filt->file_list, rec->file))
 			continue;
 
+		if (filt->func_list &&
+		    !log_has_member(filt->func_list, rec->func))
+			continue;
+
 		if (filt->flags & LOGFF_DENY)
 			return false;
 		else
@@ -329,7 +333,7 @@ int _log_buffer(enum log_category_t cat, enum log_level_t level,
 
 int log_add_filter_flags(const char *drv_name, enum log_category_t cat_list[],
 			 enum log_level_t level, const char *file_list,
-			 int flags)
+			 const char *func_list, int flags)
 {
 	struct log_filter *filt;
 	struct log_device *ldev;
@@ -364,6 +368,13 @@ int log_add_filter_flags(const char *drv_name, enum log_category_t cat_list[],
 			goto err;
 		}
 	}
+	if (func_list) {
+		filt->func_list = strdup(func_list);
+		if (!filt->func_list) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
 	filt->filter_num = ldev->next_filter_num++;
 	/* Add deny filters to the beginning of the list */
 	if (flags & LOGFF_DENY)
diff --git a/include/log.h b/include/log.h
index 3f9023ae0d2..7d8d10c1fb9 100644
--- a/include/log.h
+++ b/include/log.h
@@ -508,6 +508,7 @@ struct log_filter {
 	enum log_category_t cat_list[LOGF_MAX_CATEGORIES];
 	enum log_level_t level;
 	const char *file_list;
+	const char *func_list;
 	struct list_head sibling_node;
 };
 
@@ -605,7 +606,7 @@ int do_log_test(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  */
 int log_add_filter_flags(const char *drv_name, enum log_category_t cat_list[],
 			 enum log_level_t level, const char *file_list,
-			 int flags);
+			 const char *func_list, int flags);
 
 /**
  * log_add_filter() - Add a new filter to a log device
@@ -628,7 +629,7 @@ static inline int log_add_filter(const char *drv_name,
 				 const char *file_list)
 {
 	return log_add_filter_flags(drv_name, cat_list, max_level, file_list,
-				    0);
+				    NULL, 0);
 }
 
 /**
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index d36e9d9714e..8622dcf2913 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -39,7 +39,6 @@ static int log_test_filter(struct unit_test_state *uts)
 
 #define create_filter(args, filter_num) do {\
 	ut_assertok(run_command("log filter-add -p " args, 0)); \
-	ut_assert_skipline(); \
 	ut_assertok(strict_strtoul(uts->actual_str, 10, &(filter_num))); \
 	ut_assert_console_end(); \
 } while (0)
diff --git a/test/log/log_test.c b/test/log/log_test.c
index 1c89df4ef18..8686b1cbef3 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -320,7 +320,7 @@ int log_test_cat_deny(struct unit_test_state *uts)
 	filt1 = log_add_filter("console", cat_list, LOGL_MAX, NULL);
 	ut_assert(filt1 >= 0);
 	filt2 = log_add_filter_flags("console", cat_list, LOGL_MAX, NULL,
-				     LOGFF_DENY);
+				     NULL, LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
 	log_run_cat(UCLASS_SPI);
@@ -340,7 +340,7 @@ int log_test_file_deny(struct unit_test_state *uts)
 	filt1 = log_add_filter("console", NULL, LOGL_MAX, "file");
 	ut_assert(filt1 >= 0);
 	filt2 = log_add_filter_flags("console", NULL, LOGL_MAX, "file",
-				     LOGFF_DENY);
+				     NULL, LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
 	log_run_file("file");
@@ -360,7 +360,7 @@ int log_test_level_deny(struct unit_test_state *uts)
 	filt1 = log_add_filter("console", NULL, LOGL_INFO, NULL);
 	ut_assert(filt1 >= 0);
 	filt2 = log_add_filter_flags("console", NULL, LOGL_WARNING, NULL,
-				     LOGFF_DENY);
+				     NULL, LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
 	log_run();
@@ -380,10 +380,10 @@ int log_test_min(struct unit_test_state *uts)
 	int filt1, filt2;
 
 	filt1 = log_add_filter_flags("console", NULL, LOGL_WARNING, NULL,
-				     LOGFF_LEVEL_MIN);
+				     NULL, LOGFF_LEVEL_MIN);
 	ut_assert(filt1 >= 0);
 	filt2 = log_add_filter_flags("console", NULL, LOGL_INFO, NULL,
-				     LOGFF_DENY | LOGFF_LEVEL_MIN);
+				     NULL, LOGFF_DENY | LOGFF_LEVEL_MIN);
 	ut_assert(filt2 >= 0);
 
 	log_run();
-- 
2.47.1

