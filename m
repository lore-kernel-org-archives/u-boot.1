Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DC6CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B237838BB;
	Mon, 27 Oct 2025 17:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HzoQnd03";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hLFvHF0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A8C838BB; Mon, 27 Oct 2025 17:37:55 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F379838BB
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cwK1W6gtFz9tVJ;
 Mon, 27 Oct 2025 17:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JG+ffPQduVFTAnXU39HDvsvZBHBNID6nQ03n6h52aG0=;
 b=HzoQnd03GSQ3vvrRwPsX9s1nfI2BoqL8of3XCnhAyaX9Dy9u+/uBNWTjeBgsO51nOFh/RO
 IcpwO+Wuahx35BEY2CYp3uh+xOWUDy80Mn4VMGPCi59qikTfM4KEEw/KASZsSNODVm0BO5
 wS02+ZwHy1Yc8kPeYiJoXdRGgwz0RXKPcEdVw1BfZkIQNdZ4TtLSxi/hdYPy3rawTKfEMT
 5qkthS/qgTvgF1E8BXE8JlBWUTi+4GrKipL24tDV3XoRd3LBPOzuYIseTvvSNZtapHHuSQ
 aQGKcmSQEHz4HaCLCAHwqgdQnDi6RoKdoLIwhfAlNsioat49rF0ewUlOA0DL9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JG+ffPQduVFTAnXU39HDvsvZBHBNID6nQ03n6h52aG0=;
 b=hLFvHF0x8gaMgXICTqW6YAvet/9C2m8dNWFDvLkQwmgTQ6SwOnomRnyQT1Uegm545mCkkk
 6QLtHZ3bm8iuqLDFjMbwuVfhdJjd3bmXb3KjPJ/SX6caLepak3JV5TmY2TO/uBpJpxlYWk
 FDCGAJUprTB82KsR3NXx5i7SLkwPR+ZKEauE1InsxtlnAIdYfquXNTYA5AwIS29EMZlHIB
 XulWs2OKM4UsByjdK1UuVRQY2WTQm5ybfa/io35Q8KU7KY1MumaifA2hd4CQWe1hTIc4Kw
 cSr/M7vClMa+yjiugijMRmLpJN/Zgh0LXjNAbTEw7tD0aNSLDaSCx492WyRq6w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] gpio: renesas: Drop unused register macros
Date: Mon, 27 Oct 2025 17:35:35 +0100
Message-ID: <20251027163738.11734-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
References: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8cr934cjtc7zwu9qqcz4rqcdjbgarde3
X-MBO-RS-ID: 7909b6ce537313ed1ef
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

Remove register macros for registers which are not used by this driver.
This makes it easier to get an overview of which registers are really
used by the driver. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/gpio-rcar.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 109383e83d5..8853187e64e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -19,14 +19,7 @@
 #define GPIO_INOUTSEL	0x04	/* General Input/Output Switching Register */
 #define GPIO_OUTDT	0x08	/* General Output Register */
 #define GPIO_INDT	0x0c	/* General Input Register */
-#define GPIO_INTDT	0x10	/* Interrupt Display Register */
-#define GPIO_INTCLR	0x14	/* Interrupt Clear Register */
-#define GPIO_INTMSK	0x18	/* Interrupt Mask Register */
-#define GPIO_MSKCLR	0x1c	/* Interrupt Mask Clear Register */
 #define GPIO_POSNEG	0x20	/* Positive/Negative Logic Select Register */
-#define GPIO_EDGLEVEL	0x24	/* Edge/level Select Register */
-#define GPIO_FILONOFF	0x28	/* Chattering Prevention On/Off Register */
-#define GPIO_BOTHEDGE	0x4c	/* One Edge/Both Edge Select Register */
 #define GPIO_INEN	0x50	/* General Input Enable Register */
 
 #define RCAR_MAX_GPIO_PER_BANK		32
-- 
2.51.0

