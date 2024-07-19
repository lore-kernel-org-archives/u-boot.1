Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642BC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B424188B7C;
	Fri, 19 Jul 2024 12:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uRUPvH4Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZkIZ3Sqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C55E88B84; Fri, 19 Jul 2024 12:50:19 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AD287E96
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRK52h92z9tXg;
 Fri, 19 Jul 2024 12:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BLT3SISHGfbNU/xQ1TZqBT/DY6wFIyVn1Ynri1PtXo=;
 b=uRUPvH4YE+DqcHXhm1I2GWBKz8uJsCyeAy0PEVhRMmabUD3R/xdozpKx3XfYAfEocOpC0e
 LQbi1eGFjSEWwc/qWnTWpxR2RSVyq12sOYryPNN99I/DrHgY6pUwc+3A/tRCi23+jkPbyZ
 uevSMix0wASepLt3nXV51FZk6su3Rq7FV1qbxECp16kU2jYI7kgMI2FTkf8zcLArncfPNN
 g013lmNHKCVHNF9aAm7jQxPXtDBkw1G6qO3oRrh4nGYXRkEQoNOec+zS2SPtbVsm5z8rUj
 Pa4lo3RetTFCkLgVJpyjUZSN51Xyi/rUDwoUGOYccbc78g7+j7uH9NPHthPqkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8BLT3SISHGfbNU/xQ1TZqBT/DY6wFIyVn1Ynri1PtXo=;
 b=ZkIZ3Sqgn6Ad+nm1IedkGACWhBjPqrT6NjG+ecb2/1jO2vN/Z+QEP87Zy3tqkru1elXpIL
 eNpr7qjQKreEpc3iA+4SO/TCh5/uY6dHA1PrUfD/csP9BjTQEs8CEGh7rfBbYjWYzw9ew8
 JrwmOrCgAIkGAioS/oRMDVPWD30oP2bDWgIJmkG92JYOYimB9ALjxhjmnP/IPN8+eysUDd
 4/Alll6gsyzC81HQkHg6B5zth0ab4TVh0Sn/zV8zp9Qx97tIZP6ufeJhCf70JmWdeFu1bW
 rvMeTh8euaZeprkbbJXnWtN6886R4XjdB2yk6/pE8zzyVwXuaeKlM6paDEJMbQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/37] board: BuS: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:38 +0200
Message-ID: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5fut8s8iz8o9szho4y4p9a68697j5yyi
X-MBO-RS-ID: f880c1d3c7285c59c72
X-Rspamd-Queue-Id: 4WQRK52h92z9tXg
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
 board/BuS/eb_cpu5282/eb_cpu5282.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index cf5610861b5..c254da62bf4 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -181,5 +181,4 @@ void __led_set(led_id_t mask, int state)
 
 /*---------------------------------------------------------------------------*/
 
-
 /* EOF EB+MCF-EV123.c */
-- 
2.43.0

