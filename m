Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2707C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 11:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 820E98096F;
	Wed, 19 Aug 2026 11:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9YWrC50GwfV; Wed, 19 Aug 2026 11:15:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787138141;
	bh=g/8SxyfFWUxuNDEWbtEvMQHILQMrjnWOpbvF0k/sfWE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ENuE6Bz4t/uZoI3OxF819Nv7OiZMd2+rL90yAf7YDIJRIPEvIlBbqdA7fKjxQBJkD
	 DrhmmDaU5oGE6itIFbOebJ/ElFNx+vOIDhnlw5dRg5skJ0yr9gnkuv17QgJCPu81rQ
	 NnenwgePidNhoW4nllbb0aJeRpnZJX5Wr5NzZg8X5JjLOLRdcBX8uuzKXlpLO2F+VU
	 0TAqGjN2BZ1Pua6csIjAPz4uN7Uf0Ga+fHtFY8SYUg4ZgOnDk7bMTmN3Q3d6dIOKUv
	 fXBuO6CISuaf5o1VJsH76a4nnoJkUB2q0+NBiH8LKxdrI2JYU2mQwil2f2vQ6Lvh1X
	 ytRhIGA6sDKIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B5C80993;
	Wed, 19 Aug 2026 11:15:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BE702FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D863405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id drV84O88FVeo for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 11:15:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=pbieng3Y; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=K1SyTZUG
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F0C0405A4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 11:15:38 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hQ3s416rTz8typ;
 Wed, 19 Aug 2026 13:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787138136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g/8SxyfFWUxuNDEWbtEvMQHILQMrjnWOpbvF0k/sfWE=;
 b=pbieng3Y6xaVli+shYYvR1rTZQxLKkwUzecHWnINK5xdEkSlSiWxXJcHHYYBoL+PqqwiG8
 qNTJy12Kp88hjBiaKp6wEK82OjuW+ye7tBFQ9/uFFO8rLNVD9DsxzzuQhSTLX+9NuKYuRS
 bGvZlvp/RbiuxnnNBd659eNztcjUQdcij+LHHCV1PkcWYyykJ5Lq3l1AWRosv6VxIcCfux
 vofXVkui0jI+nbOLp2E1MAm2f8RpbP2ofems2oXME0hGJC/s9ozgqaz3QP6SRB0DFbHoi4
 vXZwB7P02H5MkfG7FrgmHJHZpESK8PtmYtseCYIhFRxphznNE3AJqAF6hnCxzQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=K1SyTZUG;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787138134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=g/8SxyfFWUxuNDEWbtEvMQHILQMrjnWOpbvF0k/sfWE=;
 b=K1SyTZUGzxmg+vRbug/p61ghqtKQ8xz0vYg6iO/QBM3Qh3zWPSiM751MX1aF4OMLkvJy8+
 TdPCP1mQx3o7TW7kMd8SmvmUAqFlDjjxh/8flNDHlILSDw8HjDy1OPN40j9UzkIq+/5i6F
 lcPjkbgn2GbLIdpTZu7ui7pLT0kK/lPB3j65S/K4cj0bJy1GxmlG0ah2yUJSMgzDQ+jrDi
 fzrhUmuiiwX0DN2Bqk5Frlk0oQNHt3cE3QwdFdShg0JsbSmqaqh96JcylO/k7uqNAmxmqN
 P1HZHedAmHvduOfE1SIqy6rGFrswBfZXtsySUDbW+MAPBiLzQWHa25Kx6H1MEg==
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Wed, 19 Aug 2026 13:13:05 +0200
Message-ID: <20260819111522.9235-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4peh6sqo333nfip5eqyizj85pu7ut3ph
X-MBO-RS-ID: 37075611a97850b7b6e
X-Rspamd-Queue-Id: 4hQ3s416rTz8typ
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

R-Car Gen4
- PCIe driver fixes and switch to generic firmware loader
- Bootloader update and switch to distro boot command
- DT removal of duplicate nodes which are in Linux DTs node
R-Car Gen5
- RSIP CM33 remoteproc driver clean up and pending updates

The following changes since commit 527115ef6783cec49e5610c523c124b399011361:

  pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-13 10:12:41 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to a8097d2dbdb33a8b9185d20ce30712493a83b6df:

  arm64: dts: renesas: r8a779g3: Drop set VDDQ18_25_AVB voltage on Retronix R-Car V4H Sparrow Hawk EVTB1 (2026-08-15 00:55:43 +0200)

----------------------------------------------------------------
Marek Vasut (16):
      remoteproc: renesas: rsip: Clear SCMI transport flags
      remoteproc: renesas: rsip: Improve error print
      remoteproc: renesas: rsip: Extract SCP initialization from board file
      remoteproc: renesas: rsip: Reset SCP core on stop
      remoteproc: renesas: rsip: Implement SCMI core stop
      remoteproc: renesas: rsip: Implement core status
      pci: pcie-rcar-gen4: Switch to generic firmware loader
      pci: pcie-rcar-gen4: Avoid repeated link attempts
      pci: pcie-rcar-gen4: Switch to devm_*() GPIO and reset
      doc: board: renesas: Document Retronix R-Car Gen4 V4H Sparrow Hawk SPI NOR layout
      arm64: renesas: r8a779g3: Add PCIe firmware environment on Retronix R-Car V4H Sparrow Hawk
      arm64: renesas: r8a779g3: Add bootloader update environment on Retronix R-Car V4H Sparrow Hawk
      arm64: renesas: r8a779g3: Switch to distro boot command on Retronix R-Car V4H Sparrow Hawk
      arm64: dts: renesas: r8a779g3: Drop generic SPI NOR support on Retronix R-Car V4H Sparrow Hawk board
      arm64: dts: renesas: r8a779g3: Drop invert microSD voltage selector on Retronix R-Car V4H Sparrow Hawk EVTB1
      arm64: dts: renesas: r8a779g3: Drop set VDDQ18_25_AVB voltage on Retronix R-Car V4H Sparrow Hawk EVTB1

 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi  |  16 --
 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi |   1 +
 arch/arm/dts/r8a78000-u-boot.dtsi               |   8 +
 board/renesas/common/gen5-cm33.c                |  70 --------
 configs/r8a779g3_sparrowhawk_defconfig          |   2 +-
 doc/board/renesas/rcar-gen4-sparrow-hawk.rst    |  21 +++
 drivers/pci/Kconfig                             |   1 +
 drivers/pci/pci-rcar-gen4.c                     | 118 +++++++-------
 drivers/remoteproc/renesas_rsip.c               | 202 +++++++++++++++++++-----
 include/configs/sparrowhawk.h                   | 121 ++++++++++++++
 include/dt-bindings/reset/r8a78000-reset-scmi.h |   2 +
 11 files changed, 374 insertions(+), 188 deletions(-)
