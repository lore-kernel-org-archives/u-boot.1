Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104F8C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C674686A28;
	Thu, 24 Aug 2023 21:56:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Quq9hhKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788A386961; Thu, 24 Aug 2023 21:56:17 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69CA869B8
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7927f36120cso1478039f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906972; x=1693511772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knLJQbSrsUo/fQCHcEuBPYHZViwc1bbKN1K65q6yKwg=;
 b=Quq9hhKy9IIcNcAHVbShE6j4rra1agPcnmFGNHyU1rkioi9QdvQCPd5uw8Y4p65T7v
 SyrdIya8yV1y9PCQTRV3w3K+Nse3D9sraF2zEHNVdaHusUKd3/wAqmEk01uaUYhTdCX5
 DrCTwC6JQM2KBcqt1IGuceyQVwG+DLOAcRL6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906972; x=1693511772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knLJQbSrsUo/fQCHcEuBPYHZViwc1bbKN1K65q6yKwg=;
 b=B2wkUx4OGOLqRCGbTeHbGwNBo+G5Z6aPSqfKZuBzR2oALVxPQkkyevsR61jmF3CpAC
 s8aYb0uMRRjfvo1EIH/c1I9OqdE+1Rv2gkawAaCcle+0wr/g04lFytNnZsbfD8VBeqOT
 B7wEZJKDNoPYTdT9iUQxHOgAkQ+y3pgNO9nIE9+DPovbegHWd32hYGI2a7BHliw+76Vx
 T8yxpLd/L8ZmHS0RjC8RBRPLzkD6KbFQbpyLppCgjR/yqeF9n5WkOb7RcKEiJCZOIgfw
 bDuX1RN2k/+XPpUrSdayQHWvWLupkYmky/Mf+5GlDs2saJsboMjg5/Q62rvqB93LqQpC
 OdtA==
X-Gm-Message-State: AOJu0YwS5FFHKqp2fhd08q7t4Os21f0lXsE35hxTKOdUtVwkmDYgZraa
 7FMX/9e+we8oZEySlEK3zOOB6lHcpIdfbqtJ6Jo=
X-Google-Smtp-Source: AGHT+IHX/yYHQHAB1dTWLppbheSHikQOOgZ+ZWYkRo0T4toh7tCVbz0KlZT1hcryIkYtK+HoffVgrw==
X-Received: by 2002:a6b:fb03:0:b0:790:aa71:b367 with SMTP id
 h3-20020a6bfb03000000b00790aa71b367mr6873621iog.4.1692906972502; 
 Thu, 24 Aug 2023 12:56:12 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/23] bootflow: Show an empty filename when there is none
Date: Thu, 24 Aug 2023 13:55:39 -0600
Message-ID: <20230824195553.1685996-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

At present 'bootflow list' shows <NULL> for the filename when it is not
present. Show an empty string instead, since that is more user-friendly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/bootflow.c       |  2 +-
 test/boot/bootflow.c | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 3c3abaf8a3b2..300ad3aaa760 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -71,7 +71,7 @@ static void show_bootflow(int index, struct bootflow *bflow, bool errors)
 	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
 	       bflow->method->name, bootflow_state_get_name(bflow->state),
 	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
-	       "(none)", bflow->part, bflow->name, bflow->fname);
+	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
 	if (errors)
 		report_bootflow_err(bflow, bflow->err);
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8a4e090e9bcf..649237a9e229 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -167,21 +167,22 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("Scanning bootdev 'mmc2.bootdev':");
-	ut_assert_nextline("  0  extlinux     media   mmc          0  mmc2.bootdev.whole        <NULL>");
+	ut_assert_nextline("  0  extlinux     media   mmc          0  mmc2.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
-	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        <NULL>");
+	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
 
 	ut_assert_nextline("Scanning bootdev 'mmc1.bootdev':");
-	ut_assert_nextline("  2  extlinux     media   mmc          0  mmc1.bootdev.whole        <NULL>");
+	ut_assert_nextline("  2  extlinux     media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
-	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        <NULL>");
+	ut_assert_nextline("  3  efi          media   mmc          0  mmc1.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-2: No such file or directory");
 	ut_assert_nextline("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
 	ut_assert_nextline("  5  efi          fs      mmc          1  mmc1.bootdev.part_1       efi/boot/bootsbox.efi");
 
 	ut_assert_skip_to_line("Scanning bootdev 'mmc0.bootdev':");
-	ut_assert_skip_to_line(" 3f  efi          media   mmc          0  mmc0.bootdev.whole        <NULL>");
+	ut_assert_skip_to_line(
+		" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
 	ut_assert_nextline("     ** No partition found, err=-93: Protocol not supported");
 	ut_assert_nextline("No more bootdevs");
 	ut_assert_nextlinen("---");
@@ -192,10 +193,11 @@ static int bootflow_cmd_scan_e(struct unit_test_state *uts)
 	ut_assert_nextline("Showing all bootflows");
 	ut_assert_nextline("Seq  Method       State   Uclass    Part  Name                      Filename");
 	ut_assert_nextlinen("---");
-	ut_assert_nextline("  0  extlinux     media   mmc          0  mmc2.bootdev.whole        <NULL>");
-	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        <NULL>");
-	ut_assert_skip_to_line("  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
-	ut_assert_skip_to_line(" 3f  efi          media   mmc          0  mmc0.bootdev.whole        <NULL>");
+	ut_assert_nextline("  0  extlinux     media   mmc          0  mmc2.bootdev.whole        ");
+	ut_assert_nextline("  1  efi          media   mmc          0  mmc2.bootdev.whole        ");
+	ut_assert_skip_to_line(
+		"  4  extlinux     ready   mmc          1  mmc1.bootdev.part_1       /extlinux/extlinux.conf");
+	ut_assert_skip_to_line(" 3f  efi          media   mmc          0  mmc0.bootdev.whole        ");
 	ut_assert_nextlinen("---");
 	ut_assert_nextline("(64 bootflows, 1 valid)");
 	ut_assert_console_end();
@@ -384,7 +386,7 @@ static int bootflow_system(struct unit_test_state *uts)
 	console_record_reset_enable();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
-		"  0  efi_mgr      ready   (none)       0  <NULL>                    <NULL>");
+		"  0  efi_mgr      ready   (none)       0  <NULL>                    ");
 	ut_assert_skip_to_line("No more bootdevs");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.42.0.rc1.204.g551eb34607-goog

