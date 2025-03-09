Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D1CC282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 06:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B899E810F5;
	Sun,  9 Mar 2025 07:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PyAFCHFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B2680107; Sun,  9 Mar 2025 07:31:58 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78E6810EB
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 07:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abf4b376f2fso593962466b.3
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 22:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741501916; x=1742106716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5CINmGC88mszs28hNlDu57B4wONVvupvbPkXeQoy5Q=;
 b=PyAFCHFYzAoCtK8eET7DYZQmCryzjXWfm/XKWn54D6rGNv+b5jHotd/h+YwWz1JQa6
 79/4NGz/HAsYWgPj2uVhF+pluFyFt/npvM0dumAJMSJD/bYMGvvUiulEvabVBO9MTbrM
 y2W0XjKYBQtFxZmNBVyDF9vPrZp6c6K3sR++Ck0kj2EyVamB6C3kxzWV4ecTyyy6H+zM
 pkVOL42W2NkudutvM98aUgvwaArwYMR3cQKp8vfYDg0TduTiyKOQszHwisWgM9aYAk3i
 +o/t77Q+x53aYYZ+0mWWmK/WDX2j8/ydGh56RjBJ6+uSVxgCvCtu3BXRY2139zyP8EKr
 BZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741501916; x=1742106716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5CINmGC88mszs28hNlDu57B4wONVvupvbPkXeQoy5Q=;
 b=n+MF3xcUPiboGnFb42UiIjQyCN4tSXShgZ7AZAa/p2/nwNkhxsDbr4N4Rb9esZZ0e4
 VffiK322KjcLix0OhfpDX/V5YRvn8m46dhC6EUWJsCswj/UMyfrKyl/R2++pDhjuNYbc
 Gco28ryagGvetpKFx8ov5tDrUt0FhjOQtdIbvZyHu42LLPbOUcJvVtRaSoFlWBw7gRif
 p4jVbucj4yHdM224ia1wbzpngFg+j/EynD6bivp8GP+WH2UWOAm2g2rJEGYC47xOwKty
 WDuyKIQE/KuGIDyKVp3Cdd2PHmcYEjFP+AnRWoYg9FnzPt+lrTgm/Gyp5/MnYzehzFsU
 7U7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh0tfEWpzUjt6c2VCJUR/LE/JCCF+5aKEYUY+RUC4yqpsCfuMJ3gF1FodDsrVmtnBvJuH36EA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2dZG3Xyi2kP+Yh2C5aOFRrP+8jhyOh+6pQdDZwSyj3TkIGon9
 cA/jHXD15CfE3DLHfO+vavaPWywGkAaYE4SPiplkhq7Cx1U6xH++
X-Gm-Gg: ASbGncuORizYvXRRJN51vnBkdxdXPVzjibjVmG+8iqpr8DBSVcLA8weJ7vAGO/AUWlF
 iPgSkAoVen65KNShoQx45Wg6ddOQfZTZkYc+nQ78ev0xiLUWeQAIK+VenytZ52+VOa7U6NTCjnu
 5MSkfDN86Lewbji0G6kAp338uynwiYsyql1AFEOQCUuBJ7/YPQcWtNVQqPopgKRA43Etj0K89n2
 Z30foXL2/srlqoos6ryQZMXgvvdPuvybF3WsVqEO85Lo64wYtc7+v1l5H6g/QfQdS+Xgd71Pqju
 LQtLP1ABldI1yNamPfO8wcz7CnZxnT2M5zpFzsu0Z4qjtKPuFXwh8oyfU1tn7FNzPm84rp2weso
 =
X-Google-Smtp-Source: AGHT+IHBqVOgvCXwA9j35S72l6v7FHZCkL2seX5VXtOBX/sRh07uA7qpENS6jTqXYRKVIlrBBDDLyA==
X-Received: by 2002:a17:907:2d92:b0:ac2:2ba5:5471 with SMTP id
 a640c23a62f3a-ac252b3664bmr1116192566b.24.1741501915815; 
 Sat, 08 Mar 2025 22:31:55 -0800 (PST)
Received: from localhost.localdomain ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239438fd1sm552978766b.18.2025.03.08.22.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 22:31:55 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: macromorgan@hotmail.com, u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] sunxi: h616: dram: Rework size detection
Date: Sun,  9 Mar 2025 07:31:42 +0100
Message-ID: <20250309063143.62859-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309063143.62859-1-jernej.skrabec@gmail.com>
References: <20250309063143.62859-1-jernej.skrabec@gmail.com>
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

Since there is quite a few possible DRAM configurations in terms of bus
width, rank and rows and columns count, size detection algorithm must be
very careful not to test combination which would be bigger than H616 is
actually capable of handling.

Ideally, we should always detect memory aliasing, even for 4 GB memory
size, which is the maximum amount of memory that H616 is capable of
handling. For this reason, we have to configure minimum amount of
supported rows when testing for columns and vice versa. This way test
code will never step out of 4 GB boundary.

While at it, check for 17 rows maximum. This aligns code with BSP DRAM
driver. There is probably no such configuration which would make sense
with 4 GB memory.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index b3554cc64bf5..6f84e59e39cd 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1363,7 +1363,7 @@ static void mctl_auto_detect_rank_width(const struct dram_para *para,
 static void mctl_auto_detect_dram_size(const struct dram_para *para,
 				       struct dram_config *config)
 {
-	unsigned int shift;
+	unsigned int shift, cols, rows;
 
 	/* max. config for columns, but not rows */
 	config->cols = 11;
@@ -1373,23 +1373,27 @@ static void mctl_auto_detect_dram_size(const struct dram_para *para,
 	shift = config->bus_full_width + 1;
 
 	/* detect column address bits */
-	for (config->cols = 8; config->cols < 11; config->cols++) {
-		if (mctl_mem_matches(1ULL << (config->cols + shift)))
+	for (cols = 8; cols < 11; cols++) {
+		if (mctl_mem_matches(1ULL << (cols + shift)))
 			break;
 	}
-	debug("detected %u columns\n", config->cols);
+	debug("detected %u columns\n", cols);
 
 	/* reconfigure to make sure that all active rows are accessible */
-	config->rows = 18;
+	config->cols = 8;
+	config->rows = 17;
 	mctl_core_init(para, config);
 
 	/* detect row address bits */
 	shift = config->bus_full_width + 4 + config->cols;
-	for (config->rows = 13; config->rows < 18; config->rows++) {
-		if (mctl_mem_matches(1ULL << (config->rows + shift)))
+	for (rows = 13; rows < 17; rows++) {
+		if (mctl_mem_matches(1ULL << (rows + shift)))
 			break;
 	}
-	debug("detected %u rows\n", config->rows);
+	debug("detected %u rows\n", rows);
+
+	config->cols = cols;
+	config->rows = rows;
 }
 
 static unsigned long mctl_calc_size(const struct dram_config *config)
-- 
2.48.1

