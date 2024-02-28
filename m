Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D646AC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 07:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238B887E01;
	Wed, 28 Feb 2024 08:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vlfhQNoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 070CA87E28; Wed, 28 Feb 2024 08:43:22 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8F487DC2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:43:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 060BC3FB76; 
 Wed, 28 Feb 2024 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709106199;
 bh=tu3D+87txJXdJ7q91xwGQPUs5dwBPXC3Og5dwEVk1Cs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vlfhQNoKVQvuF/JrhNqaVttilvYOas+0PH9hcQkHJ0P76pBiLsJVbQu5P1KisXRbH
 nrl929BQZ+cVfsrsqAKnJjVmj7oDK3m5SfcRGxy7c6lGLmaDVdqETalNdzEBs5lpOF
 nO/LCHEovz31mDBARdYUKBgjIfVl0SB5eFZpUgHgXxc8tvGIuaZ+sVk6e7Ftlw9aQz
 MNB1nSXIO4BxcNWQu4b2fzyN0KlBX50GsImZrcAbOrM1EKWsMXMnTz6roMML1Tt4gG
 tE+NuwTAwYjiemZ7cgvkPVhkONJRHuJ0YdL5KeH9HXfiE99GSfZa7c/xivhG/8av/b
 DQzubkn3tEubg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Dockerfile: build fiptool
Date: Wed, 28 Feb 2024 08:43:11 +0100
Message-ID: <20240228074311.500761-1-heinrich.schuchardt@canonical.com>
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

Fiptool is used in a binman test. The test is skipped without the binary.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 884b1089e0..a5df0847d0 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -189,6 +189,16 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
+# Build fiptool
+RUN git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a && \
+	cd /tmp/tf-a/ && \
+	git checkout v2.10.0 && \
+	cd tools/fiptool && \
+	make && \
+	mkdir -p /usr/local/bin && \
+	cp fiptool /usr/local/bin && \
+	rm -rf /tmp/tf-a
+
 # Build genimage (required by some targets to generate disk images)
 RUN wget -O - https://github.com/pengutronix/genimage/releases/download/v14/genimage-14.tar.xz | tar -C /tmp -xJ && \
 	cd /tmp/genimage-14 && \
-- 
2.43.0

