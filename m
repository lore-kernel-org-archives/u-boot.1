Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6C4C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA97281E1C;
	Mon, 31 Mar 2025 09:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ya/9aGRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB878144A; Mon, 31 Mar 2025 09:24:23 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84CB80F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 73C293F9D9; 
 Mon, 31 Mar 2025 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405858;
 bh=k59xX4+gvIlLzUrLTu1e1/ro2kl33hLZVdJsye0lvi4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ya/9aGRBj0OZONnq0GPsJl8nMogo2t5/rHNNlzDdMV/GXL+D02fQsCSx8WJPRLidh
 XXybflXUf6DLbDIF+Dun970iHR/CRwOJ4fi5iVA0HRYngQtm2TSS/Ta3kdM6Na9itA
 w/E2sBGUSIQahVB2tqYdkUepb0oQUFDtNWJrqlSOzSF1HHl4f2p8Vs96Nvjyedwnm4
 t50C9LLvZNCtMDabiaXNHJ8F40TWEUg5dZV6eVkh+3Elhcd6+fP9thJrFdyzzaXV5g
 BDqq6XmpXV0504aH1egDILE4UERGZeuTGECFZEY2J3BU6GvUR08QPcpYFeWos+y2Dh
 ijzSm8ikP/1gA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/8] board: starfive: DeepComputing FML13V01
Date: Mon, 31 Mar 2025 09:24:02 +0200
Message-ID: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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

This patch is prerequisite:
[PATCH 1/1] riscv: dts: jh7110: add bootph-pre-ram for &pllclk
https://lore.kernel.org/u-boot/20250330162421.238483-1-heinrich.schuchardt@canonical.com/T/#u

v2:
	Rebase of orgin/next
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
 doc/board/starfive/milk-v_mars_cm.rst         | 12 +--
 doc/board/starfive/pine64_star64.rst          | 26 ++----
 doc/board/starfive/visionfive2.rst            | 47 ++---------
 11 files changed, 198 insertions(+), 86 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst

-- 
2.48.1

