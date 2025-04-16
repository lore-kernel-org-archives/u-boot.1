Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B282C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B5C82CF6;
	Wed, 16 Apr 2025 09:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V8ok6CCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4671882CEB; Wed, 16 Apr 2025 09:31:23 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F9181E14
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VJYR261862
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744788679;
 bh=bzSjTsy0olM3lpHJib/v3xaonlyl9X7bQE9lm45220o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=V8ok6CCmW5Md9v/fnHy6gKVGLhZALqETvydmW9C9XHhDcDirXFoYYSi1ptcd1xecf
 EkAZ2hYhJTpv75nU6vcm1iMzuwo3MEO0puSyCuhwA6xoDrxu0OKYqCa3g3xMa0Nkjh
 uW8THDFxAXzUCIQd17RD5QY3qiW/lT9iSNnuLxvc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VJKI083981
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:31:19 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:31:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:31:18 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7VHw0051503;
 Wed, 16 Apr 2025 02:31:18 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: [PATCH v1 3/4] binman: k3: add jump-stub to tispl.bin
Date: Wed, 16 Apr 2025 13:00:56 +0530
Message-ID: <20250416073058.1441001-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416073058.1441001-1-anshuld@ti.com>
References: <20250416073058.1441001-1-anshuld@ti.com>
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

To preserve backwards compatibility with older ATF builds with
PRELOADED_BL33_BASE set to 0x80080000, we add a jump-stub component to
all tispl derrivatives which jumps execution to the address where u-boot
spl is actually loaded (SPL_LOAD_TEXT).

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..5d971ecf886 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -5,6 +5,8 @@
 
 #include "k3-security.h"
 
+#define LEGACY_ATF_PRELOADED_BL33_BASE 0x80080000
+
 / {
 	binman: binman {
 		multiple-images;
@@ -325,6 +327,22 @@
 					};
 				};
 
+				jump-stub {
+					description = "Jump stub for backwards compatibility with older ATF builds";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					entry = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					ti-secure {
+						content = <&jump_stub>;
+						keyfile = "custMpk.pem";
+					};
+					jump_stub: blob-ext {
+						filename = "jump_stub.bin";
+					};
+				};
+
 			};
 		};
 	};
@@ -387,6 +405,19 @@
 						filename = "spl/u-boot-spl-nodtb.bin";
 					};
 				};
+
+				jump-stub {
+					description = "Jump stub for backwards compatibility with older ATF builds";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					load = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					entry = <LEGACY_ATF_PRELOADED_BL33_BASE>;
+					blob-ext {
+						filename = "jump_stub.bin";
+					};
+				};
+
 			};
 		};
 	};
-- 
2.49.0

