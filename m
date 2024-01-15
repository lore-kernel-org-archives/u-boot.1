Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A91C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933CB84694;
	Mon, 15 Jan 2024 10:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IyKGuRri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD88869F7; Mon, 15 Jan 2024 10:31:54 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEA7807AE
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1705311112; x=1707903112;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7uFN0dEc5279cup5iUfF5C8mLy8MFOGRX76604HbXhU=;
 b=IyKGuRriCdMJiXbSKIXkkYnpHRjNjEZlMTLz2+ZsC2TObAYPNWaRsnjPTxda9CzF
 MNaDIiFrTj1e0QuDicwynGQa42D4Ppv7/NyscbwTZiheNrjxim0zP4Gz4y3xAaNy
 UBIW0f/wY1uz4jVOvsB76HEPqSiD+lq6lA+EsEvzSoo=;
X-AuditID: ac14000a-fbefe7000000290d-b6-65a4fb8815e3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F8.84.10509.88BF4A56;
 Mon, 15 Jan 2024 10:31:52 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 15 Jan
 2024 10:31:51 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 15 Jan 2024 10:31:41 +0100
Subject: [PATCH v2] board: phytec: fix link error when disabling
 PHYTEC_SOM_DETECTION
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240115-wip-y-moog-phytec-de-som-detection-fixup-v2-1-993ac37f964b@phytec.de>
X-B4-Tracking: v=1; b=H4sIAHz7pGUC/52NQQ6CQAxFr0K6toYiOsSV9zAsJjMVuoCZzCBKC
 He34g1cNa/t/2+FzEk4w7VYIfEsWcKoUB0KcL0dO0bxylCVVV0SEb4k4oJDCB3GfpnYoWfMYdC
 hMGkcH/J+Rjw769nUxtaNBa2LifWwq+6tci95CmnZzTN9t39IZkJC48heTmyYubn9/o+eod227
 QNH0Yib4AAAAA==
To: Fabio Estevam <festevam@gmail.com>, Teresa Remmet <t.remmet@phytec.de>,
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWyRpKBR7fj95JUg31zmCweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAldF8po+t4DF/xYFrd5gaGE/y
 djFyckgImEg8657FAmILCSxmkji8NbuLkQvIfsgo8XftHEaQBJuAisTjF/dYQWwWAVWJF982
 g8WFBcIl5vV3soHYvAKCEidnPgEaxMHBLKApsX6XPkiYWUBeYvvbOcwQJdESi3d+YAOZLyHw
 nVHif9thMEdEoIFR4uyLPewQHUoSp6+2sUBcJyzRvugWE8R1shIvzveyQ8TlJaade80MYYdK
 HNm0mmkCo+AsJHfMQrhjFpI7FjAyr2IUys1Mzk4tyszWK8ioLElN1ktJ3cQIClwRBq4djH1z
 PA4xMnEwHmKU4GBWEuGtvrMkVYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU
 1ILUIpgsEwenVAOjxcdvWj9azVWWnpu/abXVOfWX1cVSiVd7OJOTLm5wcJ3u/FNGe3VMg+XH
 whcmjp6fjjjyF3GZ97LMyykN/n29uMS1PMi9svRixrvZ3VETnH4abVjelFy1/cWWz/FPHgaY
 tqvLHBFU6FMLEc0/PjWfvfP69FtrRbRaWYO+WFz+9LfSMKeiIkGJpTgj0VCLuag4EQC4WX9O
 SgIAAA==
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

Commit aa7858fe5e2e ("board: phytec: som_detection: move definitions to
source file") moved function definitions from header to source file.
Makefile however was not updated to unconditionally (from
[..]_SOM_DETECTION) build the imx8 and phytec som detection units.
Also remove unused includes that cause build failures on arm 32bit
boards. SoM detection shall support 32bit boards as well, but arch
specific code should not be included in the generic module.

Fixes: aa7858fe5e2e ("board: phytec: som_detection: move definitions to source file")
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v2:
- change imx8m_som_detection to conditionally compile when arch is IMX8M
- remove unused includes
- Add reasoning in commit message
---
 board/phytec/common/Makefile               | 4 ++--
 board/phytec/common/phytec_som_detection.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index fe28964ce21..35c81741306 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -7,5 +7,5 @@ ifdef CONFIG_SPL_BUILD
 obj- := __dummy__.o
 endif
 
-obj-$(CONFIG_PHYTEC_SOM_DETECTION) += phytec_som_detection.o
-obj-$(CONFIG_PHYTEC_IMX8M_SOM_DETECTION) += imx8m_som_detection.o
+obj-y += phytec_som_detection.o
+obj-$(CONFIG_ARCH_IMX8M) += imx8m_som_detection.o
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 1b10923b62f..c73bf9721b2 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -5,8 +5,6 @@
  */
 
 #include <common.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>

---
base-commit: 7a59d520ef0bfd29b339cba5282149271d5ac3b2
change-id: 20240111-wip-y-moog-phytec-de-som-detection-fixup-5cade747a48a

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

