Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508A4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B5B8863D;
	Thu, 18 Apr 2024 14:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lAh2ce4e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O+d4++QF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFB588642; Thu, 18 Apr 2024 14:50:47 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F428862F
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VKyLX5Kfcz9spf;
 Thu, 18 Apr 2024 14:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713444644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQ4wBdJXeyTRVqDTfyMYRaZvBi2kzZkwiWsx/jxVV+c=;
 b=lAh2ce4ew1mOM8ZR8f/T/XrfGyoOaAFIiIoIQrdtKi9W51lCE0KWwnHLX/zs6w2eASsZ4b
 UOSXdZUBxq7Ucv/dsw+DAyMhwomYXONauBZcg4wHt2aUJTtzH3Uad1QzM/Iv2QEauXbWtG
 4RIFhr1K1Ro33QyOy3yieOJ0TnDKLOijRG0Tm0n3TLM6rBrEm+u6xIJTe6tZiLX8P5UqkP
 l0cwhdWsJzNbneqCvw6hC9nbWrALnw43Q4K6aC2hvK8gZUhqoiUkQYpoTDPaUHkxscHsG6
 UCiPx22ZJYIcXqmUppkPPqyg6OesGCBGcGexgpNQI9jAJ6Dh1Gb/nF7HcBTSJQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713444642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQ4wBdJXeyTRVqDTfyMYRaZvBi2kzZkwiWsx/jxVV+c=;
 b=O+d4++QFrTqSY3TXvzwLhGC6pC84GvGaFZ7TXV/ZpnhR7nyiygob4W0T/Hp3NAPnOUdc18
 LjuRpMkp512vhqrIgiH390H/azWxe4zk0BgSUIymug2WbNsnBNnB5AAZhm8wsuAijqPLMU
 ffaOyasXbfBcp3eCiH2GTPZS8R7Bo+SyK6BsH1kH1ab27Y3VI8nLyfrJyMX14XetjW2qXY
 9QwKjlCqxggwieQh38JSo1VjKLm4ChddMZuR3MNo7MdyrFGBBvQu+rc1PJ0IT2P12fy0pq
 KQ/I+JZvqjsPYfP1lnOfso2xG8xeFIFJk7v4MHOpgY4BmGPEjmJra0/p9Qm7HA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-fdt
Date: Thu, 18 Apr 2024 14:49:54 +0200
Message-ID: <20240418125024.7388-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rtkjk51yexk847g8udugx5whamtx4kp8
X-MBO-RS-ID: 19d052ba562a8caa4ca
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

The following changes since commit a712a54dc427708195e6405af4b072d869d0dd8f:

  Merge patch series "configs: ti: Enable basic settings for SystemReady ACS" (2024-04-17 13:16:12 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-fdt

for you to fetch changes up to aad511a488c40393728156333d983c31001aac32:

  ARM: dts: renesas: Switch to using upstream DT (2024-04-18 05:21:26 +0200)

----------------------------------------------------------------
Marek Vasut (4):
      ARM: dts: renesas: Stop using the -u-boot DTs for build
      ARM: dts: renesas: Replace R8A77950 with R8A77951
      ARM: dts: renesas: Switch to using upstream DT on 64bit Renesas SoCs
      ARM: dts: renesas: Switch to using upstream DT

 arch/arm/Kconfig                                   |  1 +
 arch/arm/dts/Makefile                              | 58 +++++++++++-----------
 ...ch-u-boot.dts => r7s72100-gr-peach-u-boot.dtsi} |  1 -
 ...-boot.dts => r8a774a1-hihope-rzg2m-u-boot.dtsi} |  1 -
 ...-boot.dts => r8a774b1-hihope-rzg2n-u-boot.dtsi} |  1 -
 ...ek874-u-boot.dts => r8a774c0-ek874-u-boot.dtsi} |  1 -
 ...-boot.dts => r8a774e1-hihope-rzg2h-u-boot.dtsi} |  1 -
 ...-lager-u-boot.dts => r8a7790-lager-u-boot.dtsi} |  1 -
 ...-stout-u-boot.dts => r8a7790-stout-u-boot.dtsi} |  1 -
 ...lsch-u-boot.dts => r8a7791-koelsch-u-boot.dtsi} |  1 -
 ...orter-u-boot.dts => r8a7791-porter-u-boot.dtsi} |  1 -
 ...nche-u-boot.dts => r8a7792-blanche-u-boot.dtsi} |  1 -
 ...93-gose-u-boot.dts => r8a7793-gose-u-boot.dtsi} |  1 -
 ...7794-alt-u-boot.dts => r8a7794-alt-u-boot.dtsi} |  1 -
 ...94-silk-u-boot.dts => r8a7794-silk-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77951-salvator-x-u-boot.dtsi} |  3 +-
 .../{r8a77950-u-boot.dtsi => r8a77951-u-boot.dtsi} |  6 ---
 ...0-ulcb-u-boot.dts => r8a77951-ulcb-u-boot.dtsi} |  3 +-
 ...-u-boot.dts => r8a77960-salvator-x-u-boot.dtsi} |  1 -
 ...0-ulcb-u-boot.dts => r8a77960-ulcb-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77965-salvator-x-u-boot.dtsi} |  1 -
 ...5-ulcb-u-boot.dts => r8a77965-ulcb-u-boot.dtsi} |  1 -
 ...eagle-u-boot.dts => r8a77970-eagle-u-boot.dtsi} |  1 -
 ...v3msk-u-boot.dts => r8a77970-v3msk-u-boot.dtsi} |  1 -
 ...ndor-u-boot.dts => r8a77980-condor-u-boot.dtsi} |  1 -
 ...v3hsk-u-boot.dts => r8a77980-v3hsk-u-boot.dtsi} |  1 -
 ...ebisu-u-boot.dts => r8a77990-ebisu-u-boot.dtsi} |  1 -
 ...draak-u-boot.dts => r8a77995-draak-u-boot.dtsi} |  1 -
 ...lcon-u-boot.dts => r8a779a0-falcon-u-boot.dtsi} |  1 -
 ...ider-u-boot.dts => r8a779f0-spider-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a779g0-white-hawk-u-boot.dtsi} |  1 -
 ...k-u-boot.dts => r8a779h0-gray-hawk-u-boot.dtsi} |  1 -
 arch/arm/mach-renesas/Kconfig                      |  1 +
 board/renesas/salvator-x/salvator-x.c              |  6 +--
 board/renesas/ulcb/ulcb.c                          |  6 +--
 configs/alt_defconfig                              |  2 +-
 configs/blanche_defconfig                          |  2 +-
 configs/gose_defconfig                             |  2 +-
 configs/grpeach_defconfig                          |  2 +-
 configs/hihope_rzg2_defconfig                      |  4 +-
 configs/koelsch_defconfig                          |  2 +-
 configs/lager_defconfig                            |  2 +-
 configs/porter_defconfig                           |  2 +-
 configs/r8a77970_eagle_defconfig                   |  2 +-
 configs/r8a77970_v3msk_defconfig                   |  2 +-
 configs/r8a77980_condor_defconfig                  |  2 +-
 configs/r8a77980_v3hsk_defconfig                   |  2 +-
 configs/r8a77990_ebisu_defconfig                   |  2 +-
 configs/r8a77995_draak_defconfig                   |  2 +-
 configs/r8a779a0_falcon_defconfig                  |  2 +-
 configs/r8a779f0_spider_defconfig                  |  2 +-
 configs/r8a779g0_whitehawk_defconfig               |  2 +-
 configs/r8a779h0_grayhawk_defconfig                |  3 +-
 configs/rcar3_salvator-x_defconfig                 |  8 +--
 configs/rcar3_ulcb_defconfig                       |  8 +--
 configs/renesas_rzg2l_smarc_defconfig              |  2 +-
 configs/rzg2_beacon_defconfig                      |  4 +-
 configs/rzn1_snarc_defconfig                       |  1 +
 configs/silinux_ek874_defconfig                    |  2 +-
 configs/silk_defconfig                             |  2 +-
 configs/stout_defconfig                            |  2 +-
 61 files changed, 74 insertions(+), 105 deletions(-)
 rename arch/arm/dts/{r7s72100-gr-peach-u-boot.dts => r7s72100-gr-peach-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a774a1-hihope-rzg2m-u-boot.dts => r8a774a1-hihope-rzg2m-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a774b1-hihope-rzg2n-u-boot.dts => r8a774b1-hihope-rzg2n-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a774c0-ek874-u-boot.dts => r8a774c0-ek874-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a774e1-hihope-rzg2h-u-boot.dts => r8a774e1-hihope-rzg2h-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7790-lager-u-boot.dts => r8a7790-lager-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7790-stout-u-boot.dts => r8a7790-stout-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7791-koelsch-u-boot.dts => r8a7791-koelsch-u-boot.dtsi} (90%)
 rename arch/arm/dts/{r8a7791-porter-u-boot.dts => r8a7791-porter-u-boot.dtsi} (92%)
 rename arch/arm/dts/{r8a7792-blanche-u-boot.dts => r8a7792-blanche-u-boot.dtsi} (89%)
 rename arch/arm/dts/{r8a7793-gose-u-boot.dts => r8a7793-gose-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7794-alt-u-boot.dts => r8a7794-alt-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a7794-silk-u-boot.dts => r8a7794-silk-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a77950-salvator-x-u-boot.dts => r8a77951-salvator-x-u-boot.dtsi} (92%)
 rename arch/arm/dts/{r8a77950-u-boot.dtsi => r8a77951-u-boot.dtsi} (93%)
 rename arch/arm/dts/{r8a77950-ulcb-u-boot.dts => r8a77951-ulcb-u-boot.dtsi} (94%)
 rename arch/arm/dts/{r8a77960-salvator-x-u-boot.dts => r8a77960-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77960-ulcb-u-boot.dts => r8a77960-ulcb-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77965-salvator-x-u-boot.dts => r8a77965-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77965-ulcb-u-boot.dts => r8a77965-ulcb-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77970-eagle-u-boot.dts => r8a77970-eagle-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77970-v3msk-u-boot.dts => r8a77970-v3msk-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77980-condor-u-boot.dts => r8a77980-condor-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77980-v3hsk-u-boot.dts => r8a77980-v3hsk-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a77990-ebisu-u-boot.dts => r8a77990-ebisu-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77995-draak-u-boot.dts => r8a77995-draak-u-boot.dtsi} (94%)
 rename arch/arm/dts/{r8a779a0-falcon-u-boot.dts => r8a779a0-falcon-u-boot.dtsi} (94%)
 rename arch/arm/dts/{r8a779f0-spider-u-boot.dts => r8a779f0-spider-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a779g0-white-hawk-u-boot.dts => r8a779g0-white-hawk-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a779h0-gray-hawk-u-boot.dts => r8a779h0-gray-hawk-u-boot.dtsi} (95%)
