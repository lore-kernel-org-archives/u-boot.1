Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FD4F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384588447D;
	Mon, 16 Mar 2026 00:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jMWJGync";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JgyTwoD2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924048447D; Mon, 16 Mar 2026 00:53:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA7C84479
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fYw5v4J14z9twG;
 Mon, 16 Mar 2026 00:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lYJJOotXr64/lShlYbhvxxLbLTBa7nqLtW0VAYjIL3Q=;
 b=jMWJGyncsjot18j6u5w180hiP7MYT80z1CXS8WeSCF29h8vLHMB0eW9GRG8Hd96eNAN633
 HKy8zasfuP8N5ZH1wfN72rCLljOpXOcvIK2dqv+Pvda1VxciOPftt5viIywH1qrr94i72I
 EmJjIg6J19UgEnmKePkz/J9v5z8uP82IxnFKM5qgQFUpcANJuaPx9ycdu6966boTBIZHND
 71lBALfe1BLdgOnvMxEJUUouYodddoR/d1C3Jj75/CE6B/vx8kJbvjY8X/bEE8dWWz0RjQ
 4J8kYZl1BaqkYEe6dpR5L96y8Yu5DZYA3o+IdonTqku4ve84VrPMqQ3Izj3joA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lYJJOotXr64/lShlYbhvxxLbLTBa7nqLtW0VAYjIL3Q=;
 b=JgyTwoD2aYeLhGm/g75IldHPgcUaq5Nnw5p7wKkD+u/yEFvaSSPJeLEMbbQ1gC62a3CBGm
 DClyo/ZOdIgkrdVv9yOTeafYlztOqTL4ejxSh4tYKI/J/rgfLEwaDRK4XE8hcG6/bfqKmL
 R2lovFCoswRyYw40yVZm8TgmzdPxMeIRGJlcpj/NxGPoRliz5m2O/GJLxTv9cFmUM/yhSJ
 r8x5FAhELfAV9PCWpSeLGnKHFkT9bqCPttQCNAYDDynLQqRccuogILqiNhZJK8zxikJG+J
 Wn2SexJvnSNoWEE0TBOiWNfWxenw5bPw8gAl1XPC1J6CiUu6lquowtR3AMKgMQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: Drop unused __XSCALE__ section
Date: Mon, 16 Mar 2026 00:53:05 +0100
Message-ID: <20260315235320.304612-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9a09ab2331040267570
X-MBO-RS-META: za6yeafh7uhgxebqaqaizz9x5j69epcw
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

The code in the __XSCALE__ section is unused, since there is no more
XScale support in U-Boot. Remove the stale code. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/lib/relocate.S | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index bffadfecba1..6ee58f4edfe 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -114,16 +114,6 @@ fixnext:
 	blo	fixloop
 
 relocate_done:
-
-#ifdef __XSCALE__
-	/*
-	 * On xscale, icache must be invalidated and write buffers drained,
-	 * even with cache disabled - 4.2.7 of xscale core developer's manual
-	 */
-	mcr	p15, 0, r0, c7, c7, 0	/* invalidate icache */
-	mcr	p15, 0, r0, c7, c10, 4	/* drain write buffer */
-#endif
-
 	ret	lr
 
 ENDPROC(relocate_code)
-- 
2.51.0

