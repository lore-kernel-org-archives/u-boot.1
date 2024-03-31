Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8422CD1284
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 18:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9477687FA3;
	Sun, 31 Mar 2024 20:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711909334;
	bh=DpScHbl4tuYg7q6NIUnvud+jkVbKAW3Egvpwp4B1zdw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NG4OStZG7Rhp687wYkqDfafkeVX2Rjsv55fM/f6d3WlSEBB0i/QVr43IWWFNtA2Xp
	 7MYPtoInYvXSikU/lF4+5fItH0rgqOEPSRekLNgtabIyfzxNrMNKn2TOZFOqeFzwCa
	 3maqHM2W76sbSrGwc8Hv8xE4ntlGGxe/Sz841/dZKq1ze0u7LqBWy3+H/Uz7LoNU35
	 XOjamYXYAQ9J79d2q/K+kIBhneNPOunm3nfdRCTgK5DGcK3vaSejwlNvm7l5k+G6A5
	 KjZauqDHdaPOB+7RQDjhSGnxVwYsS45OUc78KkuumnrvzEOcXbzRERfarHptRM/CfP
	 0+FrVf2pqvzQQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 725468780A;
 Sun, 31 Mar 2024 20:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711909333;
 bh=DpScHbl4tuYg7q6NIUnvud+jkVbKAW3Egvpwp4B1zdw=;
 h=From:To:Cc:Subject:Date:From;
 b=EvkVkNphTa4vIDNLUma+iRD/YIjerp0Ou//VYK/GQWV5kAlmihrhqXEFtKm/GJqlc
 zWStM1ioY+znmjHUr/cYOOSWCRPUYiESP3Ex1INeUPije3fERmp15se2m/FIeNXgfX
 wHDwCejBWa/SdodRPwQuxb4u413M5xAVhHa8Id/4eAglSylB5VmIr0plkRdgw2rXla
 ciiPoOAqi4nvagqXCtpEhpoXWhY65awhrBJrfwMR7gefh4eDg2xFRIkWMPqn8e5myV
 N6YmYmlR3ukkAsROinAKv7zMWXFhd6OKG7Pr/R+dwlkVZkMJxi6kmSJdXIMvjIt3Z7
 oMT5B9KxfiTcA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Jump to ep on successful resume in PSCI suspend
 code
Date: Sun, 31 Mar 2024 20:21:47 +0200
Message-ID: <20240331182202.335923-1-marex@denx.de>
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
 arch/arm/mach-stm32mp/psci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-stm32mp/psci.c b/arch/arm/mach-stm32mp/psci.c
index 8cdeb0ab3f2..4f2379df45f 100644
--- a/arch/arm/mach-stm32mp/psci.c
+++ b/arch/arm/mach-stm32mp/psci.c
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

