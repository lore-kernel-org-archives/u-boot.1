Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDABC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 04:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B99AF87657;
	Fri,  3 Nov 2023 05:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ahj9zdPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A21875FD; Fri,  3 Nov 2023 05:40:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A64875DA
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 05:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A34eRsk061783;
 Thu, 2 Nov 2023 23:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698986427;
 bh=XT0ddN3BFzS7YVDOdD2bQuTK7/Jd4DOVaTU+A9jbEtU=;
 h=From:To:CC:Subject:Date;
 b=ahj9zdPD98Gh9MRyqp8PbvBAgJAiGJyKMkHeeAizTUxNTBkFgUSufMZYu+ZQtW67N
 T4FPaDPtBKSjgdBaHaGcEVbQAZwC180vYdh9ploXegvBiTVoLUiR60jtVM5yoBc0Pc
 hzUG85geaylhLsMaaZbjH4bMooCzGF8gNl8WOFMc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A34eRr8032065
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 23:40:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 23:40:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 23:40:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A34eRYH123811;
 Thu, 2 Nov 2023 23:40:27 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] doc: board: ti: Cleanup ::prompt usage
Date: Thu, 2 Nov 2023 23:40:24 -0500
Message-ID: <20231103044026.7743-1-nm@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Due to the sequence of merges, it looks like many of k3 documentation
used code-blocks while the rest of the docs migrated to ::prompt.

Sync all to a common style.

based off:
master 07fe79c93c5c Merge tag 'i2cfixes-for-v2024-01-rc2' of https://source.denx.de/u-boot/custodians/u-boot-i2c

Changes since V1:
* squashed up the gdb patch to patch#1
* fixedup patch #2 for whitespace indentation miss

v1: https://lore.kernel.org/r/20231103000915.2413501-1-nm@ti.com

Nishanth Menon (2):
  doc: board: ti: Use prompt prompt_style to simplify documentation
  doc: board: ti: k3 docs: Use ::prompt

 doc/board/ti/am335x_evm.rst       |  39 ++++-------
 doc/board/ti/am62x_beagleplay.rst |  46 ++++++-------
 doc/board/ti/am62x_sk.rst         |  18 +++---
 doc/board/ti/am64x_evm.rst        |  20 +++---
 doc/board/ti/am65x_evm.rst        | 104 +++++++++++++++---------------
 doc/board/ti/dra7xx_evm.rst       |   3 +-
 doc/board/ti/j7200_evm.rst        |  20 +++---
 doc/board/ti/j721e_evm.rst        |  40 ++++++------
 doc/board/ti/j721s2_evm.rst       |  18 +++---
 doc/board/ti/k3.rst               |  44 ++++++-------
 doc/board/ti/ks2_evm.rst          |  15 ++---
 11 files changed, 174 insertions(+), 193 deletions(-)

-- 
2.37.2

