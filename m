Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8137CCCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 13:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B325F8004F;
	Wed, 29 Oct 2025 14:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SGWEjiU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816DA800B6; Wed, 29 Oct 2025 14:48:41 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CE28003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 14:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C72783FAF6; 
 Wed, 29 Oct 2025 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761745719;
 bh=OFL1oUwG5MewbVCT85HtvQmNrVrvGwYTtK4jnhy0/r8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SGWEjiU/JBHXCBK8hvqUWu13Hz4Hl0xnzyIprtz3zZW7+5rgDXfX1A9Hewk86R9qL
 YLqKfnSZ/sLWKD2oU9mXvEpZC3MSRq6b3VKN5kgBX0s7mGSJwVpjGiKDkGj1jXMoMF
 1vshkaYr9dcevRQu/hAPtKFNl5eVADIXvkuV4t/X/LGnrj6q/qR9V8GdcpEoxOdulX
 WxCMnUaoq694jkIski26WSzXvfcu+fJQ3Kmvpq+nzzAe4yk8Z3uaumjmZC3RcWQN5T
 9U3TRCE5Ho8MVCWB+h+wHWZpZw7SEjWZQY1CBjdF6KbOSA77yfRQPAMzKwpf91S4ab
 jr00uFN6dtP11xwkoQqd31LLZH9Dzi2h8GCrCFYip5e98f1oE0g8Qxjyv44pXGFmwR
 Jt5FA7dnAkotbyLZkhoCLwj/ZnDJGk2lIIIsnQdL8D6Fyt+h++I2uAthLz5askFbXC
 vyrmpvXRcfoDEs9r9Kaf9ev30tiDfVHMBSLRpsXJIfsJoQ2CSsp9h/z2MlaQHCwI9p
 3nYDzoahL+JCIZg8HspTPQsR5Qvwu67YhTWbx/2JsYYwnlh3ghyCD2WqMxRzNZqOxk
 8jRJ7JTiFsdqFXUk0o0NbACU38QXqcEqxbNvp3/YMfN3wkXts1AgINjcl5y5F6rFu0
 ubZWEND1P6DsVY19KnXFfDn0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] Dockerfile: remove Python 2.7
Date: Wed, 29 Oct 2025 14:48:33 +0100
Message-ID: <20251029134833.137965-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

We don't use Python 2 anywhere. Remove the package from our Docker image.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/docker/Dockerfile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..95ce1fdc6cc 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -120,7 +120,6 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	parted \
 	pkg-config \
 	python-is-python3 \
-	python2.7 \
 	python3 \
 	python3-dev \
 	python3-pip \
-- 
2.51.0

