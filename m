Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0115FCA17B
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 19:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2561483A8C;
	Mon,  9 Mar 2026 20:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eprkd8Hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6ABA83BC8; Mon,  9 Mar 2026 20:44:18 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9092D83952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 20:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flaviu.nistor@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso109272645e9.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773085456; x=1773690256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ORSpREdk1nBC4gupMM0BjcglAnUlH7iKs8z2sGA2bfI=;
 b=Eprkd8HvfGLV5MI8UKe5h3Bokmmh772WF23ooTN9P5L0bL1GgLtmptf62oOcGeLydI
 TbMWSdjn7v2VbVpdwiWNug8UXuD0dqyxlezL7yjBHyWrGGXxKyXkADTD7sgUa8hSa8ta
 vTySR3UFlfVqR2M1t9yCI+y6jUOi2NBHuHf64GtHwRwDLKGVtcHfZS5MgkdY8ZY7yUIb
 eTZoDTsxFKcBws/vq0qwfVI8P1rOWPt0szPua8i6jv69UQhD+2a5CbD9fVTNpU1MEtT5
 9GRdSvbRch5q6Es4K6Pw8P+hHnQurZDrH/XkENyu76z3RPabhE0/MHjMXEy7YzzRQq3l
 BRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773085456; x=1773690256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORSpREdk1nBC4gupMM0BjcglAnUlH7iKs8z2sGA2bfI=;
 b=tzouDAgz2EYmvqDx26qkumDxxhzlR8TI+HaR7FM+m+9+2SIt8h0GrgyBeAbCIVD0DQ
 5LNcCQk68IU4g0raKV0ypFJuJS7BH5/yY9GlNqCOF8y+Xf7G07jcEUH7lul7qi+7F0YX
 /xFuckYzuE0jQVJp8yid+jcii7EZxwDtII5juxtt4JW1sDg+zCoXhw4HaECsYq0ubibM
 Cgnecvqz8w2B4aBfmFlc0dLj/9YTwSKmAaafNCoNiYXOsmt5iY89YvcDE46Og58eY+ah
 zH9Z7r7B19Zfv59uvcrhAkpioWTnOzsAHu1j1dVIGASKIUuPOPLROnzHuQ+5qnCy9AsU
 VxrQ==
X-Gm-Message-State: AOJu0YzMW6hkgt4bA3Jo7jR88P4GbrvdiiPz3+ysotGShcES64Miaj3n
 7yYYS9RIUE8+R490dW8UadmTMSS6gox6BBlqQjrcuE91b5aswWG9An0TESqgycS4
X-Gm-Gg: ATEYQzwA2ziPy4QxIOtcnNWYUTlw6kZN4ZWTn6S97KfwGOFKwYtCNmoZfsvIo4A1zeT
 p+l3iNNd7CEitIUrlKxzhVpn75KH86t1na5RqpWZ+shV+al78drKzEgACSm/GIPLuC/nqVcbaxC
 RCP0H76s2zJtvbj9XBnzpdxM3PrI6Y4t2GkW9fsmOixs/r9GKUQsNxxqNFrhdAa8Fyw69+kGkO7
 QOvMHJ0D4hMmt7tpoqPZL2M4fXGv6AXQ0QMHHm/GL6a9ZgwUs9LYs7ZmQLqy7X3lm1QUtcTBdRr
 WyPLT1NMjZee2zri1f8gLJ+0/fQdi0qK3hqcbndRJGL1qPMsoiEQUQr6JBohzf2Acv4D9/jej5M
 UEJnqYA85lO1uLE+ryEl6IJnKPkAG/MDrqz1ODCybGVoxqXUUk8OrXIVpuvXr0G3ptau6L/6dfk
 Jp2w1LfIf8RWRQgrt2JgQAStBMZBhp+bP6mEN0TuChp8eb6LvScYceohGtg4k5sHpHAD8MiClw
X-Received: by 2002:a05:600c:c16d:b0:485:3f30:6250 with SMTP id
 5b1f17b1804b1-4853f306de9mr46824435e9.20.1773085455642; 
 Mon, 09 Mar 2026 12:44:15 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.232.50])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6e6sm30179915e9.10.2026.03.09.12.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 12:44:14 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jeffrey Yu <jeyu@issi.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: Add gd25lx128j chip
Date: Mon,  9 Mar 2026 21:44:10 +0200
Message-ID: <20260309194410.23882-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add gd25lx128j GIGADEVICE chip to spi-nor id table.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
Changes in v2:
- Drop SPI_NOR_4B_OPCODES since it is not mandatory.
- Link to v1: https://lore.kernel.org/all/20260225090651.25912-1-flaviu.nistor@gmail.com/

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 3bcb0d7b7ba..93e4f196a09 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -202,6 +202,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lt02g", 0xc8661C, 0, 64 * 1024, 4096,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd25lx128j", 0xc86818, 0, 64 * 1024, 256,	SECT_4K |
+	SPI_NOR_OCTAL_READ)},
 	{
 		INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
 		     SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
-- 
2.43.0

