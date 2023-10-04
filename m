Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F995E8FDC4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 01:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C0688702C;
	Wed,  4 Oct 2023 03:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BbbYiDkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0E686EB8; Wed,  4 Oct 2023 03:36:13 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778BE8702C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 03:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso1039504a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696383369; x=1696988169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6N8hmiEl0PDRt5vwQ+rm6Cv+JSY9JXZuOYEy3KAjpbo=;
 b=BbbYiDkL2I8Q4YNJvMPF3zc7vg0tus9E8TPUsArrulFwz4w5JLlahzwOGPcFmI26hk
 /9xFndNsz7HAozdHoPHGKyeVIUrAZuXQTWmd6KeBbhZLwrb/N/ZrbUVYY3FWlHogU2yI
 4Yxol4nJW1yf6/5m6M+JWKbtt1mATnBMIe8AcvDeNc+x54lZyLv+7dg1kFpZiuPrAbiH
 5Kac1HPxNe8n1UUdhoBhEZLfBgSi61AVscfkRGRGYbvi3RGPqPu8gidlEV+06tlUrjIc
 RRE4wc6aIaBfZ9Vf85Mucws2S+YMWkDn2FA41VcWRny3snwnCyYTvI30LcyHGZCWVzUG
 K5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696383369; x=1696988169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6N8hmiEl0PDRt5vwQ+rm6Cv+JSY9JXZuOYEy3KAjpbo=;
 b=Ye3Vcs1pu+1c/6SM/jc/QOF7MTNQCLUIIIZY058UxuR22JLh414FWT8RgIn2TDsKiG
 JA6Kx64Tpl3Dt5Ye35SDqhpQPQ2Gj4eqHMC5aajXx+83p4upnBa7VvR6pvMJwPC0Uyf8
 8r+pbNVLiD7cMVKquKupwzKPYIOsQi5LT+KqhUHFbvod/LBknGNjyLaZ+bLNJ9+faMbh
 +chAMUA1amozcga1m+PZUIRn1e8kqWST3E6f8VZ42GmGBbbWdR44os3q2TN6PCL08jjX
 MeVECYYO0IhdyM6acbwGgqwxYP2k3HxaCRCx8egToHLgJle6VYuv7RKex678KhRvRayK
 ULpg==
X-Gm-Message-State: AOJu0YxeuTC58uNUFEqg0ScSg4faspaRlp4yq14tdT0C1Qg86y+h8uBM
 M+H4Fdnlai7oxbfvrjYh5sQ=
X-Google-Smtp-Source: AGHT+IHbfo+mrSbjcCumkVHqqhlb5GrXf2iU8PNZwnm4/7byDxva60jPeZyI8otj1fUyhnvEYW0QjQ==
X-Received: by 2002:a05:6a20:100c:b0:154:b4cb:2e61 with SMTP id
 gs12-20020a056a20100c00b00154b4cb2e61mr961603pzc.60.1696383369238; 
 Tue, 03 Oct 2023 18:36:09 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:d608:e3a4:984d:9db9:72eb:86da])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001b890b3bbb1sm2276058plk.211.2023.10.03.18.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 18:36:08 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, hs@denx.de, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] i2c: nuvoton: remove standard mode only
Date: Wed,  4 Oct 2023 09:35:58 +0800
Message-Id: <20231004013558.2828546-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

first version is only support standard mode.
remove this judgment to support standard/fast/fast plus  mode.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
---
 drivers/i2c/npcm_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index ea4ef53256..b867b6c8e9 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -517,11 +517,6 @@ static int npcm_i2c_init_clk(struct npcm_i2c_bus *bus, u32 bus_freq)
 	u32 sclfrq;
 	u8 hldt, val;
 
-	if (bus_freq > I2C_FREQ_100K) {
-		printf("Support standard mode only\n");
-		return -EINVAL;
-	}
-
 	/* SCLFRQ = T(SCL)/4/T(CLK) = FREQ(CLK)/4/FREQ(SCL) */
 	sclfrq = freq / (bus_freq * 4);
 	if (sclfrq < SCLFRQ_MIN || sclfrq > SCLFRQ_MAX)
-- 
2.25.1

