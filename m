Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF21C369C2
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 02:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F51383125;
	Fri, 18 Apr 2025 04:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hH+8HIMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA2C8312E; Fri, 18 Apr 2025 04:57:52 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94AD82D5E
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E44D03FBB2; 
 Fri, 18 Apr 2025 02:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744945069;
 bh=1Lga41XHUbVsV8stnaGQydHTviS4bxplsWR4QzbTfU4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hH+8HIMv68Mj1qGtmhhQsj/KH6JdIIuZKT77VSq7DPwNvGwNkLVekUc9+ofD9HMCy
 kyr1iCRlR5Q5HQpXRV9+SNNfWWVH5zVQ/BDovmrWhrjb1v+biuvo5BpY/ZyhkUTaJK
 zZ++paTxG4vMULnJHCEVKHFT7aFc3gY8vBg7p+y0txf6zeMef46e8NuXctR54St24G
 ImMoq2XDmlZPgxn3HBIc2Lw4P+8a4MyDAK1jIRVX4CPv4fZyFgDj8hMNH1PAkU3K3k
 09oPly67sD/bGwGgxWXUNIeiUlUngKkEf2dX/sOppb4UXwxAxWuPycJvOEa091Td/c
 WQ52uzEL++lDQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Dockerfile: use QEMU 9.2.3
Date: Fri, 18 Apr 2025 04:57:43 +0200
Message-ID: <20250418025743.529973-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The RISC-V emulation has develop quite a bit since 8.2.0.
Let's update the QEMU version.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index a0fd174ff60..772e980d0d1 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -124,6 +124,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	python3-dev \
 	python3-pip \
 	python3-sphinx \
+	python3-tomli \
 	python3-virtualenv \
 	rpm2cpio \
 	sbsigntool \
@@ -218,13 +219,10 @@ RUN git clone git://git.savannah.gnu.org/grub.git /tmp/grub && \
 
 RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	cd /tmp/qemu && \
-	git checkout v8.2.0 && \
+	git checkout v9.2.3 && \
 	# config user.name and user.email to make 'git am' happy
 	git config user.name u-boot && \
 	git config user.email u-boot@denx.de && \
-	git format-patch 0c7ffc977195~..0c7ffc977195 && \
-	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
-	git cherry-pick d3c79c3974 && \
 	./configure --prefix=/opt/qemu --target-list="aarch64-softmmu,arm-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-softmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softmmu,x86_64-softmmu,xtensa-softmmu" && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
-- 
2.48.1

