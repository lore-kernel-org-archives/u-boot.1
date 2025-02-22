Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD3EC021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEEEB80F53;
	Sat, 22 Feb 2025 21:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B8Ju0DiD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dzoyHcjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B089C80F53; Sat, 22 Feb 2025 21:35:59 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E518806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z0f0F22kvz9stH;
 Sat, 22 Feb 2025 21:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN+RFkNgAlwL/3UVi/WvCvOaKSxYQ14fYjQG5+TWI58=;
 b=B8Ju0DiDtaFq8sS/d2cmDPteZ0aQesCnb3bWFTLdjVNdfTD4vB3tDPKlfpRnSAkTeVFKQR
 nVLwwj1Q/0THOegxI4pdJU4IOYtjHOksOtRBbZTxB66USurFKUmb0H97ibs6SPyth/eHRl
 6pvVB/ifPj++7Q/yahGnKwX7oJe8C/NCOkR6Jq7gAyS0nR6TdzTYi/qIncOqnBBLIz+gta
 mIuE4j/t6CALwb+ZN+hhYIhUy1tbvSbigos1fpgi2SdQw/88RNNNN/bFwFzRfY9P+vegb1
 Mgm17vRVw7rL3tV927+vydtbmQHdgtk+0llTlckCUIoQRwatahB3AExxEs1xQQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TN+RFkNgAlwL/3UVi/WvCvOaKSxYQ14fYjQG5+TWI58=;
 b=dzoyHcjToOPzlBH6xuaBa5mvliD6TNrN8AdzW4pSpxboIV8fwTdVNKeAgJKEzDKNFCN0ZF
 h61OSQGHHlWw4X1JHt6yXIZR8641ILs0L/Gitu55AbpSB0UYoyVAoBLnAbhpftg3JQTo8K
 n7blQP/rL6wDzm02NfEUvzZLxl2H4g+kMNuNmwRNuYHGkxiPERMQW4MdEvrFpOTQlY0hhW
 QyQCW15Ly6+TO4oKID1xAu5mwufa9NRSkvIa4zW2362HimGV1Q8eReYU2Avy4yhxJsTFyh
 Xo6cPodIjS8R42tp+8FxR1YdHKeqYAYBkAIwUjPiBjaE2GiuvSpdLLzjpSAE4w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/23] net: ravb: Drop empty init callback
Date: Sat, 22 Feb 2025 21:33:11 +0100
Message-ID: <20250222203511.195437-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 904c99f8e851f8e9798
X-MBO-RS-META: mn8ki8ur8q57xdwymhq85omq7jwomqj4
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

The init function does nothing, the bb_miiphy_init() already checks
whether the .init callback is assigned, and if not, skips calling it.
Remove the empty init function. The entire init callback will be
removed in follow up patches.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
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
V2: Drop the = NULL assignment early in here.
V3: Add RB from Paul
---
 drivers/net/ravb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 7286ad19598..5df557da7da 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -560,11 +560,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ravb_bb_init(struct bb_miiphy_bus *bus)
-{
-	return 0;
-}
-
 static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
 {
 	struct ravb_priv *eth = bus->priv;
@@ -626,7 +621,6 @@ static int ravb_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "ravb",
-		.init		= ravb_bb_init,
 		.mdio_active	= ravb_bb_mdio_active,
 		.mdio_tristate	= ravb_bb_mdio_tristate,
 		.set_mdio	= ravb_bb_set_mdio,
-- 
2.47.2

