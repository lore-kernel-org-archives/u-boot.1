Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01229CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 19:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3D483B9B;
	Thu,  6 Nov 2025 20:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tw9uwEoU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p7GHOwJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD6883BF4; Thu,  6 Nov 2025 20:13:47 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D1083B85
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 20:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d2X0m2jhvz9tqK;
 Thu,  6 Nov 2025 20:13:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762456424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rqZmpVlzJ7EhoBjpXxvqALMjbSHx1VGSgBXY05SJfDU=;
 b=tw9uwEoUi876q6VuhMCH60P+zo63Y/E/WmaaQ+cO9qMTry2Gc+PFT5f7qiH1i524q+/j0m
 /zBFJqvzc7if2zfmwzd03D5cRqyZwmVoM5RaLRH15YAa8Uzq+Dibh6cm3E4vEdpzzDohpQ
 DFYcnlJfS+x40wD+qyJBCbd+DbQq0URhrvCmkVs9C5B8gTlwT2HWrdFTqOZRIQdsL98UYs
 nAmhCAc6OREBpcVBccm46Bcxw8HmLkkP0yzjz3TlyE9DI8P9uzQikOtRr06elcSVM8EPAq
 b+kJWtNd0jfIBYGTnxchD78EbeZ8/KKCzFm59DrbwhCiZmJEWl32eGG5ueneoA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762456422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rqZmpVlzJ7EhoBjpXxvqALMjbSHx1VGSgBXY05SJfDU=;
 b=p7GHOwJl+e/chc67Fh+dZb1DvZP1E2tnU89CAAVwDF/X+EUP9/yij/n8hivy+8b3i20DGr
 rGNLppEvYvVKz3H81GR4IMzXOe0xHebl4QD2UdzFuYfEEdoJfTvsQS2+/eeDu2EQTTIEhK
 6mmrdq2AfLEQ9QjOAiDPkpHCkPf1dmb5BCYz2UPztjK5VwmfoxEkiUQCifh51qIDm/Wsg5
 lG8ThvM4+EbFz3wOnCTuWs5LndADqsr3iV90qlsACnqLhROKOjj9c+h4EWBpjwGclxcMnR
 38hbIse9ylNtB7qNwMXvxPJsVDQzgaf/SZZTUPMOLgHEvvj6bWJC79hX2JCCxA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: renesas: Disable CONFIG_ENV_OVERWRITE on all boards
Date: Thu,  6 Nov 2025 20:13:24 +0100
Message-ID: <20251106191337.14884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a8c68aacab3fe0c286
X-MBO-RS-META: mc45dw5nbg5q8j7eubh9micyasisarfe
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

The CONFIG_ENV_OVERWRITE allows easy rewrite of environment variables
like 'ethaddr' and 'serial#' without any protection against accidental
removal of those variables. Remove this setting to add extra layer of
protection to those variables. The variables can still be overridden
using 'env set -f' (force set) if really needed.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index 45776be62ea..d9a99e1f428 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -17,7 +17,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SPI=y
 CONFIG_DM_SPI_FLASH=y
-CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
-- 
2.51.0

