Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE466C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5F987DF6;
	Mon, 18 Dec 2023 14:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="G0H43pqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E6087682; Mon, 18 Dec 2023 14:52:53 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A0D86FBD
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:52:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 05AA1A0AB8;
 Mon, 18 Dec 2023 14:52:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=tONiAqFGkhdDFiXJp5XANfX9NuMMAJMn8osdGtJGwM0=; b=
 G0H43pqU0FYAkY2UWWWrWgw2cjt0XkKasrUXS+3F86GwwXvRZ3fGr2kc7oVGG4oh
 gGqD+tcJM6kRT90KSnjX7pVUcH2wMlIDUlgyjN4Tf+cQ+lHz8P45NZG4oZK+YW/S
 OU7NGsYn0+yZ19rIHjNUlvi1L70JANFeZP06hel5JGT52kVBucoT1miMVRV5AjxF
 MyRAeX9Z8ptkCzfc0Pf0aEaC1f6rW/KNPckTwrZviK3v5Q15Asbe+HoH2a7xxBY1
 WUg4g4fzJO87lbuHvbm1KNCrat/AmGgEI/O5HScGrig4vnU/BOAm13Y9m7Firzg2
 qyGWJb/0+qaAumhzEeFaPSFaZIK7YMiPTPQwIY+cSnLKWCCOaiR1WrB+C1gpISqg
 GB7Y/WguopIuI/HmvSCYPz9al3mTd/FScqcr4DCfCEE6aN2RaERLZwsxfvTaiMkb
 pK/TtsjwQZ0oQIb9nMl+mieUst2HuKTvzwTjPiynaGOSuYkP5qeffpNiSE37x3uH
 igPSY0I7MfCOrlxvUnRauMK2ptbZIVhDbJwRm/rIoRYwWn8Mk8jvjigCX2c/Dn4g
 GUHexZHAKEra3geSTWogx6IjPenLoY1JUkqX4e3rjQ5+e7ICG+tLVZy8x40On2u4
 M3necWK5cKV3Ep/Na3tujeX/SNMYAhfH1aAbb4DU3dQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
 <csokas.bence@prolan.hu>
Subject: [PATCH] arm: spl: Use separate fault handlers instead of a single
 common one
Date: Mon, 18 Dec 2023 14:52:37 +0100
Message-ID: <20231218135236.12542-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1702907567; VERSION=7966; MC=8498122;
 ID=112695; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE70385C6D7D66
X-Mailman-Approved-At: Mon, 18 Dec 2023 14:55:48 +0100
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

It may be necessary to set breakpoints etc. on a specific fault handler in SPL.
Add a Kconfig option to separate the different handlers into their own individual infinite loops.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---
 arch/arm/Kconfig       |  9 +++++++++
 arch/arm/lib/vectors.S | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 328e2ddc33..a6ddbad30c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -79,6 +79,15 @@ config SPL_SYS_NO_VECTOR_TABLE
 	depends on SPL
 	bool
 
+config SPL_USE_SEPARATE_FAULT_HANDLERS
+	bool "Use separate fault handlers instead of a single common one"
+	depends on !SPL_SYS_NO_VECTOR_TABLE && !ARM64 && !CPU_V7M
+	help
+	  Instead of a common fault handler, generate a separate one for
+	  undefined_instruction, software_interrupt, prefetch_abort etc.
+	  This is for debugging purposes, when you want to set breakpoints
+	  on them separately.
+
 config LINUX_KERNEL_IMAGE_HEADER
 	depends on ARM64
 	bool
diff --git a/arch/arm/lib/vectors.S b/arch/arm/lib/vectors.S
index 7cf7d1636f..a14bca6fb8 100644
--- a/arch/arm/lib/vectors.S
+++ b/arch/arm/lib/vectors.S
@@ -138,11 +138,29 @@ _fiq:			.word fiq
 #if !CONFIG_IS_ENABLED(SYS_NO_VECTOR_TABLE)
 	.align	5
 undefined_instruction:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	undefined_instruction
+#endif
 software_interrupt:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	software_interrupt
+#endif
 prefetch_abort:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	prefetch_abort
+#endif
 data_abort:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	data_abort
+#endif
 not_used:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	not_used
+#endif
 irq:
+#if CONFIG_IS_ENABLED(USE_SEPARATE_FAULT_HANDLERS)
+	b	irq
+#endif
 fiq:
 1:
 	b	1b			/* hang and never return */
-- 
2.25.1


