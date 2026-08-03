Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5493DC55174
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 00:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC3C4404A2;
	Mon,  3 Aug 2026 00:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9CUesl_mc-x; Mon,  3 Aug 2026 00:06:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 173A94051C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785715591;
	bh=ZREccnW6miNLbCA0RxQfC2hQ1xwH7UsFrgt75C6b2eM=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=uxoZzhHBu9RSYH+QkhEpjHaqkTOM6nxCVvkkaFnMJ8AZMJImYaP9lWGrwwDpoVfSZ
	 w7MRkLM1zNdVn8OR//IFYb/ZDRgFg/G8NkZ9zueK0bCgCap2ae5ppAHRAwFv7UWs2n
	 JpjsXeqecqJ43XkeQy/mBbkvBz4mevR6rJllG0XajzgVBt4PILUdvpZ/taoRO5oiwd
	 kcZUuS4SNZgv2rmOhDKceEe/2cnaUo1N96VekAFqW7YHlTrHXhmZTJIjOc2D9uzfXz
	 MabLvaeK9ym9Zbv6VNJwLR/9xl531Z7eGGbMh/TZFeHsS522yem+OVW9hqxmW2DweU
	 iXYrLu/B/gDIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 173A94051C;
	Mon,  3 Aug 2026 00:06:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D39ACFE3
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 00:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFEE3606AF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 00:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p14ErIqp_rPt for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 00:06:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0FE3B60699
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FE3B60699
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FE3B60699
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 00:06:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hCxmH0HYGzKnNr;
 Mon, 03 Aug 2026 02:06:23 +0200 (CEST)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Mon,  3 Aug 2026 02:04:33 +0200
Message-ID: <20260803000610.226554-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: gks6pq67a1bebrkshrxow86t8dgfdjqe
X-MBO-RS-ID: 1313a6559cf9011b745
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785715583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZREccnW6miNLbCA0RxQfC2hQ1xwH7UsFrgt75C6b2eM=;
 b=RTKHPBVyjmnMyKe5tp9J0eNTZ30Z3DpLecdu228UAjigtMURwTWjUtoIs8ZlHhf57U4G5d
 p4HE5kfDikh3jS6LUZ5vWZg3te4Tyx8sA4072y9t+SJlra4UXNPAnEe/HoJRPWpgQmJvzD
 FGZd5zibuh43d0B37M3TV3WApjqKVHMHf1sK12YZu1/eznQb1GmW2pe0QV/ARraRa34DFK
 8+cJSgW3r40TuEuViwJMWcyTGUNJ5XXWguR33mgIro+jlhk2i41U0we4KJ95BftvGw6KWZ
 PLvjDW7cVAnIoRPuXbREsbiFes3FrXvoJMSWW5GnP+PYKAWFFFV0F8jQppKzcA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785715580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZREccnW6miNLbCA0RxQfC2hQ1xwH7UsFrgt75C6b2eM=;
 b=qonbUBtQ2WWwf3lRwUSsmc2XQ9B2WVGeoAcTPG3RSDbR+IDrk7gK+kY9BUKQkSKHKiqjs/
 9oHMLhEBBI+zrlrHz78982Kv2xjdYZG+y6LKL8NLB2gPdVdf5CKFI83Z47L8qoKejKn1NR
 by1N52hXIfc3vOwWNf0vjjud+acgmqWyhIqs1FOtOVqh/6msVSAf6YJFmsPfNevDPngYcY
 hYdkOi1aH5vm1y8zRuXWjoZ/t0idThHV61HXc4OYVXq/sRhnky5AoHwVTmwN59Jk+s0dsq
 pX4UeaPRS6Z2wd01xpfFpXzkyFTBvAlmpOfX1yxKU1amdfxfyZzZvBqGlYMg5g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=RTKHPBVy; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=qonbUBtQ
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

R-Car Gen3 clean ups and size optimization.
R-Car Gen4 proper PCIe clock generator driver.
R-Car Gen5 support for newer SCP firmware version.

The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:

  Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to 8fa2ad1a2c66502cb4eb154c384a67996ab46c2a:

  arm: dts: renesas: Remove unused OPP nodes from R-Car H3/M3-W/M3-W+/M3-N (2026-08-02 22:15:37 +0200)

----------------------------------------------------------------
Marek Vasut (10):
      MAINTAINERS: Update SH/SoCFPGA/USB email addresses
      clk: renesas: Add SDK SCP 4.36 map to Renesas R-Car R8A78000 X5H CPG clock driver
      clk: rs9: Add Renesas 9-series PCIe clock generator driver
      pci: pcie-rcar-gen4: Handle always on reference clock
      arm64: renesas: r8a779g3: Enable PCIe clock generator and I2C mux drivers on Retronix R-Car V4H Sparrow Hawk board
      Revert "arm64: dts: renesas: r8a779g3: Reinstate basic PCIe clock description for Sparrow Hawk"
      pinctrl: renesas: Further minimize R8A77951 H3 PFC tables
      pinctrl: renesas: Further minimize R8A77960 M3-W and R8A77961 M3-W+ PFC tables
      pinctrl: renesas: Further minimize R8A77965 M3-N PFC tables
      arm: dts: renesas: Remove unused OPP nodes from R-Car H3/M3-W/M3-W+/M3-N

 .mailmap                                       |   7 +-
 MAINTAINERS                                    |  12 +-
 arch/arm/dts/r8a77951-u-boot.dtsi              |  34 +++
 arch/arm/dts/r8a77960-u-boot.dtsi              |  26 ++
 arch/arm/dts/r8a77965-u-boot.dtsi              |   9 +
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi |  18 --
 configs/r8a779g3_sparrowhawk_defconfig         |   3 +
 drivers/clk/Kconfig                            |   7 +
 drivers/clk/Makefile                           |   1 +
 drivers/clk/clk-renesas-pcie.c                 | 327 +++++++++++++++++++++++++
 drivers/clk/renesas/r8a78000-cpg.c             |   4 +-
 drivers/pci/pci-rcar-gen4.c                    |   2 +-
 drivers/pinctrl/renesas/pfc-r8a77951.c         |  28 +--
 drivers/pinctrl/renesas/pfc-r8a7796.c          |  22 +-
 drivers/pinctrl/renesas/pfc-r8a77965.c         |  28 +--
 15 files changed, 455 insertions(+), 73 deletions(-)
 create mode 100644 drivers/clk/clk-renesas-pcie.c
