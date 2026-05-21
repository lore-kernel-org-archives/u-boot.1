Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1C9CD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:06:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A2F84837;
	Thu, 21 May 2026 20:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XP0/34Kr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I9kT69nA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9605F84825; Thu, 21 May 2026 20:06:44 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051B084874
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGk35c374075
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TXstu3mA1aP
 5AsvBUAoTKlyNrD3tLS6HC4QodguhUWA=; b=XP0/34KriNLNytg+/LZSIXnr+qd
 JPYmu3SNiPEEzMgPPu2BmrnWe3pdlwYksonqCWpMjDJezgQfHWtzAqW4BEEcj3KO
 5IEMA+2BfwPhR7oeU/2bxQsj6QKkbIg1qtqg520DhjBUSa3k/hIVxgBLI56cKwpC
 ff2ERiCey/U+Vp+h06WzB6ZQkVervLJzeMDbR3xOEkv1kcDVkUk7sAKXTnCUkjkE
 pEPefxd467qdia18U2SK53uCL+QIeApA5MhlH9+fdvLnEyvmlNxUUA1mxXbMDNzk
 CjMTGS1KYQEaz1SyJIJFdR0y8duA/NCrS65WYo/tYXGRF+KIZYHeKFvFhNA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9vhbk1ge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bd1dbcccf6so106491115ad.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386796; x=1779991596; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TXstu3mA1aP5AsvBUAoTKlyNrD3tLS6HC4QodguhUWA=;
 b=I9kT69nAIyTerWhYQs77ikJgX/JDp/f2x9Kjy/qCfrll+TqIgfEAs1DUkLBkqc7LIc
 SI4dYbzagdIixSU99LMaqk+4m18j328VAHvuMpd7HTNQUkvy8wS79g3InLbDIyITFu3a
 /CbPKbYKo+GOvZk7x9tOqeYlTaGX9N0W20+xWBLJO3ixeAghKaT83yHbayYaxCU1haaa
 g/EFqvuV0h9LU35GUOx8U3oi3frtG6NWEl8lQkluL7SPsDWc/Siwnjv6ehQpo/qth8Az
 wqkKrmHUuxFRgRMw4MmUy1kmgLMNMohB9zEyjB08KrIiKhr1ZLslXvV5FPtPuXmDnRLp
 KUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386796; x=1779991596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TXstu3mA1aP5AsvBUAoTKlyNrD3tLS6HC4QodguhUWA=;
 b=eIPN+2DeUxdbi34sKk/z7FPieOrJVyM78IiGEiI8YAM0rJvpgArnGNtNXIzhLPLP+x
 PtkQO1taZqPzByfM8mU1skSsidPNk66wWVqgA0BZhI6yf7Np8rNnTZjf7hO3f+Hrtbz3
 DifFMTja1z3mr8I/xaGI7yAr8Ta+v+RFtrneciE4wC8bp7ibO5yfCb9EnUNo5DL2ypk8
 XDMdBz6C6CJ7ihU4a4SvbRWxc6AW0L/EV8z+gSVe+TCIY7bZ6sXgo0j02gjl9K+YfSeA
 tRfWg6Tlx1Cd2g2s3n01FvqD7G2J4ys+x38VQ96QyU4bvvzVcwfkrtEGYrMj+gJz7VYg
 vGpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/x9vGkfbVIsRpL+jolD0FQjAK3r9jREwNOoW2xgyMfhJ7pMhYFe4ptV1ONVS+770uz1imwH0s=@lists.denx.de
X-Gm-Message-State: AOJu0YzPE0dJzyTCU82cEg3NyVDnWDj+LTOFrAEcxN6Ya0WBef25epXJ
 s6YgCGu35Eu+fJgAChzEKQ1cvXDuNNpCWDf9z0FPPBozhftBIY6B4E+IhE6xfJaRRzx9HbNsxFA
 4RZun/pLbqDUveem4QfklXRIHr7uX9XXOuFKF+JsniiWVUw0KteXeuudI
X-Gm-Gg: Acq92OHf7rGBmRQy0MbhqJVISGlxpZgILt2U2nI/Og3Pyi5hXrRrod8jg/LVQgoAWsX
 O/j8DCmgytiXxdEvoRAIdwGRIvDJtbzxS+Sq/tS608HveFzZK/X96YHYTGDT3H0z3EhiLKjX0rs
 hdRuMPoKV54iEP1rBRjFtvqs4Th0T42m3TX2NapA/PIsbbwho1ngQIGSxwnaNcpyTcl3e/eRqv+
 A7pGe/BcNkEo8wNLM3p/jCQwEZ7JqtGy0F2ukciriBrYsBU7r4R6GshO2n72D7f5po5jLzvUQZg
 mRPOp21jenNi9QuJsSeNJ7OGa89Xbw+zHJcQvQPa26cVmpxfmOuVWpjvC9wejkWKjv6FPodeuhl
 ybWHyLV7/UdUr4a2nTZon3iHmmjWUM3Gf2xHNtFWHvDvYNYi97q+qPkrYlTGx8qDau3SA79ARnB
 +qvzZvS/WpAnb7nBXFbcbFKQijnJ6p2gZLSfMKuSjM
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2beb06924e5mr102545ad.29.1779386795873; 
 Thu, 21 May 2026 11:06:35 -0700 (PDT)
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2beb06924e5mr101715ad.29.1779386795046; 
 Thu, 21 May 2026 11:06:35 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:34 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, clamor95@gmail.com, m.schwan@phytec.de,
 msp@baylibre.com, aswin.murugan@oss.qualcomm.com,
 lucienzx159@gmail.com, sajattack@postmarketos.org,
 luca.weiss@fairphone.com, varadarajan.narayanan@oss.qualcomm.com,
 peng.fan@nxp.com, anshuld@ti.com, ycliang@andestech.com,
 n-francis@ti.com, jamie.gibbons@microchip.com, justin@tidylabs.net,
 quentin.schulz@cherry.de, michael@amarulasolutions.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 3/7] reboot-mode: add REBOOT_MODE_ENV_UPDATE option
Date: Thu, 21 May 2026 23:35:45 +0530
Message-Id: <20260521180549.282377-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX6bJElRp9E/kZ
 62pe9Pcz4hQGK4WpPueA6kWDzWyP3ev+nrs12kuHFk9ajJseNkfj/w+on/sSY9gQJjkpv//dNav
 vfWnZwBE2NcfKkakgXr2Zjb8Q8R/jfseWGTAmvyht6nnF0Jht0exSkEw/6uZHeRnlKXCcP/3Ddj
 hdH2ZfSRb8uQMrywwRdhASclayqglvooS4F/FQLhfsDBjxoW2x9nvvS95YKYWYzpBv61hMfb5L9
 sW6ZPfYHX+GDugfvlWZcCRTr3coxymr0meAYjtmfG65G/X8mGVqqpkBxXLOUpHE3BXqI+BCtyja
 Xb8Y6Kwdn/JVOtm6h5zMGkP60sFpxkRJI0FNc4Uxr/phfBcvgfjEbCkMc4kn6YykPkhuUsk5snY
 vdIiC7j12UiaUcfdZvgU+mZhM7QfSMRj94QanKfHLo7r7UX6tJWA8M5RfIaysDOm7U8C3zWveky
 sLBcYRNyfK3x9429nZA==
X-Authority-Analysis: v=2.4 cv=GYAnWwXL c=1 sm=1 tr=0 ts=6a0f49ae cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Was2I079b4wdTqC6JN4A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: mtd-St6llo-j3qFbjclTZ8cFvZcE-oO-
X-Proofpoint-ORIG-GUID: mtd-St6llo-j3qFbjclTZ8cFvZcE-oO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210182
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

Add REBOOT_MODE_ENV_UPDATE Kconfig option and implement
automatic reboot-mode env variable update at last stage init.

When enabled, the reboot-mode uclass registers an
EVT_LAST_STAGE_INIT event handler that probes the first
reboot-mode device and calls dm_reboot_mode_update() to set
the reboot-mode environment variable.

EVT_LAST_STAGE_INIT fires after the environment is fully
initialized.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/reboot-mode/Kconfig              |  8 +++++++
 drivers/reboot-mode/reboot-mode-uclass.c | 29 ++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/reboot-mode/Kconfig b/drivers/reboot-mode/Kconfig
index 72b33d71223..6e8825f1e67 100644
--- a/drivers/reboot-mode/Kconfig
+++ b/drivers/reboot-mode/Kconfig
@@ -39,4 +39,12 @@ config REBOOT_MODE_NVMEM
 	  Use any kind of non-volatile memory (EEPROM, RTC, etc) to control the
 	  reboot mode.
 
+config REBOOT_MODE_ENV_UPDATE
+	bool "Automatically update reboot-mode env variable on boot"
+	depends on DM_REBOOT_MODE
+	help
+	  When enabled, the reboot-mode uclass will automatically call
+	  dm_reboot_mode_update() on the first reboot-mode device at last
+	  stage init.
+
 endmenu
diff --git a/drivers/reboot-mode/reboot-mode-uclass.c b/drivers/reboot-mode/reboot-mode-uclass.c
index 7cbe02eb4ed..976544d2810 100644
--- a/drivers/reboot-mode/reboot-mode-uclass.c
+++ b/drivers/reboot-mode/reboot-mode-uclass.c
@@ -6,6 +6,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
+#include <event.h>
 #include <exports.h>
 #include <reboot-mode/reboot-mode.h>
 
@@ -116,9 +117,33 @@ int dm_reboot_mode_pre_probe(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * reboot_mode_last_stage_init() - Update reboot-mode env variable at last
+ * stage init.
+ *
+ * Called via EVT_LAST_STAGE_INIT, which fires after the environment is fully
+ * initialized.
+ *
+ */
+static int reboot_mode_last_stage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(REBOOT_MODE_ENV_UPDATE))
+		return 0;
+
+	ret = uclass_first_device_err(UCLASS_REBOOT_MODE, &dev);
+	if (ret)
+		return 0;
+
+	return dm_reboot_mode_update(dev);
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, reboot_mode_last_stage_init);
+
 UCLASS_DRIVER(reboot_mode) = {
-	.name	= "reboot-mode",
-	.id	= UCLASS_REBOOT_MODE,
+	.name		= "reboot-mode",
+	.id		= UCLASS_REBOOT_MODE,
 	.pre_probe	= dm_reboot_mode_pre_probe,
 	.per_device_plat_auto =
 		sizeof(struct reboot_mode_uclass_platdata),
-- 
2.34.1

