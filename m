Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BF9CF9C7D
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 15:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09BC88BCF;
	Wed, 25 Sep 2024 17:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cxChwYea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB72807B1; Wed, 25 Sep 2024 17:14:18 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B4288B6D
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 17:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDuku067031;
 Wed, 25 Sep 2024 10:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727277236;
 bh=25RKelWB7EOggWtcp4su/qVsEpNCs5kgh3tq5lSJy1A=;
 h=From:To:CC:Subject:Date;
 b=cxChwYea98ojqhn5iQa6JqFCp1hMbzt0qBoARr+Z4MUnZBGo6XvgdFYG9Iz7SrBxg
 ql6qHPT8w0Ty5nO40GRxLMCIeiJdQg/vRORx8dsVvgOzq5nCOUVEIUW6DzsDbz/Rjr
 sCfrVZ2XV3C0Sj8p7o3NEocTzBt+ISvy+dhKshXU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PFDuLf032758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 25 Sep 2024 10:13:56 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 10:13:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 10:13:55 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDthl017897;
 Wed, 25 Sep 2024 10:13:55 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <sjg@chromium.org>, <agust@denx.de>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
 <j-humphreys@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <akashi.tkhro@gmail.com>,
 <mkorpershoek@baylibre.com>, <eajames@linux.ibm.com>,
 <caleb.connolly@linaro.org>, <quentin.schulz@cherry.de>,
 <martinstolpe@gmail.com>, <iivanov@suse.de>, <n-jain1@ti.com>,
 <devarsht@ti.com>
Subject: [PATCH 0/3] Simple-framebuffer node related updates
Date: Wed, 25 Sep 2024 20:43:51 +0530
Message-ID: <20240925151354.480704-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This series fixes some compilation issues related to FDT_SIMPLEFB
and VIDEO and along with that enables support for dynamic simplefb
node enablement for AM62x platform.

Devarsh Thakkar (3):
  boot/Kconfig: Add Video Kconfig as dependency for FDT_SIMPLEFB
  boot: fdt_simplefb: Remove conditional compilation checks for VIDEO
    Kconfig
  board: ti: am62x: evm: Update simple-framebuffer node in device-tree

 board/ti/am62x/evm.c | 21 +++++++++++++++++++++
 boot/Kconfig         |  1 +
 boot/fdt_simplefb.c  |  2 --
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.39.1

