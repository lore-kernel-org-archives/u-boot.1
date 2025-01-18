Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509D8C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331B0807B4;
	Sat, 18 Jan 2025 07:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E2Z/kwDs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DwqH4bLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D48807D7; Sat, 18 Jan 2025 07:54:51 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59998807B4
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZnQw72gFz9stb;
 Sat, 18 Jan 2025 07:54:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxE6m5CDvG4ln4I7hfdanl8xW2LczmInDZz7p5RoqMQ=;
 b=E2Z/kwDsPGNg49z3m+Jqdp9rFfqIlPMrdWv/7VJBjAYzZlGAk139zccQ1g6Bk7LqVTCwIs
 AIxkV0iiBpkif7eRGhAGqP+B4Yv8eEETeYuXPqvVYPAMZjU+DhDPATu4NwxBORbn0bLdbL
 VVY+D57+RTzRJm3tOsfdPtru4cgeDn4PIyXE+PsD56Ji1FXorLm5t5Ds6/VLpu5AW8qi9N
 GbbDmlHw0RraDxBYUhCsPzxo5BxwKGKC+z7lR9m6f1OACnCILxhC62DLtfMHTbNGFZLReD
 mNKjytVTkBCo5utwWDOYb/jOONUrvZU8H1CuquDhgSsHSW4o0utk5rlGTGwh4w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxE6m5CDvG4ln4I7hfdanl8xW2LczmInDZz7p5RoqMQ=;
 b=DwqH4bLTDBTUVq7s0z4oNdIhtc9/S6TeVULvPGZlqhLR2gBmAt97l2QCneDK/I81vEh2bZ
 MEBW8ikzj7c9vSbxGr+8E9h3oYUq1ZgInZW1eFXcJqPcpUyWdLCsjYJRObCuhwUh+fMi5a
 8P5FC0yLYFEhCNLspyR2SkI0LeSGv/qlhdsW2KBPERwhHQdcTjgiZAjLCvgE+otgPMBrJM
 TaW3uwubxGZsQxcVeu8HG7piu5kdvVPiCCON5NR00GduVWn0zxzBbDIpbdE2OVdvSdG5Js
 Q5NAT/z8wt1Ba5nkzCPXrSbgiYMCBSZhCC6v7+7pw+TTWuDWX1OaF8m7dz9ggQ==
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
Subject: [PATCH 11/17] arm: mvebu: a38x: Call bb_miiphy init directly in
 driver probe
Date: Sat, 18 Jan 2025 07:53:15 +0100
Message-ID: <20250118065402.172253-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 058b42cda602ca8c153
X-MBO-RS-META: 8phj9mpqxmabu6qn8ex4khapes5ak719
X-Rspamd-Queue-Id: 4YZnQw72gFz9stb
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

All the resources needed by this .init callback should already
be available by the time probe function runs, simply call the
init callback directly and set the bb_miiphy init callback to
NULL. This shouldn't break anything on this hardware, but would
be nice if someone could double-check and test that.

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
 board/gdsys/a38x/ihs_phys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 2b598abb7f0..0c2c0a54598 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -234,7 +234,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	mdiodev->write = bb_miiphy_write;
 
 	/* Copy the bus accessors and private data */
-	bb_miiphy->init = mii_mdio_init;
+	bb_miiphy->init = NULL;
 	bb_miiphy->mdio_active = mii_mdio_active;
 	bb_miiphy->mdio_tristate = mii_mdio_tristate;
 	bb_miiphy->set_mdio = mii_set_mdio;
@@ -248,7 +248,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 		return retval;
 	*bus = miiphy_get_dev_by_name(mdiodev->name);
 
-	return 0;
+	return mii_mdio_init(bb_miiphy);
 }
 
 struct porttype *get_porttype(uint octo_phy_mask, uint k)
-- 
2.45.2

