Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92587C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86EE186A81;
	Fri, 25 Aug 2023 15:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SYR9MNc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6913C86A7B; Fri, 25 Aug 2023 15:52:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CC986A6D
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692971524; x=1724507524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l6u4gh9h0M+AxA2HydQZvzTlnhbdauxSVSPpw4fJy/8=;
 b=SYR9MNc5dpMam30Dl3sWtBKNgh4q1SVapWirDWHytjKu0sFbKcpr+JgK
 mApD0TkD/66t0vxOxMXK/6R8IhJlSZkg/sFLdgEEpiqiWYza8V2cEAjKv
 Ke7yeJ3Y9+1wxKMTe0TI5DqNYKToN16taJREvNerXzLJ+kduVLfCgnaWp
 HTn31eUkncGNwkPEacGA3wsHDetjF5Iy9pYNFbZo2tCOuQjN2+gP9XFLh
 NbBCAlSrW6uOe2iHrQnGiXEoOhf/gDJj0aM5cdB+ECP5rRvIktTxTHiGu
 acA1t9G5rhJZTj0+gTzlCX58YYPGgR10miN9UpZPnH3XACte1stq7CJGy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355044887"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="355044887"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 06:51:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740610526"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="740610526"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 06:51:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id A345F23A; Fri, 25 Aug 2023 16:51:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 2/2] x86: Prevent from missing the FADT chaining
Date: Fri, 25 Aug 2023 16:51:41 +0300
Message-Id: <20230825135141.3210006-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
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

Recent approach with FADT writer shows that there is
a room for subtle errors. Prevent this from happening
again by introducing acpi_add_fadt() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/cpu/apollolake/acpi.c | 6 +-----
 arch/x86/cpu/baytrail/acpi.c   | 6 +-----
 arch/x86/cpu/quark/acpi.c      | 6 +-----
 arch/x86/cpu/tangier/acpi.c    | 6 +-----
 include/acpi/acpi_table.h      | 7 +++++++
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/cpu/apollolake/acpi.c b/arch/x86/cpu/apollolake/acpi.c
index 16aaed7238ab..c610a7f44770 100644
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
index 4c526ff27310..4378846f8b0c 100644
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
index 92fa5bc30c36..9a2d682451be 100644
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
index ffaa56ab6f87..1c667c7d5693 100644
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
index 7ed0443c821a..1f85de091d39 100644
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
2.40.0.1.gaa8946217a0b

