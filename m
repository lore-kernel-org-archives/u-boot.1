Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919C5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 03:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5DB886A6;
	Fri, 19 Apr 2024 05:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713499191;
	bh=AFQVp/crksix6jv0cPvhRnA0FzSOunsA2Y2Fhs1IAbo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YXdQbHJyMM5x7bGZeZVAWawJckZ5pBSfAt/7T8NcU8gsIZV39tNX5nvOIJlKhWTVs
	 Mb8FWehowXUrGRfGAjKD39nqAycp0+G7zF9PmpuSTryrgNSv5+EtvY/kmD/bcDSi2N
	 ParAPoRcriPcIEL8o9NRF3hBz+pC/Q4VAgB1JEb8h/ENLN4oGcqpvFolKQsJSd1BiE
	 qGOJy19tX/ZLi4WI99+JVMbd1MjuDlek7OZwJUDsJvrkX7ntQlR//I+Gu1X/zvqYA+
	 ryxPqesjkchdnczLsJr4ixXMmBDkPUeYb5wX2HmnAzgDJuKntZTF5fG/j1n94bkglj
	 GXXEhVlwczpqw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E5C888837D;
 Fri, 19 Apr 2024 05:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713499190;
 bh=AFQVp/crksix6jv0cPvhRnA0FzSOunsA2Y2Fhs1IAbo=;
 h=From:To:Cc:Subject:Date:From;
 b=QbWf/6//6DoM1FXLLEh6kee2mqJs1BGBb9FTGYM3nKseun8Zzb65pKQ8NWv7VEVqO
 iTUYIeuBHB6kaeBGTHMLnuNNfKTDj0tJJhwfrKIlcvJj9NrsxMgqpKQduzLRUEN208
 cN+uuMWVwzybK2g07ChOEWIkb0Tdaiifr5CI40+5tUaQ/f++uVUXNRaRDFeusEybag
 VAF3ncC30i9VrFUVHFVa1ElTrEJP6+mJc5rHegEvKKGDKtjfBfnupeWcS6VO9NsnM0
 LI186NjbdsqarEpoyucDkszuDeIlOh77kV9ux8q+UtLNm4jji5guM3S5MOvGBTcaZD
 lNBQNibkfQyPA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3] ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on
 STM32MP15xx
Date: Fri, 19 Apr 2024 05:59:05 +0200
Message-ID: <20240419035931.178840-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

In case of an OTP-CLOSED STM32MP15xx system, the CPU core 1 cannot be
released from endless loop in BootROM only by populating TAMP BKPxR 4
and 5 with magic and branch address and sending SGI0 interrupt from
core 0 to core 1 twice. TAMP_SMCR BKP..PROT fields must be initialized
as well to release the core 1 from endless loop during the second SGI0
handling on core 1. Initialize TAMP_SMCR to protect the first 32 backup
registers, the ones which contain the core 1 magic, branch address and
boot information.

This requirement seems to be undocumented, therefore it was necessary
to trace and analyze the STM32MP15xx BootROM using OpenOCD and objdump.
Ultimately, it turns out that a certain BootROM function reads out the
TAMP_SMCR register and tests whether the BKP..PROT fields are non-zero.
If they are zero, the BootROM code again waits for SGI0 using WFI, else
the execution moves forward until it reaches handoff to the TAMP BKPxR 5
branch address.

This fixes CPU core 1 release using U-Boot PSCI implementation on an
OTP-CLOSED system, i.e. system with fuse 0 bit 6 set.

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Fix up the BKPRWD/BKPWD mask typo
V3: - Update the allocation to 0x20/0x20
    - Update commit message
    - Add RB from Patrick
---
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index dd99150fbc2..d75ec99d6a1 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
+#include <linux/bitfield.h>
 
 /* RCC register */
 #define RCC_TZCR		(STM32_RCC_BASE + 0x00)
@@ -41,6 +42,9 @@
 #define TZC_REGION_ID_ACCESS0	(STM32_TZC_BASE + 0x114)
 
 #define TAMP_CR1		(STM32_TAMP_BASE + 0x00)
+#define TAMP_SMCR		(STM32_TAMP_BASE + 0x20)
+#define TAMP_SMCR_BKPRWDPROT	GENMASK(7, 0)
+#define TAMP_SMCR_BKPWDPROT	GENMASK(23, 16)
 
 #define PWR_CR1			(STM32_PWR_BASE + 0x00)
 #define PWR_MCUCR		(STM32_PWR_BASE + 0x14)
@@ -136,6 +140,18 @@ static void security_init(void)
 	 */
 	writel(0x0, TAMP_CR1);
 
+	/*
+	 * TAMP: Configure non-zero secure protection settings. This is
+	 * checked by BootROM function 35ac on OTP-CLOSED device during
+	 * CPU core 1 release from endless loop. If secure protection
+	 * fields are zero, the core 1 is not released from endless
+	 * loop on second SGI0.
+	 */
+	clrsetbits_le32(TAMP_SMCR,
+			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
+			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
+			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
+
 	/* GPIOZ: deactivate the security */
 	writel(BIT(0), RCC_MP_AHB5ENSETR);
 	writel(0x0, GPIOZ_SECCFGR);
-- 
2.43.0

