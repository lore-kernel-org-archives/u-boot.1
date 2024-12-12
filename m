Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA387E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 302A680214;
	Thu, 12 Dec 2024 11:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/rbz4uQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E019780212; Thu, 12 Dec 2024 11:26:08 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D842D801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so564827a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733999166; x=1734603966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9h54Ise4N7qkCGYW0oBoLQcFq5FzwBRfUlWHThAIzuI=;
 b=g/rbz4uQoTz6eGQf5Az4TXs0GhZeJW4mukDJxCAhmTVxKZaTICQkIcOvQywQdIxfBV
 Hs9uRyXI5RWw6DIZn+HMoCL8dYDAI+Q6kED9aVxTEQ9saF151my0hKPxIeviPs3qFKlI
 Dgi+t+g7od3q8LRF+/QUPjK9hbiylx7uJQMECKb8o3Qs5J2EQY5wb37l87cuPiGcSGFj
 NEtSKNuE8agmqxDrbKYnr3C7F2nLIaJOu9Oy0oFVc05VDMedIomTUo+W6Wo2t/ms27pQ
 Q3K0T9StMKd8hX463Hn0vKGeV1vPhMfXyCQjfSkzkoVqZSsG0IVeXw+d7kw9/+4fQvMV
 XUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733999166; x=1734603966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9h54Ise4N7qkCGYW0oBoLQcFq5FzwBRfUlWHThAIzuI=;
 b=msC9vOWi5BdHNT+d0osOlGYBnLeNCPoBuwgKuiF/Rv0NW50R6wtgVK1ZPTgSz9Wy3H
 jta68IRKIknNPtUPg0t2Cy7jGRLezOpHRXmCCjL11/bwORwU8yMjSDFhofNQEPeySiC8
 dPiXs0AZbmdlLjx8rwaY2fbP7/yepbqo19cquiy2NKYr+CphCGuGv/bNBbheLCq+HDBD
 le4v1psNTV8IzsnhndYw6qleg2atUcAxja7ndh/5otBf0LRCa9mNgyfgR7qCQF71NXeR
 MOUB8iUPhdtaHbj8ZJJjgnu+aNVf3mihmkghK8xH3kiPeFQNJ7J7CS2cU1YbsemRxWTq
 K85Q==
X-Gm-Message-State: AOJu0YzlAlhYOrg8JaOAnhWb0vL5L/Y+sC3nKlne6gwPWJjeYOF1yEbO
 tbVJ092KgtAz6ABtybhXEUYfSHj4kvCam/75WT2cg44Xe2w6tCgg
X-Gm-Gg: ASbGncvYVGk+vckZ7Z0mKBShSAeOe7I5Hn5rM+I9zoFpBSTAr7bz2CObkq3IOk0DunQ
 7LsGDSDyyxtggB9cQ3fUW/i35+oP5GYed3qD57x3PYH4bfP632dLio2oR367T6gC3GttrYva7lr
 IrtzZrlQBBtTcym58DiY3ZXSfQiJQF7F54jkAX2EAcDYBXmpuHJDa3janenLzc1IYE1BWuVjduf
 1eKqhYkC8kpljjMZBOgGt6JCpCHrDgdxcRVmLMwzv/4TaD8
X-Google-Smtp-Source: AGHT+IH4qqh9U99avpQphcVOW8bEqDbhd0bgZChO5FDGIy1kW5hvR7xVBTCS1UrhMuBXAlEqX/zTjg==
X-Received: by 2002:a05:6402:3586:b0:5d0:b60a:2ff6 with SMTP id
 4fb4d7f45d1cf-5d4fa1b2fe9mr602188a12.22.1733999166110; 
 Thu, 12 Dec 2024 02:26:06 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d3f4ecdd02sm6172037a12.81.2024.12.12.02.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:26:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Tegra 4: add support for Asus TF701T and Nvidia
 Tegratab
Date: Thu, 12 Dec 2024 12:25:54 +0200
Message-ID: <20241212102556.6891-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add support for Asus TF701T and Nvidia Tegratab Tegra 4 devices.

Svyatoslav Ryhel (2):
  board: asus: transformer: add ASUS Transformer Pad TF701T support
  board: nvidia: tegratab: add Nvidia Tegra Note 7 support

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/tegra114-asus-tf701t.dts         | 1256 +++++++++++++++++
 arch/arm/dts/tegra114-nvidia-tegratab.dts     | 1050 ++++++++++++++
 arch/arm/mach-tegra/tegra114/Kconfig          |   10 +
 board/asus/transformer-t114/Kconfig           |   12 +
 board/asus/transformer-t114/MAINTAINERS       |    8 +
 board/asus/transformer-t114/Makefile          |   10 +
 .../transformer-t114/transformer-t114-spl.c   |   42 +
 .../asus/transformer-t114/transformer-t114.c  |   57 +
 .../transformer-t114/transformer-t114.env     |   15 +
 board/nvidia/tegratab/Kconfig                 |   12 +
 board/nvidia/tegratab/MAINTAINERS             |    8 +
 board/nvidia/tegratab/Makefile                |   10 +
 board/nvidia/tegratab/tegratab-spl.c          |   42 +
 board/nvidia/tegratab/tegratab.c              |   56 +
 board/nvidia/tegratab/tegratab.env            |   15 +
 configs/tegratab_defconfig                    |   82 ++
 configs/tf701t_defconfig                      |   87 ++
 doc/board/asus/index.rst                      |    1 +
 doc/board/asus/transformer_t114.rst           |   72 +
 doc/board/index.rst                           |    1 +
 doc/board/nvidia/index.rst                    |    9 +
 doc/board/nvidia/tegratab.rst                 |   72 +
 include/configs/tegratab.h                    |   25 +
 include/configs/transformer-t114.h            |   25 +
 25 files changed, 2979 insertions(+)
 create mode 100644 arch/arm/dts/tegra114-asus-tf701t.dts
 create mode 100644 arch/arm/dts/tegra114-nvidia-tegratab.dts
 create mode 100644 board/asus/transformer-t114/Kconfig
 create mode 100644 board/asus/transformer-t114/MAINTAINERS
 create mode 100644 board/asus/transformer-t114/Makefile
 create mode 100644 board/asus/transformer-t114/transformer-t114-spl.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.c
 create mode 100644 board/asus/transformer-t114/transformer-t114.env
 create mode 100644 board/nvidia/tegratab/Kconfig
 create mode 100644 board/nvidia/tegratab/MAINTAINERS
 create mode 100644 board/nvidia/tegratab/Makefile
 create mode 100644 board/nvidia/tegratab/tegratab-spl.c
 create mode 100644 board/nvidia/tegratab/tegratab.c
 create mode 100644 board/nvidia/tegratab/tegratab.env
 create mode 100644 configs/tegratab_defconfig
 create mode 100644 configs/tf701t_defconfig
 create mode 100644 doc/board/asus/transformer_t114.rst
 create mode 100644 doc/board/nvidia/index.rst
 create mode 100644 doc/board/nvidia/tegratab.rst
 create mode 100644 include/configs/tegratab.h
 create mode 100644 include/configs/transformer-t114.h

-- 
2.43.0

