Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F406C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F015A88860;
	Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ldcKfiZg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lmLEKhWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6447D88852; Sat, 13 Jul 2024 15:21:20 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE8788837
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy61lxzz9sZv;
 Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0inEDlPFblPbqkiW/MOinx/vEKqXPjm8hr8EUoe8WI=;
 b=ldcKfiZgQ2qsIJRDFdvGe2oxyxaY/7nHhFVLTWQN9GQcoj+C7/8j6Db04p64RpIl2ugLpz
 Qzb6CH11kV6rb6qlz+MEhqzU+CuL3qG/k0LffQQaxN89jZK4a8q6SEEI2NMaXKBegW9N/x
 qxWLQE6yKTukkk7kWRBk2e9nfCBSQ7Zq+wjeiPaJbwYESbCanTUYjRuYT3afbu70zzW83X
 cqfS48sUxEY+OwlvLh5CVS4DwY8HlTebCE5QhzbEz+FDrOLGzk/NZ1rBmnAWcUWrDgZZOv
 mfsGE3HbGaN5k45IZctrAW7LYe1iCInzngARLdtC8ZcucafZf+FR+j4MG1iNcA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0inEDlPFblPbqkiW/MOinx/vEKqXPjm8hr8EUoe8WI=;
 b=lmLEKhWaZ7e9zcLc3R6xSwah8Y7yjgiVNB8cn/UkAH4a3k8N3zrCu+yqSn8mtjJHtiwKnE
 vtoY7bMLpQAr56RxPer1WVqHgAsoToHsCVzGjEOZUhPP3Sfrf+bf3gxfpNgEthY4Q9UUvh
 KgLMQno6tjaATtoA6wuo946q4PNJmkEokrkp3LwcS8PLwF2fXzuS5l4s4KiUgkHvP83duV
 FsFEGZ5aYI6piTOc9lDKaQxpvwvKdQZcPjqIWvUjx19sEo9/Y5gfm+wc07jUiL03TsYJuQ
 WaH4QmUQdeBENAPaIj6AsuY78yI1XdRHBCxk1KRTFjfXmSV9fYjk1wPKko7VkA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/45] arm: include: rockchip: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:02 +0200
Message-ID: <20240713132021.57650-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e27e5edc06a15474c88
X-MBO-RS-META: u4a8bkydumm66e3qsytw3j9ic9nyuz7u
X-Rspamd-Queue-Id: 4WLpy61lxzz9sZv
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-rockchip/edp_rk3288.h  | 1 -
 arch/arm/include/asm/arch-rockchip/lvds_rk3288.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
index 9559813e520..edacf102852 100644
--- a/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
+++ b/arch/arm/include/asm/arch-rockchip/edp_rk3288.h
@@ -532,7 +532,6 @@ check_member(rk3288_edp, pll_reg_5, 0xa00);
 #define EDID_HEADER				0x00
 #define EDID_EXTENSION_FLAG			0x7e
 
-
 enum dpcd_request {
 	DPCD_READ,
 	DPCD_WRITE,
diff --git a/arch/arm/include/asm/arch-rockchip/lvds_rk3288.h b/arch/arm/include/asm/arch-rockchip/lvds_rk3288.h
index fb25504b12b..f4da391ba51 100644
--- a/arch/arm/include/asm/arch-rockchip/lvds_rk3288.h
+++ b/arch/arm/include/asm/arch-rockchip/lvds_rk3288.h
@@ -96,5 +96,4 @@
 #define LVDS_24BIT		(0 << 1)
 #define LVDS_18BIT		(1 << 1)
 
-
 #endif
-- 
2.43.0

