Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AEEC4707B
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 02:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1060C878BA;
	Fri, 12 Jan 2024 03:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hLm/sekZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25883878C6; Fri, 12 Jan 2024 03:18:09 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D8E8784F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 03:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.home.xypron
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9E6CA41BB2; 
 Fri, 12 Jan 2024 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705025884;
 bh=0BPmWfa5o+ddpq1rWR2zgFLuFvjEQElfFCxNvSF6ZM0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hLm/sekZ0GhSYOnU6IdxeSVhIjL7mryfhURp3VvuGmpHFPKTIhsWJJw0BmMVriwZz
 71jAJA/yg7F/sV+dTEPK0GUJsYhNyTYgFI71wyTE1Z02Ci74lig5ldcYRz2D8vo+kf
 mZeqyeYRSBIUTo0a//VZMWLkkKqTW2Qb77IbPHDmPEZB6v8RFvNbzXYsb4NFGz2m9P
 jq91NYrIBkD6idhFAWtyN5ry12G7Amq0BXTRR1e8aakTP0a0i77Ry262KtM9pw/A2U
 bhZs7OldHpH6wgGDLlfuwSnJMOHGkW12DSXyULKBpGKa9grb7qTFmC5oEN+4xCZyXk
 8UAQbN5IG/jOA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] docker: build QEMU v8.2.0
Date: Fri, 12 Jan 2024 03:17:57 +0100
Message-ID: <20240112021757.8719-1-heinrich.schuchardt@canonical.com>
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

ACPI support for RISC-V requires a recent QEMU.

Upgrade the used QEMU to v8.2.0.

QEMU commit 0c7ffc977195 ("hw/net: cadence_gem: Fix MDIO_OP_xxx values")
is needed to fix the Ethernet PHY driver used by the emulated SiFive
Unleashed Board emulation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index c4a2596b48..72ffb99a0c 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -178,10 +178,12 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.0.3 && \
+	git checkout v8.2.0 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
+	git format-patch 0c7ffc977195~..0c7ffc977195 && \
+	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.43.0

