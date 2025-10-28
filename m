Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6868BCCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 03:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDF48398C;
	Tue, 28 Oct 2025 04:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ioFPs+ZJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jmOzh74t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E9A483980; Tue, 28 Oct 2025 04:42:38 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC5D83980
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwbmX07fkz9tTx;
 Tue, 28 Oct 2025 04:42:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdZGJHCkeO0Dx5Tmcq8L88WzraKmywbrDK9I+UcHO18=;
 b=ioFPs+ZJBMWqz69myDAFIWVeUaLDxGPt/oMjfBM7/y7trlgfhpD+n1vh7oDy+sfpMFHraZ
 SqtwDt7BovWeY5u98+IfvuyHEY/iM1j/j3/0tMkfE0/LO3XHIU/96her4QvjbK9t+rsZOH
 pPnRQq+tJN7mybMRPK9OxyDjpN/q7oh03qsVO/p3lul8Kt8OFXuD2jYCeFwISzCsXo0xe1
 0oA+SRF089R/LgLc68T+dR7X5KxLLT2FXuYi98wc8BJHvCx0u95n6mYZZhYMMDmK6ZO5eX
 TXhAzoQdJgycMls5zoZ7ewTcKqIcqf+DuWmr/an2qCpnASybH7wgttic7jpikw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdZGJHCkeO0Dx5Tmcq8L88WzraKmywbrDK9I+UcHO18=;
 b=jmOzh74tL57J1z31CF51SeXpUe1+IeyIs+snxGC52G5jVjhRJ9NU7yaER1IExfkApqtptp
 aROF8mnDqUyO5f2Z54b70WiV4FXszd3VQrTOHBNLFWv7UqGpYdCBmTOfe1GWQgJKclvip+
 D2imKa4cOfkbJEaIZL++m+6UmFwEWq4xnqQ/GbNOskJZ5fMuIVPuVA9dlk9wSnn0wVMHG1
 92iRFl82KWpJBPIPEo8vuLn/BsI2Pkr0LB4TxwXiRad8Lxsu+IfFLoZ7mTwok0Ty4SCzv0
 o3hnjloJW98TnrTF+zK3LixbDOh/X9h1sOsSYzyLj5TdL9iG8axRh7IKnH0RtQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH 2/4] clk: scmi: Factor out clock control flags resolution
Date: Tue, 28 Oct 2025 04:41:04 +0100
Message-ID: <20251028034225.260469-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n5aantd1ekz6wu6p3exc8edpqyfaixxa
X-MBO-RS-ID: 0a799a8602ca5c1295b
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
 drivers/clk/clk_scmi.c | 51 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 0b64c73a61d..3ee2df0ca9b 100644
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
@@ -374,20 +382,17 @@ static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 
 static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
-	struct clk_scmi *clkscmi;
-	struct clk *c;
+	u32 ctrl_flags;
 	int ret;
 
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return -ENOTSUPP;
 
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

