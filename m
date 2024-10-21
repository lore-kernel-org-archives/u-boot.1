Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90354D15D98
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B203188EBB;
	Mon, 21 Oct 2024 16:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZB2Lhx2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC10388EBB; Mon, 21 Oct 2024 16:20:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B7E88E91
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729520447; x=1761056447;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6RJGWMMZMOjBMIWak3QA1IeNq19Yc6qXIuGwOWTDKXk=;
 b=ZB2Lhx2o5iK2KvfziQwS6L7r7EOh5KxbMUfpno/1X8169UgdpJMWvmxG
 PcgACz3Uu9HTbmVCSvAvTqghp2KydwghbhKkIJdUhhov4eBv9LRAc5TO/
 10HQq+TONpoypWwbXu2lU0TkBrAoCFpL9IAfIENXqe6H93ld2xeEh/+bi
 bMkrY6IjDOqyNEUTsTjL2SgwGPSO7Ac1ELZRoouL2fEVZJtIQ69J7WjWl
 c1+X7fNGk4nU2AwCPm8S/QTkg+aN4x21J50t/23chiWHoUd4XyQN48+N9
 mJ/zhxewvhRvhLSrtZoJesyN+177Fd2XowcTunhf2qQBA7c6xLJ9V5n87 A==;
X-CSE-ConnectionGUID: Pi7CnxvBQACtFT6wPlRdrg==
X-CSE-MsgGUID: cJAlX/UVTRKoU++LdMvPlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="29103030"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="29103030"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:20:45 -0700
X-CSE-ConnectionGUID: 00SYpBewRj6R2IcqBaTB8Q==
X-CSE-MsgGUID: GsC2uXrdQRCPB3LsyiBh2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="110297841"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa001.fm.intel.com with ESMTP; 21 Oct 2024 07:20:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 2AC4C1E0; Mon, 21 Oct 2024 17:20:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: Drop superfluous const qualifier
Date: Mon, 21 Oct 2024 17:20:40 +0300
Message-ID: <20241021142040.2981390-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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

The compiler will ignore it anyway:

  include/linux/mtd/mtd.h:342:15: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mtd/mtd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 6751fb52c5a5..3ffcd40807d0 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -339,7 +339,7 @@ static inline void mtd_set_ofnode(struct mtd_info *mtd, ofnode node)
 	dev_set_ofnode(mtd->dev, node);
 }
 
-static inline const ofnode mtd_get_ofnode(struct mtd_info *mtd)
+static inline ofnode mtd_get_ofnode(struct mtd_info *mtd)
 {
 	return dev_ofnode(mtd->dev);
 }
-- 
2.43.0.rc1.1336.g36b5255a03ac

