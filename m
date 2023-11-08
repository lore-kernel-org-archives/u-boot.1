Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2389C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C0B876C6;
	Wed,  8 Nov 2023 01:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SsQqM8pD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4985D876C6; Wed,  8 Nov 2023 01:40:45 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA36876EA
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso6570616b3a.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404041; x=1700008841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hawv8F24iPMN138UF55de+LmWZBcipgs2OrcK086FH0=;
 b=SsQqM8pDKqn467FXh+CsMG3II2pHP3YbCRxFCZyNwuXuLm0B1ls3Z9e3I7L/fktwtk
 Gj29e4Y7EUbgYNdyltpLckDnl3TJF84C4l7YCN1/LMVPLU1QSmTv84GNpTMPlj9V09CD
 NnFNFDP8xkRFioDRgXH7mkJhq+o0SYmRslLg3+4GJPP4OB7AHlalhT1QllELNX7sES+c
 qoZ8XVRkEb2BcolSOldAI4sXsHCaIUEExbqDpy43Q0aFTiyJB1mteyR1QaoFoR3ZKF5q
 hF9uR2JW2OiP2KC2OfkzGhiD7jzlTtKLcYjb6/c5gYMqZkblHkUrGfNXtKfEnJ7xYYAr
 Hpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404041; x=1700008841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hawv8F24iPMN138UF55de+LmWZBcipgs2OrcK086FH0=;
 b=LclQaIj2a4mrtB5iOi21mMHWVD35HYpE7TfZKyY6/WuUPXzrpjUpDfs2t8yspWOIS8
 10RhPlvqmLXS7urbmrIk1dJ4ZPrMYxlnPsh2/h9AqjTSncGdEEKaSBxE6C0h9rSQG+Rl
 igvDRbjQC2ynwBSGwjFvZdwpUeayHvQGdrvAGDZxTtMZWYTNMMccHXuZAf9GxmHnWtmM
 Wi4/VI3Qw7KLvjizyZeKX6GubtuiPHgcFYzB2S30C922rTx/nA24qcftuX+c7dDKp6yL
 FqSuvaP0W1hm2XzsKeHZ+Uvoi9ONDoan11GMyt0ra+MI32PP9dJS1D/1y448BCHwENhn
 qB1g==
X-Gm-Message-State: AOJu0Ywv2O3eh225fGuU11F7xCHMcOulSVro2Vfwqx0cyoIJOepEHrRx
 fvQRAlJM3c/+ynlTM9Bdt/I=
X-Google-Smtp-Source: AGHT+IECy52JVizi4Q8Yyg5FlvmIzGdN1CEfoHuQa43MhxPgGdpjOOYqMW72yXTD4qq76ge2+MFI+A==
X-Received: by 2002:a05:6a20:1608:b0:17f:d42e:201f with SMTP id
 l8-20020a056a20160800b0017fd42e201fmr730742pzj.15.1699404040962; 
 Tue, 07 Nov 2023 16:40:40 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 mv21-20020a17090b199500b0028066f3c373sm384284pjb.17.2023.11.07.16.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:40:40 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] fix/add npcm845 serial and board error
Date: Wed,  8 Nov 2023 08:40:23 +0800
Message-Id: <20231108004027.281383-1-JJLIU0@nuvoton.com>
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

1. Fix serial error and add bypass serial setting.
2. Fix/Add dts node node.
3. Add full function defconfig 

Jim Liu (4):
  arm: dts: npcm845-evb: fix/add node and aliases name
  board: nuvoton: update console environment variable
  configs: arbel: Enable full functions
  serial: npcm: support skip uart clock setting

 arch/arm/dts/nuvoton-common-npcm8xx.dtsi      |  2 +-
 arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++--
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
 board/nuvoton/arbel_evb/Kconfig               |  1 +
 board/nuvoton/common/Kconfig                  |  9 +++
 board/nuvoton/common/Makefile                 |  1 +
 board/nuvoton/common/common.c                 | 71 +++++++++++++++++++
 board/nuvoton/common/common.h                 | 11 +++
 board/nuvoton/poleg_evb/Kconfig               |  1 +
 configs/arbel_evb_defconfig                   | 19 ++++-
 drivers/serial/serial_npcm.c                  | 39 ++++++----
 include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 ++++
 12 files changed, 173 insertions(+), 26 deletions(-)
 create mode 100644 board/nuvoton/common/Kconfig
 create mode 100644 board/nuvoton/common/Makefile
 create mode 100644 board/nuvoton/common/common.c
 create mode 100644 board/nuvoton/common/common.h
 create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h

-- 
2.25.1

