Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF5DC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 09:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D3380BAE;
	Tue,  6 May 2025 11:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD1582076; Tue,  6 May 2025 11:24:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B3267800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 11:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384611A2D;
 Tue,  6 May 2025 02:24:17 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EE7C3F5A1;
 Tue,  6 May 2025 02:24:24 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] riscv: set the width of the physical address/size data type
 based on arch
Date: Tue,  6 May 2025 14:54:01 +0530
Message-Id: <20250506092401.646595-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
the width of the phys_{addr,size}_t data types based on the register
size of the architecture.

Currently, even the 32-bit RiscV platforms have a 64-bit
phys_{addr,size}_t data types. This causes issues on the 32-bit
platforms, where the upper 32-bits of the variables of these types
can have junk data, and that can cause all kinds of side-effects.

This was discovered on the qemu Riscv 32-bit platform  when the return
value of an LMB API was checked, and some LMB allocation that ought
not to have failed, was failing. The upper 32-bits of the address
variable contained garbage, resulting in failures.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note:
Although the LMB API cleanup series depends on this patch, I am
sending it separately so that it gets noticed by the RiscV
maintainers. Sometimes a patch may not get the required attention when
sent as part of another seemingly unrelated series.


 arch/riscv/include/asm/types.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/types.h b/arch/riscv/include/asm/types.h
index 49f7a5d6b3a..45d806c83eb 100644
--- a/arch/riscv/include/asm/types.h
+++ b/arch/riscv/include/asm/types.h
@@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
 typedef u32 dma_addr_t;
 #endif
 
-typedef unsigned long long phys_addr_t;
-typedef unsigned long long phys_size_t;
+#ifdef CONFIG_PHYS_64BIT
+typedef u64 phys_addr_t;
+typedef u64 phys_size_t;
+#else
+typedef u32 phys_addr_t;
+typedef u32 phys_size_t;
+#endif
 
 #endif /* __KERNEL__ */
 
-- 
2.34.1

