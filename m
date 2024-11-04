Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B5CD132C7
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6489088D7E;
	Mon,  4 Nov 2024 14:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC2788C75; Mon,  4 Nov 2024 14:50:35 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id AC86A889D2
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.paterson2@renesas.com
X-IronPort-AV: E=Sophos;i="6.11,257,1725289200"; d="scan'208";a="223825495"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2024 22:50:29 +0900
Received: from spl2-146.example.org (unknown [10.24.1.209])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id E578541A9A9C;
 Mon,  4 Nov 2024 22:50:20 +0900 (JST)
From: Chris Paterson <chris.paterson2@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 u-boot@lists.denx.de, Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH 0/2] board: hoperun: Fix issues caused by upstream DTS changes
Date: Mon,  4 Nov 2024 13:50:10 +0000
Message-ID: <20241104135012.45814-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.43.0
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

We've seen some issues after switching to using upstream Linux device
trees that have stopped the hihope family of platforms from booting
correctly.

The first patch corrects the MMC device used to store the U-Boot env.
The second patch removes the U-Boot specific DTS changes so that we use
the Linux device trees as-is.

Kind regards, Chris

Chris Paterson (1):
  configs: hihope_rzg2: Set correct MMC device for U-Boot env

Lad Prabhakar (1):
  board: hoperun: Switch to use complete DTS files from upstream DTS

 .../dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774a1-u-boot.dtsi             | 42 -----------------
 .../dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774b1-u-boot.dtsi             | 40 ----------------
 .../dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi  |  8 ++++
 .../arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi | 26 -----------
 arch/arm/dts/r8a774e1-u-boot.dtsi             | 46 -------------------
 board/hoperun/hihope-rzg2/hihope-rzg2.c       |  6 +--
 configs/hihope_rzg2_defconfig                 | 10 ++--
 11 files changed, 32 insertions(+), 214 deletions(-)
 create mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
 create mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-ex-u-boot.dtsi
 delete mode 100644 arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi

-- 
2.43.0

