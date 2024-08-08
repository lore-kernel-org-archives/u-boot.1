Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B59CC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8468988BBB;
	Thu,  8 Aug 2024 05:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yg3/BaaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D8B88B32; Thu,  8 Aug 2024 05:15:06 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681DF88AE1
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3dc16d00ba6so401534b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086901; x=1723691701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jac/AK+/fRXX6frGsgkwuddOiwt75cCMUFZhhfIW9h8=;
 b=Yg3/BaaZ2tyA2GnFzbrlRiGwqKiw/2m2vMLOWGTnI6LclsUVO2ooBMOFZhG7/toVWc
 LlOLjFuSTRlEJ1MXw2KhiXFeJFIDs8vCvXSiX4PQ/fxP6wI+RF6iZcCyv0ExkZzLlcMd
 XWndnX3UIOUldF4ORvYIH+EdI6SqjXelURHAxUNuKG9vrJoeoyQeFnkDQPF0oCkqI/vs
 K1abq84ix5RcLgDVJ6K4QPuzVeiK+wCRnJRz6HyLi3bjSE0Nxynau6mdV4ly5OXuMmnV
 FGWni4cRHfrieOMUS0A0yIQg+W1ufNmOSYyciyc8dRlCn5IulCBdYnC9xsHWKHfsVdsr
 hJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086901; x=1723691701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jac/AK+/fRXX6frGsgkwuddOiwt75cCMUFZhhfIW9h8=;
 b=CQgR2obU/0oTtac3IwQS5OlCTcYuRD5zxu2xTXvCU5cGhQ3kV+yXkIprJpgl0PWNbp
 ZbwKjalI+zMRR9QcrWnQFzwGgJPZpGZgCJ6n1/Z+0QpR2a5LiOn/4/jbzO1BdN2Do0Ma
 ouG8enNQCk+9PRN7lTNxa85cq8aSaewVMxDXp9zJ5I5P4mtAsZfK3tTabWlUAZ2BL3TH
 GzV6D2IlY5h8l6RYF+ZkasqaD8pxcpR2cI3dFC2ug0D9EPoS3vXE9mvxEoJMiL/AhV1f
 FZv7E/JDenRjncxGQzHZr86NLANK/IhEifXR3+5FIhjr+nSY6fUUqYH20nvJah314uW5
 IqEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT08mKkbvLOewD3WimQc5hK66iHyQoxohu0ddl9hmurGDMiaAJfc1YuPWqxJN/LvLQJTxhB4SId0sGSSBV9QNbS0qWeA==
X-Gm-Message-State: AOJu0YwXdy8TtJkLkGDSTVNxAprYOoz7ibxw6JjAQD0qaBqkkfCe8wzD
 pbbUVeEc/aF0eZBjSbORLhzZVIRgJYrg/zq/5QhG2hRDxClbNinWPAjWu13Xdbw=
X-Google-Smtp-Source: AGHT+IFPtHqOwTNPZkYtSSze395CordAuO2JOzXN/BGJZd2EoH0KaM1o1r2KWdOqTnkpgBbk/ENVnA==
X-Received: by 2002:a05:6808:2185:b0:3d9:2ac4:5d69 with SMTP id
 5614622812f47-3dc3b427b8bmr637587b6e.25.1723086901016; 
 Wed, 07 Aug 2024 20:15:01 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563b705asm4640056b6e.35.2024.08.07.20.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 22/38] mmc: exynos_dw_mmc: Convert to use livetree API
Date: Wed,  7 Aug 2024 22:14:28 -0500
Message-Id: <20240808031444.9619-23-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

Update the driver to use livetree API instead of FDT one.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - Moved exynos_dwmmc_of_to_plat() under #ifdef CONFIG_DM_MMC stanza

 drivers/mmc/exynos_dw_mmc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 09a59fdf0120..50d0208b29fd 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -6,9 +6,7 @@
 
 #include <clk.h>
 #include <dwmmc.h>
-#include <fdtdec.h>
 #include <asm/global_data.h>
-#include <linux/libfdt.h>
 #include <malloc.h>
 #include <errno.h>
 #include <asm/arch/dwmmc.h>
@@ -226,18 +224,19 @@ static int do_dwmci_init(struct dwmci_host *host)
 #ifdef CONFIG_DM_MMC
 static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 {
-	const void *blob = gd->fdt_blob;
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
-	int node = dev_of_offset(dev);
 	int err = 0;
 	u32 timing[3];
 
 #ifdef CONFIG_CPU_V7A
+	const void *blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+
 	/* Extract device id for each mmc channel */
 	host->dev_id = pinmux_decode_periph_id(blob, node);
 
-	host->dev_index = fdtdec_get_int(blob, node, "index", host->dev_id);
+	host->dev_index = dev_read_u32_default(dev, "index", host->dev_id);
 	if (host->dev_index == host->dev_id)
 		host->dev_index = host->dev_id - PERIPH_ID_SDMMC0;
 
@@ -253,7 +252,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #endif
 
 	/* Get the bus width from the device node (Default is 4bit buswidth) */
-	host->buswidth = fdtdec_get_int(blob, node, "samsung,bus-width", 4);
+	host->buswidth = dev_read_u32_default(dev, "samsung,bus-width", 4);
 
 	/* Set the base address from the device node */
 	host->ioaddr = dev_read_addr_ptr(dev);
@@ -263,7 +262,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err =  fdtdec_get_int_array(blob, node, "samsung,timing", timing, 3);
+	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
 	if (err) {
 		printf("DWMMC%d: Can't get sdr-timings for devider\n",
 				host->dev_index);
@@ -283,8 +282,8 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
-	host->div = fdtdec_get_int(blob, node, "div", 0);
+	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->div = dev_read_u32_default(dev, "div", 0);
 
 	return 0;
 }
-- 
2.39.2

