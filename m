Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D38CD1292
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 20:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA76C87F07;
	Sun,  7 Apr 2024 22:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712521295;
	bh=oXTJeLM/cLp+5fa3J2+NG/lpfLHd8xfKgLjgwqnGKp8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s5hpdYFifkTtLymrc1GCKtORPH57aXS7hDSYnvfN73igb8RdQKaPtwb/RgNqG7GIW
	 /4u654neB98ke4CqXaPm8GrW/ENCocX8kME1j9ztzyKKcNJ16ixRSNgirTsL6SHtYt
	 VvAry3SgH+niJhmUOOCLCXECVY+nTrnfE6pJIYIgvXZSQpIwAR+SHnYEsxXpIywjPI
	 VGYjcJtXOpa1q3tNDJtl0u447wN4iTis1yAv/rTKm2FKcqToHDvmltBJsZy/FWFlDy
	 o7ud2quEzPJ/MJYFV/V5YQZxv9DhQHeFKhTNHlxPRfWkdOs6WJDTFL4/lI05wGc7v/
	 I6aMm9/W/Y5ig==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8AEDD87DAB;
 Sun,  7 Apr 2024 22:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712521292;
 bh=oXTJeLM/cLp+5fa3J2+NG/lpfLHd8xfKgLjgwqnGKp8=;
 h=From:To:Cc:Subject:Date:From;
 b=GFU5gE7q6yXrOxoclnCgyhI/HFhsP0pH/UdVp6zSv0u2EOhIVxF2gFgPAJHw+XmKP
 LZ3fO5K/ZSkG5j32cSyMIQLz4G5pz/mRhQ+xTBg/xXvEJkFNhFagPSHpyN7bgekC7K
 CsR84uA1PnQeK0jz/4TW/nfPDM2+DqPuq3hlY6UoyekZ8qAzxv0MW1tJHJksdvc5eN
 DvFBv6NzGYPqvijRLtLI2UKElJYdUinlqfCyZCzuXM/veML7gG3XjfXe177jPrcluE
 hHJn0EQogJuP1Ywm+PWE2jhLf2V33w54HVamRavPqU74k55+ihkWHgGxZBKIviILvY
 GGib0d/sh2/Dw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] ARM: stm32: Jump to ep on successful resume in PSCI
 suspend code
Date: Sun,  7 Apr 2024 22:21:07 +0200
Message-ID: <20240407202118.51854-1-marex@denx.de>
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

In case the system has resumed successfully, the PSCI suspend resume
code has to jump to the 'ep' successful resume entry point code path,
otherwise the code has to jump to content of the LR register, which
points to failed resume code path.

To implement this distinction, rewrite LR register stored on stack
with 'ep' value in case of a successful resume, which is really in
every case unless some catastrophic failure occurred during suspend.

Without this change, Linux counts every resume as failed in
/sys/power/suspend_stats/fail

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
V2: Rebase on u-boot/master
---
 arch/arm/mach-stm32mp/stm32mp1/psci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
index 8cdeb0ab3f2..4f2379df45f 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
@@ -703,6 +703,8 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
 {
 	u32 saved_mcudivr, saved_pll3cr, saved_pll4cr, saved_mssckselr;
 	u32 gicd_addr = stm32mp_get_gicd_base_address();
+	u32 cpu = psci_get_cpu_id();
+	u32 sp = (u32)__secure_stack_end - (cpu << ARM_PSCI_STACK_SHIFT);
 	bool iwdg1_wake = false;
 	bool iwdg2_wake = false;
 	bool other_wake = false;
@@ -805,4 +807,16 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
 
 	writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR);
 	clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CTRL);
+
+	/*
+	 * The system has resumed successfully. Rewrite LR register stored
+	 * on stack with 'ep' value, so that on return from this PSCI call,
+	 * the code would jump to that 'ep' resume entry point code path
+	 * instead of the previous 'lr' register content which (e.g. with
+	 * Linux) points to resume failure code path.
+	 *
+	 * See arch/arm/cpu/armv7/psci.S _smc_psci: for the stack layout
+	 * used here, SP-4 is PC, SP-8 is LR, SP-12 is R7, and so on.
+	 */
+	writel(ep, sp - 8);
 }
-- 
2.43.0

