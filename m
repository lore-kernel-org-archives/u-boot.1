Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F8C1099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C89938410D;
	Fri, 20 Mar 2026 21:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mkkjm+bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7932840AE; Fri, 20 Mar 2026 21:53:48 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A211983FED
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-466ed3bc95eso404284b6e.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040025; x=1774644825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZILtkXVA1J+nl45kfIzeDTsADtHEUqFAn2QspYiI9sw=;
 b=mkkjm+bwVc0qqVja8UWhJoJog+VQo4wE1WeIVhic4aGBcBTJuXphxgIl6pIipe3CVA
 EPJy2rLJYGgQI23Q6UbykiZ5ztS0iNolWpvrkNwScYoEQ65lVRKCULqQnb3TD63KqC/n
 EJ8Pu2525Ni/AwlE9cYscyeb2b9qkh9ALH5Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040025; x=1774644825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZILtkXVA1J+nl45kfIzeDTsADtHEUqFAn2QspYiI9sw=;
 b=ByNhHqwoHKTqYm4c0o8I2JD3ExnjHb1nZG6WC75J60hLxwpep9VJDyYrEvUF3sYK1a
 7NEBzIwSR/zvTTFXjB9BIMqAV0OcVoHQCbiFwWW3LK3DsuZ+JcbQQF9AuKuczIjsfl66
 0B2maNtO+0ng+91Ti41cuLP7g4x4GpdUICkefJFh2CwQrX5vs2wzj41/9VKZtxIzf9wv
 s+URBYuwBuLV18srxP4FcGd40pkoCnX58fnP5vcRHbe5HadUboE9CLgYDmHX0k9Uf0Ya
 7g44L77PXEOkYVCeaGF2v2yiCJoUyVVAMd67D4It9gIjybCwcZfAsQB3hy4XCVB7SIFj
 3yMA==
X-Gm-Message-State: AOJu0YwKm1+TriuvMZIsWOP19H7gNO/i8XoC6YWytVN0r3J5NQXZY6x4
 LqH8QUiAZELIhqtjaUbDhquegO6TUvPk1Y6Wgh9fQIZUb2jzyiuL1BIr5DQ371knRAYF4DJjvur
 EUbR9ORY=
X-Gm-Gg: ATEYQzwy0dht+n0lzZ/9WVpmD9I+SApQreQjV+5u3j60QcT42GIV68Rignqa9HpLPI4
 4nZTvUcRa7wxZgwW7M6BnGU6WVeZeExYMM8MIYAyVmJrEXJkHnmPC3fYLw23e0VbQQRlNCAzh1z
 BbMFrJgVKnl2rJgfScSJ9KKp1LLWwqeNJ/iI3e8FPUQ4xdFDfz7AbWEvgXqDwLuKo4eNcepBjOD
 TmXjSz+DHTca9Hf5gR2s6thDlbabIB74Xu1+y0f4+EyYb4Ay02bodkpMpqRsN2WyyjGzRcmXOdc
 f+bAJe4IWM/y/ElOggNWTqIgOzPM4UEarPIJb+caqgQjLKWORpnGvG4ppCJy96qc2YI4xLeJBgs
 QFjG3fX+xSmAwK/J8s1wr+EQTxpDgdCJdKjkcIwFj3mteXP+gbxya0nXgQqKXIPpPeBinaV7Bk/
 JT+eRfYeOA+4Zym3vS1Bm8sbBPQ67TPO2KnuF/7kFDoCdUhszY4NnPBnIaxKjC8L3+N0z+VQgri
 rfYeLiGo1H3eTIjgH7MEkrJnoBAo5jZRszJ3zVyZrGgV0Z3MCJCuTkE1N8j4Q==
X-Received: by 2002:a05:6808:5243:b0:467:f567:d609 with SMTP id
 5614622812f47-467f567ee57mr1226969b6e.34.1774040025235; 
 Fri, 20 Mar 2026 13:53:45 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c144015fbsm3111888fac.0.2026.03.20.13.53.44
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] boot: Add DM_RTC as a dependency to CEDIT
Date: Fri, 20 Mar 2026 14:53:43 -0600
Message-ID: <20260320205343.3789032-1-trini@konsulko.com>
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

The CEDIT functionality, due to the cmos functions, depends directly on
DM_RTC being enabled in order to provide that API. Express this in
Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2fe3f4fe4d1e..f37e7a0c380b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -2040,7 +2040,7 @@ menu "Configuration editor"
 
 config CEDIT
 	bool "Configuration editor"
-	depends on EXPO
+	depends on EXPO && DM_RTC
 	help
 	  Provides a way to deal with board configuration and present it to
 	  the user for adjustment.
-- 
2.43.0

