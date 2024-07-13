Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0839C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66628891E;
	Sat, 13 Jul 2024 15:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bI4ltXxZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dpofxJ5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C6888905; Sat, 13 Jul 2024 15:21:51 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31EAD888EE
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyh70sMz9sTd;
 Sat, 13 Jul 2024 15:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoTvmLyqphg/JLg0PomVDVonqZtyDaRNR6YVJWLS1v0=;
 b=bI4ltXxZ7xjIWQNj6aeiJtML5rA+7nE9q+k/rcGR0pP2AbRnHwbCmyJO97XapekTMWniJ4
 rUHwZ6fv54Ml+XSR1PhMPDgzHQt71yumtJpWe0EEZFTbDdLj6JQ9HvZGEnNv/Z0BDyZ5FP
 up4XMmuJ2hvBXdDZlwyxN5phE0aQkgZjpFcvZy31Fs1SMjGNnFvcqNsh1wlVkPKes2gnOH
 A+usr9VQyViNd80CfXd0K5gnTuf8zcoB59Cd8lzaaKfXNo+zhM36/eYacLJsZfj58fduxO
 1scMX2NoZq48VHkdMAQ/2J1Cgk4hCRAhXGeyb7cr75DXEcadLgkRVZQ9bqrLJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoTvmLyqphg/JLg0PomVDVonqZtyDaRNR6YVJWLS1v0=;
 b=dpofxJ5HlvgHkS29neuNpLR4vAllWcNH/fzB+PNW/JdZLCRQt2EkdwRw3fLT1OIzcB34mf
 WbqHgoTKFJp2FbKDPkY5L8zPGDeqSHJmBEdo4d1niraz/JBgrtAsA0tSBQXS9hk9bIb7w5
 UZB1ARn/d+upe2mcpznRRgtUjX+Jh2+LOhupcI1PPPUq4Oya3M2y46h6NKRdOsweM+giLW
 uutnYTxdCUS4luRdXHBiYXC9btX9lKTGYx1qvbAHRWN+znmHCP3p67/a1KikkMbCC5TKkD
 h8drXvWzt9FthsxGIq3j//YTieK7TSt6CY1UcpPOhzKE9j+D1R4ScHjhPlv1Mg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 39/45] sandbox: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:30 +0200
Message-ID: <20240713132021.57650-39-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bb57025bd4bdfb52326
X-MBO-RS-META: 6uxze9mah6e3z1tposyo76kk38g3k559
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
 arch/sandbox/cpu/os.c                | 1 -
 arch/sandbox/include/asm/byteorder.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index d7869b2e368..46ff305b536 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -1106,7 +1106,6 @@ void os_relaunch(char *argv[])
 	os_exit(1);
 }
 
-
 #ifdef CONFIG_FUZZ
 static void *fuzzer_thread(void * ptr)
 {
diff --git a/arch/sandbox/include/asm/byteorder.h b/arch/sandbox/include/asm/byteorder.h
index 70b4c078af1..592f10a076b 100644
--- a/arch/sandbox/include/asm/byteorder.h
+++ b/arch/sandbox/include/asm/byteorder.h
@@ -6,7 +6,6 @@
 #ifndef __ASM_SANDBOX_BYTEORDER_H
 #define __ASM_SANDBOX_BYTEORDER_H
 
-
 #include <asm/types.h>
 
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-- 
2.43.0

