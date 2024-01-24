Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38E2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67AA87BCE;
	Wed, 24 Jan 2024 08:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Wqxbx09k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5AD87BF2; Wed, 24 Jan 2024 08:49:15 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06A387BB9
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1706082552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=MURjUJklunXDa2Cer8xsXzxSsaYK75a69DY9hsVeXEQ=;
 b=Wqxbx09kkXv+j28Mz0jwNDyTPsA1K5OW/RpdMegYqQHRBVJOAZUNzR0RRVHZN6ZBg3ZYjb
 kO1GCgTnpNGZ6IJh8HJD86ukyCPSFPegpniCiFFRCZJ10y/ANjMRmLQpkobGPQjBeBrTdV
 xeDyGRKf22ExvJM0TPLOFuGaXLnNAgc26kfNtpGyijxpwDcIEuXBSSzWLRCIETvO3svFhE
 EkFAsPBqL8D9pwODca8qnyj/ylplHN05rJ2rDlMp+WUnp4Jhg9hsXqxL9fXsLVfsSPTeP7
 tbEPvJCKHVojQd4BGcKFhOUEAWpGDObby1wnbOXBQWK1f2cbD6Pph3zdchXRqQ==
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] doc: dm: Fix typo
Date: Wed, 24 Jan 2024 08:48:58 +0100
Message-Id: <20240124074858.14568-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
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

That's most probably a typo, because driver model design documents seem
to be from 2012 and there is no 2010.01 release.

Fixes: 282ed24fb3ca ("dm: MIGRATION: Add migration plan for CONFIG_DM")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    This was still in an old local branch of my working copy, but it applies
    cleanly to master so I guess it is still valid?! ;-)

 doc/develop/driver-model/migration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/migration.rst b/doc/develop/driver-model/migration.rst
index 03fea943b29..b40a6af9d11 100644
--- a/doc/develop/driver-model/migration.rst
+++ b/doc/develop/driver-model/migration.rst
@@ -13,7 +13,7 @@ CONFIG_DM
 * Status: In progress
 * Deadline: 2020.01
 
-Starting with the 2010.01 release CONFIG_DM will be enabled for all boards.
+Starting with the 2020.01 release CONFIG_DM will be enabled for all boards.
 This does not concern CONFIG_DM_SPL and CONFIG_DM_TPL. The conversion date for
 these configuration items still needs to be defined.
 

base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe
-- 
2.39.2

