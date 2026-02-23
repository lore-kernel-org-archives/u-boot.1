Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9113BEA4FC3
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 14:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675BD83C39;
	Mon, 23 Feb 2026 15:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZwjdvEK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5392F83BC9; Mon, 23 Feb 2026 15:33:29 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138F880077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so4385583f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771857205; x=1772462005; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=moSc302gAjDRrtUrWXAJWDcoxOudjLfjJ4Bp0OW9LCs=;
 b=ZwjdvEK1s0tqq5iIX7vXvUr+4whxZ63fqy07odqPideYaxqPTjuwWOhXL/PBibBjif
 dlDQOkrh1ozWqd0cp7y8xD4I5BIuck3vLYv3lfF5Xu4oIMYnfRdDjEyjrUaEGYQIztpe
 l9mqtWGl0Rf1isKBsi0oGAkf4+W4EEzmKgbC3DmyApzO8MZgBDmQlgj3HVL5MJdkCZfX
 12kElpjQTbq+kLk2hXcfkbXx81fIsW+fmGpH0dfpu7lVvc/IR92gU1H/slUxz6dlLSPt
 fgwJLi7VpX1hlpdhLjHYpc/TcxSKhebPDpHwwRHTQCRmPduDZjG8O0WGilHN6jBQ7u19
 3T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857205; x=1772462005;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=moSc302gAjDRrtUrWXAJWDcoxOudjLfjJ4Bp0OW9LCs=;
 b=lXDq2vCuMXqKUOxuokuq80rfJ6DoBdVVuec767vvPDEk8E+1L8E7lWYKsQC+KFEp13
 759sAWtArKncZVijlLjdanLlb3gs6HyRMIxAfVLfoWRIUYfFsE0sE/2voxWIWombWun2
 t1pfLu01weK8LC3y0NoJJteKZAA25sHC0rpw8yYk+Ab4Ib0pTINSxg2Ehj22xQxZ3PzW
 5E+BGVw8Bl0Q1QuQUwNGVpzu3sAiI9dZo4Nl7OqrB5C0tpmX3HTmcxmYZjFsoW6COB+4
 iKyVkzoEZmnQ2GvWk9zis6VkRFi1kciP8rb6DO5W7qTXuoCZ1JZgjSifOzjZeNVla8mr
 i2dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gWE1SeNi5cc+NUvfy+59q+owEPA0fH8x5eYnar3MXpdiQfZoHOobcpwtRuWVO4OU94HaAPw=@lists.denx.de
X-Gm-Message-State: AOJu0YyKDe9JxpiGE3Ox1PrtCPeOBb9Ko7afQOhPcfYjyK4tQuAspiE5
 Bg14/HuyfAEJyAA/4Tt6ManOMcK2TSUImO6OpVsmoIET3qys329gOV6U6cRHGIeOhts=
X-Gm-Gg: ATEYQzzTEgViXtHq/aiaoI5qm+HOt7istcvE3aah7MwRQTazPn756Kq3wZ3Utd0VYXa
 FFJTpsb1ePfI5LsD581VfxJ9+UIzOhxpYy20TPEwcpQYT1PB8E61qnOMBTERQ4xs/4u3LVKta/9
 koEj0cZJ0lpDctfMixHpWlHryqBn+W2/dhyFnxwWIt8EfbAjvSIZt1gfmbKtFk4P5a2y09887cA
 Mu/DjYha7LysTjBWiiFTmotowY6VaRdPVJtXWebynGKbarHjXC9LvuybSyEMoWUjKlmPua0lwPG
 ab8kVic88QGoV68njsu3BcIyLlUBXm12zRiQ62D3D7apdZnTkrWDk9qjVTn3RBA+rNeJe+A52tb
 lYuviV6Psytef6FKrxFZPeoe4Rep+2Cjlk9V+ldVaMIp3dOmMpBMsKQHRy9yk5J7kPrhEHlDzUc
 FXKhJDsJdQRyHiL3yuETiKjSlQuow//9HZ5KnIqwY=
X-Received: by 2002:a05:6000:2203:b0:435:add0:3d68 with SMTP id
 ffacd0b85a97d-4396f1856f2mr15972730f8f.58.1771857204217; 
 Mon, 23 Feb 2026 06:33:24 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970b703f4sm21374023f8f.0.2026.02.23.06.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 06:33:23 -0800 (PST)
Date: Mon, 23 Feb 2026 17:33:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>, Anis Chali <chalianis1@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>, Jacky Bai <ping.bai@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Yao Zi <me@ziyao.cc>,
 Ye Li <ye.li@nxp.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/4] u-boot: add SCMI GPIO/Pinctrl support
Message-ID: <cover.1771856828.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

There is an existing SCMI pinctrl driver in drivers/pinctrl/nxp/ which
lets you configure the initial state of the pins via device tree.  This
patchset is a more generic version which provides GPIO as well.

I wrote two small cleanup patches to the NXP driver, one which renamed
an enum and another which made some white space changes.

The next patch adds an pinctrl driver which lets you configure the
initial state for the pins.  But the main thing is that we need one
driver to handle the SCMI pinctrl protocol so the pinctrl driver does
this.

The last patch adds GPIO support over SCMI.

I tested this code using the SCP SCMI server on OP-TEE over Qemu.  I
created a custom mock pinctrl device in SCP.

Dan Carpenter (4):
  scmi: pinctrl: add pinctrl message IDs
  scmi: update comments for scmi_pinctrl_config_set_in()
  scmi: pinctrl: add pinctrl driver for SCMI
  gpio: scmi: Add gpio_scmi driver

 drivers/firmware/scmi/Makefile            |   1 +
 drivers/firmware/scmi/pinctrl.c           | 363 +++++++++++++++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c |   4 +-
 drivers/gpio/Kconfig                      |   6 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/gpio_scmi.c                  | 221 +++++++++++++
 drivers/pinctrl/Kconfig                   |   9 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    |   2 +-
 drivers/pinctrl/pinctrl-scmi.c            | 357 ++++++++++++++++++++
 include/scmi_agent-uclass.h               |   2 +-
 include/scmi_protocols.h                  | 379 +++++++++++++++++++++-
 12 files changed, 1334 insertions(+), 12 deletions(-)
 create mode 100644 drivers/firmware/scmi/pinctrl.c
 create mode 100644 drivers/gpio/gpio_scmi.c
 create mode 100644 drivers/pinctrl/pinctrl-scmi.c

-- 
2.51.0

