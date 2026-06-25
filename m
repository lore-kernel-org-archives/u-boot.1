Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A643FCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630628495E;
	Thu, 25 Jun 2026 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="KvE8obFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD1884704; Thu, 25 Jun 2026 14:19:45 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721848460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782389982; x=1813925982;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5q6SB2nfcnDH+q/5wOMemn6kYevK3q06Y0hCiLHjL0o=;
 b=KvE8obFG3ZUyd+pApMSy4jXXtl+hNvOFV2VsOWT/lg3bcfIBY6gTNxVj
 +Cun+V48WtcZ2UqB6XJkKRqJu/xZkzClS/bKgUXu1SRPiCuh8h+VfWg07
 OPX1bfqzfj+YNqpxocTBcdSNFIRyjcwnpiUe158yG3qXERlQJPzoCNqiw
 SYSmCD/6j+EePV3e7BdmSAFXxsAOqy5l9UM9c9ZEpMvToWXNAVGMy1kgt
 Tx3T3/1CVbhPOzQIxSbkQfA6RGKwypUgzGvMocxfCiULL6VrvwPdKqpNe
 65bCqypBaoSYlMe4Th4vju5I4wD3dSwVe7oAAecDJQsDeLylksyHzns+x w==;
X-CSE-ConnectionGUID: Pht6rCHNTk6zkQwdjENyAQ==
X-CSE-MsgGUID: gtW4eoadS1yHyPVf3v9gfg==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="226851776"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:19:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 25 Jun 2026 05:19:40 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:19:37 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 0/8] MPFS: add hardware RNG support and fix RNG consumers
Date: Thu, 25 Jun 2026 13:23:17 +0100
Message-ID: <20260625122325.834568-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

Hi all,

This series adds support for the hardware random number generator (RNG) on
the Microchip PolarFire SoC (MPFS) and fixes several related issues
uncovered during integration and testing.

The MPFS hardware RNG is accessed indirectly via the MPFS system
controller using the mailbox interface. Unlike typical memory-mapped RNGs,
the system controller mailbox is shared and non‑reentrant, which
introduces a number of integration challenges in U‑Boot, particularly
during autoboot when multiple system controller services are active.

This series addresses those challenges in various ways.
1. Fixes generic RNG command handling to correctly interpret dm_rng_read()
return values.
2. Adds missing infrastructure in the MPFS system controller driver to
explicitly receive mailbox responses.
3. Binds the MPFS RNG as a sub‑device of the system controller, mirroring
Linux behaviour and avoiding the need for a device tree node.
4. Introduces a new MPFS RNG driver implementing UCLASS_RNG.
5. Enables RNG support in the Microchip PolarFire SoC generic defconfig.
6. Replaces unbounded polling loops with regmap_read_poll_timeout().
7. Replaces an immediate -EBUSY return with a bounded wait for BUSY to clear,
preserving Linux‑equivalent semantics while avoiding spurious early‑boot
failures in U‑Boot.
8. Fixes boot-time KASLR seed generation to treat RNG as a best‑effort
entropy source, only causing a warning when entropy is temporarily
unavailable.

The resulting behaviour matches Linux semantics where possible, while
respecting U‑Boot’s single‑threaded, non‑blocking execution model. RNG
consumers receive entropy when available, and gracefully fall back when it
is not, without breaking autoboot.

All changes have been tested on the PolarFire SoC Icicle Kit ES.

Regards,
Jamie.

Jamie Gibbons (8):
  cmd: rng: fix error handling for dm_rng_read()
  misc: mpfs_syscontroller: add mailbox RX helper for service responses
  misc: mpfs_syscontroller: bind RNG sub-device
  rng: add Microchip PolarFire SoC hardware RNG driver
  configs: microchip_mpfs_generic: enable MPFS RNG support
  mailbox: mpfs-mbox: replace unbounded BUSY polling with bounded waits
  mailbox: mpfs: add bounded wait for BUSY to clear before sending
    request
  boot: fdt: downgrade KASLR RNG failure to warning

 boot/fdt_support.c                       |  13 ++-
 cmd/rng.c                                |   2 +-
 configs/microchip_mpfs_generic_defconfig |   3 +
 drivers/mailbox/mpfs-mbox.c              |  27 ++++--
 drivers/misc/mpfs_syscontroller.c        |  34 +++++++-
 drivers/rng/Kconfig                      |   7 ++
 drivers/rng/Makefile                     |   1 +
 drivers/rng/mpfs_rng.c                   | 106 +++++++++++++++++++++++
 include/mpfs-mailbox.h                   |   1 +
 9 files changed, 178 insertions(+), 16 deletions(-)
 create mode 100644 drivers/rng/mpfs_rng.c

-- 
2.43.0

