Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDDFE6ADE7
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18ED489406;
	Sat, 23 Nov 2024 09:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qGfjHexd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCEB893EB; Sat, 23 Nov 2024 09:48:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74269893E1
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E48313FDC8; 
 Sat, 23 Nov 2024 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351699;
 bh=Hz5D+fLDH7J6POrRqclA5nPQvume809iH6vQ97zlMCo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qGfjHexdDJKpNH5sT+IoyeX1tylPGqMq/WkSVqqUDoCYXYAl66wQmCGx/MY77LLw7
 Lg0qgWy5ePus2bphJZBH1Jp9g+feA+/yIIUwDYoZVLs8wmXtSIOg2zJKw7o4mnFN7S
 Y6DmAnFwjMo84twA1K/ewQmmCCJckM/ronCTLoRxobVYsjwhj/pqYqnzpuh3jtVQgC
 puijV5OsWCUcECo1rlLpcrDXd6lW57o0W3dNqmQVGyIp/UUAovBAjWUE03Zdy3gwG3
 Av0S0ii2pJr6rjsOjTmIrc2LbGfV44GS3v/d17Nez0GshhHCnMhyiYqOwfKtiQr05K
 S4uZMIE5LhJmg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] examples: implement _start and syscall for RISC-V
Date: Sat, 23 Nov 2024 09:47:52 +0100
Message-ID: <20241123084754.59182-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
References: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
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

To build the API examples on RISC-V we need to
implement _start and syscall for RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/crt0.S | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S
index f1b88ed8a3d..d2a97557817 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -80,6 +80,38 @@ syscall:
 return_addr:
 	.align 8
 	.long 0
+#elif defined(CONFIG_ARCH_RV32I)
+
+	.text
+	.globl _start
+_start:
+	la	t0, search_hint
+	sw	sp, 0(t0)
+	la	t0, main
+	jalr	x0, t0
+
+	.globl syscall
+syscall:
+	la	t0, syscall_ptr
+	lw	t0, 0(t0)
+	jalr	x0, t0
+
+#elif defined(CONFIG_ARCH_RV64I)
+
+	.text
+	.globl _start
+_start:
+	la	t0, search_hint
+	sd	sp, 0(t0)
+	la	t0, main
+	jalr	x0, t0
+
+	.globl syscall
+syscall:
+	la	t0, syscall_ptr
+	ld	t0, 0(t0)
+	jalr	x0, t0
+
 #else
 #error No support for this arch!
 #endif
-- 
2.45.2

