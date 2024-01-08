Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C09C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1259987A6A;
	Mon,  8 Jan 2024 11:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fi1rgWii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DA3E878F6; Mon,  8 Jan 2024 11:50:56 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BE987A47
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so167315466b.1
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711053; x=1705315853; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ad/16uMd3ie39mBGaQFHiVGgwjULHdmhflaum9jZooI=;
 b=fi1rgWii2RvGOxtJLC+LzJkTEriw1VsAJ7hFcEdrffa3XDNo/lrR+0Ai/nAlD4MutI
 X0nYh2j4X0UDq64WKXEzP8bZ/hcXB5sw+rCcDf76HOYoMI0Em7Drd1leVYQBW+jHtbHV
 sF7rtQCts3et3hdv4WfoMEO8fTWkNPF7r2rcwRBICu55uzGQSILzXEmJSfiRjK53jvUk
 yK0/QNyy9lRcanbwUTW1iYPCksrnISUrx8SIkxibHGnmJbjIFqrO2YmGn5/u0tCh961c
 YHz+rtStJSbGA8hJYbfkHsY+bhvNFpl59wQY3kfyhmkL3sR8hsiDVagM9hGW7Gd/urp7
 sApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711053; x=1705315853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ad/16uMd3ie39mBGaQFHiVGgwjULHdmhflaum9jZooI=;
 b=mfVHTY4asReY5lDF9UWwgYrYY0cLdiBy0CF7Z99sPvafPaaakr7MMVQHXvg6fUdYPS
 f6eFRmMZRT4lML/bHXUBnVzZruJZwucOCv/LiWegPIvB/uvEUZtJREN7DClfVu+3c0Ag
 rp5OQnM6QvTUc1Qngr8u7vkdYxUSE4S1wN/F1n/y5EhsB/OPV7fos4D4erkWvFwk7spX
 UWlbJsfahn/iSeWy+asPa+pQdIzpTe6ggaDr13Jgtwi6atlwqRh3fVPPnmVRPmluZ8V0
 3AyQAOnkfOZ8jdYAIx+7uqAPN10HMdBbbWwDN3y/EulhgD4LIeo7gIVrdRx5NymD3tnm
 AA2w==
X-Gm-Message-State: AOJu0YzCgnnZ81oSDtV2LLXCLmJrKsV0/Bq6qNdwf9+NvhE4Oyzwc7CU
 FiKrdpNSnDJZf8POpTqXWpk=
X-Google-Smtp-Source: AGHT+IFWU2+K96U2nE7ZWgJS25m689lW//0XBJiY5Fj+04dap9Io/FQDh1kKvkYQNp0Ky1PYKDw3LQ==
X-Received: by 2002:a17:907:3187:b0:a28:cf0a:c29e with SMTP id
 xe7-20020a170907318700b00a28cf0ac29emr1573677ejb.114.1704711052999; 
 Mon, 08 Jan 2024 02:50:52 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/9] Add T114 video support
Date: Mon,  8 Jan 2024 12:49:53 +0200
Message-Id: <20240108105002.243149-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

T114 is not that different from T30 and all T30 drivers will work
on T114 as well with some adjustments.

Patches propose general improvements for existing Tegra DC and DSI
drivers as well Tegra 114 video support (experimentl).

Commits pass buildman for tegra.

Svyatoslav Ryhel (9):
  video: tegra20: dc: diverge DC per-SOC
  video: tegra20: consolidate DC header
  video: tegra20: dc: pass DC id to internal devices
  video: tegra20: dc: add PLLD2 parent support
  video: tegra20: dc: add reset support
  video: tegra20: dc: add powergate
  video: tegra20: add MIPI calibration driver
  video: tegra20: dsi: add T114 support
  video: tegra20: dsi: add reset support

 arch/arm/dts/tegra114-u-boot.dtsi             |  13 ++
 arch/arm/dts/tegra114.dtsi                    |   4 +-
 arch/arm/dts/tegra30-u-boot.dtsi              |   4 +
 arch/arm/dts/tegra30.dtsi                     |   2 +-
 arch/arm/include/asm/arch-tegra/dc.h          |   8 -
 arch/arm/include/asm/arch-tegra114/pwm.h      |  13 ++
 arch/arm/include/asm/arch-tegra20/display.h   |  28 ---
 arch/arm/include/asm/arch-tegra30/display.h   |  28 ---
 drivers/video/tegra20/Makefile                |   2 +-
 drivers/video/tegra20/tegra-dc.c              | 166 ++++++++++++----
 drivers/video/tegra20/tegra-dc.h              |  44 ++++
 drivers/video/tegra20/tegra-dsi.c             |  94 ++++++++-
 .../video/tegra20/tegra-dsi.h                 |  24 ++-
 drivers/video/tegra20/tegra-mipi.c            | 188 ++++++++++++++++++
 drivers/video/tegra20/tegra-pwm-backlight.c   |   3 +-
 15 files changed, 509 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-tegra114/pwm.h
 delete mode 100644 arch/arm/include/asm/arch-tegra20/display.h
 delete mode 100644 arch/arm/include/asm/arch-tegra30/display.h
 create mode 100644 drivers/video/tegra20/tegra-dc.h
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

-- 
2.40.1

