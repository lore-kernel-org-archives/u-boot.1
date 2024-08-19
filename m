Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C1FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6965288CE9;
	Mon, 19 Aug 2024 17:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E6JZ9v5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAAF88CBD; Mon, 19 Aug 2024 17:02:07 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1B587B84
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-26fde6117cfso2601841fac.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079724; x=1724684524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltZj4/Ji8gzhH309+IEHQ77DxYY9xSO3M6xa/+15m/Q=;
 b=E6JZ9v5moe5oIXX5QkzqMY1EApqQpMcPd17SyNnAkyQWJbRbRSuHn+sK/9Yo4Ub0T6
 6iGWcNyvsuhks+WAr6JqNsRDjMXwR1sFz5D3xzRs1sVo/mf3a95matprIGktmvUh2ExD
 X3907jpJij/oEkFFdDP5VraAq0jk8zupwzVTeyW4H7MNjQ8zi4be7xcT2E5rjsLtBczN
 JdJqeCFAx+DndZYYMO0JyxYuwpilQFgdnvXZE1Ulb3F3HOAYSoB6eF2DF/Zl58aRkOGK
 MaNCfVWpLgO3xKcBXFSh7cmFeNy/I4CRZyne81tXzNC8nUb0gkXMyXqB061Pi4RpcExa
 MWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079724; x=1724684524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltZj4/Ji8gzhH309+IEHQ77DxYY9xSO3M6xa/+15m/Q=;
 b=YNpO5Sr0ITwCmVrYgNS2D/lk9TUNsfOqeYLu2dBwLWitTwOWU8H/d57/TPX0YqVNtg
 zzTRXCpUeMKJ1MFF+0htqVGmYlvpwcWqOc8LVJp1vYhX4jF+1FUMCh2320HfLSNKz+ZN
 qfuj2hv604I/2AZvYZpZuiavJW1QeaBwpqU7ftHVMVksASXIXPPfBIYdKqX0DI2ZkfeX
 nSRPxRvVTpzKUH6GasCmaUUfeq0X1XD9Zak06YrAMEBy52jSLRW3LEGktCKuU+tIECGq
 rcbJVthXHMD+5UsPznzeh12EUlKUQmC7dvaSbKIC6dGRfnC2+fKtU0PgyUOZgXZG0w2W
 6xvQ==
X-Gm-Message-State: AOJu0YwkEVQQd59G4Ol8P1kwD4nd8rW5CtHuFG/cEa7YslfdDJxXUiW2
 KEngkNGywxGeGjjPGMLUUj6lWjW/UFNsECboCRYyefaquDLOMbnm22xslw==
X-Google-Smtp-Source: AGHT+IGv3zawwRaytjnLje1XYwouz9eRxY8VvScy2pZB5yoVOU4GduERqZlnrauOCU8Usp+zM//aVw==
X-Received: by 2002:a05:6871:b28:b0:25e:129c:2223 with SMTP id
 586e51a60fabf-27033fc75cdmr8188026fac.19.1724079723793; 
 Mon, 19 Aug 2024 08:02:03 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:03 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 4/9] sunxi: H616: DRAM: Adjust size scan procedure
Date: Mon, 19 Aug 2024 09:59:33 -0500
Message-Id: <20240819145938.503221-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

It's safer to start scanning for columns first and then rows. Columns
reside on LSB address pins, which means that second configuration will
already have all needed row pins active.

This is also preparation for introducing DDR4 support, which need scan
for banks and bank groups too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 31 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 72194fffc2..2f2776ce35 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1371,28 +1371,33 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
-	/* detect row address bits */
-	config->cols = 8;
-	config->rows = 18;
+	unsigned int shift;
+
+	/* max. config for columns, but not rows */
+	config->cols = 11;
+	config->rows = 13;
 	mctl_core_init(para, config);
 
-	for (config->rows = 13; config->rows < 18; config->rows++) {
-		/* 8 banks, 8 bit per byte and 16/32 bit width */
-		if (mctl_mem_matches((1 << (config->rows + config->cols +
-					    4 + config->bus_full_width))))
+	shift = config->bus_full_width + 1;
+
+	/* detect column address bits */
+	for (config->cols = 8; config->cols < 11; config->cols++) {
+		if (mctl_mem_matches(1ULL << (config->cols + shift)))
 			break;
 	}
+	debug("detected %u columns\n", config->cols);
 
-	/* detect column address bits */
-	config->cols = 11;
+	/* reconfigure to make sure that all active rows are accessible */
+	config->rows = 18;
 	mctl_core_init(para, config);
 
-	for (config->cols = 8; config->cols < 11; config->cols++) {
-		/* 8 bits per byte and 16/32 bit width */
-		if (mctl_mem_matches(1 << (config->cols + 1 +
-					   config->bus_full_width)))
+	/* detect row address bits */
+	shift = config->bus_full_width + 4 + config->cols;
+	for (config->rows = 13; config->rows < 18; config->rows++) {
+		if (mctl_mem_matches(1ULL << (config->rows + shift)))
 			break;
 	}
+	debug("detected %u rows\n", config->rows);
 }
 
 static unsigned long mctl_calc_size(const struct dram_config *config)
-- 
2.34.1

