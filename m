Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB46FC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 05:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E4D88274;
	Sat, 30 Mar 2024 06:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFsTIfyT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A239B87D37; Sat, 30 Mar 2024 06:05:25 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F05E881AE
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 06:05:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e6b01c3dc3so1476246a34.2
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 22:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711775122; x=1712379922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dykm5Lej33m+dW918XsUdlrgLMnVrB0grYF8sWygwIE=;
 b=YFsTIfyTkZNxTC3pyTCqIpOx5EwNuUDVqUCRRtTzS8NdOgQYlsJbM3TmbvYBK/PLkY
 OwqjL1A84TxI8AZx4Faot5a6Plnb2GV5QWN5J4j7cCx2Xp8SdyM5AUoUpUdWMmZp2k+S
 pPr8taq2HydrPu3wq4S1g1WP0uI2m7h8AupeggyIErEe/r5RLMxQJ7BkMIxlgaXYgEsH
 HWkyxCHIzvxhLU7UZqKvtxr2ZKOyQ/0xe3MDjExJi7K4DHL6ejxVxsY23aHUaamWc8K3
 PlFrOsOrKnVXYR8Qzj6mvjiEMMLvlPM9NSOHMmqsYlwvOZZFmqpIIYZQMhV9RplNOHws
 Pqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711775122; x=1712379922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dykm5Lej33m+dW918XsUdlrgLMnVrB0grYF8sWygwIE=;
 b=rBqg0bfNmXrps6YtXZP7so2tyVb5oS+2rIZYWE8qTFBP+gAkYCx4h+rQKrHNSGvtL9
 QJj3XBM+cwl8lF4r2UugCyzb3xn9abR/XyENaBL85pGBS5gXZ7N6OyxgnMGbzi4/bzVd
 mea/0qFEjydUCkteQNehY3jwLBJANSxvt+7ictV331bY3N645R6WrHtecH2InwtIGZY0
 dvT9eijxkc2DBElQPOAiPY6a1pveR4YYbkqCYHjZ1He4UYZ4YqfqCHgSB9JL6dtVPJgE
 2JdtsuoE15ADIexm4+wAkoJX7dtEAehES5SK6jwj87T0HFcg2zght68Hfzd5i/hDM5IF
 KGTg==
X-Gm-Message-State: AOJu0YzhPiuR6igMYcp1VGOunrOD+oh8orSMEftfZxb/Cy4nN4TbAzfh
 E/lIFtYQp9mtl5YDJxHSJpYbpAkE5Ba6GmwAoEW+id6t4RxZaO5y2K/vEY93
X-Google-Smtp-Source: AGHT+IEMebF3aTbNpK2gV8klaCoso9Ry2Apwj5jw6HeafCGTaN2SxB6+2DZyIxCr/u8Cwout4znydg==
X-Received: by 2002:a05:6870:9a0a:b0:22e:93d:f9ea with SMTP id
 fo10-20020a0568709a0a00b0022e093df9eamr3008852oab.26.1711775122135; 
 Fri, 29 Mar 2024 22:05:22 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 on7-20020a0568715a0700b0022a73f32f11sm1427634oac.32.2024.03.29.22.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 22:05:21 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: eugen.hristev@collabora.com, kever.yang@rock-chips.com, xypron.glpk@gmx.de,
 cym@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 jonas@kwiboo.se, trini@konsulko.com, Chris Morgan <macromorgan@hotmail.com>
Subject: [RFC 1/2] rockchip: sdram: Allow board/soc specific RAM bank logic
Date: Sat, 30 Mar 2024 00:05:14 -0500
Message-Id: <20240330050515.470025-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330050515.470025-1-macroalpha82@gmail.com>
References: <20240330050515.470025-1-macroalpha82@gmail.com>
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

Allow individual boards or SoCs to alter the RAM bank addition logic
by defining a __weak function that these boards can then override
if needed. In the event this function fails, fallback to the default
detection logic.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 0d9a0aef6f..53aa19feca 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -35,11 +35,18 @@ struct tos_parameter_t {
 	s64 reserve[8];
 };
 
+__weak int rk_get_ram_banks(void)
+{
+	return -EINVAL;
+}
+
 int dram_init_banksize(void)
 {
 	size_t ram_top = (unsigned long)(gd->ram_size + CFG_SYS_SDRAM_BASE);
 	size_t top = min((unsigned long)ram_top, (unsigned long)(gd->ram_top));
 
+	if (!rk_get_ram_banks())
+		return 0;
 #ifdef CONFIG_ARM64
 	/* Reserve 0x200000 for ATF bl31 */
 	gd->bd->bi_dram[0].start = 0x200000;
-- 
2.34.1

