Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B10C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E671988BC0;
	Fri, 19 Jul 2024 12:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MUfXGZGf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MUfXGZGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725F288BA9; Fri, 19 Jul 2024 12:50:27 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4202288B49
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WQRKF0n4Yz9sly;
 Fri, 19 Jul 2024 12:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY1P2JffHdcau+/Lbo1uaduteJHmO81950aAV0NR+K0=;
 b=MUfXGZGfyhq+TjDdJ4zYQuq7RxsFfNaPpnZ+edcZ5/oR4t9Fb4342t6ZvEcxS5qYS4j9Ud
 yzN/XAG1DzaTwyQ9kCvb8klLY2ohBqTM/ftJ0xskyxYShmwcRm7opUF8DFnC34PGQnocjg
 9L5B+buPXlZ2VYqBkVsan/GUWyyXPwOrZNTEYRU3YaQLxa8B+evHGliIrsUh8w0LtJOB4j
 DUlGfj6SlxmXLQ45tejy/HF2fvXzbQW3z3mZSsiFmUINp80DOqawjqnEYWngEF9Urk6nm7
 SwMhZgbPcPfg2Yw/ub10O9aUgKY+0nXu4sl9972AQGEKr+Tb9nenM4OE4K+eow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IY1P2JffHdcau+/Lbo1uaduteJHmO81950aAV0NR+K0=;
 b=MUfXGZGfyhq+TjDdJ4zYQuq7RxsFfNaPpnZ+edcZ5/oR4t9Fb4342t6ZvEcxS5qYS4j9Ud
 yzN/XAG1DzaTwyQ9kCvb8klLY2ohBqTM/ftJ0xskyxYShmwcRm7opUF8DFnC34PGQnocjg
 9L5B+buPXlZ2VYqBkVsan/GUWyyXPwOrZNTEYRU3YaQLxa8B+evHGliIrsUh8w0LtJOB4j
 DUlGfj6SlxmXLQ45tejy/HF2fvXzbQW3z3mZSsiFmUINp80DOqawjqnEYWngEF9Urk6nm7
 SwMhZgbPcPfg2Yw/ub10O9aUgKY+0nXu4sl9972AQGEKr+Tb9nenM4OE4K+eow==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/37] board: congatec: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:46 +0200
Message-ID: <20240719104948.323791-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: iojd9suj3enckm5ohr684erz3j3hpscw
X-MBO-RS-ID: cce4f4b26cd22ec9f12
X-Rspamd-Queue-Id: 4WQRKF0n4Yz9sly
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
 board/congatec/cgtqmx8/cgtqmx8.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/congatec/cgtqmx8/cgtqmx8.c b/board/congatec/cgtqmx8/cgtqmx8.c
index 99c33a1943e..054e4e10867 100644
--- a/board/congatec/cgtqmx8/cgtqmx8.c
+++ b/board/congatec/cgtqmx8/cgtqmx8.c
@@ -371,7 +371,6 @@ void detail_board_ddr_info(void)
 	puts("\nDDR    ");
 }
 
-
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-- 
2.43.0

