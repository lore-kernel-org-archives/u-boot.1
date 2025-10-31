Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DCCCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8636483952;
	Fri, 31 Oct 2025 16:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E2A8398C; Fri, 31 Oct 2025 16:23:11 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E51D383956
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cyl9R4g9hz3nn;
 Fri, 31 Oct 2025 16:23:07 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cyl9N4kGxzYyc; Fri, 31 Oct 2025 16:23:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] fit: allow signing with only an engine_id
Date: Fri, 31 Oct 2025 16:22:57 +0100
Message-Id: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHUBGkC/x3MQQqAIBBA0avErBNGLcGuEi2yJptFUyhEIN09a
 fkW/xfIlJgyDE2BRDdnPqVCtw0s+yyRFK/VYND0Gi2qwHLMokgiCymynQ9onHcrQm2uRBs//2+
 c3vcDUgDxNV8AAAA=
X-Change-ID: 20251030-binman-engine-e349b02696d0
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

I have a couple of products whose U-Boot FIT is signed via a proprietary
OpenSSL engine which only expects the name of a "slot" to select the key
to sign data with.

Currently mkimage fit support expects either a key-dir (-k) or a
key-file (-G) as a toggle for signing, however this doesn't apply to our
usecase because we use an OpenSSL engine (so no key-file to provide)
which doesn't mimic a directory layout like key-dir implies. Moreover,
binman really expects private keys (.key extension) to be available in
this key-dir directory, which we of course cannot provide.

This series allows to sign a FIT image with mkimage (and binman) with
only an OpenSSL engine and no key-dir. mkimage will read the
key-name-hint property and pass that verbatim to the OpenSSL engine API
via the key_id argument.

Note that the public key (.crt extension) still needs to be available if
one wants to embed it for signature verification (which is probably what
one wants to do :) ).

One issue though is that since binman resolves key paths absolutely and
that I don't believe an OpenSSL engine would happen to have the exact
same key_id value than a local absolute path, fit,encrypt and
fit,sign-engine cannot cohabit. An issue for the next person who wants
an OpenSSL engine AND encrypt the same FIT image, I don't.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      fit: support signing with only an engine_id
      tools: binman: mkimage: add support for passing the engine
      tools: binman: fit: add support for OpenSSL engines

 tools/binman/btool/mkimage.py |  5 ++++-
 tools/binman/entries.rst      | 22 +++++++++++++++++++---
 tools/binman/etype/fit.py     | 41 +++++++++++++++++++++++++++++++++++++----
 tools/fit_image.c             |  3 ++-
 tools/image-host.c            |  4 ++--
 5 files changed, 64 insertions(+), 11 deletions(-)
---
base-commit: 0dad93a72ec59b21cedeab365a28fcaa11a58384
change-id: 20251030-binman-engine-e349b02696d0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

