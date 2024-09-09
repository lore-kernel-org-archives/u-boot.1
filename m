Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178EBECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F4088DD8;
	Mon,  9 Sep 2024 16:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qR8cPW6T";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="f/XdIKX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5242488CC9; Mon,  9 Sep 2024 16:04:45 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B2988DE1
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 16:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4X2T9N390jz9slB;
 Mon,  9 Sep 2024 16:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725890680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=71tlnADO8qMbsmY6CDoaJiXI92ZS/OM0knw5jCuQvfY=;
 b=qR8cPW6ThMYVMJ6+f9hxFemhhaMrDKZKdP7s/MQe8TiDnlCQV2e58+FH1lpzQr8tc0zn1I
 eDfeZpm+LdBRDOUJsEB7snF+6uKDDqXqAU+NzlHd7uaZPpGc8kpDim5VDdiGUhgVk2rh+E
 Egmr3nANzbP1Bpos3aLtl6IDA92C0uF4LfWEp+2j/D1pJfG+kQFANO/0L0Y/F2bi9twFl8
 ABO6MNjOEWh87/uIO69HWunCwui8FUvp/j5qMw0GFd4hXvt14nQ30Vrfhe5+TAdlYhfcU0
 JAE5Ya3nygsp/rxJUVtm+BHzYJiRmmKKgeDrIrO7fdpRjxMlrow25phBhQTT4g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1725890678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=71tlnADO8qMbsmY6CDoaJiXI92ZS/OM0knw5jCuQvfY=;
 b=f/XdIKX1oc83ZpFxSLqh+zUzWLg+HaiHVRGYvzJY4ctG4gnPoiAO5hOOsDyB4CR6r1pNCE
 SmaeIbBq36ozNqD75oqIh1eEARZDpXdeikP8ypCWttc0lBFNiRC1bXoAC0+TKvlmqJvl2C
 /spc/bVI0FAY+ltGqxBPTLlSLEgsQ+3vxhYERkHpKN/IipAnvt/BrSBZI/HlCOoImIt3Sa
 7HG+LCzVR3IyomZM8E+3OH4fk34FKQjbMioLwKlYjZumKg0ZotIu7NWjLnl9vUBfZT1l7N
 mjk1WG3Wd2NGHgjchjNBIPb/QHY8Cr3jYeMgd1hZT5KJ4iUO5E7IdMRLx2OsWQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-spi-fixes
Date: Mon,  9 Sep 2024 16:02:55 +0200
Message-ID: <20240909140419.7713-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1gppuemdu4ozkrakub3mnwx9p93jfg9u
X-MBO-RS-ID: ac13fe8d65cf1873f15
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

Last minute SPI fixes for R-Car to make the SPI NOR work on Gen4.
Also one RPC HF fix for Gen4.

The following changes since commit 1630ff26cc960439b5949b80cfc604a2c8aa47dd:

  Merge https://gitlab.denx.de/u-boot/custodians/u-boot-marvell (2024-09-04 10:34:54 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-spi-fixes

for you to fetch changes up to 3faeb78378ea32922fbd00e9ddf675ce0aa526a3:

  ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node (2024-09-09 01:10:44 +0200)

----------------------------------------------------------------
Marek Vasut (7):
      mtd: rpc: renesas: Add R-Car Gen4 DT compatible
      mtd: spi: renesas: Write DREAR register once
      mtd: spi: renesas: Write DRDMCR register once
      mtd: spi: renesas: Configure DRDRENR register
      mtd: spi: renesas: Configure RPC PHY timing registers
      mtd: spi: renesas: Add R-Car Gen4 DT compatible
      ARM: dts: renesas: Minimize R8A779G0 V4H RPC SPI DT node

 arch/arm/dts/r8a779g0-u-boot.dtsi            |  1 -
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi | 22 +---------------------
 drivers/mtd/renesas_rpc_hf.c                 |  1 +
 drivers/spi/renesas_rpc_spi.c                | 23 ++++++++++++++++++-----
 4 files changed, 20 insertions(+), 27 deletions(-)
