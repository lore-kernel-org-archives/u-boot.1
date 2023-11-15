Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864A4C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 05:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9FF86C3B;
	Wed, 15 Nov 2023 06:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700026849;
	bh=cm2XPSMeyos3KtlQikhghlsSFPHFJX7SAJ9j8Bc+n1A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M6tc3ciN5Irg49wIE7z0pTz18FRBbsbAOY7WEgiD2yA2+/qJFSgSwXV8cssWF6kgY
	 qGZY+OirlRfozQaKrvnt+26HLVkVJa2WFY03WAGoYzEYSnalrfjCinepv7W4qhsLfR
	 d/MwybbamN6qyqNufRSj469w+N1x/GkBBI/Z+amK5Hh2JFyJODcikQo55SKr7ZiSLI
	 J1M1IOT8Wx+AMANc/9IC8NaFry8Vqr69oB/7+DztgP9xrilqiFH0UxzeOPuAuWz0OK
	 NZkkhpBRx+iVPNLaedMqd9BiKkLZG6kN8KbU2FfZY97kjIj2mSudrFH2xvlmHtVEJZ
	 cvepEzrvJ+n+g==
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: noc@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07A5C86308;
 Wed, 15 Nov 2023 06:40:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700026848;
 bh=cm2XPSMeyos3KtlQikhghlsSFPHFJX7SAJ9j8Bc+n1A=;
 h=From:To:Cc:Subject:Date:From;
 b=JsOkGaw6Is26J6mwER3t8bqk+Ja/i8ZK4c4lFSF4U9q6/3LWwYoekTCh5KbhPOA5c
 k48K+ot3x8OSHx275OkrUFNNIjLFDs21lFncoB56qxcH+QY4zIg79asJWOPQ5JKngC
 ebwBnCrM8Lxbj3E05sUzJmZY3JdLgbMaynsl86Mkaf5IFj5gauCHBEz58te5ARS1ii
 9OYhPg0IMA4mKzwHsS6mwj0Ql2plJwuYY9oGPNQ/SyxdSfStt4Ia2hNQCFs/pCZr/J
 LNUM/Uy1g1Ae0VEb6HL7SUj0P0u/JJSsldX0dyEKTy4o+b7F3gG0SMIOamm3SQwMe3
 2OEgesqaHo6gQ==
Received: from pollux.denx.de (pollux [192.168.1.1])
 by mail-internal.denx.de (Postfix) with ESMTPS id 70459180973;
 Wed, 15 Nov 2023 06:40:46 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
 id 1B9921A0083; Wed, 15 Nov 2023 06:40:46 +0100 (CET)
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>
Cc: Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
Date: Wed, 15 Nov 2023 06:40:44 +0100
Message-Id: <20231115054044.3937543-1-hs@denx.de>
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

commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")

broke AM335x based boards booting from NAND with ECC BCH8 code.

Use omap_enable_hwecc() instead of omap_enable_hwecc_bch()
in SPL restores correct SPL nand_read_page functionality.

Tested on draco thuban board.

Signed-off-by: Heiko Schocher <hs@denx.de>

---
fix NAND boot for BCH8 based TI AM335x boards

Fix is based on series from Enrico:

https://lists.denx.de/pipermail/u-boot/2023-November/536793.html

and fixes NAND boot for the draco thuban board. But this patch
apply also without the patches from above patchseries, see
azure build:

https://dev.azure.com/hs0298/hs/_build/results?buildId=111&view=results

which is clean.

Above commit seems to change only U-Boot code and did not
adapt am335x_spl_bch.c, which breaks nand_read_page in SPL
code for AM335x based boards. So use in SPL "old" hw setup
and reading page from NAND in SPL works again.


 drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index 1a5ed0de31..c9b66dadbd 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct nand_chip *nand,
 		nand->ecc.strength	= 8;
 		nand->ecc.size		= SECTOR_BYTES;
 		nand->ecc.bytes		= 14;
+#if defined(CONFIG_SPL_BUILD)
+		nand->ecc.hwctl		= omap_enable_hwecc;
+#else
 		nand->ecc.hwctl		= omap_enable_hwecc_bch;
+#endif
 		nand->ecc.correct	= omap_correct_data_bch;
 		nand->ecc.calculate	= omap_calculate_ecc_bch;
 		nand->ecc.read_page	= omap_read_page_bch;
-- 
2.37.3

