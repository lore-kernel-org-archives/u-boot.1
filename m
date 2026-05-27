Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60073CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CB9848DC;
	Tue, 26 May 2026 16:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wqLsAbEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25304848DC; Tue, 26 May 2026 16:47:13 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35FF8484F
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so77922445ad.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806829; x=1780411629;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YtxrhNc+bU4qAx+5LIsM3ux1Dyz7qCJW0GVLaRXdHtA=;
 b=wqLsAbEtN71nfugL+wyJVYjGtZggro2XilqvRGYeET3WYx47KIZd/P95iHuLELnFuS
 szyoSxmIOLAsZXJZQtao+GGQcKUIEiR5Kjfv61HXPQT6UFxkZY0A2gGrD5z7lRdsKRmE
 YBU5hsM88MQ/SYemDFLN+CE+i8HMg1bGlN8HNIyH2LBQANHzAPzgkEcQ7DJ38QWIL4dO
 5Ua25gIPPuzwDisvsQFCHyrED64iP+im7iZXKB21n5SrlvgCWliyEjBqE7aEPLxV3MDY
 PAIFDcbx5BfCcOoVj9Sq6Zp1u3hdzbnWPMAvQRETBVAhLV3wJboeDPaBtfiOu0YsiVmB
 uzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806829; x=1780411629;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YtxrhNc+bU4qAx+5LIsM3ux1Dyz7qCJW0GVLaRXdHtA=;
 b=Bs4EkHrk17b98yCRxwN36tL+n3PDqjzA5msV5xmACAqML49gj9KkUz7W5GRBnO+2LX
 UcSLfSn05MU/9LQCBxHVqp8HlBeWeieQ00v9FBEHquTyjtgCNv/Txy0fEw62s/toasQk
 ORZdSVc3LC64nkkm/Glxt8I74I8ocgs2e00h+ElylNLOHv143MY8QdIDT4qUmAS8xKaI
 v85aAFfxZf1JMtT6rJM5FBJHcsbIdeibIxa6FfKAffXLIaNMf3wOBnSfJ+cy0X2DTYh/
 dn8q1SKGTpGo/VYcGbeXSaunGF72WKcI6nLLcHwmXq9fvHm6JTXYOV96dMIJSgSj5NIq
 4Wtw==
X-Gm-Message-State: AOJu0Ywv0cfyjlPqDMonxerRXmdeyTQJiNqMWpzcOhjZwRbijILTVoFO
 VdY35332HnIUURk+opNquQGtWwJKv/Bwx8EQ3gQzd4BQ3N56XlrEHjrNbRxYXKnl5f8tyskpVsy
 GpqifkKg+og==
X-Gm-Gg: Acq92OGMey6VHLPo3hs7rNkcX02s5FnTE6ks3cNCbIDSfDA43sc/ZDRP1hkIdYtfWtn
 vVZfuREPmu1FC9+uKZpogADWhrCuxZcI6c8ByMhDHok6cHCVmtQ5KoLExAuJaO6vT0FQhy0IdaR
 M59QUBudVf70a+N5XBL3Kt+hTBsN2LexuhIJaZ2LP8ircfGxsIr/O5XL/9GaSuJrE7FyxtVhz6G
 s5r/PSRXSoqK9gLN/PRUteQgbcLb20VORSMZV91V9UjZA2GdiAG1BplTs0uauYBzsA77gCfiqrI
 8RNC4bsdf6VJUdriCnhHR6ZeIfqQABl+6r5y6EkC51wEShAgplOxJ/ORbis99IGGcZf6KbroOd4
 VldlGOiG+e8b8Iez7grdzwTIHVeRtjVOf0iCK2imRLJKiXIshcm61mhk6A85Avwr7cOYdJlSeqY
 S0OWZvU6ANmlI6OGsHCuCudjHb8mN5Rb7T9A0RH+jbInA=
X-Received: by 2002:a17:902:cccf:b0:2bd:2de3:5187 with SMTP id
 d9443c01a7336-2beb05a2486mr215560055ad.3.1779806828975; 
 Tue, 26 May 2026 07:47:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:47:08 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 22:45:43 -0400
Subject: [PATCH v2 3/8] clk: spacemit: k1: spawn reset device from
 per-syscon clock drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-3-af815e362b0c@riscstar.com>
References: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
In-Reply-To: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

The K1 reset driver in drivers/reset/spacemit/ binds by name (no DT
of_match), so the per-syscon clock drivers must spawn it.

Add a .bind hook to k1_mpmu_clk, k1_apbc_clk and k1_apmu_clk that
calls spacemit_k1_reset_bind() to instantiate a UCLASS_RESET sibling
on the same ofnode.

Also introduce k1_apbc2_clk here. Its kernel DT node has #reset-cells
but no #clock-cells, so the driver exists only as the binding hook
for the apbc2 reset spawn.

With this in place, references such as
  resets = <&syscon_apbc RESET_TWSI0>;
in the kernel-mainline DT resolve correctly.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change.
---
 drivers/clk/spacemit/clk-k1.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index a6be285c1a4..6175cf09500 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -13,6 +13,7 @@
 #include <dm/lists.h>
 #include <regmap.h>
 #include <linux/clk-provider.h>
+#include <soc/spacemit/k1-reset.h>
 #include <soc/spacemit/k1-syscon.h>
 
 #include "clk_common.h"
@@ -1661,6 +1662,26 @@ U_BOOT_DRIVER(k1_pll_clk) = {
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
+static int k1_mpmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k1_reset_bind(dev, SPACEMIT_K1_RESET_MPMU);
+}
+
+static int k1_apbc_clk_bind(struct udevice *dev)
+{
+	return spacemit_k1_reset_bind(dev, SPACEMIT_K1_RESET_APBC);
+}
+
+static int k1_apmu_clk_bind(struct udevice *dev)
+{
+	return spacemit_k1_reset_bind(dev, SPACEMIT_K1_RESET_APMU);
+}
+
+static int k1_apbc2_clk_bind(struct udevice *dev)
+{
+	return spacemit_k1_reset_bind(dev, SPACEMIT_K1_RESET_APBC2);
+}
+
 static const struct udevice_id k1_mpmu_clk_match[] = {
 	{ .compatible = "spacemit,k1-syscon-mpmu",
 	  .data = (ulong)&k1_ccu_mpmu_data },
@@ -1673,6 +1694,7 @@ U_BOOT_DRIVER(k1_mpmu_clk) = {
 	.name		= "k1_mpmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k1_mpmu_clk_match,
+	.bind		= k1_mpmu_clk_bind,
 	.probe		= k1_mpmu_clk_probe,
 	.ops		= &k1_mpmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -1690,6 +1712,7 @@ U_BOOT_DRIVER(k1_apbc_clk) = {
 	.name		= "k1_apbc_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k1_apbc_clk_match,
+	.bind		= k1_apbc_clk_bind,
 	.probe		= k1_apbc_clk_probe,
 	.ops		= &k1_apbc_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -1707,7 +1730,21 @@ U_BOOT_DRIVER(k1_apmu_clk) = {
 	.name		= "k1_apmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k1_apmu_clk_match,
+	.bind		= k1_apmu_clk_bind,
 	.probe		= k1_apmu_clk_probe,
 	.ops		= &k1_apmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
+
+static const struct udevice_id k1_apbc2_clk_match[] = {
+	{ .compatible = "spacemit,k1-syscon-apbc2" },
+	{ /* sentinel */ },
+};
+
+U_BOOT_DRIVER(k1_apbc2_clk) = {
+	.name		= "k1_apbc2_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= k1_apbc2_clk_match,
+	.bind		= k1_apbc2_clk_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.43.0

