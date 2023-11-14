Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DE0C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 07:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291708714C;
	Tue, 14 Nov 2023 08:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1699948127;
	bh=YCWZ8dKC1uE8Td/3yttjTBYAiPT7eJJXCAnRhguhsUo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OqddelR/KGTR5Goa/MH477tubqXr0XslNknA4G8KRtLMgGHUNnotsTHXk9rDNbzx7
	 TjFnRq6ZGehA1ABxfKM/t3Fhx4sVcTA3qfjOw4CnDibehsdL6xNcBGwu9ln+ADysk7
	 KN8qTVXzLHfVGmz2mAgK8v6UTRLvpDktcpsjfGwAvFMETQFy2ZsCuEWezZ5BVlXK++
	 kTVCcQX6JYpF/h4E8PSPwOdgsT7harAT/C7zihskWILBf8BWft4LJ1yJtjoIBRqvG+
	 hNKiynXl32Owq+brvIAPQMcF2FEJfSBwZ8WsxkbvkMnOusWVZWQBXsl/J+J9/tTdYL
	 UO5EgI9seLs9g==
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: noc@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0D50287129;
 Tue, 14 Nov 2023 08:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1699948126;
 bh=YCWZ8dKC1uE8Td/3yttjTBYAiPT7eJJXCAnRhguhsUo=;
 h=From:To:Cc:Subject:Date:From;
 b=pSEVZD8AoAlAg/3XDm1jbZSQsJeVQ3/mEl3mqGe9aega0c3INqF6ukptGnzyuhrnZ
 RYa2ebzh78EsYH4P/RhVNGxyJg0lpoHqD7nyM8dkYVaHJJPVMy2AwU8wjrAK2LbxGd
 UB+Im78HY6gfyJNq6+q/lnfgw/pSvVpNfSgF/VDmtI0wJIM8DqxJ0IEybCqYjoK/Ia
 KeiDEw0UVxByN3J7uaI/ZLyyWTKbtaCpv/SFJnMUoTh45BZSMF3H3KndroWLgKvWts
 g7blyM3CuIIAPOubVvbn18iusZBmoV+M5pXSUMMpq+cZUUhl+//Z6nAapUxHSlsdKo
 yrpr3fcBwdadw==
Received: from pollux.denx.de (pollux [192.168.1.1])
 by mail-internal.denx.de (Postfix) with ESMTPS id 7FA86180A2D;
 Tue, 14 Nov 2023 08:48:44 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
 id 526A61A0093; Tue, 14 Nov 2023 08:48:44 +0100 (CET)
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: rawnand: omap_gpmc: remove unneeded variable
Date: Tue, 14 Nov 2023 08:48:38 +0100
Message-Id: <20231114074838.3534552-1-hs@denx.de>
X-Mailer: git-send-email 2.37.3
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

remove unneeded variable ecc_flag in omap_correct_data_bch

Signed-off-by: Heiko Schocher <hs@denx.de>
---
azure build is fine with this patch:

https://dev.azure.com/hs0298/hs/_build/results?buildId=110&view=results

 drivers/mtd/nand/raw/omap_gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 1a5ed0de31..1fe8b1671e 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -637,13 +637,13 @@ static int omap_correct_data_bch(struct mtd_info *mtd, uint8_t *dat,
 	uint32_t error_count = 0, error_max;
 	uint32_t error_loc[ELM_MAX_ERROR_COUNT];
 	enum bch_level bch_type;
-	uint32_t i, ecc_flag = 0;
+	uint32_t i;
 	uint8_t count;
 	uint32_t byte_pos, bit_pos;
 	int err = 0;
 
 	/* check calculated ecc */
-	for (i = 0; i < ecc->bytes && !ecc_flag; i++) {
+	for (i = 0; i < ecc->bytes; i++) {
 		if (calc_ecc[i] != 0x00)
 			goto not_ecc_match;
 	}
-- 
2.37.3

