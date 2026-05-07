Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20DDCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA6684BB7;
	Thu,  7 May 2026 18:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RhwIRvzU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="d8xM8nSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBDE84BCB; Thu,  7 May 2026 18:43:30 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C89884BBD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gBJ3M5mm9z9tpZ;
 Thu,  7 May 2026 18:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDzkHmzcAxvyQV29lis4hFY6uJOHXGwyGfHp/SAbGiY=;
 b=RhwIRvzU5JuJguwS6nSWKGfRtMlC8/6tVAK8IepD7sfnj1vUkcMf3hSZXjiRvvUiSiEOyV
 7cBmjCJxlIOtsM/3R/2u33y1hh87mBG3OOJOhJ5w6m7EfPSz6ULITHmUmyFjkrH8hdnxNU
 8aI/J97YnVTCO0UzkEaBo8rS5rCGWsZvw3w328RVx4yGCcwvUHUbdHPZXEaCfgIrbPQfjA
 TFfMzinTDtDDfPoCnUIbhjU3PceiiiAok5lvSKCRIMUGS4APLsniNOqF7JC434e4bHUAjK
 grwmBx/9hWvg/Tq5y3yTwIHiaRm9h7+5v4VhQANgC/Jn3wyTB0rKbs/E5pwM9w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778172206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDzkHmzcAxvyQV29lis4hFY6uJOHXGwyGfHp/SAbGiY=;
 b=d8xM8nSpRFVCYf8Cr1B0USSvzpc/d4rgh3nGPDHBJ3gD2dOATE0nI7Jj9Qp8O90kHNSah2
 aNiK7Xx37P1ROYcE2yFodNoMLQZhdGKKgHlHJFxjTtFQPfAK/AsscmfxUxHUBm9VELBKpx
 XLHJM/J3nikcEXXdDD0hryevS+0amTxHST/Ghy3fgBsnlE8pa19rSKBVQoPboR7+a1uhEi
 d0hglgMbc1z3OtAd4N+NYaPThMegpsS3WjKdJKFS7a2Rgm1G0oA7enhzfa+84E+LA+Jcke
 V2uiM9yU03ngUs+l6qMNRpICNPbDZSUQktnJ4D9S0E/85nisrNq+me8Y4n2dzA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] clk: sunxi: Drop the extern
Date: Thu,  7 May 2026 18:42:59 +0200
Message-ID: <20260507164314.59373-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
References: <20260507164314.59373-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z8nbfbqnq5tpq5y7udq4ue9us9gi1bru
X-MBO-RS-ID: a0e34ebf241d3ae2464
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

The struct clk_ops sunxi_clk_ops is private to the clock driver
and there are no external users, no need to expose it this way.
Drop the extern.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/clk/sunxi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/clk/sunxi.h b/include/clk/sunxi.h
index c298195c51e..09cc7a4fc46 100644
--- a/include/clk/sunxi.h
+++ b/include/clk/sunxi.h
@@ -85,6 +85,4 @@ struct ccu_plat {
 	const struct ccu_desc *desc;
 };
 
-extern struct clk_ops sunxi_clk_ops;
-
 #endif /* _CLK_SUNXI_H */
-- 
2.53.0

