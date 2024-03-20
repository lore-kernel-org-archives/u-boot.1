Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60476C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC666880A7;
	Wed, 20 Mar 2024 15:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrSAc0ku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AE5879A0; Wed, 20 Mar 2024 15:57:12 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9805D879A0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d46c44dcc0so82716211fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946628; x=1711551428; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hCBBj5TTfVRE1ksV1r5NvaZbWedXSzS6Q+M03/VgWDM=;
 b=rrSAc0kuKkdl6Fie4UDzOq4clLM9cyyYVYrEU4Ywi8nCWAQJU48r3xW2+YoleA3xAI
 rdnCtQDgo35xkZEueI80v9K7z0lLbyN6ctE62NospIth7UORb0V/YOlM2MuL+kaGDjB3
 IyDQcNx5jLA5PFcTDc3hmhX7dusXSOD3s0kNepdfu9y0quZABTnskUbPgHWWHH7QVkFU
 TFtQCoUStL49+ON7rYPeNuOluNx0tC0hxGaVp+ugqcWuYaAxCWJ9+QjHlqUVmrzNrBfN
 vd3r76E1qaRt+eDgKZxRaLnbNP4zg7+/YpWa92E4r6/XGs6lwRnA4zNpJHr6ST1rTAcR
 Yjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946628; x=1711551428;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCBBj5TTfVRE1ksV1r5NvaZbWedXSzS6Q+M03/VgWDM=;
 b=CvJfoE7LR4TRLC3530qDlLxIwCY+WR/7l5G03h+FF5ePhiNv7SGrgkiO+iE7S56wqd
 cb1xMXoWfZpmLKaBb1hBApM8mYT1AA0IPbcFVRb0CCzYGqmume578FsCQwtCmdId6xyK
 o5U/qoaQVyzw8NPf6kuBSAYHjLLnkCcDszJt42B9NwFGTLzA5x72YTku9YvfllL8FTup
 efuLjabS0wORX3GVnHksZRq0I5Q0HS41+6EZIE2q8FeEqvkdZkq3M4hJo8bVkl8M+hvf
 EWdT8mN+bSHk9hbx9JvTgJHvOU0GSc+mRvJHRCpNuUYc30/wxa1BfhISySOXpuLAK5h4
 BHOQ==
X-Gm-Message-State: AOJu0YxoDvNJ99HVdWAY5d+tqUlP7heHPZOPRniI6TDuggMrBSEyNGTR
 jdgLuEvF/EzC0dadwKgwh8qSdeG27f/l5Q/N0z1OvQ+iBc38ZxZr+d7p34Y37eA=
X-Google-Smtp-Source: AGHT+IEdFd+WmWCW0ADdfu/aE623XYZlu3et7cdKbD0Lyv8vu4bJAliAgxMGqypjkdQvsiDpm32F7A==
X-Received: by 2002:a2e:b619:0:b0:2d6:8cba:c90b with SMTP id
 r25-20020a2eb619000000b002d68cbac90bmr1997070ljn.52.1710946627820; 
 Wed, 20 Mar 2024 07:57:07 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 00/14] Qualcomm platform USB support
Date: Wed, 20 Mar 2024 14:57:03 +0000
Message-Id: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/5+mUC/33NTQ6CMBCG4auYrq3pLwVX3sO4aMsATZBqSxoN4
 e4WNmokLt8vmWcmFCE4iOi4m1CA5KLzQw6x3yHb6aEF7OrciBEmCOUUG4Hv1l9x7xKMAQArSgw
 rpC0q2aB8dgvQuMdKni+5OxdHH57rh0SX9Q+WKCZYEEUtUaWqDTn1btDBH3xo0aIl9hY4lRsCy
 4I2BZdKCcNq+yPwT6HaEHgWgBpe1pURjRZfwjzPL5EaoTI1AQAA
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rg8GpPySBBqz58f7xqnn18LK+5LpUJdNhgkHvhRv+hE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx3eZGbKZJSY6Z67cEjUd+GF0MOLu8yNpp7QOvRls
 eOTg7vZO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEtugx/E+44nvoX/r2Mwd3
 B6Xw7b3q5/xnU4Fuj3xO5Rq+l20BfK0Mf0XDXy0/tbhXXFfus/z2XwaScRUxzL6t80Pbsyqra6d
 WTAMA
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

 .mailmap                                  |   1 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi    |  16 ++
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   3 +
 arch/arm/mach-snapdragon/of_fixup.c       | 155 +++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |  19 ++
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
 drivers/phy/qcom/phy-qcom-qusb2.c         | 430 ++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++
 drivers/serial/serial_msm_geni.c          |  15 +-
 19 files changed, 999 insertions(+), 235 deletions(-)
---
base-commit: 54b3fad8f70250d27e2c871d7d6b588e18b909a5

// Caleb (they/them)

