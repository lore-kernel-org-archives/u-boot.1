Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A125CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30798398D;
	Fri, 31 Oct 2025 16:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D4E8398C; Fri, 31 Oct 2025 16:23:13 +0100 (CET)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E58783980
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cyl9T0rnlzXyB;
 Fri, 31 Oct 2025 16:23:09 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cyl9S2x9wzYLV; Fri, 31 Oct 2025 16:23:08 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 16:22:59 +0100
Subject: [PATCH 2/3] tools: binman: mkimage: add support for passing the engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

mkimage has support for OpenSSL engines but binman currently doesn't for
direct callers of mkimage (e.g. the fit etype). This prepares for adding
support for OpenSSL engines for signing elements of a FIT image, which
will done in the next commit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/btool/mkimage.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 3f84220fb1a..79a8f887795 100644
--- a/tools/binman/btool/mkimage.py
+++ b/tools/binman/btool/mkimage.py
@@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
 
     # pylint: disable=R0913
     def run(self, reset_timestamp=False, output_fname=None, external=False,
-            pad=None, align=None, keys_dir=None):
+            pad=None, align=None, keys_dir=None, engine=None):
         """Run mkimage
 
         Args:
@@ -35,6 +35,7 @@ class Bintoolmkimage(bintool.Bintool):
                 signatures
             align: Bytes to use for alignment of the FIT and its external data
             keys_dir: Path to directory containing private and encryption keys
+            engine: Name of the OpenSSL engine to use
             version: True to get the mkimage version
         """
         args = []
@@ -50,6 +51,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-k', f'{keys_dir}']
         if output_fname:
             args += ['-F', output_fname]
+        if engine:
+            args += ['-N', engine]
         return self.run_cmd(*args)
 
     def fetch(self, method):

-- 
2.51.0

