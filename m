Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A60CCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 07:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49C0807B1;
	Tue, 14 Oct 2025 09:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QeNhgbJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC38809A5; Tue, 14 Oct 2025 09:22:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE3080422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 09:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6DF17260B4;
 Tue, 14 Oct 2025 09:22:21 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySDQ4ZysZz7s; Tue, 14 Oct 2025 09:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760426540; bh=Y3JWWvjj43z9zBQuj3qzmimPSH6gzgRvSxgpeKrkKyU=;
 h=From:Date:Subject:To:Cc;
 b=QeNhgbJmcVniD/av7G3+WHJEQ8WG9h1P8KpT/hEpYvYQubDm23I30HH85gTrChsTK
 oOBsmMCXjB68Sc90XD9klzSjIHK1MlY4n3uRyvOqQn7u8jEcGLqkqr594Re25/+Bdh
 5YajsnJJtymFbCkem5HeiWQ6uIgkG1CaORpyhkqPl7HQJO+4Jw0ePsWLWWaQWMpAi5
 NuqV75CPWLhTGBz59CbAvCVvyQ8ZjO3pps7imLTgjCYuadGNPHThewqiEK5hfiYBGE
 S7lLy5kqSrmmoFaGtnx+h3iqA3NiHM+Y0dJ/RWmrnLIa9vBCfKr480QVcR5niZ8hyR
 XJOAhyIcT4jTQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 14 Oct 2025 12:52:10 +0530
Subject: [PATCH] armv8: implement workaround for broken CNTFRQ_EL0 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-armv8-broken-cntfrq-v1-1-b63f9c69ffcb@disroot.org>
X-B4-Tracking: v=1; b=H4sIACH67WgC/x3M3QpAQBBA4VfRXJva9Ze8ilwsZphkMSspeXeby
 +/inAcCqVCAJnlA6ZIgm4+waQLD7PxEKGM0ZCYrrbEFOl2vGnvdFvI4+JP1QM5Lw1XNPVcEsdy
 VWO7/2nbv+wH/h77uZQAAAA==
X-Change-ID: 20251014-armv8-broken-cntfrq-f350f68fbf6e
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760426538; l=2327;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=Y3JWWvjj43z9zBQuj3qzmimPSH6gzgRvSxgpeKrkKyU=;
 b=c8BIa1ALfXwTQ0mO2uf+yiF2k1wDLBOs3xDq9Lk3gifQ+5B9G4a0ybhxTnIXJMez0KvgkF1tu
 xjVaIca9mCtA4YIh/0Byl9PRUMvHu6VXkbjxUXs05Bz6ruwT3citjVA
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:41:06 +0200
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

Thus, the only solution is to add a config option which, when enabled,
returns a hard coded value (CONFIG_COUNTER_FREQUENCY) instead of querying
CNTFRQ_EL0.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/cpu/armv8/Kconfig         | 9 +++++++++
 arch/arm/cpu/armv8/generic_timer.c | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 199335cd6040d30a355a7fd5448a449fa7f550fb..d54d874b7caea200e1c05f522d8affe6d239a102 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -4,6 +4,15 @@ config CMO_BY_VA_ONLY
 	bool "Force cache maintenance to be exclusively by VA"
 	depends on !SYS_DISABLE_DCACHE_OPS
 
+config ARMV8_CNTFRQ_BROKEN
+	bool "Fix broken ARMv8 generic timer"
+	depends on COUNTER_FREQUENCY > 0
+	depends on SYS_ARCH_TIMER
+	help
+	  Say Y here if there is no trustable firmware present which sets
+	  CNTFRQ_EL0 frequency before U-Boot. U-Boot will use the
+	  CONFIG_COUNTER_FREQUENCY value as the reported frequency.
+
 config ARMV8_SPL_EXCEPTION_VECTORS
 	bool "Install crash dump exception vectors"
 	depends on SPL
diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 1de7ec596fc7cbbc3e78a241f163bc0a4fcad6b6..409570cf6fda79527e296b958368b552900524b1 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -19,6 +19,10 @@ DECLARE_GLOBAL_DATA_PTR;
 unsigned long notrace get_tbclk(void)
 {
 	unsigned long cntfrq;
+
+	if (IS_ENABLED(CONFIG_ARMV8_CNTFRQ_BROKEN))
+		return CONFIG_COUNTER_FREQUENCY;
+
 	asm volatile("mrs %0, cntfrq_el0" : "=r" (cntfrq));
 	return cntfrq;
 }

---
base-commit: a5b3be1a37e19646b9d36c91f11b23f568be4f21
change-id: 20251014-armv8-broken-cntfrq-f350f68fbf6e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

