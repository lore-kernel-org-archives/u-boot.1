Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7BEC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D129183457;
	Thu,  7 Aug 2025 00:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f0TpkyLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7901783AED; Thu,  7 Aug 2025 00:27:27 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7516A80FA8
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7416d362e7aso348581a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519231; x=1755124031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BV2Kg1UufXJbExdCfi7l/Axe18qmpDpQ7t2fZsXOZds=;
 b=f0TpkyLhV3r5tCEdxqkwK5GQzgkRdnJaZzHuI/Mhla/fAmpardHyqEGuyKdZfuGoGD
 upav7DHX3mDs+kbUJK1Aj4MlCaqAP6lQJjpTzlXs7t6DV7l9GBXAdVS7T4VyroTu7Kzr
 xuQVl3PenoD4JBRaK4WdYcb9WTbkIJIr+ZepQFof0SeZEHBqYNTTh4rsFzxHrnREKrrn
 4EyVASZy4WgFlApxRpTvpLucSfy3F4XIu6Dun03xjWpxyUqb1yDh4gCHNqIS0WPlWdEU
 ZUC4a1eE/GDUIAzBQkXyPfCjaBcLJ2b44hgVEExiHwzve7AfwO0rCjIYWmCuZM3Apwnu
 Ae5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519231; x=1755124031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BV2Kg1UufXJbExdCfi7l/Axe18qmpDpQ7t2fZsXOZds=;
 b=UPCLyX0VWBQHe8XB7vb/KS+QOlT1lAW3ZtvEwuu0VXSmYQAl7cEXXRr1ZAWmiBYd3G
 UoSjgXB9/GPT86HfWNPaUGP/etr6zIHekFK8vaj9KhX9BwnmBHYrtzIH49jX6xlDnGbN
 dlrKWT5CHHB+7ozyNqwT8Pc2CoIX5Vj9sYk4l2kQBEksPoB+RabBmBzUgdMpAuDaZgbO
 dWcZ4H83sXijByBijZRUIdhwwSdXcItILtzYVs1z/UCt/ds/MGJOis/dH6m3rlThbt1d
 346QiEa/Ni07eDx8Nd1trbF+gNQmo13oPXaCsdVIDagUb0vZSzpJcr0theMsiUJTYj4e
 08Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNQqPFx9SkiHSsJ/5uI+06ngMt1ALpy7PPtcoSjE6bQmgLosc9s/dgYySkfqpyQkrSvERAY5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzYPCxkzFljJ1/+YRRPufge04yd5i5y+ZjLFVp4/n1G9D45EUiI
 uEUKBLnsbk3MWIYxFwKX43+foH90o9iSuyWpbq99SyaXJR+tUv+GAW7t+/3MUwI4xeg=
X-Gm-Gg: ASbGncvEAcnuEEGWNFns04OAEo1ohSI05kEACQ8mMSKMY29hdszeit8P6NPIH+xTDsD
 12RMsgGGoIJWd8SQhe+d3pI1kwIu8xAUCOqXsBLwEirLVDV19eUwlSzGsYCBOgO1LYNuokKQJPL
 sv/fqiFYe2CmI+YmpWG8n6EgtDgfEqkTio8OqDlFq5CbzPif//VS8rc1doEsQ69i69Tbpa6Uoj9
 JfaWq7D72zLRsW4fuDgtWKaPWQSo/h6jvLzIfK+DX/1q9O4Tl+QTkdzuOBVtbc7VjtJAmVaa/gc
 STv/0LZW3baAnNCBizS3CSvBwSHgcC1IKtPsnSb26PIViiN8+0MazLWlp2YK+iG1LujIAVhg/62
 pD0wVMEHTqPSRJx2w5oWs/QZphg==
X-Google-Smtp-Source: AGHT+IErYe0grmXlpBEzNjh7rLJhUKHGv/CKGl/lQ10jDUnLzzqXFP7Mq1fSg74E1lJf0RpOQ3Ed3w==
X-Received: by 2002:a05:6830:25d0:b0:73e:a0ab:3994 with SMTP id
 46e09a7af769-7430b31b508mr2890213a34.12.1754519231412; 
 Wed, 06 Aug 2025 15:27:11 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186ca91ddsm3648519a34.9.2025.08.06.15.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:11 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 00/10] samsung: e850-96: Enable USB host and Ethernet
Date: Wed,  6 Aug 2025 17:27:00 -0500
Message-Id: <20250806222710.23773-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

The E850-96 board has a LAN9514 chip which acts as a USB hub and
Ethernet controller. It's connected to the SoC via USB lines. In order
to make this chip functional the USB controller in Exynos850 SoC has to
be configured in the host role, and the corresponding power regulator
has to be enabled as well.

This patch series enables USB host and network support on the E850-96 by
making use of the LAN9514 chip. While at it, enable all power regulators
(LDO) in the PMIC chip which can be useful in the bootloader and kernel,
including the regulator used for LAN9514.

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

 board/samsung/e850-96/Makefile    |   2 +-
 board/samsung/e850-96/acpm.c      | 169 ++++++++++++++++++++++++++++++
 board/samsung/e850-96/acpm.h      |  27 +++++
 board/samsung/e850-96/e850-96.c   |  97 +++++++++++++++--
 board/samsung/e850-96/e850-96.env |   2 +-
 board/samsung/e850-96/fw.c        |  45 ++++----
 board/samsung/e850-96/fw.h        |   4 +-
 board/samsung/e850-96/pmic.c      | 144 +++++++++++++++++++++++++
 board/samsung/e850-96/pmic.h      |  14 +++
 configs/e850-96_defconfig         |  10 +-
 drivers/usb/host/dwc3-of-simple.c |   1 +
 11 files changed, 482 insertions(+), 33 deletions(-)
 create mode 100644 board/samsung/e850-96/acpm.c
 create mode 100644 board/samsung/e850-96/acpm.h
 create mode 100644 board/samsung/e850-96/pmic.c
 create mode 100644 board/samsung/e850-96/pmic.h

-- 
2.39.5

