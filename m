Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0F3C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55866814B6;
	Fri, 14 Mar 2025 06:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XO3alLN/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4645080540; Fri, 14 Mar 2025 06:55:00 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01CD814B6
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 06:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2232aead377so38579275ad.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 22:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741931696; x=1742536496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pc5JnOdB369pPUvtIVxR70VBk8k3RDYMN4D/YCsYF4=;
 b=XO3alLN/+jVr+omFGz6J8j8f+/VwDqRzhQo4yDG+Iyvv/py63fJ9JkysnjcatAxV1S
 GJuIblNysXEGEaBKXcbX08VlovU6SS0r5puoVZDxEDDlvVSIx3277GwG3zMJ9J49jW2V
 +Cg90QcQFwpbOg20qC9+3ttQxXdIUgvzAVzo/z88OB/ngexvqE72H1UITr9EU+HhiBBo
 y6AxvBJ74WZLU268J+DZYrJjSFyp7OjFYRRfDOhPb+CXi0DeGhozTaf3eEMgva01M3Ur
 NOycbGite2NFWggn5PanSXhqUuMSR1ReXuHiGTN7yUUmz8FGoCtVOFsFha4bQR+m9FmX
 ePMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741931696; x=1742536496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pc5JnOdB369pPUvtIVxR70VBk8k3RDYMN4D/YCsYF4=;
 b=PsesnPktjlE8uBDKWZYqWSlPxk1AZmpGDObBv6whJ416QYSY1CkwScdFr0TuntO/Ik
 pXIuIm8Ydpzqi5oWcSzxh8BcqR0ZqCF3/stzEGjlXqJoA5MvMKwEyRtv6LUgBmXt88RC
 zh0w9fOeo5+gxLc4FavgNsJ8FhhgFvE5uxqYPjWyFV6xfTekhhhr70ESG+0BAodkw43y
 +hzVNirt8fQMl5+KgOOuWkzAfbCBS+oxsKdW693fHkZ5ooKcr0AoaVWvNe7VVVebOvop
 k3tFhoDJsGgw2Lohcp7ziHJksBf4nIL1Yq6gHWLwZzs5ipqtQpSekcPIQtC5oaS38xDM
 gt4A==
X-Gm-Message-State: AOJu0Yz/AzTjZMDveEnRmjkKqHEYhthoR2V79Jw0OYzT2uL3xIevpQdQ
 8a12BjKG2GVriJfm0gn96JtJTeWM+LprDkAmBYgCd+GrcrX3N+FQQA5K+gfZ
X-Gm-Gg: ASbGnctg/9gxdftBBfnVxftJGOlzDpQBZ4zJ5D8wePASl41/2roNlvROXmqfgD9dKKS
 oeZe5AZ2QoBxtxG245UjBd0DCsduDf3hUzpnWMAYnlfoDJF0TnVwETp7XLVk3TBPskvYFSiKj+r
 izrXbPO3lZF9ji6DJK7oLIMb+FalqyT714uCxQmb/ZoST8/nCUxoLdVbMcezAKSQdEmty2qejOp
 YLjzui55IW3DncQlzpVH8/IN8FA9hL3eupMGMc0BnDvyjzEZlWFMoi3B3wh2EuesEGyMx5byviy
 Ejy9L9CA4o7ewHs59nXBjV+GhqPzRPZ+sS6jYWpfj4quRpzl61GfYKR+uZvLIgQngvJOLzYCV7f
 yB2Xy54ZCa5496CulDU3dOkx6XrNfbk7cEIM=
X-Google-Smtp-Source: AGHT+IHOPUqY4YmcQRn7dTpTD9+FpJ2i3jPiMNzLXCmlmbY9l2H6mpAmLgYY0y1C8hA2GQaRyKSLDg==
X-Received: by 2002:a17:903:2b0f:b0:220:e655:d77 with SMTP id
 d9443c01a7336-225e0aee8bemr18369575ad.36.1741931696377; 
 Thu, 13 Mar 2025 22:54:56 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-234-101.mse.spmode.ne.jp.
 [49.98.234.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a8574sm22846505ad.86.2025.03.13.22.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:54:56 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, ashok.reddy.soma@amd.com,
 venkatesh.abbarapu@amd.com, Hiroyuki.Saito2@infineon.com,
 Shinsuke.Okada@infineon.com, Daisuke.Nakata@infineon.com,
 tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 2/2] mtd: spi-nor-core: Rework spansion_sr_ready() for
 parallel memories support
Date: Fri, 14 Mar 2025 14:53:37 +0900
Message-Id: <39ff6a5876f739f27aae4121f0669545def4aafe.1741930961.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
References: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
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

spansion_sr_ready() needs to support parallel memories configuration,
that reads status register value from each devices and combines the
status bits, likewise read_sr() and read_fsr().

Introduce helper functions that perform RD_ANY_REG op with one-byte or
two-byte data length. And spansion_sr_ready() calls one of them
depending on HAS_PARALLEL flag.

The following commit is related to this patch.
92e0ae42b47 ("mtd: spi-nor: Add parallel memories support for read_sr and read_fsr")

Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f352c5c0e2..c792a00e4bf 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -796,13 +796,46 @@ static int set_4byte(struct spi_nor *nor, const struct flash_info *info,
  * Read status register 1 by using Read Any Register command to support multi
  * die package parts.
  */
+static int spansion_read_sr(struct spi_nor *nor, u32 addr_base, u8 dummy,
+			    u8 *sr)
+{
+	return spansion_read_any_reg(nor, addr_base + SPINOR_REG_CYPRESS_STR1V,
+				     dummy, sr);
+}
+
+static int spansion_read_sr_parallel(struct spi_nor *nor, u32 addr_base,
+				     u8 dummy, u8 *sr)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 0),
+			   SPI_MEM_OP_ADDR(nor->addr_mode_nbytes, 0, 0),
+			   SPI_MEM_OP_DUMMY(dummy, 0),
+			   SPI_MEM_OP_DATA_IN(2, NULL, 0));
+	u8 buf[2];
+	int ret;
+
+	op.addr.val = addr_base + SPINOR_REG_CYPRESS_STR1V;
+	spi_nor_setup_op(nor, &op, nor->reg_proto);
+
+	ret = spi_nor_read_write_reg(nor, &op, buf);
+	if (ret)
+		return ret;
+
+	*sr = buf[0] | buf[1];
+
+	return 0;
+}
+
 static int spansion_sr_ready(struct spi_nor *nor, u32 addr_base, u8 dummy)
 {
-	u32 reg_addr = addr_base + SPINOR_REG_CYPRESS_STR1V;
 	u8 sr;
 	int ret;
 
-	ret = spansion_read_any_reg(nor, reg_addr, dummy, &sr);
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		ret = spansion_read_sr_parallel(nor, addr_base, dummy, &sr);
+	else
+		ret = spansion_read_sr(nor, addr_base, dummy, &sr);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

