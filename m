Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C808C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3911C88BFF;
	Fri, 19 Jul 2024 12:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WL4MS+Eh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uYjFFcnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0732488BD3; Fri, 19 Jul 2024 12:50:42 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF1987E96
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WQRKV4Rphz9spG;
 Fri, 19 Jul 2024 12:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wK8b3vlHnOLnF0KTE9q5uaDjY4zkd1MG60csyUk45ak=;
 b=WL4MS+EhyzUdOmuiMq/S9/fJwzHAPp/AlELmm++JxPQiTu4SFZ+eBSOzBDaABTs3tdtXsf
 0+4XKsbAdFaQEXhUPrzLj3AcT+SaslruvCDww5ZtmBn82jL2ff2cEwHYlCVymTA1GvVccP
 p/cLacR/wrxmHuQhBF72oNNrZloNa6rU6tFWwRVKqc7riVeHKt+x7Lps1eIcQgvD5E/T0m
 phuvsTEpMBfk+X2/vTL4bQzWGNKnv2dh+iLyjdk4MGCrhwD8Xttk4qldrVKIWCm8j1SapK
 o+q+SHdsgtug3UWoFH7E3RNkyJ48VqdCyw0IT9mmCrxOu3AIvCz2R5Gii8a7vg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721386236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wK8b3vlHnOLnF0KTE9q5uaDjY4zkd1MG60csyUk45ak=;
 b=uYjFFcnV2hGc6JTtOKiXe00wYYsvt2WlLe5aiG3m7zb8oup8r+IBTfVzYNQYi2lZb4dB08
 1VdzgpuTt3GYJtNHa4FP/AOr02SaBDqaj1Z6qKJXVJkf9kAl0a+74dfxhMwz1/jXfwj71s
 CG1qgeiJWtc2A64gbqXvyAAw5tuPE3eHOtYQ68pPuI0va66B9QM+1Mb6qI0uhUTmYHrCqf
 MLJqG3Comcx8cxsc9YqE+jCasTADoEIovtH/mHcoYitghjKVxIHLu3KWqnpKON8eTzh20N
 3hWxNn2quup111uL7Z4SBZ4Np1HhQ0OtccAMmMDxcd3mbX+vp7XSxDuJxIo+Bw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 21/37] board: l+g: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:48:58 +0200
Message-ID: <20240719104948.323791-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
References: <20240719104948.323791-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4dzesw499cjtqtfj9tmr5cku4gbt4331
X-MBO-RS-ID: 8572a106b810bd57a7d
X-Rspamd-Queue-Id: 4WQRKV4Rphz9spG
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
 board/l+g/vinco/vinco.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/l+g/vinco/vinco.c b/board/l+g/vinco/vinco.c
index 066d315baa2..39e7ff633b3 100644
--- a/board/l+g/vinco/vinco.c
+++ b/board/l+g/vinco/vinco.c
@@ -62,7 +62,6 @@ static void vinco_spi0_hw_init(void)
 }
 #endif /* CONFIG_ATMEL_SPI */
 
-
 #ifdef CONFIG_CMD_USB
 static void vinco_usb_hw_init(void)
 {
@@ -72,7 +71,6 @@ static void vinco_usb_hw_init(void)
 }
 #endif
 
-
 #ifdef CONFIG_GENERIC_ATMEL_MCI
 void vinco_mci0_hw_init(void)
 {
-- 
2.43.0

