Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0656C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6358E87185;
	Mon, 13 Nov 2023 15:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RHHpC0f7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C9287116; Mon, 13 Nov 2023 15:52:05 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1154E87124
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEppY3018998;
 Mon, 13 Nov 2023 08:51:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887111;
 bh=ch8x67U+WyhQtOVxbY4lv/DcpWpP9IQEAxgCvz73U/I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RHHpC0f7PkxzFN4/sbKqUACdMttDP3s9N1FX1OY8WcKRkMbRIew3zP4kcDTjPnoaM
 9T9cMkWMqUJ9gc+qdP5Oe0b9ZZiCLm5CL9kyiBy2dtNmDB68g4fwj8tsaAsAspE9a4
 wOtdefendlw07C/kuKtbbCsK9WiVHEfaV8xPy5eE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEppHs013532
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:51:51 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:51:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:51:51 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEpp2L053374;
 Mon, 13 Nov 2023 08:51:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/8] board: ti: am62ax: env: Use default findfdt
Date: Mon, 13 Nov 2023 08:51:46 -0600
Message-ID: <20231113145149.1926732-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145149.1926732-1-nm@ti.com>
References: <20231113145149.1926732-1-nm@ti.com>
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

Use the default findfdt instead of local logic.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/am62ax/am62ax.env | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/ti/am62ax/am62ax.env b/board/ti/am62ax/am62ax.env
index bfed7f360844..2af6914e3fab 100644
--- a/board/ti/am62ax/am62ax.env
+++ b/board/ti/am62ax/am62ax.env
@@ -1,10 +1,7 @@
 #include <env/ti/ti_common.env>
+#include <env/ti/default_findfdt.env>
 #include <env/ti/mmc.env>
 
-default_device_tree=ti/k3-am62a7-sk.dtb
-findfdt=
-	setenv name_fdt ${default_device_tree};
-	setenv fdtfile ${name_fdt}
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
-- 
2.40.0

