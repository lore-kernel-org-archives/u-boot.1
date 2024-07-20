Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE884C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A5C88C6F;
	Sat, 20 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="piIBCei8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DVvxj+ZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F59788C54; Sat, 20 Jul 2024 14:43:46 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6567D88418
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WR5nX14xHz9smn;
 Sat, 20 Jul 2024 14:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycPSGZuTbh5FYci6JWTPNi7S67CZho5hNlVuBmC26TQ=;
 b=piIBCei8DB/Uh8/FkdlFGf4NIUn7iwUUzVGMaLUdXRnzR5YA/K7Ge8Ox315CLMJsyu6EDq
 DL7q5Kb661mQEzI4lSnTA5sbWQmqpqDzpq5Pjry6mO7irZr0j/c50kS4taoE+F/Unt/ini
 QeOS+nwdfvt51wUMCWPlLTTdYTebBzU5cENCNktKh9wxwbBsx8Tva2sNbbRg20zGtlenTT
 Df2/LuoeHDvqGtLw1wm4/td5bLyr6a7lyaJbQ3VpnZhnUwIfWiq08yWuk2kvT9ekXQLVef
 Y/prW3cDqN5w2Tv+e0ZIgGYik23DBFKBMaRWLrkaumZ1aOxESCzZHMvzS4EYUw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycPSGZuTbh5FYci6JWTPNi7S67CZho5hNlVuBmC26TQ=;
 b=DVvxj+ZOJCp0cxHm8+7Sa3YEhBzYqUxZmR0ofX6FMRdx4S//bpXuHvKREnq1UFDjPA7ZaD
 zXjcwgPFejfnVkySuYKG2nA1tKPFOMBf0je19aeZU+eQLnVRTQpv4S/3HP0KwXCinl399k
 VHOfvceZliE7IFSQ8MXQ4fl4rpuwRzQFN3vp34tjtt5PuSXoBQ0anTpnDcKJaWYFq/ZH/+
 5dCUGUCaXZ5Z5H8IhCQL9CKm/kMQqYOyCzebnvH8lcGQ4RME3ivrp+PPQBnW2oTZErtnVI
 xq6x7zLt/ONPqMIuMUzpI7J1q5F6jgICAH5uRoUMg3KvdjiW+NtWfY1Clso9HQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/40] drivers: gpio: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:38 +0200
Message-ID: <20240720124239.7553-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 36d2d9eb3f2811e6ae8
X-MBO-RS-META: k7tjarr9i83c3pittsh59o3y7q6bphgd
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
 drivers/gpio/altera_pio.c   | 1 -
 drivers/gpio/pca953x_gpio.c | 1 -
 drivers/gpio/sunxi_gpio.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpio/altera_pio.c b/drivers/gpio/altera_pio.c
index 7ba1595e4ae..469c50a6016 100644
--- a/drivers/gpio/altera_pio.c
+++ b/drivers/gpio/altera_pio.c
@@ -59,7 +59,6 @@ static int altera_pio_get_value(struct udevice *dev, unsigned pin)
 	return !!(readl(&regs->data) & (1 << pin));
 }
 
-
 static int altera_pio_set_value(struct udevice *dev, unsigned pin, int val)
 {
 	struct altera_pio_plat *plat = dev_get_plat(dev);
diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
index 80ebaadb3e4..e84038f312e 100644
--- a/drivers/gpio/pca953x_gpio.c
+++ b/drivers/gpio/pca953x_gpio.c
@@ -39,7 +39,6 @@
 #define PCA957X_INVERT          1
 #define PCA957X_DIRECTION       4
 
-
 #define PCA_GPIO_MASK           0x00FF
 #define PCA_INT                 0x0100
 #define PCA_PCAL		BIT(9)
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index 5e86474d3db..218ca2af397 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -157,7 +157,6 @@ void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val)
 			0x3U << offset, val << offset);
 }
 
-
 /* =========== Non-DM code, used by the SPL. ============ */
 
 #if !CONFIG_IS_ENABLED(DM_GPIO)
-- 
2.43.0

