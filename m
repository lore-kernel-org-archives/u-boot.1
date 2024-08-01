Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228CEC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999A888A7F;
	Thu,  1 Aug 2024 07:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G/LTVpm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C4D88AE4; Thu,  1 Aug 2024 07:57:51 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E0F8839A
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so796735566b.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722491869; x=1723096669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UqLVyoHanu3ol8IBjOxTJwKAbCCDuOxMedbD8SFUKdk=;
 b=G/LTVpm3GqfLFIqBExeUCGvYPcKAIDDyUsNxAAnAyef0fyze1q8NOt1jz0711tJUFV
 W8yWMxQ84F100xZrjOIl81oB9ZQMbRGE93UY03s0Du2pdku0Tc4qgBwj89oAOmlEskxx
 jz8LahUi0pHRBk7HZS+mTdYz0yK2tJp8HGnizYPcQvnCOJ+KPjG+Jn8PjsHUDvt6Xa+B
 8EFGd3CLJ69u7CL+u/WLWaFKC5DufDsId1Mw5ygBFbw+ha/eoVrx8Bnt+Yh+pVNqLz8x
 pbCqqa6UyHLj2UNuJmPLcQrzG/tMRpjhlVR9fzBJMaSIL6t8YJSiapA/DF6txWjTKLdj
 +Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722491869; x=1723096669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqLVyoHanu3ol8IBjOxTJwKAbCCDuOxMedbD8SFUKdk=;
 b=iyqf72tfH2HWoCH73FlvsmhHVVOIRbQZ5t3fvDnrP3APZzB7Vo/w5UWBIRVUhwB/Ju
 zFPQ3Ae1Y1xQb7+NV4h/+uMnxq5oD/HZzQ99nJt5otrHUwExdewwFuu4CM4urtU3LA+n
 4aENkZGv5gr3KBeYbstrTO2bWYSrCZD2FcZtGVdeCB/sSicP2dJpD9jMDaeYaUS0Belp
 McsLQncLYGmaUros7CQvPgjqOuQu9HA9gQEW9dGbrIrfuejkK51hL4tzey14MzFAcFGD
 m6+TEyZnZledFHvAa5U1DzQ0NNRibtvC0XhxuRqVBAx8+rXs7tzt0Goy+Ylmt5ZVzCZZ
 GeDQ==
X-Gm-Message-State: AOJu0YxG47ixPRb7gvvV8+VblF/LpV5V9Wf4H6Dy48TLL+Z3D+KAgd7v
 NSlYndssWk8y+5SOSxpSVtvTaQAT14ywjIoq5pZd/UY3tnZc+UYT
X-Google-Smtp-Source: AGHT+IE7CrtEFzlELbRWyyNioP44gZHxkD6aBrT5KuR/JqOi9/DSOWaqy6zflkOVt9HeQbeTfCeIeg==
X-Received: by 2002:a17:907:9706:b0:a77:cdaa:88a3 with SMTP id
 a640c23a62f3a-a7daf2cd370mr90713166b.27.1722491868662; 
 Wed, 31 Jul 2024 22:57:48 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23654sm853848266b.32.2024.07.31.22.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:57:48 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] board: tegra: convert boards to text env
Date: Thu,  1 Aug 2024 08:57:37 +0300
Message-ID: <20240801055738.7601-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Move env stuff into dedicated files in boards (1st stage).

U-Boot CI passed, boards I own work fine, tests are welcomed.

Svyatoslav Ryhel (1):
  board: tegra: convert tegra-based boards to text env

 board/asus/grouper/grouper.env                | 15 +++
 .../asus/transformer-t20/transformer-t20.env  | 16 ++++
 .../transformer-t30/configs/tf600t.config     |  1 +
 board/asus/transformer-t30/tf600t.env         | 16 ++++
 .../asus/transformer-t30/transformer-t30.env  | 16 ++++
 board/htc/endeavoru/endeavoru.env             | 13 +++
 .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
 board/lg/x3-t30/configs/p880.config           |  1 +
 board/lg/x3-t30/configs/p895.config           |  1 +
 board/lg/x3-t30/p880.env                      | 14 +++
 board/lg/x3-t30/p895.env                      | 13 +++
 board/microsoft/surface-rt/surface-rt.env     | 14 +++
 board/nvidia/cardhu/cardhu.env                |  2 +
 board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
 board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
 board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
 board/toradex/apalis_t30/apalis_t30.env       |  9 ++
 board/toradex/colibri_t20/colibri_t20.env     |  3 +
 board/toradex/colibri_t30/colibri_t30.env     |  9 ++
 board/wexler/qc750/qc750.env                  | 14 +++
 configs/apalis-tk1_defconfig                  |  1 +
 configs/apalis_t30_defconfig                  |  1 +
 configs/cardhu_defconfig                      |  1 +
 configs/colibri_t20_defconfig                 |  1 +
 configs/colibri_t30_defconfig                 |  1 +
 configs/endeavoru_defconfig                   |  1 +
 configs/grouper_common_defconfig              |  1 +
 configs/ideapad-yoga-11_defconfig             |  1 +
 configs/p2771-0000-000_defconfig              |  1 +
 configs/p3450-0000_defconfig                  |  1 +
 configs/qc750_defconfig                       |  1 +
 configs/surface-rt_defconfig                  |  1 +
 configs/transformer_t20_defconfig             |  1 +
 configs/transformer_t30_defconfig             |  1 +
 include/configs/apalis-tk1.h                  | 58 ------------
 include/configs/apalis_t30.h                  | 12 ---
 include/configs/cardhu.h                      |  4 -
 include/configs/colibri_t20.h                 | 11 ---
 include/configs/colibri_t30.h                 | 12 ---
 include/configs/endeavoru.h                   | 43 ---------
 include/configs/grouper.h                     | 45 ---------
 include/configs/ideapad-yoga-11.h             | 58 ------------
 include/configs/p2771-0000.h                  | 20 ----
 include/configs/p3450-0000.h                  | 13 ---
 include/configs/qc750.h                       | 42 ---------
 include/configs/surface-rt.h                  | 18 ----
 include/configs/transformer-common.h          | 91 -------------------
 include/configs/transformer-t20.h             |  4 +-
 include/configs/transformer-t30.h             |  6 +-
 include/configs/x3-t30.h                      | 44 ---------
 include/env/nvidia/prod_upd.env               | 59 ++++++++++++
 51 files changed, 326 insertions(+), 475 deletions(-)
 create mode 100644 board/asus/grouper/grouper.env
 create mode 100644 board/asus/transformer-t20/transformer-t20.env
 create mode 100644 board/asus/transformer-t30/tf600t.env
 create mode 100644 board/asus/transformer-t30/transformer-t30.env
 create mode 100644 board/htc/endeavoru/endeavoru.env
 create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
 create mode 100644 board/lg/x3-t30/p880.env
 create mode 100644 board/lg/x3-t30/p895.env
 create mode 100644 board/microsoft/surface-rt/surface-rt.env
 create mode 100644 board/nvidia/cardhu/cardhu.env
 create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
 create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
 create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
 create mode 100644 board/toradex/apalis_t30/apalis_t30.env
 create mode 100644 board/toradex/colibri_t20/colibri_t20.env
 create mode 100644 board/toradex/colibri_t30/colibri_t30.env
 create mode 100644 board/wexler/qc750/qc750.env
 delete mode 100644 include/configs/transformer-common.h
 create mode 100644 include/env/nvidia/prod_upd.env

-- 
2.43.0

