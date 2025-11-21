Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ACFCFC294
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58C983A1B;
	Fri, 21 Nov 2025 18:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3372F83A64; Fri, 21 Nov 2025 18:15:14 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B2483A2D
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dChg35bqvzspP;
 Fri, 21 Nov 2025 18:15:11 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dChg251H9zB1d; Fri, 21 Nov 2025 18:15:10 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 21 Nov 2025 18:14:58 +0100
Subject: [PATCH v3 2/4] tools: binman: mkimage: add support for passing the
 engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-binman-engine-v3-2-b80180aaa783@cherry.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
In-Reply-To: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
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
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, 
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

mkimage has support for OpenSSL engines but binman currently doesn't for
direct callers of mkimage (e.g. the fit etype). This prepares for adding
support for OpenSSL engines for signing elements of a FIT image, which
will done in the next commit.

Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/btool/mkimage.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.py
index 23c0a8e490d..1dbd466f438 100644
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
         """
         args = []
         if external:
@@ -49,6 +50,8 @@ class Bintoolmkimage(bintool.Bintool):
             args += ['-k', f'{keys_dir}']
         if output_fname:
             args += ['-F', output_fname]
+        if engine:
+            args += ['-N', engine]
         return self.run_cmd(*args)
 
     def fetch(self, method):

-- 
2.51.1

