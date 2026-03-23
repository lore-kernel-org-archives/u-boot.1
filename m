Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7892F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B838423E;
	Mon, 23 Mar 2026 20:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R502pYbL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45AD838FA; Mon, 23 Mar 2026 20:53:04 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B47841FA
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1742387a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295580; x=1774900380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ejX4McY7GdGiFa1VvsvkEMLPmlFSVnSxwPBikVRjtnQ=;
 b=R502pYbLymi9e0KAFEocdNBX4brVnhGrl2kLVps21m+sZx5xExHLNEhZ6+5Rarnup0
 rFR6UQREthSh/kHGj0y2Pu1mt+w/O0EhpKEPUfSiy38cyXK9rMkeiuM241qZPc6fxF8F
 jKmAU0A3x0htpOD2V4n29L+Mrn2LCmm8XJSMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295580; x=1774900380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejX4McY7GdGiFa1VvsvkEMLPmlFSVnSxwPBikVRjtnQ=;
 b=O+rjRBIVzHlfItyL2juG++YaESsFxgCFNspsvKf02AmEkUbuxtKHMhw0oos7Hbu1u2
 SVlq/a6hpOnkzuSSg41uYLGX0k0OZY9x0cINcEPv7ok8P65WoVXFxqzlH13pC7+ztYOM
 jLH4qLGiKEfgEdN5vmkrWNPFtq7tTJIGkLrKjs3zvImoB1UP37iFkjxLvOIAxBX/T1sq
 NyhmNBhvCZAEbd/pPr2XsfHaSaXJDLAfKu2IJZMIWbj3qQm1XmEByZ0f/xOC6XLPV8Es
 Tq0N/6K0E3zP/VpFEFhQ4MBrgINjJVRSeDBGoNeSbL39sW+kXzwgd+tuGsGTzRCH2C9V
 OBXA==
X-Gm-Message-State: AOJu0YwMcomC0xwDKGqD4xGOycRY8JWQxfXTLlqrXV0VRrfCFlfU1iSg
 6Egvj+51ZVCmQ56MGDq5l9jJOL1eJvW9ah1TpSi5jDbawrKu5Zp3yzjmC5XJt5qj31FREbIPYCw
 Erd/jviA=
X-Gm-Gg: ATEYQzye5Qq25lK+376bIzrF/3NWc/kUKCWsGNJaAHEmOaGOBH0RE2oB0ULG/vP01qv
 wkhotjhgPyqOKi4oBW1mnKmc0XlCbpG94b4YxcR/HjeBIUawx0UGci4IYAm9Ad3Hr40OJ060vMs
 ykLWk1M4t7Tot3tY3zQJO/Y575WXqKaF9wIxUjUjQkKfan2JUtADPOCr53nKsR2xOfpho6iUnbh
 t98UKiLFjnb0QRaYh+B7NJUt+E4D+5ievj7gII7/3UK7GKkkjB06UkCWbBrU5uqDVhKx2kj1QPY
 av/zmVOm6k9qcKVdPWOOl1PEE8Q2Q9s5U6HajkGi7smXzxc9Y07Etc5y7ECS5njBRLwObKk0paA
 eldb1s1qYT1DLoDbGnQCoTu3hIuDU0TcLXDojuI6QU4kp+4u0x4d4wYS7OQ01K/NmHoRfVkJa7P
 nvTck2dsHAz73q6IwhK+UST+PM2u5l1HvZV6FUdrUc7lMGwujpHSP6ACPKt1DUnqyVJswQ/0J3a
 nylHkgIDFSMBtdcEIJInnBgcccDhAVUZ/oJqqlHMZSXyIMSkGY=
X-Received: by 2002:a05:6808:190d:b0:467:3f4:907d with SMTP id
 5614622812f47-467e5fe6c6emr8557890b6e.56.1774295580567; 
 Mon, 23 Mar 2026 12:53:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7f131b2sm7178224b6e.15.2026.03.23.12.53.00
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spi: Correct dependencies for SPI_FLASH_SST
Date: Mon, 23 Mar 2026 13:52:59 -0600
Message-ID: <20260323195259.2363546-1-trini@konsulko.com>
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

The SPI_FLASH_SST functionality is a subset of SPI_FLASH_LOCK today, so
express this dependency in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
index 56f6fb70acdf..d8f8ee983f00 100644
--- a/drivers/mtd/spi/Kconfig
+++ b/drivers/mtd/spi/Kconfig
@@ -215,6 +215,7 @@ config SPI_FLASH_MT35XU
 
 config SPI_FLASH_SST
 	bool "SST SPI flash support"
+	depends on SPI_FLASH_LOCK
 	help
 	  Add support for various SST SPI flash chips (SST25xxx)
 
-- 
2.43.0

