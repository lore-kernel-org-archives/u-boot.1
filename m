Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5665C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 04:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5487180657;
	Sat, 18 Jan 2025 05:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mkeoQbNZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SVA21/uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F3280759; Sat, 18 Jan 2025 05:02:29 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C018036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 05:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZjc316mXz9sX2;
 Sat, 18 Jan 2025 05:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHrsqNcsRgpeY9rxAmIF6biGiqPeftsyG2RYdma4pj4=;
 b=mkeoQbNZIClP8hiKZEe9gmOenJli2ZkAG82v8Blt8boijJN+4P2eQtnK38dCQyaTwh8sR8
 HpCkVGYGEfjf5gLh6StQgDNzOyg/1x1ERAz82L4FFN3EQ6HkGfnFRiU0fW12ZIDVZcJoXe
 zh0I6JLgAsz+RlU+v6UfFATAPyx9lA3+T+evZl+fbpuIu3aDvKhAUCS5plLZ16/LjhHCmD
 6lmHZExZOk/fmWkwRXcqozfIeLepxYXUx9ia2zW475k0DK0FiwEPzQk8qxXz+wH7/lOK6H
 YbKR3aZ0KJqUmoqgXwmFjxax6IjXydCQIEq+VCui41NuUrjwdVHxStmuxrIz+w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737172945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHrsqNcsRgpeY9rxAmIF6biGiqPeftsyG2RYdma4pj4=;
 b=SVA21/ucae8BB4u3qkoKyPZGo3zk6kJxtPJnupwdDJbGmWchHoVCRZDBjWCLUk2GEG6FKO
 elY2u9gJe+RpWDgfjIuutG3DjKcb0xPmDtzWkZrkmUgUso1GZkobx6Z7pqDMciFRm77nj1
 noA/CgmDvQGjskuOKO+SjXU0AHSxB7BdKwaGtoR50crOETLlrut7vQA3AN13sH/Wqq5gsr
 u0pWgZViipkYtPVlVxulzngdbltgarU4BH1ohZW4HqtuVxkC6zL4FdmK0NjXhAmwFNTLrM
 F5E5cQ6dy0/lwamBj2HvJo04zWdQNWikBEzJpdjlgJyF0sXs6DZHvHQZhs/TQQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aaron Williams <awilliams@marvell.com>, Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] wdt: Handle return value from cyclic_register()
Date: Sat, 18 Jan 2025 05:01:02 +0100
Message-ID: <20250118040130.74921-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bpfu3xa1xiyt6puceznje1mcutz3t9z7
X-MBO-RS-ID: 996ab1a608a63b80b31
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

Handle the error code returned by cyclic_register() and propagate it.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Aaron Williams <awilliams@marvell.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Devarsh Thakkar <devarsht@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/watchdog/wdt-uclass.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 10be334e9ed..5778c8bee40 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -129,9 +129,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 				cyclic_unregister(&priv->cyclic);
 
 			/* Register the watchdog driver as a cyclic function */
-			cyclic_register(&priv->cyclic, wdt_cyclic,
-					priv->reset_period * 1000,
-					dev->name);
+			ret = cyclic_register(&priv->cyclic, wdt_cyclic,
+					      priv->reset_period * 1000,
+					      dev->name);
+			if (ret)
+				return ret;
 
 			snprintf(str, 16, "every %ldms", priv->reset_period);
 		}
-- 
2.45.2

