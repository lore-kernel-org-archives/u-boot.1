Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F39CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A1183966;
	Fri, 21 Nov 2025 17:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sqxjPCZy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MIBl6t1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8EE4839B7; Fri, 21 Nov 2025 17:17:59 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 159918394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dCgP06MYxz9tbS;
 Fri, 21 Nov 2025 17:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763741876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rAsjIa9J9SPhC2beNPDhmlUHRpTAjGfaHwx28cvY2t0=;
 b=sqxjPCZy9ljQxWEVQjvRMRTrMawROl/B/rurXRMEBfy5faHKYFa6HfMaznoFTn3uMX1Acx
 VFgcgnnp5+cip9uquHXTtjmUxTb29JkkU7d+Fow6BQuoDsk1wofj94MgPlUR6Si4LmiUFh
 M22GEkAhxKgfaJJyMP/P5m7xzTuTiVmEFckhPwaC3TEBHUkfs5UjC+DCqOdw8uAH8AOcA2
 C2jmSXzRdxVAikRoHecPe95MbzkcbashuBJ0QkF3IfqQpFbQcVkAC8SfmmONdxfPwTHvl6
 Jsn3IWZCvDAloXp21sL6Qut0VTJLrEbBLVIHvQTD/OZ55BcD0fL9AVSOIS3Wow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763741874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rAsjIa9J9SPhC2beNPDhmlUHRpTAjGfaHwx28cvY2t0=;
 b=MIBl6t1LNsLuswcA5ExE2PY8b1h11eL3njz3zasvNZxvuls0IQiHj9qyDLkkEWou286d0J
 d5CuZN5JwIvYJtZUyGLu77Aq2iZ1L3f5QdPC5cbSPjWatYNNCGifQ8G+jxeibOTUmWsSdF
 hvjbAy3chz0SiQEHxoIADhKwsRAsDGkRDFJepNoczLhhfZx/BSXGfsmx3K2LtoiCwmOefp
 lETj1Io7ZNyXraMIeouk1Ax6U9T4OeblQtxB2hpVsA+ZEMLYckZr6lsIH6+/HggvcJasUL
 zJrwqaMKUjy2UI9marbhMtr2jkuk6f4A7OpKUBcUMu9Y+2RkF+HdzgS8pAGbTg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
Date: Fri, 21 Nov 2025 17:17:37 +0100
Message-ID: <20251121161751.11849-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 28fe5aa8bdaf20d168f
X-MBO-RS-META: r7nnwk8aj3ea4bho1n8qqppsf8sx6ard
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
V2: Call only dev_has_ofnode(), which internally checks for OF_REAL
---
 drivers/clk/clk_fixed_rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
index 95a77d2e041..681bd3db20e 100644
--- a/drivers/clk/clk_fixed_rate.c
+++ b/drivers/clk/clk_fixed_rate.c
@@ -35,7 +35,7 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 				    struct clk_fixed_rate *plat)
 {
 	struct clk *clk = &plat->clk;
-	if (CONFIG_IS_ENABLED(OF_REAL))
+	if (dev_has_ofnode(dev))
 		plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
 							0);
 
-- 
2.51.0

