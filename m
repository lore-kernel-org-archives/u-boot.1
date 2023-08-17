Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD2C05052
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D1B86A43;
	Thu, 17 Aug 2023 03:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iyHfgp2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46AD186A03; Thu, 17 Aug 2023 03:52:02 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8252386A40
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bcbb0c40b1so5840907a34.3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237118; x=1692841918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LbQbI7Z25f+6JD5lVVGizMFx9IqteT0dnEjgS/o9uDs=;
 b=iyHfgp2yPQdnLeF9oUHcGIq3ofajaXpLUKTSNmVOyYp+79m7qKnB7LhKP5lQNjhpmA
 5XxxAeAUDEBKDigT3OFwedI00oomHUqyIDWJURI0JVn9fzZvDgaYzjGumGZyHukEbax/
 cANpohA2YvUaQQToYEgMw7mNQK0I7G+Wk2qks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237118; x=1692841918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LbQbI7Z25f+6JD5lVVGizMFx9IqteT0dnEjgS/o9uDs=;
 b=UP/quIVZrM23n6RZNXrTN7/368xz4iNVlsKSIRW9KipRhUw2gv6BudhnQBdr4WML34
 HDxTo+nNv+Kvrs5dKRYUlkw9GNGf/HM93dyNScklifoa9dYWkWsiOTB9j8Qr0L/ZphbR
 9AmF8U1ZyJFF0aZs/XFr/okGj/TVOHzHcP8zZSr7lBH6JIQmy/uULOrfZCcLVY4MLJit
 GXRXO8a+JtVL8QszYu9qkB20zB+W2ybGcnMVhnGYcJcdBtZbo1PR7hIvnR1pgdJNeGxp
 2qxmhWrzWB974hoVzAIB+G4ACu56hlKyh+34kCZlxvX5xwSgz17dvnprVCqjld+wTxS3
 WOAg==
X-Gm-Message-State: AOJu0YwrqOjcFC1Q2LOm016WnJPfr1caUkSNO90SfxWMGZNIcgCqmrLF
 L4AjMTBHmBGRIuHjLcWA7fstGap0e5q389yTMIE=
X-Google-Smtp-Source: AGHT+IFAQ/ZKuzJ7ja9frttd1Z7OagSxWOrzvFWRLOY8iWv8bT6qgv1tpTGwhT41Vh6iBaVph0HnZg==
X-Received: by 2002:a9d:63c7:0:b0:6bd:152f:9914 with SMTP id
 e7-20020a9d63c7000000b006bd152f9914mr3721179otl.26.1692237118076; 
 Wed, 16 Aug 2023 18:51:58 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:51:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 0/9] x86: Fixes and improvements for coreboot
Date: Wed, 16 Aug 2023 19:51:35 -0600
Message-ID: <20230817015149.774847-1-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
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

This little series fixes various bugs and annoyances in coreboot and
coreboot64:

- Make coreboot64 debug UART start reliably
- Avoid the long USB-init delay on startup
- Correct the timer speed on coreboo64
- Fix a bootstd cros bug (will likely be squashed into another patch)
- Fix the terribly slow console scrolling


Simon Glass (9):
  x86: coreboot: Rearrange arch_cpu_init()
  x86: Set the CPU vendor in SPL
  x86: Allow APCI in SPL
  x86: coreboot: Look for DBG2 UART in SPL too
  x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
  x86: coreboot: Drop USB init on startup
  x86: coreboot: Align options between coreboot and coreboot64
  bootstd: cros: Correct condition for reading the kernel
  x86: coreboot: Enable VIDEO_COPY

 arch/x86/cpu/coreboot/coreboot.c | 16 +++++++++-------
 arch/x86/cpu/x86_64/cpu.c        |  7 +++++++
 arch/x86/dts/coreboot.dts        |  1 +
 boot/bootmeth_cros.c             |  4 ++--
 configs/coreboot64_defconfig     | 10 +++++++++-
 configs/coreboot_defconfig       | 12 ++----------
 drivers/serial/Kconfig           |  2 +-
 drivers/video/coreboot.c         | 12 ++++++++++++
 lib/Kconfig                      |  8 ++++++++
 9 files changed, 51 insertions(+), 21 deletions(-)

-- 
2.41.0.694.ge786442a9b-goog

