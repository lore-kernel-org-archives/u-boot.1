Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB644C27C7A
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 12:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060F986B17;
	Thu, 17 Aug 2023 14:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="otbKGvZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D4C86B17; Thu, 17 Aug 2023 14:09:50 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B295B86B22
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 14:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HC9Xj9077011;
 Thu, 17 Aug 2023 07:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692274173;
 bh=Mzv6EJWHi8dSUBSbH5htTE8qzUo8EgdIkyPA4IXv1TY=;
 h=From:To:CC:Subject:Date;
 b=otbKGvZod8kcDLCVBwAFd8bW8bwLOD3tS3tPHMNan54W86Q6A2lNG8oIPcMfoQe/C
 FpAYdeA0KZ4GwXquuH5VuDZenzumuKp+BtznAJO4suqdXpXuKV4G1oPHx7OsuPneNZ
 y3VP+JwDv4TUFM8G5bsFcLXTPzkrGdOtWnrWUQso=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HC9I5a006951
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 17 Aug 2023 07:09:18 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 07:09:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 07:09:18 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HC9FB8025900;
 Thu, 17 Aug 2023 07:09:16 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>
CC: <bhupesh.sharma@linaro.org>, <marek.vasut@mailbox.org>, <nm@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <sjg@chromium.org>,
 <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Update UFS maintainer
Date: Thu, 17 Aug 2023 17:39:14 +0530
Message-ID: <20230817120914.144240-1-n-francis@ti.com>
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

Dropping Faiz Abbas from the UFS maintainer list as his e-mail ID is no
longer valid.

Adding Bhupesh Sharma who has been using this framework working on
Qualcomm Snapdragon SoCs as well as sending out fixes.

Adding myself as well to support in reviewing and testing patches.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Nishnath Menon <nm@ti.com>
---
Based on discussion:
https://lore.kernel.org/u-boot/CAH=2NtzyQgximynKuG45UUux715Du=WKKusm9-aQGHcUZsWzSw@mail.gmail.com/

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77a8b0ac21..d19e1fd60b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,7 +1585,8 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-ubi.git
 F:	drivers/mtd/ubi/
 
 UFS
-M:	Faiz Abbas <faiz_abbas@ti.com>
+M:	Bhupesh Sharma <bhupesh.sharma@linaro.org>
+M:	Neha Malcom Francis <n-francis@ti.com>
 S:	Maintained
 F:	drivers/ufs/
 
-- 
2.34.1

