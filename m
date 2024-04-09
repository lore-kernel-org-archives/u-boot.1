Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51FCD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 06:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291C888173;
	Tue,  9 Apr 2024 08:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YElr6IHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3339988168; Tue,  9 Apr 2024 08:20:44 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFCC8815E
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 08:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e40042c13eso12953645ad.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712643640; x=1713248440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imuA5FhJunnjtjI8Fe4ik6nXPTRL9+Z57l2YDYY9a94=;
 b=YElr6IHIV0/bnCNTi051I5u2A7RgnKeQ/7d7PtY3jVMG6A6Psf0vGo/+wH5SgMadWo
 YxXGgc5Pi4ty6tc0vIJQgi9ocWDsHZk4rkLjgrK3lOwRFRS7CJ/ynQfvkrVI95sqUZ1V
 u48jdoDUfE7d4zmuAru5VTiata1jQwX0IZO+wSrcEzUiMA6Rs5oL79zEVVuRq63VoW43
 00iZ9zIgSzaZUlyRSz9BKl32XEEoStQM1AEbYryxYuR5CvwYY+8DNYR1q8FkQaD784Hk
 MQmEfLGMHMyLBCwNi2qDzzFVtUl5eIyIVE7B4sEBD8du/XnYcPY6Heib8Z0XW3XNXmDg
 X8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712643640; x=1713248440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imuA5FhJunnjtjI8Fe4ik6nXPTRL9+Z57l2YDYY9a94=;
 b=Ca2OraULAeTiKFvQZ7U8gi6qDXc7fvHaIgUQEnspFBLFpqsEPTz2mIu3H1TidGgi30
 yBd/dcI2495s9S8X8mE3JOTTZzBhGOKqdou1Egs1QXh6VwYiaUu2Bjo0m36tcO9CrojX
 iIGLyChfmjPP2CBC4zBP8x+SB+/1jN0ZT/s6l5FAKDKawE80lFXw2dTrZX3DXNwjroeY
 V+1JPZ3moHXAdtJBdzvt84eInNAQNAi+Zf9p3RWeZgm+xBqOeqo0EwdrzOzc0oF8pc0k
 F/atcHG9q3VcZSEQp8iydshnhu+5gk8KiYrny7mAJwgJZl7tgbzskdVRspU/8FT6ME5H
 rnxQ==
X-Gm-Message-State: AOJu0YxS6IjU7x39B2urfxDfRir37sTksS0ZYYqb5xUGDjtqI9nGMjdb
 XozCr4RkDmNY1fNzD8ZjbSCCun1XC4GsPpAtvGoi6CXezemWUoh+tq0VmC8O
X-Google-Smtp-Source: AGHT+IHcRdndyjZcK/4JV7h6tiElJdjnNz+gpIJ6Z2cOlOHrumia55IkvZuk8FvLIRvcuexY3dDMDw==
X-Received: by 2002:a17:902:6f08:b0:1e2:7c72:767 with SMTP id
 w8-20020a1709026f0800b001e27c720767mr8623885plk.30.1712643640525; 
 Mon, 08 Apr 2024 23:20:40 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 x3-20020a1709029a4300b001db5fc51d71sm8037985plv.160.2024.04.08.23.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:20:40 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 1/3] mtd: spi-nore-core: Fix 4KB erase opcode for s25fs-s
Date: Tue,  9 Apr 2024 15:20:20 +0900
Message-Id: <f351754643dda5305f385ce23eb74ff2ee41e177.1712638210.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
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
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index f86003ca8c..9620852817 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3299,8 +3299,10 @@ static int s25fs_s_quad_enable(struct spi_nor *nor)
 
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

