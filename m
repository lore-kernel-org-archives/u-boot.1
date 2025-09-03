Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE50CA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 11:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D15834E5;
	Wed,  3 Sep 2025 13:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O4YR9fZm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kVX+aKuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44C5835B3; Wed,  3 Sep 2025 13:24:25 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B70833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 13:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cH0cl4zGGz9sly;
 Wed,  3 Sep 2025 13:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YREub5UZnJ5yXTAaJv2pSHOlCYvy4si9uv/DiTndUNw=;
 b=O4YR9fZmkKLaD+DoueNv1NWbJqar9H/TFUoWTJ1i3Qty5Oe+DJji9dIh2G6yDCXSyOjByv
 E1nvPjlAf4ZVSw8PWRf/1p27oAtVIlvFdT8u7340iBmjTf9Zwfi/ZigB2lhx7/lK9PvSBH
 5PQD3XwtCx2IRQutsWJZfNuZENh794vpHCPyorR8oBTm/k5Mdcho9HaGRJ/BUwmYmduOZc
 9pqBCoAzm2xhy1rcry/LbPVAS5/E73DE9+RiZ0YcKmpjR2w0jNTiex6w3lnQ5yTBqLvd8/
 iLsB0sOBpsO4mNzENmzdYSioCa8vsSfH+hwN0/RIDef/K3BRil1iJM6iTjBuxA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=kVX+aKuU;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756898661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YREub5UZnJ5yXTAaJv2pSHOlCYvy4si9uv/DiTndUNw=;
 b=kVX+aKuU4oXMDlxj7U1QujTSPYXdz2rd8nTwalDSJfs0PSUydolOOY8CIF8PDPYYYCOHKY
 EwKFhYKwIAI1fdXfcXEV4Hn4gE0T1hZ7gG+c2bK6f2UMCjijJsZJ5EBGNF23eXX3V5aKHW
 Ibkdl/W4VfwmcrNEh7la/rJzzviQb1dPufx6qieGBOC5sMFFN0emHW3FP1YBbE5r5WxWrq
 HuYTmXi94VtifoDRjZyBfV9+Yvcw6LinV+6yn6gQ7jOUIyPSbt0QIOXEoeNy9KxXPlo6fr
 urT+Ap2SINLjmQyJif92I23oehBY7PfmUZRtlfjXyenMF5xPPFrBaJKnnwtlbw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Enable CONFIG_ENV_VARS_UBOOT_CONFIG on all
 boards
Date: Wed,  3 Sep 2025 13:23:57 +0200
Message-ID: <20250903112411.48647-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wdwehn64bht1dwm78wm8oypmzxuhnwbk
X-MBO-RS-ID: eaeb977c5c82f9fe727
X-Rspamd-Queue-Id: 4cH0cl4zGGz9sly
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

The CONFIG_ENV_VARS_UBOOT_CONFIG extends U-Boot environment with
variables arch/board/board_name/soc/vendor, which can be used to
discern different devices from each other based purely on U-Boot
environment variables.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index db5846e992c..45776be62ea 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -18,6 +18,7 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SPI=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_MTD=y
-- 
2.50.1

