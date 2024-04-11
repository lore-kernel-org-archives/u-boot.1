Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC5ECD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 09:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156AC8824E;
	Thu, 11 Apr 2024 11:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6492F881E7; Thu, 11 Apr 2024 11:30:10 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616018824E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 11:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 43B9U0jB013512
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 17:30:00 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 11 Apr 2024 17:29:56 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <ycliang@andestech.com>, <tim609@andestech.com>, <randolph@andestech.com>, 
 <u-boot@lists.denx.de>
CC: Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH] riscv: andesv5: Set default cache line size to 64-bytes
Date: Thu, 11 Apr 2024 17:29:45 +0800
Message-ID: <20240411092945.777695-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 43B9U0jB013512
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

The instruction and data cache line sizes of Andes core
are 64-byte. Select SYS_CACHE_SHIFT_6 for RISCV_NDS so
the SYS_CACHELINE_SIZE is enabled with a default value.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
 arch/riscv/cpu/andesv5/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/cpu/andesv5/Kconfig b/arch/riscv/cpu/andesv5/Kconfig
index f311291aed..e3efb0de8f 100644
--- a/arch/riscv/cpu/andesv5/Kconfig
+++ b/arch/riscv/cpu/andesv5/Kconfig
@@ -1,6 +1,7 @@
 config RISCV_NDS
 	bool
 	select ARCH_EARLY_INIT_R
+	select SYS_CACHE_SHIFT_6
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.34.1

