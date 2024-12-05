Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E96E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EA7892DC;
	Thu,  5 Dec 2024 10:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="j3Y/elfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C600892DC; Thu,  5 Dec 2024 10:23:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D42F89282
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390627; x=1764926627;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HMjdCl6KqZU+h4RiZidYoJs+gfpcQzJR215m4KPhJ5I=;
 b=j3Y/elfcIuJN/8An9V30qk/9UaQEV6d2qDYbwiHlyEClTTRGY6SuDbJe
 3zSCXyABvHpgA9WwptSwFCQfP9BMI+moAdsmqBuELh8o+RrwR0+ugsR4v
 97mqAkduZTpyFAH7myCwqyRs8vDBxA8xPr7PnHFmI5oAU/vq5L5frT34q
 S2yGOqSDsxe64yjpcffZFacYyw4ob9n89AyWNGd4IX50tt+b9eZuLaigr
 eO6R86CxgGovC7GbUjnwG72Kg0M4OJBcov7d7cPxJUvtFON51c7BFhmC3
 KCX4piGeFRK5lG2vQgYGVOt38iA6cs2ZFUtp2vwiXYEc9jmX3kcjrgM0U A==;
X-CSE-ConnectionGUID: henc+JhXQtWpX4Rt805bPQ==
X-CSE-MsgGUID: A71gJpYSQ+OPefYc8K60Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610162"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610162"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:23:46 -0800
X-CSE-ConnectionGUID: CvyyyAbITdya6diRFBH53Q==
X-CSE-MsgGUID: /vhFeQZYTxWBPtZJZDjdjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121809"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:23:42 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v2 03/19] include: asm: Add support to read/write 64-bit
Date: Thu,  5 Dec 2024 17:22:59 +0800
Message-Id: <20241205092315.25060-4-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Extend support read and write 64-bits of buffer.
This is required for Cadence NAND Driver to
read/write ONFI parameter page. The parameter page is mapped to 64-bit.
With only read/write 32 bits of buffer,there is an issue of overwriting
last 4 bits of buffer which failed the NAND identification.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 arch/arm/include/asm/io.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 89b1015bc4..e3ea5f0eb2 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -391,6 +391,31 @@ void __memset_io(volatile void __iomem *dst, int c, size_t count)
 		count--;
 	}
 }
+
+static inline void readsq(const void __iomem *addr, void *buffer,
+			  unsigned int count)
+{
+	if (count) {
+		u64 *buf = buffer;
+
+		do {
+			u64 x = __raw_readq(addr);
+			*buf++ = x;
+		} while (--count);
+	}
+}
+
+static inline void writesq(void __iomem *addr, const void *buffer,
+			   unsigned int count)
+{
+	if (count) {
+		const u64 *buf = buffer;
+
+		do {
+			__raw_writeq(*buf++, addr);
+		} while (--count);
+	}
+}
 #endif /* CONFIG_ARM64 */
 
 #ifdef CONFIG_ARM64
-- 
2.19.0

