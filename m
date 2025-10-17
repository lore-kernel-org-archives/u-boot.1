Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79CECCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1088B83885;
	Fri, 17 Oct 2025 17:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kJuinOuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8245838BF; Fri, 17 Oct 2025 17:22:25 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098838384E
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CAD6826292;
 Fri, 17 Oct 2025 17:22:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJJ4sMRdoGrI; Fri, 17 Oct 2025 17:22:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714541; bh=Tj4LPtxoH96gSNmkuQCJZYNDsh9VS6l7CMMmU8KsHqw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kJuinOufFZwJN2T79y6oAYWKtsBxbHv5sraZL8OtMjjXSr3LhXIiTYc5vCntd4+HS
 n3agjUO+oGvCoG21z4u770QxxVdmpMA2ZxwSFta47pfsWYZR3foLYn/Nzqnwh1ePl3
 BRSvcMhwCQyXj39CvdTH4PhLAHvWCnG0llFNs8Yn9fLcnIj/WiXK4XU9Si06A53/Qy
 Ngw6mWMVJfq6dHYHhmTNvE86WPRU4ndw2uSR5wqrR0lIKVP2SYdV8Ygc11TQOkY612
 erYuhMjBjgD6rdkAWV03yVzDO0xfJdqqn4ECFaxxhJEIA8kugg8CVdeAdFMTCZ5TKG
 Y/A0kdYYRTfKQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:51:32 +0530
Subject: [PATCH 4/6] clk: exynos: add function for Samsung CMU ops->request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-clk-exynos7870-v1-4-83f90d425699@disroot.org>
References: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
In-Reply-To: <20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org>
To: u-boot@lists.denx.de
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=2038;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=Tj4LPtxoH96gSNmkuQCJZYNDsh9VS6l7CMMmU8KsHqw=;
 b=6ByFQJ/h3FpRmT7eqDHVptp7ZTmyYXs41LbrnvImL9xDJaRDcyFCQNfGXOy/Toux68+YL3lkv
 CDmGDOSrBhIAwkwkC3DBndDevhKW6ZK8/nAXBFBHM/YDYJ8RWZRGP7/
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:33 +0200
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

The request function performs a simple check if the clock with the
provided ID is present or not. This is done with a simple call to
clk_get_by_id(). A non-zero return value indicates that the requested
clock is not available.

In some cases, clk->dev points to the clock bank device instead of
the clock device. This pointer is therefore overwritten in order to
reference to the correct device instance.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/clk/exynos/clk.c | 13 +++++++++++++
 drivers/clk/exynos/clk.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index a3832981f9005334cf8e07b0feee89d7da7577e9..a2c9f4851daf3dbb0c04f8a1b1414b0db543664e 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -10,6 +10,19 @@
 #include <dm.h>
 #include "clk.h"
 
+int samsung_clk_request(struct clk *clk)
+{
+	struct clk *c;
+	int ret;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clk->dev = c->dev;
+	return 0;
+}
+
 static void
 samsung_clk_register_fixed_rate(struct udevice *dev, void __iomem *base,
 				unsigned int cmu_id,
diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
index e53dcc6a821a4d11ce0ca3f2086aa9e425ff88c7..c25b7cb59d4f2792d395c7a67e40fd0be8fc46da 100644
--- a/drivers/clk/exynos/clk.h
+++ b/drivers/clk/exynos/clk.h
@@ -9,10 +9,13 @@
 #ifndef __EXYNOS_CLK_H
 #define __EXYNOS_CLK_H
 
+#include <clk.h>
 #include <errno.h>
 #include <linux/clk-provider.h>
 #include "clk-pll.h"
 
+int samsung_clk_request(struct clk *clk);
+
 #define _SAMSUNG_CLK_OPS(_name, _cmu)					\
 static int _name##_of_xlate(struct clk *clk,				\
 			    struct ofnode_phandle_args *args)		\
@@ -37,6 +40,7 @@ static const struct clk_ops _name##_clk_ops = {				\
 	.enable = ccf_clk_enable,					\
 	.disable = ccf_clk_disable,					\
 	.of_xlate = _name##_of_xlate,					\
+	.request = samsung_clk_request,					\
 }
 
 /**

-- 
2.51.0

