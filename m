Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B48F30283
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EE58444B;
	Mon, 16 Mar 2026 00:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cwj6i6Ie";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LLuWGUb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B848445A; Mon, 16 Mar 2026 00:51:56 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF9384440
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fYw4B1DTZz9tQm;
 Mon, 16 Mar 2026 00:51:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RIUvFR8YZl9m64hai0iK4kZqX8dN742W56i7CX3xCDo=;
 b=cwj6i6IeNZ0b7CAGSIO2W3rYYzEN5BiHk1mZv7ivEhZcr/Hd3kbjOeo6eKNE/VPLDS4jdu
 s3ZiThBv777pqCKBbkdgsMpyYOYyPMDe/3D0n0sHrEUpuAF+JVMgfu/0MBhYBmdBjOxMqB
 Dq6J5Bq4epoPu7BAw1FjmkFvwCffnkXMoZgGlNjuoJyRLtUpIjICn17s2AbYzymdw87wzL
 F6EjferPkVvU5gOrzzy7NUhxZFIgeX8omscFVH/D/2+WZMH0N4IkVH9N30O5v/It5mWgYn
 CbOBjeOIQPgb/8PIyZNxlEBHXZtr4b9bn6GrdaEq4RyqwoRt3DdunJ0HNm30QQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LLuWGUb3;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773618713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RIUvFR8YZl9m64hai0iK4kZqX8dN742W56i7CX3xCDo=;
 b=LLuWGUb3ERRTVkXxPLgv6xvBg84aqfxJUoffy42/I3sm3G9WwEKZPYz6iPz63+/8T1Q80l
 SkufJ/QtywUEpNJPQZy+7ZQ7M2dlEGaLzsze2QQNzZfGIskzhXxVF7seSlyNEcO3lw0xxf
 Z55oKBaDFtrmmW+DW1zxKfTjS5G/hwDt6KOfx+8vvWhE2rzE/FrFpIolS9lzz4S52U846d
 CJc2/UilfxB27ShvUz6AYrxcusBUEosJ8plr6yU/c/IAEEwCSeE6pOSZJeT+CaV6Isg065
 f6/+PP+KihAG3uWMfuePCdoKg1SfvLu7V8yeb6EbTFfn3V0m9evYEN7uOw7gVw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: renesas: Enable modern HUSH parser on all R-Car systems
Date: Mon, 16 Mar 2026 00:51:35 +0100
Message-ID: <20260315235150.304538-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1457e92fb5d2ce685c5
X-MBO-RS-META: cb7uowk9o1mrhjk3mcst1jar651u5xdn
X-Rspamd-Queue-Id: 4fYw4B1DTZz9tQm
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

Enable modern HUSH parser on all Renesas R-Car systems. This replaces
the old HUSH parser and includes matching updates to the command line
parser. No functional change expected.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/renesas_rcar.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/renesas_rcar.config b/configs/renesas_rcar.config
index b3107d79b0e..1835eb1357f 100644
--- a/configs/renesas_rcar.config
+++ b/configs/renesas_rcar.config
@@ -21,6 +21,8 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_FIT=y
 CONFIG_HUSH_PARSER=y
+# CONFIG_HUSH_OLD_PARSER is not set
+CONFIG_HUSH_MODERN_PARSER=y
 CONFIG_MTD=y
 CONFIG_OF_CONTROL=y
 CONFIG_PROT_TCP_SACK=y
-- 
2.51.0

