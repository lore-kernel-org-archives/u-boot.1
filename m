Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFAEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B368852A;
	Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZUrrUQrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D19F884A3; Thu, 27 Jun 2024 11:19:34 +0200 (CEST)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D71788247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x143.google.com with SMTP id
 2adb3069b0e04-52ce655ff5bso3947543e87.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479971; x=1720084771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R5hQIADkjh/bHxPXBdQs4aUMXloViMDVjR0ylwq21R4=;
 b=ZUrrUQrcSO0Ok7Xjmw8dXh4Yfw/hCDlHwjqy7D5afEu/LSmSwjPSw1bBlFRR1Uj2Y8
 0Hhhdl9V6YvsK9zm68OlPgaw3ozFVgW+0i3PwxReBthdCCeHfhoqhmwWFzUE2qFfZUUq
 G8q9VzsQTMijGsJppnpt3keMfhm/8KNg4GFQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479971; x=1720084771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5hQIADkjh/bHxPXBdQs4aUMXloViMDVjR0ylwq21R4=;
 b=H7RZxfFmnr/CC88iUPX1uJiDAe1ZxHHCZ6akdgq7WwfEmgZF4euS/NNDMZogTCnG7t
 tFPUGBmTA0d3w34OOQ6vpzpd/ZisgO8qn2cgF7/o4Ac/9cBdQXcaHc1tW6AhCRNbLx3N
 cOinCsU3QGa7W9xexJoJZE5CuS8lkzCyBkmZtapHGmdWF92fJ/4DuOVZz7YWIgS5gEPI
 01rzQTzCjEn0LrSGTgevV87L5R9+QzITVuVPykedydOI2NuDaIKVnwpfKQcF8gfJnz5D
 io384gdj/VXaY6TCB17nfR1XehsECla9tqdkcb7A4l0OuVZrcXcAbAjvjIYHk7joR70m
 xT7A==
X-Gm-Message-State: AOJu0YyILyySwHbc9UyJLnaN1CM6i6e0aI+3Q96SrluOet7DrxrhznLq
 MdXrpddRBhpOVzkRQxbfqedblrXzdJpMG7AiCi8dzK31JZrhxsqxKuigeUm5gsSfe3g0oeqdsu5
 Fi1Ef
X-Google-Smtp-Source: AGHT+IG3wmMBP1L0sJT1mrSBT5PGDlzWdsTlsuAfXB/ptO+oK0kJC1LKvAnCx7U6Mlo0buyHw+tP0w==
X-Received: by 2002:a05:6512:114c:b0:52c:ebd0:609 with SMTP id
 2adb3069b0e04-52cebd006bdmr9391664e87.7.1719479971070; 
 Thu, 27 Jun 2024 02:19:31 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v6 0/8] Second part of bug-fixes series
Date: Thu, 27 Jun 2024 10:19:18 +0100
Message-Id: <20240627091926.374633-1-sjg@chromium.org>
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

This consists of some patches split ouf from an earlier series [1].
Apart from the fdt patch they are not needed for the upcoming release.

The FDT patch fixes a boot problem on several Chromebooks.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240626155945.278640-15-sjg@chromium.org/

Changes in v6:
Take account of ROCKCHIP_EXTERNAL_TPL in phase_sdram_init()

Changes in v5:
- Move setting of pmugrf into the probe() function

Changes in v4:
- Drop Fixes tag

Changes in v3:
- Use BLOBLIST instead of OF_BLOBLIST
- Cut the patch down to bare bones
- Split out the refactoring into a separate patch

Changes in v2:
- Use 'phase' instead of 'stage'
- Add new patch to correct memory size in SPL

Simon Glass (8):
  mkeficapsule: Add a --version argument
  binman: Collect the version number for mkeficapsule
  binman: Deal with mkeficapsule being missing
  binman: Return failure when a usage() message is generated
  binman: Keep the efi_capsule input file
  fdt: Correct condition for bloblist existing
  rockchip: Ensure memory size is available in RK3399 SPL
  rockchip: Avoid #ifdefs in RK3399 SPL

 doc/mkeficapsule.1                  |  4 ++++
 drivers/ram/rockchip/sdram_rk3399.c | 37 +++++++++++++++--------------
 lib/fdtdec.c                        | 12 ++++++++--
 tools/binman/btool/mkeficapsule.py  |  3 ++-
 tools/binman/etype/efi_capsule.py   |  5 +++-
 tools/mkeficapsule.c                | 10 ++++++--
 6 files changed, 47 insertions(+), 24 deletions(-)

-- 
2.34.1

