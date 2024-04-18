Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F54C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0445588662;
	Thu, 18 Apr 2024 19:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UWM8ovrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4FC88695; Thu, 18 Apr 2024 19:26:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FA088648
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-418c1920313so9635835e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461184; x=1714065984; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XbCbXQdS0fbAih8HtP8CpbO4/R7Ogx+6nPEHviD+IeE=;
 b=UWM8ovrTt8tuuTv+urmLSCeFWMUL8SOCy1LJKbMN4uoHwULzcqBiNDFZ6MWYEN193Q
 YghdSQPgHCAVm+2Pr5CNxtTVyy6XRq8UqSMngxIUkvih4lkuzEZDatqd1DVBQmAa81xA
 owBWJa5ewOj71LsTFfs33SGXqeh1vgPZkIqIKByFnLkkxYAU1PjAejOgd9vr/wyxo9um
 +PT4nB2GFFsfqtJTrcQFeXkUItoPsUhPxUzYcKUYWZ8L5PdmiTmA5VJ54yICFUgzp53t
 qSXi4XcDzF6bb4nBfvn40OJ7N+6fwKW8vFNtASuaLxkQ+rhL4bxnIrmRYxahlXTgOArt
 ripA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461184; x=1714065984;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XbCbXQdS0fbAih8HtP8CpbO4/R7Ogx+6nPEHviD+IeE=;
 b=tlWXdeUdlD6U96KK8N5xaFsAOLfS25tpQhq0LwbF4JJAP+lyzYRK27HhwaU3LbZDHp
 6kDqISMllW46sdWFPapXZnSU/RKeJiO4J1ID5u/VzereK5KI++H/bWl5Ulb63SlfG0jC
 HQHsiQY/js/5gATS4Klx+Uc+CCocdxOatJccAD2uSEpb/CWJDzQqENjOShgWQkBi/Ceo
 vgYnMcBCdowMm6JF6c1rZUrazL/1IWCsqWq016vErauJfytCyP5LouoiX59ofKa80fyc
 dOmQdnJydscGiK21AcSsT9vxJAK21kmHRIw2lw2hezks2fof6xfSvsMA+S/r8l6EdbIk
 ql8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjoom+lPfeFOcSMQNpfP6gzgHilNbipoYL+Ox5JvrRw3Wvqjskaqi1pq0J/QeZ5oiNfgv0nlSUmjb93ymHU0bIhz/tmQ==
X-Gm-Message-State: AOJu0YysYdsbSdkpjesAtaB3WzFkW6I+uFTbJaA42WiGBBMaqTiHD5JQ
 cqzl9OKOxF5RfROzfkPowXYzCNCTjmk3vLbYJ7oOztQi5DA1L76AsqgALz45DYY=
X-Google-Smtp-Source: AGHT+IHwLkga7U+MJs4M9Q6sLiozULwCi4UpS+BkOGtGEE0XrvWgn3Gf7fHP+lli9uFK5MEJJ6vRBw==
X-Received: by 2002:a05:600c:548e:b0:418:fc73:c0d3 with SMTP id
 iv14-20020a05600c548e00b00418fc73c0d3mr519184wmb.24.1713461183769; 
 Thu, 18 Apr 2024 10:26:23 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/9] qcom: RBx fixes and USB support
Date: Thu, 18 Apr 2024 18:25:43 +0100
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJdXIWYC/yWMzQqDMBCEX0X23IU1xiT1VYqH/GzaHNSa2CKI7
 95QYS7fDN8cUDgnLjA0B2T+ppKWuUJ7a8C/7PxkTKEyCBKSZGvQSVz9MmF2O8a0c8FOKq2C1s5
 0Dqr3zvwfqvYYL868fur1dpXgbGGsJ1Pahib0UpEjI3xQNgZi0p64prdGhNZGEzzdo4bxPH/iI
 RMxrwAAAA==
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1586;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=38TM/tmPYJYcbc2Pv1BLn8wG1YpYnE/zyJ/5KBsxEjA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H23okXWiDnXPZhjFuO9IPSk2sZbb7YkhNw7wqz+Z
 Yl8o19YRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjI/kuMDJtfT9/fLaHcZvLt
 ddaXS7Y/+jI3CB/nnBXmtX3ZPpNXxw4x/OF1PqBkZPNO1GXj+XO72CLvPgxgMZt1QIMlwkGwxmC
 dpAIA
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

This series is a few loosely connected patches to get the RB1 and 2
boards booting from USB with upstream U-Boot, and a few preperatory
patches for rb5.

Unfortunately the RB5 board requires a regulator on the RPMh peripheral
to be turned on for the USB VBUS rail. Support for this will be added in
future patches.

* Add a few missing compatible strings for sm6115/sm8250
* Fix the femto-v2 HS USB phy used on sm8250
* Fix USB role selection on RB2 (without breaking Linux!)
* Pick a value for CONFIG_SYS_LOAD_ADDR that won't cause a null pointer
  on most boards
* Fix EFI booting by generating SMBIOS tables

---
Caleb Connolly (9):
      gpio: qcom_pmic: add pm6125
      gpio: qcom_pmic: add pm8150l
      iommu: qcom-smmu: add qcom generic compatible
      phy: qcom: snps-femto-v2: drop clocks
      arm: dts: qrb4210-rb2-u-boot: add u-boot fixups
      mach-snapdragon: implement ft_board_setup() for USB role selection
      qcom_defconfig: enable OF_BOARD_SETUP
      qcom_defconfig: define safe default SYS_LOAD_ADDR
      qcom_defconfig: generate SMBIOS tables

 arch/arm/dts/qrb4210-rb2-u-boot.dtsi      |  6 ++++++
 arch/arm/mach-snapdragon/of_fixup.c       | 20 ++++++++++++++++++++
 configs/qcom_defconfig                    |  5 +++--
 drivers/gpio/qcom_pmic_gpio.c             |  2 ++
 drivers/iommu/qcom-hyp-smmu.c             |  1 +
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 14 --------------
 6 files changed, 32 insertions(+), 16 deletions(-)
---
base-commit: d5460b082cd6afd0e07c0ec0e5a82d1af8dc09f7

// Caleb (they/them)

