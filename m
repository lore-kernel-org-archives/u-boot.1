Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDB8C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA9988C4A;
	Fri, 19 Jul 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sIZ6Lcyt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h2No/8PR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9839A88BFD; Fri, 19 Jul 2024 12:50:52 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C84EB88C15
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKk4j4Vz9sdR;
 Fri, 19 Jul 2024 12:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfLMcdFTS6qTUwMFjuZzcFU9AUX7byh1eFCYewAcd48=;
 b=sIZ6LcytUTz3M8Io4+XQvfB+KsqknvEehJYE6BC+bwL0c7A2mB6J2hCBb04Swdstk+4a4L
 67VtyfCxFkHEfPrVJzDRwLaBBfVKtaArvUIcf9VB7WWNswoENmZo2joHXhAssbOKxlX2Fc
 1ugNXOK6bq6FTyGRMmy66tXw4qbeGOr52nVRTBYDghwRWubnzZRits74F6DGoq08Gx2Jwm
 YxBCMbUCeEedbtuh9IspGHz0HjPbqUn5+4aH7VkQ/huT7FJ8j/mEWkhFSaQBb/gDWOPWvv
 UAIZqTesQ4xhmSzgZ75UldbqEN+2JpBTaD4iWktBQf1XLUtMKRiJkDlgRifEkw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TfLMcdFTS6qTUwMFjuZzcFU9AUX7byh1eFCYewAcd48=;
 b=h2No/8PRVDS8V7367IrOBEVCNZPWsFBgaAim4n7hxPD+t8vW7NiLQ+tJPVKAOf07oW25x4
 GuO7wG1gdf/oG+Xf2PeXMVxQ4C6MP0HKR3vhhcYl5dH2A8q/MuTrWVWmZ/BoRjI0oVWbQ5
 vPdjXPUwzUXKvfyT7GaSnBta9Ojl6rjBknEXlqrKGQ3PdgCoNcEdYyK2FqhDuIthh2q14P
 pejd3jhEftyVmKjH+QAmXik9N27ZZeI9knToxMtefmWsvwMw4gtmfv9XB2fON9zwLKsRkv
 tvehAnfIILiZfZeLJGYMdZgHdFl1c2v2IFSpbT+SIm7bcjO+fY0Jlpogkz8zDA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 33/37] board: theadorable: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:10 +0200
Message-ID: <20240719104948.323791-33-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3tqzuhcnp8suzwafxh438e7hxez741ss
X-MBO-RS-ID: 00d6cee09cc20c50b9f
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
 board/theadorable/theadorable.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/theadorable/theadorable.c b/board/theadorable/theadorable.c
index cca5c3d33b5..d7234532fe6 100644
--- a/board/theadorable/theadorable.c
+++ b/board/theadorable/theadorable.c
@@ -288,7 +288,6 @@ int board_late_init(void)
 			}
 		} while (get_timer(start_time) < ABORT_TIMEOUT);
 
-
 		/*
 		 * At this stage the bootcounter has not been incremented
 		 * yet. We need to do this manually here to get an actually
-- 
2.43.0

