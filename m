Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA8C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 07:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33AA98056B;
	Sat, 22 Feb 2025 08:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UumAt24d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E88B3806FE; Sat, 22 Feb 2025 08:40:09 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3896E801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 08:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5461cb12e39so2664411e87.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 23:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740210006; x=1740814806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcJvNpuMT0uutGteF2QNOCg/RjFQ0NFB8+KuRuoLTJ8=;
 b=UumAt24dDCDr09S6uWMzOcZmPVQgMoPeR01A3F7RI0+MhR87siVh2TKyzwjaCGPe2A
 pCSgCd7sEjJPuQOmWP5qpmXgVagXGX3b13W5VdaUh856OtwP9KJdPRazID68qOFeKBHN
 zENUWvhQaETYiYcNPPQwkpAxQVzR7dOgpXXYeB+W9f8QSOtoEkY0p59pl9emBQzIWhn1
 eh33E4p+jDRsdmasu1PSMu/cQN4b0QeaxDpg2nnreb+46aLTjEAC28XhVUqrTU5W+wrp
 2YHJTf/Iar0H01JiSM9UT1z+gbqc2ptwQdP0tVWORsY8sAret0wumEBd7uiXwIdXBO8Q
 KTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740210006; x=1740814806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcJvNpuMT0uutGteF2QNOCg/RjFQ0NFB8+KuRuoLTJ8=;
 b=wTp7vmHKb/lnJ3GPDmdyVI6BaQ1l2zVJEWGdUSYZ603qQiuUFn/+WN26n+YcxxaMd7
 O6HMSj3dWRtcP9UIJgZFvBxBXm1Hu+Oo0PLLpOCfuZB4qaTqGShi8QKkP8LZz/6jAsIo
 yQXV/RMbHBvCWOaED4R7UiXYENampVrhI2BZ6VHu84TWMC9MP+A7aWxZR8MgX5uYHYu7
 DPXfxdwI2pkNPgX6IbamiU5WQUriSyMY4MFfyQmuLF7vBonHLa+Vs0WEl6lfdC+E+RJ2
 OZgLNhd5AhhxRFVmZVGPmfnfy1/fSGsWiIzVovPoSh83MjMi7CItMXBXrGdtmsNl/X00
 tL2A==
X-Gm-Message-State: AOJu0Yz9QZJG2gqNIo2Mx8ElPtjQn9W5LOfM23PF7reroTEHOEXO8V/+
 JZYHO18lkzjknGuQ2550YvPlmy+mW560UuBzxDR6s+NA18LR8oWOVjgRqw==
X-Gm-Gg: ASbGnctQzAXe5yOMfbtgNiUEYfafNJxnTjdb+rjJsA4WToweNZ/M1UyCliBuozLVKr/
 VEKo6+oKahZa/7puZ3YFrRnmlpd0B6igHtX7Bf19kGDLrekd9k17fsvPdr3r3+G7lkV8x8m2B/z
 2l5+WlweW8YZpFtHzYqZzV7isoseZ9S41b8OHvzMx+7gbqz7BQZTqZfXEEfKxxrYHLFGYLmRKjH
 8JCXpELmEMzeiRKpIHRDuGGlL0j7PZLcRLfSTf3K4u23PcXZ+JpVxHYGoItgj5CL8wdX1B3fr6V
 TnLQhxij+qZQGqta
X-Google-Smtp-Source: AGHT+IEGRCUlwbndxDpoHTTT9gbreEx0NOFRi8HVFY2KywVck5uFy0JrcDaAQtYsdPooJJW0CbqLZA==
X-Received: by 2002:a05:6512:3f1a:b0:545:22ec:8b68 with SMTP id
 2adb3069b0e04-54838edd169mr2064264e87.1.1740210006123; 
 Fri, 21 Feb 2025 23:40:06 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5462cb28b60sm1145775e87.153.2025.02.21.23.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 23:40:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull u-boot-tegra picasso
Date: Sat, 22 Feb 2025 09:39:41 +0200
Message-ID: <20250222073941.7963-1-clamor95@gmail.com>
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

Dear Tom,

The following changes since commit 274dc5291cfbcb54cf54c337d2123adea075e299:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-02-15 15:29:20 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tegra.git picasso

for you to fetch changes up to ad3ec11b393b7d89d1df353324df4600b219a647:

  board: acer: picasso: add Acer Iconia Tab A500 support (2025-02-16 19:11:43 +0200)

----------------------------------------------------------------
Svyatoslav Ryhel (1):
      board: acer: picasso: add Acer Iconia Tab A500 support

 arch/arm/dts/Makefile                      |   1 +
 arch/arm/dts/tegra20-acer-a500-picasso.dts | 508 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra20/Kconfig        |   5 +
 board/acer/picasso/Kconfig                 |  12 ++
 board/acer/picasso/MAINTAINERS             |   7 +
 board/acer/picasso/Makefile                |   9 ++
 board/acer/picasso/picasso.c               |  57 ++++++++
 board/acer/picasso/picasso.env             |  18 +++
 configs/picasso_defconfig                  |  83 +++++++++++
 doc/board/acer/index.rst                   |   9 ++
 doc/board/acer/picasso.rst                 | 125 +++++++++++++++++
 doc/board/index.rst                        |   1 +
 include/configs/picasso.h                  |  23 +++
 13 files changed, 858 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 board/acer/picasso/Kconfig
 create mode 100644 board/acer/picasso/MAINTAINERS
 create mode 100644 board/acer/picasso/Makefile
 create mode 100644 board/acer/picasso/picasso.c
 create mode 100644 board/acer/picasso/picasso.env
 create mode 100644 configs/picasso_defconfig
 create mode 100644 doc/board/acer/index.rst
 create mode 100644 doc/board/acer/picasso.rst
 create mode 100644 include/configs/picasso.h

Branch contains bringup of Acer Iconia Tab A500 (codename picasso), a Tegra 2
Android device with decent Linux kernel support. Ondevice tests and U-Boot test
suit all passed.

Thanks,
Svyatoslav Ryhel.
