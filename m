Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95155C48BF8
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDA687DED;
	Mon, 19 Feb 2024 14:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2IHI+m7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5853A87F48; Mon, 19 Feb 2024 14:10:27 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1C287F33
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso1245532a91.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708348209; x=1708953009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CNfGQztNZ4X1buBrwQEkyiKtkXv6ygsx8PU+fiTec8A=;
 b=V2IHI+m70nba8VVuMVFc4WFTi4+7ApQrAypaThbjbsR/JztHrRS7n316gkYgeIJhyv
 nEeFWl5x0QpXv8qzOr1zWU0kEIrDzVkgwQF/dFf1y1K4molzigPNwxF9Snb1DV2zwdPp
 XE+nqiOlqkgeBrQgBzJU/XFeaeE3aUuqfnPabeIfms0z9RX4TDLkp1HigryaY/MZA/T+
 kioAYz8+Ksfj65ByyYg2bRhzegSQtbs5IG+mdDUrU2gw8qiqu8PFcLdqZf1SFeJflG8d
 5XXTeqndgU1oJ8Tu1lC5XVUMGAXYGnqD2H8a7lxuHbCOMjqrubZ4n/IfK6hX6sDmKAeA
 9cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348209; x=1708953009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNfGQztNZ4X1buBrwQEkyiKtkXv6ygsx8PU+fiTec8A=;
 b=Ozq4y3Kphs1hcEUg9kSLN6zI0Twy8a6OHbs8eoiWeUDqpr1+WCR3QBHhlAF88WUf8Y
 DPB8exn8m9lozBWdaaJER29jkyHOguqUpUI/xr1TyrRghSm/Vd1x13bng90Wu1uzx45/
 urXlVFiehh6Kkry9qT6IqlzHgrP+x5KGjZU5T30eXr7+3VEo9Vv/2bdn46Xc1vNwKg5l
 BNe9Z/BFjUmb/Mtb/OG1N4gOh9EBpe/ubADf4q+RgDeD4XnaXfgtdQsMCAeyGFUkCMnU
 VTaqDiZ3HPxuK/QtpFR1ukPBoEcFnzLxHWAdC/eYnXYId9IR/uMrTeo6uVproToyN5xM
 bxFA==
X-Gm-Message-State: AOJu0Yw1E7ttl8JpWB/K7QUfiwq/03tKBUCF1eK4m3C0yzO1PsFYWFxJ
 cETtoEM8FN1HU5Zbj1UsBtKQZZU372oJGgGxnELh90iH0Q9+GEy9ssIDvwg8
X-Google-Smtp-Source: AGHT+IG1io6Vx2BZj9ODQPxMUgquTpT6en3r3YJ3WysjYrLHl33TGVzG7FGNwZKyJhks0NyKc3NUmQ==
X-Received: by 2002:a17:902:c185:b0:1db:a770:81a4 with SMTP id
 d5-20020a170902c18500b001dba77081a4mr9835084pld.1.1708348209183; 
 Mon, 19 Feb 2024 05:10:09 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:dae7:e0e5:f74b:fce1])
 by smtp.gmail.com with ESMTPSA id
 jw11-20020a170903278b00b001db67377e8dsm4329462plb.248.2024.02.19.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 05:10:08 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240219
Date: Mon, 19 Feb 2024 10:10:06 -0300
Message-Id: <20240219131006.391634-1-festevam@gmail.com>
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

Please pull from u-boot-imx, thanks.

The following changes since commit e4013bcb10f604ec1dfe955634d57e1fc336b15f:

  Merge branch 'master-porter' of https://source.denx.de/u-boot/custodians/u-boot-sh (2024-02-17 18:37:07 -0500)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240219

for you to fetch changes up to 0cfc2e9225fb682a1a5b3e5d49af8ebf8d893cef:

  doc: board: Add minimal documentation for Sielaff i.MX6 Solo board (2024-02-19 08:19:39 -0300)

u-boot-imx-master-20240219
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/19683

- Convert msc_sm2s_imx8mp to DM_SERIAL.
- Make Ethernel functional on msc_sm2s_imx8mp.
- General improvements for msc_sm2s_imx8mp.
- Add suport for the Sielaff i.MX6 Solo board.
- Update GE HealthCare maitainers' e-mail addresses.
----------------------------------------------------------------
Fabio Estevam (5):
      msc_sm2s_imx8mp: Convert to DM_SERIAL
      msc_sm2s_imx8mp: Make Ethernet functional
      imx8mp-msc-sm2s: Add mmc aliases
      msc_sm2s_imx8mp: Add redundant environment support
      msc_sm2s_imx8mp: Fix CONFIG_DEFAULT_FDT_FILE

Frieder Schrempf (3):
      mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
      board: Add support for Sielaff i.MX6 Solo board
      doc: board: Add minimal documentation for Sielaff i.MX6 Solo board

Ian Ray (1):
      MAINTAINERS: Update after GEHC spin-off

 MAINTAINERS                                     |   2 +-
 arch/arm/dts/Makefile                           |   1 +
 arch/arm/dts/imx6dl-sielaff-u-boot.dtsi         |  38 ++
 arch/arm/dts/imx6dl-sielaff.dts                 | 533 ++++++++++++++++++++++++
 arch/arm/dts/imx8mp-msc-sm2s-u-boot.dtsi        |  13 +
 arch/arm/mach-imx/mx6/Kconfig                   |  10 +
 board/ge/b1x5v2/MAINTAINERS                     |   4 +-
 board/ge/bx50v3/MAINTAINERS                     |   2 +-
 board/ge/mx53ppd/MAINTAINERS                    |   3 +-
 board/msc/sm2s_imx8mp/spl.c                     |   9 -
 board/sielaff/imx6dl-sielaff/Kconfig            |  15 +
 board/sielaff/imx6dl-sielaff/MAINTAINERS        |   9 +
 board/sielaff/imx6dl-sielaff/Makefile           |   8 +
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c   | 111 +++++
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env | 114 +++++
 board/sielaff/imx6dl-sielaff/spl.c              | 273 ++++++++++++
 configs/imx6dl_sielaff_defconfig                | 120 ++++++
 configs/msc_sm2s_imx8mp_defconfig               |  10 +-
 doc/board/index.rst                             |   1 +
 doc/board/sielaff/imx6dl-sielaff.rst            |  29 ++
 doc/board/sielaff/index.rst                     |   9 +
 drivers/mtd/spi/spi-nor-ids.c                   |   1 +
 include/configs/imx6dl-sielaff.h                |  25 ++
 include/configs/msc_sm2s_imx8mp.h               |   2 -
 24 files changed, 1323 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/imx6dl-sielaff-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6dl-sielaff.dts
 create mode 100644 board/sielaff/imx6dl-sielaff/Kconfig
 create mode 100644 board/sielaff/imx6dl-sielaff/MAINTAINERS
 create mode 100644 board/sielaff/imx6dl-sielaff/Makefile
 create mode 100644 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.c
 create mode 100644 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
 create mode 100644 board/sielaff/imx6dl-sielaff/spl.c
 create mode 100644 configs/imx6dl_sielaff_defconfig
 create mode 100644 doc/board/sielaff/imx6dl-sielaff.rst
 create mode 100644 doc/board/sielaff/index.rst
 create mode 100644 include/configs/imx6dl-sielaff.h
