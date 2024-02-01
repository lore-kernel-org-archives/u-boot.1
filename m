Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE413C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 13:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4F2878F4;
	Thu,  1 Feb 2024 14:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="ShC0Bvyk";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="KWMzANfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D172087968; Thu,  1 Feb 2024 14:30:22 +0100 (CET)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFC487252
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 14:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1706794220; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=pDn9xsKgzXnlb3M9QewDD1mHvNvCJZlbxnZUFcUqk4R2LWYu100+rs+yLbm0Myzi/Q
 IhrRtIRHycI6wnejWZ3lLnrYtaPPJrPpUZhKTApkdBMVwcCGu12rE1UiML/mqfe1MPC/
 t3SkONfAYHt7ZRpwBTDg8yEO11FgsdgecJ0e8+caD1CcOlQx74+OvJ94hwFQAOPUT7Xw
 vseWbBJpX1E+WxCHtIqPTtHv7xtbVZn7/3GOxjWhTYGKLUOhZ+/GS1e9R5FLeIaCK3Eh
 iA97O6YzqZvZxc1vZWIna8Ro2xctR9FxD9DrkbHMjqIXMfUNxyIt8QPdLHWB7cCTEokp
 MABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706794220;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=MGYGHdFeCcbvoRZVTstpm41BP6cBn5k7Rc0Gnf4F7Vk=;
 b=YDFUuLx8g2fY/d63Jl5jHW9rDYyAR0n3CVATaAtm5Sw0LprgDi738bsrRv8RXgedUz
 QYRgnnKrsieG/1nryexLp6y5fjzGLMkxwVHw6TdUOhQ/XOUOS+Aln4NcE+4oJxQCfH8M
 MUcE4vP+HbHwK7mjc7+6b72L88N42cMH7avCKBbHTFkX+cT51BJlWmiWz66mm4t9x8SL
 YX6qdwi6Xiwkwa7K5UA+TikxiQfk89rWFeS7a1wRJ+Fkfxmxh+zsaNE8v3tKx2FOX6aq
 tIUYeEKex0bu5FumdXhjqIWtbbXD0vCgTFwwjDYMvHnp232KKpZ2tzKe8tdHNZPFDMml
 dCEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706794220;
 s=strato-dkim-0002; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=MGYGHdFeCcbvoRZVTstpm41BP6cBn5k7Rc0Gnf4F7Vk=;
 b=ShC0Bvyk7SvIOatBgya9Cg8WgT5R/sB/umZsu6yN8vP8WIlyIZUtGcPwd8axRyeIYJ
 YGTYT6JGLwqCncLND7DXCexm4v6JexdBs/0qkQ3TiFavy3g1Ep20sgggj9eiOTjpFk1S
 Y2a5DoQp338CjA9/Sut8FMCvwlUHvxtpf9EF32PoGTgIRJHHR6zxIRvv9z+EbvxdAXx8
 /fWWaQAYJ6ubgXk3EjvCf+dkusvDr1uYMAC8p4W18TcdtV8QgUplueB//E6Q5Yvvnp4R
 /baGVA+efpviXGh5b18Ig5JpF7rBEIaJRZaXe2I59dr67cJhsMtCWUfr6xyoD0f380Y8
 EFXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706794220;
 s=strato-dkim-0003; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=MGYGHdFeCcbvoRZVTstpm41BP6cBn5k7Rc0Gnf4F7Vk=;
 b=KWMzANfVxmQ3s4JdiUBpHSlANrwZRbCQfELdTfBMgIxVja7kIHvWFW3yvuNI1lbrVo
 1D1SlNd/KAtU5V5GsoBQ==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmodKwkQi99jFCdZ0="
Received: from debian-test.local.in-circuit.de
 by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
 with ESMTPSA id x7ec2e011DUJUbK
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 1 Feb 2024 14:30:19 +0100 (CET)
From: Ludwig Kormann <ludwig.kormann@ict42.de>
To: jagan@amarulasolutions.com, andre.przywara@arm.com, trini@konsulko.com,
 jernej.skrabec@gmail.com, iuncuim@gmail.com, cfsworks@gmail.com,
 samuel@sholland.org
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/1] sunxi: sun4i: Introduce KConfig option SPL_SYS_CLK_FREQ
Date: Thu,  1 Feb 2024 14:30:14 +0100
Message-Id: <20240201133014.578083-1-ludwig.kormann@ict42.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

This option can be used to modify the initial SPL
CPU clock frequency.

This follows an earlier discussion regarding A20
CPUs dying after reboot in SPL initialization due to
incompatible CPU clock frequency and core voltage. [1]

First attempt was to update PLL1_CFG_DEFAULT to a fixed
lower frequency (144MHz), which fixed the observed issue
but might not suit all A20 users. A KConfig option
should be the better solution.

[1]
https://lists.denx.de/pipermail/u-boot/2024-January/544897.html

Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h |  4 ++++
 arch/arm/mach-sunxi/Kconfig                   |  8 ++++++++
 arch/arm/mach-sunxi/clock_sun4i.c             | 11 ++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
index 2cec91cb20..11b350824e 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
@@ -134,12 +134,16 @@ struct sunxi_ccm_reg {
 #define CCM_PLL1_CFG_PLL4_EXCH_SHIFT		25
 #define CCM_PLL1_CFG_BIAS_CUR_SHIFT		20
 #define CCM_PLL1_CFG_DIVP_SHIFT			16
+#define CCM_PLL1_CFG_DIVP_MASK			(0x3 << CCM_PLL1_CFG_DIVP_SHIFT)
 #define CCM_PLL1_CFG_LCK_TMR_SHIFT		13
 #define CCM_PLL1_CFG_FACTOR_N_SHIFT		8
+#define CCM_PLL1_CFG_FACTOR_N_MASK		(0x1f << CCM_PLL1_CFG_FACTOR_N_SHIFT)
 #define CCM_PLL1_CFG_FACTOR_K_SHIFT		4
+#define CCM_PLL1_CFG_FACTOR_K_MASK		(0x3 << CCM_PLL1_CFG_FACTOR_K_SHIFT)
 #define CCM_PLL1_CFG_SIG_DELT_PAT_IN_SHIFT	3
 #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
 #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
+#define CCM_PLL1_CFG_FACTOR_M_MASK		(0x3 << CCM_PLL1_CFG_FACTOR_M_SHIFT)
 
 #define PLL1_CFG_DEFAULT	0xa1005000
 
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index fe89aec6b9..85e3a26855 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -705,6 +705,14 @@ config SYS_CLK_FREQ
 	default 1008000000 if MACH_SUN50I_H616
 	default 1008000000 if MACH_SUN8I_R528
 
+if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
+config SPL_SYS_CLK_FREQ
+	int "sunxi SPL CPU clock frequency"
+	default 384
+	---help---
+  A static value for the sunxi SPL CPU frequency, must be a multiple of 24.
+endif
+
 config SYS_CONFIG_NAME
 	default "suniv" if MACH_SUNIV
 	default "sun4i" if MACH_SUN4I
diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
index 8f1d1b65f0..04623c1d09 100644
--- a/arch/arm/mach-sunxi/clock_sun4i.c
+++ b/arch/arm/mach-sunxi/clock_sun4i.c
@@ -25,7 +25,16 @@ void clock_init_safe(void)
 	       APB0_DIV_1 << APB0_DIV_SHIFT |
 	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
 	       &ccm->cpu_ahb_apb0_cfg);
-	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
+	writel((PLL1_CFG_DEFAULT &
+		~(CCM_PLL1_CFG_FACTOR_N_MASK |
+		CCM_PLL1_CFG_FACTOR_K_MASK |
+		CCM_PLL1_CFG_FACTOR_M_MASK |
+		CCM_PLL1_CFG_DIVP_MASK)) |
+		(CONFIG_SPL_SYS_CLK_FREQ / 24) << CCM_PLL1_CFG_FACTOR_N_SHIFT |
+		0 << CCM_PLL1_CFG_FACTOR_K_SHIFT |
+		0 << CCM_PLL1_CFG_FACTOR_M_SHIFT |
+		0 << CCM_PLL1_CFG_DIVP_SHIFT,
+		&ccm->pll1_cfg);
 	sdelay(200);
 	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
 	       AHB_DIV_2 << AHB_DIV_SHIFT |
-- 
2.39.2

