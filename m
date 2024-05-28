Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74803C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D1D8845C;
	Tue, 28 May 2024 10:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="miORNhBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC398843A; Tue, 28 May 2024 10:13:28 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ACDB8845C
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8DOTr009737;
 Tue, 28 May 2024 03:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716884004;
 bh=f8HvisbITvdYN0QlYsYut4pX02X3mEtfxWTIJNeVfdo=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=miORNhBtUfoioVieV2Be/IRyPF5JZnQatX39UECe4omHms1/+IKDtx7nj6qMS5oL9
 C6Tynzzs9OKI//ug1qOclAN0KVt6maQFMXJE7cqPoH+AMhCLz00c56GNH0MZSHjDfK
 ljr3p3LyYlaA6cz2daz6SurVKjkqRZcn6pLI7Mto=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8DOKM006562
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 03:13:24 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:13:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:13:24 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8Cxuq066670;
 Tue, 28 May 2024 03:13:21 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 13:43:04 +0530
Subject: [PATCH v2 5/7] arm: mach-k3: j721s2_init: Initialize AVS Class 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-avs-v2-5-df940f2309d0@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716883980; l=938;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=YWs+L0fHfPiA9ib/SLirMZ0j5QkVRGhCYdcfo0ep9D0=;
 b=kKIkeaIPxMpH9SJLvVOpgkljhjY/EjFqYqtKvfpGCDGxOAqyMUMhqwvllf0XNPKjHZ1qe4ha5
 H7j8vSHgVOPAi7vusJ+9EwZkXbN43/HnmcmYbgOWxL/ARPz0Qp6SZP9
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Initialize AVS Class 0.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index fe9766e9b4b2..cc49662367f0 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -290,11 +290,21 @@ void do_dt_magic(void)
 #ifdef CONFIG_SPL_BUILD
 void board_init_f(ulong dummy)
 {
+	struct udevice *dev;
+	int ret;
+
 	k3_spl_init();
 #if defined(CONFIG_SPL_OF_LIST) && defined(CONFIG_TI_I2C_BOARD_DETECT)
 	do_dt_magic();
 #endif
 	k3_mem_init();
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
2.43.2

