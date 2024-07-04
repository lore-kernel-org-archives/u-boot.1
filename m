Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143DBC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 08:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4246B888CC;
	Thu,  4 Jul 2024 10:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ico9pSqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6AD888EB; Thu,  4 Jul 2024 10:44:17 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5289988679
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 10:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4648i6xF105008;
 Thu, 4 Jul 2024 03:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720082646;
 bh=EuBFkTzLVc9RKUL+BsCrNpOOJUwUUExoNyet8Ne9L84=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ico9pSqVHqlqDNdr7/wgTtme12vuXfns6s8nzf019oTQuq4dBubpqb4Nt5CcAyUlm
 I4s6WOsNjCMOMR9knDM11tBh5wJK9gC4KC8ePcSOXyL1qHySg5CLmUQaIyVCNp8yvo
 w7sk7AdGZVPdOtaCDP61lTAztMty7s8r3URiZmI8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4648i6pU011259
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 03:44:06 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 03:44:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 03:44:06 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4648hPVA010413;
 Thu, 4 Jul 2024 03:44:02 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V4 6/6] MAINTAINERS: Include the TI docs under ARM TI
Date: Thu, 4 Jul 2024 14:12:08 +0530
Message-ID: <20240704084207.2211801-7-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704084207.2211801-1-d-gole@ti.com>
References: <20240704084207.2211801-1-d-gole@ti.com>
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

Add entry for the TI boards documentation under ARM TI

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b32a6d94644..da730c6e4840 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -733,6 +733,7 @@ F:	arch/arm/mach-omap2/
 F:	arch/arm/include/asm/arch-omap*/
 F:	arch/arm/include/asm/ti-common/
 F:	board/ti/
+F:	doc/board/ti/
 F:	drivers/dma/ti*
 F:	drivers/dma/ti*/
 F:	drivers/firmware/ti_sci.*
-- 
2.34.1

