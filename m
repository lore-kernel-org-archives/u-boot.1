Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAD5C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06AED8212A;
	Sun, 23 Mar 2025 17:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745728;
	bh=97ZOzlN6JGAw73Luaiu6fRsktV1qiYkN+4sRUmbs2hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KGRp+lBmSdLcM5USFi57ykPSH1UqVcGaw4j3cA0SS3hA89MpHafa2i3SF1nGwpHOL
	 54jIIQKZ5IQaDbdc1bp4kDO5VmyQnVvGarpy6QnsaA1qqrusmDcMwZ/D1imHzjaQIX
	 3hjlyUfmwbgzx8vae4R80CX+S2suXHex93cLpSmt3gMTSWxnKhvIVb265sRERUOgWV
	 Qw/+3JFVxHruH2sK2dvFFqUceu6BKgoLi2Z1XabFzLpuFnV/sUedO29QaaklWghZAG
	 URYKWhCyZxIE/dyqDhI2BLFMXlrYwnUXucFGmC8N641VOUHlMDVa3qfrvA1eHNFWPv
	 om4ODkyK1oxIw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685C3820F0; Sun, 23 Mar 2025 17:02:03 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6156981CFD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bIaJh/71"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 167B710290255; Sun, 23 Mar 2025 17:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745720; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=97ZOzlN6JGAw73Luaiu6fRsktV1qiYkN+4sRUmbs2hI=;
 b=bIaJh/71689Q+sy+0aGe9lr8kZZ0O3lZm1bACTCOAr5CmxwtSJC61qX5hzFc1nO+3Iqfq2
 Fp71f5GtQ/DJXfTAtcQLkZF4YVrmKeXiBrzGC2F/Q69PWynPsCOQragNY/VKfvXM7J1yAM
 +v36ySrA8TSSallREwX148/m/s6P5duig/GiYdCxliX7XlXhMrpHxK4L+zZVnYq+JXmmQI
 z1u2sPsxmYEuN/D14q8qowzjuRMtKOgzCOnWWG4qec5c3duxSvhidnfcUEcHqyxu3Njha2
 eC28eovGIOC787eBZPkZY2vlSuiFLyr+wVAFzILTzzTQ3itx+LyIK7yhVGHKzQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 09/24] clk: imx: gate2: Use struct udevice instead of
 struct device
Date: Sun, 23 Mar 2025 16:58:38 +0100
Message-ID: <20250323160107.145749-10-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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

Use U-Boot specific struct udevice instead of Linux compatibility
struct device in gate2 clock registration.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/imx/clk-gate2.c | 2 +-
 drivers/clk/imx/clk.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 65fa6b5b139..400121a8ae1 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -90,7 +90,7 @@ static const struct clk_ops clk_gate2_ops = {
 	.get_rate = clk_generic_get_rate,
 };
 
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
 		u8 clk_gate2_flags, unsigned int *share_count)
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 6f0ae86f612..6f964f2679f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -78,7 +78,7 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 			    void __iomem *base,
 			    const struct imx_pll14xx_clk *pll_clk);
 
-struct clk *clk_register_gate2(struct device *dev, const char *name,
+struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
 		u8 clk_gate_flags, unsigned int *share_count);
-- 
2.47.2

