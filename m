Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A768CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0961838CE;
	Sat,  1 Nov 2025 16:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFSzy3xl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0A883A3B; Sat,  1 Nov 2025 10:40:05 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA9F83A24
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 10:40:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c7f4f8a2so122380f8f.0
 for <u-boot@lists.denx.de>; Sat, 01 Nov 2025 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761990003; x=1762594803; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6tu0h17rBY70tILmRi5UNHeUAcHuRRiWbagvo7LFy6c=;
 b=BFSzy3xl3hqy5f0xqmmaMqUhFX4r55N1yK7cSK9yxFiYvnoYz3jVzcgm2iVZv0GRlL
 lyA4LstIJIX82MCvCmW4NQpWiR9mXkXJPNfo8xfD909ZHtZl/evEo2vGTZeLG1SXnB1D
 iSxhlaWJy+jt5Fj0ak+ETz8RNVBNRBqF0mm8S6cC/9u/u6oesAHsvK/VNHKGAKNHS6Wx
 ChMTypf+MCzaKoVam5orh0I7RzWbHyQ7eaSMxJFY2bPQqMwhaJdCC+XMTR+qBMVDHAvE
 9Atae8CtLiwnSyRD063vJLO5rlM+N4+t2pAkRjg8HdEO27EelonRfTtMcTGQ6a0PdYZQ
 XATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761990003; x=1762594803;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6tu0h17rBY70tILmRi5UNHeUAcHuRRiWbagvo7LFy6c=;
 b=jI0jyZp6Y3h/DmHNCh+/UbrJA04dVw8+3m8buRQ+Hy74zbHdvzhos/eaKVPtuMDd0B
 KLM/lXOV6pSlOLFi2rpUU/P3Lo/3srWqhg93tRX+tlNVGLglHP17YIgYzSnDo4LufB0A
 sRkR/iYaGQOimFlU2llSbZWsoDGoiAZYAL2FlXgFB2w4XCvxReCxzjDK5MuzV3Xyc9Wa
 IbWcYKRhJH5b/6NgFi9CGHJHTC1cQLETK2K3KjnKgnLGRz1UsbpxHPpJinvfGAX2zsSd
 Cyd4PFXwCdnpzaT4K0GlXzV+pFe+IlCHCkYwZP8WweGO5PdUM199mYQXyQeRD/YlzTFQ
 nqZw==
X-Gm-Message-State: AOJu0Yycwcbr9uVr1ntoZbVGX1R1uw32VCZtaNMeBdZk7SaOTxPTsQcO
 dVTILlq8yvdq3rhvzsjFNI3jyjh9SKchlMaqmE7c1hZNov1J4qZYAmAc
X-Gm-Gg: ASbGncu+l43XvtVxSlZhkuEVbsKZ7/0oOtazT64WYJ7dp6sqy3dvrYCQF4BAxYQD9NM
 y7ja8is0X1aRRxwZjV/iabVuv0xaGP139pRfeuV7G0LwfwGLm4HRblX9oVhoGJYHrL1DOu+ajot
 v0iOWXsPXR2tVWEpbGIBSNqO9kdtqXE+W/0WPYEFCmRN33L/m7ohmOXP9e4D5X7LhmaQ6+TJ5jC
 oEZ4g2pH47XkPIYqiYI4gnrnSY8HcGkrSwzRJo890hacalbQp0jVytxsX/asWpQN3Sjv2BO/G0X
 EXS1gapMUaJbCVW1fZCB0wYISYHZm+umt56qbLfRGpzg6LGypD8bQnf7qz803rh5bHF3rdqGCst
 3hGQ8eaGpI0nXMQj3Dk9WjIVuiRou0U0F2gP+BEMAXNKwOmQr3/VLZV0fh8gFLhUPu0IvtLiRGa
 gol+XoXOVxcqz2aXPY7xnXTxjSfIX7FJVVfgA=
X-Google-Smtp-Source: AGHT+IFe4++vT5HeWADOUQIuHmEySSUH+afMzdi754XpSgJYKurna/ZphkjLAoe4b5kdcwZ2YsXyVQ==
X-Received: by 2002:adf:ef44:0:b0:429:ba83:dea7 with SMTP id
 ffacd0b85a97d-429ba83dfcbmr5567513f8f.25.1761990003113; 
 Sat, 01 Nov 2025 02:40:03 -0700 (PDT)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c110037asm8697791f8f.3.2025.11.01.02.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 02:40:02 -0700 (PDT)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH 0/2] Fix AArch32 compilation with Clang
Date: Sat, 01 Nov 2025 10:39:57 +0100
Message-Id: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3VBWkC/x2LQQqAIBAAvyJ7TnANofpKdJBtq4WwUIhA/HtLx
 5lhKhTOwgUmUyHzI0WupICdATpi2tnKqgze+YDo0NKp1m7ycrFEbnA4Uh98BD3uzH/QYV5a+wD
 ipK7hXQAAAA==
X-Change-ID: 20251101-clang-fixes-cc08019c352a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

I faced some minor compatibility issues when choosing Clang as the cross-compiler for my target.

Please review these two fixes, aiming at enabling Clang-based builds (still using GNU binutils)
for 32-bit ARM targets.

Tested to fix build with (also run-tested on qemu arm and arm64 with clang):

make ARCH=arm HOSTCC=clang CROSS_COMPILE=arm-none-eabi- CC=clang imx6ulz_smm_m2b_defconfig
make ARCH=arm HOSTCC=clang CROSS_COMPILE=arm-none-eabi- CC=clang -j20

Thank you!

Best regards,
Dmitrii

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
Dmitrii Sharshakov (2):
      arch: arm: build: only set -mgeneral-regs-only for AArch64
      build: fix building u-boot.lds with Clang as a cross-compiler

 Makefile           | 1 +
 arch/arm/config.mk | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 62b45e82bdbf703571450e97f605893fe0d50530
change-id: 20251101-clang-fixes-cc08019c352a

Best regards,
-- 
Dmitrii Sharshakov <d3dx12.xx@gmail.com>

