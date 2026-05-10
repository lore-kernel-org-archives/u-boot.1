Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41650CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24ED984839;
	Sun, 10 May 2026 19:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gPKnUzvy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M4bl6Tph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B664E84839; Sun, 10 May 2026 19:17:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CA9846D0
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gD8gZ2f0vz9trC;
 Sun, 10 May 2026 19:17:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h95iAmUrYmIQGfHD/OOdajo7oc2aU4j+2dEcBLetKko=;
 b=gPKnUzvyTB8beQjD1afbZymB/nXTqS+k+bWPKKZhZP6Ysqztzk/5V4Vh/LpZ7Ahs8Ihbz5
 l5fRef6r4/xtnsSnJX9oLOT/AbmUVfO+QBMEouPjraP4OYbqcSuZ3sSJaGB2+IdBuGtjwa
 xTEAsfM3PO65RXjC3Pf5n0bU1H6KZTKI9+JdLW9fSNvLAGCE7jcfyeAOsuG95h5jFyRb6b
 wScR8MBCFEmnEEgZ4HFspAIbqJi2I3jFZQs5equMWSuuLTrknUt9tpZO3rFktLttdiJIre
 1j9WK3GH7zt8ROSjHd5OPWU5k5m0xXbAnlNw5WdRhoWZcU39ORvKM6jIcnJv/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h95iAmUrYmIQGfHD/OOdajo7oc2aU4j+2dEcBLetKko=;
 b=M4bl6TphxiAC7jCR+JnTEXYTwaIPucRlvBHzwv3TBUEmRgYQbX9zApJNfUeHQhgrBSTitg
 wbwVIiWNdkLWabjyL3pqj5pTiRqQUxT0kmuxZ9NaDNTcG0yYYT0O9Zm6HHJVxYK8oe5dhL
 yzLyT7zOe+7WZsM1vQONRF5A+orYUrnOjmcyEB9t6LQ6YjBaukda8YpLMTYdr/8Ix/J5zW
 1IRd1Uijqv2S+b0ehkarUZUr59sy2RJKf4t9y3xqGzwA/QNxtep0g5P8L0N5+CuEw2C+GX
 Kj36ludxSXXR/RUU/jUsFShSNFdidz2LpmMpiLbdAsCT7cXbMrGuoOeI+urXpA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/11] video: stm32: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:04 +0200
Message-ID: <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u4gqoh8ez9xxn769en59foemubbjsaie
X-MBO-RS-ID: 8537b3bfc5576dd47f5
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 drivers/video/stm32/stm32_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/stm32/stm32_dsi.c b/drivers/video/stm32/stm32_dsi.c
index 5c4d8d2aab5..29c57a4ff89 100644
--- a/drivers/video/stm32/stm32_dsi.c
+++ b/drivers/video/stm32/stm32_dsi.c
@@ -511,7 +511,7 @@ err_reg:
 	return ret;
 }
 
-struct video_bridge_ops stm32_dsi_ops = {
+static const struct video_bridge_ops stm32_dsi_ops = {
 	.attach = stm32_dsi_attach,
 	.set_backlight = stm32_dsi_set_backlight,
 };
-- 
2.53.0

