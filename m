Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9587CCCFA18
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 01:35:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4A583EB7;
	Sun,  9 Nov 2025 02:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eSF8YfP0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JlEtJncx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D101F83EAC; Sun,  9 Nov 2025 02:35:45 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C735583E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 02:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d3wNb492Lz9tWy;
 Sun,  9 Nov 2025 02:35:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTEXLc/kJn+Og5SBmQFEidxITOOuDSGttlfleczXrbs=;
 b=eSF8YfP0Zi+2qkY1E4ONG5u6UFzRxj5hjUyCO2W2KV6Gyvm/GGwmZGi9i5FFciZa4cShKw
 QkfBw/wleGcvE14SsUPzyYb4SH4aUInN5Ey2WaV1d6MuA3f8vRAIoJiobs/MUidCDKtJw6
 uZj7VX3PlQK3hwQ9wRqdfj8p71bJvi4N4YmFsGehGxiSJZg4msM7n6VP9o4tVc/5XhjNn1
 CJgb8ioe8kFf1rfXmkzlSnYV+NawCUfpas9TXpBRPw+VhkOmDmOjMgU+Aw/0egrzwpRQhA
 5poSYI9y5gpsAj+pXuJkYgwQ8u77PXUsYjCvIBUbmH3TaL3RwqhquaARPkivwA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTEXLc/kJn+Og5SBmQFEidxITOOuDSGttlfleczXrbs=;
 b=JlEtJncxWW4nAjJOB1aiPS2KU5bvWoX2G5Xlrhy85peTcmpff2Uzsg2obJQl/pt6pUNKkc
 Sm0BnOqW1yPyI/811FaJDlJX0lD/Q5hRDfZxUNELrQ/tlEDi9+NjxtX3lOsVbkC0HvcLqP
 uAkjUXXNWx4QIOxf3j2n8I1PrM8DdS+9shDZXdUumhe0pUzWc1FotxCmQUiOo6CkpVa/fb
 ckR9eMtUqY3Z+Uvmd5+SRTlstI5buK5d4dn2BG5SUgNUiW+DwtB85IfF5QaOwgLXdt9r1g
 hQfVS+WWNe6f2fVGUHWgUifqOOH5FJjFoy53pRpnky1XWZY6V/sUl2zR5NlPWA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v3 2/4] clk: scmi: Factor out clock control flags resolution
Date: Sun,  9 Nov 2025 02:35:07 +0100
Message-ID: <20251109013533.816361-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
References: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9d6474d1846d1dee1f4
X-MBO-RS-META: 31ytuzqdet7qeq659mzetgnuffgydxn9
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
V3: No change
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

