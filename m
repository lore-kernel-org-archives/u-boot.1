Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B02C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7881B83824;
	Thu, 31 Jul 2025 13:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ETinZ0uO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE66383816; Thu, 31 Jul 2025 13:11:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C017583816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so210076f8f.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 04:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753960308; x=1754565108; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E5pFJuSMnMOoqFbNeFo5JvU/ELa8JeOsBTKkwo5IlEI=;
 b=ETinZ0uOCtUSeXZ3DiON6guVhuk6pSPUO6pRhn7lnMgQW1RrzLKG9oqtV9XYt6KGd3
 NGkLMR7/LoP+R26yfeATi2gBnOb0l/jb9lj15DqWn3oT4N6lW17cTl6Kzj24OBsaUc8o
 C9ChHcw5YTeUTi+lJ8yb5csC5EQlersXiOwoGWDRoivDkHhZ0CATVkcr5B87fafd09KP
 HCKceXUB+bFKSwptlakuaULet94ThEpWOwNTPyZn+NOcMIesETdLkH+DSMDCpulR8YYs
 GKjY6FXZHZI1cFaLoZIJ4wTCNeFUqM+o+VUOjBADZqi3bxp5YfEXtnHKGh4cYUFnGoOA
 yRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753960308; x=1754565108;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5pFJuSMnMOoqFbNeFo5JvU/ELa8JeOsBTKkwo5IlEI=;
 b=f/UOHp7WDnZyT7FgOYVmp0TllI08GimoUPEYhHJg3th6Ui9OC0SiSm4f3vba0cPQ1/
 7MxD+Ad6KcslMFKuCs6pna3/TnFU0JePbsywe5Zk2QIeeSPYxl0ZchV4z6/TxdbMnEDW
 EO3CUR1TvN7g7LfzsVByLnd/eOlejmyN9uAkg18TEARpQqBgL5VjXcdCD1bqizgRhFRh
 +45I41ZAYGXp8jlnkJ6x0ooueZZ9XDHJBMEV14NI6UCI0Y/cAWV170DpdxDKtl9kM/Pj
 +X1kUb1hh06z4Hve3QkuvZFfrzK9h84mGCw9irnwyg8cBbvgL4tFb3OawaXh8akNZPOD
 VNvA==
X-Gm-Message-State: AOJu0Yx5vbbFDec23SGlnZki9SEqkniLjPVZ901grjFbxVCxlazfi+Gb
 1Tya3ci3mN9cn6h+uwGVDQR3UOt0wZkOBX4BQV7dcG3x1nXFOzHYExktazHXoFil11J825jvFEZ
 I32k3
X-Gm-Gg: ASbGnctne6jP9sO5Ll32x2pndmXtg3N/MGFaL2dlqKfYqeWlkrXX2GydaFL7zSpNzIH
 /y6O6DOkmvkqX6XrhAn/P+TY4M0Iy09HMvDdqpFSqE9zNp9pe8u6yaqxa63q+NiW4e95MWmY4bR
 2noF1o5JM9cm7E3HgMmyFxKqIBar2dSHcdDnOhWl+EZXilpKw0Bk0wfWrsM5e5k3JqcXLfj1bvI
 I3V1AgGK2DmR8melsZ2Tbeumplqe3X7kbxuu36AbFqHNDZRjXiW2TvMsISePK9CiPW1YN5Z3SrB
 nUdr1WQrYf4dupKa0NEGLh4mFX5sk4nI10xbC00tFcVo2ebA6CgR2dGFkdXdsTHhG1xu+6afur8
 6CGlyADrkhzjyZPpIq4XYYDb/NUUOnbgVA1YF8zcOFE9nOBE/1A==
X-Google-Smtp-Source: AGHT+IGDCnF6mDE+xpzLAWEo9lin2fO7KOmAn0jgc5CyyUVpH8UBww6O4L3MKTf3TLi1Aw6U5dvGBQ==
X-Received: by 2002:a05:6000:2303:b0:3b7:6828:5f71 with SMTP id
 ffacd0b85a97d-3b794fe4f84mr5183793f8f.9.1753960308092; 
 Thu, 31 Jul 2025 04:11:48 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:14a5:dbc6:afe:7138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abed3sm2081857f8f.10.2025.07.31.04.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 04:11:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 31 Jul 2025 12:11:47 +0100
Subject: [PATCH] mmc: owl_mmc: Do not dereference data before NULL check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHJPi2gC/x2NUQrCMBAFr1L220CT0ipeRUSS9MUumFR2iwqld
 2/q5zADs5JCGErXZiXBh5XnUsGeGoqTL08YHiuTa13fnjtr5u/rkXM0SHZA58JwSSPVOniFCeJ
 LnI4+e10gh3gLEv/+i9t923avgyRUcgAAAA==
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In owl_mmc_prepare_data there is a NULL check for the pointer data but
it happens after data has already been dereferenced. Refactor the code
so that the NULL check happens before any code dereferences data.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mmc/owl_mmc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/owl_mmc.c b/drivers/mmc/owl_mmc.c
index bd4906f58e7..c18807b1f49 100644
--- a/drivers/mmc/owl_mmc.c
+++ b/drivers/mmc/owl_mmc.c
@@ -135,19 +135,19 @@ static void owl_mmc_prepare_data(struct owl_mmc_priv *priv,
 
 	setbits_le32(priv->reg_base + OWL_REG_SD_EN, OWL_SD_EN_BSEL);
 
-	writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
-	writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
-	total = data->blocksize * data->blocks;
-
-	if (total < 512)
-		writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
-	else
-		writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
-
 	/* DMA STOP */
 	writel(0x0, SD_DMA_CHANNEL(priv->dma_channel, 0) + DMA_START);
 
 	if (data) {
+		writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
+		writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
+		total = data->blocksize * data->blocks;
+
+		if (total < 512)
+			writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
+		else
+			writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
+
 		if (data->flags == MMC_DATA_READ) {
 			buf = (ulong) (data->dest);
 			owl_dma_config(priv, (ulong) priv->reg_base +

---
base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
change-id: 20250731-owl_mmc-ef16e32b68fd

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

