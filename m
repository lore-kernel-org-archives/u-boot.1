Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2907C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 08:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83ED8717B;
	Tue, 24 Oct 2023 10:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EH92Vw77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA478716D; Tue, 24 Oct 2023 10:38:32 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C8787188
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 10:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507ad511315so6221898e87.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698136707; x=1698741507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPgpIpeSBmuPUbjR+RurV8RufmJIZnBw9Atoit9w0SI=;
 b=EH92Vw77CNXvRwrYL7xNW8+7oTikxokb85WysH366EekJYdfBbhSQudimNla5+ioRk
 0zvlUgEAzrR/aSfOYDti9F9zpUgilB6nZL82nhzx0BSSCerUdy4umPxaixl3vDjHWj9l
 R0GoPq5lZdyTbBGIEREsuud2hmAeTsNVqETSfYjwt9lg7mH1J78IFDNhb614iPUiaIwa
 BK333oG2VqoM9WtM86w7XPRFx0hLJ3Pbu7D81ydiBq8O7At0R1GaKZrzV5dlVQM6bfOk
 arshxY1jgHV0e4zer20Qf0qQEzGQfULHart7dp9hwvl+QBL0BTzibiRkQnabQGiVtWEC
 /9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698136707; x=1698741507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPgpIpeSBmuPUbjR+RurV8RufmJIZnBw9Atoit9w0SI=;
 b=fvQ/ehdnlcX7WV5TykQiH/xVWCRjV5ViySYUJDILYhg2Ep38BpkRpn3BTNCdXbhhKm
 nMGm1d5vI3bkvn/V72qxf22yEfEy3Dy79H4bhQ1LVJCfJK78+RBweK4nB6MuJV0uIVFy
 GeWu/e/E00Dkb5lWf3uTMQ/79LSp4njR0ZamzalHRrhVC5bhh/9rGd5SrVkYpLTkSAX/
 4MIqYRPVBSL3BTfSBSCUrX4MmuWBLwuLtBytsXzr0eFT70KqAqr+6JaGJE5vtx7rpejj
 Kc13xQ8e84OOpMGAMQipztcYYuoHbT8HuXThjUKPNACNSOW04akhL68ueloAQRcz1QND
 F+tg==
X-Gm-Message-State: AOJu0Yxdo8WhnJfx5Ug7QmoGO6S9G6AzttJdnrVjKUMHPoAEbvetSnti
 fWwH8NKqAwItqdi5Af/J5Ts=
X-Google-Smtp-Source: AGHT+IEGQaXoNzrtONrYG3/BXAbEb2oIIwyx1KpILnONifE73LGBo1ZbKwTK+8LJsbtZ4cLuTWub2w==
X-Received: by 2002:a19:650f:0:b0:4f9:586b:dba1 with SMTP id
 z15-20020a19650f000000b004f9586bdba1mr7281034lfb.4.1698136706682; 
 Tue, 24 Oct 2023 01:38:26 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 z10-20020a19650a000000b004faa2de9877sm2063304lfb.286.2023.10.24.01.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 01:38:26 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] Implement GPIO cells for PALMAS and MAX77663 PMICs
Date: Tue, 24 Oct 2023 11:37:58 +0300
Message-Id: <20231024083801.202365-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This patchset adds support for gpio-uclass to work with pmic gpio childrens
properly and implements MAX77663 and PALMAS GPIO cells/children as a 
reference and to be further used in devices I am currently maintaining.

All drivers are tested on actual hardware and confirmed to work as
expected. MAX77663 GPIO cell is tested on wexler qc750 tegra 3 device
and PALMAS GPIO cell is tested on tegra note 7 tegra 4 device.

These patches require "Add support for PMICs used on Tegra 3 devices"
patches to be merged first for proper work.

Svyatoslav Ryhel (3):
  drivers: gpio-uclass: support PMIC GPIO children
  drivers: gpio: implement MAX77663 GPIO cell
  drivers: gpio: implement PALMAS GPIO cell

 drivers/gpio/Kconfig                |  16 +++
 drivers/gpio/Makefile               |   2 +
 drivers/gpio/gpio-uclass.c          |  19 ++-
 drivers/gpio/max77663_gpio.c        | 179 ++++++++++++++++++++++++++++
 drivers/gpio/palmas_gpio.c          | 133 +++++++++++++++++++++
 drivers/power/pmic/max77663.c       |   9 ++
 drivers/power/pmic/palmas.c         |  10 +-
 include/dt-bindings/pmic/max77663.h |  18 +++
 include/power/max77663.h            |   1 +
 include/power/palmas.h              |  12 ++
 10 files changed, 395 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpio/max77663_gpio.c
 create mode 100644 drivers/gpio/palmas_gpio.c
 create mode 100644 include/dt-bindings/pmic/max77663.h

-- 
2.39.2

