Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC06C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2783987D73;
	Tue, 23 Jan 2024 18:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2676987D73; Tue, 23 Jan 2024 18:57:17 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C499487D57
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKFCs3Jm5zMqvkZ;
 Tue, 23 Jan 2024 18:57:13 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TKFCr5nMbzJ9B; Tue, 23 Jan 2024 18:57:12 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] tools: buildman: fix non-existing SafeConfigParser in
 Python 3.12+
Date: Tue, 23 Jan 2024 18:57:01 +0100
Message-ID: <20240123-safeconfigparser-v1-1-1312af945f47@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
SafeConfigParser was renamed back in Python 3.2 (yes, no typo) to=0D
ConfigParser[1], but it was still working as an alias until it got=0D
removed in 3.12[2].=0D
=0D
[1] https://docs.python.org/3.8/whatsnew/3.2.html#configparser=0D
[2] https://github.com/python/cpython/pull/92503=0D
=0D
Cc: Quentin Schulz <foss+uboot@0leil.net>=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
 tools/buildman/bsettings.py | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/tools/buildman/bsettings.py b/tools/buildman/bsettings.py=0D
index f7f8276e629..e225ac2ca0f 100644=0D
--- a/tools/buildman/bsettings.py=0D
+++ b/tools/buildman/bsettings.py=0D
@@ -16,7 +16,7 @@ def setup(fname=3D''):=0D
     global settings=0D
     global config_fname=0D
 =0D
-    settings =3D configparser.SafeConfigParser()=0D
+    settings =3D configparser.ConfigParser()=0D
     if fname is not None:=0D
         config_fname =3D fname=0D
         if config_fname =3D=3D '':=0D
=0D
---=0D
base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe=0D
change-id: 20240123-safeconfigparser-778a81ef8f47=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
