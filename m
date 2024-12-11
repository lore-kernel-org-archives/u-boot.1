Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D109AE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EFF80241;
	Wed, 11 Dec 2024 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lLKkdz+w";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IfQ7NN92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E6158021D; Wed, 11 Dec 2024 08:32:36 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D496280217
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S414DWnz9srp;
 Wed, 11 Dec 2024 08:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KAAPm9s1uA/5iVnl6aXAhX3K0KOaxEvuew8dAHbhbg=;
 b=lLKkdz+wzizXCneC3+bxPPmPiNxrNqGfTtz5a1xufHMY23fKX+aUCJaai+xcj6nWgiV+Tk
 GiI2iVaiC7hR6Fquqt4SlnIqjBKxApTk7pl5yLS3D8+HD22FWAgtBY8aSapZT0/CCcKMih
 rbXnMswih4vJEJqq2k6/rYZd508aLZfyxK/poge3kD8sEfNtaU3+2QCmXSXAqgKA3XGNrW
 XgEyVsQVVGgK6hYBo9KX3erchHZfJ0CI3rOxPv8Su4OmkKLjpjfyykGyIurOTX+0zdkc67
 R6Yokq/Yc32lGMF471/KkoKxte2pZdK7tqY0Gk2PFjTHjOeQ7QNycYlW7pZudw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KAAPm9s1uA/5iVnl6aXAhX3K0KOaxEvuew8dAHbhbg=;
 b=IfQ7NN92aGyyCS6PFUMUciARuPxvDJKobx6Nwdssxg6U+6SUua7/zXRGNxC991JVIPkalO
 xYiipKNacajjzMJT1zoZmlrxkEhDj/G32sltY7V+DbNFFv9LmFnoNC5r87CDdLvkPwvg1k
 XXIweI/vYOrHxN0tdMsEK5jcbMph9zsfDMUAulJeEPLUU3IXrAdIyOB0xp7UMoW3hWX78O
 m0WmmOpwvthJe9dWmg3L48euXbfruiPDlQMOJON5RDX2qN1o5Uu7UZCYvrA8wrUf/ivcte
 qhTOI8xd9ST1SYsQSMTSG1yWzjhxOot0KuNPmwtx0uL+iGEWSzEebXy9XXIuNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/13] gpio: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:28 +0100
Message-ID: <20241211073210.8087-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b7wqfa4sh8qudd618yjyub898jr3h3cj
X-MBO-RS-ID: 998391fd315f5550c65
X-Rspamd-Queue-Id: 4Y7S414DWnz9srp
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 92a8597420a..f4a453e1cdd 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -358,10 +358,10 @@ config PCF8575_GPIO
 	 chips are from NXP and TI.
 
 config RCAR_GPIO
-	bool "Renesas RCar GPIO driver"
+	bool "Renesas R-Car GPIO driver"
 	depends on DM_GPIO && ARCH_RENESAS
 	help
-	  This driver supports the GPIO banks on Renesas RCar SoCs.
+	  This driver supports the GPIO banks on Renesas R-Car SoCs.
 
 config RZA1_GPIO
 	bool "Renesas RZ/A1 GPIO driver"
-- 
2.45.2

