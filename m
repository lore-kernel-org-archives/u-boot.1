Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40239CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 03:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42258397B;
	Tue, 28 Oct 2025 04:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ylK8xb8t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KPtKlN9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51CB83987; Tue, 28 Oct 2025 04:42:39 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99698391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwbmY3MPpz9tV5;
 Tue, 28 Oct 2025 04:42:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB0MV/33nTj2YgGs7bRK+h3WFRqtvc80rWJg2rMMtjE=;
 b=ylK8xb8tItcgdSL1+xVWcizoB0Fh2Sj55gcEDCSsaNQSuu3oErfYAL13TBhtzC7xMQGKd2
 PyjbFgfmunq2z2xxM8MWUFxN9Luo2iqgXzboIg7vTM1P3AL+OIkplvchdpS/6q6dxbAE3l
 Ankzev2upZ1w1tJ7PTTtiEm3yWAUTRJjys4mcyhmb295jZU/nDdaWkkeIHzVDnU8cXg0VM
 wicF3z7ygzPXHmbo70YMNCVTWRehqcSpo+g8FLnj8EqNBGXCzZdxAscJQ9sXHkMGaDUae7
 Sal+ibySPCxyykbGu2icTdbJixajLs581ocJMxNvZmAPgmoP9MfUw69PwwuNKw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gB0MV/33nTj2YgGs7bRK+h3WFRqtvc80rWJg2rMMtjE=;
 b=KPtKlN9HRhVGSuax4UqtmYY6gdPTDkxEjbIBiqqLtNPoYZ2IQc5A/uBCplaaiL8FYRb+qI
 6zo3d8U9N179z1xKZnynFweF+ZSIBfeFzmRIHUjagCDiqllwct6UW5Pwow+0Wv4EySkmR0
 WeyVA3c4vUh17sMyGqUbPsXn6n/ij9l1+4TpVwm70FPbpHpPC8rtAloNI+t4ldorgv+CKo
 qd+Qgn59Skxi/CrV3pNqBQA+GztEShJl4hzUWLurMgG3olv0afMF+2P3m7mpzxITbWHHjc
 lV5qNmCoIYRL86+lqJfOjtZPELcYEJo9pIkH4LuGIqwSaBV+Ap6XMQt/mdYlUg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH 3/4] clk: scmi: Postpone clock name resolution
Date: Tue, 28 Oct 2025 04:41:05 +0100
Message-ID: <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: npfco9w48dd9eb1xzjrgidn9x1qpqb6p
X-MBO-RS-ID: 13769db00d491765429
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
 drivers/clk/clk_scmi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 3ee2df0ca9b..afaeb84e65d 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -16,6 +16,7 @@
 
 struct clk_scmi {
 	struct clk clk;
+	char name[SCMI_CLOCK_NAME_LENGTH_MAX];
 	u32 ctrl_flags;
 };
 
@@ -325,24 +326,20 @@ static int scmi_clk_probe(struct udevice *dev)
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
+		dev_clk_dm(dev, i, &clk_scmi->clk);
 
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
 			if (CLK_HAS_RESTRICTIONS(attributes)) {
 				u32 perm;
 
-- 
2.51.0

