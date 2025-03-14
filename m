Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F656C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BEB81877;
	Fri, 14 Mar 2025 06:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPKp85H/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE2F81877; Fri, 14 Mar 2025 06:54:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97396808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 06:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22355618fd9so35133435ad.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 22:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741931683; x=1742536483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jnuVS+NkQM+1X/a/vcIwvEzRyHJiJTjKX1XzE7LcfNE=;
 b=nPKp85H/bLaftI6JU2ic2tkxC0JCSl9zdUdfFEJ5sDxwc3SeyNBAL0cXkdrOGfKoI1
 Y8dfJ48/Y8qn6PLCKcDvR6weyePUQgJvfkDiwX1tRMTZUFORvt5wp3M1QfFqlL8PAuTq
 X02YOtRBncPNrb1a3LUHulND7c5yfgnjDsDSg//N0niJbcQcx/By+5uLte8AXQOIXkNG
 Nl1vyfpbnzZh96squHMa8jpxokxZv4nktHfd5xo76rYZ4o/sDW1FjFXnXRMQBGEzWD8H
 4UCgbkdEP3BovqJQAherNetEzMmdVwivzjT/45uLBxowzDSZ6BJjeoqCFEMaEQ888q89
 VPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741931683; x=1742536483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jnuVS+NkQM+1X/a/vcIwvEzRyHJiJTjKX1XzE7LcfNE=;
 b=ww0zKGJltRqiZJe5E1CoPSBBcZbLH9BZDbiJH6eT2QMH6WjXoPrWQR1W0QAgy9boqa
 lMGhvs6YS0z15kje82rCE1f0nFja3QvMYe4Ima86FZ4rKY409yzUotVnT5/7gpFWYT2J
 U/sYrtm4pYeZ0fEtmD2alAe1BOQEUmcUrro5zl/RUgiKtgWbDRpE+ab0XOR4fcssn/Cv
 S1fdWn7/rcCTluiKxIw4/Xt1u7pEI+DZx7yTANWfLwHb8x/8Hz2cpUQm5PB/6i49MqBZ
 0U0iUFmsfbRwuH9qQoXhuYWVuzOB2guoiqe+aEvwCNEugRtTfOCBzfeHFPAAvHkcjwXW
 LUSQ==
X-Gm-Message-State: AOJu0Yx2po/7VS2jlxh38uN9ircZFnuISyVafv3UtEkynlQ1ndFnKoaS
 Ku12PFEEQP4jSfZ8ujWY5M3T8WqTJppopBMCXymKrFndtdRkzUpHlw4YKJvd
X-Gm-Gg: ASbGncssrRibSAcKQGG0bh+jrjmO1dr4/Vnb/TCHi/dYn8PkO4C4T9EVqiaZg7lI5fJ
 PJAcj08I1DwLOfFjW5AFJv9Z+fYy0oStnwX8fJOlI0DfQQHMGWWA7nWcIpakhqjUXW+buEAdkgV
 81/sOChnd6x1HFINmwNOI5SX7oJD2P+6DHIkfq2w6tn0r15DB0C9VSHVrpHRHoJiNthpX+j0z/o
 xjeAxaVU+2YcQcA/oSwwxw4hrlPEiBwGbnhPuCnnm6EwQ6elI8k1XMKuZ+Cig5HQ9fJODJGO2lJ
 Amx0fdvAgytsJLOXcjdG5eHNI86OghukwpPw/zdB58EHDA5J9VhJkQxbSBMdGWR4vn6cn2Lw53J
 EwTMzeeJ393r5xP1nIgoOczSa7Hy4uhA/fYc=
X-Google-Smtp-Source: AGHT+IHfSCtJnWPZhkF3i/O/FPP1cmMNaZYqg+x0TH5D5y2xcVY2qeUiFmMot6awI8M9skg73uzcxA==
X-Received: by 2002:a17:902:ccc6:b0:224:255b:c934 with SMTP id
 d9443c01a7336-225e0b2750dmr15660005ad.51.1741931682985; 
 Thu, 13 Mar 2025 22:54:42 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (sp49-98-234-101.mse.spmode.ne.jp.
 [49.98.234.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68a8574sm22846505ad.86.2025.03.13.22.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:54:42 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, ashok.reddy.soma@amd.com,
 venkatesh.abbarapu@amd.com, Hiroyuki.Saito2@infineon.com,
 Shinsuke.Okada@infineon.com, Daisuke.Nakata@infineon.com,
 tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/2] zynqmp parallel memories support for Infineon Flash
Date: Fri, 14 Mar 2025 14:53:35 +0900
Message-Id: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Some of Infineon SPI-NOR chips use vendor or device specific commands
which we need to take care for parallel memories configuration in zynqmp.

Tested with Infineon S25HS02GT flash and AMD EK-VMK180 board.

Takahiro Kuwano (2):
  spi: zynqmp_gqspi: Make WR_ANY_REG opcode not use striped access
  mtd: spi-nor-core: Rework spansion_sr_ready() for parallel memories
    support

 drivers/mtd/spi/spi-nor-core.c | 37 ++++++++++++++++++++++++++++++++--
 drivers/spi/zynqmp_gqspi.c     |  2 ++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.34.1

