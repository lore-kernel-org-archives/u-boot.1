Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB80C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 15:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5580882F1;
	Fri, 31 May 2024 17:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="rbaynKgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F24988607; Fri, 31 May 2024 16:21:46 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205BB88288
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.schramm@manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717165303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mb2L/mhRfty6JaEjaB3DSclqer07j2y21eiE3aYO+4A=;
 b=rbaynKgbZGFGaKuJ2aymHf8DraA62gWuvXtn3+DJ9zYyuis2YKRvOsh4RvU2BXvumLGjgd
 pJmkQ3aV6RWt5mU4eUB2FLqsLuf/9kzEIlDR4ztfGbFeWysTlMfsyQnKC9Np/3YkPBKdGX
 IFUuKs085Oaq48UTY0nMDxVOLH6fc2eX43zWrzXPka6m40Yv950hG4D91uqP1PjS4RE6ci
 gtDiUwqLLJGAmhhMI/RnsojLu6QVNQKEF52DPeDP67BH8wr6CotuZTLLiY4vi1zdTd5/uB
 Mgb0589u8GxXApDTX93CQqI08+RFbmASaatPqdPWShEbuIXT/e4DhhoOjVpUEA==
To: u-boot@lists.denx.de
Cc: Hans de Goede <hdegoede@redhat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] arm: sunxi: add support for I2C1 on V3s-based SoCs
Date: Fri, 31 May 2024 16:21:38 +0200
Message-ID: <20240531142138.14129-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
X-Mailman-Approved-At: Fri, 31 May 2024 17:13:20 +0200
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

Previously enabling I2C1 when using a V3s-based SoC had no effect.
Set pinmux on PE21 and PE22 to I2C1 function when enabling I2C1 on
V3s-based SoCs.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 board/sunxi/board.c  | 4 ++++
 include/sunxi_gpio.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 1313b01dce..df2faba3e5 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -98,6 +98,10 @@ void i2c_init_board(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(16), SUN6I_GPH_TWI1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(17), SUN6I_GPH_TWI1);
 	clock_twi_onoff(1, 1);
+#elif defined(CONFIG_MACH_SUN8I_V3S)
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(21), SUN8I_V3S_GPE_TWI1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPE(22), SUN8I_V3S_GPE_TWI1);
+	clock_twi_onoff(1, 1);
 #elif defined(CONFIG_MACH_SUN8I)
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(4), SUN8I_GPH_TWI1);
 	sunxi_gpio_set_cfgpin(SUNXI_GPH(5), SUN8I_GPH_TWI1);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c039..175b13a887 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -113,6 +113,7 @@ enum sunxi_gpio_number {
 #define SUN4I_GPB_TWI1		2
 #define SUN5I_GPB_TWI1		2
 #define SUN8I_V3S_GPB_TWI0	2
+#define SUN8I_V3S_GPE_TWI1	3
 #define SUN4I_GPB_UART0		2
 #define SUN5I_GPB_UART0		2
 #define SUN8I_GPB_UART2		2
-- 
2.30.2

