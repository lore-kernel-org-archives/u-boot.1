Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E5DC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F62182E38;
	Fri, 18 Apr 2025 13:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4170982EBE; Fri, 18 Apr 2025 13:26:24 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E2F82C15
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfCBj3kn5zmBQ;
 Fri, 18 Apr 2025 13:26:21 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZfCBh1N6JzQKH; Fri, 18 Apr 2025 13:26:20 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/2] binman: properly error out if path provided to
 key-name-hint in signature nodes
Date: Fri, 18 Apr 2025 13:26:06 +0200
Message-Id: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM42AmgC/22NQQ6CMBBFr0Jm7Zi2KVBceQ/DgtJRJsZCpkokh
 LtbSdy5fC/576+QSJgSnIoVhGZOPMYM5lBAP3TxRsghMxhlSmW1Rs/x0UWcXv5OCwYWtM47V3l
 dl00DeTcJXfm9Ny9t5oHTc5Rlv5j11/5q9k9t1qhQ1c6G0nZ9ZfS5H0hkOQaCdtu2D/d5+BmyA
 AAA
X-Change-ID: 20250411-binman-pubkey-dir-48b886b17599
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

I misunderstood the documentation and put the signing key in a keys/
directory while setting key-name-hint property in the signature node and
u-boot-spl-pubkey-dtb to a path.

mkimage doesn't fail if it cannot find the public key when signing a
FIT but returns something on stderr to notify the user it couldn't find
the key. The issue is that bintool currently discards stderr if the
command successfully returns, so the FIT is not signed AND the user
isn't made aware of it unless the image is manually inspected.

mkimage does fail when trying to insert a public key in a DTB if it
isn't found but we can have a better error message.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- added tests,
- fixed typo in docstring,
- synced both error messages,
- Link to v1: https://lore.kernel.org/r/20250414-binman-pubkey-dir-v1-0-0784d54ac621@cherry.de

---
Quentin Schulz (2):
      binman: etype: fit: raise ValueError if key-name-hint is a path
      binman: etype: u_boot_spl_pubkey_dtb: provide more explicit error for key-name-hint with path

 tools/binman/etype/fit.py                          |  3 +
 tools/binman/etype/u_boot_spl_pubkey_dtb.py        |  2 +
 tools/binman/ftest.py                              | 25 ++++++
 .../test/347_key_name_hint_dir_fit_signature.dts   | 98 ++++++++++++++++++++++
 .../test/348_key_name_hint_dir_spl_pubkey_dtb.dts  | 16 ++++
 5 files changed, 144 insertions(+)
---
base-commit: cb7555e93075114fe4af0adb806877ac4d4ef80d
change-id: 20250411-binman-pubkey-dir-48b886b17599

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

