Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B84EC87FCA
	for <u-boot@archiver.kernel.org>; Sun, 10 Aug 2025 12:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA22282D32;
	Sun, 10 Aug 2025 14:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LF9/08a7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFDF82F14; Sun, 10 Aug 2025 14:22:03 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AA7C82CEA
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 14:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6182ea5a6c0so28903a12.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754828520; x=1755433320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P3gRcKeM5jv3hbo+ZIaK+3NypdPKh4HNR7YavxfPWR0=;
 b=LF9/08a7Pr/+C4KJ+PAYR9i4NE40TcP5QyAIYgveMfYvGUXY4ScwEyGC6OnOQcRc4x
 fzuMepBUjKw+nWrz3t0eOytNI4PFiwpcgB1Rimw9M/BXhfhBZ4IIuUN94KS/YIKPOFpY
 Jd95u2VZ0Lwci7JgeE2+L3fzEUcfAt2hC71O6nx0BLF9PiBvYHLVylTz2QZAL1W4Q+um
 Isarvd5bHd6XzA/szhxntqw+pVynm/58Irhb8R0dn9gO5MIg9A5rUVJ2kg5o/sOmJ2Sb
 ahw7CczFDiHgNa66vilqlzgTaZfHBtRk2F1eVr7w2Nfk1M5txgKKg7ioGJ5SIymFZPPJ
 B41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754828520; x=1755433320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3gRcKeM5jv3hbo+ZIaK+3NypdPKh4HNR7YavxfPWR0=;
 b=DCVPo2e8UbG0V4WDwSLeRXLPZYElSUd6zMd7EdMKXGws+HrLkbw9wo1weTdtoJLQ4F
 W5rEwaQEB3wUW1KU7OTplmHI+DgxNmgtpASWJjrxPc9quwCY44GZlDFSry9peMxabdrd
 IlK1SHzITylvpDEuhUITGtJTmItuTSWSQ6I51wNxmxMLisOC5xMHE0n0vPsnEtfvpNoR
 FMQ71mcYIQ9svf40npNubZb9uEeCL3d6i5SQnUHZuKT2N3OZlyyqTvsyd2A31Xf8dFgW
 k/HPcD9yWF8l6mMs0/jkvYngQUy6XZ/ZeJZXgy1V/kKwgLQtZ9D1ao1mqTMsRZSkIAoQ
 HkbQ==
X-Gm-Message-State: AOJu0YxoapGMIAY2Erro6qSbXUDHwGoJ7DJepi92l3bud6wgDiJ25ZQQ
 sh3GG+ASb1YTJ4XGBNhNjUqlEzMsWWmcs08VXcbkpS8vGDgsle7qNLol
X-Gm-Gg: ASbGncsCdR2Tdhbo3I5wKUeL1fgFoZzgiVuSz42CyCwrr7uCcm27HsTspn3/DM5qACT
 Tmk/IKjGVBXcnvoV4oUGCvNGjnZ1rV1EqJM+sQMy3Gd1OUf6vfOFwicXutlFY0dipjGKN4I/kHT
 4nW2/1XsdO0Pt9BKQN6yQVI3zmltVBsUlqaKdyUZ3RhVje3h7MeLgoK+PLatuOjjO2epyh2u+fG
 Zydx5J7afQQ2FFpapjnMUFCR796uaBDX0W4+wtqT5PVQFDwQpWxoZ42Q6uAsVZm+xOs3gW0165l
 2PxFl/xlr28cR0iyZKO98KviYk/AODknEFx0HiPLAUDTRskLfGd4tYNFLxAJjCKu6NtmVmCmV1x
 RmKXiCCdvqe9mDQ==
X-Google-Smtp-Source: AGHT+IHBoR6nyOiqw3jFEIUK4iRX+j/XaH3LPXmVK2ciPNJ5YgfDgo7dpxdEocuGsTuIdXIYBn0XJA==
X-Received: by 2002:a05:6402:35c1:b0:618:87:bafd with SMTP id
 4fb4d7f45d1cf-6180087bf4fmr4941026a12.27.1754828520252; 
 Sun, 10 Aug 2025 05:22:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8fe7a32sm16699647a12.37.2025.08.10.05.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 05:21:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Tegra114: add support for Microsoft Surface 2
Date: Sun, 10 Aug 2025 15:21:32 +0300
Message-ID: <20250810122133.55729-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for Microsoft Surface 2 Tegra 4 tablet.

Jonas Schwöbel (1):
  board: microsoft: add Microsoft Surface 2 support

 arch/arm/dts/Makefile                         |   2 +
 .../dts/tegra114-microsoft-surface-2-0b.dts   |  10 +
 .../dts/tegra114-microsoft-surface-2-13.dts   |  10 +
 .../tegra114-microsoft-surface-2-common.dtsi  | 905 ++++++++++++++++++
 arch/arm/mach-tegra/tegra114/Kconfig          |   5 +
 board/microsoft/surface-2/Kconfig             |  13 +
 board/microsoft/surface-2/MAINTAINERS         |   7 +
 board/microsoft/surface-2/Makefile            |   6 +
 board/microsoft/surface-2/board-info.c        |  71 ++
 board/microsoft/surface-2/surface-2-spl.c     |  42 +
 board/microsoft/surface-2/surface-2.env       |   8 +
 configs/surface-2_defconfig                   |  82 ++
 doc/board/microsoft/index.rst                 |   1 +
 doc/board/microsoft/surface-2.rst             |  41 +
 14 files changed, 1203 insertions(+)
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-0b.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-13.dts
 create mode 100644 arch/arm/dts/tegra114-microsoft-surface-2-common.dtsi
 create mode 100644 board/microsoft/surface-2/Kconfig
 create mode 100644 board/microsoft/surface-2/MAINTAINERS
 create mode 100644 board/microsoft/surface-2/Makefile
 create mode 100644 board/microsoft/surface-2/board-info.c
 create mode 100644 board/microsoft/surface-2/surface-2-spl.c
 create mode 100644 board/microsoft/surface-2/surface-2.env
 create mode 100644 configs/surface-2_defconfig
 create mode 100644 doc/board/microsoft/surface-2.rst

-- 
2.48.1

