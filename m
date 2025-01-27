Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C9AC0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 01:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439E680F98;
	Mon, 27 Jan 2025 02:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737939762;
	bh=3FsSuvcG6rQOQydZRd6c6jX1L/ILnxGRB5bm49MUTVU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K6vw9g40yF7TbtplIcMAPHDA4lTbm3FPfh/WaXX4vwBJcmP/z9OvRQEzAx4dYOH4R
	 MMKdWdJ2zNyIQYz8WjoWCD+wtl52Z7h2zJdRXW92he+U9+ZKSprShkvt1JPoE997G1
	 1I0l/J08E4Rcr/Ut99mvr1XM/+lwjEE4XJOp4n9yUv4JW9QSRLWErjSZUzRYMmYWoG
	 jm1Fh8AOhzcXw5/MxxBg6pYHsLvTp+9H0KKT9YetoM6yMRK5GTlI0DK7EfcyGKZ2xy
	 PsQcw2Fm/eN7XbyWBHHkxbuyMieDrf0X9BMS9vLpUdMM2GvkRz/3TcxYq1VfbH6WnV
	 Z6dj3bRr0qqQg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4144680F9E; Mon, 27 Jan 2025 02:02:41 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BA080ECD
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 02:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CYOrWRcV"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 761E71049BF23; Mon, 27 Jan 2025 02:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737939757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3FsSuvcG6rQOQydZRd6c6jX1L/ILnxGRB5bm49MUTVU=;
 b=CYOrWRcVjYYFlrBWmUBmomlY20qkiesq4IOqAhUWY3rgbTgD7sVTQfykr0OEGKsnKoN+Ij
 1oYzgoTKoQg5NEG53OG6NJKCUUgb0gs//mrFXiKruohL3plZWhiNZ1vTb3VKzK/niVOZx6
 6wGmyhhMEEBrtQY94f/WZXQ9JRX+JtkV/T7ACcT3ANj7hsj070kSVZPCSXxD1satljrbjm
 U16fky68wDpI++DPNGWPFa1oZ7zeXJjC/ddbX2Y+fNahZvaEpgvha/VVWGf4QNdsaWbN4y
 tpiOF7CvBVzzunm4ITOEw63yyYu+J8T4Cx7PMGL4LW5AJcvOWu1p/mVzmqbhDA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH] net: fsl_enetc: Enable optional ENETREF clock on i.MX95
Date: Mon, 27 Jan 2025 02:02:08 +0100
Message-ID: <20250127010215.555205-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The ENETCv4 port DT nodes on i.MX95 may contain optional clock phandle
to IMX95_CLK_ENETREF "ref" clock. These "ref" clock must be enabled for
the ethernet to work. These "ref" clock are enabled after cold boot, but
when the system booted Linux and rebooted, those "ref" clock might have
been disabled in the process, which would make ethernet inoperable after
reboot. Make sure those "ref" clock are always correctly enabled.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 67ef5f34a8a..52fa820f518 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -5,6 +5,7 @@
  * Copyright 2023-2025 NXP
  */
 
+#include <clk.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdt_support.h>
@@ -981,11 +982,31 @@ static const struct eth_ops enetc_ops_imx = {
 	.read_rom_hwaddr	= enetc_read_rom_hwaddr,
 };
 
+static int enetc_probe_imx(struct udevice *dev)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_enable(clk);
+	if (ret)
+		return ret;
+
+	ret = enetc_probe(dev);
+	if (ret)
+		clk_disable(clk);
+
+	return ret;
+}
+
 U_BOOT_DRIVER(eth_enetc_imx) = {
 	.name		= ENETC_DRIVER_NAME,
 	.id		= UCLASS_ETH,
 	.bind		= enetc_bind,
-	.probe		= enetc_probe,
+	.probe		= enetc_probe_imx,
 	.remove		= enetc_remove,
 	.ops		= &enetc_ops_imx,
 	.priv_auto	= sizeof(struct enetc_priv),
-- 
2.45.2

