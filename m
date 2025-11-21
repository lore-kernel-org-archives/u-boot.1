Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902DACFC273
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD398838A5;
	Fri, 21 Nov 2025 14:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B6F83935; Fri, 21 Nov 2025 14:22:37 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38638388D
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCbVf386Jz5cQ;
 Fri, 21 Nov 2025 14:22:34 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dCbVd5KzfzZLq; Fri, 21 Nov 2025 14:22:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 14:22:16 +0100
Subject: [PATCH next 3/3] CI: use coreboot mirror for GNU dependencies of
 coreboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-gnu-mirror-v1-3-548e6cd2665e@cherry.de>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
In-Reply-To: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 85274c303c8..b89e3025a3e 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -330,7 +330,7 @@ RUN mkdir /tmp/trace && \
 # Build coreboot
 RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp -xJ && \
     cd /tmp/coreboot-25.03 && \
-    make crossgcc-i386 CPUS=$(nproc) && \
+    make BUILDGCC_OPTIONS="--mirror" crossgcc-i386 CPUS=$(nproc) && \
     make -C payloads/coreinfo olddefconfig && \
     make -C payloads/coreinfo && \
     make olddefconfig && \

-- 
2.51.1

