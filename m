Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2881BC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:56:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079FC807D6;
	Sat, 18 Jan 2025 07:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E9irJA21";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RSrLCCDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A3D8063E; Sat, 18 Jan 2025 07:54:56 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7457E807F1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZnR11d2Wz9slj;
 Sat, 18 Jan 2025 07:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GTsf/KAWpno7mpmalcexOx5XRNPIdQmrR6aVZWuGbQ=;
 b=E9irJA21o0QxQR/rnsE6SwLoKqcj3o5PTGfxcILEcTmWuTxCSY3+52Sd1AprDIUUyXWnJh
 YVlI17cxGasOzgs9wD5+srrDt2pNYalwgym2T0Id0v0g76RXxXZ+wXCJtY3dQTY2liuefl
 yYy0FxlgFWZFJbMl9QwXdmSqmKyBgGL5fbBsndRLhY2x/5OKA4NFR0hE2stcTxiDTkCy7T
 i2Nf8TKbqMMJoc17PiIXqooqzBDHLxiLNQqS805tDbf8/lkerHdhcNZ6UQfBNTEoI8JA5e
 0CxTM7FPBJiZX3O2wclXup/hzWiddndowihsKD7FAPe1Kb2TNHPmIQ94U9Fd8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GTsf/KAWpno7mpmalcexOx5XRNPIdQmrR6aVZWuGbQ=;
 b=RSrLCCDrDKtuxjH1iiL+hR8clplzo2KhWHNb+0a46QB93NOHV/tUqlEHOdTRnttKO2cTJX
 n/TUA+1K7S6saLg7RynPQTjupgtTLJ/eZa1ZqUSabGXIlfw5EGMe/OLC/24IESzYVMkXhh
 dHtgX8AyjpxfrMcYYDN8L6s6xzGtcS+VuGMHhD6ak8grOz06Avd1SPTOjPcsnnDyqlu7f4
 4w6EeKah0c4ojYTk0YvfvunUc81ruv7uGCtgywRgnhSV/IJeB1Rv7dba0PMUyeisckjJ6v
 lGHRIhqBY2eK/UkoHAAgMM6i2w/NZgLpLuA/X3YkVQhSgby1IjSrLYLQxEYefQ==
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
Subject: [PATCH 13/17] arm: mvebu: a38x: Drop use of miiphy_get_dev_by_name()
Date: Sat, 18 Jan 2025 07:53:17 +0100
Message-ID: <20250118065402.172253-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 27aed26c40542f5d661
X-MBO-RS-META: 3ruowi6cb55bn383h5xg3ctys35eaqig
X-Rspamd-Queue-Id: 4YZnR11d2Wz9slj
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
 board/gdsys/a38x/ihs_phys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 0c2c0a54598..2663724b930 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -246,7 +246,7 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
-	*bus = miiphy_get_dev_by_name(mdiodev->name);
+	*bus = &bb_miiphy->mii;
 
 	return mii_mdio_init(bb_miiphy);
 }
-- 
2.45.2

