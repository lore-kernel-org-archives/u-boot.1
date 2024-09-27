Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B213BCEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E59488F89;
	Fri, 27 Sep 2024 03:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WIg8ppAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52AB78902A; Fri, 27 Sep 2024 03:18:33 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C0489023
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71798661a52so1261570b3a.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399907; x=1728004707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPQWufmwG00vyE4aYxiAXETrI6SowTYkWwOAIF2lEso=;
 b=WIg8ppANEBbHpaYlDSezWJhBhSmdXDP9yP3B2eLKYuS35vpzEH9W/DhNGazN3WKH2o
 4dF/++N/faBcHku0ns1XUP+FYQXvjJNjitLxb+3Tii/xGoTr34BqCXeLajDwAZtNmOsO
 wy+fWJHpBmhSb8JEQ7Fr+AIGZZICm3Q5qFK/K9XEP6U0gv2S5q+yL2ke5Yw6n0PfOoGc
 02XrcMozIZgiuXLfu+fA302dIPyJ4n1sIjjA58dRp1awXjzBKbaVhnIb9D32Gyb+lciE
 Cw93B7lz6X5+S9Riocz1SfxRqftKpN4HP+NrSZoGy0kWl2qHS/WBtJblEzz8YWebY79m
 9f/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399907; x=1728004707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPQWufmwG00vyE4aYxiAXETrI6SowTYkWwOAIF2lEso=;
 b=UkB08SCuZd4VTBcA+8oeTFAWOnRwape7YhDDocLniEQbu+PrwaoBJWTQ+LYJL++hrg
 9QMKRMwwuK8KQ4H6k5rauU6VBBEdpE3HCe6zq4fZNMZi9a3Q+O3AMO3kqCmrEzc/sb3o
 NNcGuzIcW5c3/+MThCH6m2NbJVCS/V/cOT4GAxVptZzb+bVF92+EqNhjJac6OKedNsJw
 7cuc1glQ6iuLHQnCNJxZymFmvUAGqIQ1hCFQT35uQBQxrHAOmPhzs3bMif6M1yRTPSsq
 0Frp2RQYqxTKxHKZQAE9a/7hvYhdG/XA0rc9FTyKcFqTPvt60PC3D+MqPsOnxqLIZKJH
 GRMw==
X-Gm-Message-State: AOJu0YyxlBPnQfLw3eruHlgHzjI/YysRvsyxg1fuSXAJmubbeH4L055N
 u6DpkOnxlHBsOJFlAGDIFxN/4WfIMR2P3DBOb3sKc4B+T1/In8eerWtRvw==
X-Google-Smtp-Source: AGHT+IHzvuCJl3+qHMoWj2149A2omf/NZQqFja3I6dTtOt7VxIvIzRMLHd6rGBtHPKLoS0nbOt0QHw==
X-Received: by 2002:a05:6a00:801:b0:719:24a3:2a8b with SMTP id
 d2e1a72fcca58-71b26066805mr2926463b3a.12.1727399907514; 
 Thu, 26 Sep 2024 18:18:27 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b2652a622sm509908b3a.164.2024.09.26.18.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:18:27 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [2nd RESEND PATCH v2 3/6] mtd: spi-nor: Check nor->info before
 setting macronix_octal_fixups
Date: Fri, 27 Sep 2024 10:18:08 +0900
Message-Id: <cbb207c3b9a514cbdec861322b3ceebd4a00bca4.1727399650.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
References: <cover.1727399650.git.Takahiro.Kuwano@infineon.com>
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

The macronix_octal_fixups should be set only when mfr and flags match.

Fixes: df3d5f9e41 ("mtd: spi-nor: add support for Macronix Octal flash")
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 4dfc110b02a..6eaed3da392 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4067,7 +4067,9 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-	nor->fixups = &macronix_octal_fixups;
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_MACRONIX &&
+	    nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
+		nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
 }
 
-- 
2.34.1

