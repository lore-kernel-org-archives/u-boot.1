Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1317BC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 12:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767D781119;
	Mon, 27 Jan 2025 13:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RyI3teZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8F38111F; Mon, 27 Jan 2025 13:11:42 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CF681115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso74917815ad.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 04:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737979899; x=1738584699; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aPlWLNyaIqAi3QU0qksVsNeTacSigRr9aFThzKr1e+s=;
 b=RyI3teZkzWAGNGmi5QEjJ+KQupeybGYwKKatEfFpcK5xi72K9+C524v5nq+WogE59t
 mAAUCqHbF3toWk/1hyyDPMWX/PD3+VN9yDejgJcmjGECWsGNV9wf210TRdxvmUYF1mRE
 YFR2uWUc8i1Bn2nczKClVnawTclMmPD4dMiqfj6mhtlwKA0G0gB/6Z5vGZ6iUJwwqV4C
 6FfYavTEQBw1Wc8UxTZTuaJfmF4N9Bp7dBgAyAEDatw/YFZYDavckDKo3pjHGgEfOzRc
 P8o+YavSQ2JVvf+YuZQneCGxWoLo2XAj4/idQpFPVttLjpIWwNKz0pCuv0aieCfIVZEv
 Ieeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737979899; x=1738584699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPlWLNyaIqAi3QU0qksVsNeTacSigRr9aFThzKr1e+s=;
 b=Vsh2IuEvxgeJNr4vLf0+7kFOZufnIjXBEHzf++yajcj1UsDubV/ktyGhogRul27C3Y
 49i/JZdk/CidltgQ0yTFpAqGA301JwCr7kozvCYkiR70XN7Jhjjc1C3vUa8DXlN8FGHB
 Fcw2cLA2vmdonW4hJBPLr3iIMaAF+iILqPe8ioLVyQ6Zm+c7BtKe2houovhquDYrPuLn
 9PAzmAHlp+QCIgfZQ8KuDcd6GulsT9gniz+JLAfflfPV5x157+4cCCGMLw5WYFfYMefm
 eY5kW7hNJvZoH5ZiDldFJW5YhN2vRpGrgof1YOh+QTLRR8R/h+6ECv34GPNRFzz8Fnnv
 7WvQ==
X-Gm-Message-State: AOJu0YwOiXu1WGlvbBd0mFrmi/8h3aVgyZnuZunCG3PzdnRxTCl8j7jE
 yZv8K8A04oDfA3TZsBOu3DWcjIKAu38H7jLER7Ct/dJyochn3kL3pVH7Uw==
X-Gm-Gg: ASbGnct6wFZba5HJwrgrdIogTdzisSujCs3BeJ58AcEe1jbE7cQ1PSx9qIN+8qHQ2zg
 OC7od5RbVcSEaNC3vEA03/0apPUTSTGqRCNVGENBwhAOXyUnNtshXlIljv9uuO2unm90v8ZPbA+
 73zKEa8IzMueeN/Cde2J3OWoK6kfQw7xm3bpmyVDgNRSSxt0T8UT9GBcDDAa23TOtxMr16v+KDt
 c/ytDk6UU7v9DZywbVQ3TVM+Xn+CaAlFYEu/oew8JVRgch/qhhxnGC28AHvOjKTduMKi01Lx5p9
 juPYgXRoUbIn5D3ZBt0=
X-Google-Smtp-Source: AGHT+IFyOAoJANkHxhd7UVVJTcIUkFlBOb8IKbgobwol47KK8QLQHP7qMo3cjvbQe5ZV4IUapZOVJA==
X-Received: by 2002:a17:902:ea0e:b0:216:6fb5:fd83 with SMTP id
 d9443c01a7336-21c35563092mr180222635ad.29.1737979898615; 
 Mon, 27 Jan 2025 04:11:38 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:eb9d:1fda:389d:6d4c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3b69sm61698825ad.61.2025.01.27.04.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 04:11:37 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20250127
Date: Mon, 27 Jan 2025 09:11:34 -0300
Message-Id: <20250127121134.634412-1-festevam@gmail.com>
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

The following changes since commit 8162f35a108441b8d7a44ac9266c1a64dbf79fd5:

  Merge patch series "test: Improvements to ut command and test-suite running" (2025-01-24 14:35:37 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20250127

for you to fetch changes up to 219b0488200633cda74ecc04cda2eb84443ab88d:

  net: fsl_enetc: Enable optional ENETREF clock on i.MX95 (2025-01-27 00:27:54 -0300)

u-boot-imx-master-20250127
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/24366

- Refactor the imx pinctrl driver.
- Enable optional ENETREF clock on i.MX95
- Remove optional from tee-os entry on the i.MX8M u-boot devicetrees.
----------------------------------------------------------------
Marek Vasut (11):
      pinctrl: imx: Push imx_pinctrl_ops into drivers and staticize
      pinctrl: imx: Rename imx_pinctrl_ops to match drivers
      pinctrl: imx: Drop .remove callback for SCU variant
      pinctrl: imx: Inline struct imx_pinctrl_soc_info access into probe
      pinctrl: imx: Split imx_pinctrl_probe() into common and mmio parts
      pinctrl: imx: Rename imx_pinctrl_remove() to imx_pinctrl_remove_mmio()
      pinctrl: imx: Split imx_pinctrl_set_state() into common and mmio parts
      pinctrl: imx: Split imx_pinctrl_set_state_scu() from imx_pinctrl_set_state_mmio()
      pinctrl: imx: Fold imx_pinctrl_set_state_scu() from pinctrl-imx8.c
      pinctrl: imx: Split MMIO accessors into pinctrl-imx-mmio.c
      net: fsl_enetc: Enable optional ENETREF clock on i.MX95

Yannic Moog (1):
      arm: dts: imx8m*-u-boot: remove optional from tee-os entry

 arch/arm/dts/imx8mm-u-boot.dtsi        |   1 -
 arch/arm/dts/imx8mn-u-boot.dtsi        |   1 -
 arch/arm/dts/imx8mp-u-boot.dtsi        |   1 -
 arch/arm/dts/imx8mq-u-boot.dtsi        |   1 -
 drivers/net/fsl_enetc.c                |  23 +++-
 drivers/pinctrl/nxp/Kconfig            |  22 ++--
 drivers/pinctrl/nxp/Makefile           |   2 +-
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c | 228 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx.c      | 222 ++------------------------------
 drivers/pinctrl/nxp/pinctrl-imx.h      |  20 +--
 drivers/pinctrl/nxp/pinctrl-imx5.c     |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx6.c     |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx7.c     |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c  |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx8.c     |  86 +++++++++++--
 drivers/pinctrl/nxp/pinctrl-imx8m.c    |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c  |  18 +--
 drivers/pinctrl/nxp/pinctrl-imx93.c    |  18 +--
 drivers/pinctrl/nxp/pinctrl-imxrt.c    |  18 +--
 drivers/pinctrl/nxp/pinctrl-scu.c      |  70 ----------
 drivers/pinctrl/nxp/pinctrl-vf610.c    |  18 +--
 21 files changed, 418 insertions(+), 421 deletions(-)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx-mmio.c
 delete mode 100644 drivers/pinctrl/nxp/pinctrl-scu.c
