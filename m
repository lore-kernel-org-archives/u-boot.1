Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D8BCCD1A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB2988C4C;
	Wed, 18 Sep 2024 15:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fjeyNapz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37BB88CF7; Wed, 18 Sep 2024 15:49:30 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F183988C4C
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1E8C3A4045B;
 Wed, 18 Sep 2024 13:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA1CC4CEC3;
 Wed, 18 Sep 2024 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726667367;
 bh=pgQQVVHr2/UqU1fGLXRB4+GwWz5JpxGA7lfki8LTiS4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fjeyNapzK1o2u7sQ7e5byNEMSAYe9fyv2T2nsA7OCjInqw/nP7QBEMS5Mq0e/yCC6
 ojrgekxAAj96a8Ir2mpFtj4xa6+SgQF0ClkZPzakCwRXuFqfj1Tr+2kOPnXt+dMubN
 5j3/Ux8GP48+ZeTrzwrQ8k4WjgwvStBZPyfQ4UElIgQBDtjgFIRqd0bKn37eHSqDJk
 csVyUeMLDX8h+tOqdlyA5pEgbcpqGGJqrrcsFBHaqO0HWFqGNIpNXnD13JdaD3NHb7
 N99IokdFucjTgkd82OmyL23oMeGtNn8VBt8EjTiZBreYSBHHidoD3go7Yvz1gx3epl
 WO41DJgGkVecg==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 18 Sep 2024 16:49:21 +0300
Subject: [PATCH 1/2] mux: mmio: Support "reg-mux" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-j721e-ums-v1-1-62f295dce6aa@kernel.org>
References: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
In-Reply-To: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=pgQQVVHr2/UqU1fGLXRB4+GwWz5JpxGA7lfki8LTiS4=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm6tpjXKRT+nAEMkXxHxfFot215puQhb8hF7o3I
 O9st8Ipv5yJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZuraYwAKCRDSWmvTvnYw
 k4gTEACE0kgP90VQFJ/i5ZFBm38Zt+3bJZ4nDnwNxGbPRybNMFBDdHInzJzFZT+xaV1eWH2Lasz
 8hZN8Mi3b4m/PEKlYcZd37YEEC8sBioumx8E57rBSi//v7N0BRoFunYrlQGlORuGKo98lmynfly
 z74h0G+4RaBbn4nK+RFj1tG7Zm010M6/F0SH7SWdxniuAabQDpwqUzJEFXflY9xfojwfY5zhLkE
 JLmL2qMP+lcF7Q/rU2IEO+jPq1nWiqOxD4c5vs3Xi7EB+gxAMG263y1W7BddjtPSlfcGT/u4KUb
 Zudy2XGynMhZT+53i+0sPADizixdgXEdYGvc2p9zkm4wth6+u9pT3sgvwy8hP53mwvW54w/LutK
 B3JofVUfyoOuUklh0IXQrwrU/4eXYq4WCT+Wk3b1GVTNQhdLNiDcub8md5NFEBkysEk9gA0GTEW
 GNpzACaISjaEU3P4GxRbmJJzUAXDu5br2z1wlbOVjnttGj1L7kDnnXIylCUYdKeGCuSFd91YqN0
 HPXKpHA7io5mlgMWDv/3tFwVonijLJd7VmVAWK2feoHnE2H/dUa1jSr8E+vBcelXt5wWJu5M4C5
 H2/xXURpkxM4luJKdY9jqer6oQJIGvIeYccj8Gwu7++NYcFDaWtPBsLGZ4FDZXwp2gH3IHr7319
 AnEYymdu92tJemg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

With "reg-mux" compatible the driver no longer expects the parent
device to be a syscon type. It uses it's own regmux.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mux/mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index e1125458a62..e06f4462b5a 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -31,6 +31,7 @@ static const struct mux_control_ops mux_mmio_ops = {
 
 static const struct udevice_id mmio_mux_of_match[] = {
 	{ .compatible = "mmio-mux" },
+	{ .compatible = "reg-mux" },
 	{ /* sentinel */ },
 };
 
@@ -45,7 +46,11 @@ static int mmio_mux_probe(struct udevice *dev)
 	int ret;
 	int i;
 
-	regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "mmio-mux"))
+		regmap = syscon_node_to_regmap(dev_ofnode(dev->parent));
+	else
+		regmap_init_mem(dev_ofnode(dev), &regmap);
+
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		dev_err(dev, "failed to get regmap: %d\n", ret);

-- 
2.34.1

