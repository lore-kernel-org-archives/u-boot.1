Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F6CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6ABB84895;
	Wed, 20 May 2026 00:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="XSBfWC2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA4284895; Wed, 20 May 2026 00:49:14 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3297284894
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso2471022a91.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779230950; x=1779835750;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QMFkn0acHSnxyDPtR3R9pRnMCZNqg9C0QTu6Tytv/OM=;
 b=XSBfWC2qsfcAp6Q3eco3u2icYFrJYI8kx+zFaN7AaO4ARMtn1/o7CS9QG7M4RaWVCu
 TX6AhDxWXOy1kVUlo9WZ15LKG90kZqfEhL1YmS4sQt+eZAfcRO+ZvY9PCnWxWo0f6yk7
 I+VkC5mJKcw6Ekh7wkHhs4k6ILo05XO9+KC6h2FTjQEHa5lRNLnNcdxo9ZaaWKeADA9d
 8RlRSGP6GFeTodTl0f4iYgS09iN9ZzgNbNyuNVlbgv+ViJ4P/GPAWsjnU8x+3sH1gvZl
 F5OXep7U9hLEEjhe8pSyZgPM9GGNJY+nO1VKsaFOOW6uCE2iU9fK6f8Inkc8/4zFa3L4
 pNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230950; x=1779835750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QMFkn0acHSnxyDPtR3R9pRnMCZNqg9C0QTu6Tytv/OM=;
 b=d3lKn6itre4P13mgVaUUerATdYFTYer6wxIwzB8dHCWOsICXPCchDM5q0tmeGucQU4
 /DhpoE/SRaN85fQC9CC/yUDacoaEEl6nkcV7PzNb8yIDufRNJ5MeiUhZwCQNrGaCq9/i
 1miDjLVNnE2ywqhmjRafk2+xAejej42dJewbO/75QZymBD8m/aSu/190Txv+Qc9Yy+mv
 iS2n0tslDkc9Tmet9vUJo+ZDml96xHwDgSj/eXme5Lg9Nhnia7Pd1wSEkU5qmKhdNmT9
 d84yKUJuRVJiSDERuDVrehsHb44bhq+lZzKMqYUHjivHzkwRcar+YUZv3NXKA0M4DG2Z
 iP4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/26ICJOgO5JmRVrvwo0FZt/iURnrNU2DRLBr6sFwZW6tq5rg2ygDXAcSwwEADpocEzsdI6OLY=@lists.denx.de
X-Gm-Message-State: AOJu0YxemhWmVbOeekQv3EL3vKEheXjSikvzo5lBtPux0p+u9O3fNpRw
 y1g2gtsyy+xuXF/3ycgNnyXfKIpnGwmMIhF92vwa1BRJfojdfYCJRj2ijsZNbAXbNH0=
X-Gm-Gg: Acq92OGxGAUhFTayuicNHfs0dWYz2PcDE6EHtinloDcBlZbHOhpZiKNqlmK2AksJo+h
 QDPNgz+9G177Gny47ztMRkr1GNwEzavRVa+ZM7gF3CSIX1ogPugucIqrKLU2zZTcNtNTBNjft4A
 KD9/39YnBNffVIpexwowpMtGFgVfxMZIy9dsVYLwAXXZppcOVHL3+e/7LiTFYhsp/svcuVB9FuE
 1JqJboGzBL7lm/Z2bqi1b/9zVB8fdHNVfw6m3duqd7KQTM1AIDHXjtk6I6U59uKS+vUT9pUU5CW
 vb4BgqD5yvB+idSsHQTwGThO255uMs3XxOUYr+NXSYUGKlv+PX0N2feMORiSbHw6QJ4Sq/YuSXb
 Q6/XWCCgWaMuxHOq+jY2DV67geYeTg0XobfEhudCW1zoB1OLnBOs3eT1tEAUMfuL+rpg3nvAPpN
 arI/sl81xy3XC3DDsbPHZsnR2XgrxWuKmMoCT/yJeXOhE=
X-Received: by 2002:a17:90b:3904:b0:369:e1fa:962b with SMTP id
 98e67ed59e1d1-369e1fa98f6mr7703861a91.26.1779230949678; 
 Tue, 19 May 2026 15:49:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4073])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a0e93e0sm5720707a91.10.2026.05.19.15.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:49:09 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Wed, 20 May 2026 06:45:50 -0400
Subject: [PATCH v2 6/9] spacemit: k1: Add multiple device tree support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
In-Reply-To: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io
Cc: Vignesh R <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1
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

Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
allowing a single U-Boot binary to support different board variants.

The SPL reads the board type from EEPROM and selects the corresponding
device tree at runtime via board_fit_config_name_match(), ensuring the
correct hardware description is passed to U-Boot proper.

Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v2:
- Reworked.  Drop the v1 approach (new local k1-muse-pi-pro.dts,
  enlarge SYS_MALLOC_F_LEN, MMODE switch).
- Use binman --fit-multi-config so u-boot.itb packs multiple board
  DTs from the upstream tree.
---
 board/spacemit/k1/spl.c       | 42 ++++++++++++++++++++++++++++++++++--------
 configs/spacemit_k1_defconfig |  2 ++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index da4169fbc8c..d749e21a2d5 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
 #include <power/regulator.h>
@@ -55,6 +56,8 @@ struct ddr_cfg {
 binman_sym_declare(ulong, ddr_fw, image_pos);
 binman_sym_declare(ulong, ddr_fw, size);
 
+char product_name[I2C_BUF_SIZE] = "k1";
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -322,14 +325,8 @@ void nor_early_init(void)
 	udelay(10);
 }
 
-void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
-{
-	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
-}
-
 void board_init_f(ulong dummy)
 {
-	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
 	int ret;
 
 	ret = spl_early_init();
@@ -344,11 +341,11 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 
 	i2c_early_init();
-	ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
+	ret = read_product_name(product_name, I2C_BUF_SIZE);
 	if (ret)
 		log_info("Fail to detect board:%d\n", ret);
 	else
-		log_info("Get board name:%s\n", (char *)i2c_buf);
+		log_info("Get board name:%s\n", product_name);
 	pmic_init();
 
 	ddr_early_init();
@@ -363,3 +360,32 @@ u32 spl_boot_device(void)
 void spl_board_init(void)
 {
 }
+
+int board_fit_config_name_match(const char *name)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	memset(fdt_name, 0, I2C_BUF_SIZE);
+	if (!strncmp(product_name, "k1-x_", 5)) {
+		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
+			 &product_name[5]);
+	}
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, "k1-musepi-pro");
+	}
+	for (i = 0; i < I2C_BUF_SIZE; i++) {
+		if (fdt_name[i] == '\0')
+			break;
+		fdt_name[i] = tolower(fdt_name[i]);
+	}
+	if (!strcmp(name, fdt_name))
+		return 0;
+	return -ENOENT;
+}
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+}
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 64c724c62a5..465788cc2e5 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -5,6 +5,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
+CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_STACK=0xc083fb00
 CONFIG_SPL_TEXT_BASE=0xc0801000
@@ -27,6 +28,7 @@ CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_SUPPORT_RAW_INITRD=y

-- 
2.43.0

