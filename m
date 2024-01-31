Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B32C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 10:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C901B87727;
	Wed, 31 Jan 2024 11:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ict42.de header.i=@ict42.de header.b="dPH2o1+e";
	dkim=permerror (0-bit key) header.d=ict42.de header.i=@ict42.de header.b="Qu1+d5nV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681DF876C1; Wed, 31 Jan 2024 11:49:50 +0100 (CET)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CF586FC9
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 11:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ict42.de
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ludwig.kormann@ict42.de
ARC-Seal: i=1; a=rsa-sha256; t=1706698188; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=iRN1SqCNXFYrQ3GFbLs+hZaIqgM9xlvhFQE/f6SPM+78E1m+18RGtIMwipMVFCS9Or
 6bKbLCtU+fbNYwaI97UNtYNb4xL8NsBLVKe6jcjrGz7LbnjFcLsLvsJEQGAt2UH2CmS8
 mGHEuxG8J7r5T6bVHcFS/uiYZQl3t3Dqj8ljyISOH+fAYBV7d7jLqIJTRjeIZvgJgjZK
 PlskH1taHIaUmW7Wf9mpky/irESLCE2CeMGDO3WqWekvcNfjIF7jdOMxx2cJqSBHO/MC
 JoNpqArQUcLRWJumPYPufz//CiKTfiZGQ34n66ksm7bwwUjwDIVAIf8RZ1RrPRng6Zvr
 EXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1706698188;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=rtFUVFVyA8d/o23gHZbWyIXMF0ud/jMCNIke9JC4h4I=;
 b=hjhuddQiQiWW08BuGLz5qP7Uf34edFafUvgvHjnPXBEyGWEJFIkrLBh/C4aCWtMWTT
 eu03QfTiBcANKHVTnOK+I3GArevPzTnUWtJTYGkx3fmnoe7TfQZ2qkbafeIpDRLGyF25
 tloIWj/az4tTHLbN9XA4pVzcNgvs+KYDN/57ePXKkScvtnFhT7cBlrkHSP3zPvLXwkWT
 91fedcv8lv3dcOvSHWDGV8j1m7xeW7rHLne9KO/m5B3XaF9iQuenRMpuJvjDyirBQ7eJ
 xWpbdnavcbdL0/oDEvJzbeeblOfYpobzPydWjuLr+k3cEZVYmX+zMKWdoG/roBkHdv2F
 hGjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1706698188;
 s=strato-dkim-0002; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=rtFUVFVyA8d/o23gHZbWyIXMF0ud/jMCNIke9JC4h4I=;
 b=dPH2o1+et4g454Zjwg4+sceBtCvVGny6l24NdvC4AZWT9oNzJnwvzDzEiqiepUH34Y
 Q8J2hzjQ9LUzqkQeJixxWcJlpRQzbxpl8gFQZqHQOp4uYrlMobVAPo45vQA9YXWnYhIh
 qRMkd3gwQ+a9k2YfvQA8mU2BGhVBVmKj8MJZsPs47cpa0f/Ejs4pfY4a0m9TLCKZzPIm
 gkRYPnrNKdV8txaenLM53M19MAOhcp8T4Z/0XBWe3GWqx7nnfVM/grkpNM1eDDH1iBQw
 ekeVhhJK8/2M1+i6vEiiaYXK1xQgE3qmTq3KWVmqco6SiW9WbqA975YmhQDusLN+7+yy
 OePg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1706698188;
 s=strato-dkim-0003; d=ict42.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=rtFUVFVyA8d/o23gHZbWyIXMF0ud/jMCNIke9JC4h4I=;
 b=Qu1+d5nVuHGhW/wPCcYtmFYtyKERtw/DsJ3n23VskRMJy17UJHrozApT2e5G30BWQV
 NkpNOaRtxLpYlhaEWGAw==
X-RZG-AUTH: ":IHkAYkmvNfSwjg/qSc4u8zZOVaURsoXe3UH2mQA0KglxDI1B7BeEcdPLARTmodKwkQi99TJCcPJmIA=="
Received: from debian-test.local.in-circuit.de
 by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
 with ESMTPSA id x7ec2e00VAnmGi9
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 31 Jan 2024 11:49:48 +0100 (CET)
From: Ludwig Kormann <ludwig.kormann@ict42.de>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/1] sunxi: sun4i: Reduce cpu clock at SPL initialization to
 144 MHz
Date: Wed, 31 Jan 2024 11:49:43 +0100
Message-Id: <20240131104943.196256-1-ludwig.kormann@ict42.de>
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

Up until now cpu clock gets initialized at 384 MHz, which is
the highest supported cpu clock.

Recent A20 batches show an increased percentage of modules
reacting very sensitive to operating conditions outside the
specifications.

The cpu dies very shortly after PLLs, core frequency or cpu
voltage are missconfigured. E.g.:
- uboot SPL selects 384 MHz as cpu clock which requires a cpu
  voltage of at least 1.1 V.
- Linux CPU Frequency scaling with most sun7i dts will reduce
  cpu voltage down to 1.0 V.
- When intiating a reboot or reset from linux the cpu voltage
  may keep the 1.0 V configuration and the cpu dies during SPL
  initialization.

Therefore reduce cpu clock at uboot SPL initialization down
to 144 MHz from 384 MHz.

Signed-off-by: Ludwig Kormann <ludwig.kormann@ict42.de>
---
 arch/arm/include/asm/arch-sunxi/clock_sun4i.h | 2 +-
 arch/arm/mach-sunxi/clock_sun4i.c             | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
index 2cec91cb20..252c4c693e 100644
--- a/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
+++ b/arch/arm/include/asm/arch-sunxi/clock_sun4i.h
@@ -141,7 +141,7 @@ struct sunxi_ccm_reg {
 #define CCM_PLL1_CFG_SIG_DELT_PAT_EN_SHIFT	2
 #define CCM_PLL1_CFG_FACTOR_M_SHIFT		0
 
-#define PLL1_CFG_DEFAULT	0xa1005000
+#define PLL1_CFG_DEFAULT	0xa1004c01
 
 #if defined CONFIG_OLD_SUNXI_KERNEL_COMPAT && defined CONFIG_MACH_SUN5I
 /*
diff --git a/arch/arm/mach-sunxi/clock_sun4i.c b/arch/arm/mach-sunxi/clock_sun4i.c
index 8f1d1b65f0..ac3b7a801f 100644
--- a/arch/arm/mach-sunxi/clock_sun4i.c
+++ b/arch/arm/mach-sunxi/clock_sun4i.c
@@ -25,6 +25,7 @@ void clock_init_safe(void)
 	       APB0_DIV_1 << APB0_DIV_SHIFT |
 	       CPU_CLK_SRC_OSC24M << CPU_CLK_SRC_SHIFT,
 	       &ccm->cpu_ahb_apb0_cfg);
+	sdelay(20);
 	writel(PLL1_CFG_DEFAULT, &ccm->pll1_cfg);
 	sdelay(200);
 	writel(AXI_DIV_1 << AXI_DIV_SHIFT |
@@ -32,6 +33,7 @@ void clock_init_safe(void)
 	       APB0_DIV_1 << APB0_DIV_SHIFT |
 	       CPU_CLK_SRC_PLL1 << CPU_CLK_SRC_SHIFT,
 	       &ccm->cpu_ahb_apb0_cfg);
+	sdelay(20);
 #ifdef CONFIG_MACH_SUN7I
 	setbits_le32(&ccm->ahb_gate0, 0x1 << AHB_GATE_OFFSET_DMA);
 #endif
-- 
2.39.2

