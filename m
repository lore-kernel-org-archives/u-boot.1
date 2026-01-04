Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA3C2A062
	for <u-boot@archiver.kernel.org>; Sun,  4 Jan 2026 15:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A284683AAB;
	Sun,  4 Jan 2026 16:23:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=email.cz header.i=@email.cz header.b="JZbvJV+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9290283AB7; Sun,  4 Jan 2026 15:02:18 +0100 (CET)
Received: from mxe-3-78e.seznam.cz (mxe-3-78e.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:78e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D5983A24
 for <u-boot@lists.denx.de>; Sun,  4 Jan 2026 15:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomaspaukrt@email.cz
Received: from email.seznam.cz by smtpc-mxe-76f795765d-zqk4m
 (smtpc-mxe-76f795765d-zqk4m [2a02:598:96:8a00::1200:78e])
 id 48d68f63b6223dc94858017b; Sun, 04 Jan 2026 15:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
 s=szn20221014; t=1767535335;
 bh=YT7our6/SpK7gate0qA+O7Tj2kkW8jQPBsQ5tNc8X7s=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=JZbvJV+9OLda6OPeOkJ6mWnXqdSWCrAOUZ0+20CFceCVS/1FcvN6S6Yk4x2fO1HRM
 wPGiitBmeSZt7al30ajtUy1EPMl+b4/ID1IpaLiAjV1ALiWTqlPKBykV30ywwfADPg
 AODvda1ZiOz/cVJAgeKwWDNxzMERLukLjqkWqlU6mDUPcRH5MqjSddXZ/czRWKiUKU
 Lm0IU1yzLkE4QhQqhRk1MkU4K48uKCR3tsk7S5euTNkRG2s8Aa4o0ik57Ty40RFUXi
 yNPKWzTRAZ4LenUDT90WigSlcG32G5VCktD39r4tmxVpALobJfZng2UTOY5xHozzEQ
 SImQpN1AIjiiw==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
 Sun, 04 Jan 2026 15:02:11 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] lib: crypt: remove dependency on autoboot
Date: Sun, 04 Jan 2026 15:02:11 +0100 (CET)
Message-Id: <4fK.Z}kd.3rlt0vRvdGr.1fMdBZ@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.1.91)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 04 Jan 2026 16:23:43 +0100
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

Make crypt_compare() accessible from board-specific code
by removing its dependency on the autoboot feature.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 lib/crypt/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/crypt/Kconfig b/lib/crypt/Kconfig
index 22af6834d93..452b645831b 100644
--- a/lib/crypt/Kconfig
+++ b/lib/crypt/Kconfig
@@ -1,6 +1,5 @@
 menuconfig CRYPT_PW
 	bool "Add crypt support for password-based unlock"
-	depends on AUTOBOOT_KEYED && AUTOBOOT_ENCRYPTION
 	help
 	  Enable support for crypt-style hashed passphrases.
 	  This will then be used as the mechanism of choice to
-- 
2.17.1

