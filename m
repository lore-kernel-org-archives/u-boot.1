Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603ABCCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 21:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11886833AD;
	Wed, 22 Oct 2025 23:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="IAnWXB/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CE3832BC; Wed, 22 Oct 2025 23:04:15 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5013780422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 23:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 0E2CC25ECE;
 Wed, 22 Oct 2025 23:04:13 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lzf0M0G0N4oC; Wed, 22 Oct 2025 23:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761167052; bh=BP0hRywDW0dINnhd7pPlJjXGjiia6IX/gzs0xoJHl+c=;
 h=From:Date:Subject:To:Cc;
 b=IAnWXB/iqPfKhYhNM2IlmTVdLkWy8JRA0fAs5TmrB4t/DoPwa8WKBO7aq208iCvaN
 K9fWMoxHayPCHDvPO3grvnAHu0aWRAXNh3QDhFALXfURV1sX0uJM1LCoLhXi8yZ33A
 9M/l58FVdfyyi3vjNVLexsW+f+XkRpLmeGbQGzGHpeKbwRa37/7GyY+z56C8aRj+na
 x4QeOlLJmbSiBy2u36C35fz5Bi0PUhfeyq/0Oca3/5zgpsC/ERivMmoRuQhRnh3fLg
 pFWxiZmyjmSz0BtExtdkImQs1s4vtjIR2aBm+fysrzIq4YlWia8u7Fcm5J8lsBL+aB
 ZH4dp7GTOfCqQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Thu, 23 Oct 2025 02:32:57 +0530
Subject: [PATCH v3] armv8: implement workaround for broken CNTFRQ_EL0 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-armv8-broken-cntfrq-v3-1-e0f68cdd571d@disroot.org>
X-B4-Tracking: v=1; b=H4sIAIBG+WgC/23NTQ7CIBCG4as0rMXwU0BdeQ/jotChJcaiQ0M0T
 e8ubVxo0uX7JfPMRBJggERO1UQQckghDiXkriKub4YOaGhLE8GE4kxI2uA9H6jFeIOBumH0+KR
 KGsmMY7xVmpTLB4IPr1W9XEv3IY0R3+uTzJf16/F608uccmq19Eenj947e25DwhjHfcSOLGIWv
 4rZVkRROLBaOmu1MvCvzPP8AVIYziz+AAAA
X-Change-ID: 20251023-armv8-broken-cntfrq-537307c01d56
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761167049; l=2752;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=BP0hRywDW0dINnhd7pPlJjXGjiia6IX/gzs0xoJHl+c=;
 b=QA54j3ElTANlo/ls9UV8RUmG2nJXL/3m0h+3cRAGdK1boDbT+MH6/GAFJq4lKdCFXqoNPUNE5
 YFXNaVuxWGtDdsJQZPYymTtbgzeYcm6eRSJE4hyMnKSG9pOboM494M5
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Wed, 22 Oct 2025 23:51:38 +0200
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

In devices where the U-Boot is used as a secondary bootloader, we rely
on the device's primary bootloader to implement CNTFRQ_EL0. However,
this reliance may lead to a non-functional timer in broken firmware.

For instance, some versions of Samsung's S-Boot don't implement it. It's
also not possible to set it in the U-Boot, because it's booted in a lower
exception level. CNTFRQ_EL0 is reported to be 0.

Use gd->arch.timer_rate_hz to override the queried value if set. This
setting needs to be done in the board file, preferrably in timer_init().
This feature is present only when the CONFIG_ARMV8_CNTFRQ_BROKEN is
enabled.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- Added back config option for use with timer_rate_hz (Tom Rini)
- Link to v2: https://lore.kernel.org/r/20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org

Changes in v2:
- Switched to using gd->arch.timer_rate_hz instead of a new config
  option (Ahmad Fatoum)
- Link to v1: https://lore.kernel.org/r/20251014-armv8-broken-cntfrq-v1-1-b63f9c69ffcb@disroot.org
---
 arch/arm/cpu/armv8/Kconfig         | 8 ++++++++
 arch/arm/cpu/armv8/generic_timer.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 199335cd6040d30a355a7fd5448a449fa7f550fb..dfc4ce851c3a6e406423412b469164b2e6f7d5f8 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -4,6 +4,14 @@ config CMO_BY_VA_ONLY
 	bool "Force cache maintenance to be exclusively by VA"
 	depends on !SYS_DISABLE_DCACHE_OPS
 
+config ARMV8_CNTFRQ_BROKEN
+	bool "Fix broken ARMv8 generic timer"
+	depends on SYS_ARCH_TIMER
+	help
+	  Say Y here if U-Boot depends on a prior stage bootloader, which
+	  does not set the CNTFRQ_EL0 frequency, and its not possible to
+	  set it from U-Boot either.
+
 config ARMV8_SPL_EXCEPTION_VECTORS
 	bool "Install crash dump exception vectors"
 	depends on SPL
diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..744ab3b91e59703ad83e19459e60a42643eb2e61 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
 unsigned long notrace get_tbclk(void)
 {
 	unsigned long cntfrq;
+
+	if (IS_ENABLED(CONFIG_ARMV8_CNTFRQ_BROKEN) && gd->arch.timer_rate_hz)
+		return gd->arch.timer_rate_hz;
+
 	asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
 	return cntfrq;
 }

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251023-armv8-broken-cntfrq-537307c01d56

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

