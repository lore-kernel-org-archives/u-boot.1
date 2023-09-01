Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77A5CA0FEC
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 17:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32ED86564;
	Fri,  1 Sep 2023 19:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sob/cj6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE9C8071F; Fri,  1 Sep 2023 19:27:42 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B105860AA
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 19:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so5645539f.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693589258; x=1694194058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QadWbuoxSzeOGSXWeC9JhwDmnXpSvx82SBVjFydM90w=;
 b=Sob/cj6FgwSDuS6CYKseit/lGmCXSyjOEybJPjvYe+qyYvAQs7oxduIX4biqmSmFFD
 rd3HIMh0MTaWJqAyvFe/+t3Tt/JuIGq/+akNgSrdfbDGgRbdkEjSGLfWzBFLGab9cltZ
 CWSbGRhz09BdZ8nlS4B7Hq9n4FHbGk8NPk2L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693589258; x=1694194058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QadWbuoxSzeOGSXWeC9JhwDmnXpSvx82SBVjFydM90w=;
 b=fBSS8IzpMLdIwdG4aESYCzMf7YIAZC2cPJvFRuVHcMTj2ZFFekog9JHXybFHnnnujU
 y29Q7c0DOoeSOVQgt1bZwieo6CkjwiEEljRBn+CtyAYwmvRakRgtkF4EIjjqG/1yyrSO
 mfJoFJBDHzcDOEk2Z0rggkaIy+z8gt4Hco4xi/9p0QZZKUl0hMILTIGMlFfnzsCGF6WV
 YHCSGlf29BJabvag30TbL/MV9v2GZETcvim3swRXD/iDcV4CBr2v2eTl7VDEBEA6LEX3
 WIoorZNjnaeNobwrXypBc5Yzr/HZk6Rqv1S+WWxCdqy1VXGo55vtuoz94bElMF+StxH5
 jvpw==
X-Gm-Message-State: AOJu0YyJp0LcOo6TBRrvw7BigpHDAuAlNDYz0OZkDGTJwZQRMuI9/sv8
 7eBDyMzC1vzqle81U/BfmHO37FZ09ihsvk4NPgU=
X-Google-Smtp-Source: AGHT+IECLdhdM+UVFTsTwpOnvt1IH6Jpi+GviypLzzsVBYfWhHLAnhvASMbGGdIFO0ZViV16IPSOGA==
X-Received: by 2002:a6b:3b41:0:b0:794:e98c:30c9 with SMTP id
 i62-20020a6b3b41000000b00794e98c30c9mr4329543ioa.1.1693589258587; 
 Fri, 01 Sep 2023 10:27:38 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:6e93:c368:57d1:5c46])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a6bf207000000b00786f5990435sm1192610ioh.7.2023.09.01.10.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 10:27:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/2] x86: Prevent from missing the FADT chaining
Date: Fri,  1 Sep 2023 11:27:10 -0600
Message-ID: <20230901112707.v3.2.Id8d2f7a61003b53d62b89aab0523afe7184217cb@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901112707.v3.1.I61008e563b1209243a9a7f2b66073b4737ff82d1@changeid>
References: <20230901112707.v3.1.I61008e563b1209243a9a7f2b66073b4737ff82d1@changeid>
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
2.42.0.283.g2d96d420d3-goog

