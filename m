Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D95CCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E6283768;
	Mon, 13 Oct 2025 15:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="TckBxXfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A178837E4; Mon, 13 Oct 2025 15:09:11 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54147836F0
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-637dbabdb32so8271244a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760360948; x=1760965748; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Obkx4/tIWs1su35wRBPZSbH1fC8HystjrJG0MtbjPso=;
 b=TckBxXfKNZ9+lDfN9T0XSr7GVP5OibGaDYTFGlHIKs/xpauQbYNZLeH/jqht6EndUn
 Va/DJtNQx+J+KUPuWN49gvnZARJaDJcLWU9KZ4z3YHOxJJpA38hiuqaSScBL5cVTNvG2
 THk6pc9NTd3QIlLfPH83Ti3Kk3CKMzJpa+15CYOHCQ6AKeMttHtdVeNw8mD9LjHgd2cS
 x5IZaTFuQyQ51T/bcDTVlekAG/ICzYWac7UbI45nys6Fzihz7R0ZZF9vSu0LCjgtNWVm
 +xhG1S0wKeoEIMrTmHUU0tic2H7ZpVDARfSZHT711oao3AifOeeYy1ksURBgGFvOT7Yk
 zt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760360948; x=1760965748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Obkx4/tIWs1su35wRBPZSbH1fC8HystjrJG0MtbjPso=;
 b=Bc4+g8zak3q4r092PGrfDqRt8IO/4Q7pQMPz1qJlNgj0xJWWYFxr4yJQ/F22H3Nt7d
 2Cm+Ppoj8Yv+y9fr6Nb+EgAzn3v1lPJXEjFrRQZdjOgsP6RWNZdaVkfGimzXmB6T1SSk
 Y5psEybOpwVbZ4zvzDk24xTjXZj0uoiC/1qyzPDr0vYvduvwDJFrINiv+XazCpChKkvC
 GcYjTSDAiIGuLHC/EPOPTY26xPxXQ/9ptNU2MRJTpU95wEsLtuNjz69hYBpAITvU8Dt5
 xDhQVkh+Z1zv7oQ5seQFgNpwa4Hz6Xoovdxp4zL2NfAvivr18krWoQTUCVsAGvBM0H0j
 M8fg==
X-Gm-Message-State: AOJu0YysCyVSY4oOYrRjI8y2eZn953PwipCh15G4fGT0Ou9gXYmOduQB
 RLYj3Izdw8ZZbOWEs97Q4PJVAiudVPeDwrE8IOa0S73S5hZ/LgH8FAVZa13IxA==
X-Gm-Gg: ASbGncuupfXZ25eIodMjWzSEaaOFHWrRJJoL+ffNVCRL1m8SZmcsaAIb1aC+Zb3HJ5A
 9k/xcHMnj3psskkIHToUr6vqHCo83vqs5NamhFq9cPG22uYO0Ve/y9gw6L6Sg3rmxmelci+P6xF
 WF5Cs9zNahylJvO5xH+UzrZm6osAAzXvvXyIh+2WhAhbz4/cOoUNsdhDC2v9Jrk88sXccLaKs11
 FTErBp2iQaz9dmKwWETiip4x2Q32pS0gIGsJc8IKW1l6tHBW/eulkUNQdJigJYhV3y59PqJ5F1Z
 5S9J2g3EgEYOWZtG4lWWDMst9Ztc519cazdKmjJpu4hPKk7NaiGSjPAn2yyWiQJaici9UCqSSxP
 ZLmXCzVrLMFGC/Mdq4l4uohbqRe9/l86iONUtYXu5P4GcLWVZn4twYPXJFEyqwcvhsAOor2+SqT
 ljAJ4IpwP1tYPqRHGNOMoGuMuM7H6ybzTm
X-Google-Smtp-Source: AGHT+IHdux6R8KewwjoKqSyV+eOin7QEoVGHQuM+Vdj0/1Pe0KJKAZmZPgIWj9MZuwLajT6aUD0idg==
X-Received: by 2002:a17:906:f590:b0:b4b:dd7e:65ea with SMTP id
 a640c23a62f3a-b50abfd3a41mr2016626766b.35.1760360947848; 
 Mon, 13 Oct 2025 06:09:07 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d61ccb09sm891262266b.19.2025.10.13.06.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 06:09:07 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] arm: baltos: enable TI_SYSC and CLK drivers
Date: Mon, 13 Oct 2025 15:09:02 +0200
Message-Id: <20251013130902.74719-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 configs/am335x_baltos_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/am335x_baltos_defconfig b/configs/am335x_baltos_defconfig
index 5c43503ff32..93a5fb94adf 100644
--- a/configs/am335x_baltos_defconfig
+++ b/configs/am335x_baltos_defconfig
@@ -53,8 +53,9 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
-# CONFIG_TI_SYSC is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_CLK=y
+CONFIG_CLK_TI_CTRL=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-- 
2.34.1

