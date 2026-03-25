Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67C0109192D
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 01:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F2B8352B;
	Wed, 25 Mar 2026 02:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TwY1JI3j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Er03Imxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB1AD838BB; Wed, 25 Mar 2026 02:18:49 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C39DC81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 02:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fgTZH3PB9z9vB9;
 Wed, 25 Mar 2026 02:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PxIT81DKKpPC0owQReYEbFsGfOR3/Rci61bNUdcpxd4=;
 b=TwY1JI3jVMGPJKWZNgacv14+2JB06Klb8o5m2XlAMY64PhYf47Wbkl7pD1M6nXxZ79Yd0b
 hFI24RcFn6D1Sd5+gpFBt2AHC0q6bS7n7CkQS4ZaQSijIM9ygTRPIG5TEjf7MF6KW4lteu
 XT8ZF560wmzx45h/RHCO0jKV7fYxjGytCzI5snfFisu3A3eeo19SHv42wmkwNEL6iMcvf3
 Hp4JUnxbMF8ER6esentOC46akVSQ0jHVVqhUfSQoTzfb1diHZEP3laTpAGGZx6oZM9N3dR
 skuje+yypAYQtB2pzjCUCYhosRRq7+ZGIyw1/4fvBkiLynSDlH3po0u9oqqfnw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774401526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PxIT81DKKpPC0owQReYEbFsGfOR3/Rci61bNUdcpxd4=;
 b=Er03ImxfTvwcaaCkDlTMrN3dMCi35B7NfP7qPUDvPdLdMjNz+fwYkOTYNCDmjS7I0ooCuX
 qf/n0w8QmAmKsWoDxKtgEo9ypk0dRDIqcP1yYCXPQSJrT3rp5z/dz/D5cNvc8BPUn5dnkL
 bxdXfrjmPwGTD3To+/QHhsg62ueDZp6aOmlomVCPXK25Vx7whIUwNICmWSPZdOQJoIIb6x
 pODvQ4CpfayffetqeEz39U/LiYv3etUPJfbf7YQoIpIa6/4d/8433Z1O0l1PO9W9hEGKYs
 ibunD/Vn8w9mBTfH1TQZgeCl4sveT5UOmoKQO2B6XMRAIlJPdo1kZnDfdQTmcw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Make R-Car board code 32-bit ARMv8-M
 compatible
Date: Wed, 25 Mar 2026 02:18:28 +0100
Message-ID: <20260325011842.298113-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4fa3a50c20d5a2ef749
X-MBO-RS-META: 9ajwq4eqsgomw4e6s551utxpaj6di3hx
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

The 64-bit R-Car board code is currently unbuildable on 32-bit ARM
cores. Skip DRAM initialization bits to make the code compatible with
these cores, because those cores do not use the DRAM, they only use
SRAM.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/rcar64-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/rcar64-common.c
index 2d956611056..497e7663aea 100644
--- a/board/renesas/common/rcar64-common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -25,7 +25,8 @@ int dram_init(void)
 {
 	int ret = fdtdec_setup_mem_size_base();
 
-	if (current_el() == 3 && gd->ram_base == 0x48000000) {
+	if (IS_ENABLED(CONFIG_ARM64) && current_el() == 3 &&
+	    gd->ram_base == 0x48000000) {
 		/*
 		 * If this U-Boot runs in EL3, make the bottom 128 MiB
 		 * available for loading of follow up firmware blobs.
@@ -45,7 +46,7 @@ int dram_init_banksize(void)
 
 	fdtdec_setup_memory_banksize();
 
-	if (current_el() != 3)
+	if (IS_ENABLED(CONFIG_ARM64) && current_el() != 3)
 		return 0;
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-- 
2.53.0

