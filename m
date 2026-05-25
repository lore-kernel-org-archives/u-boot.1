Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001F5CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23E38486A;
	Mon, 25 May 2026 04:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="JAgALSiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623DC8039B; Mon, 25 May 2026 03:30:00 +0200 (CEST)
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9558039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johan.axelsson@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=hvjptkd5i5ghnjbchf2dredgza.protonmail; t=1779672597; x=1779931797;
 bh=qJN72wCV8kuoyZJT+Q0KmW2YxGWtEMzub+mtR7UiWEg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=JAgALSiqc6+v0u2lhPHjD75h2plaQWBY3x7nLbw/qi+rLox4Oa6DV2fc4LbG4bQO+
 8N/dykINpwSbrxuYVZI0VeNR7xCTQOhEnU6hhfukG0qZpVdaxbtw4DB6KKa6RnwgX9
 sL5U2ltWPqeTDp/MvEXO7ZjcGoXvt2xJUZ3y6zBi4aca+tExEnNTj4Zn0pR/mFP8xJ
 zOY5F3w9uyWIB+MuQhSTLwl5TkkfKTxtm0Oqup3lwHQZgMV5Oma2SxTtMzuNgYxXWi
 2d8HUmyeQvD2EjWS5N4nRyWqSqGZ0jdaSsKrwr4FBTJgQEamBdacF68wpoT0k/P0AY
 coAWnswmwRhXw==
Date: Mon, 25 May 2026 01:29:53 +0000
To: u-boot@lists.denx.de
From: Johan Axelsson <johan.axelsson@proton.me>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu,
 Johan Axelsson <johan.axelsson@proton.me>
Subject: [RFC PATCH v1 13/14] serial: rockchip: add DM_DRIVER_ALIAS for RK3576
 UART
Message-ID: <20260525012824.121-14-johan.axelsson@proton.me>
In-Reply-To: <20260525012824.121-1-johan.axelsson@proton.me>
References: <20260525012824.121-1-johan.axelsson@proton.me>
Feedback-ID: 111481869:user:proton
X-Pm-Message-ID: 553ec22f9e75ef05374675952e28a6f367f204ab
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 25 May 2026 04:30:57 +0200
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

The RK3576 UART is compatible with the shared rockchip_uart driver.
Add the DM_DRIVER_ALIAS so that dtoc (OF_PLATDATA) maps the
"rockchip,rk3576-uart" compatible string to the correct driver during
TPL builds.

Without this alias, OF_PLATDATA fails to bind the debug UART in TPL
and early console output is lost.

Signed-off-by: Johan Axelsson <johan.axelsson@proton.me>
---
 drivers/serial/serial_rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/serial_rockchip.c b/drivers/serial/serial_rockc=
hip.c
index 8a15173f238..1f4b6cadc1e 100644
--- a/drivers/serial/serial_rockchip.c
+++ b/drivers/serial/serial_rockchip.c
@@ -54,3 +54,4 @@ DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3188_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3288_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3328_uart)
 DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3368_uart)
+DM_DRIVER_ALIAS(rockchip_uart, rockchip_rk3576_uart)
--=20
2.45.1.windows.1


