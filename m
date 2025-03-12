Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DAEC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05EF807D7;
	Wed, 12 Mar 2025 19:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NnoW7l5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9D1817A5; Wed, 12 Mar 2025 19:49:11 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFCA68056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so28757666b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741805349; x=1742410149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ih3IXPyf8Ampy5iDW/nn8JqP6HtPALt7VvLXfoaQgBI=;
 b=NnoW7l5r+57/rnXHqnO0Wy98BrU+a0PZHxnNwQXJJCpMQxhzwh7FZNSkB2tKLAiUEL
 WZfMGw9lE7JKqC1uzIZRDEpDPPrl7+nt8GM50zotNwD0edwt4Jitw7fO/i1Itzr0uyZX
 SXiPXC/XmUuWJytZH4JUZHOt8YBRbL/M5RQ/48fHQVqFUwC+Wzm3KeblH7meZ6St+uZH
 ECX6U2C24Triis/nG8+YbxaSTuYnK+kiWEnAXpkDJoeDynAuLHwmnmer35vLah0gNMMe
 MXiZWQbhaUGJJfuk5PylUxQ2srrwYFVEaFNpJRYCsooyWMon2b38khS40xRrQK1u7Dlb
 79Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741805349; x=1742410149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ih3IXPyf8Ampy5iDW/nn8JqP6HtPALt7VvLXfoaQgBI=;
 b=wmzPaiOcZ54Ct5aX9F2c6bLxAmhwjpiJZtIdkdVfN9sGJyJ2+CpcBcDh7wow8JIKts
 aF9Pgxt4HeEjqDE+LtV82zCLwjtgKzpIiXyUnT0vWh2MA88SGwJtRq0H45BX3/JTqqqu
 i0+IGXGqepfLPI2BdxRwX82X3v1flnMC0cxsZ2Yq/FHPtTBpWb87jNCiwA3nKPW5TXZ3
 pHDZNXWLRSCKIci0QzpQzBPitoM+u2cse3+j66QfpzLRIWit9h94q0l36ojwvCgepzmX
 CE1wNnkbafw57eLIQva3cMbwXesaAC4cafqV3EovDEjIIBkKOUY6ilKAVQ7Pm0hef9Jj
 vvfA==
X-Gm-Message-State: AOJu0Yy+ZNbBn5pO9APpQMafGLsTZlEqsTlqAFAsB3OGO1LQTwhCD3Xi
 Tvsiamo+UDZnO1dQ61+w9G8oqAxwPSoMtsOWLk75ie/SBn2IZuihz9L86g==
X-Gm-Gg: ASbGnctNx2Juho8mopthFlcwXvIxfZV9x3hXUQarbIx8Bi+Un3KJw/d/2Yd4O7wMglz
 RlK3YKwNVLSoD5J18ZqJRb3ujb6ekovqo/DcWGsTqjkHvhmfxpzDaxvhEb1jx5ESO42RLUMJwfl
 IDyEOY0N3sn2FVpZW05NBdvYXPWzLWk1PxCH+8mIWNK9JAFgFyEY/+qI7iFliVYJuMxfhXntAaF
 gy0mQW/DdEhTvEhuTXRLuiWMYptR93o2YT/3nsdYU++GsX5As05OEMW46kQElnS0CuzCUqSDjjv
 t01l7TpBfUt5PqoTk98JpzGx52YPN/0HStBp
X-Google-Smtp-Source: AGHT+IHQGoQ1MnR/UCQldBW0XYlByIYpsusmBBPN5KUShP4lYbTOebAenFQt8pZwwicGxD8aoxkx4A==
X-Received: by 2002:a17:906:e4a:b0:ac2:64e1:c75a with SMTP id
 a640c23a62f3a-ac264e1d275mr2315024866b.45.1741805349039; 
 Wed, 12 Mar 2025 11:49:09 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac29426a87esm593250766b.87.2025.03.12.11.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:49:08 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] board: tegra30: ouya: add basic support for Ouya Game
 Console
Date: Wed, 12 Mar 2025 20:48:40 +0200
Message-ID: <20250312184843.123975-1-clamor95@gmail.com>
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

The Ouya microconsole is build on Nvidia Tegra 3 (T33) SoC, featuring a
quad-core 1.7 GHz ARM Cortex-A9 CPU and a ULP GeForce GPU, paired with 1GB
of DDR3 RAM and 8GB of internal flash storage.

With this iteration all but eMMC works.

Svyatoslav Ryhel (1):
  board: ouya: add Ouya Game Console support

 arch/arm/dts/Makefile               |    1 +
 arch/arm/dts/tegra30-ouya.dts       | 2065 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig |    5 +
 board/ouya/ouya/Kconfig             |   12 +
 board/ouya/ouya/MAINTAINERS         |    8 +
 board/ouya/ouya/Makefile            |   11 +
 board/ouya/ouya/ouya-spl.c          |   41 +
 board/ouya/ouya/ouya.c              |   21 +
 board/ouya/ouya/ouya.env            |   12 +
 configs/ouya_defconfig              |   85 ++
 doc/board/index.rst                 |    1 +
 doc/board/ouya/index.rst            |    9 +
 doc/board/ouya/ouya.rst             |  123 ++
 include/configs/ouya.h              |   23 +
 include/env/nvidia/prod_upd.env     |    5 +-
 15 files changed, 2420 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/tegra30-ouya.dts
 create mode 100644 board/ouya/ouya/Kconfig
 create mode 100644 board/ouya/ouya/MAINTAINERS
 create mode 100644 board/ouya/ouya/Makefile
 create mode 100644 board/ouya/ouya/ouya-spl.c
 create mode 100644 board/ouya/ouya/ouya.c
 create mode 100644 board/ouya/ouya/ouya.env
 create mode 100644 configs/ouya_defconfig
 create mode 100644 doc/board/ouya/index.rst
 create mode 100644 doc/board/ouya/ouya.rst
 create mode 100644 include/configs/ouya.h

-- 
2.43.0

