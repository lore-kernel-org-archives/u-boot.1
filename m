Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68032CFC274
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906508390D;
	Fri, 21 Nov 2025 14:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E91802C1; Fri, 21 Nov 2025 14:22:35 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40824836F0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCbVc6vVgzjcK;
 Fri, 21 Nov 2025 14:22:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dCbVc2MFjzhCL; Fri, 21 Nov 2025 14:22:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 14:22:14 +0100
Subject: [PATCH next 1/3] CI: use GNU mirror for grub (and switch to HTTPS)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-gnu-mirror-v1-1-548e6cd2665e@cherry.de>
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

GNU announced they activated mirrors for git servers[1] in May this
year.

The main git server keeps being very unreliable and switching to those
mirrors seems to improve reliability (albeit somewhat slow).

Yes, the URL in this patch has nothing in common with the URL in the
linked mail, it was extracted from the Clone section in the mirrored
cgit page[2].

While at it, switch to the HTTPS clone which is "more secure" than git
protocol.

[1] https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html
[2] https://cgit.git.savannah.gnu.org/cgit/grub.git/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 2dc4bec33bb..34713c5e8b2 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -148,7 +148,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	zip
 
 # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
-RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
+RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
 	cd /tmp/grub && \
 	git checkout grub-2.12 && \
 	git config --global user.name "GitLab CI Runner" && \

-- 
2.51.1

