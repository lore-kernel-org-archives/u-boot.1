Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7010FFD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F5584137;
	Tue, 10 Mar 2026 17:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TPXwPGNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B24C9840EE; Tue, 10 Mar 2026 17:26:20 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893C18412C
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4671cbce32bso397356b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159976; x=1773764776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DJZ5s3YHeccnE4hyOnkmg0Klw8TSi168DsnxXu8jap8=;
 b=TPXwPGNAI8FCL7DUCzT8yd5nWsYi8zHcDZ+SrpP6n0CaLvmeOwAH7xW+jUGLHgCzmb
 1BJ4f57qXJjnVSTbYKYWXnxUVAt7RFAVUzBKSevVj+USMguqcj9e6heRkZNkCxothYav
 nnOwhzWqABvnC9CLooOfjhqesy9xms00pEq3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159976; x=1773764776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJZ5s3YHeccnE4hyOnkmg0Klw8TSi168DsnxXu8jap8=;
 b=rr0L4sd9phUxz1YCZPm3p5DzF05Q1cUIYtzZmiATWpT4I5frTupgvQ2QElP+K62eJx
 nT+WsJvcb/T2ZmZ8QBKtS1v/X5d/ooFo78CAv+MuHLdJmQ99nioItwCC5HfopsNSSICk
 PYX1Aw98wSV+d4zPBnFvUOxp1ceiNd9Vl9kqIS3p6y16spT+NWZLN/v2ybygiRsLTCAN
 aTKR52zDsMvBFlcVCHCtxsyB3RpjtkFJhlNM3L8h/8rdxDkw3zSzvCodfPqTje99pUGe
 E4lfQu2e3CLfi0WywSBwiZFByKcta8xd5wIK/IsoE52bcdoNchfFU+WrF71ZoAKDzCVy
 Nmfg==
X-Gm-Message-State: AOJu0Yxm/l85BmZMQyVQZjmBidSI4f1rEqawFpwPLFnj+k+xWqzBsQoy
 87zdPXaZ6Znk4h8lgKcTv5N0OaoIJ3UhTgNs2ShGQMKOS3OX3RKBo9lqdyb5nRa93pcpSsTbfVZ
 8tYSFNW4=
X-Gm-Gg: ATEYQzw/1U3CY1PB6R5QWsydQoZndojT/HNmzJ43bmQbD/J8tDYfwPJPh9at0ZhmDj6
 IO+mkHbbmSCmeuuhkvwueZ1nYZIrTrW0DG2aDRqO90260/B+WVlvpUwmSgR7t8j7LK+rO0/wM1t
 xrIjqruX+4ZgR2IunD70oPSMqnMYtnWpm1eJD6fdTGh1218zhaQX9yyli+xQgwxQDmQKG7V675f
 w/Q09WEQPqG/5lW8FcciCEk/+SqT9HF4tbEQsA0198qpIcYLaBTo8M/f3hTrr+y0Qb9EDorIf6X
 h/OLxa2dkfImkG7i1LcDJF/mzJLN2JnVCA7bKOl5kF5vKQ1SA0UJd0icf3I/eYKBiLp0X/mcMjW
 lAltG55FOHpD4AbBrSrRN5w3gAIcz8O6I7FmSNcA8aEyNpGR85qUqgz5LMTfAqFu4nlhzeyzzN2
 B2KpICtbsTcUsV1IXSII1btFteRnnwUmdqRob+lDlRaY6qPLrANdUwEtWcy0g08Y/1MwisrVX+I
 i5FhUk6hieQXgSR5Jy1HC+1j7oy4XQDhQTxOfx/ITB4y9Py
X-Received: by 2002:a05:6808:1186:b0:45a:78b:65e1 with SMTP id
 5614622812f47-466dcc0bd12mr7614940b6e.48.1773159976219; 
 Tue, 10 Mar 2026 09:26:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467124b3292sm3501318b6e.14.2026.03.10.09.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:26:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: Move network PHY under NETDEVICES
Date: Tue, 10 Mar 2026 10:26:14 -0600
Message-ID: <20260310162614.1163871-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A number of network PHY drivers have Kconfig dependencies on various
network drivers under NETDEVICES. This is in addition to logical
dependencies of network PHYs needing network drivers. Resolve the
Kconfig problems by moving the network PHY lines to be after the network
devices, within the overall NETDEVICES guard.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 drivers/net/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d3ef050d1a13..42c232abc001 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1,7 +1,3 @@
-source "drivers/net/phy/Kconfig"
-source "drivers/net/pfe_eth/Kconfig"
-source "drivers/net/fsl-mc/Kconfig"
-
 config ETH
 	def_bool y
 
@@ -1098,4 +1094,8 @@ config MDIO_MUX_MESON_GXL
 	  This driver is used for the MDIO mux found on the Amlogic GXL & compatible
 	  SoCs.
 
+source "drivers/net/phy/Kconfig"
+source "drivers/net/pfe_eth/Kconfig"
+source "drivers/net/fsl-mc/Kconfig"
+
 endif # NETDEVICES
-- 
2.43.0

