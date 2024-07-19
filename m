Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046BC3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5BE88BF2;
	Fri, 19 Jul 2024 12:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="I4NfNMnC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eWsZU89O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEAB88BD7; Fri, 19 Jul 2024 12:50:40 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B407588BE7
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WQRKS38qLz9sdB;
 Fri, 19 Jul 2024 12:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIkOqpRcm+N1x/hH9+ZiOCGJV5uX7k3tf0Nqvj3bXjs=;
 b=I4NfNMnCeX2yeh9zDZSzFf2f0+6d/0HaEICqy5GOMielI3/n+uZCpCbBant1YvyiLOedgn
 ZAs+gqqW0i92jTTQvoudxUrUeviJYyaOMUXzdBKGWyp+b1+DGdI11blqhJpxAWoBoUGnkz
 m4YE+9R4G3hZHXGaiTXdGu8c/YJbt/fCKnPmtSVY8KsH/GoFOPMDmH02oc0Yz0C4r5pyQL
 bhS9uNjScfJ9U8eJyWzUkozRNAzShUleSSSjOeHSPN6tWR0Wq2/G3tiHoAQb6lcgvjwXqa
 30hvu+VYY47X4X7E7lHHUdtpHME77iBx5Sz0SwyQI16zrcuLQc5a0ycdFpCdKg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIkOqpRcm+N1x/hH9+ZiOCGJV5uX7k3tf0Nqvj3bXjs=;
 b=eWsZU89OydZuZiyivvYblME6qHh8HKpx/RSymQvlvNQ8vlH6A1m92KZy96uKtTm8P/tpLA
 xpzAzorfKt5J1MWiXkh7H5Y4nmalvUvBfArOnc+l4lYmWnDU6jm+XXdUUaTDLyb2XQB83I
 7iyMke0t2lq0IMpx2mmOP1LYhPXke53d4eLsdxSn5g5O52SBFm8PzGLLwh4/qgEwRWbn+y
 auQmUv/JNWfei+/N9NGCcMuA6QvnLaaUn+SvAjrCyRPmA5UpjzLxPF/ruoxUJ1wDBC0V9+
 xNGzPbdGlU9oNII1+4/6OlXvNilvsUOEm+v/nJoinmIbBJzfE8pIPT/Q0fUFww==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/37] board: is1: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:56 +0200
Message-ID: <20240719104948.323791-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e655f3046f561dc55a4
X-MBO-RS-META: zpohuborwaq1w9bmrgyq5bgnwmb1erxp
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
 board/is1/qts/iocsr_config.h | 1 -
 board/is1/qts/pll_config.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/is1/qts/iocsr_config.h b/board/is1/qts/iocsr_config.h
index e54af2caed4..619b8a6706e 100644
--- a/board/is1/qts/iocsr_config.h
+++ b/board/is1/qts/iocsr_config.h
@@ -655,5 +655,4 @@ const unsigned long iocsr_scan_chain3_table[] = {
 	0x00004000,
 };
 
-
 #endif /* __SOCFPGA_IOCSR_CONFIG_H__ */
diff --git a/board/is1/qts/pll_config.h b/board/is1/qts/pll_config.h
index 0a5f5dd196f..95a4fb6305e 100644
--- a/board/is1/qts/pll_config.h
+++ b/board/is1/qts/pll_config.h
@@ -80,5 +80,4 @@
 #define CFG_HPS_ALTERAGRP_MAINCLK 4
 #define CFG_HPS_ALTERAGRP_DBGATCLK 4
 
-
 #endif /* __SOCFPGA_PLL_CONFIG_H__ */
-- 
2.43.0

