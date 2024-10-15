Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A010D1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 20:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D211889E9;
	Tue, 15 Oct 2024 22:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729023326;
	bh=oris4kezGZtUPkXpwu3yTknUo0uTLNwMBqCNzosMJuI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JBMBvpZ3J7cPgbQ37+hCwyZ/pYmW9yuMk7RHpChbX1k6Y+h4Kwxfw64UU0JvcVm59
	 4i4c153EPdcy2F3nKVJlX6aKlN8+PkAifkJSbRyhxBq8fIRZpi2eD7QiwsHsbL/zB9
	 Pmjq8RpX/iep6gta5B25jf4geYmK0oYmFkqLzzI7T6oM+67xDR2rW23l6x0x8qnPCi
	 wQQqxT+CHm6D0WOZ5rNXsdGAP2Lp9+udOTqyP/CsFd5WvGKTWYxB8shPF//EBD0NC+
	 QeIKOHY7G4cs9KqMBBDO85ztqICA3eiR63e2x5KxWgbm2xaZYKUzCwPbDUONS46bm/
	 hGuY+A5zxldJw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3735188A1B;
 Tue, 15 Oct 2024 22:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729023324;
 bh=oris4kezGZtUPkXpwu3yTknUo0uTLNwMBqCNzosMJuI=;
 h=From:To:Cc:Subject:Date:From;
 b=EZnHAbRG3+grHHQkLgGSJFKytetSv57NzZaeOa24TFMVbWJPYgVjABycZzLxka4oI
 qyCujNKeIqWenD0mK+ZFsw7ym92nZXD/efvpqidu5hS71nAezyuN2nUm4CoVfCNNxx
 7bNtXe6brM4bTQPp185elYWqbgkHUm5UzOYw5+DrtWp89822V3wXF41nVNDwnIN/4E
 OrhbNxqGdkrzeQ5WPh4nWgt6VJImTjxHa3XK+GABkDtIC+4tKsdig2D6u9jLeFcghQ
 qMuOt2mGElUq/GRIgmBI8Z+pyP0ZghZncVEfy71K51BXPsEnuV2/MGaynQNFAJFJRb
 U6EWjm12Y5MPQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Move SR3 WPS bit definition in the correct
 location
Date: Tue, 15 Oct 2024 22:14:53 +0200
Message-ID: <20241015201513.21836-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Move the SR3 bit definition in the right place. Fix
what is likely a rebase artifact. No functional change.

Fixes: 215f1d5794c6 ("mtd: spi-nor: Clear Winbond SR3 WPS bit on boot")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Johann Neuhauser <jneuhauser@dh-electronics.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Vignesh R <vigneshr@ti.com>
---
 include/linux/mtd/spi-nor.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1ae586b2e5f..655a6d197ea 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -182,15 +182,15 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* Status Register 3 bits. */
+#define SR3_WPS			BIT(2)
+
 /*
  * Maximum number of flashes that can be connected
  * in stacked/parallel configuration
  */
 #define SNOR_FLASH_CNT_MAX	2
 
-/* Status Register 3 bits. */
-#define SR3_WPS			BIT(2)
-
 /* For Cypress flash. */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
-- 
2.45.2

