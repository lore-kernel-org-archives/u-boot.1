Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0CEEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B876886ACA;
	Wed,  6 Sep 2023 23:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IYMBPPRu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hJqcc2OZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9668B868BC; Wed,  6 Sep 2023 23:31:07 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524BE86A68
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXk0jbwz9tTZ;
 Wed,  6 Sep 2023 23:31:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcgkYvWHGiLO9SSzofNt+dgVgyo+8MhZvY5yLQurLsU=;
 b=IYMBPPRuWMg/8e8Gdn8HB/Ll42YlVVSrjJJqRD3x6U/PQTOsjI1SXnKckQjZEZe8aBj8St
 jXJsImYSVisH/rlKuMPwS6QEjqvJaCAcRVihOXhZexd6nxm0N1+ZBbyFj/KKoLbbQOi0EE
 h23zRITMqt2NHhi2uyDaPvyYvnADnDfFY5eduGGz1B3glYIO4xeCPiXA6yqCzkuxRgtZKS
 IK04HofdKoy5TVCRoICH5HvjM17HS8UVh9LfZ0Jtk8DHctB3Q1wY/7/5j+bsBzBvi7J39v
 80G1bWBKXoqe83WjGUaCbyxNr14teCN7CT1z/tI5aQ8hiHK/p3hdzAjqeXTe5w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcgkYvWHGiLO9SSzofNt+dgVgyo+8MhZvY5yLQurLsU=;
 b=hJqcc2OZoXZ0iHJH7Iq1AH4fG6gk+byfTBJ3Ikep3aHAWOBKMpJ9fzWkLinKrteNR0dE1A
 pRX+H4SrcDXNfJWpArLXRsdb7fs9j0BfSm5iMiUcXDCvHiGRxb+xb+N1x3uJrL746jsZrP
 DKR+dbLWkQHESiM5GFQwG+fMzlF6bey5GSnbwiNR0LG0Z37vOHHsgsKvcgM8F0h+8zF5Id
 ixjLnnuXi4UmQJe63Il6Mwd/78S/n0iYeQRoanpLmN7hzZeyRF3qLAHlcmITUsYGSPgnl3
 3gWxNktwcJrgxFa47j7ydwTp5dRGIfrvGOD8NoS5GKv2rtZlFpmthe1lY10fVw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 34/35] wdt: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:14 +0200
Message-Id: <20230906213015.203437-35-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1247674cd6ad70359ad
X-MBO-RS-META: 98745ufghs94pk7ai6riugpwir5cj4qu
X-Rspamd-Queue-Id: 4RgwXk0jbwz9tTZ
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/watchdog/wdt-uclass.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 509896a1b80..ed329284dec 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -236,28 +236,6 @@ void watchdog_reset(void)
 }
 #endif
 
-static int wdt_post_bind(struct udevice *dev)
-{
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct wdt_ops *ops = (struct wdt_ops *)device_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->start)
-			ops->start += gd->reloc_off;
-		if (ops->stop)
-			ops->stop += gd->reloc_off;
-		if (ops->reset)
-			ops->reset += gd->reloc_off;
-		if (ops->expire_now)
-			ops->expire_now += gd->reloc_off;
-
-		reloc_done++;
-	}
-#endif
-	return 0;
-}
-
 static int wdt_pre_probe(struct udevice *dev)
 {
 	u32 timeout = WATCHDOG_TIMEOUT_SECS;
@@ -295,7 +273,6 @@ UCLASS_DRIVER(wdt) = {
 	.id			= UCLASS_WDT,
 	.name			= "watchdog",
 	.flags			= DM_UC_FLAG_SEQ_ALIAS,
-	.post_bind		= wdt_post_bind,
 	.pre_probe		= wdt_pre_probe,
 	.per_device_auto	= sizeof(struct wdt_priv),
 };
-- 
2.40.1

