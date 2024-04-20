Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5608C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEDC8817C;
	Sat, 20 Apr 2024 12:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L992j0sn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3C588124; Sat, 20 Apr 2024 09:02:10 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A08488113
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eddff25e4eso2344247b3a.3
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596525; x=1714201325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZDsvjnYz/FS7yuGGVz1EBaWRc8jDyuGYDKmWNVRKGc=;
 b=L992j0snOT/OfvXgPZvhpD57C8UHErEdWoNvxTxu3fqUw4h0jSGKbeeyNlx9uW8niB
 n7Pkphx0BnztkhvityJdu+mjXPFnvJ5wL+uSMOlHV6UpOkhki5VW9WRr9Ig1NH+xlxu/
 yw4f2x2p0md3IMzugWAB6kgVRITbJaNZIa3fyz0lU8AzRfkXc1RF6gusnOiC53MRMZB5
 dgpBkAGHeyfnVWLx6Q4EdIje0nFMuJkte92WMDVopVWR7LFHudKKvoRCdmXpjx34Nrvs
 I6VpzlT5x4dqs2fyxJx6FUFYVhcbVKZNzaAYNibYkoNA6COjRGjhFwYis/1FBPmk1egf
 byNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596525; x=1714201325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZDsvjnYz/FS7yuGGVz1EBaWRc8jDyuGYDKmWNVRKGc=;
 b=IAWZ24G3UyFhRiFtGOgfXgHRvvqfxGB15WawbtPTXSga2QLrs8g3qJeIkN9OOzO2jA
 nj5vbdimhwc7cmGAU6qR2yytjWRGUyab85SG3MCCf4YTc9P8/VRF/H9XZN+nSg+CThO3
 ymHYRUjReScRp32yqlIjjqeGgcfWI5uTtTooBGZsA28JYthApywDSPCb1eEH118YjtNw
 4a8tCwIhuOqHHOV7waD+dFqOjx6kFwcESGHrbOl7av7PwwjMQqCOTOp+aJK7sZdXuXI3
 JbxVyS4jqyC+IefGYWGbymL7WhKPWjFhfHBbBAbzD/I6IZIzxkkpnbN3PMQsu/Uek5ea
 +m8Q==
X-Gm-Message-State: AOJu0YxSr63WF0Kov9p6TPauPDEh4LrJTvtzUJZo1v8fANLm31wl+4q/
 IvpilMQoGDq4TFvrTeUIjWNIy1yMDh1XNCextCiwcixh9mldoSvVFFpPhViatRI=
X-Google-Smtp-Source: AGHT+IErddEowjXQIYIXYtZVZ/tHjG/bBCI5Gjh06o6pKbkArwzrVYdYFMhhC5OnP9n8fHbCK/3TyQ==
X-Received: by 2002:a17:902:f708:b0:1e2:bbb5:e2cd with SMTP id
 h8-20020a170902f70800b001e2bbb5e2cdmr5412454plo.54.1713596525297; 
 Sat, 20 Apr 2024 00:02:05 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a170902778900b001e51b690b7dsm4424137pll.295.2024.04.20.00.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:02:04 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>, Jim Liu <jim.t90615@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Leo <ycliang@andestech.com>, Nils Le Roux <gilbsgilbert@gmail.com>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] board: sophgo: milkv_duo: Add ethernet support for
 Milk-V Duo board
Date: Sat, 20 Apr 2024 15:00:26 +0800
Message-ID: <20240420070149.8917-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

This series add init code for cv1800b ethernet phy and enable ethernet
support for Sophgo Milk-V Duo board.

In cv1800b, as the PHY register phy_id being initialized to 0, it is
necessary to initialize the PHY before the ethernet driver initialization.
Therefore, the initialization code is placed in the board_init function.

For the Linux kernel, due to the presence of a hibernation mechanism, whether
the phy id will be reset to 0 after hibernation and how to reassign it
thereafter remains an issue to consider. Once this issue is resolved, the
Ethernet driver for the Milk-V Duo will be sent to the kernel.

Changes in v2:
- Change compatible
- Add clocks and interrupt properties.

Kongyang Liu (3):
  board: milkv_duo: Add init code for Milk-V Duo ethernet
  riscv: dts: sophgo: Add ethernet node
  configs: milkv_duo: Add ethernet configs

 arch/riscv/dts/cv1800b-milkv-duo.dts |  7 ++-
 arch/riscv/dts/cv18xx.dtsi           | 23 ++++++++
 board/sophgo/milkv_duo/Makefile      |  3 +-
 board/sophgo/milkv_duo/board.c       |  4 ++
 board/sophgo/milkv_duo/ethernet.c    | 79 ++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/ethernet.h    | 11 ++++
 configs/milkv_duo_defconfig          |  4 ++
 drivers/net/designware.c             |  1 +
 8 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 board/sophgo/milkv_duo/ethernet.c
 create mode 100644 board/sophgo/milkv_duo/ethernet.h

-- 
2.41.0

