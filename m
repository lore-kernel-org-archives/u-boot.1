Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5853D10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3601B89051;
	Sat, 26 Oct 2024 22:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m8F2C8RG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QroXca94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E60C788D70; Sat, 26 Oct 2024 22:18:30 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B105689058
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XbWDw1YNFz9t3b;
 Sat, 26 Oct 2024 22:18:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEiwIN9kew2gB8b0Hp3qTXyd/l5nRR2lAX6+QuexzH4=;
 b=m8F2C8RGcuH0riIg1KuKjOpxVXhnTvvL0ml4v2mjbW7QHB3flMrCQqpkljNwUjbGcN1S+a
 qhV7C0eZPFZ6JmYdM59pSyK1+k0VMIL0T4ZwKk44yOcew+2nxnx7Ox8k5Pj+ByjD/kKshH
 AZQUOUacrP5+J3KD0U+4vz0USkBAO0hCP3wYbADSY/bEISXDBPl8VIAtIQ1IWzypFZ06UF
 FH+Tk3l8eB2dFnY8WG+cpBxawXskVJdyT3W//DNCvktxyvN3xcxVVH1bC/ndB2H9Ta0GZd
 0CavKTObamyTTUghnNhCuSvCpVgkwxE9S3Cpain13CkfSvpDZftw/e8V20xsxw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEiwIN9kew2gB8b0Hp3qTXyd/l5nRR2lAX6+QuexzH4=;
 b=QroXca94vcSoCQRJXFPj3ZOxkOGeG8Nbp9SkHey/r72VTve+kiM2ZYkWIOVCBBIjUcRZu8
 34HdVvUMu6BrIwqGJc9K6gJ9Z3Ti1bengaGCafgvkILEWT8iXYEckIbO1C8VtoTszigdDl
 BdVUz9Os6cyVTkAmGxOWEVU12/H4rWcGjQOHDUA9/J8Wx7bnhfEgFvLbY2c/km3L03Amz7
 3+wp5xRez5BAVVX4GhalEP7cLTvdIurGCwAdk3CI2b8uNJwsSMetqR9rSBQXkhtNVXuy8X
 NgoSdXrXyUVKxLTzB0stb6SovMjmLN6ICpHziMstiwuaNcLilX1BueXWpu00RA==
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
Subject: [PATCH 2/9] mtd: spi-nor: Remove recently added
 spi_nor_wait_till_ready() call
Date: Sat, 26 Oct 2024 22:16:19 +0200
Message-ID: <20241026201741.171073-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bkrkms5rtftmi5anogwgwwxtbhynjjnc
X-MBO-RS-ID: 2787c5824ccf8689503
X-Rspamd-Queue-Id: 4XbWDw1YNFz9t3b
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

Remove undocumented spi_nor_wait_till_ready() call. This was added in commit
5d40b3d384dc ("mtd: spi-nor: Add parallel and stacked memories support")
without any explanation in the commit message. Remove it.

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
 drivers/mtd/spi/spi-nor-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 8dfdcda47fb..0b131ad9aba 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1631,10 +1631,6 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (read_len == 0)
 			return -EIO;
 
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto read_err;
-
 		ret = nor->read(nor, offset, read_len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
@@ -2018,10 +2014,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 		page_remain = min_t(size_t,
 				    nor->page_size - page_offset, len - i);
 
-		ret = spi_nor_wait_till_ready(nor);
-		if (ret)
-			goto write_err;
-
 		write_enable(nor);
 		/*
 		 * On DTR capable flashes like Micron Xcella the writes cannot
-- 
2.45.2

