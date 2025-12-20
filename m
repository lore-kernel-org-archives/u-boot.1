Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5808E6689E
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 08:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB39280325;
	Sat, 20 Dec 2025 09:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Z8AcKAR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02687803F5; Sat, 20 Dec 2025 09:33:51 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE43580050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 09:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3A3FE403D0; 
 Sat, 20 Dec 2025 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766219628;
 bh=cEUxOKaKGDPCHMLNzYUCwvavdWJdNNI8/WXv4pQsJiA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Z8AcKAR0lS/oJrlQFmnmIjDcB9IfABz9shNyCbTqsc2+1qRhZO8/1plpMME+Tkyl5
 bIzxl0YBPXjbhkgPXYD4xC1IusJlJPLWi2Zei0PBiXms6BgvxkJaN9Z35OrJB4nBPv
 7X9/vKRqYga2qiOBSvW5tlvvca0tQGKH2Sby2OWtsiQFDinOtRYQBq2EeTzyVRumEo
 4JxpawPEHTQO3oUC74/vn4wBWMbbTNqsUDGYqBPin3TtQLzN4KaloQWl5djgmRsX3o
 MCTcklMEYr98zuQHSaNRgDHb/g1tVHRovLzFVeMvN6zHtDXX9SVpiv2Ti9SQP3vNxg
 BYRSmk+DO9GvRawnvmbTJxY6m7jtdc9+zSGutkyoPpR6IIG0V7XGERKHay9ItGpXTg
 tnzL11iIOFaaoVfWmw5GSli1Jq8Ha2ifbv0jVqIaNNpRnWG7Ut2lpbgKw2Fuc85knU
 qeIzFIFFCnZUh1WlT+tUAAc2IBw0AACpjHHesiZGk8iGX4FP8dpRXzqEAGHeG9htnI
 aZnJMt9HycqfT3L5++mIydw2KqBidyFJR9/0HL7MUIL1+eSrthi3qPvyyK9yEbHCrZ
 +99aXpvnj9etjMYW4fPm4EP8q9vooS3+/MJi3C7R5DMDgC1jitdu0OgVlfUDQzr7+z
 CekK8geUqAZud7caDxQzMMQM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb: always enforce CONFIG_LMB
Date: Sat, 20 Dec 2025 09:33:43 +0100
Message-ID: <20251220083343.10060-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

We don't have any platforms left that build without LMB.
Configuring something useful without LMB is difficult.

Always enforce CONFIG_LMB=y.
Move selecting CONFIG_ARCH_MISC_INIT to the `config PPC` definition.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig | 1 +
 lib/Kconfig  | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4af0da2485f..4b243eb969d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -155,6 +155,7 @@ config PPC
 	select SUPPORT_OF_CONTROL
 	select SYS_BOOT_GET_CMDLINE
 	select SYS_BOOT_GET_KBD
+	select ARCH_MISC_INIT if LMB
 
 config RISCV
 	bool "RISC-V architecture"
diff --git a/lib/Kconfig b/lib/Kconfig
index fe0b878a206..f30dfa1748f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1239,10 +1239,8 @@ config LIB_ELF
 	  This supports for 32 bit and 64 bit versions.
 
 config LMB
-	bool "Enable the logical memory blocks library (lmb)"
-	default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
-		     NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
-	select ARCH_MISC_INIT if PPC
+	bool
+	default y
 	help
 	  Support the library logical memory blocks. This will require
 	  a malloc() implementation for defining the data structures
-- 
2.51.0

