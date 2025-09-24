Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2261DCAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBE3835BF;
	Wed, 24 Sep 2025 17:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VkTlUxAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D44980B9B; Wed, 24 Sep 2025 13:31:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1612A833ED
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3164978f11so238360266b.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758713486; x=1759318286; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eP4LPyR9/5VvG/jgDPIA6h91H9iU586DyZ87hAD6Pj8=;
 b=VkTlUxAPqO/8wG7HlIqU1ImogzNRdGwTJe7IccnOR1wplbGOEsdInbIIan1u6lpINZ
 0EeK3d6NwXWP9ytkICf1Pp06xlXcHXCnUxDgkwCNuUVN+WrqAfwH+PwX7DemSaPh/LDG
 lTPOABq5n6VvUuUspeARGrifOZvQhKOcyIBN9LWlQGj46CZvsWteumkcEjAhien7Ba1a
 irPb/Z8VYIap1yxIuViqemVO2pTDctGfGVJloZHr37+uI3ZsXj5T97s88G1eq1xpo2Gp
 yr7Siz9aw3GjT9Nz5LOhatSLy6KSvAm1dpJZFe/88YA55ZrSFHTVKrqWpdRPmvOxyta4
 Qlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758713486; x=1759318286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eP4LPyR9/5VvG/jgDPIA6h91H9iU586DyZ87hAD6Pj8=;
 b=ml5mXje28x5CQN1tVcwby9xbfELXvEt7HWgOdYMSefD8ZvM6BkMBk43foqHCWcuMxb
 QVrzmZmOsXDkPbAXjJBS5rEzdNqLyVwCqnaaUExhTK7urmi2zJkVBMpZfUuwJbmw0TWh
 31LeP6G0q/FnOIKOAwmz3r43rNcG6/FG2I+q0NfLOpArio/WtnaKRZFdYTmbLnNF/Gf6
 58t5ED6AWBmGCl4n/Ll0rOlwvIbWaYdWTRy/ZKOYIzf/5xoTHz6l2tZYl+dMl5TGguhy
 NB5zeSN188CHA6tQOoNRh71Vno27jjkhb2fDddF5M38ZqIjTs2NYUbQ34pcizGz3PX/l
 /b9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWwRD2F4LxyQM9SL0rvcqZ8ZIz+UlMrMSG7KgkHFK3zuDCfNfC0Q/+d2ZXmSZ0ZohLwqsbEts=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+u+OwKKCYk6aKHKhqZIA1kSl1IeQUjTthnsvDOy4A7i5BdQ3o
 1ugJFMUzaAUQ9WDz3x7X+ryFlcmjhST5Hgk2gRssXRCnVqyc0zE9/K29UCw2q85h4zw=
X-Gm-Gg: ASbGnctSlWxRG3V0dkndJXsyvhNlMK+jpLFlm2hsyDZBOLrgxuer7Wi55N24srabTeK
 Vwh96bWGVF4uXbNmwZfB2zDuRQmw7IcsHRbK4oNc+er8W3M3nDOISvpU7RtLkI8oXMSgarZPeuO
 jFluQhXanl4ofdVMR+HCsSzU6I+a/BAv2Jk0BDQuS/bk4HZrg8BbAZiYfLHOhuEFTx+2xwod3fG
 DXo1yT9nfEseUEV6z35eYOV9CaEbYyQ9ZxoDo4a8zRO/H8J0VrqShpfRP2JxGAPaPAKFcVBs1QK
 RMRBWqedRFy0NAjbOPoGmi5BQ7MQzeaPZQaGdOjCuMfubJ7n25Xp+CEoS2+3TbfNGJ+kM5jGlV4
 C6oudRZH4/mSREvf20eHD8l9ErMWuLoGBIc7apyTz+JwBE42nc1RSVkF6KohT/p+i725FIg==
X-Google-Smtp-Source: AGHT+IGz3vyW7Nvwn8gYqwan3SPW2BtzRbEbSZq9SqQWyLhdRM6tXcubJiiOimVGpfF7QxIoCxBvpg==
X-Received: by 2002:a17:907:9403:b0:b04:c373:2833 with SMTP id
 a640c23a62f3a-b302a1795e3mr560135866b.32.1758713486430; 
 Wed, 24 Sep 2025 04:31:26 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3339789812sm96698266b.17.2025.09.24.04.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 04:31:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 24 Sep 2025 13:30:08 +0200
Subject: [PATCH 2/5] clk/qcom: sm8250: Remove unused defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-2025-10-misc-v1-2-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758713484; l=1013;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZGpS7nImmc5V/CEBaaIJFuo8SyXkNjVuMtqw6u0/9ao=;
 b=g6qzWfvymnydWqyE+rJGCHLojkEu9qHimjg+q7HH296LjjZ/B9oAsyHFkqT+/50wfPU4HUxgs
 EHFn6/dM5VKBTYFWoaDR4b+dxZ3u/QWGSLIM76/ZodLwq6fZ4NlYeCl
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

Clean up some defines which are not used in the driver.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-sm8250.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
index cc481258d2266a40c54d51fd2c5faee22ea9f2cc..37268c4eaf5a6c89f519cf9853101717ce86b9c9 100644
--- a/drivers/clk/qcom/clock-sm8250.c
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -18,14 +18,9 @@
 #define GCC_SE12_UART_RCG_REG 0x184D0
 #define GCC_SDCC2_APPS_CLK_SRC_REG 0x1400c
 
-#define APCS_GPLL0_ENA_VOTE 0x79000
 #define APCS_GPLL9_STATUS 0x1c000
 #define APCS_GPLLX_ENA_REG 0x52018
 
-#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
-#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf064
-
 static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s4_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),

-- 
2.51.0

