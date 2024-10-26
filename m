Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2666FD10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3006689070;
	Sat, 26 Oct 2024 22:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MMhpFcrf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S/0ANqqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E18289045; Sat, 26 Oct 2024 22:18:41 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433E488B1F
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XbWF608kcz9slg;
 Sat, 26 Oct 2024 22:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tcq2n+hybtG1blHsjbiuXXq0He8UxCx2e4DuNROHdzk=;
 b=MMhpFcrfci7xPfTOcV7GllNNSRlJ7jvjYfi5FyWMys/rFdz0xihKOVNJCPd3WQAd6Dr86S
 g+NeFgxE4jd5VIJMOz+BHNHWywcYJSFQiXyFjjnBNK1LUye/G0TP0SLSUXkZfT4mcMG1zg
 PShbImUVLXUGtWiej9KBvbWnea1HLPekNgnK1mdXnbtwDO6Rm2Lgc8h+2NMlxEiDUFvmqM
 wfoEBv7dRJzTqJqI66N1NGIiyiG09bxM6XBmOua0Dg0OiPJKWEBLaDrjsPDCR+0P5AonYh
 oQKzDx8R9v4u0mBAKcDS/d4C6B1wjBlbfEa03EQCP5yOtVAFX20LuJ6mVz/OFQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tcq2n+hybtG1blHsjbiuXXq0He8UxCx2e4DuNROHdzk=;
 b=S/0ANqqXrJteHTWjy17E/LL6kRdstmCd9C9pWw1lGCFbEFvrLsDBRBAfHzrTRPvbwNWj0x
 ixu4mgO4KWjOXFBH13JuZrxRncfzMq7rPLa8pXxNPLQ0Exm6DXH2GRSaLyDC01QdX2YzHF
 td0aWGX14rkDHfg0fnqQ/UQxpRTOBPc1dUGLc7bqzCPWA+bpQ05JuDjDdbpGohBHHVQGTr
 UkwAzTeK7DCPvHvdK0plarB+2sKsIQUGg8hUDcEzkJ3I3+VHXqBh1y9XHJigN9Mtp+kVCB
 iY8yXQ8DWAZL++YlFhPG/ati5147L+AVOeFYIaJJ0cpXNkLBeoo4VkPaLlFgqg==
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
Subject: [PATCH 6/9] mtd: spi-nor: Fix multiple coding style issues
Date: Sat, 26 Oct 2024 22:16:23 +0200
Message-ID: <20241026201741.171073-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tdddyxc93t5mqsxtorzk456amx41ehcj
X-MBO-RS-ID: de35553da99372237c2
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

The offset variable is set, but never used afterward.
Fix indent. Fix predecrement without justification.
Remove use of parenthesis where unnecessary.

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
 drivers/mtd/spi/spi-nor-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 3c47751348e..e49b7cad023 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1134,12 +1134,10 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 			offset /= 2;
 
 		if (nor->flags & SNOR_F_HAS_STACKED) {
-			if (offset >= (mtd->size / 2)) {
-				offset = offset - (mtd->size / 2);
+			if (offset >= (mtd->size / 2))
 				nor->spi->flags |= SPI_XFER_U_PAGE;
-			} else {
+			else
 				nor->spi->flags &= ~SPI_XFER_U_PAGE;
-			}
 		}
 #ifdef CONFIG_SPI_FLASH_BAR
 		ret = write_bar(nor, addr);
@@ -1588,7 +1586,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
 
 	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
-	    /* We can hit this case when we use file system like ubifs */
+		/* We can hit this case when we use file system like ubifs */
 		from--;
 		len++;
 		is_ofst_odd = true;
@@ -1969,9 +1967,9 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			return ret;
 
 		*retlen += 1; /* We've written only one actual byte */
-		++buf;
-		--len;
-		++to;
+		buf++;
+		len--;
+		to++;
 	}
 
 	for (i = 0; i < len; ) {
@@ -1991,7 +1989,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 			page_offset = do_div(aux, nor->page_size);
 		}
-		offset = (to + i);
+		offset = to + i;
 		if (nor->flags & SNOR_F_HAS_PARALLEL)
 			offset /= 2;
 
-- 
2.45.2

