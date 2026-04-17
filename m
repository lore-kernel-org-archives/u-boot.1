Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D9F8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 02:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DFD84228;
	Fri, 17 Apr 2026 04:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44AF2842BF; Fri, 17 Apr 2026 04:41:06 +0200 (CEST)
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF98C8422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 63H2edcq033481;
 Fri, 17 Apr 2026 10:40:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 10:40:39 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, "Takahiro
 Kuwano" <takahiro.kuwano@infineon.com>, Jagan Teki
 <jagan@amarulasolutions.com>, <ycliang@andestech.com>
Subject: [PATCH 7/8] mtd: spi-nor: Add Macronix MX25U quad-mode fixups
Date: Fri, 17 Apr 2026 10:40:33 +0800
Message-ID: <20260417024034.4046667-3-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417024034.4046667-1-ycliang@andestech.com>
References: <20260417024034.4046667-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 63H2edcq033481
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

Add quad mode (1-4-4) read and page program fixups for Macronix
MX25U1635E and MX25U25635F SPI NOR flash chips. These chips do not
properly expose their quad capabilities via SFDP, requiring explicit
fixup hooks.

The fixup enables SNOR_HWCAPS_READ_1_4_4 and SNOR_HWCAPS_PP_1_4_4
capabilities with the appropriate opcodes and protocols.

Both chips share the same fixup function since their quad mode
configuration is identical.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/mtd/spi/spi-nor-core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..d8a073fef3f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4248,6 +4248,21 @@ static struct spi_nor_fixups macronix_octal_fixups = {
 	.post_sfdp = macronix_octal_post_sfdp_fixup,
 	.late_init = macronix_octal_late_init,
 };
+
+static void macronix_quad_post_sfdp_fixup(struct spi_nor *nor,
+					  struct spi_nor_flash_parameter *params)
+{
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_1_4_4 | SNOR_HWCAPS_PP_1_4_4;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_4_4],
+				  0, 8, SPINOR_OP_READ_1_4_4,
+				  SNOR_PROTO_1_4_4);
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_1_4_4],
+				SPINOR_OP_PP_1_4_4, SNOR_PROTO_1_4_4);
+}
+
+static struct spi_nor_fixups macronix_quad_fixups = {
+	.post_sfdp = macronix_quad_post_sfdp_fixup,
+};
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
@@ -4544,9 +4559,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-	if (JEDEC_MFR(nor->info) == SNOR_MFR_MACRONIX &&
-	    nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
-		nor->fixups = &macronix_octal_fixups;
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_MACRONIX) {
+		if (nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
+			nor->fixups = &macronix_octal_fixups;
+		else if (!strcmp(nor->info->name, "mx25u1635e") ||
+			 !strcmp(nor->info->name, "mx25u25635f"))
+			nor->fixups = &macronix_quad_fixups;
+	}
 #endif /* SPI_FLASH_MACRONIX */
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
-- 
2.34.1

