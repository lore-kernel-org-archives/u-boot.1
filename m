Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E533CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 06:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6542683870;
	Fri,  5 Sep 2025 08:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OueeBqxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07E68388D; Fri,  5 Sep 2025 08:39:42 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3BF83857
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 08:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-336bbcebca9so13929541fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 23:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757054380; x=1757659180; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7nw3EVbPjlpNLozO9fXzK+FlfcUv696zCvBuW+5os2I=;
 b=OueeBqxuG6gOIeOcflBj8ACqa+8q9zLN+nxy9YZL0ptpRaemnvUW8xjYCSM4QKxkyq
 EdRQ/0hhONrSHpugVlCB3Cboon21NSAIjlm4LMV8Gi9T0/R44jR13ub2Nk7Do9DlsaoS
 3wgh1VUajZTkP9p2wRp6uFdcBkOr1vgnuRGsAv2mL5EtSNgVrQUSZ6QuPfhVVvCDMz/H
 QYCuRflszVyKiG37J3f5054lik73M6YrM+8kvmZIVv95PZn2Uio+uuxqt0eVtcqhw6ug
 kVZJOFf7CCOpvBHUcBCN5pPaUs9AKxqZY6D/egUI4Cuum2W7lZxzDIXZh9mTKxEGHdZt
 Pmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757054380; x=1757659180;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7nw3EVbPjlpNLozO9fXzK+FlfcUv696zCvBuW+5os2I=;
 b=QVMFII+d5+ZHXU1D3bIs/7ECnOyozuG+eGj8FY4pnMny+WXR05Q5Nkk1BjdLwMaNT8
 v3TEqyj4DPOdUhNavpJOTP3/0fAc4BTZ+1+6du059NBNz0fjmiy73Nqw1uM93db3cZO+
 md2MkapRmE7AekJAxX6Ud7N0vqM7GqeBURGA9ZYV6iVDEHIrXyMa4Vni26SLo9xcLp84
 fBq97ChPhkM15+2/s7gTCVg4brScPrJRIcph+v8EjEF1aU9amV9n+VenbSwTlTH1Ffd1
 1NeF4Mq+zD6fEfT2vvug1zOYCyV/zxdBVVR/CrDPH4fIxgL9nzP7KTeXhlGKkqjvTyNi
 5oUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi4OauVkAx8qj1vNdrbp0LnkaqhjKSc3nu/h1cN9cP8OG4q/fx0eCYksrOc/qIu5VTQx/U6v0=@lists.denx.de
X-Gm-Message-State: AOJu0YyX595s9H79E1nB+/K1Bs5m2LLsv/d61ccwUpiO1nhenNbx63Y2
 Z27IP2XCfuAfGtmHSR1pEy3kMWLfz8FvjTCGxZdzc1KWHyZ0weSA04CnAVMI4ShpQlYTxcWup/W
 L1Wyf7zuvIV4w2SCPSs/0/46pGSumFXE=
X-Gm-Gg: ASbGncu2j8gJ8bYc4UAc+OoYwwc5SzuDd/2PZDmWAOXnTH4ckluc4RKF/Qt8uhvHymW
 XGsxDiGkZrcmxEOkGVFXJZC8R2bnRoizFWGA2KAryfol/OF9FKJMc+xCGS5WHYmFPEVswAzy0ha
 1D0t53HmM2gIVaEy/Gv0fVO8XAF6chhHHG84RdcQWxCS+TjXHRuHS+DifuDfue3K8x9JVWD8N66
 VoE7sjRsQPPX31B3g==
X-Google-Smtp-Source: AGHT+IED2bscfiDqqayv6oR4jB8upN0mmYptQREJrxYxS0WxpZYu7hznYtmjNd9Rrk8IpsCBxQ+Ni71j3ddwLdan9Gw=
X-Received: by 2002:a05:651c:554:b0:336:d2fa:b3d with SMTP id
 38308e7fff4ca-336d2fa0d41mr53271901fa.37.1757054379430; Thu, 04 Sep 2025
 23:39:39 -0700 (PDT)
MIME-Version: 1.0
From: Minkyu Kang <promsoft@gmail.com>
Date: Fri, 5 Sep 2025 15:39:27 +0900
X-Gm-Features: Ac12FXzHUf6a-Rzdp4CfB18ydg2LmoK1okLaqZwl_LFrKAA-2iz7kp9PrnFcA9U
Message-ID: <CALrBrZ3u3hGubrjAowRzuR0G2x=EOxPzoC0ezskJbi06YC_nmw@mail.gmail.com>
Subject: please pull u-boot-samsung master
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Tom,

The following changes since commit 3dc5e9a0108bb114175b6362f9cb22367402f624:

  Merge tag 'u-boot-stm32-20250825' of
https://source.denx.de/u-boot/custodians/u-boot-stm (2025-08-26 08:33:10
-0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 93c3404de9b2320bfd07cd3ce4ab0660f0d39523:

  spi: exynos: Remove extra term from test (2025-09-03 19:32:38 +0900)

----------------------------------------------------------------
Andrew Goodbody (2):
      clk: exynos: Fix always true test
      spi: exynos: Remove extra term from test

Henrik Grimler (3):
      ARM: exynos: use correct exynos4210-origen SoC in Kconfig
      ARM: exynos: pinmux: fix parentheses alignments
      ARM: exynos: pinmux: add newlines to debug messages

Sam Protsenko (10):
      usb: host: dwc3-of-simple: Add exynos850 compatible
      board: samsung: e850-96: Set ethaddr
      board: samsung: e850-96: Add ACPM code
      board: samsung: e850-96: Add PMIC code
      board: samsung: e850-96: Configure PMIC regulators
      board: samsung: e850-96: Extract device info from fw loading code
      board: samsung: e850-96: Add bootdev var to choose boot device
      configs: e850-96: Disable CONFIG_DEFAULT_FDT_FILE
      configs: e850-96: Enable USB host support
      configs: e850-96: Enable Ethernet

 arch/arm/mach-exynos/Kconfig        |   2 +-
 arch/arm/mach-exynos/pinmux.c       |  32 +++----
 board/samsung/e850-96/Makefile      |   2 +-
 board/samsung/e850-96/acpm.c        | 169
++++++++++++++++++++++++++++++++++++
 board/samsung/e850-96/acpm.h        |  27 ++++++
 board/samsung/e850-96/e850-96.c     |  97 ++++++++++++++++++---
 board/samsung/e850-96/e850-96.env   |   2 +-
 board/samsung/e850-96/fw.c          |  45 ++++++----
 board/samsung/e850-96/fw.h          |   4 +-
 board/samsung/e850-96/pmic.c        | 144 ++++++++++++++++++++++++++++++
 board/samsung/e850-96/pmic.h        |  14 +++
 configs/e850-96_defconfig           |  10 ++-
 drivers/clk/exynos/clk-exynos7420.c |   2 +-
 drivers/spi/exynos_spi.c            |  10 +--
 drivers/usb/host/dwc3-of-simple.c   |   1 +
 15 files changed, 502 insertions(+), 59 deletions(-)
 create mode 100644 board/samsung/e850-96/acpm.c
 create mode 100644 board/samsung/e850-96/acpm.h
 create mode 100644 board/samsung/e850-96/pmic.c
 create mode 100644 board/samsung/e850-96/pmic.h

-- 
Thanks,
Minkyu Kang.
