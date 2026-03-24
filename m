Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F5EF54ACD
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 15:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C29080517;
	Tue, 24 Mar 2026 16:09:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NhBrket8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F9382A9E; Tue, 24 Mar 2026 16:09:12 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 562CB80212
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 16:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so41562675e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774364949; x=1774969749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P8RmIok3yTkeUNcmhidDvRM1w4/Sk44GpMpVQEuqqQQ=;
 b=NhBrket8rgs4T1kK35T15hI/n4S5WpjBYADRtCi/hMeYL7PPFIPcX1W40p7WGzE9z2
 Z5a1Htm15Ix6zq7ai1eMVGXf6S59uooXYUklRbCrrMBZJKlHwHHYHpQvReBN5No1K0BO
 YADisIH1rRKnp7sesEbNIxKAXH61r1C9NYHsr5m57ID0+xBDAI+yGYEQQ2MeB8r2Ciaw
 VoHloZsB8zYG5G2te41TENO1p7VKAy0WFDk9Bf5oWtAax4krFa0SxjCreLtdoAj8ebaV
 UHdGrQTzE7e7rDdrh2RWj5uSz+CV4scM7v0WaYrWp5iye0+Bdogl2jjHcPLFchP3JTla
 Mr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774364949; x=1774969749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8RmIok3yTkeUNcmhidDvRM1w4/Sk44GpMpVQEuqqQQ=;
 b=aA5XMh/RcsgeYCA9ZPCI8BEzsLjkS8QTNY8wK54/qdBIrt/QPYURCvayzqhedsJn0w
 +t+156XP3dAqhnS5ca39Jafum/bGz+p6fIb3uK8tiBR40u2qtpblLzWFoIolDLs6Z5ml
 5+C0Yhpwxq6LffFoqh+4vLA35ytgJlQyFKhVE3B5YJr8gN7VNbhDnm00ilcTNEXPiBu7
 tZIrWW0Oa7B+ntOqjqF+LIdb01nkwzk8GD/T5fcW4GRGky5O3T/wTk8Qwr1487avyfJN
 RkVBlIZa1vQoTNjT2RCgI8OujdavVUSEW2Qg3RIkmjVxT69/wVP4FucUS5Q1zPVeIE2x
 xSAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFzJKtt7u+/5zKt2UC63e4tULeI40ScGneJ6xv9v9ku6Vyjjeg1zG+F1g9UHm7vqnpnJlo69Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwdacLG7c3AWkHD1uucewO27lpigug6lytHHAx2EQLDhQIjjW7S
 DlK871X3rpxRNUmdDLrxUIS9ZybkisKZ/02XYvSyaVHs2a/U/KKSyiT18b2MgYNdcQ4=
X-Gm-Gg: ATEYQzxZbR7a+Z+JLr8i7bc4SVXR1Obst1WPWd1VXQr96CvTNxhs6MILIDYC+AM9mhj
 1uWuyN4IFqoHXExJcN6wSJmL8j5hKVC/sB1omAjsMnQ8lt1eYS33+u42u5mv00i6FVSJ+qxjFuz
 LzILpQrDiT+XabwhLyYhfPFdSaCh9jcboSTS3T9/CoKuhz/qUI4h8FdUCVnbpMVMm+ZdS8ap9uQ
 aRaq0Y1iz6CiIJOAIgXihFfOiVUGtLggl2dD57PJkvb1ztUmpBJh1aQmT2sFpgkvp3LHFKoRzPO
 4IzIm6wdiKdfiXt+Qf/kaJ9IyYCsrcyr8IaNf1oeGwRiZ9WUG8dFaf8jiDGDY6bdcXF6VKv4yrC
 oTJC5gx9OLQ0wXHcmwkXM0aHzgmUfeDc8e5uWuxPB9/pA6enQ+Yw8JlT4my5BXlsRRSnVl0yXGp
 0ST+91mvBhh+2IjvSjT+4StiKcFhVUCl9qVmVoGm53YDZ+oSKCWBC4cOW6o2YnDJqmV4TyePemH
 g==
X-Received: by 2002:a05:600c:1d19:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-4871605aa27mr1613445e9.22.1774364949375; 
 Tue, 24 Mar 2026 08:09:09 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29eb0d.dip0.t-ipconnect.de.
 [91.41.235.13]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116d82e4sm104870775e9.12.2026.03.24.08.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:09:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-fixes-24Mar2026
Date: Tue, 24 Mar 2026 16:07:34 +0100
Message-ID: <20260324150903.3786680-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

These are minimal fixes that should ideally go into master, sorry
they're so last minute. The watchdog patch is the priority, if you'd
rather not risk taking the others I can queue them for next instead.

Kind regards,
Casey

The following changes since commit eb95914b9f5886b7ca0eaa2dbcd8a66bb8e5f81a:

  Prepare v2026.04-rc5 (2026-03-23 14:19:17 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-fixes-24Mar2026

for you to fetch changes up to 1cf505e51b49438271f4b36a648b93b618f13a8e:

  watchdog: qcom: stop watchdog by default (2026-03-24 11:51:52 +0100)

----------------------------------------------------------------
Balaji Selvanathan (3):
      clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK support
      clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
      phy: qcom: qusb2: Add QCS615 QUSB2 PHY support

Casey Connolly (3):
      serial: msm-geni: allow invalid clock
      qcom: rpmh: don't error for SLEEP requests
      watchdog: qcom: stop watchdog by default

Tom Rini (1):
      power: regulator: qcom: Correct dependenecies for DM_REGULATOR_QCOM_USB_VBUS

 drivers/clk/qcom/clock-qcs615.c   |  2 ++
 drivers/phy/qcom/phy-qcom-qusb2.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/power/regulator/Kconfig   |  2 +-
 drivers/serial/serial_msm_geni.c  | 15 ++++++---------
 drivers/soc/qcom/rpmh-rsc.c       |  8 ++++----
 drivers/soc/qcom/rpmh.c           |  4 ++--
 drivers/watchdog/Kconfig          |  1 +
 drivers/watchdog/qcom-wdt.c       |  2 +-
 8 files changed, 55 insertions(+), 17 deletions(-)
