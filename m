Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54961CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7469B84BC7;
	Thu,  7 May 2026 18:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JTh8FwDw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TpZ0ARS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612BA84BCB; Thu,  7 May 2026 18:43:29 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F6384BB3
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBJ3K5BTnz9twN;
 Thu,  7 May 2026 18:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzaqBkcBBaK/iebjlhHWgqGtgunpx1xN3WLTv9ERu9E=;
 b=JTh8FwDw3raPLIYbl2W9hU0AAINqR85BNWnjTIbZsO1JEpqmu4C9rrrtQx7jR2gEirx28z
 3HwxO/8P+XAaKZSbYfxU0MUrVP95ker7ceesDvlocdPBJmjcuQuOxsvv/22C+Hc0On79rR
 TplDPfAx1Ze/KmGDEJYCbAUV+rDLinVmAd9QBEA3AOsqY7fYwPQu8VHDgNK/zUI/ajSRwn
 LOkL1ysIYyLqEWY7wzy3gMPzr+oeNyjVh3UAi4rEM4v2LmBkBI2yAkcdH/4TO5g8TQGd3m
 uXzRmvlqf0UXcCxPndLOgWp852gat+OHLnv4fNYNMZxNajTyy4R4cOimtSfaJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzaqBkcBBaK/iebjlhHWgqGtgunpx1xN3WLTv9ERu9E=;
 b=TpZ0ARS6wx52zKGSYDn8tLBpk3lbLQAhCjT0YojyYomEGHGjHec+Qa2ZlZQDaJuwr2S4dX
 szcqctd8Wfcsxz9Z97cmVXV0YCnO5+skpx7DRCrXX0T2d/b/b2jDds9mP8EFsC47a8FDVR
 MSbbKdSDMvPJYHlCH31DWWDa77zweA50gZmqLBWxRivKBu92bgh4BpQ0z2JSI6ETnldaG2
 0OaEjwHTc5wd1bCR4NHFam6VRj55MfgvhWkD8HUpsONekIckR90PkOh76XtXit8U3gXF1s
 Yr9G/qwmSJ1FVnkZS4UoWTZaNHu1PcVXOrxq+s/I/79LQ1WFV1s3qY+Dx5OB4Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] clk: ast2600: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:42:58 +0200
Message-ID: <20260507164314.59373-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
References: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pped7cimcf8js7qb356pk89bo53ozmcg
X-MBO-RS-ID: bbbe4f5b34bd8cb68af
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
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/aspeed/clk_ast2600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
index 535010b7941..4530053bc6b 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -1161,7 +1161,7 @@ static void ast2600_clk_dump(struct udevice *dev)
 }
 #endif
 
-struct clk_ops ast2600_clk_ops = {
+static const struct clk_ops ast2600_clk_ops = {
 	.get_rate = ast2600_clk_get_rate,
 	.set_rate = ast2600_clk_set_rate,
 	.enable = ast2600_clk_enable,
-- 
2.53.0

