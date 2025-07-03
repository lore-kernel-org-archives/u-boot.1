Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CADC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 05:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84F682A76;
	Thu,  3 Jul 2025 07:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EKU8gNVU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA9182F6D; Thu,  3 Jul 2025 07:20:17 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0603282F08
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 07:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2A19640B5F; 
 Thu,  3 Jul 2025 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751520006;
 bh=thztEdt54at96yZDDThnPGLoLN0dwqVyMdLNRm2al5s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=EKU8gNVU2S+w4ayDsigUZreWGT7POY/od7bbPxuNTSqG0QlVe9Xi74up6o2Xfu0kp
 70OhC8kJat3qxAaNtbi40QKwQT4uiTrJDwA3EGmswJ5lOERcOU/zukM6qR6k0cE3UF
 jNI7YWtRisTKafIB3GbmuLr1UEBx1zPr3dWry4jWXqxWeDv6c3FLkAJbAPLHQF6kJD
 vjxnEHhXwwVyYJHS3pk+uErEM0+DReKfxcvwpJ/rpVhbOlrbpP6LsyU/BrKAu2VDJU
 Kekp6ZeBKpjlskvdCVFBXUIpRLuZ2GFEDauwZTrYjS6IPsxtr5FVq0D83bPk2v4czB
 z/RKJda+182Vw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/5] Kconfig: make CONFIG_FRAMEPOINTER available on arm64
Date: Thu,  3 Jul 2025 07:19:50 +0200
Message-ID: <20250703051951.43372-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
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

Move the frame pointer configuration to the generic setup section as it is
applicable for multiple architectures (RISC-V, arm64).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 Kconfig            | 25 +++++++++++++++++++++++++
 arch/riscv/Kconfig | 21 ---------------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/Kconfig b/Kconfig
index 05b7f410fa5..99b1596b843 100644
--- a/Kconfig
+++ b/Kconfig
@@ -165,6 +165,31 @@ config CC_COVERAGE
 	  Enabling this option will pass "--coverage" to gcc to compile
 	  and link code instrumented for coverage analysis.
 
+if ARM64 || RISCV
+
+config FRAMEPOINTER
+	bool "Build with frame pointer for stack unwinding"
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
+config SPL_FRAMEPOINTER
+	bool "Build SPL with frame pointer for stack unwinding"
+	depends on SPL
+	help
+	  Choose this option to use the frame pointer so the stack can be
+	  unwound if needed. This is useful for tracing where faults came
+	  from as the source may be several functions back
+
+	  If you say Y here, then the code size will be increased due to
+	  having to store the fp.
+
+endif
+
 config ASAN
 	bool "Enable AddressSanitizer"
 	depends on SANDBOX
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c6feae5735..f60ad5e9ace 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -150,27 +150,6 @@ config ARCH_RV64I
 
 endchoice
 
-config FRAMEPOINTER
-	bool "Build with frame pointer for stack unwinding"
-	help
-	  Choose this option to use the frame pointer so the stack can be
-	  unwound if needed. This is useful for tracing where faults came
-	  from as the source may be several functions back
-
-	  If you say Y here, then the code size will be increased due to
-	  having to store the fp.
-
-config SPL_FRAMEPOINTER
-	bool "Build SPL with frame pointer for stack unwinding"
-	depends on SPL
-	help
-	  Choose this option to use the frame pointer so the stack can be
-	  unwound if needed. This is useful for tracing where faults came
-	  from as the source may be several functions back
-
-	  If you say Y here, then the code size will be increased due to
-	  having to store the fp.
-
 choice
 	prompt "Code Model"
 	default CMODEL_MEDLOW
-- 
2.48.1

