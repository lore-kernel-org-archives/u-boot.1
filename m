Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC30D0EE3F
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 21:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECD189413;
	Fri, 11 Oct 2024 23:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j6q9nF4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1CC89407; Fri, 11 Oct 2024 23:40:45 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496C0893D6
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 23:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a3bd664ebaso497335ab.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 14:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728682842; x=1729287642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6ePxWlG4ffiLMC1LAsRw92IjHsxtWQIDqjO5XqetVs=;
 b=j6q9nF4xuub4KIE1iLHAuMUQzX9GHH8yd/cm9j/cKxVoXhPRaCvVpGM1mVOSg9bFqF
 FjVwvVGAZHjfHrXXTIm5G3aFbUgl3QEY90qIOu/hJsP7bYtxXxUu8qWP0yRAlmrJcBao
 RPTktyl3K3vAPr1gKtfmzBuuZGaivbMrGqoZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728682842; x=1729287642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6ePxWlG4ffiLMC1LAsRw92IjHsxtWQIDqjO5XqetVs=;
 b=rrATcJcw2pe8zQ0yQev1KYpNC92AwXKdRViPVtIK05bGH3XKrX2XPs3MHR5rBFC/qo
 ik9oyehsH/v2gD155eTILYtjIGr4sGMHU7Dj173tGB/79sWjbyQJ6CSFZwkEQxGGtUxp
 4X2+bH+7NMSZTlEp3eGDixxBcnH75DfAD12rdI16XrLHnN26gnSU6bGENL/rSwO/cGuA
 JCCjmpgVj05suamRrISeoFD8USrp1AeZTjBaBA645tbS8jADoY2mVgIDcAWvI8PNr0UW
 C3+5fqt6xu7yP2TbH/5eXPgvX2xj+4zFZwelKMoAW/Q9r9GIVAg/BjDSxYjUA6CptwRs
 uFCg==
X-Gm-Message-State: AOJu0Yx+883GrEAqMdTUG73M3nYMv3zqR8JD+schaWt3yo5NKFktzl+W
 86lWMAa2e9GPCNfXh2/T9ThqS9PTnR04NuUFHW2ZC/ukm3L42x0EEJViy6/mLg2oS7mRr0CtTG8
 u7A==
X-Google-Smtp-Source: AGHT+IFFq/5DDp940YGxyerFtzlmaZPkxYZYeoKlfNC1x3y0LySdQtxD/QZ+MbK+FWP+OEoXLJb7gQ==
X-Received: by 2002:a05:6e02:144e:b0:3a2:7651:9876 with SMTP id
 e9e14a558f8ab-3a3b5f94b2cmr30310385ab.13.1728682841843; 
 Fri, 11 Oct 2024 14:40:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a3afdae0f1sm8830475ab.11.2024.10.11.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 14:40:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/7] bootstage: Allow counting memory without strings
Date: Fri, 11 Oct 2024 15:40:29 -0600
Message-Id: <20241011214032.760072-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011214032.760072-1-sjg@chromium.org>
References: <20241011214032.760072-1-sjg@chromium.org>
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

The bootstage array includes pointers to strings but not the strings
themselves. The strings are added when stashing, but including them in
the size calculation gives an inflated view of the amount of space used
by the array.

Update this function so it can return the amount of memory used by the
bootstage structures themselves, without the strings which they point
to.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c    |  2 +-
 common/bootstage.c  | 16 +++++++++-------
 include/bootstage.h |  5 +++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 2e04a47b546..bf4252784a4 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -582,7 +582,7 @@ static int reserve_fdt(void)
 static int reserve_bootstage(void)
 {
 #ifdef CONFIG_BOOTSTAGE
-	int size = bootstage_get_size();
+	int size = bootstage_get_size(true);
 
 	gd->start_addr_sp = reserve_stack_aligned(size);
 	gd->boardf->new_bootstage = map_sysmem(gd->start_addr_sp, size);
diff --git a/common/bootstage.c b/common/bootstage.c
index 49acc9078a6..b1506120f9d 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -520,17 +520,19 @@ int _bootstage_unstash_default(void)
 }
 #endif
 
-int bootstage_get_size(void)
+int bootstage_get_size(bool add_strings)
 {
-	struct bootstage_data *data = gd->bootstage;
-	struct bootstage_record *rec;
 	int size;
-	int i;
 
 	size = sizeof(struct bootstage_data);
-	for (rec = data->record, i = 0; i < data->rec_count;
-	     i++, rec++)
-		size += strlen(rec->name) + 1;
+	if (add_strings) {
+		struct bootstage_data *data = gd->bootstage;
+		struct bootstage_record *rec;
+		int i;
+
+		for (rec = data->record, i = 0; i < data->rec_count; i++, rec++)
+			size += strlen(rec->name) + 1;
+	}
 
 	return size;
 }
diff --git a/include/bootstage.h b/include/bootstage.h
index 57792648c49..3300ca0248a 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -371,9 +371,10 @@ int bootstage_unstash(const void *base, int size);
 /**
  * bootstage_get_size() - Get the size of the bootstage data
  *
+ * @add_strings: true to add the size of attached strings (for stashing)
  * Return: size of boostage data in bytes
  */
-int bootstage_get_size(void);
+int bootstage_get_size(bool add_strings);
 
 /**
  * bootstage_init() - Prepare bootstage for use
@@ -444,7 +445,7 @@ static inline int bootstage_unstash(const void *base, int size)
 	return 0;	/* Pretend to succeed */
 }
 
-static inline int bootstage_get_size(void)
+static inline int bootstage_get_size(bool add_strings)
 {
 	return 0;
 }
-- 
2.34.1

