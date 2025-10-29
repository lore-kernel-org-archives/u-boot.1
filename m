Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62B9CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529BA8004F;
	Wed, 29 Oct 2025 12:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6C5800B1; Wed, 29 Oct 2025 12:30:46 +0100 (CET)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F89A8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxQ6D2spcz5Z8;
 Wed, 29 Oct 2025 12:30:44 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxQ6C6f8DzSt6; Wed, 29 Oct 2025 12:30:43 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:30:36 +0100
Subject: [PATCH] binman: btool: mkimage: fix Bintoolmkimage.run() method
 docstring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-btool-mkimage-docstring-v1-1-9905a95018cc@cherry.de>
X-B4-Tracking: v=1; b=H4sIANv6AWkC/x2MQQqAIBAAvxJ7TqgNJftKdLDabKk0NCII/550H
 IaZFyIFpghd8UKgmyN7l6EuC5hW4ywJnjMDVijrCrUYL+93cWx8mCxnP8UrsLNC63ZUDSJJoyD
 XZ6CFn//cDyl9opfcF2kAAAA=
X-Change-ID: 20251029-btool-mkimage-docstring-998b6322e5a6
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
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

Commit 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
removed the version argument from the run method but forgot to remove it
from the method docstring, so let's fix this oversight.

Fixes: 65e2c14d5a5a ("binman: btool: mkimage: use Bintool.version")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/btool/mkimage.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 3f84220fb1a..23c0a8e490d 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -35,7 +35,6 @@ class Bintoolmkimage(bintool.Bintool):
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
             keys_dir: Path to directory containing private and encryption keys
-            version: True to get the mkimage version
         """
         args = []
         if external:

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-btool-mkimage-docstring-998b6322e5a6

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

