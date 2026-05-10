Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E4FCD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 00:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A07984A48;
	Sun, 10 May 2026 02:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ZkVUPKj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9565684A44; Sun, 10 May 2026 02:07:19 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3C684A4A
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 02:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso32411865ad.2
 for <u-boot@lists.denx.de>; Sat, 09 May 2026 17:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778371636; x=1778976436;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8iJxq/QySdbFn6syh0RErNipDKBSxgbGQlbfm/XUCxQ=;
 b=ZkVUPKj0SRS/XgmV4zWj5TbAkEM5y8s5Le9sHXQajln9u47iYY3iUjUHKZLycEAlqQ
 KUqa2UhwhHuCoUd+WaRLg+YJvmgIzbCf+SBBzIjg5QIwe/yHef2uIJMGOqY4ypQ7ZAZW
 eSXCt5RiSZL3aVyYyDvPJRPd5BeSh9La4DMmLEas/CsgzVLj3euQNIGus6yaE7YQd3Vz
 FSNpkXQ8cwnNEkeizV7thdkoj5MUKIDH/F1rAwRGbDynO28cztK+hTHKFUogMaHJJ2Xk
 9ZAZ5B98vDLVFfsmLtDq9keodU1pmhBJXxXwPD3WgreOU32rHUDahRH0E2Pxu6rT8uxx
 gGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778371636; x=1778976436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8iJxq/QySdbFn6syh0RErNipDKBSxgbGQlbfm/XUCxQ=;
 b=esNnafplQAOTXKWDtAtiO8pl2Z3Sskc2gyZX6J3uzvi12rcjODLfAY8660dpzElRlz
 ITGioNU9lKr9FDyhryH2KpQZBfzZSIRC/hVsR6iszfKMH6YGaIsgWtpZzJ6IsfzVQNWz
 vKLe55urngQ/8LnvUAMKcLGDUSG0og1dMC4f5FCiVCrKX8Vfawgj7w4B+xk1Wz3gJBWP
 JhhNwEgcN4YrGSJx2+roxkZUKd9KyhSCLg98QJwTi0remuCjn6eTGBM8JT6tV9Gwsbvm
 asPNdxaCiy5wYYAB2m3kt/DPd4ElSoBWPUXq5dHd29/lCJUe2UoCS/j9ZkU9MYzbb1il
 WbDQ==
X-Gm-Message-State: AOJu0YxtHFRYxjVJaD+JCA1e8+gbwcPDBk34S7qk8yTIGeXILjxKVoY6
 rFzuCW74loGMmx+/f8Jpygd2EOtBVmZx3K+6F+8R3XYn9o6uVY14iIlLIyI+F2dHxRs=
X-Gm-Gg: Acq92OFzXYmZcH6G/4Mmw+qQ4SGcPt4KJMgz7tA9eHNEYMMFCVXno8610CLu/hhXwZY
 TM7c4/1qi1t/1+wrnmLhUHOWgLADdo2KtIjnnn5d11BCDyOBuIM9++aSFj1m8fd4Wnfb346OmyQ
 ZoIabNIAZpHtcLGoKjvyK3QD8gLBjsWbEHtPNlZqn8ZD/wCoFgG3xcNb9qgyQ/h/LuGg+GDWaDZ
 q5MgFHThDND55ULW83390KUoFFzRePedJRWha8tWQ7HFeWSOYCRqSsEivsy5x5yIvbLB/Z3voM9
 vaPMhkW7U3wk9PmSCME+E4fc3yp2VXoi5BH5kVryD6o7O+2fpTfAYuJkj9uknbYLQNejxu1m+xU
 cXqKeLbbFiUJIDxex+D0L6aaa3kOkNpkMCl6RereCrquAKv2v5UXFCsFzJ4QMbmuCxw2N9C0Hh8
 Ij7r0Tf2wq4FlPmnhA1R5Dt4HSkZx0JrrK6gYxHmrWRec=
X-Received: by 2002:a17:902:74c2:b0:2ba:7354:7299 with SMTP id
 d9443c01a7336-2ba79bdb06emr141987655ad.27.1778371635939; 
 Sat, 09 May 2026 17:07:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d3fee3sm57010625ad.18.2026.05.09.17.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 17:07:15 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 10 May 2026 08:06:25 -0400
Subject: [PATCH 3/8] clk: spacemit: k1: spawn reset device from per-syscon
 clock drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-b4-k1-clk-reset-upstream-dts-v1-3-db0b0503ee44@riscstar.com>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
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
 Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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
 drivers/clk/spacemit/clk-k1.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/clk/spacemit/clk-k1.c b/drivers/clk/spacemit/clk-k1.c
index 4c0972d952e..80eede251b8 100644
--- a/drivers/clk/spacemit/clk-k1.c
+++ b/drivers/clk/spacemit/clk-k1.c
@@ -13,6 +13,7 @@
 #include <dm/lists.h>
 #include <regmap.h>
 #include <linux/clk-provider.h>
+#include <soc/spacemit/k1-reset.h>
 #include <soc/spacemit/k1-syscon.h>
 
 #include "clk_common.h"
@@ -1670,6 +1671,26 @@ U_BOOT_DRIVER(k1_pll_clk) = {
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
@@ -1682,6 +1703,7 @@ U_BOOT_DRIVER(k1_mpmu_clk) = {
 	.name		= "k1_mpmu_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k1_mpmu_clk_match,
+	.bind		= k1_mpmu_clk_bind,
 	.probe		= k1_mpmu_clk_probe,
 	.ops		= &k1_mpmu_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -1699,6 +1721,7 @@ U_BOOT_DRIVER(k1_apbc_clk) = {
 	.name		= "k1_apbc_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= k1_apbc_clk_match,
+	.bind		= k1_apbc_clk_bind,
 	.probe		= k1_apbc_clk_probe,
 	.ops		= &k1_apbc_clk_ops,
 	.flags		= DM_FLAG_PRE_RELOC,
@@ -1716,7 +1739,21 @@ U_BOOT_DRIVER(k1_apmu_clk) = {
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

