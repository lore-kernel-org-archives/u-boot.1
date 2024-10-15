Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C37ACFC288
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A4B891CF;
	Tue, 15 Oct 2024 12:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dByEbS01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7E1891CF; Tue, 15 Oct 2024 12:52:47 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7AA8918F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqgxC112760;
 Tue, 15 Oct 2024 05:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989562;
 bh=GeL1JS8tpB9KbFRtvwRmZvW3zaMYWIabqaVAHThpdJg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=dByEbS013ablwukNfnwegM+q4pmpo2FezmJjgAZ2dfmRT7witB2vsRMH7qd0gJP7Q
 EJ6JK6JEM72cfElfgaVQNZyhv3sRjM9pUflLNb5XEzkZnya69VOujQziNgPCga7w42
 BxmBHNjIqMPlwNC3I4TlewUnxC0gs8L5gTKlJiI4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FAqg6M019998
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Oct 2024 05:52:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:41 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbj044559;
 Tue, 15 Oct 2024 05:52:38 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 15 Oct 2024 16:22:21 +0530
Subject: [PATCH v5 5/7] arm: mach-k3: j721s2_init: Initialize AVS Class 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-5-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=1189;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=kxQNFt/yh20TCioeB5uB2m8w0d3pUNt3SP7cumaywig=;
 b=5MtvDXyqrfZJ2557SEXEydA70EdJxMH5sSAV3xjAB5kETCgCzgLN3Ph/VLHQb3m1nLZ75vWHO
 gLTR+Sr4WXoDjIgDbmI8NWwRwtbWvzrxWrcF6K+2FpDzy5HGz8/GTB4
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Adaptive Voltage Scaling (AVS) Class 0 is a procedure for lowering the
voltage on certain device power rails. Initialize AVS Class 0.

Link: https://www.ti.com/lit/pdf/spruj28 (Section 5.2.3.3.2.5 AVS-Class0)
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 05453fcad41a..5f5961a2c17a 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -315,6 +315,9 @@ void do_dt_magic(void)
 #ifdef CONFIG_SPL_BUILD
 void board_init_f(ulong dummy)
 {
+	struct udevice *dev;
+	int ret;
+
 	k3_spl_init();
 #if defined(CONFIG_SPL_OF_LIST) && defined(CONFIG_TI_I2C_BOARD_DETECT)
 	do_dt_magic();
@@ -325,6 +328,13 @@ void board_init_f(ulong dummy)
 		setup_navss_nb();
 
 	setup_qos();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
+						  &dev);
+		if (ret)
+			printf("AVS init failed: %d\n", ret);
+	}
 }
 #endif
 

-- 
2.46.0

