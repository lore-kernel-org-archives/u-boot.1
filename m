Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F503C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:30:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF6C88B79;
	Fri, 19 Jul 2024 12:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hB6P6DT2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wSICC5oP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500BB88B6F; Fri, 19 Jul 2024 12:30:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7631788B49
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WQQsx6Yjnz9sWt;
 Fri, 19 Jul 2024 12:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFFSsIw38LdqXlg6z92nHCyn22Vcr3FR13QbouXs1L8=;
 b=hB6P6DT2834PKNinly8h1pKa5s93MQ95t1S9hhZ68dx1scfGTJstxlWDnge8XGc9AP464j
 vnaKstLiQqc0qf2kU+B4Usa3iYjInnHWegknFGMwCEKCWGHM7eEpChxPBDuNLFoEga1sQL
 NuJIpjIF69aUcggPa1MoHXrUPMDusxHSMC7KcqDRuJMnTsAGArq+OR5ueOaEG8xqLdAO6C
 ehBeswTRzOirPzE9NcJPcjQc8bitJnFMkqORpgEp9NzcJWPOaMXnWs1lJPMFKgn2PEUPAk
 SdIHlIHLd2PGGicpS5rfYB6aW47q/RHePFPXu4lUQv3TMOiDeRiRUImuz2rrPg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721385012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFFSsIw38LdqXlg6z92nHCyn22Vcr3FR13QbouXs1L8=;
 b=wSICC5oP8bUrgzuALNKQ/YMig/MPgB+omkuEwr7KoMxFbAsMDG68FIF6tMFfP+PM/C/ByV
 o0NVAlPUHe7QWs/F3Omhsjh1nkYPmvc/yErIv+25gtL5WqeqWvPDqt1frJ+zgF+OtUCHsL
 B3eVA3fFPuWTiFxq2lHEW6i3gwg3EOmy9V302T4/U/Znyfbbcf4s7/EYy37/K5vgTwqXP/
 IIgjLo2hdeAWcNdeQwUogN8YmJ+tRCSbpbijh562j7ssSjlhfGn6p7A4Xl/BBCTjIUqFU7
 aYy7rVQ2vZEtghD9a7PAKGWnMldKtSUcdsq+JKJz1T6uIPiOgUskDzskKf07IQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/37] board: advantech: Remove duplicate newlines
Date: Fri, 19 Jul 2024 12:27:56 +0200
Message-ID: <20240719102934.322997-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
References: <20240719102934.322997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fqcyjof6315iec19ytsercodbsmmc4ms
X-MBO-RS-ID: 0c5678ff5e5c3881919
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
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
index 070933fb54b..cc3a6624155 100644
--- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
+++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
@@ -59,7 +59,6 @@ struct efi_capsule_update_info update_info = {
 
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-
 int board_early_init_f(void)
 {
 	init_uart_clk(2);
-- 
2.43.0

