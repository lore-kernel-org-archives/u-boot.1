Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B25BC44521
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B78683FF5;
	Sun, 19 Jul 2026 03:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF1780398; Sun, 19 Jul 2026 03:49:31 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDAF983FF5
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGen-000000001lr-18Ig; Sun, 19 Jul 2026 01:49:29 +0000
Date: Sun, 19 Jul 2026 02:49:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] rtc: pcf8563: add haoyu,hym8563 compatible
Message-ID: <d9576ac4c07fe3055a76dcb1bd32ad605c9a68da.1784423738.git.daniel@makrotopia.org>
References: <cover.1784423738.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784423738.git.daniel@makrotopia.org>
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

The HYM8563 is a PCF8563 clone with an identical timekeeping register
layout and is found e.g. on the Radxa ROCK 5B. Match its compatible so
DM_RTC (and with it the EFI GetTime/SetTime runtime services) can use
the existing driver with upstream DT.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/rtc/pcf8563.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/pcf8563.c b/drivers/rtc/pcf8563.c
index 03bef68051b..83d60dc9b55 100644
--- a/drivers/rtc/pcf8563.c
+++ b/drivers/rtc/pcf8563.c
@@ -213,6 +213,7 @@ static const struct rtc_ops pcf8563_rtc_ops = {
 
 static const struct udevice_id pcf8563_rtc_ids[] = {
 	{ .compatible = "nxp,pcf8563" },
+	{ .compatible = "haoyu,hym8563" },
 	{ }
 };
 
-- 
2.55.0
