Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D89C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 16:53:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAE0D87E7F;
	Sat,  2 Mar 2024 17:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uw1nf3xx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="omFDG2Ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C425F87E7F; Sat,  2 Mar 2024 17:53:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781D487E75
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 17:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Tn9yL17HPz9sxb;
 Sat,  2 Mar 2024 17:53:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709398410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=51Ml8szm/uwm7pT8VXGTTpAhEpiz7VDZNDJCNqP1btY=;
 b=uw1nf3xxGVhCHNst3cKsOEiZFT4G0x7uCprzxayi3QxhXx9zRX/DrtHcEzm+Tcq7GyquGn
 3gFWbrPY045e7qXBEsQ6gNqWLHoXnpyd9PqAL6su07+DVxK1xOC3GH8XB4pdffu/zTeb4n
 b88VVMAlvZLdOZqu47X2KyInDJTwyj0KnQDEpLIkEB6596AXu1bLDMdgsvAsfvSHGzuMTQ
 VA5SeCm64zakvEsb6pMXjBAvHg2THEdzctbruQ91yxhQ1i8GlQfIWXtAaoTGgZKnTvKs2l
 P13A5qidRGxdhc+jrFPzyI89L74uA1OwNAl2gDJot0QOs/5Jl+K4erPa1y+8Rg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709398408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=51Ml8szm/uwm7pT8VXGTTpAhEpiz7VDZNDJCNqP1btY=;
 b=omFDG2HtX9aAXk4ADIuz/qDcSYxWrvaatgBbs3JgPRK4moRovKmZKLrkaP9OXCRn8YLmsm
 bbmVYktO6ocSxSCub4QeERhY/i0lXvI8emvQDte3om7AT6WIF4bqyQv3EXd+OORQkStK46
 ljjhqfBWqJ5pxam1GBVqtQ7hbtoeIskjzU1VfrzEa9i3PBEweIaOvR2d7p8S7MDLC2u8wy
 wnmRox0ar8AoILE4RweyvxxcDcTl0tX17Ssf6uV7pDvD/zCPzK26q6r8gqb/8cWA2F4mNQ
 racUzrfVA7GJ8RMkB3pV7Yav2TyrUvv8VB3U9vtfaWRHyNuyksz91pTjQfyj/A==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master-riic
Date: Sat,  2 Mar 2024 17:52:43 +0100
Message-ID: <20240302165311.27487-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2128c33788d987f6d0d
X-MBO-RS-META: wyeiei969fjsmkaru8gruhsrd7euos3w
X-Rspamd-Queue-Id: 4Tn9yL17HPz9sxb
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

The following changes since commit abd4fb5ac13215733569925a06991e0a182ede14:

  Merge patch series "Dockerfile: Build coreboot from source" (2024-02-27 16:28:57 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-riic

for you to fetch changes up to 3787ee1d2d782cabe604a79c95785276ccd03177:

  board: rzg2l: Support reset via Renesas RAA215300 PMIC (2024-02-28 18:42:27 +0100)

----------------------------------------------------------------
Paul Barker (8):
      clk: renesas: Confirm all clock & reset changes on RZ/G2L
      arm: dts: rzg2l: Sync with Linux v6.7
      i2c: rzg2l: Add I2C driver for RZ/G2L family
      pmic: Add Renesas RAA215300 PMIC driver
      board: rzg2l: Enable access to Renesas RAA215300 PMIC
      sysreset: Support reset via Renesas RAA215300 PMIC
      pmic: raa215300: Bind sysreset driver
      board: rzg2l: Support reset via Renesas RAA215300 PMIC

 arch/arm/dts/r9a07g044.dtsi               |  16 +-
 arch/arm/dts/r9a07g044l2-smarc.dts        |  21 +
 arch/arm/dts/rz-smarc-common.dtsi         |  18 +-
 arch/arm/dts/rzg2l-smarc-pinfunction.dtsi |  20 +
 arch/arm/dts/rzg2l-smarc-som.dtsi         |  22 +-
 arch/arm/dts/rzg2l-smarc.dtsi             |  43 +-
 arch/arm/mach-rmobile/Kconfig             |   1 +
 board/renesas/rzg2l/rzg2l.c               |   8 -
 configs/renesas_rzg2l_smarc_defconfig     |   7 +
 drivers/clk/renesas/rzg2l-cpg.c           |  17 +-
 drivers/i2c/Kconfig                       |   7 +
 drivers/i2c/Makefile                      |   1 +
 drivers/i2c/rz_riic.c                     | 624 ++++++++++++++++++++++++++++++
 drivers/power/pmic/Kconfig                |   9 +
 drivers/power/pmic/Makefile               |   1 +
 drivers/power/pmic/raa215300.c            |  50 +++
 drivers/sysreset/Kconfig                  |   6 +
 drivers/sysreset/Makefile                 |   1 +
 drivers/sysreset/sysreset_raa215300.c     |  58 +++
 19 files changed, 896 insertions(+), 34 deletions(-)
 create mode 100644 drivers/i2c/rz_riic.c
 create mode 100644 drivers/power/pmic/raa215300.c
 create mode 100644 drivers/sysreset/sysreset_raa215300.c
