Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C053CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D98A86940;
	Tue,  5 Sep 2023 20:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a2/A8dDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85754866DC; Tue,  5 Sep 2023 20:10:08 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0FC865F4
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385IA1Ik061280;
 Tue, 5 Sep 2023 13:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693937401;
 bh=Ov78murwZdaHHDyalUiUb2zOZ74WmBPYnTUOleCcorY=;
 h=From:To:CC:Subject:Date;
 b=a2/A8dDjw+5+N7qNks9dMsRbTY59HnsZNCyBBAPGrWhb5PFNAfvnlN/9BogMIsTEP
 53FzL7eFMK+PjLZWqVcvvfyj6SFBM48d6LVDfU/f5K9TigLrch8DplSOL7FF6Nao4k
 s1mdy21dY8mDNMuEpTRz5gqz2pS5Z/9zsA+oK34Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385IA1TK002428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 13:10:01 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 13:10:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 13:10:01 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385IA051025418; 
 Tue, 5 Sep 2023 13:10:01 -0500
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH] Makefile: Force regeneration of env.txt
Date: Tue, 5 Sep 2023 13:09:59 -0500
Message-ID: <20230905180959.392276-1-afd@ti.com>
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

If the source .env file changes to one that is also older than
the generated env.txt file then it is not regenerated. This means
when switching board configs we do not regenerate the env. This
can be tested easily with:

$ make j721e_evm_a72_defconfig
$ make # this may fail to complete but that is okay for this test
$ make am64x_evm_a53_defconfig
$ make
$ vim include/generated/env.txt

Note this is still the J721e env not the AM64 config as expected.

There is probably a better way to detect if the dependency name changed,
but that may involve extra files and hashing contents, so let's just
force it for now.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9be24c4ec61..d195590d4b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1830,7 +1830,7 @@ quiet_cmd_envc = ENVC    $@
 		touch $@ ; \
 	fi
 
-include/generated/env.txt: $(wildcard $(ENV_FILE))
+include/generated/env.txt: $(wildcard $(ENV_FILE)) FORCE
 	$(call cmd,envc)
 
 # Write out the resulting environment, converted to a C string
-- 
2.39.2

