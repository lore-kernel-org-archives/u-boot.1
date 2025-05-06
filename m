Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B372CC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D9382999;
	Tue,  6 May 2025 12:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tot23ddb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE78A829CD; Tue,  6 May 2025 12:42:47 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9AF282928
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgfUL1031448
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 05:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746528161;
 bh=MfVlZc8BcSWgLO3W4O31R7ByjJYwj+EYr8mC4iZ9FWE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Tot23ddb4G/yp1wAOct9pxqnpowBXaQh7D3ydY5/PlZU39IcHfxffz6aNfxBzSC9e
 b+Xoa7+HDecZ5zQsY1QYZobS24pX2D14IyOavRwa3WY+Yvp1a2set8gFZ+7MQcdpwE
 mT84RkCAbjsg6M2XLF/QEustPO7L3FjselZLghVg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546AgfAs122203
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 05:42:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 05:42:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 05:42:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546Ag2uZ103095;
 Tue, 6 May 2025 05:42:36 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v2 6/7] arm: mach-k3: Explicitly identify TIFSSTUB images when
 discarding buffers
Date: Tue, 6 May 2025 16:12:01 +0530
Message-ID: <20250506104202.16741-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506104202.16741-1-b-padhi@ti.com>
References: <20250506104202.16741-1-b-padhi@ti.com>
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

The board_fit_image_post_process() function assumes that all TIFSSTUB
images appear at the end of the image_os_match[] array by using
the condition:

	i > IMAGE_ID_DM_FW

However, this assumption breaks when new image types are appended to the
enum and the array, causing unintended image types to match this
condition and having their buffer sizes incorrectly set to 0 with:

	*p_size = 0

To avoid this issue, replace the range-based check with an explicit
match for TIFSSTUB image IDs.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v2: Changelog:
1. New patch. Fixes condition to allow new images to be added at the end
of the enum.

 arch/arm/mach-k3/r5/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index da5184e615c..81fc67a0023 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -365,7 +365,9 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 		}
 	}
 
-	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
+	if (i < IMAGE_AMT &&
+	    (i == IMAGE_ID_TIFSSTUB_HS || i == IMAGE_ID_TIFSSTUB_FS ||
+	     i == IMAGE_ID_T)) {
 		int device_type = get_device_type();
 
 		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
-- 
2.34.1

