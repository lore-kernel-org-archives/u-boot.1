Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD120CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8361891AA;
	Thu, 19 Sep 2024 16:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i0dxhynQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE84891A4; Thu, 19 Sep 2024 16:02:52 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E477E89137
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5e1baf317c7so341292eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754568; x=1727359368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKpUeGtD4Gby783ZNifLzopVA5FXIAdfJfSwsk+OrGI=;
 b=i0dxhynQ8nV9bTbwV1XxrfsDAuREgQ4yw50BMN2hEG6LY8yu6PYkFocxQXC3ODjN/S
 VAp0NizG01D8u3lZ9BmR4UiRQm7NLb9UZlteG0sDiUm4y0vzQ2vx22LPUvx9HjScss+v
 f+Yxef5bDHlsnbGRjZvr3/2azGtRrk7kEzQCcSV9ejWG5no9Sj55LSWRYzgBXvOn+ALR
 oismGmBbc8vHDUYjvHCHbAiycJSaGYYydca51Bu9Cy+88MaSy9hTCVtyL8tGyNnn9N7n
 yixjNavKbaM9ftASq12zSyw9PityPQuWOLl1isK0UGXVdmxS4oqD6HhQJp5kxoXvIaz9
 BWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754568; x=1727359368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKpUeGtD4Gby783ZNifLzopVA5FXIAdfJfSwsk+OrGI=;
 b=nA0EkCpjwS+eSD6N/dFjPB2t0No+T+rSVi8Qphmv0AIVFZDoNXi9eeCMkX7oHtOqFj
 QS2I6BzE/g2GbRAvluShuNQDnjFhzE/JNaEZf4qP0s/6s2abA6iGzpRhVudS2/foCu7K
 DZ2i8WRIBjaxZ2cong18gndjY1uVDhuQI01Zn5Ub18y65hi2OpnljFiqzNl2cIOBWqMw
 I8UhoR+VShiWB/vDUNOwhix8092w7j2RASFcETg+p3J03q9NOpw8RgkBaWWtGyx2MCM+
 vJl6ECaac9N7/63Mz5E6h2H/brKL4ZxXP39NlRLJtX5NYAq4ygrojBJ8ij5CBNofc0WI
 6J4w==
X-Gm-Message-State: AOJu0Yy1ZH74UBaPJzREL94R3nN8YkOQnuxR8KK1SxjaO0h2QX+j4szc
 ddZfrmJrffghkXo62UIZy07aLitRJSm5FwMlnpQq/sVlvrtx519qsyRJ7AyQ
X-Google-Smtp-Source: AGHT+IFL3LsVApIigmuY0dQdsj1ys3ajBTH1y0yvc0C+lcpObpbzwFV+6Pnv7Z0Nkf5Wbe0nVrorhA==
X-Received: by 2002:a05:6820:2295:b0:5da:a26b:ce79 with SMTP id
 006d021491bc7-5e20c3a52dfmr12041708eaf.3.1726754568364; 
 Thu, 19 Sep 2024 07:02:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5e3b0d6ae98sm1941649eaf.5.2024.09.19.07.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:02:47 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 4/4] board: rockchip: Enable PD_VO before driver access
Date: Thu, 19 Sep 2024 09:00:22 -0500
Message-Id: <20240919140022.511067-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140022.511067-1-macroalpha82@gmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Enable the PD_VO power domain before driver access on the rk3568 SoC.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/rk3568/rk3568.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
index 1b3e40074e3..d5742b68d68 100644
--- a/arch/arm/mach-rockchip/rk3568/rk3568.c
+++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
@@ -26,6 +26,8 @@
 #define PMU_BASE_ADDR		0xfdd90000
 #define PMU_NOC_AUTO_CON0	(0x70)
 #define PMU_NOC_AUTO_CON1	(0x74)
+#define PMU_PWR_GATE_SFTCON	(0xa0)
+#define PMU_PD_VO_DWN_ENA	BIT(7)
 #define EDP_PHY_GRF_BASE	0xfdcb0000
 #define EDP_PHY_GRF_CON0	(EDP_PHY_GRF_BASE + 0x00)
 #define EDP_PHY_GRF_CON10	(EDP_PHY_GRF_BASE + 0x28)
@@ -130,6 +132,10 @@ int arch_cpu_init(void)
 	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_1);
 	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_2);
 	writel(0x3f3f0707, GRF_BASE + GRF_GPIO1C_DS_3);
+
+	/* Enable VO power domain for display */
+	writel((PMU_PD_VO_DWN_ENA << 16),
+	       PMU_BASE_ADDR + PMU_PWR_GATE_SFTCON);
 #endif
 	return 0;
 }
-- 
2.34.1

