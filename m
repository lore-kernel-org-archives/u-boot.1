Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A71C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E658129B;
	Sun, 30 Mar 2025 11:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FMj0snHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261E381DCD; Sun, 30 Mar 2025 11:28:35 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D2480F9C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so593608066b.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743326912; x=1743931712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NKYC0kQa18f/AnqPByqhtAl/dMarHjffJH56RawejpI=;
 b=FMj0snHbSvSWgTvBarEpHPRs9VgennVd05Ppn/SWkyf0J+9rRsyNulmV51mOaxrp9k
 VHhsC0FzgK3jgd6egduUdJHq3LAeD0ozZ52WWHssOg2jXspHlFWBqumJIPEywiYjfIgN
 VTgi6HlfwiOKsmWAnno5r88HxOHH1lEbErhmwbd/Vjv/GYss6l4btpKfWxVE+gOxwYfe
 feLvoPfobcZWxS9Hg2SFFAYXymsqfqMUC2Fxutr2ZOjprUYe4TTpIyJLIrPXLv2N/X6I
 BLEY/jlYUCPE34cL+ckSjV4GWiT880cZzGJpP1XV+wpU4Bp8hq4DTX327I2QydJHMrfh
 sWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743326912; x=1743931712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKYC0kQa18f/AnqPByqhtAl/dMarHjffJH56RawejpI=;
 b=mN5myg7brxWsMgs8s78CwnLWlWMvOhq3oWk4yzprTcmCYsSB4uFk71PpdXVG3vr/Fg
 ZyAi7kDnYYqdhSWwkkcyU3No3xe2DmmuNLUkBQr9Q7OesVcWUEtimhPaE/FSLWFzetff
 q54WjjhWGB12hMSeMxm4ngB9ZDoTiuWcBnLiaM2gjT+0NWLKdQr5tO5FJJirC2Ph3lTZ
 45VulOAdlCCpx+PqVWdeWiODTKQS5Jfi8VLVBkk+3vU4KWM6iTW4dqcvfVsX9862N+nT
 CjiNvh6VfKlXRz6QZ3bMTg8vc+ukRbK834qWOJjePFta1eY9vIeQ1ppGCdY0spHbF5XC
 QBGA==
X-Gm-Message-State: AOJu0YwduuNehJKwZu3/AbOQbQQfbONCSGTYS2N/i3D57HT4Vr4+6kNM
 N0VZY0jYSS+KzIwKWpzhd+bAiMO5V2elLnPJwkrMWN5WE/hYZfXJ
X-Gm-Gg: ASbGncveQDBVY8Pv2OIuOh29iKj46cAI7CBqLVluybEm2loGT4TrdU0SAEbbUTiL+2w
 1MLU5S1vUWHicd7ZFoJKIkvD274zkt7Nhe2qYAv749AH0G/grGrjQVepri5p+WhR/DiN1Pj3eo/
 DyaASOr+Mxo8QkIYj+t3mGvi0r/ONHAhrzY4ekw0zjOocrSTy00u8pvsRGfQIWm2jYAvpKJDr5K
 aqXDJTNTOmacHcvMHkhneU6XjwEr+8t7QuZVyQZn8jAU5G/13N6vIcsGmpex46ncJZ/8IQrUzjZ
 BKMv4YeQE8BSVta8C79NUiGAoXknQTLDzw74
X-Google-Smtp-Source: AGHT+IGlCR0nqkNLgc15cO8Jv+c9cP7LgoVMQz4YOZ7suwjQlfmnMozduMu6POI4PqdowLbWz7koPQ==
X-Received: by 2002:a17:907:720e:b0:abf:7a26:c47e with SMTP id
 a640c23a62f3a-ac738b61ec5mr438356266b.43.1743326912365; 
 Sun, 30 Mar 2025 02:28:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971053csm455653966b.178.2025.03.30.02.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:28:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] sysreset: add PHASE_ to GPIO reset and poweroff configs
Date: Sun, 30 Mar 2025 12:28:14 +0300
Message-ID: <20250330092815.10350-1-clamor95@gmail.com>
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

GPIO reset and power-off functionality depends on device tree data, which
is often absent in SPL or TPL. To address this, incorporate PHASE_ into the
config option.

Svyatoslav Ryhel (1):
  sysreset: add PHASE_ to GPIO reset and poweroff configs

 drivers/sysreset/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0

