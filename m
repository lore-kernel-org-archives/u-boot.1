Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7888BC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 05:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DBA826AD;
	Fri,  4 Apr 2025 07:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="egN2ovDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EC08290A; Fri,  4 Apr 2025 07:30:51 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D51826AD
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 07:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so265926166b.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 22:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743744648; x=1744349448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mpJ8vQhB1qy1aZF4hR+6Yp35ErNRFWFQCt0kiDxi9V4=;
 b=egN2ovDR+CgLW9vxyCtyri+KxxDOWaPQpffHV0W+1pxfdMjZcitj7RfRp9ijtMZNJA
 DaR35arvE5CBCsz6ltD5WYZ78idexXMclxyQ/B7J8x2elabyVt8sGfXIhy50WeUUmk6C
 MLHsYwidjzvfu3Pf7cia57lMvGj9Uc0pOlFD5b4LDsZsFtS5ztXw+0saSp58IYr0wJK/
 F/ZSS70LmiHAIMCULKHo3Z1pUoBeArK74geq8x4XUkH9baRNlkZnfcppCuTFYe0RSKjd
 ZUdSBTW6RHWVwEhpAkCqS0afiJBWJSIQSy8Ph/HjIUzWfnmGz5rfHAuKmXKu5Q8JVWZs
 BWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743744648; x=1744349448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mpJ8vQhB1qy1aZF4hR+6Yp35ErNRFWFQCt0kiDxi9V4=;
 b=aIVqek1CLFdHB1nsgPJ0FkkkDhMGrrgmA9H6KubFCmp66BBynHzSUlXXYHlbFZ1yGg
 B7j8fmWVIPrPNo0nUPicMVbW27gCjNBy7+MqgsMgUx77rg5pxUTKegoGa0EfjWNF/05J
 yNjkRFdt9ftFIC5qPheYNcsksLJ10kymNrucNMya48Bi2Z6HLKLXkk1YKxNkz+QQ8Bwb
 pCpdRlGD8o0zsLy4RS2JGy7aWdqPip49wgSUxy0JWvnLNZwpgACScswMevvQD0+tb1pT
 hX0d/Jq+kEvFMoVHqmuPMpWAzfWo4eGHIvJ0o4qHQTymvOacvFDEAgkxWyzrpqd+KIfR
 4YLQ==
X-Gm-Message-State: AOJu0Yw7YcVJ+LjONepDc5qqN3Pi8EJuXF/T5X+MYeD30P013YSjnmPQ
 nayeSoTvbMhwQm0y2GT4tWvWTkBcx6s/J7SqWQMBtdEppMb4AbsD
X-Gm-Gg: ASbGncsmCDaiCT2Cc+Ry+QhKI55kQXZaD9x0KhX0lV2e+xY4s9rettN5HkFnjfiExmD
 /ynxbzzDHMuF3YT8Ov5cf8V4S6HxC0mmEd6T6kWlrUtzcYhe9v5uvOdWGmeThCZ3CqlsdUhzSkr
 N++hr+W5IhubFySzsCBKnAvHuLzVva/nD5W+zQOt1ZIeBGwmp90UW9uy5q9pwOC9QQg2Y5DpkyK
 bNjMUl+IZoTtvbAI1hYwK4X3hH1TVCZGASbKMHHNKUdrgX9hh8bsTBpOpqYmzuodqtDCYtCGKkR
 7QubvUoo5xXKyM/SsEfskE9FhS3S8WOV5NEKRV+YtMotGnU=
X-Google-Smtp-Source: AGHT+IGKv9OzN6y27PkLaeHgaB/1U8CjJHDFHar+UqGOtUAfGyhZSJFatd9sIEKSebaGE0QllLWGsw==
X-Received: by 2002:a17:907:72c3:b0:ac7:9acf:4ef with SMTP id
 a640c23a62f3a-ac7d6e9fe06mr87693366b.56.1743744647605; 
 Thu, 03 Apr 2025 22:30:47 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea0d72sm197214666b.69.2025.04.03.22.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 22:30:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/3] Tegra 4: add support for Asus TF701T and Nvidia
 Tegratab
Date: Fri,  4 Apr 2025 08:30:19 +0300
Message-ID: <20250404053022.6564-1-clamor95@gmail.com>
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

---
Changes in v2:
- upgraded to comply latest video and device header changes
- fixed chainloading fail due to T114 clock issue
---

Svyatoslav Ryhel (3):
  ARM: tegra114: clock: avoid touching DISP clocks on init
  board: asus: transformer: add ASUS Transformer Pad TF701T support
  board: nvidia: tegratab: add Nvidia Tegra Note 7 support

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/tegra114-asus-tf701t.dts         | 1245 +++++++++++++++++
 arch/arm/dts/tegra114-nvidia-tegratab.dts     | 1041 ++++++++++++++
 arch/arm/mach-tegra/tegra114/Kconfig          |   10 +
 arch/arm/mach-tegra/tegra114/clock.c          |    1 -
 board/asus/transformer-t114/Kconfig           |   16 +
 board/asus/transformer-t114/MAINTAINERS       |    8 +
 board/asus/transformer-t114/Makefile          |   10 +
 .../transformer-t114/transformer-t114-spl.c   |   42 +
 .../asus/transformer-t114/transformer-t114.c  |   57 +
 .../transformer-t114/transformer-t114.env     |   15 +
 board/nvidia/tegratab/Kconfig                 |   16 +
 board/nvidia/tegratab/MAINTAINERS             |    8 +
 board/nvidia/tegratab/Makefile                |   10 +
 board/nvidia/tegratab/tegratab-spl.c          |   42 +
 board/nvidia/tegratab/tegratab.c              |   56 +
 board/nvidia/tegratab/tegratab.env            |   15 +
 configs/tegratab_defconfig                    |   84 ++
 configs/tf701t_defconfig                      |   89 ++
 doc/board/asus/index.rst                      |    1 +
 doc/board/asus/transformer_t114.rst           |   74 +
 doc/board/index.rst                           |    1 +
 doc/board/nvidia/index.rst                    |    9 +
 doc/board/nvidia/tegratab.rst                 |   74 +
 include/configs/tegratab.h                    |   19 +
 include/configs/transformer-t114.h            |   19 +
 26 files changed, 2963 insertions(+), 1 deletion(-)
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

