Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65FBC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 00:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4128886463;
	Fri, 26 Jul 2024 02:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LzwUDK7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E207988373; Fri, 26 Jul 2024 02:01:03 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6985B8641C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 02:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so191176366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721952061; x=1722556861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w81s6QiW3NduB2rlSOFteNF7kjrV6E36KkV+ytD20g8=;
 b=LzwUDK7qnSF1fI5vqbEUiY4s5YqHbsFkqRh66HVCh/WtXe6yk+VHre4a5a3O00Cx+L
 7AE8UIFeqZXDHA3vCf47G09asfMssFn3bcWoLSi51Fk/PqZYgAYe/FrnfrgYvEXbdh33
 8AS2gusR2TfODxLpCAYOojoEx+pQidRC+F5uQHOGk7tQEnpdI6U94TqQ0ZuhQgc+dc+j
 dM8a11xN8fWNxnkU8T/zjOV7iL4r6WcTy3tMmuYx44is3t5QOZBEYpMrugLF6u1S/K1C
 AFncLhvYjMHARaS+mQD8ps1ss6vEEB76J7FA2gyJ5bPCNZsA27pbp6wuKNNZGwkm6yuf
 UtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721952061; x=1722556861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w81s6QiW3NduB2rlSOFteNF7kjrV6E36KkV+ytD20g8=;
 b=pK5HX/4Q8OlYhKL2C1FDfPG2vIwsAriTX4GgnF5XWz1Mbnsg9DpZxva7RjlgmXVbwe
 /XuvJvT8XSu0FMK76as/h3NIApEbMpJOlYlnmiP+wQOOIfhDmlQs8+cw4/n3yasE1ddf
 qO4Jx1viXAGlpkPAQGcfdycAX3VvyOMmdaVTvSTeotuaJtkN2hkceLHxFDGjiy1uaN9R
 C6YYVooNd+IJ8u667r/iyCjyBbiozhWBu4N6EE43oxHeTySyjk/wmz2sCTZkx5RNN3GD
 0bBSG89V7lCDUqJX1ob0cbPpBSjL368l4gjQHsvGuLEOR9xj70kqUfa6GDDVlKxMD14f
 7qdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQjgklXRH93Z8jOGsYIGPJ0Uek7SCL4d5Ge4r6nJuIgKQqfEm2Mbx4p4F4RTXZHJ+HvkFLYLvHeS7361cUbogoG50Fig==
X-Gm-Message-State: AOJu0Yx6IdAVNzGoDwjJmNHr+5OixO/1GJtHrdxLvqRlFvqqhlYcxwLE
 Y5jpa4FW+ipmj7+BAUNwi/3+hnrZAbMD/9iDrIaocU8QrUhRQFekmgntpodOCcE=
X-Google-Smtp-Source: AGHT+IEzKDlbolYF81AxzV4IcvsOspekox2ZUMwCR4VPyMbawulVrjAsOyeHSC5HWn3QQxVvC+SXsg==
X-Received: by 2002:a17:907:7e9a:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a7cd28452f0mr214180266b.28.1721952060746; 
 Thu, 25 Jul 2024 17:01:00 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23828sm119707666b.19.2024.07.25.17.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 17:01:00 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom/qcom-main
Date: Fri, 26 Jul 2024 01:55:06 +0200
Message-ID: <20240726000050.2299441-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Just a few things:

* Qualcomm platforms >~2016 gain support for the RPMh (Resource Power Manager)
  peripheral which is used to control most regulators. The RB5 is now able to
  power up its USB VBUS regulator via the rpmh regulator driver. Git history
  from the original Linux driver is preserved for ease of maintenance.
* IPQ40xx SoCs gain ethernet networking support via the new ESS EDMA driver.

The following changes since commit f659ba43837e5ae5a35fdff3736c8e13f9062abd:

  Merge branch '2024-07-23-remove-or-update-some-platforms' (2024-07-23 10:43:58 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to 927739c0b700cb37fd16dfbe8919484511885359:

  arm: dts: add IPQ4019 ESS EDMA U-Boot additions (2024-07-26 01:53:13 +0200)

----------------------------------------------------------------
Caleb Connolly (24):
      dm: core: scan reserved-memory nodes
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: import rpmh and cmd-db drivers from Linux
      soc: qcom: cmd-db: adjust headers for U-Boot
      soc: qcom: cmd-db: drop unused functions
      soc: qcom: cmd-db: adjust probe for U-Boot
      soc: qcom: cmd-db: adjust for U-Boot API
      soc: qcom: rpmh-rsc: drop unused multi-threading and non-active TCS support
      soc: qcom: rpmh-rsc: adjust headers for U-Boot
      soc: qcom: rpmh-rsc: adjust probe for U-Boot
      soc: qcom: rpmh-rsc: remaining U-Boot API changes
      soc: qcom: rpmh: adjust headers for U-Boot
      soc: qcom: rpmh: drop unused functions
      soc: qcom: rpmh: U-Boot API changes
      soc: qcom: add build infrastructure
      power: regulator: import qcom-rpmh-regulator from Linux
      power: regulator: qcom-rpmh-regulator: adjust headers for U-Boot
      power: regulator: qcom-rpmh-regulator: port over lineage_range helpers
      power: regulator: qcom-rpmh-regulator: adjust structs for U-Boot
      power: regulator: qcom-rpmh-regulator: remove unused regulators
      power: regulator: qcom-rpmh-regulator: port ops to U-Boot
      power: regulator: qcom-rpmh-regulator: adjust probe for U-Boot
      power: regulator: qcom-rpmh-regulator: add build infra
      qcom_defconfig: enable rpmh regulators

Robert Marko (5):
      clock: qcom: ipq4019: add ESS clock
      dt-bindings: clock: qcom: ipq4019: drop downstream file
      clock: qcom: ipq4019: add missing networking resets
      net: add Qualcomm ESS EDMA adapter
      arm: dts: add IPQ4019 ESS EDMA U-Boot additions

 arch/arm/dts/qcom-ipq4019-u-boot.dtsi         |  104 +++
 configs/qcom_defconfig                        |    5 +
 drivers/clk/qcom/clock-ipq4019.c              |    9 +
 drivers/core/root.c                           |    3 +-
 drivers/net/Kconfig                           |    8 +
 drivers/net/Makefile                          |    1 +
 drivers/net/essedma.c                         | 1192 +++++++++++++++++++++++++
 drivers/net/essedma.h                         |  198 ++++
 drivers/power/regulator/Kconfig               |    8 +
 drivers/power/regulator/Makefile              |    1 +
 drivers/power/regulator/qcom-rpmh-regulator.c |  544 +++++++++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/qcom/Kconfig                      |   27 +
 drivers/soc/qcom/Makefile                     |    4 +
 drivers/soc/qcom/cmd-db.c                     |  225 +++++
 drivers/soc/qcom/rpmh-internal.h              |  138 +++
 drivers/soc/qcom/rpmh-rsc.c                   |  505 +++++++++++
 drivers/soc/qcom/rpmh.c                       |  110 +++
 include/dt-bindings/clock/qcom,gcc-ipq4019.h  |  169 ----
 include/linux/bitmap.h                        |    8 +
 include/soc/qcom/cmd-db.h                     |   30 +
 include/soc/qcom/rpmh.h                       |   28 +
 include/soc/qcom/tcs.h                        |   81 ++
 24 files changed, 3230 insertions(+), 170 deletions(-)
 create mode 100644 arch/arm/dts/qcom-ipq4019-u-boot.dtsi
 create mode 100644 drivers/net/essedma.c
 create mode 100644 drivers/net/essedma.h
 create mode 100644 drivers/power/regulator/qcom-rpmh-regulator.c
 create mode 100644 drivers/soc/qcom/Kconfig
 create mode 100644 drivers/soc/qcom/Makefile
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 drivers/soc/qcom/rpmh.c
 delete mode 100644 include/dt-bindings/clock/qcom,gcc-ipq4019.h
 create mode 100644 include/soc/qcom/cmd-db.h
 create mode 100644 include/soc/qcom/rpmh.h
 create mode 100644 include/soc/qcom/tcs.h
