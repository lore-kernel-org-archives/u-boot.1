Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E3EC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 20:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932EA87D9A;
	Wed,  1 Nov 2023 21:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E37876AF; Wed,  1 Nov 2023 21:06:45 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C7B1186E64
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 21:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,269,1694703600"; d="scan'208";a="181450872"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2023 05:06:40 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.52])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5A908400F78D;
 Thu,  2 Nov 2023 05:06:38 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 4/8] pinctrl: rzg2l: Drop <common.h>
Date: Wed,  1 Nov 2023 20:05:55 +0000
Message-Id: <20231101200600.119507-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
References: <20231101200600.119507-1-paul.barker.ct@bp.renesas.com>
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

In line with changes elsewhere, drop inclusion of the common header.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/pinctrl/renesas/rzg2l-pfc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/renesas/rzg2l-pfc.c
index 7b045f75d3f9..e88ec1c18373 100644
--- a/drivers/pinctrl/renesas/rzg2l-pfc.c
+++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021-2023 Renesas Electronics Corp.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
-- 
2.39.2

