Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A73CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 03:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158538398D;
	Tue, 28 Oct 2025 04:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t5/Ca6SU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dauQ+/hx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448518398C; Tue, 28 Oct 2025 04:42:37 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A21A8391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwbmW1Fshz9tTj;
 Tue, 28 Oct 2025 04:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VxO1yR6nftZXtzcOULZDBQcTSVN/HU6791qwdZC15Yg=;
 b=t5/Ca6SUEY39s1CBQ3qPTaRWZSGhmYNDJF25fg0zkvWytaGmvhAHP6DzUwXEeK+0nUpJDv
 wABnLaUd+Jc+pWbk8Wsq5tVps9ebi+sjMEsgyB5jPr4pk9NJ9yvzRv8OvgKw1JiB/ABr/v
 sRoi4EEdfpTIqx8+ucZg8WIN3Ph6WZCQYnKDb2jHtBuDenp/xosJXF0cr6oICWjV7+ko5l
 CIZzUIkeRH+J6Z6xF9m6LsVFTZ4SSyIV6B+9NxgXmoo7gRg4kGQDmBNcwj3ckZ3Hqc/Kur
 C6UsgebQO/8QnphcNhhkerTKyNya5ka+u9IIlObdqxrr2bKu7vwHapBCFdUtUg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VxO1yR6nftZXtzcOULZDBQcTSVN/HU6791qwdZC15Yg=;
 b=dauQ+/hxV/E1+5yN1Sp85wQOd5FhjQXD6w2cDTV2Zp2u1vp5GxeBTzyBIEFFcaGyw5Ysio
 WUnUZEM/DHv78o/IyOxXZ6teirE7GkeLnEhZrMl23DrRlafhUM+nNcE1PboQp3/XEQYaC9
 p3jAxqO7IYAyl66giq6W0NJyjj1CZwsAI3saEBDdd3mfkSrBR9Is2xB9io+0MwPMP+13hU
 SZyGhOA5jTHbtwWTo/9QsNSW+Yb4RmX01A3gryqJdygd050oPv/l8QjQ7ak50l5EsCe5vs
 PPYmT8F4znpc1Kga/4KRipMKhTNPPE0FywfNP3ZKzUclRQKqF9CNIubW0BDaow==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Date: Tue, 28 Oct 2025 04:41:03 +0100
Message-ID: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cahrha4mhdkz36jykwqswktomtdca8d3
X-MBO-RS-ID: fb8e254a5b5014973bc
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
 drivers/clk/clk_scmi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index f9e17c38cad..0b64c73a61d 100644
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

