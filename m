Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB90C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15AD987F8F;
	Tue, 19 Mar 2024 13:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q7YYHzeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A37D87F8E; Tue, 19 Mar 2024 13:22:39 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99A587EF4
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e570ef661so2513435f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850956; x=1711455756; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FBdfLlqXX7+vScna9p7RcGoAdOi36tTTDxNJiiwix5I=;
 b=Q7YYHzeYZ6xdjWMRxXZ8bjxBgGn/iFp6muFUuMLKvLKGRSEx7FyI+k9qidZvxZqJ+3
 Q7PWEl+i1YSKSYg/7ZLsFt3Xu4XZkvMyeKyQpi460n/Vb1S0D7SQwwmdB5Dc2oLiBTPY
 M3qaUWnuchCo1nn7JF4QpU3JXMZJVlpAcXYfkR57fEotUs6CkfDE0ZNYK+3cyrtwkx/Y
 z9FpQ+/e6ZEJBIFIlPrxZypdB1W88gAKkFEVMmRSV9xzaeChBdwAC697YYk9Ei5080wQ
 xTc70tXZaCtX1gaMRJ3oKdwNrlRIBVs3KwV+uk4fK8c/B1y5HpJD3woxCYxrJb8qy6Oe
 +JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850956; x=1711455756;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBdfLlqXX7+vScna9p7RcGoAdOi36tTTDxNJiiwix5I=;
 b=UGVrVqUW/Ph7dStdSCVkK7taJ4EyzYK6a9z9oMONBebbP5HDn5iq+p7NBIM5SsiSQq
 L4s6YIjD0wcoYS17ritmKomKlRfxDqcpnVoVJErqPDeAj78oiHWdaqaRKhu2P3Q+PyQ+
 LiVimveTH4hOV1eL/hMg+Zj8lukzlXsA+UV7FnlsA+wcfz6vPmRGhsZMtRpE3ssPs+Wo
 djL5sUDipaRqjY0xEd0c9syhzTgYE7DHPYQU7VzJM5VxqjFQE4TN47yUAkZ3rgFpUBzF
 6/u8XsUejU6eu9IWNEZyN7edW/TP2phxMxLnxcnA+Y3AsWj6fD3KV2F6/F3yae8VkzW5
 FUYA==
X-Gm-Message-State: AOJu0Yx5iVKQPa4BsFgPRXW4GJoZ1OzZ07V8Dl1eb8qEOtMckUqlcfCK
 FdLn9pbcpR+C/YQ7PoMzk2tGWcpJfyHkg6Debr/S6fCvl93+VdJVNd4xG9hvSng/ZMZwxUkdZmO
 7
X-Google-Smtp-Source: AGHT+IGaFO1Gk1ymqecZ39qlEquVSPe6luIAXKGGEagoDQ+oiyn0wsf9hGMVbAEWg8sH7zXyr0R+RQ==
X-Received: by 2002:adf:cd0c:0:b0:33e:c522:e3b9 with SMTP id
 w12-20020adfcd0c000000b0033ec522e3b9mr11493231wrm.36.1710850955686; 
 Tue, 19 Mar 2024 05:22:35 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v3 00/14] Qualcomm platform USB support
Date: Tue, 19 Mar 2024 12:21:59 +0000
Message-Id: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGiD+WUC/33NTQrCMBCG4auUrI3kt1FX3kNcNOm0HaiNJiUoJ
 Xc37UYEcfl+MM8sJEJAiORULSRAwoh+KiF3FXFDM/VAsS1NBBOKccmpVfTh/I2OmGAOANRwZkW
 tXX3UHSln9wAdPjfyci09YJx9eG0fEl/XP1jilFHFDHfMHExr2XnEqQl+70NPVi2JjyC5/iGII
 jS2ltoYZUXrvoSc8xuDhg3T8wAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4078;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=X9ay+qX2n9VLEBxxY5UBWUdj0TgLksOOnfdID+2B25I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzZ1ezOcW7focdFjzrr6VqUzJLsPdbjPFOS+fk5teE
 rsu5umtjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRtm6G36yFJUKlEyvCxAMs
 3ezXeGw+e+SE5reTfTvF9XJu84V4XmP4X6wi5LhqsdJGdoPHa8L3V+nybKy9f/x6uULAP6v87VY
 cYQA=
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

[1]: https://lore.kernel.org/u-boot/20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org
[2]: https://lore.kernel.org/u-boot/20240311213334.3567389-1-volodymyr_babchuk@epam.com
[3]: https://git.codelinaro.org/linaro/qcomlt/u-boot/-/tree/b4/qcom-livetree

---
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
      phy: qcom: Add USB HS 7nm PHY driver

Caleb Connolly (12):
      mailmap: update Bhupesh's email address
      mach-snapdragon: disable power-domains for pre-reloc drivers
      clk/qcom: use offsets for RCG registers
      clk/qcom: sdm845: add gdscs
      clk/qcom: sdm845: add USB clocks
      gpio: msm_gpio: add .set_flags op
      serial: msm-geni: support livetree
      mach-snapdragon: fixup USB nodes
      mach-snapdragon: fixup power-domains
      dts: sdm845-db845c: add u-boot fixups
      qcom_defconfig: enable livetree
      qcom_defconfig: enable USB

 .mailmap                               |   1 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi |   8 +
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/board.c       |   3 +
 arch/arm/mach-snapdragon/of_fixup.c    | 147 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h   |  19 ++
 configs/qcom_defconfig                 |  52 ++--
 drivers/clk/qcom/clock-apq8016.c       |  39 +--
 drivers/clk/qcom/clock-apq8096.c       |  28 +-
 drivers/clk/qcom/clock-qcom.c          |  24 +-
 drivers/clk/qcom/clock-qcom.h          |  16 +-
 drivers/clk/qcom/clock-qcs404.c        | 121 ++-------
 drivers/clk/qcom/clock-sdm845.c        |  61 +++--
 drivers/gpio/msm_gpio.c                |  27 +-
 drivers/phy/qcom/Kconfig               |  15 ++
 drivers/phy/qcom/Makefile              |   2 +
 drivers/phy/qcom/phy-qcom-qusb2.c      | 468 +++++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-usb-hs-7nm.c | 295 +++++++++++++++++++++
 drivers/serial/serial_msm_geni.c       |  15 +-
 19 files changed, 1108 insertions(+), 234 deletions(-)
---
base-commit: 7194c72d0eef33d9b76555a281d808a0afe54ab5

// Caleb (they/them)

