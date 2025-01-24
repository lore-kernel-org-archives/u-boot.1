Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9818BC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF35D80ADB;
	Fri, 24 Jan 2025 15:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730552;
	bh=Umw790y9Ri48w7XnsJz569ITmB5vJWsB4uV34ExDe7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VlRoqHfAtbYZnqkdwdXIcBf1o4aeOS09FE1EKwsRrWuA7I8gvVdeXhUTvjPIe0hM7
	 MDRRWhdV8fnJMzcMlOX3nEPBQl2oQG+h0mCTkh1RGtI6qI0IFwsrENZN6si/KDOl3k
	 g5BxpNUpXZJU4HZ/qO7EP8ZFpQhqFQjjNRKV+t0HtSS6VzNeVl7pCRcH1CIj0XNGi4
	 ROXI4lHPO0R9hiskpQQSHxFGv563xwF6LqUyJlkeOfe+KFywr6GheD5YJvrAsYDk19
	 6bSTANp/csXdnNACxft2PAMh11df2U0G6gw3aikZ0RGfl2v3jPmfMyl05f64W+tPtG
	 2ulcdtAi1uafg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE33807E4; Fri, 24 Jan 2025 15:55:51 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AE080817
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="N5h6mwuW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E8B610A2F870; Fri, 24 Jan 2025 15:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Umw790y9Ri48w7XnsJz569ITmB5vJWsB4uV34ExDe7c=;
 b=N5h6mwuWYYgOr7OKj9K2QiiUluJ6arLzDuxNwqtLErmZq3TmqCFyuFup4asZ2rHm5JBtzX
 97X3DkkGuos6juayw7881nzuHphA50kapP1tJvBOfdr21XKSjEN6tA+dTl2rsvIWJuvF/U
 +81UPxQHsO47NSJ0wGdmpqpVC1yupYYWOU0fVmK4PuA0q5agZlsEPirb/aO+G0nj2uOKKS
 iGvNSX4nTWjb7EfGCQFKWU8+JLNFRGgQ9kBJHM0rXZq+hnP1p0t8snUfIphSLIyoSYwzHN
 WNSmo9LRpkV1pG9H6JV3sWCODORflqFHCcRsbNSyyLrfVjD1TmwscoBS+3YGsw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/10] pinctrl: imx: Rename imx_pinctrl_ops to match drivers
Date: Fri, 24 Jan 2025 15:50:51 +0100
Message-ID: <20250124145520.185414-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124145520.185414-1-marex@denx.de>
References: <20250124145520.185414-1-marex@denx.de>
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

Rename the structure instances to match driver names, so they
can be easily looked up e.g. in objdump and readelf outputs.
No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/nxp/pinctrl-imx5.c    | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx6.c    | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx7.c    | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx8.c    | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx8m.c   | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx93.c   | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imxrt.c   | 4 ++--
 drivers/pinctrl/nxp/pinctrl-vf610.c   | 4 ++--
 10 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index c17d396d2b2..56f0e174888 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -31,7 +31,7 @@ static const struct udevice_id imx5_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx5_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -42,6 +42,6 @@ U_BOOT_DRIVER(imx5_pinctrl) = {
 	.probe = imx5_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx5_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 2d3d4ceaa2b..23b5566d358 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -40,7 +40,7 @@ static const struct udevice_id imx6_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx6_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -51,7 +51,7 @@ U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
 	.probe = imx6_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx6_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index 2505f5df4a4..faccd2ef8aa 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -28,7 +28,7 @@ static const struct udevice_id imx7_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx7_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -39,6 +39,6 @@ U_BOOT_DRIVER(imx7_pinctrl) = {
 	.probe = imx7_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx7_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 7d732f5a505..3288926ad9e 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -32,7 +32,7 @@ static const struct udevice_id imx7ulp_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx7ulp_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -43,6 +43,6 @@ U_BOOT_DRIVER(imx7ulp_pinctrl) = {
 	.probe = imx7ulp_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx7ulp_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 930de19075a..0afae31eb77 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -29,7 +29,7 @@ static const struct udevice_id imx8_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx8_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -40,6 +40,6 @@ U_BOOT_DRIVER(imx8_pinctrl) = {
 	.probe = imx8_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx8_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index d30a6eef351..661e08cd1b7 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -26,7 +26,7 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx8m_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -37,6 +37,6 @@ U_BOOT_DRIVER(imx8mq_pinctrl) = {
 	.probe = imx8mq_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx8m_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 0fb116a9893..40901f31752 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -31,7 +31,7 @@ static const struct udevice_id imx8ulp_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx8ulp_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -42,6 +42,6 @@ U_BOOT_DRIVER(imx8ulp_pinctrl) = {
 	.probe = imx8ulp_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto = sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx8ulp_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 2d027cd844e..4db224d32a4 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -26,7 +26,7 @@ static const struct udevice_id imx93_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imx93_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -37,6 +37,6 @@ U_BOOT_DRIVER(imx93_pinctrl) = {
 	.probe = imx93_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imx93_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index fdb3cbe8190..4383015fb33 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -27,7 +27,7 @@ static const struct udevice_id imxrt_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops imxrt_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -38,6 +38,6 @@ U_BOOT_DRIVER(imxrt_pinctrl) = {
 	.probe = imxrt_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &imxrt_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index 86514ebdb20..0e17b8c9ff9 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -27,7 +27,7 @@ static const struct udevice_id vf610_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
-static const struct pinctrl_ops imx_pinctrl_ops = {
+static const struct pinctrl_ops vf610_pinctrl_ops = {
 	.set_state = imx_pinctrl_set_state,
 };
 
@@ -38,6 +38,6 @@ U_BOOT_DRIVER(vf610_pinctrl) = {
 	.probe = vf610_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx_pinctrl_ops,
+	.ops = &vf610_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
-- 
2.45.2

