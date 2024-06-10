Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9527FC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C611D88524;
	Mon, 10 Jun 2024 03:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q/pH8txl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E00088506; Mon, 10 Jun 2024 03:12:45 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15308849A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2548a00c19eso1244587fac.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981961; x=1718586761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUlSrGaFAyyOiQQdsehGkSzrSRXQT/CDiakY96Iprr8=;
 b=Q/pH8txlX6Kf7AzRRBG74SCCnJ/MRAjlBeuA/PaR/ESoWClP8U56GZLRrIlhwJUl/Y
 1GJvYvDXei6LD30KsSXRAfWBy6or8/xaMKbU/F/EK94g5V0iougReRpO1yncpRq4vWXL
 BP0sMqMPoOpvcgkzaZvuKEjbz2HVtsR0VK1u5Y9m3b4hzyRB2A7tZ4Jc999PgWK8SdsY
 Ed71PIOspBF/JDDSCeRbppV+pW14d50v2Lc2tXVYd5Xarb0CE+/wMr7z/d0Uj/icN8k+
 jlF0dW8lEbiehU4gxHkVrm6gUPkiL4jpAKKYdAXoKJWY//h3sRWejAgK5Vf7X+bzGwca
 Cl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981961; x=1718586761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kUlSrGaFAyyOiQQdsehGkSzrSRXQT/CDiakY96Iprr8=;
 b=hlC0Wfydyae6aj1Ov1So2Cd9kWPM/I73zcH4jeg6OUDzOq3H1YMYTvOGGeAkzfn2hk
 IKV2SO+mGxeTItl7kpPR8u35FUb9kR4Y8Dq4AP7P7U7C0otovHO3Kdvuz/yPpcrpdAiB
 SsnCiuxgCuwvNUWf4tjST8s2GLTy0vEP+hSwObnVhhs0/zoRovH9vXj9s85vMfTHw5Sx
 Q1WJJyGdxH4Il5TTubaU8RSyrgipK7tGWnNZJabF2NkQJsewQaCSmdtk0kjmgVXtH2HQ
 9VCQSkjWhsZCNLCcPiL8W6QevQje3vUu7BOW3I369647qKisui8ABZNRMKAeQybxYoq0
 FloA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSLYbcnu44wHVY/EwuyF6eIJxMAiU//aGJsfvGqJE8GFNb22R6lug+1szmw9bh406SlmPftKHiueQVDeZevzFmb2kuig==
X-Gm-Message-State: AOJu0Yx6M/A1neNssL5DerwNJ4kT57GAClVkvF/A0b+TvdgrAXKVd7BT
 8eZrozWmp0+ac8d/Q8nv+stZKdDxDLvkczacvxThwtq8ee4XzvyLJBaSgJaWYms=
X-Google-Smtp-Source: AGHT+IFX7aFiHyuQ9Kvg0f0zorva3E9kjMI1JW93wzC0TUYcNPxj0DTsq6xI0AWS4L8xOeyggkilMw==
X-Received: by 2002:a05:6870:8326:b0:24c:ac7e:8a5c with SMTP id
 586e51a60fabf-25464c3dbc1mr9448757fac.21.1717981961509; 
 Sun, 09 Jun 2024 18:12:41 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9633c5c35sm951306a34.4.2024.06.09.18.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:41 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 20/40] mmc: exynos_dw_mmc: Don't call pinmux functions on
 ARM64 chips
Date: Sun,  9 Jun 2024 20:12:06 -0500
Message-Id: <20240610011226.4050-21-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

Pinmux configuration on ARM64 platforms must be performed during startup
in pinctrl driver using info from device tree. exynos_pinmux_config()
and pinmux_decode_periph_id() are only available on ARM32 platforms, so
don't call those functions on ARM64 platforms. Instead of the latter
function, use "non-removable" property from device tree to derive the
dev_index value.

This fixes next linking errors on ARM64 platforms:

    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `exynos_dwmci_get_config':
      undefined reference to `pinmux_decode_periph_id'
    ld: drivers/mmc/exynos_dw_mmc.o:
      in function `do_dwmci_init':
      undefined reference to `exynos_pinmux_config'

Fixes: a082a2dde061 ("EXYNOS5: DWMMC: Added FDT support for DWMMC")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Replaced CONFIG_IS_ENABLED() with #ifdef

 drivers/mmc/exynos_dw_mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 8e80bd6a059f..2ed8429d0a40 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -145,6 +145,7 @@ static int exynos_dwmci_core_init(struct dwmci_host *host)
 
 static int do_dwmci_init(struct dwmci_host *host)
 {
+#ifdef CONFIG_CPU_V7A
 	int flag, err;
 
 	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
@@ -153,6 +154,7 @@ static int do_dwmci_init(struct dwmci_host *host)
 		printf("DWMMC%d not configure\n", host->dev_index);
 		return err;
 	}
+#endif
 
 	return exynos_dwmci_core_init(host);
 }
@@ -164,6 +166,7 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 	int err = 0;
 	u32 timing[3];
 
+#ifdef CONFIG_CPU_V7A
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
@@ -175,6 +178,12 @@ static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
 		printf("DWMMC%d: Can't get the dev index\n", host->dev_index);
 		return -EINVAL;
 	}
+#else
+	if (dev_read_bool(dev, "non-removable"))
+		host->dev_index = 0; /* eMMC */
+	else
+		host->dev_index = 2; /* SD card */
+#endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
 	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
-- 
2.39.2

