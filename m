Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1188C36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F4F82132;
	Sun, 23 Mar 2025 17:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745728;
	bh=RkHPKNTKYToOjNFg/9QWlZmYHhGzzxd8QYt8FE5TDZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TyMW0RtHMRdf2I3YAjS4eEMgApdH6ic3+xz7haR2w8J7nvDG+/xhwBLrA3WxBJvF1
	 2kAKFsI+j1a1WuUYEjJOV2NSEYnWqZdFWnYZCahh2jFE3Ky+gqOYSVf/E5JMN7CvHt
	 it3WyvPk9lwteq1RebShSRuA/loOzwUFyvdaNvDsN4CJaZCF1BV6VENo70B1hGbRFd
	 JIWJuuFRE9yCpSHcV+CC+2WyQSPmtAmIzXGd9sQlfYod3H7gsEMtlmGZKgBCWsMGeE
	 22YKmaoYKYjYq9PgOsVfli9tt3NDQH1stjTy7Px+pqWHk5EXE6PXGo982H+8EqILCz
	 HvsbP1Jhfjy+A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB7C81EDD; Sun, 23 Mar 2025 17:02:04 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9C0820B0
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="YzSw+qwh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1573E10290256; Sun, 23 Mar 2025 17:02:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745721; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=RkHPKNTKYToOjNFg/9QWlZmYHhGzzxd8QYt8FE5TDZU=;
 b=YzSw+qwhk04nqkO+nnVkjjADQk7ECAwsZccMjfbZuZqVryBx9pQ/MXQnrw9gXS0as7kBHq
 WE/nBAwgmcPKiXsAtDZEhvksq+APJb5aIGD40dpuBQy8wXgYFFU/EBw4Zp4NMTRXcRM/tz
 ozsE1Q1rf4Uy7Bv8GB2TfA7/EL6QfeE8drIn/goKNy4nIOs/g+6uS7r7XRwnJwS7DdrCeK
 GkpE/3NEOmKHxuul4ti9XQh/58xHSg/Lzz9JvBIQ/LpjJy4it3EUGxWvgr3g04CMak3niR
 gF3l5QIZ7rbNjdry9UfJQIQFQ8/6oqgaGgB8DBTG6O6Z+xDgr1XckEQp4J+ZEQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 10/24] clk: imx: gate2: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:39 +0100
Message-ID: <20250323160107.145749-11-marex@denx.de>
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

Use clock-names property which is accessible via parent clock OF node
to look up the parent clock by name instead of depending on unreliable
global clock name to perform look up.

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
 drivers/clk/imx/clk-gate2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index 400121a8ae1..fa07b13249b 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -111,7 +111,8 @@ struct clk *clk_register_gate2(struct udevice *dev, const char *name,
 
 	clk = &gate->clk;
 
-	ret = clk_register(clk, UBOOT_DM_CLK_IMX_GATE2, name, parent_name);
+	ret = clk_register(clk, UBOOT_DM_CLK_IMX_GATE2, name,
+		clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(gate);
 		return ERR_PTR(ret);
-- 
2.47.2

