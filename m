Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CE5C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E77682C0C;
	Wed, 11 Jun 2025 20:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bIB8eMS6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C26E82C65; Wed, 11 Jun 2025 20:17:45 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5483D82B0F
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55BIHcsI2689848;
 Wed, 11 Jun 2025 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749665858;
 bh=/1/qf34Mi8dcTYzrBenyBCM9tYK9dTDIDdX0InqY0v4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=bIB8eMS6GoNtEvf6uw26laxKk/jtQCqma3/fjCLwidb5DmTaJ+cqfNMSWmvtnkg61
 J6yuhd79xqXfZdmgeICWmlp6Kj7fhBDpPb/G0BfuF0B74cjEu54XQq54Ac7Bo3AKMx
 z0vbsVp7STVGLchVEEDF9rD6/BJFpTNOCCQK8DxE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55BIHcqe1203177
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 13:17:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 13:17:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 13:17:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55BIHclf731491;
 Wed, 11 Jun 2025 13:17:38 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Wed, 11 Jun 2025 13:17:35 -0500
Subject: [PATCH -next 4/5] binman: allow '.' to be included in the missing
 blob tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250611-missing-blob-help-entries-v1-4-c6de1844117f@ti.com>
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
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

Extend the regex to add periods '.' in the tag so entries like
ti-fs-enc.bin can be represented in the missing-blob-help file.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/control.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 1946656f7d368209df3299a0e7c833b93edf2120..e5bd78898069205498c13c443d76000791fd7fa3 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -97,7 +97,7 @@ def _ReadMissingBlobHelp():
         return tag, msg
 
     my_data = pkg_resources.resource_string(__name__, 'missing-blob-help')
-    re_tag = re.compile('^([-a-z0-9]+):$')
+    re_tag = re.compile(r"^([-\.a-z0-9]+):$")
     result = {}
     tag = None
     msg = ''

-- 
2.49.0

