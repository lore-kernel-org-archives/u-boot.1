Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF0CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 03:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D802183C61;
	Fri,  7 Nov 2025 04:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a470CpIs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SK3/kRbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5E883C6E; Fri,  7 Nov 2025 04:04:09 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26FE83C60
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 04:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d2kRV5Tlsz9tTR;
 Fri,  7 Nov 2025 04:04:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Vs9liGtc3jnRLtSnln7aX4tRXuxOiiTgPkojW9AZVM=;
 b=a470CpIs5oOgZk6gU6JqLkGO1UHTg4JJ/+K4RF4gPcJDf7wbpEimXZZBYkBPt6V+hmAa6z
 XaFt7G3/S44JNU59iZlcafVOmprp1UzG6lUqdZldnuXjXwSRPCObgG1t7pu057N2OWcHE4
 aIJPs2t9KnthLYA9UjBzDE4yEl7EUyDoi5AWbEeLSMm9hquqPhKbxY9W8leZK6Jwka262V
 UQukSdUXWMPtm7OcWdc3l+lbAB1qdagFBnKevFExQAgKIjswSWKh7ZANptcImW+X3nUtR2
 nUrG/9+IXBfx6j3o5Q7epaEZjXHkSwACi2FlUza08D6lR0Om2bTNHhtXB6I07A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Vs9liGtc3jnRLtSnln7aX4tRXuxOiiTgPkojW9AZVM=;
 b=SK3/kRbTy7fLLugg+m3WUeNTij13d0SK6x72kJjGfuzFDV8wH+aZfDV6CFEc6gG2OJG9uY
 vtbjpXinatPqwSDGpbqaI7097WQXQu+CgfZjxhD0WNNWZu3oHtQHyiT6LJSbOIokbsmttY
 VhqjAQP4at89xV4k11DFK/otR5yubP7znYIjebNdQdtq011OHdbAwPwaw2M0RhKtUZARVj
 uOm1Nr3rJ8JkEDq6vE9mqlAWmczkoNt/02/jhG5/xJ7qPxlPbOYLDkqa0FM2tyPyX0THaB
 hKg2b+iaIP9mRWCs+hhe3y1DDzmWj+snrrEVN6FO0zpVrVfiUf7SybmiwLEdhw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v2 2/4] clk: scmi: Factor out clock control flags resolution
Date: Fri,  7 Nov 2025 04:01:24 +0100
Message-ID: <20251107030352.475169-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 85d18c1a4f17642132c
X-MBO-RS-META: 4zg3wbzdtas1ryon1rizuou7egabb364
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

Pull clock control flags resolution into dedicated function and
call it from each site that does access clock control flags. No
functional change.

This is a preparatory patch for deferred issue of SCMI_CLOCK_ATTRIBUTES.

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
 drivers/clk/clk_scmi.c | 51 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 548bbfe14de..1a6a6ae464c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -163,22 +163,36 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 	return scmi_to_linux_errno(out.status);
 }
 
-static int scmi_clk_enable(struct clk *clk)
+static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 {
 	struct clk_scmi *clkscmi;
 	struct clk *c;
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(CLK_CCF))
-		return scmi_clk_gate(clk, 1);
-
 	ret = clk_get_by_id(clk->id, &c);
 	if (ret)
 		return ret;
 
 	clkscmi = container_of(c, struct clk_scmi, clk);
 
-	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+	*ctrl_flags = clkscmi->ctrl_flags;
+
+	return 0;
+}
+
+static int scmi_clk_enable(struct clk *clk)
+{
+	u32 ctrl_flags;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
+	if (ret)
+		return ret;
+
+	if (ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
 		return scmi_clk_gate(clk, 1);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
@@ -188,20 +202,17 @@ static int scmi_clk_enable(struct clk *clk)
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	struct clk_scmi *clkscmi;
-	struct clk *c;
+	u32 ctrl_flags;
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return scmi_clk_gate(clk, 0);
 
-	ret = clk_get_by_id(clk->id, &c);
+	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
 	if (ret)
 		return ret;
 
-	clkscmi = container_of(c, struct clk_scmi, clk);
-
-	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+	if (ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
 		return scmi_clk_gate(clk, 0);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
@@ -259,20 +270,17 @@ static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 
 static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
-	struct clk_scmi *clkscmi;
-	struct clk *c;
+	u32 ctrl_flags;
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return __scmi_clk_set_rate(clk, rate);
 
-	ret = clk_get_by_id(clk->id, &c);
+	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
 	if (ret)
 		return ret;
 
-	clkscmi = container_of(c, struct clk_scmi, clk);
-
-	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+	if (ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
 		return __scmi_clk_set_rate(clk, rate);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
@@ -375,20 +383,17 @@ static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 
 static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
-	struct clk_scmi *clkscmi;
-	struct clk *c;
+	u32 ctrl_flags;
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return __scmi_clk_set_parent(clk, parent);
 
-	ret = clk_get_by_id(clk->id, &c);
+	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
 	if (ret)
 		return ret;
 
-	clkscmi = container_of(c, struct clk_scmi, clk);
-
-	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+	if (ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
 		return __scmi_clk_set_parent(clk, parent);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
-- 
2.51.0

