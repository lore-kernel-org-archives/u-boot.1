Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B69C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 10:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CA8820EB;
	Mon, 14 Apr 2025 12:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11283820B7; Mon, 14 Apr 2025 12:51:05 +0200 (CEST)
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2149482075
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 12:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zbkbn63MGzly2;
 Mon, 14 Apr 2025 12:51:01 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Zbkbn2bRZzlxt; Mon, 14 Apr 2025 12:51:01 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 14 Apr 2025 12:50:45 +0200
Subject: [PATCH 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-binman-pubkey-dir-v1-2-0784d54ac621@cherry.de>
References: <20250414-binman-pubkey-dir-v1-0-0784d54ac621@cherry.de>
In-Reply-To: <20250414-binman-pubkey-dir-v1-0-0784d54ac621@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

key-name-hint property in u-boot-spl-pubkey-dtb binman entry may contain
a path instead of a filename due to user mistake.

Because we currently assume it is a filename instead of a path, binman
will find the full path to the key based on that path, and return the
dirname of the full path but keeps the path in key-name-hint instead of
stripping the directories from it.

This means mkimage will fail with the following error message if we have
key-name-hint set to keys/dev:

binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qschulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstream/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certificate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file or directory

Let's make it a bit more obvious what the error is by erroring out in
binman if a path is provided in key-name-hint (it is named key-name-hint
and not key-path-hint after all).

Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/etype/u_boot_spl_pubkey_dtb.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/binman/etype/u_boot_spl_pubkey_dtb.py b/tools/binman/etype/u_boot_spl_pubkey_dtb.py
index cb196061de28610eb785fb44c887982e3979659f..70c74b7638228f8093b85b144c6407dc92875be5 100644
--- a/tools/binman/etype/u_boot_spl_pubkey_dtb.py
+++ b/tools/binman/etype/u_boot_spl_pubkey_dtb.py
@@ -87,6 +87,8 @@ class Entry_u_boot_spl_pubkey_dtb(Entry_blob_dtb):
                                          dir=tools.get_output_dir())\
                                               as pubkey_tdb:
             tools.write_file(pubkey_tdb.name, self.GetData())
+            if '/' in self._key_name_hint:
+                self.Raise(f"'{self._key_name_hint}' is a path and not a filename")
             keyname = tools.get_input_filename(self._key_name_hint + ".crt")
             self.fdt_add_pubkey.run(pubkey_tdb.name,
                                     os.path.dirname(keyname),

-- 
2.49.0

