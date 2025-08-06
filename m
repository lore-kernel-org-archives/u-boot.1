Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809E6C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CCED83B55;
	Thu,  7 Aug 2025 00:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cu4nBeuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E9783457; Thu,  7 Aug 2025 00:27:38 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C95683B0A
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3004ade907bso260979fac.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519236; x=1755124036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B89BIWQNmsoGaA1keXWg/Bl0OT8Zt1fLOuvTPuu/SPU=;
 b=cu4nBeuIkvL3yM6c/ULCRcTz62kuXNOfGun6FOdopvKXzxikgjyHOYTBVEGhgJiQrc
 jW6KmwYQF5tB84XIk/AltShHv1S51mJSR9IjgdHboVWbM5PCUSN3UwXykrlzosAMQiHQ
 olHpmQ2eL8uSKMMt5LzNxZ1V0gjbKow9H/2EL399bTEouRSyzrisdRLUAYB0owrBUWTN
 X8DTpgRtMkzap5iVHj7NlyOXOWQJ5xA/2+ejUNXgIELjh91f2LZtgW3uegXgRd+fTC14
 uvSIcvzS3DaZ9jAjqsnPRYEpOE0aBXANfYGt2bVKEB9jWFAJOHdwxqigtDFB7MEXRCkT
 ZAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519236; x=1755124036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B89BIWQNmsoGaA1keXWg/Bl0OT8Zt1fLOuvTPuu/SPU=;
 b=aSA/mOaTTIseNwu6xhX9hHxrmcMtMoP4EBAwdai1g8DhTJ607ZxvJ5QeDNYeIHR62D
 Am7mHDlYTtrxb88nAgTzCRYOJn9u/CrFg5ze7oHQ3nEJzyWESCKdyn5fiSuTMkjzoj4Z
 ZIZEKYuRRpI1xngNsRpYZWtqq88IVq+nPk8fOcXZldYadRgW5L0Zl5G1wLn+9MHpYUOY
 2jEJ1LbpsmJl4Tgly5V3iL1g4i6IxIESRjnKSu9EWibXgC9+G9RgaA3Smld7h210uLtG
 SXz+eLIjvUS1lyzL7bNS2dfyk2/2EUp/e2uTHsStturnUk3awwA/RebG3OdFlX8lHUJw
 SaNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtdDtphNk5VeFeBY3zNvX4j+RFlnhB6pl9DaTrQSAw6IBlGfKmqb/s5FDzm+KWnjDvWctoQYk=@lists.denx.de
X-Gm-Message-State: AOJu0YzToJ1/PJ+M+A/LYQ0j1SP8vJ3sWIaJEA1qPZfO2VV/xOQUOmQQ
 q+Eik0TTrOrGGIgpZgbmy+JiyeaCiC4CiSkuzScFOmpaSyY+1vKDeEOc+Q4eMzh/O3M=
X-Gm-Gg: ASbGncu9SdJKjQhwl3GesX3d6MYBf/hXPn4fl0m+0ppNSYgaYTBmUOI8Cl1KviWqYGK
 b0L6F/v62xKYPjLl2Z+R2hoaMbRmH7ocprTR2oUVCOET+RK1U6yLtAZAqEE+0IQwqlpS0kpLCEG
 CH4OyRCcjUIp6QOYz1wZd2BeBh0iYqHxlGI8PPVgWeTpuaPOSAzGB9IPRH0FYA5AS96Hm37I0mz
 TpFZc3CjY5stuBjVswHdjPnlOE9YOyioRNGWV+h9XSr2wL7ptKcknNNC6A/9Sch5xwFngsIhIFR
 iySrcibuUBO5r3SNMT1ONLFPALriI1IQQLwcH7HBNzUXOjUAWg9rclwhNM32BzmwpUVKuAuUfLl
 EYyAifEeNy11hyzASZ6MLnPY89g==
X-Google-Smtp-Source: AGHT+IEiTDHLsngR5coJr/NW+hZ4vZiIar6bkUaQJVhXyCDO6pw0cmdtO5T4H32FxSnwHJ4WoiowMw==
X-Received: by 2002:a05:6871:522a:b0:2ff:94ac:c40b with SMTP id
 586e51a60fabf-30be5e05e43mr2650078fac.13.1754519236099; 
 Wed, 06 Aug 2025 15:27:16 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8345fef0sm3001081fac.15.2025.08.06.15.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:15 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 05/10] board: samsung: e850-96: Configure PMIC regulators
Date: Wed,  6 Aug 2025 17:27:05 -0500
Message-Id: <20250806222710.23773-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Make use of PMIC configuration routines and enable all LDOs that might
be useful for bootloader and kernel. The most crucial regulator being
enabled at the moment is LDO24 which provides power to LAN9514 chip.
That makes Ethernet controller and USB hub functional.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index d489716bfdf2..2cf874fcf7a5 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -11,11 +11,18 @@
 #include <net.h>
 #include <asm/io.h>
 #include "fw.h"
+#include "pmic.h"
 
 /* OTP Controller base address and register offsets */
-#define EXYNOS850_OTP_BASE	0x10000000
-#define OTP_CHIPID0		0x4
-#define OTP_CHIPID1		0x8
+#define EXYNOS850_OTP_BASE		0x10000000
+#define OTP_CHIPID0			0x4
+#define OTP_CHIPID1			0x8
+
+/* ACPM and PMIC definitions */
+#define EXYNOS850_MBOX_APM2AP_BASE	0x11900000
+#define EXYNOS850_APM_SRAM_BASE		0x02039000	/* in iRAM */
+#define EXYNOS850_APM_SHMEM_OFFSET	0x3200
+#define EXYNOS850_IPC_AP_I3C		10
 
 struct efi_fw_image fw_images[] = {
 	{
@@ -56,6 +63,13 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
+static struct acpm acpm = {
+	.mbox_base	= (void __iomem *)EXYNOS850_MBOX_APM2AP_BASE,
+	.sram_base	= (void __iomem *)(EXYNOS850_APM_SRAM_BASE +
+					   EXYNOS850_APM_SHMEM_OFFSET),
+	.ipc_ch		= EXYNOS850_IPC_AP_I3C,
+};
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
@@ -133,3 +147,14 @@ int board_late_init(void)
 
 	return 0;
 }
+
+int power_init_board(void)
+{
+	int err;
+
+	err = pmic_init(&acpm);
+	if (err)
+		printf("ERROR: Failed to configure PMIC (%d)\n", err);
+
+	return 0;
+}
-- 
2.39.5

