Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F2C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772558403D;
	Fri, 11 Apr 2025 18:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gybb7mUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBB9838AB; Fri, 11 Apr 2025 18:15:25 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 342C6838AB
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso3479905a12.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744388123; x=1744992923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IGNN6aGbKHcH6Capa+ymRdfB7bDOe1OnvdR4NcBsvY=;
 b=gybb7mUnWoBwW0mCai6mlKricC7F/0edEmzuKW0BHoudIlsKZR0wkiPVN/fmr4WkPQ
 2PacDPDcpuQWRW/sWVWlju91mtJN3qUtuSy5cNBKoqIR6JUKGJitzQ7vXbbOBNeux9MS
 wFuf/D2Y3kpGbzJlL2qC6enb+5wjbBe9bmn5zxeBd5R1MGbBj0Z7c+wK55+yan4siJkN
 866kQL29+0vEQI8fYxmX1uLEZmjponHAsxbe/tiRIqAbF/nLrRBwwJfpn62jiswntGMx
 g8z1nH4F/DRPl4tbCV3yod3pKGs13Tpfl8ydpOG7KMUR1hHkijjVkcdaBTlDmhXYvpyU
 iw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388123; x=1744992923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IGNN6aGbKHcH6Capa+ymRdfB7bDOe1OnvdR4NcBsvY=;
 b=knUZomKS2gSZDqvPdq05r/BD0bSvN3qza6pG+Xb+PcNJceh/xZRgungRtwxw+Azs0N
 Prvp/C2+Ej0IrHO4UVBmCjj6A8jBH/4H4rAEq32G9ukyBYVO0Ats5QtoAw14xsO1pYtk
 6bkvW6evsAiQuJYPxiuLHBhlofFWWLWiug3ixjJVTV7w8KxobTOa2F+vxnDHbR2DHVdO
 FejTJeqnb2y9IYa0kKFxhdIv7LT5tMEMaMucgk8JVmrHY6VZkXMn3su4Gv7zFoqO4htO
 PPiSPhZR8uuqj+SSHFqYC1U0h/pkMv/wkr8pv6OHrv7QlBO3h8aqA+jlgY2WarZ00Ywu
 K0aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZraN07slFXzW/rPtxwmcVAHw+XVm876r7HJWhdAsmmU8UExVrRabmhi94AVatMbM38+dw//I=@lists.denx.de
X-Gm-Message-State: AOJu0YxS9QfyCks+gsBuacorRLM0lZfdq9b5RIh/YlR4nqKDD2p7vQ4+
 NdmZP14LCCS2MWhXqY8dX90Nj3hxVunRXwc/JUXv5St/8XQvaNhgEtB1vjalGxY=
X-Gm-Gg: ASbGncsebtkg17Y0BW7hkQJ+y5fdPaMZurHlVaawTUZtSiNc0YMzW9cSSgGQlnaPNxr
 1NxKryTM9/2tREE1BvFJXa0n+2ZUj9GU6wMFVnssSiSPbOYSau38my89mfwD+5wYmdZhDo4rINX
 wy7evemx/W7JjWXk5FbhViIQ9oMmMQc9w84pYYPIZg0tPV0cC7aGKKwtZNPTriBSu/GjYLzPDo0
 gAC4dCla+BgjFlOl9yTMmLBvNShugwCWcCVBMZB4OXvtPNk5ZtmdUYa+r+u57rTeuL3uEwkocrW
 F89CO3WJLUcgYgsY+0/jp/V07JIFFxn5sjwV8VpX4taBw6ke/Xpu0buEYQ==
X-Google-Smtp-Source: AGHT+IHGPQcIH6fxyoGt0YfhSdF0afBr8xnUcPqiyOupXM5CcByh7Q/fMnwhqpNRnJzCSJMXSnSfLA==
X-Received: by 2002:a05:6402:270f:b0:5e7:110a:c55 with SMTP id
 4fb4d7f45d1cf-5f36f77aad1mr2867188a12.18.1744388122272; 
 Fri, 11 Apr 2025 09:15:22 -0700 (PDT)
Received: from localhost.localdomain ([80.90.89.143])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f526da3sm1136246a12.67.2025.04.11.09.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:15:21 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: trini@konsulko.com, macromorgan@hotmail.com, uwu@icenowy.me,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/5] sunxi: h616: Panic if DRAM size is not detected
Date: Fri, 11 Apr 2025 18:14:35 +0200
Message-ID: <20250411161439.4743-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411161439.4743-1-jernej.skrabec@gmail.com>
References: <20250411161439.4743-1-jernej.skrabec@gmail.com>
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

If colum or row size is not detected, panic instead of continuing. It
won't work anyway and it's better to inform user directly what's wrong
instead of failing later down the road for random reason.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index cd9d321a0185..d1768a7e7d3a 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1396,7 +1396,7 @@ static bool mctl_check_pattern(ulong offset)
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
-	unsigned int shift, cols, rows;
+	unsigned int shift, cols, rows, found;
 	u32 buffer[16];
 
 	/* max. config for columns, but not rows */
@@ -1416,10 +1416,15 @@ static void mctl_auto_detect_dram_size(const struct dram_para *para,
 	shift = config->bus_full_width + 1;
 
 	/* detect column address bits */
+	found = 0;
 	for (cols = 8; cols < 11; cols++) {
-		if (mctl_check_pattern(1ULL << (cols + shift)))
+		if (mctl_check_pattern(1ULL << (cols + shift))) {
+			found = 1;
 			break;
+		}
 	}
+	if (!found)
+		panic("DRAM init failed: Can't detect number of columns!");
 	debug("detected %u columns\n", cols);
 
 	/* restore data */
@@ -1437,10 +1442,15 @@ static void mctl_auto_detect_dram_size(const struct dram_para *para,
 
 	/* detect row address bits */
 	shift = config->bus_full_width + 4 + config->cols;
+	found = 0;
 	for (rows = 13; rows < 17; rows++) {
-		if (mctl_check_pattern(1ULL << (rows + shift)))
+		if (mctl_check_pattern(1ULL << (rows + shift))) {
+			found = 1;
 			break;
+		}
 	}
+	if (!found)
+		panic("DRAM init failed: Can't detect number of rows!");
 	debug("detected %u rows\n", rows);
 
 	/* restore data again */
-- 
2.49.0

