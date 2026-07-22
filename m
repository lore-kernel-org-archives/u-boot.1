Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE9BC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBFC3608D7;
	Thu, 23 Jul 2026 00:52:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQqXWmWP-xTv; Thu, 23 Jul 2026 00:52:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E32D2608D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767942;
	bh=vdWY0ZTuwPgVe5EpHJU2TRSJfK8hstSrxSEGTz2+vss=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sZIVSDuxZgaAX6NSgytRiIW5txK6Nf603XFW9W6aygwEdTpA+DiE5VjPc5VA+wkG4
	 UR63e1+6kx71YoCDUMXGJ4wA72Tx41fYx2GL2hH/kJoaVpHnGaBeKFHNjMBUqtsidN
	 MlJAZuqeFA04wOJfLmthVuBiku+AY0FJKY677kfM8ZPPRfPLZymw/ynKrUVp7HNTwi
	 kHbDFwARCqECa87M/mhhCw1NhsBiSOBdATzzgBY2AQKlYaFq4QKnheHrz7/IL/+nqQ
	 WjqrKYozmEaF/0zJKp48K/hxy7t0roi6Q7dgn+cp4Fs/L9JnclaAdGzljhjk1Qe/ak
	 X4nZa2azuI5Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E32D2608D1;
	Thu, 23 Jul 2026 00:52:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2369E2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09AC2607E3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3W4nvF5V1Yr for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:42:47 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=prvs=656eedf95=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AAD25607DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAD25607DC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAD25607DC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:42:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80BF8494B; Wed, 22 Jul 2026 17:42:42 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2176F848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:42:39 +0200 (CEST)
X-CSE-ConnectionGUID: 6XP81SuIQaqI50N8poLatQ==
X-CSE-MsgGUID: 2A83FQjxRe20Q0V/Z60zgw==
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="70467178"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jul 2026 08:42:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 08:42:36 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 08:42:34 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin
 Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH v2 0/6] MPFS: add hardware RNG support and fix RNG consumers
Date: Wed, 22 Jul 2026 16:45:43 +0100
Message-ID: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784734960; x=1816270960;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lUVZmt5lm1hpQkWR8jVnM8OZRl6bPk/mUOxk4J/M0pg=;
 b=IGHJWTVBxosVZD+EQIxJylReO6GR/ftyalVz1yMFdyyfhvaczpYq8Wwg
 JhcSUfVTUEG+HTUsUKIYeJgGy1mKwUqM0t97rrnx8KqbvRzzN53T6BVi0
 ysbZciMsVLTQCFngvBOwsxE+t3zjVxnWI6QeVfgijNZsdgmBInNVLy3Rq
 +ixFPQZUPBVZ850H0IGb2WM7+UXOd6testtVDXJKEITQF+p3vQwv3fVa5
 yd0z08cDJ0E/8DiE5eLdClceSyIimgAdkQQjeeeS0dbkiThM+pkQgztWo
 ZJVjxcvJQrc8ibry7JBvy2dXXgg9JWE7hAkZ4bX5VbVFKNo32NRtGPg8S
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=IGHJWTVB
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=656eedf95=Jamie.Gibbons@microchip.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.b="IGHJWTVB"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi all,

This series adds support for the hardware random number generator (RNG) on
the Microchip PolarFire SoC (MPFS) and fixes several related issues
uncovered during integration and testing.

The MPFS hardware RNG is accessed indirectly via the MPFS system
controller using the mailbox interface. Unlike typical memory-mapped RNGs,
the system controller mailbox is shared and non‑reentrant, which
introduces integration challenges in U‑Boot’s synchronous, polled
execution model during early boot.
While integrating the RNG support, testing revealed that mailbox requests
issued during autoboot could fail spuriously due to transient mailbox
BUSY states. Investigation showed that the MPFS mailbox BUSY indication
reflects multiple phases of the underlying IHC handshake, allowing
U-Boot’s polled model to observe intermediate states that Linux’s
interrupt-driven model normally hides.

This series addresses those challenges in various ways.
1. Adds missing infrastructure in the MPFS system controller driver to
explicitly receive mailbox responses.
2. Binds the MPFS RNG as a sub‑device of the system controller, mirroring
Linux behaviour and avoiding the need for a device tree node.
3. Introduces a new MPFS RNG driver implementing UCLASS_RNG.
4. Enables RNG support in the Microchip PolarFire SoC generic defconfig.
5. Replaces unbounded polling loops with regmap_read_poll_timeout().
6. Replaces an immediate -EBUSY return with a bounded wait for BUSY to
clear, before issuing requests, avoiding spurious early-boot mailbox
failures and allowing KASLR seed generation to complete successfully
during autoboot.

The resulting behaviour matches Linux semantics where practical while
remaining appropriate for U-Boot’s single-threaded execution model.
Interactive RNG usage and boot-time KASLR seed generation both work
reliably after the mailbox sequencing fixes.

All changes have been tested on the PolarFire SoC Icicle Kit ES.

Regards,
Jamie.

v1 -> v2:
- Removal of patch 1/8 (cmd: rng: fix error handling for dm_rng_read())
  after correcting the MPFS RNG driver to follow existing UCLASS_RNG
  semantics (0 on success, negative errno on failure).
- Removal of patch 8/8 (boot: fdt: downgrade KASLR RNG failure to warning)
  after the mailbox sequencing fixes resolved the early-boot RNG failure
  along with the correct return value fix above.
- Moved `DM_RNG` selection into the defconfig enablement patch.
- Removed special-casing of `-EBUSY` in the system controller path.
- Removed informational RNG registration logging.
- Added review/ack tags where applicable.

Jamie Gibbons (6):
  misc: mpfs_syscontroller: add mailbox RX helper for service responses
  misc: mpfs_syscontroller: bind RNG sub-device
  rng: add Microchip PolarFire SoC hardware RNG driver
  configs: microchip_mpfs_generic: enable MPFS RNG support
  mailbox: mpfs-mbox: replace unbounded BUSY polling with bounded waits
  mailbox: mpfs: add bounded wait for BUSY to clear before sending
    request

 configs/microchip_mpfs_generic_defconfig |   3 +
 drivers/mailbox/mpfs-mbox.c              |  27 ++++--
 drivers/misc/mpfs_syscontroller.c        |  36 +++++++-
 drivers/rng/Kconfig                      |   7 ++
 drivers/rng/Makefile                     |   1 +
 drivers/rng/mpfs_rng.c                   | 101 +++++++++++++++++++++++
 include/mpfs-mailbox.h                   |   2 +
 7 files changed, 165 insertions(+), 12 deletions(-)
 create mode 100644 drivers/rng/mpfs_rng.c

-- 
2.43.0

