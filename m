Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACFFC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3230180F5B;
	Wed, 22 Jul 2026 20:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SzVily1W9PcO; Wed, 22 Jul 2026 20:15:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0774680F51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784751350;
	bh=/tAbsHdsIhhPqPQh7S634rzTHIQ1Oi/W3iyufsPLzFU=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=OuX/pfDqyTjelLywkjjUvvfgJVp8VBu4S5ra+NVYXjyROgafReS0SxSoHFQcdDYfd
	 RivspahXZe3VVj2PeIU9lTOoAOB6D6AuTlWkQ4ROdD1H73HmrtUacUX0EIecal0Rkt
	 S0Rx8T7D5m0ASjLn9zJZFJq2X6raDwEF2D+/bwKUlbIHvkLhJ9kMOQYEZXlRU/WCuZ
	 s+5l6pzLyo2OzAETh1VHAe4ayrOYl+mCCKGu59+QuZ/P7AJJMsQKfjp2RD18n5f3hU
	 oCGFo8hJwM+JOELyfLocvXz8WWbnyvSZF6qRiExkAKQHX6AeK+efvw1rG/Fs9qHmt6
	 drMyY9cJYWVXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0774680F51;
	Wed, 22 Jul 2026 20:15:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BA100313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB94C80F51
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxyjOk6LeUSP for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:15:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D7B3E80F24
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7B3E80F24
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7B3E80F24
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:15:44 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so10013616a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784751344; x=1785356144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/tAbsHdsIhhPqPQh7S634rzTHIQ1Oi/W3iyufsPLzFU=;
 b=YxJUSSHkUtIdIEruJbAZVPnh2G3kLXoSZvkl/iSqdk3GGcmxOpqjIKqrHU+Q8MczSm
 BWqP32LEVfPtXsOLvocpRYWwDWoavDsAyz35PtoH87b1I6JDP5Fd7ggeTPuh3JtskSkN
 h/R2XgIbwpwsZejrrWElOU++/CbthhJIASAso3cCdRewOwm7pegKy8XDtwYS3SfpsT4r
 US76PoBkhYSLZrkTFnLCoF+OCPBoD3E4C8o3rxnAy/RzrlTHGid2o2u8mnN2/CqrGSby
 z04LJf5d3y9l3KpIC2AfqszWBI1rVD2zVk1Q4P89tkE9aTvG1t8sOLk94bcRaRlDKtks
 vCQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq54ybVjSIaybXfWsDMpNNHL6/FU7COAkItOFgk4wU8m186yeIyy+zXtnICXlnEz3CqhtZMzVc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwgfCzUW/Ortwky49zOEAuKIQ6IYew/bk/MjuLxM5rdl07RQOfM
 PZTqZtG82GemzetFi+K0SgoQuJo+/UZevOH4OgAosdjEXM8g20kOZ23W7S3vs0V17sg=
X-Gm-Gg: AR+sD12QYR1cymqgOob6pUBTRqTegxUXRzClx5bg1L2ucTco7tu/jslg58kQXaULEQJ
 oOpFj1BGrGd+hYn4AJ2akC8VNGHCc437P32EqlEWu7sNwteBGP1U1eZrn6apoPlPSE010E34ZMh
 KDPCZGbzuq7Gtp3ChCe4CuWlvOlFCvYB3wI2qzzJqWO6w2JOp8dx4UycpPq+zTGaUaKG0CPhhub
 Bo+hSpGSKM7VNncFAzc5XkTdeRO4DyHjuHjRMqI66iJ12esLuwORbJi94tByZCFza46bihKwJg7
 Abvfr0igXpXMgzJEQ9vKEksNiYjl1CgxTyhvdTMmNSH6casiKK6HFm4wPrex0A2zjEMAirf1eHH
 QtpxeE9ZOrjeThT/ZiRc9LJiC5eBUXguXHA7MY0mr9Pe0o0gMdA1b9cwxFqd54zx2D3WXxhuUnJ
 imA6A=
X-Received: by 2002:a05:6830:81d7:b0:7e5:f957:a61f with SMTP id
 46e09a7af769-7ee43d65b32mr239633a34.18.1784751343978; 
 Wed, 22 Jul 2026 13:15:43 -0700 (PDT)
Received: from freyr.lan ([2600:8803:e7e4:500:d067:7d1:556a:2be5])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29db0ccesm2058534a34.5.2026.07.22.13.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:15:43 -0700 (PDT)
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream@mediatek.com,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: [GIT PULL] Please pull mediatek-for-main-2026-07-22 into main
Date: Wed, 22 Jul 2026 15:08:59 -0500
Message-ID: <20260722201522.3930921-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784751344; x=1785356144;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/tAbsHdsIhhPqPQh7S634rzTHIQ1Oi/W3iyufsPLzFU=;
 b=htVq3SVWN7b2kMV2JdkXxF+yyaLMQASOvHOsEITs1pGGmAGZp3ot/DkXk733P6Oolo
 vSnSkdmEodtNvyS1GwCvTd+ond8cKMk7Cl76wyJvbKzbieZnfI+UHhfeHniprBjtRTpX
 3/BlsCKwDhuUCauHLj30bMQE2iws43pM45HRz0YW+Pnr9LblFpGR5a4o54eC9P8Nkxdl
 3ePJrzzGS/AV9m9CzqanNfuJoqn1U02e7roGXmMAnEvVQamEuQ6RuMx/X77UsyuH1GDS
 5WdBfuJMN6pqfSb7lAHz0huGswRnjQWz6A4TAHObp143zb3dOYgRPCk+dvx5sMgbtxw0
 LYwQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=htVq3SVW
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The following changes since commit 1b8283bd3220e898d338fb98929f0b06ed63da84:

  cmd: read: fix unsigned overflow bypassing range check (2026-07-21 13:52:50 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-07-22

for you to fetch changes up to d0c49353a648e135f269a2953dc9326505ba87de:

  configs: mediatek: enable MT8188 power domain (2026-07-22 13:54:55 -0500)

----------------------------------------------------------------
Fixes:
* Fixed some wrong parents of VLP clocks on mt8189.
* Added a missing perficfg_ao clock in mt8188.
* Disabled watchdog by default on Genio 510/700.
* Fixed U-Boot DT overrides not included on Genio 510/700.

Cleanups/refactoring:
* Changed how clock parent providers are registered and looked
  up for all MediaTek targets.
* Removed duplicate devicetree node in mt7623.
* Removed unused/non-standard DT properties in mt798{1,6,8}.
* Simplified MAINTAINERS by using N: instead of F: when possible.
* Replaced duplicate driver names in all MediaTek clock drivers.
* Cleaned up MediaTek power domain driver and split into separate
  driver per compatible target.
* Removed unused power domain enablement from mt798{1,6,6a,7,8}.

Features:
* Added power domain driver for mt8188.

----------------------------------------------------------------
Carlo Caione (1):
      configs: mediatek: do not autostart the watchdog on the Genio EVKs

David Lechner (41):
      clk: mediatek: mt8189: fix VLP_CK wrong parents
      arm: dts: mt7623: remove duplicate topckgen override
      clk: mediatek: mt7622: set parent flag for GATE_APMIXED()
      clk: mediatek: add registration function for clock tree types
      clk: mediaTek: mt7622: add clock tree type flags
      clk: mediaTek: mt7623: add clock tree type flags
      clk: mediaTek: mt7629: add clock tree type flags
      clk: mediaTek: mt7981: add clock tree type flags
      clk: mediaTek: mt7986: add clock tree type flags
      clk: mediaTek: mt7987: add clock tree type flags
      clk: mediaTek: mt7988: add clock tree type flags
      clk: mediaTek: mt8183: add clock tree type flags
      clk: mediaTek: mt8188: add clock tree type flags
      clk: mediaTek: mt8189: add clock tree type flags
      clk: mediaTek: mt8195: add clock tree type flags
      clk: mediaTek: mt8365: add clock tree type flags
      clk: mediaTek: mt8512: add clock tree type flags
      clk: mediaTek: mt8516: add clock tree type flags
      clk: mediaTek: mt8518: add clock tree type flags
      clk: mediatek: use registered provider for parent lookup
      clk: mediatek: drop parent udevice field
      clk: mediatek: remove mtk_common_clk_infrasys_init()
      arm: dts: mt7981: remove clock-parent properties
      arm: dts: mt7986: remove clock-parent properties
      arm: dts: mt7988: remove clock-parent properties
      clk: mediatek: mt7629: remove mt7629_peri_clk_tree
      clk: mediatek: mt7622: unique driver names
      clk: mediatek: mt7623: unique driver names
      clk: mediatek: mt7629: unique driver names
      clk: mediatek: mt7981: unique driver names
      clk: mediatek: mt7986: unique driver names
      clk: mediatek: mt7987: unique driver names
      clk: mediatek: mt7988: unique driver names
      clk: mediatek: mt8183: unique driver names
      clk: mediatek: mt8188: unique driver names
      clk: mediatek: mt8189: unique driver names
      clk: mediatek: mt8195: unique driver names
      clk: mediatek: mt8365: unique driver names
      clk: mediatek: mt8512: unique driver names
      clk: mediatek: mt8516: unique driver names
      clk: mediatek: mt8518: unique driver names

Julien Stephan (16):
      arm: dts: mediatek: add U-Boot dtsi overrides for Genio 510 and Genio 700
      clk: mediatek: mt8188: add missing clock in pericfg_ao
      power: domain: keep Makefile and Kconfig sorted
      configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
      power: domain: mediatek: use MT7622 naming instead of MT7629
      power: domain: mediatek: use MT2701 naming instead of MT7623
      power: domain: mediatek: remove enum scp_domain_type
      power: domain: mediatek: prefix internal identifiers with mtk_
      power: domain: mediatek: constify scp_domain_data instances
      power: domain: mediatek: split into per-SoC drivers
      power: domain: mediatek: wrap domain tables in struct scp_soc_data
      power: domain: mediatek: rename mtk_power_domain_probe to mtk_scpsys_probe
      power: domain: mediatek: rename struct mtk_scp_domain to mtk_scpsys
      power: domain: mediatek: add support for the power-controller model
      power: domain: mediatek: add MT8188 power domain driver
      configs: mediatek: enable MT8188 power domain

Marek Vasut (1):
      MAINTAINERS: Replace Mediatek with N:

 MAINTAINERS                                   |  38 +-
 arch/arm/dts/mt7623-u-boot.dtsi               |   4 -
 arch/arm/dts/mt7981.dtsi                      |   3 -
 arch/arm/dts/mt7986.dtsi                      |   3 -
 arch/arm/dts/mt7988.dtsi                      |  12 -
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |   7 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |   7 +
 arch/arm/mach-mediatek/mt7629/init.c          |   4 +-
 arch/arm/mach-mediatek/mt8516/init.c          |   2 +-
 board/mediatek/MAINTAINERS                    |   3 +
 configs/mt7622_rfb_defconfig                  |   2 +-
 configs/mt7623a_unielec_u7623_02_defconfig    |   2 +-
 configs/mt7623n_bpir2_defconfig               |   2 +-
 configs/mt7629_rfb_defconfig                  |   2 +-
 configs/mt7981_emmc_rfb_defconfig             |   2 -
 configs/mt7981_rfb_defconfig                  |   2 -
 configs/mt7981_sd_rfb_defconfig               |   2 -
 configs/mt7986_rfb_defconfig                  |   2 -
 configs/mt7986a_bpir3_emmc_defconfig          |   2 -
 configs/mt7986a_bpir3_sd_defconfig            |   2 -
 configs/mt7987_emmc_rfb_defconfig             |   2 -
 configs/mt7987_rfb_defconfig                  |   2 -
 configs/mt7987_sd_rfb_defconfig               |   2 -
 configs/mt7988_rfb_defconfig                  |   2 -
 configs/mt7988_sd_rfb_defconfig               |   2 -
 configs/mt8188.config                         |   3 +
 configs/mt8365_evk_defconfig                  |   1 +
 drivers/clk/mediatek/clk-mt7622.c             |  51 +-
 drivers/clk/mediatek/clk-mt7623.c             |  20 +-
 drivers/clk/mediatek/clk-mt7629.c             |  46 +-
 drivers/clk/mediatek/clk-mt7981.c             |  31 +-
 drivers/clk/mediatek/clk-mt7986.c             |  23 +-
 drivers/clk/mediatek/clk-mt7987.c             |  23 +-
 drivers/clk/mediatek/clk-mt7988.c             |  36 +-
 drivers/clk/mediatek/clk-mt8183.c             |  30 +-
 drivers/clk/mediatek/clk-mt8188.c             |  19 +-
 drivers/clk/mediatek/clk-mt8189.c             |  28 +-
 drivers/clk/mediatek/clk-mt8195.c             |  10 +-
 drivers/clk/mediatek/clk-mt8365.c             |  10 +-
 drivers/clk/mediatek/clk-mt8512.c             |  32 +-
 drivers/clk/mediatek/clk-mt8516.c             |  30 +-
 drivers/clk/mediatek/clk-mt8518.c             |  30 +-
 drivers/clk/mediatek/clk-mtk.c                | 184 +++----
 drivers/clk/mediatek/clk-mtk.h                |  21 +-
 drivers/power/domain/Kconfig                  |  89 ++--
 drivers/power/domain/Makefile                 |  15 +-
 drivers/power/domain/mt2701-power-domain.c    |  89 ++++
 drivers/power/domain/mt7622-power-domain.c    |  56 +++
 drivers/power/domain/mt8188-power-domain.c    | 665 ++++++++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c       | 576 +++++++++++++---------
 drivers/power/domain/mtk-power-domain.h       | 131 +++++
 51 files changed, 1745 insertions(+), 617 deletions(-)
 create mode 100644 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 create mode 100644 drivers/power/domain/mt2701-power-domain.c
 create mode 100644 drivers/power/domain/mt7622-power-domain.c
 create mode 100644 drivers/power/domain/mt8188-power-domain.c
 create mode 100644 drivers/power/domain/mtk-power-domain.h
