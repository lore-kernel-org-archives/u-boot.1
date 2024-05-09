Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18509C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5685B88022;
	Thu,  9 May 2024 16:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lhq+QBdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EF1880A3; Thu,  9 May 2024 16:20:48 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF2387F52
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449EKho1130414;
 Thu, 9 May 2024 09:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715264443;
 bh=OaaW4rpI3NTjO1xeih7CGcRtq03NW+L0kMRFQAYVwL8=;
 h=From:To:CC:Subject:Date;
 b=Lhq+QBdzwtv0XG2zx8Bo2boFbFtnbQWoz8Hhl2ISLPmLgOf/TJd51ZXDjjrMTGZ35
 78PgM+YPE/xmca/it0ktrlEPL3R/xTtFc8/FbM4T5Wuw5oLpM4X1hX+XDT4UIOKt2a
 p3kf0zicyYTKSoT2OKQu1/RL3uF6dskfZmTTnK7U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449EKhuA126148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 09:20:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 09:20:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 09:20:43 -0500
Received: from localhost ([10.250.32.135])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449EKgE1075262;
 Thu, 9 May 2024 09:20:42 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 0/4] Add remoteproc driver for AM62a SoC
Date: Thu, 9 May 2024 09:20:33 -0500
Message-ID: <20240509142037.32064-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This series adds relevant ip data in remoteproc driver for AM62a devices.

Logs: https://paste.sr.ht/~hnagalla/5e20838705c1d688bca81886dad56451b56d3913

Hari Nagalla (4):
  remoteproc: k3-dsp: Enable C71x support for AM62A
  remoteproc: k3-r5: Add support for R5F core on AM62A SoCs
  configs: am62ax: enable remote proc drivers
  board: ti: am62ax: Add support for remote proc load

 board/ti/am62ax/am62ax.env           |  4 ++++
 configs/am62ax_evm_a53_defconfig     |  3 +++
 drivers/remoteproc/ti_k3_dsp_rproc.c | 13 +++++++++++--
 drivers/remoteproc/ti_k3_r5f_rproc.c | 29 ++++++++++++++++++++++++++--
 4 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.34.1

