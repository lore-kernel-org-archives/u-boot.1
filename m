Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FCEC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA59788C2F;
	Fri, 19 Jul 2024 12:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZBNxvpLI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X8BeK1iz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE8688C05; Fri, 19 Jul 2024 12:50:49 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB68588BFC
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKg4nZyz9spG;
 Fri, 19 Jul 2024 12:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNvGlUIpTJbWCoJaVA+GqtOjpi/mlsbt5BvAWNc0fLE=;
 b=ZBNxvpLIwll/cm0qgB/KjdXWQzJzzg1Kzq7Mrg1Lh9cnTZ+wOaU3WxkYzgGmiGoRaB/38d
 gxT6O2gKFvM9hs2QBL1riQ6SOGYbg4n2E7UN/ctjX0+vnkA9U1YkqJMYko1/y27Dsz+6GV
 gy8Z6H9ffAz5bfbf0w9M7TXDq4OhC+ioloikHNl2WmuXmpEROjGZixSXEho/u2RSud6ZWZ
 fDR/3/lyTjUL2f6sl2y18nlvAhOND/OoTSvaS6AFm8WizjF/c6OXoLKkRUdl3kHCtarXyS
 UhNq9WnZWFm72PO5TpDNpep1RKsuQr2oWxd56oWJF4Yr1IHZifYRjt+z2RbvlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNvGlUIpTJbWCoJaVA+GqtOjpi/mlsbt5BvAWNc0fLE=;
 b=X8BeK1izNsx5qufH2V9F8sR0osYr+vOPRm5Ah9mqTySPDK5LbdEH+1jthpc5BRo58bIB1+
 ku7eRzuP3nw+DLvqlXXbZ9LGtvX5vuVFZ8SJcH4ddF3t2ubtCshRP6p0qFKxHTNkL84qSW
 uBWrM6VA+E+lIu8GEzpu4mROl9K/P2k8EwvurSkqTyuQ0lkSYzcqBej1cY7YStP3kYWhmB
 NKYtmcTGPD1W3eSMqGCXSJxC8+EGa+dvNI99xDDLa2DF+9Zz2RztLmuyDg5ZVkN5XD3xXg
 jnuJ4UbZueCPg82z8dRlJNfyMmWvKTN26uPc7Vpc3VQIqxseBPJ8ckn+NWUNXQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 30/37] board: synopsys: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:07 +0200
Message-ID: <20240719104948.323791-30-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4b739414e8c3e49a859
X-MBO-RS-META: 369oinkiyeffq5hikuws71royb9e489g
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
 board/synopsys/emsdp/emsdp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/synopsys/emsdp/emsdp.c b/board/synopsys/emsdp/emsdp.c
index adec7d32199..ffa544fa963 100644
--- a/board/synopsys/emsdp/emsdp.c
+++ b/board/synopsys/emsdp/emsdp.c
@@ -76,7 +76,6 @@ int board_early_init_r(void)
 	// Switch PSRAM controller back to memory mode
 	writel(0, PSRAM_FLASH_CONFIG_REG_0);
 
-
 	// Switch PSRAM controller to command mode
 	writel(CRE_ENABLE | CRE_DRIVE_CMD, PSRAM_FLASH_CONFIG_REG_1);
 	// Program Refresh Configuration Register (RCR) for BANK1
-- 
2.43.0

