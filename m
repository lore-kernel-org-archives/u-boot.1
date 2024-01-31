Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C74C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253B187D60;
	Wed, 31 Jan 2024 16:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="StlbPi95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F032B87239; Wed, 31 Jan 2024 16:17:04 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB05D87B1D
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so57495175e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714222; x=1707319022; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7hcaLvjotK3SWkVPPIHbtX4d2j0pF3XwOtAF53m7jZs=;
 b=StlbPi95TLsrp/7NTqMJpjBfdGi9X9sL+xh6WtIdLoj3iwyifPYMynDFZgwys4aWSY
 QuGflOOQqvDFdsaqsOIZRQeRD+mb/caIL8WignfmVmbb+3k8Cy0NOhc/9v9GFhpxYuuN
 ukueor4KXmndlVDqF9LAxwGwMSkQqyRDIQrb4Dz8E9qBZrOYou9QsQJvcaURLay3umz0
 qMqBhoWeLQ8zBt2Xx9oTMtM5n+AG4hlwQDbj8ns7bX9SWambXx87eAG8yqrVQJKbbUJ1
 juJBO84Qr6yDAWC3WcoDQPxBSRU6PdA/AjOJnMpS2+MzZx5ZHlwSVp4EZfk14wOB/E+q
 vxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714222; x=1707319022;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7hcaLvjotK3SWkVPPIHbtX4d2j0pF3XwOtAF53m7jZs=;
 b=KXCNjeL9V1kuanTY/ppEODWJfnFva0xKSgwLaj4QIl2T5fHOO3ItnnAmUts7IfkwkH
 fQ4Jg8xX9xZ0XAq+w7HVV6+RHA7Auk+Z0hKGfqC5VMD1GzKIHMQfqyXlH3Ma7jidICgR
 vjvOzup9au0tGd+M8SetEZ8U8eRirO6Z+C4EAl2rZAKapU5YLT6Cx3EmVUH3lUMDqo39
 xJOWOmZVJg9EmC6AnCap15pIpLbO3c7mMX4zP772f1NQ9RPJmBFKRWvPDvF6SKg26bRU
 5YByyJO0ovuaCL3hzqrZyR6xQ/0ASw0oCldh2y+/DVrTaFmEWxRdcrAlQ7HpeaeAWyLR
 bpBw==
X-Gm-Message-State: AOJu0YxsnUTjWgzq7enF8spSxbhRzoCHgbzHYv3E7Bd1+hXcVrvl/4C1
 3MH9Vu6eAnNN4z1hqrDkHJB1cV4QGChSUwwr8jLtytUAJbgmJzcLqNz688SKyRyAo3lkK+sOOje
 n
X-Google-Smtp-Source: AGHT+IF3jB5YMhgFjhcw8azPJGqlfB8a5P0cpi3QMKSpaKftlkVRyb1mjYADvw1NinFs8R6R2kcZrg==
X-Received: by 2002:a5d:4b50:0:b0:33a:ed44:6679 with SMTP id
 w16-20020a5d4b50000000b0033aed446679mr1161882wrs.71.1706714221753; 
 Wed, 31 Jan 2024 07:17:01 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 00/13] Qualcomm platform USB support
Date: Wed, 31 Jan 2024 15:16:52 +0000
Message-Id: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRkumUC/x3MTQ5AMBBA4avIrE3Sqb9wFbGgBpPQ0opIxN01l
 t/ivQcCe+EATfKA50uCOBtBaQJm6e3MKGM0aKVzRRnhkONh3IarXHx6ZqxIDbosTFkXE8Rs9zz
 J/S/b7n0/veYS+mIAAAA=
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=loLM7Hxw2Krvk9GcDF4zeRAQlKMXQZl22gwPDknyT/k=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKdnGU9WdE76fMec59q3GcmvG6rjHZ9oNlJvDUwLMP
 cT6vcU6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwERklzD8Zvv50rX/pqH1Fr4H
 NyPkn3L/P1Ruee/kNL2Ch+tjts3pPcPwv/7N8qdvLnRtWrq/RubqB8P5f5n7uWxrnbas+fVqx7V
 8uSwA
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

This series depends on the ("Qualcomm generic board support") series [1]
switching to upstream DT, as well as the ("Qualcomm DWC3 USB support")
series [2]. A feature branch based on qcom-next with the necessary
dependencies for testing the Dragonboard845c can be found at [3].

I think most of these can go through the Qualcomm tree, but I'm not
exactly sure. I'd appreciate any suggestions on if/how to split this
series up further.

[1]: https://lore.kernel.org/u-boot/20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org/
[2]: https://lore.kernel.org/u-boot/20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org/
[3]: https://git.codelinaro.org/linaro/qcomlt/u-boot/-/tree/b4/dwc3-qcom

---
Bhupesh Sharma (2):
      phy: qcom: add Qualcomm QUSB2 USB PHY driver
      phy: qcom: Add USB HS 7nm PHY driver

Caleb Connolly (11):
      mailmap: update Bhupesh's email address
      clk/qcom: use offsets for RCG registers
      clk/qcom: add gdsc_enable helper
      clk/qcom: sdm845: add USB clocks
      gpio: msm_gpio: add .set_flags op
      serial: msm-geni: support livetree
      mach-snapdragon: fixup USB nodes
      dts: sdm845-db845c: add u-boot fixups
      qcom_defconfig: regenerate with savedefconfig
      qcom_defconfig: enable livetree
      qcom_defconfig: enable USB

 .mailmap                               |   1 +
 arch/arm/dts/sdm845-db845c-u-boot.dtsi |   8 +
 arch/arm/mach-snapdragon/board.c       |  88 +++++++
 configs/qcom_defconfig                 |  22 +-
 drivers/clk/qcom/clock-apq8016.c       |  39 +--
 drivers/clk/qcom/clock-apq8096.c       |  28 +-
 drivers/clk/qcom/clock-qcom.c          |  40 ++-
 drivers/clk/qcom/clock-qcom.h          |  20 +-
 drivers/clk/qcom/clock-qcs404.c        | 121 ++-------
 drivers/clk/qcom/clock-sdm845.c        |  45 ++--
 drivers/gpio/msm_gpio.c                |  21 +-
 drivers/phy/qcom/Kconfig               |  15 ++
 drivers/phy/qcom/Makefile              |   2 +
 drivers/phy/qcom/phy-qcom-qusb2.c      | 468 +++++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-usb-hs-7nm.c | 295 +++++++++++++++++++++
 drivers/serial/serial_msm_geni.c       |  13 +
 16 files changed, 1017 insertions(+), 209 deletions(-)
---
base-commit: b5195aca8b5b30071fda8e60bb56013032e06d18

// Caleb (they/them)

