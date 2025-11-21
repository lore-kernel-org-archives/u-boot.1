Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DF1CFC295
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF9E839E8;
	Fri, 21 Nov 2025 18:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5624A83A1E; Fri, 21 Nov 2025 18:11:10 +0100 (CET)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8CF839DF
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dChZM49sfz97S;
 Fri, 21 Nov 2025 18:11:07 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dChZL5H12zrm5; Fri, 21 Nov 2025 18:11:06 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 18:10:54 +0100
Subject: [PATCH] CI: add libengine-pkcs11-openssl package for pkcs11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyND3YLs5GJDQ93kTF2LxFQTc+Nk85Q0syQloPqCotS0zAqwWdGxtbU
 AwhGQsVsAAAA=
X-Change-ID: 20251121-pkcs11-ci-8ae473c7df6b
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

In the future, we'll need proper pkcs11 support so that we can validate
mkimage/binman works well with pkcs11 OpenSSL engine/provider via
softhsm2-util (already installed).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
@Tom, once this is merged can you please tag and push a new image to
DockerHub?

This is needed for v3 (not posted yet) of
https://lore.kernel.org/u-boot/20251117-binman-engine-v2-0-e053f683c0b8@cherry.de/
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index cca35eb4082..c080af88420 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -95,6 +95,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	inetutils-telnet \
 	iputils-ping \
 	libconfuse-dev \
+	libengine-pkcs11-openssl \
 	libgit2-dev \
 	libjson-glib-dev \
 	libgnutls28-dev \

---
base-commit: f85aadf4d6d4aa79d4d1dec0453d99d982b9ca06
change-id: 20251121-pkcs11-ci-8ae473c7df6b

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

