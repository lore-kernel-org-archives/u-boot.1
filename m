Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA229C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 07:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0429587F15;
	Wed, 28 Feb 2024 08:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wObsDpn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D804B87F95; Wed, 28 Feb 2024 08:23:35 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A5687E78
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D023A3FBBB; 
 Wed, 28 Feb 2024 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709105010;
 bh=1DQ0MG9e6u92EkXwkWZOTwfj6NpbBrfFcgj2tUb0UUs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=wObsDpn36dpBqiRQD1HA9v5GTYSnEYh+A6W/usxONVycbVjWTV9RQz+GwILa8WJOV
 Qkw6M91I+E0xEmHMjGAKkz5XEkUGoQFNTK4/mZBM0vF5nHW+9hkOm3e/ODfEoGKlBU
 KosscPy0X2s1BmRA1N2WUWNr95DwNlfWx04K/24Yh070sxqPc2P14Cw8nFYyxGzzyW
 C8rhmptSdprg4Pwn9lDB7VNDJp1SL/pJjrgL5riKGW4RM1oEIdBXqONJludeWAUvaz
 iWVnafTNmTETCjurAJfqEMxvQRglq0+QAHynV61Kc7OV7oFMYxEuPEdtR6VMbifiob
 rzC76LJV+f88w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Dockerfile: install xilinx-bootgen package
Date: Wed, 28 Feb 2024 08:23:09 +0100
Message-ID: <20240228072309.476781-1-heinrich.schuchardt@canonical.com>
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

Bootgen is used in a binman test. The test is skipped without the binary.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6122776bc6..884b1089e0 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -116,6 +116,7 @@ RUN apt-get update && apt-get install -y \
 	virtualenv \
 	vboot-kernel-utils \
 	vboot-utils \
+	xilinx-bootgen \
 	xxd \
 	zip \
 	&& rm -rf /var/lib/apt/lists/*
-- 
2.43.0

