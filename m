Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9874FCCFA13
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 20:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4C8383E8E;
	Sat,  8 Nov 2025 21:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E7q4wJbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5F683E8A; Sat,  8 Nov 2025 21:48:50 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF60D83E63
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 21:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so288325866b.3
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 12:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762634928; x=1763239728; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bfntuLjqI8ECA91b/L7VUtC3m667vuDWT94iW3acEg0=;
 b=E7q4wJbZsHa7ZQLRZZDxtIwWuHNAobkrwCsFjbiQS71ZSN1IdWmdXVF02uriEhRjo8
 zcXuyWFUkYqeEccMiDYKu2rlUjHd2BCiGBbm1HyPu2Gh1erVdysk2hAKS0USjH44vRh5
 1PAZRhgV7Y5Uu3luGiPIJL660IJ2npaGcjzJV3jD7suB44aYliJm0EweAxZ6Wm/1HxRP
 O3lb5+oDBhKtyJbsxfj5CtO+chpxu3cSJuQorXK8F0/ZOm8H7SlA0ryDxjN0LnDOQF3w
 9CjjFe4IZe3+ojdYTYlyqqiCJrSL6J8j64x8p3mJMi8nN3Q8fSXJW8g0bh04xWA/CWhD
 q4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762634928; x=1763239728;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfntuLjqI8ECA91b/L7VUtC3m667vuDWT94iW3acEg0=;
 b=cuNeXcspPqnuS60Ml2NN07/AIDmfWjwGwbV4OTut8755Fh4Ev6KOLqS82eh9/jHyPS
 G1an9PIbeS8+UQo0Uc5OE2Vjurgkgku1l6umDu6j9/5Un4YAH6ZFajxhOlCmfx4vRJM4
 fDI3sR5b3i9jb6U6ceHMNy6Fjns5Z3R8bY2gqpFaw7LZPBnKEM5tjHgIGMtZfCvCmEnd
 mF+6shXPKG9f9u7CZ6AOv0uIz6eZtXDRYUi/rqJGt2rm2aXmo5BE0mzLlNUNtpq+tLMe
 8CfmIfc/mgckaCRfrshp5YMkZd3PiAdqIqgR8S0/o2rR8iLf4Zg9gdHFq/1mYcrLaUBQ
 BL5w==
X-Gm-Message-State: AOJu0YxnufC4D6ccyn+ipvfcVa/AO0bpj1p1VrUBqft45dt8KHYhDibr
 UX9/Zc7HSGrj4g2S0bcgcGAOmANbPNDrcnOum06ZCUO05sjHaL3JZMXm
X-Gm-Gg: ASbGncs8bcB7Ntr8pndG0Q17NcKCoORUYgBaikUepxsrv5R/BXRcj4oWHlXBeAA20pc
 X/B4E1pzFqPEIgOrKlCq161qrcNIEQC666zIfBqjxx38SYTV1hrPk33BPjbVL6PlIdKiEIfeWB8
 dn6P2Vk+3YugswWIZdVYx11UuF4fk8n0OWm4/sfsmlNXY7MIUU01Erq0aAOpvd/mFn3FlIxSk2M
 eRXzMJPLL6/HtEv+FdQ4hODvrxqr39fref/B5bZvYftAJQkKqbFcD7nnzVp2vdKL9m/6e0X0b/C
 5WTZioJtVoZrhghx7GSi/zQnMcRig/nJJnPrkaRv811ZqOybA8ZuzWrfvCn7FtJKS7/ValSLCDC
 +m8EX1uiQ96qgyBS8+8XwRzVz6LaCdlGVWvr5qkl23jo7rjouS0njsfAIKGY20sS872/92M3UOG
 RAbghZ+IwKxi7IfEkxuBC+7Cs2
X-Google-Smtp-Source: AGHT+IFYa3bB5pd84lZg78+492e/foVOVKHJC/XtgKzSs6iBRRQLG6qawRKxXApu/CbGT0rZA6XsqQ==
X-Received: by 2002:a17:907:9482:b0:b5c:74fb:b618 with SMTP id
 a640c23a62f3a-b72e02ca213mr351382066b.12.1762634928203; 
 Sat, 08 Nov 2025 12:48:48 -0800 (PST)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bd3d1sm642067366b.58.2025.11.08.12.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 12:48:47 -0800 (PST)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Subject: [PATCH 0/2] Fixes for Clang builds for AArch64, improve
 CROSS_COMPILE handling
Date: Sat, 08 Nov 2025 21:48:45 +0100
Message-Id: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2sD2kC/x2LQQqAMAzAviI9W9gK6vAr4sHNqgWZsoII4t8tH
 pOQB5SLsEJfPVD4EpUjG/i6grRNeWWU2RjIUeO9C5h2s5jKoYqL3KzouzkGR8QUW7DvLPwH24b
 xfT8dt4izYwAAAA==
X-Change-ID: 20251108-clang-cross-fixes-17db8022e2b6
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
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

Initially fix the inconsistency reported in reply to the previous
series[1] and also make sure AArch64 images can be built with latest
Clang versions by guarding AArch32-specific options behind extra
config checks.

Tested qemu_arm_defconfig and qemu_arm64_defconfig with Clang 21,
mainline (to be 22) ce7f9f9c and also Clang 18 (for AArch64 only, as I
have not managed to build an AArch32 image with clang-18).

Please review these patches, feel free to suggest other parts of the
LLVM/Clang compatibility task I should take a look at.

Thank you!

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
Dmitrii Sharshakov (2):
      build: fix prefix for Clang when CROSS_COMPILE is an absolute path
      arch: arm: fix AArch64 builds with Clang 21+

 Makefile           |  2 +-
 arch/arm/config.mk | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 928af44314a1a086e946ef3c0901d40bdb3e19a9
change-id: 20251108-clang-cross-fixes-17db8022e2b6

Best regards,
-- 
Dmitrii Sharshakov <d3dx12.xx@gmail.com>

