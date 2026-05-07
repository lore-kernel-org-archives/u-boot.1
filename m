Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8E6CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E691D84BD4;
	Thu,  7 May 2026 18:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fqCJYHX2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Kyz3W8nA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F56484BCF; Thu,  7 May 2026 18:43:31 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B75C84BB3
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gBJ3P2mFRz9tyN;
 Thu,  7 May 2026 18:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ffji+ngXiQfYET53JCiHRWPNyWr6ewfmx6xDbo+yQFg=;
 b=fqCJYHX22C3NEs9awYUsEYrmeX382aQgt0JKM7yl4fTb//ib7jlg2pHQ6sP5ZlwCmhnDWP
 aRpc1BgOPOvUpmQ5OJzHQMLkyIWY391qWLrCpCz0NEPFE4Eu4lp2gqpUk5o6hvmyfIuCyE
 nk8wA6/KI6dQlzyBDJmGQmtbyZIaegdgD9XbjWDECJr70muOCQ0be0Tkrjhy0C3seySMMR
 NtWnjFcogQmr2ts5rp7ZHTITItKGceywuiG7MFMmHx2gGzs29xXwJONr25EXC/5SglCbSA
 fvqRpPP2mjkt96mBHqa54Qfi7pYAKDLSs39zNcyZeM/XCVBgwvwd7Kwb/Nut0g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ffji+ngXiQfYET53JCiHRWPNyWr6ewfmx6xDbo+yQFg=;
 b=Kyz3W8nAKr8OCnMU7KutgzHftByVszzEddN6KmD51K93OXtgRYB/1/es0tg60xm0XuS7SN
 J8RCImDGx2a/h/xguvmOYH6zM/TXFaDybm0Z4xg8TPNfxhGdgyxQf/cYuUAlBWRgsp9zqs
 cdT2I1F3R4kQuCq91m9XyKBL6S4sFMqK/UpHhK0KhrU7eb1cvvrnplDC43WiwfX+H+aEdr
 MOnOipel0AqE2M6HRqnhz61so223lBVTm5vk0xEirdsGboZNXuKCi12NH0VtR9S33/MEnM
 6wXJYUc21RYJfcuajibOTm689NLvxxPGwYRhms7dJexERI7F3sy1tFdt0gR0yw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] clk: sunxi: Staticize and constify driver ops
Date: Thu,  7 May 2026 18:43:00 +0200
Message-ID: <20260507164314.59373-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
References: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: my64e3h6485mc734wae8q598a83tkhob
X-MBO-RS-ID: 9155e5749ab97760ac6
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
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/sunxi/clk_sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
index 842a0541bd6..046d5d1605a 100644
--- a/drivers/clk/sunxi/clk_sunxi.c
+++ b/drivers/clk/sunxi/clk_sunxi.c
@@ -64,7 +64,7 @@ static int sunxi_clk_disable(struct clk *clk)
 	return sunxi_set_gate(clk, false);
 }
 
-struct clk_ops sunxi_clk_ops = {
+static const struct clk_ops sunxi_clk_ops = {
 	.enable = sunxi_clk_enable,
 	.disable = sunxi_clk_disable,
 };
-- 
2.53.0

