Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEE8CCFA13
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 03:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6456D83C91;
	Fri,  7 Nov 2025 04:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cb0WlkoQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RpoGbZjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1600E83C6C; Fri,  7 Nov 2025 04:04:12 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0699D83C70
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 04:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d2kRY5ShMz9v0p;
 Fri,  7 Nov 2025 04:04:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xE93nVW+gvxqBTsZWmTff5dwK0f9Rvdy5IrqhrypIzI=;
 b=cb0WlkoQVN0MIEuU+3XYxmip4vZiWdA2mFM3ry/uOvzqUZphoJel8e/QDqPMIgldg+wPa8
 /TEqgv+tA/vZ2aq5bZbrHJ/MQcsUFnhmsBX/IZBDBF8YCpZSaOKS/Am9KjCX4Q+CsIgP/q
 RXnAmxC4fBUpMym2ptVB8xVBJTO4AJL++cOeSVfoUtxUfkJu+T3QJMo5cOEuTwZ/OD7WEj
 8I/Jxzx45DBt8+qau9uXJXUKZukuyKrvc4Lgz3riFK+cpefnddAGG2/k2GjqphgZKovPKH
 DDi1MVdnUesVpuOiuWalmbm1+YJD479TzZsZettEBptbqkQv8/drJMIqZUAhhA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RpoGbZjX;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xE93nVW+gvxqBTsZWmTff5dwK0f9Rvdy5IrqhrypIzI=;
 b=RpoGbZjXyV7WiK3c2OnVDsIhEjdy1tlFDiqUg5bpmUeqFOPQFHoO6i9wAp9f9jy3MXALl5
 DMpjWuzcH+6Cvt+HxE9nW04avOnrEj1SAUlktKS8Ld4g4ljlXwCNsQR8REZvrUUMakPD7Q
 Ug01fCbLOqEhu3K4uHogTgJj6Br0wn9a5R6wPcvBvdWCfyGgXUV3fruGaSCkfl/Vx9mI/W
 ewJUzv2h2RF/9+nOiN2wEWWhF5gj16o23a+eDh7wBbFZOXtI5CSyBrIOrn2e3FMcmAQ3Cf
 bALfgh4L7pq2Q35ycDF75xjR5jcB5zXetweaDwojy6aaj1DGES2Kdwire2Phrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Date: Fri,  7 Nov 2025 04:01:26 +0100
Message-ID: <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dad68e23e6091e98f5a
X-MBO-RS-META: x8yy1gzjqp8p6nishafjtwn9kw98dyxq
X-Rspamd-Queue-Id: 4d2kRY5ShMz9v0p
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
---
 drivers/clk/clk_scmi.c | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 9bb41eddbba..4073ff895cd 100644
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
 
@@ -166,7 +167,9 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 {
+	struct udevice *dev = clk->dev->parent;
 	struct clk_scmi *clkscmi;
+	u32 attributes;
 	struct clk *c;
 	int ret;
 
@@ -176,6 +179,31 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
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
@@ -328,7 +356,6 @@ static int scmi_clk_probe(struct udevice *dev)
 	for (i = 0; i < num_clocks; i++) {
 		clk_scmi = clk_scmi_bulk + i;
 		char *clock_name = clk_scmi->name;
-		u32 attributes;
 
 		snprintf(clock_name, SCMI_CLOCK_NAME_LENGTH_MAX, "scmi-%zu", i);
 
@@ -339,21 +366,6 @@ static int scmi_clk_probe(struct udevice *dev)
 
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

