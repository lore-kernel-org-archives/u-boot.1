Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BECAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64080835A2;
	Wed, 24 Sep 2025 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="qG7Ktee4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A3183542; Wed, 24 Sep 2025 13:31:30 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E6680B9B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b04ba58a84fso1131086666b.2
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713486; x=1759318286; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KydBHPAWJZOhpksHXCHzM+in4qGGJIf0hL3uEDfsAtI=;
 b=qG7Ktee44/Eq/MXFTEjcGI7Pc2BN26e+xRu3HteSECTd4t22QaMgYHtsxAvVS71Ft9
 T2vd+juALlpeB9E/6d36TJEeAfO5BSyF3ouVcoiCWgdl6UA7qjV2Ci1kkGbrLHdTex03
 wwPMySNmbiFAa+Cg+squGeuAFrP3Uh0LSNYy4s1Hxa9XRDvjbHYz0FEH+0LO4N5FTiL0
 D+tpYHHOvaPCXAFsdlInfTSle0CTGY7pQzXNHzHpriZzP7QAm35r7Fh0YcHP4WwNkv9V
 cOJvSN8e7YRbPuw2NKov1H2cnBSr7Bi9dGXujO6qvGIzjixCslItSeo91cllV2zbOSyt
 SyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713486; x=1759318286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KydBHPAWJZOhpksHXCHzM+in4qGGJIf0hL3uEDfsAtI=;
 b=IVLgDUsFdegDiR7+vIPrgaV7M5cctidu3wwbj0mfwXRA7oP8g7He6ZfxJgAwNQR8vz
 kfbsQ9VXM09qRue9RBBYIS2XI6ZRRfzYXy0mkSdEFDZgth2Jg8RCazrhmjoYUWv8ddLQ
 pDfhoqjkxeO2WawRLx09kJHfhJlwjTu498JRm2PVReoPQ1AkTlIh0Pa9DlSvKEumM9bw
 B8CMFL1tdCvlgAc7whOxT8V1JwZTUUCtPkTJj/KuCUh9XZFxpggE+mzakpEiwpUhVeij
 fgPuKZJ0bK1fZ+wuTkLP2BAQ/Qdq0UQ3BaR63+Cx0cy9A3bZ/5VdUJM36WMGREhxarqJ
 /qTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBxTsX4avdP2ZgtItii2jcWCnE9hc8KzSEyWfR4zoYoDBUUnvHTCwjM1k+5HJR3fX2EXRTuz8=@lists.denx.de
X-Gm-Message-State: AOJu0YxgLx65hNToUvtHBgAKq6nr0rrfygNtLQCs72pk8tVdCg5j91iq
 4h0QxP40opKp1tmbG2gBRPBvojpKGVkyaBoiGwOe3gRP/mK6enqHPUdyNK6zXRCywV4=
X-Gm-Gg: ASbGncu7pAc4/CSCaaEtWlsYy7vcdzg7UfB4iqbAqO4W4oDF57edSIHtt/1Ro6hXz0P
 ovefn6o+2zZIL/QA6zW7BaEkG0Oe8yqSWGfu3FQRITjehwdZ9HfsVis6LARkP7ZKgVt2cDG5Y06
 bAd75EpIx07KLsBG+YapgmBAIZBpstu/satl1JIS9qZgpqIvl2jjsVjpgvEcex74ngybgOKZYl3
 PGJ3OAdXfAyN/eiM5IegMx6tjQUk89SWxBH+XVpB8Raxo6sKjpPISgwuO4gwVxARhIL0wAl4L9G
 MgnlRh/Cyx1KHFke41c4Rdr0xjHD+ToSMIJlHfP1qya4YibE0G11+L2h5Kh3Poja9vEfNiKEYg6
 l+apOtl/XR7wk1ktViQ4IfAsZVMvbz89ZnQ4DsIk3ucdD0RR2wJ76CX0IQS+rqs964NOtgw==
X-Google-Smtp-Source: AGHT+IHEXiEpVYI0U27mEuG4eH1gigHOMwA72hky20g+DcWkjTgxF772mH67f0xxjyRfOCyngzsRAQ==
X-Received: by 2002:a17:907:6092:b0:b04:6045:f7ed with SMTP id
 a640c23a62f3a-b30263b8ed0mr645235766b.10.1758713485910; 
 Wed, 24 Sep 2025 04:31:25 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:25 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 24 Sep 2025 13:30:07 +0200
Subject: [PATCH 1/5] pinctrl: qcom: sc7280: Fix offset of UFS_RESET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-2025-10-misc-v1-1-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=1254;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=gfatSIUBXZvBwzNYO13WLnimoJmk2JArVeW1hBdJg9s=;
 b=3caAoAZs/8OGStMjTPF+MwJ0hDz49HKuxbE/DYGlsZV4a0N75L63Ll+LC65lcGdvLgl7QjWON
 39wzJf8HkZ3D9W4xttQmYV+hDJnMBBrMUdXUjjqZ43RFW4OkKpGNRpJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

There's no WEST, SOUTH or NORTH in sc7280 pinctrl. Fix the offset of the
ufs_reset pin.

Fixes: 51ec7fdb64b ("pinctrl: qcom: add sc7280 pinctrl driver")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/pinctrl/qcom/pinctrl-sc7280.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280.c b/drivers/pinctrl/qcom/pinctrl-sc7280.c
index fe87947fbbf9c27509498c1da982997e4d542478..d62b2cc6fb6b3e50773df7cd8bdedd43841c540a 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7280.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280.c
@@ -10,10 +10,6 @@
 
 #include "pinctrl-qcom.h"
 
-#define WEST 0x00000000
-#define SOUTH 0x00400000
-#define NORTH 0x00800000
-
 #define MAX_PIN_NAME_LEN 32
 static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
@@ -47,7 +43,7 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	}
 
 static const struct msm_special_pin_data sc7280_special_pins_data[] = {
-	[0] = UFS_RESET("ufs_reset", SOUTH + 0xbe000),
+	[0] = UFS_RESET("ufs_reset", 0xbe000),
 	[1] = SDC_PINGROUP("sdc1_rclk", 0xb3004, 0, 6),
 	[2] = SDC_PINGROUP("sdc1_clk", 0xb3000, 13, 6),
 	[3] = SDC_PINGROUP("sdc1_cmd", 0xb3000, 11, 3),

-- 
2.51.0

