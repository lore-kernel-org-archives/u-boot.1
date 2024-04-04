Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A7CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E68A88423;
	Thu,  4 Apr 2024 11:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Is24vNko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F2188423; Thu,  4 Apr 2024 11:01:07 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3278842F
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490sw6069994;
 Thu, 4 Apr 2024 04:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221254;
 bh=z45PJnsm48jwQhyKDxp46mGSekI4JjqTgMG0oAlvPzY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Is24vNkoq37qMp7q1Pfv8ScJX7hslDYE+la8y/sTEvH3BFzHFOTdjQwvd9ZPRM3mf
 usYwT9j3rJlL18nOX98qRKMTGXSicsXa+VMiC6QUJhOpNt+cpb6PsjOBXPdZ91Yuin
 F8mtPSu/3C48Kg83k2tY5GPZ/RMAwCwNh6rZvabA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490sLi091423
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:54 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490rB7010979;
 Thu, 4 Apr 2024 04:00:53 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 09/15] ram: k3-ddrss: Enable the am62ax's DDR controller
 for J722S
Date: Thu, 4 Apr 2024 14:30:33 +0530
Message-ID: <20240404090039.87458-10-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
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

The J722S family of SoCs uses the same DDR controller as found on the
AM62A family. Enable this option when building for the J722S family.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 9838a2798f..a64d2dff68 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_J784S4
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"
-- 
2.25.1

