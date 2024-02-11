Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F3DC4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5850587EC1;
	Sun, 11 Feb 2024 18:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R1QZKXE2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BF9UxIcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB1C487EC1; Sun, 11 Feb 2024 18:35:09 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC97087EB8
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:35:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TXvqZ3ymSz9sX2;
 Sun, 11 Feb 2024 18:35:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UR8ROyCKraeKDJoj4/isb+TM8OWyseMejzCO9MViYqI=;
 b=R1QZKXE202VqonX/OjbB4u3e5WF9RNCs50HIxpqdJn45GU3vIF9cXSfl+wM+ZAHjd+xOjy
 WXhphz5sGoJV02m/jqnM01XWFaC4KeIkDIjUiVfroaehQwlZEzTsPQre0NwOUY++otyyAy
 y/QiDUAnuc3lt1V4W1cxyHghsMIC8VUpHaR31n+KXwEZ5guxS5UJTeAZb+Kt7hxNdn7PI9
 ID3chWhlY2A1A1OdvprmtqWOQvWW90xp4uZkxCsvBeOYQsHSQfaqP3eJ1/ABR7h4PRVUNT
 Jn0sZx4WlwQdDe55ldS9HSAu7+qSzPjgAbC4N0K8R4LR3ETskD8SddAih7qdJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UR8ROyCKraeKDJoj4/isb+TM8OWyseMejzCO9MViYqI=;
 b=BF9UxIcM+lym9orSE1npmTV1ZCoMa2s55/O9vjpMd77zlrXSgexEl/L+T7KIVG9Gm61xnc
 X8abT0cerVWu5n+vO+/kJ0PlBU2Ko4+DkiEJtwojvi6bofdYi6WdoYP9wMoSItEwPsiERD
 SlQDNT8Fa5dxfTmyAFe9GKg0DrD/zrGA+qLutZFyT7rUChObIUZkJ1iDE48CVao2ln98Un
 TokgUafUALyFoM7l+k+ckSIGcNTKJjBklrmNu3b5RENFXpYpGso16hypZVgntYnITB6BA2
 Xf0DI0op+3gPikSuZirPjl2YtkMN8ZXXt6kvjKDbO5fjL33jve+Pmz1K/ILc7g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 3/3] ARM: renesas: Enable LTO on R-Car
Date: Sun, 11 Feb 2024 18:34:30 +0100
Message-ID: <20240211173446.7162-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240211173446.7162-1-marek.vasut+renesas@mailbox.org>
References: <20240211173446.7162-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 765b12cea7d34ed1892
X-MBO-RS-META: nszocostx48i9kbc65xp3a1p98gshq7e
X-Rspamd-Queue-Id: 4TXvqZ3ymSz9sX2
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

Enable LTO globally on Renesas R-Car platforms. This has been enabled
on a subset of boards already, but at this point it is safe to enable
it globally. This saves units or tens of kiB from the resulting build.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6b072be2463..fde85dc0d53 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1076,6 +1076,7 @@ config ARCH_RMOBILE
 	select DM
 	select DM_SERIAL
 	select GPIO_EXTRA_HEADER
+	select LTO
 	imply BOARD_EARLY_INIT_F
 	imply CMD_DM
 	imply FAT_WRITE
-- 
2.43.0

