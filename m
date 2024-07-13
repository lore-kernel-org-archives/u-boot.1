Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5267EC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78A318888E;
	Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bEb+dnDS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ezqoXNNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669DD88890; Sat, 13 Jul 2024 15:21:30 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8204C88840
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpyJ2Cbnz9scD;
 Sat, 13 Jul 2024 15:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esYKZoYre3DoiAKll5/ff2hhQMqKtbKyPyU1LV+swGs=;
 b=bEb+dnDSYs9+YsGz7VbmuVZREdxxzlDyPOaMjeQDWnEjYfBCnTs1adAiOEipkgqn4njIip
 BH21fTy/jup1Hvy8fGhWHeGHaGBdHYxY1+wtsI31uB4Md+DMLK0B/TpP62Z3QiuehMcuQ/
 YAlXjZsiv5EfKEx4d1kWgRk9ED2TIa7Gq4Cbgf6CxDnu24qeMF/6NjmbQShUlCcptdDd+x
 prEdBkZIbqluvM/YctCBlfgYA5+6AGjXS+xKbIdk/sPww+wrhnShT4Vl85vgk1H6kLBqYJ
 7iHzADsSWa3UzDjWZpEz/CTZUB0/0xuwYHN1aBvuVAGpzFjk1dFOL9oJ4xjyAw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=esYKZoYre3DoiAKll5/ff2hhQMqKtbKyPyU1LV+swGs=;
 b=ezqoXNNpdEJZ20lz6Z11t8uzx5P7sZ6m/ZJR//L7vpSA0tFZh48VQrcgwhCYl869vNx2Z1
 zWdr+SvFBufcmr1HGSfPMFPyDPi9S8i6H+XWsXMviIvGCE0yToEHQJYlDc26yIEWNsGfGr
 pk+1G26a1rfXMSZyRBJp3J9NZ52Kr7r8n00Up8gSVrsTcZmGAFHM4CiwVP6huBC230jcLb
 mTacv4pzGy/i+ahXmJSlD9Q4yqacy68L8VsgfwOx1+dR5UvKc/gUujXguUeGMfGaA0ccXy
 54hzrCOPgWr2JnKS4C7FgIsMJalSVXcLA5ofmcxbVu9r6X3Se6pGvTKbgn/7AQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/45] arm: mach: renesas: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:11 +0200
Message-ID: <20240713132021.57650-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 34a8fb0e44e91acfa9a
X-MBO-RS-META: rnodii3xyurnwoicdtn7phkrzo4hjyic
X-Rspamd-Queue-Id: 4WLpyJ2Cbnz9scD
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
 arch/arm/mach-renesas/include/mach/rcar-base.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-renesas/include/mach/rcar-base.h b/arch/arm/mach-renesas/include/mach/rcar-base.h
index 4c2ee8187e0..a0f1c7762a0 100644
--- a/arch/arm/mach-renesas/include/mach/rcar-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-base.h
@@ -328,7 +328,6 @@
 #define MEDIA_AXI_VSP0W_BASE	0xFE966D00
 #endif	/* R8A7792 */
 
-
 #define SYS_AXI_AVBDMSCR	0xFF802000
 #define SYS_AXI_SYX2DMSCR	0xFF802004
 #define SYS_AXI_AX2MDMSCR	0xFF802004
-- 
2.43.0

