Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D96EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAFE686FFA;
	Mon,  6 Nov 2023 16:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yGHXs/El";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EFA86D7E; Mon,  6 Nov 2023 16:29:27 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B538986FFA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso35362425e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284549; x=1699889349; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ohm0Ty9NZ/yJiYODYeT3dcktkgD6Cz39pMYzl1qtWE4=;
 b=yGHXs/Elj9XIegF61Sv/02OrrJe616tzRmaR2DMPQ2X99D9bPGoa5FP8gbBkPr7uuA
 r4iW9ny+9apk+iled7WSxnuKZrNPb1M3I+CdtzcoxB9l2MMmoUFb1H5Csuc168xedjHU
 Pnc1cdGmJe4g4Mxnt9QnYzVEMYZNXsMQE3jLQjbgvp66HGnlVe2S1pIvl8K6nrbpLpKH
 JAyQlbzxM+M+Ctj8puu2rjVk9UlEcifIvb9candDkcKVOtmpZcqz5uauqdyl0O7GNJdm
 SmhwE5odgLJg6vit5WRUXRF7kAUtXVP/lw+7/qljLiiSQBx34gbMZSGsrb2TRA10m4FT
 ab0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284549; x=1699889349;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohm0Ty9NZ/yJiYODYeT3dcktkgD6Cz39pMYzl1qtWE4=;
 b=e2tR2WWzYLRNEIhj5lbWua6ALh1Iemk0asgUGhLOMu0mABKvZ8wa9gOEy2rJoGVlUd
 nZrM1DVmfXtxAtWynlJAmJtFnX4xTgTm+/OUiUqJQShyz1dJvvjAjAlNlm5wvRt+9Zag
 qlW/MN8A1X9gDmZs/XRAC66AM7j4eX2CjJCY82fedODFBed0s4rhtNhlgW6uFV4Xd/tk
 3W7cZW1GXV4ABio0+1TBey53bqa520RD0wUwOM+jadyE4pLFgBE+QjVOYi+vXn/dmxRG
 CO2wXONUhNx1q3/D8VL5i02xAE52hSc3PzhiZhQ78Q9VebrPPqBPDdZlV05K6MCrv5mV
 Ms2w==
X-Gm-Message-State: AOJu0Yy453uE26fdVpff/iPosVE+Lx9bSIJtblllXpzAcuu+F6ZXwSRn
 /sRcXIkDEbMFJM0YLqNZc6BowA==
X-Google-Smtp-Source: AGHT+IE0RI+noZvYs7u6gDFOt7TtIsaHBvoOXbbQ3MttWcFNg8Hv3kyn841abHx2AZIbsfnKsqbJfA==
X-Received: by 2002:a05:6000:144c:b0:32f:7901:c462 with SMTP id
 v12-20020a056000144c00b0032f7901c462mr26407559wrx.3.1699284549245; 
 Mon, 06 Nov 2023 07:29:09 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 bx30-20020a5d5b1e000000b0032f7d1e2c7csm8116094wrb.95.2023.11.06.07.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:29:08 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 15:29:04 +0000
Subject: [PATCH v2 5/5] fixup! pinctrl: qcom: make compatible with linux
 DTs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-pinctrl-v2-5-406e8d8689ca@linaro.org>
References: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
In-Reply-To: <20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=449;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=qwiGsHKwozAMMS6EVpb+Q3aDDHWfLWZujYHlXyFYC0I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRPNjsGsdyN6h1VFp5VCZp/lp7QOjO3Q8TO+csHntkHt
 NmLGc52lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQ3h4hSAiUx8yfA/c7mqlk7jjNN+zPNX
 Rn78enNHu87OScYBBwO9D0z2iriQw/C/yFVSqVdv5clLzWyl/DOYCr4yCd4IjmHadmqZuWiQqnI
 1AA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

---
 drivers/gpio/msm_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 3e4a0194b10a..80cd28bb231f 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -11,7 +11,7 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <qcom-gpio.h>
+#include <mach/gpio.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.42.0

