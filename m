Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630F3C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF0E88CEF;
	Sat, 20 Jul 2024 14:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PBfjodVC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mULz400d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556DF88CC5; Sat, 20 Jul 2024 14:44:12 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 833D188C82
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5p22BpMz9sJ3;
 Sat, 20 Jul 2024 14:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ze6kgjH36ZuD2ES2WOiF9inbLpdSbEMuUDGoNCJXXZ8=;
 b=PBfjodVC/fRBsMtcssADPNCojz3xCsMpGEBhQkD+Jq2eYSkW9pvU76r2ggIsa8LwD3aWvy
 DjI77DOaCz/av4v6Jr6f/i9uw1GvJSmKoLYc31tXbyIv7ZOAdeGBJka0Ht6Ipl2HNLHH5F
 x4AFRHhg2vhwClFnSUBVeVw4NhtaqGkcOmDloY1kX9KE1yCw3pTKXzs+H7fNQwVEgw9OoY
 Md2zOlF9xSjBEA941tN9IdRnf8b4Cu8dvbb4J1HwIAdBECN0tkgArex0X2Koi+xMtCedBr
 G2sZmDh009ucuOcWXcppY/BsLI3AWSaqGilIdk6AEGZsvD1O7ibXRGORI6FIYA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ze6kgjH36ZuD2ES2WOiF9inbLpdSbEMuUDGoNCJXXZ8=;
 b=mULz400dH1RD2XAm/y6LwGi2O181W4StFl/cA6PbVSF/YewWydyuxb8QlmPEYSvVLUodL2
 l4xH07Y3LEV8QJjr2oxNRerFNJ3rqU/vrOMlOBxPEBtu/g7Mhfa1EAQmfW1oNhDTe50DEA
 7MXxEoxYCIBKOPYw2QLo0qhTGK9o7qbgsQwEXyCylTmkehJhxr4OWsKm7Qqh2krZqBRKbC
 gbTPM6NvtBBLwpp7UtnTHFnpBmzil1tR6W3ZSywaFVCnKyt5UFEB/VaCpkdMPWIvFBG8hi
 habAp7DmJ0Uvj/+yA4q3AKe1v41rCumnf4vJtrJsb5+FbSuJaPHqjAa2eBrDIg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 40/40] drivers: watchdog: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:05 +0200
Message-ID: <20240720124239.7553-40-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 741ff00bb0bf70cd5c6
X-MBO-RS-META: yj865wn9oixeazftwa57ahom43e5phmh
X-Rspamd-Queue-Id: 4WR5p22BpMz9sJ3
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
 drivers/watchdog/meson_gxbb_wdt.c    | 1 -
 drivers/watchdog/sandbox_alarm-wdt.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 01a35b3ab30..fced8f3686b 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -24,7 +24,6 @@
 #define GXBB_WDT_CTRL_DIV_MASK			GENMASK(17, 0)
 #define GXBB_WDT_TCNT_SETUP_MASK		GENMASK(15, 0)
 
-
 struct amlogic_wdt_priv {
 	void __iomem *reg_base;
 };
diff --git a/drivers/watchdog/sandbox_alarm-wdt.c b/drivers/watchdog/sandbox_alarm-wdt.c
index 8dbbfc249e7..a7ffca96216 100644
--- a/drivers/watchdog/sandbox_alarm-wdt.c
+++ b/drivers/watchdog/sandbox_alarm-wdt.c
@@ -56,7 +56,6 @@ static int alarm_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
-
 static const struct wdt_ops alarm_wdt_ops = {
 	.start = alarm_wdt_start,
 	.reset = alarm_wdt_reset,
-- 
2.43.0

