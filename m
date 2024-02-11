Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB2C4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C65587EBC;
	Sun, 11 Feb 2024 18:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cOAmBjKO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cjCJ4sY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D378C87C4D; Sun, 11 Feb 2024 18:35:07 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E40D787EA9
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TXvqY5r1Tz9sTH;
 Sun, 11 Feb 2024 18:35:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lY9GALBkA0KACOusmC9dOJedry2jbEekA94atY17BsU=;
 b=cOAmBjKOTBL1na4j/w9DAn3+0H520c2yxwuKFvG+376EgKXaosRRspqetVLvqoib3AcJvi
 wy2NEKuEadcEQWZwlFh4VNBqq7XVc2GR7HN99zrQU/LV4Ix52F2i023Om0E4LsV3XEZqSY
 /N84YzRetq4HgFvKL0nnB4haRPwFYGxCXpHYauEEPXIsu9aSbbNRUjSSxA/vo8Ddxw9WuA
 w2Oequbo6AASkD3oDdr8I5NRwrKUHj7XdsyYgdKSMXAuZtGd0+vXfm/Mr389L+zVCRM2LF
 ctZMDhci8a5s1Jz72BhDqnwtBl9fK8YE9ELliPM4q6b7Vda1wuVqOofBFcs03A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707672903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lY9GALBkA0KACOusmC9dOJedry2jbEekA94atY17BsU=;
 b=cjCJ4sY0w+RZEhZBKzLl2YML1RHGzd0klTw3eHnevxBm9SoSpufthS1H/FnkfFKdFtK+Tf
 xmtm3Wf31atXdMAWs5+UUi08gSx3vc7XUkNfAjue3rx9sFYYDnjJxZ3SCmZCmdbZfJ1xhu
 TDH3hR3U+Ck4YhvpspaD1VEw3RgGvaeXWCXLIHtRAZZ0tL/1wew5OAUXITBPKt4BOVNOrZ
 yQCmzj9EyISGGKlJvGEuHBOTQtTrWv4jkTpTRV1IC89nW24XZ+9j0RoF+R7E7/bt9r2/NC
 N3vYFcRy0pkmOAH9tvJNXYR/gN4M/WujCYU4o2PvChIa9JmueXlXhTLjf0dFAA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 2/3] ARM: renesas: Set R-Car Gen2 board size limit to 512 kiB
Date: Sun, 11 Feb 2024 18:34:29 +0100
Message-ID: <20240211173446.7162-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240211173446.7162-1-marek.vasut+renesas@mailbox.org>
References: <20240211173446.7162-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 95750bd8a9acfecfdaf
X-MBO-RS-META: 1drkj78tamezr7bcc6m9p5nt1dbdw5rs
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

The maximum size of u-boot.img on R-Car Gen2 is 0x80000 or 512 kiB,
set the limit to avoid overflows as new functionality gets pulled in.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 00ed1ecc173..5710934000f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -500,13 +500,14 @@ config BUILD_TARGET
 
 config HAS_BOARD_SIZE_LIMIT
 	bool "Define a maximum size for the U-Boot image"
-	default y if RCAR_64
+	default y if RCAR_32 || RCAR_64
 	help
 	  In some cases, we need to enforce a hard limit on how big the U-Boot
 	  image itself can be.
 
 config BOARD_SIZE_LIMIT
 	int "Maximum size of the U-Boot image in bytes"
+	default 524288 if RCAR_32
 	default 1048576 if RCAR_64
 	depends on HAS_BOARD_SIZE_LIMIT
 	help
-- 
2.43.0

