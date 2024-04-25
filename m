Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922BB88E8A;
	Thu, 25 Apr 2024 06:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKfQJ6bU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3268C88E8A; Thu, 25 Apr 2024 06:53:43 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B4B8803A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5aa241232faso463596eaf.0
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714020819; x=1714625619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOXzfwbFEAejy6AbYA9OdGQR6gy22fYdZyBx7cCJ4ug=;
 b=YKfQJ6bU5bVrwT+Y/OmPaxODgtWP1wYbNryCdHBvlDptGWSJLnrHIywM3VADdvTPN+
 HHHQRDKMGHM7Cg+ChtSF9a9H75pLy+PJgfnfmIbhppliA5oO3wkVvZnKjYWRKUI1j+0p
 ec5fvBWEnygXoy0YJqrQhv0W+zwvGhYhKHWQmK2r1jEuZgBr4LLj9SNJfhq/NRfChfHb
 azCw+zYoQKFMfE+orVn7dXkJKqFreNnDLvhbO5fLgJDbz9UEy67j3UFdzW0zgsvwlivb
 JBUSND75vt3UHMrxBEzZwtzWDWmiCwE3rriknwVrfHCqCUj75LIgghjV5EHTmZsIYaL1
 Pu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714020819; x=1714625619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOXzfwbFEAejy6AbYA9OdGQR6gy22fYdZyBx7cCJ4ug=;
 b=u6As40nUDFQP78WnzCs6OYIBPvPQP3rq0Kv0OmHMGN+Zf/N/BurU5lfykPFtssHYIz
 MxuWRDusKFPl2hjxJd+h9v+yXPRK0nX1HI5Rj78WXIoJ9ZltwR2+eK8oIWrMJog2Nxmj
 6ohxSZrSQBke/Wmbeqs1S+qFgDhBYke6TrczrWBTz3TEX1EnApj5XtFBYI75ux5aq5Uz
 A4NYTH1l4X3Lu3IWk1Qdp1wPQy2Y9tvd7hNz0PFpsXH9MsLPFh0Ks+GzDvmrU/zT8K/D
 /6xojrlyVqG3mMfJGrd0I6HQj+BUYbD6IwPEEGYpQLluhZfcenLTVDNsre63bKqR8t5d
 TXOQ==
X-Gm-Message-State: AOJu0YzxSHdkQsWTHJ9+S9ecKgqHUaRanbfMJW1rRtc6bjlQbFhglswN
 2mobf95BmVyVqCVtyMHvk3wo+IbQbr5ueopKFSxStS81finN4ZfVCsBgqQ==
X-Google-Smtp-Source: AGHT+IGexUyezbVsIz6cuHJefroPg1hamUheu3fXkK3jHpQMvbsXdBf1JXVlwwzhDMJtSoYfOlzXjw==
X-Received: by 2002:a05:6358:38d:b0:183:ab13:faaf with SMTP id
 a13-20020a056358038d00b00183ab13faafmr5083553rwj.7.1714020819030; 
 Wed, 24 Apr 2024 21:53:39 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 p22-20020a170902b09600b001e7b7a7934bsm12754513plr.107.2024.04.24.21.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 21:53:38 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 d-gole@ti.com, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 0/6] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Date: Thu, 25 Apr 2024 13:52:10 +0900
Message-Id: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
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

This series is equivalent to the one for Linux MTD submitted by
Pratyush Yadav.

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

Changes in v2:
  - Fix an issue in setting macronix_octal_fixups
  - Rework fixup hooks

Takahiro Kuwano (6):
  mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
  mtd: spi-nor: Allow flashes to specify MTD writesize
  mtd: spi-nor: Check nor->info before setting macronix_octal_fixups
  mtd: spi-nor: Replace default_init() hook with late_init()
  mtd: spi-nor: Call spi_nor_post_sfdp_fixups() only after
    spi_nor_parse_sfdp()
  mtd: spi-nor: Set ECC unit size to MTD writesize in Infineon SEMPER
    flashes

 drivers/mtd/spi/spi-nor-core.c | 88 +++++++++++++++++++++-------------
 drivers/mtd/ubi/build.c        |  4 +-
 drivers/mtd/ubi/io.c           |  9 +++-
 include/linux/mtd/spi-nor.h    |  1 +
 4 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.34.1

