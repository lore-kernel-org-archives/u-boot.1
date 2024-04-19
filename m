Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66175C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 22:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563BF8861B;
	Sat, 20 Apr 2024 00:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713564230;
	bh=bwL/s5ptFcdr3ehhR4P+83rS3mT4uufOnY6YGs8tudI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NO54Y9nja6frKmQpz7zpypwwc4NV08TZHdRJEXTToCZhCJ+JOw99kEfvE1PBiGQcU
	 aaoy49hjcfItvYh8tLUIMle/PHS2sHNyLn0MWtmlJY2NTIY1eqtVvwXqD2vyyJrPXi
	 ZZvvHQzdVPUGoAEHpQfLy9XKfhOk9IEwsZfqthELM7lc88wIcaBDZTW+/Advs/qJmx
	 1D/WjQme5aduOSDLDxJWOMtdXYUYv1bQ9er3nOUfgia4RIMvBdJCMcMMwezxbWJGXI
	 2iwt/ZvJDTWHKSgQBD0U5B6rKKCf3ANdnENpEUWIBsm1o8fY41LAxckRxA1O/Zm1n+
	 lAPdRclOLFtKg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 096B8884EB;
 Sat, 20 Apr 2024 00:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713564229;
 bh=bwL/s5ptFcdr3ehhR4P+83rS3mT4uufOnY6YGs8tudI=;
 h=From:To:Cc:Subject:Date:From;
 b=T1rUKJE9pztiuPJHEX/daeq3i6ql0MqX3QukXYkf+tk5rO1zEJuUwAoqs73w0BAbZ
 +OqbGH2w0dwwF/tNfTkPw70U8XffGDQeCRyNTUXfSLs34tmt2CIfPkUIMKbZp4unhY
 6tfTi09HSaaIGaVc8/+BiXfg0CQCp9eDdxnpXxmuo/oB8DpamSD1KZr0/TjuJZfSa0
 veVtINwydqblxO8iLlJK4//XQteOok7QYodDC/Tv5c7BirwWc3+u+fgUvqsphxJS5Q
 N+xIZh8Rbrv02VXNmxLu+wDYQcL6yYtZxFmMd9q1wRiIKAgMoo0K7hh8JVcZlGyUaU
 3RX7eqwhBZVlA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Ping IWDG on exit from PSCI suspend code
Date: Sat, 20 Apr 2024 00:03:09 +0200
Message-ID: <20240419220331.277574-1-marex@denx.de>
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

Make sure the OS would not get any spurious IWDG pretimeout IRQ
right after the system wakes up. This may happen in case the SoC
got woken up by another source than the IWDG pretimeout and the
pretimeout IRQ arrived immediately afterward, but too late to be
handled by the suspend main loop. In case either of the IWDG is
enabled, ping it first and then return to the OS.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/psci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
index 4f2379df45f..e99103910d9 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
@@ -808,6 +808,27 @@ void __secure psci_system_suspend(u32 __always_unused function_id,
 	writel(SYSCFG_CMPENR_MPUEN, STM32_SYSCFG_BASE + SYSCFG_CMPENSETR);
 	clrbits_le32(STM32_SYSCFG_BASE + SYSCFG_CMPCR, SYSCFG_CMPCR_SW_CTRL);
 
+	/*
+	 * Make sure the OS would not get any spurious IWDG pretimeout IRQ
+	 * right after the system wakes up. This may happen in case the SoC
+	 * got woken up by another source than the IWDG pretimeout and the
+	 * pretimeout IRQ arrived immediately afterward, but too late to be
+	 * handled by the main loop above. In case either of the IWDG is
+	 * enabled, ping it first and then return to the OS.
+	 */
+
+	/* Ping IWDG1 and ACK pretimer IRQ */
+	if (gic_enabled[4] & BIT(22)) {
+		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG1_BASE + IWDG_KR);
+		writel(IWDG_EWCR_EWIC, STM32_IWDG1_BASE + IWDG_EWCR);
+	}
+
+	/* Ping IWDG2 and ACK pretimer IRQ */
+	if (gic_enabled[4] & BIT(23)) {
+		writel(IWDG_KR_RELOAD_KEY, STM32_IWDG2_BASE + IWDG_KR);
+		writel(IWDG_EWCR_EWIC, STM32_IWDG2_BASE + IWDG_EWCR);
+	}
+
 	/*
 	 * The system has resumed successfully. Rewrite LR register stored
 	 * on stack with 'ep' value, so that on return from this PSCI call,
-- 
2.43.0

