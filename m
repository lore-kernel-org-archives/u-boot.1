Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D10BCFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5FC88CBD;
	Sat,  5 Oct 2024 21:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="egIJjePP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E757988A1B; Sat,  5 Oct 2024 21:14:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A8088A24
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155643; x=1759691643;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hwjHDzEKF7V4yV6AhPlPignXsRC3bIJp6I8JjXAybEo=;
 b=egIJjePPtY5uIM7YjmuHiR9hU7fhyeFuOs2THmFzQiaCfMXnzchQxaGj
 CAXzmoSHa9VJAo1uAcN3BTj4dunyKtUkfHEMuY6Be5xVuBYEuN6WBEDI/
 uVfZpdDhWLJF/pmkk8VxLWqdpBnISUxDHMCWwDEPOiOwtJ+z1Kfh07HLZ
 v6VJVKTw34fQWSIe778wTHwITE4ns1963d+BI8uPscD0RCEKEfnPFJYo1
 B0+bh5I0t6R8o1baiSg0iFTpW+ayu98hGoK5GHOnjBeoanjmKE/dWFlHV
 ysJIzuOdDzpEy7OY+sojbmSwxhWzVshc5TpDerXRYsjV/NgsD5IN3B3D1 A==;
X-CSE-ConnectionGUID: 2VPGnKeaRwO86D4dsAA/Ow==
X-CSE-MsgGUID: V6qTB/LQReaqmOi7kb2gGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="38742273"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="38742273"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:13:59 -0700
X-CSE-ConnectionGUID: MnM9nbsZR9O1YXV3SqAsqA==
X-CSE-MsgGUID: gvS7giIjQoqhfRs9FF0ZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="79813923"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa005.jf.intel.com with ESMTP; 05 Oct 2024 12:13:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 270583A6; Sat, 05 Oct 2024 22:13:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 4/4] x86: cpu: Add missing header inclusion
Date: Sat,  5 Oct 2024 22:12:00 +0300
Message-ID: <20241005191353.1927660-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
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

Without asm/cpu_x86.h inclusion a compiler is not happy:

  arch/x86/cpu/cpu_x86.c:14:5: warning: no previous prototype for ‘cpu_x86_bind’ [-Wmissing-prototypes]
  arch/x86/cpu/cpu_x86.c:29:5: warning: no previous prototype for ‘cpu_x86_get_vendor’ [-Wmissing-prototypes]
  arch/x86/cpu/cpu_x86.c:41:5: warning: no previous prototype for ‘cpu_x86_get_desc’ [-Wmissing-prototypes]
  arch/x86/cpu/cpu_x86.c:55:5: warning: no previous prototype for ‘cpu_x86_get_count’ [-Wmissing-prototypes]

Add missing header inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/cpu/cpu_x86.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/cpu/cpu_x86.c b/arch/x86/cpu/cpu_x86.c
index 6c53f0ea821f..6c32ae499df3 100644
--- a/arch/x86/cpu/cpu_x86.c
+++ b/arch/x86/cpu/cpu_x86.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <asm/cpu.h>
+#include <asm/cpu_x86.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
-- 
2.43.0.rc1.1336.g36b5255a03ac

