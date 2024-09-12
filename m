Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B8DEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DFD88E07;
	Thu, 12 Sep 2024 08:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ms9xB/U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A8E88DBC; Thu, 12 Sep 2024 08:13:55 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41D988E64
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20688fbaeafso7590285ad.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121631; x=1726726431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fUL8CxEs8Y+bj4uMJx5ydfZkvJXWGlW7fdTFFBVlZas=;
 b=ms9xB/U7I1xkUoyISmMnC6i4oUEIc6aw8rsaTPEoQpqdxTic5FNCVblEDA5NMJg83x
 a7yeF6jjai3OXFAOvA9haykGWhf665Civ+VOdOKsP6yQOLqVpANV6eqv8dxAHtEUrWqe
 g+d6wS0+mI2wRJjeXHPM2Yeg0B4OdumayraeXf0GvdMajlP8tCk+XpzbiF2OTCyhDSSy
 CmLVzExQ15XnASKOTqGwu9698+Zfp9xQW2ed7A2eHrIcylf8zUa59MVKibjGgQnOYIXH
 EroBevFMrZJVsWytpsl/oiLnV7K7ja+edFbs6oonafz4vrDt4fZMmUUXvh11HPoqfVvY
 mdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121631; x=1726726431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fUL8CxEs8Y+bj4uMJx5ydfZkvJXWGlW7fdTFFBVlZas=;
 b=czDVkHHNPoJB/1Oq/+IXzd9K0a7SGc9CZPtAncYCRj3g/7hkEGOAQ72FolCIUhF7Oj
 06wxX/YCZLhntu8Yt46hgVTpf7kcjFxHY1o8JuzQf3vpkYFSfZZAc9XKiXKZ7rivG4Oa
 XUW1cmY3NUOGNsIS3zk5mhZuSDCBZtdERawrDTGD3rp9MdndwGV6DDN3qFm5kPzd5NC7
 lK3iV33Y8xlYjXpPYkeQYsWmO7HEC95/0xo/dgf10ZWZwe1GzUQaf0sQ0mMVR6Ag/TcF
 GaQz8ynwHKkh9RwYbV5k1nmo++iezeasy5rxJawkYrPEPz7vsNJIQYS8aAq+33XOnp3h
 Cg8g==
X-Gm-Message-State: AOJu0Yzw0FW9f+yPpqp26BLVg2IgaHNq/JTsWZYDk5ul5YXQ34a9f9IU
 CBerTzCqtxSvF3E7T+5k/qRyPznajU6O0wJPY32224PtKcro8C+0LOdFXw==
X-Google-Smtp-Source: AGHT+IE7y377y3VbCWdsycM3x4shQcNOQDtJ6++rf0AgONhZRTaPVpzR1jRRh6yEiQemLwenJuVOyg==
X-Received: by 2002:a17:903:110e:b0:205:4885:235e with SMTP id
 d9443c01a7336-2076e40c0b6mr21585945ad.39.1726121631346; 
 Wed, 11 Sep 2024 23:13:51 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afdd046sm8214065ad.166.2024.09.11.23.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:13:51 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 1/3] mtd: spi-nore-core: Fix 4KB erase opcode for
 s25fs-s
Date: Thu, 12 Sep 2024 15:12:59 +0900
Message-Id: <4c0da342c806e0b24a855dabcda0884c81e58871.1726120686.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

The correct 4KB erase opcode should be selected based on the address width
currently used.

Fixes: 562d166a13 ("mtd: spi-nor-core: Add fixups for s25fs512s")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index aea611fef5..b633f3092b 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3349,8 +3349,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
 
 static int s25fs_s_erase_non_uniform(struct spi_nor *nor, loff_t addr)
 {
+	u8 opcode = nor->addr_width == 4 ? SPINOR_OP_BE_4K_4B : SPINOR_OP_BE_4K;
+
 	/* Support 8 x 4KB sectors at bottom */
-	return spansion_erase_non_uniform(nor, addr, SPINOR_OP_BE_4K_4B, 0, SZ_32K);
+	return spansion_erase_non_uniform(nor, addr, opcode, 0, SZ_32K);
 }
 
 static int s25fs_s_setup(struct spi_nor *nor, const struct flash_info *info,
-- 
2.34.1

