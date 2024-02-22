Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1393AC54788
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56C0880A6;
	Thu, 22 Feb 2024 14:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jcq/zeA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E47880AF; Thu, 22 Feb 2024 14:08:30 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAD088087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8DtO081165;
 Thu, 22 Feb 2024 07:08:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708607293;
 bh=XQHENsM6zbNGlXZ4vsGsWhrAdHUlW6PAmdevy6e6KgE=;
 h=From:To:CC:Subject:Date;
 b=Jcq/zeA+b8tEfGtO58uszn4m4U+XcKsck/ngpZOu/WWemcM8XEnmZiYh9GC39LqLz
 2q3JhewtUVUCG4JMvDajpVj0kdlH+T7EemcLoh8PHUswSEfm+QicpkltS+GGlALHYJ
 +Y6E6U96rOOTHTl8II9OoQa3EgvLek8qRqVTCnkA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MD8DCT106727
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 07:08:13 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:08:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:08:13 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8CUI121357;
 Thu, 22 Feb 2024 07:08:12 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH 0/4] Simplefb and fb reservation related updates
Date: Thu, 22 Feb 2024 18:38:07 +0530
Message-ID: <20240222130811.3878567-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
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

This adds support for simple-framebuffer reservation using video handoff
when splash is enabled at SPL stage.

Also adds helper function to only enable framebuffer reservation without
enabling simple-framebuffer in case user want to continue display
bootloader splash without displaying anything else in between until
kernel boots up.

Lastly, it enables above support on AM62x.

Devarsh Thakkar (4):
  boot: fdt_simplefb: Enumerate framebuffer info from video handoff
  video: Assume video to be active if SPL is passing video hand-off
  boot: Move framebuffer reservation to separate helper
  board: ti: am62x: evm: Update simple-framebuffer node in device-tree

 board/ti/am62x/evm.c         | 19 +++++++++++++++
 boot/fdt_simplefb.c          | 46 ++++++++++++++++++++----------------
 boot/fdt_support.c           | 21 ++++++++++++++++
 drivers/video/video-uclass.c |  4 ++++
 include/fdt_support.h        |  2 ++
 5 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.34.1

