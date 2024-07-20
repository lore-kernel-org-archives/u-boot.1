Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3CDC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F2488CC6;
	Sat, 20 Jul 2024 14:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="K4FHauGR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pQc593/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE1488C96; Sat, 20 Jul 2024 14:44:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9003788C84
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nt2Pjbz9sSs;
 Sat, 20 Jul 2024 14:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90wzyT9+3v/274oFawFfGyfNLbToYIPOWe5aPA2Iq5Y=;
 b=K4FHauGRXLnJ9rySlu8h3w9JgfmGQ4ooK//jupN6aGCQh+6/Kx3mrzFaGNxMw80sIcxAv9
 b+OfJelhdPw00TPVzor4E6de0+/T2AvJLQwtR/5GNAmD+fAVd2x4yXpVsNJd/NwOktFME8
 6wRXfjftbt79lSkVShfIBKw3QUCzZ+myPRz/P+8N8RUgyo66NQWrELP6YorJr+F5gKnBKD
 JO0mgqu7OA5scUraWsMELlPw2LaUUP7f6ZpTe3P6FN0wjvOVtzE7I/AHoW6DSHRrewx2mR
 dMLNWbLHvWFMf3yLdBE2GNw2kkR6p68FxCd6mtvlZu0Cjb9NrqnTf47/qBM/+Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90wzyT9+3v/274oFawFfGyfNLbToYIPOWe5aPA2Iq5Y=;
 b=pQc593/cYPLaIaw86pXc+2sJeX5GH/w6+GkwFOGW9hHgRU9qLI/ESNedZ9TbV3DnsJ4LAT
 EYcMvnWqgNcMD3bHw2RfrSYsTgjUodBccyH6J19wWIl9MrHtBD/wAZikhfoWWHSrdFbVo/
 Fs5IWYsYx1f+sWtu7/DY04fl+0FTezLd3G42akQcN0rjiaVrE4rarXjU3ItGTQgx8wDv4X
 pl4O4BFYTsy2gujDQ17wlkWXMgBxtsLpdpZvqwBqyeJnUAkcfNmGoUkmAqxRMOiO+nOi4P
 Nr2wM8T9Ej2PtqLgbMXul4wXT8K3KK9rVtTvBwmXoalerwI8Csh72h/k6uwiIg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 32/40] drivers: sound: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:57 +0200
Message-ID: <20240720124239.7553-32-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3f6bc21e091824a3a1b
X-MBO-RS-META: uxhp88ufgiequyntokfxq9xh1rkenwrf
X-Rspamd-Queue-Id: 4WR5nt2Pjbz9sSs
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
 drivers/sound/wm8994.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/sound/wm8994.c b/drivers/sound/wm8994.c
index 6b3091aa5de..42947357836 100644
--- a/drivers/sound/wm8994.c
+++ b/drivers/sound/wm8994.c
@@ -579,7 +579,6 @@ static int wm8994_init_volume_aif2_dac1(struct wm8994_priv *priv)
 	ret = wm8994_bic_or(priv, WM8994_AIF2_DAC_FILTERS_1,
 			    WM8994_AIF2DAC_MUTE_MASK, 0);
 
-
 	ret |= wm8994_bic_or(priv, WM8994_AIF2_DAC_LEFT_VOLUME,
 			     WM8994_AIF2DAC_VU_MASK | WM8994_AIF2DACL_VOL_MASK,
 			     WM8994_AIF2DAC_VU | 0xff);
@@ -588,7 +587,6 @@ static int wm8994_init_volume_aif2_dac1(struct wm8994_priv *priv)
 			     WM8994_AIF2DAC_VU_MASK | WM8994_AIF2DACR_VOL_MASK,
 			     WM8994_AIF2DAC_VU | 0xff);
 
-
 	ret |= wm8994_bic_or(priv, WM8994_DAC1_LEFT_VOLUME,
 			     WM8994_DAC1_VU_MASK | WM8994_DAC1L_VOL_MASK |
 			     WM8994_DAC1L_MUTE_MASK, WM8994_DAC1_VU | 0xc0);
-- 
2.43.0

