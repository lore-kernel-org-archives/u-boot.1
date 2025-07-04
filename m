Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923D4C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D432882F00;
	Fri,  4 Jul 2025 23:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DwdgVVY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B0A82F6D; Fri,  4 Jul 2025 23:46:01 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F8982063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7382ffcb373so843467a34.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751665558; x=1752270358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1q8XVKm3SFIqu3ggHdK30uwYY0ZOUh3OWurnYiENofk=;
 b=DwdgVVY15i8LTv0IPFfVtSV/Eu7xdPzIYJdVEM5sYBba+iiggzYdEvmwFu5u4VR/WQ
 7M/RlASucpDLP0BxNvS+C1Pqshdai87ESvAk4YgoRgWBukm+O9zkEqFqADdncU+EjAKe
 No31o3jPTF5qggkWDNC+eDV50WP7MQX/gxOMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751665558; x=1752270358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1q8XVKm3SFIqu3ggHdK30uwYY0ZOUh3OWurnYiENofk=;
 b=t5+gez0wFAKNt97dEyMrwGIf+pu+AmHUZvb6iOeKlGthUOfMCias+KPzCO6w4eeYF2
 B1gwQmEJzfRALvCXOTX6po7aEzmMZtrk0TuOMrJL8DYNUwN8yrd3QjIP/SgRa97qZufA
 tk43ncjyvxGYSyQKfA809acDEj/k+OLCSPKXDRDKzDMJreqILAgBfL8/LoCGIFFfDEy5
 9UuklB6hA0+/mjBAVGZ5ltOjiJGZN/gigOkw1qwYuhk9pdK+N9XPBSgfrM42d3GEIVbx
 QkGqfNdjXEZgJDZVtWsqHEmognFVDWvfRIX47SxONegSeTCqhEezcAgAXi1eEXGlqlM8
 eOow==
X-Gm-Message-State: AOJu0YyJP5XB95AjcURsp49KwsWaPMjhkwO06qzPkDDoSxVZwVlV3+IB
 t37CNUWf5v5la+TnGGjVCk6V7RnXMyv3JpzbOOGFACm4BgJAOrhr008i+HFUJocdAOLlNlUMueB
 w5kF0Frs=
X-Gm-Gg: ASbGncvG6NEsDMbgCcnUG89xSDq7YIjG+2ZwdGhrQdV5if4zIKfM2Wmjh4q78bKjowp
 Es8SeDLEfOnmvnP56p58JcjxqZGnidFubsEkp3tTGMi+FXRMmuU2tdAVb/Cii8YOfVYLxF8UcBz
 oGdI5lcq5z8nt9RKX0PjAZQpTYEbWTi3G11uen1my98JHVkwEa3WdRFckWlGvohlrb/CfG9FPC4
 UT+fDCoUNOZgWPpqZXskRHXPta02a3AnJPA9PMTCXfACVDUfx2UulEaT7trG2Myz5A9NaPn1atR
 j0m/XSeS/CvHDw7Qpz8UyaWJEbLli6ayT7+tD5VEsE1wEn4sab7QSFqNfU5Qn9LIL8UjWTbf8nr
 orM8bhYXnPMg22baaSVQX1/A=
X-Google-Smtp-Source: AGHT+IEUfhWwgtpTRh9Knzf0NA59/E7v4Dn5PCE+Yo/5l1Djr+zxV3unlEQ6RN9dQTIw4LQRpZhlFQ==
X-Received: by 2002:a05:6808:6f88:b0:406:6f21:8161 with SMTP id
 5614622812f47-40d2ad81ca4mr190012b6e.9.1751665558046; 
 Fri, 04 Jul 2025 14:45:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02ab28cesm431230b6e.27.2025.07.04.14.45.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:45:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: Correct dependency on SYS_FLASH_CHECKSUM
Date: Fri,  4 Jul 2025 15:45:56 -0600
Message-ID: <20250704214556.3418849-1-trini@konsulko.com>
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

This feature requires that CFG_SYS_FLASH_BASE is defined and this in
turn is only done in the case of FLASH_CFI_DRIVER && !CFI_FLASH or in
other words, when DM_MTD is not enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 2b7f5e5ed7ba..f561b07e40b9 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -166,7 +166,7 @@ config SYS_FLASH_QUIET_TEST
 
 config SYS_FLASH_CHECKSUM
 	bool "Compute and print flash CRC if 'flashchecksum' is set in the environment"
-	depends on MTD_NOR_FLASH
+	depends on (FLASH_CFI_DRIVER && !CFI_FLASH)
 	help
 	  If the variable flashchecksum is set in the environment, perform a CRC
 	  of the flash and print the value to console.
-- 
2.43.0

