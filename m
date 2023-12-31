Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF53C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9B8878BA;
	Sun, 31 Dec 2023 16:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ihMjKbUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC58878C2; Sun, 31 Dec 2023 16:26:20 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB2887859
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7b7fd9e17d8so404567039f.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036377; x=1704641177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPcwditsFK5DH6QEZDS50seTwavRlC4D98U45v8ga1w=;
 b=ihMjKbUOCqNJ/8zMmuryKKfenbMZtFfna9ZzfMUXb73XtkpZ3afbZokg9Ty0nErrDD
 5/1W1+u5aRoYLVXu3B0Pa1B+t2X6g7h+Aue74QFhZz/CG0900aWoZw2GCq7L/fqBmpaU
 wa6v6C4N+RZLlwAciEAqTRID09VcbZc69kTrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036377; x=1704641177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPcwditsFK5DH6QEZDS50seTwavRlC4D98U45v8ga1w=;
 b=dAJ8PJqUC+4LvijAIc1oxYPTpwqyF8YnF5ki5nZM5pydbt5/Wh+2WfvmRrD8+YS3DT
 8w9HZLlFkEMEyhGc5CdFtJdPcuLS+MLkzvzi8+UVclFKjgu0Dk9uNEJ615YbambsNMRW
 tySG2bZNviT9S50XEIO8cnQjKko7LbGU4YN46aQwe0oXxLWD6d6ei/mtyz88mA4T/A8C
 9NQ8skOT60/IhmQCF+N4VJvkMZT2PYxJTZf8FkRurN0WT+bshcFcQip0682QuJ7uZErD
 +XaWuWAZWafRYG1jHaqNDBS/8/sZWm/qgHhuE3VMqW7Z4MGn+lVA7kYbKUHkH3xq+Exk
 FbcQ==
X-Gm-Message-State: AOJu0Ywl+aPG9+mRvAGu6cGisrlRhKI9ONRqHVUkC4EZ6HA+UTFbHIV5
 3zmLv06xcX7Gy9FLgZvuuirSBViMh5O40foskf88qTJp3j9b
X-Google-Smtp-Source: AGHT+IGSC8gCKl90ZaiUVqw+Tk7xDvGXalEsWDTkUjhZ3nCgpNYFYyEkFTZ7vZCjrQMSibDdHkJtiA==
X-Received: by 2002:a5d:93c4:0:b0:7bb:4dd8:3156 with SMTP id
 j4-20020a5d93c4000000b007bb4dd83156mr5148832ioo.34.1704036376893; 
 Sun, 31 Dec 2023 07:26:16 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 10/12] acpi: Rename test dm_test_setup_ctx_and_base_tables()
Date: Sun, 31 Dec 2023 08:25:53 -0700
Message-Id: <20231231152555.464874-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

Use the word 'acpi' in this test so that it runs along with all the
other ACPI tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add new patch to rename test dm_test_setup_ctx_and_base_tables()

 test/dm/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/dm/acpi.c b/test/dm/acpi.c
index fb071902b45..1211e2f0e7f 100644
--- a/test/dm/acpi.c
+++ b/test/dm/acpi.c
@@ -330,7 +330,7 @@ static int dm_test_acpi_basic(struct unit_test_state *uts)
 DM_TEST(dm_test_acpi_basic, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
 /* Test setup_ctx_and_base_tables */
-static int dm_test_setup_ctx_and_base_tables(struct unit_test_state *uts)
+static int dm_test_acpi_ctx_and_base_tables(struct unit_test_state *uts)
 {
 	struct acpi_rsdp *rsdp;
 	struct acpi_rsdt *rsdt;
@@ -376,7 +376,7 @@ static int dm_test_setup_ctx_and_base_tables(struct unit_test_state *uts)
 
 	return 0;
 }
-DM_TEST(dm_test_setup_ctx_and_base_tables,
+DM_TEST(dm_test_acpi_ctx_and_base_tables,
 	UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
 
 /* Test 'acpi list' command */
-- 
2.34.1

