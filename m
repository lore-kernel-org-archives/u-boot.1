Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C37F4213B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803E78412A;
	Wed, 15 Apr 2026 20:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AhfArcaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93AC84178; Wed, 15 Apr 2026 20:46:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F20840AB
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso75973035e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776278791; x=1776883591;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zYV565yI5Ng4lUjz13+m66GQKpvTHyW46Fm5wC2zN7k=;
 b=AhfArcaatVSVfXS8FN5asyLZpPdPsUOwJZjL2wo0473g73Q/26TBFYJ0u8siLW68hz
 2Af+ykCeoTt1BUUB8yNafHlBXClkZxyplHgyDh6AsRtuqOeJ30HvkuDuAvfTyANpZrxz
 gk99HC9JGdm2NxpzfejfmZtWZ9Xu9niQo8kv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278791; x=1776883591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYV565yI5Ng4lUjz13+m66GQKpvTHyW46Fm5wC2zN7k=;
 b=ql5E+HSPc5dKH9T3bT7zUgm64DEfhRuh10qD5Xd4v2qkD4YX02gU4t0W82eDv3LKp8
 KPfPrIiiaxZZVG7cH36MWZgXdyBQ4acPqR95/jMHPOPqWuk/JnhRaBKjVrCIt6kq62XO
 yTwlXWQoynCJkS1Ka5Oqwd3kEPPCgQOJgPxHuKabHBJ8Jr4Jq577uHiQtxAsmrSvh9vf
 1YXEqyPuKnhIRdrs1Y0c9Yw78b0ROy/7VbPYjvJFP329STSUnts0M8huZ0sXJNZmkhH1
 OsegA3pEsxMOsP9EqEAQTj/1GfXi7MyQATvF1xEsp3TNCE5Onn6W9CTvYgo6+E9Dq3HE
 04ng==
X-Gm-Message-State: AOJu0YyAKLZy1m8sywpN8uOx7nXDKI8sqEKyfE4eY+FS6pa8UDiQ0os7
 c4MhvpzpUXhO+lQLIr2gFRl12K1Y/+2EBQPE8akgtj5LlLCuV2WummfSrJHmkxtlPW2cOQqik8l
 n/zrb
X-Gm-Gg: AeBDieu2dZZx955kAWOEacG5NpSXhbosk/HAG8/QOfMJootHa3yI9lfyBdo3dkuIdME
 K9xRQzFxN89WoR6Pvg4u4yq7w0uZXSb3Q4alwKvBG2VAuBf2Yg91gJ73slM4yJwzivp1SJJt4mR
 bsLBaHmfPZHQLCXp/o+Z8qgN1GjSXJyN8/mzsMXEQDJrpxvdXmwm4tG2p+XjZPsKumgxuZDx8Bi
 8NtKy6fHI+OJsB8i8jU1NQNbt3ZMAjTWg7Jf+uOUe7QZe6P2MIGExmvOWMu5GlO1O6w8rMj0AW/
 Wz6hGtgiuVpS6thHt5WEp7ARzmfNSWWHwl+YWW6U0KMDL9EwwGH5bF8uuZXzZwRbeZc5FrsRMsM
 r8eHZeuP5KMy5AWKIwhfvGALhAltwvD6cMDB3g3/tCaFPlqjGvskdKmhsL9mrGFgEfKsBE2L1qh
 zAJYVHUE5bdK0//rIjkjz/8oJAycerkJIVVhPpxOgUV3ZiMgIMUPdD4se1v8yvJkhY77HjfTKLb
 CcfMQ5p1pkfbiUF0VLOJHhulbcwuM47AyATXBkRt55Qzv10wlEFF2BNkw==
X-Received: by 2002:a05:6000:40db:b0:43d:7062:4367 with SMTP id
 ffacd0b85a97d-43eb10ec745mr1000039f8f.25.1776278790534; 
 Wed, 15 Apr 2026 11:46:30 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead33d665sm7280228f8f.7.2026.04.15.11.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:46:30 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] video: Kconfig: fix indentation of help text
Date: Wed, 15 Apr 2026 20:46:12 +0200
Message-ID: <20260415184615.3033520-1-dario.binacchi@amarulasolutions.com>
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

Fix the indentation of the help text for VIDEO_LCD_NOVATEK_NT35510 and
VIDEO_LCD_ORISETECH_OTM8009A to align with the standard Kconfig format.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

---

Changes in v3:
- Add Review-by tag of Quentin Schulz and drop the ones of Tom Rini
  and Svyatoslav Ryhel. Sorry for the noise.

Changes in v2:
- Review-by tag of Tom Rini and Svyatoslav Ryhel

 drivers/video/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..8ce660804072 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -566,15 +566,15 @@ config VIDEO_LCD_NOVATEK_NT35510
 	bool "Novatek NT35510 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Novatek nt35510
-	dsi panel.
+	  Say Y here if you want to enable support for Novatek nt35510
+	  dsi panel.
 
 config VIDEO_LCD_ORISETECH_OTM8009A
 	bool "OTM8009A DSI LCD panel support"
 	select VIDEO_MIPI_DSI
 	help
-	Say Y here if you want to enable support for Orise Technology
-	otm8009a 480x800 dsi 2dl panel.
+	  Say Y here if you want to enable support for Orise Technology
+	  otm8009a 480x800 dsi 2dl panel.
 
 config VIDEO_LCD_LG_LD070WX3
 	bool "LD070WX3 DSI LCD panel support"
-- 
2.43.0

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
branch: video-kconfig-help-text
