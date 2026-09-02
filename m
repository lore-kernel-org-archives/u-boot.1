Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB27C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 18:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B4D2608E2;
	Wed,  2 Sep 2026 18:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q30EdF_J1EQc; Wed,  2 Sep 2026 18:46:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 279CF607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788374768;
	b=nXz/zyAA5AuRQw01G/7m5ChoSADGC5LRDBm7/szgvk/dQlVMMfOh7+Y0AW4Mp8x2pgL4
	 SP13Gr3k5qEejlMfPb1+wn4PjHbyZUZXAHO8bBcOVkm7TzXzPLmLvLwhELjFdBgxDDTrr
	 C/vVCE+ZZn/VZMcjHhslNOc269G+4UPhfP3qxPHG344/BYlWH+J/WZR2cvbQhiZ1vUJpR
	 JM0yN35x5DuzxQDi+MovQpZi/xPK2qc27HFLzz20JwHhl0MdbPK6ixP4ECn452gG+dcQk
	 UdjvW6bO4Np4RKOKMO+/k4elQpcDLixzTzvck/aK3mhfHctrmqs5ttko499gmQFi7Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788374768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5ORFfDmvQHYPb2jUBs0fb6XIX0qCQs35bl3AcXFOg1c=;
	b=TUBKkigjyNYSvCyA3BzFsWSKoMK77Bnd8DsQYr1H2uoNxIvjPZA9dlN/do3wQ+QKeX4H
	 vjWMj84A3GvMKFLdmFaOLJ0WSKlXAPkmfmtIF/JT4l0nalETwo55+pA5cZMig4uc9T4X0
	 aovrDvk7McJ3SCDNMdg/8CdkJFQq8A3uGv5lMAIaV73ccJucWPi5BtbfLgz8fyNm18+43
	 LLDfef7ojLBi7ODExJuXBx7uhjZcB4J79ZwXXdap4exDpI4BoZOfJiHA979aozJGn3iOE
	 mCodHQBM540/kPC/rPKyE+BXO+/t6fP27/qGVUIIMkSJhEYMw5MkgtKgVsQxPKPumRQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788374768;
	bh=5ORFfDmvQHYPb2jUBs0fb6XIX0qCQs35bl3AcXFOg1c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wpYRWWYaXPZBoX6GG3aJcY0uwyjBetK2F8Ftd3yVolauE+CJkau5pywxC8zfROK2R
	 3jyTegng0lInCV6NwvevcuhsWDXZzFI+j9jE5hX02mrHF5b+ik0qKxTecpJAgo+4bY
	 GaeGvPprm9wt2TQABh3tmZGANwlTzz2OhArAT6gpaNx1uR0eTUiNsYWLnjXAI7hBZ6
	 j/rSSeJ44xcxQUUrieg2dG7+oV3mBigBrTqro0MP3F3DUOwt7da7V7mZP3TinVkr5v
	 z/oypkJ0gShEZ2hGgmTqDFFhP0jM8X+EHRF1z3QKyx/Qc1i+cia0hT7bvu4a4o5PX9
	 4lOHBNm5YbrxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 279CF607FF;
	Wed,  2 Sep 2026 18:46:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B3312FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30DB840D06
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1Nj1mEwOGTw for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 18:46:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E94DD40D01
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788374765;
 b=s4WSw2/Dh8d9DE1LeWD7tnWqlZhv0EoigWOlNZULQBPE14OevbbYawTE72q8qzI69g+b
 IpojtnWd6yLsXiMG/TSI/WCEEqDzF9dQcZVXASzJUPLSX3fJCMsSK64BMp26UNCf2kT66
 ma8lFeVAvyXqVHarWRC75kjryUWOsbiEdI6/x9Aqc43IXw7NoQwVx1YSd9a1yCpPRp27U
 T2CCqoTTK8kF+ceX/hYrB8e3cQ269xpaFeQ+J8RTvIetf0zBu9PhRMCMs0EWK2JJVMZkv
 gHaM8zQO4A7N8EM9Yyjfpcxuc1gZKpqOsGaYyi/TkFIGKUobX1D3eXHVRnmd+4Va5EA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788374765;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=5ORFfDmvQHYPb2jUBs0fb6XIX0qCQs35bl3AcXFOg1c=;
 b=bNwr15MXUs4zyLcFjz3JCpzK80RVxTa0xtN+FmmbsVkGv7iLG1LwtSEM0zIbcDwilpl8
 gPjZ00PZL8CFDP41cy7XxgJyShaHzWPo9fos9mvarrpaTqRtxEGXRlvdtn4jWK30JIWQV
 ZiL9eLtvmkrhUCigwZY7JL7O8EhjHAk9Cqsq8pe4xFxs/M1CB5DkMqQKZyOhNmk76VT/r
 swmrsKMqDCQkM0SAOGnmBorQF/VOxavxobjlFB+BIH7vkvXqAqIuxePYzbE30a/wCsJiE
 C8dtyvaNr+rZWkx1Lfkv1yaOJTmeL2iW9c6Qr89bxp0iuoIN75HTMoyKlBSgFnoephA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UQWOtrJz; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UQWOtrJz
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E94DD40D01
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 18:46:04 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-46fdd5884d0so247832fac.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788374763; x=1788979563;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ORFfDmvQHYPb2jUBs0fb6XIX0qCQs35bl3AcXFOg1c=;
 b=UQWOtrJzpNGcYC2/7IYlmLYr42JZZ+BKN3ioiHjMA2uSzsgexb35JxmtzwniAOhI7c
 LAxu6P/TFbCFzpzlsxvGvtCWqzJTD7CO+N0Be9YsshFEvy+cIXC97mH09HqLRpkUOF2a
 sSYNmFDkdE8PiixkAr2dhejFUdE/aoriXV3te+tZevLnIdr9JyS0biDTbM/VIADb/fY4
 Y/hRd1yGU8XlROekVhR7AXIPzpFohFWWk3qZ5Lp/9eAryFy/cuXn5bfjfxWciXagnUIy
 HR5ppcsXMMDffTeVeDKdVHtfnytwpU0yr2kyvaiPvibzeyEWjItbe34UaKAeUxO++2wl
 Q6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788374763; x=1788979563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ORFfDmvQHYPb2jUBs0fb6XIX0qCQs35bl3AcXFOg1c=;
 b=WMISm0iqcwVT+10EXqgWLa/Kf7IV8bZcUj3XXRqbcHv9uvm6Tc2N0ETvaBrMEJz9cE
 SbjfnvVv/a/qJFGJiBByuLWIRYXMkmq+hfVNBxc+yHWkowgAreSsAWFm3MVq7YomYQPi
 nvzwz6uzqHW0MLe+HE7oehFysjX0Z9javxCbAPH7PT+u/5unemkmsKWQqWSp6c6FFSWg
 3yoEo/ldzYcuQUGrRNstUJ5IC+mS4JP8cjkg0v//DHzfAKvJtI+7x8HgC1NTDpmUFIkh
 nD7cju/pzwejbm75eFjCr1LB9ujzsiyhREWF3lC0ANetAdScl1Y+OFD1TTi5bWStK8O5
 kYZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqm8F0MvheMRjGz0wyGNq+12wDHcl2onXJSio/Twc0WjkDzdWLWmXXv5m7o3X0y5VjpqmHJj2g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lz8fIcVGqqoj1Xo52E/K/aMUhRcTFK0kWNh5UP2o3nrzBuDghm
 5sXxPOM/zV6eRZALphStdNGA2Y7oAmDqsgS9XRVI0jY1DUUnknlzsdngDuMbYpOF3RvKKAmH/34
 fJMm6
X-Gm-Gg: AYBFou3ur7QW6KmyQo074Nin/2FLeNGCYBtYiAmk3hp4m6qRoHAMJAMu2zLJe7yno4I
 3DmDlLbMwGugjBatZdRfAxEB0cIXNw+shI62RquZHQAP1DiwTuUhV4hemPkCwyot1uuQP71/N36
 qZlMavKsfloLprXIg0ohtZEH1pBCno9bwpfra3T6JvTwSzxW+oZoiYnFyqD1h/kuS09xjApyJzx
 DJXQ4FBr3OEEkD84v3D9o4T76YShzcl82h9hmCSlrqbUWmKHuccwVacq8Q9SZDEYXpaIh2ZcViL
 nIeF6+JEa/U6r/dobrYTNrRqw2bHlYICisrXhBC2OkrxKH+7JCYDE7OvjQG/IGz5/U6TuyNL/5N
 FFpSt4QjuiL3qYG1DRIORqh0EC4Nz8Hq4WfkjgoCeHWuboSMdLPeNUviu9c56iZDHUalRfgMihC
 ZufUqz4iZks+vFTvOs9AjoakqMc/bxO7GJ1aCwfpE4htCk0z4EeIo2ZARmum8BWPg=
X-Received: by 2002:a05:6870:d68b:b0:46a:d3e7:2552 with SMTP id
 586e51a60fabf-46f88407f23mr5913948fac.1.1788374763077; 
 Wed, 02 Sep 2026 11:46:03 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f330827f0sm3904280fac.14.2026.09.02.11.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:46:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-next-2026-09-02 into next
Date: Wed,  2 Sep 2026 13:45:11 -0500
Message-ID: <20260902184600.3717230-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The following changes since commit 4a4bcb0ada8d43390e2819e62f4baee723631f5d:

  Merge tag 'u-boot-stm32-20260901' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-01 08:11:37 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-09-02

for you to fetch changes up to 938e2774f01674a3a38cc6df5d20401cf09b1401:

  power: domain: mtk: remove setting DCM_TOP_EN (2026-09-02 10:56:51 -0500)

----------------------------------------------------------------
* New mipi_dsi_{generic,dcs}_write_seq() helper macros
* Convert 5 panel drivers to use the new mipi_dsi write_seq macros
* Support num-interpolated-steps in pwm_backlight
* Fix MediaTek clock driver using BSS before relocation
* New MT8366 clock driver and dt-bindings clock header
* MediaTek power domain: bus_prot_sta_mask field and BUS_PROT_WR_IGN() macros
* New MT8366 power domain support and dt-bindings header
* Fix setting DCM_TOP_EN on chips that don't have it in MediaTek power domain driver
* Devicetree cleanups: drop mt8188 tphy fallback, remove unused mt6357.dtsi
* Remove UFS defconfigs for Genio EVKs

----------------------------------------------------------------
David Lechner (8):
      arm: dts: mediatek: remove mt8188 tphy fallback
      clk: mediatek: fix using clocks before relocation
      power: domain: mtk: add bus_prot_sta_mask field
      power: domain: mtk: add BUS_PROT_WR_IGN() macros
      arm: dts: mediatek: remove mt6357.dtsi
      video: pwm_backlight: support num-interpolated-steps
      configs: mediatek: remove UFS defconfigs
      power: domain: mtk: remove setting DCM_TOP_EN

Irving-CH Lin (1):
      dt-bindings: clock: add MT8366 clock header

Irving-ch Lin (2):
      dt-bindings: power: add mediatek,mt8366-power.h
      power: domain: mtk: add mt8366 power domain

Julien Stephan (6):
      mipi_dsi: add mipi_dsi_{generic/dcs}_write_seq helper macros
      video: panel: hitachi-tx10d07vm0baa: use common mipi_dsi_dcs_write_seq macro
      video: panel: lg-lh400wv3-sd04: use common mipi_dsi_dcs_write_seq macro
      video: panel: mot-panel: use common mipi_dsi_dcs_write_seq macro
      video: panel: renesas-r69328: use common mipi_dsi_dcs_write_seq macro
      video: panel: himax-hx8394: use common mipi_dsi_dcs_write_seq macro

irving.ch.lin (1):
      clk: mediatek: add support for MT8366

 MAINTAINERS                                       |    1 +
 arch/arm/dts/mt6357.dtsi                          |  282 ----
 arch/arm/dts/mt8188-u-boot.dtsi                   |   10 -
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi     |    7 -
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi     |    7 -
 board/mediatek/MAINTAINERS                        |    4 -
 configs/mt8189-ufs.config                         |    8 -
 configs/mt8189.config                             |    4 +
 configs/mt8195.config                             |    5 +
 configs/mt8371_genio_520_evk_ufs_defconfig        |    4 -
 configs/mt8391_genio_720_evk_ufs_defconfig        |    4 -
 configs/mt8395_genio_1200_evk_ufs_defconfig       |    8 -
 drivers/clk/mediatek/Makefile                     |    1 +
 drivers/clk/mediatek/clk-mt8366.c                 | 1561 +++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                    |   70 +-
 drivers/power/domain/Kconfig                      |   10 +
 drivers/power/domain/Makefile                     |    1 +
 drivers/power/domain/mt8366-power-domain.c        |  299 ++++
 drivers/power/domain/mtk-power-domain.c           |   13 +-
 drivers/power/domain/mtk-power-domain.h           |   15 +-
 drivers/video/himax-hx8394.c                      |   86 +-
 drivers/video/hitachi-tx10d07vm0baa.c             |  180 ++-
 drivers/video/lg-lh400wv3-sd04.c                  |   58 +-
 drivers/video/mot-panel.c                         |  140 +-
 drivers/video/pwm_backlight.c                     |  125 +-
 drivers/video/renesas-r69328.c                    |   69 +-
 include/dt-bindings/clock/mt8366-clk.h            |  473 +++++++
 include/dt-bindings/power/mediatek,mt8366-power.h |   33 +
 include/mipi_dsi.h                                |   35 +
 29 files changed, 2824 insertions(+), 689 deletions(-)
 delete mode 100644 arch/arm/dts/mt6357.dtsi
 delete mode 100644 arch/arm/dts/mt8188-u-boot.dtsi
 delete mode 100644 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 delete mode 100644 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 delete mode 100644 configs/mt8189-ufs.config
 delete mode 100644 configs/mt8371_genio_520_evk_ufs_defconfig
 delete mode 100644 configs/mt8391_genio_720_evk_ufs_defconfig
 delete mode 100644 configs/mt8395_genio_1200_evk_ufs_defconfig
 create mode 100644 drivers/clk/mediatek/clk-mt8366.c
 create mode 100644 drivers/power/domain/mt8366-power-domain.c
 create mode 100644 include/dt-bindings/clock/mt8366-clk.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8366-power.h
