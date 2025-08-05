Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A7C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 09:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 597F981D5D;
	Tue,  5 Aug 2025 11:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZpzbGXby";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23F382AC4; Tue,  5 Aug 2025 11:19:38 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D70801DD
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so3399634b3a.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754385575; x=1754990375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tw05F9u5YSD2lfBEiDUzlzsp/HUQPZUD6MsLWW9gFw0=;
 b=ZpzbGXbyJBFv2engiBn0pwdJsW5IcwV9L+x3cfCj0ezF8szUxTM7IQeL55PEoL0Zd2
 wJlfs7ol1Etzg74QN6+um6WEbMZ1aJvCTwEgbSRXRKr1QkrFLm0FZqDQuanBsoxopsCN
 d04DbRU3Q520ripfPB33C59DxlHfL4frNJfxyilJaUeYDhsJViOD7P3vgCkYb/PUktyT
 qKtSo5+DNYVZJ9hp9sjmgyNfh4OSfWSQf2x9/eajx/EZwsFEKECSQqfB1j7/4Xld79ai
 FBkKqm8KbmYuTENUCIO1B5FqH8VQ2j4FAJbQz4atZONizxlK/HfceuxAyNaV84nfWBOt
 0Gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754385575; x=1754990375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tw05F9u5YSD2lfBEiDUzlzsp/HUQPZUD6MsLWW9gFw0=;
 b=wqvw6c96SupoxufFUMjzz+DOhCBD9pWMC/7QbV7M7pAyj3VgwIi8/RHWuJNZM/je0z
 T/b0uc+pRMJJ92V+EFK3jOeoSgeGc+ITRk96IdKhq+iyiL77wCKSZr6+59vmr0VgiyqF
 4J8zofZSl10t9os1HfX4yPZwEH2Cj3ZwlkK83UgAeC8R2wg/000exL2qePX/6/VQR1Fw
 4gEt9edP0vKHKNe889uUL2HMah3Ej3yEofilZA4L/KktlQXk8ew2it1qy024Rk2FaQ0L
 wgAxKjJA3uBYCWStawTaF62srTUfNjSvBJAuliWOpvLWL9+dxKVrjiySI8qQaQmLR0IS
 L+SA==
X-Gm-Message-State: AOJu0YygVN0suLjk3s9uUcYBf2Mu1c0ichzg2Xm1Ouo0aDxyF6qxqu9f
 L+J0ojnOy+7WpU6kzhUVfHfbL9rK0lqa6OXYnj+dr8UMnNdQYG2FwnbO
X-Gm-Gg: ASbGncvWH9HevZ4yipNbD6xO/UC7CQ8KY29sjhWtNwgxLnbnnICXK+UefnMpksKvw/A
 hevb/rko7xw4+3VEWwyH3Ih0YJpl8Gc93ywhEIU4g8N+vzQRABlQdNegikwTMdgSsi/phFdDzc8
 FiVOKBqkRMtKrxN1Udy5G9qtOmozF81zpBOiG6o1SK2i4w/0lLpoT1ce+lRocVnqInnqfuLVVEW
 TxLHPnnVMktIdQgyrqGCeKbpJYYrDJNtPaXRKCdwvlRAdS2HaD7uimm06JigY3NiDeQEGX9ElZe
 A6qvS+zcmkh6ZhYIPa7oi2HZxohVKhJUahcD+U3ub8bLeSHCYEYHaD4Lt4Be/0muWvMFtUmH94X
 kZudPKPeGkZdrxuRaSYS8b9mAS1EdKy1i6A==
X-Google-Smtp-Source: AGHT+IHVAlAYytr6Ng6KAiSAn2QXh403gSwhgNuDq1PF5ES/dh83xncRi9yAsKVQj6MjPeO91tWQqA==
X-Received: by 2002:a05:6a00:a21:b0:742:a77b:8c3 with SMTP id
 d2e1a72fcca58-76bec311399mr17127509b3a.4.1754385574532; 
 Tue, 05 Aug 2025 02:19:34 -0700 (PDT)
Received: from cs20-buildserver.lan ([2402:7500:400:60db:2e0:4cff:fe68:863])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce89125sm12495185b3a.33.2025.08.05.02.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 02:19:33 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, YSCHU@nuvoton.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/9] modify npcm7xx/8xx feature and bug fixed
Date: Tue,  5 Aug 2025 17:18:41 +0800
Message-Id: <20250805091850.2051096-1-JJLIU0@nuvoton.com>
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

modify npcm7xx/8xx feature and bug fixed

Jim Liu (6):
  net: phy: broadcom: add support for BCM54612E
  arm: dts: nuvoton: Change timer node
  net: designware: Fix get_timer value overflow
  misc: npcm_host_intf: Add Arbel eSPI workaround
  misc: npcm_host_intf: Disable pending KCS/BPC interrupts
  configs: npcm: remove CONFIG_SYS_SKIP_UART_INIT

Stanley Chu (3):
  arm: dts: npcm8xx: add pinmux for VCD input
  pinctrl: npcm8xx: add support for setting VCD input source
  i2c: npcm: fix consecutive dm_i2c_read/write error

 arch/arm/dts/nuvoton-common-npcm8xx.dtsi  | 15 ++++-----
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi  |  4 +++
 board/nuvoton/arbel_evb/arbel_evb.c       |  9 +++++-
 board/nuvoton/poleg_evb/poleg_evb.c       |  2 ++
 configs/arbel_evb_defconfig               |  1 -
 configs/poleg_evb_defconfig               |  1 -
 drivers/i2c/npcm_i2c.c                    |  7 +++++
 drivers/misc/npcm_host_intf.c             | 33 +++++++++++++++++++-
 drivers/net/designware.c                  |  2 +-
 drivers/net/phy/broadcom.c                | 37 +++++++++++++++++++++++
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  2 ++
 11 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.34.1

