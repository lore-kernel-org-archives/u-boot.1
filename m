Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638A0606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tsW3mm3G;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=Zh/sZJHo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CFEA60E39;
	Fri, 13 Nov 2026 02:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7dYvi7CwtRG; Fri, 13 Nov 2026 02:33:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1648860E61
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537202;
	b=qCXGXhYmFT7fsmuHlH6ZERtnIToMtztkPlsiMN9aiVC1hfnNxCFQ3blXizdVGNatNmCv
	 cLSG28hMbCM6T0W3v6HqkPhKt8VmBQ/EWlFcsa/DGAmb4089MxEW/xAwXpkBEou2InaAv
	 JsNq5rBDtnVRAvr7usbgFUdiJ5Wq/DTY2AFN7zVYRzJ2CnzLMjLhKcJWIz6pbWhhU5N//
	 cV+BlLoiXXhySZwSjZvosLyA/jIPydwOLNax+sOwLqC2ghCBvTqQ+a5MDkP3uOU+hmdpW
	 8JphG1dyI7ZkQSfDPC5q5p2VHZZry70vd3Y02DHyxiMuJEgOn9WYPoyGsV1IA0BlIJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HIQVgM8vTOi2mswvoqxKwoIwZtjHrCs+6HPyuJ1rIOQ=;
	b=LiGGod+FJjz4RXaPTRZQYWtZGFDylLzkoafgt40D2MNbffFahewlVjxMOWpg+2cC3b5d
	 hZfDgppsBYyefhWX/ifG5UJ6L8Wfx538r+5QP7xoFdFF2VcBSbQiX7TvCpJ/Av6AYKaWk
	 eVdxW2g/JfW6SSAifZ9htljyyBWOexvKe8jZJqU+5+Z5/BTIku7N2GVS/v/PeOZ6j/T4t
	 lL+8dvcbrntmTu2Dt1irwjwtEpcbJclVDcgHrhQliqpU9crDDPvbz9LhLgASZxOJsmiyw
	 +pvWw/bzBgs0SyqfA3yOx2ktPpLaxWPO2xflLW4gyO+ZVICR/uSATx718s8WYa8dAew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537202;
	bh=HIQVgM8vTOi2mswvoqxKwoIwZtjHrCs+6HPyuJ1rIOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsW3mm3GSDA+Cqqr1i0FscPWp4GlNJ3M1oRH5QdMzOc6B/90s07HMNBOyCkI6PmAv
	 C50Ztbx5qsbGah6n4ZmPfHgHtb0V8CP66nRO7kXun9mYpSmbZbGHmXaDx8udlaKmpd
	 V+CDLPGElortXhT40VIicN6F/2Y19BHQ7W91C4tAp3cS8N/jWaB51Q5XyncDEQDU+/
	 qilRcRUxfa2BNoLgPI7EVqm/tXWS5YWqOJWlcW7soXsGT3vG8H3VDSPzrFCiOAKBrn
	 ahB3KoVQA16q+FwcQs3f0qJWVAU6icLZCUlCLT9j4/wya1Ve7Iy7qMpkobZwlS/++F
	 KJ3x1ktLsRn5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1648860E61;
	Fri, 13 Nov 2026 02:33:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5B04F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AAB94815FA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0N2gXaghxGn for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 926AE8151E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=Zh/sZJHo
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 926AE8151E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:33:18 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 9C94745731;
 Fri, 13 Nov 2026 13:33:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIQVgM8vTOi2mswvoqxKwoIwZtjHrCs+6HPyuJ1rIOQ=;
 b=Zh/sZJHoHXkF4r9E6FksaNcu1YgDsRHyAXas/eguxTqND4RfB9mHAWFcpc7LBTI5PcsJRe
 LpLBMqKrbbMTQZF+IErPi38gXzPjKexGzDXWSrDH7A83jfQb1+1ldDBmo1RBJMPH1ZkMi8
 TCqxINAX1B1NbpEBeGFaZHR9zA/v0XbTm73yzOctfxa7nse5ulmO11HlOcHndDScEE0jxv
 XyarLXZ6ktmPTXpYQQYlj4v/IVkS2LKn12Zkgh4Oxj1NYQt1e+auAj62KrZ3KiQwihUDKq
 RhYvL8lt53VuE0hj0pnSP7Oyrjq0nLuhxKxBtIelCXc3uWMKRp+Z7vQ2RKjg6A==
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 06/26] gpio: a733: add initial support
Date: Fri, 13 Nov 2026 13:32:16 +1100
Message-ID: <20261113023236.569054-7-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yixun Lan <dlan@gentoo.org>

In A733 SoC, the main GPIO register layout has changed: Port B begins at
offset 0x100 (leaving a 0x80-byte virtual Port A slot at offset 0x80)
with a 0x80-byte bank stride and DRV/PULL offsets at 0x20/0x30, whereas
R-PIO (0x07025000) retains the NCAT2 0x30-byte bank stride and DRV/PULL
offsets at 0x14/0x24.

Introduce CONFIG_SUNXI_A733_PINCTRL to support both main PIO and R-PIO
bank addressing, 4-bit drive strength masks, and UART0 PB0/PB9 mux
constants.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
Link: https://lore.kernel.org/r/20260113-01-a733-soc-support-v3-6-f19dcd098f60@gentoo.org
[Alastair: preserve NCAT2 DRV/PULL offsets for R-PIO, fix 4-bit DRV mask
 and preprocessor guards, add PB0/PB9 UART0 mux defines]
Co-developed-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/gpio/Kconfig      |  7 ++++++
 drivers/gpio/sunxi_gpio.c | 49 +++++++++++++++++++++++++++++++--------
 include/sunxi_gpio.h      | 10 +++++++-
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7f12e39dad8..725d5c3c277 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -472,6 +472,13 @@ config SUNXI_NEW_PINCTRL
 	  The Allwinner D1 and other new SoCs use a different register map
 	  for the GPIO block, which we need to know about in the SPL.
 
+config SUNXI_A733_PINCTRL
+	bool
+	depends on SUNXI_GPIO
+	help
+	  The Allwinner A733 uses a 0x80-byte bank stride starting at offset
+	  0x80 for main PIO while retaining 0x30-byte banks for R-PIO.
+
 config XILINX_GPIO
 	bool "Xilinx GPIO driver"
 	depends on DM_GPIO
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 094c45a6927..a997d528fd6 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -38,22 +38,48 @@
 
 #define GPIO_DAT_REG_OFFSET	0x10
 
-#define GPIO_DRV_REG_OFFSET	0x14
-
 /*		Newer SoCs use a slightly different register layout */
-#ifdef CONFIG_SUNXI_NEW_PINCTRL
+#if defined(CONFIG_SUNXI_NEW_PINCTRL) || defined(CONFIG_SUNXI_A733_PINCTRL)
 /* pin drive strength: 4 bits per pin */
 #define GPIO_DRV_INDEX(pin)	((pin) / 8)
 #define GPIO_DRV_OFFSET(pin)	(((pin) % 8) * 4)
+#define GPIO_DRV_MASK		0xfU
+
+/*
+ * On A733, main PIO (0x02000000) places DRV at 0x20 and PULL at 0x30, whereas
+ * R-PIO (0x07025000) retains the NCAT2 layout (DRV at 0x14, PULL at 0x24).
+ */
+static inline u32 gpio_drv_reg_offset(void *bank_base)
+{
+	if (IS_ENABLED(CONFIG_SUNXI_A733_PINCTRL) &&
+	    (uintptr_t)bank_base < SUNXI_R_PIO_BASE)
+		return 0x20;
+	return 0x14;
+}
 
-#define GPIO_PULL_REG_OFFSET	0x24
+static inline u32 gpio_pull_reg_offset(void *bank_base)
+{
+	if (IS_ENABLED(CONFIG_SUNXI_A733_PINCTRL) &&
+	    (uintptr_t)bank_base < SUNXI_R_PIO_BASE)
+		return 0x30;
+	return 0x24;
+}
 
 #else /* older generation pin controllers */
 /* pin drive strength: 2 bits per pin */
 #define GPIO_DRV_INDEX(pin)	((pin) / 16)
 #define GPIO_DRV_OFFSET(pin)	(((pin) % 16) * 2)
+#define GPIO_DRV_MASK		0x3U
 
-#define GPIO_PULL_REG_OFFSET	0x1c
+static inline u32 gpio_drv_reg_offset(void *bank_base)
+{
+	return 0x14;
+}
+
+static inline u32 gpio_pull_reg_offset(void *bank_base)
+{
+	return 0x1c;
+}
 #endif
 
 #define GPIO_PULL_INDEX(pin)	(((pin) & 0x1f) >> 4)
@@ -65,12 +91,15 @@ static void* BANK_TO_GPIO(int bank)
 
 	if (bank < SUNXI_GPIO_L) {
 		pio_base = (void *)(uintptr_t)SUNXI_PIO_BASE;
+		if (IS_ENABLED(CONFIG_SUNXI_A733_PINCTRL))
+			return pio_base + SUN60I_A733_PINCTRL_BANK_OFFSET +
+			       bank * SUN60I_A733_PINCTRL_BANK_SIZE;
+		return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
 	} else {
 		pio_base = (void *)(uintptr_t)SUNXI_R_PIO_BASE;
 		bank -= SUNXI_GPIO_L;
+		return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
 	}
-
-	return pio_base + bank * SUNXI_PINCTRL_BANK_SIZE;
 }
 
 void sunxi_gpio_set_cfgbank(void *bank_base, int pin_offset, u32 val)
@@ -136,8 +165,8 @@ void sunxi_gpio_set_drv_bank(void *bank_base, u32 pin_offset, u32 val)
 	u32 index = GPIO_DRV_INDEX(pin_offset);
 	u32 offset = GPIO_DRV_OFFSET(pin_offset);
 
-	clrsetbits_le32(bank_base + GPIO_DRV_REG_OFFSET + index * 4,
-			0x3U << offset, val << offset);
+	clrsetbits_le32(bank_base + gpio_drv_reg_offset(bank_base) + index * 4,
+			GPIO_DRV_MASK << offset, val << offset);
 }
 
 void sunxi_gpio_set_pull(u32 pin, u32 val)
@@ -153,7 +182,7 @@ void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val)
 	u32 index = GPIO_PULL_INDEX(pin_offset);
 	u32 offset = GPIO_PULL_OFFSET(pin_offset);
 
-	clrsetbits_le32(bank_base + GPIO_PULL_REG_OFFSET + index * 4,
+	clrsetbits_le32(bank_base + gpio_pull_reg_offset(bank_base) + index * 4,
 			0x3U << offset, val << offset);
 }
 
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index 12b54c8dda4..ff181d77bbd 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -19,6 +19,9 @@
 #elif defined(CONFIG_SUN50I_GEN_H6)
 #define SUNXI_PIO_BASE		0x0300b000
 #define SUNXI_R_PIO_BASE	0x07022000
+#elif defined(CONFIG_MACH_SUN60I_A733)
+#define SUNXI_PIO_BASE		0x02000000
+#define SUNXI_R_PIO_BASE	0x07025000
 #elif defined(CONFIG_SUNXI_GEN_NCAT2)
 #define SUNXI_PIO_BASE		0x02000000
 #define SUNXI_R_PIO_BASE	0x07022000
@@ -117,6 +120,8 @@ enum sunxi_gpio_number {
 #define SUN8I_A83T_GPB_UART0	2
 #define SUN8I_V3S_GPB_UART0	3
 #define SUN50I_GPB_UART0	4
+#define SUN60I_A733_GPB0_UART0	3
+#define SUN60I_A733_GPB9_UART0	2
 
 #define SUNXI_GPC_NAND		2
 #define SUNXI_GPC_SPI0		3
@@ -169,7 +174,7 @@ enum sunxi_gpio_number {
 
 #define SUN9I_GPN_R_RSB		3
 
-#ifdef CONFIG_SUNXI_NEW_PINCTRL
+#if defined(CONFIG_SUNXI_NEW_PINCTRL) || defined(CONFIG_SUNXI_A733_PINCTRL)
 	#define SUNXI_PINCTRL_BANK_SIZE	0x30
 	#define SUNXI_GPIO_DISABLE	0xf
 #else
@@ -177,6 +182,9 @@ enum sunxi_gpio_number {
 	#define SUNXI_GPIO_DISABLE	0x7
 #endif
 
+#define SUN60I_A733_PINCTRL_BANK_OFFSET	0x80
+#define SUN60I_A733_PINCTRL_BANK_SIZE	0x80
+
 /* GPIO pin pull-up/down config */
 #define SUNXI_GPIO_PULL_DISABLE	0
 #define SUNXI_GPIO_PULL_UP	1
-- 
2.53.0

