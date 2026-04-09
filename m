Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C3CF364A4
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 17:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9146E83DC9;
	Thu,  9 Apr 2026 19:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="X7ZG0azQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nD9srTi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C144B84105; Thu,  9 Apr 2026 19:11:32 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6924683D8A
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 19:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fs60d0VJFz9ts1;
 Thu,  9 Apr 2026 19:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775754689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ar0PBev3YZ8QJgiBDwDKaznnK9iLKNL29N5IiRYkRDQ=;
 b=X7ZG0azQ5EB5FqoRKDzicj/TmfGXpdD3MH8CVXyLAzoP3JiQlEnpCfQ0XqzSQNZUVUFO2g
 VaroV8/Ue/URDc3pRw9yxer3RaTPemkkDFiBG7Cp8+lh3SNtwGwQNeCQfDeZa64yy9IQ7I
 SaLyIaQIdVA958e840PtdVRs6b5UFfC1Cx0e7981a02pjH29RxEyE/Gm//u3jaT94ays2t
 sUY0KqhUdKPIt6AzEUho4iUBSVtpmRfjo65IcfE8KK+o2wpdwLQhR0YfUIkUUbmfOzXQCN
 WxTKgd4k5wEp65raIKQVfW+K+bMnNlQimLTsmGjo3OnT+3yDW147bV+bA5OIFg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775754687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ar0PBev3YZ8QJgiBDwDKaznnK9iLKNL29N5IiRYkRDQ=;
 b=nD9srTi0mujOjAR25hdUFW7un9gxPhZICVIukScrBiPxQRmbbdz113Sbv6M5r6/mtM0Iyz
 bFyNM2pVN96PyCOawBidGaU7xPRtl4G0BNS9LeVIPPym7qyrDCFWjrXTxUVwZsPN8lWVI3
 hv2G798aN+Njkc+Ti/uZtxKIllnRLjMsY2ImfQL2nU/8aS2yA7rzZjAEYNJ3JoCdwabpfF
 OU4yMhcos74rMG4btHC6oeuA+UynR2Z6sVJl4ZkOBXxKxydQ5KPvWPe3prvhqj6DqzbayN
 Y4SxinqNcwUWDfzDjTB+m0TwzUzTduW6T+vC0uGnNNR7C+nvLj+GOY+RMarEsg==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Thu,  9 Apr 2026 19:09:04 +0200
Message-ID: <20260409171057.16628-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: abea728762ea8fdb2d3
X-MBO-RS-META: 9jdywoczcxn1hehgkdfmbnk97sm3n6ok
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

Assorted fixes and tweaks, HUSH parser, preboot env variable, SMC command
enablement, s_init and 32bit/64bit code clean up, DBSC and APMU remoteproc
clean ups, UFS dev_phys_to_bus() remap support and SCIF R-Car Gen5 support.

The following changes since commit a383c9689282269bb9687ec6c115de094c27fa67:

  dm: Respect dma-ranges size (2026-04-07 15:27:22 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 4a95a2a9e13ab05e4fc309f92bc33998d80afe01:

  ufs: Remap CPU to bus addresses using dev_phys_to_bus() (2026-04-08 19:53:44 +0200)

----------------------------------------------------------------
Marek Vasut (10):
      arm: renesas: Enable modern HUSH parser on all R-Car systems
      arm: renesas: Enable preboot environment variable on all R-Car systems
      arm: renesas: Use stock lowlevel_init function and remove s_init
      arm64: renesas: Enable SMC command on all R-Car 64-bit systems
      arm64: renesas: Make R-Car board code 32-bit ARMv8-M compatible
      arm64: renesas: Separate 64bit only code
      ram: renesas: dbsc: Use macro in renesas_dbsc5_board_config channel count
      remoteproc: renesas: apmu: Fix typo in Kconfig symbol help text
      serial: sh: Handle HSCIF on all 64-bit R-Car SoC
      ufs: Remap CPU to bus addresses using dev_phys_to_bus()

 arch/arm/mach-renesas/Makefile             | 11 +++--
 arch/arm/mach-renesas/lowlevel_init_gen3.S | 71 ------------------------------
 board/renesas/common/gen3-spl.c            |  4 --
 board/renesas/common/gen4-common.c         |  4 +-
 board/renesas/common/gen4-spl.c            |  4 +-
 board/renesas/common/gen5-common.c         |  4 +-
 board/renesas/common/rcar64-common.c       |  5 ++-
 configs/renesas_rcar.config                |  3 ++
 configs/renesas_rcar64.config              |  1 +
 drivers/remoteproc/Kconfig                 |  2 +-
 drivers/serial/serial_sh.c                 |  2 +-
 drivers/ufs/ufs-uclass.c                   | 24 +++++-----
 include/dbsc5.h                            |  2 +-
 13 files changed, 41 insertions(+), 96 deletions(-)
