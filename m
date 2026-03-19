Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A4B1075276
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D0B83F2D;
	Thu, 19 Mar 2026 09:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A878283FA4; Thu, 19 Mar 2026 09:30:37 +0100 (CET)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BB883F2D
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8Tte2014940;
 Thu, 19 Mar 2026 16:29:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:29:55 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 2/6] riscv: Extend noncached memory support to RISC-V
Date: Thu, 19 Mar 2026 16:29:47 +0800
Message-ID: <20260319082951.3310908-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319082951.3310908-1-ycliang@andestech.com>
References: <20260319082951.3310908-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8Tte2014940
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

Extend the SYS_HAS_NONCACHED_MEMORY Kconfig to support RISC-V
in addition to ARM and MIPS, and add FTMAC100 to the list of
drivers that benefit from noncached memory.

The ftmac100 DMA descriptors needs to be marked uncacheable
to stay coherent for SW and HW on noncoherent platforms.

Also add MMU_SECTION_SIZE definition (1MB) to the RISC-V system
header, matching the MIPS convention used by the noncached memory
infrastructure.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/Kconfig                    | 2 +-
 arch/riscv/include/asm/system.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index fb3e8d598e7..b05f249b661 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -529,7 +529,7 @@ endmenu
 
 config SYS_HAS_NONCACHED_MEMORY
 	bool "Enable reserving a non-cached memory area for drivers"
-	depends on (ARM || MIPS) && (RTL8169 || MEDIATEK_ETH)
+	depends on (ARM || MIPS || RISCV) && (RTL8169 || MEDIATEK_ETH || FTMAC100)
 	help
 	  This is useful for drivers that would otherwise require a lot of
 	  explicit cache maintenance. For some drivers it's also impossible to
diff --git a/arch/riscv/include/asm/system.h b/arch/riscv/include/asm/system.h
index 87a804bfd5f..b71bbeef1e2 100644
--- a/arch/riscv/include/asm/system.h
+++ b/arch/riscv/include/asm/system.h
@@ -25,6 +25,12 @@ struct event;
         csr_set(CSR_SSTATUS, __flags & SR_SIE); \
     } while (0)
 
+#ifdef CONFIG_SYS_NONCACHED_MEMORY
+/* 1MB granularity */
+#define MMU_SECTION_SHIFT	20
+#define MMU_SECTION_SIZE	BIT(MMU_SECTION_SHIFT)
+#endif /* CONFIG_SYS_NONCACHED_MEMORY */
+
 /* Hook to set up the CPU (called from SPL too) */
 int riscv_cpu_setup(void);
 
-- 
2.34.1

