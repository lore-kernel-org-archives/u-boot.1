Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0730C83F15
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D5C80771;
	Thu, 31 Aug 2023 05:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="koK6F6z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A933A86557; Thu, 31 Aug 2023 05:13:52 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F0486546
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34ca860051fso1479605ab.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693451628; x=1694056428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/uY/PRnn4AnM28846Y0Skmr35u6OUgbiJ8mmfR3KKY=;
 b=koK6F6z1YpdWhsjBAHc8QV+BFvCLvcFGcZzAO0pcTLjRPAwxTfw+gMAkHJucNQp7L0
 z03gFrg7qMqH6J83CVEQlMR0Hiw2SvnMxyfOpaWjAyfnDdJbtTqWA+5shKLVp7w9xXTK
 8A1qNuSvZis+CWI9mQGySO2iPa+fxX/ThSXx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451628; x=1694056428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/uY/PRnn4AnM28846Y0Skmr35u6OUgbiJ8mmfR3KKY=;
 b=MdeML2Tm0OUQsv9EOSKRmTk6eir+mRslV4Vr3F36EOzPzVkawnAqrw1qhsBhflswL+
 RYOOWX2pUF9mpHtMj9zOPsXg/htV6vp2CQNqD0xD70IlmplsZaMN91FadJQQoH8RZ4eS
 A+vbWqf69EqZoAlj4Epzy5JJ8hSyhKiPXzxLcLLyYaE4SeH+OoJwnDTMmDa3t9Iqwtjz
 +jcpqxtkSVfIJrpD1070hyQRGTsy1eza+OYQqojhqRuopllzrd/yAd8I3ZD0ot2Kt9Rv
 UmM6Y44eVV5y4FZFJ0KYxsaXQ5yZky21Y7yAi8x+xQ6fESiIxa1DENTzqyp1cIGjkkSY
 h6uQ==
X-Gm-Message-State: AOJu0Yw2aRKWUUy5zAo0WJ9xR6Ra1C+mJaBqEsL8kDNA7QfNN+um8Bd+
 tdg5mxZhJNjiO8keJAk50ORGOKTkArrWWgoNLeU=
X-Google-Smtp-Source: AGHT+IHtYfLvOcLCB4tvywvN2DZHFWi5zRDwLfOsTOEg0/n1eJZm6Gr1kvG488Wlc3tpT9XIazQqvQ==
X-Received: by 2002:a05:6e02:12a2:b0:33a:a6de:65be with SMTP id
 f2-20020a056e0212a200b0033aa6de65bemr4184437ilr.21.1693451628292; 
 Wed, 30 Aug 2023 20:13:48 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 x10-20020a02ac8a000000b0042bbfe3dc42sm142879jan.173.2023.08.30.20.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:13:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/2] x86: Prevent from missing the FADT chaining
Date: Wed, 30 Aug 2023 21:13:35 -0600
Message-ID: <20230831031341.2657786-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831031341.2657786-1-sjg@chromium.org>
References: <20230831031341.2657786-1-sjg@chromium.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Recent approach with FADT writer shows that there is
a room for subtle errors. Prevent this from happening
again by introducing acpi_add_fadt() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/apollolake/acpi.c | 6 +-----
 arch/x86/cpu/baytrail/acpi.c   | 6 +-----
 arch/x86/cpu/quark/acpi.c      | 6 +-----
 arch/x86/cpu/tangier/acpi.c    | 6 +-----
 include/acpi/acpi_table.h      | 7 +++++++
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index 16aaed7238a..c610a7f4477 100644
--- a/arch/x86/cpu/apollolake/acpi.c
+++ b/arch/x86/cpu/apollolake/acpi.c
@@ -158,11 +158,7 @@ static int apl_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	header = &fadt->header;
 	header->checksum = table_compute_checksum(fadt, header->length);
 
-	acpi_add_table(ctx, fadt);
-
-	acpi_inc(ctx, sizeof(struct acpi_fadt));
-
-	return 0;
+	return acpi_add_fadt(ctx, fadt);
 }
 ACPI_WRITER(5fadt, "FADT", apl_write_fadt, 0);
 
diff --git a/arch/x86/cpu/baytrail/acpi.c b/arch/x86/cpu/baytrail/acpi.c
index 4c526ff2731..4378846f8b0 100644
--- a/arch/x86/cpu/baytrail/acpi.c
+++ b/arch/x86/cpu/baytrail/acpi.c
@@ -142,11 +142,7 @@ static int baytrail_write_fadt(struct acpi_ctx *ctx,
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
-	acpi_add_table(ctx, fadt);
-
-	acpi_inc(ctx, sizeof(struct acpi_fadt));
-
-	return 0;
+	return acpi_add_fadt(ctx, fadt);
 }
 ACPI_WRITER(5fadt, "FADT", baytrail_write_fadt, 0);
 
diff --git a/arch/x86/cpu/quark/acpi.c b/arch/x86/cpu/quark/acpi.c
index 92fa5bc30c3..9a2d682451b 100644
--- a/arch/x86/cpu/quark/acpi.c
+++ b/arch/x86/cpu/quark/acpi.c
@@ -137,11 +137,7 @@ static int quark_write_fadt(struct acpi_ctx *ctx,
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
-	acpi_add_table(ctx, fadt);
-
-	acpi_inc(ctx, sizeof(struct acpi_fadt));
-
-	return 0;
+	return acpi_add_fadt(ctx, fadt);
 }
 ACPI_WRITER(5fadt, "FADT", quark_write_fadt, 0);
 
diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index ffaa56ab6f8..1c667c7d569 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -52,11 +52,7 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
-	acpi_add_table(ctx, fadt);
-
-	acpi_inc(ctx, sizeof(struct acpi_fadt));
-
-	return 0;
+	return acpi_add_fadt(ctx, fadt);
 }
 ACPI_WRITER(5fadt, "FADT", tangier_write_fadt, 0);
 
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 7ed0443c821..1f85de091d3 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -883,6 +883,13 @@ void acpi_inc_align(struct acpi_ctx *ctx, uint amount);
  */
 int acpi_add_table(struct acpi_ctx *ctx, void *table);
 
+static inline int acpi_add_fadt(struct acpi_ctx *ctx, struct acpi_fadt *fadt)
+{
+	acpi_add_table(ctx, fadt);
+	acpi_inc(ctx, sizeof(struct acpi_fadt));
+	return 0;
+}
+
 /**
  * acpi_write_rsdp() - Write out an RSDP indicating where the ACPI tables are
  *
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

