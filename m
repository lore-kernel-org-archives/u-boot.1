Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362A5C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEA28882F;
	Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tC4mTqYw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I7FTNnR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1923888821; Sat, 13 Jul 2024 15:21:16 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A3F86E40
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy16gSbz9sZv;
 Sat, 13 Jul 2024 15:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmontMwkmrFTLgck4XNbbEB6kDYOJTUzwQwOV/4+LLs=;
 b=tC4mTqYw2bRJhm1ly6WxrqUhvdHnASJay2fIisj51BERA/YDcfpINYb5I0dpN0nEcUUvYE
 wJcHJS8CfZ2AjYDhaKIPfe/RBfFePocg+K438C8tVy1MCZBo0Ga1MwA9/gqOO8GDV6mAY/
 u6x09jUa86iqqam3vrDtg1Oneq64L04kTxNU9/XyppPMMAyK7SsuL7kRjsMq4mIPnm1feB
 pS409LjfPszrLcjAcj8mPSqFZMZN0uzLBK7xbEsjZ/fbksf8MLmIyFFaafJ+qm/uR6JXiX
 F1RxjaK3MQcU3fU2EawAz3+67xVhhv+JOpBpour7iee79bzgEyxbXrM5dJlT+g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmontMwkmrFTLgck4XNbbEB6kDYOJTUzwQwOV/4+LLs=;
 b=I7FTNnR8gEYe2gT+G2VdgVbYKJXtTHp9dBgxN8o1Tq8/iHOlJI69L+S98T03sxdl8MKSpk
 8oadQ1d3sB4l4oy4M40NbtPJwlm3Nithq40ztaDB2QbdQZGXat84lMApbfWmjfkFaEX1Gv
 nnWH22p8i4YRKZbQh0BChvHHYIKwdFmYSnNeIuVJrrMyP6Ic9I5h3djvvZkQlaC51VSvoo
 4F11laYgqB4jT0sMw7kc6opNplnIQXzG3KnRXNUsXumsmAsnPYM8D7g2LUvwx0j18giKq/
 ouB4dfKqMyYU1bVJKNFxfyY0UjmLpUZGbmLqlm6CDWW9zvSsdS6M8FJ9bamGVg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/45] arm: include: nxp: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:58 +0200
Message-ID: <20240713132021.57650-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d90820d62e82c974c43
X-MBO-RS-META: 4uenncgmmrf4iheq6idihsoxgjfoe1dk
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-lpc32xx/config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-lpc32xx/config.h b/arch/arm/include/asm/arch-lpc32xx/config.h
index 41160384a4d..b2d87524f70 100644
--- a/arch/arm/include/asm/arch-lpc32xx/config.h
+++ b/arch/arm/include/asm/arch-lpc32xx/config.h
@@ -8,7 +8,6 @@
 #ifndef _LPC32XX_CONFIG_H
 #define _LPC32XX_CONFIG_H
 
-
 /* Basic CPU architecture */
 
 #if !defined(CFG_SYS_NS16550_CLK)
-- 
2.43.0

