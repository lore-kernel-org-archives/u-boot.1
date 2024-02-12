Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794D0C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 11:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F4887BE5;
	Mon, 12 Feb 2024 12:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UM3NxN2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70F5D87EC4; Mon, 12 Feb 2024 12:02:09 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF603879DF
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 12:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso594282a91.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 03:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707735725; x=1708340525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8owkyLsN8ILDoUCIvUvjXPU4glWYrWv2egX19J2ds0A=;
 b=UM3NxN2+29UPYp5w9bYvje4UPtgPb+5l7xivf1mtHTHLA1lECV9GD3MNO4mq3YpCD+
 VxZEIMSH7B6s88OER7vyQ4WDFes0Ksjp/wwgdqwnrEr3X7Gs1Rkj10IwJJGmcqDwTgBb
 TdQ0ZAISkv5ps+Yl7HmhyFQr0ZlfzrPcbVM5YM4/K+OkgD4KNolXEWQcR8dtV+t+dOy/
 nJOfnxXT/fW/CNJZIGLEzbm6UiSAOfGoc7BuboaqjuhSURc4YnqrdMsgumLowRvTpT9L
 EDOxepNsaFzjAiUDDBLwz74AGLawTE6+byPl39Hb7eulUPFM27g3A8k8Cjxp3hgh56jV
 Qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707735725; x=1708340525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8owkyLsN8ILDoUCIvUvjXPU4glWYrWv2egX19J2ds0A=;
 b=I7RhsghxapJey14JxOBnpuAoRHl2oJDFzsy1nsIwlA7DIv/uTSp/p2N0M0a9rb41Ix
 FvyMG42arSV1IYgESUvMCMSqOibTls6bExE8+kByL3gEgiPuw7cWwVczOpjWeSKERVKX
 huSfwDY3L+DcsgZLJFEb/IMwKJEGHws/3FFma/JN/W0r5MFwtQNanocKnHYLVqz+YoOT
 ZCOY4wgoU0rHg/fAg2bPJakF9bdKCDK83YJs5qDtGkK+PcaUtyYxGh+yEm+9+Tt5D/5Z
 g1tN2msCmKvY8YS40f3WaS6csSjuTXMb4D7H2VRyojNlLOKDoIY9MFvCFd048aa3lWIb
 70GQ==
X-Gm-Message-State: AOJu0Yw3pUyOgaDV8xv2wLfrCUxlG9RbOtO+Zab6vdP90D3FFsnToJIK
 qbYS4C23bHZiY8djJdRIWwV0HKrTS2yy5/HcfNQle67kgoPRkVRkk5XJPppg
X-Google-Smtp-Source: AGHT+IGH7bU6dIdimFroJj7+92IAIzORWRaTls5ixEYziOHXW0BKxO/ADGeIPjcKjazbvkjUrx92Gw==
X-Received: by 2002:a17:90a:6f83:b0:296:ee29:ac4 with SMTP id
 e3-20020a17090a6f8300b00296ee290ac4mr4313736pjk.3.1707735725110; 
 Mon, 12 Feb 2024 03:02:05 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a8ea:7cb9:1157:1655])
 by smtp.gmail.com with ESMTPSA id
 sv7-20020a17090b538700b0029604b0b7d1sm226926pjb.15.2024.02.12.03.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 03:02:04 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: Please pull u-boot-imx-master-20240212
Date: Mon, 12 Feb 2024 08:01:59 -0300
Message-Id: <20240212110159.2426827-1-festevam@gmail.com>
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

Hi Tom,

Please pull from u-boot-imx, thanks.

The following changes since commit d7aaaf4223d0a2f9f8c9eed47d7431860b3116d8:

  Merge tag 'u-boot-dfu-20240209' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-02-09 09:00:42 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240212

for you to fetch changes up to fcd377ed6480643b1f79188c7a8fb9280a211b4f:

  configs: imx93_var_som: Enable AHAB support (2024-02-10 15:16:13 -0300)

u-boot-imx-master-20240212
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19583

- Fix the i.MX8MP SPI compatible string.
- Let the SPL clock code do the configuration on Data Modul i.MX8M Plus eDM SBC.
- Enable secure boot on the imx93_var_som board.
----------------------------------------------------------------
Marek Vasut (2):
      ARM: imx: Let SPL configure ECSPI1 clock on Data Modul i.MX8M Plus eDM SBC
      spi: mxc_spi: Add imx6ul-ecspi compatible string

Mathieu Othacehe (3):
      imx93: Use a header for imx9_probe_mu declaration
      board: imx93_var_som: Probe ELE MU
      configs: imx93_var_som: Enable AHAB support

 arch/arm/dts/imx8mp-data-modul-edm-sbc-u-boot.dtsi |  3 +++
 arch/arm/include/asm/arch-imx9/mu.h                | 13 +++++++++++++
 board/freescale/imx93_evk/spl.c                    |  2 +-
 board/phytec/phycore_imx93/spl.c                   |  2 +-
 board/variscite/imx93_var_som/spl.c                |  5 +++--
 configs/imx93_var_som_defconfig                    |  1 +
 drivers/spi/mxc_spi.c                              |  1 +
 7 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-imx9/mu.h
