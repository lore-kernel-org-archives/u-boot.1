Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F226FC44525
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD2A82991;
	Mon, 20 Jul 2026 10:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="PvNXG1pB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF11083E76; Mon, 20 Jul 2026 10:49:13 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD9680517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h3Z1y1l2xzhJF;
 Mon, 20 Jul 2026 10:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1784537349;
 bh=QTxDziIQOcYMFX8HMIWoziuAsWiIBUppus3N+3BFN8M=;
 h=From:Date:Subject:To:Cc:From;
 b=PvNXG1pB3Mjcf0KdB4yaqIwYTbpVL4OnNSsofRfb61KSremKcSmC5XfkMRKLcgMr2
 pQO0/a40NZ5X4Sc5A6O5DYdTm2QYrKCZ5ykzi4EkaeJ89UbMlhE0l8XRtwqLgM9was
 2030GmE7fcFItimV1Pol9/2hvo38Gp9gNkCMMFcTDP94S/CExMFj7U+HYT8sN5pxbg
 XYsKm5SC1HFCX5xBZDKb3kajUzRVm9h5aquT+IkNzAezcE/xtUG+l1JGlu9g5NfGHc
 pzQVd8eVn/qYAsPxxGg+FoO61TxtN378bjmYGE7B4agnPZTlZocx5D9V564VhE4U4E
 i2y/OiAESWcUg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h3Z1x2FcwzmJ; Mon, 20 Jul 2026 10:49:09 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 20 Jul 2026 10:48:59 +0200
Subject: [PATCH] doc: CONTRIBUTE: replace "as" with "like"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-typo-contribute-v1-1-90e89c6d648f@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBNMoqCrRAudppoWKmpRRHfPa
 vkW/18QKTBF6IoLAu0c2dmMqiwAF21nEjxmg5Kqka2SIp3eCXQ2BTZbIjEZQxJRt6puIFc+0MT
 Hd+yH33EzK2F6N3DfD8pAWf1zAAAA
X-Change-ID: 20260720-typo-contribute-fbbe0cca7246
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
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

It's either "as with" or "like" but not "as", as reported by Simon.
Let's fix this oversight.

Fixes: 06f014394594 ("doc: CONTRIBUTE: tell people reviewing *is* contributing")
Reported-by: Simon Glass <sjg@chromium.org>
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/CONTRIBUTE.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index e8fa595ed4ab..4fc171ed2106 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -38,7 +38,7 @@ script. Please don't send patches as attachments, and ensure corporate mail
 systems don't reformat patches, append disclaimers or other unnecessary notes.
 The b4 tool automates a number of components mentioned above.
 
-Code is not the only thing you can contribute to the project. As most
+Code is not the only thing you can contribute to the project. Like most
 open-source projects, the U-Boot project suffers from a lack of reviewers.
 Consider spending some time reading patches on `the mailing list archive
 <https://lists.denx.de/pipermail/u-boot/>`_ and providing feedback to

---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260720-typo-contribute-fbbe0cca7246

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

