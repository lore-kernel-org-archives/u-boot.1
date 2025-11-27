Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D8D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 13:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A6A843C7;
	Thu, 27 Nov 2025 14:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A779C843B9; Thu, 27 Nov 2025 14:29:49 +0100 (CET)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42a8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839E9843BF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 14:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dHHN91lfVzf5D;
 Thu, 27 Nov 2025 14:29:45 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dHHN85Ptkzx43; Thu, 27 Nov 2025 14:29:44 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 27 Nov 2025 14:29:28 +0100
Subject: [PATCH next v2 3/3] CI: use coreboot mirror for GNU dependencies
 of coreboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-gnu-mirror-v2-3-c86fa2e8d464@cherry.de>
References: <20251127-gnu-mirror-v2-0-c86fa2e8d464@cherry.de>
In-Reply-To: <20251127-gnu-mirror-v2-0-c86fa2e8d464@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>
X-Mailer: b4 0.14.3
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

coreboot buildgcc script downloads GNU dependencies from GNU FTP server.
For some reason, this is also as unreliable as their git main server.
There's no option to use a GNU mirror (and I'm not even sure if there's
one for FTP), so we simply pass --mirror to the buildgcc script via the
BUILDGCC_OPTIONS variable so that it makes use of coreboot's mirror.
Hopefully, this proves more reliable than GNU original FTP server.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 440a3c39293..bc45f59d6e7 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -329,7 +329,7 @@ RUN mkdir /tmp/trace && \
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-25.03 && \
-    make crossgcc-i386 CPUS=$(nproc) && \
+    make BUILDGCC_OPTIONS="--mirror" crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
     make olddefconfig && \

-- 
2.52.0

