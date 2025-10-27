Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E5CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC5C83710;
	Mon, 27 Oct 2025 06:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zmzdyaAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F8D82E34; Mon, 27 Oct 2025 06:51:10 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AC780422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c2816c0495so3103810a34.3
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544266; x=1762149066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qvp8UEI6UzOJL8IyR0uAEqWwpJLb0vXewmexLyoAkQI=;
 b=zmzdyaAqgF+IJLHRzbQ9aSdfOtl9fEB/EPDWmJZMb6QJX8ezvECTOYU7IZIhpz8BFz
 NJCHHfLke6XUhivk4uwd7wGgThbZ31x2BoXka1YKMc1wfGArdBjAA9yiIn68STI6BD75
 qKuup7i6QHLxqugohFNOOuSiUa8YqI+7z9naKVNqFqYpTpkwKYQTLP84CGjYoDsBbqQQ
 ROzLRbcVTmgxyR2jnkrZ2sD9ddx56+/xWRMDkb0jTbHZFHA+31C7KgQTGIe+IL9TMXjE
 e3LuMsTNGA+UmPxMZ069Jcs9PoBOb3QNmi3RYdcir4G0tUl93qtHR1GShc8hBA6UtKC6
 OulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544266; x=1762149066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qvp8UEI6UzOJL8IyR0uAEqWwpJLb0vXewmexLyoAkQI=;
 b=PlfN/Ft5g7y3g18UJjj9q1BowYdLsmwOth+TicsweiTXU9yn1L7rIwUiO49GFmV2YA
 kY8YH/lk9bhLLdXbmk9A8ZZMhpEx8/d4Hdfyxke2bYPa+5E3b6VyEXnveKYdyCV0+qi8
 pvlbsb+ZVl72mQXufSOPuqQ3vKhxsvrLIBrqpf4+16Fva37P6pXKxp08qzU2YwgpGoKL
 ibh2leKJB4uK6BVLmlMPHDEMBW75Tth4Q6Sm//9+s85be4hk/1jHnfVWVqq621WrJuBd
 L/YJy2oElQkfNSGVhE/whrEdCEko8L4/9o9P385aMdMgn613mmpqEyHGLqbxLnr2Y+Ud
 JUfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAhkA9bjcdyhpSXCgAMMieIkofJF45tstnP6qPYC9bt6VzgDru5c7a6bQlOTfhUMQfrEAmPHk=@lists.denx.de
X-Gm-Message-State: AOJu0YwXWdpc2dD+1pYhzuVGB8Gnb+rOeysBgvBIJSYMzNC8jWt/OKav
 3+R5rL4m0tJ9ik/kYG57q1hcGhzTcVt71yShAWM7HBY66L0f3638edoXYK6u/pIYJjQ=
X-Gm-Gg: ASbGncu/ThG/sOS6EOSofDjvxLxaRh0nlL5sDwyeHYkK1XU8dGeprDdZxlTDiXizWAE
 ST9GJbIb/Mkq1RLYhBzoCJUESsKSJopT6g6bzUWixpcdYSL8czYGA+6CHeULHamT1vU+NO62DIO
 BBZ8In8uaI8mZv6g6X4fb7fiswuBQp4eXvMduyuY0fRhJOaX1Yn+ABbPceBIh2KslKv+v5s5gjw
 WnnBWJGGg1cJ+QLqWCK9+hDe3IDqrBFk7ymcm5cHi1uPA3G/xmDXFJq/omkQZmVcQZb2P7SZw7a
 nj2I9tVL0+Bppg20GJAE51ySi2cZgl/HnjkuxjScovxYbbRVMZintl+olt/XWWAdG6UDv4uVgld
 SlzhJXLT0wM9uA48gY2ir2JgnUJbPJOZEZ02nJJnfQccFMI1Dpqa2gwwNPyVG/oyp7VGFQtC11p
 K4gYp0Ksr57FhdF9JhHa9t
X-Google-Smtp-Source: AGHT+IFwqIi3CRTspdVDckjk4UtiOsgTBR8xNRP1bcpG+IpFfyHMsDjLGZFZTrjxQhk0mi3PCalH7A==
X-Received: by 2002:a05:6808:6909:b0:43b:9be2:2f45 with SMTP id
 5614622812f47-443a2f17cd5mr15968869b6e.22.1761544265771; 
 Sun, 26 Oct 2025 22:51:05 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm1968880a34.25.2025.10.26.22.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:05 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 0/5] board: samsung: e850-96: Support USB boot
Date: Mon, 27 Oct 2025 00:51:00 -0500
Message-Id: <20251027055105.720-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When U-Boot is executed during USB boot [1,2] on E850-96 board, two
issues happen:

  1. eMMC fails to initialize
  2. Attempt to use USB PHY driver leads to abort

It was identified that issue #1 happens due to enalbed Flash Memory
Protector bits in MMC block registers during USB boot, and it's handled
in patch series [3].

Issue #2 on the other hand happens because ROM code expects the
bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
USB using SMC calls. Before that, the access to USB blocks (USB PHY and
DWC3) is disabled, probably because corresponding TrustZone domains are
configured for access from Secure World only.

This patch series implements downloading LDFW and TZSW firmware over USB
during USB boot, which makes it possible to use U-Boot for flashing
images to eMMC using fastboot and DFU protocols. That in turn simplifies
the U-Boot development, as one can use `dltool' [1] to run U-Boot binary
during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
It's not possible when using LittleKernel bootloader, as it expects
non-standard Samsung GPT partition, but in case of U-Boot we use the
regular one.

Once this patch series and patch series [3] are applied it'll be
possible to use U-Boot during USB boot. The two series are independent
of each other, and can be applied in any particular order.

[1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
[2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
[3] https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko@linaro.org/

Sam Protsenko (5):
  board: samsung: e850-96: Keep public functions together
  board: samsung: e850-96: Add routines for checking boot dev
  board: samsung: e850-96: Split LDFW loading and init
  board: samsung: e850-96: Add routine for loading images over USB
  board: samsung: e850-96: Load firmwares over USB on USB boot

 board/samsung/e850-96/Makefile  |  2 +-
 board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/bootdev.h | 23 ++++++++
 board/samsung/e850-96/e850-96.c | 65 +++++++++++++++++-----
 board/samsung/e850-96/fw.c      | 75 ++++++++++++++++++-------
 board/samsung/e850-96/fw.h      | 10 +++-
 6 files changed, 239 insertions(+), 35 deletions(-)
 create mode 100644 board/samsung/e850-96/bootdev.c
 create mode 100644 board/samsung/e850-96/bootdev.h


base-commit: fd976ff3a233ae7c6a9f5bec790b02bbbf57bb24
-- 
2.39.5

