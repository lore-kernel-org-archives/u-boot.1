Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161BCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60BE183890;
	Fri, 17 Oct 2025 17:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="WAqBBJxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B238382E; Fri, 17 Oct 2025 17:22:07 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8443B8051F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 54AEA26173;
 Fri, 17 Oct 2025 17:22:04 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BxXJMAOzFle3; Fri, 17 Oct 2025 17:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714523; bh=0aqn28+30E5l2QLqkYwGsNls3BQHZiQObDxXkXalkcg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WAqBBJxdPtwCooaP7OoIsgBwgyYw86zXTvdZtIozJrKeRou4CR+h2iznYS2EoYGLS
 vGFGivOi49IIlbzd7we31fqHbjrMhGlzNqyg98R6S8Xhpjg/7Jm7tK/XYyOdnAQxpa
 qgZrG+Ghlm87HIxhtA98fki0HLca5iUIwZD2fXiJlF/Ba4ftHTE8c3c595UJ5aBakG
 prvqAQQF59NT/C4hDZWKBS6iM0sLZ2cDvRZ62z9n+yI4q39l7Q/zrYNkncdDJ++bsl
 pnA4NWUk18ORxcSXKLFdPoeGgGjiIehCeptTJ19j+lO8n1W4K4QU1KrhkKPWbz85wY
 r21js4AdA3q/g==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:51:30 +0530
Subject: [PATCH 2/6] clk: exynos: add support for fixed rate and fixed
 factor clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-clk-exynos7870-v1-2-83f90d425699@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714499; l=4431;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=0aqn28+30E5l2QLqkYwGsNls3BQHZiQObDxXkXalkcg=;
 b=p1JltfwDpSTXZbSjSYLzvZsUEpueNGWx5NlqUEjrp/VufDmySEcvKDU0SRm5nW01pZUvmPuhv
 6eOa4MU1tHgDFGWhKZDWkbx9TGbms5XPwFRj1qytdtf9t7luGN2yt23
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:22:22 +0200
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

Add register functions for fixed rate and fixed factor clock drivers.
The vendor-specific structs defined are borrowed from the CCF driver
found in the Linux kernel.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/clk/exynos/clk.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/exynos/clk.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index 2f5a3de65631dfba1b69c4e877cb54ec254a5399..a3832981f9005334cf8e07b0feee89d7da7577e9 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -10,6 +10,47 @@
 #include <dm.h>
 #include "clk.h"
 
+static void
+samsung_clk_register_fixed_rate(struct udevice *dev, void __iomem *base,
+				unsigned int cmu_id,
+				const struct samsung_fixed_rate_clock *clk_list,
+				unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_fixed_rate_clock *m;
+		unsigned long clk_id;
+
+		m = &clk_list[cnt];
+		clk = clk_register_fixed_rate(NULL, m->name, m->fixed_rate);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, m->id);
+		clk_dm(clk_id, clk);
+	}
+}
+
+static void
+samsung_clk_register_fixed_factor(struct udevice *dev, void __iomem *base,
+				  unsigned int cmu_id,
+				  const struct samsung_fixed_factor_clock *clk_list,
+				  unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_fixed_factor_clock *m;
+		unsigned long clk_id;
+
+		m = &clk_list[cnt];
+		clk = clk_register_fixed_factor(dev, m->name, m->parent_name,
+						m->flags, m->mult, m->div);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, m->id);
+		clk_dm(clk_id, clk);
+	}
+}
+
 static void samsung_clk_register_mux(struct udevice *dev, void __iomem *base,
 				     unsigned int cmu_id,
 				     const struct samsung_mux_clock *clk_list,
@@ -79,6 +120,8 @@ typedef void (*samsung_clk_register_fn)(struct udevice *dev, void __iomem *base,
 					unsigned int nr_clk);
 
 static const samsung_clk_register_fn samsung_clk_register_fns[] = {
+	[S_CLK_FRATE]	= (samsung_clk_register_fn)samsung_clk_register_fixed_rate,
+	[S_CLK_FFACTOR]	= (samsung_clk_register_fn)samsung_clk_register_fixed_factor,
 	[S_CLK_MUX]	= (samsung_clk_register_fn)samsung_clk_register_mux,
 	[S_CLK_DIV]	= (samsung_clk_register_fn)samsung_clk_register_div,
 	[S_CLK_GATE]	= (samsung_clk_register_fn)samsung_clk_register_gate,
diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
index ed0a395f0f636eea40c63dd7bbd2dbcaf8ae2b0b..e53dcc6a821a4d11ce0ca3f2086aa9e425ff88c7 100644
--- a/drivers/clk/exynos/clk.h
+++ b/drivers/clk/exynos/clk.h
@@ -58,6 +58,53 @@ static const struct clk_ops _name##_clk_ops = {				\
  */
 #define SAMSUNG_TO_CLK_ID(_cmu, _id)	(((_cmu) << 8) | ((_id) & 0xff))
 
+/**
+ * struct samsung_fixed_rate_clock - information about fixed-rate clock
+ * @id: platform specific id of the clock
+ * @name: name of this fixed-rate clock
+ * @fixed_rate: fixed clock rate of this clock
+ */
+struct samsung_fixed_rate_clock {
+	unsigned int		id;
+	const char		*name;
+	unsigned long		fixed_rate;
+};
+
+#define FRATE(_id, cname, frate)			\
+	{						\
+		.id		= _id,			\
+		.name		= cname,		\
+		.fixed_rate	= frate,		\
+	}
+
+/**
+ * struct samsung_fixed_factor_clock - information about fixed-factor clock
+ * @id: platform specific id of the clock
+ * @name: name of this fixed-factor clock
+ * @parent_name: parent clock name
+ * @mult: fixed multiplication factor
+ * @div: fixed division factor
+ * @flags: optional fixed-factor clock flags
+ */
+struct samsung_fixed_factor_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		mult;
+	unsigned long		div;
+	unsigned long		flags;
+};
+
+#define FFACTOR(_id, cname, pname, m, d, f)		\
+	{						\
+		.id		= _id,			\
+		.name		= cname,		\
+		.parent_name	= pname,		\
+		.mult		= m,			\
+		.div		= d,			\
+		.flags		= f,			\
+	}
+
 /**
  * struct samsung_mux_clock - information about mux clock
  * @id: platform specific id of the clock
@@ -206,6 +253,8 @@ struct samsung_pll_clock {
 	}
 
 enum samsung_clock_type {
+	S_CLK_FRATE,
+	S_CLK_FFACTOR,
 	S_CLK_MUX,
 	S_CLK_DIV,
 	S_CLK_GATE,

-- 
2.51.0

