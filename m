Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5713FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6D984099;
	Sat, 25 Apr 2026 18:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ifm.com header.i=@ifm.com header.b="Gz/cZwNZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EED383FB0; Sat, 25 Apr 2026 18:20:08 +0200 (CEST)
Received: from pp2023.ppsmtp.net (pp2023.ppsmtp.net [132.145.231.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989FC840ED
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ifm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedor.ross@ifm.com
Received: from pps.filterd (pp2023.ppsmtp.internal [127.0.0.1])
 by pp2023.ppsmtp.internal (8.18.1.7/8.18.1.7) with ESMTP id 63NBsBHE002802;
 Thu, 23 Apr 2026 13:54:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ifm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps; bh=gq1nTI
 y+/CDUeeEW0Wf7DuXiYs29wnqt7zrmzUhsIes=; b=Gz/cZwNZBRiDMKTaSyIopF
 5GsU9bjyo65RWXeo57c8aDv1lWgteXD+jLma74AR1aOhYrIZdR/0WdUswjTbMze0
 gPNu2mRRCld0VgKIGwPbSowJ3cfWNq1dP/bdfCIQNAced6qBxV9VZ8XU7Nl3sE/i
 sYnO50TlGK+gLGvCzUxs0s4xbr6l4PNjAhuttn6XFg8yZfOeWXgJ1q2BzunAP0vJ
 USPr5fXz9aW1gly0CJoFKQHVMaCVmbMaIhlhXc08JdWCfKFuN7C0S6Y76NrxCEV6
 PlsKZuCby6s/qoEgTjr/Rpqjxi0c0v6hUAq07Bi98aV6qmfDKn87a5riu+t78/lg
 ==
From: <fedor.ross@ifm.com>
Date: Thu, 23 Apr 2026 13:54:42 +0200
Subject: [PATCH 1/2] imx: Add SPI NOR A/B switching support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260423-b4-imx95_img_set_sel-v1-1-1681ea8b1507@ifm.com>
References: <20260423-b4-imx95_img_set_sel-v1-0-1681ea8b1507@ifm.com>
In-Reply-To: <20260423-b4-imx95_img_set_sel-v1-0-1681ea8b1507@ifm.com>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Fedor Ross <fedor.ross@ifm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776945295; l=1766;
 i=fedor.ross@ifm.com; s=20251127; h=from:subject:message-id;
 bh=uR3X3hZ2xg9FNfKuMBITAnOd9FWGT1xbvVk4gG0nyEw=;
 b=4+TNGKzuXgj41mOjHbJaK04PrHJUp+auCfoS8ZE1NYWJy8K4xVBysb14v27HT74X/2rrHifs2
 NABt5Gkqt40AWZGvFW+SVVBVj9oWiSwKU3Qzg8ItykSYnY1/nbD4V2O
X-Developer-Key: i=fedor.ross@ifm.com; a=ed25519;
 pk=QXV2AUGQzqdu1EMmSJgH2f2Z1Mu1wSx7+5+dcQzQ864=
X-Originating-IP: [172.19.129.122]
X-ClientProxiedBy: DEESEX10.intra.ifm (172.26.140.25) To DEESEX10.intra.ifm
 (172.26.140.25)
X-Proofpoint-ID: SID=4dpjh9dc95 QID=4dpjh9dc95-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
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

From: Marek Vasut <marex@nabladev.com>

Query the SM via SCMI, obtain rom_passover_t->img_set_sel and based on
that, add 0 or 0x400000 offset (A or B copy offset) to boot container
read address.

Signed-off-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
---
 arch/arm/mach-imx/image-container.c | 10 ++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c   | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 7bfcc9d7e9d..eeea0b80b39 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -204,6 +204,8 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 	return ret;
 }
 
+extern u8 imx95_detect_secondary_image_boot(void);
+
 static bool check_secondary_cnt_set(unsigned long *set_off)
 {
 #if IS_ENABLED(CONFIG_ARCH_IMX8)
@@ -227,6 +229,14 @@ static bool check_secondary_cnt_set(unsigned long *set_off)
 	}
 #endif
 
+#if IS_ENABLED(CONFIG_IMX95)
+	u8 img_set_sel = imx95_detect_secondary_image_boot();
+
+	*set_off = img_set_sel ? 0x400000 : 0;
+
+	return !!img_set_sel;
+#endif
+
 	return false;
 }
 
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..330b276b23a 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -745,6 +745,19 @@ void build_info(void)
 	puts("\n");
 }
 
+#if IS_ENABLED(CONFIG_IMX95)
+u8 imx95_detect_secondary_image_boot(void)
+{
+	rom_passover_t rdata = { 0 };
+	int ret = scmi_get_rom_data(&rdata);
+
+	if (!ret)
+		return rdata.img_set_sel;
+
+	return 0;
+}
+#endif
+
 int arch_misc_init(void)
 {
 	build_info();

-- 
2.47.3

