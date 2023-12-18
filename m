Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE2EC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F8D876B4;
	Mon, 18 Dec 2023 20:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Af38i03u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC99F87620; Mon, 18 Dec 2023 20:12:32 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE4FA871C0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28b012f93eeso1425618a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926749; x=1703531549;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8wgaCKRATO5KhOzHFDTHEvlfjJpDYLmBV+y8Aj9OKg=;
 b=Af38i03uxbkkYyltNl4xhANYm5vq74yZitqe84OiGVcjkwHkmhc6111HpCTd8Y6fK7
 a8v+RFPrIM1DCRZ2oHxCPdb/nHBmAZdvlgQoGgeTTUKeqy4Jl5x6oEuV/5n7bNwi5vDN
 80nDUfgLlvjT1DFNOdowAC5F2z8QgF/A/GPaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926749; x=1703531549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8wgaCKRATO5KhOzHFDTHEvlfjJpDYLmBV+y8Aj9OKg=;
 b=ZfqY6vlrl/9BtzZLJAcY9+m92V26ad3be0FbM9rGy+LynA3k8SreEyedwUI2gefvAU
 7CSGSwTgjsGi56LskZzKdZhnNNYZ10W6txCrlcRXm4q3RBn3WiIgzLHnqTN6pTsVVIkc
 i0eg3W+NNQc7FbOTFNurQ4svnINBGkdtT9GQJ6xOmCOgrPCJaTmO/SCob3qEznPSsq5f
 mC4MQueXws7w2XFB2T7SW9L6Gvsz0QNuq7q8UL4RNpKq8fI2xgNeqQ4OKhoRbMV6Qfso
 k+9ThCS3vpRw7uRMjBvhza0HpayVnJp6gYAd7Y9THUczZ/Oyjnst5+qZsQREHQB60jUt
 U/+Q==
X-Gm-Message-State: AOJu0YysgKO2rapvyT8+ZlYpLpBAkDu7SRV/eu102H9dGUp+mqDqBS06
 HYw4AVAecFhunFJsKmwqNbBaaw==
X-Google-Smtp-Source: AGHT+IGvgZ6LzmottLQZ1MVIqtOmOEu5ekIUS8Z9ICefsBpB1k9vQYa1F6KThhz/5JFgUZonH1zEbA==
X-Received: by 2002:a17:90a:558f:b0:28b:313a:74a5 with SMTP id
 c15-20020a17090a558f00b0028b313a74a5mr1988427pji.2.1702926749219; 
 Mon, 18 Dec 2023 11:12:29 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:12:28 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 16/17] configs: evb-rk3328: Enable vidconsole for rk3328
Date: Tue, 19 Dec 2023 00:41:13 +0530
Message-Id: <20231218191114.129329-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

Enable video console for Rockchip RK3328.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 include/configs/evb_rk3328.h    | 5 +++++
 include/configs/rk3328_common.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/configs/evb_rk3328.h b/include/configs/evb_rk3328.h
index d10e5b1d2e..c985080f7b 100644
--- a/include/configs/evb_rk3328.h
+++ b/include/configs/evb_rk3328.h
@@ -6,6 +6,11 @@
 #ifndef __EVB_RK3328_H
 #define __EVB_RK3328_H
 
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdin=serial,usbkbd\0" \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
 #include <configs/rk3328_common.h>
 
 #endif
diff --git a/include/configs/rk3328_common.h b/include/configs/rk3328_common.h
index e920ec7e5d..2c40674b22 100644
--- a/include/configs/rk3328_common.h
+++ b/include/configs/rk3328_common.h
@@ -26,6 +26,7 @@
 	ENV_MEM_LAYOUT_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"partitions=" PARTS_DEFAULT \
+	ROCKCHIP_DEVICE_SETTINGS \
 	"boot_targets=" BOOT_TARGETS "\0"
 
 #endif
-- 
2.25.1

