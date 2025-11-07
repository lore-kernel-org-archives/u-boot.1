Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91072CCFA13
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 03:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2700083C7B;
	Fri,  7 Nov 2025 04:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jVAHgMM3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u7ABtbB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B40B83C8C; Fri,  7 Nov 2025 04:04:10 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F28F83C64
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 04:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d2kRX2ptpz9tfv;
 Fri,  7 Nov 2025 04:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kmcCLh+nRURHz9BZsFepcFp8QNwRIO0a/G9CoKqybo=;
 b=jVAHgMM39kb/lgygKyrqlnycNuabP0K0cLfoVnhL9EgMAwPhH6FsQtnKg7sXiMV1mm6xIA
 Z7R4tmwNveb3d81e8sMgsGNS/LG3E07mR9+8Dhh1ChHRArvn/KFgtDMzcrYIeFrGrsoJWE
 wfVG3/QLqq/mlyrsOvGqjkfzYStRy8jfXWjjKPFy8j37ovQZfp9nLhC6coW7fn7Qz4OPAB
 Q3FRRwOh1zQ6QsK8wUt0S1KR6fZQOEP0Azo883tdMD2NwaM/ZXduGauPkYD/w22alX92bL
 rh6jQBYdT6Hia8i0HsUhViOqv7uCRVMzb1rrOfmPqQxHBc66Is97ba56ShUt0Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=u7ABtbB7;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762484646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kmcCLh+nRURHz9BZsFepcFp8QNwRIO0a/G9CoKqybo=;
 b=u7ABtbB7uqyDFUi62NwxiiCppRYEgSexG48a647PcKi8bpc/XzPzo5NdKw5xJ1d2Lz4TAX
 Oahx9JGuFJXCzY0Gj+RcMBsUyEuu4Aj3dErEhPQ09LDzN8DtxkD5VFh3oKmIWj8z1vzHBw
 LcNYXROYZpnecOjo3VEZJUWOs446onidStlurNmKCDhqa5YvYtdI9CWcIghvhQmlw8wJxJ
 Ck+ten62OZlXu9ElFyRxACuZXl7PA30aLOgYWVZIDapkUSYkzhG11rJRMXQfnBRIuztJ7L
 o55gXwAptc+PdrmElu2t0kwOQiPix4q5M5f+9CRYBLX4IujupRDWjUlBE+XeDg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH v2 3/4] clk: scmi: Postpone clock name resolution
Date: Fri,  7 Nov 2025 04:01:25 +0100
Message-ID: <20251107030352.475169-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dc3f353b1a23f592796
X-MBO-RS-META: 1w911grjc4fd1t5j9mrrrmd65mjkht3p
X-Rspamd-Queue-Id: 4d2kRX2ptpz9tfv
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

