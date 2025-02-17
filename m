Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141AFC021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A07F80F1C;
	Mon, 17 Feb 2025 14:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PlCzGAZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BFC80F6C; Mon, 17 Feb 2025 11:57:40 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E80DC80F56
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvYrf1340204
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 04:57:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739789854;
 bh=eX/WyYft36MzQbaQE8H9fdVD9mNqWIC6jey1su/rCvk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PlCzGAZoBnmaIr2dsvkmXPfjAYBRBGxrLIl8GpXN3aBtcb/fv7bIQh85r8Mn5RHK+
 +H9UZ16n26gdQqHFWBmGjDA8JligHvjn5A2op7kEXBIEoMKbHSisaZvQZbn5VqyTd6
 jneXk8iWty0/bdYBJQDr8u0t1ZBVxssNT7m6Pxic=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvYDZ052639
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Feb 2025 04:57:34 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 04:57:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 04:57:34 -0600
Received: from ubuntu.myguest.virtualbox.org ([10.249.128.48])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HAvPXm071781;
 Mon, 17 Feb 2025 04:57:31 -0600
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] configs: j722s_evm_r5_defconfig: Enable the ESM Configs
 to support watchdog
Date: Mon, 17 Feb 2025 16:27:18 +0530
Message-ID: <20250217105718.3109-3-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217105718.3109-1-j-keerthy@ti.com>
References: <20250217105718.3109-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 17 Feb 2025 14:28:17 +0100
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

Enable ESM configs. ESMs are a prerequisite to enable
watchdog reset functionality. The ESM aka error signalling module
is primarily responsible for sensing the watchdog reset event.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 configs/j722s_evm_r5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index a78a66d33a7..3bf2a74b3d2 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -127,4 +127,7 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
+CONFIG_ESM_K3=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MISC=y
 CONFIG_SPL_LIB_RATIONAL=y
-- 
2.17.1

