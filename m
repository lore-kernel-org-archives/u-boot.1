Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F3FC4828F
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 19:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4343487B77;
	Sun,  4 Feb 2024 20:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qbQv/7dn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684DF87C13; Sun,  4 Feb 2024 20:14:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C935387B05
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 20:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 30BD7419B1; 
 Sun,  4 Feb 2024 19:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707074040;
 bh=/yA6xKoLCKFB/ASdqGx0m9MMEAZHT8DN9ldqXjS3AXo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=qbQv/7dnFB5luh20MYex37B64/28VpjjKMmTBSSLLdUn4l4SGI2I7r7+PLnWa8qI5
 r/SyV7cc6a0LDQj8in8UwU7ONJJvDl5CSa9WLoKmg0+Om/+MxX8vRT8ZphDP1uXLvM
 efwhH0YZUUJLfbDDOaJsK4TzrmnmgZ53XRDgC88gK8+3xizsR7nnPlF/SNUoa3QOAz
 I4IcuraqM/sUj3cWtLuAXmbVf8bjfac6uGf5Vl1NztDekQmQcwiQeT0fDxtj20eFcY
 /fxbG/KqeeE86yma0VHIB+8EIlZmAOABbtxyZFkcowEU01lWxV8mJGWvzfgTfJVOdo
 L18eknRyuxz+w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] docker: build QEMU v8.2.1
Date: Sun,  4 Feb 2024 20:13:57 +0100
Message-ID: <20240204191357.178510-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Upgrade the used QEMU to v8.2.1. This avoids patching the source.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6122776bc6..7df68d9c9c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -178,12 +178,10 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.2.0 && \
+	git checkout v8.2.1 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.43.0

