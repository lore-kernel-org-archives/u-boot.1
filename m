Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9728FCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6001C8834D;
	Wed,  3 Apr 2024 14:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="poeke/oU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4133988367; Wed,  3 Apr 2024 14:03:49 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA628833D
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433C3gFq024308;
 Wed, 3 Apr 2024 07:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712145822;
 bh=XGlee1/IzwxwjpkrApbDM+6dM43uke5oe/zqmpCMzSo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=poeke/oU907DFYplDLgxFEGALbWQC5+HiBXo2Xx6/9ZspW3sF80nY/fVw8729zh9V
 qFXaeLq7/NAu7oSLucTb+Xkdum0TmQgf33sinf/1Ne1RrQg7lBcU6DQQLj294MNqq1
 A5Xb1YEtXxoq4DVeLKGsVKPLgIPggVAeJNrjSTiY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433C3gE0058040
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 07:03:42 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 07:03:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 07:03:42 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433C3T4i128691;
 Wed, 3 Apr 2024 07:03:40 -0500
From: Dhruva Gole <d-gole@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vibhore Vardhan <vibhore@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 1/2] arm: mach-k3: add support for detecting TIFSSTUB images
Date: Wed, 3 Apr 2024 17:33:09 +0530
Message-ID: <20240403120309.4026170-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403120309.4026170-1-d-gole@ti.com>
References: <20240403120309.4026170-1-d-gole@ti.com>
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

From: Kamlesh Gurudasani <kamlesh@ti.com>

Add support for detecting and processing TIFSSTUB images for HS, HSFS
and GP devices.

TIFSSTUB image for related device type will be loaded, rest TIFSSTUB
images will be discarded.

Example, for GP device, tifsstub-gp will be loaded, tifsstub-hs and
tifsstub-fs will be discarded.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm/mach-k3/r5/common.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index c02f8d330998..0f6c294f1eb2 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -24,6 +24,9 @@ enum {
 	IMAGE_ID_OPTEE,
 	IMAGE_ID_SPL,
 	IMAGE_ID_DM_FW,
+	IMAGE_ID_TIFSSTUB_HS,
+	IMAGE_ID_TIFSSTUB_FS,
+	IMAGE_ID_T,
 	IMAGE_AMT,
 };
 
@@ -33,6 +36,9 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tee",
 	"U-Boot",
 	"DM",
+	"tifsstub-hs",
+	"tifsstub-fs",
+	"tifsstub-gp",
 };
 #endif
 
@@ -314,6 +320,24 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 			break;
 		}
 	}
+
+	if (i < IMAGE_AMT && i > IMAGE_ID_DM_FW) {
+		int device_type = get_device_type();
+
+		if ((device_type == K3_DEVICE_TYPE_HS_SE &&
+		     strcmp(os, "tifsstub-hs")) ||
+		   (device_type == K3_DEVICE_TYPE_HS_FS &&
+		     strcmp(os, "tifsstub-fs")) ||
+		   (device_type == K3_DEVICE_TYPE_GP &&
+		     strcmp(os, "tifsstub-gp"))) {
+			*p_size = 0;
+		} else {
+			debug("tifsstub-type: %s\n", os);
+		}
+
+		return;
+	}
+
 	/*
 	 * Only DM and the DTBs are being authenticated here,
 	 * rest will be authenticated when A72 cluster is up
-- 
2.34.1

