Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47682CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 18:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E25F881CE;
	Wed, 10 Apr 2024 20:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jcPwXklK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A782F881C9; Wed, 10 Apr 2024 20:38:41 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E5D86E40
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AIcZ2T115208;
 Wed, 10 Apr 2024 13:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712774315;
 bh=E+nrV6KL0IDUKFMdJh3eUnQECNqt82FI1iGwoxulyhE=;
 h=From:To:CC:Subject:Date;
 b=jcPwXklKEujq//TQiwpkF4MvDPQRymBHjmya3hWIPWUmcRV0y+hvo+EgHJE6nsM+J
 XiDQ41YRIPbWT0RgoZx00C9/8xjtVYmbwZed1XWHSFszIcOnvocnKGX5PiOjht8Ho2
 hEvRJb2AJkw1NPOm/mlVprXn+RZYwDj/6b3oV56s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AIcZTb050557
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Apr 2024 13:38:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:38:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:38:35 -0500
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AIcZfD091373;
 Wed, 10 Apr 2024 13:38:35 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Jon Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>, Andrew Davis
 <afd@ti.com>
Subject: [PATCH] arm: mach-k3: security: Lower verbosity of cert message for GP
Date: Wed, 10 Apr 2024 13:38:34 -0500
Message-ID: <20240410183834.153876-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

When we find a certificate on an image to be booted on a GP device we
print out a message explaining that the certificate is being skipped.
This message is rather long and is printed for every image. Shorten
the message and make the long version into a debug message.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
index 22697a263a8..7c46914d9dd 100644
--- a/arch/arm/mach-k3/security.c
+++ b/arch/arm/mach-k3/security.c
@@ -50,7 +50,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size)
 
 	if (get_device_type() == K3_DEVICE_TYPE_GP) {
 		if (ti_secure_cert_detected(*p_image)) {
-			printf("Warning: Detected image signing certificate on GP device. "
+			debug("Warning: Detected image signing certificate on GP device. "
 			       "Skipping certificate to prevent boot failure. "
 			       "This will fail if the image was also encrypted\n");
 
@@ -60,6 +60,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size)
 				return;
 			}
 
+			printf("Skipping authentication on GP device\n");
 			*p_image += cert_length;
 			*p_size -= cert_length;
 		}
-- 
2.39.2

