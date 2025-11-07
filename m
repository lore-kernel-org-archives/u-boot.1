Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F9BCCFA13
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 03:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9511383C5A;
	Fri,  7 Nov 2025 04:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pLy0dhEi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i90LmTwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B05C83C64; Fri,  7 Nov 2025 04:04:07 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153F683C4B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 04:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d2kRS62FTz9t9P;
 Fri,  7 Nov 2025 04:04:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=syP9eImGGhJt6X6FzySaZ628ShRpg12lBTX2ZOTkSNs=;
 b=pLy0dhEiaa8AA9wdAxnzLiUItHZqjbt0b1uHasfclTNHG7SvPpgOgFiZwFPC+Kw5M7bg9/
 SoR7I2f1fIqqGHVX7rXcdqxhoYMtD5+LQs99YuOqJOHgoJdYLahS3EqqYEMgHgm3gxvd5i
 1qTDQxX96Ndne5Ng5/Gp7KQmEyjpTPBBfpv1Kq37Z0e8DrU3kbealgY1Y1K4t5QWPxw4XD
 9PjuCB/hR2YSsqmLtfRE/45ySVFwcMsxNcTci0YEdCpLkRkbVDVKsAD6kr/niRaHAlKYop
 SF7xnrDpXl6eLhJqPsyR3nPcDfZYdQC6we2KErMIqP5ZeX6jl0KCFAF9NPc+bQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=i90LmTwx;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=syP9eImGGhJt6X6FzySaZ628ShRpg12lBTX2ZOTkSNs=;
 b=i90LmTwxwlx9kHMPGCcww22KjSx/tjlG7QGPbMGBi7aBxxgOmpuRDGeUaVFrDYglsTTC0r
 f9xp9k/ueSRvwrQys3symwPlAdRsPACtYUbhciXNthqzp4+ALEXL+b68RVKpmspWCCyrlE
 QzJ4Bz8bcMWpnO8d6UH2jcpA/0zjF1c7Rx87zc7Mkjg7+4izJKQ2tAMLx67XtUK9IcYEmm
 7v+cs20KIRBka8cO/uDQOn2C22z85TEHrnBgO6AylSSUXkFJ9luBFgXIDhagyZofClXzP8
 qE4vVe53R0GHZ5PK8KK9FeCdRHXjwZU7uxNIZ8aYfGo4EvaUD1sMBBvg0ws+MA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v2 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Date: Fri,  7 Nov 2025 04:01:23 +0100
Message-ID: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1e3b93d7d8dbbe663f5
X-MBO-RS-META: 6fm6wnazjrc8keddwg98s76e3m459p6n
X-Rspamd-Queue-Id: 4d2kRS62FTz9t9P
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

Allocate all sub-driver instance data at once. The amount of data that
have to be allocated is known up front, so is the size of the data, so
there is no need to call malloc() in a loop, mallocate all data at once.

The upside is, less heap fragmentation and fewer malloc() calls overall,
and a faster boot time.

The downside is, if some of the clock fail to register, then the clock
driver cannot free parts of the bulk allocated sub-driver instance data.
Such a failure can only occur if clk_register() were to fail, and if that
happens, the system has more significant problems. Worse, if a core clock
driver fails to probe, the system has even bigger problem.

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
 drivers/clk/clk_scmi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 37e349b9c78..548bbfe14de 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -283,7 +283,7 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk_scmi *clk_scmi;
+	struct clk_scmi *clk_scmi_bulk, *clk_scmi;
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	size_t num_clocks, i;
 	int ret;
@@ -312,20 +312,23 @@ static int scmi_clk_probe(struct udevice *dev)
 		return ret;
 	}
 
+	clk_scmi_bulk = kzalloc(num_clocks * sizeof(*clk_scmi), GFP_KERNEL);
+	if (!clk_scmi_bulk)
+		return -ENOMEM;
+
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
 		u32 attributes;
 
 		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
-			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
-			if (!clk_scmi || !clock_name)
+			clk_scmi = clk_scmi_bulk + i;
+			if (!clock_name)
 				ret = -ENOMEM;
 			else
 				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk_scmi);
 				free(clock_name);
 				return ret;
 			}
-- 
2.51.0

