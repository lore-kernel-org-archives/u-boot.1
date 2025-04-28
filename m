Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855ACC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 16:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1F782103;
	Mon, 28 Apr 2025 18:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WHznOc4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEE78210D; Mon, 28 Apr 2025 18:07:01 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B58381E0F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 18:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so4806409a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856417; x=1746461217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fu5W0aWSp4BdsYdKKWj5GIXYeNVIjvmjJyoLNBjpM1w=;
 b=WHznOc4BIIvf7NKRdHjdvN4rN1TXsU7pjI2K4Z792UFJmJMzVSVbJZOgDYNhvpG7u7
 +b+Xf1OXQqaFfa5HPDK/xgZPOV4RlZOMm0F9ZuCTU9jKIdY4XFtkSiMMjW5b6AvolQOM
 eapteHF47gecr8q3PqCFjgFEikiwfYc64ngPLs5eCoBmwRdG6xU5LxX0gOJBXEDlDET6
 JE5W2uDgEUMfumTaGXk2oJJjhaPpFjHM28+NgLIC/V1D1aX3NBBOJAMKPaSfqQIdbHKk
 A+FeFZQZoqYiEbmyFeT1Rws3Ft+K+RtNcz6xt5adaWg5ka9JcaqR2seL6dhE05C2GRcf
 7Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856417; x=1746461217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fu5W0aWSp4BdsYdKKWj5GIXYeNVIjvmjJyoLNBjpM1w=;
 b=qa6jFbMfZywdNxi2cAQkNK7aGWVYoTqTMvtxYYNaL+2bz3mEEqb0L12HqCxsPD4HK3
 5R/qE/zozTEeZidp2LS9DDHl07tEqczNDS7W2sXJ+OHWhr/XD+6+YzTtElK50jl+DViW
 IPXbc5v0HvkNK98VUTlapaa7U5RlUsL9OhmVLzinwYfCQFlxXb4PjETnG9p/KbCXiBqc
 SF9WY+oB1xD9nSf1uAs4CRvWRGRRws2RrUEjdeQKXZOU15kmh/fClMxYbTLsIPSAK8wJ
 l6yn9ExKVRVNo60beNUe1TB4tJtMbvwnySUJe9KEbc/8+dw+HJO9ZGI75OfFcfoXYdbp
 ZJqg==
X-Gm-Message-State: AOJu0YxOFbA0Xf4Ocjmmvrs7A8Q7DuSE2BW7nBrQMuFP6DqTqjbro9iq
 hQ0V6ucCZffNZX/o1j9kf+mmqILNdcNALoPvXcmNslrU7r6o6cG75HrR3A==
X-Gm-Gg: ASbGncsJQuovNeZZhwEMcNq3kj/3FObqwuNPYjoe3QJp6OsyP6JNAGztu0Z+v5Aahdd
 9XQLapVNpZXDtmHB3jUReGLj0tp5klPb/r2dIXJLlXqkVA8nfn6IDzWdpb5pY7Jsfo7juYSdXoV
 ACmWc/N99afEvRmSU85VLTy/mhDCSJAT8Ab24sC0TPNPx+OMQxdX2DGX5C8XPYFYCfTa5eumfBQ
 AKWuqv0ElAyCBB5nWvLsz5mQo23QlCqSacAdY7Kj3mgDzCBkU+ncdDhQbNVDOAPzsLMjjYPwfXG
 1CXx2bFfgQp+RwXbxQF3L9R/5dRaP6l/+ymShjZ6auKvpEmHTic7hew=
X-Google-Smtp-Source: AGHT+IE5HCOE52ucQYbw/RseVdsJQdwvKX2VrbxQH3Pfsk/2IS3A8kCeJMrv9k6BpeO+1b7EVfGl4Q==
X-Received: by 2002:a05:6a21:318b:b0:1f5:a577:dd10 with SMTP id
 adf61e73a8af0-2045b9f1a53mr19869526637.36.1745856417344; 
 Mon, 28 Apr 2025 09:06:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a6f1:d0dc:cd4e:d6d5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a317sm8452431b3a.93.2025.04.28.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:06:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250428
Date: Mon, 28 Apr 2025 13:06:52 -0300
Message-Id: <20250428160652.2592846-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Please pull from u-boot-imx/master, thanks.

The following changes since commit 10f48365112b164bee6564033ab682747efcb483:

  Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250428

for you to fetch changes up to ef41a9f01d20e9209942db4a679ab89b80bb876c:

  siemens: imx8qxp: remove unused config file (2025-04-28 10:46:12 -0300)

u-boot-imx-master-20250428
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/25974

- Fix power-domain ref counting regression.
- Fix i.MX8MP USB clock regression.
- Fix i.MX8MM osc_32k regression in SPL.
- Finish converting clock-osc-24 back to osc_24 on i.MX.
- Several imx8mp capricorn updates.
- Update Stefano Babic's email address.
- Fix fsl_qspi bug by moving AHB read buffer config after LUT.
- Fix verdin imx95 sku 0089 pid4.
----------------------------------------------------------------
Adam Ford (1):
      clk: imx: Finish converting clock-osc-24 back to osc_24

Emanuele Ghidoli (1):
      toradex: tdx-cfg-block: fix verdin imx95 sku 0089 pid4

Fabio Estevam (1):
      arm64: dts: imx8mm: Make osc_32k available in SPL

Heiko Schocher (3):
      imx8qxp: capricorn defconfig: collect common Kconfig options
      arm: imx8qxp: capricorn: move env offset settings
      siemens: imx8qxp: remove unused config file

Marek Vasut (1):
      clk: imx: Pass CCM udevice into clk_register_composite()

Miquel Raynal (2):
      power-domain: Add support for refcounting (again)
      imx: power-domain: Enable refcounting on imx8mp

Pawel Kochanowski (1):
      spi: fsl_qspi: Move AHB read buffer config after LUT

Stefano Babic (2):
      MAINTAINERS: Update email of Stefano Babic
      imx: mx51evk: drop Stefano Babic from MAINTAINERS

Walter Schweizer (2):
      siemens: capricorn: enable text based default environment
      siemens: capricorn: defconfig updates

 .mailmap                                         |   2 +-
 MAINTAINERS                                      |   2 +-
 arch/arm/dts/imx8mm-u-boot.dtsi                  |   5 +
 arch/sandbox/include/asm/power-domain.h          |   2 +
 board/freescale/mx51evk/MAINTAINERS              |   1 -
 board/siemens/capricorn/MAINTAINERS              |   1 +
 board/siemens/capricorn/capricorn_default.env    |  49 ++++++++
 board/toradex/common/tdx-cfg-block.c             |   2 +-
 board/toradex/common/tdx-cfg-block.h             |   2 +-
 configs/capricorn_cxg3_defconfig                 | 135 ++---------------------
 configs/imx8qxp_capricorn.config                 | 134 ++++++++++++++++++++++
 doc/git-mailrc                                   |   2 +-
 drivers/clk/clk-composite.c                      |   2 +
 drivers/clk/imx/clk-composite-8m.c               |  30 ++++-
 drivers/clk/imx/clk-imx8mm.c                     |   8 +-
 drivers/clk/imx/clk-imx8mn.c                     |   8 +-
 drivers/firmware/scmi/sandbox-scmi_devices.c     |   1 +
 drivers/power/domain/imx8m-power-domain.c        |   4 +
 drivers/power/domain/imx8mp-hsiomix.c            |   4 +
 drivers/power/domain/imx8mp-mediamix.c           |   4 +
 drivers/power/domain/power-domain-uclass.c       |  90 ++++++++++++++-
 drivers/power/domain/sandbox-power-domain-test.c |  15 +++
 drivers/power/domain/sandbox-power-domain.c      |   4 +
 drivers/spi/fsl_qspi.c                           |  13 +--
 include/configs/capricorn-common.h               |  52 +--------
 include/configs/giedi.h                          |  16 ---
 include/linux/clk-provider.h                     |   2 +
 include/power-domain.h                           |  69 ++++++++++--
 test/dm/power-domain.c                           |  11 +-
 29 files changed, 438 insertions(+), 232 deletions(-)
 create mode 100644 board/siemens/capricorn/capricorn_default.env
 create mode 100644 configs/imx8qxp_capricorn.config
 delete mode 100644 include/configs/giedi.h
