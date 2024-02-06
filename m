Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C752BC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 14:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EFAE87C7D;
	Tue,  6 Feb 2024 15:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G77oZm87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C7987C7E; Tue,  6 Feb 2024 15:03:03 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B86D87C78
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AD22061138;
 Tue,  6 Feb 2024 14:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA9C433F1;
 Tue,  6 Feb 2024 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707228179;
 bh=S+9/fhAMmU4rPb5CjHJqExMjJ42mr+PsRU1vmZ8Oxw8=;
 h=From:To:Cc:Subject:Date:From;
 b=G77oZm87/dMNv3YoUV+GQ74dXRhK+Gi3iJ3KuRrb6RC7MA7zOVjnRZFXn8rve5tdA
 jf6LyJwnZpUr41lhzUmHLmFJsdkcKmuRDyoGDlBfRBixKThC8KlxhjPMxJi0+TYT7U
 qNqlAuCvUshuiRuXjBQ7ua58ys42aUD/UtJIZuS7nDLVTAvxSrRhWYUjU4PTYwMZpj
 BC5eBIRrprbkYELzHNVUHuEZDMxu/qxhAmKxXX4XQEjC1rFR2ChgHrXBAUzJ2pcezj
 2XbWhlQRdKMOQ90oZKIDK/cslwii3Uv+Qgw5nMcicJ+u9vKUzzHaihg0jSXxo82Bz9
 II5hKnpgnb+WQ==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com
Cc: dario.binacchi@amarulasolutions.com, nm@ti.com, praneeth@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] memory: ti-gpmc: Fix lock up at A53 SPL during NAND boot on
 AM64-EVM
Date: Tue,  6 Feb 2024 16:02:51 +0200
Message-Id: <20240206140251.44155-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

AM64 ES2.0 bootrom seems to enable WAIT0EDGEDETECTION interrupt.
This causes a lockup at A53 SPL when accessing NAND controller
or ELM registers.

A good option would be to softrest GPMC block at probe
but this cannot be done for AM64 as SOFTRESET bit is marked
as reserved in SYSCONFIG register.

Fix the issue by disabling all IRQs at probe.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/ti-gpmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index 0b8674339e..8877b8f438 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -1196,6 +1196,12 @@ static int gpmc_probe(struct udevice *dev)
 	gpmc_cfg = (struct gpmc *)priv->base;
 	gpmc_base = priv->base;
 
+	/*
+	 * Disable all IRQs as some bootroms might leave them enabled
+	 * and that will cause a lock-up later
+	 */
+	gpmc_write_reg(GPMC_IRQENABLE, 0);
+
 	priv->l3_clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(priv->l3_clk))
 		return PTR_ERR(priv->l3_clk);

base-commit: 28760ce8640ff6266bd1c1c568a4a231576f3919
-- 
2.34.1

