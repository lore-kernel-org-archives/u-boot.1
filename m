Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE9C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43E8888F5;
	Sat, 13 Jul 2024 15:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QpVqPy+x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C/QlvKHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4397D88925; Sat, 13 Jul 2024 15:21:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5663F88905
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyl0yFQz9sZF;
 Sat, 13 Jul 2024 15:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKyrAC6km5ql+3n4gicNwx4eKVe90VyvS1D5dfE2Upk=;
 b=QpVqPy+xFOsJnIjdJis2pit45+GL72L2wkHh/8m5ULFeT7mPGB0R9/4isB0yA2lMiqlAOS
 SxJWbZr7zbprPJxGmVXwJzT4qg/UYNI0pSPvZ6AhzOObRjU5MseAPdyReEBs8UupQXZd7m
 mYDMLgK/apgIB9pyBg8boJbp0fv5Jn+nNXURXwqkm94jjG7T9NUK0jWLCIQBZByzXyf2Az
 XVsWNmg+4/rqfRvRNyZ3LffOa1kWy+z8e+ezOX5mx/IFsrVpwjlaYcq+cd33Jyvo9tZ5pJ
 VJJ0EAQ5tAYfs+K6FcTm/7TaFWS0UaxHTGd+yTPgVU7dpNjmJAkwsqXEwSPTPw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKyrAC6km5ql+3n4gicNwx4eKVe90VyvS1D5dfE2Upk=;
 b=C/QlvKHD2FJuFLf7xB53CnD8Ywf8BCeJVPwQWuUTjA7Ukm1P7tZd1yN16DqMCXp/mZM337
 ElxSUGZZdGaGiNZc/17a9/lv9xm7VszHpJufbnr9IhqxSGK3woDZaZHkoXblWUW/iekdXo
 vYA4Fd1/glF4eEFHh7qak1UdsRMk2vjLWqiDn77hMvOrN2E62vrmT0KxHa+1Bpbd5YJckN
 Stv/sV+bzY8W6S8lsMtMzVBeGKIzqkhV7saKd0nn81wX0/NsMmbVTLgYRUGDxwQkNdZHiK
 q7f6nu12VPFNbD6IBLJbfcPDmScEQIGf8D/TthJdg5XyUDMQ7YpYxoCYuw8txg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 41/45] sh: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:32 +0200
Message-ID: <20240713132021.57650-41-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3190d60d895fb6c597d
X-MBO-RS-META: bou7ei15xhinjwjk6wix3gmactdafwkz
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/sh/include/asm/cpu_sh7722.h  | 1 -
 arch/sh/include/asm/cpu_sh7734.h  | 1 -
 arch/sh/include/asm/cpu_sh7752.h  | 1 -
 arch/sh/include/asm/cpu_sh7753.h  | 1 -
 arch/sh/include/asm/cpu_sh7757.h  | 1 -
 arch/sh/include/asm/posix_types.h | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/sh/include/asm/cpu_sh7722.h b/arch/sh/include/asm/cpu_sh7722.h
index 9f1f6a04741..aae5b371cee 100644
--- a/arch/sh/include/asm/cpu_sh7722.h
+++ b/arch/sh/include/asm/cpu_sh7722.h
@@ -210,7 +210,6 @@
 #define RWTCSR      0xA4520004
 #define WTCNT	RWTCNT
 
-
 /*	TMU	*/
 #define TMU_BASE	0xFFD80000
 
diff --git a/arch/sh/include/asm/cpu_sh7734.h b/arch/sh/include/asm/cpu_sh7734.h
index 546f4fff9b4..22ae884c141 100644
--- a/arch/sh/include/asm/cpu_sh7734.h
+++ b/arch/sh/include/asm/cpu_sh7734.h
@@ -50,5 +50,4 @@
 #define GPSR4	(GPSR0 + 0x10)
 #define GPSR5	(GPSR0 + 0x14)
 
-
 #endif /* _ASM_CPU_SH7734_H_ */
diff --git a/arch/sh/include/asm/cpu_sh7752.h b/arch/sh/include/asm/cpu_sh7752.h
index e024423f25a..f084ed8e34f 100644
--- a/arch/sh/include/asm/cpu_sh7752.h
+++ b/arch/sh/include/asm/cpu_sh7752.h
@@ -66,7 +66,6 @@ struct sermux_regs {
 };
 #define SERMUX_BASE	((struct sermux_regs *)0xfe470000)
 
-
 /* USB0/1 */
 struct usb_common_regs {
 	unsigned short	reserved[129];
diff --git a/arch/sh/include/asm/cpu_sh7753.h b/arch/sh/include/asm/cpu_sh7753.h
index 2f779b137e1..4f25f1dd0dc 100644
--- a/arch/sh/include/asm/cpu_sh7753.h
+++ b/arch/sh/include/asm/cpu_sh7753.h
@@ -66,7 +66,6 @@ struct sermux_regs {
 };
 #define SERMUX_BASE	((struct sermux_regs *)0xfe470000)
 
-
 /* USB0/1 */
 struct usb_common_regs {
 	unsigned short	reserved[129];
diff --git a/arch/sh/include/asm/cpu_sh7757.h b/arch/sh/include/asm/cpu_sh7757.h
index b3aaec2aaa1..c0a8d89c951 100644
--- a/arch/sh/include/asm/cpu_sh7757.h
+++ b/arch/sh/include/asm/cpu_sh7757.h
@@ -162,7 +162,6 @@ struct pcie_system_bus_regs {
 };
 #define PCIE_SYSTEM_BUS_BASE	((struct pcie_system_bus_regs *)0xffca1600)
 
-
 /* PCIe-Bridge */
 struct pciebrg_regs {
 	unsigned short	ctrl_h8s;
diff --git a/arch/sh/include/asm/posix_types.h b/arch/sh/include/asm/posix_types.h
index c9d9fb84f1f..769c5eb4c18 100644
--- a/arch/sh/include/asm/posix_types.h
+++ b/arch/sh/include/asm/posix_types.h
@@ -65,7 +65,6 @@ static __inline__ void __FD_CLR(unsigned long __fd, __kernel_fd_set *__fdsetp)
 	__fdsetp->fds_bits[__tmp] &= ~(1UL<<__rem);
 }
 
-
 #undef	__FD_ISSET
 static __inline__ int __FD_ISSET(unsigned long __fd, const __kernel_fd_set *__p)
 {
-- 
2.43.0

