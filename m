Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33653606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OyxhM/5k;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3SfJbSe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B42BB8133E;
	Tue, 10 Nov 2026 13:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N9sU7L1PSE-w; Tue, 10 Nov 2026 13:05:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CA1581316
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315943;
	b=RQGoQsRDphVqTNdlZHFMGKLM+9pv4ddl05EbxqOvUaDo60WQfYHA/R9ynv9Cbh3sAC4T
	 IkFsz/MQtcrrkbpI4ZWlFRQaGlQSJCtBDrXguFT+p4v4lCUBnFd0fSm9G9G0Tv2jEgt51
	 9pnV/DfD8wpVUiovZRIOzo5i1IsYoJQwOl99F+n8KLOCJ+A84X/IGgZFwO0Z3FCgUHLOw
	 xSnHCfVsARSv4F63ckjHRbR34fDTkzvubzVLyMfUIe7aFRkx9KO0juT16ReF2z4kG3jSn
	 hOoIyKnIlVY7x5zmC4F4ecw3VxdGjXGgiSnfCu2oj95Lv7rJh9NO9aDQ/REIJNOOzlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=J5tiFDm30P95X///PlJ3K83/h21FIww6fOOH/PSKpjg=;
	b=BhHm3eiRy/NazZ7+s3czoT04dXTG/NhLA2RYuBsqRfgxn1q3A9clXN0PiP7sUQikTkLP
	 bAqG3Y1bqAkXFyX7vo/b9rHDZ3aiiq79laYc9hMgS7idqqcP3ZuLVvP/js2NNcDRs/2Eu
	 nlbl84d+qi71ZSKTKGrHHVPYZeBR+0ISwRHLLZovfTgRf0WdG9/HXkkU5Fo0wdYzBmssd
	 VYTlxnZGaPnKwFQfIBXUduDcUwCjkovrSgQy7kw29mSTDC+x503NVoU9wUhftbrDJsOCd
	 x4jW36X3GMIY7XLc+284Qjf/PZWhMuCCXXS+JLta/Fy3vG3K6NUB8suHuPOiN/92r9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3SfJbSe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315943;
	bh=J5tiFDm30P95X///PlJ3K83/h21FIww6fOOH/PSKpjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OyxhM/5keO37C8Ax/PjcthU3Mrqra46fpULCCY1OWrhVS3wCsPBSKfgnnoCYR/CEJ
	 VdIppeJ5xbbIZBYhMYuD840NoKv4LLgBG2qmeBZ0zIQFkgcEetTJZ2B4LWt1rWZ7U9
	 l8Z6i7zDia/aVetudZ+n5Feq3RJANDieSyjvhirIxtYmHQOLPJAeNHmdp0XOxg9as3
	 zSaGflYdCgXZlRdJXnN2XOhK2odw55D+jdbWXh5F43X0m/hhx7SxSO8cp+HyU+5+V6
	 wNtkA2V+o7n67hgk5fhutCiEaOAbeP31x4dSWX6rX/b1t1+zg3A5pwL30jB+p5UmWy
	 TI6V2tARnnDDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CA1581316;
	Tue, 10 Nov 2026 13:05:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE67D31F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B436480F36
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VNutI5t73I0G for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A584A80F1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f3SfJbSe
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A584A80F1B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C537F6375E;
 Tue, 10 Nov 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5F83A1F008A2;
 Tue, 10 Nov 2026 06:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291577;
 bh=J5tiFDm30P95X///PlJ3K83/h21FIww6fOOH/PSKpjg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=f3SfJbSeXc20BSP3UO+Mbt1Eqbj7oYv8BayslYi44Dhxnv6TCTswVs0NvH9ZwcXty
 LIHZFXQIz/FwyQd0Hf77Pec8wLs7vdK3knHxf6/5hAze2EhrBixDB6jTlrNE0z7QHl
 Ih0C7vAHffvPti+gAjNNvgNmmaW/FvijcP3nxFkHZo0x4W4dRcwSVzSfiZVdPImBM9
 B8SBvfTT4hMYZMlPlokGBAXCfIBEJHwEs1102+rzCSLRp8GcXO5za23bNUwev+OPgF
 ugBD2FAqaHKW8HgRfQqWWfghkLkWqnQ3pa2FAI4Vh9aVFD4BUf4BMZKBdLLSe/lNmq
 TTu5OlnNyib7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C8CF9488E6;
 Tue, 10 Nov 2026 06:19:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:19:36 +0000
Subject: [PATCH 1/2] sunxi: H6/H616: support the RSB bus for the SPL PMIC
 access
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-h616-rsb-spl-v1-1-bf91cc26507e@gmail.com>
References: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
In-Reply-To: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291575; l=5969;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=m5M2/DsDQHSwBRy2WZjZLXiCZIY3Sk5PDrr2qUnBUec=;
 b=dfkyduX/u7yG4Q8wubEl3rovjITicxRLc2bv1vz4cULrOOTgC3j72W/IfqkKBLWvYlclVqZwb
 h0FXd5g8ljJAhR/2RUJW5BXU1x+Lp1s6rBHbKi7TtD/IElecmyL4sTf
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

On H6/H616 boards the AXP305/AXP805/AXP806 PMIC is described on the
R_RSB bus in the Linux device tree (e.g. pmic@745 on the OrangePi
Zero2). TF-A switches the PMIC into RSB mode (AXP "device mode" register
0x3e = 0x7c) and Linux talks RSB to it. The PMIC keeps that mode until
it loses power, so after every warm reboot the SPL, which can only use
R_I2C on these SoCs, gets no acknowledge from the PMIC, axp_init()
fails and the SPL prints

  Failed to set core voltage! Can't set CPU frequency

The CPU then stays at the 408 MHz clock_init_safe() value through the
SPL, TF-A and U-Boot proper.

Teach the SPL side of the sun8i RSB driver about the H6 generation:
- the controller is at 0x07083000, its gate and reset are bits 0 and 16
  of PRCM register 0x1bc (like the R_I2C one at 0x19c); R_PIO has no
  gate to open. PL0/PL1 use pin function 2 as on sun8i.
- pmic_bus: the AXP305/805/806 answer at the "secondary" RSB hardware
  address 0x745 (runtime address 0x3a), the other RSB AXPs at the
  primary 0x3a3/0x2d. The mapping is fixed, see drivers/bus/sunxi-rsb.c
  in Linux.

rsb_init() issues the device-mode switch itself, so a cold boot with the
PMIC still in I2C mode works as well. Nothing changes for boards that do
not select CONFIG_SYS_I2C_SUN8I_RSB.

Tested on an OrangePi Zero2 (H616, AXP305) together with the next patch:
cold boot and warm reboot both come up without the core voltage error,
TF-A still finds the AXP305 on RSB and Linux's sunxi-rsb driver probes
it; the SPL to TF-A time on a warm reboot dropped from 1.5 s to 1.0 s
(serial console timestamps).

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h |  1 +
 arch/arm/include/asm/arch-sunxi/prcm_sun50i.h   |  3 +++
 arch/arm/mach-sunxi/pmic_bus.c                  | 22 ++++++++++++++++++----
 drivers/i2c/sun8i_rsb.c                         | 10 ++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
index 2a9b086991c..18ac118ca15 100644
--- a/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h
@@ -47,6 +47,7 @@
 #define SUNXI_PRCM_BASE			0x07010000
 #define SUNXI_R_WDOG_BASE		0x07020400
 #define SUNXI_R_TWI_BASE		0x07081400
+#define SUNXI_RSB_BASE			0x07083000
 
 #ifndef __ASSEMBLY__
 void sunxi_board_init(void);
diff --git a/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h b/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
index d6653c3bb06..6e9bf587a55 100644
--- a/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
+++ b/arch/arm/include/asm/arch-sunxi/prcm_sun50i.h
@@ -11,6 +11,7 @@
 #ifndef __ASSEMBLY__
 
 #define CCU_PRCM_I2C_GATE_RESET		0x19c
+#define CCU_PRCM_RSB_GATE_RESET		0x1bc
 #define CCU_PRCM_PLL_LDO_CFG		0x244
 #define CCU_PRCM_SYS_PWROFF_GATING	0x250
 #define CCU_PRCM_RES_CAL_CTRL		0x310
@@ -18,6 +19,8 @@
 
 #define PRCM_TWI_GATE		(1 << 0)
 #define PRCM_TWI_RESET		(1 << 16)
+#define PRCM_RSB_GATE		(1 << 0)
+#define PRCM_RSB_RESET		(1 << 16)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _PRCM_H */
diff --git a/arch/arm/mach-sunxi/pmic_bus.c b/arch/arm/mach-sunxi/pmic_bus.c
index c77dc538456..8c72d773601 100644
--- a/arch/arm/mach-sunxi/pmic_bus.c
+++ b/arch/arm/mach-sunxi/pmic_bus.c
@@ -18,6 +18,20 @@
 
 #define AXP221_CHIP_ADDR		0x68
 
+/*
+ * RSB hardware/runtime address pair of the PMIC. AXP305/AXP805/AXP806
+ * sit at the "secondary" address (0x745/0x3a), every other RSB AXP at
+ * the primary one (0x3a3/0x2d); the mapping is fixed, see Linux's
+ * drivers/bus/sunxi-rsb.c.
+ */
+#ifdef CONFIG_AXP305_POWER
+#define AXP_PMIC_RSB_DEVICE_ADDR	AXP_PMIC_SEC_DEVICE_ADDR
+#define AXP_PMIC_RSB_RUNTIME_ADDR	AXP_PMIC_SEC_RUNTIME_ADDR
+#else
+#define AXP_PMIC_RSB_DEVICE_ADDR	AXP_PMIC_PRI_DEVICE_ADDR
+#define AXP_PMIC_RSB_RUNTIME_ADDR	AXP_PMIC_PRI_RUNTIME_ADDR
+#endif
+
 #if CONFIG_IS_ENABLED(PMIC_AXP)
 static struct udevice *pmic;
 #endif
@@ -45,8 +59,8 @@ int pmic_bus_init(void)
 		if (ret)
 			return ret;
 
-		ret = rsb_set_device_address(AXP_PMIC_PRI_DEVICE_ADDR,
-					     AXP_PMIC_PRI_RUNTIME_ADDR);
+		ret = rsb_set_device_address(AXP_PMIC_RSB_DEVICE_ADDR,
+					     AXP_PMIC_RSB_RUNTIME_ADDR);
 	}
 #endif
 
@@ -63,7 +77,7 @@ int pmic_bus_read(u8 reg, u8 *data)
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN6I_P2WI))
 		return p2wi_read(reg, data);
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
-		return rsb_read(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
+		return rsb_read(AXP_PMIC_RSB_RUNTIME_ADDR, reg, data);
 
 	return i2c_read(CONFIG_AXP_I2C_ADDRESS, reg, 1, data, 1);
 #endif
@@ -77,7 +91,7 @@ int pmic_bus_write(u8 reg, u8 data)
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN6I_P2WI))
 		return p2wi_write(reg, data);
 	if (IS_ENABLED(CONFIG_SYS_I2C_SUN8I_RSB))
-		return rsb_write(AXP_PMIC_PRI_RUNTIME_ADDR, reg, data);
+		return rsb_write(AXP_PMIC_RSB_RUNTIME_ADDR, reg, data);
 
 	return i2c_write(CONFIG_AXP_I2C_ADDRESS, reg, 1, &data, 1);
 #endif
diff --git a/drivers/i2c/sun8i_rsb.c b/drivers/i2c/sun8i_rsb.c
index 2197f180566..4a0903ff869 100644
--- a/drivers/i2c/sun8i_rsb.c
+++ b/drivers/i2c/sun8i_rsb.c
@@ -159,8 +159,18 @@ int rsb_init(void)
 {
 	struct sunxi_rsb_reg *base = (struct sunxi_rsb_reg *)SUNXI_RSB_BASE;
 
+#if defined(CONFIG_SUN50I_GEN_H6)
+	/*
+	 * H6/H616: the R_PIO clock is always on, the RSB module has its own
+	 * gate/reset register in the PRCM (like the R_I2C one used by
+	 * clock_twi_onoff()).
+	 */
+	setbits_le32((void *)SUNXI_PRCM_BASE + CCU_PRCM_RSB_GATE_RESET,
+		     PRCM_RSB_GATE | PRCM_RSB_RESET);
+#else
 	/* Enable RSB and PIO clk, and de-assert their resets */
 	prcm_apb0_enable(PRCM_APB0_GATE_PIO | PRCM_APB0_GATE_RSB);
+#endif
 
 	if (IS_ENABLED(CONFIG_MACH_SUN9I)) {
 		sunxi_gpio_set_cfgpin(SUNXI_GPN(0), SUN9I_GPN_R_RSB);

-- 
2.55.0


