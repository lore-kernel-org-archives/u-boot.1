Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0263CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 17:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9AC881C2;
	Thu, 28 Mar 2024 18:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wtc4nETv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422F183CF3; Thu, 28 Mar 2024 18:59:43 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D808488158
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-515c3eeea5dso1206165e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648780; x=1712253580; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gugm8PULZiYBGaxWKr7R55yd2Q/KndKrrE30A+QWiq8=;
 b=Wtc4nETvMWRsPn+Mx470URK2ey6wGabzi5TXev6wVJuuAKTR9/T4nrkKEVFEJM66hc
 ns/6/NuVXZNW7xV5s2O5VktYNGXJTc2hts1yYjW6s7fdAGONuBX5z1gW1t2k2UVk2h3s
 uERwCPwyW7pY+c8qA6TjxnVD0eBDtnGu7z5FgBlCsNR7Rjl8hZffZQmWK1G0jbCvXivr
 FiRtynfIj+zCU5Epe4cZwb7fS/J1TwsRfaPIZM/CDy5txid6rPPv14MbgAEZCd8r0chk
 ZgF2vD32c9Z57KlbL70WYb3tTYAWR6sYIISes2sp3Orc6ad6zc7xu6VcYdtEJTwGVDSf
 n1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648780; x=1712253580;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gugm8PULZiYBGaxWKr7R55yd2Q/KndKrrE30A+QWiq8=;
 b=gPQ8H/Q7CZgYVssbA893M7OsfNqRKNmsG1gMvde/oneB97PqUeXbH2l0uUViW5VlHa
 eBu/U8i2HH496E5tQzIOJnwH1QJgar2KH16XCWeGdAob5ADupyvHIPY5akF9hWe1amPl
 u1hhCOakw8LwSJf9J+9SHAcZSEhTR6e41jns/dWoaoeC+/9r5Zwv1oWfD+MsEAJWFriK
 RbIYQ/6z0Jq/c2DM8c6bWpFpST65uEKRUQRwina34ehiWRjDrgbP8SQAMxJK5S2gQGWl
 AwagC/aulLJXCSaBHgMBj+LTV+rx13q/VOsH2ROXU6VLrfxG8K8N5Pkej23J9VxfClTG
 BZfg==
X-Gm-Message-State: AOJu0Yz99uRpmKiqF1bwg+jR6L518cYpgjaijOLYZg0GBXaXQpj1LaNK
 WOOFg9PcagiakiWrNeyGoQFLDmnOirQ/PpU2hTkITgVYQCoD6hbPJAZVG8ZV2K0=
X-Google-Smtp-Source: AGHT+IH6F+nSYRCp4Tjnu1C9taQNTBzRIhODsD6qQTPaEaKzEsIuWsf7oknsBARz53mhyZqI/0w4ZQ==
X-Received: by 2002:ac2:5056:0:b0:513:e4bc:824e with SMTP id
 a22-20020ac25056000000b00513e4bc824emr93583lfm.57.1711648779897; 
 Thu, 28 Mar 2024 10:59:39 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 00/16] Qualcomm platform USB support
Date: Thu, 28 Mar 2024 17:59:06 +0000
Message-Id: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqvBWYC/33Ny27CMBCF4VdBXuNqxtekK94DsfBlApYgpk5kU
 aG8ew2bUhF1+R9pvrmziUqiiX1u7qxQTVPKYwu93bBwcuOReIqtmQChACVyr/hXyBd+TpXmQsQ
 tghdGB9PrgbWza6Eh3Z7k/tD6lKY5l+/nh4qP9R+sIgeuwGIA29noYXdOoyv5I5cje2hV/AoS9
 YogmuC8kdpa5UUMb4J8FfoVQTaB0Msu9l4NTr0J6kUQsCKoJsTOWOdxABPEH2FZlh/0ATLtdwE
 AAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5088;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xX8hYRoE9Vz3hx6l9TaPnlzVTqihsbPljRxVCb8k0/I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZxPsk6YHj4mlhwYHfZWZE2ThcEZDkl3vfc3zk6P5
 LvzXeZjRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhInRvD/4iK634Xz+9ffIu9
 d9f8oNV/9j7X9Djm/Erc+RTvmxaLj8UMv9ma9S2O/ojbaxkZZDzT6eUy8VfdO0Mfu6cxzXr9jit
 lci8A
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
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++
 drivers/serial/serial_msm_geni.c          |  15 +-
 drivers/usb/gadget/f_mass_storage.c       |  13 +-
 20 files changed, 1001 insertions(+), 241 deletions(-)
---
base-commit: 0d08018d01afaddcee8dd1f1929a48577684110c

// Caleb (they/them)

