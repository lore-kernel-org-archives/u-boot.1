Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803B7C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA8587FFF;
	Fri, 15 Mar 2024 16:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C6UAAVFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F73287FC6; Fri, 15 Mar 2024 16:10:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B011E87FC6
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-413f2721129so15293755e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515429; x=1711120229; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5FOyFJac5oMLJGuM8+ZMmQjzJA5vbK2iWX2IARWmFsw=;
 b=C6UAAVFSGKgAlxAB9AjLVoFTHe6kQt84uM9+2C9f1m/Fq4nOREty9L5NppojoSiB31
 ejrZJF0bvFipoSvEWdNoPlFkpzWYumS177giCL6bjlkUdxFGVkSUt3KkSA2dDSaGTmKR
 nCyx7D82ZzjPLZf0IYKqvw4YwQDa9j2sE/9uFbN5iud4fYDoRUkQ/RiSne6xCGwHaON7
 DYvdKu8ou3UiO9wfCRWeWQCxtDfRcinoDc0+bn+lMaFIpFoy/Ad9LVROus8KiwiTcnL8
 vb34GFPZ17RmxzpfG6B36q8/az9savhUtzIYx2gjqxWZQ2sOCsJUmJzQJtx0k9v2/ITV
 AtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515429; x=1711120229;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5FOyFJac5oMLJGuM8+ZMmQjzJA5vbK2iWX2IARWmFsw=;
 b=B4IzB1Cp8jMbL67LKtzKtU6ZD3UfdH4jDZaKbn4LCUdm2RXPCCAH3w0Pdy3izlTP86
 2nX8curL/zJQGsNKQPIUJ1LaCFfg900awEOAos1tZjIa/HlUEfUWZvYZZq0i3FuzYwmv
 gnmK3/CsSf/+iIzTmMTpEMEf9fsEHOHJjJuD0ppI+nZmmSy+KN5cOrhOY5l6prLdx6Pi
 GYyDGl7trAjIhAYnf9cGOp2zliHijxKzEAjUXM6NffReeKabdyBIZTRa7ssat+/K9M0f
 m5XpcKdKvN4KQqs61Ys4oFA4jc4sZmTXAI0KrshX1KVNrw8rX51YbKFsZpq5PyU38sub
 d1OA==
X-Gm-Message-State: AOJu0YxHbot0ZtKP8eRHbWIHfeYd1KCwZx2baF+pQO/Dkg6DWqfp1tLQ
 VwivGCox73bMEjtvEEu9vNDK1WVN/ycfGl9OVcki7yzM2W3w4Dgba8Vc+/rNOe/bbUaYpn+nps8
 K
X-Google-Smtp-Source: AGHT+IGGdpGEB1g5ZQOmqVcNjNc2/ZWSmxkMtcn6ciAyGW6ePD8yrAEKzggEiellGgYc/QVbOYnwqQ==
X-Received: by 2002:a5d:480a:0:b0:33d:c5b5:5796 with SMTP id
 l10-20020a5d480a000000b0033dc5b55796mr3591811wrq.22.1710515429020; 
 Fri, 15 Mar 2024 08:10:29 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 00/14] Qualcomm platform USB support
Date: Fri, 15 Mar 2024 15:10:09 +0000
Message-Id: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFk9GUC/32NQQ6CMBBFr0Jm7Zi2AlVX3sOwoGWASZDqlDQaw
 t2tHMDle8l/f4VIwhThWqwglDhymDOYQwF+bOeBkLvMYJQplT5pdCW+fHjgxIkWIUKrlTN15et
 L1UOePYV6fu/Je5N55LgE+ewPSf/sn1jSqLBUVntlz7Zz6jbx3Eo4Bhmg2bbtC3M0AnexAAAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3895;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XUOVWU8rBkqEVjrhTClOPKohO+BngAD80JiBFJir78U=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY9kHFXcZr4PNT+6RlPExHlJfSPDDs3cK2oMTwLDq
 +Yx+nl3lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIn83MHw3/n1avH4VPNJwWp6
 P7I1ek3KbPSuuS9l/3csVMNzC9fqd4wM055MXqZ93P7vsxDTT79EFhj6N1+56en86E5USoZlZrG
 RBgA=
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

[1]: https://lore.kernel.org/u-boot/20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org
[2]: https://lore.kernel.org/u-boot/20240311213334.3567389-1-volodymyr_babchuk@epam.com
[3]: https://git.codelinaro.org/linaro/qcomlt/u-boot/-/tree/b4/qcom-livetree

---
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
 configs/qcom_defconfig                 |  15 ++
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
 19 files changed, 1094 insertions(+), 211 deletions(-)
---
base-commit: 6b65bdc55f5ddb1318d1f702f27d3f6d058d001d

// Caleb (they/them)

