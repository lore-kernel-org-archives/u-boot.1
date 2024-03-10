Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F25C54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 12:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD26887C82;
	Sun, 10 Mar 2024 13:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RiYOBZNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EBA87CF2; Sun, 10 Mar 2024 06:58:40 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D43F87BF4
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 06:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-21e45ece781so1746615fac.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710050316; x=1710655116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UFHFwAdiZxnksWAMiLqor/GWsGs9FD4xciDNpQo4U4k=;
 b=RiYOBZNqd7a2MjYPukJi6JXt8SDwPRudI6ReVquOvsUREYajGeYqWU7n6lrd+iE1sW
 qiy4+g2qHcWi57xr9yUCL0fi+ECoEQMKaf+SjuY8sGQUrPiF7J7nyS5TWy05NDOq3xet
 8Z896tmiqtDFOM3NJqcgRTtdw3GPWOBHAJ0CRipI2HrQo8UV26jA9P8HfoTfBHwOLvx5
 h2O9t/LgDsNZfaLpozqGGTiShSI/HfogEsOjgLaT1W3hQCPM1gfCIBne/rR0tgglY0Fh
 mu7Y4hrnw0eZ6aQ5Sod6cjSG9ymjkeQpQYmQI5iSeF7fHjRkuuh1dRlU2hv4qfS74b47
 KOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710050316; x=1710655116;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UFHFwAdiZxnksWAMiLqor/GWsGs9FD4xciDNpQo4U4k=;
 b=My7wuSg2ZiZdWpjONDYty9DYIR1XpNYC1PsP4rV5K1/XMPQNKJLT0iCTiKPeD47Gwg
 iyvnvPmEKp3EKYQPYjpmm1weK6CbnsXUxLSUax+lWuXJFRoHCixyZRGLBf8pJDHTXylS
 iI3d/UXzkO4yze5m0gTnLLoi2fmcxWp9JXMFeTB5i8FmpF0HAPhY8wdvsyJlJq+QR41X
 taABdff4HLxlvxP2BD/0KKu9yOabpB8X+0BPMaTIhy8/3TSolgJZ57S6GSMDEwPYZ32P
 qPUg0KGU8DhiD5il4eTrM9/5A2vq2rtf65mQMV47ubT06h0eEobKSNrySvli+0cFmnL0
 dQsg==
X-Gm-Message-State: AOJu0Ywo3BoV9HtASaUF0SOJLxllgUPZqruCKCoUErY+aZiQSYiO/7fj
 uRprcJj2Ka4HtBpDGGtlj3yAdPp6YdFqCScT268ykYH2u1XDqdEBss1DShYfpQrYJg==
X-Google-Smtp-Source: AGHT+IGG1AYJmNI1RKHafeaR/f9y4GVvQEV7SP4CjCUb6sTvHsbm82u+5KVKu5EX7jeoLBnqMMvOHg==
X-Received: by 2002:a05:6870:d693:b0:221:9ab1:7629 with SMTP id
 z19-20020a056870d69300b002219ab17629mr3802405oap.7.1710050315983; 
 Sat, 09 Mar 2024 21:58:35 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b006e508b6a13dsm2037522pfo.58.2024.03.09.21.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 21:58:35 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Baruch Siach <baruch@tkos.co.il>, Joe Hershberger <joe.hershberger@ni.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Leo <ycliang@andestech.com>, Nils Le Roux <gilbsgilbert@gmail.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] board: sophgo: milkv_duo: Add ethernet support for Milk-V
 Duo board
Date: Sun, 10 Mar 2024 13:56:43 +0800
Message-ID: <20240310055816.11575-1-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 13:10:19 +0100
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

In cv1800b, due to the PHY register phy_id being initialized to 0, it is
necessary to initialize the PHY before the ethernet driver initialization.
Therefore, the initialization code is placed in the board_init function.

Duo to modification of dts and defconfig, This series depends on the series:
https://lore.kernel.org/all/20240309175330.79267-1-seashell11234455@gmail.com/


Kongyang Liu (3):
  board: milkv_duo: Add init code for Milk-V Duo ethernet
  riscv: dts: sophgo: Add ethernet node
  configs: milkv_duo: Add ethernet configs

 arch/riscv/dts/cv18xx.dtsi        |  6 +++
 board/sophgo/milkv_duo/Makefile   |  3 +-
 board/sophgo/milkv_duo/board.c    |  4 ++
 board/sophgo/milkv_duo/ethernet.c | 79 +++++++++++++++++++++++++++++++
 board/sophgo/milkv_duo/ethernet.h | 11 +++++
 configs/milkv_duo_defconfig       |  4 ++
 drivers/net/designware.c          |  1 +
 7 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 board/sophgo/milkv_duo/ethernet.c
 create mode 100644 board/sophgo/milkv_duo/ethernet.h

-- 
2.41.0

