Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F5ACCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09F683655;
	Wed,  1 Oct 2025 23:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CJ/WJEs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FB583653; Wed,  1 Oct 2025 23:29:45 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63067835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-92790f12293so15657739f.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354181; x=1759958981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjVWaYbtzi4TFqj/55vHtVVZZHZD4IDJyqahetrPrJ4=;
 b=CJ/WJEs0AW/wN1+nCFB8+ad4ceHFzaLAaIlUOYyFM4ok8xqRpZXhqH2M9O0Px0ibKY
 CTDGxSy35QMsZX4dxpMWAW+DHY1J4Jkyy2Lf5cMcsAM/DZK1ry6nn+1iTMOz+cKfd3Ji
 FvLWDEyXYpgHqODfF0vTs2CYiZPBvXDIcOFQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354181; x=1759958981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjVWaYbtzi4TFqj/55vHtVVZZHZD4IDJyqahetrPrJ4=;
 b=OnZ8rKTeEhqJIpeG5fip4tlCzUf5hdbCyL445mAb6Yw6rA1jbJN76D45X01DXnsw6i
 ywBxWmYn1pe8t4xxJWbIXjNLI46bpAnmsvymo2l+4Y2oVsmq6Q0GX+y24hB8pRV6JzDh
 9A1e+Rwk9uWn+5l6n9td2ob57GYVXHflztkBdn+ywN6y3+sSrVGgcXvE3akfrlCgRL+4
 kQJLKDPHwZRVpmvPCyJq7R8tXEskBGW2I4bgCKBo7eUyA8AiCWBDrEFc2CXEY2F6PgLF
 QKDrC8KzUlOi8ytbUeFlNMvhMvAxFI354CNpplbyCsbeR59mnJFHdHjPyUv19JPWYBOv
 M6VQ==
X-Gm-Message-State: AOJu0YxCqS0Ub7WoqXY0jvsZLAUFw/eEZH0Ggkzcfbhon2SLgAjXqgas
 XzGKOHQvR1Qei6L6/mrwkA46K5huDAXAwRgK5hFeUSgFbpICe52vGwwUt2kJuc6u5qsaVueHFZf
 T/b+cbegj
X-Gm-Gg: ASbGncsHsaV4SmiWmNG8RHFiu8NYEcyHSctNFSX9pzAgTvRSz+INAoW7ywsnzfArJDQ
 PMHcz9seR5vbURZt/FhTy3OiW0qUJvnEdLVMOne26biBwR1y6R54VWu3UV9+CpyawfaicUwEpDB
 P0sY5eUzD59px2IUjWqyT0FPfPECzGBtNpFANeeCNRugE1YgjCns5YSMsq6/bjE3dnBPPDQcEth
 F3xRGy02+tZwocoZsTGRtYIJkvwIlcF/Avc398ddGs7N7c75+9P1618y5qztdApIzH0UffXPmfq
 zrPEdwQK79ZOEguYpjhO20EFQd0uruDUlDMDBnSLm9Wlw1zWKe81JO3+Rd65hDrRiYZ1354LayD
 pJ592AvWT7OSiNT7U7+MtKHMHgWBmAo2+GOHt/7wE
X-Google-Smtp-Source: AGHT+IGh8/Lh4RL/fOIrXzVs350KIPlPDiqCbM8b3m4JrDr/QjyxUNH+djpD1TpOYA7ug0E9hVfjsg==
X-Received: by 2002:a92:cda8:0:b0:40b:db4:839b with SMTP id
 e9e14a558f8ab-42d815abb60mr67845255ab.5.1759354180915; 
 Wed, 01 Oct 2025 14:29:40 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/17] boot: Move showing of bootflows out of the command
Date: Wed,  1 Oct 2025 15:26:30 -0600
Message-ID: <20251001212649.3263574-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

It is helpful in tests to be able to show the bootflow that is being
examined. Move show_bootflow() into boot/ and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a log_err() for an invalid state

 boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
 cmd/bootflow.c     | 68 ++--------------------------------------------
 include/bootflow.h |  9 ++++++
 3 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 4595aa55f0f..9aa9d449b7f 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -54,6 +54,63 @@ const char *bootflow_state_get_name(enum bootflow_state_t state)
 	return bootflow_state[state];
 }
 
+/**
+ * report_bootflow_err() - Report where a bootflow failed
+ *
+ * When a bootflow does not make it to the 'loaded' state, something went wrong.
+ * Print a helpful message if there is an error
+ *
+ * @bflow: Bootflow to process
+ * @err: Error code (0 if none)
+ */
+static void report_bootflow_err(struct bootflow *bflow, int err)
+{
+	if (!err)
+		return;
+
+	/* Indent out to 'Method' */
+	printf("     ** ");
+
+	switch (bflow->state) {
+	case BOOTFLOWST_BASE:
+		printf("No media/partition found");
+		break;
+	case BOOTFLOWST_MEDIA:
+		printf("No partition found");
+		break;
+	case BOOTFLOWST_PART:
+		printf("No filesystem found");
+		break;
+	case BOOTFLOWST_FS:
+		printf("File not found");
+		break;
+	case BOOTFLOWST_FILE:
+		printf("File cannot be loaded");
+		break;
+	case BOOTFLOWST_READY:
+		printf("Ready");
+		break;
+	case BOOTFLOWST_COUNT:
+		log_err("Unexpected boot value of bootflow error %d",
+			 bflow->state);
+		break;
+	}
+
+	printf(", err=%dE\n", err);
+}
+
+void bootflow_show(int index, struct bootflow *bflow, bool errors)
+{
+	const char *name = bootflow_guess_label(bflow);
+
+	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
+	       bflow->method ? bflow->method->name : "(none)",
+	       bootflow_state_get_name(bflow->state), name, bflow->part,
+	       bflow->name, bflow->fname ?: "");
+	if (errors)
+		report_bootflow_err(bflow, bflow->err);
+}
+
 int bootflow_first_glob(struct bootflow **bflowp)
 {
 	struct bootstd_priv *std;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 5b803d4ace5..46b2c8260d0 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -18,68 +18,6 @@
 #include <log.h>
 #include <mapmem.h>
 
-/**
- * report_bootflow_err() - Report where a bootflow failed
- *
- * When a bootflow does not make it to the 'loaded' state, something went wrong.
- * Print a helpful message if there is an error
- *
- * @bflow: Bootflow to process
- * @err: Error code (0 if none)
- */
-static void report_bootflow_err(struct bootflow *bflow, int err)
-{
-	if (!err)
-		return;
-
-	/* Indent out to 'Method' */
-	printf("     ** ");
-
-	switch (bflow->state) {
-	case BOOTFLOWST_BASE:
-		printf("No media/partition found");
-		break;
-	case BOOTFLOWST_MEDIA:
-		printf("No partition found");
-		break;
-	case BOOTFLOWST_PART:
-		printf("No filesystem found");
-		break;
-	case BOOTFLOWST_FS:
-		printf("File not found");
-		break;
-	case BOOTFLOWST_FILE:
-		printf("File cannot be loaded");
-		break;
-	case BOOTFLOWST_READY:
-		printf("Ready");
-		break;
-	case BOOTFLOWST_COUNT:
-		break;
-	}
-
-	printf(", err=%dE\n", err);
-}
-
-/**
- * show_bootflow() - Show the status of a bootflow
- *
- * @seq: Bootflow index
- * @bflow: Bootflow to show
- * @errors: True to show the error received, if any
- */
-static void show_bootflow(int index, struct bootflow *bflow, bool errors)
-{
-	const char *name = bootflow_guess_label(bflow);
-
-	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
-	       bflow->method ? bflow->method->name : "(none)",
-	       bootflow_state_get_name(bflow->state), name, bflow->part,
-	       bflow->name, bflow->fname ?: "");
-	if (errors)
-		report_bootflow_err(bflow, bflow->err);
-}
-
 static void show_header(void)
 {
 	printf("Seq  Method       State   Uclass    Part  Name                      Filename\n");
@@ -233,7 +171,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_FAILURE;
 		}
 		if (list)
-			show_bootflow(i, &bflow, errors);
+			bootflow_show(i, &bflow, errors);
 		if (!menu && boot && !bflow.err)
 			bootflow_run_boot(&iter, &bflow);
 	}
@@ -291,7 +229,7 @@ static int do_bootflow_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		     !ret;
 		     ret = bootdev_next_bootflow(&bflow), i++) {
 			num_valid += bflow->state == BOOTFLOWST_READY;
-			show_bootflow(i, bflow, errors);
+			bootflow_show(i, bflow, errors);
 		}
 	} else {
 		printf("Showing all bootflows\n");
@@ -300,7 +238,7 @@ static int do_bootflow_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		     !ret;
 		     ret = bootflow_next_glob(&bflow), i++) {
 			num_valid += bflow->state == BOOTFLOWST_READY;
-			show_bootflow(i, bflow, errors);
+			bootflow_show(i, bflow, errors);
 		}
 	}
 	show_footer(i, num_valid);
diff --git a/include/bootflow.h b/include/bootflow.h
index 657e3731f11..b1efeee3259 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -700,4 +700,13 @@ int bootflow_menu_poll(struct expo *exp, int *seqp);
  */
 const char *bootflow_guess_label(const struct bootflow *bflow);
 
+/**
+ * bootflow_show() - Show the status of a bootflow
+ *
+ * @seq: Bootflow index
+ * @bflow: Bootflow to show
+ * @errors: True to show the error received, if any
+ */
+void bootflow_show(int index, struct bootflow *bflow, bool errors);
+
 #endif
-- 
2.43.0

