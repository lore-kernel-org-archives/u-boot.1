Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F761D2FFFD
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A2C8909E;
	Fri, 18 Oct 2024 14:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VjyK2A2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B87890A9; Fri, 18 Oct 2024 14:29:22 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84CE89093
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 14:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cbcd71012so18867355ad.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729254558; x=1729859358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mv1dUUy6W0ucI48bJc1E2+kqCvI8fcQdvxeha/5BbOg=;
 b=VjyK2A2JzXQRC49mjptYmnPu/Me/qYAC5S3pxwUSaRFoFESjao83knlgsSgStIvT71
 BYXo4Kw7rYuF3r/kT9EsRGOWvi/djgWbHVuvfQMEIBr0IaLnepCsGwyUEM2hg6TP4FEz
 Iy3ImJLFjzVb3gUyY00KGAMJclrF6Su+BnRHXNfI06B9XmQSaGkIC9ELCXxN0MkS7//j
 0/g37PBRynSOMV45O28Mnb35dB8y2Z/sbGKMmu19m6vpGahl8fa7EHPZaXdd0rfy/p39
 UntRglzm2/Wo2od3HIveHFXo6Q2tVbx8wXCe5xTyoENczn1WWGWs+RW9cL9j26hkxUx1
 Rzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729254558; x=1729859358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mv1dUUy6W0ucI48bJc1E2+kqCvI8fcQdvxeha/5BbOg=;
 b=e+xMcnqvK3vDonI08nnKbdcAgHjAaMjLkLWm9LmJYGm4K3MU+eykDGb0DD33a0LhwS
 z6vbVLAkPC20YQaT3VZ5uihzsEM7/K9csxBzGD9ozU9HquQzapl0W9WJ/ecDiX3mtgaz
 trSJwF5GOZnS6ebAxZDpOtdwFQ1LH46jZTbs5tTWnhiZpJVS4vxijxZLGnTX1G7+5Mxn
 PjSFWtBc8uUUQmFXBvZ4g3ebQXJZ6jNI2Z4wCAW8hbhPCGpmqAY1ece87N/B1Fr+/D+e
 xTtet4m4oMbetxCK3tbOoCowXuO7vZFuuBtk1G1snOCslGDX/w8kmFnEhtHgaSWuE/xF
 KMaA==
X-Gm-Message-State: AOJu0Yz5h1UEuiXmK5+3NGyks4vAVWbUmud64KVQKFJAzG65SvQ+Yyuh
 tTnQVE+ovJ3sX7LlMquHKlNY1KkrGsPqVtPbrNZ8t8RTswqZzmZiekiHhw==
X-Google-Smtp-Source: AGHT+IEos/JxUFw4h6dJDPUya3VOuEMCqYpBUZ2iW8lJYAWHkjozIAUNLXAQmxhwGXd0a0v32+vqNA==
X-Received: by 2002:a17:902:c40c:b0:20c:79bf:6793 with SMTP id
 d9443c01a7336-20e5a70d626mr21279925ad.3.1729254558372; 
 Fri, 18 Oct 2024 05:29:18 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bb8f:5e95:1838:b1fd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8f73b3sm11563975ad.224.2024.10.18.05.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 05:29:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20241018
Date: Fri, 18 Oct 2024 09:29:14 -0300
Message-Id: <20241018122914.251188-1-festevam@gmail.com>
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 608a31bdec6284ad6f821226e4c62c9cd3052874:

  Merge patch series "Introduce the lwIP network stack" (2024-10-16 11:11:57 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20241018

for you to fetch changes up to fd3f2e3f0edc1f87be4c5a39a0c81037d551c069:

  cpu: imx8_cpu: Avoid revision to corrupt device tree (2024-10-18 08:02:30 -0300)

u-boot-imx-master-20241018
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22796

- Switch to using upstream DT on DH i.MX8MP DHCOM PDK2/PDK3.
- Add ability to build fallback DTBOs from arch/$(ARCH)/dts.
- Remove fdt_high and initrd_high env variables from imx6-dhcom.
- Add dummy clk for imx8.
- Fix DT corruption in imx8_cpu.
- Improve DDR stability on pico-imx7d.
----------------------------------------------------------------
From: Marek Vasut (1):
      arm64: dts: imx: Switch to using upstream DT on DH i.MX8MP DHCOM PDK2/PDK3

Marek Vasut (2):
      dts: Add ability to build fallback DTBOs from arch/$(ARCH)/dts
      ARM: dts: imx6-dhcom: Remove fdt_high and initrd_high env variables

Peng Fan (2):
      clk: imx8: Add dummy clk
      cpu: imx8_cpu: Avoid revision to corrupt device tree

Ray Chang (1):
      pico-imx7d: Increase ODT resistor value

 Makefile                            |   4 +
 arch/arm/dts/Makefile               |   2 -
 arch/arm/dts/imx8mp-dhcom-pdk2.dts  | 158 ------------------
 arch/arm/dts/imx8mp-dhcom-pdk3.dts  | 317 ------------------------------------
 board/technexion/pico-imx7d/spl.c   |  10 +-
 configs/imx8mp_dhcom_pdk2_defconfig |   6 +-
 configs/imx8mp_dhcom_pdk3_defconfig |   6 +-
 drivers/clk/imx/clk-imx8qm.c        |   4 +
 drivers/clk/imx/clk-imx8qxp.c       |   4 +
 drivers/cpu/imx8_cpu.c              |  32 ++--
 dts/Kconfig                         |  16 ++
 dts/Makefile                        |  14 +-
 include/configs/dh_imx6.h           |   3 +-
 scripts/Makefile.dts                |   6 +
 14 files changed, 78 insertions(+), 504 deletions(-)
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx8mp-dhcom-pdk3.dts
