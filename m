Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A989CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC56808AF;
	Tue,  4 Nov 2025 13:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="UV69gR7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068E3835FE; Tue,  4 Nov 2025 13:56:10 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3F08144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 880FCC9DCE; Tue,  4 Nov 2025 13:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762260967; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ueiq+t5hUOG+rU9SfWgdxHm/3KQm1kPkB15jFTiJU9g=;
 b=UV69gR7N7h1Oxem5PWtInybb08dLldf2tguAYBDkhPj3s2u9dlA90AwbX257JADp3EdK6d
 o7xJFWGB5WEv9U9m08eDtLeOsge5UpCD5UREVyjdhjnPMz3aL1Rgi5MQzuQItrGBzXxNIT
 FUjwZAJ4Rlb9koKWCdp+AJ2E6eYTMYpCi/yZk8nwzifxlhJLjHOY+TyMfJl8ODlyGBL1+m
 LRIChXVwzu7gEIxRvdolW0xXHTXAkxPJi9l8XED+UWIZzuF+K9euupNDTsNdWOTBpjf+42
 QFqrnYIlanrDoOkHT7gvwD0wF5OWYN3Y6K1vRN4f65N//1pjfDeUdftZ+QIHCQ==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Annette Kobou <annette.kobou@kontron.de>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>
Subject: [PATCH 1/4] imx: kontron-sl-mx6ul: Enable CONFIG_BOARD_LATE_INIT to
 fix auto fastboot
Date: Tue,  4 Nov 2025 13:54:25 +0100
Message-ID: <20251104125441.138131-2-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104125441.138131-1-frieder@fris.de>
References: <20251104125441.138131-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Recently code was added in board_late_init() to autostart fastboot
in case of booting from USB OTG. This change was ineffective as
enabling CONFIG_BOARD_LATE_INIT got lost during upstreaming.

Fixes: 410d9ccc0388 ("imx: kontron-sl-mx6ul: Autostart fastboot if booted from USB")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index 8e35d894dae..9f7003bf54c 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -34,6 +34,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 CONFIG_BOARD_TYPES=y
 CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_RAW_IMAGE_SUPPORT=y
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_LEGACY_IMAGE_CRC_CHECK=y
-- 
2.51.0

