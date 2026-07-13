Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB96DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD2684BEC;
	Mon, 13 Jul 2026 15:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LSDPVjDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7019084BF0; Mon, 13 Jul 2026 15:31:07 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6D484BE3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=GWELQBHCH4uopkJT2l/cf+3b9EUU1Xm+L8YyOSV/NiE=; b=LSDPVjDc8a0v6mlFdJZijLBp6u
 GXfHI3fBQsi4qWb5va04KFjsC0tTV54IaO6IUMSWtYqS8ZF6bTu9X5n27PaI8JsqCrwIkznO/ZcG8
 T+sj1B7LQQNFYZSrZHxFinNjeNfBQJVIQipnKEqq1mcLYphkCC669c1lKnKmcD5qC1iXiqzA9Np+k
 B085LjcBgzdidlcYEEDI/7YC/6cDKDDXZgtsZHbyaP9BqjM8uK1oYxlRbmekZuuePDAY9KvjJaKLT
 VjWF7OeRK+BQ0YN0o5y/EIPiafM0mEg1q8uXO8gSS1qvuV/uZFpiOdIOW3dTpmmhhuDlO8hDuGOOD
 CPpxiD/Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHt-000Dma-2h; Mon, 13 Jul 2026 15:01:33 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wjGHs-000Hfn-30; Mon, 13 Jul 2026 15:01:33 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Paul Gerber <Paul.Gerber@ew.tq-group.com>
Subject: [PATCH 4/6] board: tqma6: use runtime SoC detection in enet setup
Date: Mon, 13 Jul 2026 15:01:04 +0200
Message-ID: <20260713130109.321862-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
References: <20260713130109.321862-1-Max.Merchel@ew.tq-group.com>
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

Select the appropriate iomux settings based on the CPU type
during ethernet configuration.

Signed-off-by: Paul Gerber <Paul.Gerber@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6_mba6.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 32aeb1b07c8..8cc5857b06f 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -33,21 +33,11 @@
 
 #include "../common/tq_bb.h"
 
-#if defined(CONFIG_TQMA6Q)
-
-#define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
-#define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e07ac
-
-#elif defined(CONFIG_TQMA6S) || defined(CONFIG_TQMA6DL)
-
-#define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0768
-#define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e0788
+#define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
+#define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM		0x02e07ac
 
-#else
-
-#error "need to select module"
-
-#endif
+#define TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0768
+#define TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM	0x02e0788
 
 /* disable on die termination for RGMII */
 #define IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE	0x00000000
@@ -63,10 +53,17 @@ static void mba6_setup_iomuxc_enet(void)
 	/* clear gpr1[ENET_CLK_SEL] for externel clock */
 	clrbits_le32(&iomuxc_regs->gpr[1], IOMUXC_GPR1_ENET_CLK_SEL_MASK);
 
-	__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
-		     (void *)IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
-	__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
-		     (void *)IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	if (is_mx6sdl()) {
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
+			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
+			     (void *)TQMA6DL_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	} else if (is_mx6dq()) {
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM_DISABLE,
+			     (void *)TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM);
+		__raw_writel(IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V,
+			     (void *)TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII);
+	}
 }
 
 int board_mmc_get_env_dev(int devno)
-- 
2.43.0

