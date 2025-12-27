Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA703E8FDD0
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 11:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05FD83AB0;
	Sat, 27 Dec 2025 11:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Xd6IFxHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9542C83B48; Sat, 27 Dec 2025 11:59:59 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5540983AA0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 11:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so3556426b3a.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1766833194; x=1767437994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cY/7RUenItFOKmCB6pG5i/ZniVxuWR6cItl5Y3ACSzA=;
 b=Xd6IFxHhlzy2+sO2hZSe24nk/awccb78AFcOpGPLdDuaKmGeerfvNjoykHgeik9rK5
 3BpqUiu04Erkfp9sM6loYvd6hS+EKTUZml3rhqsE7VoT78eyDuRzyGWuWtnQ3UaB6QKl
 ljzuo1YRBVMUkwS4cErBq/owcuZlJjgfBzUWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766833194; x=1767437994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY/7RUenItFOKmCB6pG5i/ZniVxuWR6cItl5Y3ACSzA=;
 b=BWAR5CBoRIkRdxAj1S0wMCXmtP8rJ4snUZYyk0aak6A4cBE63OTvveaQDRw6A1GP8T
 joc0/dCgPC227s1rBA4NdJ0Gr4YSwqkTK5/WUPPTxUiA6LzB6CBwi8J77v4HSeqh9Fv/
 Wo2g3tF8EMhY9n/BpkpDnOVhTch9x01pMlufIZC1/NjFZexpjnPChL9ZytMZR8IX3dLI
 vLTZvpOXWE2/nF9H8yJ6UaymtMEIrXzBQQ5FmOeYUxPEmD1GNDtivIzGrC6Imvs0ep9N
 ENY4AEas9lP8UMOyeB92hs1lXAEOx+AWBLJU/ibc/XlXXA5vL+MLIcZLxkQwB8cnZF2h
 q4fw==
X-Gm-Message-State: AOJu0YwOT9AMpomzfqIh6uzIOH7QjZu1HtsD6nJ7iYjJSK1dgsAFfiVq
 ENU1le5bFPLX/uLhdq816BEsnx4kyE1BXkmaJFMQxpIhCF1PJkHeRfH2GDB6KiGz9MU=
X-Gm-Gg: AY/fxX7rWuhP8GzHapffFxSKxcMTNfLO5UvdzwiBBXPZoniCZcltxKxb9r1KjIGRttp
 X/7cDlzhwlWHkthunEwaslbT362/7deqmc64xDH3Gafb+JNt5B5WpAeIY9+vTwEk4scioL/M/G1
 Ihd52XxOaFoYCXxKSSRzW1CueDSMoy9LcnGj6XL5sE/0pj1Jxb1OJdF8hRsE3woZcJUyr3b+Jyk
 FK4ohMoWB3Ez11I5ll73JZENxpn5mbkJF0qgCjgyvYKnkAf3cmjaWP98K3X1T1DsSr/o73X6FDX
 THE9bAcu8YmkXNxUYZMpNRl5bx/m4QhfFDfbv7UYAsXut6TLw1xxyr72vUae0hyGglOl7pf9q5C
 x/4MEWNPhrvSEPUdGslJMWTcBgRoZWjs9Jl2F9dF+7rf6eGhnLCrY3bJLX/rPL46Vcn3MrGj45O
 4vFw8titianTnJK0I42+AgotftGYYbYO3I5lddgM5DC1QZGozqsiGa+imM9Occ1kcSJRLnuj8e9
 4o=
X-Google-Smtp-Source: AGHT+IGakPoo5Yfkn/y1JiolHuDedDBQf8kSnHoVVykYf2Dn5rnUSsQb8fGiR/lfExzX3zjq53QLFQ==
X-Received: by 2002:a05:6a00:4289:b0:7e8:43f5:bd4e with SMTP id
 d2e1a72fcca58-7ff6735e580mr22828565b3a.58.1766833194466; 
 Sat, 27 Dec 2025 02:59:54 -0800 (PST)
Received: from kinako.work.home.arpa
 (p1532155-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.208.155])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7dfaba49sm24464625b3a.34.2025.12.27.02.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 02:59:54 -0800 (PST)
From: Daniel Palmer <daniel@thingy.jp>
To: peng.fan@nxp.com,
	jh80.chung@samsung.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] mmc: mmc_spi: Select CRC16 if CRC checking is enabled
Date: Sat, 27 Dec 2025 19:59:46 +0900
Message-ID: <20251227105946.332061-1-daniel@thingy.jp>
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

Currently CRC16 is not selected when CRC checking is enabled and
if it wasn't enabled in the config otherwise the build will fail
because of references to crc16_ccitt() that doesn't exist.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 4c46df0ffb87..39caf2eff1b7 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -91,6 +91,7 @@ config MMC_SPI_CRC_ON
 	bool "Support CRC for SPI-based MMC controller"
 	depends on MMC_SPI
 	default y
+	select CRC16
 	help
 	  This enables CRC for SPI-based MMC controllers.
 
-- 
2.51.0

