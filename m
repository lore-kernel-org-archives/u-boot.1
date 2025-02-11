Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A43C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06094806FE;
	Tue, 11 Feb 2025 09:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EoGXhC7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5BC6805D7; Tue, 11 Feb 2025 09:29:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A2F8033D
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8Sipu203386
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Feb 2025 02:28:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739262525;
 bh=DYh98KU2zkJJ89g7VMqRhV9PmPF3dreOyOx/2LlLUtM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EoGXhC7boz9V4hjBdmnhZ1hAJu/x6mS3s41DxPEoerWqoR7u6a642jd1qmLijUAlr
 pD9h0r8uyBgiA5wBzDdIqq6qEgNsxN3/PJAdSjWu75qbuJ/Q43j+upTctKtCG016g9
 wP+TIB0Tqz24QoLxwtOLWc49aQLnAsd12pQvBprg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8SiXr102067;
 Tue, 11 Feb 2025 02:28:44 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 02:28:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 02:28:44 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8Sc9Z109021;
 Tue, 11 Feb 2025 02:28:42 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <mkorpershoek@baylibre.com>, <ddrokosov@salutedevices.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
 <a-dutta@ti.com>
Subject: [uU PATCH 1/3] include: configs: Override get_fit_config to get FIT
 config for AM57x
Date: Tue, 11 Feb 2025 13:58:36 +0530
Message-ID: <20250211082838.18766-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211082838.18766-1-a-dutta@ti.com>
References: <20250211082838.18766-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Sinthu Raja <sinthu.raja@ti.com>

Kernel commit 837833a724b7 ("environment: ti: Add get_fit_config command
to get FIT config string") introduced "get_fit_config" in ti_armv7_common.h
to mangle the fdtfile name when used to select a config node from the OE
made FIT image. However, the ti_armv7_common.h is common for both K3 and
AM57xx platforms. AM57xx platforms' fdtfile name does not have '/' and
"conf-" prefix so the setexpr command fails and boot hangs.

Override the get_fit_config in AM57x specific config header to get the
correct FIT config name.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/ti_omap5_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 26b6c1cd188..d315a52f36f 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -251,6 +251,7 @@
 	DEFAULT_LINUX_BOOT_ENV \
 	DEFAULT_MMC_TI_ARGS \
 	DEFAULT_FIT_TI_ARGS \
+	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
 	DEFAULT_COMMON_BOOT_TI_ARGS \
 	DEFAULT_FDT_TI_ARGS \
 	DFUARGS \
-- 
2.34.1

