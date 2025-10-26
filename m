Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F981CCD1BF
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 775A083835;
	Sun, 26 Oct 2025 02:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XEXch3e0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2AD836B4; Sun, 26 Oct 2025 02:07:07 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD9E807C0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c3e45dae8dso1157804a34.1
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440823; x=1762045623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24MVeQHAO5zZu6lYzKtJCVkSlH2PtId1UYIKtEwXu2A=;
 b=XEXch3e0SQUVRQZ2V3B0yur8q36ihll8nR3M47xC/q2T9MNkCyhogb/ni49WOZuvdF
 Z0tRJx0/btgKvFkYKRGISmbTHoOzzX7frolQUqI082cNtlr5G3whVznHAmpuAoK81FUg
 9Q0wdtUaBT5rfeWjKI1fnvXtHPsiR465oybd4mIsRkBdrqaPdha4DkIWNQdDtlhWxBTe
 ySo71NR4ltsLCRh1pHsdPOUM6u4yhVPWF4zEHB27qsWEU/rgJ++w/STkcclh8h97Ci/y
 xIFFRw74WxUm2NpJddYP9koU9LhfRYvv5grXt5HMbDyo+ewkY0YHaYw0LNK/j1337biQ
 5KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440823; x=1762045623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24MVeQHAO5zZu6lYzKtJCVkSlH2PtId1UYIKtEwXu2A=;
 b=lVjQ8i4GYaC1RgJulzvqjky7Bo3CWqxPU3X4NxSueZBS+lUx+NU653Y3sn7M/CO23Y
 oTo6BNV6POxZCbWzolM/1YDbyvXP03agNY+bdBRkgyqJGkoPSFx/zF8kAAKRbNFXFPrV
 +xBsNfOVe4fyAzhlyNLfiWZ7VOOFakMVi//MePZnlF4hflP7H+rn9skay41seHHJvK5O
 3IxQmB7zLdqGkLjSapSdyeGKHIwzuHbm5spQUNxm7+EtITEWVdRr4jGy9dvU/KKACRfo
 eRqBNHrY7j/PPHktIfgyADiMuqUmzz8aB6m1rH2t4afvCojvEk5fKJqHxQjIhgao1LAd
 u4qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1MQ+ysM6RnO3UZrXBOxeLWn6jtA6ksg750psH7jkYZwnONO5o9EtirWnmphiNCdQRH7sKPWQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2ftTRsaduYo4Y0Wnu/klW5nkV/yWW37V3jFgQzFvyurrS3ZPE
 //VjWe5tRxL3pjI2Sb7Yjlv9cpjqxtA5yqpsTe0TA7MVm5XYaiBa5dh4n2lAoMKLuNQ=
X-Gm-Gg: ASbGncscORJwTLAhT4vt6Nl3Pz2VzMSEe2VjVI/oY9F+GUPE7/RGudCRW1ba+pqptpu
 ckoV2X63cIjtZhSZLvqWMXuaJ8OZ8zAFOzQOoqOrJTjlt8bWkgBo/KIbcDKYimqLJnCf9u3dfWy
 3nf54l0Jaba5Qc+/LE8jWajRxAK2UA2+i/WPstkGJbgmKpPnn5hfUqKa+09+AMv38AymHUyD+lB
 tWXPFJJW5PWfgT1tklVAXWgFPNrf1CDPCMFRBpHBZRQ8UbR05O53bNNoyCoCohaetLJ+rlwQAgB
 JPTjXVC1N46R492qTkqfqs9un/8odTITR/9oKEv0pQS2cnhd6q59XOiiw15jdkq/Cu3DVrKzUgH
 /A0IBMt8bPirlHEcC5cEUGXwdq6gyiWbbjpzyKhSHIjtV1WuwIOloXT4dSw4Lhub8L8qNLJsv+w
 p5i1ETrD8JzrigPrnDAf6j
X-Google-Smtp-Source: AGHT+IH6M5+qpro7vW2OkikDiEvY9ur4BB/aTNpOmAmNcCruqH8LsohtpTQYIcXrJerWDQ7X1n2WnQ==
X-Received: by 2002:a05:6808:2229:b0:442:5fa:28ff with SMTP id
 5614622812f47-443a2efcd3cmr13916097b6e.15.1761440823427; 
 Sat, 25 Oct 2025 18:07:03 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e48249sm845101b6e.5.2025.10.25.18.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:02 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 4/6] mmc: exynos_dw_mmc: Add quirk for disabling FMP
Date: Sat, 25 Oct 2025 20:06:56 -0500
Message-Id: <20251026010658.19271-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
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

Add DWMCI_QUIRK_DISABLE_FMP which disables Flash Memory Protector (FMP)
during driver's init. It's usually done by early bootloaders, but in
some cases (like USB boot) the FMP may be left unconfigured. The issue
was observed on Exynos850 SoC (the E850-96 board). Enabling this quirk
makes eMMC functional even in such cases.

No functional change, as this feature is only added here but not enabled
for any chips yet.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/include/mach/dwmmc.h |  6 ++++++
 drivers/mmc/exynos_dw_mmc.c               | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 75d84988b7d6..4432deedef7d 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -17,10 +17,16 @@
 
 /* Protector Register */
 #define DWMCI_EMMCP_BASE		0x1000
+#define EMMCP_MPSECURITY		(DWMCI_EMMCP_BASE + 0x0010)
 #define EMMCP_MPSBEGIN0			(DWMCI_EMMCP_BASE + 0x0200)
 #define EMMCP_SEND0			(DWMCI_EMMCP_BASE + 0x0204)
 #define EMMCP_CTRL0			(DWMCI_EMMCP_BASE + 0x020c)
 
+/* EMMCP_MPSECURITY bits */
+#define MPSECURITY_FMP_ON		BIT(29)
+#define MPSECURITY_MMC_SFR_PROT_ON	BIT(28)
+
+/* EMMCP_CTRL0 bits */
 #define MPSCTRL_SECURE_READ_BIT		BIT(7)
 #define MPSCTRL_SECURE_WRITE_BIT	BIT(6)
 #define MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 51867a552495..be17bc4692c1 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -35,8 +35,16 @@
  *
  * %DWMCI_QUIRK_DISABLE_SMU: DW MMC block has Security Management Unit (SMU)
  * which has to be configured in non-encryption mode during driver's init.
+ *
+ * %DWMCI_QUIRK_DISABLE_FMP: DW MMC block has Flash Memory Protector (FMP) which
+ * has to be disabled during driver's init. This flag disables FMP encryption
+ * and lets external non-secure main CPUs access the SFR (peripheral memory
+ * region, i.e. registers) in MMC core. Although it's usually done by early
+ * bootloaders (before U-Boot), in some cases like during USB boot the FMP might
+ * be left unconfigured.
  */
 #define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
+#define DWMCI_QUIRK_DISABLE_FMP		BIT(1)
 
 #ifdef CONFIG_DM_MMC
 #include <dm.h>
@@ -225,6 +233,18 @@ static void exynos_dwmci_board_init(struct dwmci_host *host)
 			     MPSCTRL_NON_SECURE_WRITE_BIT | MPSCTRL_VALID);
 	}
 
+	if (priv->chip->quirks & DWMCI_QUIRK_DISABLE_FMP) {
+		u32 reg;
+
+		reg = dwmci_readl(host, EMMCP_MPSECURITY);
+		if (reg & MPSECURITY_FMP_ON ||
+		    reg & MPSECURITY_MMC_SFR_PROT_ON) {
+			reg &= ~MPSECURITY_FMP_ON;
+			reg &= ~MPSECURITY_MMC_SFR_PROT_ON;
+			dwmci_writel(host, EMMCP_MPSECURITY, reg);
+		}
+	}
+
 	if (priv->sdr_timing)
 		exynos_dwmci_clksel(host);
 }
-- 
2.39.5

