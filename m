Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580B6D10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40FA788D70;
	Sat, 26 Oct 2024 22:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g7aCVHcw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tw01I7IC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6642F88B1F; Sat, 26 Oct 2024 22:18:55 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442CC88D70
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XbWFD6wgLz9scR;
 Sat, 26 Oct 2024 22:18:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeTUnZjxsy92MbdrUfxGZ9kKY0pquJGLJ5ZgTBm3gV8=;
 b=g7aCVHcwE7WWXan3sVnfQEK2eWItNawiFAgcYHIDrJ0WeB6WKxNr4A4Ig9gd9V2zWD4HVl
 ASJV8J7m0IsUcbi3rcrGEGKn7qcueEVYIXtGKY3vJpgzCxHHrILbV/vruJs8fQBq1/ZoMR
 /jWCUlL/mBoiUchwQtnFONOz+2DJ7D9rtRTvzPF5GMwcK94hBTGShdkBDelKFxOyRFUSEc
 K/8wfSv5T77HIqBsk5kCYY9EkUsd3aYVO6kZVQ5j4THQQW2BwWYxAgowRuVvhjohHg157S
 94uPFSbQVv0vCU3v3PdkRZ+tONekq4tsfHaai+joNkStJ2a4P/IZl+06qwQAQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeTUnZjxsy92MbdrUfxGZ9kKY0pquJGLJ5ZgTBm3gV8=;
 b=tw01I7IC1InnTgV3Tx9mxWonYI+NjgErFVUaq4Dbag+H62mXT9eSEUFE5UqfeqZ38Hp2SQ
 1h2Q25LBmzPflq0pvO+wTRPtAmniUUdl2wUqbOmXZbFrS60xL46pLUYJW1k1YL0ew1oZGU
 pN7fpItgN4YtGb9jcTDrzaBwIrd7yRWb3cnmaGCwSjnOJiQfV/uVS70NRurp3jbpjDg9hb
 cbwme7UU3ABFpRcQHGZ0OKqrDqv4nJbUsONQiNNllNPJ0tr5R6mmDjMWY2kg6lsjyvwU/e
 gh2bad+OJWDeWBRYmWqnmv3F3X/KJ0fOYwqfHYkOtargqGyQHgImGJCLo4Ha2A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 9/9] mtd: spi-nor: Always build SPI_STACKED_PARALLEL code
Date: Sat, 26 Oct 2024 22:16:26 +0200
Message-ID: <20241026201741.171073-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ac1f91wjqaz9p5qsm36dix44y7gs4eaj
X-MBO-RS-ID: aabf7eadb44be0abc39
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

Prevent the code gated by SPI_STACKED_PARALLEL from bitrot
by using if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) around
it. That way, it is always at least compiled.

Fixes: 5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Pratyush Yadav <p.yadav@ti.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/mtd/spi/spi-nor-core.c | 116 ++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 74aec6b60c4..a3a62fff213 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3047,13 +3047,6 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			       const struct flash_info *info,
 			       struct spi_nor_flash_parameter *params)
 {
-#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
-	struct udevice *dev = nor->spi->dev;
-	u64 flash_size[SNOR_FLASH_CNT_MAX] = {0};
-	u32 idx = 0, i = 0;
-	int rc;
-#endif
-
 	/* Set legacy flash parameters as default. */
 	memset(params, 0, sizeof(*params));
 
@@ -3172,62 +3165,69 @@ static int spi_nor_init_params(struct spi_nor *nor,
 
 		spi_nor_post_sfdp_fixups(nor, params);
 	}
-#if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
-	/*
-	 * The flashes that are connected in stacked mode should be of same make.
-	 * Except the flash size all other properties are identical for all the
-	 * flashes connected in stacked mode.
-	 * The flashes that are connected in parallel mode should be identical.
-	 */
-	while (i < SNOR_FLASH_CNT_MAX) {
-		rc = ofnode_read_u64_index(dev_ofnode(dev), "stacked-memories",
-					   idx, &flash_size[i]);
-		if (rc == -EINVAL) {
-			break;
-		} else if (rc == -EOVERFLOW) {
-			idx++;
-		} else {
-			idx++;
-			i++;
-			if (!(nor->flags & SNOR_F_HAS_STACKED))
-				nor->flags |= SNOR_F_HAS_STACKED;
-			if (!(nor->spi->flags & SPI_XFER_STACKED))
-				nor->spi->flags |= SPI_XFER_STACKED;
+
+	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+		u64 flash_size[SNOR_FLASH_CNT_MAX] = { 0 };
+		struct udevice *dev = nor->spi->dev;
+		u32 idx = 0, i = 0;
+		int rc;
+
+		/*
+		 * The flashes that are connected in stacked mode should be of same make.
+		 * Except the flash size all other properties are identical for all the
+		 * flashes connected in stacked mode.
+		 * The flashes that are connected in parallel mode should be identical.
+		 */
+		while (i < SNOR_FLASH_CNT_MAX) {
+			rc = ofnode_read_u64_index(dev_ofnode(dev), "stacked-memories",
+						   idx, &flash_size[i]);
+			if (rc == -EINVAL) {
+				break;
+			} else if (rc == -EOVERFLOW) {
+				idx++;
+			} else {
+				idx++;
+				i++;
+				if (!(nor->flags & SNOR_F_HAS_STACKED))
+					nor->flags |= SNOR_F_HAS_STACKED;
+				if (!(nor->spi->flags & SPI_XFER_STACKED))
+					nor->spi->flags |= SPI_XFER_STACKED;
+			}
 		}
-	}
 
-	i = 0;
-	idx = 0;
-	while (i < SNOR_FLASH_CNT_MAX) {
-		rc = ofnode_read_u64_index(dev_ofnode(dev), "parallel-memories",
-					   idx, &flash_size[i]);
-		if (rc == -EINVAL) {
-			break;
-		} else if (rc == -EOVERFLOW) {
-			idx++;
-		} else {
-			idx++;
-			i++;
-			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
-				nor->flags |= SNOR_F_HAS_PARALLEL;
+		i = 0;
+		idx = 0;
+		while (i < SNOR_FLASH_CNT_MAX) {
+			rc = ofnode_read_u64_index(dev_ofnode(dev), "parallel-memories",
+						   idx, &flash_size[i]);
+			if (rc == -EINVAL) {
+				break;
+			} else if (rc == -EOVERFLOW) {
+				idx++;
+			} else {
+				idx++;
+				i++;
+				if (!(nor->flags & SNOR_F_HAS_PARALLEL))
+					nor->flags |= SNOR_F_HAS_PARALLEL;
+			}
 		}
-	}
 
-	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
-		params->size = 0;
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++)
-			params->size += flash_size[idx];
-	}
-	/*
-	 * In parallel-memories the erase operation is
-	 * performed on both the flashes simultaneously
-	 * so, double the erasesize.
-	 */
-	if (nor->flags & SNOR_F_HAS_PARALLEL) {
-		nor->mtd.erasesize <<= 1;
-		params->page_size <<= 1;
+		if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
+			params->size = 0;
+			for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++)
+				params->size += flash_size[idx];
+		}
+		/*
+		 * In parallel-memories the erase operation is
+		 * performed on both the flashes simultaneously
+		 * so, double the erasesize.
+		 */
+		if (nor->flags & SNOR_F_HAS_PARALLEL) {
+			nor->mtd.erasesize <<= 1;
+			params->page_size <<= 1;
+		}
 	}
-#endif
+
 	spi_nor_late_init_fixups(nor, params);
 
 	return 0;
-- 
2.45.2

