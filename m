Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ADDC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFE7887AA;
	Fri, 31 May 2024 15:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iE38v/yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9D5887A1; Fri, 31 May 2024 15:11:59 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B898488765
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBtOX104281;
 Fri, 31 May 2024 08:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717161115;
 bh=Oh43IgBF9DcOnpRvmQytjkrcOFo1SkOT0WEvaEM6nf4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iE38v/ygIjI3bXT5YoXK7nzP8LzbFrmxNeRAXSQvDN+tLBqE7RrNizc8IlbxiPNJn
 hC3sQF/NmUf5gxkvTy60vfPdmawomWL5VhoZtjgxt9JXZvQ5QcWEnWGoq/8HTZ6/Hb
 XDQJ8LvHyjebYV1IwGpvJPxt7+qKn4xTFDG931wU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VDBt5K053980
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 08:11:55 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 08:11:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 08:11:55 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VDBm6q063605;
 Fri, 31 May 2024 08:11:53 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 2/6] arm: dts: k3-j7200-r5: Fix indentation to use tabs
Date: Fri, 31 May 2024 18:38:19 +0530
Message-ID: <20240531130823.646311-3-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531130823.646311-1-a-limaye@ti.com>
References: <20240531130823.646311-1-a-limaye@ti.com>
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

To avoid whitespace diff, use tabs throughout the file for indent

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index 78d07ff4e70..c7086791ef8 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -85,16 +85,16 @@
 };
 
 &ospi0 {
-    reg = <0x0 0x47040000 0x0 0x100>,
-          <0x0 0x50000000 0x0 0x8000000>;
+	reg = <0x0 0x47040000 0x0 0x100>,
+		  <0x0 0x50000000 0x0 0x8000000>;
 };
 
 &mcu_ringacc {
-    ti,sci = <&dm_tifs>;
+	ti,sci = <&dm_tifs>;
 };
 
 &mcu_udmap {
-    ti,sci = <&dm_tifs>;
+	ti,sci = <&dm_tifs>;
 };
 
 &tps659414 {
-- 
2.34.1

