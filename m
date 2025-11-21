Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDC3CFC273
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177FB8382A;
	Fri, 21 Nov 2025 14:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608DE802C1; Fri, 21 Nov 2025 14:22:38 +0100 (CET)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010A6837F2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCbVd56CKz5HN;
 Fri, 21 Nov 2025 14:22:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dCbVd0NVkzdq7; Fri, 21 Nov 2025 14:22:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 14:22:15 +0100
Subject: [PATCH next 2/3] CI: use mirror for gnulib dependency of grub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-gnu-mirror-v1-2-548e6cd2665e@cherry.de>
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

grub bootstrap script downloads gnulib from a non-mirror URL and thus is
unreliable.

Instead, manually clone the gnulib repo from a mirror URL and pass that
repo to the bootstrap script via --gnulib-srcdir.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/docker/Dockerfile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 34713c5e8b2..85274c303c8 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -148,12 +148,13 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	zip
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
-RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
+RUN git clone https://https.git.savannah.gnu.org/git/gnulib.git /tmp/gnulib && \
+	git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.12 && \
 	git config --global user.name "GitLab CI Runner" && \
 	git config --global user.email trini@konsulko.com && \
-	./bootstrap && \
+	./bootstrap --gnulib-srcdir=/tmp/gnulib && \
 	mkdir -p /opt/grub && \
 	./configure --target=aarch64 --with-platform=efi \
 	CC=gcc \
@@ -218,7 +219,7 @@ RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	make -j$(nproc) && \
 	./grub-mkimage -O x86_64-efi -o /opt/grub/grub_x64.efi --prefix= -d \
 	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd && \
-	rm -rf /tmp/grub
+	rm -rf /tmp/grub /tmp/gnulib
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \

-- 
2.51.1

