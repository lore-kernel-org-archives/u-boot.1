Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C521CD4F49
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 591C786BA1;
	Fri, 22 Sep 2023 12:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VlPEJlfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD4B586B55; Fri, 22 Sep 2023 12:40:10 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B999C86B9E
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38MAe6hm077703;
 Fri, 22 Sep 2023 05:40:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695379206;
 bh=Sl90oIC4qbTzTWQcEmBadY3/QTcXIQ+RlANKQSXT64g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VlPEJlfUXyjJRX7e7zGNsgmdHZT8sbGiEoT1PaKTW84qVFitcK+c/CXBEiD4ujtyP
 ocnfDvMUmqbHPt4tutSEo39wXrbKFIsf3uXLnJmhMvVxtjG5Gg7o1KK6SjosYTN9MR
 /rMb9ign2+bscnLVh6ZMBzkDruRiwQ23T9vHRFCM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38MAe5Ft000979
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 05:40:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 05:40:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 05:40:05 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38MAdtBs034669;
 Fri, 22 Sep 2023 05:40:01 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/6] arm: mach-k3: j721e: dev-data: Add mcu_timer0 ID
Date: Fri, 22 Sep 2023 16:09:49 +0530
Message-ID: <20230922103954.3454891-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922103954.3454891-1-n-francis@ti.com>
References: <20230922103954.3454891-1-n-francis@ti.com>
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

U-Boot uses mcu_timer0 as the tick-timer, so add it to device list.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j721e/dev-data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/j721e/dev-data.c b/arch/arm/mach-k3/j721e/dev-data.c
index 97f017f8af..b0adb1857b 100644
--- a/arch/arm/mach-k3/j721e/dev-data.c
+++ b/arch/arm/mach-k3/j721e/dev-data.c
@@ -56,6 +56,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(4, &soc_lpsc_list[8]),
 	PSC_DEV(202, &soc_lpsc_list[9]),
 	PSC_DEV(203, &soc_lpsc_list[10]),
+	PSC_DEV(35, &soc_lpsc_list[11]),
 	PSC_DEV(102, &soc_lpsc_list[11]),
 	PSC_DEV(103, &soc_lpsc_list[11]),
 	PSC_DEV(104, &soc_lpsc_list[11]),
-- 
2.34.1

