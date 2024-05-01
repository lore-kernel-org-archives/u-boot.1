Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69319C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4626D88B21;
	Wed,  1 May 2024 10:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3258A88B22; Wed,  1 May 2024 10:17:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 00AFF88B2E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.hoyes@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89C8C339;
 Wed,  1 May 2024 01:17:26 -0700 (PDT)
Received: from e133390.cambridge.arm.com (unknown [10.1.198.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6D73F793;
 Wed,  1 May 2024 01:16:58 -0700 (PDT)
From: Peter Hoyes <peter.hoyes@arm.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com,
 quentin.schulz@theobroma-systems.com, Peter Hoyes <Peter.Hoyes@arm.com>
Subject: [PATCH v2 2/2] armv8: generic_timer: Use event stream for udelay
Date: Wed,  1 May 2024 09:16:33 +0100
Message-Id: <20240501081633.120913-3-peter.hoyes@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501081633.120913-1-peter.hoyes@arm.com>
References: <20240501081633.120913-1-peter.hoyes@arm.com>
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

From: Peter Hoyes <Peter.Hoyes@arm.com>

Polling cntpct_el0 in a tight loop for delays is inefficient.
This is particularly apparent on Arm FVPs, which do not simulate
real time, meaning that a 1s sleep can take a couple of orders
of magnitude longer to execute in wall time.

If running at EL2 or above (where CNTHCTL_EL2 is available), enable
the cntpct_el0 event stream temporarily and use wfe to implement
the delay more efficiently. The event period is chosen as a
trade-off between efficiency and the fact that Arm FVPs do not
typically simulate real time.

This is only implemented for Armv8 boards, where an architectural
timer exists, and only enabled by default for the ARCH_VEXPRESS64
board family.

Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>
---
 arch/arm/cpu/armv8/Kconfig         |  8 ++++++++
 arch/arm/cpu/armv8/generic_timer.c | 27 +++++++++++++++++++++++++++
 arch/arm/include/asm/system.h      |  6 ++++--
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 9f0fb369f7..199335cd60 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -191,6 +191,14 @@ config ARMV8_EA_EL3_FIRST
 	  Exception handling at all exception levels for External Abort and
 	  SError interrupt exception are taken in EL3.
 
+config ARMV8_UDELAY_EVENT_STREAM
+	bool "Use the event stream for udelay"
+	default y if ARCH_VEXPRESS64
+	help
+	  Use the event stream provided by the AArch64 architectural timer for
+	  delays. This is more efficient than the default polling
+	  implementation.
+
 menuconfig ARMV8_CRYPTO
 	bool "ARM64 Accelerated Cryptographic Algorithms"
 
diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 8f83372cbc..e18b5c8187 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -115,3 +115,30 @@ ulong timer_get_boot_us(void)
 
 	return val / get_tbclk();
 }
+
+#if CONFIG_IS_ENABLED(ARMV8_UDELAY_EVENT_STREAM)
+void __udelay(unsigned long usec)
+{
+	u64 target = get_ticks() + usec_to_tick(usec);
+
+	/* At EL2 or above, use the event stream to avoid polling CNTPCT_EL0 so often */
+	if (current_el() >= 2) {
+		u32 cnthctl_val;
+		const u8 event_period = 0x7;
+
+		asm volatile("mrs %0, cnthctl_el2" : "=r" (cnthctl_val));
+		asm volatile("msr cnthctl_el2, %0" : : "r"
+			(cnthctl_val | CNTHCTL_EL2_EVNT_EN | CNTHCTL_EL2_EVNT_I(event_period)));
+
+		while (get_ticks() + (1ULL << event_period) <= target)
+			wfe();
+
+		/* Reset the event stream */
+		asm volatile("msr cnthctl_el2, %0" : : "r" (cnthctl_val));
+	}
+
+	/* Fall back to polling CNTPCT_EL0 */
+	while (get_ticks() <= target)
+		;
+}
+#endif
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 51123c2968..7e30cac32a 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -69,8 +69,10 @@
 /*
  * CNTHCTL_EL2 bits definitions
  */
-#define CNTHCTL_EL2_EL1PCEN_EN	(1 << 1)  /* Physical timer regs accessible   */
-#define CNTHCTL_EL2_EL1PCTEN_EN	(1 << 0)  /* Physical counter accessible      */
+#define CNTHCTL_EL2_EVNT_EN	BIT(2)	     /* Enable the event stream       */
+#define CNTHCTL_EL2_EVNT_I(val)	((val) << 4) /* Event stream trigger bits     */
+#define CNTHCTL_EL2_EL1PCEN_EN	(1 << 1)     /* Physical timer regs accessible */
+#define CNTHCTL_EL2_EL1PCTEN_EN	(1 << 0)     /* Physical counter accessible   */
 
 /*
  * HCR_EL2 bits definitions
-- 
2.34.1

