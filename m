Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05738D0C604
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 20:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B827E88E6F;
	Sat, 26 Oct 2024 22:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aP9WZbXp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SyyAfgUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB40E89066; Sat, 26 Oct 2024 22:18:39 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC69E89045
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 22:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XbWF342H5z9swM;
 Sat, 26 Oct 2024 22:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrX6canwsPRk7Absj48A2L4NOOnm/t2ov3Dle4EUFyY=;
 b=aP9WZbXpSFs9HvUwsp8KkRFR7baiw96therfmyPrT7cdjFaLR+aOu4A9mv0ZHLTVPG+Dz/
 m2qtHeur3d34dST42I9XhAIxdtS5vtYY0tbqsNn+HjGnFkQHtcV/alDIwo5ep1R8UKbasv
 zHRH2DbY6V3Ge9n6rk5vmFDxJtbk5oGHVJQdd/uMOKqyHQeyDzjVY7H6tPNJyS7dJAgkP9
 /t36NlbWTFtsNStt/3cJES5KRBOZC2pWeKiWIJbt7hdcpNZ1UtzRjWnR3iPKPlNbNa7FKl
 y94p1rc68ZO/Jnq0fphWR1KQfsCkPwBwMv5b3A6vARkRjO6dakayEWl3O4SH+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729973909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrX6canwsPRk7Absj48A2L4NOOnm/t2ov3Dle4EUFyY=;
 b=SyyAfgUwPmnxD9K1BmGXJbQEgDRYb5zXJOCMaCIu6SsPQ4ZIM9rD+7nr/8RHwuWIeqEtMJ
 pqH4i9ITEK4MommsCjnczfMWck/FwD6nveqCccxHqoconb0owYOzIxEApwlnNM2YUqWIXx
 yGHp/TylsgoYHzTOWyrgBz31I9ms1NIadIG9OuuVZrjKP1sTkdhX+hWRGH5ruOpyRW7iFk
 87z6eo0PX0yvWk286Qz5R7Vtx88s45vmYTMpCNSbNwOJ8dAXt1INahAPPP8IiP0K7q6Jpa
 m7LereF9u1KmYF5Fjl836noMUjN1usWiqDqOWUhybEeQ0eN5chDsAEow3TPN6w==
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
Subject: [PATCH 5/9] mtd: spi-nor: Remove recently added SST special case
Date: Sat, 26 Oct 2024 22:16:22 +0200
Message-ID: <20241026201741.171073-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jg3n91fkx6ojbrzosywrsiyr3t8rxzqs
X-MBO-RS-ID: ee8424b1b04fda5e5b2
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

Remove undocumented SST special case. This was added in commit
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
 drivers/mtd/spi/spi-nor-core.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index d22363e8267..3c47751348e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3578,19 +3578,6 @@ static int spi_nor_select_erase(struct spi_nor *nor,
 			mtd->erasesize = info->sector_size;
 	}
 
-	if ((JEDEC_MFR(info) == SNOR_MFR_SST) && info->flags & SECT_4K) {
-		nor->erase_opcode = SPINOR_OP_BE_4K;
-		/*
-		 * In parallel-memories the erase operation is
-		 * performed on both the flashes simultaneously
-		 * so, double the erasesize.
-		 */
-		if (nor->flags & SNOR_F_HAS_PARALLEL)
-			mtd->erasesize = 4096 * 2;
-		else
-			mtd->erasesize = 4096;
-	}
-
 	return 0;
 }
 
-- 
2.45.2

