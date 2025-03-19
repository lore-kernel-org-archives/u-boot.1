Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C7FC35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E447A81101;
	Wed, 19 Mar 2025 04:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354370;
	bh=235Zz82jqRN7bcD7yZjyQFc7u13zH1TzUZ1xK09Cqdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFu7ueKm0jOmd5RJEGtLvdQfWdp4ZbSTjksPsCMujXQBFuSMIyvbsUbwwJEZXUsSB
	 k8tSYDsNC39gF+8btxo6eWxxo3ztM7qzfbvcmIQ4IQP577mv7PzexdxxTUWzsfZthI
	 xfyBKGR6wDcr0TFPfwfUbnTn3G35/C2gRKjBQUvntxbgW+WK/TPb+Ks/fOJL6OhAx6
	 2LnBSLZAxayx2vVU4YFYMB3pXa4t7AQ8brdyV+fuFSVEQ8ZjcTrPxEPlsDUT6IS0/+
	 1SrMpzJV3OyixvWZkW05L2P6uWNxEaqK7m30oDQXgbMbyCuAHiUGcpxdxOwwUtVPg5
	 P5I4M19TQnkug==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBEBD81E60; Wed, 19 Mar 2025 04:19:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5118D81E25
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="h8+Etwx1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB948101E91CC; Wed, 19 Mar 2025 04:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354363; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=235Zz82jqRN7bcD7yZjyQFc7u13zH1TzUZ1xK09Cqdk=;
 b=h8+Etwx1zR0YwidH9Ig0SRDen6Ac1QMCRABFKjD5rbhGY7kmhNSZUIPZyYzFMixTVz+jvW
 g0HSwRsncZa1ZGbCkzc5DNyW00qfjGqGaFdyhMHQw1VrEz2IPUMF7yX//4ew+dkiBR2uG+
 QuIoxn4VwYA7HZlVmQXaPnsY+doUSYZJeZ7AY1sFZdvGsLwYbmVEA2476qjLAeJAMgnE77
 BTXqWmbtT2VIU2DXE+UM4DHlvPVYOXPayILvpwiSi810JuxEZe5530f1aNdHOeLjp9/Hh8
 LUR71dZWnm1Ee5MgsHumPy8bOeYIvnc1WHlXBzuOo3w4xubvQwZ6QN8ea9J1zw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 09/24] clk: imx: gate2: Use struct udevice instead of struct
 device
Date: Wed, 19 Mar 2025 04:17:19 +0100
Message-ID: <20250319031852.233537-10-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
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
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
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

