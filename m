Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5A3EE3F2F
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 14:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19509864F0;
	Fri, 15 Sep 2023 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SUKfciFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39A3864DD; Fri, 15 Sep 2023 16:43:29 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57D5864CB
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 16:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38FEhPGk056841;
 Fri, 15 Sep 2023 09:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694789005;
 bh=WmKaoBdob3j/u9BeUQsoY4egLKGOJtdtZlq5UUNOp2E=;
 h=From:To:CC:Subject:Date;
 b=SUKfciFi0iARHOOmhUVhiPFB7gWR2aI86L+9FMteUpwMxB9utqcEZW3NDppuS4ZJ5
 uwBkZ11KlCUpkglByYhFa7r0i3yv/JCyRNPdfYJKsbinJuOGw2G81CMAUUznsuEfBD
 68wSeJroqUgxWqM88qN+2tf2AQkdB72dgwQ8jWWY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38FEhPvQ010046
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Sep 2023 09:43:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 09:43:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 09:43:24 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38FEhOJs021631; 
 Fri, 15 Sep 2023 09:43:24 -0500
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH v2] Makefile: Force regeneration of env.txt
Date: Fri, 15 Sep 2023 09:43:23 -0500
Message-ID: <20230915144323.76660-1-afd@ti.com>
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

If the source .env file changes to one that is also older than the
generated env.txt file then the .env file is not regenerated. This
means when switching board configs we do not regenerate the env.

This can be tested with:

$ make j721e_evm_a72_defconfig
$ make # this may fail to complete but that is okay for this test
$ make am64x_evm_a53_defconfig
$ make
$ vim include/generated/env.txt

Note this is still the J721e env not the AM64 config as expected.

As ENV_FILE is set based on configuration, regenerate anytime
autoconf.h changes.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Depend on autoconf.h as suggested by Simon

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9be24c4ec61..dba3c145368 100644
--- a/Makefile
+++ b/Makefile
@@ -1830,7 +1830,7 @@ quiet_cmd_envc = ENVC    $@
 		touch $@ ; \
 	fi
 
-include/generated/env.txt: $(wildcard $(ENV_FILE))
+include/generated/env.txt: $(wildcard $(ENV_FILE)) include/generated/autoconf.h
 	$(call cmd,envc)
 
 # Write out the resulting environment, converted to a C string
-- 
2.39.2

