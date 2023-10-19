Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55858CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2158723E;
	Thu, 19 Oct 2023 16:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69E687232; Thu, 19 Oct 2023 16:31:00 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 735BE870F3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,237,1694703600"; d="scan'208";a="179875860"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 19 Oct 2023 23:30:54 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.46])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 826C04005B25;
 Thu, 19 Oct 2023 23:30:52 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v4 0/2] Add support for the Renesas RZ/G2L SMARC EVK
Date: Thu, 19 Oct 2023 15:30:42 +0100
Message-Id: <20231019143044.1363-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
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

These patches finish off initial support for the RZ/G2L SMARC Evaluation board
kit (EVK). All patches which have already been merged are dropped, this is just
the re-worked SCIF patches.

These patches have been tested on an RZ/G2L as well as on the qemu 'r2d' machine
to confirm that the serial port issue observed by Marek in v3 is fixed.

Paul Barker (2):
  serial: sh: Fix error handling
  serial: sh: Add RZ/G2L SCIF support

 arch/arm/mach-rmobile/Kconfig |  1 +
 drivers/serial/serial_sh.c    | 31 +++++++++++++++++++++++++++++--
 drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
 3 files changed, 48 insertions(+), 3 deletions(-)


base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
-- 
2.39.2

