Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3674CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360A486FE3;
	Wed, 18 Oct 2023 20:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697655150;
	bh=pfzr4Yy3OvtDSaoAH0Fi9v7i6G3FJ2pPUWePbJF2nL0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PEsMibHhI0mZ20E2sizdDnLzE3GlXAlEzvkvleE7SLruKZrNjEhiLjeGkYOzqbz7o
	 yR/5FkGDIPM7uUf3dJyb99FtbEm16zCu0UYmpSQWwcxLGtye/4n64wghp7plsXYuoj
	 xfdZTbapa/V64Swa8JShRix0b0XrNGiyuqjDJyYIq8tBCtFcQ70iP5YRSwwGJj2exK
	 u0FyoACW2TfmfOuJfrjhRyu8ZNPPYXFo2g2/0BzChmAY4w8JeHm2uJdyhLQ9T677kz
	 OYEGiOogoM5VeGEH4q31/SQ7v4pkqkxyBPnRFOTfdCwfm9svP+lCmKUPb60d3i1W3r
	 nGcY1am8ABI9w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 445F686F8F;
 Wed, 18 Oct 2023 20:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697655148;
 bh=pfzr4Yy3OvtDSaoAH0Fi9v7i6G3FJ2pPUWePbJF2nL0=;
 h=From:To:Cc:Subject:Date:From;
 b=D9q7iIFzwvsc+baVZbfU9e5gQFfazvkJE8hYc/b7OvrrzFgFY13ix/E4uhkE01e/c
 cVwDSGgINHkZGDS9yeUV9SXQrzek/kwJXRY8r0cBZ5jiaF3GOipMwtOeKB2nFkQNTa
 Q7sbrsVWblCKbN1biem+8/ad1gVHbqWE1kwy5Gfp4mRL/9LsTpBfZi61g54XPfPOEz
 n1ggq4m4SmrMcTvB4inZVCG8u9ZwxgMemJHhNSqSL9CISt813Kij7MjlH6q8herL8g
 ZSkbccEdiSKBGLJ0Q9u2KqBTTK8I1+ePCAyOHeej5h66UfbJsK75tJVQfFpWimRoak
 2J/GzN9lT1Fhw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] arm: mxs: Clear CPSR V bit to activate low vectors
Date: Wed, 18 Oct 2023 20:51:59 +0200
Message-ID: <20231018185212.128405-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

The MXS starts with CPSR V bit set, which makes the CPU jump to high vectors
in case of an exception. Those high vectors are located at 0xffff0000, which
is where the BootROM exception table is located as well. U-Boot should handle
exceptions on its own using its own exception handling code, which is located
at 0x0, i.e. at low vectors. Clear the CPSR V bit, so that the CPU would jump
to low vectors on exception instead, and therefore run the U-Boot exception
handling code.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
---
V2: Mark both get_cr()/set_cr() callsites as __attribute__((target("arm")))
    and noinline to force generation of ARM version of those functions,
    as this core cannot run mrc/mcr in Thumb mode. This is truly hideous
    workaround right here.
---
 arch/arm/cpu/arm926ejs/mxs/mxs.c      | 4 ++++
 arch/arm/cpu/arm926ejs/mxs/spl_boot.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/arm926ejs/mxs/mxs.c b/arch/arm/cpu/arm926ejs/mxs/mxs.c
index 6d6166cb839..4f3cb63c56d 100644
--- a/arch/arm/cpu/arm926ejs/mxs/mxs.c
+++ b/arch/arm/cpu/arm926ejs/mxs/mxs.c
@@ -71,6 +71,7 @@ void reset_cpu(void)
  * actually 0x20, this the associated <destination address>. Loading the PC
  * register with an address performs a jump to that address.
  */
+noinline __attribute__((target("arm")))
 void mx28_fixup_vt(uint32_t start_addr)
 {
 	/* ldr pc, [pc, #0x18] */
@@ -85,6 +86,9 @@ void mx28_fixup_vt(uint32_t start_addr)
 		/* cppcheck-suppress nullPointer */
 		vt[i + 8] = start_addr + (4 * i);
 	}
+
+	/* Make sure ARM core points to low vectors */
+	set_cr(get_cr() & ~CR_V);
 }
 
 #ifdef	CONFIG_ARCH_MISC_INIT
diff --git a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
index 5e7bdb78be1..249f8de8fbe 100644
--- a/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
+++ b/arch/arm/cpu/arm926ejs/mxs/spl_boot.c
@@ -17,6 +17,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/gpio.h>
 #include <asm/sections.h>
+#include <asm/system.h>
 #include <linux/compiler.h>
 
 #include "mxs_init.h"
@@ -93,7 +94,9 @@ static uint8_t mxs_get_bootmode_index(void)
 	return i;
 }
 
-static void mxs_spl_fixup_vectors(void)
+static noinline
+__attribute__((target("arm")))
+void mxs_spl_fixup_vectors(void)
 {
 	/*
 	 * Copy our vector table to 0x0, since due to HAB, we cannot
@@ -104,6 +107,9 @@ static void mxs_spl_fixup_vectors(void)
 
 	/* cppcheck-suppress nullPointer */
 	memcpy(0x0, _start, 0x60);
+
+	/* Make sure ARM core points to low vectors */
+	set_cr(get_cr() & ~CR_V);
 }
 
 static void mxs_spl_console_init(void)
-- 
2.42.0

