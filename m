Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB611F357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D87F8366F;
	Wed, 25 Feb 2026 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TzG4GS6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C34083DCB; Wed, 25 Feb 2026 08:20:13 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466D182A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AC80F40A21; 
 Wed, 25 Feb 2026 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772004010;
 bh=9ChqYi048OOFkd88gMeSB4jAIRCQAt8dMrPC76q+Bts=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TzG4GS6TXiNVO9GfugggWy3gS4ArwA9+bQqbEn0HYdPtS8clCPSCxWrbhUrvcbEs0
 /wyhM54+wk5WUFuIRQ2wf3ttMAGSSaO+aEgeb5QjudlztW3WjY4EE/EzqDRQ9nJW1E
 Adex2H9YNMHaetysnGnlALbAwXvMkaq25OYvsLsJZH55evUr2Oujuhq/VAvsBmh7+B
 0whmN/nYHhItCXnQQprAZZNMTxOi4nUss3/RK/lvXCY8oSLZ63vm/C3PCp5k86zJjs
 5l44SeXX+PlNevc2S3P/oAzoymti24Td35Wj+cYHccnBjhjejdVDE/r/bDGi7YP8qL
 5Q5CZUxrAElzmkpuTEqQH0EC0RBq50KzC/z94TqyZrQkkiu8NoD16hK7Zgv5OoHDly
 Lui3GK9f+TRcipwlpzNtNYO4XmWbK5rAMcvAUkFVQDK3nGcvNXBApGeTpxR+MO73N1
 AUAmjqcksYyuQBFHgOASV7iuJgxEgRAgGgCdRhKQsJFCDjOr/fFM2UCD6SdzP9fPzw
 HQYXZawuVWet/og01YdkAo7QeKW5T+ISRvxyzZ4wTgYWUFCpvyVf06tvOQ0xYGLSn3
 DNVL7BxONH8v7fqvDnyxQN8OfWcuk56mFnTVnvH46KPmuxs2A+8AdBTKD+RGaB3pP+
 hKq+ZaCZ+hQip4x8m2qKyD8s=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] dma: ti: don't use non-existent CONFIG_TI_K3_NAVSS_PSILCFG
Date: Wed, 25 Feb 2026 08:20:09 +0100
Message-ID: <20260225072009.50434-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Symbol CONFIG_TI_K3_NAVSS_PSILCFG does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/dma/ti/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 5cec6ddd3e3..d904982c800 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -8,7 +8,6 @@ config TI_K3_NAVSS_UDMA
         select DEVRES
         select DMA
         select TI_K3_NAVSS_RINGACC
-        select TI_K3_NAVSS_PSILCFG
         select TI_K3_PSIL
         help
           Support for UDMA used in K3 devices.
-- 
2.51.0

