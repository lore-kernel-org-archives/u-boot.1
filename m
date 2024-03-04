Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184BAC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D7687FBE;
	Mon,  4 Mar 2024 18:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+ssLIRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3032A87F7F; Mon,  4 Mar 2024 18:53:04 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC6887FBE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e5769aa0b3so1032679b3a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574775; x=1710179575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KmMLCeLSMaQk+blO+wdtdAsYO6rGTEZ0KbJ07tjVxQ=;
 b=e+ssLIRNnCFSHnddZRY3IWqf25Wqt7goiroJFH2mj50jkrvt8nrFMFA12qXLPBrNsa
 PtJkqTXTzhEUdRgz+cAdAX/vNdW/CUnqUsdYAeJgbbwSgjvMSUca8EcdZaYK7UxxMpjX
 o7pX4rmRqnofCr5Qs/0Xl8haUNsFsV59YDe5d/PrzmDhfrQRMDDjuc129Gg3ljtOoK0P
 D3LoAEsCsy0x+6LOwvr6iZA4FyjpUH2buAz1V2o3DGgd4j+E4Gsd5dnWrtw/MzuR4Nkh
 XcNh4ZeE88wCV8h3bUnyryMStLTG34v3HReXVp9jqzIT64gAFuEI2acJELeqJRrNBlA7
 yiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574775; x=1710179575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KmMLCeLSMaQk+blO+wdtdAsYO6rGTEZ0KbJ07tjVxQ=;
 b=Nejd//vKV7lGAQ+8Zt+ZsbubgmPFkquGktSRDsFW9nPn3S+Mbo9RXjRIcYB0CRQ7Nl
 gHWDswWxMj/VU6Dlnz3FvxaJtSocmzkHdEWxzEs5TCpTeNEO+TLdZfwFFcwUId5TBhDl
 QFqGAIyrWivOBcialMr3/HxUA0h2ZfVuMcL4q9JoDd2L5+iUw8ht06/0oUt57S/qE2mR
 OlOmBImFI+LV3BUzYEM96WsPuMw8uAQ34LgFDLYBkaB5Y/u5z59+4Qn+1v3oOnl10p02
 DfyzA+V2cz5zKuyEkt46xEcPzj/Wa5YzkkQ5afaUh3pfs1VUNMe88iGZjH4feYgf0FOU
 PqXQ==
X-Gm-Message-State: AOJu0YzVzT5O6gs8L8hVv0blb/UDSWPHhRBxduI7QXWdSGQ0H+y2j6YA
 3D5eRi3LaVx8IYYFpCZ9WaDAycRIkNY5+EIEipfKn3zyoPft8M0VMw2mqeTd
X-Google-Smtp-Source: AGHT+IHlx5al4jlJY/LWefy8JaN21WfugNhBHX3QmHXTj0kTqtpHwgitRvKd9lRpp+Pelq/QTcgKiA==
X-Received: by 2002:a05:6a00:1a90:b0:6e5:e634:fb8c with SMTP id
 e16-20020a056a001a9000b006e5e634fb8cmr9872195pfv.1.1709574775403; 
 Mon, 04 Mar 2024 09:52:55 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1aed:7721:4ff:b79])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a626307000000b006e624f5c866sm2005126pfb.145.2024.03.04.09.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:52:54 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240304
Date: Mon,  4 Mar 2024 14:52:51 -0300
Message-Id: <20240304175251.823846-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx, thanks.

The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1f1:

  Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-02 14:30:25 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240304

for you to fetch changes up to 9b9f022e7368cacafa368beaa7fadd931f2cfcdb:

  video: mxsfb: add back imx6ul/imx6ull support (2024-03-04 08:18:48 -0300)

u-boot-imx-master-20240304
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19817

- Fix i.MX93 OP-TEE support.
- Use the container image for i.MX93 revision A1.
- Fix display regression on opos6uldev.
----------------------------------------------------------------
Mathieu Othacehe (3):
      imx9: Fix OP-TEE support
      tools: imx9_image: Reword warning message.
      imx9: Update to mx93 A1 chip revision.

Sébastien Szymanski (2):
      opos6uldev: make the LCD work again
      video: mxsfb: add back imx6ul/imx6ull support

 arch/arm/dts/imx6ul-opos6uldev-u-boot.dtsi | 28 ++++++++++++++++++++++------
 arch/arm/mach-imx/imx9/container.cfg       |  3 ++-
 arch/arm/mach-imx/imx9/imximage.cfg        |  2 +-
 board/armadeus/opos6uldev/opos6uldev.env   |  1 -
 board/freescale/imx93_evk/spl.c            |  7 +++++++
 board/phytec/phycore_imx93/spl.c           |  7 +++++++
 board/variscite/imx93_var_som/spl.c        |  6 ++++++
 configs/opos6uldev_defconfig               |  3 ---
 doc/board/nxp/imx93_11x11_evk.rst          |  8 ++++----
 doc/board/phytec/imx93-phyboard-segin.rst  |  8 ++++----
 doc/board/variscite/imx93_var_som.rst      |  8 ++++----
 drivers/video/mxsfb.c                      |  1 +
 tools/imx9_image.sh                        |  2 +-
 13 files changed, 59 insertions(+), 25 deletions(-)
