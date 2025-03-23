Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C956CC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E058215F;
	Sun, 23 Mar 2025 17:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745746;
	bh=KVgvGcZMHdZVJAnYj9ShGM/o0E3qGsGbSnq4sAiGldQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YiFNnoc+/d4N4fGXei3D2vs+K8VrD/GnF2O5DwGETOzvs50nKjV1bPblcIwlxTLOj
	 CfkBCcmkds/XzFCyBmiJlOEv3Klewc02W94GUx+hO219bcg0ALHwdntb9rWouuMoIR
	 mqlCIIkg0OPZm/2yzmPmHDC0RDLpCuxq5VDarlm1lKK6oxXa5CxKnGMOm+9Srm35uK
	 dxYHxG4oBV+GSZ0DVCkgLkbbceavdSeUrfYkEFf+NeXq4qR6VzLSr6KHM+84U4FfjN
	 fw0LB7oS2SLuNI0xpoJeUjLpwlc+bZjzychdinoJA6UIbaESpCImfTNBKG2ie9rNWf
	 2526fuMO52AXw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9277381DAB; Sun, 23 Mar 2025 17:02:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E62A82724
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MdRjbIYe"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D535102E64C5; Sun, 23 Mar 2025 17:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745734; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=KVgvGcZMHdZVJAnYj9ShGM/o0E3qGsGbSnq4sAiGldQ=;
 b=MdRjbIYeYkYxOR+wvAE31M0KrxiOyki4lciAQLvHQBn+FQoWiAk0L1RqnfpNYiCngD2gfB
 AkQHNT0YYSmn587xvaO3uFM3pFOOo2/fR6y+7E4ZfnylAaS168ttp4EhzUQ4vam3oCR/F3
 NtzhW9llPkNLNPFaNLlZnijoUkcFyYY+EvTZIOE90Goc7IG+wDZYBKjuKwAfPWHXXP8ALi
 wuT87iIaNoITJdxig5lKybMtn9Q0t3GNEaeoRxEOBzlgma0LGnLyffnhKVzTXQGgYNVvGI
 5FZfBZb01CQ4f8ZKvj360XSzSVrw7Z/bzFlZzB905xEUe23KCsD+9sY+vNshnw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 22/24] clk: clk-fixed-factor: Use struct udevice instead of
 struct device
Date: Sun, 23 Mar 2025 16:58:51 +0100
Message-ID: <20250323160107.145749-23-marex@denx.de>
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
struct device in clk-fixed-factor registration.

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
 drivers/clk/clk-fixed-factor.c | 4 ++--
 include/linux/clk-provider.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 068798cf9b0..ff61fb4d706 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -37,7 +37,7 @@ const struct clk_ops ccf_clk_fixed_factor_ops = {
 	.get_rate = clk_factor_recalc_rate,
 };
 
-struct clk *clk_hw_register_fixed_factor(struct device *dev,
+struct clk *clk_hw_register_fixed_factor(struct udevice *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
@@ -65,7 +65,7 @@ struct clk *clk_hw_register_fixed_factor(struct device *dev,
 	return clk;
 }
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk *clk_register_fixed_factor(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 198f3ff0e42..5ea2171492e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -233,7 +233,7 @@ struct clk *clk_register_composite(struct udevice *dev, const char *name,
 int clk_register(struct clk *clk, const char *drv_name, const char *name,
 		 const char *parent_name);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk *clk_register_fixed_factor(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div);
 
-- 
2.47.2

