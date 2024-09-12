Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB48EE645D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 08:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B778688EDE;
	Thu, 12 Sep 2024 10:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V9CywTSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6829C88E8C; Thu, 12 Sep 2024 10:01:51 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4524A88EDE
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-717849c0dcaso608630b3a.3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 01:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726128105; x=1726732905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjOn+qEQYAg2fbWzLiZjS6S+xS6z0mdCUnh0Q+Ooju8=;
 b=V9CywTSra1mJZeBN/yoBJjlZvii5uuVxaojd0K7s9744CXw1ex0rOofOMFGgOPuEsT
 sHEW91eB46i010QPMbLlfI7BLkBf/ET8ImwnmOWhz0HKn9jkG9WkXRPhIlHYBObopK7l
 GEn9kSynOwDAwuFnmRY1i+hXRXeYpmpc9eP2yiZhaCtrCmor6H/BAJoZdEgKTKtcK4zZ
 AoOePWLUUEdYU07/IFkHTLJ/BKl7x/xaXi+IX6d51z+NHrm6AM+hnekvc7QOrGea7ZJO
 q2YGHba4Wqy6J/F/T0SJGP87XsO8hFqmMm/LklaGkvRuqWh0Dcq7uzx8PitNT8gSy7fO
 HBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726128105; x=1726732905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjOn+qEQYAg2fbWzLiZjS6S+xS6z0mdCUnh0Q+Ooju8=;
 b=QhPmNhISaatxDKUqHykbxNiC3jDGh7+cKt3m0E7wSeyX7V7efRae5D5racvMFVq0kg
 pSviRo6R3jLeIXCR59eN+gYvIjyMn7JSlHjeOhSimqc3CygfyOSNl/DOJ3JoeRXVzyur
 JVHHn1K/GsWCjK6xeu00MJKbaKfRwtDXQjbAxxx8uZzvefh/1sIMEML1xdfy4pcoHYgt
 5oG1CaMXmu4Yiv4k+xn4lKvhWIEq1CDeWQ15kT/NjIXxr3HpPFTe2MSWwY9zmPeKkkWc
 kH5+MhtmU+2K59c8Lb+sAXmMLTg0nrziG/unvQcWJ+T/Lc4iQnwxZrjmH8FYYkZxBbvy
 Pzxw==
X-Gm-Message-State: AOJu0YxJ2zXF7NhiiIHRrmvTjSWvq1cZuW1dBfySJ8a47qNgmVJpmqWV
 XclqPvBM4XBbDhpU1dhiMTStLv5rBsaOzuz0OfVovm3AtA7geG0XLLcYmQ==
X-Google-Smtp-Source: AGHT+IHBYLkOFlgTjk0Us0IWdAy00aTXyGIKyYURAydjWA8uXBME74mQAz+tV6aVJl+3ZJhJPKUNOg==
X-Received: by 2002:a05:6a00:13a0:b0:717:8e49:37ce with SMTP id
 d2e1a72fcca58-719261e7a0cmr2997547b3a.21.1726128104941; 
 Thu, 12 Sep 2024 01:01:44 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090ad8bfsm4241790b3a.145.2024.09.12.01.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 01:01:44 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, prasad.kummari@amd.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 2/2] mtd: spi-nor-ids: Add NO_CHIP_ERASE flag to Infineon
 s28hs02gt
Date: Thu, 12 Sep 2024 17:01:30 +0900
Message-Id: <abd98036c398e5e7b770e65d3cc3c1d42198da41.1726127619.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1726127619.git.Takahiro.Kuwano@infineon.com>
References: <cover.1726127619.git.Takahiro.Kuwano@infineon.com>
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

S28HS02GT is dual-die package parts and do not support chip erase.

Fixes: 16dd1095101 ("mtd: spi-nor-ids: Add Infineon(Cypress) s28hs02gt ID")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3270ebb533..4e7e89eb65 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -388,7 +388,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.34.1

