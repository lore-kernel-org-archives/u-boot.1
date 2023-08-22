Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C80EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB798649F;
	Tue, 22 Aug 2023 20:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5664C8649F; Tue, 22 Aug 2023 20:10:42 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 4B6358645C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,193,1684767600"; d="scan'208";a="177305227"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 23 Aug 2023 03:10:35 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.37])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6BCF8406EA66;
 Wed, 23 Aug 2023 03:10:33 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 0/2] Renesas SCIF driver fix & tidy up
Date: Tue, 22 Aug 2023 19:10:22 +0100
Message-Id: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I'll shortly be sending an initial patch set adding support for the Renesas
RZ/G2L SMARC evaluation board and R9A07G044L SoC. Before dropping those patches
I've got a compilation fix and a header tidy up for the SCIF driver.

Paul Barker (2):
  serial: sh: Fix compile error when lacking HSCIF support
  serial: sh: Tidy up pre-processor directive indentation

 drivers/serial/serial_sh.c |  2 +
 drivers/serial/serial_sh.h | 84 +++++++++++++++++++-------------------
 2 files changed, 44 insertions(+), 42 deletions(-)

-- 
2.34.1

