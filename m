Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3967EC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 05:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6F981E14;
	Fri, 25 Apr 2025 07:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XfK5aSbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2956681E25; Fri, 25 Apr 2025 07:34:40 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8558059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 07:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53P5YYHG2080685
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 00:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745559275;
 bh=SBO4cHSvmLiMHeFauJOjoIZCh8VBSN+6qraErwOJwRk=;
 h=From:To:CC:Subject:Date;
 b=XfK5aSbY5/uUNXTmczdUcvtTQTvAUaDBqrQnr5YRtWii7fJ6FNZG+7Nhc52ZGa9yP
 XnuLr3qeubmFWQZV6fBLGH8ZZR/42HT7cAwgf2i4FL9H33iMKGs/SHjqEmwDYLLskN
 3LSevsbugtdevvuIz9s5G3cJzRjBeJ/DkFUyBe0M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53P5YY39019199
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 00:34:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 00:34:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 00:34:34 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53P5YWp7048874;
 Fri, 25 Apr 2025 00:34:32 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/2] AM57 Boot fixes 
Date: Fri, 25 Apr 2025 11:04:29 +0530
Message-ID: <20250425053431.1622267-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
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

The directory structure for omap has changed to /boot/dtb/ti/omap/<dtb file>.
This results in "Failed to load '/boot/<dtb file>' error".
Do relevant changes so that the fdtfile can be set from C code.

Logs: https://gist.github.com/anuragdutta731/3b58f48f7ddc07b7b8a98ca436a06e3a

Anurag Dutta (2):
  include: env: ti: mmc.h: Find DTB files in dtb directory for AM57xx
  board: ti: am57xx: Set fdtfile from C code instead of findfdt script

 board/ti/am57xx/board.c           | 19 ++++++++++++++++
 include/configs/ti_omap5_common.h | 36 -------------------------------
 include/env/ti/mmc.h              |  2 +-
 3 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.34.1

