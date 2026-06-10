Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2B9CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 11:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A1D841C2;
	Wed, 10 Jun 2026 13:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PaQUnsCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5134484841; Wed, 10 Jun 2026 13:38:54 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BD7807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:38:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-692491fec0bso3165132a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781091531; x=1781696331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mta/c9E7hwijwccj1mbV46fArdzPzgDLqioHvAX4I24=;
 b=PaQUnsCefMB10PEPXsbFuu84aqo2VhguaMCrebIoNr2eQyIQgFQayprx3UM9WQ16m9
 q8xfose8SDKwYfIvBDrSh/HOfAdtB2ZwkU9nVFn70FHt0nbA8wdAWzY2c+fjf77bSB9x
 7tQ/XL56TvkwSnKnEo0bvXJ6EyBmdP3kOiN3/OtZxbmPvzP78w/uzgkTyQnpU6ozAc5U
 fjg6b4smH59GgCNcVi0ZZn8hKoxFvKEQsIPoAyyH48xaNxah/abMCLOeD+DFFoyUzNeq
 4zDLEljHOeFjDOANL9JHVDgR0iK6QdJ39HfTj7N1UEDdAoLGHUoKwmh8mgoiHck5yWqA
 +4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781091531; x=1781696331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mta/c9E7hwijwccj1mbV46fArdzPzgDLqioHvAX4I24=;
 b=gxD/d5ixzg9FWhvZcpEc8vhALvaSkV9OrfKRR0q6ZiUnJYX0N1la/0liLyll7Rg4ke
 Bd1+l+VSYK7+UZ2jK3QUxSRS4Ab4U7dzMluS4I5TxquzGcic7Lz0UWr7vin3GgB9u4h0
 WY20eLkyYxMgYtfJI+ATYs89w+RhscNqCPN7BM7KWO+/mDpc/fFv59PUZKtgGjLH8Jjg
 PZBh6ZYRCTtM3hRcMGyXAxVcks0hpCiIi7j9H04KrJWIyeorkL5fSecUrtdYmgtWFJqd
 i0UUNTVg7UPrhyHAj+TmFg+0x4yva/UQ3fW12n+tph2exE2cnC6o/SoTbus7uU9MPd6U
 cuMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+rJm41TesNAFtm7+NQPnifgpBIP7mNsKd06LfkPni550jNpSn8pj1q3TKFveQPcDkw2tdQNo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9HBEMZP5W6ZeDPh4jBf5W+Qz22L5VrPihcn852pwnDVrjUSUD
 wyHh2ZpX9+rNVdjxEUHurFjxDL0OPArebITiGRqS18f04UBqe3yY5qDiLum0/EpwRPU=
X-Gm-Gg: Acq92OErq0f3sQ8GAwsdqd798D33mnEEzCpWr+tL/6TOOZ451z9JKkPW4gtTX04e4rb
 X1R7+FiSaE34nxj3XnIS9Ah+g1BVWtiYhSTRDyZJK8qD7CpLZeylQrdavsOgz6Z45DsHltT4JKy
 W33h1xKTaeBUgYuV5Rc/SUmSWOnBaGlA+QZ/ITYhOEx5X6OZKSfb+SoyCw6rot+jQ6QKHcxEOBc
 8/yW0GcAxWV4VYOMQ8+FlKEVQ4eF8l/nqgn+kO+k0BunTSsZqyMIesZBkXWxYkGnjGqlvZtx0t8
 dVpnImGips5XLjYwz4mEeXwSw3UVsMfChpwttNpT1UtDRlkQqZCYhqlb2pUNo7DR/IU2i3z6lBN
 PyFKhDFRTFje+hDns+1b0zHPcmCnRDzaTkQUHJzgD4RO3lVrA+Uh4vUKV8LWxrFQXsipkG+waVW
 OqVfnlUnn2WGsqd4hkJ9LTcMqc64Vk6Fvrg3/0ULTKE0ld9KmmTdysaZ1LctKAKMwPIzw4B9Zl/
 9ayjtdL6trB
X-Received: by 2002:a05:6402:528d:b0:68d:296d:9a34 with SMTP id
 4fb4d7f45d1cf-68fa4f3d27emr11784392a12.18.1781091531273; 
 Wed, 10 Jun 2026 04:38:51 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29e032.dip0.t-ipconnect.de.
 [91.41.224.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2f1bbsm9695160a12.2.2026.06.10.04.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 04:38:50 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 Petr Hodina <petr.hodina@protonmail.com>, Sam Day <me@samcday.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-main
Date: Wed, 10 Jun 2026 13:36:28 +0200
Message-ID: <20260610113844.3715979-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.53.0
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

A few Qualcomm fixes for 2026.07

* Define memory map for lemans-evk (pending SMEM)
* Fix CONFIG_SYS_INIT_SP_BSS_OFFSET in db410c chainloaded fragment
* Fix the "dump bootargs" command in the qcom-phone boot menu
* Fix a bug in the rpmh-regulator driver where the regulator mode may
  not be set during enable.
* Enable watchdog autostart for Dragonwing boards
* Fix serial console init on ipq5424-rdp466

CI run is here: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/30394

I dropped a minor UFS patch last minute since Neil already picked it up
but I don't expect CI to fail with that change.

Thanks,

The following changes since commit 1a8b7ad50aed5f5f0a4ccbfd455233919c097293:

  Merge patch series "mailbox: mpfs-mbox: fixes and syscon support" (2026-06-08 15:38:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to 757a95c7faae4bdc10dc463c1bb3cf3fee1418a0:

  arm: dts: ipq5424-rdp466: add chosen node for serial console (2026-06-10 13:36:18 +0200)

----------------------------------------------------------------
Aswin Murugan (1):
      dts: lemans-evk-u-boot: add override dtsi

Balaji Selvanathan (1):
      configs: qcs615/qcs9100: Enable watchdog autostart

Federico Amedeo Izzo (1):
      regulator: qcom-rpmh-regulator: fix regulator mode mismatch

Gurumoorthy Santhakumar (1):
      arm: dts: ipq5424-rdp466: add chosen node for serial console

Petr Hodina (1):
      gpio: qcom_spmi_gpio: move PM8998 GPIO from legacy pmic driver

Sam Day (2):
      board: qualcomm: phone: fix 'Dump bootargs'
      board: dragonboard410c: fix chainloaded.config

 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi            |   3 +
 arch/arm/dts/lemans-evk-u-boot.dtsi                |  19 ++++
 .../dragonboard410c/configs/chainloaded.config     |   2 +-
 board/qualcomm/qcom-phone.env                      |   2 +-
 configs/qcom_qcs615_defconfig                      |   2 +
 configs/qcom_qcs9100_defconfig                     |   2 +
 drivers/gpio/qcom_pmic_gpio.c                      |   1 -
 drivers/gpio/qcom_spmi_gpio.c                      |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c      | 108 +++++++++++----------
 9 files changed, 86 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/dts/lemans-evk-u-boot.dtsi
