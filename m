Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC94C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D50084A29;
	Wed,  8 Jul 2026 19:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="I3Sg1/dC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C397843B6; Wed,  8 Jul 2026 19:21:36 +0200 (CEST)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::42aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0749784A30
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwPyh4ZBnz4mG;
 Wed,  8 Jul 2026 19:21:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783531292;
 bh=l+CtSVfAB+L5Vuskxw+HgoaQGAIMMcv0uO2Kwm0vVuY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=I3Sg1/dCtokhxCExLbDbe1T94YUtYRLhUQBzl9jTO58qgsl6Q89d7V2R9CCEvo83v
 kWvRHxi04TJeG8FoYdRCje+T8+cKK3DMZsFCqDrbtFaUs367e87QEb7av6GdMl9VKi
 Zzi+D2r7qnxWGN0LiSCiCtJJ4/TeqnVQ8172gwJdAHvo99mT9WwcyZ8oNsRh+PaiBI
 FtAXhpQEAaWmyfU+qsq8Xa9F4QZbpVMLeWjC8ytmLZ3P+3FH4+CLIOXm1CqAahoft0
 iwbNbJNyW9tQLHy2GmRnOvF/2eUMaj3K+AK5zuvpYClRlY9AFRq+MxnK+2LLM+tQGS
 0dROPLdXlkI7w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwPyg67ZfzbH0; Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 08 Jul 2026 19:21:15 +0200
Subject: [PATCH 3/3] doc: CONTRIBUTE: explicitly list tests and
 documentation as welcome contributions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-other-contrib-v1-3-8b3bd4d265ef@cherry.de>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
In-Reply-To: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

We don't have too many people looking at those at the moment, so having
people getting into the project by adding tests or documentation is I
believe a good thing so let's encourage those specific contributions.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/CONTRIBUTE.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index cd9a381a3eb8..e8fa595ed4ab 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -47,6 +47,13 @@ to what's most often believed, you do not need to be an expert to review patches
 and the project will benefit from people with different skillsets and experience
 looking at the same patches and each catch different bugs.
 
+The project would also benefit from more :ref:`develop/index:testing`.
+
+New sections or updates to the documentation are most welcome, e.g.
+:ref:`usage/index:shell commands`. See :doc:`/develop/docstyle`.
+
+Thank you for your help!
+
 Patch Series
 ------------
 

-- 
2.55.0

