Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEFCC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A05B82E2D;
	Wed,  9 Apr 2025 09:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Mc9OJbkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39368283E; Wed,  9 Apr 2025 09:18:48 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8143C820E2
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-207.46.114.pool.telefonica.de
 [46.114.104.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1F21D4019E; 
 Wed,  9 Apr 2025 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744183125;
 bh=rvZbp0zofoCrmKqWuvEpmEglrGBr8eLiiQlOmsAfTL8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Mc9OJbkwBkY0mrlNtS8avByd+xkj4X3STB/nW53btViOdjNcYK5sAjVHtHPzNclbA
 dk8319bn8FUG0EeZkSJNY1k9ZMc7EeGaZgHLZ04dFUe/CMi4Nv5rBjoS/gzPWVfO6E
 aalO3rwKWQ2MkThUCY79PcOWjObEgbb+mV/xgc1SfU3a3yiuyF+goNrHq9qq4kCXSa
 0mgktoC+n3bUgzIqMLPo5I7os4u557p9SlusYD12rDMwr6stSv0Cid+4s+bjdaDzQ2
 JoyjRC5CTbNDPG58d59yH9vRr4nnPbIXScd13qfDwPXKTKhJqmW89SRekbsofSXSqQ
 JOGo0wVWiZbEA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/8] board: starfive: DeepComputing FML13V01
Date: Wed,  9 Apr 2025 09:18:27 +0200
Message-ID: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We use starfive_visionfive2_defconfig for supporting JH7110 based boards.

The DeepComputing Framework motherboard is a new JH7110 device with
upstream kernel support since v6.13.

Add support and documentation for the board.

This patches are prerequisite:
[PATCH 1/1] riscv: dts: jh7110: add bootph-pre-ram for &pllclk
https://lore.kernel.org/u-boot/20250330162421.238483-1-heinrich.schuchardt@canonical.com/T/#u
[PATCH v1] board: starfive: Remove compatible boards Milk-V Mars CM and Mars CM Lite
https://lore.kernel.org/all/20250327175550.529248-1-e@freeshell.de/

v3:
	Rebase upon Milk-V Mars CM removal patch
v2:
	Rebase upon orgin/next
	Carve out common documentation of JH7110 boards
	Drop patch for binman config - not needed anymore
	Add information about the debug UART


Heinrich Schuchardt (8):
  configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
  riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
  board: starfive: DeepComputing FML13V01 fdt selection
  board: starfive: spl: support DeepComputing FML13V01
  doc: add DeepComputing FML13V01 documentation
  doc: starfive: use consistent formatting
  doc: starfive: use jh7110_common.rst
  doc: jh7110: describe debug UART

 .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |  7 ++
 board/starfive/visionfive2/spl.c              |  5 +-
 .../visionfive2/starfive_visionfive2.c        |  6 +-
 configs/starfive_visionfive2_defconfig        |  2 +-
 doc/board/starfive/deepcomputing_fml13v01.rst | 80 +++++++++++++++++++
 doc/board/starfive/index.rst                  |  1 +
 doc/board/starfive/jh7110_common.rst          | 80 +++++++++++++++++++
 doc/board/starfive/milk-v_mars.rst            | 18 +----
 doc/board/starfive/pine64_star64.rst          | 26 ++----
 doc/board/starfive/visionfive2.rst            | 47 ++---------
 10 files changed, 192 insertions(+), 80 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst

-- 
2.48.1

