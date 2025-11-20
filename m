Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77B3CF64B0
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 04:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB01783E0E;
	Thu, 20 Nov 2025 05:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qpTxXiQW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q8s2qz17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1905F83E40; Thu, 20 Nov 2025 05:14:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB7883952
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 05:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dBlP349BSz9thl;
 Thu, 20 Nov 2025 05:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsrTn4JBJTn9FqZ/TfpUn4P3mtfn6+HWcQ/Q7y9/Po8=;
 b=qpTxXiQWSn0psswEcy/aCltUG0onYrLxo3ZpmBDVdiriEkyM58hLKFIb836lAvLDN5ROAP
 fd13k0V1eLzs6BdxFnotJkrmvg3f4Y1Rz7VaKeWoaWP26ab8gKIGmr22PUp7AWTuqaTbVN
 FeOuyWpY9THzK4ob5xkri6s4jqcyb+gtpNDNFl7ekyIhf1cOeZaDvN/hqJMzlPctNHhYXm
 fJhaMTVU/C+1ogfIlE5aHyk8Wxwhbn8FrN4iW123N8QTnlAJn+lTdKi/diwCPLSfro+Eei
 hLIaxB+gHKl16ikxutjWCoeK0/dqC9dSH5MiPSkTODVZtZbBSSduq9Cmbo/nnw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763612085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BsrTn4JBJTn9FqZ/TfpUn4P3mtfn6+HWcQ/Q7y9/Po8=;
 b=q8s2qz17addoqKzWteEVa/PqUjK48ajPu6YN+Xvz2xe1pSIHWWHnnUjq00lb7Zv88ZX44t
 WAKP4AUUwsb2LlX+NvWpqa8xyRF49SFPIONFe3kAa21Ge/7C3nvXc1QUkDFEULyc1B3zny
 Co4f+H0q2CVvEF2snALI2jMz54VXWU/KXGbn4gTN9RziMCOkmxon3mxl4fxpLccVU+odn2
 ofo3C6Uv5Hq5vBSogakILmZhPqOeKGisWzUbtUqRkbCf70PQJDHq+hL+O8Hv7lG16Mmd10
 3jMydf1w8p20e5qgaZhIcGGcO7DqB21DajqQq6l1ckGJpP8g+F2ebZiV7a8xUQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Thu, 20 Nov 2025 05:14:06 +0100
Message-ID: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 97339914cf896f7e3c7
X-MBO-RS-META: g9akxrmkuiqwd4i7gacrn4roftt6y9uo
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

If CONFIG_OF_PLATDATA=y , then the udevice has no valid OF node associated
with it and ofnode_valid(node) evaluates to 0. The dev_read_u32_default()
call ultimately reaches ofnode_read_u32_index() which invokes fdt_getprop()
and passes result of ofnode_to_offset(node) as an offset parameter into it.

The ofnode_to_offset(node) returns -1 for invalid node, which leads to an
fdt_getprop(..., -1, ...) invocation, which will crash sandbox with SIGSEGV
because libfdt can not handle negative node offsets without full tree check,
which U-Boot inhibits to keep size lower.

Add dev_has_ofnode(dev) check and do not assign clock rate in case the
device has no valid node associated with it, and do not call any of the
dev_read_*() functions for devices without valid nodes.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_fixed_rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
index 95a77d2e041..5c32ae207fe 100644
--- a/drivers/clk/clk_fixed_rate.c
+++ b/drivers/clk/clk_fixed_rate.c
@@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 				    struct clk_fixed_rate *plat)
 {
 	struct clk *clk = &plat->clk;
-	if (CONFIG_IS_ENABLED(OF_REAL))
+	if (CONFIG_IS_ENABLED(OF_REAL) && dev_has_ofnode(dev))
 		plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
 							0);
 
-- 
2.51.0

