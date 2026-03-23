Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A2DF483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7B8841DD;
	Mon, 23 Mar 2026 20:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ms4ChUcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F2E83FDC; Mon, 23 Mar 2026 20:53:03 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E638409A
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4be94eeacso454884a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295579; x=1774900379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uv1er5CRxhp+Q4vNeNA1NKhnAH9M69ZNE1DF/9bPr3k=;
 b=ms4ChUczS/G72ISEw4klQv0rll//FgRkAtnaQhTn3KEehN5nIKKo/jXc7G2xL5Zr1F
 tOlizsJwwwgEtujhCRL0lhHLEnlOaLSCx5wjfJRDHyhR3MF0e0/KOHXpzIsR/k/Hl01+
 4KbD3Ahbtikbsz94zcc6cVKkseA8zugYf3Qyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295579; x=1774900379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uv1er5CRxhp+Q4vNeNA1NKhnAH9M69ZNE1DF/9bPr3k=;
 b=VR0/4Q/H7O+l2T4bTkA0kKyfi/B2+4HR4UB9WuifzcDmotpnA7rZoiY9FCAC5JRB8/
 IDHjacx+SOSVYqGnJVCbWNhDW6MquxMWMlha3jAv7pevEsQeweV21xub4LodZ0n0ZLvs
 67lyo7ZS1Y1oZ4uwTVV2Lxyv+LAtfOlnq76V6s1TF1uNmSjF4ppESB08mZ9d0ZoxsHNk
 4Cu6cJXXQRRHEMaKgLGWbae+8RTVXoN97wnbP/psnYHEiP9UC+7g7qCPmatxvxg0NbTY
 TiOKYWutadXIMI2Cjq/m9DKGKTvZKOGgDdk1bLZk65xuFdc6owPBdrem1r3D3dPPBv7a
 Yb+A==
X-Gm-Message-State: AOJu0YzmWKqiABqZKMad96HycejGtGRWVYkttVjzvv1uROz0zlmFCne+
 Yv+5imrj0xQemSGE937wiPemvVl2IdJTnDybCRWD1xBkp/XSspZsvpBfaKV5mE1UeAoj5T+40sE
 SCP4kUy0=
X-Gm-Gg: ATEYQzwMyUmswuKBm+JnUxb+jwwkiD4Ew+DNnhJxaP3rRBZKoCvjfuAb28WuWyVEg0i
 bIjcpJp5WA5PDg9xqFbku5XHKGnVAM2PUbnIS3vGlO1EnfeythnmOznID6C/HeD2LfATDNdT6Mz
 /3m9eBzG847Ql9kexbC/v664DJY688yQxplaS0O6XxpwOpDqpRFWUhltiJAraQMO4/AO/mMdNv/
 RMLld413ekZlq9THaO58P9hcn70YRPv7Geu7DnaWXdLnRRUt49li3lra91DIm/m+3QwbL6f9Ytq
 yK33xBuarIC9w6VeQj6mrNCqjK+FT0417bloq2s3FVz4tUXOr8ejGp3BYOw+Gm0/ONrtoZ/h9jR
 VSgXF3PQOBtNa75/9s5PQmhPhIZQqkECFcJ3MRMCjO9DWWMqIRWEBE8mcbP8Yv8KUm5h7v28neZ
 86X8wN4UT4od6EyYZUfZyd8QenntelaQP97b5YUwS13qGgXe30Bf6T1AR5K19P4ingcR1cel0DJ
 a6WZDqnNdCQo7Xb7JditNK/InHqOg8wJ0unXGry2pT/fqZekRg=
X-Received: by 2002:a05:6830:6d28:b0:7d7:cc2f:babb with SMTP id
 46e09a7af769-7d7eae42752mr9002854a34.2.1774295578999; 
 Mon, 23 Mar 2026 12:52:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eac17b0asm10213577a34.9.2026.03.23.12.52.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] input: Correct dependencies for CROS_EC_KEYB
Date: Mon, 23 Mar 2026 13:52:56 -0600
Message-ID: <20260323195256.2363513-1-trini@konsulko.com>
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

The CROS_EC_KEYB functionality can only work with CROS_EC enabled, so
express this dependency in Kconfig, for all build phases.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/input/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 5bf122c55051..df8fbf1551de 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -64,7 +64,7 @@ config CPCAP_POWER_BUTTON
 
 config CROS_EC_KEYB
 	bool "Enable Chrome OS EC keyboard support"
-	depends on INPUT
+	depends on INPUT && CROS_EC
 	help
 	  Most ARM Chromebooks use an EC to provide access to the keyboard.
 	  Messages are used to request key scans from the EC and these are
@@ -72,7 +72,7 @@ config CROS_EC_KEYB
 
 config SPL_CROS_EC_KEYB
 	bool "Enable Chrome OS EC keyboard support in SPL"
-	depends on SPL_INPUT
+	depends on SPL_INPUT && SPL_CROS_EC
 	help
 	  Most ARM Chromebooks use an EC to provide access to the keyboard.
 	  Messages are used to request key scans from the EC and these are
@@ -80,7 +80,7 @@ config SPL_CROS_EC_KEYB
 
 config TPL_CROS_EC_KEYB
 	bool "Enable Chrome OS EC keyboard support in TPL"
-	depends on TPL_INPUT
+	depends on TPL_INPUT && TPL_CROS_EC
 	help
 	  Most ARM Chromebooks use an EC to provide access to the keyboard.
 	  Messages are used to request key scans from the EC and these are
-- 
2.43.0

