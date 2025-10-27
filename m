Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055CCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1306838EE;
	Mon, 27 Oct 2025 17:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WkoFoyGk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DY+eDwmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B0D838E5; Mon, 27 Oct 2025 17:37:57 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4AB82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwK1b2z46z9tDX;
 Mon, 27 Oct 2025 17:37:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4Asf3NojzseHrTZk7qLuGkWU/Ih1k11ZQiJ6zU1MDY=;
 b=WkoFoyGkgza5/jpYDK9M8GCNyRV79FmYI6lAUMztuxtlF+D4yVs1nC/yVvSjJQXz4wVvkk
 3l0B7w0zuHiGghWKI2S6rT3j+V8cu/JUznyberi/zqz5pvyi+rKosRH1c6D6y2LPLg7nuc
 W2JPxftXisEjSY5zCFXF1UG2KiIBGZfbrjwkCPeCtorRb+1V2vfAfKSNyCMi6JS5pCbNAi
 elhkR0uouXZdcQ0Bqukl7UB+0kZHYlDs/Leg3a1fFke+hG7U7XmLqITNaaTfPIgeSt+5fU
 643KDB8478ZjMsJ6zIqWzSENZaXFmzrYCQfT8lJnfrq96vPvul5CjplyTqoaJA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DY+eDwmE;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4Asf3NojzseHrTZk7qLuGkWU/Ih1k11ZQiJ6zU1MDY=;
 b=DY+eDwmE0S2oeYWTN13JfGUTGuMr4l1NynKyv+Wm4mDhhbBNRSb6WM1wP6ODn+X0+MldsP
 hXYDRCwRUPBOYK3QqZsNvqn7z+CFTvy8yqAhLWO/TW3eVr+/iMacwo6PQK0LJVc21bmSuA
 827/5vZrsCekL9imdT1RQpQLx+p/uR9xRUDgwcKFv9thduYW5Ueqvo+Ue1FUDAn6zkdy9+
 J5AJ14IxOD4c3aXvL3MpWrN3RL83vAUj1SdvzWlSNVfXtXyjadJuZtS2UpNB9jqN5rT7Vx
 vTds+y9sihSCWebB4O59+BZvsJGZvyUA/+VU1Teyty3pKolsPfwyUdJN/erbzw==
To: u-boot@lists.denx.de
Cc: Huy Bui <huy.bui.wm@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] gpio: renesas: Add R-Car Gen5 support
Date: Mon, 27 Oct 2025 17:35:38 +0100
Message-ID: <20251027163738.11734-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
References: <20251027163738.11734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 556f0f5b720c521916d
X-MBO-RS-META: xfmy3xyx5ke61jocdprrbntnadimyhdn
X-Rspamd-Queue-Id: 4cwK1b2z46z9tDX
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

From: Huy Bui <huy.bui.wm@renesas.com>

Add support for the GPIO controller block in the R-Car Gen5 SoC family.
The GPIO controller has a General Input Enable Register (INEN), whose
reset state is to have all input disabled. The GPIO controller also has
updated offsets for its control registers. U-Boot uses three registers,
INDT, POSNEG, INEN, which have updated offsets, those are handled by the
driver.

Signed-off-by: Huy Bui <huy.bui.wm@renesas.com>
Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: - Access Gen5 specific registers via driver data offsets,
        - Update commit message]
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Huy Bui <huy.bui.wm@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/gpio/gpio-rcar.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index f4eaf6f9c2d..c1ad20177f7 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -22,6 +22,10 @@
 #define GPIO_POSNEG_G2	0x20	/* Positive/Negative Logic Select Register */
 #define GPIO_INEN_G4	0x50	/* General Input Enable Register */
 
+#define GPIO_INDT_G5	0x1c	/* General Input Register */
+#define GPIO_POSNEG_G5	0x90	/* Positive/Negative Logic Select Register */
+#define GPIO_INEN_G5	0x18	/* General Input Enable Register */
+
 #define RCAR_MAX_GPIO_PER_BANK		32
 
 #define RCAR_GPIO_HAS_INEN		BIT(0)
@@ -184,6 +188,13 @@ static const struct rcar_gpio_data rcar_gpio_gen3_data = {
 	.inen_offset = GPIO_INEN_G4,
 };
 
+static const struct rcar_gpio_data rcar_gpio_gen5_data = {
+	.quirks = RCAR_GPIO_HAS_INEN,
+	.indt_offset = GPIO_INDT_G5,
+	.posneg_offset = GPIO_POSNEG_G5,
+	.inen_offset = GPIO_INEN_G5,
+};
+
 static const struct udevice_id rcar_gpio_ids[] = {
 	{ .compatible = "renesas,gpio-r8a7795", .data = (ulong)&rcar_gpio_gen2_data },
 	{ .compatible = "renesas,gpio-r8a7796", .data = (ulong)&rcar_gpio_gen2_data },
@@ -195,6 +206,7 @@ static const struct udevice_id rcar_gpio_ids[] = {
 	{ .compatible = "renesas,rcar-gen2-gpio", .data = (ulong)&rcar_gpio_gen2_data },
 	{ .compatible = "renesas,rcar-gen3-gpio", .data = (ulong)&rcar_gpio_gen2_data },
 	{ .compatible = "renesas,rcar-gen4-gpio", .data = (ulong)&rcar_gpio_gen3_data },
+	{ .compatible = "renesas,rcar-gen5-gpio", .data = (ulong)&rcar_gpio_gen5_data },
 	{ /* sentinel */ }
 };
 
-- 
2.51.0

