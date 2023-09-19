Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CDBCD5BCE
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 14:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A119986548;
	Tue, 19 Sep 2023 16:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVZxFtVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8251C86479; Tue, 19 Sep 2023 16:57:10 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3528603A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 16:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso730028566b.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695135428; x=1695740228; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqBn6tIvP7xKVcebNbXgzgfH0PF2fP/a8iwA9wqWboM=;
 b=fVZxFtVPlpwFqbADnhQMVMIcy0USusSFVhuU4krPS0vSD7Vn06lpxozBi67ZnVdb+G
 2Jtmhd1Fvh/g2zfvwN1AfIJ48d9q8hkjfOSpXiteCSkU4fhP7WSi4R2glJacJi6thvXC
 jJA+6fL4mKcAis53PSmy9VzVppD5kISujEak40G5z7TiKwND1SK0VG12fWDBIs6yxgC5
 uN3yXvDz5ZFs2BgdqPWq2qPplxlOWT+Ad5j/ZGg4XRP2Xfp1n6++ZHNnUO2PBAXMZBkK
 fb4j1OlCV5qcHVNZ/6Mk9x47/L8k00wvi+RhMrefuypuSkkNYvc85HY8VSBMvqKDK/36
 m0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695135428; x=1695740228;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zqBn6tIvP7xKVcebNbXgzgfH0PF2fP/a8iwA9wqWboM=;
 b=Lushmyt2OMVal+wThJZUZio+JVA2unHDstvJ7b1AeejEpFNNOSEjXPgbZEhaarz6J4
 EEe1ZgXLmiimtDG9JFlPGqnAaiPXZYZpslGCgMtNVpCmBAYhQehi5+hYsUxgKa+U3gik
 f1jGSv5fvJIC+87g05OdIfekubyh28lVRguFp29l/KTqP/uTueMD42dC8EpCzQUgq0tV
 q7aDfvwxqJyxC8tAdI6xJAWvTw0T+QONC1PrS1IeACCjcMIXLG2UJ4vbNL9w3gFW997F
 l1wZwa5iFz7XklooGxW3/zHpdyAhrZ0MPJI/G+1OanXd+CrCN+Wty2HJTnL3Xw0UePvV
 Cqdw==
X-Gm-Message-State: AOJu0YyqSgNMbVD922rlbKXPqGKhCiptrhYikg/jSB3TBnfmeFhEdJPr
 MCBk6+LA8beS6a6OTkp2AG8=
X-Google-Smtp-Source: AGHT+IHcMWwOl7bLV05Y0R0pBKU+IJYoMvKK7VcyiUx6tpmpLRVC8hVaB4MYTt6AA+M3F/vB/u7ffw==
X-Received: by 2002:a17:906:da:b0:9a1:e233:e627 with SMTP id
 26-20020a17090600da00b009a1e233e627mr10061339eji.42.1695135427597; 
 Tue, 19 Sep 2023 07:57:07 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a1709065ac800b0099bccb03eadsm7817561ejs.205.2023.09.19.07.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 07:57:07 -0700 (PDT)
Message-ID: <183eaaad-ef37-22a2-f041-a32e499c7f88@gmail.com>
Date: Tue, 19 Sep 2023 16:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2] rockchip: include: asm: fix entering download mode rk3066
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Keep track of the re-entries with help of the lr register.
This binary can be re-used and called from various BROM functions.
Only when it's called from the part that handles SPI, NAND or EMMC
hardware it needs to early return to BROM ones.
In download mode when it handles data on USB OTG and UART0
this section must be skipped.

Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
support to enter download mode on return to BROM. This binary must check
the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
It then returns to BROM to the end of the function that reads boot blocks.
From there the BROM code goes into a download mode and waits for data
on USB OTG and UART0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Note:
Normal boot flow is OK.
In download mode this binary hangs after return to BROM for unknown reasons.
Replace CODE471_OPTION with 30_LPDDR2_300MHz_DD.bin for now.

Could Rockchip disclose what further conditions must be met
in rk3066 download mode?

Changed V2:
Move file to rk3066 specific location
Replace retry_counter by LR check
Add DNL mode return address
Restyle
Reword
---
arch/arm/include/asm/arch-rk3066/boot0.h | 77 +++++++++++++++++++++++-
arch/arm/mach-rockchip/Kconfig | 17 +++++-
arch/arm/mach-rockchip/rk3066/Kconfig | 6 ++
3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rk3066/boot0.h b/arch/arm/include/asm/arch-rk3066/boot0.h
index 28c0fb9a4c6b..1af4b9c1d7ba 100644
--- a/arch/arm/include/asm/arch-rk3066/boot0.h
+++ b/arch/arm/include/asm/arch-rk3066/boot0.h
@@ -3,6 +3,81 @@
#ifndef __ASM_ARCH_BOOT0_H__
#define __ASM_ARCH_BOOT0_H__

-#include <asm/arch-rockchip/boot0.h>
+#include <asm/arch-rockchip/boot_mode.h>

+/*
+ * Execution starts on the instruction following this 4-byte header
+ * (containing the magic 'RK30'). This magic constant will be written into
+ * the final image by the rkimage tool, but we need to reserve space for it here.
+ */
+#ifdef CONFIG_SPL_BUILD
+ b 1f /* if overwritten, entry-address is at the next word */
+1:
+#endif
+
+#if CONFIG_IS_ENABLED(ROCKCHIP_EARLYRETURN_TO_BROM)
+/*
+ * Keep track of the re-entries with help of the lr register.
+ * This binary can be re-used and called from various BROM functions.
+ * Only when it's called from the part that handles SPI, NAND or EMMC
+ * hardware it needs to early return to BROM ones.
+ * In download mode when it handles data on USB OTG and UART0
+ * this section must be skipped.
+ */
+ ldr r3, =CONFIG_ROCKCHIP_BOOT_LR_REG
+ cmp lr, r3 /* if (LR != CONFIG_ROCKCHIP_BOOT_LR_REG) */
+ bne reset /* goto reset; */
+/*
+ * Unlike newer Rockchip SoC models the rk3066 BROM code does not have built-in
+ * support to enter download mode on return to BROM. This binary must check
+ * the boot mode register for the BOOT_BROM_DOWNLOAD flag and reset if it's set.
+ * It then returns to BROM to the end of the function that reads boot blocks.
+ * From there the BROM code goes into a download mode and waits for data
+ * on USB OTG and UART0.
+ */
+ ldr r2, =BOOT_BROM_DOWNLOAD
+ ldr r3, =CONFIG_ROCKCHIP_BOOT_MODE_REG
+ ldr r0, [r3] /* if (readl(CONFIG_ROCKCHIP_BOOT_MODE_REG) != */
+ cmp r0, r2 /* BOOT_BROM_DOWNLOAD) { */
+ bne early_return /* goto early_return; */
+ /* } else { */
+ mov r0, #0
+ str r0, [r3] /* writel(0, CONFIG_ROCKCHIP_BOOT_MODE_REG); */
+
+ ldr r3, =CONFIG_ROCKCHIP_BOOT_RETURN_REG
+ bx r3 /* return to CONFIG_ROCKCHIP_BOOT_RETURN_REG;*/
+
+early_return:
+ bx lr /* return to LR in BROM */
+
+SAVE_SP_ADDR:
+ .word 0
+
+ .globl save_boot_params
+save_boot_params:
+ push {r1-r12, lr}
+ ldr r0, =SAVE_SP_ADDR
+ str sp, [r0]
+ b save_boot_params_ret
+
+ .globl back_to_bootrom
+back_to_bootrom:
+ ldr r0, =SAVE_SP_ADDR
+ ldr sp, [r0]
+ mov r0, #0
+ pop {r1-r12, pc}
+#endif
+
+#if (defined(CONFIG_SPL_BUILD))
+/* U-Boot proper of armv7 does not need this */
+ b reset
+#endif
+
+/*
+ * For armv7, the addr '_start' will be used as vector start address
+ * and is written to the VBAR register, which needs to aligned to 0x20.
+ */
+ .align(5), 0x0
+_start:
+ ARM_VECTORS
#endif
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 07b5595dac8c..84a2f0d5ff48 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -402,7 +402,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
config TPL_ROCKCHIP_BACK_TO_BROM
bool "TPL returns to bootrom"
default y
- select ROCKCHIP_BROM_HELPER
+ select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
select TPL_BOOTROM_SUPPORT
depends on TPL
help
@@ -448,6 +448,21 @@ config ROCKCHIP_BOOT_MODE_REG
The Soc will enter to different boot mode(defined in asm/arch-rockchip/boot_mode.h)
according to the value from this register.

+config ROCKCHIP_BOOT_LR_REG
+ hex "Rockchip boot early return LR address"
+ depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
+ help
+ With ROCKCHIP_EARLYRETURN_TO_BROM enabled this LR address is
+ used to keep track of the re-entries.
+
+config ROCKCHIP_BOOT_RETURN_REG
+ hex "Rockchip download mode return address"
+ depends on TPL_ROCKCHIP_EARLYRETURN_TO_BROM || SPL_ROCKCHIP_EARLYRETURN_TO_BROM
+ help
+ Rockchip SoC models without built-in support to enter
+ download mode after early return to BROM code use a SoC
+ specific return address in BROM.
+
config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
bool "Disable device boot on power plug-in"
depends on PMIC_RK8XX
diff --git a/arch/arm/mach-rockchip/rk3066/Kconfig b/arch/arm/mach-rockchip/rk3066/Kconfig
index 95d7fc8a2917..3721f7469a9e 100644
--- a/arch/arm/mach-rockchip/rk3066/Kconfig
+++ b/arch/arm/mach-rockchip/rk3066/Kconfig
@@ -10,6 +10,12 @@ config TARGET_MK808
config ROCKCHIP_BOOT_MODE_REG
default 0x20004040

+config ROCKCHIP_BOOT_LR_REG
+ default 0x00001058
+
+config ROCKCHIP_BOOT_RETURN_REG
+ default 0x00001100
+
config SYS_SOC
default "rk3066"

--
2.39.2


