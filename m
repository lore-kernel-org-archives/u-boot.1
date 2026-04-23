Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F87FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063C683FF5;
	Sat, 25 Apr 2026 18:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="ZEjc7qpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DC683FB0; Sat, 25 Apr 2026 18:20:31 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7E1840CB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1dCS2prkzb2m;
 Thu, 23 Apr 2026 16:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1776953124;
 bh=Am+dN9nWVO3w1+L7d79/2Oz6ZB6t6UiDiMGAsf3ikNQ=;
 h=From:Date:Subject:To:Cc:From;
 b=ZEjc7qpyWwgvZ9X6riMRGoEaFMayXTrP5n8/XGO2YVOhs3Lpz0sqFJcELO/RMgLM2
 uD7d2n0CO1bYQEbvQ1ym65CNbgF73VEA3H7+oYMVbxniiKhPhG0tAn7MRZOyXEHjO8
 9agY6eal3tQVR6VmO52lJAnrQ/bqeobDkOLQVj1fVJNEwbclBeTKFDiCTcOj7kyL15
 s5LArYRzwHIJsdoodBXfSzCNnL8if8IR+v2dIZK3vxhhZDaZXC59bCp8PiSrILaICL
 jlj6rj6Bv1wVx6PV/g12H26xvCKoMiAIppWJT7Oq5wBbMAxwxiS0kBPwQJm6kRZnw1
 e41Z+NcepL/GQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g1dCP6Pj3zQyf; Thu, 23 Apr 2026 16:05:21 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 23 Apr 2026 16:05:13 +0200
Subject: [PATCH] rockchip: fix asm-operand-widths clang warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-rk35-cnt-freq-v1-1-8f07677be5ca@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQExXqVUoXOpm0YyHaiYog3
 t3YLt/i/x0Sq3CCtthBeZUkY8wobwXQu4svRvHZYI1tTGUd6sfVSHHGoPxFU997R8F5bwlyMyk
 H2X6/x/PvtPQD03xN4DhO1QXN63EAAAA=
X-Change-ID: 20260423-rk35-cnt-freq-059b3cf3dd2c
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

CONFIG_COUNTER_FREQUENCY is currently 24000000 for all SoCs, meaning it
fits in a 32b type. For 64b SoCs, it's an issue since the registers are
64b.

clang complains that we're trying to fit a 32b value into a 64b
register:

arch/arm/mach-rockchip/rk3528/rk3528.c:98:45: error: value size does not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
   98 |         asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
      |                                                    ^
include/generated/autoconf.h:372:34: note: expanded from macro 'CONFIG_COUNTER_FREQUENCY'
  372 | #define CONFIG_COUNTER_FREQUENCY 24000000
      |                                  ^
/home/qschulz/work/upstream/u-boot/arch/arm/mach-rockchip/rk3528/rk3528.c:98:32: note: use constraint modifier "w"
   98 |         asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
      |                                       ^~
      |                                       %w0

Even though cntfrq_el0[1] is only using the 32b LSB of its 64b, use the
'x' operand modifier[2] to force the value to be 64b and fix the
warning.

[1] https://developer.arm.com/documentation/ddi0601/2026-03/AArch64-Registers/CNTFRQ-EL0--Counter-timer-Frequency-Register?lang=en
[2] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AArch64-Operand-Modifiers

Suggested-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/rk3528/rk3528.c | 2 +-
 arch/arm/mach-rockchip/rk3576/rk3576.c | 2 +-
 arch/arm/mach-rockchip/rk3588/rk3588.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3528/rk3528.c b/arch/arm/mach-rockchip/rk3528/rk3528.c
index f9bfc445b85..a39cb8be9a1 100644
--- a/arch/arm/mach-rockchip/rk3528/rk3528.c
+++ b/arch/arm/mach-rockchip/rk3528/rk3528.c
@@ -95,7 +95,7 @@ void rockchip_stimer_init(void)
 	if (reg & TIMER_EN)
 		return;
 
-	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	asm volatile("msr cntfrq_el0, %x0" : : "r" (CONFIG_COUNTER_FREQUENCY));
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
 	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
index c17ba418ced..e44ebb6e676 100644
--- a/arch/arm/mach-rockchip/rk3576/rk3576.c
+++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
@@ -130,7 +130,7 @@ void rockchip_stimer_init(void)
 	if (reg & TIMER_EN)
 		return;
 
-	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	asm volatile("msr cntfrq_el0, %x0" : : "r" (CONFIG_COUNTER_FREQUENCY));
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
 	writel((TIMER_EN << 16) | TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index eedce7b9b08..10f96175a17 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -167,7 +167,7 @@ void rockchip_stimer_init(void)
 	if (reg & TIMER_EN)
 		return;
 
-	asm volatile("msr cntfrq_el0, %0" : : "r" (CONFIG_COUNTER_FREQUENCY));
+	asm volatile("msr cntfrq_el0, %x0" : : "r" (CONFIG_COUNTER_FREQUENCY));
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT0_REG);
 	writel(0xffffffff, HP_TIMER_BASE + HP_LOAD_COUNT1_REG);
 	writel(TIMER_EN, HP_TIMER_BASE + HP_CTRL_REG);

---
base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
change-id: 20260423-rk35-cnt-freq-059b3cf3dd2c

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

