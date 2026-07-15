Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D1CC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 15:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEC384BB4;
	Wed, 15 Jul 2026 17:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=permerror header.from=rootcommit.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=rootcommit.com header.i=@rootcommit.com header.b="H/+sV3+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9B7484BD7; Wed, 15 Jul 2026 17:04:30 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7CB84B88
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=permerror header.from=rootcommit.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=michael.opdenacker@rootcommit.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 635BB4E40DD3;
 Wed, 15 Jul 2026 15:04:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 373E36035C;
 Wed, 15 Jul 2026 15:04:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C2E911BD04C2; 
 Wed, 15 Jul 2026 17:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
 s=dkim; t=1784127867;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=Ph7TSWqbRR41OeGz3sHYWgugu0ABUb1ZDwQkdKONSA4=;
 b=H/+sV3+l89ZMEGaCmzWKDRJVYDs4bkTBeZR4YwVOcF6UlEbgEu0AcZlbnp/4zWUSImVgTc
 UlF1YVWesso1VhvzyhXBmXeT41b/mjpZmq1FM0undVj2v0PfIwM0AGKvxZZwImZwCl4VaU
 jylkk7BZZMlj7Mb65GJEPj0IM1KqikvWULVL2z6GRfgEx9gFsU8g5cZSVk08OnwlASXsCK
 isWgTE6utCetYLhWqj0E+feXCxXrYK2eFC7sd0gldGsBnOBBIL6P2c5lNbDXleF4RzLpUH
 6F9eWnnArV6m0h5V55fZMp3nevTWSVsy2m+vyrdC9Hh0p1uho0CsCMTDLOUQ9Q==
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Date: Wed, 15 Jul 2026 17:04:04 +0200
Subject: [PATCH] doc: thead: lpi4a: detail how to enable fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-improve-lpi4a-doc-v1-1-4cc045eb59bc@rootcommit.com>
X-B4-Tracking: v=1; b=H4sIAGOhV2oC/yXMQQ6CMBBG4auQWTsJRQT1KsRFaX9giNKmVUJCu
 DsVlt/ivZUigiDSM1spYJYobkpQl4zMoKceLDaZiryo8lrdWD4+uBn89lJqts5wB9i7eih7rQ2
 lzgd0shzP5nU6/toR5vsf0bbtqm2ho3UAAAA=
X-Change-ID: 20260715-improve-lpi4a-doc-feed8191d37c
To: u-boot@lists.denx.de
Cc: Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Add that the "BOOT" button must be used
to switch the board to fastboot mode.

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 doc/board/thead/lpi4a.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/board/thead/lpi4a.rst b/doc/board/thead/lpi4a.rst
index acd7ac2698d..3920efcd710 100644
--- a/doc/board/thead/lpi4a.rst
+++ b/doc/board/thead/lpi4a.rst
@@ -91,8 +91,10 @@ OpenSBI firmware and proper U-Boot.
 Booting
 ~~~~~~~
 
-u-boot-with-spl.bin should be loaded to SRAM through fastboot. Connect
-the board to computer with Type-C cable and run
+u-boot-with-spl.bin should be loaded to SRAM through fastboot.
+
+To put the board in fastboot mode, press and hold the ``BOOT`` button,
+connect the board to the computer with a Type-C cable, release ``BOOT`` and run:
 
 .. code-block:: bash
 

---
base-commit: 8dbe57ba648648c4897717cebbc4505a8e0a8c23
change-id: 20260715-improve-lpi4a-doc-feed8191d37c

Best regards,
--  
Michael Opdenacker <michael.opdenacker@rootcommit.com>

