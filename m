Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DEECE8D4C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495CF889C3;
	Thu, 19 Sep 2024 05:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OVY27GSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3563C88FE3; Thu, 19 Sep 2024 05:55:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0173889C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718139; x=1758254139;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dWH5fJ0t+kiDp4pa9iJCA8R1q255KOEO/Ty4YdbmxmY=;
 b=OVY27GSRbx8CI5upEjQXo8IkrB9mIDY1rlJv30gaAhLeiYl2zeSOoNuY
 I6OVIpUdH75PgvVDwP59s6jcc+Lbi+1TVyyBQmxrPOEBkuprTeYQ7D6T2
 t05fIq3SEvGoW8kocohC+TnTZWDdecJdC3NaUkH5lUJPQa5jZ+cF3dquc
 2gmwJ3RzfskEU751sL0rN/Eo89suq8Yl3As4lmhR/nTJ8dNrhg5vy8OIe
 0eDy8cSoXoSYdUZKAmc/bX6v5uRoKqpaIyWajdET0XvSHZqGJpQGMV0OS
 3cV0z90wpMh7CzfkMtbKp5FHBWWU8u09ENmsMVPgra6kAKoDtj5h1BUaC A==;
X-CSE-ConnectionGUID: yiVz07KmQpuMrE0vI9Sl3A==
X-CSE-MsgGUID: UEtfnMZ5SlK1FTvef2Me4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43177964"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43177964"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:38 -0700
X-CSE-ConnectionGUID: 6TGAehuvTPucxM3lCMRN6w==
X-CSE-MsgGUID: NwrkFq2RR5usBo3YqLa9ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253715"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:33 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 03/19] include: asm: Add support to read/write 64-bit
Date: Thu, 19 Sep 2024 11:54:56 +0800
Message-Id: <20240919035512.13854-4-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

The patch is to extend support read and write 64-bits of buffer.
This is required for Cadence NAND Driver to
read/write ONFI parameter page. The parameter page is mapped to 64-bit.
With only read/write 32 bits of buffer,there is an issue of overwriting
last 4 bits of buffer which failed the NAND identification.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
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
2.26.2

