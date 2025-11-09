Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A174DCCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 01:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B1083E85;
	Sun,  9 Nov 2025 02:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VdUGYDZ3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HHA+3sIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918CE83EC9; Sun,  9 Nov 2025 02:35:47 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9655B83E7F
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 02:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d3wNd2yvPz9thx;
 Sun,  9 Nov 2025 02:35:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH99Pei8qm/AXviXdpL01fxwkGcgR1QYCXIJK1X6W+Y=;
 b=VdUGYDZ38/sWQMNAktfHdXv0OXOsUw/kGhZiDl9mEGUSYAG98ThdoJO6aEoBhfI53V8pZk
 YHm25t2NMjOqC18KwOSYtqhHo8wd4YcwwTLYe0exmYSUZ5lNnIE44eQFMiicwDW/8S/TGa
 iiPeB9apz7B/UC9JkaK70L5jG5rCI/bWbH/KRchVQ3y0P5Oo6YG2Cx8b2ooC5qbMotijhG
 akz3yRb/CiB8l3zN9hO1x/JiuBWP3lXuHK3m7MvCn1eTK0QYvsr/bEAHLm3ctN4MOzP09l
 nhIBY5vRnV7WF+20KHWf2rvN0MQOuuXJlnnbizFEIwHDOnJueF6B1Rj6x0CKwQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HHA+3sIA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762652143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH99Pei8qm/AXviXdpL01fxwkGcgR1QYCXIJK1X6W+Y=;
 b=HHA+3sIAeK/9piahkzc4O8oYvOWhZVexRg3S4I0UXFzAOxWH+OMl4vqpdxajEChZDH24lL
 7QPgr16f/wCrgPNwN/fo55c3jzivZBJ2YXnNXkIeiJMNKxgqQJtTq44A8sJQSBP7lcMVaG
 NDHqL6NBx7VJOzGaF8OUR4tJhPTsxDvrvHh44VQyf1Xql7CRHKz2qSteOAn2R9p4A0KkNb
 7I2qX2HH4RJMkp0LIQaIx8MKLbE9cjgqFFrTauwSxmohBUHCwIBCwcc0siY8Ii9RZ7oMOG
 sLU7x8CoISM8FbRXd5nj3ev/3wCM1KEdQ7aK6MtYs+yKR+mNtQmCwH+6HBUuxQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v3 3/4] clk: scmi: Postpone clock name resolution
Date: Sun,  9 Nov 2025 02:35:08 +0100
Message-ID: <20251109013533.816361-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
References: <20251109013533.816361-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: aef49ee217837d66b34
X-MBO-RS-META: 6a7d7tpmjkkszjunb3hzohtudue7a986
X-Rspamd-Queue-Id: 4d3wNd2yvPz9thx
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

The clock names are retrived via SCMI_CLOCK_ATTRIBUTES, called for each
clock ID. This may take a lot of time to complete and is not strictly
necessary. Register each clock as "scmi-%zu" instead, and let the first
call of SCMI_CLOCK_ATTRIBUTES fill in the actual clock name.

This has a side effect, which can be considered both an upside and also
a downside. Unused clock are never renamed and retain their placeholder
"scmi-%zu" name, which avoids empty clock names for nameless SCMI clock,
and avoids the name resolution and improves boot time. But for those
SCMI clock which do have name, that name is not listed until the clock
are used.

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
 drivers/clk/clk_scmi.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 1a6a6ae464c..9bb41eddbba 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -17,6 +17,7 @@
 
 struct clk_scmi {
 	struct clk clk;
+	char name[SCMI_CLOCK_NAME_LENGTH_MAX];
 	u32 ctrl_flags;
 };
 
@@ -325,25 +326,21 @@ static int scmi_clk_probe(struct udevice *dev)
 		return -ENOMEM;
 
 	for (i = 0; i < num_clocks; i++) {
-		char *clock_name;
+		clk_scmi = clk_scmi_bulk + i;
+		char *clock_name = clk_scmi->name;
 		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
-			clk_scmi = clk_scmi_bulk + i;
-			if (!clock_name)
-				ret = -ENOMEM;
-			else
-				ret = clk_register(&clk_scmi->clk, dev->driver->name,
-						   clock_name, dev->name);
-
-			if (ret) {
-				free(clock_name);
-				return ret;
-			}
+		snprintf(clock_name, SCMI_CLOCK_NAME_LENGTH_MAX, "scmi-%zu", i);
+
+		ret = clk_register(&clk_scmi->clk, dev->driver->name,
+				   clock_name, dev->name);
+		if (ret)
+			return ret;
 
-			dev_clk_dm(dev, i, &clk_scmi->clk);
-			dev_set_parent_priv(clk_scmi->clk.dev, priv);
+		dev_clk_dm(dev, i, &clk_scmi->clk);
+		dev_set_parent_priv(clk_scmi->clk.dev, priv);
 
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
 			if (CLK_HAS_RESTRICTIONS(attributes)) {
 				u32 perm;
 
-- 
2.51.0

