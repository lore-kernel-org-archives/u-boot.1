Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D06DCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9597386D17;
	Fri, 13 Oct 2023 01:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vJ7ZFj2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6977B86D41; Fri, 13 Oct 2023 01:07:10 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B5686E50
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JPl067510;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=1FZ9eVLx88fyZNTH4GxBg8fs6zCFxUyXlEr7jQyV7ck=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vJ7ZFj2Fuqyx2FuGmCOGuXG965yKBagfnEEe7VPV2cvijHE3weZHbxsIaYzzXLeRq
 2o1gl3wMTYIvYJrxBLlKQZTxdA25rMw0zs5bt00TodgiKRBQBNz8kEATX4L8vPHTuJ
 W7ZC8acxFE0fh0PqZUGMgF/5DzL7/UihQn0K8pQo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6J0k020817
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6Iwm032140;
 Thu, 12 Oct 2023 18:06:18 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 03/11] ram: k3-ddrss: enable the am62ax's DDR controller for
 am62px
Date: Thu, 12 Oct 2023 18:06:20 -0500
Message-ID: <20231012230616.2101992-16-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=bb@ti.com;
 h=from:subject; bh=yokM9ea79E7xIfeUNNUKzZU96XNpuq/v2iDcWRZBvPs=;
 b=owNCWmg5MUFZJlNZ6SICDQAAaP////f/hz95zzfr1oVt/2Ujt7/2+z/r/9v19r/f+zlN98awA
 Rsxo6ADQAAaPUAAaAAAAA0aA0ADIaAANAB6jQABp6anqNNGmnpqep6ZJo0PT1QyTTQNGhpo0yDQ
 0Bpo0ZMho00aDRoAaGINAyeghgIAxDTQAaGmg0eoAyDQZAZD9SPSNMRo0A00DENGRoDQ0GhoxAA
 DTQB6gGhoyaAANAaMjIANB6jRoGjJp6m1AgukkkHiBhFCT8qnFbE93mnuxlIyZsiiyl4BxaDdtN
 9AtX5NsiwQ48MTG9AeuxozZmyT+A00CPNBZSVKrW9CgCf3xmMJZytf6oyIzi/Weln1tErcsOHC1
 08d97STctlGrQg1BlTDOA90uzQN0KrUwm8x2Wo8LUy/MbBYoMfFCwAmxdbnMGJ+kBIaJeVYSPUw
 SXVTuo4dirl0rNSjUOl9jAPhnDvYKaOhOO/Cn8OZkr49QwXXKlh/JSuLSxkrTRoii5BFpFioZEa
 OwfRCLVmH7IFSYytO9sTPLyfRES/rwmjnLPLhxprksf4+t/SAiZ36xxEKbEbTRm8zTbkHKe+Cob
 ADyIKAZCvbnIfP33AsyFsMON/RuhAZ3UgyEAs9s5AjRVVCwhWYYxYHI37iZUShUmmjrHq3Q0tRC
 ntBWDvAUsYpwBf4u5IpwoSHSRAQaA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The am62px family of SoCs uses the same DDR controller as found on the
am62ax family. Enable this option when building for the am62px family

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/ram/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index bf99964577418..85dcb5d959789 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -65,7 +65,7 @@ choice
 	default K3_J721E_DDRSS if SOC_K3_J721E || SOC_K3_J721S2
 	default K3_AM64_DDRSS if SOC_K3_AM642
 	default K3_AM64_DDRSS if SOC_K3_AM625
-	default K3_AM62A_DDRSS if SOC_K3_AM62A7
+	default K3_AM62A_DDRSS if SOC_K3_AM62A7 || SOC_K3_AM62P5
 
 config K3_J721E_DDRSS
 	bool "Enable J721E DDRSS support"
-- 
2.42.0

