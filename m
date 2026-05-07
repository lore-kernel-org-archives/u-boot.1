Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E303CCD37AA
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E99B84BC7;
	Fri,  8 May 2026 00:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rAOCup1H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j1V1ymj+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3630184B86; Fri,  8 May 2026 00:08:24 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E52184C20
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBRGG0Y3qz9tLQ;
 Fri,  8 May 2026 00:08:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O34UO6lVFCA2s0RGZq3iCt6hk9dkufuMYnH4oDq9gVA=;
 b=rAOCup1H1wMRQHpgZphldFNJcyai+twgR+s0mtXMe9YT4iS49zRqlC1ExxBYg70VP6rbn9
 +DgUbmnMbwkadIya10JbNv55y7mn6rdBTAHM2yfl3XD7gIG3kiZU7tNh+1hz2/CVlAC8jS
 FRDp7/gDcvW58rfC+bB2iYjbf2LVM2y6MzYVsZcn1NUIoWReVTkBOPvkBez5G/bmNv3jq8
 vR6qs7XAnaMIBN5bOcxWcaFcVa5PyAruExRr5dR43uK/MzJclhfFiWAnrN7qERYk1VYNYe
 2YTmcRsSTyAxSC1PhaLx3Ur3VIcY9hJ2IPJZ1Fi+vzJfX9dhIr1S7g5t1vVg4A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778191700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O34UO6lVFCA2s0RGZq3iCt6hk9dkufuMYnH4oDq9gVA=;
 b=j1V1ymj+cIGPhVIC1UIEAFHiUJcZQ7mSI8wF3Bie+CRMwrGUm0WMTUbrS342vvYdi4F4q4
 arV+FyMLvNf3zVzShgtGHEbcgrVW1yTfVrCUv1b9FYoDmHh0uZUBUec8MTM2xeli3M9Y3k
 toqb3Z6XcQy7o7JmwZodKqAHk/IMtL5xvSB09q2MZnHpdpb4SyTioy2pqKKx/PFAYyTftM
 c9yK9FAvYvfIxDqAhzr3bo1rfLGZmLwZjpdpgaggYcOnjDFx0eg3f4JEkNPShr07Y3K7Cw
 G2LKiZina7kSSheL3Ubs+zJODP1ZW2PXIGXerM/S+vEi4yaktJa0eYHcWSj0qA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi: bootstd: Staticize and constify driver ops
Date: Fri,  8 May 2026 00:08:10 +0200
Message-ID: <20260507220817.209253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: q8cyueiskagc36wighaiyxc98chzugrb
X-MBO-RS-ID: 16dcf2ea3d5e7acc649
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
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/spi/sf_bootdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
index 017a74a3016..6ace4ee0aed 100644
--- a/drivers/mtd/spi/sf_bootdev.c
+++ b/drivers/mtd/spi/sf_bootdev.c
@@ -57,7 +57,7 @@ static int sf_bootdev_bind(struct udevice *dev)
 	return 0;
 }
 
-struct bootdev_ops sf_bootdev_ops = {
+static const struct bootdev_ops sf_bootdev_ops = {
 	.get_bootflow	= sf_get_bootflow,
 };
 
-- 
2.53.0

