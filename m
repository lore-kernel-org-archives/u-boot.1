Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB54C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1893287B4E;
	Thu, 14 Dec 2023 17:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="avcBuVg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D1187ABC; Thu, 14 Dec 2023 17:30:24 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7EF87505
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D1B1AA0B08;
 Thu, 14 Dec 2023 17:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=mail; bh=4IQL+oF99QSuhsVcPvJ46e9KNRvpjVmRySWXpxuCHNs=; b=
 avcBuVg35Qn8KZmPdN8G5S+dgDbVJulvLr+ZqKmzLwkXdxU5LcXszLctrTkrLBr6
 OJ5ib9NftX2LAwheOYNkUN39lAAkKz5n9UF+ckb/iygYPcE8oUY4QthhWhtdk7EO
 /Keiw7XYW28s/2K5MTxGrzT/9DaHhVfgWZgCRlhC4Fyc6aUasY2gEMCYJW7d24fZ
 EiIzsjbouUiEGXC9Vd64oBZpHU/Oadnwy0IoM7yM4tIKQ1UqppTqHjiynbucGUO6
 UPyAlzHJwMd6fbIJNbGF2i1nSCFqs5cFfAhDEmAOc7QK5KpUBvqvhE+2a6Cf6qwM
 VCUvOR/h5wRQ/aAXpDBhWBtXKcFb1AA7k+j0Dw5XrojQYjK80MoNfEEEwaSc3kRZ
 dzE5IOqTAoPe99Y5KqVaJe7N72hpDXbUf03Z7yvuARvUEF5rymRRKUkc34qn8+0D
 uKbWJXnzhag2DC22WH+JJPormcHNwX5NVMoMDElDzGSeqM6qn/Roxr4+nyt3B92c
 h1hlKxz+jpdZD9pI281CKuZMovp3iMiPeNzOgynv9FNkqkotenF+rBrO5LLrscpk
 t7q3XKnL7ZyN/s4zovS5iwDVitz1a3pt2L/cIB+RhwucsSUGaM6lXzQrfpJVSM8O
 A8FQLDmL2I6EzWTs/7Eidqnhxt8vyUafHkKrUqrcdzs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
 <csokas.bence@prolan.hu>
Subject: [PATCH] arm: spl: Use separate fault handlers instead of a single
 common one
Date: Thu, 14 Dec 2023 17:29:31 +0100
Message-ID: <20231214162931.34236-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK; S=0; OP=CALC; TIME=1702571420; VERSION=7966; MC=3290524803;
 ID=81617; TRN=0; CRV=0; IPC=; SP=0; SIPS=0; PI=3; F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D385C6D7166
X-Mailman-Approved-At: Thu, 14 Dec 2023 17:52:15 +0100
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
 arch/arm/Kconfig       | 10 ++++++++++
 arch/arm/lib/vectors.S | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 328e2ddc33..47494cb72b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -79,6 +79,16 @@ config SPL_SYS_NO_VECTOR_TABLE
 	depends on SPL
 	bool
 
+config SPL_USE_SEPARATE_FAULT_HANDLERS
+	bool "Use separate fault handlers instead of a single common one"
+	depends on !SPL_SYS_NO_VECTOR_TABLE
+	default n
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


