Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B319EC369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 10:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5250A8209C;
	Mon, 14 Apr 2025 12:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB348129F; Mon, 14 Apr 2025 12:51:03 +0200 (CEST)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::1908])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E1982047
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 12:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zbkbn1Vzyzb2Y;
 Mon, 14 Apr 2025 12:51:01 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Zbkbm4KZ9zn9n; Mon, 14 Apr 2025 12:51:00 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 14 Apr 2025 12:50:44 +0200
Subject: [PATCH 1/2] tools: binman: etype: fit: raise ValueError if
 key-name-hint is a path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-binman-pubkey-dir-v1-1-0784d54ac621@cherry.de>
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

mkimage doesn't fail if it cannot find the public key but it prints to
stderr. Considering that btool.run() discards stderr, it means binman
happily returns an unsigned FIT and doesn't tell you something went
wrong.

Binman will actually find the file if there's a path in the
key-name-hint property but the current logic expects key-name-hint to be
a filename and thus returns the dirname of the found path for the key,
but with the original key-name-hint appended. This means we can have the
following:

- key-name-hint = "keys/dev"
- name = "/home/qschulz/work/upstream/u-boot/keys/"

so we pass /home/qschulz/work/upstream/u-boot/keys/ to the -k option of
mkimage but the FIT still contains "keys/dev" in key-name-hint which
means mkimage will try to find the key at
/home/qschulz/work/upstream/u-boot/keys/keys/, which doesn't exist.

Let's assume paths are simply not supported (it is named key-name-hint
and not key-path-hint after all) and raise an error if the property
contains a path so that the build fails and not quietly.

Fixes: 133c000ca334 ("binman: implement signing FIT images during image build")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/etype/fit.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 803fb66ea838f1f02da7fa42c121057de31ec2ef..c1d964aecfd0f52e7db72fb5ab41f6482fbf1b93 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -557,6 +557,7 @@ class Entry_fit(Entry_section):
         Raises:
             ValueError: Filename 'rsa2048.key' not found in input path
             ValueError: Multiple key paths found
+            ValueError: 'dir/rsa2048.key' is a path not a filename
         """
         def _find_keys_dir(node):
             for subnode in node.subnodes:
@@ -565,6 +566,8 @@ class Entry_fit(Entry_section):
                     if subnode.props.get('key-name-hint') is None:
                         continue
                     hint = subnode.props['key-name-hint'].value
+                    if '/' in hint:
+                        self.Raise(f"'{hint}' is a path not a filename")
                     name = tools.get_input_filename(
                         f"{hint}.key" if subnode.name.startswith('signature')
                         else f"{hint}.bin")

-- 
2.49.0

