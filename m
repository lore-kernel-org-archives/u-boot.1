Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE22DC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1969C8885D;
	Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZLwZEeLg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c0oGd5ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC1388837; Sat, 13 Jul 2024 15:21:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B3088836
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy95TzZz9sZv;
 Sat, 13 Jul 2024 15:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B48JoT+zmn4FvDsXTjlMT9E+oVD1w+lnzAF9eEBHXE4=;
 b=ZLwZEeLgXdBCcACXbpn9EnThdOpbjVkWmwKbIMEOe1UmWuvYSK4Yr0GqOf34HtIkuP2Zn4
 JScxcKCWazS7mqiEWBG8l1nXT+8MlRRnqrfbSKoKYXNByxSqNPkHg463nDJ/L+zRZlcJ4Z
 o2tj+g6y0YA4Qwl9iu96Xut4f6Y03NRmSpIlQNLj8Jo9+0Id8XI/HjncGmS2F8KiUah9Ym
 zShaOAx00WFcVapnlgnJ6DeF8Ap7RTHO3CZ5QGKIP+JbROtv7C6XTVM6qL+bceLSdbMoLd
 puC3eiqJKxRBWc5u48udDRTn+xNWnbZE57yGppwE38dAw953bOV/e0+5GcnFYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B48JoT+zmn4FvDsXTjlMT9E+oVD1w+lnzAF9eEBHXE4=;
 b=c0oGd5ewAN05nLNmbjDyvhgvK0IKi5Nd3TVG5LwWNBsBAaM7DNDKQsExvFRDtk6pARsVGv
 mOc1xLa5qhuZIuhS4Eegl1UDL6Z8wnl9/JjWIIFU4yxbQeC4vBIR0r+jrF4EsAIFXF38Bn
 dB52TR+Uo9+F0CxD73TpDBF/kuW+6n22bw3JAutUXzIcLQlEH78lyM9cT73bAnGVTcVdy7
 AZpa8lbHaNYhbuTTSsT9PrfADL0TbbwrNYOZMHTztLChmkkjSWvJ+xxG7sBHx31qrkCxGj
 yHejTE2pwVYazcPH6uQsJMLOs9RrM31J2bztJfoGsFwyFm22TlvaP2GozMWIKQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/45] arm: include: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:05 +0200
Message-ID: <20240713132021.57650-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea871cdf14b9606e913
X-MBO-RS-META: r5ga5geqp4gnm9bscinxhio946huzihd
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
 arch/arm/include/asm/byteorder.h        | 1 -
 arch/arm/include/asm/emif.h             | 3 ---
 arch/arm/include/asm/mach-imx/gpio.h    | 1 -
 arch/arm/include/asm/mach-imx/mxc_i2c.h | 1 -
 arch/arm/include/asm/omap_common.h      | 1 -
 arch/arm/include/asm/opcodes.h          | 3 ---
 arch/arm/include/asm/setup.h            | 1 -
 7 files changed, 11 deletions(-)

diff --git a/arch/arm/include/asm/byteorder.h b/arch/arm/include/asm/byteorder.h
index 20cce7657e1..6a80be57506 100644
--- a/arch/arm/include/asm/byteorder.h
+++ b/arch/arm/include/asm/byteorder.h
@@ -15,7 +15,6 @@
 #ifndef __ASM_ARM_BYTEORDER_H
 #define __ASM_ARM_BYTEORDER_H
 
-
 #include <asm/types.h>
 
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
diff --git a/arch/arm/include/asm/emif.h b/arch/arm/include/asm/emif.h
index 2141a4581c7..4a9e26f634d 100644
--- a/arch/arm/include/asm/emif.h
+++ b/arch/arm/include/asm/emif.h
@@ -880,7 +880,6 @@ struct dmm_lisa_map_regs {
 #define RL_FINAL	6
 #endif
 
-
 /* Interleaving policies at EMIF level- between banks and Chip Selects */
 #define EMIF_INTERLEAVING_POLICY_MAX_INTERLEAVING	0
 #define EMIF_INTERLEAVING_POLICY_NO_BANK_INTERLEAVING	3
@@ -913,7 +912,6 @@ struct dmm_lisa_map_regs {
  */
 #define READ_IDLE_INTERVAL_NORMAL	(50*1000)
 
-
 /*
  * Unless voltage is changing due to DVFS one ZQCS command every 50ms should
  * be enough. This shoule be enough also in the case when voltage is changing
@@ -961,7 +959,6 @@ struct dmm_lisa_map_regs {
 #define REG_SR_TIM		0xF
 #define REG_PD_TIM		0xF
 
-
 /* EMIF_PWR_MGMT_CTRL register */
 #define EMIF_PWR_MGMT_CTRL (\
 	((REG_CS_TIM << EMIF_REG_CS_TIM_SHIFT) & EMIF_REG_CS_TIM_MASK)|\
diff --git a/arch/arm/include/asm/mach-imx/gpio.h b/arch/arm/include/asm/mach-imx/gpio.h
index 25763526f5f..f7d751f4024 100644
--- a/arch/arm/include/asm/mach-imx/gpio.h
+++ b/arch/arm/include/asm/mach-imx/gpio.h
@@ -4,7 +4,6 @@
  * Stefano Babic, DENX Software Engineering, <sbabic@denx.de>
  */
 
-
 #ifndef __ASM_ARCH_IMX_GPIO_H
 #define __ASM_ARCH_IMX_GPIO_H
 
diff --git a/arch/arm/include/asm/mach-imx/mxc_i2c.h b/arch/arm/include/asm/mach-imx/mxc_i2c.h
index e8b330f33d1..cf694de4970 100644
--- a/arch/arm/include/asm/mach-imx/mxc_i2c.h
+++ b/arch/arm/include/asm/mach-imx/mxc_i2c.h
@@ -91,7 +91,6 @@ struct mxc_i2c_bus {
 		}					\
 	};
 
-
 #define I2C_PADS_INFO(name)	\
 	(is_mx6dq() || is_mx6dqp()) ? &mx6q_##name : &mx6s_##name
 #endif
diff --git a/arch/arm/include/asm/omap_common.h b/arch/arm/include/asm/omap_common.h
index 17fdfbcffb7..9945eeb66b8 100644
--- a/arch/arm/include/asm/omap_common.h
+++ b/arch/arm/include/asm/omap_common.h
@@ -814,7 +814,6 @@ static inline u8 is_dra76x_acd(void)
 #define HS_DEVICE           0x2
 #define GP_DEVICE           0x3
 
-
 /*
  * SRAM scratch space entries
  */
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 21b33442989..bc2f9e70810 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -15,7 +15,6 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ARM_OPCODE_CONDTEST_PASS   1
 #define ARM_OPCODE_CONDTEST_UNCOND 2
 
-
 /*
  * Assembler opcode byteswap helpers.
  * These are only intended for use by this header: don't use them directly,
@@ -42,7 +41,6 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___asm_opcode_identity32(x) ((x) & 0xFFFFFFFF)
 #define ___asm_opcode_identity16(x) ((x) & 0xFFFF)
 
-
 /*
  * Opcode byteswap helpers
  *
@@ -94,7 +92,6 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 
 #endif /* ! __ASSEMBLY__ */
 
-
 #ifdef CONFIG_CPU_ENDIAN_BE8
 
 #define __opcode_to_mem_arm(x) ___opcode_swab32(x)
diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index e0e2d7e3606..b8ca50a6401 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -75,7 +75,6 @@ struct param_struct {
     char commandline[COMMAND_LINE_SIZE];
 };
 
-
 /*
  * The new way of passing information: a list of tagged entries
  */
-- 
2.43.0

