Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F59CC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B53288BCF;
	Fri, 19 Jul 2024 12:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="raSsFVjo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BvDgC4Xw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C1188BEF; Fri, 19 Jul 2024 12:50:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F099F88B33
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKQ5RKpz9sdB;
 Fri, 19 Jul 2024 12:50:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1qI8IPfmKQaP8bADLpM1bqcWdppIpJeJpoSpfymHhc=;
 b=raSsFVjo1uBPRKq6/q7Z6rjSC/TCpqdYzlY1H1MemyECOqmyClzccA591Vpo1Q/lEzqw9/
 iRnkg1Fv6tcUEN3BwhYksoLwWVeDUQAt4b0vzFcEKi1hyUf4JL3Hw5kkJfxtgBeeJivCeP
 8jM+QU3wNj+z8qXtUNTayL3LPLutai07KTVdLtaM3ZuqF9Zb6n4VNQ8hgy8eaaobe9ntQ6
 /fO4rVrdV9RxGAv5tDVU1cePhjnVhILY7hX8y8hnkVZR5M7XSEfQDkAAF9zGcbjrsjA+Tn
 PXOFjOvcZWQKhV/1B+lNep02lxS/3rkMjydg1G4/v0Yy+elbpve26qQEaZkRQw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1qI8IPfmKQaP8bADLpM1bqcWdppIpJeJpoSpfymHhc=;
 b=BvDgC4XwnMnDg8x9P1amshnbm0fKRldMJPx7umQfvUmOjXPN4vAgRKJHjxZ407v7INg34H
 cWlWj/Wr1tzJLRGJElf9KSzdXKbPjjEj0b+Oqlpy+YmmQq70SWkw0ifOsHh+wc7wTFEJPG
 MSiKyFjyTj2AfUsyb3sTT+Ok2YKdqfEYMB9PmowHrrUUfZmhRiUnAskw/GoeGmWnHPViah
 l8sFUx+asJ0Bd7B/AhkRbdP1pmYzPpUmljOWrTCJegfc/rHFxGfjVs0yCzMf5At+mBryf/
 r0iGeKG1uWYGGeGhWKBNuAOblmpqIvQ9xG9/1+CgyVUjsppZCArZTmt4aQglbw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/37] board: ge: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:54 +0200
Message-ID: <20240719104948.323791-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 44e7df60809410ec01e
X-MBO-RS-META: 1n5b6f9miqdo89oee5ueyumzx3pz4q7t
X-Rspamd-Queue-Id: 4WQRKQ5RKpz9sdB
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
 board/ge/bx50v3/bx50v3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/ge/bx50v3/bx50v3.c b/board/ge/bx50v3/bx50v3.c
index 2d8951964a8..e1d08475e94 100644
--- a/board/ge/bx50v3/bx50v3.c
+++ b/board/ge/bx50v3/bx50v3.c
@@ -434,7 +434,6 @@ static const struct boot_mode board_boot_modes[] = {
 };
 #endif
 
-
 /*
  * The SoM used by these boards has XTAL not connected despite datasheet
  * suggesting connecting unused XTAL pins to ground. Without explicitly
-- 
2.43.0

