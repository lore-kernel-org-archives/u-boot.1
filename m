Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305EC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD0688C3B;
	Fri, 19 Jul 2024 12:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AiTQOCpr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RVkS7oKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5733088BFD; Fri, 19 Jul 2024 12:50:55 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DC388BD7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQRKn2N34z9skR;
 Fri, 19 Jul 2024 12:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy4oliY6wF8i3M/Y2caemkx3zL9ImnfI2vipYYD3Mbk=;
 b=AiTQOCprwctw6gAf3JZwvfB7W1g8BZ9tynMHlw+rNR1Ka+Py4GFWtnE3RYm/a/rQRnPqFv
 OLL/HhNA5OsaHRPh7OordRokWVgQxqzA1fXyzTQacAhY/V1KSdt5QX6PcCgV3rg8XdFstW
 Z9YQ0l3cny1rOnrS/ZgaZVdEUnxxvbtk3VZd1SxazH2fXuWNCpb84D0HQscPSO4z4vFKRb
 z6X3I0FstyoZKt/ivfdatybfBKrlAUxnuQvPxm8Ui8s336EmKOtCApkQPPfwHAKsPSV3sg
 qCzN6aEX/lkRrXNoU8vqkuxHKvzKyz91sljwel+tzyeINq5ut/OlE2eNaHBBLA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy4oliY6wF8i3M/Y2caemkx3zL9ImnfI2vipYYD3Mbk=;
 b=RVkS7oKQbAywWu2liXN2KteLdLwOv5ltJBiJMxXDFDKzqXwO+vJFS8BftyYaol4UcOPwvR
 CdnQpZukwmIOl8hSONpkoctaiTU9cHdS3RykCbKGjuRqOZX8vi1/9Qu9Hox0O7EEjARYAs
 VZGsWBv2JcP2zr36MjtqqeqCbeZu75FNS9IPyooJeOzNB5SQ2tMOGmSk7sKB2hgdqa7Y+K
 DlMbeRUDQBrxhmmliR0xzlzSqwonyktnJccRpq0hbFML+jyVT3BD9+e3ZIcpNH6wdh6G5p
 D+oi0wVNM+KjtwZqtvvbPrjktHdFJOvO0nvvu7H5GbU7QM88uXlkkO7ICymNGA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 36/37] board: vscom: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:49:13 +0200
Message-ID: <20240719104948.323791-36-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a7125ab51f441c74462
X-MBO-RS-META: tz99h78w7dzhq95mznhxub9zh4zyukty
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
 board/vscom/baltos/board.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/vscom/baltos/board.c b/board/vscom/baltos/board.c
index 2c91e9fac43..cea25f8c900 100644
--- a/board/vscom/baltos/board.c
+++ b/board/vscom/baltos/board.c
@@ -285,7 +285,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	mac_addr[4] = header.MAC1[4];
 	mac_addr[5] = header.MAC1[5];
 
-
 	node = fdt_path_offset(blob, "ethernet0");
 	if (node < 0) {
 		printf("no ethernet0 path offset\n");
-- 
2.43.0

