Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D6C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97128799C;
	Fri, 12 Jan 2024 22:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BfsZrVCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E760879AC; Fri, 12 Jan 2024 22:33:52 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323A78787E
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78104f6f692so552255285a.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095228; x=1705700028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lB2D6uqalW6oYp6rQ2F7MG4FqQ/yRuyXZKBvlqfhChM=;
 b=BfsZrVCVPprlfSIoJEusH+HJ2KDtWhHKCIIm35A4JFBwbsZvSmgTcpsHPsuKcVc2fR
 uoTPFrZt4kFC7LaugwQGqdgoVl2VyklCxPldJUQseTLE/kIcCPLeI22w5kn6gim2Tokv
 oiu3+m58tsDLDZJRC34s5B4woZ5U3yi1Pi6h1aq/cctnBZ1DXl7XBzuBXlRLRhgvYiM2
 lDCitNK97+kYKNWQ1tHEJj+VzliEA5wdt03i01712qVG3VwD5d1/s2efbuhMwH0t/O6s
 aZzRJcAWGWTlnyFFj7zdY6n4H2k1o+nfvqJp4/CareODfi/EZo50v5lTz6in1EpVUv7N
 HqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095228; x=1705700028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lB2D6uqalW6oYp6rQ2F7MG4FqQ/yRuyXZKBvlqfhChM=;
 b=F1SFu2cHPY7Exf72gNEZuCjZ28GuJfg9AmVC0PQZP9oj+G6OHx9BmoOItV3JHHM0wv
 /naNJ067c2sVUHSEuJVA4uEorWXu7ciG5S3D6TOL+zHl/q3l6YKpUZdQ+dxjJ6i8LWxu
 RTaC+TTbLdT1oVnZGqlT9YFpQjZuHgjioXyxCGdk8cpGQaRyZmxe/qlxW5UuGeaO6CqF
 h1wkbzcLhKT3rquATC6lOb1drf8no/VQ/nwF68L0yh0fBWpCRz+X2o/lQdwWn2/7Vs5I
 X9IGWhWvRkc/Mdg95zSqQYu9XrYEQE5SmKeWX1JzSMFKbrAmr8R5CnHxq5KJgNg3TorK
 0JUA==
X-Gm-Message-State: AOJu0Yz+1Mw5knm1uZrwx343W9q9rz/I+bTCN5RdH0H4P0Yvb472T6JH
 /0mYQD+zVO+Mh/9uKg27Wlbrd0MjlBOgQhBo8hdySYTNDqI=
X-Google-Smtp-Source: AGHT+IEU3Y8QHpDJEjXnmHJaMBW2c2taHfx6tPk0cokCTRI1fVznn70yzYs0MMg8Ejlv1+1Y2fSNgw==
X-Received: by 2002:a05:620a:4d14:b0:783:3365:64cc with SMTP id
 wa20-20020a05620a4d1400b00783336564ccmr2912947qkn.47.1705095228621; 
 Fri, 12 Jan 2024 13:33:48 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:33:48 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 0/8] Handoff bloblist from previous boot stage
Date: Fri, 12 Jan 2024 13:33:26 -0800
Message-Id: <20240112213337.185460-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch set adds/adapts a few bloblist APIs and implements Arm arch
custom function to retrieve the bloblist (aka. Transfer List) from
previous loader via boot arguments when BLOBLIST option is enabled and
all boot arguments are compliant to the register conventions defined
in the Firmware Handoff spec v0.9.

FDT library function will load the FDT from the bloblist if it exists.
Otherwise it fallbacks to get the FDT from traditional way.

If an arch wishes to have different behaviors for loading bloblist
from the previous boot stage, it is required to implement the custom
function xferlist_from_boot_arg().

V5:
Drop [PATCH v4 8/9] fdt: update the document and Kconfig description.

Raymond Mao (8):
  bloblist: add API to check the register conventions
  bloblist: check bloblist with specified buffer size
  bloblist: refactor of bloblist_reloc()
  arm: armv7: save boot arguments
  arm: armv8: save boot arguments
  arm: Get bloblist from boot arguments
  bloblist: Load the bloblist from the previous loader
  fdt: get FDT from bloblist

 arch/arm/cpu/armv7/start.S   | 19 ++++++++
 arch/arm/cpu/armv8/start.S   | 14 ++++++
 arch/arm/lib/Makefile        |  2 +
 arch/arm/lib/xferlist.c      | 27 ++++++++++++
 arch/arm/lib/xferlist.h      | 19 ++++++++
 common/bloblist.c            | 85 +++++++++++++++++++++++++++---------
 common/board_f.c             |  9 ++--
 configs/qemu_arm64_defconfig |  3 ++
 include/bloblist.h           | 47 ++++++++++++++++----
 lib/fdtdec.c                 | 18 ++++----
 test/bloblist.c              |  8 ++--
 11 files changed, 202 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

-- 
2.25.1

