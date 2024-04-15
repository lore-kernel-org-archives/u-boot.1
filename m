Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4605BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36CF18822F;
	Mon, 15 Apr 2024 08:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E53F881FB; Mon, 15 Apr 2024 08:08:18 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A458820E
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYX0tFSz9t0b;
 Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ic2fAQwYUiYY; Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK5D8Rz9t7B;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AEC1B8B764;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Mtg2vgzvGxLf; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C1FF8B778;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 11/17] powerpc: 8xx: Set SDMA configuration register
 correcly
Date: Mon, 15 Apr 2024 08:07:24 +0200
Message-ID: <ae8013855888d0a9c31fbc88a282378c52d5efe3.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

SDMA configuration register needs to be set up only once and doesn't
belong to drivers. Also, the value to be used is different on mpc885.

So do the init in cpu_init_f() with 0x40 for mpc885 and 0x1 for others.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/cpu/mpc8xx/cpu_init.c | 6 ++++++
 drivers/spi/mpc8xx_spi.c           | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/cpu/mpc8xx/cpu_init.c b/arch/powerpc/cpu/mpc8xx/cpu_init.c
index aac4203a6e..d1abe8f00b 100644
--- a/arch/powerpc/cpu/mpc8xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc8xx/cpu_init.c
@@ -92,6 +92,12 @@ void cpu_init_f(immap_t __iomem *immr)
 				CONFIG_SYS_PLPRCR);
 #endif
 
+	/* Set SDMA configuration register */
+	if (IS_ENABLED(CONFIG_MPC885))
+		out_be32(&immr->im_siu_conf.sc_sdcr, 0x0040);
+	else
+		out_be32(&immr->im_siu_conf.sc_sdcr, 0x0001);
+
 	/*
 	 * Memory Controller:
 	 */
diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index 2aa9c7d5df..0d142f12e9 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -103,10 +103,6 @@ static int mpc8xx_spi_probe(struct udevice *dev)
 	while (in_be16(&cp->cp_cpcr) & CPM_CR_FLG)
 		;
 
-/* 5 */
-	/* Set SDMA configuration register */
-	out_be32(&immr->im_siu_conf.sc_sdcr, 0x0001);
-
 /* 6 */
 	/* Set to big endian. */
 	out_8(&spi->spi_tfcr, SMC_EB);
-- 
2.43.0

