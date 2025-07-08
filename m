Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8735FC83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 07:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1224583189;
	Tue,  8 Jul 2025 09:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGZzgFcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4050D83242; Tue,  8 Jul 2025 09:40:54 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5217383145
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 09:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-556fd896c99so3308165e87.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751960451; x=1752565251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7GoxAQV6on5A+VLfvSHb9NPOog6ev8c/vqIYK6eEr/Y=;
 b=bGZzgFcqn4sHnjd1joT+tRg/MWP1djQ/RWzMNHtCZA1IcZfTpNuQohJQWQ7KNSjqoC
 h171ghpESVAJc1ZPl1tuq+IHCVlr2EPgbK5BKD0TMbUMFPXn1We2L4UjxPySgBlcMOcT
 vPkrqzNTbg4H51Qzd+iqjIk/Z5K+u+IEEoFC0NBDcl4xIyFk/QJGAC3vwBz/bQm+ojKT
 hM8IbGVO2EuRiJpfSqsEI3iH1cnaH7jNQF9rjlt3WIn0FHm77qjgoF8dOonA2Ti05Hzf
 0PbHWUITVq0oQFwnnMFf9IKbo6cxtY9IxZNxCmT2YUpnzJ0+6awoC6F4W1PDlBQiDSvH
 hqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751960451; x=1752565251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GoxAQV6on5A+VLfvSHb9NPOog6ev8c/vqIYK6eEr/Y=;
 b=E9uAIQ069OQINKT5vfOmAn5MMcJJJNXglb8t3qJO0TMOxAuUpAzWJKKGjYax1Afeew
 SqZBa+FcJvOuHQ3Z4v4QMp5/AymXrbPA5ZLG0KPvyY7HNyRVu9kjncFozUbckiz5SOvL
 vQOKN/QoUCSkdIBQXF4T4nQYT8IiOXiq5EtNPGLFNv/Ch1kYkmbIkySHE8COvssf9Lnu
 YoZj2ju5l9PeKuOJBIe7Hk0Gh6kUvJ3qAHK8IaMatmIzh4Vpc0uAL6TV7yCyeZbhkdUh
 hEnmitd5PE0ExR/KCm8iArAYnAvQR1t3sPhx64b7vdSrtCKoCUHjS4rADdny1zo/C2Ge
 5zMA==
X-Gm-Message-State: AOJu0YwwqQLaFJil081cHNHLvFRhvgyJ9LZZNagootvR1SAocANqSVt4
 vshDPA1ML8K/v8gfucBxIsv3zReBciQLw+xtVC54t0Wh0q8ETWkFZe1P
X-Gm-Gg: ASbGncv6epzdj5bcbOneC9TP5QqZKiM+oEWR8uyaWvWYdVYOQaAMEVSO1qt5K1YKDhh
 ePGmviKjSA3GN+SDUqgT6FcZAEIL4usWqgXz32G68UCqRfOLsMg5MdQHsSlXUWD4j+EkbnAA+2Y
 U/acP2xbuRqR3D589t/MVQg1+KqfwxBXffkmfv+Av6wNJDFBjTyt5qIM37Yk5notQAlmJ+0k5Cu
 SCm0prfKSyjEB4sWxsW/qCDd8vwXLicJEaqxr1NYL+aBXkAODFqWdstiTSMocHBOGyJ2rJmqLhc
 PXME0hBXQHQ0OGHPyM/h+VRqRSdONzz4PbjVZUD9sqSz40LO2PLA5PKosCRbR+C0
X-Google-Smtp-Source: AGHT+IG9/I23On5IpE7BhuIRTC+fMo/X0sgIvJjkZn/n91lj6nv8Tv1lJRnbtZzrvLaD/cbC895tfw==
X-Received: by 2002:a05:6512:159a:b0:553:2bf7:77ac with SMTP id
 2adb3069b0e04-557aa86bf06mr4713166e87.41.1751960451263; 
 Tue, 08 Jul 2025 00:40:51 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-556384c5248sm1582662e87.228.2025.07.08.00.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 00:40:50 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Tegra30: add support for Pegatron Chagall
Date: Tue,  8 Jul 2025 10:40:28 +0300
Message-ID: <20250708074031.9946-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Add support for Pegatron Chagall Tegra 3 tablet.

Svyatoslav Ryhel (1):
  board: chagall: add Pegatron Chagall support

 arch/arm/dts/Makefile                     |    1 +
 arch/arm/dts/tegra30-pegatron-chagall.dts | 1291 +++++++++++++++++++++
 arch/arm/mach-tegra/tegra30/Kconfig       |    5 +
 board/pegatron/chagall/Kconfig            |   13 +
 board/pegatron/chagall/MAINTAINERS        |    7 +
 board/pegatron/chagall/Makefile           |   11 +
 board/pegatron/chagall/chagall-spl.c      |   41 +
 board/pegatron/chagall/chagall.c          |   23 +
 board/pegatron/chagall/chagall.env        |    9 +
 configs/chagall_defconfig                 |   80 ++
 doc/board/index.rst                       |    1 +
 doc/board/pegatron/chagall.rst            |   41 +
 doc/board/pegatron/index.rst              |    9 +
 13 files changed, 1532 insertions(+)
 create mode 100644 arch/arm/dts/tegra30-pegatron-chagall.dts
 create mode 100644 board/pegatron/chagall/Kconfig
 create mode 100644 board/pegatron/chagall/MAINTAINERS
 create mode 100644 board/pegatron/chagall/Makefile
 create mode 100644 board/pegatron/chagall/chagall-spl.c
 create mode 100644 board/pegatron/chagall/chagall.c
 create mode 100644 board/pegatron/chagall/chagall.env
 create mode 100644 configs/chagall_defconfig
 create mode 100644 doc/board/pegatron/chagall.rst
 create mode 100644 doc/board/pegatron/index.rst

-- 
2.48.1

