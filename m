Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FB8C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E9E82C49;
	Thu, 12 Jun 2025 13:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tPntj95v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1772882C84; Thu, 12 Jun 2025 13:39:08 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A170828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55CBd2FZ2908999;
 Thu, 12 Jun 2025 06:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749728342;
 bh=/1/qf34Mi8dcTYzrBenyBCM9tYK9dTDIDdX0InqY0v4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=tPntj95v9EPENHaLHvpafqYmKHwRYcsyuPg8o8rx13L6LR89kQdg/HVb87Ne3nnwW
 YY14yKxPHjS7dTFzl5ZeeozoII2SqxlZ8/TebTDCTt7yWI2xe2MtYK0bmAFKZ9ksv8
 udMHeG5WWDwn2EE9ZSE1fGsLezBkzpXopBdh3u2U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55CBd2vO3606975
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 12 Jun 2025 06:39:02 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 06:39:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 12 Jun 2025 06:39:02 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55CBd2ua2099290;
 Thu, 12 Jun 2025 06:39:02 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 12 Jun 2025 06:38:53 -0500
Subject: [PATCH -next v2 4/5] binman: allow '.' to be included in the
 missing blob tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-missing-blob-help-entries-v2-4-36f1c8078155@ti.com>
References: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
In-Reply-To: <20250612-missing-blob-help-entries-v2-0-36f1c8078155@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=bb@ti.com;
 h=from:subject:message-id; bh=WEcpe/fayyK+iC3P9GpGWSfU5dc97vCYvlWy+rg4FOA=;
 b=owNCWmg5MUFZJlNZL4lXOQAAX3////7733Uj7MzvEuRXtfL/+vNv//7///9/76zf3n/buP6wA
 RsYIeoNAPRA9QANAGhoA0BoADIaAAABoNAaAABoAA0AMQ0bUZHqBkaeU/RQ6DQNNAA0aAANA000
 MjIPUA0aAAeoGhoAGQAyGmhoNPUGj1A9IZND0jQekMRkAhoaekBkGQ00DQNBoyAwjQ0aABoBkBp
 oAAGjJgIwmgGgAaDJoAMmjAQ0AYMk/Fd0APeygEHDhQ8tiSAFbecuSsf4WCdifivBY5ONWU8/4I
 vMEVxdOduds66F3pR+mzxi64lujQHFawOZqTQO/HeCRsMQv2zRMr2oGDEVJUPjRclzd7tGrNPi8
 7ljuMGWs09h3kRygIAg8kQQqvyHn/4+JgjG8ltKTE+mGe8cIOud4Ef8RBk8zYALype220uuoSJt
 oyVOifMScduDWW0qMXAAt2ifonGUkUF9mmgbWOrwuLkH9cg2jINuTE8VqqnTkziTA6E9jdwqpWo
 TIhU2OuUZilGGSFzEl29mjz4AHhvlYLLfkx9HCBDx5AwUwufX/qrr0+zQLxwDQqx6DHYjXnZ1v3
 WL1x8JCgUwhlIEA3knRl44++rKQoyAwiro6YAGWsDFCpHEHNvdtrvi0osRFImkfBAUEVO3pLViJ
 SjiUaB/xdyRThQkC+JVzkA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

