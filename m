Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D08C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 04:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1104C80E92;
	Sat,  8 Aug 2026 04:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2T7ygUS-3Zs; Sat,  8 Aug 2026 04:26:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3205780E6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786163175;
	bh=Yb7UbU8+RpGWC5/C1VdTIhT9aw0kcpOUoKbA/pPbMyI=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=h0Ohr8GVwPDqqFTjTn+oMNU4xdLU0oZEpQAKvgxadM0wRLD0K8+/gFBxQTUGx3hkF
	 gpwrKv42D3U1jKIQyj7TjtenHmZb+Bw1J2wdUgSXYUyuws3r4OdeFm8MUzRB0oRTCZ
	 ceFXmPuxDkf+rl8w9M0HXCVRGvKhJcnIsIc/7aKmJCHPkTlQWDFOJTI4f8jelkzrdO
	 Ncc82kD9O0i2pCkz9/JvXW6pnUhXlFMUM4lk855E3IbMJemRs4fwVUWoOuxjOAKnuP
	 ojuRm66DvbWmSYDwAW5O06CDpkzT992DAHTRAj3uE6H6O9ukrXWo7pZfZc8UaBGOie
	 cMdo0fwuxrmkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3205780E6F;
	Sat,  8 Aug 2026 04:26:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FFA72B6
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 04:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21A9880E63
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 04:26:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PA_fzaW7plEl for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 04:26:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D08B780E5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D08B780E5F
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D08B780E5F
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 04:26:10 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hH7Hh4cNrzKnbY;
 Sat, 08 Aug 2026 06:26:08 +0200 (CEST)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/main
Date: Sat,  8 Aug 2026 06:22:48 +0200
Message-ID: <20260808042549.145756-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3mkmqxmmokx1awiu85gwry4nbnotwagt
X-MBO-RS-ID: 1b06727b10ee615591f
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786163168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yb7UbU8+RpGWC5/C1VdTIhT9aw0kcpOUoKbA/pPbMyI=;
 b=HtaqiUaoShHjigf0Y0buAtxZPt9GOs6684mX6fW5Vb/xR4ahODnk/qwVcXO9gn89ux0u+u
 34KmfIEOLihNbg2e7fU/itQz8BOoGEWJU9oL2nzO5DBExvZmydcLICMurFBnHPfZnPomSQ
 5w2H1EC+MVFwIAkc5/bRoQ34OutHv978335kOXAwlNoJnYSODN1JZcdnBg+JFfkry+kXeu
 /Ruq3tLG3kg+LgBm3nZTWQjmI2B7twpLELqX4wuy9V86E8jfZrssaywL+cqr59itc1y0CH
 4aLWPavCDVBT8ivYnV/1ekBpu2jfJ/2eVs07pEv8HsTv6DTjMddHuZx6nm+LRw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786163166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yb7UbU8+RpGWC5/C1VdTIhT9aw0kcpOUoKbA/pPbMyI=;
 b=bhqiSPGgfHjRZQT9h6z4zkO2T/+7a7nPR94k0NKRuT7p3mmWTwlOEPO8QlxS3Ub0e936AC
 F+QpV2XRwiNzhSpd8JQbG2sew3VB4jrTfuOWG0yHKVHg6pL8eSQWZyCemIDIEKukILLUQJ
 I57MibqLtYOHtPDY/mHqF9AA0F2ValsMdvaUwS/LgueA8eMjRENyG/rWIzg8EVdDhMxkCb
 bjF2thXUHK9rv2dl6cRs8PpoKnHJSfUwEe2N3ZVw/n/gg1jDuRydALAK36HKaGqsFf6DEn
 vW3hgQCgiRZbwVcYfPTC4QTyW4lhW+DCDhlWXmN8OHsEpmkGqMz95ROdm163TA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=HtaqiUao; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=bhqiSPGg
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

This includes temporary U-Boot DT ECC carveouts for R-Car Gen5, they
will be dropped from U-Boot DTs once OF_UPSTREAM DTs get re-synced.
This also includes RPC-IF support for R-Car Gen5 and env storage in
RPC HF.
This also includes an update for R-Car Gen5 UFS controller driver.

The following changes since commit 06c866fee0052579dbd27456fac425d002d44a80:

  Gitlab CI: sage: Disable test_net_tftpboot_boot on Raspberry Pi 4 for now (2026-08-06 19:36:56 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-sh.git main

for you to fetch changes up to c0ed490da30e35a5951646ca08e984d7415fdd58:

  arm64: dts: renesas: ironhide: Describe inline ECC carveouts (2026-08-07 21:59:00 +0200)

----------------------------------------------------------------
Marek Vasut (10):
      mtd: rpc: renesas: Switch to dev_read_addr_name()
      mtd: rpc: renesas: Add R-Car Gen5 DT compatible
      mtd: spi: renesas: Align macro prefixes
      mtd: spi: renesas: Add R-Car Gen5 DT compatible
      arm: renesas: Disable MMC support on R-Car R8A78000 X5H Cortex-M33 RSIP port
      arm: renesas: Bind RPC on R-Car R8A78000 X5H Cortex-M33 RSIP port
      arm: renesas: Enable RPC on R-Car R8A78000 X5H Cortex-M33 RSIP port
      arm: renesas: Store env in HF on R-Car R8A78000 X5H Cortex-M33 RSIP port
      arm64: dts: renesas: ironhide: Describe all reserved memory
      arm64: dts: renesas: ironhide: Describe inline ECC carveouts

Tuyen Dang (1):
      ufs: rcar-gen5: Switch from FASTAUTO mode to FAST mode

 arch/arm/dts/r8a78000-ironhide-cm33-u-boot.dtsi | 17 ++++++
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi      | 78 +++++++++++++++++++++++++
 configs/r8a78000_ironhide_cm33_defconfig        | 22 ++++++-
 drivers/mtd/Kconfig                             |  2 +-
 drivers/mtd/renesas_rpc_hf.c                    | 26 ++++-----
 drivers/spi/renesas_rpc_spi.c                   | 19 +++---
 drivers/ufs/ufs-renesas-rcar-gen5.c             | 22 ++++---
 include/configs/rcar-gen5-common.h              |  4 ++
 8 files changed, 157 insertions(+), 33 deletions(-)
