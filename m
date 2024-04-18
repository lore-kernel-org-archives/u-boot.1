Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E318C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 09:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B89885A3;
	Thu, 18 Apr 2024 11:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="NQhy7Ocd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FDA4885B2; Thu, 18 Apr 2024 11:14:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1E4885AB
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a555b203587so60371566b.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713431680; x=1714036480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rd1Q6gJh84Bl9N5fQ0Bn0TP1W4PJtTj7HUVuOEfuqD4=;
 b=NQhy7OcdC4HoCvQkLJUvGQUVrSPUpKrRSkSZZgvGhq1Ap5aFSPcjin5Id4VxeoHTmj
 IqnKS95WlDkMYqqevZ40KZpdxHfhchs1KtZWJjQqb1dIbAGl1agqa0zuHBVlDhWhtB9G
 ybGT26Zmz4MwSwgyJhorwpQNx8BDx+RxZLewY7ZwPH2ghbdFlymFpd5QUc8XuatfyKwn
 PC4PI6xMmHTK/Ft1wO2r25WLLjrBkw7TMDbt7Y1lwqKWVaWkciVIGuRsbwAo3maa3GQW
 gvQeCYEiXvZ9v3jimUb/i/Ut2xePH71LBdZZ4jMrrLVrcM44ynCjiqfMc7zQrJQWvqUX
 mFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431680; x=1714036480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rd1Q6gJh84Bl9N5fQ0Bn0TP1W4PJtTj7HUVuOEfuqD4=;
 b=nufWcOLW3q6UR0ZHYP2eWlX2VaCbktb3pE8bnLWz5kip4IsykQpYhDGOBxiwRGrWPH
 G2fjS4WjSm1kOofTXWYZ0+bRT9w2/HpzEfsA67K+F/Y3AvbCeRIwqfzca4wTkJGHEpcb
 wRIv2OVXDgRKUdMPd7LbU62H7xHcnBGdFI7GPtxptPeM4wh2B7mB3PoWujRPvfQ5K78D
 fLfKwTlRkzDh+UeYwi18tEtdLSHHUbPxgqqG8dFApXH3N9xxXK3pJGhU3d7QOLtxOICM
 qtZb2Vr3ycmhAY8LfUWipeVn76zrkcuZMPIUb7t5t/xjCiMkSO+pu33VNa2YCXqwe6Es
 DTzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHSPBDQ0kB9pgc4dO3UmxBptvmf8rMMU19wiLgDv9ydxwN3dt3wFB3ylEG+fI4UTh+4GxJTvVOB5uyzs1dJQuSWTkYbQ==
X-Gm-Message-State: AOJu0YzwgKb8fUj2Whf1Gt9MsS4M0bvFy5FJhCTvdziM8W4nDBlVjO2G
 bm65n1R25Raa3HZYtk0bc4+iI+xd7iJzPzEpeNn3XrMbK5KtXurRKl/HQT8wfbc=
X-Google-Smtp-Source: AGHT+IHo3SMhkjKud/gGBRLdy4wPa8XgQezKxLps4X5ExGKnzUDRKolIQlkXN38IY6rCdl26bwjZyw==
X-Received: by 2002:a17:906:452:b0:a55:75f6:ce0f with SMTP id
 e18-20020a170906045200b00a5575f6ce0fmr674087eja.13.1713431680375; 
 Thu, 18 Apr 2024 02:14:40 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-161.dynamic.amis.hr. [188.129.45.161])
 by smtp.googlemail.com with ESMTPSA id
 c19-20020a170906155300b00a526a99ccecsm624322ejd.42.2024.04.18.02.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:14:39 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/3] mach-ipq40xx: import GPIO header from mach-snapgradon
Date: Thu, 18 Apr 2024 11:14:03 +0200
Message-ID: <20240418091435.18232-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418091435.18232-1-robert.marko@sartura.hr>
References: <20240418091435.18232-1-robert.marko@sartura.hr>
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

Pinctrl driver was refactored and moved, but the required header that
it depends on was not included.

Fixes: 24d2908e987a ("pinctrl: qcom: move ipq4019 driver from mach-ipq40xx")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-ipq40xx/include/mach/gpio.h | 37 +++++++++++++++++++----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ipq40xx/include/mach/gpio.h b/arch/arm/mach-ipq40xx/include/mach/gpio.h
index a45747c0fe..53c6ae0649 100644
--- a/arch/arm/mach-ipq40xx/include/mach/gpio.h
+++ b/arch/arm/mach-ipq40xx/include/mach/gpio.h
@@ -1,10 +1,35 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Empty gpio.h
+ * Qualcomm common pin control data.
  *
- * This file must stay as arch/arm/include/asm/gpio.h requires it.
- *
- * Copyright (c) 2019 Sartura Ltd.
- *
- * Author: Robert Marko <robert.marko@sartura.hr>
+ * Copyright (C) 2023 Linaro Ltd.
  */
+#ifndef _QCOM_GPIO_H_
+#define _QCOM_GPIO_H_
+
+#include <asm/types.h>
+#include <stdbool.h>
+
+struct msm_pin_data {
+	int pin_count;
+	const unsigned int *pin_offsets;
+	/* Index of first special pin, these are ignored for now */
+	unsigned int special_pins_start;
+};
+
+static inline u32 qcom_pin_offset(const unsigned int *offs, unsigned int selector)
+{
+	u32 out = (selector * 0x1000);
+
+	if (offs)
+		return out + offs[selector];
+
+	return out;
+}
+
+static inline bool qcom_is_special_pin(const struct msm_pin_data *pindata, unsigned int pin)
+{
+	return pindata->special_pins_start && pin >= pindata->special_pins_start;
+}
+
+#endif /* _QCOM_GPIO_H_ */
-- 
2.44.0

