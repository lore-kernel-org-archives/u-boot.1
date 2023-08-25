Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31874C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EB586A57;
	Fri, 25 Aug 2023 15:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aEOm9/Oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFCE86A77; Fri, 25 Aug 2023 15:52:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A7A869F9
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692971523; x=1724507523;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fKSRPDkSHUTz7CHG0b8cK5Ap89feqoANhBtUlNNOTN8=;
 b=aEOm9/OyVkIN43eokaM0tE189nV1cOd7KWCnLu6br1GUXlFSJTdjqQ4K
 EL53qyy1WUWQexey6qV6yw2byhHswhrJNh13EqDuoYBOBdJ0M+OnkBV0L
 a0i0bOCTpxp6HWq6Zp3a2Ny+pdFfSbMJJAi8dyBgKnyaLlmcAA3WFCzfF
 BmZap47n3F0M8Ykri5k9QPxiJLpJr0cF4GpMjvLFI6mWPvfmMMCrPdHt5
 KLBzmGNLi21SSTZHwXzyRYPu7eQJbMH4DqW3iPzmgUI+JH8n/fhh45xXz
 mk3QSWNaM+bExIdiQpvVTeakrXnOZe++sNjKZbI9XwL48kwK67ciUTZkW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355044881"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="355044881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 06:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740610525"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="740610525"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 06:51:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 90F041CA; Fri, 25 Aug 2023 16:51:55 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 1/2] TO BE FOLDED: x86: tangier: Add FADT to the chain
Date: Fri, 25 Aug 2023 16:51:40 +0300
Message-Id: <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
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

The Simon's patch missed the FADT to be added to the chain, hence all
the issues on Intel Tangier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/cpu/tangier/acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/cpu/tangier/acpi.c b/arch/x86/cpu/tangier/acpi.c
index 01b30553818c..ffaa56ab6f87 100644
--- a/arch/x86/cpu/tangier/acpi.c
+++ b/arch/x86/cpu/tangier/acpi.c
@@ -52,6 +52,8 @@ static int tangier_write_fadt(struct acpi_ctx *ctx,
 
 	header->checksum = table_compute_checksum(fadt, header->length);
 
+	acpi_add_table(ctx, fadt);
+
 	acpi_inc(ctx, sizeof(struct acpi_fadt));
 
 	return 0;
-- 
2.40.0.1.gaa8946217a0b

