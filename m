Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4EFC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105D184A30;
	Wed,  8 Jul 2026 19:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="KUfX1W0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E82843B6; Wed,  8 Jul 2026 19:21:34 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79B384A1F
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gwPyg3d3mzCLH;
 Wed,  8 Jul 2026 19:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783531291;
 bh=ReBQmBpqZCX5BawAVc0CP887gRhrfogOCyK3giy94ns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KUfX1W0jFl0rOOcboR/MF2ScRYzGv5I+xC6BC0XVAuSlokXCkbl6cbbFBlgIU8eOx
 Z95uWJ1sDPUEmaxrAb+HZsvApnxuD5LeqpwVBsX35cfxaJlWEDGIXGYyiJD4uRiJSR
 G8wbPPXaXEL0ycdaUiwTNvVciIlKn1eAOUWkPFgbC00lGvkUNqxitO+AnHJJRRKafM
 b7yv51ydWnwsIwlfSGjYzcU3BHBTbBx9LoqkZr7Gse9/0OEXP0ZchR85pDUjiJCt9e
 O5xGXP0u2tqB/kXorwbn1QZ3hbhh7CCWWLI/qbjAMrebu1LTmlHrD3pD7pYKnidLvN
 2L+m32oX+vL6A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gwPyf5zSRzdwp; Wed,  8 Jul 2026 19:21:30 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 08 Jul 2026 19:21:13 +0200
Subject: [PATCH 1/3] doc: CONTRIBUTE: use internal link instead of
 hardcoded external URL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-other-contrib-v1-1-8b3bd4d265ef@cherry.de>
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

This way we don't need to make sure this link still points to something
that exists, as Sphinx will enforce it at build time. It also has the
added benefit that if someone builds the docs they will point at their
docs (though that is debatable whether that's useful, but at least you
stay on the same website).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/CONTRIBUTE.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index a6e1cd1fb68a..0179d55dbcc0 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -21,8 +21,7 @@ Repository
 
 The official U-Boot repository is located at https://source.denx.de/u-boot/u-boot
 
-Further more detailed documentation can be found at the following link:
-https://docs.u-boot-project.org/en/latest/index.html
+Further more detailed documentation can be found at the following link: :doc:`/index`.
 
 Contributions
 -------------

-- 
2.55.0

