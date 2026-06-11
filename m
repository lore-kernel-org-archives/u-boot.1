Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4893CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45F78485F;
	Thu, 11 Jun 2026 16:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qkzgEY5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086608485F; Thu, 11 Jun 2026 16:18:34 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8248C83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-517863a2edfso64857231cf.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187510; x=1781792310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obbhCCPzKsAe6rf1zvJx5H7WJ/yFkfxrjbiXkykNmi8=;
 b=qkzgEY5/Tmh4cFDhV4nXLqGFZnLmHBDTxfl6t2xDvm+iVxkgYqJ3+zvsULa5hNfvT0
 b/Kh7os7ZNCyzYLq+6HeWZHz7KaYT/GDZVqrVbXCFEsip3ugSffxLylz+hScZNqu+ZpP
 sDjuRsHliYV6vINITftG0MD6wCTUVUfqcyrHfyvHuwGLYQW7FEo6WLY2hZ9dH5KnYK+G
 s5ZLNXnq792ytJeXJ5tr/loJsKQFHZSoYjOLK62Ab00hW+bEncFayVdVglpE9y7jiufa
 ERZxtONdrJ+B0smBFdaybWuLuXtkhy3O6D8/Qe4PTRZpV+NCvIfuor9F4wCCb72Fw9lG
 U8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187510; x=1781792310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=obbhCCPzKsAe6rf1zvJx5H7WJ/yFkfxrjbiXkykNmi8=;
 b=qhZq6fso2tLyXJuO2oC9b5ZJpsee3mNVuPjQzYvhET0468WoSOi8gZJkw3mkI8FW+k
 Iv/x6pnHymrdndUyleI3zEdiOudSxCa120ImYH6oW6OUZ3U/3AxevDXAYSP6jPo0DHk9
 U2pwJcX5HYbAbqyfFsXs2at8o2T7kkx1AnbrJAPGNLIPzrP4JUPnDuJ3xjpykqP3p3ee
 4k4nmYpqNzSMhAvXtHLfCWKxBnKIaArQO7RmX2bqziJ7JF1wXwcB5wP194VfGE1UR+Nh
 yMompOCZuMkfmBCIj4iRajui3YZzSp3SXY45KFRjenmDgo3RqoG4J8eSX5Bmir0K6BMH
 n3Ig==
X-Gm-Message-State: AOJu0YxU5r8lude6ILoifaGu5puHrxJ4SxpdwgkmICeIt9z+LNvUCt+X
 QcrPh+/YAALdUlywJyp+A+7sWkgAkpHHF4XhhOlJSPctkE13dKEWOyjj/Pjtlfi8
X-Gm-Gg: Acq92OFiiJmrpIeW7gagXSJD4u1qZc8FAt8FVox6Jy8KhjlLmPY23bc3LqaI9+79iJW
 hYjX0CWYg986pjuJ1pIswBVXMoY+4BNDBcLfKwAUD1clPunTh+u6MEbP3IWtzUc0MHpRCbA9BX/
 exGIu5JtY9ZqxTsvSv/BNKWPeNVKDb4fU3+EarOm+UxthfGnwTU+5nFm1Zng4hBLlRiNSr6+nQH
 xNrk87jg8zc6o6jHi/+MYiAok3a/qPxha4V4lPB02mqKTylssThAKzpooSLRAO4/12Htfyb2EtC
 7X6Lu+CWtp0omutWQcMqTGFbeSiz4zcJGzC/bCzw40dANVnFjX6nOTevd02sAVHmGP+HqPDrrAI
 ribrjPQi6gJQxSgFb/RVZdHJoteokWuV33EvgCUHc5LZUo09T2cg0U+vJVLOLBrbqflw4pcAhpI
 zspbTMGTKKOM/Nsqhk1DgiJUxBjcqeTGAbhQdIJy9FkE+p7LsWD0Ucm6gXMF6q5oU5c1J12u123
 4lySY+kWZyKIJdJh4c=
X-Received: by 2002:a05:622a:11cd:b0:517:6fb4:5796 with SMTP id
 d75a77b69052e-517ee1c0101mr47321191cf.30.1781187510137; 
 Thu, 11 Jun 2026 07:18:30 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:29 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 2/9] mtd: spi: enable spi_nor_remove() in soft reset config
Date: Thu, 11 Jun 2026 10:18:04 -0400
Message-Id: <20260611141811.68904-3-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

spi_nor_remove() is only implemented in spi-nor-core.o, not spi-nor-tiny.o.

So make spi_nor_remove() only valid for CONFIG_SPI_FLASH_SOFT_RESET.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- None.
Changes in v3:
- None.

 drivers/mtd/spi/sf_probe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index 7100b64bf22..dee03662d45 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -229,9 +229,11 @@ static int spi_flash_std_remove(struct udevice *dev)
 		spi_mem_dirmap_destroy(flash->dirmap.rdesc);
 	}
 
-	ret = spi_nor_remove(flash);
-	if (ret)
-		return ret;
+	if (CONFIG_IS_ENABLED(SPI_FLASH_SOFT_RESET)) {
+		ret = spi_nor_remove(flash);
+		if (ret)
+			return ret;
+	}
 
 	if (CONFIG_IS_ENABLED(SPI_FLASH_MTD))
 		spi_flash_mtd_unregister(flash);
-- 
2.25.1

