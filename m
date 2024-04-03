Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3515CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB19D8838C;
	Wed,  3 Apr 2024 14:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KohouVSv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A36288387; Wed,  3 Apr 2024 14:07:52 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0009188238
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d700beb60bso104780501fa.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146069; x=1712750869; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7pYbPx1vk+XqBgc3hGNtUy53R0kIt4y6U+8OA+/aqbo=;
 b=KohouVSvXi9qZWjsKufFxAS756E1EHsfAvcAMINKoJJ70JMdPShdYwDeI+ncFan5f7
 mixXR8lwr/8E6gKJ0gACnDRb/1EPhNnnZix8oLCHvoucuppDN6sNT/5RC3ic5n+wT7sH
 7nyoFnHSieXJl2YUhuQUTi4ZIssDcD8CNJmLjaVKvkqDQtxQLg1TaN47zeX2fx6HiR+C
 e6+ySQLNNfe9hI7337waYum0G10avJboGUZ9k341BqRmVsrUL8NRlSrjVcUjiDclkbT0
 Vat81AewXq9AbFkDJebYHdUNaIzAu/De2oucevEhEVldGdPQza58qlGmBiHLSNJPg3w2
 fIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146069; x=1712750869;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pYbPx1vk+XqBgc3hGNtUy53R0kIt4y6U+8OA+/aqbo=;
 b=KnrZtLDKlrtV63ZZURa2u79+9L1Qqw6amwU7jzw7v+aOxdxTtrWsnDyaLQoAyzlcWj
 gpqBBNl3mS2sd+55olRS6KzBHqmbQj0lKZOZ2oXLQIUvWQWORQ7jqLddXjYSRpTVQuVn
 dqvEW06N5GH09PZnT0cCtlz5XheIq9ScA01qRJqhqdlvHC833XjOeR3ozbOpLUkWVqqH
 XsOHo1y7Ntnzrb0aHR+JgPKdd9m3lrfn6OK6vmt1zH1dltjnfT+sAt+ypVLlerhclmYL
 JqJcxTpGGix3R6c/306jGWNAF5DXTL1X6m3ATNpRbQyNunvl83Ie+xh3GIiRLEu75Qyi
 fskg==
X-Gm-Message-State: AOJu0YyCjnSi+71GVq6N7X9RiTUoATZpFXs5EvGhdQNShomAKG2be/Jn
 GF/goxfnjfwQkc3bpGYLdK7xseHKlQohkIlp/ojYFBqWzq9J3PefaAUYQUoUew4=
X-Google-Smtp-Source: AGHT+IHfrAQdVWVyrSjrWDgpJlRNBJHqOXenzh7ZIQPeJCXrLZDJddwjmkzh6iycPYGLJx/xWtYPuQ==
X-Received: by 2002:a2e:a7c8:0:b0:2d4:a20f:299f with SMTP id
 x8-20020a2ea7c8000000b002d4a20f299fmr4585869ljp.35.1712146067167; 
 Wed, 03 Apr 2024 05:07:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v6 00/16] Qualcomm platform USB support
Date: Wed, 03 Apr 2024 14:07:35 +0200
Message-Id: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdGDWYC/33QS2rDMBCA4asErasyGj3dVe9RstBjnAhSK5WDS
 Qm+e+Vs6mLT5T8w38A82Eg108jeDg9WacpjLkML83Jg8eyHE/GcWjMEVCCk4EHxr1g++SVPdKt
 E3AoIaHQ0ne5ZW7tW6vP9SX4cW5/zeCv1+3lhEsv0H2wSHLgCKyJYZ1OA90sefC2vpZ7Yok34K
 0ihdwRsgg9GamtVwBQ3glwL3Y4gm0AiSJe6oHqvNoJaCQg7gmpCcsb6IHowETeCXgtuR9DLH6h
 ziC7IBPKPMM/zD5husoy5AQAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=5327;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WMBuXaHV7S0bVn5IX59PcAnBVcsx4k6pIDGTz7caKwM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaPFWHAjOPzUyLYrMCMUXYqcVCYAcj+aF5Sx
 Y7vfHJ7bHGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GjwAKCRAFgzErGV9k
 tgBCD/9UYwE277aO9Uxpg1eGodUKFzWnuOuWJ05fW2Qx9MOq4/wunz0i4EDGEXlGxU2EvTjwC1V
 1xKPbGWCnBAoC1jgO5gkqj/+6drUOelPjZjTiaTomXjyhj6e6DBgo8qVj6KK/EUT9y6cO4QDykJ
 nIF0if4cHTcdrD/rvS1B3iRZnrtxcyUDy1aamU0h54ef3KeVhsvev5h4bVyiLI9wX2peq9hrfHZ
 qEYzfOjOnoxf18Qks+ovRBdMs8ThN9Nkk/pMe8ZQ6S+E3Gg0v4pN9+9W6O6A4ks2/wMGLjSfzwC
 Hya9RXAjAdC40rIK3nbiA+3YLgzBy548BXF1cddRkF6YRDvtnxJ0bHT+Z57wg5PbvCQgP9hbX/L
 lW8hxVHGSPcF21MEmA+g0Jnsz4FtVRjoME9rSKkaAxajlSP/rTm3X6TIw4dHSotV5dxDaTXyMvB
 Rh7sjDhCTwpLrF9a3QEJJ0y74LaR+lYKIQR0E6b92Z/GlK2STnBFt1LS+bfolQG24EwkjLTmZRX
 JkeczgeeUIg9rM2QoQiCPAa+ktsbGe64qaQLjkp8wxNYqEcx5J+EY1D8VhVLAHMlBBllNJK0OH0
 nqkCbyNeFltdOLF9XSjQrNYTyXkhoncsG/SayfqqtLLO68ekKZbx8MsQa0Lf7IwPI1UyS8kncVU
 LiQQQA0/i8wQBNA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

This series enables USB on Qualcomm SDM845 platforms and lays the
foundation for future SoCs as well.

It introduces two new high-speed PHY drivers, one for SDM845 and one for
an upcoming platform. The SDM845 clock driver gains support for
configuring the USB clocks, and the GPIO driver is updated to use .set_flags
which fixes a strange bug where GPIOs would also be configured as input.

Support for super-speed USB modes is not currently available, however
configuring the device to be high-speed only requires modifications to
DT.

To improve compatibility with upstream DT, we switch Qualcomm platforms
over to OF_LIVE and apply fixups to the tree to remove references to the
super-speed phy, as well as configure the Qualcomm glue for high-speed
only mode.

The db845c requires a vbus-supply to be hooked up for its usb type-A
port. A U-Boot dtsi file is added to configure this.

With these patches, it is now also possible to run U-Boot on some SDM845
phones like the OnePlus 6 using a dtb from Linux, and access the U-Boot
shell via the CDC ACM USB serial gadget.

This series depends on the ("Qualcomm DWC3 USB support") series [1], as
well as Volodymyrs patches enabling power domain support [2].
A feature branch based on qcom-next with the necessary dependencies
for testing the Dragonboard845c can be found at [3].

[1]: https://lore.kernel.org/u-boot/20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org
[2]: https://lore.kernel.org/u-boot/20240311213334.3567389-1-volodymyr_babchuk@epam.com
[3]: https://git.codelinaro.org/linaro/qcomlt/u-boot/-/tree/b4/qcom-livetree

---
Changes in v6:
- Add a comment explaining the non-standard clrsetbits_le32()
  implementation in the femto-v2 phy.
- Link to v5: https://lore.kernel.org/r/20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org

Changes in v5:
- Call regulators_enable_boot_on() during board_init() and don't use
  the vbus-supply property anymore. This is slightly more aligned with
  upstream.
- Minor checkpatch fixes
- Link to v4: https://lore.kernel.org/r/20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org

Changes in v4:
- Fix defconfig.
- Mark db845c vbus regulator always-on to fix a bug in Linux.
- Add a timer in qcom_of_fixup_nodes() so the boot time impact can
  be easily measured.
- Drop unused macros from femto v2 phy, general cleanup, remove custom
  set/clrbits impl.
- Rename "7nm" phy driver to "femto-v2" to match Linux, also fix
  copyright.
- Use set/clrbits() in qusb2 phy driver.
- Link to v3: https://lore.kernel.org/r/20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org

Changes in v3:
- Add back missing gadget options to qcom_defconfig (thanks Neil)
- Link to v2: https://lore.kernel.org/r/20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org

Changes in v2:
- Fix incorrect order of NULL/0 parameters to of_write_prob() in
  fixup_qcom_dwc3()
- Move fixup_usb_nodes() to a separate file in preparation for future
  additions.
- Add missing break to switch case in sdm845_clk_enable()
- Remove rogue return statement in msm_gpio_set_flags()
- Rebase on Volodymyrs power domain patches.
- Link to v1: https://lore.kernel.org/r/20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org

---
Bhupesh Sharma (2):
      phy: qcom: add Qualcomm QUSB2 USB PHY driver
      phy: qcom: Add SNPS femto v2 USB HS phy

Caleb Connolly (14):
      mailmap: update Bhupesh's email address
      mach-snapdragon: disable power-domains for pre-reloc drivers
      clk/qcom: use offsets for RCG registers
      clk/qcom: sdm845: add gdscs
      clk/qcom: sdm845: add USB clocks
      gpio: msm_gpio: add .set_flags op
      serial: msm-geni: support livetree
      mach-snapdragon: fixup USB nodes
      mach-snapdragon: fixup power-domains
      mach-snapdragon: call regulators_enable_boot_on()
      dts: sdm845-db845c: add u-boot fixups
      qcom_defconfig: enable livetree
      qcom_defconfig: enable USB
      usb: gadget: UMS: fix 64-bit division on ARM32

 .mailmap                                  |   1 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi    |   9 +
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   5 +
 arch/arm/mach-snapdragon/of_fixup.c       | 155 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |  20 ++
 configs/qcom_defconfig                    |  53 ++--
 drivers/clk/qcom/clock-apq8016.c          |  39 +--
 drivers/clk/qcom/clock-apq8096.c          |  28 +-
 drivers/clk/qcom/clock-qcom.c             |  24 +-
 drivers/clk/qcom/clock-qcom.h             |  16 +-
 drivers/clk/qcom/clock-qcs404.c           | 122 ++-------
 drivers/clk/qcom/clock-sdm845.c           |  61 +++--
 drivers/gpio/msm_gpio.c                   |  27 +-
 drivers/phy/qcom/Kconfig                  |  15 ++
 drivers/phy/qcom/Makefile                 |   2 +
 drivers/phy/qcom/phy-qcom-qusb2.c         | 429 ++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 216 +++++++++++++++
 drivers/serial/serial_msm_geni.c          |  15 +-
 drivers/usb/gadget/f_mass_storage.c       |  13 +-
 20 files changed, 1010 insertions(+), 241 deletions(-)
---
base-commit: 0d08018d01afaddcee8dd1f1929a48577684110c

Caleb Connolly <caleb.connolly@linaro.org>

