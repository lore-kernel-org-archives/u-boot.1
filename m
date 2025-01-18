Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD0C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547658073D;
	Sat, 18 Jan 2025 07:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Eq2Y6hWT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dazsvyQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD4D807E9; Sat, 18 Jan 2025 07:54:58 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721EB80808
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZnR31gDWz9sls;
 Sat, 18 Jan 2025 07:54:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpn9kxpYy9oMboFfjK1INKqvc85h2Ski70fBStizBYs=;
 b=Eq2Y6hWT6mChrAjbQNpsnMJo9kKoykuFo7NrXtngUxto9B1KPAE+oKjgctl9b+hcgbqVWo
 okaw7W5TZeJ/2LllKkxK4APXKVHvoBMsunAcxUm6oQQrD0WcByXAvB9KJLLjOQEmZ+Nt07
 NZDerwXDVgI3j8kmnBzRBFrK8kmTgD6CydMRvFXuLaAf4Qz+6L+G4hrPvMF0OAZWBN+tNn
 V73IQduYcvMXqfQZL066j/A16n/C3GvGbQu5gwnMqjR3WuFBnyA7eRlMwH+fMWzgqLk2p6
 IMpX0nICH5uD+EWIu1h1Z52nl2mp2lLezTR/sEpepNXtaYIyAvIGibLoZLw1yg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpn9kxpYy9oMboFfjK1INKqvc85h2Ski70fBStizBYs=;
 b=dazsvyQY3uIMEzpeO3QInZyjRDOHoWkiIad3g0JnxBESZDm3quYEOEN9NcYxkTnY6bPhzD
 9Z0vxXjOKKWY7liXepzGk3WabythjpguQztPYAmTJBjozao0gnTkPOyMjw0WPacWGed1qq
 4Ikg8p7f8ipYeXHrdzvfVjHILMBOW9Yu/4dT6ejn5Tot6/yRKLY/b7TLY3h+pbHKg78sG8
 hWRaxtssdD3i9+JRe/WTXMzJU5PGDqH5+08KWmyuU10udbsUTXuSGuM9kN+PE6BdvRD3Ss
 h7exiBktgL6mi2kjh1OvgwdEKgDF/Tai90JAf8dEbR2CfLeKNK9ddcG9ShPn7A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/17] net: ravb: Drop use of miiphy_get_dev_by_name()
Date: Sat, 18 Jan 2025 07:53:18 +0100
Message-ID: <20250118065402.172253-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 23c1de75d61de67cd6f
X-MBO-RS-META: b74w7nzunmonk4byquzudkjhkdefytaw
X-Rspamd-Queue-Id: 4YZnR31gDWz9sls
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

Instead of doing another lookup, trivially access the struct mii_dev
embedded in struct bb_miiphy_bus . No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/ravb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index efcf176c6ad..ac5bb89c905 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -592,7 +592,7 @@ static int ravb_probe(struct udevice *dev)
 	if (ret < 0)
 		goto err_mdio_register;
 
-	eth->bus = miiphy_get_dev_by_name(dev->name);
+	eth->bus = &bb_miiphy->mii;
 
 	/* Bring up PHY */
 	ret = clk_enable_bulk(&eth->clks);
-- 
2.45.2

