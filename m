Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC7BD15D98
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1B488EDA;
	Mon, 21 Oct 2024 16:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EjdhGDSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6A188EDA; Mon, 21 Oct 2024 16:06:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BD888916
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729519568; x=1761055568;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yANAHEkaqIu4N8ymIQD1QfPCJH1nVqf7+O+/fyanggM=;
 b=EjdhGDSsNJynnZJYvp2z7Kbu+5QcFIfpJ5sEPY7HFL6EErEme81RfWy9
 iXPpdBiuqvMxCvAS13zabj7HC2l4GUFSAJDExN5GMnAnhZ+5SvspBhY7E
 T3JMtV74DIAIg/clpc1ByXJMxxasrHkchJAJce8FJ7y2dofZpD/GZUHy/
 iwjfhl2Rc85c+wsf5l2G8H3vMc8Ytdk5mZ72g8CiYKvRlTZ2e3GRyZdbP
 0j4P6NoOQoC88UP+eQCOaFZeabm4hhPMHcb/tGoXT8GINNLfk5qEEP551
 qZuazYRwYuMcK+w3ndCV/rTUMxLzrGPTwQeE4b7uanJf0TBoLMnyNxn/L Q==;
X-CSE-ConnectionGUID: 69Bth53hT9SpzzubEOF/mQ==
X-CSE-MsgGUID: 1BjVS3QASXyc4TrR2z8sFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28459077"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="28459077"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:06:00 -0700
X-CSE-ConnectionGUID: HH1ozYrAT/K/JNrosq32bA==
X-CSE-MsgGUID: biltzn6TRwSMADfEGrRK+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="79702173"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa006.jf.intel.com with ESMTP; 21 Oct 2024 07:05:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 4B87D299; Mon, 21 Oct 2024 17:05:49 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>,
	u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] efi_loader: Mark a function static
Date: Mon, 21 Oct 2024 17:05:46 +0300
Message-ID: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

efi_bootmgr_release_uridp_resource() is not used anywhere except
the same file where it is defined. Mark it static.
This helps avoiding the compiler warning:

  lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous prototype for ‘efi_bootmgr_release_uridp_resource’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/efi_loader/efi_bootmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 589d3996b680..79144962cd73 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -385,7 +385,7 @@ err:
  * @ctx:	event context
  * Return:	status code
  */
-efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *ctx)
+static efi_status_t efi_bootmgr_release_uridp_resource(struct uridp_context *ctx)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac

