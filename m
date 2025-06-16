Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB39C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DA782A0A;
	Mon, 16 Jun 2025 11:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RTdjeOM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50CA829F5; Mon, 16 Jun 2025 11:44:51 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0D980C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so2423377f8f.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067088; x=1750671888; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wdsH3zh6R5sAcOzBTMPiEqD+va3yHRdhckxXVr5nmDw=;
 b=RTdjeOM4K7/WrMUtemIL2q8jffUHP30h+tvOgXAyphVMCWUB91cRDZQYjBaF7HCfUE
 vxsH25xqmiSmIdZ9PcWZD6NAgpy+BhviUQaTyeljNj0WqHkGriigLGuNYjf7ExGLk4Qg
 Mh1ufsNbN4H4OsNzCGOy5LGko5ko3RZh2oYcCs29/8pOvG5PU0VnqMmuf6vm9++FJ0I2
 EuuDFHCd9XqZUvzpdBjZo9a9c8bYVDVatflmJ+Ek9F2eG/RH+h9PVurfV1t3+czUdeiL
 4GnwIDIKpZydscFb0ltjRbvZDM1rrRuNwHT3pXGG9ms1SQzEukzQjQ1EytNWeEMhciiN
 jHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067088; x=1750671888;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdsH3zh6R5sAcOzBTMPiEqD+va3yHRdhckxXVr5nmDw=;
 b=koidtsYCYU6DpMuEQhFIQ7HZ+H8TlyZlfHxLM2j2aCMTv/pWL34YvsaEjvnMgBA6o8
 YtbiVDr0qxLMNnWDk8eoGT30SpFXZhd55OZLoQenhVgMQBrRiEzgEtOIFKBdOcBGeXNt
 4kdNaT0Aqt9BrHMwo9PCg1JoabI61wc64KW93GeohWD/fLSwkL1d9xwy5kTUv97cyPWI
 BAH/8CuE4o3QrYOWCpCVnDCK47ZQTVu6qytPOIYA1EJiw42qBg0DtoktQUfymGuCfGNq
 sXiBndETTObvBH7p2BH0yIHllMwCMx/nfoh0o7/AUzRCM8kM3jgAPJojUzDu/2UKWEoV
 caXQ==
X-Gm-Message-State: AOJu0YyUWs219d3oVQiOuOhERDLfsBlDh8BjpbnVgLFvY/YbhDamm4WB
 Ylpnx15mSV7K79TXqzNsiG4TleMTJp6HI2FSBp7L6SnkQmNJUoWycG1D1VIr6R51nzY=
X-Gm-Gg: ASbGncvudZ6T1qgrOH92LWgPGsWF+CrtSvPM1Xmq9nQ5stEwmKldh350ZYxPbMuXkvO
 yrjPaQ5zghLAhwD9ZtGcHEWGpFDz/X6YZXiLYlAwClQynPF6IrDfcxOl4zW1Z4gG3CnHjB3FLIj
 IyPdWL+D/lsBPxg5as6NmIY1kI2dsqwqWLYP/drspeHjQcsRYxHRep0dJjbTRtzhDLsejIDOAoj
 EomoCboOg9NlGDI1BFICs1JNiM7/j46E+qTZe3etXQSdBFBOq54dQmXxIx+xINkUFgej0LzJnjS
 lS/7MarphFlf0Ih1HMqd44zl9v2OltaJIoCdfwUVzA+DGRqsbj7XHQ2CgJSUbeq18iVjAUVdZWL
 kaJQH
X-Google-Smtp-Source: AGHT+IEnq0pmwgE+CWW7lNbz/6kIWbZdiJvNbIguJ5CLWJ83P2BdhlAsKKCUlf4ewPdP9NUFWqdLkw==
X-Received: by 2002:a5d:5849:0:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a5723aeb2cmr7224146f8f.39.1750067088505; 
 Mon, 16 Jun 2025 02:44:48 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:47 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 0/9] Qualcomm: implement support for GENI firmware loading
Date: Mon, 16 Jun 2025 11:44:42 +0200
Message-Id: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIrnT2gC/22P207EIBRFf6XhWQzXgWmM8T+MD1wOHWJbFGrVT
 PrvMkyi4+jjJqy1co6oQI5QUN8dUYY1lpjmOsRNh9zBzAPg6OtGjDBJOBV4gDniMRmPwzsm4Iz
 gLAi9d6giLxlC/Gi6x6fzzvD6Vq3L+RFNUIpp1r67+5YWp5gmeEoZsBuTey54pZhgMF4KoZXjG
 h7GOJucblMe7k8ta0r9nKYpLn2310RyRn3wYNGpfIhlSfmz3bXSlv7/hNaRWgUmA9OUhYtOM63
 sh95RckWzSitn/M46qr0lf2h+SfMrmlfaglLacksJtb/obdu+AArVFeGfAQAA
X-Change-ID: 20250314-geni-load-fw-0eca432f489c
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3967;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qoKIq8VKw3yy7SRrV//rRt0hfgriV3oexSplXoTbZN4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eNaXpxb+ivN7n3LRpOKPiLiVi58ow9SkQJE
 WbIcyCz/06JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njQAKCRAFgzErGV9k
 tjwMD/9Fugr7MUxK0sndSoDT7JwEimL2UxfYSDFou9/IUNFovsFDFIClk385o7qjuWa2dmbLDIh
 f04uKwuixcP/7JblEsGVylQqDb6fhBrIJQGh619mC0Nhji5AVrlVmJu9+TMfUBNf9G7JWqltpr1
 l2XYzYSQFzr97QvMe+3dkQUsm+Ixdt2W98QZaiyNE/ZnX0iz0pedYaEGYCNYfIPZz8o2AkOEqIK
 GFBC6LxctT0cgl3nSud30bHoa2QuO8Oqu5RziRREMFqdZfeMo/l1tSkfaw438fuZRJE6u+js7iI
 fwjRfUnVs9YKVLKhUx9V9/p4/8pKv5y7HFsrqZnYcEuSsiik+VHbDjPjbcrFwfK4WSwk+gpMUCh
 oa1PWdL3JMRsw2joyVxuF2zhtXNpIMmqI8KdC95gHdfvaEA2Hi/pTEtmiwk9/qyrTw6LHp2DZQ3
 LcZJIWwrTK448LE175pSY6jd5tB+iLCsvlfFWOSzqO7TfEMXRAuAwMj4K8LXrsBWQM5ROpCO7I7
 /N8WQ03ISWhdm/SJQWgPTu4f61HZcBVtaGscCEyCH3ZPKXkztwZfZZOd+ZE/C1zHiPciwPgvPRc
 fWOMbIkSBwuNL5KFm/0yLemhaWDxmnQx/xb66HgaVAafQVxM/UsdliXOJQ9jcoyHbQ9IN1HG/Ac
 jtAW+yVoK0GFT2g==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The GENI block on Qualcomm platforms contains many Serial Engines (SEs),
these are general purpose hardware blocks capable of implementing any
low speed protocol (UART, SPI, I2C, etc).

The protocol implementation is provided in the form of firmware which is
programmed in to the peripheral, typically by the EDK2 bootloader. Up
until now we have primarily been chainloading U-Boot, and therefore
haven't had to deal with this problem.

However, when running U-Boot as the primary bootloader it is necessary
to handle loading and writing the firmware.

Support for doing this in Linux is also in progress [1], this series is
largely based on that one, however the Linux patches expect the firmware
to be provided in /lib/firmware, and will only exist on newer kernels.

Since we may want to use peripheral (e.g. EEPROM) inside U-Boot it is
still useful to implement firmware loading in U-Boot.

The approach taken here is to bind all peripheral devices which don't
need firmware loading (e.g. the serial port), then wait until
EVT_LAST_STAGE_INIT to handle loading the firmware from storage and
probing the remaining peripherals. We forcefully probe them so that they
will trigger firmware loading and will be available to Linux.

For testing on the RB3 Gen 2 [2] is needed so that the i2c peripherals
can be probed.

[1]: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/
[2]: https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org/

---
Changes in v4:
- Regenerate qcom_ipq5424_mmc_defconfig
- Adjust Kconfig so that peripheral drivers express their dependency on QCOM_GENI for firmware loading and update the defconfig
- Add fw loading for UART (e.g. bluetooth) and SPI
- Link to v3: https://lore.kernel.org/r/20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org

Changes in v3:
- Replace printf() with pr_XXX() in geni SE driver
- Add firmware loading for UART as well
- Link to v2: https://lore.kernel.org/r/20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org

Changes in v2:
- Use GENI_SE_INVALID_PROTO in geni_i2c instead of 0xff
- Fix typo
- Link to v1: https://lore.kernel.org/r/20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org

---
Casey Connolly (9):
      configs: run savedefconfig on qcom_ipq5424_mmc_defconfig
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required
      clk/qcom: sc7280: add uart7 clocks
      serial: msm-geni: implement firmware loading
      WIP: rb3gen2: describe micro-usb port
      spi: geni: load firmware if required
      configs: qcom_*: enable QCOM_GENI where needed

 configs/chromebook_trogdor_defconfig            |   2 +-
 configs/qcom_defconfig                          |   3 +-
 configs/qcom_ipq5424_mmc_defconfig              |  69 +--
 configs/qcom_ipq9574_mmc_defconfig              |   2 +
 drivers/clk/qcom/clock-sc7280.c                 |   6 +
 drivers/i2c/Kconfig                             |   2 +-
 drivers/i2c/geni_i2c.c                          |  14 +-
 drivers/misc/Kconfig                            |   9 +
 drivers/misc/Makefile                           |   1 +
 drivers/misc/qcom_geni.c                        | 578 ++++++++++++++++++++++++
 drivers/serial/Kconfig                          |   1 +
 drivers/serial/serial_msm_geni.c                |  81 ++--
 drivers/spi/Kconfig                             |   2 +-
 drivers/spi/spi-geni-qcom.c                     |   8 +
 dts/upstream/src/arm64/qcom/qcs6490-rb3gen2.dts |  17 +
 include/soc/qcom/geni-se.h                      |  36 ++
 include/soc/qcom/qup-fw-load.h                  | 178 ++++++++
 17 files changed, 904 insertions(+), 105 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e
change-id: 20250314-geni-load-fw-0eca432f489c

Casey Connolly <casey.connolly@linaro.org>

