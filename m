Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A435C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B446E871BE;
	Tue, 14 Nov 2023 09:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4xX1ybc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027A0871C3; Tue, 14 Nov 2023 09:52:15 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70EF871A0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6c4eaa5202aso3808695b3a.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699951931; x=1700556731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RbAdVq+2hg2/ZF7k2S+WpxgU5s23W++f0S22mFQ5JY=;
 b=X4xX1ybca0tyJUmuAgcf5vTWJdsZobaqoV3+b9pvd4Z0yETN7YLcv31tjN/dLNMTfJ
 lHjxH1Her9oq898JCHJQqrMNwQdD54rbAA0d1V4QLLL0wv6azyFpAoQnDfPZl2PDFn/G
 HSo9GvwFPoOv+5x86SuHxy9HoiE6AoPDUZ0yF97hNfQ7Q2U/rrBNcVfDo2AcLBlTcBFF
 BkWPz5qKtll3FvY0vaiXEtq3DGFtDVhpLVJ0fYskoSa12cosQkuVevx4j05smyzC+0gr
 B68K4D0Hriy8aVy99CD64NqF2I1tJpP3hvu/QysxOZlrP+X7qHLHlQuGQC0O8CNjVd/C
 n/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699951931; x=1700556731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RbAdVq+2hg2/ZF7k2S+WpxgU5s23W++f0S22mFQ5JY=;
 b=L8cAoK37z2oqPnisVhAIbV0JIHCykj6NxD3zDuJQyr0aLypJpSoNarDaYFSqJ/XuLD
 Nzz6JMvpHkjg8AKX4SpdiCbO+wwtVWHlZiSz810jYKB082QJnTEBHkQFjkWL348W8sdL
 RkwKmFSMGeJQnM0n/Io6rtECqeDEEapYbjf8dvPwDXYKN9LgUEVGklAJ0xafia3RkE3u
 sRaYLXo1o9P616f6/i4Ku7f1tE7u31IcO7srzP7J9zqB+UhILhCKFoE+HxCZ02wJqrMo
 j6Vgze3r/kYlYkYCuZ9yI5UOofkspJm1EphlHQatOTpoNbn7dUQaH1zyb+hBO/fG1ICW
 /Q9w==
X-Gm-Message-State: AOJu0YxglCFK8ywvdSYtZ2TqnEcaL7Mn9fnZbQYQVbfQM515FemxsUpi
 vIXBzHw3UsWYIKNdZHteuro=
X-Google-Smtp-Source: AGHT+IEkcQcscq8+frl84U4gIj1YeFCA/vh8mGAAlrJz7gb7RSx/FQA+CzVhmJA8L/8AtAoAIeEzvA==
X-Received: by 2002:a05:6a21:6d93:b0:186:9a3f:f2c4 with SMTP id
 wl19-20020a056a216d9300b001869a3ff2c4mr5486419pzb.47.1699951931115; 
 Tue, 14 Nov 2023 00:52:11 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 fh23-20020a056a00391700b006be0bd6a4d8sm778696pfb.36.2023.11.14.00.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:52:10 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/4] fix/add npcm845 serial and board error
Date: Tue, 14 Nov 2023 16:51:55 +0800
Message-Id: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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
  arm: dts: npcm845-evb: fix/add node and aliases
  configs: arbel: Enable full functions
  serial: npcm: support skip uart clock setting
  board: nuvoton: update console environment variable

 arch/arm/dts/nuvoton-common-npcm8xx.dtsi      | 11 ++-
 arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++--
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
 board/nuvoton/arbel_evb/Kconfig               |  1 +
 board/nuvoton/arbel_evb/arbel_evb.c           |  7 ++
 board/nuvoton/common/Kconfig                  |  9 +++
 board/nuvoton/common/Makefile                 |  1 +
 board/nuvoton/common/uart.c                   | 71 +++++++++++++++++++
 board/nuvoton/common/uart.h                   | 11 +++
 board/nuvoton/poleg_evb/Kconfig               |  1 +
 board/nuvoton/poleg_evb/poleg_evb.c           |  8 +++
 configs/arbel_evb_defconfig                   | 16 ++++-
 drivers/serial/serial_npcm.c                  | 39 ++++++----
 include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 ++++
 14 files changed, 194 insertions(+), 26 deletions(-)
 create mode 100644 board/nuvoton/common/Kconfig
 create mode 100644 board/nuvoton/common/Makefile
 create mode 100644 board/nuvoton/common/uart.c
 create mode 100644 board/nuvoton/common/uart.h
 create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h

-- 
2.25.1

