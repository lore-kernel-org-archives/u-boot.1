Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F31C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B856A80DDF;
	Mon, 27 Jul 2026 12:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKjBbymsCe_g; Mon, 27 Jul 2026 12:06:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9EA780DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153987;
	bh=kwXr+M2bCkvKR2Pt6YqTKDeyfNH9IzdhKhXCNsAEf4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tcHK8YN6ZRLbLIT0j7iYX3FqLfjkv6AS0OOjqhICdDxEJ9zcBmSPGptbTU+pNE0NX
	 3FMKM2f0YHqGKCvRL8m+b/mU8YGtfr62CwSCzCm+H6mgE5fXzPPeP6ZN8ZN81V6cYX
	 HHGa/pMaQpVwr9h6BemSMj2/vZj5beiKfbWpacsJyu+D3lRJL7tlyK0PqNbkwH3/FI
	 A0QgVWPa/Ds2ZAySYORN0GMjyqRqDFWog3roxK8PVzoUwFMSwq+fZVgjru7OulPiLN
	 G5cfLWR3KZAtlzfLULJ+o19X1FfbbQyjV2mikZwJLODk4es+A9V1T2H70vJH/gY6dC
	 viI3pSkg6NSzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9EA780DDA;
	Mon, 27 Jul 2026 12:06:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CBF8C78A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDCD780D77
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQQrPTbw9aGF for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:06:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A9D5780D5C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9D5780D5C
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9D5780D5C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:06:20 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000JMn-0s; Mon, 27 Jul 2026 14:06:18 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woK66-000I7f-01; Mon, 27 Jul 2026 14:06:17 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 14:06:18 +0200
Subject: [PATCH RESEND 4/6] board: tqma6: use runtime SoC detection in enet
 setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6_bis_spl-v1-4-27673934830f@ew.tq-group.com>
References: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
In-Reply-To: <20260727-tqma6_bis_spl-v1-0-27673934830f@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org
Cc: Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kwXr+M2bCkvKR2Pt6YqTKDeyfNH9IzdhKhXCNsAEf4E=; b=SSEldIKnu/ApbfeZ9iRC+U9I1W
 4RrwdfmuxNnYkfGImhMjF1nR/NRrGGrYGvsXjO+Aiyj1QZeve1F/BnWIwqfPjJQUFm/QrVeu9xp4/
 fR2/qHIIH1VDVK02+HiG1bxuVsx4xZb/7EvquzjYSrTNdnCAJkXAcrdznMQj4/HrLDsHvFH0vzsD8
 o6HWecXCeTm6xggoXQCQhJ0DYxShbe9mDyD9xIsp3tO/vj+FO4CeaUQQMUttNgNerUkeuBMnTvEJK
 123wnArY8mnffMrEAe5EbdRoMSrqsgzPhXKd42gAQ5FtuVVRAbpy2Zl3K1mmkhNGoTD9q+4YqFAB4
 K6iB9lgg==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=SSEldIKn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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

