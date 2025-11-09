Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFFCCFA18
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 01:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A9A83EB3;
	Sun,  9 Nov 2025 02:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hUV6utQX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ztmoat/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EAF83E7F; Sun,  9 Nov 2025 02:35:49 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C9583EBA
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 02:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d3wNf5sjbz9tlq;
 Sun,  9 Nov 2025 02:35:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7JnozJmDZ9IXKbBAW33QpqlV6RjWXwUtFRmSFA9I9Y=;
 b=hUV6utQXXsJBsA4p6LZmn2cvIxq5J+uZ+tCZtF3ReVPYx06t9qUx+ccI1WNzf4/P3TC7ay
 pxYu1OgL3eh+bOg6QoXxsx+uIqwdCKK3PjuFJN3OVuu/wjaM0q0l2NeZWTeJ7bOuNGYMiN
 /Or9ysFG1yzc/Y+MFpZGyzPodkOm76DzPyLBGDLEjPH+LRvg6MNkIJ+uS+5AyBWQHxyToR
 UMvhOp09eERvrzR+HIYQLMSIAuSxlGeIblzDpWNXdZiwAT3W+AXNwMIKXuyZEyPM/jlCFl
 x5Hn5QWJzQF2orPsfxb20shop0SvGrxGnQQCqGHly9rQ8smc9dqQhEtbfoDK1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7JnozJmDZ9IXKbBAW33QpqlV6RjWXwUtFRmSFA9I9Y=;
 b=Ztmoat/JZqOPejTCEu/khv8qM6t3Phs1dfbrMg6FkdYdvYhJfW8otJj/sjL2vZLjs6UhPv
 mpWY45jTl4h5/D0TFyK40aSn+czCg6g4ifkXJ3wu8a/oFu3if4Ho+0xrAW0A9GW+3x1uJl
 I/lD1HWG98uHwiu3JTSPs5oeGG5r2nVQXZFJyC5VC0963P7xUG/bNVBUZfMd6sgA2hFzqX
 HxhJnko3oiS6DiD5ZdBDtkYCRE0q0OC2GJAKJSiEQ3rSIGNweuX6qnS/dgKDRGM3Tx9wgu
 o/qSWtm5727moLw6lsI0RegwcEosKyA1P6xuRT098yim0sS6zYT0vg9qYJsV7A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v3 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Date: Sun,  9 Nov 2025 02:35:09 +0100
Message-ID: <20251109013533.816361-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
References: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 70c463858a98c8d9e99
X-MBO-RS-META: x6oe8pm1cfyud66qkdn5uuyci94dnnir
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

Instead of resolving clock control flags using SCMI_CLOCK_ATTRIBUTES
during probe for each and every clock, resolve the clock control
flags using SCMI_CLOCK_ATTRIBUTES when the clock control flags are
first used. Because most clock are never used by U-Boot, this allows
reducing the amount of SCMI_CLOCK_ATTRIBUTES considerably, and this
improve probe time of the scmi clock driver and U-Boot start up time.

On Renesas X5H, with 1700+ SCMI clock, the boot time improved by 1.7s .

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Peng
V3: Use clk_get_by_id() clock 'c' device parent instead of clk->dev->parent
---
 drivers/clk/clk_scmi.c | 52 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 9bb41eddbba..683ac822a01 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -19,6 +19,7 @@ struct clk_scmi {
 	struct clk clk;
 	char name[SCMI_CLOCK_NAME_LENGTH_MAX];
 	u32 ctrl_flags;
+	bool attrs_resolved;
 };
 
 struct scmi_clock_priv {
@@ -86,7 +87,7 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
 				 u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
@@ -110,7 +111,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 		if (ret)
 			return ret;
 
-		*name = strdup(out.clock_name);
+		strncpy(name, out.clock_name, SCMI_CLOCK_NAME_LENGTH_MAX);
 		*attr = out.attributes;
 	} else {
 		struct scmi_clk_attribute_out out;
@@ -127,7 +128,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 		if (ret)
 			return ret;
 
-		*name = strdup(out.clock_name);
+		strncpy(name, out.clock_name, SCMI_CLOCK_NAME_LENGTH_MAX);
 		*attr = out.attributes;
 	}
 
@@ -167,6 +168,8 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 {
 	struct clk_scmi *clkscmi;
+	struct udevice *dev;
+	u32 attributes;
 	struct clk *c;
 	int ret;
 
@@ -174,8 +177,35 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 	if (ret)
 		return ret;
 
+	dev = c->dev->parent;
+
 	clkscmi = container_of(c, struct clk_scmi, clk);
 
+	if (!clkscmi->attrs_resolved) {
+		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
+		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
+					    name, &attributes);
+		if (ret)
+			return ret;
+
+		strncpy(clkscmi->name, name, SCMI_CLOCK_NAME_LENGTH_MAX);
+		if (CLK_HAS_RESTRICTIONS(attributes)) {
+			u32 perm;
+
+			ret = scmi_clk_get_permissions(dev, clk->id & CLK_ID_MSK, &perm);
+			if (ret < 0)
+				clkscmi->ctrl_flags = 0;
+			else
+				clkscmi->ctrl_flags = perm;
+		} else {
+			clkscmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL |
+					      SUPPORT_CLK_PARENT_CONTROL |
+					      SUPPORT_CLK_RATE_CONTROL;
+		}
+
+		clkscmi->attrs_resolved = true;
+	}
+
 	*ctrl_flags = clkscmi->ctrl_flags;
 
 	return 0;
@@ -328,7 +358,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	for (i = 0; i < num_clocks; i++) {
 		clk_scmi = clk_scmi_bulk + i;
 		char *clock_name = clk_scmi->name;
-		u32 attributes;
 
 		snprintf(clock_name, SCMI_CLOCK_NAME_LENGTH_MAX, "scmi-%zu", i);
 
@@ -339,21 +368,6 @@ static int scmi_clk_probe(struct udevice *dev)
 
 		dev_clk_dm(dev, i, &clk_scmi->clk);
 		dev_set_parent_priv(clk_scmi->clk.dev, priv);
-
-		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
-			if (CLK_HAS_RESTRICTIONS(attributes)) {
-				u32 perm;
-
-				ret = scmi_clk_get_permissions(dev, i, &perm);
-				if (ret < 0)
-					clk_scmi->ctrl_flags = 0;
-				else
-					clk_scmi->ctrl_flags = perm;
-			} else {
-				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
-						       SUPPORT_CLK_RATE_CONTROL;
-			}
-		}
 	}
 
 	return 0;
-- 
2.51.0

