Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5384CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 02:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C749848D8;
	Wed, 17 Jun 2026 04:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R2Z66be3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EdeN4Uo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A640848F0; Wed, 17 Jun 2026 04:42:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0D9848A2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 04:42:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gg7SL3V83z9tHp;
 Wed, 17 Jun 2026 04:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y50eKLOi22SA5Xgvfi5WsglDf1DqczYAVt6Fpml+rOk=;
 b=R2Z66be3Zk+aoxMkXTxxKIu76V71KSXnmBxA9RQHAHBR/ZrL3Hs2T+IyiZJBrzgHFI+zCK
 OvCSOVaEPrTIqq0y1aS+z22mLEpiCmnViqVUvxRAFXU0QgrUe56FRc2asK7lyg6UnLlj/V
 MFQFCa5MXLegCYBzG57U5DKa+oCz+TFWUsbjESRMFDWe7YIEa69TADRLSLvQVI6MgGWUZ/
 mx+u6CzDpvS4mEcep1Y7sgWeq7vZdYx/emUAsC5DGGKuqsEHXihiTsS1Za+JOOBdnbpGp6
 kmfwxk+tUq8KrQcP9upjIWj0uakn1HueYUaAK5AdYqYAo4tr8FmjCK+h4opzhQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EdeN4Uo4;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y50eKLOi22SA5Xgvfi5WsglDf1DqczYAVt6Fpml+rOk=;
 b=EdeN4Uo4yW6RGrtFfBAhcZcq43oOdr8fBfIiulUC0g+lWUrQiTPa6xToACW9Ykq6jeFjWZ
 DbkFTXLMZtbCyarRNYcFy3MqI627LAFAQBZja8CXc8ZmfZc+M6smlsnlHRCVn7CDotE19q
 DWVE1GJ3yvjWA8QfZqtkyz6uBE5offhSvsz/A5pOVi1TEX9k+Ir6Fa2YyZ8cdFI5diiEUY
 oUOLE8445HdsmRhCj6MkhUnois6DJTEXDOfHJ8vjKaHAA/iBXZNUQEXqVAtYlptvsERx2D
 a8VaIwJJ5LNnVoeZSW15/kAbwWiPDXy3se4fwwp1EoiGmnO8sNx/5eaMqq9J1w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Atmel with N:
Date: Wed, 17 Jun 2026 04:42:30 +0200
Message-ID: <20260617024238.152918-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kp3wsc65dadfi9rkw1zsgeozeheer7dy
X-MBO-RS-ID: d288528fa264ea7ca4c
X-Rspamd-Queue-Id: 4gg7SL3V83z9tHp
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

Use N: to match on all atmel/at91 files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Eugen Hristev <ehristev@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01c17489765..edab1622bc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -391,21 +391,12 @@ ARM MICROCHIP/ATMEL AT91
 M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-at91.git
-F:	arch/arm/dts/at91*
 F:	arch/arm/dts/sam*
-F:	arch/arm/mach-at91/
-F:	board/atmel/
-F:	drivers/cpu/at91_cpu.c
-F:	drivers/memory/atmel-ebi.c
 F:	drivers/misc/microchip_flexcom.c
-F:	drivers/timer/atmel_tcb_timer.c
-F:	include/dt-bindings/clk/at91.h
-F:	include/dt-bindings/dma/at91.h
-F:	include/dt-bindings/mfd/at91-usart.h
-F:	include/dt-bindings/mfd/atmel-flexcom.h
-F:	include/dt-bindings/pinctrl/at91.h
 F:	include/dt-bindings/sound/microchip,pdmc.h
 F:	drivers/timer/mchp-pit64b-timer.c
+N:	at91
+N:	atmel
 
 ARM MSC SM2S IMX8MP SOM
 M:	Martyn Welch <martyn.welch@collabora.com>
-- 
2.53.0

