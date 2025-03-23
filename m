Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B8C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49392820B3;
	Sun, 23 Mar 2025 17:02:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745720;
	bh=3TZRF4Opc+xIFSSc9OZxW3Q3T8Mbsd0OTJNRII1AnRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D4NnJkVZ4JnjdJ9j1Uytn+KGxHMpxwVvS4U7Pq3HZn37khSH9qpB1W/V6oaZ/IFJp
	 3dGEGrzPKTj5mYmhtuK5ng7Fy1zS3siDSbIFfikL5MAUUmy4s9ARMEmnFYASa+hxMB
	 WE48KYOuWKX25JzmMPY33LBVKUYKu9IaznMCv7H6VvU1f5M1oIAbqoug3OX41KGtAJ
	 s5/l97J0QJi6bp8kmfrfYZSl7L7quqg/j4v1l4Qef0OsMWM/g4lhgpjm6bCB9P/a3t
	 BzSbWJ/O9hmqHXWuwL3H6C9cc5sSXzGdZ6oHdTaxVAkvnAdv+S6hzxVTNjkNOlpEr7
	 pVjBDfCX/Sv3Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7806881EDD; Sun, 23 Mar 2025 17:01:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67281CFD
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FhZ7HuzQ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 429001029024C; Sun, 23 Mar 2025 17:01:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745715; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=3TZRF4Opc+xIFSSc9OZxW3Q3T8Mbsd0OTJNRII1AnRA=;
 b=FhZ7HuzQ8kCAnO9A66Xywb1LA/OhnCnNtsfZw0Sz1+BzCrDTCx6v3ZT8lYa+4Woa8stXz4
 +kLiVVTStoEREKTqcha+105RtrNwRXx1Gd68k8rlxhYTkLz8fApLI9mExDPz/BNilrd8sN
 6fBuUzKEK8df7q64X1yeqObtIVmUa1LZP7302dTTX/di9vqpm8GMSIgJsC3EYE9UR8icLh
 NSO7VwSep4AVXXkzRpKs4Ri0XSgbJrsHmKggCS1Px9FNb5xOU6AY89y7NiOb8gB988JLa7
 2UVwOujBhOqs/c6Oa4R9+6rzAgP4NzM3byUWhpHtDyCYZEKn5gTxQZWmYWuBtQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 03/24] clk: clk-mux: Use struct udevice instead of struct
 device
Date: Sun, 23 Mar 2025 16:58:32 +0100
Message-ID: <20250323160107.145749-4-marex@denx.de>
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
struct device in clk-mux registration.

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
 drivers/clk/clk-mux.c        | 2 +-
 include/linux/clk-provider.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 9507a779525..e2331a07840 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -159,7 +159,7 @@ const struct clk_ops clk_mux_ops = {
 	.set_parent = clk_mux_set_parent,
 };
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk *clk_register_mux(struct udevice *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 59f9c241b84..f27878ae6fa 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -242,7 +242,7 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags);
 
-struct clk *clk_register_mux(struct device *dev, const char *name,
+struct clk *clk_register_mux(struct udevice *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
2.47.2

